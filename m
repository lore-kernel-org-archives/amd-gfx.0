Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCB7C4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 09:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198BF6113D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 09:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198BF6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD2AA6E3AA;
	Fri, 28 May 2021 09:09:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5CE6E3AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 09:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFmNYzkPJqVxdwLe4wqNsSZ9QDQeh6R32XEW6Iig/WDyNqJBiAxk1zIyvKWWEab+gA2TdTWiRFuVGtZQJ9hLq2QpWEVFOoWVsVBeactIhkm7OymwrYfq03LC2/c9J3uURrWKwT1KpqNzHt+EJD1Had7mq3DbOWxmDuhQfIKuRpQFeZf8cuP2CQfPn6Zi8cae4KuIDc42T8HpcmIxDnXLWN8e+VX4P4lipnj3wAAfDgFX01zRAP/qvlfFPrcSBgQUEc6LAlkqdarJVuhIfY1glFyeKOD4wHX7qfdAomEp7Cem4JZeHy+pSjD7uWb/VsfKFqqj2Lf6FFnKmVG+Ihxk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ6ONbIMy4ifLHxBnAKfLF37v6AxgWjRRRYDvuTjJrY=;
 b=b6vU8HGaVNSjAoe5Cy4Q5nC7S8TWpWEkg1Pwc/xE/OWxPWKyy2DqhqNMbu1azPp67ydKSu+cTNowBecGb0DZLUCYbFz417GosoM5dhs3Ptz1kTAOV7YNnY86CKxBBnKmvL6gBvibysvnc6oWUFdVJQKSLs9eogIv0LyY2SR8qgun9/gHmt5yVUWbkwutdLVhbb7fuomT7g3Vq9BvcO/uaPZuERhk8jSvqtXpo86AwnBGl9s/VshkUV0/Vtz0BRbHxkTcLNlRU6Rnebkdb5cnl7cSVbcTIMjmWC+rNSLcPXd0qp2jKXPk4dRZvOvSxC60as/WMvGHi36PrdwDo1LL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ6ONbIMy4ifLHxBnAKfLF37v6AxgWjRRRYDvuTjJrY=;
 b=DnzcGA3Rd4h82C635Ai6O69/VgzxhdL3x4MpbQaIZ80bm9Llm2Wx/RpXg1TAGpVbi7ft3aLylkzExZCL5WXu5paqu/n4Q9/QUPLyyo0qKKn3UTX+XdhuZ2O7a5zSYx4bHHziaa+W1uMtL+7mc+VzWqDEzYx1l3KTH4VFeyI0Txs=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 09:09:28 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 09:09:28 +0000
From: "Das, Nirmoy" <Nirmoy.Das@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 4/6] drm/amdgpu: switch to amdgpu_bo_vm for vm code
Thread-Topic: [PATCH v3 4/6] drm/amdgpu: switch to amdgpu_bo_vm for vm code
Thread-Index: AQHXUu79DMDA3VmHpky+xEbEoyxRfKr4iUGAgAAS7wA=
Date: Fri, 28 May 2021 09:09:28 +0000
Message-ID: <DM4PR12MB513689ACB968AE3CFB4C2A348B229@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20210527115343.20133-1-nirmoy.das@amd.com>
 <20210527115343.20133-4-nirmoy.das@amd.com>
 <d568cbc5-c9d4-c12c-7702-f88756e5c360@amd.com>
In-Reply-To: <d568cbc5-c9d4-c12c-7702-f88756e5c360@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-28T09:09:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2cace572-7041-4b67-ae4d-59f56a74f2c8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2003:c5:8f21:6900:10f4:3065:5814:d1ee]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9d198c6-ed7f-44b1-0846-08d921b84bf7
x-ms-traffictypediagnostic: DM4PR12MB5184:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB51841E36C172667B7C4A451B8B229@DM4PR12MB5184.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXH/UUJIG5Vs97POl3/vOCjYLvT6YwWsH9HyuaF+fT0KmividqoNLShfn9yiNqf7FR2PhtYQV2rXg2QR/qEzblHZp6ANcFkOX69xTzmBCWJEa5oXm37Y2Z2Ij87uOpUseD1cj5NfPnmf60GG/jxfj3cvYa8VK63VLN59Ax/v6g04RFC+HSkHhHJSYTPqANt+TyHofxRdyhk9WedAJ0oJhFacuUVVfK3JNDie/B2dGruYlcNm9eOqjewZG+w2P7okwuKwjA5LA/L9jHfXF+M9n6uepcCMSXvYAAptQLkwbICpjvmSoMD2AFWdt0aMJZAsl2Efc3Fyd+lsYn5ysw+3OXrTQfnHDwn9LvpAFevEPQmyhSveszBkhGQWgL7DccSVagxK6tohh6dmi6diJ3mt1io7DmTJaXCUtiESKb/W5TSU+hxGb5YBx2OKMemEp4drmAfJf2fN8QyIaPvVzId9oiPsjogpuEv9SQW/U0Q5eQuRNFk+iYbMRRfZBnnb+OMf6t6eNzQjjqYuqBLb0MdP6+g/5RIJo2JieJ52FiJgzaKy7UTW2+4X5ahz+DnPH7/X1kb51Lsy8gC3gZFbeYwAb6rW2xhHjoO9mkLno3K0Jfk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(122000001)(86362001)(8936002)(83380400001)(38100700002)(33656002)(478600001)(55016002)(110136005)(2906002)(4326008)(9686003)(186003)(316002)(6506007)(53546011)(66476007)(66556008)(64756008)(66446008)(8676002)(66946007)(30864003)(5660300002)(7696005)(71200400001)(52536014)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Lys4RkJ1OGJOdkNNcVVFQksrOFpwOWtOZzI2RWhQVlhPS1cxR2JubGdnLzlP?=
 =?utf-8?B?eGlVcVRka3A2VnVmL3o5OUU4S2ZicUFxTjlMWkpsNVlpcXg3MmVTZU5JVEJx?=
 =?utf-8?B?MTJ0NjlQaUdLZUZoVG9RR0NTRUVER3lHa2lOUk5jUndyTVdURTRRdDkzcFUr?=
 =?utf-8?B?Y0ZNSUV2RXcrbFB6azFvbThCNE1Ock90QXhQbzZBWVJYYUhrakt1YTRjNVpu?=
 =?utf-8?B?dDIxdFhXNlM2OGIya0VHamF4bGN5VE1BTzVJVHRTYkRPR3BET2dBd3NhNzFZ?=
 =?utf-8?B?aFowVFFhaThnbWJvL2VDKzFqcXY0YkZsOEozYXcyM0NVVVZ2TDFxZytlZzFY?=
 =?utf-8?B?UUpzMXYvKzFVMEo0bE9ueU1WTkVFTWZlbVVaZjFUalNQUmtkamxSalFkb0Nu?=
 =?utf-8?B?bVZuVVR5YmgyUUF5OXlSTzFDTU5pM1FNRStFZ3RUWm1yYkFua3J2RjExQWVa?=
 =?utf-8?B?S0l3VGlPUXREeWVPaFdqNWNOdDhoeWdmTG5Zeng5VTFONEtJWHBIbXlDNXVz?=
 =?utf-8?B?a0J4dENnejB0NElZU1NqZXdDQmFRU3pyU1VIWkxqUTFBKzdLWmZWcmhta2ZJ?=
 =?utf-8?B?TThldXY1UlNmWEpNejV4MkxvQ2p4WUQ4dHVHNEtJMjlFVi96eTBBVENGOHB5?=
 =?utf-8?B?T2VHM0VOdjF4MmRSMkhKaVlQQmlhSjBKbFRuOWc3OGdLRWZ3aDBER09TREF5?=
 =?utf-8?B?TmptbzFxcENFRThvWHMwc3Uzc2lQN1B2WHREN3IwYW1FQTlQekNEYUFTVTlY?=
 =?utf-8?B?SmtVUVMyYUR4cTRXZkwzMDdKTmlLRWYzZGt6ZjBlVFVEd1EwdjlZSllXNFdW?=
 =?utf-8?B?Q3ptM294YVJEWWNSZzluRm9Tc29XT3pOTnpJTElnL1JpNXUwajRUWDI5Rkwy?=
 =?utf-8?B?ZDdsbHpPb3FHaDZ1bEV1eXZUeTlXcGFiQm1YZlE4ZEhoRExXTkhCNVdLT2Z4?=
 =?utf-8?B?SW1VYjkvOUlqNFlRbGVLMzNsUndua3hVVnY1U21MdnRNVGs3L2J5OUlLdzdK?=
 =?utf-8?B?WjVQdDZFc3lxeHpmb0RJYTZIWDZ2aytRbFYzbDNGVjByNmUvbE9EaGhYK0F1?=
 =?utf-8?B?a1d0Z1lqUzdVMy9QZ25aVjNOVm05WXB3U2J0TmdHK0p1OTc5cWJOaE9adU1z?=
 =?utf-8?B?d202VkttMitBRU40VEM5V2tFRkx6WG9UVW1hY3QxTmg3YnFTSHd1akZzUXVx?=
 =?utf-8?B?bXN2QzNzcnI2eDBkeXNJMjhOZHdqTWVnbkpVajA0N09CeWVES1k2Yk16alN3?=
 =?utf-8?B?QitWTjVvQ1pkM2UyeHNGQnJKakQxNWNac0JLelRXYXBnWmF5K2hodFZBUWs1?=
 =?utf-8?B?TUxMaVg0V2VWdmNxa24wR2F5Y3lZcnJkZ0syMTlkanUvOUJBQ1RJZEZlQzI1?=
 =?utf-8?B?RUV3a0htK056dUtVUWNXaFBDdlkycnZjcktTV0c0VzljMjhQRWJEL3Vkc3dZ?=
 =?utf-8?B?VkI5K1l6SnR4UWczaldjSXpCdHdkejlnNXlXaTB4Y01vaVRVcTJObHBCaGYy?=
 =?utf-8?B?RW9lTnFLSGtMVnJHdkZFMnppVlhITTc5QlhQdDBPVmRhUDRiYnhvdFlFVko1?=
 =?utf-8?B?aFVyYStPdGRqSTdGUWhZbWxPc25iSHAvb3N4K3NsMTdjRkcxTzBuN25oVjVx?=
 =?utf-8?B?SURncTdSMmlScTJ1c1N4bCt6a01YMnVLWjNpQ0VxT1FkWGFMWFNqeGdleGI3?=
 =?utf-8?B?K21ycjR1c1puL2NMMzd4dFVDQUFwbHMxRU5WNDJORlBSK2M1Y0tZWFJVK3lG?=
 =?utf-8?B?cFpQVzJWbkNpeGQvQjNqbHBpM3lsWFRoSzUzUk5Ta0RIbnAzcnh4RFhDMmNI?=
 =?utf-8?Q?70sm6FXemGBc2MwIPrDU6HWIvETf2nkJgNKek=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d198c6-ed7f-44b1-0846-08d921b84bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 09:09:28.0849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbgsEjYS05rmdEjkLVSJbUYZRlUUyWCatEDKCEkOwJzxcaGMPpRhK01NXT6aTPVCQm3N7f9/RU+Gm0evkogaBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks Christian, I will resend with your suggestions included.

Nirmoy

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Friday, May 28, 2021 10:01 AM
To: Das, Nirmoy <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v3 4/6] drm/amdgpu: switch to amdgpu_bo_vm for vm code



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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
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
> @@ -692,12 +692,13 @@ int amdgpu_vm_validate_pt_bos(struct 
> amdgpu_device *adev, struct amdgpu_vm *vm,
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
>   	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) { @@ -957,10 
> +977,11 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
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
> @@ -968,7 +989,7 @@ static int amdgpu_vm_alloc_pts(struct 
> amdgpu_device *adev,
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
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) { @@ 
> -2843,7 +2867,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
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

I think it would be simpler if you make the parameter to amdgpu_vm_sdma_map_table a vmbo in the first place.

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

Same for amdgpu_vm_sdma_map_table(), just make the parameter a vmbo in the first place.

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
> @@ -238,8 +238,8 @@ static int amdgpu_vm_sdma_update(struct 
> amdgpu_vm_update_params *p,
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
> @@ -248,7 +248,7 @@ static int amdgpu_vm_sdma_update(struct 
> amdgpu_vm_update_params *p,
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
