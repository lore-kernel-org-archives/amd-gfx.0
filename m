Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1218DC83F29
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 06:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42ED010E176;
	Thu, 31 Aug 2023 06:15:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7094F10E176
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 06:15:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myARXSw214gBSpFUR6nNLzbgqrZ7h8rqWtlr6rUqNTq3lVeoglvz2QJgtAWTPVjbvYUqFUOD53Ot1N8w5dWPKbuCuuBuhxLAmFA3GrYZYM/GUDwFfKvTJON+n9FAw6T6lGjVrUcnjVEM4Z9vipFGD+SPDkVSTEe36eTp9b5IfRO2VtGsdId4DayqIf/ZpO1QOJKErDJbBCmjGQH3Yy7AesSamzkqEUCy/lVRYdKQ+5B6MBrvSttuaE8HhUjGKGmFd/FkhP4Ivbx3BCU1N+rlMjDWd4Tv5pNCGRLjX71WtPTLNkLhEd6/jZfbppM4IhridgxkMQSNm+Z3lLZAIcx8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SDRlw1/ICTLpZAU9sqavrq9b3iQyJPDQ+U9PYvDINQ=;
 b=j3RUJp6cPGG3murVXFCgpnlHiJmHHblYDIjzMFN1KW3Y4h3Pf3ZfFj1SX/8HEhodwx0pnZ1BV4TT3G4LrxLDEK87imE2KevT5GTdwZlWdFNZJP7wL7aew0vVRwTPOkHBWCYrjlpU3ZubQusatm04xc9NMFKgVkEIeGWip+j8fOOyA1WjRdJCFex6dxgXqM+bs+5vy2TmLRtrxaii/6UaEUlxe4oMjis/gEwfEi28j5vbomZRYC+BSSC2mEe2/p54RI31oQotAU0gABkof2TfM+As5vKmtKE4RHmBEOeKlVE5Kqfa5LXlvQJ1WX/4lsDITPP9Chiw88BZY192fwioPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SDRlw1/ICTLpZAU9sqavrq9b3iQyJPDQ+U9PYvDINQ=;
 b=skn87gWioeww/RzTh3JSWzYay03fbAgvnaYG97T9eAyuVsiD0pk6WKvfQnbKYKxdc9H3m8E6ayngyV5BLQqc3SKKG3WFuxjihZx/iHmDsFJrTBkkznMh3tfMmIn/w1QxrBPef0Gxlnaucv8BLNwGuo4BS58peJxgLo8fM/s/QV4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.21; Thu, 31 Aug 2023 06:15:31 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06%7]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 06:15:31 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: only poweron/off vcn/jpeg when they are valid.
Thread-Topic: [PATCH] drm/amd/pm: only poweron/off vcn/jpeg when they are
 valid.
Thread-Index: AQHZ29HFXaZHqM1gjEmvyhii3fE/CrAD7Pgg
Date: Thu, 31 Aug 2023 06:15:31 +0000
Message-ID: <DM6PR12MB26191065EE09275BDD903DE6E4E5A@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230831060937.4120912-1-yifan1.zhang@amd.com>
In-Reply-To: <20230831060937.4120912-1-yifan1.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2df88381-f1d6-480c-887c-bafd803bde52;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-31T06:13:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH0PR12MB5218:EE_
x-ms-office365-filtering-correlation-id: 830ea2f0-0c05-4b33-4cdf-08dba9e9adf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pO7UiY3yVScIDQOAnpsloAY6SitBRkfV62rgzkL+sDm1opD1fj9DKFeaFI836Ud7th5EQoxc+sNjDKpGeVTz85JOVtj1hheXfL0EPjMP4WkobWwR5U0BnkLC0eGLm5794Xjf3QXf2ewX1flJsPoiiyabL8IcE8iVM2wuO6gDXLnKFSRRd30tWAeSQMtyu3tJ2n/daUGh65LW5Z7+nD6PWpSely5f5iXsckVvDzBvQl5FQvbnya8rzAOG/mI4hp6Z2mVPoLF4LgE7bV/buCclivzb36myRuf+U3AkWncARHU3ib6DLop+kGszvrmFjLCz/EPPcHMt3lbfX0+EDVvM+877UylHPFYq8FPPAfXRte41FtM5y3rkRSK4vae7HUIs3x5BcYrMavBtxWFIl/6e49FIgxHXY+4LMoNGMpD8k/PPf5Fo2uvzQhZSPG1zoQCeaX+6EE0JMYR4bjcMNSsY8UwdhXSJE5I9xC773XaJr/vxEevzpnBamgHxXI1elSUvIhFJtq1oB02vrF9UrTAQgUtfKFeTPSzsLzQdEy7IgrrA/wJ/0eC0UYGm8JxBgzBnmN0szRjFKZeRd6kX0O7thk28TfOeWxnp+vmFfa4jqA32Be8NQdYAUEEVMjNH/Iby
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(1800799009)(186009)(451199024)(6506007)(71200400001)(7696005)(9686003)(53546011)(478600001)(83380400001)(2906002)(26005)(66476007)(64756008)(41300700001)(66556008)(316002)(66446008)(66946007)(110136005)(76116006)(52536014)(5660300002)(8936002)(4326008)(8676002)(33656002)(55016003)(86362001)(38100700002)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IoyIpB/CeJNe8uIEG15r+7AJBYlu68zW6R5otUMXwsTmvJhgR6w1GLY/L3La?=
 =?us-ascii?Q?7bIroAEN20dlviDiTxWhEBszLT21+0W2qsSMFLkmAPU9TSdvFzuYUhqqbfRC?=
 =?us-ascii?Q?dZrl+c+3aZRfpEF8teBKF3tvl48ObPV3QaiuCeQ0imo90LQHUvSmcOpt9d53?=
 =?us-ascii?Q?tsBLL0Tkw2RiVlDgAhoHOGyAichza11LrZPCwQo/Mnbdqajt7ZJPbpCCb1o4?=
 =?us-ascii?Q?e/Qd86uf1EX3+rC+gwGJoeXMx248pkDA7DizTM1XqBktOVqnsu9pbsjNOqO7?=
 =?us-ascii?Q?M0Yax/y+ZJN7sYEHGfZICUlPHpDb3wibWTJsl+zZ6Lkf9xCNArbCZeOu92Z4?=
 =?us-ascii?Q?ebz8LAsTwrzanNzNgX824AQUiJWjfatrL2InYlSN35NJDYi+wuxjFzb8/DGo?=
 =?us-ascii?Q?JvYT1kb22NQkrLwFxyKW1Ui0becx2nFdVbvw3JTXwT6QjlPMfne/r6cebS9G?=
 =?us-ascii?Q?UzyjLkqPSLfedbX1LEbymaDvai937dOtMzqwKzUFmLDWG+rBGpyP9YmzTa1c?=
 =?us-ascii?Q?0oKqjL0xD7m6QNqhNJuFF9CG630Cc2+RyhY1ZNOpPT8aiD+R4lchSMKdctcU?=
 =?us-ascii?Q?EZSEuHiSnvzdlnZP1XAaYoRBI1N+i0ndyhLUfGRyKC56gsvlNRTOKu6Mntvc?=
 =?us-ascii?Q?hnaSGdQ+e7GmUOopQahmYnixNDdXkCltmDeTb2gK3JokcnQ9DEqMx/qNYHDl?=
 =?us-ascii?Q?iVqFc2UN3xiLbZ6clUFFOKCZ3BZraLNble1/0aJTE5vezUAAR4kx5VMF5y06?=
 =?us-ascii?Q?z+LDAOE3Jg7smwklhFKkmaBXYR7Lqje9+8tAtivPbX487OugbwF0nWHjt2K1?=
 =?us-ascii?Q?Yq6Ai+GNxLK5Swd9nWDYoMRRBOXYLMJKiJRcEAB3huYH3FXtD36ao+3cjLDy?=
 =?us-ascii?Q?/H2xJiarE3OEQnaFWNokgiq8I3NGkH1Wz/aUbYNwIWH91puJ+tP4wPvfLjM/?=
 =?us-ascii?Q?p+QSWqYkiNxb0Lapyp3drlqttCSinFx/ffaprfvqcrTle55LjZlPlpWEETC9?=
 =?us-ascii?Q?TXjRPLAMVKlv4/u46kZCbLxfNUZSk9OhHsLi7rQB3pFPFPW7qZlEH80RC6Cf?=
 =?us-ascii?Q?+Jfl3Y+BiC5zMJ1Giip10EzSlyWwhDo5++50oo5OsJyXRd0u8pAYBEkxREmX?=
 =?us-ascii?Q?NNdbPlRaKutooNgdnm9ncrbaXxYCvQGUotHEUP7mm1dj5kyCw/SzdcIlIjQI?=
 =?us-ascii?Q?atOIyZOWyo5QzerpR7o13/J084qAmCyspZCFuKNet82m7iFAzVtGCimNaaIY?=
 =?us-ascii?Q?mxm39JSvGSmtc+xR34wxbnMLZSPZwZgRvGA7+x9hPq5jO93fFOdwUJ/nq2SZ?=
 =?us-ascii?Q?qHU0fFAwM/IZuyAdo7LivNA7r1PCONapoHraZN6B7jY3dcLXFmx9m1CS3qPo?=
 =?us-ascii?Q?mt0gg4MRWaX9xVtyY81D+FwlTwDkjDM+iFmC2yERzsE8eArLrEmGsUa2nXii?=
 =?us-ascii?Q?xRlN2idjswxyb8akaM8n/OS+jJBwjBwJ1O42sm+zDxN1qTebUj92pEgt6PlG?=
 =?us-ascii?Q?ISz2ubPiMNpuqmAs0F0zZc3Qk3rQN0x4qlY9nHSlGqnaPwPahd24Qe1G2/BO?=
 =?us-ascii?Q?stPp8L+VkdeUPm0QJbQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830ea2f0-0c05-4b33-4cdf-08dba9e9adf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 06:15:31.3796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDSItbBIOpHoPH6CI8owqcc+EdsZAbhoSWHvGKJwqgKLyoHx5yuyvb2sFabj9acI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
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
Cc: "Ma, Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, August 31, 2023 2:10 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Ma, Li <Li.Ma@amd.com>; Zhang,
> Yifan <Yifan1.Zhang@amd.com>
> Subject: [PATCH] drm/amd/pm: only poweron/off vcn/jpeg when they are
> valid.
>
> If vcn is disabled in kernel parameters, don't touch vcn,
> otherwise it may cause vcn hang.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 31
> ++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f005a90c35af..f5e7ce011cab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1454,6 +1454,21 @@ static int smu_start_smc_engine(struct
> smu_context *smu)
>       return ret;
>  }
>
> +static bool is_vcn_enabled(struct amdgpu_device *adev)
> +{
> +     int i;
> +
> +     for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +             if ((adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_VCN ||
> +                     adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_JPEG) &&
> +                     !adev->ip_blocks[i].status.valid)
> +
> +                     return false;
> +     }
> +
> +     return true;
> +}
> +
>  static int smu_hw_init(void *handle)
>  {
>       int ret;
> @@ -1475,8 +1490,14 @@ static int smu_hw_init(void *handle)
>               ret =3D smu_set_gfx_imu_enable(smu);
>               if (ret)
>                       return ret;
> -             smu_dpm_set_vcn_enable(smu, true);
> -             smu_dpm_set_jpeg_enable(smu, true);
> +             /*
> +              * don't poweron vcn/jpeg when they are skipped.
> +              */
> +             if (is_vcn_enabled(adev)) {
> +                     dev_info(adev->dev, "yep, vcn are valid\n");
> +                     smu_dpm_set_vcn_enable(smu, true);
> +                     smu_dpm_set_jpeg_enable(smu, true);
> +             }
Better to move the "is_vcn_enabled" check into `smu_dpm_set_vcn/jpeg_enable=
`. That will make code more tidy.
Also, the "dev_info" here is obviously not needed.

Evan
>               smu_set_gfx_cgpg(smu, true);
>       }
>
> @@ -1651,8 +1672,10 @@ static int smu_hw_fini(void *handle)
>       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>               return 0;
>
> -     smu_dpm_set_vcn_enable(smu, false);
> -     smu_dpm_set_jpeg_enable(smu, false);
> +     if (is_vcn_enabled(adev)) {
> +             smu_dpm_set_vcn_enable(smu, false);
> +             smu_dpm_set_jpeg_enable(smu, false);
> +     }
>
>       adev->vcn.cur_state =3D AMD_PG_STATE_GATE;
>       adev->jpeg.cur_state =3D AMD_PG_STATE_GATE;
> --
> 2.37.3

