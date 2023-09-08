Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CDDEE57E1
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 07:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A99B10E87A;
	Fri,  8 Sep 2023 07:51:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F7C10E87A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 07:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc/PiTzHD84x8i1cLhFlam8F5uk6w1Qj9urdxVleu4owytvxOyVFUr/3rl0HNSa7kbGhsQ2b1Wp6fOPILJ9HGmr7acFsAQvqIir5XtuDc9QNjx18+eYZW6Tw94OtNLbTpTrUXPvhEryEA19lZYolD0ph/KN67Tdk9awct1fkP8sIahQoMAeJECNmzKyCyLkT5TJC6KgmZZvuxvD+5fTh5Q4/36DF5slQAquC+2UhSMYAntHxRz7ru0/bT78mPltujtTTRy8sskHpoELSEcF5gjLeDQGim11NKgNS0UiEuLtvz/+dqWdDa3JrFrtFTjB9Rf15dGz1Ip7ohTh03zPKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk/D5kU6fGwbTRx61hQe57PaJb3RO9noz+i1Gz0Uxow=;
 b=g72srSIZ+dKdqZOUAWywAalxk7DEPFXbOdMNvfpDK09zxsQANWNFB8kziOX3QqzQkpLDDdhCwhB/ALFvjNuYY3ayld6T//W/lVJFHnSkVMDTLe+6uYjaPLV3IyzblZg5fx7++cM8p84ifmOGSnE0vVrg/3DcPPNIuHz3BIgPZdFLW+LwiC1KpOZXY3dhA6sukWRh974ajfv+f+ur61GUur+sVogy7tVqIEyLh0oqrbyjQHXsBJuo6iXpBEUZOMlBbBlVsQpcdbRrMRgk2E2wRRMoD+BUiVM1PcfmZp2Fal5ZdlP3FmX5gHZsVCURIgb1B/WQCRadY9MGaURf/FNQZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk/D5kU6fGwbTRx61hQe57PaJb3RO9noz+i1Gz0Uxow=;
 b=QnbIXF4tle57Ky+jsmQPztlDPTYo4MEgE28KPGd1wd+F3tWZw3/SVkHf1cMtM8UHtOwbY1MKX5Q9bQOr1lJ8iTpeu5IKtoii7cCqnDwyg4DSYGXLY4UT+eta8RJmy9seBC+OwLUu089IZQadMbV40dj+xrISy3R6+xixWnHpIzc=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 07:51:06 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 07:51:06 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: enable smu_v13_0_6 mca debug mode when
 UMC RAS feature is enabled
Thread-Topic: [PATCH 2/2] drm/amd/pm: enable smu_v13_0_6 mca debug mode when
 UMC RAS feature is enabled
Thread-Index: AQHZ4h6CHghEVSC80UWieaxeHWVV9rAQjVsw
Date: Fri, 8 Sep 2023 07:51:06 +0000
Message-ID: <PH7PR12MB7988A59E0A2AB823BB6DEA939AEDA@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20230908063354.2478663-1-kevinyang.wang@amd.com>
 <20230908063354.2478663-2-kevinyang.wang@amd.com>
In-Reply-To: <20230908063354.2478663-2-kevinyang.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=77f8d0b4-07bc-4f0f-8b03-ad4c7a5c74a0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-08T07:48:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|PH8PR12MB7136:EE_
x-ms-office365-filtering-correlation-id: ba774603-f88c-46f5-4d74-08dbb0405b75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BSELqUrDU/SnKIyO7Mh4sgUxScsmBud1gQUwR5QboeggTTaxuV4O39QFZ/acG/xiQjH31wxPb6plI/FcQFNtJbV7RFVzvtYkad3IDnpJ96EEXCefAFxSzPsjbThROghNtPIq0bt4/0528v08jxXSKQP5TVfFg5rz+Yx30FGz9JA5fy7C0W5IOaPt3UtZJvtCqVF7AGYyANr1lVYq1+iZtijZn/fRvKFYIP2A/wC7gV4kpR3s876yRtVJmognwqePtB0It1apiPK6GF38i30FjlttGUN5iWgTTbEbCe8B+zwXF5ecEN+kqeYO1MY13TaQE2ljB8t8WUTwe0CWgZvFkxlKRfgrSsggPA+KK4hYsqwTHTkh9b6SfE2CGO9bO5eboAIM90gC4t1/NAdf0TstRtsLWKoafYKoA+WB16t+BmtZVccUQe9b9soRK2eu0G6ummCJwjZ+7yJBynXPP3mMKaI1Jxcesg71TryIRoYxvQebWfU26ozaUEhfOIqc6LMUUWxBZA1UcRGpyBurC9k+FNfHs+Hh8GKx/SSZs8dGl1b/3LQjIsjY8g/ZK+yNdZPPLaH3eR4Y3d2zC3hwRE2qR2JCCUCdY49jyxLxMdmPJxacOEd8Sze/M9qPqInWki+E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199024)(1800799009)(186009)(5660300002)(52536014)(66946007)(4326008)(8676002)(8936002)(6506007)(7696005)(316002)(66556008)(54906003)(64756008)(66476007)(66446008)(41300700001)(478600001)(2906002)(110136005)(71200400001)(53546011)(9686003)(76116006)(26005)(83380400001)(55016003)(122000001)(38100700002)(86362001)(33656002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dC3M8NoNWvvbGvykajuBWoBHfWEbtyVck6HrM9ULHvvdrGWLInVwT5I4F0tI?=
 =?us-ascii?Q?B9YE9UAhsgn6g2D/TFVMjy3h6mheu65FxGSHdxaew4P47A9dB1iBnUjHdcYv?=
 =?us-ascii?Q?m+NOxW5j03SGANq+RbyIYQTnKHBCt+ChtEmxXT7K1Z36s/YEXhTTmHdGe1Iz?=
 =?us-ascii?Q?nC8JC4F+pd+RNJJxqHXZ8MIoYnpDceXJbdAtxhNc3iupeu3QSTBXajkJYL7W?=
 =?us-ascii?Q?r8kbLJmho8ay/vQ0GRv6eDzF25gc14Li4xOFNvIUxn266WAEaRkmkJ9SdGYH?=
 =?us-ascii?Q?OHL9QTph4G4ZbLTIvsuRvrqs4vVqcDbyNMxpn9+Q+mbhZcuEZIZgMA/2NSf5?=
 =?us-ascii?Q?PlDX0CJrmhI1cw4p1mcn3oginEK/RbkNvpE2GDiF2iJQAb9xvOdvFRjGUjBL?=
 =?us-ascii?Q?+Z7CMY80tYTWt+MacO8sTw3WKmCVez6kE84Xpq3LNlcueyfadj8FwJBAm3ZP?=
 =?us-ascii?Q?xaNXnW9LckU53SvIpHVt6C+NEdVGc0o/BYObiE89DaAzyAxy/NqdnmGje1is?=
 =?us-ascii?Q?WZypHiF2wL1mM9sRmEXjOmZ1i10ETjwfoFuqAgAC6LfDomfLd1V8K5ovDcQd?=
 =?us-ascii?Q?zTf5b9JORZs9OFZ838DuFgzNkIY/KsZRooh0FLBjfBoJ4+hhdwKTErhz93Cu?=
 =?us-ascii?Q?/T0mUeZeNA7gTzgbEBms/Xk8liS7N0gq9HVEW8tYPR+2Eq+QHt4Tqq9Sh59Z?=
 =?us-ascii?Q?zlSpuNpnoXvNve5lA4+uzNGZcLxd9pJj3aL/eZvBQ/eCnHQibh+Y1aduj2A9?=
 =?us-ascii?Q?/kSMppq65HCyHp6W4S5kDLJHxsCX5ryW5+clgqns9tvFX1TJHIa5dmWfveDF?=
 =?us-ascii?Q?qw/BBb77AMYK8YfivMKuRuXB008H9Oa+vcopU+P+KKWpEJeqlRwE3ZyWfjTM?=
 =?us-ascii?Q?8QC+Pvs0nSFLhPl/yxVQx3W92f5C5axAS5unCyy/mnxusJBjC3xJy/9trjOi?=
 =?us-ascii?Q?APMvAuOyUFZOnWngGYtWIcpaUuq3q1/J/mnsqf1tcVsZPRJcKERgLS1hN9Fd?=
 =?us-ascii?Q?6U1mLzCsQ0UvdbkBsnyqr/TH/jSGmRk6wzJJoYEIkQZLLdA20xdWX8BgKIkj?=
 =?us-ascii?Q?z7RIhq6AGBSjYhIMHlQbyhA6gBuZ5xD0aiFLQjsTX19VBxOGFXEGasOY4mpd?=
 =?us-ascii?Q?cxBSSp82U1P+lAL+sXkJQv6esrsRK5z/6WdICmlQnKKQwsXqRq9w7/KY7APC?=
 =?us-ascii?Q?oZJ5zBjLmi8qQvix10xEpQDqviYiM1hEmiXnoAQmyxM6K7hGAYqVx7tpbpeI?=
 =?us-ascii?Q?7kZHH4WusSIQNMysZpdrha8U9/Pqsbio90KO+cQqtFy6yDDK9d69fdcZmwVP?=
 =?us-ascii?Q?duGGvZ8DeRorlYzNjbDxotYeLgT62o7a2CQB/fDC8uJH8YoH6mnhIOC1APn0?=
 =?us-ascii?Q?oOzU8kVdX8TiBO4kdgAeXEUQllJzNFA2WawPMGasTpMEd9hnUdbJNWf91KPJ?=
 =?us-ascii?Q?9G6JeVyGiyGwxqHCiWw1VvImNMMudb7KygiA6Mst5lJlesQ9NwdbeURDYhi/?=
 =?us-ascii?Q?nXzA83H2hrcBeD2MP7eimO3KofIwNGs6/W6rcZkfKWXf9VGkd3fioum3sAFO?=
 =?us-ascii?Q?PdMc6TpLhHwPw1+mivM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba774603-f88c-46f5-4d74-08dbb0405b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 07:51:06.1761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oK/pARNQwYHekl1a1bFZdGkXKNb+VO5vXq2dUZcv2ZwMKqmCHWPcqLPhWzBIBN2B1stNJyF/jl3py595xfwqAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang
> Wang
> Sent: Friday, September 8, 2023 2:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amd/pm: enable smu_v13_0_6 mca debug mode
> when UMC RAS feature is enabled
>
> enable smu_v13_0_6 mca debug mode when UMC RAS feature is enabled.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 26
> +++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index ebc789e7a289..f762c01b98a5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -247,7 +247,8 @@
>       __SMU_DUMMY_MAP(Mode2Reset),    \
>       __SMU_DUMMY_MAP(RequestI2cTransaction), \
>       __SMU_DUMMY_MAP(GetMetricsTable), \
> -     __SMU_DUMMY_MAP(DALNotPresent),
> +     __SMU_DUMMY_MAP(DALNotPresent), \
> +     __SMU_DUMMY_MAP(ClearMcaOnRead),
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)        SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index ff58ee14a68f..5ecc90e6af10 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -133,6 +133,7 @@ static const struct cmn2asic_msg_mapping
> smu_v13_0_6_message_map[SMU_MSG_MAX_COU
>       MSG_MAP(SetSoftMaxGfxClk,
> PPSMC_MSG_SetSoftMaxGfxClk,                0),
>       MSG_MAP(PrepareMp1ForUnload,
> PPSMC_MSG_PrepareForDriverUnload,          0),
>       MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,
> 0),
> +     MSG_MAP(ClearMcaOnRead,
> PPSMC_MSG_ClearMcaOnRead,                  0),
>  };
>
>  static const struct cmn2asic_mapping
> smu_v13_0_6_clk_map[SMU_CLK_COUNT] =3D { @@ -1393,6 +1394,20 @@
> static int smu_v13_0_6_notify_unload(struct smu_context *smu)
>       return 0;
>  }
>
> +static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu,
> bool
> +enable) {
> +     uint32_t smu_version;
> +
> +     /* NOTE: this ClearMcaOnRead message is only supported for smu
> version 85.72.0 or higher */
> +     smu_cmn_get_smc_version(smu, NULL, &smu_version);
> +     if (smu_version < 0x554800)
> +             return 0;
> +
> +     return smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_ClearMcaOnRead,
> +                                            enable ? 0 :
> ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
> +                                            NULL);
> +}
> +
>  static int smu_v13_0_6_system_features_control(struct smu_context *smu,
>                                              bool enable)
>  {
> @@ -2182,6 +2197,16 @@ static int
> smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
>       return ret;
>  }
>
> +static int smu_v13_0_6_post_init(struct smu_context *smu) {
> +     struct amdgpu_device *adev =3D smu->adev;
> +
> +     if (!amdgpu_sriov_vf(adev) && (adev->ras_enabled &
> BIT(AMDGPU_RAS_BLOCK__UMC)))
[Stanley]: is there any reason only check AMDGPU_RAS_BLOCK__UMC bit? If HBM=
 ECC is not active but SRAM ECC is active,
the AMDGPU_RAS_BLOCK__UMC bit is not set, is it necessary to set debug mode=
 for this scenario?

Regards,
Stanley
> +             return smu_v13_0_6_mca_set_debug_mode(smu, true);
> +
> +     return 0;
> +}
> +
>  static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
>       /* init dpm */
>       .get_allowed_feature_mask =3D
> smu_v13_0_6_get_allowed_feature_mask,
> @@ -2235,6 +2260,7 @@ static const struct pptable_funcs
> smu_v13_0_6_ppt_funcs =3D {
>       .i2c_init =3D smu_v13_0_6_i2c_control_init,
>       .i2c_fini =3D smu_v13_0_6_i2c_control_fini,
>       .send_hbm_bad_pages_num =3D
> smu_v13_0_6_smu_send_hbm_bad_page_num,
> +     .post_init =3D smu_v13_0_6_post_init,
>  };
>
>  void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
> --
> 2.34.1

