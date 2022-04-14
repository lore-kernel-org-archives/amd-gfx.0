Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB966C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 16:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E33710E32F;
	Thu, 14 Apr 2022 16:19:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E69310E32F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 16:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP3e2r7T0/+dOzVMcWho17FJOdJBxVfpzutWfbFqZ4RXYpuDwQTOXTK0r5SScf4iLTlfHoKsYruxvY3etOaFcz1OJaCqimeaTlPAsIQjfFiisVkLuzioFW44qGRCfTzRMQ4U3XeE3SU3bcvVjuLbchsvge8bSGHCnyhad08O6tgiJKGmKFUj5bXQ3uay5y1kCoCRcs47FPhXQwnx3sbWz7pzBvwgRG4r67KuJqcIcycKPSUQ/TTALDpFbB3e2i6bE3F85EY595TTPLy5tLbAOfBBffB0PyHGAJDFRnl5x3TWTHElUf32+FsQIPoSqjEdKsLMROZTpzHw2FjAQDIgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+zHyy8Ax+wmKzWIWC5QpRbDbfkcUrU1jsH0YqVjPdQ=;
 b=jcSHQALAZhXwg4DP1tDKRVb/tMUC3KmnNqGdd49oRIrH8u8Tw21kQkewCkTcaEGuZXBU7mz9Ocs0Pg0jAt/Y6FlC9FVwR7XWVplqOPhyhIfZN/8UYoRtLW3cUPhJLm7t1KdOSRe6iqcP6BG5nZG3JDgYd88zQ7ea+VhTla1bYEkqYguGKJqbayhqzUmhkJK+ochpRl0rpV5QTbTTym3r1kv06DDaNitD4PNjPYZzHzomm8A3HY13F997eU9tlr1zn7R960rZjNfpkUKVoAqIeFfNaGLBUcUi8lUTeLNCBNpGKTns54dDKhGJ+Cf8tuciUOXAbDujlyFTQoqpJq5BeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+zHyy8Ax+wmKzWIWC5QpRbDbfkcUrU1jsH0YqVjPdQ=;
 b=v1AMd+knIb3Fi4ogvPWqXbYb1ROINcppxMMem3HmPtBMpTPFYHbjyw2QtIyDqe0XpS58fSFCS2BxTs+YdqmOBG8Y9ZpoMRIYo3wAV8ND2Z9ug+F/mH+tfVeTcz1vzna/AToHDhKGRRh9JDVBm2BKpRRrsQGJUDLx1apJHUmfgSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM5PR12MB2343.namprd12.prod.outlook.com (2603:10b6:4:b3::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 16:18:38 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b0d6:ffbc:e5a:3903]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b0d6:ffbc:e5a:3903%6]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 16:18:38 +0000
Message-ID: <a74d29b9-0cc0-c858-dc6c-481a8d7b99b8@amd.com>
Date: Thu, 14 Apr 2022 12:18:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: Ignore bogus signals from MEC efficiently
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220408024038.320357-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220408024038.320357-1-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:208:239::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121af2da-b40d-45a7-373b-08da1e326efb
X-MS-TrafficTypeDiagnostic: DM5PR12MB2343:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2343F1D64FBD6B77F53F2EA0E6EF9@DM5PR12MB2343.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: be+LIFCUfYxMnzcAmj7R3+ELVj6EMSbrnV6ZrQLMD6ptj1wxGU0I7CWxGjG5jD/Y1U3AXXWlOX/TJXJMxtGe6u6qY3tDZv0a8kHwBtBOoz1y2Y3+9tAhsNjOW+Jy7G520wgDGNZ5fBkfTd9HN87UFYy0NJwb3Nj6ZqBEuYU4r5FPKYNHW+j5ZHYZDO9gVOpHFUrqqCtEUj17iOVaNcgyHfNNwsJ7VHHW/4zBZAV6IgSiak0J8lNVUN2AH+N7XUwoGirLPDfaGPqm3Y41Nk73P8XJbz8AGKutP+WrJlMAlH8x7O6EnF6IqiSS5+epiHOD7cn+svMW+rLnIoIEK5/ZPgBKtx7kXYVvrrd+xnlZpDun3pxD6m4H9j1wt7w8sxtJdlYOBZHYrrmMbD3L+/twChkLVd26WNO+WfTOVfMyJYdl+Hd4J/30XBJaNG8l0H0UF3kvKpP62mFi9911GlaiWjRx5ioaqG+D/V+guJYmUhwzguVbwr95AYmqaJpo32hgBJsbUZGccYBOyGUiYz8HhscPTWBMQem4X0d0TAd+nx3ENKNxu2N+azqMrQspXZhLHtFQ7MwK7TlsXXp0v03tdQh5cjdF60dHwGpMgF+NHw9WnTgcFY983PDfPOwcaZmBYisC7WS/FX4BmZCVY3InGN2JcA1boxjQ2oMKZFxrJm9pNjfo/m6G5NqXhmup3hOQOznUyaFhv3Oyjc8wsjGenvtN6G+bnGdDOBsGtX32RAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(2906002)(6486002)(2616005)(31696002)(8676002)(6512007)(66556008)(66476007)(508600001)(4326008)(26005)(186003)(316002)(66946007)(6506007)(5660300002)(8936002)(36756003)(83380400001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlIzWTNXODRZUmtCUWJBZVFKbUN0M1BOcVlJU05IODN3WTBnOUNRdUcyM2dN?=
 =?utf-8?B?RWVCZWFINzUxc3d2eEt6dVdHdi9nREtWRDBvR1UrSnRRYmtRQ2MrM25HMmlz?=
 =?utf-8?B?QWd3ZGJCMm5ZNXJObVNQSUlsS0M3VjlFL25Pcmd4bC9oeDRpS0Y1YXpwVFlO?=
 =?utf-8?B?WnN2QkVVam5FNUtBaDdjMERiWmJ3RjY4bXYwaDZ3d2dRaHR4MytKdTA2NWNE?=
 =?utf-8?B?QS91UG5BRVhybmFkVW05UU5iRlI5ZEcyT0s0cTUzOG8xbG1TZzZtMjVIQXZx?=
 =?utf-8?B?Y3dvMzBQbEJSdkdHVXU4MXJ4bTJ2M1pEWmhxUzdZSkc4Y25tb2NQSDlEZzNT?=
 =?utf-8?B?UFFFaFNCTkNBWEd2VEpENEdtSEh6aFRnWFdkQjdNNFk0bi9jOW1Ea3dFeEl1?=
 =?utf-8?B?dGxmV2kxcU8wNklHOC9tTnVQNGlHT2NKbElweFpJWjNGZFFibk1iM1phRDlx?=
 =?utf-8?B?TjdGY3hSVDIzT0FVaGJtc0F5QjdGbCtyZFFDTHZWNUMxeFREb1NBRGpEZ1J2?=
 =?utf-8?B?N0lGdHZDSWhIQmIzV081MXpFT3FadlI2d0VzV1drVFlEVDFwc0l4cXIrNjVw?=
 =?utf-8?B?S1kxSHdzdUJxMTY2SDU1bUU1TnJTK1JBSy9tWUlSb1NZQTZTNUxQckhkSmlT?=
 =?utf-8?B?TnkrR0liVnAxQjFkQ2RJM0xtYldsUmp5VXdxdlFNSSt0amVmNEVFdi96ODhu?=
 =?utf-8?B?K082Y1hMY2U4WFNEM1V1aXhNMnZrQmhMckZDeHhjclZNOXNzc3hxWUdwbUxP?=
 =?utf-8?B?MWdPL0d4bmtXcElhVWhPendhNFpHRTRHeVJwYnU1UjJITloraDZMb0c0RDgz?=
 =?utf-8?B?RU9QMlVReGkxbjhwanNVMUxyU0dCL0t1ck9NYmZicXZvVXl3VmRWcHRqOHdG?=
 =?utf-8?B?S3NrUHI4TFkxUlNBZVFUamxSMWduUUVmek1WOVk4VkxvTnJxKzB3amxkL1hL?=
 =?utf-8?B?dW90cld4MlBMbWgrVDdnRFQ2SXlIMlVTRWRlbHYxQ0RGaVVOSmhhQXk1RzVo?=
 =?utf-8?B?aXd2UDVFMEpkZlNnRjRVdmI1UjFmSXdGQzZuZ0Z5YVRhMEN1SkxyMUhUa3hv?=
 =?utf-8?B?WDJOMkFTdk9vUmdQMVFPcUFhKy9pUFoyYng0MHIwVWVwVnNYQ2hSa0xsYmk3?=
 =?utf-8?B?SDFZdExRdWpta2hlWFZmV1FESmpHZ3VRRHNTbFlnd0Foa2JIRlBRai9WZy9Y?=
 =?utf-8?B?VjZaL2NVQjdGSkZ4bDc0YkhaYzVYSUJTMHRkdDNhYjNBRTlKN3dhemFQWDJH?=
 =?utf-8?B?ZGRsMk9DVmZiejhOY09jNkJlOWZuQVE0dU1BUjNiQmZBS3pIYUFKdi96c2Vn?=
 =?utf-8?B?SkU4Y1B1MiszOW9GT3hlUzZTL3NWRXFWb1hyWnNWcVpINlFNVE1PQXcxZUVi?=
 =?utf-8?B?YUsxUVZmVXlKNmNURnB5TUhqNUFmTkZYTlFPRGNsMk1KcEZXV0piK1pBZ1Nq?=
 =?utf-8?B?UHZhYTJTYjVBQjlLWWhyendQZ1dkTlMvazJnNFh1YktFbEFQWGhkbWFHVXZI?=
 =?utf-8?B?cVBBWXBYVHRBL0JVMlJtd3Zjb1QrZnJjRjJCZWp5MTAzNm4wcDQ5VzBwK0Fs?=
 =?utf-8?B?a3F5WDFIN1NBVXRMMFN6NWVqSHU5VXRLbUpNd1lKc21GQVdyUjE0MDNOU1dO?=
 =?utf-8?B?VVBNWlQ5UnJPYlVCRWd0NVVPYi9IR2pOQms5T1dUSHNMNkFYdmtmcGptdXBC?=
 =?utf-8?B?M05GQStSU3Vpb2JZemMrYUJXTThXc20rOEZuOS9ocDBqUEVla2o3NExiVjZU?=
 =?utf-8?B?Yko2aGoveVVBeVBrbFczR0RSNnAxWnpTaW1SWE9ONWxZSGlsejZ0eFhOUmN1?=
 =?utf-8?B?cjVFN3V0b2d3c0RIVXVIc254TGtwVTJOd3QyenYwZ1dSem9uQXIycXpiL2JF?=
 =?utf-8?B?NkdPdDdRZEhXdjZRSk4vZWVvdUNSR3FDTXRacEt0WFlSeUNSdXk0YUY1ZStR?=
 =?utf-8?B?Wk9Td3VobFJpZ3BHTXMwemJYdWhVVXdhSGkyTFNVU3c0eGNTSGE3QzVxdjhX?=
 =?utf-8?B?NVdtUXhKL3lsdU96RVNrMFVveVFOd3F0MWt1YzJaUEMzUTFsRitTd3NGL3Y2?=
 =?utf-8?B?YnBQdm5IT0MydWE5OTg1TzhWeHhzWjJqUUlEb1VGK3E5T1pPclJJeVkwcDB4?=
 =?utf-8?B?SzBFcnd5ZUZkaVNuNUtjaURNRUNRT2ZQZ093ZVFVd2l3OXRzNVpmNVMwYzNs?=
 =?utf-8?B?S0JuZjMxZUt2M0FnT2hPc1dRU1hXbUZQZHoxWWN0U3dnRTFwSVl1TlNlTFBi?=
 =?utf-8?B?MGYvZzIxYk5hNjI3WUVXOE9zQ203cjBaalJYRnd3dDNkcHVaZG5sS1FwRllF?=
 =?utf-8?B?aFJMY1dBSFJrb3k1WG03dTZsWjFSRFdqQlcxc0k2WlRXM1oybnpkUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121af2da-b40d-45a7-373b-08da1e326efb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:18:38.7532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvhzQfaJozCspG9XKZJpNSqK7KRa6HijK1Fj527VoDrJKfmmCdM5JC9HfSwXTXJR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2343
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
    <div class="moz-cite-prefix">On 2022-04-07 22:40, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220408024038.320357-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">MEC firmware sometimes sends signal interrupts without a valid context ID
on end of pipe events that don't intend to signal any HSA signals.
This triggers the slow path in kfd_signal_event_interrupt that scans the
entire event page for signaled events. Detect these signals in the top
half interrupt handler to stop processing them as early as possible.

Because we now always treat event ID 0 as invalid, reserve that ID during
process initialization.
</pre>
    </blockquote>
    Reviewed-by: Philip Yang&lt;Philip <a class="moz-txt-link-abbreviated" href="mailto:Yang@amd.com">Yang@amd.com</a>&gt;<br>
    <blockquote type="cite" cite="mid:20220408024038.320357-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       | 22 +++++++++++---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 29 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 10 +++++--
 4 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 75847c5d5957..e43bb14adfca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -238,12 +238,24 @@ static int create_other_event(struct kfd_process *p, struct kfd_event *ev, const
 	return 0;
 }
 
-void kfd_event_init_process(struct kfd_process *p)
+int kfd_event_init_process(struct kfd_process *p)
 {
+	int id;
+
 	mutex_init(&amp;p-&gt;event_mutex);
 	idr_init(&amp;p-&gt;event_idr);
 	p-&gt;signal_page = NULL;
-	p-&gt;signal_event_count = 0;
+	p-&gt;signal_event_count = 1;
+	/* Allocate event ID 0. It is used for a fast path to ignore bogus events
+	 * that are sent by the CP without a context ID
+	 */
+	id = idr_alloc(&amp;p-&gt;event_idr, NULL, 0, 1, GFP_KERNEL);
+	if (id &lt; 0) {
+		idr_destroy(&amp;p-&gt;event_idr);
+		mutex_destroy(&amp;p-&gt;event_mutex);
+		return id;
+	}
+	return 0;
 }
 
 static void destroy_event(struct kfd_process *p, struct kfd_event *ev)
@@ -271,8 +283,10 @@ static void destroy_events(struct kfd_process *p)
 	uint32_t id;
 
 	idr_for_each_entry(&amp;p-&gt;event_idr, ev, id)
-		destroy_event(p, ev);
+		if (ev)
+			destroy_event(p, ev);
 	idr_destroy(&amp;p-&gt;event_idr);
+	mutex_destroy(&amp;p-&gt;event_mutex);
 }
 
 /*
@@ -739,7 +753,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 			 * iterate over the signal slots and lookup
 			 * only signaled events from the IDR.
 			 */
-			for (id = 0; id &lt; KFD_SIGNAL_EVENT_LIMIT; id++)
+			for (id = 1; id &lt; KFD_SIGNAL_EVENT_LIMIT; id++)
 				if (READ_ONCE(slots[id]) != UNSIGNALED_EVENT_SLOT) {
 					ev = lookup_event_by_id(p, id);
 					set_event_from_interrupt(p, ev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 03c29bdd89a1..7d0111c197c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -141,6 +141,21 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	}
 }
 
+static bool context_id_expected(struct kfd_dev *dev)
+{
+	/* Borrowing firmware versions for GWS support because they were known
+	 * to send context_ids on legitimate signals.
+	 */
+	switch (KFD_GC_VERSION(dev)) {
+	case IP_VERSION(9, 0, 1): return dev-&gt;mec_fw_version &gt;= 0x81b3;
+	case IP_VERSION(9, 4, 0): return dev-&gt;mec_fw_version &gt;= 0x1b3;
+	case IP_VERSION(9, 4, 1): return dev-&gt;mec_fw_version &gt;= 0x30;
+	case IP_VERSION(9, 4, 2): return true; /* was never broken */
+	default:
+		return false;
+	}
+}
+
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
 					uint32_t *patched_ihre,
@@ -206,6 +221,20 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 	if (WARN_ONCE(pasid == 0, &quot;Bug: No PASID in KFD interrupt&quot;))
 		return false;
 
+	/* Workaround CP firmware sending bogus signals with 0 context_id.
+	 * Those can be safely ignored on hardware and firmware versions that
+	 * include a valid context_id on legitimate signals. This avoids the
+	 * slow path in kfd_signal_event_interrupt that scans all event slots
+	 * for signaled events.
+	 */
+	if (source_id == SOC15_INTSRC_CP_END_OF_PIPE) {
+		uint32_t context_id =
+			SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
+
+		if (context_id == 0 &amp;&amp; context_id_expected(dev))
+			return false;
+	}
+
 	/* Interrupt types we care about: various signals and faults.
 	 * They will be forwarded to a work queue (see below).
 	 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e1b7e6afa920..3761655ab0a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1292,7 +1292,7 @@ extern const struct kfd_event_interrupt_class event_interrupt_class_v9;
 
 extern const struct kfd_device_global_init_class device_global_init_class_cik;
 
-void kfd_event_init_process(struct kfd_process *p);
+int kfd_event_init_process(struct kfd_process *p);
 void kfd_event_free_process(struct kfd_process *p);
 int kfd_event_mmap(struct kfd_process *process, struct vm_area_struct *vma);
 int kfd_wait_on_events(struct kfd_process *p,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 9e82d7aa67fa..cb8f4a459add 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1370,12 +1370,16 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	INIT_DELAYED_WORK(&amp;process-&gt;eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&amp;process-&gt;restore_work, restore_process_worker);
 	process-&gt;last_restore_timestamp = get_jiffies_64();
-	kfd_event_init_process(process);
+	err = kfd_event_init_process(process);
+	if (err)
+		goto err_event_init;
 	process-&gt;is_32bit_user_mode = in_compat_syscall();
 
 	process-&gt;pasid = kfd_pasid_alloc();
-	if (process-&gt;pasid == 0)
+	if (process-&gt;pasid == 0) {
+		err = -ENOSPC;
 		goto err_alloc_pasid;
+	}
 
 	err = pqm_init(&amp;process-&gt;pqm, process);
 	if (err != 0)
@@ -1424,6 +1428,8 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 err_process_pqm_init:
 	kfd_pasid_free(process-&gt;pasid);
 err_alloc_pasid:
+	kfd_event_free_process(process);
+err_event_init:
 	mutex_destroy(&amp;process-&gt;mutex);
 	kfree(process);
 err_alloc_process:
</pre>
    </blockquote>
  </body>
</html>
