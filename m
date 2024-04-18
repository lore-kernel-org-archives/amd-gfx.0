Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9630CC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 16:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2783E113DCE;
	Thu, 18 Apr 2024 16:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="02mA0c5O";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60868113DCE
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 16:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvNH/lj/8EGC+uky4xq4nbya87uK1Y3i6jYpRnyuPolJVLjlcyW2F2ifZXCKX9Ms6PuE8gZtY0dEnuo1hbu/5hYK//0jUqt0rO3P3vjpDfCWC432c6ZHuvSdTH4oK1WlYycEQKPMko390O9B0NEzJjzf/CH86l+1YWFuTW+bb/6sSM5brkgGQtXidkuU4PYu87vR0cG3pSrc/gvyPYpNXCoaBO7bU/hPsUEFn5sEb+Lofi+9SsRP4zQR8UBk2xQFqzRuKkrzewI7SUAtgrraU0PUq7E1TJAmf1R5F9Itr1Gjd+VEDNK7MNQKrRlrViEV9ztIwJiMs7BysrCTfR80oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKa349kNEtzFm9j7ApbyWQxpg7vwKA1TV9PpyLT32Lo=;
 b=RZoHdU8juCnyS/OP0Y6s3taJyNTTqLl7V0sdEeXuQvVAkkknNjGQLZRGq8hvl1/uyfYA81iR8rdbOyM5e7/kEOo1LUoZ6g3jH9AynqCBJoVCOHjHv7YPinkvUmY1fa+tfmJ5NirAPopLZK/h/Z408WSkjxDKbR5hzFQom+VFmZgHi2R7mDv4+6tkcXTK5ztqltf/ZgwaZl8yEPZxfXO5+q+jD9RO7aDZ12wKqa6BnPCoSNnc9yDIqywg87bzgBtRnqJCbEjiNmgopwJJt5Xb+l68riiPXz4IyCNBGb1uEhG2X2fmhwzgAlIoRR4Q6gVFAiwKgTJ39XQ5VxUnI9UT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKa349kNEtzFm9j7ApbyWQxpg7vwKA1TV9PpyLT32Lo=;
 b=02mA0c5OocqiHKe57NGmDVbDOt4GJRx2Qig06CIO2eGMUoaGTc+FWLtFo+Ekz/OmMfZ4jvBkYhqXNzP4yrl25721o+rysSxHTqaBqlJEEXWL0Hy+JRp6Yxy/hrRJkKF3uUobcXWJQ71fdgzENz6Ih9nIwxi+l6dwwGhos8fuzIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:33:59 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:33:59 +0000
Message-ID: <1315e3ae-95d1-8e08-af95-39ff3f89a97f@amd.com>
Date: Thu, 18 Apr 2024 12:33:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix eviction fence handling
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: gang.ba@amd.com, vitaly.prosyak@amd.com
References: <20240418031410.2815452-1-felix.kuehling@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240418031410.2815452-1-felix.kuehling@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0329.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b5eb57-ece3-4b84-1998-08dc5fc5591d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLYxUVAk1BU9+4KHLO+8cGs2m40HjTbi1Py2sVXgUFc5lOtsVgCtBCxxw5nzitRZpt9cTEEMwugeaoi3k8TV4cW8nAiMdUiPOY2FN6B6Z3FWwjVIiTsKfdEdyT5iMtfegcnVoKNc3/C/Ch1ZjbzItMKEkdcgk3qIjhud6ksbmg5Y8vme5cP1DzWTtD8pt9Ek5JRQJIn2j8g2KeyrphDqrbIsWJBCjk4plkonLyETe8VOzIFUwrv1csTT/I4sMnanw3tvehwYzOssFc9m1F3dUbVZg5XpJ7tSTvC5A3bU4JNSOnQjNP3nSux0nRx0xRxry0rxGGMl4KKIDnIXudeGEwJJcUQkNq6b3wVLRf+LDCbWNQ98X+nymOE7JvVdABhC++ssP55OZIG1dqvcMufXKANe2+XF2akxwle7cKBJHXMUApgGbm5ACfBqlIT5RzSXDauEMBpk64ENcJza25OuIwbipHLo8FMbUFPI+SfL2l/Y0ZUcJ7PoY0anKJxa4H6CLyaMmLQ9MvKqe0DYNyTcuw1b4jUSB1KTIMmxvNM+3WqYqERJDJL7kuiTuDctZPbpwRkscE1wG99tiK2kSYkB+JivqfnsXzj5Bm03Hd3capwv/1JGVRf1LHg+HQPQCfo22TctSe6ul3hqZGRrACk4H2R23v8jtqq5K0z3YlIBrsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzhIOEtySHh5T1hWOTNhLzBmL2QzK213NG9XRk5YZ0NSUnpQNzFHdExOUlBW?=
 =?utf-8?B?VjlZVDl5dXU5b0ZieGQrUE43NnI3OE4wWHVZbUVidnpNNG5BM2Y1akl6cXVk?=
 =?utf-8?B?OUJhU1pNN05RcHA1b0pFN25NMVdMbkpCR2lEM0YwSzNaNktRZnRGUXVLbU13?=
 =?utf-8?B?TUFxNitSWHVCWjNKTVFSVXp5dHpCcC9LZld0S21uYnNDWGZobTdGelJCSFNn?=
 =?utf-8?B?K0hISHBKblFBQmZLRUxKQ2V0UHljaUM3bE5NT2tTbVkzS2Y5Q2gzeXV6Tk9i?=
 =?utf-8?B?bHZkZldvUS9aTlV2Sm1ueTNSdGhjRk5mL3h3bnBwQS90T2JnWSs0WkdTOFpr?=
 =?utf-8?B?TmQ5KzJCK1MvUlRSd2VZaFRjaWVBVG5ZM1J2ajEvMXpHSUQrRHloWjlaaVg2?=
 =?utf-8?B?OXlscFRQY3h4ZVIzbFp0dG01cVpPMzd6cEk4VDlEL0RSSWZUTFVHbWlCWlVz?=
 =?utf-8?B?a2RpRkRtYmc1WFBEZEVORHUwcTE5QkNtTWsvZjVyU01GQmk4SUt1L203K3FG?=
 =?utf-8?B?VG11RlNUakVyMXprV2QxbjhuUUQ4MUlSdkFxcUkrbW9HVVptenZDWXhUcngw?=
 =?utf-8?B?VHZCdHFJc1hqYUlhOUR4WWd4eXF5Skdpb3NVeFhGc3JzVTA4R1d0K0xiNEt1?=
 =?utf-8?B?NTd0elBraDZNYTdSeXBKSENmeWRReWNhOTBvalRZMGxQQ1dYZ0oreEs1anFU?=
 =?utf-8?B?Q1FzQnEvd2gzUUlVcFh2Q0t0RzVnUmoxNkRtL3BYR0NSalBGR1BoNWh0Njc4?=
 =?utf-8?B?bmU1UEwxMndPcmpTWWw5NCs2M2pTc3g5cS9uUFM2ZTdyd3VXbFNEN2xUa284?=
 =?utf-8?B?QlNlNzMxb0ZJT2YyNXBmNkN3TWluMjQyK0M5amJsaGpUc1MvWVFaL0NHRGxy?=
 =?utf-8?B?QXpRekxGZFZXZzRtWlV3ckJLUzdzV3dQdExTRkVrN3pwV21CMnpKUFNTV29t?=
 =?utf-8?B?N3pkYy9PWFFtYkJDRUNyZlgrSzM4ZE5WSisrQmlwL2ZEeVlYQzhWK0RCZ2Z5?=
 =?utf-8?B?OUNWZXhtMEVSZVRabWVySERMdDFWQklmUlQvbmpOUjRtaElDclNPL0laU0tW?=
 =?utf-8?B?QnRWdEdDU0MyeHF1UkdrcU9QU3ZXTWptL1M5VDFlYy9LdVJmaEx2YXZDK2hY?=
 =?utf-8?B?TGZXTHdlYWNHdHdocFVkZ2QwRjBvWHZhKy9KdU0zNW1jWjVCVXhrNXFxTC94?=
 =?utf-8?B?RmdiV0JSaVhYSFJCb3JpeExsakRod1J6WUwzWi9ORkVsVk5BL2xRaVRNRzMr?=
 =?utf-8?B?bURXRFBFRWR2R2F0ckNNMVVlRU8wcWZzZVZKYXZCQTNoem1qbzZoMWVRbDJX?=
 =?utf-8?B?TVhTNXp5dFpwMXlpUmsvbXltWkIxQVJwdDQxMzBJcDFrQVUvOVdpcEtTc05Q?=
 =?utf-8?B?Szd3ZkNJWlZqNGtOazNCSjdwRi9Jc2w5QVRVTkZiZzh0TG13YmsyZ21VVUJZ?=
 =?utf-8?B?amxjZGRvbUNmVDlZa2puYWd2cUtPUW5rUnI1akFTckxoQWtpMkxXVmNZU1VF?=
 =?utf-8?B?UjB0ekZSb3RpSnVndXFyNlJvaE4xRVlPdjFLK2lydUJOcGg4RzVsV3BTNXJG?=
 =?utf-8?B?V1ZzVHRWUzhxUVdiMHZtOUxTQjBrUkdMUFgyaFZLM3pud1BjMVBybmRSM0U2?=
 =?utf-8?B?YldUYUcrZTVBNitBOHdVako1SHJoZFRNaUNBMjZmTDlya2xRSjFSV1ozK2t2?=
 =?utf-8?B?end1akhYNUUzcWJzZkxodUMyYm1LektJK0I5QmVsYXJSZWRSV1dkY29SSEh2?=
 =?utf-8?B?cCtVVjBSL3EwdytOaXc0alRjVHpOQmhCYStkMVdHcXFGZGVySCtNUWt0L2lU?=
 =?utf-8?B?Njg3VnJNeUtUcUJGUXJMR0VPODhlbTN0cG55UzhNeXZoYm9BSWllei9qQ3RG?=
 =?utf-8?B?cHE1bHUvTUp4ZVF5M21nZ0NRQTl1RTE3K05VNWdha3JoUGM0Ylp3dFFVUTJo?=
 =?utf-8?B?bXlyeFFCL2ZZc24yM20xa3hXNFBtakpIK2NXWVE4YVhsYjZobEIwNU5OdnNK?=
 =?utf-8?B?NEI1enRaajdCeCs5eWQxS1pDNDNVamFzd09rTkZTSGtiazhDMFRqek1Tc0w2?=
 =?utf-8?B?OFB4R015UEJLRDFTMmNPWk5HZDNUSHl5TDFTOFRva0RMdWF5Rkk1cHVObVMw?=
 =?utf-8?Q?dRTM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b5eb57-ece3-4b84-1998-08dc5fc5591d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:33:59.0335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zArZ07ZLtARlFXMz+uufUCAKfXGLgap3rm3zZw/C/1goUFC9Y2SvAPORqTAPF4L6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-04-17 23:14, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240418031410.2815452-1-felix.kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">Handle case that dma_fence_get_rcu_safe returns NULL.

If restore work is already scheduled, only update its timer. The same
work item cannot be queued twice, so undo the extra queue eviction.

Fixes: 9a1c1339abf9 (&quot;drm/amdkfd: Run restore_workers on freezable WQs&quot;)
Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20240418031410.2815452-1-felix.kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index b79986412cd8..aafdf064651f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1922,6 +1922,8 @@ static int signal_eviction_fence(struct kfd_process *p)
 	rcu_read_lock();
 	ef = dma_fence_get_rcu_safe(&amp;p-&gt;ef);
 	rcu_read_unlock();
+	if (!ef)
+		return -EINVAL;
 
 	ret = dma_fence_signal(ef);
 	dma_fence_put(ef);
@@ -1949,10 +1951,9 @@ static void evict_process_worker(struct work_struct *work)
 		 * they are responsible stopping the queues and scheduling
 		 * the restore work.
 		 */
-		if (!signal_eviction_fence(p))
-			queue_delayed_work(kfd_restore_wq, &amp;p-&gt;restore_work,
-				msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
-		else
+		if (signal_eviction_fence(p) ||
+		    mod_delayed_work(kfd_restore_wq, &amp;p-&gt;restore_work,
+				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
 			kfd_process_restore_queues(p);
 
 		pr_debug(&quot;Finished evicting pasid 0x%x\n&quot;, p-&gt;pasid);
</pre>
    </blockquote>
  </body>
</html>
