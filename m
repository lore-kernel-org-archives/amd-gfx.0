Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0365C11D05
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 15:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F88208CD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 15:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f7ynxLRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F88208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3202C6E8DC;
	Thu, 20 Feb 2020 15:13:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E776E8DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 15:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIBtnbSnuVI0z35Xas7T8tEC/Co+ecmb8mnGO+kZqd9YNb6uNCr34IokaJfP8URH4u0lNQsg7ZW8KpmgOWYyR855LjGpzhpcT8j65Nr6ENLPT4BcCa2vvP35lkAmkJBveaLDiFRma/mY9QpTlkpQW2Z88fcV8R2CcaWye7OMaMy2bsK5OjEIpyEOprETojyoV2OjLfkhhXMB0mjWa6OwfHtFY4FNXUSDsrm+P/XkKQpLymtrq94H0VK8C3vQyp5rK0momiyRkOr+7BFLnmXBMAkwJilq4oWDZIG9HjS7Fy90xLppQ0i5pfMpEsdVECBRiDcTtvQZcospzRLZ8Bp/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY6i6YXZWwG46MQQ4EmVuszCoTmhYDWD9dH05UrYo3g=;
 b=NHwKgeP1mcSV6xVY2G+14sJ5IzZIctSDSaBeKDvi2ZKyA5rcWh+lnKY65CaaDMs/oJOfb44ZNWk4UBBVhFUaJ7WVFOvtiQC5exyorl8O7GfTdDSdVe8MTHJQPBwx6swP/QHREVPuwiOTflkgstfE7ValuiCqtchzkaT4zAAwv3UcvRzunTY+BRCI685r6cFSHB0Ba87kBqGHyByG70qyOwlq7zITrntbcokAcSaLIymNU6ora50XX7glq4neyyMIX/50pxebrDTJbdgdWJJpqmDCfsO0QbXPcQmV226GQNLyXUNXbcQcjmOvUBIrRlkbMGzahbdsQX24SnXNXkTl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY6i6YXZWwG46MQQ4EmVuszCoTmhYDWD9dH05UrYo3g=;
 b=f7ynxLRTlivTOZ+6UghIQ8N+g5QdHUMEBG9EcV6TwHdUj6iKnCN2PlCJdGwYdkGCPde8d6J2K9MfpAxWouk7tF5V62lv7KN9DuVuZmb3BnSK8xP3vUG2OyfNgpYs3KDsRW0YUVbvfXHoGBMIbK4SPjrkLnf21Zmvmj1xTJDr1w8=
Received: from MN2PR12MB3376.namprd12.prod.outlook.com (20.178.240.148) by
 MN2PR12MB3743.namprd12.prod.outlook.com (10.255.237.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Thu, 20 Feb 2020 15:13:37 +0000
Received: from MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b]) by MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b%4]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 15:13:36 +0000
From: "He, Jacob" <Jacob.He@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
Thread-Topic: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
Thread-Index: AQHV5w2DvZzJMh9mOEKuDtk7HI5K26giWh+AgAHVnqk=
Date: Thu, 20 Feb 2020 15:13:35 +0000
Message-ID: <MN2PR12MB337654EB7B37A8C082EA0FA19B130@MN2PR12MB3376.namprd12.prod.outlook.com>
References: <20200219101506.16779-1-jacob.he@amd.com>,
 <e2fea4f5-0eea-75b5-9cd7-68b603629d8d@gmail.com>
In-Reply-To: <e2fea4f5-0eea-75b5-9cd7-68b603629d8d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-20T15:03:34.7355849Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f1f5eff-38eb-4332-11a4-08d7b6177510
x-ms-traffictypediagnostic: MN2PR12MB3743:|MN2PR12MB3743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3743FA99AEA9909C87400FFE9B130@MN2PR12MB3743.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:339;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(189003)(199004)(53546011)(33656002)(6506007)(55016002)(66574012)(9686003)(2906002)(26005)(186003)(7696005)(110136005)(71200400001)(316002)(66556008)(66446008)(66476007)(478600001)(66946007)(91956017)(76116006)(52536014)(8676002)(81156014)(8936002)(5660300002)(64756008)(81166006)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3743;
 H:MN2PR12MB3376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8yCzSztLTXgAU1xS+/KTJLf9EUSztB1Tm4KKPC9NPLO7383e3zYpslpbyhFT9GYkX5DYi52JXCxPfKuU3ZeSwREvnvp1WiYWDSuwA1YKalLZ5UiRakV4697hiEMzQ0YnQOqp5P4bUAhK8++cfvAhhi0jcQf30J7XqUgdwtaWEix/FXVFkhAVdx9ZMfVNRDjFOtsNzGRnn1MlZoSQEqL81+Dj3htd8eQd8eSl0WW7MNtimvLnWK+YST9nh3tFtBicxjdZ/7Djrj9L5AQLT4OpzdS7Qe5la6MqGOPC0acOQzvnCLB7NOGvWvUaLA/qcMBfiY2U8PD3ZziddouY1WS/Olu8z1/BpQ2vFB58Ib5T51u25EsdxtAua0NVJG8buZEcxpaZvrgebiEYtrGKWk3XIIuy8Ykhr15w2A3CKX2FmRxKdvjnmITLHLWoTz5YbuZF
x-ms-exchange-antispam-messagedata: fmBKd+mu/tNq6Qq5DfYZlQG/Sn+1Z7m1km6FmP8gFOV7M+qMmeljUxki5tuKwKoTJQe0iSmKfXADtUzwO9+W/ztY9C8wrf7/A1Ov44hDQtCihGmIt9cdYQkeNVKEU+z8osm92pi3BLXFo0Ejv6p8Hg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1f5eff-38eb-4332-11a4-08d7b6177510
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 15:13:35.7896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGTGZs1tmW3umcYs0bJbpr13Tn6vPez3M+k8vGkclm5HtaRilXv6jB96BSKTmhSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3743
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
Content-Type: multipart/mixed; boundary="===============0849958676=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0849958676==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB337654EB7B37A8C082EA0FA19B130MN2PR12MB3376namp_"

--_000_MN2PR12MB337654EB7B37A8C082EA0FA19B130MN2PR12MB3376namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Christian,
  This patch is just for a simple scenario. Multiple SPM processes is not s=
upported. That is saying, it=92s not necessary to take MCBP or other compli=
cated cases into account. UMD waits GPU idle right before enabling SPM trac=
e. Serialization is made by UMD.
  It=92s not necessary to clear mmRLC_SPM_MC_CNTL also. For those spm disab=
led submission, mmRLC_SPM_MC_CNTL is useless. For those spm enabled submiss=
ion, it will require KMD to update mmRLC_SPM_MC_CNTL.

Thanks
Jacob

From: Christian K=F6nig<mailto:ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, February 19, 2020 7:02 PM
To: He, Jacob<mailto:Jacob.He@amd.com>; amd-gfx@lists.freedesktop.org<mailt=
o:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace

Am 19.02.20 um 11:15 schrieb Jacob He:
> [WHY]
> When SPM trace enabled, SPM_VMID should be updated with the current
> vmid.
>
> [HOW]
> Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can tell us
> which job should update SPM_VMID.
> Right before a job is submitted to GPU, set the SPM_VMID accordingly.
>
> [Limitation]
> Running more than one SPM trace enabled processes simultaneously is
> not supported.

Well there are multiple problems with that patch.

First of all you need to better describe what SPM tracing is in the
commit message.

Then the updating of mmRLC_SPM_MC_CNTL must be executed asynchronously
on the ring. Otherwise we might corrupt an already executing SPM trace.

And you also need to make sure to disable the tracing again or otherwise
we run into a bunch of trouble when the VMID is reused.

You also need to make sure that IBs using the SPM trace are serialized
with each other, e.g. hack into amdgpu_ids.c file and make sure that
only one VMID at a time can have that attribute.

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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index f9fa6e104fef..3f32c4db5232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -113,6 +113,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p, union drm_amdgpu_cs
>        uint32_t uf_offset =3D 0;
>        int i;
>        int ret;
> +     bool update_spm_vmid =3D false;
>
>        if (cs->in.num_chunks =3D=3D 0)
>                return 0;
> @@ -221,6 +222,10 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_pa=
rser *p, union drm_amdgpu_cs
>                case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
>                        break;
>
> +             case AMDGPU_CHUNK_ID_SPM_TRACE:
> +                     update_spm_vmid =3D true;
> +                     break;
> +
>                default:
>                        ret =3D -EINVAL;
>                        goto free_partial_kdata;
> @@ -231,6 +236,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p, union drm_amdgpu_cs
>        if (ret)
>                goto free_all_kdata;
>
> +     p->job->need_update_spm_vmid =3D update_spm_vmid;
> +
>        if (p->ctx->vram_lost_counter !=3D p->job->vram_lost_counter) {
>                ret =3D -ECANCELED;
>                goto free_all_kdata;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index cae81914c821..36faab12b585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -156,9 +156,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, uns=
igned num_ibs,
>                return -EINVAL;
>        }
>
> -     if (vm && !job->vmid) {
> -             dev_err(adev->dev, "VM IB without ID\n");
> -             return -EINVAL;
> +     if (vm) {
> +             if (!job->vmid) {
> +                     dev_err(adev->dev, "VM IB without ID\n");
> +                     return -EINVAL;
> +             } else if (adev->gfx.rlc.funcs->update_spm_vmid && job->nee=
d_update_spm_vmid) {
> +                     adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmi=
d);
> +             }
>        }
>
>        alloc_size =3D ring->funcs->emit_frame_size + num_ibs *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.h
> index 2e2110dddb76..4582536961c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -52,6 +52,7 @@ struct amdgpu_job {
>        bool                    vm_needs_flush;
>        uint64_t                vm_pd_addr;
>        unsigned                vmid;
> +     bool                    need_update_spm_vmid;
>        unsigned                pasid;
>        uint32_t                gds_base, gds_size;
>        uint32_t                gws_base, gws_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_rlc.h
> index d3d4707f2168..52509c254cbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -126,6 +126,7 @@ struct amdgpu_rlc_funcs {
>        void (*stop)(struct amdgpu_device *adev);
>        void (*reset)(struct amdgpu_device *adev);
>        void (*start)(struct amdgpu_device *adev);
> +     void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
>   };
>
>   struct amdgpu_rlc {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 5e9fb0976c6c..91eb788d6229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4214,6 +4214,18 @@ static int gfx_v10_0_update_gfx_clock_gating(struc=
t amdgpu_device *adev,
>        return 0;
>   }
>
> +static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsign=
ed vmid)
> +{
> +     u32 data;
> +
> +     data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> +
> +     data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> +     data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC=
_CNTL__RLC_SPM_VMID__SHIFT;
> +
> +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
> +}
> +
>   static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =3D {
>        .is_rlc_enabled =3D gfx_v10_0_is_rlc_enabled,
>        .set_safe_mode =3D gfx_v10_0_set_safe_mode,
> @@ -4224,7 +4236,8 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_=
funcs =3D {
>        .resume =3D gfx_v10_0_rlc_resume,
>        .stop =3D gfx_v10_0_rlc_stop,
>        .reset =3D gfx_v10_0_rlc_reset,
> -     .start =3D gfx_v10_0_rlc_start
> +     .start =3D gfx_v10_0_rlc_start,
> +     .update_spm_vmid =3D gfx_v10_0_update_spm_vmid
>   };
>
>   static int gfx_v10_0_set_powergating_state(void *handle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 8f20a5dd44fe..b24fc55cf13a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4221,7 +4221,8 @@ static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_f=
uncs =3D {
>        .resume =3D gfx_v7_0_rlc_resume,
>        .stop =3D gfx_v7_0_rlc_stop,
>        .reset =3D gfx_v7_0_rlc_reset,
> -     .start =3D gfx_v7_0_rlc_start
> +     .start =3D gfx_v7_0_rlc_start,
> +     .update_spm_vmid =3D NULL
>   };
>
>   static int gfx_v7_0_early_init(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index fa245973de12..66640d2b6b37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5600,7 +5600,8 @@ static const struct amdgpu_rlc_funcs iceland_rlc_fu=
ncs =3D {
>        .resume =3D gfx_v8_0_rlc_resume,
>        .stop =3D gfx_v8_0_rlc_stop,
>        .reset =3D gfx_v8_0_rlc_reset,
> -     .start =3D gfx_v8_0_rlc_start
> +     .start =3D gfx_v8_0_rlc_start,
> +     .update_spm_vmid =3D NULL
>   };
>
>   static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_dev=
ice *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 9b7ff783e9a5..df872f949f68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4704,6 +4704,18 @@ static int gfx_v9_0_update_gfx_clock_gating(struct=
 amdgpu_device *adev,
>        return 0;
>   }
>
> +static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigne=
d vmid)
> +{
> +     u32 data;
> +
> +     data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> +
> +     data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> +     data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC=
_CNTL__RLC_SPM_VMID__SHIFT;
> +
> +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
> +}
> +
>   static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =3D {
>        .is_rlc_enabled =3D gfx_v9_0_is_rlc_enabled,
>        .set_safe_mode =3D gfx_v9_0_set_safe_mode,
> @@ -4715,7 +4727,8 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_f=
uncs =3D {
>        .resume =3D gfx_v9_0_rlc_resume,
>        .stop =3D gfx_v9_0_rlc_stop,
>        .reset =3D gfx_v9_0_rlc_reset,
> -     .start =3D gfx_v9_0_rlc_start
> +     .start =3D gfx_v9_0_rlc_start,
> +     .update_spm_vmid =3D gfx_v9_0_update_spm_vmid
>   };
>
>   static int gfx_v9_0_set_powergating_state(void *handle,


--_000_MN2PR12MB337654EB7B37A8C082EA0FA19B130MN2PR12MB3376namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Bookman Old Style";
	panose-1:2 5 6 4 5 5 5 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"#954F72">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Christian,</p>
<p class=3D"MsoNormal">&nbsp; This patch is just for a simple scenario. Mul=
tiple SPM processes is not supported. That is saying, it=92s not necessary =
to take MCBP or other complicated cases into account. UMD waits GPU idle ri=
ght before enabling SPM trace. Serialization
 is made by UMD.</p>
<p class=3D"MsoNormal">&nbsp; It=92s not necessary to clear mmRLC_SPM_MC_CN=
TL also. For those spm disabled submission, mmRLC_SPM_MC_CNTL is useless. F=
or those spm enabled submission, it will require KMD to update mmRLC_SPM_MC=
_CNTL.</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Jacob<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"mso-element:para-border-div;border:none;border-top:solid #E1E=
1E1 1.0pt;padding:3.0pt 0in 0in 0in">
<p class=3D"MsoNormal" style=3D"border:none;padding:0in"><b>From: </b><a hr=
ef=3D"mailto:ckoenig.leichtzumerken@gmail.com">Christian K=F6nig</a><br>
<b>Sent: </b>Wednesday, February 19, 2020 7:02 PM<br>
<b>To: </b><a href=3D"mailto:Jacob.He@amd.com">He, Jacob</a>; <a href=3D"ma=
ilto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace</p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 19.02.20 um 11:15 =
schrieb Jacob He:<br>
&gt; [WHY]<br>
&gt; When SPM trace enabled, SPM_VMID should be updated with the current<br=
>
&gt; vmid.<br>
&gt;<br>
&gt; [HOW]<br>
&gt; Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can tell us<br>
&gt; which job should update SPM_VMID.<br>
&gt; Right before a job is submitted to GPU, set the SPM_VMID accordingly.<=
br>
&gt;<br>
&gt; [Limitation]<br>
&gt; Running more than one SPM trace enabled processes simultaneously is<br=
>
&gt; not supported.<br>
<br>
Well there are multiple problems with that patch.<br>
<br>
First of all you need to better describe what SPM tracing is in the <br>
commit message.<br>
<br>
Then the updating of mmRLC_SPM_MC_CNTL must be executed asynchronously <br>
on the ring. Otherwise we might corrupt an already executing SPM trace.<br>
<br>
And you also need to make sure to disable the tracing again or otherwise <b=
r>
we run into a bunch of trouble when the VMID is reused.<br>
<br>
You also need to make sure that IBs using the SPM trace are serialized <br>
with each other, e.g. hack into amdgpu_ids.c file and make sure that <br>
only one VMID at a time can have that attribute.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666<br>
&gt; Signed-off-by: Jacob He &lt;jacob.he@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&nbsp; |&nbsp; 7 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c&nbsp; | 10 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |&nbsp; 1 &#43;<br=
>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |&nbsp; 1 &#43;<br=
>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp; | 15 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp;&nbsp; |&nbsp; =
3 &#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp; |&nbsp; =
3 &#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp; | 15 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; 8 files changed, 48 insertions(&#43;), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_cs.c<br>
&gt; index f9fa6e104fef..3f32c4db5232 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; @@ -113,6 &#43;113,7 @@ static int amdgpu_cs_parser_init(struct amdgpu=
_cs_parser *p, union drm_amdgpu_cs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uf_offset =3D 0;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool update_spm_vmid =3D false;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cs-&gt;in.num_chunks =3D=
=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -221,6 &#43;222,10 @@ static int amdgpu_cs_parser_init(struct amdgp=
u_cs_parser *p, union drm_amdgpu_cs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; case AMDGPU_CHUNK_ID_SPM_TRACE:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_spm_vmid =3D=
 true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fr=
ee_partial_kdata;<br>
&gt; @@ -231,6 &#43;236,8 @@ static int amdgpu_cs_parser_init(struct amdgpu=
_cs_parser *p, union drm_amdgpu_cs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto free_all_kdata;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;job-&gt;need_update_spm_vmid =3D u=
pdate_spm_vmid;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;ctx-&gt;vram_lost_=
counter !=3D p-&gt;job-&gt;vram_lost_counter) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D -ECANCELED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto free_all_kdata;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ib.c<br>
&gt; index cae81914c821..36faab12b585 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; @@ -156,9 &#43;156,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ri=
ng, unsigned num_ibs,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (vm &amp;&amp; !job-&gt;vmid) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(adev-&gt;dev, &quot;VM IB without ID\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (vm) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!job-&gt;vmid) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;de=
v, &quot;VM IB without ID\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid &amp;&amp; jo=
b-&gt;need_update_spm_vmid) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.fu=
ncs-&gt;update_spm_vmid(adev, job-&gt;vmid);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_size =3D ring-&gt;func=
s-&gt;emit_frame_size &#43; num_ibs *<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_job.h<br>
&gt; index 2e2110dddb76..4582536961c7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&gt; @@ -52,6 &#43;52,7 @@ struct amdgpu_job {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; vm_needs_flush;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_p=
d_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; need_update_spm_vmid;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasi=
d;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_=
base, gds_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gws_=
base, gws_size;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_rlc.h<br>
&gt; index d3d4707f2168..52509c254cbd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
&gt; @@ -126,6 &#43;126,7 @@ struct amdgpu_rlc_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*stop)(struct amdgpu_d=
evice *adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*reset)(struct amdgpu_=
device *adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*start)(struct amdgpu_=
device *adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void (*update_spm_vmid)(struct amdgpu_de=
vice *adev, unsigned vmid);<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amdgpu_rlc {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v10_0.c<br>
&gt; index 5e9fb0976c6c..91eb788d6229 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; @@ -4214,6 &#43;4214,18 @@ static int gfx_v10_0_update_gfx_clock_gatin=
g(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev,=
 unsigned vmid)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_M=
C_CNTL);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~RLC_SPM_MC_CNTL__RLC_SPM_=
VMID_MASK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (vmid &amp; RLC_SPM_MC_CNTL__R=
LC_SPM_VMID_MASK) &lt;&lt; RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, d=
ata);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlc_enabled =3D gfx_v10_=
0_is_rlc_enabled,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_safe_mode =3D gfx_v10_0=
_set_safe_mode,<br>
&gt; @@ -4224,7 &#43;4236,8 @@ static const struct amdgpu_rlc_funcs gfx_v10=
_0_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v10_0_rlc_re=
sume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v10_0_rlc_stop=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v10_0_rlc_res=
et,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v10_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v10_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D gfx_v10_0_update_sp=
m_vmid<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int gfx_v10_0_set_powergating_state(void *handle,<b=
r>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v7_0.c<br>
&gt; index 8f20a5dd44fe..b24fc55cf13a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; @@ -4221,7 &#43;4221,8 @@ static const struct amdgpu_rlc_funcs gfx_v7_=
0_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v7_0_rlc_res=
ume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v7_0_rlc_stop,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v7_0_rlc_rese=
t,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v7_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v7_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D NULL<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int gfx_v7_0_early_init(void *handle)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v8_0.c<br>
&gt; index fa245973de12..66640d2b6b37 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; @@ -5600,7 &#43;5600,8 @@ static const struct amdgpu_rlc_funcs iceland=
_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v8_0_rlc_res=
ume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v8_0_rlc_stop,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v8_0_rlc_rese=
t,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v8_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v8_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D NULL<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_update_medium_grain_clock_gating(stru=
ct amdgpu_device *adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v9_0.c<br>
&gt; index 9b7ff783e9a5..df872f949f68 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -4704,6 &#43;4704,18 @@ static int gfx_v9_0_update_gfx_clock_gating=
(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, =
unsigned vmid)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_M=
C_CNTL);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~RLC_SPM_MC_CNTL__RLC_SPM_=
VMID_MASK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (vmid &amp; RLC_SPM_MC_CNTL__R=
LC_SPM_VMID_MASK) &lt;&lt; RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, d=
ata);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlc_enabled =3D gfx_v9_0=
_is_rlc_enabled,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_safe_mode =3D gfx_v9_0_=
set_safe_mode,<br>
&gt; @@ -4715,7 &#43;4727,8 @@ static const struct amdgpu_rlc_funcs gfx_v9_=
0_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v9_0_rlc_res=
ume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v9_0_rlc_stop,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v9_0_rlc_rese=
t,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v9_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v9_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D gfx_v9_0_update_spm=
_vmid<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int gfx_v9_0_set_powergating_state(void *handle,<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB337654EB7B37A8C082EA0FA19B130MN2PR12MB3376namp_--

--===============0849958676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0849958676==--
