Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3992C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 21:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD5E61009
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 21:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD5E61009
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0496E5C1;
	Tue,  1 Jun 2021 21:51:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 423396E5C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 21:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+ehtd9aaDkYJZk5FpXw1EBJg6ho+O4r+exag5NDVzzXwtlwx0jDp9t6n8o3Bvg6zPYKA420qv+enqiKTiFDhP1hPoIJkCqRhQRKJeJQ/wH1H4KUNK4+jfNf4iwluu6uDGdwRcialuQzAilI7qGwndHKSiMq+v6P5/uLLTFO1odojj+VNu5ZIeZlyY8MGAu1TpCc2mhr8HksDkJ5m3+oBxv8GagF8XHmN0NJE1Jnt1GA2brHmZKxUa6OfEVJrwEtofQYZn+dkQyJQwrG8DVzoL6nKu8SmStcSgcEHGVYFnUYAE3ps8q5eDCaZyDhKZkDmk4AXWsxUZaxjVRw2tamCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqAJqZq+aa4s9vfa4/Tr25nX8TqAvf2MlCLmtrjG910=;
 b=grmctUzszza0U8+2Gc92jH1DvnRPhSuRXEPwYRIDJShmDfTB2fLkrbZS2kUgbVnlwWnTZi+4Y4fA0EDOjtARJYqaIO/A8fwnngPjBuvx0w1fHmH1arjogXj+SMPFEnzZcwG3MS3P2Rct5/6HEbAUn3hYPoPE1+cnVQwOEdPrdNqsPhkpEZYfy4U4SLOV3/s8ksP4BqqFhuezplEzySssmyNSuKpEGoW8ByXFqpuiaWb00caQx6YWih+R+2hlZkxw+mwNzQP162mEKb9J8WIhQm+QpcFz98pzY5a3Zb/DK8ahlq402/3bdBgZm1Xw9cc4vGG+ZAs+NtkiQuuBhFY96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqAJqZq+aa4s9vfa4/Tr25nX8TqAvf2MlCLmtrjG910=;
 b=ZNt3AwMe2AcFEZbwSiScsazGyhjAikDyR7gDiskjbgULxCYnqnxFgm2f5F0fb0KNzyr/SwNfoNPVzUlnmy+wYgJCnv61kwOztUT+E7ZEcglWHI0j/gDCRVaixNndEd/P8JCmbZK2xOirshu/dAzOpbHxldPQ3AneMK0W+6f/5JM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 21:51:27 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::407d:38a8:e51a:8145]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::407d:38a8:e51a:8145%6]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 21:51:27 +0000
Subject: Re: [PATCH] drm/amdkfd: use resource cursor in
 svm_migrate_copy_to_vram v2
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210528155243.88181-1-christian.koenig@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <8389ebc3-47a7-d978-f35e-aefaba1273ea@amd.com>
Date: Tue, 1 Jun 2021 17:51:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210528155243.88181-1-christian.koenig@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::35) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0126.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27 via Frontend Transport; Tue, 1 Jun 2021 21:51:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0737dead-d69a-462a-a07a-08d92547687a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5120BABA6590E605B67583F6E63E9@DM4PR12MB5120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GQHZIyUGJkwUR9ErZgqSQL/fEKiFwb1oljs8/hdkGk8+O4vIknDrcwUJO9nMJz72WHMy2mLeRjkJV5Q83ZrQkxFYw6C+ybtWVy1jp/NH9Rh+ulMEW7JgjUw8TYCyiLHTkr4KOTnPLY9vQiMoS/0H0v7x8VIPogtsgPA/iDYIms+f5JthtT6r+T+rJ1SffTROTFAGPLsZrSR7ZVgTd5zsy5xKbLZNPjIuAn5x5HsZUx0W0jvcCs98BZtRDjjvBwO4+rrfoAqqdKwJZEL57BJlsyFepKTX58a6BxhQevov+v75sExH9kqpuBqhl2S1bh4wFW1Wt5y/INSpOwuoV84Gf2zn7BqJw1jmYKcET2emPFVC130j236GbqVWMBmrDTwAhs3e26NJvtyAJ5Qv4P2MGBiaVU6C+Ws453UQ2tPznPiYnynl8ckarBNpA9OVPCoGOyrJhC+C/22nRkdkFSe3ja80lIi2hwwUiDEo6MkU1d20CS0qNCwhVr7r7MefxErJGgRSyD17l6v62Nxd2jC4ZtSncD+DmzZnBF2TsisTF78YUlEkuCYLygMyCaZ0NYbej74bV6KtevjNpCi1G1w57sq2S8V6Kzca7/bhtw0fjpjtwXdQHIyNY2MbqV0igwx9zptuvDUWLtUnVrJBFtTOuaiL0whKq1j7LdFX/XUPMLWHMQDchicNfquSmTsBtEy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(956004)(66556008)(66476007)(66946007)(2616005)(5660300002)(16526019)(186003)(31686004)(4326008)(38100700002)(316002)(8676002)(53546011)(6486002)(36756003)(83380400001)(478600001)(8936002)(31696002)(16576012)(2906002)(66574015)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MHlUcm9sejBPcU56VmhsR2JGenRQUEhRWG1tU2NLTUJuTDNzeEhHQzhHNFVy?=
 =?utf-8?B?azdTMUp0ZTFFdmhUZDNnbHZpa1N1MjM2dytIdDZyNjVLbThUSmptWERYZDNJ?=
 =?utf-8?B?VjRWZG9JQ0JZZXFRRGpxeG9IbkMvODdsL0J5K2lrS0pDY3FVdzNBemg2aU5I?=
 =?utf-8?B?b1RVSEJqMEkvTUV2UVBQT25iN0tvRTRoTk04OXFRdXlqNWYwQXFsVjFzWnhn?=
 =?utf-8?B?enlVVzZBdU9OMEh3UWdZYXFBenVhKzBnZ0lieWc0Uzd2VnhCUUpQK0RKS2Vv?=
 =?utf-8?B?aHRCZU9PNDZYZnZjWVJJQWZxc1NkWnk2UEl5UmNHaDBDQkhEZjVjc1RtWkoz?=
 =?utf-8?B?b3kvZXRGcVMrY1Z6T1ROUWdrOW5sS0U1YnhBVy9UY1dxTDd6b1FvNnNleXlj?=
 =?utf-8?B?WXF1WWZMQW5qUHh5eGRkRXpwMU56dG9VdkhZL3ZMWCtsOWtJRmw3S3pxTVB4?=
 =?utf-8?B?TlZveTBIU0RYZmVNeVU2VkFGZjlxMkNrbHVld1hxOGJFVEFlRmxxM25ubmVl?=
 =?utf-8?B?eEMxOC8yeExPaGgwYUZuSkFkM3VYazJjT0tEV1lBdWJvWjVOYkYvclp0VE5t?=
 =?utf-8?B?T1p5V1RwaSs4YlhFTERSVlM5cFZhNmk2OVUvQ1lXRTVscTFMVllDSzNuYXEv?=
 =?utf-8?B?MkE0WFRVcnFqYUFaSnYzT1VYMnlwZlgrVXpLN1NkWXRDajRMcVRwbG9FbG9U?=
 =?utf-8?B?Y0RvWDFYL0NkYnlsUUg3UW4veWJwcGZndWFCWnFiTkpyd09jSStHZTZEUytq?=
 =?utf-8?B?NVptblV3T0dlQ0RKeGIrdHUrWXNqOXAwTXNBTDU5Y0s4RXJhWDN4Vm8wb2tK?=
 =?utf-8?B?cm95ZnFUdHlJRTRXV2dkWUlDWTdwckdPTHZvZy9jZzNWNm9IejMydXZqSXdM?=
 =?utf-8?B?SDNmaXJ6RHBDVThnZ3ZQOWM5dVE0aUpadDRqWithZThPbG5BaEk2VWJxZzJH?=
 =?utf-8?B?Z3JIYW1SUEdOR3Vhc3hCZlgzYnZJb3BnSFA5QTZ6QUNJMGF2K0dhQlV2SFVh?=
 =?utf-8?B?Z20xWWhWVXh2QTF2SGxkZ2dTcW4xbkpTaUFEYjMyZjd0M2xtRC9uSnNQQ1kr?=
 =?utf-8?B?cnpOSnBPUUp4SVNrNEhvaWFuVU9BSExHK3pKMVZ3bFd0eit3Y0c0L0pKSWRU?=
 =?utf-8?B?V1A3ZTBZYjIzVVpjejlROWM4QzkxdHpsUTdJL2lKR3hXZ25FTVUxdklvdlU2?=
 =?utf-8?B?Y2tzZnZpOUJrSElOalAwbHBFOHRRbUdjMWd1cjZMTi9ZR0pRWW1JTGpBUFc3?=
 =?utf-8?B?Zm5LZmNSWDQ0K0ZwS1BWYW5MZ2o4TDJTRG5qaGRxa0VIMkh5b2NvalNEVEQw?=
 =?utf-8?B?UzR2Vzl1MW9wZ2NwMHV4VTNxcFNiRkVkZ2pPNE5mOVdlL2RXbTdDdStscWpN?=
 =?utf-8?B?V29MUEJmcFpxSzlkaVRqUytveEZUdEpCYXlYVlp6NW1MVVNMZzlTWmxLVmxv?=
 =?utf-8?B?VWt6QWt0WDFBYlJReVZWcFVxc2prdklManNDT2c5aUtuMDRDU0FUK1F3WHRZ?=
 =?utf-8?B?V2dITTRkUnNRWHd5N1pOcFlxaHVyakxwcmlzZmJrd2hUUHExQnJFcmNMVkZs?=
 =?utf-8?B?R1BVUm1LTXpFcU85Y3d1RXdPV2pLODRCUlRTdVlxUWNyajNoMUtXNVRYellH?=
 =?utf-8?B?ZUhqa01wMGtDUGlteEo0d0h6VkZYSHhJTmdVU3VUTzFTSWJ6MWx6LzNKWjE4?=
 =?utf-8?B?R1ZuZkpjUTlQb2h1V1k1MmxHaEZIVzN2Z2h0T0doUU9KV2wzN1lyZW1iTHBa?=
 =?utf-8?Q?NkSehhEyAZ8YavDooMAwcickBrapw4a51Cre3/S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0737dead-d69a-462a-a07a-08d92547687a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 21:51:27.6414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7KPwgIzDKcWhlsA0ztTnKueLT/gHHk9VxL+vtywMkyyyvxG+XpwfLGtcgEjnPcX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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
Cc: felix.kuehling@amd.com
Content-Type: multipart/mixed; boundary="===============1927189340=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1927189340==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>One change inline, with that fixed,</p>
    <p>Reviewed-by and Tested-by: Philip Yang
      <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    </p>
    <div class="moz-cite-prefix">On 2021-05-28 11:52 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210528155243.88181-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">Access to the mm_node is now forbidden. So instead of hand wiring that
use the cursor functionality.

v2: fix handling as pointed out by Philip.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 68 ++++--------------------
 1 file changed, 10 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index fd8f544f0de2..5ce8fa2ddab0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -29,6 +29,7 @@
 #include &quot;amdgpu_object.h&quot;
 #include &quot;amdgpu_vm.h&quot;
 #include &quot;amdgpu_mn.h&quot;
+#include &quot;amdgpu_res_cursor.h&quot;
 #include &quot;kfd_priv.h&quot;
 #include &quot;kfd_svm.h&quot;
 #include &quot;kfd_migrate.h&quot;
@@ -205,34 +206,6 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
 	return r;
 }
 
-static uint64_t
-svm_migrate_node_physical_addr(struct amdgpu_device *adev,
-			       struct drm_mm_node **mm_node, uint64_t *offset)
-{
-	struct drm_mm_node *node = *mm_node;
-	uint64_t pos = *offset;
-
-	if (node-&gt;start == AMDGPU_BO_INVALID_OFFSET) {
-		pr_debug(&quot;drm node is not validated\n&quot;);
-		return 0;
-	}
-
-	pr_debug(&quot;vram node start 0x%llx npages 0x%llx\n&quot;, node-&gt;start,
-		 node-&gt;size);
-
-	if (pos &gt;= node-&gt;size) {
-		do  {
-			pos -= node-&gt;size;
-			node++;
-		} while (pos &gt;= node-&gt;size);
-
-		*mm_node = node;
-		*offset = pos;
-	}
-
-	return (node-&gt;start + pos) &lt;&lt; PAGE_SHIFT;
-}
-
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
 {
@@ -297,11 +270,9 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 {
 	uint64_t npages = migrate-&gt;cpages;
 	struct device *dev = adev-&gt;dev;
-	struct drm_mm_node *node;
+	struct amdgpu_res_cursor cursor;
 	dma_addr_t *src;
 	uint64_t *dst;
-	uint64_t vram_addr;
-	uint64_t offset;
 	uint64_t i, j;
 	int r;
 
@@ -317,19 +288,12 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		goto out;
 	}
 
-	node = prange-&gt;ttm_res-&gt;mm_node;
-	offset = prange-&gt;offset;
-	vram_addr = svm_migrate_node_physical_addr(adev, &amp;node, &amp;offset);
-	if (!vram_addr) {
-		WARN_ONCE(1, &quot;vram node address is 0\n&quot;);
-		r = -ENOMEM;
-		goto out;
-	}
-
+	amdgpu_res_first(prange-&gt;ttm_res, prange-&gt;offset &lt;&lt; PAGE_SHIFT,
+			 npages &lt;&lt; PAGE_SHIFT, &amp;cursor);
 	for (i = j = 0; i &lt; npages; i++) {
 		struct page *spage;
 
-		dst[i] = vram_addr + (j &lt;&lt; PAGE_SHIFT);
+		dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
 		migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
 		svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
 
@@ -354,18 +318,10 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 						mfence);
 				if (r)
 					goto out_free_vram_pages;
-				offset += j;
-				vram_addr = (node-&gt;start + offset) &lt;&lt; PAGE_SHIFT;
+				amdgpu_res_next(&amp;cursor, j &lt;&lt; PAGE_SHIFT);
 				j = 0;
 			} else {
-				offset++;
-				vram_addr += PAGE_SIZE;
-			}
-			if (offset &gt;= node-&gt;size) {
-				node++;
-				pr_debug(&quot;next node size 0x%llx\n&quot;, node-&gt;size);
-				vram_addr = node-&gt;start &lt;&lt; PAGE_SHIFT;
-				offset = 0;
+				amdgpu_res_next(&amp;cursor, PAGE_SIZE);
 			}
 			continue;
 		}
@@ -373,19 +329,15 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		pr_debug(&quot;dma mapping src to 0x%llx, page_to_pfn 0x%lx\n&quot;,
 			 src[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(spage));
 
-		if (j + offset &gt;= node-&gt;size - 1 &amp;&amp; i &lt; npages - 1) {
+		if (j &lt;&lt; PAGE_SHIFT &gt;= cursor.size - 1 &amp;&amp; i &lt; npages - 1) {</pre>
    </blockquote>
    if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT) - 1 &amp;&amp; i &lt;
    npages - 1) {<br>
    <blockquote type="cite" cite="mid:20210528155243.88181-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">
 			r = svm_migrate_copy_memory_gart(adev, src + i - j,
 							 dst + i - j, j + 1,
 							 FROM_RAM_TO_VRAM,
 							 mfence);
 			if (r)
 				goto out_free_vram_pages;
-
-			node++;
-			pr_debug(&quot;next node size 0x%llx\n&quot;, node-&gt;size);
-			vram_addr = node-&gt;start &lt;&lt; PAGE_SHIFT;
-			offset = 0;
-			j = 0;
+			amdgpu_res_next(&amp;cursor, (j + 1) * PAGE_SIZE);
+			j= 0;
 		} else {
 			j++;
 		}
</pre>
    </blockquote>
  </body>
</html>

--===============1927189340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1927189340==--
