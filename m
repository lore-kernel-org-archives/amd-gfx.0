Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9482AC433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 02:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA4F2078B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 02:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KdbS0oEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA4F2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B096E566;
	Tue,  1 Sep 2020 02:45:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 978306E566
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 02:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEQq4to2MxXw6bOIqNqL6EJpMkW2pGpKbm9JvS40hO8foht+eXo4OSE9CV1Hv3ueXzR5qGQJEz3qtM0KUQWkZpWaboIgJQD8N2MUVVeb4ZnOvYZtMRUHjt+TcJROUYo8VudUaOVae0XnMtffixS85NuNV9njFZHpNndOwxj+m5kpzaRCs6pQD+uAoZwYgtY3D//99uiHwsYMXqLZQa1Wq07btgVJha45FwW5xipx7nusKJn1QxMsXFoCf/u0FbqCNPMGr8oCjayuyM0DCDFlAdScoJriKlcej/ITx3h9Q0Gp5q5tcRVHJXXklEg/9Cy4+Ec5yOJKUYnjWU5Fo7RO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFURZi0baw0E5G8glYRXdo3HUm9J3s633HFPKuDs6ig=;
 b=hOwRl1dLuQpWD9THawld8ihVBxDP1Y+QbbebdzyhoPYE7wrOQN/sbo3jjP7RG7l8I6fQFkUPgnbHB4QFv/w2+e2pv7aQmY5f0HgSnqgVPKcC7dASBadomeYzGANmdN1gdvrGIxD0KgS0V5GN3VE2FyQ9hRYraJW2LTAC0wPegSJoxa7Ig+yZAteINSFjkLUlSA0dyDjYJEw2kMAjMeVXhSf7yLFFoVgW3rMEdRmQ+kX9NB2lH64dt0JHs6YMh/MiS6ebqsVtHdAgzdqPxqxnmlImAbz4ScQSt1GhRU8nCWoG6yzcQ2drnr0IXGG9eRSSV6lsbFYKqUEEzt5HbugPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFURZi0baw0E5G8glYRXdo3HUm9J3s633HFPKuDs6ig=;
 b=KdbS0oEZ/5aqg7MFcbkAuPebJ2I9QvEVHf8gyyQ9Fk762LB1ewBFP+L9LFnxfGIbV9AaAb71XO57bWa6awkxU6yaRpi3BzJbmgeCLiFfaYVUn3UvJF41oH416I9yw+0Gh06OqiXDj9AsTkGW5Y7ABPsdhrI8MNuJ3Y5JJxE9dow=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB2905.namprd12.prod.outlook.com (2603:10b6:5:181::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.21; Tue, 1 Sep 2020 02:45:15 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 02:45:15 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: block ring buffer access during GPU recovery
Thread-Topic: [PATCH] drm/amdgpu: block ring buffer access during GPU recovery
Thread-Index: AQHWf/26T+5V1loKy0aUUBxKhlJiQqlTAaGAgAAQ1oA=
Date: Tue, 1 Sep 2020 02:45:14 +0000
Message-ID: <DM5PR12MB25336BB24DD7E7E6BCD04A4AED2E0@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200901011727.14059-1-Dennis.Li@amd.com>
 <41d0b931-653a-0aba-2ab8-b51c459b2012@amd.com>
In-Reply-To: <41d0b931-653a-0aba-2ab8-b51c459b2012@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-01T02:45:08Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e91f73df-e1de-498f-8624-9697260b3f6e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a56b0ba-4d19-4dc6-a5d0-08d84e210e33
x-ms-traffictypediagnostic: DM6PR12MB2905:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2905112FC11BDB84D6B4C483ED2E0@DM6PR12MB2905.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LdUX9aUX1og2M03GF2oPfWeElyRupoAZKnqQ9ITva2MkVXGw7PGmzfqT8wdzTOgDVrz9m6kBnjaHjnTYDidSO7zwvVxrAh5DON40kISEFiqDGpyoqZus594fWhZE70dHp1wbSWfFg/c2JJKALa5Lr54hCRO/tqeaBq6b1Io30jWfHWtTfWQ3H95YazP3140cUJUYpqyYxEWV7KOiZ7vBjGhm/yrgOZbIN5lU6vCnaGAQr7YB1jc8LNaZAX+uHGj02BTdpa+z+HrLDsEO6v3Z68dYAloGKo/EUuU0xb+eFyjdw/qntK2hPHQ4NHXxukH24MkO2qefQ97o3i3/GuITXZmQTeLspSWjI4TdRCc1QLHDD1EdqWmuG8Qu/gbXMq3e
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(8676002)(83380400001)(6636002)(66446008)(2906002)(478600001)(186003)(5660300002)(66476007)(71200400001)(316002)(9686003)(33656002)(66556008)(55016002)(76116006)(110136005)(64756008)(66946007)(26005)(7696005)(8936002)(86362001)(52536014)(6506007)(53546011)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: HU3sN9LanNn5v0bcPvr/UZgvUKO1Ek3WmSqBXy/dzjarc2mln6gETbrTKciTW8gg4ZSI9N1ucupWcQi3L/BseNkOq4kupyy9jtf+SjsTUc6oM/x1ou221nsqXXhhTBJuLgwj4UK4sKQ1/nGyPeROGWThTjroQVJsV3813p8KmbHmM4ywvuK/BfDnQhe/dZurUWEUadWxbbugVXhStKDQKJQB4LdCU0ef2fGhSeMC57YjOmN4Uaal5pA8NbT2iQyve5oIPZKUhATl5qtiW4xZjBdLtd/JxBwHQLV6anXj9v6aQ5jWl1pLi7zvojHFoOuwkbz9y7M4VDJJdH3APFeQ87DRBd1V6/UzywpeT3nd3u4Qu/RTM/FBs4aNSLfl6XW+xpr7WgSQZa0hS6Oxm2Bi0qhkVN0kL5owJ0st4ATNvSMu+viVi8j0rt+LggauWX1GTZV0Jhp2rSz7RxW4TYRIn2R7aUjRV4V3/OltaY/dEgFS7TLuApPHRW5UjGrR4BmP+tEPTTcl+nb7/JwcJHal3Eqbme0zbmNkG+UsvaU/IByZ0gS7bd40apX4O72cxkRzSftnkFSibYRNK8h4Cxv/WYv3lySTmUMudY1UP+5Yuj72hV4bH9wwca4KfHZzsPmFgt5gvYu7h0CKBiY1vUsrZA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a56b0ba-4d19-4dc6-a5d0-08d84e210e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 02:45:15.0609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmVFwiyFmmf+LNMWGltNmkOc1cRrOR/qj77Kb5/CpLwXOmTPsYIHclBG0CSXyELH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2905
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi, Andrey,
    
RE- Isn't adev->reset_sem non-recursive ? How this works when you try to access registers from within GPU reset thread while adev->reset_sem is already write locked from amdgpu_device_lock_adev earlier in the same thread ?

Deli: down_read_trylock will fail in this case, return false immediately and will not lock adev->reset_sem. In GPU reset thread, we should use MMIO instead of KIQ to access registers. 

Best Regards
Dennis Li
-----Original Message-----
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com> 
Sent: Tuesday, September 1, 2020 9:40 AM
To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: block ring buffer access during GPU recovery


On 8/31/20 9:17 PM, Dennis Li wrote:
> When GPU is in reset, its status isn't stable and ring buffer also 
> need be reset when resuming. Therefore driver should protect GPU 
> recovery thread from ring buffer accessed by other threads. Otherwise 
> GPU will randomly hang during recovery.
>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 172dc47b7f39..8db56a22cd1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -319,8 +319,13 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   {
>   	uint32_t ret;
>   
> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
> -		return amdgpu_kiq_rreg(adev, reg);
> +	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		amdgpu_sriov_runtime(adev) &&
> +		down_read_trylock(&adev->reset_sem)) {
> +		ret = amdgpu_kiq_rreg(adev, reg);
> +		up_read(&adev->reset_sem);
> +		return ret;
> +	}


Isn't adev->reset_sem non-recursive ? How this works when you try to access registers from within GPU reset thread while adev->reset_sem is already write locked from amdgpu_device_lock_adev earlier in the same thread ?

Andrey


>   
>   	if ((reg * 4) < adev->rmmio_size)
>   		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4)); @@ -332,6 
> +337,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
>   		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>   	}
> +
>   	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
>   	return ret;
>   }
> @@ -407,8 +413,13 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>   void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>   		    uint32_t acc_flags)
>   {
> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
> -		return amdgpu_kiq_wreg(adev, reg, v);
> +	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		amdgpu_sriov_runtime(adev) &&
> +		down_read_trylock(&adev->reset_sem)) {
> +		amdgpu_kiq_wreg(adev, reg, v);
> +		up_read(&adev->reset_sem);
> +		return;
> +	}
>   
>   	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index ad9ad622ccce..4ea2a065daa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -287,7 +287,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	 */
>   	if (adev->gfx.kiq.ring.sched.ready &&
>   	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> -	    !amdgpu_in_reset(adev)) {
> +	    down_read_trylock(&adev->reset_sem)) {
>   
>   		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>   		const unsigned eng = 17;
> @@ -297,6 +297,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct 
> amdgpu_device *adev, uint32_t vmid,
>   
>   		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>   				1 << vmid);
> +
> +		up_read(&adev->reset_sem);
>   		return;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index e1a0ae327cf5..33b7cf1c79ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -501,12 +501,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	 */
>   	if (adev->gfx.kiq.ring.sched.ready &&
>   			(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> -			!amdgpu_in_reset(adev)) {
> +			down_read_trylock(&adev->reset_sem)) {
>   		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>   		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>   
>   		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>   						   1 << vmid);
> +		up_read(&adev->reset_sem);
>   		return;
>   	}
>   
> @@ -599,7 +600,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	if (amdgpu_in_reset(adev))
>   		return -EIO;
>   
> -	if (ring->sched.ready) {
> +	if (ring->sched.ready &&
> +		 down_read_trylock(&adev->reset_sem)) {
>   		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
>   		 * heavy-weight TLB flush (type 2), which flushes
>   		 * both. Due to a race condition with concurrent @@ -626,6 +628,7 
> @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   		if (r) {
>   			amdgpu_ring_undo(ring);
>   			spin_unlock(&adev->gfx.kiq.ring_lock);
> +			up_read(&adev->reset_sem);
>   			return -ETIME;
>   		}
>   
> @@ -634,9 +637,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
>   		if (r < 1) {
>   			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
> +			up_read(&adev->reset_sem);
>   			return -ETIME;
>   		}
> -
> +		up_read(&adev->reset_sem);
>   		return 0;
>   	}
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
