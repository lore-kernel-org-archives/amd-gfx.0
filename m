Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44589C4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Dec 2023 18:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9962610E033;
	Tue,  5 Dec 2023 18:48:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3501910E033
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Dec 2023 18:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZbMG6VkS3wPr5BBy0/LOPXxy+Gp22g+A8IntioAMe5NNBdeFxRJwup18O4sfsaTBVkRdtLB1l6MPa3NYQKI3OpJwT49nChIP974pqO0gfF6WASjvF2i3lM50nD7y9i0DIU5j38rrU8NvHR4vsk1G1JfSRG7lpw+4EJcIwXVrlVcPGiK7y6xCyCAdkZs2DD6sn+9oxIw+QETdoPSynuyA3v2Jc5PPKJB934/JfM8oExU71j9UxQ+iRTOfJdtTLs8F2IG3azPb3YIMNYXtsHvAz0QYztjkuZIsJiVUvn85vOO4EIXGwBZlhi9wMXNCOWyXhuBAhVhvNLWDv28X18Nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47ooQEfd1ECU75Yo1iKhhhR5voXkfSiDthz7gX7v9Ko=;
 b=QL65Um4PXjs57p8jobYUHy+4rrL3HMIV5NuIzPdJFcRtA3356i1hVCo0zSggoG+UjSouoZ114P5DzY2vfvkTjdPMPY1Cn0ZAjpS7MQLCxii9bH+zWT3ZEoqCINX4JUZcr+RpbCQfYQitAEW4n//uxsDaCOgeHux1+4Nn5bSMi29A+z2nizrfDhib05hNPEnrcGreEEOrA22bkFz9IbgyfdF1v5n77q1e4mBOTOPDqutYgUf+pqI1+lZV97PuZF2UjQ82twZCyHznGYI025+PjrBII45ZhFXc+PsRWCe2GIshLUqSq/4eL273cflAMUOxRQR7WNrP1HGYu2uWBwq1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47ooQEfd1ECU75Yo1iKhhhR5voXkfSiDthz7gX7v9Ko=;
 b=or8oxzAZicTNpSm9xqsxywBCFAaR/jhSqsaaZG9Iu71zVrjDftDKicPrkWxqnnG6tsO3ozUiRAM2wt/fIqd0CmBrSXWo+zZ4T8m7lNN8wrh0o6XrriQt4WHJkR1bHkigjDMwOrjr5uM/5t/mNfjNip3hBn9CrS1pDoVNj1BbY4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 18:48:30 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 18:48:30 +0000
Message-ID: <40849594-0ec2-b615-74df-597f5c5c667d@amd.com>
Date: Tue, 5 Dec 2023 13:48:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Use partial hmm page walk during buffer
 validation in SVM
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231204202310.23834-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20231204202310.23834-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTBP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: be45d2e9-0ba1-4b30-54a0-08dbf5c2c638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFe6zPrv+W2dRa3jTulxvK3kttsqOfTxtP4xuYJuRxBmG0cdazDIrTTK0nqP8kCc3iEBoBec5kLsGYkIzpTFexTF0kvFwPrtIID8eAUEGCqiyiGu6qM154fxq20Zb33DyvBx9tLVCKpC6vhYCneGC++SNjwqrWw9aJWQ0Mhwohq7+rzvCimKo9nL1eoSscWHUY4V2Zln4DsZtJkcUqUApftNK20xNON3fMciZSih8LlZCoLwp54ZySDwaCYNm3xZGwHRApRouPldD/1hbeu91acYeYPzeMMs68FYNsQZRsB2fuj0d/v1D0TvN+vDcHFi2ux/kwfLbfMS1t42nElhbV9SGhP6glUt5aspnfEx7poHnZhgQbaP0TscdAgBMhsky/ymvbb4U7K0wtK+/gOG/USqfe2Mdo1TLon6uepos2S3qKxCe77yqRbThtVBdlVZt7L6aRxPeNM44GqkE30wg6WFWok/mKnioVgi0mjptm9S0eudXxCTOAJSsz4+eXCPCmS4VTr0IYLHcZ9vu4sHZqUrUKtO/1CnHwuw8iYZ/Sv+BoBfC0E/PGO+yM72ErqWaLqsybKa/Cdc4L2emqR/afE6MVBPDFjIhWyuLG/D/cyiZbeEBfWQxvcWuaPhlTdMmNkiG7dWkiZT+zbbqmYLKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6486002)(83380400001)(478600001)(6512007)(2616005)(53546011)(6506007)(26005)(66476007)(316002)(66556008)(66946007)(41300700001)(36756003)(8936002)(4326008)(8676002)(31696002)(2906002)(5660300002)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpiRmduMEZ5cTd0cW5FalMyZTh4WkpTRStZRHpJWWxoNitnbmZoY2VqYW1K?=
 =?utf-8?B?bnZwOUpVdlc4YlZUbUhCaHNjMHhldjd5VFpidDZrVm1XZ0tKdFRFRTlZY3hR?=
 =?utf-8?B?aWtrNnF0WTJERG9EakNmOC9zZG1jOTFXNk82ZXI5Rm5aM1EvNFh4T2o1OWtr?=
 =?utf-8?B?YmtHUkkycElLN0Y5UGtNeVNCZGxpMUFOR2dkeExTY0w4bHBhbG1xQlBPS2hJ?=
 =?utf-8?B?a2M0alJpSlJTUkJrUG4zb0xYWk9velgvNS96MU41YzJlWm9EazdDdE1ScnlV?=
 =?utf-8?B?RUxDb0xTTjBZMkdQbnZqR0s5cDNyblpIcmlWQ0I2OVFFUzU3NGIyczU2M0Vk?=
 =?utf-8?B?RnVTYXV4VFdrZU5XV0hFU2RSdnNZbWpWeDcvNHdiVnExbmhKdWhkTm94a0VQ?=
 =?utf-8?B?aWVsQk1sUm11YjdqNmdvSmF1Z3ArMjhtUzBrR0tRckRKOG1tVEk1WjkxcGgz?=
 =?utf-8?B?cVdlWWN4clNUVnNpS2FyZis5Z3E0YVRWMmdqM2ZWcVFJTmpxdW1nTkxUTDZT?=
 =?utf-8?B?RHZHbEtFcDcwYTlnNmRudEgzblBibUZmMURKdXRYT2o3ZmZGc2NpWExBcTRr?=
 =?utf-8?B?RWRGc2JWdnJjYnpXNFRISE1FN3RkVVVEMnd6bHZiWlNDTE4zRldQUGhDMEk4?=
 =?utf-8?B?eFFjWEFHdWZnZnpTc3IwU3BMYitZMkJkTXVJak5kZUpNdkpvYWQxVm0zbUdM?=
 =?utf-8?B?Q0N6WjlyeVl4amU0U3llQnRvODVqWU9FcnVHQWdIL2dpdzBnTFI0VE1pMnJF?=
 =?utf-8?B?ZGZFaFFuclJFN2owYVJkd3BOVGE1T2JBU2FUbENCdnRzRUVZQUFUcVBuWE0r?=
 =?utf-8?B?NTA1dnIrRDlHakJtUmJKNnM1WE0zZ3kwK2xaTVJhc0o2U0ZEbERXaThTY1or?=
 =?utf-8?B?dDV4a05kZEYzWnpCVGdIR1VjU01NS2FYQThVVC91UmoxUlRrYUtvVjVBdFgw?=
 =?utf-8?B?WFFlQlZPSGk0aTJhRVpEeCt6UVVUY3NPR1hWSDFJU25vdGhPRGRobWYvYmZO?=
 =?utf-8?B?Q2hkdC81YTRHNllrOWF4Zm8vaGdpZ1lPRzZNY0VmMUcwaFl1SGxKMytYbWJT?=
 =?utf-8?B?c1dhNVBwQjE0WG9qOGt1Rkx1NlVON3ZHUk1MTGFhVGdrcmFUTU5NSG84cXQ2?=
 =?utf-8?B?L3JSYmw1dDZJbWo3T2UwcmFLRVVCdFltWGZrcno0T3luNFdNK2d4MkVnNHRR?=
 =?utf-8?B?aU8xbHVwWUdvcGhOcDF5SytvZldtWXF6Y1NYaXhLTXVmMkJYdDV6c2tjeSt5?=
 =?utf-8?B?ZEZBL21MbE5lSE10QWxBTHJSNTAwQ1BDQ1pwc0JBN3J0cmtBSGFQb0hVckNK?=
 =?utf-8?B?WVdWNVIyelI4MGk2R1hxV2M3M05Maktud2RTSHN2dE0zRnBQZmNWNmlMQVhw?=
 =?utf-8?B?QlpOa2tsUDZpeldWSGVMRG1va3JZU0djb1pPeE9YMWdEN1J4WWwzWjZjQVRY?=
 =?utf-8?B?dk9iWlpmaFBpYUgraWlCZFJXTDIxSFR0eGs3TTVLM203K2dMNnp1cnRMa0lD?=
 =?utf-8?B?MyswYWMzTnFIajlrSkwvbGNQSUJGdTNFK3RRVWMrWkpEeElUOWZrSGpxYnJl?=
 =?utf-8?B?Q1hZSzRlei9uZDJlQzFEUkF5QmV1eGxaZTdvRlRIQzlabmxQdTRuYmx4SFVp?=
 =?utf-8?B?MFZPUkxjcnB3VXh3cWNib2VXSzZ0bnllUTRJem5uck93UEl5UVIzdnQ4T2ti?=
 =?utf-8?B?d1lnVHNneTFrZXdoTTg4S3dzclRZSC9WK1JINlREMnpUUFlaVTZzUk44dTNz?=
 =?utf-8?B?M1hnNFQ2TmVXS3ZZWkxwZSsyd1ZVaytBUTVtMDJCYUNuZW1RSGlLUjA3OGRv?=
 =?utf-8?B?Zjl5TE83UnZScXBoY0d0aUhlTnhoaE91NDNHUnFVTzdJa2ZuclRFWlZkTlRG?=
 =?utf-8?B?cmJ1VWErVU0zdjZWbEc4TjVnWm54WmtOZFdDOTZBdXBzdnRZYWVoeU9MeHNp?=
 =?utf-8?B?OEUzT1ZrWHRsRlE4M2swYUxyZFEybzlvRU14Uk02UlJvZzFWU0xpRlpzZnFB?=
 =?utf-8?B?MFprWEg0Wm5ieFhtdUI2RHlOUzh2SEc5NU9xbngvQnNRckQ1NC91QjQ0RzV1?=
 =?utf-8?B?anlwNG5LQ3B2Y0xGVzB1TzRFWHhBbk1WN2NBenI1WUxvTVdDcGNTTjhYM1lP?=
 =?utf-8?Q?ob1k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be45d2e9-0ba1-4b30-54a0-08dbf5c2c638
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:48:30.2845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxuL4OQcsBsmEnWNjvzndYMGtk0j3OvRqLGb8CdXoU9mTpZHPLgFRE7ERFPwVhYA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689
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
Cc: Philip.Yang@amd.com, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-12-04 15:23, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231204202310.23834-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

v2:
-not need calculate vram page number for new registered svm range, only
do it for split vram pages.

SVM uses hmm page walk to valid buffer before map to gpu vm. After have partial
migration/mapping do validation on same vm range as migration/map do instead of
whole svm range that can be very large. This change is expected to improve svm
code performance.</pre>
    </blockquote>
    <p>Seems we could calculate old, new prange-&gt;vram_pages inside
      svm_range_split_pages, using dma_addr &amp; SVM_RANGE_VRAM_DOMAIN
      to decide if it is vram or system memory pages. This will cover
      both unmap from cpu and set_attr to split range cases, Thet the
      new function svm_range_vram_pages is not needed. </p>
    <p>prange-&gt;vram_pages update after migrating to vram should use
      mpages, not cpages, the total collected pages.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <p> </p>
    <blockquote type="cite" cite="mid:20231204202310.23834-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 149 ++++++++++++++++++++-------
 1 file changed, 109 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2834fb351818..2f14cd1a3416 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -158,13 +158,12 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
-		      unsigned long *hmm_pfns, uint32_t gpuidx, uint64_t *vram_pages)
+		      unsigned long *hmm_pfns, uint32_t gpuidx)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 	dma_addr_t *addr = prange-&gt;dma_addr[gpuidx];
 	struct device *dev = adev-&gt;dev;
 	struct page *page;
-	uint64_t vram_pages_dev;
 	int i, r;
 
 	if (!addr) {
@@ -174,7 +173,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		prange-&gt;dma_addr[gpuidx] = addr;
 	}
 
-	vram_pages_dev = 0;
 	addr += offset;
 	for (i = 0; i &lt; npages; i++) {
 		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
@@ -184,7 +182,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		if (is_zone_device_page(page)) {
 			struct amdgpu_device *bo_adev = prange-&gt;svm_bo-&gt;node-&gt;adev;
 
-			vram_pages_dev++;
 			addr[i] = (hmm_pfns[i] &lt;&lt; PAGE_SHIFT) +
 				   bo_adev-&gt;vm_manager.vram_base_offset -
 				   bo_adev-&gt;kfd.pgmap.range.start;
@@ -201,14 +198,14 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		pr_debug_ratelimited(&quot;dma mapping 0x%llx for page addr 0x%lx\n&quot;,
 				     addr[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(page));
 	}
-	*vram_pages = vram_pages_dev;
+
 	return 0;
 }
 
 static int
 svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		  unsigned long offset, unsigned long npages,
-		  unsigned long *hmm_pfns, uint64_t *vram_pages)
+		  unsigned long *hmm_pfns)
 {
 	struct kfd_process *p;
 	uint32_t gpuidx;
@@ -227,7 +224,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 
 		r = svm_range_dma_map_dev(pdd-&gt;dev-&gt;adev, prange, offset, npages,
-					  hmm_pfns, gpuidx, vram_pages);
+					  hmm_pfns, gpuidx);
 		if (r)
 			break;
 	}
@@ -982,11 +979,6 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 	new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
 	new-&gt;ttm_res = old-&gt;ttm_res;
 
-	/* set new's vram_pages as old range's now, the acurate vram_pages
-	 * will be updated during mapping
-	 */
-	new-&gt;vram_pages = min(old-&gt;vram_pages, new-&gt;npages);
-
 	spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
 	list_add(&amp;new-&gt;svm_bo_list, &amp;new-&gt;svm_bo-&gt;range_list);
 	spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
@@ -1107,9 +1099,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 
 static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
-		     struct list_head *insert_list, struct list_head *remap_list)
+		     struct list_head *insert_list, struct list_head *remap_list,
+		     struct svm_range *tail)
 {
-	struct svm_range *tail;
 	int r = svm_range_split(prange, prange-&gt;start, new_last, &amp;tail);
 
 	if (!r) {
@@ -1122,9 +1114,9 @@ svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 
 static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
-		     struct list_head *insert_list, struct list_head *remap_list)
+		     struct list_head *insert_list, struct list_head *remap_list,
+		     struct svm_range *head)
 {
-	struct svm_range *head;
 	int r = svm_range_split(prange, new_start, prange-&gt;last, &amp;head);
 
 	if (!r) {
@@ -1573,7 +1565,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
 	struct kfd_process *p;
-	uint64_t vram_pages;
 	void *owner;
 	int32_t idx;
 	int r = 0;
@@ -1642,15 +1633,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 	}
 
-	vram_pages = 0;
-	start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
-	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
+	start = map_start &lt;&lt; PAGE_SHIFT;
+	end = (map_last + 1) &lt;&lt; PAGE_SHIFT;
 	for (addr = start; !r &amp;&amp; addr &lt; end; ) {
 		struct hmm_range *hmm_range;
 		unsigned long map_start_vma;
 		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
-		uint64_t vram_pages_vma;
 		unsigned long next = 0;
 		unsigned long offset;
 		unsigned long npages;
@@ -1677,13 +1666,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		if (!r) {
-			offset = (addr - start) &gt;&gt; PAGE_SHIFT;
+			offset = (addr - (prange-&gt;start &lt;&lt; PAGE_SHIFT)) &gt;&gt; PAGE_SHIFT;
 			r = svm_range_dma_map(prange, ctx-&gt;bitmap, offset, npages,
-					      hmm_range-&gt;hmm_pfns, &amp;vram_pages_vma);
+					      hmm_range-&gt;hmm_pfns);
 			if (r)
 				pr_debug(&quot;failed %d to dma map range\n&quot;, r);
-			else
-				vram_pages += vram_pages_vma;
 		}
 
 		svm_range_lock(prange);
@@ -1716,19 +1703,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		addr = next;
 	}
 
-	if (addr == end) {
-		prange-&gt;vram_pages = vram_pages;
-
-		/* if prange does not include any vram page and it
-		 * has not released svm_bo drop its svm_bo reference
-		 * and set its actaul_loc to sys ram
-		 */
-		if (!vram_pages &amp;&amp; prange-&gt;ttm_res) {
-			prange-&gt;actual_loc = 0;
-			svm_range_vram_node_free(prange);
-		}
-	}
-
 	svm_range_unreserve_bos(ctx);
 	if (!r)
 		prange-&gt;validate_timestamp = ktime_get_boottime();
@@ -2037,6 +2011,81 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
 	return 0;
 }
 
+static int
+svm_range_vram_pages(struct svm_range *prange)
+{
+	unsigned long start, end, addr;
+	struct svm_range_list *svms;
+	struct kfd_process *p;
+	struct mm_struct *mm;
+	struct page *page;
+	int32_t gpuidx;
+	void *owner;
+	int r = 0;
+
+	prange-&gt;vram_pages = 0;
+	svms = prange-&gt;svms;
+	p = container_of(svms, struct kfd_process, svms);
+	mm = get_task_mm(p-&gt;lead_thread);
+	if (!mm) {
+		pr_debug(&quot;svms 0x%p process mm gone\n&quot;, svms);
+		return -ESRCH;
+	}
+
+	/* prange-&gt;actual_loc should not be 0 here */
+	gpuidx = kfd_process_gpuidx_from_gpuid(p, prange-&gt;actual_loc);
+	if (gpuidx &lt; 0) {
+		pr_debug(&quot;failed get device by id 0x%x\n&quot;, prange-&gt;actual_loc);
+		return -EINVAL;
+	}
+	owner = kfd_svm_page_owner(p, gpuidx);
+
+	start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
+	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
+	for (addr = start; addr &lt; end; ) {
+		struct hmm_range *hmm_range;
+		struct vm_area_struct *vma;
+		unsigned long next = 0;
+		unsigned long npages;
+		bool readonly;
+
+		vma = vma_lookup(mm, addr);
+		if (!vma) {
+			mmput(mm);
+			return -EFAULT;
+		}
+
+		readonly = !(vma-&gt;vm_flags &amp; VM_WRITE);
+		next = min(vma-&gt;vm_end, end);
+		npages = (next - addr) &gt;&gt; PAGE_SHIFT;
+		r = amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr, npages,
+					       readonly, owner, NULL,
+					       &amp;hmm_range);
+		if (r) {
+			pr_debug(&quot;failed %d to get svm range pages\n&quot;, r);
+			mmput(mm);
+			return r;
+		}
+
+		for (int i = 0; i &lt; npages; i++) {
+			page = hmm_pfn_to_page(hmm_range-&gt;hmm_pfns[i]);
+			if (is_zone_device_page(page))
+				prange-&gt;vram_pages++;
+		}
+
+		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
+			pr_debug(&quot;hmm update the range, need validate again\n&quot;);
+			mmput(mm);
+			return -EAGAIN;
+		}
+
+		addr = next;
+	}
+
+	mmput(mm);
+	return 0;
+}
+
 /**
  * svm_range_add - add svm range and handle overlap
  * @p: the range add to this process svms
@@ -2109,6 +2158,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			 * will change. Clone and split it, apply updates only
 			 * to the overlapping part
 			 */
+			struct svm_range *head, *tail;
 			struct svm_range *old = prange;
 
 			prange = svm_range_clone(old);
@@ -2123,18 +2173,37 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 			if (node-&gt;start &lt; start) {
 				pr_debug(&quot;change old range start\n&quot;);
+				head = NULL;
 				r = svm_range_split_head(prange, start,
-							 insert_list, remap_list);
+							 insert_list, remap_list, head);
 				if (r)
 					goto out;
 			}
 			if (node-&gt;last &gt; last) {
 				pr_debug(&quot;change old range last\n&quot;);
+				tail = NULL;
 				r = svm_range_split_tail(prange, last,
-							 insert_list, remap_list);
+							 insert_list, remap_list, tail);
 				if (r)
 					goto out;
 			}
+			/* cal each inserted svn pragen vram_pages */
+			if (prange-&gt;actual_loc &amp;&amp; prange-&gt;ttm_res) {
+
+				if (head) {
+					r = svm_range_vram_pages(head);
+					if (r)
+						return r;
+					prange-&gt;vram_pages = prange-&gt;vram_pages  - head-&gt;vram_pages;
+				}
+
+				if (tail) {
+					r = svm_range_vram_pages(tail);
+					if (r)
+						return  r;
+					prange-&gt;vram_pages = prange-&gt;vram_pages - tail-&gt;vram_pages;
+				}
+			}
 		} else {
 			/* The node is contained within start..last,
 			 * just update it
</pre>
    </blockquote>
  </body>
</html>
