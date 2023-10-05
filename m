Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080CFE92732
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 19:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8815710E48C;
	Thu,  5 Oct 2023 19:36:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E840410E48C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 19:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqN/SIElKhsICzR5R6lL45dMm1xcBxQO6mtGWBnagFYiECVzRWuAicd8sATvCTGxjTzhtc+R5H5m/f9ajgKkq1NKZmykqpYVNA6KwjuIZ7ved40w0JJEkD7FS3ARvEdUqSBMTyMM/T2s1jOVn+2Dk+BPbOnNDtvfmvcqkXIfLd62HvCKUM4LSwckmeJb3Kq3qlL1sz5FfocvKkkzohgR8tBk3rdmGR9875+Y41iJA8zRTBzn1KpBOczN8pzy6VGtK1utAwmuQeYDQK/x6QGM5TqFiaSLWzXiTyJ5UQnDT/nisZS7UHMaw1SUti2xDekAKMAD0dS9ZfGkNY+L7mfwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUTInA8PlfpjHMlv8r0Ne61g6TQXPQz7fabyS96zdHo=;
 b=mxJl1eKi/J8M4xv6nUIvod5rth21DERLw2MGoIYLXycXICUmKlrynx95mvsih1J117OH9OKHZ5l+S3rV2hhRfPKv+yGAzB8r6K36bfWxwmcbKf/5L/JsToD0afgb9DrxMbEmne7sK6Qrpsviq/VIVj39GXAch3tTICdQOLjNFlHD6nPMEGq3dTIBqGayZLiS+7S37geXPYrYNKEo/RL3stG0V6/BseBfBSqhuWryckvFS2MKha5qeQM/NsnR74x73IW4tl7uKwxFpCgcsyODRgflJYAVLD1oq5yLx4y54oK+CawRw57XDMTrCrB9sf1lleoti2Tg6ufpBuou6sxSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUTInA8PlfpjHMlv8r0Ne61g6TQXPQz7fabyS96zdHo=;
 b=ywu48jc5JdC//DnQcLTmLyQvkOQ/UsBrzKCAECj3pr+MMF1w1kInEFUU+SOwDLNdnzikjZl0T2ccTIvlOrKWYleUC9K0zFsTWRAszbuhaFGRQIxJkqStv0lv2B+oyOH2TMC86ul76HHpsgKPTHYOsokv/lWGpK/Wco4vXcksE7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 19:36:25 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:36:25 +0000
Message-ID: <1f9eb9fc-8c0e-4ee6-8730-5e19ef823eec@amd.com>
Date: Thu, 5 Oct 2023 15:36:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] amd/amdkfd: Unmap range from GPUs based on granularity
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929141115.10016-1-Philip.Yang@amd.com>
 <20230929141115.10016-2-Philip.Yang@amd.com>
 <3c56e437-b901-4d93-a3bb-1b788d1aba18@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <3c56e437-b901-4d93-a3bb-1b788d1aba18@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::33) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd6f03d-c468-4945-e8d3-08dbc5da5cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbIFOb/O6AAmnmkJY3uIEd77dUVFUSF2MC1ZLdIOj9pErry8CZDmUh95Vo/UiX0FqF5ndVLt+ezAPb4RljbYKatyU3X+fX2Oc9cO7Rjn4bCWu2HTkKCvN+bGXmCY9d3qUiWobuY/i2g5LL0qFJvraAnmQxTaa9bO2U14s+/ij/PXCvP3QXSM1Wkd+jBJgcomDdxScegR0u3msA0nexuWi1qk9qATSGlbbt0m4olI1j9CSQAk5PogtbXpbqYQBBbwdlg1cu+6etwa2pjEm7G1LYqz+t5ibXPMhgI4kzSisP4V4IaObBLLe69omSKutLwk2EChE1kh0NYfUo/UxtNrzgd1mTUDmafj33VsDNFFwEfrYO6W0TvgNVzEZl4an67U+0RI1LoZ3z5nGje5pu49d1BbU5yErOkCmLgCeglnLXm0KAvOV37LT5fEj7qG3gzMMzb8ea2fZRlfzTNA4bm7gWVnaXZiDqcg6fwhkCqRLgQAzXzWR6bmmJGBtCn+sU3gh3YE1ckpJXhk/4pnKZAAf/ZLB8iwaKArPiG4Jrx73VsP0bdVmvyWSu1uDIAmXj8N41+UQNc9JpBpBuXR46HzR7HqS9T/Qvk+2rWiFKsGt0fBXg8ugfgj5+g6hps0IW5VAIjWt61z+k6c861JyuyoxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66556008)(66476007)(66946007)(38100700002)(110136005)(83380400001)(316002)(41300700001)(478600001)(6486002)(2906002)(31696002)(5660300002)(8936002)(36756003)(8676002)(6512007)(6506007)(53546011)(2616005)(26005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzV6L1hYUkwyLzNQRnA1bklpdWlVd2VXM3VlMEtHNlJWVWttV1pEUVQrSHN0?=
 =?utf-8?B?UWQwV2xnT1Mwb2xtNksxbWc0cVk4d3RGeGQwd0RjbWNWa2pHTmVYd3RSQTNG?=
 =?utf-8?B?bzkvemRHUW5yUlFHZTl2a3R1OEc1US9CQndzald3Z3B1MmxJL09zTWxvckNh?=
 =?utf-8?B?VkJmcmlSb1M5TG1UNXZMcDE4MEU0dVBJeTBTQU8wRlZBTGtFNVhleHNVQk1K?=
 =?utf-8?B?OTUrU0oyU1VUM1JqNGZYMGN0dnNyK2pkRWNtZkdPeUNWMncwT2JmemdNVUky?=
 =?utf-8?B?aE44c0xwdEZ6RlhuQVJ3UytENTMyTDVlQ2toYk42VkdreG0zUExYQjZ2eGxF?=
 =?utf-8?B?c1hiQjVtYk81RTRndjdHckZJL20ySmpkSVpYSUIySWFQb1B1b24rMEdzSFR3?=
 =?utf-8?B?bGh4YVdTZm9zaUkySlE2UUIrMzFpWjVPbmZ2TEp4amFZZmhIc2lnN2Uya3ND?=
 =?utf-8?B?RUVJTlZ3R0ZKbmdjQVpWT3NxWTdkUWNYTE0rejltQkRnZi9hY3VJNTVuWis4?=
 =?utf-8?B?TDlTRnFkSHU2NmE1OFU2OXZyRzBLTUFuZDJFbE5GUWhtV25nbmRJcjYvR2RB?=
 =?utf-8?B?d3dXaW5QdDYvSXZONDZ3MXp4OXZMOHlWWk5jbzI3NldIUzQ5aXR3c0hNVHFz?=
 =?utf-8?B?UGVobXViSXM5T1F4Yk1MWUUyZ01KODkrTWdXVzVDQXhvQXVJUmZhZjNib1JT?=
 =?utf-8?B?bm1PMjlMcmdJbFdUUHJXVnJKR0p0SmVGUWhWQ3FOQmlsUnF1czZaaFlKT0Ev?=
 =?utf-8?B?VDFWSWpCdFFGMG5yNkIwem43dzEvTmpSMG8wZzRSYi90U1kwRlA2SXVyODJq?=
 =?utf-8?B?T2VUbTJTc1Y2aGEzR0cwSEFvTTVrS0JXMUMyYmlJZlJsSjhVQTd3Z1B6Rk83?=
 =?utf-8?B?dit6K3ovM2NFSGprT2lQeG5LVytFSGVYQ1l1WVVqUkdKMlRwYXQ2WU9FSzJp?=
 =?utf-8?B?cVFpVEhROEtwdmhIQk0za1VjNkE3UTdkOGtUdFdXZzFEZS9nVEM3Y1F3UW9P?=
 =?utf-8?B?SGFycjZ1cyszMVBrWEd4NmxkRFF3RWhWTUY1SFdHcllkNVRUcThFRGpJb1Vk?=
 =?utf-8?B?SW1KQ2ZGU2ZMTEN4S3huWC9XUlhZQkpydFd4UGRYNlpvU1lPMzBEL0VwaVdt?=
 =?utf-8?B?dkxrOTFkVXJ1VVJ0eTh0ejdHcEhuQmR5ZFU3ZWtaZGpKTHoybjlBS2RoSldi?=
 =?utf-8?B?bFBXL2ZXUlJtZDJ2T3gyOHd3WFJMR3dPWmFndGxyMFhISWMzSWFXQnNyeGJ2?=
 =?utf-8?B?dW5uRjhuNmMwdkxXWVdMM3JkNnFiQ0RpUVk3SEEzRHhNMGRWSmtsRjBNcDJW?=
 =?utf-8?B?dnVQUmZFWDBFWnMzMTM1ZkVHVlhJVmNJZndyT2o1anJxclRoZXBkdmJ0NWty?=
 =?utf-8?B?U01LT2xiU1NkWERoMjVDemw4LzEyNnJTMWVNbW84SEhCek0zTW02MGxINjQv?=
 =?utf-8?B?U2V3K1hFMDcvWXhqZWFxbEVtYW1oa0xIdXp2RGUrTVRiSlczTGdydmlBRElr?=
 =?utf-8?B?ajh6Y0ZZMzRWUnVDeUQ1QnVMWThhTldaTXNaK3lNbnJMZFVyUGtuUU1jTCt2?=
 =?utf-8?B?dzBnREtHSVdiQXgvTnhhdm9XQzcvMmtJV3dvM1dYenlXL2xudGJwLzgwSUJX?=
 =?utf-8?B?OFVheWpQLzZCNHNQS0lrZEpWcmtHdFE3ZnFMdFc5RHlqY0NZbU4wZCtTNk13?=
 =?utf-8?B?UnZibzJ0bzR1WmQ5T3k1ZzV6V1A0RDg1WnJXdVBadThmeTgwTUJqWFN0WXps?=
 =?utf-8?B?VmJuRjFFQ2o5UGxCN1JlZjdGU2tiU0Q0cS9WN1RnMFZyaDg0V0xjeENsQ1ht?=
 =?utf-8?B?NjBBa0cvd1RZRG9uRTQ2b3ZxYUVVWENKL1V2c2pYM1ZRUzN3SER3UFNscEoz?=
 =?utf-8?B?S09KQmtYTHFKOFNvdm5UcVpjNzBzN01sZTFKYS9ZNFYyazlrSWM5cTB6RVpF?=
 =?utf-8?B?clNBY05vOGY5NzM0akN5MnJFOSt1TU5BU1VwMFR1MG5Wa3gyL1JNd2xZSUJJ?=
 =?utf-8?B?R3BkNldkY0sxTW9IR0Y0WkNXdmJrMkxJV2d4NVk1SU9KVG5YY2I4STY2c0lW?=
 =?utf-8?B?ejUwZFJqMUQ4OVFvMnNDME9qY1RxZm9nVnNBUGN6dHBFMGNqV1ZRUmVZQnRH?=
 =?utf-8?Q?4bK8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd6f03d-c468-4945-e8d3-08dbc5da5cf2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:36:25.7435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +i5GmkpcWk/+hDqdIHU4dKhu1/45aPK8VGwlP0ceZVi8F3mNpEj3JS7hmhPY+OKI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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
    <div class="moz-cite-prefix">On 2023-10-02 15:27, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3c56e437-b901-4d93-a3bb-1b788d1aba18@amd.com">
      
      <div class="moz-cite-prefix">On 2023-09-29 10:11, Philip Yang
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20230929141115.10016-2-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap="">Align unmap range start and last address to granularity boundary.
Skip unmap if range is already unmapped from GPUs.</pre>
      </blockquote>
      <p>This only handles unmap due to MMU notifiers with XNACK on.
        What about svm_range_unmap_from_cpu?<br>
      </p>
    </blockquote>
    unmap_from_cpu is going to remove the range, we cannot align range
    based on granularity, still split the prange and unmap from GPU the
    exact range .<br>
    <blockquote type="cite" cite="mid:3c56e437-b901-4d93-a3bb-1b788d1aba18@amd.com">
      <p> </p>
      <p>Regards,<br>
        &nbsp; Felix</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20230929141115.10016-2-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap="">This also solve the rocgdb CWSR migration related issue.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35 ++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 626e0dd4ec79..ac65bf25c685 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2004,6 +2004,26 @@ static void svm_range_restore_work(struct work_struct *work)
 	mmput(mm);
 }
 
+static unsigned long
+svm_range_align_start(struct svm_range *prange, unsigned long start)
+{
+	unsigned long start_align;
+
+	start_align = ALIGN_DOWN(start, 1UL &lt;&lt; prange-&gt;granularity);
+	start_align = max_t(unsigned long, start_align, prange-&gt;start);
+	return start_align;
+}
+
+static unsigned long
+svm_range_align_last(struct svm_range *prange, unsigned long last)
+{
+	unsigned long last_align;
+
+	last_align = ALIGN(last, 1UL &lt;&lt; prange-&gt;granularity) - 1;</pre>
      </blockquote>
      <p>I think this should be</p>
      <pre>	last_align = ALIGN(last + 1, 1UL &lt;&lt; prange-&gt;granularity) - 1;
</pre>
      <p>Otherwise you're off by one granule when (last &amp; (1UL
        &lt;&lt; prange-&gt;granularity)) == 0.<br>
      </p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20230929141115.10016-2-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap="">+	last_align = min_t(unsigned long, last_align, prange-&gt;last);
+	return last_align;
+}
+
 /**
  * svm_range_evict - evict svm range
  * @prange: svm range structure
@@ -2078,6 +2098,12 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 		unsigned long s, l;
 		uint32_t trigger;
 
+		if (!svm_range_partial_mapped(prange, start, last)) {
+			pr_debug(&quot;svms 0x%p [0x%lx 0x%lx] unmapped already\n&quot;,
+				prange-&gt;svms, start, last);
+			return 0;
+		}
+
 		if (event == MMU_NOTIFY_MIGRATE)
 			trigger = KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE;
 		else
@@ -2085,16 +2111,17 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 
 		pr_debug(&quot;invalidate unmap svms 0x%p [0x%lx 0x%lx] from GPUs\n&quot;,
 			 prange-&gt;svms, start, last);
+
 		list_for_each_entry(pchild, &amp;prange-&gt;child_list, child_list) {
 			mutex_lock_nested(&amp;pchild-&gt;lock, 1);
-			s = max(start, pchild-&gt;start);
-			l = min(last, pchild-&gt;last);
+			s = svm_range_align_start(pchild, start);
+			l = svm_range_align_last(pchild, last);
 			if (l &gt;= s)
 				svm_range_unmap_from_gpus(pchild, s, l, trigger);
 			mutex_unlock(&amp;pchild-&gt;lock);
 		}
-		s = max(start, prange-&gt;start);
-		l = min(last, prange-&gt;last);
+		s = svm_range_align_start(prange, start);
+		l = svm_range_align_last(prange, last);
 		if (l &gt;= s)
 			svm_range_unmap_from_gpus(prange, s, l, trigger);
 	}
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
