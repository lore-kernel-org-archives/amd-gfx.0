Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BF1C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 21:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B47160F01
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 21:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B47160F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2556E89F6D;
	Tue,  3 Aug 2021 21:03:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF2F89F6D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 21:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqtxzkD6ffz2yzuz+80ELgQJzPiR9mg0yl5/rAnc+iZh3IbygH47OZjp352Rdxp4e8RVUxpAMx6FX/E5I7bKnGQUfl1v9X572z1xUM+7SYfsXz8i7PuQfK3KSY+C8gR9Z0Nn5h5FzuxmjVF1MqxF+AFEj491kN9jVt/KLcvPeZ1k+z9E1vi094MyuieC8k3JYaxbcUBTiccV4BfV/mNjQqbj48w9TvMxtKK9mr5tMZAVzbhV26417+mZd+GSRsRMOFmyyLfP4gruSHXm169TmDvl7l6rDgDZtSxfVJXxcQjU2qNneg+XUI/ZKVPC5uVyF03YlWgejm8bjbhpaYmFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9YnVh88xjmj3yGTngm32niyHy3Gh6y+2jHWD//o/PA=;
 b=EJ9jgWFjlSyVgrCl1qvBY2lOwE2/ms/j2KvmMh94b8QJ1cm4HV/gugSEayEI4W++6GUyGUrzpfGsCIC+xYpyPXQhn2aaCdYvGKI7XPuyi4YMcqsIYWyEd/5NFPALkKZDI7SuIWmi9jGxblCYOsxzoqKaBr7ALvsLDckfIggQvZS7g1gIDEbd+CpSE4gr6GvfhAAAOcjSjPbhQGV6RDU8nH2yS2Eeun83npvv+RFaiqF6JrkkiDlv7zbjceTivOQzLxjO76aeFj44i4gCMW81+KlC3lVz1bTUlGcr9zo6hoB6IsD15sLCgNJPkslqWiZl2u8d6sq/41dbpve+Tnn/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9YnVh88xjmj3yGTngm32niyHy3Gh6y+2jHWD//o/PA=;
 b=sWxKnR8VxkgeREJB0jPn5xmMAXEr6hTvPSaDpuidG7H51TrB748tN/gS4TYqj9R8wJwQesdxqNd1QSST6tavx7zVwBR2UILJ4YX/JLw4O/4IetK5R1pIQPtX0yR3NJ4vYuZOQwH4R0j02IKI7JlAaczVzNFmp+urXA55vVAMP9k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5280.namprd12.prod.outlook.com (2603:10b6:5:39d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 21:03:43 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427%9]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 21:03:43 +0000
Subject: Re: [PATCH] drm/amdkfd: support file backed SVM range
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20210802145606.11888-1-Philip.Yang@amd.com>
 <9200e997-50c3-bae3-45d6-902e3d47dd4a@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <9da091cf-909e-2bd4-d16d-13e6e029b39f@amd.com>
Date: Tue, 3 Aug 2021 17:03:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <9200e997-50c3-bae3-45d6-902e3d47dd4a@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42)
 To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.19 via Frontend Transport; Tue, 3 Aug 2021 21:03:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18911b2e-283a-4183-e9dc-08d956c22d31
X-MS-TrafficTypeDiagnostic: DM4PR12MB5280:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5280C85E688D6F953466D8F0E6F09@DM4PR12MB5280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LFJzp7SMV0El5Sc5REDVxUq53ZYbBdq4F1hA6cNxrz21Yo5upU9sMBsFRhpJKWCV9+7j70qxo6VKJesF9cMutnsJ3hnu+4KqLKs7lk8N388RLgvX0if4tFUJ2dSCXsC4Bbgf+hCqFbnyRfYAUQh2jN3Ol5PmwZC8bHmjKo2eBESznNs2N+gCkS6T2Vq7h5NMDhk/VOIC8p0++A0nKHbUUaUFs9wmBn0ylD29S0Fj5ptckvdvLCbf8VxRqJSnSDZGDJFh/9pb+2bEK9Lejqyu21GYTbdYm/HZ9pkwepYPWsb4IrYiooOQ5CXpo9CqhMgAxPOXx7mZF0mJ/TSeyKGl+NPKq4hVA8eDOytwhyKoMM4HNZGgiNrClxK77KUa6Ue7iDl0oYOoCCRikUT1gP8GCxUwxBpGL9iHARwOykHjGetdlZxIsQJ1auxC64+eTzQUSObPOiTVcEjjybfwjRV2X7/BQBvKN5Pd8Y7clc4cxV1bncZRgH6FHlRGNR9ylFoqqZ/abrVywcSPoZZFD09Un62ZszxTxgIjmeqbmDaR1esUWU1ciFPMV6WFQCCQ6J1Bjc/ccIe78w3WyfCFkuGT1Y6UtZmEmEHb9LHU6Q3psWNSaqpSJmw3I33BZDONLxqO5iftUW4q5FHN4CJBuxgRzPzGb5fs+Y1J7PExfJDRKcOxrA/uvAL5IJVkFkMxTngswLDlL4yAXTbJ7xkX8UfxE+3QYUvMiW8hieVNf9GuEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(8936002)(478600001)(8676002)(26005)(5660300002)(66476007)(66556008)(6636002)(186003)(2616005)(36756003)(66946007)(2906002)(38100700002)(16576012)(316002)(53546011)(110136005)(31686004)(956004)(83380400001)(31696002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFpRamRoeXlkd2pidFdGZW9tT1M2Y0JqeE1ma1djRzdUZzNWclRORWdXd05I?=
 =?utf-8?B?eE91MUZFaXdoQjVBSW80dTFuVG1ZNEtJOEY4YmZSUWRHNk9qYzlTa3R3N1RM?=
 =?utf-8?B?ZTcrYkJEZW01MEFUZFprbHJ0RGplby83WVpKcTJFMnRTQmxnK1F4NHBlM05I?=
 =?utf-8?B?YWtoaDNvdEZreTRucmlFV2N0RTIwWWRlWG04Y005eU8vMkJvWUdrdkdqQkpP?=
 =?utf-8?B?WGdKS0x6cTBSN0F3eTRQSitsczJMbGFnNzNPMDFlamR2UTkzWVZELzVDOHp0?=
 =?utf-8?B?RXNpODZQQUZkbHp2UFhpemJoUHRUZlVvRmpqSkJESnFBUUlnQVpQMXdOUFlD?=
 =?utf-8?B?UU9Oalh4NGw5bnhkVHFuV00xNmpEVXVyRUNzQ3MvdUowUkVYM0VlaXkvQi9Q?=
 =?utf-8?B?ZWdEVzlaZ3UwQiswSVFnS2pmM2NSTE5jZXdUcmhnNTQxMWxmNlJ1VmZ0d21l?=
 =?utf-8?B?d1ZSWURJMWZwNTZyVjlQdXRuS1UrYmFJbGgxQkR3Q3JZZUUyQU5EZzJ6TDdI?=
 =?utf-8?B?SmpYZEdHeUlvUXp1MHVlREM0NTFRcXVzcVYyUHl2ZkFrVWx3V0pSeGJKV0Ns?=
 =?utf-8?B?K09TWE9NclVHWEs0bU5yU3c1RWlrVms5MTJnQWhFcFpyK1VLTmdHbGltOEph?=
 =?utf-8?B?QjRqc1lFa3AzNG1BZmh2dENEaVNWbGswOXlKdzQ4d1c4N3EzN1c3RzBXS0lB?=
 =?utf-8?B?ZFZRcUplS2ZyYjhzSGdCckRuQXBsbzhVTGxZMWtYQWE4aTZFMGNTVG5GbGwz?=
 =?utf-8?B?VkppaTFRZWx2R3BXcXMvN1FIQmZaSmt5ME9oODhJK2RGMFkvM1FodjRvNGRq?=
 =?utf-8?B?RnR5bjFUWXlhQTYyTHphajBlUHJkZGFrKyt0YVFBSXZJQy9hSXIzeko5SW43?=
 =?utf-8?B?ZEhiMllpc2dEZkVTbmhXTDJoQXJpRGs5bmtodHNidGVpL05IRS96bW1HczEw?=
 =?utf-8?B?VGhtY0k0cFJEWjhrTWdXYS9QdWg5NG4vbkRtelQvWDJoUXpFajA4MVVHeVRK?=
 =?utf-8?B?NnRjN0pLVEpEcS9BVlV2MDhpQ0J6bGlBYVRzUDFjS1cxeDdDMGl2eHhKZFUw?=
 =?utf-8?B?bUV2eFhTaUZkdEdWSTkrTHowTHA1SW44RGlrNGVZSDFBaXdEd0xZSFBIMHNs?=
 =?utf-8?B?V0FrV25rQWhKWUV2TmJpQTlzaDFsM1UveDRPWjd3VGlQS1AxU3MzYjZhaTZW?=
 =?utf-8?B?cmFmVldId1ZXT09ERndaekRqeWs5emQzY2cvTnFlK0dZcDNQNTFzS0hoSTVP?=
 =?utf-8?B?Z1pGa1FQTExKb1U3MzVMdW1CdnY2ZXNYdHdiQVByVVZ2Q0VsdUdBWjdrSnpB?=
 =?utf-8?B?UDdMOGRBOHRNVGxJY3IwN2RUSFY0OEZqL3A5U0RUZThlOTFjbFNMekRPUWRW?=
 =?utf-8?B?KzdpZDloeXRqVDVuekszQkFtMU11R0ZTVjdZQnVmWjR4UjI3UG05cjltbFR5?=
 =?utf-8?B?ZGV0M2RDbE9RWm92V1lXMjJ4WFkvekx5U2tRVTRHNktBQlJHaVF6UmhVMFFk?=
 =?utf-8?B?Y0tMczdWWmhmS3NFTytYQXFROEJHTmFRZVFaWkl4R2tVN2Q5SXA0cERmWW9z?=
 =?utf-8?B?aVVvam5ldlZSMDlWSmtJamVPVldKRFZ0TzBxdVpaeHl1MHQ4NnF3aisxQmZo?=
 =?utf-8?B?Ymx3YkhjZkQrVW1QdEVta3J2dzZFZXV0S1U1M0ZHbFFXRVlWdjZwcGpBV0lH?=
 =?utf-8?B?bDlwVll0aXY2UitrcDdkaTBjR1NJeVNCVXlUdFoxM0VWM2pVTnZKSFg3RU52?=
 =?utf-8?Q?jKVStkauUL1s/YNwn9w6iyK5Z4CqPc3VJXehUQL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18911b2e-283a-4183-e9dc-08d956c22d31
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 21:03:43.2690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 271fD0AfvBQg69nbcHqUZPCd3ccZzyNut2u2JBJUkaBvkJbyKLphkrgsphgKJCjZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5280
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
    <div class="moz-cite-prefix">On 2021-08-03 1:01 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9200e997-50c3-bae3-45d6-902e3d47dd4a@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-08-02 um 10:56 a.m. schrieb Philip Yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">HMM migrate helper migrate_vma_pages do not migrate file backed pages to
replace it with device pages because the pages are used by file cache.
We can not migrate the file backed range to VRAM, otherwise CPU access
range will not trigger page fault to migrate updated data from VRAM back
to system memory.

For file backed range, don't prefetch migrate range to VRAM, always map
system pages to GPU and also use system pages to recover GPU retry
fault.

Add helper to check if range is file backed or anonymous mapping.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This patch should not be submitted to amd-staging-drm-next. As I
understand it, the real fix is in Alex's partial-migration patch series.
This patch is a hack that could be useful for older release branches
that won't get Alex's patch series because it's too invasive. So let's
review this on the internal mailing list.</pre>
    </blockquote>
    <p>As partial-migration patch series are checked into dkms branch,
      and file backed range works fine, so this patch is not needed, I
      will abandon it.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:9200e997-50c3-bae3-45d6-902e3d47dd4a@amd.com">
      <pre class="moz-quote-pre" wrap="">

Thanks,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f811a3a24cd2..69237d2ab2ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2400,6 +2400,36 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
 		WRITE_ONCE(pdd-&gt;faults, pdd-&gt;faults + 1);
 }
 
+/**
+ * svm_range_is_file_backed - decide if prange is file backed mmap
+ * @mm: the mm structure
+ * @prange: svm range structure
+ *
+ * Context: caller must hold mmap_read_lock
+ *
+ * Return:
+ * false if entire range is anonymous mapping
+ * true if entire or partial range is file backed, or invalid mapping address
+ */
+static bool
+svm_range_is_file_backed(struct mm_struct *mm, struct svm_range *prange)
+{
+	struct vm_area_struct *vma;
+	unsigned long start, end;
+
+	start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
+	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
+
+	do {
+		vma = find_vma(mm, start);
+		if (!vma || !vma_is_anonymous(vma))
+			return true;
+		start = min(end, vma-&gt;vm_end);
+	} while (start &lt; end);
+
+	return false;
+}
+
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint64_t addr)
@@ -2496,6 +2526,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		 svms, prange-&gt;start, prange-&gt;last, best_loc,
 		 prange-&gt;actual_loc);
 
+	/* for file backed range, use system memory pages for GPU mapping */
+	if (svm_range_is_file_backed(mm, prange))
+		goto out_validate_and_map;
+
 	if (prange-&gt;actual_loc != best_loc) {
 		if (best_loc) {
 			r = svm_migrate_to_vram(prange, best_loc, mm);
@@ -2520,6 +2554,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
+out_validate_and_map:
 	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
 	if (r)
 		pr_debug(&quot;failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n&quot;,
@@ -2850,6 +2885,11 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 	int r = 0;
 
 	*migrated = false;
+
+	/* Don't migrate file backed range to VRAM */
+	if (svm_range_is_file_backed(mm, prange))
+		return 0;
+
 	best_loc = svm_range_best_prefetch_location(prange);
 
 	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
