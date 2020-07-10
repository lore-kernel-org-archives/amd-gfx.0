Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA5FC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7AC2072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZEEvhKfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7AC2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 209BC6EB61;
	Fri, 10 Jul 2020 04:52:00 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750057.outbound.protection.outlook.com [40.107.75.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81146EB61
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKk0e6eHQmgqehZItD3XB7S722E31kctgAU253BpMDbBp0xpNAsUlxNGfSD4KrCFXrM3esg4FGPCFtestSJhy7JbDoWakU1LPD9/KgBazI8pEw28WTKr/QnmFyX3rAkCSFxM4IfTRECox2J8JMMzMgWXRQBP1x2VnOswxDq6mcMzn6NSiZmlCKfySnXdtCN7SIi9MkrTdiwUQvn5hqfieThFX4NxO2P79AQfsPOZinoqVosKPBlp4kCEXQTQEan5YSXmb1wlLlM4LE9+BU1DGdXngRSQB6Il8PffYREkQoJXB9uCQx62zDPiy/xtSPC4j39dMAtHPao0PSKmp9ozFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1klyxXozPtPBmsLbW/XQggci6HQDw9ieIjxkBkH2Luw=;
 b=kNmQPgOvQQflUgG+85yU1qaOXrFtGOuwewAeD3VXhK1h7EvbKuVPfLTq6pt9Y2YIEJ2z9Jmzio+9O1tmr9W/T7vH2qlZPP5PqIaCrdpBqxIEtInBWltf5I6Tw0JjLKAn1121gIMShgSYBHSr1MMqmpONBVx2WqqY9nwhjaHUZ1UG+pdtrO4L904JqbdQ3uR+10syW0GoUvP2HxCfqkQMkTlooQIEeY/VfFsn9uUzaexLUGHz6X3aV0DkBZ0DxzqMCmdsTkY67oHteNL4eVJzzMWjcZYBjdjncwSqfPTHjvftocOhs/zJRqLzj1K/SgiEHnZ7VoJy9l+CnRnQ7RwEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1klyxXozPtPBmsLbW/XQggci6HQDw9ieIjxkBkH2Luw=;
 b=ZEEvhKfp4kYsvO2DyoPBMe0s0bFFofHAG/2kIIzf9hrIdFCSB8bw8Api3g8q4jBaRQJ29dfaQZ5dGlbZgttq3qWdTdQUF27SSYub3NrbCRY9PX9pHpCqNIowZCHnoL+apmlJOUANolTuuezxBS7o4htOYzaKyld3byVE84CNt2Y=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:51:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:51:56 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 11/14] drm/amd/powerplay: drop Sienna Cichlid specific
 set_soft_freq_limited_range
Thread-Topic: [PATCH 11/14] drm/amd/powerplay: drop Sienna Cichlid specific
 set_soft_freq_limited_range
Thread-Index: AQHWURS1BVlQAqH2Akuxw3fKY2gluaj/wY+AgACHUjA=
Date: Fri, 10 Jul 2020 04:51:56 +0000
Message-ID: <DM6PR12MB26190860716141275950BD07E4650@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200703083303.478-1-evan.quan@amd.com>
 <20200703083303.478-11-evan.quan@amd.com>
 <CADnq5_NckTisVjtGTeJVwqVN-gFFt+BfZRHmuNBx0-jKmooajA@mail.gmail.com>
In-Reply-To: <CADnq5_NckTisVjtGTeJVwqVN-gFFt+BfZRHmuNBx0-jKmooajA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6b28a6c9-d003-4ea6-bc2a-00000287e6f4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-10T04:49:40Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5bea4d39-736d-4eee-9b17-08d8248cf952
x-ms-traffictypediagnostic: DM5PR12MB2360:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB236025751037E6AC35BFC212E4650@DM5PR12MB2360.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bz43dmY0WVdqWqrmG+Iu6Wf4RwV9gAQ4XEycse1ObQB48rKG/I3KOZEJa93wTGAc2ALnMppBx+2dnPC3S+NHZgGzu33irelj2uIO2Tuds3GiidcNOtzBvIFfxGwEGj2G3wdz5myyg7OneCdJorS7EdDT8Pll8bpyjx7XBBVp+pCYAjNtjhJL6QRRy62vGQCEc1vh/STC4qbME6hO2nGnbgG9w5cAKJsDzlM+95EyeCtEhk2EbHsPgunJetDexUX9BppDw3mzLDfJ+vuCCexAImQQW6dkDM8jIfD8qMjFouEyK6etDLYvZVDZH3AftxUeJaDl6TmfUanuLponaDz2ADxBlKyZn1Gu7LiVqL9fGbgyUOTjh4wBBtNQfv7KauwOKRnVh02wa952/L4rucGvZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(9686003)(83080400001)(55016002)(2906002)(4326008)(8676002)(8936002)(83380400001)(53546011)(7696005)(6506007)(186003)(26005)(6916009)(54906003)(316002)(966005)(45080400002)(478600001)(86362001)(5660300002)(52536014)(71200400001)(33656002)(66556008)(66446008)(66476007)(76116006)(64756008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: FXe/8Sx1jHPsEXNpMWwdR11bKq5NNuRqB0k7z+HllGTkWOXPMq8anU1ACJ8lmp5EtFTEFPu6AT2b/Opfw7tuTaCIQEih9ewAAxuNw8CHWRw9ujgRLpf7OPOcHM3CCLLDxmdJyaLJwsuja5gmtA9p42LGUhU5UTvLKo4KrUd9VG/8yi13laZOiR8Wj+tyQuSm6tXD3HuV3SfkUlCxK4v5CAx5IS6sLKftZD0tpJdgyHMxTPLdoQyASOOkNk2P2wvbVCaO0HR1B0II0wSqZiWpt9a10O61gbeat65cJPirfeUYXNytZD3sPmavwHeWee0DMFFHuEoAOlp0qrgIkKDe3GUnkW9Nf1u3L81eHfb1nEYe3uV7cDvkhdJ18L+3hq5f3yE0UOYljBkGvGna69IjPuzHRNYqCjv3uCHkXVMFawA31edmKO4cIXb0TKRC92NIwOQXeg42k74TSAqCTlxYB/w40DL7EgiIEiOLprnb8cCzF+UuWqSjtdGQoRx3YlzU
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bea4d39-736d-4eee-9b17-08d8248cf952
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 04:51:56.7838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqHEmMsMr4xLVkZHVHMBRBho7FgrdDUulLw0W+hKrY9HIKl+hVCajy1Z5SgzXpXe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks. Other ASICs from SMU V11 should need this also.
A new patch was created to apply this for all SMU V11 ASICs.
Please see the updated patch series.

BR,
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Friday, July 10, 2020 4:45 AM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 11/14] drm/amd/powerplay: drop Sienna Cichlid specific set_soft_freq_limited_range

On Fri, Jul 3, 2020 at 4:34 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Use the common smu_v11_0_set_soft_freq_limited_range.
>
> Change-Id: I9f8772880b324ce9e741291751bb1b8ff4c36ea3
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 20 ++-----------------
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 -
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 +++++++++++++++----
>  3 files changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 27f77bde184f..141944df97b0 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -1046,22 +1046,6 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>         return size;
>  }
>
> -int sienna_cichlid_set_soft_freq_limited_range(struct smu_context *smu,
> -                                     enum smu_clk_type clk_type,
> -                                     uint32_t min, uint32_t max)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       int ret;
> -
> -       if (clk_type == SMU_GFXCLK)
> -               amdgpu_gfx_off_ctrl(adev, false);
> -       ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min, max);
> -       if (clk_type == SMU_GFXCLK)
> -               amdgpu_gfx_off_ctrl(adev, true);
> -
> -       return ret;
> -}
> -
>  static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
>                                    enum smu_clk_type clk_type,
> uint32_t mask)  { @@ -1097,7 +1081,7 @@ static int
> sienna_cichlid_force_clk_levels(struct smu_context *smu,
>                 if (ret)
>                         goto forec_level_out;
>
> -               ret = sienna_cichlid_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
> +               ret = smu_v11_0_set_soft_freq_limited_range(smu,
> + clk_type, min_freq, max_freq);
>                 if (ret)
>                         goto forec_level_out;
>                 break;
> @@ -2566,7 +2550,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .baco_enter = smu_v11_0_baco_enter,
>         .baco_exit = smu_v11_0_baco_exit,
>         .get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
> -       .set_soft_freq_limited_range = sienna_cichlid_set_soft_freq_limited_range,
> +       .set_soft_freq_limited_range =
> + smu_v11_0_set_soft_freq_limited_range,
>         .override_pcie_parameters = smu_v11_0_override_pcie_parameters,
>         .set_thermal_range = sienna_cichlid_set_thermal_range,  };
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 8fbfa0562007..1b357e349d1e 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -93,7 +93,6 @@
>  #define smu_asic_set_performance_level(smu, level)                     smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
>  #define smu_dump_pptable(smu)                                          smu_ppt_funcs(dump_pptable, 0, smu)
>  #define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq)                smu_ppt_funcs(get_dpm_clk_limited, -EINVAL, smu, clk_type, dpm_level, freq)
> -#define smu_set_soft_freq_limited_range(smu, clk_type, min, max)       smu_ppt_funcs(set_soft_freq_limited_range, -EINVAL, smu, clk_type, min, max)
>  #define smu_override_pcie_parameters(smu)                              smu_ppt_funcs(override_pcie_parameters, 0, smu)
>  #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)  smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
>  #define smu_set_thermal_range(smu, range)                              smu_ppt_funcs(set_thermal_range, 0, smu, range)
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index c2564df304f7..1ed5ac946c05 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1745,9 +1745,12 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
>         return ret;
>  }
>
> -int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
> -                           uint32_t min, uint32_t max)
> +int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
> +                                         enum smu_clk_type clk_type,
> +                                         uint32_t min,
> +                                         uint32_t max)
>  {
> +       struct amdgpu_device *adev = smu->adev;
>         int ret = 0, clk_id = 0;
>         uint32_t param;
>
> @@ -1755,12 +1758,16 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
>         if (clk_id < 0)
>                 return clk_id;
>
> +       if (clk_type == SMU_GFXCLK &&
> +           adev->asic_type == CHIP_SIENNA_CICHLID)

Is this specific to Sienna cichlid or do we need to check this on other asics which support gfxoff as well?  Might be cleaner to have some flag that we check (smu->disable_gfxoff_for_soft_limits or something like that.) rather than adding all asic types in the code.

Alex

> +               amdgpu_gfx_off_ctrl(adev, false);
> +
>         if (max > 0) {
>                 param = (uint32_t)((clk_id << 16) | (max & 0xffff));
>                 ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
>                                                   param, NULL);
>                 if (ret)
> -                       return ret;
> +                       goto out;
>         }
>
>         if (min > 0) {
> @@ -1768,9 +1775,14 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
>                 ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
>                                                   param, NULL);
>                 if (ret)
> -                       return ret;
> +                       goto out;
>         }
>
> +out:
> +       if (clk_type == SMU_GFXCLK &&
> +           adev->asic_type == CHIP_SIENNA_CICHLID)
> +               amdgpu_gfx_off_ctrl(adev, true);
> +
>         return ret;
>  }
>
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7Cca953813754b411cfc7c08d8244906f1%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637299243351546676&amp;sdata=BAWcscVqwPVkc
> UBgF2nzhnJ1lG8wS0CDjYw%2FlFJPpOw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
