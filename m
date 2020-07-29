Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02678C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7AC207E8
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EDiHjeh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7AC207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881116E431;
	Wed, 29 Jul 2020 02:34:17 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750042.outbound.protection.outlook.com [40.107.75.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5356E430
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhjnMN3gcSiEmFzQbTZALkcsgTlCgR38GZAm3pKBu448MKALw2pjP6WiaDqoaR44kuHj98fjtttdcvm5iDJyGrpu9jVtC1jxTdDcg13mBOrzOf4a/jNC94fKMJMdsAPruqPh29MJR4fOuI1skLSE9j4BDYCeab2MlXn31NB9by2YFvp/n0uK4yBnZq45hBOyu0dudDHi9+8DjtjwQxoSd9xbto++A9wu2LpbM7k6fHMwMiLCG5k1L3Cti1CxTWXzTQyt9GuO2L93G/yIxulkcTIEwtbBVM977WXj3RuJpWkKXKRetVp7TtUyAUkyu2N5DUvknzn28PywruFo0Rd+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ds04Mj24J2MEhhzIwRRu6o28W8u1uRishJdJqYfVHg=;
 b=BQdZaJKsxQfx5y3+k0kjLSVc01ifV+gSeosLAZoFs2DyF1WwpztGdUqclrfc5nUPUC8o7Yr8OVYsv95hMw0U7SLL29oq7GGRC24QzSYOdIcuKTPw+TkCpePQVR7aW67f7MRPROZ5dpoKIihvndnULokggmw0OpmGINCu1eDV0/iInOzLmV6+qkCSxR36M1g1rH+UMX418/WpujaJeng4N2OwuNpScQD7riv3daKddeosWV4czfciJOm4M14Rz2J5RE+72T2yrUu8w7WciD1oNdjCb69zPIFQjNVE4N+Jt6FTgM3E+pEYvUY9wsenLtGL19Ndg7JnswCZ7aUJdqNg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ds04Mj24J2MEhhzIwRRu6o28W8u1uRishJdJqYfVHg=;
 b=EDiHjeh9FaE06OI7GOoCU+IzBkUsSDswnEIsF6l9ImGVIrbvrwvpqLZimqPIntqS+Vb+OURPjvfelAzlODYtEbpoJc8uHXufT1xWd6b5uqA5AJZaHyRUpq4nhAV4flhpAFv5tjt/ihO0Bo2gxDlHu3B4I9+rHOkaRDPVVJQneDs=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Wed, 29 Jul
 2020 02:34:10 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::391f:5cf2:69c7:9962]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::391f:5cf2:69c7:9962%7]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 02:34:10 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: add interface amdgpu_gfx_init_spm_golden
 for Navi1x
Thread-Topic: [PATCH 1/2] drm/amdgpu: add interface amdgpu_gfx_init_spm_golden
 for Navi1x
Thread-Index: AQHWZJ/If51w3Fy480WoSev5UcYb2qkdUOCAgACHP7A=
Date: Wed, 29 Jul 2020 02:34:09 +0000
Message-ID: <BY5PR12MB37773E8A11E29E6E7D55726495700@BY5PR12MB3777.namprd12.prod.outlook.com>
References: <20200728052717.21071-1-tianci.yin@amd.com>,
 <737bbfe1-a030-b411-5ba2-e0704c03c76c@amd.com>
In-Reply-To: <737bbfe1-a030-b411-5ba2-e0704c03c76c@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-29T02:34:09.412Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e882a24c-e09b-4e47-89c9-08d83367dfb6
x-ms-traffictypediagnostic: BYAPR12MB3240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3240388DF2EDF3DB5769B64295700@BYAPR12MB3240.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2Y++LG0S79vJqc8TWQGlJiOd5ADZkeAIxI87rjIqBALX2itggta6ttsC8U5JhdbDgGZCmxxYLytNgCh8IKhzlaYkUDm/1xi8zPl0omCtMkU3zkXBtFOvYuZ7w+xUav4V1LCuozJxQ0XRXZsb4eWWaZCKX1NY60DrjMdMUtsQU27d0wldTL2Gm40SSdTOs1RZh3BNFJMjICWVjSaubCVvwaS8yzG5/AhBZVwW1dYKyNk+r/6P/ktDKr18Yq2vADV7fBW09tab0lT0hZDL/lDI0Ka+q9mzRTUl/3JNIO/JKgWeLnY3mp8OCMwhVZJP8Pxm3DMUdOhdeGdHh7DsfipkD/WTkucl0By44njMCG5sxHG4PI8oe+saYp2QovjwovB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3777.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(33656002)(66946007)(316002)(53546011)(71200400001)(4326008)(8676002)(26005)(66446008)(6506007)(52536014)(5660300002)(66476007)(66556008)(64756008)(91956017)(76116006)(83380400001)(2906002)(478600001)(86362001)(8936002)(54906003)(110136005)(186003)(7696005)(55016002)(19627405001)(9686003)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: OZ22d3L/z4FDklHUrEyepWreb0K2LYkTheMbsRmwlKVpDcpuEVTM9QWmY/jOk1UcpOcVdtGaJsJ3PPzQx65UAahDYRANkWzJ8nIbym0bCch/inoWo/sGp3WPnFW+8eFSVuLikp0V2PBJKA8UybeCb1gSNAd86IX+wnEZpRLLSlEsmt8feMYWQ0M8QpthqOO3MbDqvtFWtSjfaT9ICWZFt+Dgv2L1hyKEDPegdjKo7LLomBqs1rNFgUybzaeZoavLWLuhOl7Xr2I1hPCPNIEHeH8nDjbG4yYD+IqozSsYkfZ6IKh9Lfa3DdIRIyCqu36YtWGfJ3kS8sT1qk7U0h6And8ZE2Hgg78bCPw/4neVvoMSCllm71RPNrTSSVqdj38vKBRNNvZSlkVsAPo3IPZjsKKlABV6kb1xPo4m7HLECCCk19Fj5d4nx5HUICrHPWh5kr7D5vub4t+ssOViJnUkpfZQ8nwqh0wg8uewf8ciLf0kMXINo+XFcoesWGA8K6WE
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e882a24c-e09b-4e47-89c9-08d83367dfb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 02:34:09.8856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgU6FOHD6z/Pt5rXs0qDEu1H5JYQfGTLlqEYqQFqLhBxlC9XjRaJR6NtOsOlHvWa86chkPl22DOBcQHkAtp8ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3240
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Hesik,
 Christopher" <Christopher.Hesik@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Swamy,
 Manjunatha" <Manjunatha.Swamy@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0175067116=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0175067116==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB37773E8A11E29E6E7D55726495700BY5PR12MB3777namp_"

--_000_BY5PR12MB37773E8A11E29E6E7D55726495700BY5PR12MB3777namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks very much Luben!

Regards,
Rico
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, July 29, 2020 2:29
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Hesik, Christopher <Christ=
opher.Hesik@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, E=
van <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add interface amdgpu_gfx_init_spm_gold=
en for Navi1x

On 2020-07-28 1:27 a.m., Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit,

Use present tense:............... " are lost after "

> reconfiguration is needed. Make the configuration code as an interface fo=
r

Add "so a reconfiguration is needed. "

> future use.
>

If the lines of your commit message are too long, then "git push" complains
about them. Sixty char wide is perfect, since "git log" indents them when
displaying them.

With this fixed, then Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> Change-Id: I172f3dc7f59da69b0364052dcad75a9c9aab019e
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 34 ++++++++++++++++++-------
>  2 files changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 1e7a2b0997c5..a611e78dd4ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -216,6 +216,7 @@ struct amdgpu_gfx_funcs {
>        int (*ras_error_inject)(struct amdgpu_device *adev, void *inject_i=
f);
>        int (*query_ras_error_count) (struct amdgpu_device *adev, void *ra=
s_error_status);
>        void (*reset_ras_error_count) (struct amdgpu_device *adev);
> +     void (*init_spm_golden)(struct amdgpu_device *adev);
>  };
>
>  struct sq_work {
> @@ -324,6 +325,7 @@ struct amdgpu_gfx {
>  #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gp=
u_clock_counter((adev))
>  #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.func=
s->select_se_sh((adev), (se), (sh), (instance))
>  #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx=
.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
> +#define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_gol=
den((adev))
>
>  /**
>   * amdgpu_gfx_create_bitmask - create a bitmask
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index db9f1e89a0f8..da21ad04ac0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3307,6 +3307,29 @@ static void gfx_v10_0_set_kiq_pm4_funcs(struct amd=
gpu_device *adev)
>        adev->gfx.kiq.pmf =3D &gfx_v10_0_kiq_pm4_funcs;
>  }
>
> +static void gfx_v10_0_init_spm_golden_registers(struct amdgpu_device *ad=
ev)
> +{
> +     switch (adev->asic_type) {
> +     case CHIP_NAVI10:
> +             soc15_program_register_sequence(adev,
> +                                             golden_settings_gc_rlc_spm_=
10_0_nv10,
> +                                             (const u32)ARRAY_SIZE(golde=
n_settings_gc_rlc_spm_10_0_nv10));
> +             break;
> +     case CHIP_NAVI14:
> +             soc15_program_register_sequence(adev,
> +                                             golden_settings_gc_rlc_spm_=
10_1_nv14,
> +                                             (const u32)ARRAY_SIZE(golde=
n_settings_gc_rlc_spm_10_1_nv14));
> +             break;
> +     case CHIP_NAVI12:
> +             soc15_program_register_sequence(adev,
> +                                             golden_settings_gc_rlc_spm_=
10_1_2_nv12,
> +                                             (const u32)ARRAY_SIZE(golde=
n_settings_gc_rlc_spm_10_1_2_nv12));
> +             break;
> +     default:
> +             break;
> +     }
> +}
> +
>  static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
>  {
>        switch (adev->asic_type) {
> @@ -3317,9 +3340,6 @@ static void gfx_v10_0_init_golden_registers(struct =
amdgpu_device *adev)
>                soc15_program_register_sequence(adev,
>                                                golden_settings_gc_10_0_nv=
10,
>                                                (const u32)ARRAY_SIZE(gold=
en_settings_gc_10_0_nv10));
> -             soc15_program_register_sequence(adev,
> -                                             golden_settings_gc_rlc_spm_=
10_0_nv10,
> -                                             (const u32)ARRAY_SIZE(golde=
n_settings_gc_rlc_spm_10_0_nv10));
>                break;
>        case CHIP_NAVI14:
>                soc15_program_register_sequence(adev,
> @@ -3328,9 +3348,6 @@ static void gfx_v10_0_init_golden_registers(struct =
amdgpu_device *adev)
>                soc15_program_register_sequence(adev,
>                                                golden_settings_gc_10_1_nv=
14,
>                                                (const u32)ARRAY_SIZE(gold=
en_settings_gc_10_1_nv14));
> -             soc15_program_register_sequence(adev,
> -                                             golden_settings_gc_rlc_spm_=
10_1_nv14,
> -                                             (const u32)ARRAY_SIZE(golde=
n_settings_gc_rlc_spm_10_1_nv14));
>                break;
>        case CHIP_NAVI12:
>                soc15_program_register_sequence(adev,
> @@ -3339,9 +3356,6 @@ static void gfx_v10_0_init_golden_registers(struct =
amdgpu_device *adev)
>                soc15_program_register_sequence(adev,
>                                                golden_settings_gc_10_1_2_=
nv12,
>                                                (const u32)ARRAY_SIZE(gold=
en_settings_gc_10_1_2_nv12));
> -             soc15_program_register_sequence(adev,
> -                                             golden_settings_gc_rlc_spm_=
10_1_2_nv12,
> -                                             (const u32)ARRAY_SIZE(golde=
n_settings_gc_rlc_spm_10_1_2_nv12));
>                break;
>        case CHIP_SIENNA_CICHLID:
>                soc15_program_register_sequence(adev,
> @@ -3360,6 +3374,7 @@ static void gfx_v10_0_init_golden_registers(struct =
amdgpu_device *adev)
>        default:
>                break;
>        }
> +     gfx_v10_0_init_spm_golden_registers(adev);
>  }
>
>  static void gfx_v10_0_scratch_init(struct amdgpu_device *adev)
> @@ -4147,6 +4162,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_=
funcs =3D {
>        .read_wave_sgprs =3D &gfx_v10_0_read_wave_sgprs,
>        .read_wave_vgprs =3D &gfx_v10_0_read_wave_vgprs,
>        .select_me_pipe_q =3D &gfx_v10_0_select_me_pipe_q,
> +     .init_spm_golden =3D &gfx_v10_0_init_spm_golden_registers,
>  };
>
>  static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
>


--_000_BY5PR12MB37773E8A11E29E6E7D55726495700BY5PR12MB3777namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks very much Luben!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 29, 2020 2:29<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; H=
esik, Christopher &lt;Christopher.Hesik@amd.com&gt;; Swamy, Manjunatha &lt;=
Manjunatha.Swamy@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;;
 Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: add interface amdgpu_gfx_init_s=
pm_golden for Navi1x</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2020-07-28 1:27 a.m., Tianci Yin wrote:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt; <br>
&gt; On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exi=
t,<br>
<br>
Use present tense:............... &quot; are lost after &quot;<br>
<br>
&gt; reconfiguration is needed. Make the configuration code as an interface=
 for<br>
<br>
Add &quot;so a reconfiguration is needed. &quot;<br>
<br>
&gt; future use.<br>
&gt; <br>
<br>
If the lines of your commit message are too long, then &quot;git push&quot;=
 complains<br>
about them. Sixty char wide is perfect, since &quot;git log&quot; indents t=
hem when<br>
displaying them.<br>
<br>
With this fixed, then Reviewed-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt=
;<br>
<br>
Regards,<br>
Luben<br>
<br>
&gt; Change-Id: I172f3dc7f59da69b0364052dcad75a9c9aab019e<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |&nbsp; 2 ++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp; | 34 ++++++++++++++=
++++-------<br>
&gt;&nbsp; 2 files changed, 27 insertions(+), 9 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gfx.h<br>
&gt; index 1e7a2b0997c5..a611e78dd4ba 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; @@ -216,6 +216,7 @@ struct amdgpu_gfx_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*ras_error_inject)(stru=
ct amdgpu_device *adev, void *inject_if);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*query_ras_error_count)=
 (struct amdgpu_device *adev, void *ras_error_status);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*reset_ras_error_count=
) (struct amdgpu_device *adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void (*init_spm_golden)(struct amdgpu_device=
 *adev);<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; struct sq_work {<br>
&gt; @@ -324,6 +325,7 @@ struct amdgpu_gfx {<br>
&gt;&nbsp; #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)-&gt;gfx.fu=
ncs-&gt;get_gpu_clock_counter((adev))<br>
&gt;&nbsp; #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)-&=
gt;gfx.funcs-&gt;select_se_sh((adev), (se), (sh), (instance))<br>
&gt;&nbsp; #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (ad=
ev)-&gt;gfx.funcs-&gt;select_me_pipe_q((adev), (me), (pipe), (q), (vmid))<b=
r>
&gt; +#define amdgpu_gfx_init_spm_golden(adev) (adev)-&gt;gfx.funcs-&gt;ini=
t_spm_golden((adev))<br>
&gt;&nbsp; <br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * amdgpu_gfx_create_bitmask - create a bitmask<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v10_0.c<br>
&gt; index db9f1e89a0f8..da21ad04ac0f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; @@ -3307,6 +3307,29 @@ static void gfx_v10_0_set_kiq_pm4_funcs(struct =
amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.kiq.pmf =3D &am=
p;gfx_v10_0_kiq_pm4_funcs;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +static void gfx_v10_0_init_spm_golden_registers(struct amdgpu_device =
*adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; soc15_program_register_sequence(adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_settings_gc_rlc_spm_10=
_0_nv10,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)ARRAY_SIZE(golden_=
settings_gc_rlc_spm_10_0_nv10));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; soc15_program_register_sequence(adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_settings_gc_rlc_spm_10=
_1_nv14,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)ARRAY_SIZE(golden_=
settings_gc_rlc_spm_10_1_nv14));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; soc15_program_register_sequence(adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_settings_gc_rlc_spm_10=
_1_2_nv12,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)ARRAY_SIZE(golden_=
settings_gc_rlc_spm_10_1_2_nv12));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static void gfx_v10_0_init_golden_registers(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) =
{<br>
&gt; @@ -3317,9 +3340,6 @@ static void gfx_v10_0_init_golden_registers(stru=
ct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_settin=
gs_gc_10_0_nv10,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)AR=
RAY_SIZE(golden_settings_gc_10_0_nv10));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; soc15_program_register_sequence(adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_settings_gc_rlc_spm_10=
_0_nv10,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)ARRAY_SIZE(golden_=
settings_gc_rlc_spm_10_0_nv10));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&gt; @@ -3328,9 +3348,6 @@ static void gfx_v10_0_init_golden_registers(stru=
ct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_settin=
gs_gc_10_1_nv14,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)AR=
RAY_SIZE(golden_settings_gc_10_1_nv14));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; soc15_program_register_sequence(adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_settings_gc_rlc_spm_10=
_1_nv14,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)ARRAY_SIZE(golden_=
settings_gc_rlc_spm_10_1_nv14));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&gt; @@ -3339,9 +3356,6 @@ static void gfx_v10_0_init_golden_registers(stru=
ct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_settin=
gs_gc_10_1_2_nv12,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)AR=
RAY_SIZE(golden_settings_gc_10_1_2_nv12));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; soc15_program_register_sequence(adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_settings_gc_rlc_spm_10=
_1_2_nv12,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)ARRAY_SIZE(golden_=
settings_gc_rlc_spm_10_1_2_nv12));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&gt; @@ -3360,6 +3374,7 @@ static void gfx_v10_0_init_golden_registers(stru=
ct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_init_spm_golden_registers(adev);<b=
r>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static void gfx_v10_0_scratch_init(struct amdgpu_device *adev)<b=
r>
&gt; @@ -4147,6 +4162,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_g=
fx_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_wave_sgprs =3D &amp;gf=
x_v10_0_read_wave_sgprs,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_wave_vgprs =3D &amp;gf=
x_v10_0_read_wave_vgprs,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .select_me_pipe_q =3D &amp;g=
fx_v10_0_select_me_pipe_q,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .init_spm_golden =3D &amp;gfx_v10_0_init_spm=
_golden_registers,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)=
<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB37773E8A11E29E6E7D55726495700BY5PR12MB3777namp_--

--===============0175067116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0175067116==--
