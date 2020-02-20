Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EEAC5ACC4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 02:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677DD2465D
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 02:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FbAfJfZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677DD2465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276996E8A1;
	Thu, 20 Feb 2020 02:13:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4286E8A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 02:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImvyBdCbv0QeSjP52WDaAIBIAQgo3t/4mMXoHMlf9BFNEpi3W84HDihd5y2XrwgSu4ZY8d75ep2TUesTq4VdG8iDukK7EIpr/EtvD4vZEUIjurG4RTGT/vmfZ5PDHEqG87lAn9wKmQtHN9Q4b+tAzEv7JyUFkgX18aotYKBZzOHi3Y/VcXxhZxcxgXhKCHUdJgfNeK4tFVCYEzw/mnafZbVkS6qFFD8zN0Us3YC1dZ88Cb59OkiewoAG4Moe3sb4Qv0lTEIFGiQXDIRbPvTWHH8ZFQyU6vA1NPYiBIZKUBVEidksdyonmnKiXtRVMbHWknu0823hUvDHviqs26xH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdnpAzgARC//8yPr6qK5B5lBMdeOwg9PX7+UXr6SuC8=;
 b=WFY/dkVijKfu305yX/Lwnd5c2bFQgXftt+l3uOoroIhd+d/w/UwImvsC8Tf8KqPUxFI/LvNrAgBujX1z+jFKsibKsyT22sLRGmb2R7AyLW9st9nzisnnYPoXu9KBISIdlQdga5NmNGpzeiE1yeC5I2M/u2/Vd0d2g8f9v7OAvWZIZhsNkRPOlhXCB0401GGezjN1NvmkUGj0zUUcYwll+bsBOfwu3pybxZSZLeVXaNZmQ1GBEv4aE4lUIKrLFY4Knrpt+NIuQmIrdLFZH1fKVzd4IAZbuA4PxxV/Ba6wpWPdPFfIgIOEv0xacAV+tvMEBzpQi7gNSYJSWWu7eGTsxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdnpAzgARC//8yPr6qK5B5lBMdeOwg9PX7+UXr6SuC8=;
 b=FbAfJfZy7eYQu6VAStwEdjR/oLvLwnRPjjb8gSt/vgsuM/mfhCIYIrM2T9ei8ze6wGSCscj6Jald2x2ZDYOGZ5wrgTbUgdiLzcMUvDD1A6rxf1XTdvz6yHWBatzvJrG7MtiL5wMKoG68J5w35taMQz1Bnz4izmPD9JgwhrzgbaI=
Received: from MWHPR12MB1406.namprd12.prod.outlook.com (10.169.207.13) by
 MWHPR12MB1773.namprd12.prod.outlook.com (10.175.52.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 20 Feb 2020 02:13:50 +0000
Received: from MWHPR12MB1406.namprd12.prod.outlook.com
 ([fe80::b029:90fd:e576:2b68]) by MWHPR12MB1406.namprd12.prod.outlook.com
 ([fe80::b029:90fd:e576:2b68%5]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 02:13:50 +0000
From: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "He, Jacob"
 <Jacob.He@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
Thread-Topic: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
Thread-Index: AQHV5w2KvhLwlJGH906PcncqCOU+FqgiWh+AgAD9lNA=
Date: Thu, 20 Feb 2020 02:13:49 +0000
Message-ID: <MWHPR12MB1406B3418562F0692572C511B4130@MWHPR12MB1406.namprd12.prod.outlook.com>
References: <20200219101506.16779-1-jacob.he@amd.com>
 <e2fea4f5-0eea-75b5-9cd7-68b603629d8d@gmail.com>
In-Reply-To: <e2fea4f5-0eea-75b5-9cd7-68b603629d8d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-20T02:13:46Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=71dc1940-d897-4428-8fb1-000044a8776f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-20T02:13:46Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: baa6c249-4022-4240-b792-0000ad5a11b0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David1.Zhou@amd.com; 
x-originating-ip: [240e:e0:8c36:100:92b:b151:6113:e962]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef0a4b8a-12a2-4da5-93f5-08d7b5aa8679
x-ms-traffictypediagnostic: MWHPR12MB1773:|MWHPR12MB1773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB17737AD7B26A596D16B72050B4130@MWHPR12MB1773.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(189003)(199004)(9686003)(186003)(53546011)(316002)(71200400001)(6506007)(110136005)(55016002)(5660300002)(76116006)(81156014)(66946007)(66446008)(64756008)(66556008)(45080400002)(66476007)(7696005)(81166006)(2906002)(478600001)(966005)(86362001)(66574012)(33656002)(8936002)(52536014)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1773;
 H:MWHPR12MB1406.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PsIIiZ1W0wFi99VYNv0VB9havOm6jx3Ef3/uPHiOnCvX0HgD4kTEiFLNolkUrQtSvLyWfwDGL7iG/d3nM/1gnMSmM8jUqYwvRWO72UsV0lk9z7a+FGKXmGWb/hcyQWCWzzsOwChdl+ed2omwDowNOGcfTJG6ZFeoF0JL/h7D5mYFBkswMow8y4vrgfz5JOgS+aCnHHcEMB+M3WqbRFLsie+14sslRzcvAvX/vB7AmTQwVeS7md7S/weEBHB4mX/HsKBPA3iGZloY2BrGYaL375m/mH+OAtSq6fOVquVK91I+I7uc10Dzsd6oXjZS8qe+LG8sc/vp9586sMYYYaPKf8CPfNyQju7Vc+xO6c7tvYzAAVd70W3yDV9SOUQE22oiTPoi5gkkt+ml6vGa2O9lEEPfgfQQg2fh3jM/U4ZAIB+KdvgWOtbmsQ3Niy5VVJY6adrIzFn3GjO98LtyTWxQTaP/fe4mlFhF+3eJ50LDakBVmEyujLwf09C+6XpkhNA2UtOVN+nzKAqNnFmvlXn8oQ==
x-ms-exchange-antispam-messagedata: M912sXBsBBEMInUpmO3C3Eo5zgazGeNwwQ9dxU7yVffjd072BBJc0VIsOkuKAIEx7b2v1AsXb0qQPHhNX5LsmQCQ2XIytioownfGNxFE4wfcXF3JtwcXMdiQ4cTHDW1Cs0eO4ChpzkdFpmr2pIk1YjH4glsuMNSGMFxAhinkEnhWHUKy8XYg2PTAOiatLA9r9dMTBBd/ot5eP1GbnpKnMA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0a4b8a-12a2-4da5-93f5-08d7b5aa8679
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 02:13:49.9467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wc2r3lygV0vQkCBMX/99QF56vaPt85fNK9LZScvcXn5mVIVazlQPzFVX+sDxeQ95
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1773
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Christian is right here, that will cause many problems for simply using VMI=
D in kernel.
We already have an pair interface for RGP, I think you can use it instead o=
f involving additional kernel change.
amdgpu_vm_reserve_vmid/ amdgpu_vm_unreserve_vmid.

-David

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christia=
n K=F6nig
Sent: Wednesday, February 19, 2020 7:03 PM
To: He, Jacob <Jacob.He@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace

Am 19.02.20 um 11:15 schrieb Jacob He:
> [WHY]
> When SPM trace enabled, SPM_VMID should be updated with the current =

> vmid.
>
> [HOW]
> Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can tell us =

> which job should update SPM_VMID.
> Right before a job is submitted to GPU, set the SPM_VMID accordingly.
>
> [Limitation]
> Running more than one SPM trace enabled processes simultaneously is =

> not supported.

Well there are multiple problems with that patch.

First of all you need to better describe what SPM tracing is in the commit =
message.

Then the updating of mmRLC_SPM_MC_CNTL must be executed asynchronously on t=
he ring. Otherwise we might corrupt an already executing SPM trace.

And you also need to make sure to disable the tracing again or otherwise we=
 run into a bunch of trouble when the VMID is reused.

You also need to make sure that IBs using the SPM trace are serialized with=
 each other, e.g. hack into amdgpu_ids.c file and make sure that only one V=
MID at a time can have that attribute.

Regards,
Christian.

>
> Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666
> Signed-off-by: Jacob He <jacob.he@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 10 +++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15 ++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15 ++++++++++++++-
>   8 files changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c =

> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index f9fa6e104fef..3f32c4db5232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -113,6 +113,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p, union drm_amdgpu_cs
>   	uint32_t uf_offset =3D 0;
>   	int i;
>   	int ret;
> +	bool update_spm_vmid =3D false;
>   =

>   	if (cs->in.num_chunks =3D=3D 0)
>   		return 0;
> @@ -221,6 +222,10 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_pa=
rser *p, union drm_amdgpu_cs
>   		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
>   			break;
>   =

> +		case AMDGPU_CHUNK_ID_SPM_TRACE:
> +			update_spm_vmid =3D true;
> +			break;
> +
>   		default:
>   			ret =3D -EINVAL;
>   			goto free_partial_kdata;
> @@ -231,6 +236,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p, union drm_amdgpu_cs
>   	if (ret)
>   		goto free_all_kdata;
>   =

> +	p->job->need_update_spm_vmid =3D update_spm_vmid;
> +
>   	if (p->ctx->vram_lost_counter !=3D p->job->vram_lost_counter) {
>   		ret =3D -ECANCELED;
>   		goto free_all_kdata;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c =

> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index cae81914c821..36faab12b585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -156,9 +156,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, uns=
igned num_ibs,
>   		return -EINVAL;
>   	}
>   =

> -	if (vm && !job->vmid) {
> -		dev_err(adev->dev, "VM IB without ID\n");
> -		return -EINVAL;
> +	if (vm) {
> +		if (!job->vmid) {
> +			dev_err(adev->dev, "VM IB without ID\n");
> +			return -EINVAL;
> +		} else if (adev->gfx.rlc.funcs->update_spm_vmid && job->need_update_sp=
m_vmid) {
> +			adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
> +		}
>   	}
>   =

>   	alloc_size =3D ring->funcs->emit_frame_size + num_ibs * diff --git =

> a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h =

> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 2e2110dddb76..4582536961c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -52,6 +52,7 @@ struct amdgpu_job {
>   	bool                    vm_needs_flush;
>   	uint64_t		vm_pd_addr;
>   	unsigned		vmid;
> +	bool			need_update_spm_vmid;
>   	unsigned		pasid;
>   	uint32_t		gds_base, gds_size;
>   	uint32_t		gws_base, gws_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h =

> b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> index d3d4707f2168..52509c254cbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -126,6 +126,7 @@ struct amdgpu_rlc_funcs {
>   	void (*stop)(struct amdgpu_device *adev);
>   	void (*reset)(struct amdgpu_device *adev);
>   	void (*start)(struct amdgpu_device *adev);
> +	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
>   };
>   =

>   struct amdgpu_rlc {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c =

> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 5e9fb0976c6c..91eb788d6229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4214,6 +4214,18 @@ static int gfx_v10_0_update_gfx_clock_gating(struc=
t amdgpu_device *adev,
>   	return 0;
>   }
>   =

> +static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, =

> +unsigned vmid) {
> +	u32 data;
> +
> +	data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> +
> +	data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> +	data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << =

> +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +
> +	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
> +
>   static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =3D {
>   	.is_rlc_enabled =3D gfx_v10_0_is_rlc_enabled,
>   	.set_safe_mode =3D gfx_v10_0_set_safe_mode, @@ -4224,7 +4236,8 @@ =

> static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =3D {
>   	.resume =3D gfx_v10_0_rlc_resume,
>   	.stop =3D gfx_v10_0_rlc_stop,
>   	.reset =3D gfx_v10_0_rlc_reset,
> -	.start =3D gfx_v10_0_rlc_start
> +	.start =3D gfx_v10_0_rlc_start,
> +	.update_spm_vmid =3D gfx_v10_0_update_spm_vmid
>   };
>   =

>   static int gfx_v10_0_set_powergating_state(void *handle, diff --git =

> a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c =

> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 8f20a5dd44fe..b24fc55cf13a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4221,7 +4221,8 @@ static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_f=
uncs =3D {
>   	.resume =3D gfx_v7_0_rlc_resume,
>   	.stop =3D gfx_v7_0_rlc_stop,
>   	.reset =3D gfx_v7_0_rlc_reset,
> -	.start =3D gfx_v7_0_rlc_start
> +	.start =3D gfx_v7_0_rlc_start,
> +	.update_spm_vmid =3D NULL
>   };
>   =

>   static int gfx_v7_0_early_init(void *handle) diff --git =

> a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c =

> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fa245973de12..66640d2b6b37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5600,7 +5600,8 @@ static const struct amdgpu_rlc_funcs iceland_rlc_fu=
ncs =3D {
>   	.resume =3D gfx_v8_0_rlc_resume,
>   	.stop =3D gfx_v8_0_rlc_stop,
>   	.reset =3D gfx_v8_0_rlc_reset,
> -	.start =3D gfx_v8_0_rlc_start
> +	.start =3D gfx_v8_0_rlc_start,
> +	.update_spm_vmid =3D NULL
>   };
>   =

>   static void gfx_v8_0_update_medium_grain_clock_gating(struct =

> amdgpu_device *adev, diff --git =

> a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c =

> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 9b7ff783e9a5..df872f949f68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4704,6 +4704,18 @@ static int gfx_v9_0_update_gfx_clock_gating(struct=
 amdgpu_device *adev,
>   	return 0;
>   }
>   =

> +static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, =

> +unsigned vmid) {
> +	u32 data;
> +
> +	data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> +
> +	data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> +	data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << =

> +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +
> +	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
> +
>   static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =3D {
>   	.is_rlc_enabled =3D gfx_v9_0_is_rlc_enabled,
>   	.set_safe_mode =3D gfx_v9_0_set_safe_mode, @@ -4715,7 +4727,8 @@ =

> static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =3D {
>   	.resume =3D gfx_v9_0_rlc_resume,
>   	.stop =3D gfx_v9_0_rlc_stop,
>   	.reset =3D gfx_v9_0_rlc_reset,
> -	.start =3D gfx_v9_0_rlc_start
> +	.start =3D gfx_v9_0_rlc_start,
> +	.update_spm_vmid =3D gfx_v9_0_update_spm_vmid
>   };
>   =

>   static int gfx_v9_0_set_powergating_state(void *handle,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cdavid1.z=
hou%40amd.com%7C354be34ff18e4f424f6708d7b52b43b0%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637177069753914395&amp;sdata=3D9rSL4kgPJweuZ4EJpdqtqTxyC=
VGEkmsg6aUzbtvGFrs%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
