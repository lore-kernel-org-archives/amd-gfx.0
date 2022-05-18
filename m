Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434E9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 18:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AAD710E264;
	Wed, 18 May 2022 18:36:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 222E010E229
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 18:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOzzK5CTKmyvKURwaj28XU9UK/JzWhsth6/x+tz0RzSxJuKd6gOvdX5Em9JDQpXz7NXUwhRjrLgEdp3uzYoDToHQ7fUG425umJivuAb/4qVs7HIk7VSxOodm8aPY3Q0l0cJUPF4SX4ZG+Hj3L0m+Pr/3gf7A0PTTCgVkWxBvz+6S0t/BX4Uj8caUjoPIhfOdKxGcjkdFeprqkj8cSEX5LjIbpOHRmFLLGNAg2fZqgeTJxeBTys1VaUcZco0PypUjRPXblXhCWXrqWVGVRcQbG71xh0I4qJTc3vcYyQBdCWpE0ZlJUNCFHxUeXYW1GoX9WJQu/B1B9qg4aBWpciKvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvzLS4IEB8gecrzA57SlrOI2GT1Pw0H9Hab1Nz1aC8k=;
 b=kqQTf8GIFiOcgJNRquQouQxlu6aSEtEP/c4m3WY7/i/EXIOaS46Lzz77sxnahD5X3WST6ef7FXrFyPSYsbLWJPgWDNUVs2paResf3I+4ot1ShmOht3obu6BF5tc8ImN8SRMYDiDNVb/8ETRK4FJChehEzkKcWf9G2+eaFYFx5oGpm0+/GfHoPGwfo5pnGPaCK+3cuirCzUlhOYKU6+fyjE6BbYmO370DHBilBnnEKTFtzNa99Ps3L+t6tWjYhJytFJ4t9byN0IKbVi2ghfEUrbSSRU6HYvX1LdgGg1Cspb+vt87O41nauY7hn5JzYW/sH5Kgsh4QE9powhiCQ2wUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvzLS4IEB8gecrzA57SlrOI2GT1Pw0H9Hab1Nz1aC8k=;
 b=ZZl8FV/mH7Juna1tqzTSeBTI9wUal7AJVMnvYzqmDVzhYHtL3mw0U2yjrZwkIXszlE2Cc3AFJS71zmJV39RMvWvrjgYyw6tM2hOYXkqpEZRhcftNP6pTSwt4s2SYUy6Izh8d90oHpopgYPLB5CYKlO1QKTYbuXZqykXTLyA57Uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 18:36:43 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%8]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 18:36:42 +0000
Message-ID: <e225fdde-d11a-2d83-c129-393f7284a6d2@amd.com>
Date: Wed, 18 May 2022 14:36:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220517231108.14048-1-alex.sierra@amd.com>
 <20220517231108.14048-2-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220517231108.14048-2-alex.sierra@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9eceb51-1530-4fe8-c747-08da38fd5aaf
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4431E9F01D1A11DB9A0357A2E6D19@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbIhlyQYf7ytJ29EI0w7L+mD4RXEPdAvBwxqmvxN4J5Ofus4+j82PaaYBn3q6veZde6k8aly/34pAb4kKfvRNycX0DZ0hA9WBLJfdNsoacm64mUQoN7ZIFjq9QVFyVC3f79KLBjwb+SjWrokEKmdCJ8XY1F/iKbSfs9/LC6BgONpxtEYWzRa6S6W8/eeMgTGgX3GLdtCFN2dMvgVQ6RUz641prSbqSANbJ6kmQPvlb6O5ZT7aAf4gDLNsfSoJQnLJ+WCnNMfvUIxha5LYelRNtUWEGwwHAFDyMJ5zCPIcV1EXzxJ+pIRIV0nm/T+WovQbhqDt76kIckRYW9SNFB0Jil0d+Ti+afLwmOA26ceV06nvM7B/lbhHSiBXIjc6dFjArpxqzZd+NfQ/nNaxUNoiV8pOAelEpsbTzrrAHAqeml0GJVPujQ9lerOKbDwTh1AWE6pSe4NTjKgZ0waM656NFWzkVELorzypxEoyPXhTph+8XYy55A7bEgDFcl+I6SBS5plL31blop1ZyoUi/w74CRBtDmtwOcgqyKNdilNlK3E5dTxrj2luX5Y7/9oTnY2Yb3YXs1MDIPLroxSIVGRiiJQCdS0WnL6hFuk2OMulo9TILOZm2zquUKB01/qcV6CFkUuWIZc3MchIJ01jnDcTDP75o7STETBRY/x79I2WDL6hfWXKH1H3RrbtQPliioGQ/IjLt4wVQvdUzxWkWUZynvJKNpVIdGNBLeyljZOnOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(66556008)(31686004)(316002)(8676002)(36756003)(38100700002)(83380400001)(66476007)(66946007)(508600001)(6512007)(2616005)(186003)(5660300002)(31696002)(26005)(2906002)(8936002)(53546011)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW8vc2ZBdWRzS1V5dHBTNm8rbWowZzJLaTVuTWlxemZLb1R1Nmg2d2NlWUxE?=
 =?utf-8?B?amRxaFFlbG96QzBmSnpZVngvWWNxSi9xdkFKaFdhSUtGb3ZKNTNRUWdMejFX?=
 =?utf-8?B?cEVwdU5YZmhmZDdaaWRtSHFSMXBjTkkwN0tpZTkrRis1eCtKdDhiS3ZPM3BZ?=
 =?utf-8?B?UXIyZFAvZGpDMVoxTWdUcTdiUFlMb2dOUW8zWVgzNFAxanNYZ1hmWks4Y2Q5?=
 =?utf-8?B?bHhzTE0xWmJnY2dxMUhVVkQ4SUNCRGs4aDJJc2UrZnozUFFIbjhUR2hHaGdj?=
 =?utf-8?B?NzFPR1diQ1g3RVlNZmxWd1F1OXJ5aXVBVEZtSzlsTHNrdjBTMUhTSk5SRHpH?=
 =?utf-8?B?cmdHQVRZdDhlbDQza1hSRW5Nak1zSkFtUTBTUUdYTXJUTnJ6RjVIRUV1QitN?=
 =?utf-8?B?YmFLQ0R4VkZmMGVYeDNJeFMvRmx6NTBaMXc0M1dlWXZQM1ZhRWRwRmNWRktW?=
 =?utf-8?B?em1Cd2pCaVJPWEtqZEFjTzNIazZRRS9NZmRSQmZldXZoSEhsWGVYNFdmYVhs?=
 =?utf-8?B?T0ZBMWxzNm9FYjUxNjMwZTN0dEZkcThsRUk1MVNWRElBQkh1UzdiODVtUGxR?=
 =?utf-8?B?bEFVNW1CaEh2bjJsL1ZmVW9GanpJVXp5dHZWRk94Z0JiY294T0NpSzZyc01L?=
 =?utf-8?B?Q3grbjN1SHQ5VU1lcER2dXlSYTJPOGJvNlQ5ZUEyMUhXNTk2NklKcXZCRjAx?=
 =?utf-8?B?TjdBUFdtV1RMZmhINElGSVhHMHVncGJnMVRKbzFCd1BnYmp3WjlNS1pMbVpF?=
 =?utf-8?B?UlRMeXlPTGt3Tzk5R3JQdWo2RzhuSEYvSm1UVThjTEY0MnE3cExGUTFvZlBD?=
 =?utf-8?B?QUxabzZraEJ4L1VzaHVGVVlvWElmaFBaTjMvSld2NXdXTnE1aDdFcWs1VkJD?=
 =?utf-8?B?R2lkYkpBY3Y1YnZIalU3dTR1ME90K2NVRWxsS3pyL092WmJXQXJIUmJVRHEx?=
 =?utf-8?B?Y21tQkhVWWFWRExKR2pnY3NTUXlSaGovVDZNeStuR1Z0YVU1L201aEpTd2t2?=
 =?utf-8?B?NHUxWGtuMUJzbGdaaGp4M2RxZmIvVGF0KzZzZDF6RXlRZHdhYndDVGxLM1do?=
 =?utf-8?B?ZDkwWWFDd3ppaFlZMlhLME5kWnc5dXVlV3JKWklmUW1DcFVCL1JyMnBkVmxQ?=
 =?utf-8?B?UG84WVFPdzA0RHdtTkRBT09HVXJYellxTnR6RTRjelY2L21IRmpjditzMGR6?=
 =?utf-8?B?a2JxYXIzbWErZldqVFgvcmZkN3hyN3c1RzZTck04MWRHMGlHUTI1bVlJaGEz?=
 =?utf-8?B?VDdPNmFLd0lWVkdrY0lBakxHcExXTjJnSzF0Z29VWUdxZTZoRXJrUlNqWm9z?=
 =?utf-8?B?NExOdThWaVI4VjlMU3Blc2J5WUFCbks1WlZaWjRJZjdJTHE1ZWo3bjQ1K1Uz?=
 =?utf-8?B?VU1UM1J0bHpGOG9WRUpqbnF6RFlaRkREL1YxVTY4ZVhybHhRY01aNGNNSWNq?=
 =?utf-8?B?aFhkcTVOdXB2cjB2TDlSelpKKzg5VzhDdlpvOGZ2eDJkbUxHcnZLbjJRcFdG?=
 =?utf-8?B?cUpLdlliTFRWemhqL2VSS3c1Smd5SWFDZ25BN0xuSVpHWDBXVVRZVm5Dc3hB?=
 =?utf-8?B?ZTZzbHNBYWM1V0h0ZHNtckZsaDZHY3d2cG9ySW9wd1h4aE1TVklDRnhwOVJz?=
 =?utf-8?B?eTE1L0RvTFZ5VXNyS2lnSkdDMFIxYzZ1YmJsMWVTbUFaenpGTkNPQm05Vm82?=
 =?utf-8?B?Y3JTLzgyT3k5Z2tpMzU3d3c2UnBlby8rTTY5NEg1cXVYbk1JdnpXUUZWWGhU?=
 =?utf-8?B?YmxiR0ZydG1MbXV3OFdxVkFlTkdiVEhKQlJqTFRoUGFqYUVBVTZNa0J3UlRR?=
 =?utf-8?B?aTd5bjdFblNvUDFCUWJwb3FnejZLYXZiZm9BejYyUWJROU9KOTZHN3ZJM1kz?=
 =?utf-8?B?dDFLcUhpZGF3NW5TbEFuQWI4UWx3MVJGNXgyTXoxVkFEb0UwSlljVVdzei96?=
 =?utf-8?B?WGFkZEpHOTUxSExtYnN4cVg5OWRPaFlvOXd0ckUrendwa0xoSUtEMUFTN3Fu?=
 =?utf-8?B?TXoxOVlUa1laV1JNSGsxQkE0RUNMc2IwWWxxbkI5OC9ieUR1Y0hFNDR6RmEy?=
 =?utf-8?B?TWEyQVF6LytxUExtTWdueHF0bVRKeWo1ZEp5SFFrRmhtZzZSQnJVdVV3Skp2?=
 =?utf-8?B?cGhYSGtMeHFab29kMlM1OUhkdUlOR1JKbmJPNTNqMEZaSERoUkpSb056UklF?=
 =?utf-8?B?amJGTW5HaGZBbzZzSzdCSjNXLzIrSko3dDdMVmJ6RzFpU2xIaGJGVkdObmRm?=
 =?utf-8?B?eXU2QVl5RVRFeHh4SmpUTmVRNTRGc2hmNVNwb1JVT1U0YmVaaXpRZGZCY0ly?=
 =?utf-8?B?Vm1TMDEranNlQWVCdW45VWpXVDNIMGtUTEhHYTdkNVZ4TXdkM1BoUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9eceb51-1530-4fe8-c747-08da38fd5aaf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 18:36:42.8988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrYAKfXhAqzpgydYPnhrUPdOo6EmYA+M2wETrjMWH2sMvAqTiLXvP2zu/7i0AXGG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
    <div class="moz-cite-prefix">On 2022-05-17 19:11, Alex Sierra wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220517231108.14048-2-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">[WHY]
Unified memory with xnack off should be tracked, as userptr mappings
and legacy allocations do. To avoid oversuscribe system memory when
xnack off.
[How]
Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
API and call them on every prange creation and free.

Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 24 +++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 34 ++++++++++++++-----
 3 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..f55f34af6480 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -301,6 +301,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
+int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
+		uint64_t size, u32 alloc_flag);
+void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
+		uint64_t size, u32 alloc_flag);
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e985cf9c7ec0..b2236159ff39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -122,7 +122,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  *
  * Return: returns -ENOMEM in case of error, ZERO otherwise
  */
-static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
+int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	uint64_t reserved_for_pt =
@@ -157,8 +157,8 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	     kfd_mem_limit.max_system_mem_limit &amp;&amp; !no_system_mem_limit) ||
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed &gt;
 	     kfd_mem_limit.max_ttm_mem_limit) ||
-	    (adev-&gt;kfd.vram_used + vram_needed &gt;
-	     adev-&gt;gmc.real_vram_size - reserved_for_pt)) {
+	    (adev &amp;&amp; (adev-&gt;kfd.vram_used + vram_needed &gt;
+	     adev-&gt;gmc.real_vram_size - reserved_for_pt))) {
 		ret = -ENOMEM;
 		goto release;
 	}
@@ -166,7 +166,8 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	/* Update memory accounting by decreasing available system
 	 * memory, TTM memory and GPU memory as computed above
 	 */
-	adev-&gt;kfd.vram_used += vram_needed;
+	if (adev)
+		adev-&gt;kfd.vram_used += vram_needed;
 	kfd_mem_limit.system_mem_used += system_mem_needed;
 	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
 
@@ -175,7 +176,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	return ret;
 }
 
-static void unreserve_mem_limit(struct amdgpu_device *adev,
+void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	spin_lock(&amp;kfd_mem_limit.mem_limit_lock);
@@ -184,7 +185,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		kfd_mem_limit.system_mem_used -= size;
 		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		adev-&gt;kfd.vram_used -= size;
+		if (adev)
+			adev-&gt;kfd.vram_used -= size;
 	} else if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= size;
 	} else if (!(alloc_flag &amp;
@@ -193,9 +195,9 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		pr_err(&quot;%s: Invalid BO type %#x\n&quot;, __func__, alloc_flag);
 		goto release;
 	}
-
-	WARN_ONCE(adev-&gt;kfd.vram_used &lt; 0,
-		  &quot;KFD VRAM memory accounting unbalanced&quot;);
+	if (adev)
+		WARN_ONCE(adev-&gt;kfd.vram_used &lt; 0,
+			&quot;KFD VRAM memory accounting unbalanced&quot;);
 	WARN_ONCE(kfd_mem_limit.ttm_mem_used &lt; 0,
 		  &quot;KFD TTM memory accounting unbalanced&quot;);
 	WARN_ONCE(kfd_mem_limit.system_mem_used &lt; 0,
@@ -211,7 +213,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	u32 alloc_flags = bo-&gt;kfd_bo-&gt;alloc_flags;
 	u64 size = amdgpu_bo_size(bo);
 
-	unreserve_mem_limit(adev, size, alloc_flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
 
 	kfree(bo-&gt;kfd_bo);
 }
@@ -1601,7 +1603,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	unreserve_mem_limit(adev, size, flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
 err_reserve_limit:
 	mutex_destroy(&amp;(*mem)-&gt;lock);
 	if (gobj)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5ed8d9b549a4..e7e9b388fea4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -261,11 +261,21 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
 
 static void svm_range_free(struct svm_range *prange)
 {
+	uint64_t size = (prange-&gt;last - prange-&gt;start + 1) &lt;&lt; PAGE_SHIFT;
+	struct kfd_process *p;
+
 	pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx]\n&quot;, prange-&gt;svms, prange,
 		 prange-&gt;start, prange-&gt;last);
 
 	svm_range_vram_node_free(prange);
 	svm_range_free_dma_mappings(prange);
+
+	p = container_of(prange-&gt;svms, struct kfd_process, svms);
+	if (!p-&gt;xnack_enabled) {
+		pr_debug(&quot;unreserve mem limit: %lld\n&quot;, size);
+		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+	}
 	mutex_destroy(&amp;prange-&gt;lock);
 	mutex_destroy(&amp;prange-&gt;migrate_mutex);
 	kfree(prange);
@@ -284,7 +294,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
 
 static struct
 svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
-			 uint64_t last)
+			 uint64_t last, bool is_new_alloc)
 {
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
@@ -293,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
 	if (!prange)
 		return NULL;
+
+	p = container_of(svms, struct kfd_process, svms);
+	if (!p-&gt;xnack_enabled &amp;&amp; is_new_alloc &amp;&amp;
+	    amdgpu_amdkfd_reserve_mem_limit(NULL, size &lt;&lt; PAGE_SHIFT,
+					    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {</pre>
    </blockquote>
    The range will create svm_bo to migrate to VRAM, so count acc_size
    is correct.<br>
    <blockquote type="cite" cite="mid:20220517231108.14048-2-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		pr_err(&quot;Failed to allocate usrptr memory\n&quot;);
+		kfree(prange);
+		return NULL;
+	}
 	prange-&gt;npages = size;
 	prange-&gt;svms = svms;
 	prange-&gt;start = start;
@@ -307,7 +326,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	mutex_init(&amp;prange-&gt;migrate_mutex);
 	mutex_init(&amp;prange-&gt;lock);
 
-	p = container_of(svms, struct kfd_process, svms);
 	if (p-&gt;xnack_enabled)
 		bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,
 			    MAX_GPU_INSTANCE);
@@ -1000,9 +1018,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 
 	svms = prange-&gt;svms;
 	if (old_start == start)
-		*new = svm_range_new(svms, last + 1, old_last);
+		*new = svm_range_new(svms, last + 1, old_last, false);
 	else
-		*new = svm_range_new(svms, old_start, start - 1);
+		*new = svm_range_new(svms, old_start, start - 1, false);
 	if (!*new)
 		return -ENOMEM;
 
@@ -1825,7 +1843,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 {
 	struct svm_range *new;
 
-	new = svm_range_new(old-&gt;svms, old-&gt;start, old-&gt;last);
+	new = svm_range_new(old-&gt;svms, old-&gt;start, old-&gt;last, true);</pre>
    </blockquote>
    <p>clone prange is not new memory allocation, use false.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20220517231108.14048-2-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	if (!new)
 		return NULL;
 
@@ -1951,7 +1969,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 		/* insert a new node if needed */
 		if (node-&gt;start &gt; start) {
-			prange = svm_range_new(svms, start, node-&gt;start - 1);
+			prange = svm_range_new(svms, start, node-&gt;start - 1, true);</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20220517231108.14048-2-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
 			if (!prange) {
 				r = -ENOMEM;
 				goto out;
@@ -1967,7 +1985,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	/* add a final range at the end if needed */
 	if (start &lt;= last) {
-		prange = svm_range_new(svms, start, last);
+		prange = svm_range_new(svms, start, last, true);
 		if (!prange) {
 			r = -ENOMEM;
 			goto out;
@@ -2585,7 +2603,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		last = addr;
 	}
 
-	prange = svm_range_new(&amp;p-&gt;svms, start, last);
+	prange = svm_range_new(&amp;p-&gt;svms, start, last, true);
 	if (!prange) {
 		pr_debug(&quot;Failed to create prange in address [0x%llx]\n&quot;, addr);
 		return NULL;
</pre>
    </blockquote>
  </body>
</html>
