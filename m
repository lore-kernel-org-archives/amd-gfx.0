Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DCAC47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 08:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5436124C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 08:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5436124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D7AA6E9DD;
	Fri, 28 May 2021 08:00:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D6C6E9DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 08:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjdbktGBn+gVvjE6VIvz3RSpeShXbDrPfkajozUPBruKZKcBtFJdejm1/+u/CbhUBGnWXNCS+aHnVQaa9m9lHB4aLRGD3VNvejeXYcBaoLcdCscExoX/we39Q8P9m7fzCpSv3UZXcRoDU67YdKsfYepeeUXaZABJtLqFdcQRRaCRG2XWA3CaaPgtWD/ygeBsCFvW8AKDuERe7Bjdo4T7wqA/4FttB0tILDX4iKVymEsMKgHNHu1ulZM0FPJLg0hMQBBA/lRAT/mJEcvdkmqHJbjiaR3TYMmT6vNX8Zj+YpMKa6YInVxmLV9XFq8niaXcPYQOLlFWzzA8OZ0Mu7bjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smmhUYj5kstsDUjyBnbqaiPbTmX9siFfa4uwCL0t+Cs=;
 b=X1/Vt9OaVJhn9skbbbjc+ygUkYZHm2TucyvfsPA2jamSBJWkgtTAy3dSV5FIo8l7Pa2qFPEtSlkBWBmDJqrg2eMHrKG8BxrpyTvROr54snoQcm0+J3/ZwGK09ca1Dk+UEv+O1wICp+j080w3aIaYv2ywnyRLdmXnq+lg5r4xEZTBjBcHKUDav4JEHGCl4w8d24UQNmqbMaZp8nN2U+cBNrbNe3S8lbedT2HhIwIA87ei8qVeGl1qpo/yC4luIQrKd6LtjNn/0EaGXJRU6OApKuIw2bRhTCM8H2H1yfIZ5FXhbDMklFt9h5yNjV6JLOW/w2Cq9wEmeA0oEf9q217f0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smmhUYj5kstsDUjyBnbqaiPbTmX9siFfa4uwCL0t+Cs=;
 b=PcrZMWntYJDznxICfL8U4aT/60rt019tG7UUDt8rJgiloFiFc+Af7mvVwB6g/38ZXgfLgfQif2ZQyFQ8GH5D/bKz2R7hJmdTGxEhvvSU1GS9wdbQJMPjzyGYZjmLz/goy/BVIwBcDYtiJDXYP04CUHClRlcc7+mlHr5Qewkmtus=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3885.namprd12.prod.outlook.com (2603:10b6:208:16c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 08:00:50 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 08:00:50 +0000
Subject: Re: [PATCH v3 4/6] drm/amdgpu: switch to amdgpu_bo_vm for vm code
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210527115343.20133-1-nirmoy.das@amd.com>
 <20210527115343.20133-4-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d568cbc5-c9d4-c12c-7702-f88756e5c360@amd.com>
Date: Fri, 28 May 2021 10:00:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210527115343.20133-4-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:2960:4608:1392:c6ae]
X-ClientProxiedBy: AM3PR05CA0147.eurprd05.prod.outlook.com
 (2603:10a6:207:3::25) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:2960:4608:1392:c6ae]
 (2a02:908:1252:fb60:2960:4608:1392:c6ae) by
 AM3PR05CA0147.eurprd05.prod.outlook.com (2603:10a6:207:3::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 08:00:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dcbc657-8b0b-4883-1146-08d921aeb562
X-MS-TrafficTypeDiagnostic: MN2PR12MB3885:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3885412E07145B9B49CC1DA883229@MN2PR12MB3885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIXBAQ5LbZjA61SitLnJDpQQd74N1auGfyHJss0CHCqlityu4lBaSqpMaDBpKJU222bVXe3f2Z05+73UK/tJUZ5K+I+Fl894rfP/pxPsSBIPP1rSQ1Zj3wqAdPtn7LBj94Qx2ccFw0KgcsECr02fKYv00plDN88NFuw4BmHRjF6xf42ZvL1GraiUqdsJUwNaKcyGSns1ufbCG11qRwh1Vr+mHZePSGYqzm7yfKNonGG+zqhJfK6Pqh4bWuc+S2CrP+aCN++xWC6XbcvzlbgjimnWNkpRZQcw5jjVPtY0AkU2Qif/wbYMmMVI3u+Mvh4F4+JVXJtOkm7h1ODxKpOinG0xhrZ8P4M5Y45hX4YpG+L08ZAky2Ds3iRUhqzDj63zP3fXk6uj9dRR7UuQ7pFsJ3AZoXp5Aj7JYwS1QGK3L25bwrMYmSJwJfj3TVxp799z4u6OryxKTpMcBXj96dESWc30Gwla2ekClY+HTDgRLjNruIvKipNofjottl/4gCInbXTRo2S1UtknlWXTvDDtwR8wCTna/A8tHLfDCKaibhCWXMaWFxoBSAJG+SWE6dw+ByThR+ugxxwZPlw/6BRAXi+m/LY/GiFxjv1h65+68Qp3xM3zSJq42gsYhChkTele2nCNjda7uI5EGeI0xkjsnpxz8mB6QIOXF9tgQ+Q+KNdhV17lBZK75q6fITzYusHH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(8936002)(83380400001)(8676002)(4326008)(6666004)(30864003)(38100700002)(86362001)(186003)(16526019)(36756003)(6486002)(2616005)(31696002)(66476007)(66556008)(478600001)(66946007)(31686004)(5660300002)(2906002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MHlQdUhONktGTmVNU1Q4Nmswd2hPVkJOQStBYTZHeVlwanR5T1NRZk9XSG5V?=
 =?utf-8?B?MDJZS3ZmWG5KOXJ0ZFUxdDhCMVFIM0xnVnMwclNEMFdMOUpmWFI4UklmK3A3?=
 =?utf-8?B?RVpCeE1DaGpjMmRSTzUzakZLOWFWeCtBbzJnTXI1T2trbktPcVIrQUJuTjhU?=
 =?utf-8?B?K3FBaFFqYXFPK21aVGNvalBVNFRjcmtPYVlvemMyb3dpdGliU0Uwc20wL3hZ?=
 =?utf-8?B?bnkyNTNPZUc3V2RqTHBCazJVaDlZeSs4cEc3U2M3MlZCZVBPbU44eWQ5aUVC?=
 =?utf-8?B?ZHNuS1ZSTkhkcVltaXBhNExUdVJoMjQrOWM0Qi9LQmVJM0l5ZFdSOERSWCtH?=
 =?utf-8?B?eVBFNkFOR1A5ZS85TUlLZHhlZkhsK04vdWVYZUhoMEdpTEIzNnJ1dlpZa3hk?=
 =?utf-8?B?TnJldXhZcFFLQmIybXpTUUV4NGFlQVg5djI2SXFJMVZIMjNudzd6S3VqS2Nn?=
 =?utf-8?B?ZDRhZXZIUGxEV3pVcnBXK0RoVERGMkhHZzBDL2hobk9qMG9yWTI5Vy9VeTZW?=
 =?utf-8?B?dDBsVnB6Y28zNWFiWE5YN1dPTVhFYnJFdnJETkI1WG9OMVF6M3JNa05nSEdU?=
 =?utf-8?B?MDhnQU83OGVkMkx5MlQ3RTBMZnppaXNSOFFxUHhwcEFxaEJ1ekxTVGVkZ0ll?=
 =?utf-8?B?NlZmVXpvR0dQZ0xIbmtsdFI5WGxaOVFIOFVKMDM1cTBUTXpHYW9tZnpRUEdH?=
 =?utf-8?B?U1kvQjhCd3A4Mm12SWVSVHIyNXprQitJOVVwM0NRWVRMOUE3ZW1WNFlGb096?=
 =?utf-8?B?TFRKd05OSkNYYWhYVC9LZEJlUVRPWkU5RG13ZklVVHBwdHNkd0ZhaXJFdVNx?=
 =?utf-8?B?UUNFR0sveFFKd0hGQlErZGV5Y01Lbmw0bUlqYmY0cHNIUGRVM1NrNm5JNzl4?=
 =?utf-8?B?ZnlHT1dNcTJYeDRxc0tyQnJqQWNORGVCM2F6azdpZUc2QkVFUW9Mc3RtOGJt?=
 =?utf-8?B?WHlDeFQzTzFQYmxWOXQwWUZFQXBqUzQ1MlNMeVJLZXUrd3NLaEpxZUxzbWFD?=
 =?utf-8?B?VFhRNzMxOWFzYkRJOURTVEZMdStyQXZSdVh6WDF3dDBnZyt1aUdjUjc5eFBU?=
 =?utf-8?B?YWlpL2tLMDMxSG1TWlFaWnErc2VPNDg3N3FLK0hMVjl0aU5jN3Y3dWx2bnZK?=
 =?utf-8?B?RjdtM3RpT0ZBcUphRGRqUDJHazMvTWs5alRBbzJLRE5NWFJkNVJ1MExjR3gr?=
 =?utf-8?B?VDVWd1R5SlVIUVBUU3IrUys2dHJWMyt5SURuVkFsK0k5YWQ1bUUzbUFqaE04?=
 =?utf-8?B?OHE5QndkLy9tek91VDhLakFnSEFYUk5ubFQ2S1NicGdyK2txUXZMSHVOdmM1?=
 =?utf-8?B?ZHBrNGUwdFNEMHpjQnR2cy9DcVhQYlpDZk5OdzN1d3k4eGgzNkxwMzloWGRu?=
 =?utf-8?B?dXNBRS9lQmovb2ZHYU5WczdkYi9Dc3VGYXA4THFDVXhleVRpYWF2dmhLR1ox?=
 =?utf-8?B?cU04TG0yRURJekc4RE50dmRxQ0Z4a29YWWs4SThicmt2YmJCOUlESXYyWWd6?=
 =?utf-8?B?bkpwVFJicmJwRkdhNGcwdENuUGVnVVNtVkxtWC8xNEV5OWpKT2dDQ0NTMW0x?=
 =?utf-8?B?WDk3bjVwNUVNUDFOMXY0V2liczFtWHlJd3FYeExkYzluNlhqV1ZsemZuQ09a?=
 =?utf-8?B?VVRMZEdtRCtsVXloREhORmRuQXZXRGttdWdzYkI3Rlo4K1lxTnV1WHdzQnpG?=
 =?utf-8?B?bkVvM1l4QXdRcndJK3diUFNtMFVqK20wa2p0TThxcWNTTzRKUzV6QlJMY1Vo?=
 =?utf-8?B?UVJzb3BsbTZBb0M5cmtMZmUxS1N0bGFVMTBmVFZUWmFjNlYyZG9lSG1FTVpo?=
 =?utf-8?B?TGxQT1pGVC9vOW1aZGNzK2lvdUNxc2UrVDFzSElvT1MxTm1KQkFzd2lsZHVp?=
 =?utf-8?Q?OOxqbNtgst34N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcbc657-8b0b-4883-1146-08d921aeb562
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 08:00:50.1904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g22JzdTSQcE+ZUdTK1zxXU1mDEBC0schEyIT05bs1iHPCvJJwSfFwFA1vu4tz2m5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3885
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



Am 27.05.21 um 13:53 schrieb Nirmoy Das:
> The subclass, amdgpu_bo_vm is intended for PT/PD BOs which are also
> shadowed, so switch to amdgpu_bo_vm BO for PT/PD BOs.
>
> v3: simplify code.
>      check also if shadow bo exist, instead of checking only bo's type.
> v2: squash three related patches.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 93 +++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 18 ++--
>   2 files changed, 68 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 6bc7566cc193..d723873df765 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -652,15 +652,15 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   	spin_lock(&adev->mman.bdev.lru_lock);
>   	list_for_each_entry(bo_base, &vm->idle, vm_status) {
>   		struct amdgpu_bo *bo = bo_base->bo;
> +		struct amdgpu_bo *shadow = amdgpu_bo_shadowed(bo);
>
>   		if (!bo->parent)
>   			continue;
>
>   		ttm_bo_move_to_lru_tail(&bo->tbo, &bo->tbo.mem,
>   					&vm->lru_bulk_move);
> -		if (bo->shadow)
> -			ttm_bo_move_to_lru_tail(&bo->shadow->tbo,
> -						&bo->shadow->tbo.mem,
> +		if (shadow)
> +			ttm_bo_move_to_lru_tail(&shadow->tbo, &shadow->tbo.mem,
>   						&vm->lru_bulk_move);
>   	}
>   	spin_unlock(&adev->mman.bdev.lru_lock);
> @@ -692,12 +692,13 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>
>   	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
>   		struct amdgpu_bo *bo = bo_base->bo;
> +		struct amdgpu_bo *shadow = amdgpu_bo_shadowed(bo);
>
>   		r = validate(param, bo);
>   		if (r)
>   			return r;
> -		if (bo->shadow) {
> -			r = validate(param, bo->shadow);
> +		if (shadow) {
> +			r = validate(param, shadow);
>   			if (r)
>   				return r;
>   		}
> @@ -754,6 +755,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   	unsigned level = adev->vm_manager.root_level;
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_bo *ancestor = bo;
> +	struct amdgpu_bo *shadow;
>   	unsigned entries, ats_entries;
>   	uint64_t addr;
>   	int r;
> @@ -793,9 +795,9 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   	if (r)
>   		return r;
>
> -	if (bo->shadow) {
> -		r = ttm_bo_validate(&bo->shadow->tbo, &bo->shadow->placement,
> -				    &ctx);
> +	shadow = amdgpu_bo_shadowed(bo);
> +	if (shadow) {
> +		r = ttm_bo_validate(&shadow->tbo, &shadow->placement, &ctx);
>   		if (r)
>   			return r;
>   	}
> @@ -863,14 +865,16 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
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
> @@ -890,26 +894,41 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   	if (vm->root.base.bo)
>   		bp.resv = vm->root.base.bo->tbo.base.resv;
>
> -	r = amdgpu_bo_create(adev, &bp, bo);
> +	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
>   	if (r)
>   		return r;
>
> -	if (vm->is_compute_context && (adev->flags & AMD_IS_APU))
> +	bo = &(*vmbo)->bo;
> +	if (vm->is_compute_context && (adev->flags & AMD_IS_APU)) {
> +		(*vmbo)->shadow = NULL;
>   		return 0;
> +	}
>
>   	if (!bp.resv)
> -		WARN_ON(dma_resv_lock((*bo)->tbo.base.resv,
> +		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
>   				      NULL));
> -	r = amdgpu_bo_create_shadow(adev, bp.size, *bo);
> +	resv = bp.resv;
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
> +	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
> +
> +	if (!resv)
> +		dma_resv_unlock(bo->tbo.base.resv);
>
>   	if (r) {
> -		amdgpu_bo_unref(bo);
> +		amdgpu_bo_unref(&bo);
>   		return r;
>   	}
>
> +	(*vmbo)->shadow->parent = amdgpu_bo_ref(bo);
> +	amdgpu_bo_add_to_shadow_list((*vmbo)->shadow);
> +
>   	return 0;
>   }
>
> @@ -933,7 +952,8 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   			       bool immediate)
>   {
>   	struct amdgpu_vm_pt *entry = cursor->entry;
> -	struct amdgpu_bo *pt;
> +	struct amdgpu_bo *pt_bo;
> +	struct amdgpu_bo_vm *pt;
>   	int r;
>
>   	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
> @@ -957,10 +977,11 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
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
> @@ -968,7 +989,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>
>   error_free_pt:
>   	amdgpu_bo_unref(&pt->shadow);
> -	amdgpu_bo_unref(&pt);
> +	amdgpu_bo_unref(&pt_bo);
>   	return r;
>   }
>
> @@ -979,10 +1000,13 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>    */
>   static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
>   {
> +	struct amdgpu_bo *shadow;
> +
>   	if (entry->base.bo) {
> +		shadow = amdgpu_bo_shadowed(entry->base.bo);
>   		entry->base.bo->vm_bo = NULL;
>   		list_del(&entry->base.vm_status);
> -		amdgpu_bo_unref(&entry->base.bo->shadow);
> +		amdgpu_bo_unref(&shadow);
>   		amdgpu_bo_unref(&entry->base.bo);
>   	}
>   	kvfree(entry->entries);
> @@ -2674,7 +2698,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   	struct amdgpu_vm_bo_base *bo_base;
>
>   	/* shadow bo doesn't have bo base, its validation needs its parent */
> -	if (bo->parent && bo->parent->shadow == bo)
> +	if (bo->parent && (amdgpu_bo_shadowed(bo->parent) == bo))
>   		bo = bo->parent;
>
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
> @@ -2843,7 +2867,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>    */
>   int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   {
> -	struct amdgpu_bo *root;
> +	struct amdgpu_bo *root_bo;
> +	struct amdgpu_bo_vm *root;
>   	int r, i;
>
>   	vm->va = RB_ROOT_CACHED;
> @@ -2897,18 +2922,18 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
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
> @@ -2935,8 +2960,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
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
> @@ -3078,7 +3103,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	}
>
>   	/* Free the shadow bo for compute VM */
> -	amdgpu_bo_unref(&vm->root.base.bo->shadow);
> +	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.base.bo)->shadow);
>
>   	if (pasid)
>   		vm->pasid = pasid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index a83a646759c5..c9ef025c43f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -41,10 +41,7 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo *table)
>   	if (r)
>   		return r;
>
> -	if (table->shadow)
> -		r = amdgpu_ttm_alloc_gart(&table->shadow->tbo);
> -
> -	return r;
> +	return amdgpu_ttm_alloc_gart(&to_amdgpu_bo_vm(table)->shadow->tbo);

Here you also need to check if shadow isn't NULL.

I think it would be simpler if you make the parameter to 
amdgpu_vm_sdma_map_table a vmbo in the first place.

>   }
>
>   /**
> @@ -201,17 +198,20 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>   				 uint64_t addr, unsigned count, uint32_t incr,
>   				 uint64_t flags)
>   {
> +	struct amdgpu_bo *shadow;
>   	enum amdgpu_ib_pool_type pool = p->immediate ? AMDGPU_IB_POOL_IMMEDIATE
>   		: AMDGPU_IB_POOL_DELAYED;
>   	unsigned int i, ndw, nptes;
>   	uint64_t *pte;
>   	int r;
>
> +	shadow = amdgpu_bo_shadowed(bo);

Same for amdgpu_vm_sdma_map_table(), just make the parameter a vmbo in 
the first place.

Apart from that patch looks good to me.

Christian.

>   	/* Wait for PD/PT moves to be completed */
>   	r = amdgpu_sync_fence(&p->job->sync, bo->tbo.moving);
>   	if (r)
>   		return r;
>
> +
>   	do {
>   		ndw = p->num_dw_left;
>   		ndw -= p->job->ibs->length_dw;
> @@ -238,8 +238,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>
>   		if (!p->pages_addr) {
>   			/* set page commands needed */
> -			if (bo->shadow)
> -				amdgpu_vm_sdma_set_ptes(p, bo->shadow, pe, addr,
> +			if (shadow)
> +				amdgpu_vm_sdma_set_ptes(p, shadow, pe, addr,
>   							count, incr, flags);
>   			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
>   						incr, flags);
> @@ -248,7 +248,7 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>
>   		/* copy commands needed */
>   		ndw -= p->adev->vm_manager.vm_pte_funcs->copy_pte_num_dw *
> -			(bo->shadow ? 2 : 1);
> +			(shadow ? 2 : 1);
>
>   		/* for padding */
>   		ndw -= 7;
> @@ -263,8 +263,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>   			pte[i] |= flags;
>   		}
>
> -		if (bo->shadow)
> -			amdgpu_vm_sdma_copy_ptes(p, bo->shadow, pe, nptes);
> +		if (shadow)
> +			amdgpu_vm_sdma_copy_ptes(p, shadow, pe, nptes);
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
