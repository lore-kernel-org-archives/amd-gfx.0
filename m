Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADC0EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 04:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9654210E272;
	Mon, 24 Jul 2023 04:46:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54B210E272
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 04:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJu5xHjr/EOmJUfxiHnnvbgEcaAcBRNda6/vCn6yyqT6dCmIBPP5afYzyUZChyl9ycHdA5W5epaOUBuP3JDDrRmPwgiCntn7U8lY0CMJkubLu0ps7GUhrUH6j0OGu7RIaKRLvQRIdyo8TED3mgwMq+wbvcPf7w/pbHWkmKyyUm6pDvZ8aZSVyyjOBOw3dmJwipq7+NLAceqPaAY5/sTIN1ClKA/+Imq+lCWYT6VpK/W3SuzYF4aEnL7Wp0FUoWGSSRns0I4jvw7PhjvgVbB0cgSZu7VIn6tnSFCVuOMqP2Py0oBH9h22HJXZQYf+ch9hOV1MJw538R0iCP1ZmVROJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW7n5yp1ZasGAELfXUjTg8L+t2onAL5zPN5SaPYGKyc=;
 b=Mh2Gjklm2uZbH15UeB8WrV8QBPIZrcab9PoS3mlNeFrV1JVDYNhj1D0kmkEHYzWJa3J1yc5g3ll8hOiZjgKWaEUgY1UlFdnC2tKTy23oEnEmg8Rl3S6lFbMJH8ak1zDEMw6LYjFECxBWNtPU5HvVk2G/Agh6s9594C4RzqTx4h33ML43sej67zTgoF2TcF7GljWIegN5xrX2v3BTNU6chwa9WqTK1Bf9ep3j/Oh/JGI+CmGdGsmJ43kch25G/fDVF+A4h5Ka/IseL8ywnF3+7zTs1YuL0EX4lbeiTvEiNRD4RT0DqwRC36GndKoiGIR6enzmwABrTSkVPbCuSVgRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW7n5yp1ZasGAELfXUjTg8L+t2onAL5zPN5SaPYGKyc=;
 b=tbvGFWr4J0z3lRyr9h+ljJAlxcHXJycPvIO2wKm2D6UMuKIwXGf1bCHIPQXcimEqt7sEy+3GWTNvFC2Gh/8P6lK1rfvqPMkE4W6aSozo6m6adsClmnMsQdaDCWwZECcOG6HPcSgEk+yhkkc196w+0RPTAHLOvfmhmK1O9sWRXPQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 04:45:58 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 04:45:58 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amd/pm: disable the SMU13 OD feature support
 temporarily
Thread-Topic: [PATCH V2] drm/amd/pm: disable the SMU13 OD feature support
 temporarily
Thread-Index: AQHZvd3+bB44COEcP0OjlOUebJG64q/IV5yw
Date: Mon, 24 Jul 2023 04:45:58 +0000
Message-ID: <DM5PR12MB24692B456E317F454F4C8D91F102A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230724032123.504966-1-evan.quan@amd.com>
In-Reply-To: <20230724032123.504966-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8d5d54e2-f9b4-4498-9254-8e1982762199;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-24T04:45:33Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|PH0PR12MB5417:EE_
x-ms-office365-filtering-correlation-id: 561f5731-793a-4c7c-5ebf-08db8c00df8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pXCh9gwydO5aGd1IvDGKTalBQ/bpuPjfdIaqZI/Zjr1bkvfkI0y5/kPwlSVt/27D2G6SBfas2GaiJZFRRJKOPIW3uLCupKJN0AAB6thxGQZZs7KRVuW9JoIO3AjbKkSkvqrnsPbbDNCbVMrUbREcDXqofx0svV62NenX29XJSuEjc0Dew/S6SZ59WP43gLX/ITaG9NodX0mAEoLjyTxGWPeQJpvxdamaWFXbGOQ1xhcFyc+6bhIUTVx968IKxwow0VMq/y65xs5LUMV+8ZdRTLNHBwVvdgmUZbc9BuDms4htlsbZ/TSqQWJQ6ndRbcPT4xQYtQGAw6b810c0xeytTVn/vytIW5w+975wmwjfK9x1TdF2FEzBVN1vipYk4e+nvvvOKV/ZQoGE1L9ML2s3ve2ClDhpmGMIOxp0cxKDchlMltuf4usFnUtdYL5Gn+D0gnERfJcf4gZrEfs6tF5MQ1EZffyb9XJwcvW5aEr0JVs73echMiKewh5KWGlZpOB/BC5uIqCOAT6j0zzfgmr05eTzKc8kCUEBkVI8FZv/JAkahIX7FCk2jQY6rU71tnFlpLOC94PIgBMbFKbMt4XeNx36H/PCc+Lphp/EC1vY//3vhjYaO0+b3x2XS2F8Jf6s
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(2906002)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(4326008)(7696005)(33656002)(71200400001)(478600001)(86362001)(9686003)(110136005)(83380400001)(186003)(122000001)(26005)(38070700005)(6506007)(53546011)(38100700002)(55016003)(41300700001)(8936002)(8676002)(5660300002)(52536014)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nO6XTSSeCcOTDb6fHot3bY8+0Po3xwqwURExKExrx6Q0IxJbmK97vsJsAqHy?=
 =?us-ascii?Q?e5+CaqtHnc89f4ZbpTn5cHP4xKC7XY+5oMzaUw+wWWlEoS/EQoTZAsCKbeGI?=
 =?us-ascii?Q?KRzWjLt22+MWGxUg17pQ8iThJc246FiIzB3Tw82Fc1D3ohpaFlF5+BaS3u1S?=
 =?us-ascii?Q?OKP6D20sphz6bVfajc/ygCheWuvVSmgERjqimcM0AFa2/I2JLTv+cGMr4f71?=
 =?us-ascii?Q?b/yCOd3xjDsBoVsik+wIZbqMi08MR43T4gcd9UmVjA1aZ9s7rwHDXqZSVuRs?=
 =?us-ascii?Q?DoFkIcwldE+q7VLvR8xb0wjrq6yMJah+DCpFhR4WzDZk23C3wQP9Lln44DPo?=
 =?us-ascii?Q?xtaOh+OqTJfu2sxvotxTPlHtKHTSLHCKfDSwzof3fYdRvMx3GB1KZ9wBSfub?=
 =?us-ascii?Q?nxlNT9YYaSiKebf6xJzPrfJBxPLbAN5Jx63DiNIo9dZSwvo/w6Cp8qSGwzWX?=
 =?us-ascii?Q?T4DVUOb57iYOfFDz5qQC5BTt5o8P61mKaGaDPjKx4p/mvU4Ubbx/+/slyTGf?=
 =?us-ascii?Q?jtBCuKob7qp1LqEN6MVXpM/E6zEsD2gqGV7o1mDOEA16QDb3cfbC9ekp0FtK?=
 =?us-ascii?Q?XWrr3wkRjMVOV6yO1Jt4svyQmaHNC0IxRXMa2rAQjL192OAq7Z17SWxN9IiA?=
 =?us-ascii?Q?kaLLfcwZLTqzlc3FT8Fm+rUxIyA6+mffpq+CtBwwB0ljFAbziwbMTSx8n3+r?=
 =?us-ascii?Q?9VG8nHYfz+LNU48iLrx0cfelM4Rkv8/dt5M8XYdEnrWJ49wtaogALnOtH/hh?=
 =?us-ascii?Q?/FSvLPL7ZwPpCzgc5h/2yy+5d2WCgadvpKW1ogBg/+j+oyEtouuwoin/nmR0?=
 =?us-ascii?Q?p8ZcKqvWbsIn5wRg6HgewpGb9Wttb6ji+8ZDW6UnV+/8L1BP1h4ktLj25pEA?=
 =?us-ascii?Q?1YMscKawPHs/bkrTg6jNek4Io5JF4CYw+HW7PfPjDtESM6Zc2ZF9wCcqaql7?=
 =?us-ascii?Q?uMpvAF7ZMTKFmwK4qyH4jIaCktPi2fgR8hDGhPMS2n09NvBZfV8MH2rijC73?=
 =?us-ascii?Q?VqZdFzVTmar1gRWZKNSuNEZ9TejsrgkP39edqEIXRfs+TYp/hbzbts4W0Qey?=
 =?us-ascii?Q?6oJgIlWAF/j2C49UUHW35IyHAB6XiQkrrzuoHfHhV7O5ONEgzIqMEhOM32gk?=
 =?us-ascii?Q?SH1dfuhHlTkxjMJUh3dzx7rlmQ6PYQswVuX9P9etOILveI7c5bkgIC0DAyUE?=
 =?us-ascii?Q?iB38HpPDkj7BdSe6AFNrv84THNt1n+FnUYkb+W8PMEGVTTMxSAJ/mQra2poE?=
 =?us-ascii?Q?5QoGPOAtF7Bafu/+/ezXWmhbeVbA6kb02ccHgwGCresK0/E5iPiwjBFv6fX9?=
 =?us-ascii?Q?Y2oOsknV8Gg8WO8ZORFUrOKku1Pqhad2mymKMfKu5GMiYzAC2xcECPMQMGKr?=
 =?us-ascii?Q?faAwQG2Z0AYGRbAiSLRT+7mm+fbaF8WJPMAmljeevqvf/hkQAST6apMg3UQp?=
 =?us-ascii?Q?VelV3lcnPnvxgSA7SPWn5VfFTnoEMgxQaFGb/tZkdGO7vhfy3dBJE8ftG2aH?=
 =?us-ascii?Q?Z6V8jdo2XJiCN198litLCyGf/fV4lKqRhKklb0EiJKAuydmoi/iVAc0GvtY+?=
 =?us-ascii?Q?2JdS8nb71cPxzdABgTw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561f5731-793a-4c7c-5ebf-08db8c00df8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 04:45:58.1285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oc9HlTMLS+QDWi+g3uJ0O0U6L8xfu7La2fE88Yo789stMqO4dmK3cirzEebLYdyRYx8GN2u7mjQfYy2ErKdbOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Looks good to me. Reviewed-by: Guchun Chen <guchun.chen@amd.com>

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Monday, July 24, 2023 11:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH V2] drm/amd/pm: disable the SMU13 OD feature support
> temporarily
>
> The existing OD interface cannot support the growing demand for more OD
> features. We are in the transition to a new OD mechanism. So, disable the
> SMU13 OD feature support temporarily. And this should be reverted when
> the new OD mechanism online.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v1->v2:
>   - comment out other unneeded members altogether(Guchun)
> ---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 15
> ++++++++++++---  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> | 10 +++++++---
>  2 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 60d2684478a0..160362540a03 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -348,18 +348,27 @@ static int
> smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
>       if (powerplay_table->platform_caps &
> SMU_13_0_0_PP_PLATFORM_CAP_MACO)
>               smu_baco->maco_support =3D true;
>
> +     /*
> +      * We are in the transition to a new OD mechanism.
> +      * Disable the OD feature support for SMU13 temporarily.
> +      * TODO: get this reverted when new OD mechanism online
> +      */
> +#if 0
>       if (!overdrive_lowerlimits->FeatureCtrlMask ||
>           !overdrive_upperlimits->FeatureCtrlMask)
>               smu->od_enabled =3D false;
>
> -     table_context->thermal_controller_type =3D
> -             powerplay_table->thermal_controller_type;
> -
>       /*
>        * Instead of having its own buffer space and get overdrive_table
> copied,
>        * smu->od_settings just points to the actual overdrive_table
>        */
>       smu->od_settings =3D &powerplay_table->overdrive_table;
> +#else
> +     smu->od_enabled =3D false;
> +#endif
> +
> +     table_context->thermal_controller_type =3D
> +             powerplay_table->thermal_controller_type;
>
>       return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index ebb961f60316..f12850acfa12 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -338,18 +338,22 @@ static int
> smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
>       if (smu_baco->platform_support && (BoardTable->HsrEnabled ||
> BoardTable->VddqOffEnabled))
>               smu_baco->maco_support =3D true;
>
> +#if 0
>       if (!overdrive_lowerlimits->FeatureCtrlMask ||
>           !overdrive_upperlimits->FeatureCtrlMask)
>               smu->od_enabled =3D false;
>
> -     table_context->thermal_controller_type =3D
> -             powerplay_table->thermal_controller_type;
> -
>       /*
>        * Instead of having its own buffer space and get overdrive_table
> copied,
>        * smu->od_settings just points to the actual overdrive_table
>        */
>       smu->od_settings =3D &powerplay_table->overdrive_table;
> +#else
> +     smu->od_enabled =3D false;
> +#endif
> +
> +     table_context->thermal_controller_type =3D
> +             powerplay_table->thermal_controller_type;
>
>       return 0;
>  }
> --
> 2.34.1

