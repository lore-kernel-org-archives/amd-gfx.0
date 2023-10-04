Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B90E7C4E2
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 16:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B94210E393;
	Wed,  4 Oct 2023 16:54:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083EF10E393
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 16:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQLEbGQ+OhHjLNKNFwns/Un4QJrDRIv7qt+Nzwu2ZKnymBsXuQqdaayrJ0gkyR28IHyEthHINDC55Ejp8qqmGKcc2fkJtR05G0sMiI9xZquwRIHoV0+Lxm2Zzg2VY/tveAqAM9bXEGAsM4dBf2yp4SSZ6w02wYmHnB0WEq1MRLK+8UX1n4enTF/oJ6700RHise/zZ8o3xWq6vjzzPOEzNKwidHqLN7ly9DgDCXhZqMGOFiLat/wPxXFaD3GOYknzlYdMLGBRc/coS9ab/O7+r5vKhLkIeYCh94aF+1PSdK2OYUGi9esCc+5VwXB4tybdu+rspFCEeGW2lZbr4u/FbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/zUd/j6AFPfWEnSozuUTPpcbEHI/A9868vXcSJ7U44=;
 b=ksIWewkNp+uzdNAWiH1vkg+AktlARxVsjOb/e3Mx3JSCSr+77DzcWc9AsUsREtwBYoFjW0CRaYJiDJ/ZYSKh5JL1qe1tv4KLqKCnxoJUljB50pdjpg5oFuB3zLnOuYwAjGj8LbYYZbpwuec0QtztBm3vxSy8uz5aIS669vmHhz3mW9S+X0v9+gJ2cPtpdWz1pq8aiNRCeUfqAGN7+L7ggZsacakjbmwy4WGL1+QMHX2wZwp9Xcw75SDOr8Y3vQjqmKqKs8MPI87YP5PCiFtsMBfp9+YrbM+RZunt83PURn3XAlZD72/u2J84rMBxW0VL7gfZQjNYIgd9NcD2wr1ilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/zUd/j6AFPfWEnSozuUTPpcbEHI/A9868vXcSJ7U44=;
 b=AxCJ/yeIeia8X+KZy5NBP4keuM+jPo7WyUYpaystQm/4GCBCM8CZ4Ou8fucgFMF8BNL1cWJk1leOAzPUwXqtPoy+o5RH62sBPszbmGz/moCU+83pcCskfQhUddtyNyY55MOjyzaMS6vATgv9+yb417MqUmwAeAEa74aT7IGVUm0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 16:54:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 16:54:01 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Xu, Feifei"
 <Feifei.Xu@amd.com>
Subject: RE: [PATCH 13/16] drm/amd/display: Don't set dpms_off for seamless
 boot
Thread-Topic: [PATCH 13/16] drm/amd/display: Don't set dpms_off for seamless
 boot
Thread-Index: AQHZ9qSo5den4/EwcU21xRcNk4zASLA52SoQ
Date: Wed, 4 Oct 2023 16:54:01 +0000
Message-ID: <MN0PR12MB61010B2DCB3505A464E7DA2DE2CBA@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
 <20231004092301.2371458-14-chiahsuan.chung@amd.com>
In-Reply-To: <20231004092301.2371458-14-chiahsuan.chung@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f46c8e5b-dae1-4f66-99c4-0761641e626b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-04T16:52:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|BL1PR12MB5317:EE_
x-ms-office365-filtering-correlation-id: b2f2b9b1-67d8-41ef-c0de-08dbc4fa827e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: efBwcP4j6n1ewe+CpA7XsnoiGvUxGG4vjULap+TnfVKAT2axcsBDu6ctz7tQMZOcUbU3aQallrgaeIRBWYSUIeCe1uVz9f3g+c+joW9w4+daGAVT4nSvQGSGO1jt0kPZuewg2IcUkpTgc0/xZma4MZYOMD9MOwb2XY0TDBkEhlzNoGVpu7h2hAvJBeaYUOQRQdxrCUifuOt9aFqIM8d1pRfPR9UWsEJsunRMpvclzCwAhmTE4PLnT9+p7utkxHrLCxWnlWc0ARnBnmEB2ye2YJO3KpnUwnew449XiAb1oL6WRS413kAm67g/XdejqawLhV9NfYZyW/xe3Pzw8W2G/4XjdTqxQoU/WI+sfaGoyXi5zk4WK0/tdbh4hfzWb3XFr5v/bOSXgpqnV1C6cmfvPNFS+0eIfIoszSGlGKnrg+DPLGvm81wuO5TFKqZCI6IIk51S3qTiOlyoWln/jwWsfH3VUH02kY6rHjsxG+1rm/XPVUPh5SFJSi1fN+qeYhJGrdMZzoiSF6B/oAsKeVKQlldz3lJOyNvuBh2RI6enO/gugSqfvm7jd6S3gB2B4RJAMb/Zdel2TCzSSFVm5kBJt7F3FXKnLY91VHvSeyowkl3yVmcMAw7/muS5PGqXBTu/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38070700005)(86362001)(33656002)(38100700002)(55016003)(71200400001)(9686003)(5660300002)(478600001)(54906003)(316002)(66476007)(66556008)(66946007)(52536014)(76116006)(6636002)(64756008)(2906002)(110136005)(6506007)(7696005)(66446008)(41300700001)(8936002)(8676002)(4326008)(122000001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?InxeBrOAeZlkoRQ6A5pu/6dXRtnAP+hbekXTXZOutDrPiXZlgDeFOP+IWLA+?=
 =?us-ascii?Q?EJMmY9YILl5ysoE/YX9tPu6YmMd9lUFYKq4mgZ8FXweqFJ6PxKv4N31GdoY9?=
 =?us-ascii?Q?Zpdyl4+lBa+mKdvpCr0DCip2QtMXagke9kLABBWJvEAN4AMopw51NIQdqnWn?=
 =?us-ascii?Q?nCGUdCJM7JRrS63AFGEpuH7vkt/Xwdg1hUtSz9UklYSzPeAe2o8ueCz+Gtu/?=
 =?us-ascii?Q?YEEhRLWpMkTLzQ3Fdy3dAycv3BrMyQA3eTzzRdU+bkbtJKfgpvtxGyrvUBGT?=
 =?us-ascii?Q?bff+UlZUHNhTqF5QVBIXYhOLHplfX0lSVvBoRksNEunH9lAh3oO84SYXs4BP?=
 =?us-ascii?Q?gsJAYCg/YxU2eUgUB3eTm7ZzCeUgbGQk1P9TzTQjarsA0Gjb2EP0otTczI/8?=
 =?us-ascii?Q?Fdjw195JSxf35BFaIimG+brDImolLt0OWH9kFrXtqmwOqrOWMTv8VX7RXGtQ?=
 =?us-ascii?Q?T6pbBF/KJB6D0ZFVFV2odm2l4KbuVUSzFBa6UiBA28j7aZdzI2MJi2/gV05q?=
 =?us-ascii?Q?tYWlYqzGUGMCWQng9gSUrQr7pVYDNiQ16k8Q1LtLpI5nrS2whq4ST8qkNZq6?=
 =?us-ascii?Q?z7yPZZHxeq5/i/7nqxSt6Mck27H4YI8+DrMJwW+DWLJA+HGWMBEoj4wtAe5+?=
 =?us-ascii?Q?+1uQul7PAZHHL3GzpPyovBzVtk44DuvygQXSfOSg3MEQL5btdHabjPAkF3Pe?=
 =?us-ascii?Q?I+loMOJ8SMFz4LpfjRn2vNb7AiKL1n/zal5IsYC/ZPezvGEZvYXU1qMNd/ay?=
 =?us-ascii?Q?cTnN79t5vQUDu6HQtDzxeuruvPq24ANaKsE5SafnxxHBT7w7BnTc7qd7FIEM?=
 =?us-ascii?Q?gLAAsDL25OGXI7AGUUElgBKSqdndbdXZFBeByQOKTn+2Gf5HhVTbQAyVi+Ve?=
 =?us-ascii?Q?NDj7YV/ZWx3yYJfLl2DgNr8sUoO199GVzRq1XMjbKTLY2/rowU0Ly22vqBnB?=
 =?us-ascii?Q?D+Hofk4CNIE23EHoPqx6sEqAi4oe6Qtwtcq1JkW+qML65RAqaGJc302TLQ9y?=
 =?us-ascii?Q?KYJnlGo5YOobt76Du54COH/d2SlcrhJSmYkXdM+09Wpk3AL0dkTg6CxlOjCH?=
 =?us-ascii?Q?IKXdoB+TZsfHkGLqIqQa52PnJTcnhF8n4qokFwnJxLmLv0H5h7Jp4DVqq0dt?=
 =?us-ascii?Q?qzWM/XqQ77QAr8KgTWb3FHUgDGmfHaUR1EVAMiuaWCgesqp69msXWeRFF4e8?=
 =?us-ascii?Q?gD/UiAWtUbYk+ostMOGujw5jAl0RSVvWWdMJ4oH5dhC8AkQ2zKSrECFnF8If?=
 =?us-ascii?Q?2872ndpCdR7SNUhu0IVNRaieAiOJTuqMjt15Z8ASNhcMk6rBgtidqOs0qWjP?=
 =?us-ascii?Q?yVVH36hj/Rf5igkP4Ux8VZuTI2ic/nzRmucFhhpGvZnPAL9y1Ejcm60kVRof?=
 =?us-ascii?Q?sR/Pq5dHmd4RiR0Qq6nAvCpQDO/uUTX2TeA5MhAh/O0Pt7OblDb7fDtHwaok?=
 =?us-ascii?Q?u7eSM/oq3tKpIk3l6piqBvsZhQH/UW5V6QGZ9qx8ASb79jh0Ty/j3QyFQM/V?=
 =?us-ascii?Q?J0L2sW5S1ie2PRVT4gmcHArhPOkBs3fzwCdXNEUsoCQW1aFsLnowvCGNut8E?=
 =?us-ascii?Q?CFWOWGq4GGFSxbV8OkY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f2b9b1-67d8-41ef-c0de-08dbc4fa827e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 16:54:01.2728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhZNq7o9tD9Sc2euvC8Bn0sYZI8o7J5DWxb3rjQb7G+G2euCaLCLb/oJXInBRiHGXnrFVmfQm2ZQDlcSM2ghVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
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
Cc: "Wang, Chao-kai
 \(Stylon\)" <Stylon.Wang@amd.com>, "Miess, Daniel" <Daniel.Miess@amd.com>,
 "Chung, ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>, "Liu, 
 Charlene" <Charlene.Liu@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Lillian" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> From: Daniel Miess <daniel.miess@amd.com>
>
> [Why]
> eDPs fail to light up with seamless boot enabled
>
> [How]
> When seamless boot is enabled don't configure dpms_off
> in disable_vbios_mode_if_required.
>
> Reviewed-by: Charlene Liu <charlene.liu@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Acked-by: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Daniel Miess <daniel.miess@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
>  1 file changed, 3 insertions(+)

Feifei,

Can you recheck seamless boot on DCN3.2 after this lands into amd-staging-d=
rm-next?
If it works, we may remove the check to only apply it to APUs.

>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
> b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index bd4834f921c1..88d41bf6d53a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1230,6 +1230,9 @@ static void disable_vbios_mode_if_required(
>               if (stream =3D=3D NULL)
>                       continue;
>
> +             if (stream->apply_seamless_boot_optimization)
> +                     continue;
> +
>               // only looking for first odm pipe
>               if (pipe->prev_odm_pipe)
>                       continue;
> --
> 2.25.1

