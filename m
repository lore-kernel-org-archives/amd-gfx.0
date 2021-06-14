Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB4C48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 11:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819216109E
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 11:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819216109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3933989E1D;
	Mon, 14 Jun 2021 11:10:56 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11F689E1D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 11:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBECqJC+8Dm0Db53zCCDFrVVZe4TrNqXYwNqPJGP6iAK780rFTVtbzSBM2IjaLH6aSGJbD3moNBjNjXZzfisflFp3vsJGc8KXluxNJH6qz4dKFnwAeEKA7JLwYNNL+x7Ou7J4T5uTstGjn3wFM4wHwSB7cFtiT9CTjDWcCBTkbqwuhSYB6tlF96PwH2iET87kV7SeZuNGc/N7PFX7uhEVgRKieg6RcJxyZ+6ZdRKwA5F/aIjwK0i1sm2REaSmzvXr0yJI+Awri9Q+BlUDbTuTyNvRezg2kEg5oEloxIPIkvFjHFGcgIuTXg8h6pS2tcpIdrfWxmU6GXPPUGBQ4XQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOwrJD0tjC4FeiLduPbuwXn7K2xL8aVyn2WG0pGFv7M=;
 b=nxFFQHZFlbqA+u5Jzbt2ELpSjUAOhLOP846+Nv6CRND6wvKHLpYKm1ylh/Md40psuE+MIsyZJQjXQsfihZMWr45b6vAozeN3kY8a5cuQ7mlpXWgLh0P9sb4TqWJvoYqg/DwcJA67KkJR5g8CbIxK+fx906CGacj0h4zZIz16R1ZFZRlgoaDxKsmjFFAjCWDf2uFmBxRGiSitSjqpqIcuj+hBh2mcH18JlA5HQiJTL2SBc1rrpadMQ6EB59pHn3XNahlk/3Si96iCnRA1ycbVyrq5/tQEpM0kmR7ywD/pnidv8ecrHVsUC75QBL+4Pgm2H29nXKHBd00dOddHT5oGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOwrJD0tjC4FeiLduPbuwXn7K2xL8aVyn2WG0pGFv7M=;
 b=A6MWUWDpIYaQSWQbRwcqW4aRNG7LEwno6vbkvFiZqxNtjQo6RHMzI6RuKwviaa1oPM0Kq1colw377d4kqx7BICwybjkAjpWJpMlba17Y/KtbglPQ7Z8gJAZ8PJnUTivTF5zSlvnUyd3VHxDwK93aoGQ5lyNynGymnsRjMdwgEHA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5053.namprd12.prod.outlook.com (2603:10b6:5:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 11:10:52 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 11:10:52 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: remove amdgpu_vm_pt
To: amd-gfx@lists.freedesktop.org
References: <20210610172412.4113-1-nirmoy.das@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <38b4fb1f-08fb-3284-1dbe-107d710ea7d3@amd.com>
Date: Mon, 14 Jun 2021 13:10:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210610172412.4113-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.72.6]
X-ClientProxiedBy: AM0PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:208:1::30) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM0PR04CA0053.eurprd04.prod.outlook.com (2603:10a6:208:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 11:10:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca6be3a-a9e5-43b6-a2f9-08d92f2512a1
X-MS-TrafficTypeDiagnostic: DM4PR12MB5053:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB505375647E615A624BF7F1DE8B319@DM4PR12MB5053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:59;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyoYLl7vZB41yLXZaD2lw36qWQCxNajyqmlDivly9hgWiXO4CQiSR0bPgFQiA8eVU/F7/c6c9FndOUFc1M0FwureqPrG/BDQ0EmvOsrbFWSusPnCrTm6LzWr11Cwca2CApwa0z6qUkcm2cq+d/xMjxO57D6DVGXjQSbPjElc4jESj3hJli2HfkGMDckfVJMXM8/VhZl6KnHdD3FiY5LDa/j9/rVQEdiGW2tomUhDESWvDZYshpgan5AkiL/sKJSGWTcHJpDnhIKHBaTHSiALsL5NTTJOwiwvM7yOJBK7ttCwkSA5PpI7v4CsZGoU0iR3ShVmTpFjziHbCEJQ5FZbWk4C+GLQV+/Z1E5L/I8Zo+RkFkxFvko1OvSoAAWZWhet6O1nthQPWWptYDfYZRMT/6rdqXQD3jzwzJqZdTozCr7teYc/qP/+7pbTet02DARJza3xHx8x5chqobbwX5pOg/9I+1WPZdDY5ds+b00//gL7Ur26pPZfe6tDtEklH/soYBqmgZoXiofa0S840ftG4Z1Jfp112BVo/0QebTfxHvoSxf9NdVbZV5jXrsIl1hAjfeU9tamHeCH9x6TGFE/HEMrQg7FNdt5y/3nl1YDiGQD2buqrgCbVpj+5LAKJsNIdYxAo8CkR2mvzbp46TmV4h8Hs6euoOkSCk/em4YJeYX9DtOM+/10JoHeIryhx2vKzxMkE9GUd4fPzVDWBTnZ6np+kEuFnmQvDcLbINHsYSPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(2616005)(30864003)(38350700002)(6486002)(16576012)(4326008)(38100700002)(956004)(316002)(6916009)(86362001)(53546011)(8676002)(2906002)(36756003)(66946007)(52116002)(83380400001)(186003)(478600001)(26005)(31696002)(31686004)(8936002)(5660300002)(66556008)(6666004)(66476007)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1Bvekd4RXJneHZRaWZKRHZvQlJCaFExM1p0eXFMZERNMXhONFdRenlucFFU?=
 =?utf-8?B?Qit4M2ZJU1NVRXgxWCtGL015MTVNSjg5akhmcnhaZkYyUTlYeHlBWTFOSE5E?=
 =?utf-8?B?TFpXTnBhNk5ISVR1MzV0dFpSWko2cElLR1I5VU1lVkhBQWdxS1VKM213ZVlj?=
 =?utf-8?B?bEMxN3dtRy9VcnJQK3NsejMvK2ZoOTR4SjBuaGZZY094bEFvTUhSSWtmOXQr?=
 =?utf-8?B?cFQ2WnVEYzRQS1djb21wbGpUbnpiY0tzWHo5TTdGOVZJdWQrZUJ0Tk1XblJ2?=
 =?utf-8?B?Wk1yZUk3U2FnV1lXbmEzazcxdlVZeDhIQTgrbkJMWDhHcUpKcjY3bVQrUk1l?=
 =?utf-8?B?T3FldzJGOVlVLzc4dTErRi9jOVA5VVZCTmd1cG1UMGRGQURWNFY0SlRxdEcy?=
 =?utf-8?B?djVVdVdPT2JBVW1JRGdpcFdrc2VmUVVDMGFQWHVRek5UbTVuaHh4bFpzL1pW?=
 =?utf-8?B?UGV3V3RhRnkwWEJNS3M2RnZoMTEvaDBLckp3alBFR055NDhwSXJxT2VyTlA0?=
 =?utf-8?B?dXhESXArTWlaSEJvajdkbTZ1c3o5UnpUd00yVHovL2FvRW1JVDFaSm50Ly9D?=
 =?utf-8?B?VW83NDI4MTVFVncxOUpZRXpGaHlHQUtRZEJxRDBwOEw1NFVBb2Z4dm1JT2NL?=
 =?utf-8?B?c0JCSDFiTXRuZnNVc25lcmM2UCsxaDZHQ3pBdEtlNUZMNWZuVWJ5YlhBRmlY?=
 =?utf-8?B?NHdaMG9DdDc2UURLY1hRZVhMMG5yU2NIZ2ZKQk1FaThUNVdDTTY5Q0Z4WU5o?=
 =?utf-8?B?MU15eHhUY290alZnY3JmL1d1VTVPcnpkWUZlV05XTjkwaTg3YzVjL2NmcmJV?=
 =?utf-8?B?Ry9sTDB0UmYvbGg2WlV2eGM5dHJwSkp5WHNDVXVpTHBZaWNJTTI0OE42NW4v?=
 =?utf-8?B?ZHhjQzJYUkovSnhiaHZzaS9uRHAyTEpsQkpiZmxYb1FkUXJLUlNoZFp1alhM?=
 =?utf-8?B?cDFPRE8xQlNJalFMME44ZDZYblJmS0JwKzlBUHVkOTUzMkxwQ1NMZUZKWHB4?=
 =?utf-8?B?Uk1hOXVaMlNsdXdFTFJWaE9sTW45WWV2ZWtGVVo4M08yTmhkQ0FHSlBLU1pr?=
 =?utf-8?B?cWFtdnFLKzIweDc2clMzRFUvR3NkSFQydThTSmNITmhHSXY5dnJCS3lWN0JS?=
 =?utf-8?B?NnBlVC9jTXUxcEhXc0JoSnZ2Q3pzK3doRmVEeWJIMHZxa0NNa1BQTWtQT0kw?=
 =?utf-8?B?eThrQ3JuQzdlQiswQW5DZ1F0UVI5SEN4NnBmNnNPV2p1YVd4MEpLdTN6dEYx?=
 =?utf-8?B?VmVsL3pBbGRReVpSY3ovdnl2NHVJTVB3elNlQTBNTDRPdmZqNFB0SjA5K2dJ?=
 =?utf-8?B?T1hqSzczcURUekQyQUh3eE45SzBlRGVPd1pzaktMVlhYbHRWeDhta05jMHRu?=
 =?utf-8?B?VHNacTRSRTA4RlovVW1sZU5qVFp2VEowRXhLYXhDOTN3ejN0TTJHMWhackJB?=
 =?utf-8?B?T0p2SUJDQi9sSVpkWWVpb3VmcFJKVkhjWmpIWjc4L0UwTU1QalFtQjE3M2Fk?=
 =?utf-8?B?b052bzZSYzJPaVBNV0JRZ2gwYlhsUHB4MVBkSzE0NDk0a0NSdUFTVGkwclRu?=
 =?utf-8?B?c0p6WUphVnlwVVNHdjJtLy9LckpNNDZSZms1UlBnQzBZMzBHR1lXejN6Lzll?=
 =?utf-8?B?SnYraC91cE1oeVhvdHRRZnFTSjBIU3lHZXhPRm9ZeHZwOGpRVVRKTFluL3E2?=
 =?utf-8?B?S25maWtudWNqbW9wWFdtWlpnMlptK0JHSCtvS09mY0s2bm4xSXBxNkJvS1pa?=
 =?utf-8?Q?ck+hXGZ0w6FJgeN8yw4A5f0P3CGOnJuj+gtlZfe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca6be3a-a9e5-43b6-a2f9-08d92f2512a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 11:10:52.5222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOOSxh/z9mvM2FBOdFZYYctKkl0xVmyw1vH+NK3XRtwM2T8uz77RXsfKHykeLbtL5V99vB4Ya8FInX3OEeXvag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5053
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
Cc: Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping.

On 6/10/2021 7:24 PM, Nirmoy Das wrote:
> Page table entries are now in embedded in VM BO, so
> we do not need struct amdgpu_vm_pt. This patch replaces
> struct amdgpu_vm_pt with struct amdgpu_vm_bo_base.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  26 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 164 ++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   9 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   2 +-
>   12 files changed, 105 insertions(+), 126 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index fb6bcc386de1..f96598279593 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -356,7 +356,7 @@ static int amdgpu_amdkfd_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
>    */
>   static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
>   {
> -	struct amdgpu_bo *pd = vm->root.base.bo;
> +	struct amdgpu_bo *pd = vm->root.bo;
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
>   	int ret;
>   
> @@ -372,7 +372,7 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
>   		return ret;
>   	}
>   
> -	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.base.bo);
> +	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
>   
>   	if (vm->use_cpu_for_update) {
>   		ret = amdgpu_bo_kmap(pd, NULL);
> @@ -387,7 +387,7 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
>   
>   static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
>   {
> -	struct amdgpu_bo *pd = vm->root.base.bo;
> +	struct amdgpu_bo *pd = vm->root.bo;
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
>   	int ret;
>   
> @@ -1153,7 +1153,7 @@ static int process_sync_pds_resv(struct amdkfd_process_info *process_info,
>   
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			    vm_list_node) {
> -		struct amdgpu_bo *pd = peer_vm->root.base.bo;
> +		struct amdgpu_bo *pd = peer_vm->root.bo;
>   
>   		ret = amdgpu_sync_resv(NULL, sync, pd->tbo.base.resv,
>   				       AMDGPU_SYNC_NE_OWNER,
> @@ -1220,7 +1220,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   	vm->process_info = *process_info;
>   
>   	/* Validate page directory and attach eviction fence */
> -	ret = amdgpu_bo_reserve(vm->root.base.bo, true);
> +	ret = amdgpu_bo_reserve(vm->root.bo, true);
>   	if (ret)
>   		goto reserve_pd_fail;
>   	ret = vm_validate_pt_pd_bos(vm);
> @@ -1228,16 +1228,16 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   		pr_err("validate_pt_pd_bos() failed\n");
>   		goto validate_pd_fail;
>   	}
> -	ret = amdgpu_bo_sync_wait(vm->root.base.bo,
> +	ret = amdgpu_bo_sync_wait(vm->root.bo,
>   				  AMDGPU_FENCE_OWNER_KFD, false);
>   	if (ret)
>   		goto wait_pd_fail;
> -	ret = dma_resv_reserve_shared(vm->root.base.bo->tbo.base.resv, 1);
> +	ret = dma_resv_reserve_shared(vm->root.bo->tbo.base.resv, 1);
>   	if (ret)
>   		goto reserve_shared_fail;
> -	amdgpu_bo_fence(vm->root.base.bo,
> +	amdgpu_bo_fence(vm->root.bo,
>   			&vm->process_info->eviction_fence->base, true);
> -	amdgpu_bo_unreserve(vm->root.base.bo);
> +	amdgpu_bo_unreserve(vm->root.bo);
>   
>   	/* Update process info */
>   	mutex_lock(&vm->process_info->lock);
> @@ -1251,7 +1251,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   reserve_shared_fail:
>   wait_pd_fail:
>   validate_pd_fail:
> -	amdgpu_bo_unreserve(vm->root.base.bo);
> +	amdgpu_bo_unreserve(vm->root.bo);
>   reserve_pd_fail:
>   	vm->process_info = NULL;
>   	if (info) {
> @@ -1306,7 +1306,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   				    struct amdgpu_vm *vm)
>   {
>   	struct amdkfd_process_info *process_info = vm->process_info;
> -	struct amdgpu_bo *pd = vm->root.base.bo;
> +	struct amdgpu_bo *pd = vm->root.bo;
>   
>   	if (!process_info)
>   		return;
> @@ -1362,7 +1362,7 @@ void amdgpu_amdkfd_gpuvm_release_process_vm(struct kgd_dev *kgd, void *drm_priv)
>   uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
>   {
>   	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
> -	struct amdgpu_bo *pd = avm->root.base.bo;
> +	struct amdgpu_bo *pd = avm->root.bo;
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
>   
>   	if (adev->asic_type < CHIP_VEGA10)
> @@ -2389,7 +2389,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   	/* Attach eviction fence to PD / PT BOs */
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			    vm_list_node) {
> -		struct amdgpu_bo *bo = peer_vm->root.base.bo;
> +		struct amdgpu_bo *bo = peer_vm->root.bo;
>   
>   		amdgpu_bo_fence(bo, &process_info->eviction_fence->base, true);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 1476236f5c7c..76fe5b71e35d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -832,7 +832,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   	if (r)
>   		return r;
>   
> -	p->job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.base.bo);
> +	p->job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
>   
>   	if (amdgpu_vm_debug) {
>   		/* Invalidate all BOs to test for userspace bugs */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index a9bbb0034e1e..536005bff24a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1304,11 +1304,11 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>   
>   		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
>   				vm->task_info.pid, vm->task_info.process_name);
> -		r = amdgpu_bo_reserve(vm->root.base.bo, true);
> +		r = amdgpu_bo_reserve(vm->root.bo, true);
>   		if (r)
>   			break;
>   		amdgpu_debugfs_vm_bo_info(vm, m);
> -		amdgpu_bo_unreserve(vm->root.base.bo);
> +		amdgpu_bo_unreserve(vm->root.bo);
>   	}
>   
>   	mutex_unlock(&dev->filelist_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index baa980a477d9..94d4d3256cb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -493,7 +493,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
>   
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>   		struct amdgpu_vm *vm = bo_base->vm;
> -		struct dma_resv *resv = vm->root.base.bo->tbo.base.resv;
> +		struct dma_resv *resv = vm->root.bo->tbo.base.resv;
>   
>   		if (ticket) {
>   			/* When we get an error here it means that somebody
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index dbebbe16e3b3..d94c5419ec25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -69,13 +69,13 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   	dev = PCI_SLOT(adev->pdev->devfn);
>   	fn = PCI_FUNC(adev->pdev->devfn);
>   
> -	ret = amdgpu_bo_reserve(fpriv->vm.root.base.bo, false);
> +	ret = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
>   	if (ret) {
>   		DRM_ERROR("Fail to reserve bo\n");
>   		return;
>   	}
>   	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem, &cpu_mem);
> -	amdgpu_bo_unreserve(fpriv->vm.root.base.bo);
> +	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>   	seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
>   			dev, fn, fpriv->vm.pasid);
>   	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index b7c424291702..65521c8b9b1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -129,7 +129,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   		return -EPERM;
>   
>   	if (abo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID &&
> -	    abo->tbo.base.resv != vm->root.base.bo->tbo.base.resv)
> +	    abo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>   		return -EPERM;
>   
>   	r = amdgpu_bo_reserve(abo, false);
> @@ -265,11 +265,11 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
> -		r = amdgpu_bo_reserve(vm->root.base.bo, false);
> +		r = amdgpu_bo_reserve(vm->root.bo, false);
>   		if (r)
>   			return r;
>   
> -		resv = vm->root.base.bo->tbo.base.resv;
> +		resv = vm->root.bo->tbo.base.resv;
>   	}
>   
>   	initial_domain = (u32)(0xffffffff & args->in.domains);
> @@ -298,9 +298,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   		if (!r) {
>   			struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
>   
> -			abo->parent = amdgpu_bo_ref(vm->root.base.bo);
> +			abo->parent = amdgpu_bo_ref(vm->root.bo);
>   		}
> -		amdgpu_bo_unreserve(vm->root.base.bo);
> +		amdgpu_bo_unreserve(vm->root.bo);
>   	}
>   	if (r)
>   		return r;
> @@ -787,7 +787,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   		}
>   		for (base = robj->vm_bo; base; base = base->next)
>   			if (amdgpu_xgmi_same_hive(amdgpu_ttm_adev(robj->tbo.bdev),
> -				amdgpu_ttm_adev(base->vm->root.base.bo->tbo.bdev))) {
> +				amdgpu_ttm_adev(base->vm->root.bo->tbo.bdev))) {
>   				r = -EINVAL;
>   				amdgpu_bo_unreserve(robj);
>   				goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 131ae2a17abf..cbb932f97355 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1261,7 +1261,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   	}
>   
>   	pasid = fpriv->vm.pasid;
> -	pd = amdgpu_bo_ref(fpriv->vm.root.base.bo);
> +	pd = amdgpu_bo_ref(fpriv->vm.root.bo);
>   
>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>   	amdgpu_vm_fini(adev, &fpriv->vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index fa75251148be..e36b84516b4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -126,7 +126,7 @@ struct amdgpu_bo_user {
>   struct amdgpu_bo_vm {
>   	struct amdgpu_bo		bo;
>   	struct amdgpu_bo		*shadow;
> -	struct amdgpu_vm_pt             entries[];
> +	struct amdgpu_vm_bo_base        entries[];
>   };
>   
>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3b6c0b48d0b1..7cddddd77ae2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -331,7 +331,7 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	base->next = bo->vm_bo;
>   	bo->vm_bo = base;
>   
> -	if (bo->tbo.base.resv != vm->root.base.bo->tbo.base.resv)
> +	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>   		return;
>   
>   	vm->bulk_moveable = false;
> @@ -360,14 +360,14 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>    * Helper to get the parent entry for the child page table. NULL if we are at
>    * the root page directory.
>    */
> -static struct amdgpu_vm_pt *amdgpu_vm_pt_parent(struct amdgpu_vm_pt *pt)
> +static struct amdgpu_vm_bo_base *amdgpu_vm_pt_parent(struct amdgpu_vm_bo_base *pt)
>   {
> -	struct amdgpu_bo *parent = pt->base.bo->parent;
> +	struct amdgpu_bo *parent = pt->bo->parent;
>   
>   	if (!parent)
>   		return NULL;
>   
> -	return container_of(parent->vm_bo, struct amdgpu_vm_pt, base);
> +	return parent->vm_bo;
>   }
>   
>   /*
> @@ -375,8 +375,8 @@ static struct amdgpu_vm_pt *amdgpu_vm_pt_parent(struct amdgpu_vm_pt *pt)
>    */
>   struct amdgpu_vm_pt_cursor {
>   	uint64_t pfn;
> -	struct amdgpu_vm_pt *parent;
> -	struct amdgpu_vm_pt *entry;
> +	struct amdgpu_vm_bo_base *parent;
> +	struct amdgpu_vm_bo_base *entry;
>   	unsigned level;
>   };
>   
> @@ -415,17 +415,17 @@ static bool amdgpu_vm_pt_descendant(struct amdgpu_device *adev,
>   {
>   	unsigned mask, shift, idx;
>   
> -	if (!cursor->entry->entries)
> +	if (!(cursor->level < AMDGPU_VM_PTB) || !cursor->entry ||
> +	    !cursor->entry->bo)
>   		return false;
>   
> -	BUG_ON(!cursor->entry->base.bo);
>   	mask = amdgpu_vm_entries_mask(adev, cursor->level);
>   	shift = amdgpu_vm_level_shift(adev, cursor->level);
>   
>   	++cursor->level;
>   	idx = (cursor->pfn >> shift) & mask;
>   	cursor->parent = cursor->entry;
> -	cursor->entry = &cursor->entry->entries[idx];
> +	cursor->entry = &to_amdgpu_bo_vm(cursor->entry->bo)->entries[idx];
>   	return true;
>   }
>   
> @@ -452,7 +452,7 @@ static bool amdgpu_vm_pt_sibling(struct amdgpu_device *adev,
>   	shift = amdgpu_vm_level_shift(adev, cursor->level - 1);
>   	num_entries = amdgpu_vm_num_entries(adev, cursor->level - 1);
>   
> -	if (cursor->entry == &cursor->parent->entries[num_entries - 1])
> +	if (cursor->entry == &to_amdgpu_bo_vm(cursor->parent->bo)->entries[num_entries - 1])
>   		return false;
>   
>   	cursor->pfn += 1ULL << shift;
> @@ -538,7 +538,7 @@ static void amdgpu_vm_pt_first_dfs(struct amdgpu_device *adev,
>    * True when the search should continue, false otherwise.
>    */
>   static bool amdgpu_vm_pt_continue_dfs(struct amdgpu_vm_pt_cursor *start,
> -				      struct amdgpu_vm_pt *entry)
> +				      struct amdgpu_vm_bo_base *entry)
>   {
>   	return entry && (!start || entry != start->entry);
>   }
> @@ -589,7 +589,7 @@ void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
>   			 struct amdgpu_bo_list_entry *entry)
>   {
>   	entry->priority = 0;
> -	entry->tv.bo = &vm->root.base.bo->tbo;
> +	entry->tv.bo = &vm->root.bo->tbo;
>   	/* Two for VM updates, one for TTM and one for the CS job */
>   	entry->tv.num_shared = 4;
>   	entry->user_pages = NULL;
> @@ -621,7 +621,7 @@ void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo)
>   	for (bo_base = abo->vm_bo; bo_base; bo_base = bo_base->next) {
>   		struct amdgpu_vm *vm = bo_base->vm;
>   
> -		if (abo->tbo.base.resv == vm->root.base.bo->tbo.base.resv)
> +		if (abo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>   			vm->bulk_moveable = false;
>   	}
>   
> @@ -779,11 +779,11 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   		entries -= ats_entries;
>   
>   	} else {
> -		struct amdgpu_vm_pt *pt;
> +		struct amdgpu_vm_bo_base *pt;
>   
> -		pt = container_of(ancestor->vm_bo, struct amdgpu_vm_pt, base);
> +		pt = ancestor->vm_bo;
>   		ats_entries = amdgpu_vm_num_ats_entries(adev);
> -		if ((pt - vm->root.entries) >= ats_entries) {
> +		if ((pt - to_amdgpu_bo_vm(vm->root.bo)->entries) >= ats_entries) {
>   			ats_entries = 0;
>   		} else {
>   			ats_entries = entries;
> @@ -900,8 +900,8 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   
>   	bp.type = ttm_bo_type_kernel;
>   	bp.no_wait_gpu = immediate;
> -	if (vm->root.base.bo)
> -		bp.resv = vm->root.base.bo->tbo.base.resv;
> +	if (vm->root.bo)
> +		bp.resv = vm->root.bo->tbo.base.resv;
>   
>   	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
>   	if (r)
> @@ -960,19 +960,13 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   			       struct amdgpu_vm_pt_cursor *cursor,
>   			       bool immediate)
>   {
> -	struct amdgpu_vm_pt *entry = cursor->entry;
> +	struct amdgpu_vm_bo_base *entry = cursor->entry;
>   	struct amdgpu_bo *pt_bo;
>   	struct amdgpu_bo_vm *pt;
>   	int r;
>   
> -	if (entry->base.bo) {
> -		if (cursor->level < AMDGPU_VM_PTB)
> -			entry->entries =
> -				to_amdgpu_bo_vm(entry->base.bo)->entries;
> -		else
> -			entry->entries = NULL;
> +	if (entry->bo)
>   		return 0;
> -	}
>   
>   	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
>   	if (r)
> @@ -982,13 +976,8 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   	 * freeing them up in the wrong order.
>   	 */
>   	pt_bo = &pt->bo;
> -	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
> -	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
> -	if (cursor->level < AMDGPU_VM_PTB)
> -		entry->entries = pt->entries;
> -	else
> -		entry->entries = NULL;
> -
> +	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
> +	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
>   	r = amdgpu_vm_clear_bo(adev, vm, pt, immediate);
>   	if (r)
>   		goto error_free_pt;
> @@ -1006,18 +995,17 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>    *
>    * @entry: PDE to free
>    */
> -static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
> +static void amdgpu_vm_free_table(struct amdgpu_vm_bo_base *entry)
>   {
>   	struct amdgpu_bo *shadow;
>   
> -	if (entry->base.bo) {
> -		shadow = amdgpu_bo_shadowed(entry->base.bo);
> -		entry->base.bo->vm_bo = NULL;
> -		list_del(&entry->base.vm_status);
> -		amdgpu_bo_unref(&shadow);
> -		amdgpu_bo_unref(&entry->base.bo);
> -	}
> -	entry->entries = NULL;
> +	if (!entry->bo)
> +		return;
> +	shadow = amdgpu_bo_shadowed(entry->bo);
> +	entry->bo->vm_bo = NULL;
> +	list_del(&entry->vm_status);
> +	amdgpu_bo_unref(&shadow);
> +	amdgpu_bo_unref(&entry->bo);
>   }
>   
>   /**
> @@ -1034,7 +1022,7 @@ static void amdgpu_vm_free_pts(struct amdgpu_device *adev,
>   			       struct amdgpu_vm_pt_cursor *start)
>   {
>   	struct amdgpu_vm_pt_cursor cursor;
> -	struct amdgpu_vm_pt *entry;
> +	struct amdgpu_vm_bo_base *entry;
>   
>   	vm->bulk_moveable = false;
>   
> @@ -1302,10 +1290,10 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr)
>    */
>   static int amdgpu_vm_update_pde(struct amdgpu_vm_update_params *params,
>   				struct amdgpu_vm *vm,
> -				struct amdgpu_vm_pt *entry)
> +				struct amdgpu_vm_bo_base *entry)
>   {
> -	struct amdgpu_vm_pt *parent = amdgpu_vm_pt_parent(entry);
> -	struct amdgpu_bo *bo = parent->base.bo, *pbo;
> +	struct amdgpu_vm_bo_base *parent = amdgpu_vm_pt_parent(entry);
> +	struct amdgpu_bo *bo = parent->bo, *pbo;
>   	uint64_t pde, pt, flags;
>   	unsigned level;
>   
> @@ -1313,8 +1301,8 @@ static int amdgpu_vm_update_pde(struct amdgpu_vm_update_params *params,
>   		pbo = pbo->parent;
>   
>   	level += params->adev->vm_manager.root_level;
> -	amdgpu_gmc_get_pde_for_bo(entry->base.bo, level, &pt, &flags);
> -	pde = (entry - parent->entries) * 8;
> +	amdgpu_gmc_get_pde_for_bo(entry->bo, level, &pt, &flags);
> +	pde = (entry - to_amdgpu_bo_vm(parent->bo)->entries) * 8;
>   	return vm->update_funcs->update(params, to_amdgpu_bo_vm(bo), pde, pt,
>   					1, 0, flags);
>   }
> @@ -1331,11 +1319,11 @@ static void amdgpu_vm_invalidate_pds(struct amdgpu_device *adev,
>   				     struct amdgpu_vm *vm)
>   {
>   	struct amdgpu_vm_pt_cursor cursor;
> -	struct amdgpu_vm_pt *entry;
> +	struct amdgpu_vm_bo_base *entry;
>   
>   	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry)
> -		if (entry->base.bo && !entry->base.moved)
> -			amdgpu_vm_bo_relocated(&entry->base);
> +		if (entry->bo && !entry->moved)
> +			amdgpu_vm_bo_relocated(entry);
>   }
>   
>   /**
> @@ -1369,11 +1357,12 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   		return r;
>   
>   	while (!list_empty(&vm->relocated)) {
> -		struct amdgpu_vm_pt *entry;
> +		struct amdgpu_vm_bo_base *entry;
>   
> -		entry = list_first_entry(&vm->relocated, struct amdgpu_vm_pt,
> -					 base.vm_status);
> -		amdgpu_vm_bo_idle(&entry->base);
> +		entry = list_first_entry(&vm->relocated,
> +					 struct amdgpu_vm_bo_base,
> +					 vm_status);
> +		amdgpu_vm_bo_idle(entry);
>   
>   		r = amdgpu_vm_update_pde(&params, vm, entry);
>   		if (r)
> @@ -1553,7 +1542,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>   			continue;
>   		}
>   
> -		pt = cursor.entry->base.bo;
> +		pt = cursor.entry->bo;
>   		if (!pt) {
>   			/* We need all PDs and PTs for mapping something, */
>   			if (flags & AMDGPU_PTE_VALID)
> @@ -1565,7 +1554,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>   			if (!amdgpu_vm_pt_ancestor(&cursor))
>   				return -EINVAL;
>   
> -			pt = cursor.entry->base.bo;
> +			pt = cursor.entry->bo;
>   			shift = parent_shift;
>   			frag_end = max(frag_end, ALIGN(frag_start + 1,
>   				   1ULL << shift));
> @@ -1620,7 +1609,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>   			 */
>   			while (cursor.pfn < frag_start) {
>   				/* Make sure previous mapping is freed */
> -				if (cursor.entry->base.bo) {
> +				if (cursor.entry->bo) {
>   					params->table_freed = true;
>   					amdgpu_vm_free_pts(adev, params->vm, &cursor);
>   				}
> @@ -1699,7 +1688,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>   		struct dma_fence *tmp = dma_fence_get_stub();
>   
> -		amdgpu_bo_fence(vm->root.base.bo, vm->last_unlocked, true);
> +		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
>   		swap(vm->last_unlocked, tmp);
>   		dma_fence_put(tmp);
>   	}
> @@ -1844,7 +1833,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   
>   	if (clear || !bo) {
>   		mem = NULL;
> -		resv = vm->root.base.bo->tbo.base.resv;
> +		resv = vm->root.bo->tbo.base.resv;
>   	} else {
>   		struct drm_gem_object *obj = &bo->tbo.base;
>   
> @@ -1875,7 +1864,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   	}
>   
>   	if (clear || (bo && bo->tbo.base.resv ==
> -		      vm->root.base.bo->tbo.base.resv))
> +		      vm->root.bo->tbo.base.resv))
>   		last_update = &vm->last_update;
>   	else
>   		last_update = &bo_va->last_pt_update;
> @@ -1917,7 +1906,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   	 * the evicted list so that it gets validated again on the
>   	 * next command submission.
>   	 */
> -	if (bo && bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv) {
> +	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
>   		uint32_t mem_type = bo->tbo.mem.mem_type;
>   
>   		if (!(bo->preferred_domains &
> @@ -2054,7 +2043,7 @@ static void amdgpu_vm_free_mapping(struct amdgpu_device *adev,
>    */
>   static void amdgpu_vm_prt_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	struct dma_resv *resv = vm->root.base.bo->tbo.base.resv;
> +	struct dma_resv *resv = vm->root.bo->tbo.base.resv;
>   	struct dma_fence *excl, **shared;
>   	unsigned i, shared_count;
>   	int r;
> @@ -2101,7 +2090,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm,
>   			  struct dma_fence **fence)
>   {
> -	struct dma_resv *resv = vm->root.base.bo->tbo.base.resv;
> +	struct dma_resv *resv = vm->root.bo->tbo.base.resv;
>   	struct amdgpu_bo_va_mapping *mapping;
>   	uint64_t init_pte_value = 0;
>   	struct dma_fence *f = NULL;
> @@ -2260,7 +2249,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>   	if (mapping->flags & AMDGPU_PTE_PRT)
>   		amdgpu_vm_prt_get(adev);
>   
> -	if (bo && bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv &&
> +	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
>   	    !bo_va->base.moved) {
>   		list_move(&bo_va->base.vm_status, &vm->moved);
>   	}
> @@ -2622,7 +2611,7 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
>   	struct amdgpu_vm_bo_base **base;
>   
>   	if (bo) {
> -		if (bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv)
> +		if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>   			vm->bulk_moveable = false;
>   
>   		for (base = &bo_va->base.bo->vm_bo; *base;
> @@ -2716,7 +2705,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>   		struct amdgpu_vm *vm = bo_base->vm;
>   
> -		if (evicted && bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv) {
> +		if (evicted && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
>   			amdgpu_vm_bo_evicted(bo_base);
>   			continue;
>   		}
> @@ -2727,7 +2716,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   
>   		if (bo->tbo.type == ttm_bo_type_kernel)
>   			amdgpu_vm_bo_relocated(bo_base);
> -		else if (bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv)
> +		else if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>   			amdgpu_vm_bo_moved(bo_base);
>   		else
>   			amdgpu_vm_bo_invalidated(bo_base);
> @@ -2857,7 +2846,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>    */
>   long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>   {
> -	timeout = dma_resv_wait_timeout_rcu(vm->root.base.bo->tbo.base.resv,
> +	timeout = dma_resv_wait_timeout_rcu(vm->root.bo->tbo.base.resv,
>   					    true, true, timeout);
>   	if (timeout <= 0)
>   		return timeout;
> @@ -2943,13 +2932,13 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   	if (r)
>   		goto error_unreserve;
>   
> -	amdgpu_vm_bo_base_init(&vm->root.base, vm, root_bo);
> +	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
>   
>   	r = amdgpu_vm_clear_bo(adev, vm, root, false);
>   	if (r)
>   		goto error_unreserve;
>   
> -	amdgpu_bo_unreserve(vm->root.base.bo);
> +	amdgpu_bo_unreserve(vm->root.bo);
>   
>   	if (pasid) {
>   		unsigned long flags;
> @@ -2969,12 +2958,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   	return 0;
>   
>   error_unreserve:
> -	amdgpu_bo_unreserve(vm->root.base.bo);
> +	amdgpu_bo_unreserve(vm->root.bo);
>   
>   error_free_root:
>   	amdgpu_bo_unref(&root->shadow);
>   	amdgpu_bo_unref(&root_bo);
> -	vm->root.base.bo = NULL;
> +	vm->root.bo = NULL;
>   
>   error_free_delayed:
>   	dma_fence_put(vm->last_unlocked);
> @@ -3000,17 +2989,14 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>    *	0 if this VM is clean
>    */
>   static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
> -	struct amdgpu_vm *vm)
> +					  struct amdgpu_vm *vm)
>   {
>   	enum amdgpu_vm_level root = adev->vm_manager.root_level;
>   	unsigned int entries = amdgpu_vm_num_entries(adev, root);
>   	unsigned int i = 0;
>   
> -	if (!(vm->root.entries))
> -		return 0;
> -
>   	for (i = 0; i < entries; i++) {
> -		if (vm->root.entries[i].base.bo)
> +		if (to_amdgpu_bo_vm(vm->root.bo)->entries[i].bo)
>   			return -EINVAL;
>   	}
>   
> @@ -3044,7 +3030,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
>   	int r;
>   
> -	r = amdgpu_bo_reserve(vm->root.base.bo, true);
> +	r = amdgpu_bo_reserve(vm->root.bo, true);
>   	if (r)
>   		return r;
>   
> @@ -3072,7 +3058,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (pte_support_ats != vm->pte_support_ats) {
>   		vm->pte_support_ats = pte_support_ats;
>   		r = amdgpu_vm_clear_bo(adev, vm,
> -				       to_amdgpu_bo_vm(vm->root.base.bo),
> +				       to_amdgpu_bo_vm(vm->root.bo),
>   				       false);
>   		if (r)
>   			goto free_idr;
> @@ -3089,7 +3075,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	if (vm->use_cpu_for_update) {
>   		/* Sync with last SDMA update/clear before switching to CPU */
> -		r = amdgpu_bo_sync_wait(vm->root.base.bo,
> +		r = amdgpu_bo_sync_wait(vm->root.bo,
>   					AMDGPU_FENCE_OWNER_UNDEFINED, true);
>   		if (r)
>   			goto free_idr;
> @@ -3117,7 +3103,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	}
>   
>   	/* Free the shadow bo for compute VM */
> -	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.base.bo)->shadow);
> +	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
>   
>   	if (pasid)
>   		vm->pasid = pasid;
> @@ -3133,7 +3119,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>   	}
>   unreserve_bo:
> -	amdgpu_bo_unreserve(vm->root.base.bo);
> +	amdgpu_bo_unreserve(vm->root.bo);
>   	return r;
>   }
>   
> @@ -3176,7 +3162,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> -	root = amdgpu_bo_ref(vm->root.base.bo);
> +	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
>   	if (vm->pasid) {
>   		unsigned long flags;
> @@ -3203,7 +3189,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	amdgpu_vm_free_pts(adev, vm, NULL);
>   	amdgpu_bo_unreserve(root);
>   	amdgpu_bo_unref(&root);
> -	WARN_ON(vm->root.base.bo);
> +	WARN_ON(vm->root.bo);
>   
>   	drm_sched_entity_destroy(&vm->immediate);
>   	drm_sched_entity_destroy(&vm->delayed);
> @@ -3320,7 +3306,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		/* Wait vm idle to make sure the vmid set in SPM_VMID is
>   		 * not referenced anymore.
>   		 */
> -		r = amdgpu_bo_reserve(fpriv->vm.root.base.bo, true);
> +		r = amdgpu_bo_reserve(fpriv->vm.root.bo, true);
>   		if (r)
>   			return r;
>   
> @@ -3328,7 +3314,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		if (r < 0)
>   			return r;
>   
> -		amdgpu_bo_unreserve(fpriv->vm.root.base.bo);
> +		amdgpu_bo_unreserve(fpriv->vm.root.bo);
>   		amdgpu_vmid_free_reserved(adev, &fpriv->vm, AMDGPU_GFXHUB_0);
>   		break;
>   	default:
> @@ -3401,7 +3387,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	spin_lock(&adev->vm_manager.pasid_lock);
>   	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
>   	if (vm) {
> -		root = amdgpu_bo_ref(vm->root.base.bo);
> +		root = amdgpu_bo_ref(vm->root.bo);
>   		is_compute_context = vm->is_compute_context;
>   	} else {
>   		root = NULL;
> @@ -3426,7 +3412,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	/* Double check that the VM still exists */
>   	spin_lock(&adev->vm_manager.pasid_lock);
>   	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> -	if (vm && vm->root.base.bo != root)
> +	if (vm && vm->root.bo != root)
>   		vm = NULL;
>   	spin_unlock(&adev->vm_manager.pasid_lock);
>   	if (!vm)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 1f089da1e615..ddb85a85cbba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -152,13 +152,6 @@ struct amdgpu_vm_bo_base {
>   	bool				moved;
>   };
>   
> -struct amdgpu_vm_pt {
> -	struct amdgpu_vm_bo_base	base;
> -
> -	/* array of page tables, one for each directory entry */
> -	struct amdgpu_vm_pt		*entries;
> -};
> -
>   /* provided by hw blocks that can write ptes, e.g., sdma */
>   struct amdgpu_vm_pte_funcs {
>   	/* number of dw to reserve per operation */
> @@ -284,7 +277,7 @@ struct amdgpu_vm {
>   	struct list_head        done;
>   
>   	/* contains the page directory */
> -	struct amdgpu_vm_pt     root;
> +	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
>   
>   	/* Scheduler entities for page table updates */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 422958152c2b..dbb551762805 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -112,7 +112,7 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>   		swap(p->vm->last_unlocked, f);
>   		dma_fence_put(tmp);
>   	} else {
> -		amdgpu_bo_fence(p->vm->root.base.bo, f, true);
> +		amdgpu_bo_fence(p->vm->root.bo, f, true);
>   	}
>   
>   	if (fence && !p->immediate)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 0f18bd0dc64e..bd911b74b7f9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1274,7 +1274,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
>   		adev = (struct amdgpu_device *)pdd->dev->kgd;
>   		vm = drm_priv_to_vm(pdd->drm_priv);
>   
> -		ctx->tv[gpuidx].bo = &vm->root.base.bo->tbo;
> +		ctx->tv[gpuidx].bo = &vm->root.bo->tbo;
>   		ctx->tv[gpuidx].num_shared = 4;
>   		list_add(&ctx->tv[gpuidx].head, &ctx->validate_list);
>   	}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
