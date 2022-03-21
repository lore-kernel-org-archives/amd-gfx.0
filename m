Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A903C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 13:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB6610E36B;
	Mon, 21 Mar 2022 13:41:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1C310E36B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 13:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nolb+ORgc18jtsbRVLWe83fPnnV6rZnxJNqkkPpx0DKkBViYW7ACfZhRSsDBUqmOGknd9uswzKpCc2Fsd/dGIlNC4eExIcmVh/zEooquy3ux7Hf6BYNb6PFtbnvaRCAoXqUjfx6o/TiWP0T0LRpLk9RRo3cuMvQ7FGOSlPRJ65VNGVN4G6tRV7sY56nrY/0+h1S3HENsfOaihgKqd1ONdvthlpVFTurLtRrg6fs7a5tzGfuj5l32qRm5B0zKZVb/SpNMyqf2Bn5XBTEQSW4NQ7xdqB4wTnXDyVakKS3SqQ1Eiy/tybtFryzRalD5/Xj+cfDqAYl1t1owDrDJbt/nKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01Jl6my4+3SIgF21Hhv+SxhUVzQ5oUYSc7YZZD5YcAo=;
 b=G9SxOoSIvIZWpV86xvrEP6xVY0pi28R7wvDw/bctMROHGCNJnBSXbu+uBmvB643SCFWSLMSch8dLmqXz0dZLACkTGv71c3uvkkve8vHyJBE9Yrwso+8miKAhwjc3ddXShySM65RPlt+Qq4zdaYXuZE8OZWDTx4U7MCRurZuT8zBV8L7F1K+q9EX+ZA6byN5d3hRTjBP+hHwihMBMnH6oP8zToiOPMzj/IYLVhWEIZftpyv5xEduQicsA0msjSunakB8QPQrvnrgDVZWGZ14lVglnadCa45WmNsKNIDW1LCAArQAFhBL2/jId5A7QxKo8tdhy8JerWGgD6w2phcLwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01Jl6my4+3SIgF21Hhv+SxhUVzQ5oUYSc7YZZD5YcAo=;
 b=fOC2SCJawqdb2ZfESmouVoYgheSMt9RNLN347+bgLqew7VyULwehGTsUChu/nNox6J4UeWr+cjQl8il1ewbeA92jH/tGDuAbf1QLAOI2dS3F5MU0d9xJ8QGmxLed34icreNeUAlPKfIdcEFC7A90oM6LD0fXi4Lns0y4X8k82Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB3135.namprd12.prod.outlook.com (2603:10b6:208:c4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 13:41:21 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329%7]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 13:41:21 +0000
Subject: Re: [PATCH 7/7] drm/amdgpu: remove table_freed param from the VM code
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com
References: <20220317135044.2099-1-christian.koenig@amd.com>
 <20220317135044.2099-7-christian.koenig@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <69ffd32d-1416-b324-2fcc-b6b98452c0ba@amd.com>
Date: Mon, 21 Mar 2022 09:41:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220317135044.2099-7-christian.koenig@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc4d34e4-554a-40ae-d479-08da0b407bb3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3135:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31359EF59129AEF96D5BFE63E6169@MN2PR12MB3135.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/GIWMrRh3vDwH3yasS+dxcKMb7+nstlTdWxaRC9M6WfMT8D+vmW2X84oillkaxn/x34uBdsWsvOvOIJcnv8S6Pe7Z6fz/+V9c7zUIo61BSk89j9ELg4aY+vKo2eB2RlP6cg6nJSU4dSHiHhZR8CMlj4uQYLKB8yYe3whCdwLNYA0Sgg//a8VOPdxDFYNcSW8jhoL1mtFVL0clN4UFfupZ2mS99FGHGN1mXjWJ+LxGe47h87qQs+91Zwz+m38T8nVg0ZopfgbwY28/Qu90aC3dOTJ3UdrKb2Z1E1ngkWeoR7MQNtioeMn4s0OP6xcY/bNdJnDcfZu2k62GQ7ieGE2RoQGiLylGceqW/vL9gkagRQXzRY8lsQlkRYM3py73UvWq2lvt07JJxwvs6NcK4/9ysiw4CXNVqEouYhQt/3+MndoR/nB9VgKw9O+HJ62MRxP5c5M+d6qAq8x9F95/gkqGFQ3R7P9SCjJWNoz22KXshyh0goK57nukBApiXJ1UQzJiU8qAyxbSvoamnTGbm8i7tMWzAtdq/iEnGEuKn5oXx3yppwIlSp2DIe5LxeJ4k6Q86wNtlabuR88zJFA71Rekx1tisEoV/VgouqTIjIDaRZU6Vec3++qII/bjxRkZjdcoCgk/n4vnhBed9kdgx08NVrtZzBWmmpU18AuKMH0SWkPU8qsH/7oM0emPqE/odK39Q1qnxehOODLPbIKEhLgoUkbw4K8Z7O4yu4uJUig0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66476007)(66556008)(8676002)(53546011)(66946007)(6506007)(38100700002)(316002)(8936002)(2616005)(31696002)(6636002)(6666004)(5660300002)(6512007)(6486002)(31686004)(2906002)(66574015)(83380400001)(508600001)(26005)(186003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ZzYmdZSksvR1V5YTdrTlFqWEw5RFM3U210SDIwZ1NzZFc4a3VaUjhVVmlq?=
 =?utf-8?B?b2QwejhvZVcwWEZlM2xoZ2NDN2pmbW1HU1psK3lVTGZmRVBMVzE4bm5ldCt0?=
 =?utf-8?B?WEtSSWNzTXN0ZVpxblQxSnMvYzh6RkE1SWJZRitKcDRRQVZYR252WjllVkVJ?=
 =?utf-8?B?eTgzR0k1c2hHUnhKQ3Q4UnZXN0hrUmNKZHVTWUJTT0VrRTJkaHp2TThIT2pT?=
 =?utf-8?B?eXRiblRuRHNTdlJ6Rlh1ZE9BdEhnaEhhdWlTMmVBcHNOMUdNcWlvb2IrYW5r?=
 =?utf-8?B?MTJjUXhpSlNrL3c5Z0ludkd1TUVDZnJLdmpNZXlyMlJZNE5TMkpEY3ZYaG10?=
 =?utf-8?B?WnNlYjdpbitzQmhqVVpFYkJHSGVJZjFDc1JqRU84cCtvVGtIOG13eS9QTnlr?=
 =?utf-8?B?TDNlQTR0cmRveDlQL1pRLzFXTjJYU3NhS1pTdjc0dWhLVE80NktMd2JmMGtx?=
 =?utf-8?B?NlU4RkF6RWd4VzM2SnQyOGhMeUIrYTVEZTlDclJ1Q2hOMDNEdU9RT3Q0UGVD?=
 =?utf-8?B?Z3FNRkJqTnYzR3ZsdFhidGVhU01kWXdwbVVrdi9hdjlWZXdxMGJ5Si84SGt0?=
 =?utf-8?B?UlA2d1BodjlLSTAyZU4wZThZaHNDVyttZkY2SXh3cmJkWkZyVVBxZVMraFhE?=
 =?utf-8?B?M21admdLd0xJMHAxR0prWVI0S1dLM2NaWXhCMU5hV1V3bkdXOEN0REhGTW1y?=
 =?utf-8?B?a1RhWjhNY2lrbWlqZ09QNDlheEo0VTl3SlI0ODBETFlYZ1JkZGlhS1gvcXhE?=
 =?utf-8?B?TlVIT3ZPSmR5ZnN5dzZsalIyc2w3a05DMk4ycW95T1FFVDgyUVRXWUVGaFRI?=
 =?utf-8?B?RStFMllML1pFNDdmNXBjamlDSFcwM09VbGptdGQ3RVFIenFrakFGWGxacGRn?=
 =?utf-8?B?SmpnTXpKZW4xZDVCZW1zOGxhUHJyY1V4bEhrblVKN1ZrZ0c3anBzOGx6aEwz?=
 =?utf-8?B?dzdUQ1NYU3YyamZPcm82TVdFWXNiT1daekFjZjFmcGtBVlRXajczdkZsVTMy?=
 =?utf-8?B?QnNheW9BcGNHZ3FYRlM3OW02TWFTZmVBM3N6b3h6azNhTEt5NCsra3hmc1Bs?=
 =?utf-8?B?WlVTOUxZeit3M05JWmJtOWxyTmUxSlFXbWI4RUZaTmtHU1Q2eUpDQXRJMmlG?=
 =?utf-8?B?b1ZtNlJGcklHU3ZPdmpFcGZWOE15NkFLQkdnaGJ2TmRJaVRZSXBhT0cxOG1w?=
 =?utf-8?B?Y012YVFETXl0MGpRUUJTZG1JN3M4OGRrMkJrYmErZ1JXVjl1WHBOQ2YyS2VD?=
 =?utf-8?B?ai9uZWd6NWgySVlpMUZ3RnZRYXR6bmg2QUFnd2NPbUZnYWNNeTdjKy9QaVJx?=
 =?utf-8?B?MnpiUnlub3V6L3FqU0REQVpxeG8rdkNGTzBtNXZsVE5BcXMyQ2o4NGpzZ3Ra?=
 =?utf-8?B?TmliYjl5cEpVeUxSc2VZTEdwVHdRUjBOakRGUmhma05iV1dFaHBCb0RzQlNH?=
 =?utf-8?B?NGh2eDZETUg1djNieWtCT1YyOXFibW1pRnV3VnBjdUE4NU9IYkJQN2h4YjNF?=
 =?utf-8?B?WVNCQXI2bEhQMG1rZUJCNS9QN1BUODdQUUpzQ2xaQ2pqM0hxNUQ2UVVUbE9R?=
 =?utf-8?B?WWZ1cDRuUmlQVU9JUjM4MHFQMzErbFJUdDdXckZ1VXIxN2xmNnZoVlpXZkRE?=
 =?utf-8?B?dTYxUldHS1l5dzAvTlZUd3BxMHFDUlpCc0lETWJJVUhsc0p4VnFXVzFheC9Z?=
 =?utf-8?B?YjVvQUV1RFdMYlFlLzY4NEl4R2hDU0ZLMzdvZGEraUpPb2ZWempudXhPbFll?=
 =?utf-8?B?RHlMbjIwRjVHMEI1SXQ5UVlqczJHaUprem8wL1BoNktlQVdZNldXeStJb0ZH?=
 =?utf-8?B?bVFscGJCcTZqQTNmalJmMHNrK0lpcG0vZEt0Um1EWVZXMzU1bDZ3YzlrNWRp?=
 =?utf-8?B?Z29jUVRCQ2hvSUpCaTQvcWR1YjBXTjdEUUhXUE1ML3hDaTJsSWppSVRkK0F1?=
 =?utf-8?Q?zhWFA+Vsg7U26LoyUh5Jgc0iw359l83B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4d34e4-554a-40ae-d479-08da0b407bb3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 13:41:21.2396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGBlmwDfxpNp47JXeBb50t7AdpC7vOLZeyXXSDafskLxwUU6GdPTY1ryBP87Pcwz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3135
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-17 9:50 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220317135044.2099-7-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">Better to leave the decision when to flush the VM changes in the TLB to
the VM code.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 21 +++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  5 ++---
 6 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 57b521bb1eec..8b14c55a0793 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1104,7 +1104,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 		return ret;
 
 	/* Update the page tables  */
-	ret = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+	ret = amdgpu_vm_bo_update(adev, bo_va, false);
 	if (ret) {
 		pr_err(&quot;amdgpu_vm_bo_update failed\n&quot;);
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2d4a89fb264e..62518c7b31c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -806,7 +806,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_vm_bo_update(adev, fpriv-&gt;prt_va, false, NULL);
+	r = amdgpu_vm_bo_update(adev, fpriv-&gt;prt_va, false);
 	if (r)
 		return r;
 
@@ -817,7 +817,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
 		bo_va = fpriv-&gt;csa_va;
 		BUG_ON(!bo_va);
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
 
@@ -836,7 +836,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (bo_va == NULL)
 			continue;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index bab6500728cb..2e16484bf606 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -618,7 +618,7 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 
 	if (operation == AMDGPU_VA_OP_MAP ||
 	    operation == AMDGPU_VA_OP_REPLACE) {
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			goto error;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a43302a86254..c29b12fec863 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -808,7 +808,6 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
  * @fence: optional resulting fence
- * @table_freed: return true if page table is freed
  *
  * Fill in the page table entries between @start and @last.
  *
@@ -823,8 +822,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				uint64_t flags, uint64_t offset,
 				struct ttm_resource *res,
 				dma_addr_t *pages_addr,
-				struct dma_fence **fence,
-				bool *table_freed)
+				struct dma_fence **fence)
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
@@ -937,9 +935,6 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 		tlb_cb = NULL;
 	}
 
-	if (table_freed)
-		*table_freed = *table_freed || params.table_freed;
-
 error_free:
 	kfree(tlb_cb);
 
@@ -999,7 +994,6 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
  * @adev: amdgpu_device pointer
  * @bo_va: requested BO and VM object
  * @clear: if true clear the entries
- * @table_freed: return true if page table is freed
  *
  * Fill in the page table entries for @bo_va.
  *
@@ -1007,7 +1001,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
  * 0 for success, -EINVAL for failure.
  */
 int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
-			bool clear, bool *table_freed)
+			bool clear)
 {
 	struct amdgpu_bo *bo = bo_va-&gt;base.bo;
 	struct amdgpu_vm *vm = bo_va-&gt;base.vm;
@@ -1086,7 +1080,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 						resv, mapping-&gt;start,
 						mapping-&gt;last, update_flags,
 						mapping-&gt;offset, mem,
-						pages_addr, last_update, table_freed);
+						pages_addr, last_update);
 		if (r)
 			return r;
 	}
@@ -1280,7 +1274,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, false,
 						resv, mapping-&gt;start,
 						mapping-&gt;last, init_pte_value,
-						0, NULL, NULL, &amp;f, NULL);
+						0, NULL, NULL, &amp;f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -1322,7 +1316,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 
 	list_for_each_entry_safe(bo_va, tmp, &amp;vm-&gt;moved, base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
 	}
@@ -1341,7 +1335,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		else
 			clear = true;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, clear, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, clear);
 		if (r)
 			return r;
 
@@ -2525,8 +2519,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, NULL, addr,
-					addr, flags, value, NULL, NULL, NULL,
-					NULL);
+					addr, flags, value, NULL, NULL, NULL);
 	if (r)
 		goto error_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 38a1eab1ff74..6b7682fe84f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -410,10 +410,10 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				uint64_t flags, uint64_t offset,
 				struct ttm_resource *res,
 				dma_addr_t *pages_addr,
-				struct dma_fence **fence, bool *free_table);
+				struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
-			bool clear, bool *table_freed);
+			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
 void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 			     struct amdgpu_bo *bo, bool evicted);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 509d915cbe69..1cb0d811dde0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1190,7 +1190,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, true, NULL,
 					   start, last, init_pte_value, 0,
-					   NULL, NULL, fence, NULL);
+					   NULL, NULL, fence);
 }
 
 static int
@@ -1283,8 +1283,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 						prange-&gt;start + i, pte_flags,
 						last_start - prange-&gt;start,
 						NULL, dma_addr,
-						&amp;vm-&gt;last_update,
-						&amp;table_freed);
+						&amp;vm-&gt;last_update);
 
 		for (j = last_start - prange-&gt;start; j &lt;= i; j++)
 			dma_addr[j] |= last_domain;
</pre>
    </blockquote>
    <p>You already pointed out this bug, to flush TLB after waiting for
      vm update done. The below fix can be merged to this patch.</p>
    <p>SVM is missing one optimization for mGPUs (Felix pointer out this
      before), add fence of mGPUs to a sync, then wait for sync, instead
      of waiting for fence of each GPU. This can be added later.<br>
    </p>
    <p>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c</p>
    +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
    @@ -1243,7 +1243,6 @@ svm_range_map_to_gpu(struct kfd_process_device
    *pdd, struct svm_range *prange,<br>
    &nbsp;{<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = pdd-&gt;dev-&gt;adev;<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm = drm_priv_to_vm(pdd-&gt;drm_priv);<br>
    -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool table_freed = false;<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pte_flags;<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long last_start;<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int last_domain;<br>
    @@ -1305,8 +1304,6 @@ svm_range_map_to_gpu(struct kfd_process_device
    *pdd, struct svm_range *prange,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fence)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *fence = dma_fence_get(vm-&gt;last_update);<br>
    &nbsp;<br>
    -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (table_freed)<br>
    -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);<br>
    &nbsp;out:<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
    &nbsp;}<br>
    @@ -1362,6 +1359,8 @@ svm_range_map_to_gpus(struct svm_range
    *prange, unsigned long offset,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
    +<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
    &nbsp;<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
    <br>
  </body>
</html>
