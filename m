Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56F0C4320A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 15:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3AD610A3
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 15:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B3AD610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 125546EAAB;
	Fri, 20 Aug 2021 15:44:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A05736EAAB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 15:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAc+Lrj4gxzxjlB1VB65mEZeJEJloto34LVPRgxd8+6CR1PZBJcgs65TdBftcw7DnyIIM2UtQEzie+xpDCv4W/ki78kL4N8rS+y5oIpS+TNpugrtC5nU+2ogkAPlVn+NoBc3oWU8XDBX7aMWlO9GEtb2H2UmATUxBwoLMwMj3orQqntIU+TlfTpy08OqJVtJ10Efd5T1zxh2kAWpzXzKhaHDwReyZqkDPC5yU8HEOBl/v4hWi9DW9IA6R5mEZGgJBtyYxWkJDEgKEQRqOB1A1SKNZQkltBNN0xwrwMBeqlnEshm+Bvrp6GBFEp1r0L+v88yhcGne3896Mpp7f47nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZfUtaRBwnG3UGIMOcyO/q54cIiv1HN+VSzU5VFq7r8=;
 b=hsCMobE0SOY6QE8VcBlfdJRawbAL1hL3u1J48CBZUdBeC+2O3zuo9aKHZvULLMfjn0opI8UQorYk09WkJG2zDLMHoJGV8HfMz8NpH25bbIE1OMxrshdC+nwTxZJuUihLhyjq3dVDutF5SAsE+JEl3ieA/PsG3z8Iv7NNA6dAxFnWhhhsmkHQ57mAAycQ1IFzSmhhXtP0kSQdK4sEzU3a4+jkQPDaKKnN9iZ1Jz0wmcQqXw8PebKm+nIUB5UJg1ef0x2E2Ms+b7+1ofOtHT8VlbngXELrYn9nzb/pJIfgZMBpl1NsBXqBWxdHQXE7NjyQ8zWIoNkmOyNBvDl1ksZbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZfUtaRBwnG3UGIMOcyO/q54cIiv1HN+VSzU5VFq7r8=;
 b=rSWz4eHpVULHLr7F+q7Bg9kTKW/80kaSb90GLpDbST4QaosVlkkhF9woto+HteYYweQpgvZZn5BRokpr4QE/vne4K3/+0M+uBIz8A2VqQQJ4CaWC8Xcrreq75GMEJTepxq70JNcNIvD+aLUXZExPageEskaKZpVdulgY9wTQego=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:44:55 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427%9]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 15:44:55 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: map SVM range with correct access
 permission
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20210819145658.2254-1-Philip.Yang@amd.com>
 <20210819145658.2254-2-Philip.Yang@amd.com>
 <3fa1a300-8ea8-3b7d-9ca8-82c70ec8fac4@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <d412332a-43dd-367e-03bb-c92d98b3c1c6@amd.com>
Date: Fri, 20 Aug 2021 11:44:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <3fa1a300-8ea8-3b7d-9ca8-82c70ec8fac4@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0089.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:44:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a7b0176-aa54-44b2-f6a8-08d963f17529
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5039DC261A0790590F79F2BFE6C19@DM4PR12MB5039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euL+6TS0RWlqrVReyEsEr8lGawHRFJTug2JHBPtOucodkZdyDaguGiCId7EUb+0gXe0LfpV3nU9G96v/YRDHQQQlILl6zSG2vLFEAtHLt7GMGHdsKeT4V7Jm6Twy8T/rydPVBEh7Cd36QHtuVGed2k+d+z9Tf8G+BOjFGCcdr3RrG7I+Flnnx8JWYB/qEoUkYI9Vq8l0Iq4QTrCyyh24aygv1QpkWuZ+8jzMrrF855rMq9c9SrOkWUt2HU/VMojvD9FfbZF1+sICzf9w3OIHNYY+EhumwK9J+aBvWNHfnFYigMIJ9mpc0369terFIG1Ct0/VaHkcK2laCBDKRgHy/a6kcFjvXa2m5vTj2gEasmjvOdPSSMRBi3Wl42l+gj7uDILDlrT5UdPtspa4K1glShZ89ML0eSykZVmk/2Nmb0bphp2t4UWetgGq6jFZzmvxsGFbPi3QgWjlREip0PhsVfLEaN+tVJrbBa7vCFzycS4YW4LMNs/M/11y2YcIGATPDJV3yTQ2nLD1yzBPhhvwoLK93hf4hrwRq/9SJFN4Gr3m8AXTjn9bCOzXND6BCilxRPDM4ntKejgSiTXl0btAxuKfGD7aDJmrAJw7dKdYtde25nbg0U2IQNlFTIS8C+rf4xEXzwHZVxXZ29hVhtuPXr6vGaJs9nXj5wBhpNLrYjcyuiuME00QOA4NMAXOQrssce245Twvsd3O3sE16BEaEhXsTH/uCjSEL/isIMyVTKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(8936002)(16576012)(2906002)(2616005)(956004)(6486002)(186003)(83380400001)(36756003)(478600001)(31686004)(6636002)(38100700002)(316002)(26005)(5660300002)(66946007)(66476007)(53546011)(31696002)(66556008)(8676002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjRHV0dHS21HWWhUT2E1b0lJdi91UkdoUUdUcVFjQ1FlT3V0VlJhQWx5aTc4?=
 =?utf-8?B?bzhPQWkxTHpPSkJZSURPdjdQZS9ITExyaHJ5T0pUWllYYno0V00rMTJzSkgr?=
 =?utf-8?B?OEkyem4ySnhUaCtsUXY0UEw2Mks2N2dVaW1qckk5ZGswMk9Ld1hWdlo4S1l6?=
 =?utf-8?B?QVdZMkNkenkyVjNaNUFCL2ZyZkc3RFhyN3pQS2lVSDI4aW9MZkRwWis3eGFZ?=
 =?utf-8?B?OElJQ3M2MEhTTmNJTDJmM1Y2ZjNQaFN6QXFJUFdmejh1YVlFcWdGMENzV3lH?=
 =?utf-8?B?M2tTL0ZUaVVnWlRyMkgreFg1c1RsVkhsL2tia1FOQUJRbWR2YU9DaHROVE5l?=
 =?utf-8?B?SHJjVjRFcjlxb01FdU1oRU9haGVndzhxUGpsd2pZN0RFZkZaUEZyci84TUxw?=
 =?utf-8?B?T1NBWG1LSzdRYkYvTHZSTWVYbVQ1ZVhPTWc3eVhSZHZXWkYxN1ZlSER1KzVE?=
 =?utf-8?B?ZG8wdGJhYUJaV1ZRa29qa3g3UUhraUkvZTEvWitoTlJINnkvWHJTVDQ0UVha?=
 =?utf-8?B?dU9UWGxCN2g3cGIvWVR4NzZ5dmcrcjVmVTRWOHE5dmlzYnNUKzZuMFRrL3dh?=
 =?utf-8?B?QXhoaG40cWxpZEU1ZEQ1U1BOd0pDQlZhVFRpYXArSW1FTmFOUFIxWnJlSDQr?=
 =?utf-8?B?L2dkOGVwZkRWa0dWL2xqVktIRG9TMTNTVUI5eTZrbUcvc3VhdmtRYkpuQ3di?=
 =?utf-8?B?Rk1ibmlqTElRNko3RkRSUkcwcktjNm1VVVNIMUt1Yk5nVmVhWDF4ekZqTlFr?=
 =?utf-8?B?TU83MjZxb3U5eml1bHBrZW9rK2tBemJJdU5QUm81VnRLWmRZQVowaVNCYmJL?=
 =?utf-8?B?WndmdG1NL2c3MHNSSERSYTZ0VVA1ZTNINE9LTm1hZXF3U0gvNUtmMEQvakR2?=
 =?utf-8?B?RGlQRk0zZ09NeWcyUHhkcWJRN1ExZi9GV0F5Skhrc28rKzB3WUZ6K1Zscjc0?=
 =?utf-8?B?bEdkeldOVmRKRldKaE9xSTBpU1ZzeGlwTS9wdXJoaFhCdUZwWGsxRVYzblRU?=
 =?utf-8?B?NlNsa1NtMXE5L2RpbVNGRmp2bDNDYmNaSzFKYTdhaCtjS2xidjhPbVlHMm1m?=
 =?utf-8?B?emNFaFFpOVN1R1V4VjJHRGtlZ1JXYnEwTVZPeEx6YTg0cTdkNWNyUzgrR05C?=
 =?utf-8?B?aklhb1VhbGVETGhpSkM3ank5bVJ5WGlKWlNQSUtiTzB3cW14aW42LzdIN1Z4?=
 =?utf-8?B?NmpBN3grd0lKTDBDRzJSVTRzdmRCZ1VGc3krWkhqZGJaWUVXdFVrNXVkeWhh?=
 =?utf-8?B?V0NtT3pvODBQRnpMekpLNkR3dWt3eTFvK2J4V3dGTHdQZjMvQmFneEh6eDUy?=
 =?utf-8?B?a2Q0QTJkQzFIZ3h0SXQxVVMxejl0bUl5K1dKQnJzVFFPSnlpR1JYQjF3LzJ6?=
 =?utf-8?B?dWtqQmhsa3JTMzNLNTlVU0lIQ1FJVzNYRHdvN3V4NUhWaEVFNWZ6UGJoUXBp?=
 =?utf-8?B?NU1pK3o5dkRBeEVZV2JQd09NSUpLeDFpN1VHS2xCWXhxam4wdExTN093Mk1x?=
 =?utf-8?B?aFJ2QVBDQTNjeko2Z1hwVzUrUjhxVVhmM2U2aElrNmxER3ZseDlCaTJxM0tR?=
 =?utf-8?B?dDR4MlZiREc2ejBKZ0RvSkZSTll3Z2loVnJpcEJXRFBwbkFFek0xWHdlZTJM?=
 =?utf-8?B?SjdETzhIYy8ybzMwNzRZUzZlS1dSN3NRajZBMVc3QkV1WUtoRi83MlE5NFR6?=
 =?utf-8?B?ZHNHVm13RTFRTUkreTJDVnV1RXphd0hVWlRMMnFPOTl2T3ZpYWtOMWJJbkRt?=
 =?utf-8?Q?boTRySU9wZ1r3NYJ9VyOvabgnua0W+ZQVWjwlZ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7b0176-aa54-44b2-f6a8-08d963f17529
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:44:55.5579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPbHU78xAenDSKqyJhX9qvABZ9sO/j5SPmN5qOv4SwofPDfXqig5PyEJepD0ofaR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
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
    <div class="moz-cite-prefix">On 2021-08-19 5:32 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3fa1a300-8ea8-3b7d-9ca8-82c70ec8fac4@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-08-19 um 10:56 a.m. schrieb Philip Yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Restore retry fault or prefetch range, or restore svm range after
eviction to map range to GPU with correct read or write access
permission.

Range may includes multiple VMAs, update GPU page table with offset of
prange, number of pages for each VMA according VMA access permission.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Minor nitpicks, and one question. See inline. It looks good otherwise.


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 131 +++++++++++++++++----------
 1 file changed, 84 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cf1009bb532a..94612581963f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -120,6 +120,7 @@ static void svm_range_remove_notifier(struct svm_range *prange)
 
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
+		      unsigned long offset, unsigned long npages,
 		      unsigned long *hmm_pfns, uint32_t gpuidx)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
@@ -136,7 +137,8 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		prange-&gt;dma_addr[gpuidx] = addr;
 	}
 
-	for (i = 0; i &lt; prange-&gt;npages; i++) {
+	addr += offset;
+	for (i = 0; i &lt; npages; i++) {
 		if (WARN_ONCE(addr[i] &amp;&amp; !dma_mapping_error(dev, addr[i]),
 			      &quot;leaking dma mapping\n&quot;))
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
@@ -167,6 +169,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 
 static int
 svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
+		  unsigned long offset, unsigned long npages,
 		  unsigned long *hmm_pfns)
 {
 	struct kfd_process *p;
@@ -187,7 +190,8 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 		adev = (struct amdgpu_device *)pdd-&gt;dev-&gt;kgd;
 
-		r = svm_range_dma_map_dev(adev, prange, hmm_pfns, gpuidx);
+		r = svm_range_dma_map_dev(adev, prange, offset, npages,
+					  hmm_pfns, gpuidx);
 		if (r)
 			break;
 	}
@@ -1088,11 +1092,6 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
 	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
 
 	pte_flags |= amdgpu_gem_va_map_flags(adev, mapping_flags);
-
-	pr_debug(&quot;svms 0x%p [0x%lx 0x%lx] vram %d PTE 0x%llx mapping 0x%x\n&quot;,
-		 prange-&gt;svms, prange-&gt;start, prange-&gt;last,
-		 (domain == SVM_RANGE_VRAM_DOMAIN) ? 1:0, pte_flags, mapping_flags);
-
 	return pte_flags;
 }
 
@@ -1156,7 +1155,8 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 
 static int
 svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		     struct svm_range *prange, dma_addr_t *dma_addr,
+		     struct svm_range *prange, unsigned long offset,
+		     unsigned long npages, bool readonly, dma_addr_t *dma_addr,
 		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
 {
 	struct amdgpu_bo_va bo_va;
@@ -1167,14 +1167,15 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r = 0;
 	int64_t i;
 
-	pr_debug(&quot;svms 0x%p [0x%lx 0x%lx]\n&quot;, prange-&gt;svms, prange-&gt;start,
-		 prange-&gt;last);
+	last_start = prange-&gt;start + offset;
+
+	pr_debug(&quot;svms 0x%p [0x%lx 0x%lx] readonly %d\n&quot;, prange-&gt;svms,
+		 last_start, last_start + npages - 1, readonly);
 
 	if (prange-&gt;svm_bo &amp;&amp; prange-&gt;ttm_res)
 		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
 
-	last_start = prange-&gt;start;
-	for (i = 0; i &lt; prange-&gt;npages; i++) {
+	for (i = offset; i &lt; offset + npages; i++) {
 		last_domain = dma_addr[i] &amp; SVM_RANGE_VRAM_DOMAIN;
 		dma_addr[i] &amp;= ~SVM_RANGE_VRAM_DOMAIN;
 		if ((prange-&gt;start + i) &lt; prange-&gt;last &amp;&amp;
@@ -1183,13 +1184,21 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 		pr_debug(&quot;Mapping range [0x%lx 0x%llx] on domain: %s\n&quot;,
 			 last_start, prange-&gt;start + i, last_domain ? &quot;GPU&quot; : &quot;CPU&quot;);
+
 		pte_flags = svm_range_get_pte_flags(adev, prange, last_domain);
-		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
-						last_start,
+		if (readonly)
+			pte_flags &amp;= ~AMDGPU_PTE_WRITEABLE;
+
+		pr_debug(&quot;svms 0x%p map [0x%lx 0x%llx] vram %d PTE 0x%llx\n&quot;,
+			 prange-&gt;svms, last_start, prange-&gt;start + i,
+			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
+			 pte_flags);
+
+		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false,
+						NULL, last_start,
 						prange-&gt;start + i, pte_flags,
 						last_start - prange-&gt;start,
-						NULL,
-						dma_addr,
+						NULL, dma_addr,
 						&amp;vm-&gt;last_update,
 						&amp;table_freed);
 		if (r) {
@@ -1220,8 +1229,10 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
-static int svm_range_map_to_gpus(struct svm_range *prange,
-				 unsigned long *bitmap, bool wait)
+static int
+svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
+		      unsigned long npages, bool readonly,
+		      unsigned long *bitmap, bool wait)
 {
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *bo_adev;
@@ -1257,7 +1268,8 @@ static int svm_range_map_to_gpus(struct svm_range *prange,
 		}
 
 		r = svm_range_map_to_gpu(adev, drm_priv_to_vm(pdd-&gt;drm_priv),
-					 prange, prange-&gt;dma_addr[gpuidx],
+					 prange, offset, npages, readonly,
+					 prange-&gt;dma_addr[gpuidx],
 					 bo_adev, wait ? &amp;fence : NULL);
 		if (r)
 			break;
@@ -1390,6 +1402,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				      int32_t gpuidx, bool intr, bool wait)
 {
 	struct svm_validate_context ctx;
+	unsigned long start, end, addr;
 	struct hmm_range *hmm_range;
 	struct kfd_process *p;
 	void *owner;
@@ -1448,40 +1461,64 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			break;
 		}
 	}
-	r = amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, mm, NULL,
-				       prange-&gt;start &lt;&lt; PAGE_SHIFT,
-				       prange-&gt;npages, &amp;hmm_range,
-				       false, true, owner);
-	if (r) {
-		pr_debug(&quot;failed %d to get svm range pages\n&quot;, r);
-		goto unreserve_out;
-	}
 
-	r = svm_range_dma_map(prange, ctx.bitmap,
-			      hmm_range-&gt;hmm_pfns);
-	if (r) {
-		pr_debug(&quot;failed %d to dma map range\n&quot;, r);
-		goto unreserve_out;
-	}
+	start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
+	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
+	for (addr = start; addr &lt; end &amp;&amp; !r; ) {
+		struct vm_area_struct *vma;
+		unsigned long next;
+		unsigned long offset;
+		unsigned long npages;
+		bool readonly;
 
-	prange-&gt;validated_once = true;
+		vma = find_vma(mm, addr);
+		if (!vma || addr &lt; vma-&gt;vm_start) {
+			r = -EINVAL;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think -EFAULT would be the appropriate error code here.</pre>
    </blockquote>
    Yes, this error code will pass to user space, -EFAULT means bad
    address, is appropriate error code here.<br>
    <blockquote type="cite" cite="mid:3fa1a300-8ea8-3b7d-9ca8-82c70ec8fac4@amd.com">
      <pre class="moz-quote-pre" wrap="">


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+			goto unreserve_out;
+		}
+		readonly = !(vma-&gt;vm_flags &amp; VM_WRITE);
 
-	svm_range_lock(prange);
-	if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
-		pr_debug(&quot;hmm update the range, need validate again\n&quot;);
-		r = -EAGAIN;
-		goto unlock_out;
-	}
-	if (!list_empty(&amp;prange-&gt;child_list)) {
-		pr_debug(&quot;range split by unmap in parallel, validate again\n&quot;);
-		r = -EAGAIN;
-		goto unlock_out;
-	}
+		next = min(vma-&gt;vm_end, end);
+		npages = (next - addr) / PAGE_SIZE;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Use &gt;&gt; PAGE_SHIFT for consistency.


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+		r = amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, mm, NULL,
+					       addr, npages, &amp;hmm_range,
+					       readonly, true, owner);
+		if (r) {
+			pr_debug(&quot;failed %d to get svm range pages\n&quot;, r);
+			goto unreserve_out;
+		}
 
-	r = svm_range_map_to_gpus(prange, ctx.bitmap, wait);
+		offset = (addr - start) / PAGE_SIZE;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">PAGE_SHIFT
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
    done.<br>
    <blockquote type="cite" cite="mid:3fa1a300-8ea8-3b7d-9ca8-82c70ec8fac4@amd.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+		r = svm_range_dma_map(prange, ctx.bitmap, offset, npages,
+				      hmm_range-&gt;hmm_pfns);
+		if (r) {
+			pr_debug(&quot;failed %d to dma map range\n&quot;, r);
+			goto unreserve_out;
+		}
+
+		svm_range_lock(prange);
+		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
+			pr_debug(&quot;hmm update the range, need validate again\n&quot;);
+			r = -EAGAIN;
+			goto unlock_out;
+		}
+		if (!list_empty(&amp;prange-&gt;child_list)) {
+			pr_debug(&quot;range split by unmap in parallel, validate again\n&quot;);
+			r = -EAGAIN;
+			goto unlock_out;
+		}
+
+		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+					  ctx.bitmap, wait);
 
 unlock_out:
-	svm_range_unlock(prange);
+		svm_range_unlock(prange);
+
+		addr = next;
+	}
+
+	prange-&gt;validated_once = true;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Should this be conditional on &quot;!r&quot;?</pre>
    </blockquote>
    <p>Add if (addr == end) condition, to ensure all pages of range are
      validated once.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:3fa1a300-8ea8-3b7d-9ca8-82c70ec8fac4@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
 unreserve_out:
 	svm_range_unreserve_bos(&amp;ctx);
 
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
