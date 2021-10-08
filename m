Return-Path: <SRS0=CorL=O4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7B8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 19:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239E760F6C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 19:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 239E760F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B327C6E0A6;
	Fri,  8 Oct 2021 19:28:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9DC6E0A6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Oct 2021 19:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKzeiM3nnNGmOIN2nooiOwMuYA2rM4Hcdfu+hLtmiN8Zz+k4jloY8UtROcNzHBJEUt1w4DNUKXOhfbz/IlKzbPg9fO60IOEXhT6iLqe2TZNs3lXVgqhxJXr4314T2hbpEixpgoKwZ/Rw2cF7jIVyhfbXl+8VgmZzYnpLPVBbR7Q9K9Ynm+Ypz5mgkO94vVM4m1n9Zi82RULHNa1keGu7FytVnBk7aYqANjMHHryglPMtFYkJD2Lj9jtMHJC6iTzc5/MvUNMQcso18NE3Su64ssdnGJLEWcfm0hwQjkmL34SrFFWt+OWp1wzC4hyd+gmmrPRYVUmhxWCyo4OYrcJ1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+07tkeqHM6Yde927I4dnlqeP8LAzyQu5qS/s5gEP80=;
 b=Cq1k/eyRkR/Hg8DzLBPWAF5y8hYAehdvEUEyqvoXVZF9Uaa26Sd98fxDtndZv+neTfvFtJCxJFsxCpG1o2cfWcwCiIs/7WVsqg3mtlhTy31Ahp/1RlJt2LNQo6/Ohema2hCVfJGAfWQw0Sj3XzsKpZPgKlGuUzg0Gyx+RwQNFd8h//mMiqHtTxsJ7mWC7zwopx4fXtg2CtJDgIwpQbSwxZVsyJ4N5dO/KG7VsIauwVKUUwVTEmPprW71bl5Y56TECT+xm0EHapJmOkNuiDXxgZUj5Oe1kXZrSs/iMosK1Wd7D4mYIPcK2Q9mJcP26gFZgWuiu0gPLAO/q0nX5ZJHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+07tkeqHM6Yde927I4dnlqeP8LAzyQu5qS/s5gEP80=;
 b=GbgU8RQ1gN9dyTG4IaLkA0savFqzbNabDALwgnk7DspsQb+UwERFnn7fmly5WPcc6zWiECjeTvI/b/F0WukO4i0ePW8HR3ekKTw0pPf3HXBib9zece2dK6ZiUfG9LCEmLc7HFoOwy/tpbfdXcySR4Rmg75iCqlP1tH5Md9xAQ/c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 19:28:02 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab%7]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 19:28:02 +0000
Subject: Re: [PATCH 1/4] drm/amdkfd: ratelimited svm debug messages
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211006143210.4954-1-Philip.Yang@amd.com>
 <9a5d8ae9-db74-4fb0-22dc-f571c8bdb775@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <6533d884-6950-84ee-f795-6c61fc0ca2c4@amd.com>
Date: Fri, 8 Oct 2021 15:28:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <9a5d8ae9-db74-4fb0-22dc-f571c8bdb775@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19 via Frontend Transport; Fri, 8 Oct 2021 19:28:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 016bf93d-337f-48ed-fad1-08d98a91beab
X-MS-TrafficTypeDiagnostic: DM4PR12MB5165:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5165F08A1E6DBCCD52F0CBB6E6B29@DM4PR12MB5165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVZjXDfOaSHN24blD2LfCQC42q18AmKC3evelhvU1J8eCEHPOm97Q29eCFMmn49CynpKMpAQKW8haVro+JvNBdoPO5B7hH4tROWkINTUCEAlarV59fGutafckaU5oxPjcAM0Tjl23NYy+nuCxCzbeIaoFCDPUw4ipTzFYXcyRtBOx7/FYFd+t2hsb5p3+cbKdP0m0mrQlKTR1DP1UmoOmV6bg/03DKHa6B15EscEaM1NecBGdJkehWeUNbVKELFIeCNOEES9GSISqziWor19Gnk7AS3vSwZHqhGx4JAFY+R2+ACkGd3nFKRMdc6DIMhLGD++Y0YnNwzdBlej520tVtr/1X1lZBoCXBbDs0YQXldFCzzvUGPr9F474V+B4i6vi1c8p1VHgMd/dAUIk+8u+HHRbnPoajlYzy2X3WfjCgl5w1fx6O3PLgV4TVPWtdpJHCct+haUxyV/npuVYuHlRB1Hjltymilc9g1Pzag5dW6Vz9xU5Nq6UrvzicpcAWULxMSDKfHNUBVhCq2scj66jvJN5rtWyKdxaUq/Yki2QUjlR0aJxoQ5Lkt3elX4aywQ1w48+nmm2F2A46a4OfR0OVKt63DB5Dp557tWCEnyDN3hRXfg4oU7PY6mPeogbMP+usRgeLENa++xjZQqF+BAEnVAn42iQnMtqOMwJQraLPlrg1vdMNCZIX44aj3CEsMWd5HG9R9vJYUrNS7XzY4zG6dXBaOiS/2vaY5jj6ZIQGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(8936002)(38100700002)(66556008)(8676002)(5660300002)(83380400001)(508600001)(36756003)(2616005)(956004)(15650500001)(6486002)(26005)(186003)(53546011)(2906002)(31696002)(110136005)(31686004)(16576012)(316002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aElJNksyd3kvMkdGQ3NOWjBFMkF3QU9rQXNoSlhFRjZpRHZ4ZDB4Q0VNM0FJ?=
 =?utf-8?B?bkg2amZoTGtobmN1eDE1aVlNNnljRk55anZUMkdNUGR0L2VGVldRYldJUG9k?=
 =?utf-8?B?RkNySVA3T05nRjdVRGdXODZ6bkgxbVo2cTVGMVorWURxN0lUMFpza3JsR01E?=
 =?utf-8?B?RDVJVm9STmpFcjBVc3EwOFlxL200aTZjMzltYkZNYmRSTUpaMUMxUDhtWi9i?=
 =?utf-8?B?dkhPM09VL3d1MWx1bHJ2NytPc09iaWtCTWJBVWxDcVdiZCtOaU9iRHgyZFhp?=
 =?utf-8?B?b2JjK0FUMWREUnR2Tm5iWG1PRmZWbWZ4aG0vM2ZXS0NwaWVPQ1ViRTFLLzJo?=
 =?utf-8?B?RjJxRnhRcXdZQ2prNnYvejVhVXVvYjlHZzJVbldIMjZ6V1l6WitPZkQxL09l?=
 =?utf-8?B?QUVXSjE5YlNqRGMyTEo4Sk8zNzdkamFHbkZJQm9scW5ZaXR6TlNJVlZEQlBk?=
 =?utf-8?B?S1BZZlRxSjhmUG1iN2NiSWtPWGlNMnVUK3dJWmV0clcyeTc4VXlMTHNvb29r?=
 =?utf-8?B?Zm1lL3NNcEN2ZzZ5SEIwZmVIeUQ0ejNjRytkSzR4VDVLblQxcTJjclJOME0v?=
 =?utf-8?B?L0VvUGFtR1l3aWUrR01zTTZzYkxNUEdDc1F4ZDQ4ZCtSd0FTMWtFaFMwbTJw?=
 =?utf-8?B?ZG5xSll1bFVBYzdMQ2dzZk4rYURkQ3pSTWIxelJYM2NjeTJZYUwxbWtqY0lT?=
 =?utf-8?B?SHVKYWhwRTdwcXRYZDlBeGZHbkhjTG1lVTBZNTRJTDJlYUVacWdGbXN2OGVz?=
 =?utf-8?B?L3BDd1RBWjY2TzhXbllIdnBqY0RlZEFaNGVNWTYxNzhrK2tzWWdtbU84UHBi?=
 =?utf-8?B?WGtNcTQremd2THM1eWhteW1XQ0pNZHZuVHBMYUk1VW4vSm0rYjkrc0lTODhB?=
 =?utf-8?B?aHhlMnpjK2pzaEwrT28xMDNscmtVSitPVGhWd3A4T3NhemxzcUxXS1JkQ0sx?=
 =?utf-8?B?dzFrKzFLTXEyQTF1aVN4S1VMWTU5ekd0RngzUGtlZTlyOHo3RTVDZ05tWEx3?=
 =?utf-8?B?cnlERzNFQXdOSk9GQ05vVzNIVkFrRVo2VmNPK05TeEZpa2FSK0VOTEswamRn?=
 =?utf-8?B?S2hKWnFuMHh6TFZvU2pMM1VXMlZiMDQxbld1bUF5TjgvRmdFUm5KNmhSZzNm?=
 =?utf-8?B?cVNyZEZZOGJhMzB0a2ZUeDNaNUE5Y3U0U0w1Q3c4dFcxeGFGVW5rdlBpNzFV?=
 =?utf-8?B?Tkx6L3ZWSFFtenI2bHlzSkRXRHBESXE2OUhzOGdDbVROT3grSjJxUmloVy9q?=
 =?utf-8?B?NW5IOXIrdXFIN21jRmx5SEhNN2Vpd0FRUWtIRTVHcUlyQTVCeE1tMloxUWxC?=
 =?utf-8?B?NzdYVDYyT0Mrem8rdS8rdGlCK2NRY0h4Zk5MVEF6R1NtUlR0T25wMTRxM1Yx?=
 =?utf-8?B?cCtUbWd3MzU4K3VjbW03azhoRFNDQm02UjRzeFpOOTBpOWlPMHFBdEwxV0My?=
 =?utf-8?B?Y0ppa1ByNjZTT2h5NGI5Tm0rUVJvcFVMd24yeU1EekE0NVRYY1BJMC92SzJn?=
 =?utf-8?B?VE5YWXFzS1l1SFZad0tzZXN4TEJjdmVOU0lKR1piendqWjZENCs2NmlmUzlo?=
 =?utf-8?B?Rm1ueDNPY2FNSXJLTGdPTzc0Q2pWa2lNd2k0SXUrQVJTTWxYd25PeGFOMVRn?=
 =?utf-8?B?VXJFRFEvWkg4clZKUThVc25WTW1udndvWmJMZUE2V29lZE9zcW1rU3NaR09s?=
 =?utf-8?B?NENETElYZUt3TnY0RjZseGFXSENRMnZRTWc3RFk2eW95azZ3Y1JacXA3OXhm?=
 =?utf-8?Q?+3cLI/7+RFdkqlPapsEjerIqmZeROqkdSmVappn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016bf93d-337f-48ed-fad1-08d98a91beab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 19:28:02.5071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+k5+sMrFVkoLB1fKCvnofHTUFJz75mLHlGYfkflAxV5XMu+Juarxhbybwj69Qxe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
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
    <div class="moz-cite-prefix">On 2021-10-06 4:55 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9a5d8ae9-db74-4fb0-22dc-f571c8bdb775@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-10-06 um 10:32 a.m. schrieb Philip Yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">No function change, use pr_debug_ratelimited to avoid per page debug
message overflowing dmesg buf and console log.

use dev_err to show error message from unexpected situation, to provide
clue to help debug without enabling dynamic debug log.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
AFAIK, dev_err does not print function and line-number information. So
you probably need to provide a little more context in these messages. I
think this could be done with a

&nbsp;&nbsp;&nbsp; #define pr_fmt(fmt) &quot;kfd_migrate: &quot; fmt

in kfd_migrate.c. I'll make a few more specific comments inline.</pre>
    </blockquote>
    <p>I will add below to output function name in error message after
      include head files, because dev_err uses dev_fmt and amdgpu.h
      overwrite dev_fmt. pr_debug can use dynamic debug control +pfl to
      output function name and line number, don't need define pr_fmt</p>
    <p>#ifdef dev_fmt<br>
      #undef dev_fmt<br>
      #endif<br>
    </p>
    <p>#define dev_fmt(fmt) &quot;kfd_migrate: %s: &quot; fmt, __func__</p>
    <blockquote type="cite" cite="mid:9a5d8ae9-db74-4fb0-22dc-f571c8bdb775@amd.com">
      <pre class="moz-quote-pre" wrap="">


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 34 ++++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 12 ++++-----
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f53e17a94ad8..069422337cf7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -151,14 +151,14 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 			gart_d = svm_migrate_direct_mapping_addr(adev, *vram);
 		}
 		if (r) {
-			pr_debug(&quot;failed %d to create gart mapping\n&quot;, r);
+			dev_err(adev-&gt;dev, &quot;fail %d create gart mapping\n&quot;, r);
 			goto out_unlock;
 		}
 
 		r = amdgpu_copy_buffer(ring, gart_s, gart_d, size * PAGE_SIZE,
 				       NULL, &amp;next, false, true, false);
 		if (r) {
-			pr_debug(&quot;failed %d to copy memory\n&quot;, r);
+			dev_err(adev-&gt;dev, &quot;fail %d to copy memory\n&quot;, r);
 			goto out_unlock;
 		}
 
@@ -285,7 +285,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = svm_range_vram_node_new(adev, prange, true);
 	if (r) {
-		pr_debug(&quot;failed %d get 0x%llx pages from vram\n&quot;, r, npages);
+		dev_err(adev-&gt;dev, &quot;fail %d get %lld vram pages\n&quot;, r, npages);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This message is misleading. svm_range_vram_node_new doesn't care about
npages. It allocates memory for the whole range or reuses an existing
allocation. So I'd drop the npages from the message.</pre>
    </blockquote>
    agree, change to &quot;fail %d to alloc vram\n&quot;<br>
    <blockquote type="cite" cite="mid:9a5d8ae9-db74-4fb0-22dc-f571c8bdb775@amd.com">
      <pre class="moz-quote-pre" wrap="">


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 		goto out;
 	}
 
@@ -305,7 +305,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 					      DMA_TO_DEVICE);
 			r = dma_mapping_error(dev, src[i]);
 			if (r) {
-				pr_debug(&quot;failed %d dma_map_page\n&quot;, r);
+				dev_err(adev-&gt;dev, &quot;fail %d dma_map_page\n&quot;, r);
 				goto out_free_vram_pages;
 			}
 		} else {
@@ -325,8 +325,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			continue;
 		}
 
-		pr_debug(&quot;dma mapping src to 0x%llx, page_to_pfn 0x%lx\n&quot;,
-			 src[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(spage));
+		pr_debug_ratelimited(&quot;dma mapping src to 0x%llx, pfn 0x%lx\n&quot;,
+				     src[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(spage));
 
 		if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT) - 1 &amp;&amp; i &lt; npages - 1) {
 			r = svm_migrate_copy_memory_gart(adev, src + i - j,
@@ -347,7 +347,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 out_free_vram_pages:
 	if (r) {
-		pr_debug(&quot;failed %d to copy memory to vram\n&quot;, r);
+		dev_err(adev-&gt;dev, &quot;fail %d to copy memory to vram\n&quot;, r);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think you only get here if svm_migrate_copy_memory_gart failed. That
function already prints its own error messages, so this probably doesn't
need to be a dev_err.</pre>
    </blockquote>
    done, keep pr_debug<br>
    <blockquote type="cite" cite="mid:9a5d8ae9-db74-4fb0-22dc-f571c8bdb775@amd.com">
      <pre class="moz-quote-pre" wrap="">


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 		while (i--) {
 			svm_migrate_put_vram_page(adev, dst[i]);
 			migrate-&gt;dst[i] = 0;
@@ -405,8 +405,8 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = migrate_vma_setup(&amp;migrate);
 	if (r) {
-		pr_debug(&quot;failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n&quot;,
-			 r, prange-&gt;svms, prange-&gt;start, prange-&gt;last);
+		dev_err(adev-&gt;dev, &quot;fail %d vma setup 0x%p [0x%lx 0x%lx]\n&quot;,
+			r, prange-&gt;svms, prange-&gt;start, prange-&gt;last);
 		goto out_free;
 	}
 	if (migrate.cpages != npages) {
@@ -506,7 +506,7 @@ static void svm_migrate_page_free(struct page *page)
 	struct svm_range_bo *svm_bo = page-&gt;zone_device_data;
 
 	if (svm_bo) {
-		pr_debug(&quot;svm_bo ref left: %d\n&quot;, kref_read(&amp;svm_bo-&gt;kref));
+		pr_debug_ratelimited(&quot;ref: %d\n&quot;, kref_read(&amp;svm_bo-&gt;kref));
 		svm_range_bo_unref(svm_bo);
 	}
 }
@@ -563,8 +563,8 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 		dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr);
 		if (!dpage) {
-			pr_debug(&quot;failed get page svms 0x%p [0x%lx 0x%lx]\n&quot;,
-				 prange-&gt;svms, prange-&gt;start, prange-&gt;last);
+			dev_err(adev-&gt;dev, &quot;fail get page 0x%p [0x%lx 0x%lx]\n&quot;,
+				prange-&gt;svms, prange-&gt;start, prange-&gt;last);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The prange-&gt;svms pointer (or its hash) is pretty meaningless in an error
message. It's OK in a debug message to correlate with other messages.
But in an error message that's always enabled, I'd prefer a more
readable ID. I think it basically stands for the process because svms is
part of the kfd_process structure.

prange-&gt;start/end are also not really meaningful for this failure. The
page allocation failure doesn't depend on the prange start and end
addresses. It's basically just an OOM error.

I think Linux will be pretty noisy about OOM errors, so we probably
don't need to add more messages about that here.</pre>
    </blockquote>
    agree, keep pr_debug<br>
    <blockquote type="cite" cite="mid:9a5d8ae9-db74-4fb0-22dc-f571c8bdb775@amd.com">
      <pre class="moz-quote-pre" wrap="">


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 			r = -ENOMEM;
 			goto out_oom;
 		}
@@ -572,12 +572,12 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
-			pr_debug(&quot;failed %d dma_map_page\n&quot;, r);
+			dev_err(adev-&gt;dev, &quot;fail %d dma_map_page\n&quot;, r);
 			goto out_oom;
 		}
 
-		pr_debug(&quot;dma mapping dst to 0x%llx, page_to_pfn 0x%lx\n&quot;,
-			      dst[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(dpage));
+		pr_debug_ratelimited(&quot;dma mapping dst to 0x%llx, pfn 0x%lx\n&quot;,
+				     dst[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(dpage));
 
 		migrate-&gt;dst[i] = migrate_pfn(page_to_pfn(dpage));
 		migrate-&gt;dst[i] |= MIGRATE_PFN_LOCKED;
@@ -631,8 +631,8 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = migrate_vma_setup(&amp;migrate);
 	if (r) {
-		pr_debug(&quot;failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n&quot;,
-			 r, prange-&gt;svms, prange-&gt;start, prange-&gt;last);
+		dev_err(adev-&gt;dev, &quot;fail %d vma setup 0x%p [0x%lx 0x%lx]\n&quot;,
+			r, prange-&gt;svms, prange-&gt;start, prange-&gt;last);
 		goto out_free;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7c42a0d4e0de..7f0743fcfcc3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -158,17 +158,17 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 				   bo_adev-&gt;vm_manager.vram_base_offset -
 				   bo_adev-&gt;kfd.dev-&gt;pgmap.range.start;
 			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
-			pr_debug(&quot;vram address detected: 0x%llx\n&quot;, addr[i]);
+			pr_debug_ratelimited(&quot;vram address: 0x%llx\n&quot;, addr[i]);
 			continue;
 		}
 		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
 		r = dma_mapping_error(dev, addr[i]);
 		if (r) {
-			pr_debug(&quot;failed %d dma_map_page\n&quot;, r);
+			pr_err(&quot;failed %d dma_map_page\n&quot;, r);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Why not dev_err?</pre>
    </blockquote>
    <p>Change to dev_err in v2 patch.<br>
    </p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:9a5d8ae9-db74-4fb0-22dc-f571c8bdb775@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 			return r;
 		}
-		pr_debug(&quot;dma mapping 0x%llx for page addr 0x%lx\n&quot;,
-			 addr[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(page));
+		pr_debug_ratelimited(&quot;dma mapping 0x%llx for page addr 0x%lx\n&quot;,
+				     addr[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(page));
 	}
 	return 0;
 }
@@ -217,7 +217,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 	for (i = offset; i &lt; offset + npages; i++) {
 		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
 			continue;
-		pr_debug(&quot;dma unmapping 0x%llx\n&quot;, dma_addr[i] &gt;&gt; PAGE_SHIFT);
+		pr_debug_ratelimited(&quot;unmap 0x%llx\n&quot;, dma_addr[i] &gt;&gt; PAGE_SHIFT);
 		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
 		dma_addr[i] = 0;
 	}
@@ -1459,7 +1459,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		/* This should never happen. actual_loc gets set by
 		 * svm_migrate_ram_to_vram after allocating a BO.
 		 */
-		WARN(1, &quot;VRAM BO missing during validation\n&quot;);
+		WARN_ONCE(1, &quot;VRAM BO missing during validation\n&quot;);
 		return -EINVAL;
 	}
 
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
