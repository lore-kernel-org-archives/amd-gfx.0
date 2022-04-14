Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0817C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 14:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E4D10FFD8;
	Thu, 14 Apr 2022 14:47:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26AA10FFD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 14:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhMcj0L/JNFr1xQBu/uCJ8Peb0UbJbK0oJtHOfFvclgxTirJUsdQqicIBskQVASFhtGfaVzkwVvIFdHUnlPq5kPpjO3wlU3+hQX2n+jvyHZ1quf8JRXR0iu/Qqv7PLMpqHLVpiMjtkdraZeecSnhPg/3NhKExZf4XbSUN3ddhcUJbn3Clu0VARMHoqfK/QclXo0p8KXT/Y2YmEOwPYhGExATFWb6HWAAK0LsFNwjW4m/1twugeo/pqkVvH1SG9/nqrcawN9f6UuUw44i0Vb7gLcG6/Zi2YgvfNgrCj6Em5d2+J3frdm9aNEVarEbrjmV5u+2aTcY1oaqBSJkqBgdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KWCW0Jt4fRa7FwHMzElmVODtOLgAaWLkUNaR3D6Dds=;
 b=gH6U9YOnswXoi8kBww1xydsegDcbf12bBsRavNHBXcK/gT31VTSWCcYHbHof/9RApAW0LfXgCBYj7jMAoFRGBf/+qfYaR8j9JiGVE0VdKwq7dwTdRKKB78ibPle8lNEYt4Jvc8fuUgEYv7sq96LbLoR9xvzEks/TdoycdnSRBSkVRea0qud65GP1ofujYNGVh12ap8ea4mEdpeLGQ4reJQJEXsh/UWg7pZIiwTy0yE8/nRmgKA6wz/KJMP+V+yuhaFoASdMijmSz7K1HSuSCsP4zjnNZzXJtpgApJc1F72pf3HyWMW1vcfXwbUa36uiuUMmxdzycqkWbzUbfZA/d6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KWCW0Jt4fRa7FwHMzElmVODtOLgAaWLkUNaR3D6Dds=;
 b=Y0AUN2inFYVW5rUImAlqjPXWxyx0U8RNw/NQKK/unybtUVhxnpy01I3SVYqKw2iy/YwhIe1IQ0Y47c4w8OSBtPnHvmGSXc/4+eS3wBrfVi2xgl2eN9LT+/9sX0+GDFZ1PxuSmHoNRzrLeGzSB5mGOeYy838Drg7/XrlXB54NraU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB3291.namprd12.prod.outlook.com (2603:10b6:5:186::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 14:47:09 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b0d6:ffbc:e5a:3903]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b0d6:ffbc:e5a:3903%6]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 14:47:09 +0000
Message-ID: <85969e6f-0caf-ee73-5de7-dc0f587734fe@amd.com>
Date: Thu, 14 Apr 2022 10:47:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: fix race condition in kfd_wait_on_events
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220412215853.487491-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220412215853.487491-1-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0069.prod.exchangelabs.com
 (2603:10b6:208:25::46) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04087cce-5352-4d39-d604-08da1e25a6d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3291:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3291C21B772143BB3015CEF4E6EF9@DM6PR12MB3291.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ETAVve+WT93057M+7JBdB/8d+w+jeZ9MEfhDzZMwEMtUCjEzpf/wSsq7sd8xc0RnXFIS+EmYWAHrB9xp4pb31oVg8/XCcrNJxeN/xvKXHEAWAuB2511AzfEiERkwL67nlx1W0xHU/jiEzuyrDFNHu/2A1GQRtx6Dx/5UHiaDatXX8/qOtung9DcMzgb0+0kD+M5COvXsyXEEC9xRDyhabW6PJun43nFwWIFfQVWIfkmljzDeOQK+NRC1CGLBRpV/Z73CFcNGiq8W+HZ0Lt2eS3V4uyWcRKej20Cg1I+K9tUPfn/bzdLGTiE2Tgn0AyB7V/Q4fkENWrOFlrMR+iDW5SX8/8+gXsfNPiWTk2+nvav99q/Qrsc2ttrrGPXK0+iKxkMEqA0TvdiJ/ajgD5hEuFx7RatC9Qhmku3MstGyMZ5a0we8bA+VYsuyZ+dwJatwG5P7jcL1+BOWyztEkQcPaqRtj0BrieAuP9gfvIRasqUo4wwLthmRlxZVyHRhQZW3MQXT5w6gotBf7PryeXuF5iMv8kmrdaaUiStFkdjuwZZxrW/9PFbPlmG/VuS6m8SRX17MpxR1+FpJqyaV8Y1GS+lXODEtfJ7miQ7Oo8pn3D60D1VloJJ4bxyVC6l/bE5qTHTWwGRH4SA5qc8WptdW2I/+t7E8KqBaKY2s7gzTe5K45WAv2c+vtW2Gdsor4nXTCxKcu6ijDIKEwiFvDiSqrrETvm1ssH2/r3VZaPdjAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(8936002)(38100700002)(6512007)(6506007)(66556008)(66946007)(5660300002)(31696002)(53546011)(2616005)(316002)(8676002)(2906002)(6486002)(508600001)(31686004)(83380400001)(36756003)(26005)(186003)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejZtUjhUamNrZGpEa1ozaWhoa1RXUy8zMFJaNEFzbGJDL2NUM3lQaXBiMjBq?=
 =?utf-8?B?M0tWOElhOXNLakVNNXE2VkV5NC9vL1I0L1V1ck04dlhVcVRrb2tObUl1L24x?=
 =?utf-8?B?N1ljSTg2MGJHSmp3cEdRdkhuRzI5V2lDQmNwZmJNWTRhTWRmYjQrVG9OZjBL?=
 =?utf-8?B?ajV3eW1Vbnd3SWJhK3BnUTQ5V3lPOTI5dC9YOHpLL0dHcFNST2h6OUtwdlVN?=
 =?utf-8?B?TFlaTFJaTERMeUlvdGYrMm1Kc0Jwd0J1cTJPSkJ3QzNNQ3VKSGk4RWlWekZu?=
 =?utf-8?B?ZDBSQ1QzL2ViWkZ6TEFKWHFnbWxJbFFFZFdXeExMektseUJHVWEwM0R4dWRE?=
 =?utf-8?B?eUJYSE9TNHJkbzBZRnkzTmdWK05iL1huaTFJSm4vKzdYSUF2OEhlTFdNVElL?=
 =?utf-8?B?dXBORFRzWWJrbTdaK1h1dHQwRnVlMkJLekRvQzQwVmM1TGhiSVlXa3dPSjNU?=
 =?utf-8?B?K0JhUDBEOEI4ZVpZMkx0aFhuc2ZydG1TZndmSnU1eU1BMUNZdncwUXQwQzlP?=
 =?utf-8?B?d29Qc3hhd21CY0VXOUphZ0cxU2xVazkyczVRei9PNjNRdVZpZnhsZnk5bWNj?=
 =?utf-8?B?MGRPVXVhMmRkVWhaelVNTjk0UHA1YjZaRk0rSlg1U3VubGU4TFVLZlhDOXQw?=
 =?utf-8?B?OGRLb2tKQzdWazRTdUFHUFFoTkRIZ2FiMVo5N3RNZFhPaEdJZjYxaXdFN210?=
 =?utf-8?B?K1VLQlQzZ1FxUUNEbDFXMjBOcXY0U29xUTBzMVBxRVdGYkhDZjZMSnhWdmhB?=
 =?utf-8?B?Y0xZd2xxd1BrV09HZllXeTZVN2tFUHBvTk5hNDBHd0VnVUZpYXRQQkV4Tlly?=
 =?utf-8?B?Zjc3SDI2dVZXWWxCMHFhSitxc1RFY3F6Q0gwbEpiWkRiRjJHQVRLRm8wcEsr?=
 =?utf-8?B?MXovUVQ3RGswbGVoaXpuN0lPSGhmOEFtTm5UdUc1elVNK0dFQ0RMZWF0ODhm?=
 =?utf-8?B?czFURWxyWncvV0ppL2lJUkNQWDVBNVJSQjY3K2FXdGkwbmxudllxc005aG4x?=
 =?utf-8?B?bG0xWlhWT0p3Y0tPalFkVmxEUjFvN0tXV2czTEpxWldLcldjWUs1WS8vTGho?=
 =?utf-8?B?T0w1c1VtWk56bXJ5eXpmTGNzNm5nRi9GUm1GV2RMNlpSRXBWd0wxNS9Tam5L?=
 =?utf-8?B?cWQwQWM0dmU4Y3p5R1BDRUZjVVV0M0xCdlREYUVxNDFOS05HY2tBN1hYZmJx?=
 =?utf-8?B?bitmVTdYM0xMQXUzd3l1NkRidFM1aXB3VHA5S0lnaFhQNHp4NUQ1VGE0bnNw?=
 =?utf-8?B?OVl0czdXMjVtMXlCL244WTB4UEwyZW8wWTFrdzFLUWUvallPYTJFbVZPSk5V?=
 =?utf-8?B?bTgxa3B4U2xWZHI0ZjNyd093MEZiRGo4VXRSNWNsbWVVZlV5VlVYY1FMQnVC?=
 =?utf-8?B?ZGFrd1M2UThzeEZMa1hNWVZWUjJkdDE0TndFUHBXaGRwREZkSTZ3cWtKZnZX?=
 =?utf-8?B?KzYyN2tzcVA4Nzd4dWJhYnhkTDFiclVvWi82VW0rZkVxQmt0U1VKZnR3QnNT?=
 =?utf-8?B?d3o1R2F4UHFQbGRXRnhmalZzNnExcXpoclpSUWhrQkJxSjZXRTQwdkI0SHNr?=
 =?utf-8?B?c2JVWElnb3Y3MUFlbGZWbVdmUFhZN09PVzM4UWEwZllGUGlLQjRjQlRMWlZ1?=
 =?utf-8?B?VXlLOHdST1BvUndobXRSZEFVSnhKRHdGQmJ3RlVzem9EWk9oRXorbmxaYXoz?=
 =?utf-8?B?OHNYbnA0YjE0eUxVa3doaS9PR2Z2MktGbm9IWElCbi9aQTBKM3NiL2dJNlV4?=
 =?utf-8?B?RmhjQWtnaHB0UWZUTTgvUmNoUUNXRHY3aUFnZnlEd0wxVmtyMHlsQ293Z0FB?=
 =?utf-8?B?cFNkczlPQWV4dUQzcDhLaS9lS2VkdXBFZ0U0OHBpN3gxN0FCekFQWlVKcFZJ?=
 =?utf-8?B?ci9pY0h6QktFaFY3dEJpeDRUejJJYkJMN1NrS0dmaXVCcDZEM3JoZ2VGNTdk?=
 =?utf-8?B?WjZDZ3orVENBMTc5OEhXOVlhclFISnd6aC82R2lSUjZIMzk3QkFjeGJxcVgr?=
 =?utf-8?B?SURJVW9DZWpzZUhTVnlSWjJkQnNlaUhURXZWZlBEMFhZK3dGWTd3OGtCRXh0?=
 =?utf-8?B?eDlGa1lGZlRZTklNVWs1Mkg0bFgxMnRRb1Y2UFp1TGFYOWJxam91NUUvWEpy?=
 =?utf-8?B?cWNpcHd6Qlo0K1A2ZHZ1Q0pUblFYd2NZejl4eGxFam43eDRqZy9MVW1CbG5T?=
 =?utf-8?B?bDdYeGlSMDdYcUFuN2hrUi9CR0FtcnQ3dXpqa3RTbmExallvaU90MEFCK3VF?=
 =?utf-8?B?VWhnY2lDSGpaK3dKSzZzb1E1Z2NsZnc2ZGZicXB3ZWNiNng5K21Ub1pTZVRW?=
 =?utf-8?B?VEk1NktWZUJJbDVtcGpNdnJmZDRGcXk2MTR1cllBRitYMy9wUnR6UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04087cce-5352-4d39-d604-08da1e25a6d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 14:47:09.0213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZqN6qUQj106KBBlthyAICUH9bFAqM0bB/IYueVtHbpOw3wK9QMxIjd5/Mt53Ndy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: sean.keely@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-12 17:58, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220412215853.487491-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">Add the waiters to the wait queue during initialization, while holding the
event spinlock. Otherwise the waiter will not get activated if the event
signals before being added to the wait queue.
</pre>
    </blockquote>
    Reviewed-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20220412215853.487491-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 26 +++++--------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e43bb14adfca..ca562b9a8abe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -784,7 +784,7 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
 	return event_waiters;
 }
 
-static int init_event_waiter_get_status(struct kfd_process *p,
+static int init_event_waiter(struct kfd_process *p,
 		struct kfd_event_waiter *waiter,
 		uint32_t event_id)
 {
@@ -797,25 +797,13 @@ static int init_event_waiter_get_status(struct kfd_process *p,
 	waiter-&gt;event = ev;
 	waiter-&gt;activated = ev-&gt;signaled;
 	ev-&gt;signaled = ev-&gt;signaled &amp;&amp; !ev-&gt;auto_reset;
+	if (!waiter-&gt;activated)
+		add_wait_queue(&amp;ev-&gt;wq, &amp;waiter-&gt;wait);
 	spin_unlock(&amp;ev-&gt;lock);
 
 	return 0;
 }
 
-static void init_event_waiter_add_to_waitlist(struct kfd_event_waiter *waiter)
-{
-	struct kfd_event *ev = waiter-&gt;event;
-
-	/* Only add to the wait list if we actually need to
-	 * wait on this event.
-	 */
-	if (!waiter-&gt;activated) {
-		spin_lock(&amp;ev-&gt;lock);
-		add_wait_queue(&amp;ev-&gt;wq, &amp;waiter-&gt;wait);
-		spin_unlock(&amp;ev-&gt;lock);
-	}
-}
-
 /* test_event_condition - Test condition of events being waited for
  * @all:           Return completion only if all events have signaled
  * @num_events:    Number of events to wait for
@@ -945,8 +933,8 @@ int kfd_wait_on_events(struct kfd_process *p,
 			goto out_unlock;
 		}
 
-		ret = init_event_waiter_get_status(p, &amp;event_waiters[i],
-				event_data.event_id);
+		ret = init_event_waiter(p, &amp;event_waiters[i],
+					event_data.event_id);
 		if (ret)
 			goto out_unlock;
 	}
@@ -964,10 +952,6 @@ int kfd_wait_on_events(struct kfd_process *p,
 		goto out_unlock;
 	}
 
-	/* Add to wait lists if we need to wait. */
-	for (i = 0; i &lt; num_events; i++)
-		init_event_waiter_add_to_waitlist(&amp;event_waiters[i]);
-
 	mutex_unlock(&amp;p-&gt;event_mutex);
 
 	while (true) {
</pre>
    </blockquote>
  </body>
</html>
