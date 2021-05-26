Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971EDC47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 14:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4454B613C7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 14:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4454B613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E30A06EB19;
	Wed, 26 May 2021 14:58:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCCE16EB19
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 14:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUIT4uB4R9iDiRm6Y/3ou7JdsDsfm9Np9iK61iz5e587Qgp0RTuPUWGJUWz/CIaSLjHp8n6M1lq32CBZpGN99sWQm7sCDhqfkW4dzYPDa/XZfz/fL9ZS7o33Nvc0gsk8XHoCvcehYkuNpDwDdHBCEg24u5QXmZY2wmew75pVnyY2fRaacdLkFjEb6vLn1QsF6d0K7JDRQhd/+vi1iwi4m1FY1ZGnFwzsraPdjY4784BSHPn6x20C7WZLikftucoCOSgI/8KOQqhkxdYWm2O4703AN4reWhNRioHS2iblyKPAaGi3/dj5jqU6VFud9NZ8KN+Eb+FFj5XisRBvDHBkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C41QsOVx0n2UmFB6KF6dg/dlpV2NXsYbx7rVS3Ddbfo=;
 b=lG1TbBTbQMbMUW2x7Pj+AtqaoqabOvFJUaWHZPN3DzrJHhnYIyjKA1QJzA22wxEqNHRMceALvJH+YaAj+vywmPPnisnN+FI4tYVi4bPmalO4yKjdjWy+u/WxqMxhFkdMX2AqQPgOjyFDTLMk+0EeKs05uaORh0H90Bp1Cpr5B3zi8Je633K5SvbqOPGnc7z2FiQiXI2OMsa4D4M+GRG0sFpHtQ9y0z7hOvN7wRhMrQPxB6UK/foZwK8OKqUBaRQDtxRJNIb4qu+QIKKffrsIH6v1F5grt7MIg/fd8eZPUfzmtH/VCWaQp76W3eazbvbNPnEKKHMSQf+i9ryw9rDORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C41QsOVx0n2UmFB6KF6dg/dlpV2NXsYbx7rVS3Ddbfo=;
 b=gmV2a+FaT8INslYl/ajBK7c0pQ8e1gHf1BOabzesGZu9/Jk7TdToDIhLnLQ8rSkGsxSg7joZMs/23YRF4mTIB6XdxYoIf0NjFwruADp5RnWyevRxBT77PfGcTnIo2mP96sQk8oMY2B23Xw7xuAeEeEUSyT1KgC6f732YW7K2Bos=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 14:58:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 14:58:30 +0000
Subject: Re: [PATCH v2 3/5] drm/amdgpu: switch to amdgpu_bo_vm for vm code
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210526130658.4237-1-nirmoy.das@amd.com>
 <20210526130658.4237-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e7e7470d-9574-0518-53be-c03238b51b53@amd.com>
Date: Wed, 26 May 2021 16:58:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210526130658.4237-3-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:1950:35e:cae9:5bed]
X-ClientProxiedBy: PR1PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::49) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:1950:35e:cae9:5bed]
 (2a02:908:1252:fb60:1950:35e:cae9:5bed) by
 PR1PR01CA0036.eurprd01.prod.exchangelabs.com (2603:10a6:102::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 26 May 2021 14:58:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 289063d9-1b2a-4b52-b5f1-08d92056b956
X-MS-TrafficTypeDiagnostic: MN2PR12MB4359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4359F15CFCA434DFFB37320483249@MN2PR12MB4359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VflC5NznCzo2J072zGd5dVYL+Ozg2Zlp5s1CBhEIA4Q/4JeKWvoaYobXH7m/2CDmFCkdR90wQvvAAuPjKt1bTLCN4mo85khsvyErUD1KZctXCI7NV1Yw9uPTd4VptJ3dtdwdT50b0BwM9exwM6OFTRMSTM0wWh7R6wpBSe3S2AObjnUjrnZzLR6PMk6db2E+XiUyBlQFQPDmKFXj948WqZqZ8TGtkgh/mA/KakAHYB2DmN9gMan6nxCrVhV53E3oZ0g05gXVog4kyuKnULvHBP3z8V8xhxeBLplcu9hkdeZ+k9nfWoDhUNp0ysVqkcZVFdktKySlQtgNgDxxsObPSb6F5JcSK/V6K50zjrsLMZI6eOVhy5eHXbYVMSYzKLuSVjr1f5XBcm4lZlBZFCztd30PwEZ0KScG93vICAaPGDgcVoSMmMZIqG/GXcn9jloo3eFWKcsaKp7z9LSkFkac1Ltjwz4DriTpgP5UY09jy7PjdozBJJW0UAB0Uje5q7fyxLpaqYxjl0MLqwk6J7QqUqqSiSpKPWGojmrEvY6cDYEeBQQfzi/6IcMmUABEWZnEHmjThUuI+yHn7fxNjZ0mwdLSjJPc3EDZ5Gl3dIHucXZ1A5+G8s9Bq7zIIoBhPCF1wAZqH3mDjarnR1whUxdClsLIkRpRq1D2NXEaD8guk/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39850400004)(346002)(396003)(38100700002)(6486002)(316002)(66556008)(16526019)(36756003)(186003)(30864003)(66476007)(86362001)(478600001)(52116002)(8936002)(8676002)(4326008)(31696002)(2616005)(6666004)(31686004)(66946007)(5660300002)(83380400001)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QVpEc0hmQ0c2STRMRTREUGxIRWZnMkdBMytkMDBRakowQ1pqV1hLYnkxb2t2?=
 =?utf-8?B?TUh2L0lsbGc2bXFtTFA0WExMR1lmOWFyN0FLUERmdVBtVDN4eGNjTWZaekh4?=
 =?utf-8?B?QmdZVmZUNDgyY084UCtMNTNhcHptbW5Ta2hqbFV2KzVIeE9xVDRTZkx1ZUpZ?=
 =?utf-8?B?bWdDN04zNFFaeVFlQkRUNjU2aWZjMDZ1d3pxcjA5c1ZUendJS1o2UjlFNzE4?=
 =?utf-8?B?UytXTnZ4NXVpeU5GZXR6RXlXRlBHSWQrc2w2aGxzK2t0SkkreUd6ZnUwV0s3?=
 =?utf-8?B?Rmkrc25SOGlGQ2lWczc4bUFDTW1pYTU4Q2tnVFAwUGNMYlF4SFJ1WUVwY0tZ?=
 =?utf-8?B?ODVCMXVSN3JQU0FHOTNYN2JwaU5KQnRQbkhxdXlxYWhEZ0JBbFNOQnNubDBP?=
 =?utf-8?B?MTNLdU41NHUwY2cyYzJhSW52SnE3QmNZV0lEU1BxTVE5VHZWVkhBOFJKdVlP?=
 =?utf-8?B?UmU2eEpmV1JGa0VHb1ptZzVOSlhHZDBWRHliWmJURmNmMEFncW5ZVlVWamRk?=
 =?utf-8?B?Uk1tZjJFUGhKalViZDI1SkhrWDhSb0luOVlsbi94WmpZVk1RT0xkbW41Q0cr?=
 =?utf-8?B?Y2oydVVrdlcvM3JMWktOeElYTkMwWTdmOC84ZUZ1QkVrZFZIRjNrZnUrMFk5?=
 =?utf-8?B?ei9FakREWmVmZUxNS3BvZ0pLMkIxbGxPb0p3UmNtV01kRk5pUGVOM05KSVht?=
 =?utf-8?B?cjBCL2R1Nld1dFdvakU5Z2JSNGFtMU5sT3VieXZ0YitLZnJhNVMrZ3dKZnZn?=
 =?utf-8?B?TCtmejJwTXdvNGcxMTlYNS80S0JwT2VrNitwQ20xc09KUXdpNm5QSXl3aWoy?=
 =?utf-8?B?U01qNndnNEN2TlFUb1lDTGl5TWNHRVRsTTJRa25uTWFYTjRhYy9pd2MvZ2JU?=
 =?utf-8?B?eU1IMVhsK3FtbVNvYmcvM2hlQmp6aXdVOGFKdk4xVDZxZ1UxeEdGaDlXbWpW?=
 =?utf-8?B?RHVCOHF5UWdydjJiTG84NUhtWUg3cVBjOHFlZHNFZE05WW5LcjJEK0ozNHpY?=
 =?utf-8?B?WEhmYTRkcEtLaDN5Y0NJdkxLZCtVZFp0ZU1SSHNPNlhBeXY2MWVraGVXWjEy?=
 =?utf-8?B?Y3F1Z29Mbkd3TnpqVWx1UlBWQkxXVWhRTVBCMi9QV2pQOG01QzhMRyt3YkhJ?=
 =?utf-8?B?ZnRkdkpVN3Q3WFZweEMvbFlqNXljWTJsUkdsMzNLR1YvK0VpOGlXVFhxcEdW?=
 =?utf-8?B?MjhoUXRhVTVnZ0FvejBINzd0VkN5d3NVcitKRjU1WnFqYXVXSGtSTlVXMjUr?=
 =?utf-8?B?aFUvQmRkai9aU29JNHZrWUpQckdVbElZUlhzV1JqeFVpZHYrNTRRQzhveWhs?=
 =?utf-8?B?U2c3U0hudW12MkZKMjVoSC9oZ256MjhoOXBMUStXQXlyZGxRY3VEblphQ2Fn?=
 =?utf-8?B?YWpDbHFoT21tajNEcnhmWURvZXBwNDFoYnI5OXNhc2EwTHpycndvV2RMRlVr?=
 =?utf-8?B?ZUlEWFNrZkNTWEZRQjVTMUVDTjdDQ1ZqRlFWdk5QWm1WcFg1bFpMLzJVWTRi?=
 =?utf-8?B?MFkyY3Y0eHV0RC9XdXlVVGh5Q2U4a0FTb3FvRWk4czFaRDRJdndEZFg0VTlm?=
 =?utf-8?B?MXFWeDcyenFOdXh0VlJMb0wrZzRNcGZTTVp2TzR3bEtnODhwdzNqR0Nua0xG?=
 =?utf-8?B?cFhVTnhBem9Qald3ZnhHRHZweTFoK3JaYmNJeDRVajdWa0gvWFBYdmVYdlIx?=
 =?utf-8?B?cFg5c291U0NRQmh1b1JsL0IyNjdibkFFRHkwMmRmL0Fab1NEMTBOS1h6eUky?=
 =?utf-8?B?Q0FvNXlVUjN2TkNSVUkrNlEzWjBqZjFKbGtjS1hvaWNjU2tiNkkyTXRpQVJj?=
 =?utf-8?B?Qjh1TVJiMWIrWGV1My8xR3lYUHJtczRnT0tuNHhhZ3hLRDRUb0UraU9Qcmpj?=
 =?utf-8?Q?s5Rpcf/MRXZBk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289063d9-1b2a-4b52-b5f1-08d92056b956
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 14:58:29.9778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DxprvJdQrYoJrAqbiUExWsNx5JevR6DOsAcWeVe4f+c5V9z84o52s0uDz77t4cA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.05.21 um 15:06 schrieb Nirmoy Das:
> The subclass, amdgpu_bo_vm is intended for PT/PD BOs which are also
> shadowed, so switch to amdgpu_bo_vm BO for PT/PD BOs.
>
> v2: squash three related patches.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 90 +++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 16 ++--
>   2 files changed, 67 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 6bc7566cc193..80d50e6d75f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -658,9 +658,9 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>
>   		ttm_bo_move_to_lru_tail(&bo->tbo, &bo->tbo.mem,
>   					&vm->lru_bulk_move);
> -		if (bo->shadow)
> -			ttm_bo_move_to_lru_tail(&bo->shadow->tbo,
> -						&bo->shadow->tbo.mem,
> +		if (bo->tbo.type == ttm_bo_type_kernel)
> +			ttm_bo_move_to_lru_tail(&to_amdgpu_bo_vm(bo)->shadow->tbo,
> +						&to_amdgpu_bo_vm(bo)->shadow->tbo.mem,

Maybe use a local variable for the shadow BO here.

>   						&vm->lru_bulk_move);
>   	}
>   	spin_unlock(&adev->mman.bdev.lru_lock);
> @@ -696,8 +696,8 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		r = validate(param, bo);
>   		if (r)
>   			return r;
> -		if (bo->shadow) {
> -			r = validate(param, bo->shadow);
> +		if (bo->tbo.type == ttm_bo_type_kernel) {
> +			r = validate(param, to_amdgpu_bo_vm(bo)->shadow);
>   			if (r)
>   				return r;
>   		}
> @@ -793,8 +793,9 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   	if (r)
>   		return r;
>
> -	if (bo->shadow) {
> -		r = ttm_bo_validate(&bo->shadow->tbo, &bo->shadow->placement,
> +	if (bo->tbo.type == ttm_bo_type_kernel) {
> +		r = ttm_bo_validate(&to_amdgpu_bo_vm(bo)->shadow->tbo,
> +				    &to_amdgpu_bo_vm(bo)->shadow->placement,

Same here.

>   				    &ctx);
>   		if (r)
>   			return r;
> @@ -863,14 +864,17 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>    * @vm: requesting vm
>    * @level: the page table level
>    * @immediate: use a immediate update
> - * @bo: pointer to the buffer object pointer
> + * @vmbo: pointer to the buffer object pointer
>    */
>   static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   			       struct amdgpu_vm *vm,
>   			       int level, bool immediate,
> -			       struct amdgpu_bo **bo)
> +			       struct amdgpu_bo_vm **vmbo)
>   {
>   	struct amdgpu_bo_param bp;
> +	struct amdgpu_bo *bo;
> +	struct amdgpu_bo *shadow_bo;
> +	struct dma_resv *resv;
>   	int r;
>
>   	memset(&bp, 0, sizeof(bp));
> @@ -881,7 +885,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
>   	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>   		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> -	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
>   	if (vm->use_cpu_for_update)
>   		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>
> @@ -890,26 +894,43 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   	if (vm->root.base.bo)
>   		bp.resv = vm->root.base.bo->tbo.base.resv;
>
> -	r = amdgpu_bo_create(adev, &bp, bo);
> +	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
>   	if (r)
>   		return r;

> +	bo = &(*vmbo)->bo;
>   	if (vm->is_compute_context && (adev->flags & AMD_IS_APU))
>   		return 0;
>
>   	if (!bp.resv)
> -		WARN_ON(dma_resv_lock((*bo)->tbo.base.resv,
> +		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
>   				      NULL));
> -	r = amdgpu_bo_create_shadow(adev, bp.size, *bo);
> +	resv = bp.resv;

Maybe shuffle that code around a bit, then you only need the resv 
variable and no longer the bo variable.

> +	memset(&bp, 0, sizeof(bp));
> +	bp.size = amdgpu_vm_bo_size(adev, level);
> +	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> +	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> +	bp.type = ttm_bo_type_kernel;
> +	bp.resv = bo->tbo.base.resv;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>
> -	if (!bp.resv)
> -		dma_resv_unlock((*bo)->tbo.base.resv);
> +	r = amdgpu_bo_create(adev, &bp, &shadow_bo);

> +
> +

Remove the two empty lines here

> +	if (!resv)
> +		dma_resv_unlock(bo->tbo.base.resv);
>
>   	if (r) {
> -		amdgpu_bo_unref(bo);
> +		amdgpu_bo_unref(&bo);
>   		return r;
>   	}
>
> +	shadow_bo->parent = amdgpu_bo_ref(bo);
> +	mutex_lock(&adev->shadow_list_lock);
> +	list_add_tail(&shadow_bo->shadow_list, &adev->shadow_list);
> +	mutex_unlock(&adev->shadow_list_lock);
> +	(*vmbo)->shadow = shadow_bo;

Ok, we should either move the shadow_list into the vm_mgr structure or 
keep that in the object code.

I think I prefer the later, something like amdgpu_bo_add_to_shadow_list().

> +
>   	return 0;
>   }
>
> @@ -933,7 +954,8 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   			       bool immediate)
>   {
>   	struct amdgpu_vm_pt *entry = cursor->entry;
> -	struct amdgpu_bo *pt;
> +	struct amdgpu_bo *pt_bo;
> +	struct amdgpu_bo_vm *pt;
>   	int r;
>
>   	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
> @@ -957,10 +979,11 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   	/* Keep a reference to the root directory to avoid
>   	 * freeing them up in the wrong order.
>   	 */
> -	pt->parent = amdgpu_bo_ref(cursor->parent->base.bo);
> -	amdgpu_vm_bo_base_init(&entry->base, vm, pt);
> +	pt_bo = &pt->bo;
> +	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
> +	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
>
> -	r = amdgpu_vm_clear_bo(adev, vm, pt, immediate);
> +	r = amdgpu_vm_clear_bo(adev, vm, pt_bo, immediate);
>   	if (r)
>   		goto error_free_pt;
>
> @@ -968,7 +991,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>
>   error_free_pt:
>   	amdgpu_bo_unref(&pt->shadow);
> -	amdgpu_bo_unref(&pt);
> +	amdgpu_bo_unref(&pt_bo);
>   	return r;
>   }
>
> @@ -982,7 +1005,8 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
>   	if (entry->base.bo) {
>   		entry->base.bo->vm_bo = NULL;
>   		list_del(&entry->base.vm_status);
> -		amdgpu_bo_unref(&entry->base.bo->shadow);
> +		if (entry->base.bo->tbo.type == ttm_bo_type_kernel)

That should always be true, otherwise we have a rather big bug.

So no need to check that here.

> +			amdgpu_bo_unref(&to_amdgpu_bo_vm(entry->base.bo)->shadow);
>   		amdgpu_bo_unref(&entry->base.bo);
>   	}
>   	kvfree(entry->entries);
> @@ -2674,7 +2698,8 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   	struct amdgpu_vm_bo_base *bo_base;
>
>   	/* shadow bo doesn't have bo base, its validation needs its parent */
> -	if (bo->parent && bo->parent->shadow == bo)
> +	if (bo->parent && bo->tbo.type == ttm_bo_type_kernel &&
> +	    to_amdgpu_bo_vm(bo->parent)->shadow == bo)
>   		bo = bo->parent;
>
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
> @@ -2843,7 +2868,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>    */
>   int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   {
> -	struct amdgpu_bo *root;
> +	struct amdgpu_bo *root_bo;
> +	struct amdgpu_bo_vm *root;
>   	int r, i;
>
>   	vm->va = RB_ROOT_CACHED;
> @@ -2897,18 +2923,18 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   				false, &root);
>   	if (r)
>   		goto error_free_delayed;
> -
> -	r = amdgpu_bo_reserve(root, true);
> +	root_bo = &root->bo;
> +	r = amdgpu_bo_reserve(root_bo, true);
>   	if (r)
>   		goto error_free_root;
>
> -	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
> +	r = dma_resv_reserve_shared(root_bo->tbo.base.resv, 1);
>   	if (r)
>   		goto error_unreserve;
>
> -	amdgpu_vm_bo_base_init(&vm->root.base, vm, root);
> +	amdgpu_vm_bo_base_init(&vm->root.base, vm, root_bo);
>
> -	r = amdgpu_vm_clear_bo(adev, vm, root, false);
> +	r = amdgpu_vm_clear_bo(adev, vm, root_bo, false);
>   	if (r)
>   		goto error_unreserve;
>
> @@ -2935,8 +2961,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   	amdgpu_bo_unreserve(vm->root.base.bo);
>
>   error_free_root:
> -	amdgpu_bo_unref(&vm->root.base.bo->shadow);
> -	amdgpu_bo_unref(&vm->root.base.bo);
> +	amdgpu_bo_unref(&root->shadow);
> +	amdgpu_bo_unref(&root_bo);
>   	vm->root.base.bo = NULL;
>
>   error_free_delayed:
> @@ -3078,7 +3104,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	}
>
>   	/* Free the shadow bo for compute VM */
> -	amdgpu_bo_unref(&vm->root.base.bo->shadow);
> +	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.base.bo)->shadow);
>
>   	if (pasid)
>   		vm->pasid = pasid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index a83a646759c5..3d9cff0c9dda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -41,8 +41,8 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo *table)
>   	if (r)
>   		return r;
>
> -	if (table->shadow)
> -		r = amdgpu_ttm_alloc_gart(&table->shadow->tbo);
> +	if (table->tbo.type == ttm_bo_type_kernel)


Again that check should be unecessary.
> +		r = amdgpu_ttm_alloc_gart(&to_amdgpu_bo_vm(table)->shadow->tbo);
>
>   	return r;
>   }
> @@ -238,8 +238,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>
>   		if (!p->pages_addr) {
>   			/* set page commands needed */
> -			if (bo->shadow)
> -				amdgpu_vm_sdma_set_ptes(p, bo->shadow, pe, addr,
> +			if (bo->tbo.type == ttm_bo_type_kernel)

Same here.

> +				amdgpu_vm_sdma_set_ptes(p, to_amdgpu_bo_vm(bo)->shadow,
> +							pe, addr,
>   							count, incr, flags);
>   			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
>   						incr, flags);
> @@ -248,7 +249,7 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>
>   		/* copy commands needed */
>   		ndw -= p->adev->vm_manager.vm_pte_funcs->copy_pte_num_dw *
> -			(bo->shadow ? 2 : 1);
> +			((bo->tbo.type == ttm_bo_type_kernel) ? 2 : 1);

And that here won't work and allocate to much SDMA space.

>
>   		/* for padding */
>   		ndw -= 7;
> @@ -263,8 +264,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>   			pte[i] |= flags;
>   		}
>
> -		if (bo->shadow)
> -			amdgpu_vm_sdma_copy_ptes(p, bo->shadow, pe, nptes);
> +		if (bo->tbo.type == ttm_bo_type_kernel)
And that is wrong as well.

Christian.

> +			amdgpu_vm_sdma_copy_ptes(p, to_amdgpu_bo_vm(bo)->shadow,
> +						 pe, nptes);
>   		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);
>
>   		pe += nptes * 8;
> --
> 2.31.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
