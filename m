Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75433C4706F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 06:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C1410E394;
	Thu,  4 Jan 2024 06:12:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC4710E394
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 06:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsV2MMMo+MJQAgGiD650PDnVciJwHcYmf1MBtwoul73JOEeq6Afy96maypKY9vRCKP9/Y63tOHQfQCEObKpdRXoV3MpsMr9LVzWWauKfINEX+sg8D08yocZRPbeLKxwqW1ttauBI74Wd4TTzd/dYR8LjrdpHjx+89lS1TM03Hbp14/sIq2RJGcvKUNWiss1kRkiDWQfFps4hFoGEP9EoBd9pdho5C1ibkMadnvTRnRdaE+7oIClkBmJnE6IQSmWOaj0hq1W1+0qwA829gZwhJgkBtBMok3aO/+KJl3v8qVvS09eny6OIV6ygHyYO4XATEL5nQUmwX9Tk2qofeiiZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yw0TfPvZqt849f4TVEPJ2B9m7fAZQgvp3bCLIxJbmHo=;
 b=YpU32kxAK9fWkfo8ND+7jF0AzgV5oGFl/ecbcoZvKDFiimyoaMpY+nVD2MO1LTisc7a+0XGqVL3RhpMwY7R34kW8DYGUTBqyVESGvT1IXRpLmRm7iORUDHS5mdNvjbtcIZDPkpebgsvE6Dti9Ma4LdTdP/57MBnsb1XyvtovuPBFsPIEGjrVwnJEZPN4BG5CPkcfA9QNz89i847waO55pHYs0ZNQO8aqDDpUE9/uhF9KscGw65RwrwRaMWfUpAzuWYRBRrut5NskkDSyXthT57XT9T4FtGCGbkQD/vOcMBS38bY6j5wTMTED2L5Ws5uzHU/fwjMFK6zLgS1C+osR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw0TfPvZqt849f4TVEPJ2B9m7fAZQgvp3bCLIxJbmHo=;
 b=J3G0YE+jvZoJy0x1vQ4gguUh0dvrZVEoYG4Ilzlc0sBRIzqSKbFE67QnY1YLSVyPIut52/Qp+2yLpfflgzH4ze+83EHLv74QojNlLJ4Vo7MHfZ5v48nicUUUCo+xtI4wSt7XvCq+V568dVDSEu80ELdAlYWQy+W4bbnNXCUWLm8=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 06:12:01 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 06:12:01 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Support poison error injection via ras_ctrl
 debugfs
Thread-Topic: [PATCH] drm/amdgpu: Support poison error injection via ras_ctrl
 debugfs
Thread-Index: AQHaPs0mp467mg/3hUKh/dUbzb58QbDJK0GQ
Date: Thu, 4 Jan 2024 06:12:01 +0000
Message-ID: <PH7PR12MB879622373727FECD79EF344FB067A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240104051542.3770904-1-candice.li@amd.com>
In-Reply-To: <20240104051542.3770904-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9efdbef4-9a18-4a83-b1c8-8f100cc2a0f2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-04T06:08:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MN0PR12MB6223:EE_
x-ms-office365-filtering-correlation-id: d47fa54e-a562-4b36-373c-08dc0cec1103
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: moRL8P5LwHUXckGfm+fC9L++a6ykGqexP/kdptO2rXZeNWFpiXhMuaPv+mJc+3XRkOZoKDtFLNSr1ZFUM1bixYNIl0wLyFWHcvE6Ivh4Ss32dMH2QpPEZbvmnriL3vh6/GJUW3vx4t0WtcrbE9ZdMl4TS12K5NcL33NPVi4cPLXSDoWn+ioaAV3iAd7WOfEWvNcrNPwXaazYkgsMiDh4pxSiEhXAEMGvuxALfQroBN1AIhGLh+IPthsR9cbRCu3GKOGoI00VVBe6vEWUzBbWI17+qHMCTLcFz3KMnkRDaw9+iw0P68lBbH4L+h+PsGQ3qEc2V6yH9wSdLkMe6K5+aPKsXQydcXgft3kpIy+o9cClZwjS/YWOLDXqJEvSNvNdDWK1l/Nc1hmk4z03W4DCpbKo2Y7XhNYEUDCvBNGI2YGTBdijvMwKDN1b29XlSfWZZe8zCBiLOXH77reeQakzFv2J1kJdDwkx6JjoaFo+4B8vuexTpk7d8r+3yPzwJz9MCmxMCrBRlXOtKbWm/sBzY2jWy7sBoeTymmB7HU5VsXHCjXgMWQEcgfNo9oNk5kNCPcQwpfuEs1tXuvpEBn+Q28gDDe3yzY15FNluf77m02tKvEKiGRUM/IgXKa+oGsFg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(122000001)(7696005)(71200400001)(2906002)(478600001)(52536014)(4326008)(8676002)(9686003)(6506007)(53546011)(66946007)(66556008)(66446008)(76116006)(64756008)(110136005)(66476007)(8936002)(316002)(5660300002)(41300700001)(26005)(83380400001)(86362001)(55016003)(38070700009)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?proc+UzPdk8bpeUMnbZkPHV/4oTNtvcyx15w08sqZq7jHWjXOBTYS7N1AKOg?=
 =?us-ascii?Q?bwmdeTcHmDOnU8wtDHgxBsIo3PHPsslqWXgS1vdlOhSbjO98xiQZV+YQLi9d?=
 =?us-ascii?Q?aDLCPqQ8o3Pr86zSPKwl25YGrHEqgFCuYlyslh5GSjRpTsee6m6bYtTMildJ?=
 =?us-ascii?Q?i3Qh2eASE78flwbnqDpckAyxqrXPv+IfxmKLGaZObhyK1K/wK4/Hb88tsMGM?=
 =?us-ascii?Q?t1kFCldT3xwYEoVkcWJx8qA6/odj3eC5VNNWui89VOnOqa5PgNzx/UVtFtFZ?=
 =?us-ascii?Q?boni1A+7UCKZnG47TKnlNyqd6LWcDlm3xwui6ptekFHSv9lUFoSMdUmevOub?=
 =?us-ascii?Q?FtQ17JVk/XG0zgxBYGxdC8CFGOSdZgoBSwc6TmTfwfECtIlq07gwAPt5ET7D?=
 =?us-ascii?Q?62ePn/sHaeYsVIQl65fexciRXfJ4MowTcyQZrZKGrtcEFDDrWaXqmOGsIjkb?=
 =?us-ascii?Q?FT2bnBWzAiTq5ZzfecPBqTweyziBHNYDQjT1NeZSBCxlww7TAXgdpuP+V1AY?=
 =?us-ascii?Q?sH1+va+8VljnfU1l6cUGM0uOuMkUFpBRicYiRBGjLEPhDIO4suH12MqBNl52?=
 =?us-ascii?Q?W0Q3WuZYlvtklhZvre+Jh0BVTjXWKYCkyz4O3B9WGpZ5wMESCpDCq/pI5aBq?=
 =?us-ascii?Q?Z0jJMoT3VtPK3NHg5MqSQ91VS5jPLE3Ytj9qb7ziy0JVouovsg97vzHWjcxR?=
 =?us-ascii?Q?nG6Ka4j2XJP8QTA8K8hlMRs8304PRmLATgw5AEXAcaAJhKJDm0IqSpCUvzOo?=
 =?us-ascii?Q?fduH/11Xcajf1XmKfzSsyH5sNiLXzSK5Bcnl9+F1cqY8LVsBDaSc7wIJz7c/?=
 =?us-ascii?Q?Sy8b4vfSI/ltJkXc8AY9mjhx4qlU0sxvcGkTTTgNFnf8B6lDVBwpwPROJ17o?=
 =?us-ascii?Q?QOj0bm6+ghaqJUCwMtUXf4/2TigsssiHnOX8F6awUakL7FKvQO5NGpMvd21y?=
 =?us-ascii?Q?BweyLQEJDNZMgQ3AL8TRyQi5G634ABqCNZiWD754bXgUTWslOlFVm3R9G4oU?=
 =?us-ascii?Q?/zrriEJTItRPcHCBLkqkiCZD+GWN09H3WxSKim6Fn7VC2aRPSlPIwLN18243?=
 =?us-ascii?Q?SkFiuPlWSsRPhCRVdjMhLdoziqV4MeUaYpNVVktoeYCAJtDs22yruya3aLW8?=
 =?us-ascii?Q?B8aol2m7/QAbYzjeUg/YSJ3Gfqck+pLLjIWa6NFbgO2TImiNZ4i/vGSfUKVq?=
 =?us-ascii?Q?h9N9u4nGx0WPc1MgC1E5F6zsa1D/R/TRZZ74zUbwSQyd1EYo5Xt6ASBQxki3?=
 =?us-ascii?Q?akGMS6IbVVL18hd9lBPXM4TSpoSqoZbdloTR1Z3vIUXx1wokuypQXGOXDgeY?=
 =?us-ascii?Q?HaOdcSPTloMELdbW7cXgi2g2kc8D66bPQjUDnECWdloO6UiBJwRI8YHpxdj5?=
 =?us-ascii?Q?1qLl3FR79t0X3v+wF1EsYb1BjWrJi3eIKCUZ57kkc3FBKnsZ4tisXzNKBR/c?=
 =?us-ascii?Q?wuv1GDlMbWLAQdLmj9gFfvEgaraWHLzQuNPGSdLnLVxTugles8LuMVgBQ130?=
 =?us-ascii?Q?pa3FE6fHnnnWODblcMIGFXqBeNOxucYUj9g9+XIQ/qXGGGYcHRmPbhc9ML3r?=
 =?us-ascii?Q?UedC2jTCsIyofdm9Nrk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47fa54e-a562-4b36-373c-08dc0cec1103
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 06:12:01.6396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uwo+bspQfukCdO9ZtmdMdvCn81gFPL4AUrJv/OhxIHcs0VCg86IjfuZ7uSPiZQb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please also update the description of error type in "DOC: AMDGPU RAS debugf=
s control interface" for ras_debugfs_ctrl_write.

With that fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e Li
> Sent: Thursday, January 4, 2024 1:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: Support poison error injection via ras_ctrl =
debugfs
>
> Support poison error injection.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index caf00df669bf7e..5851c7a80a5a8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -305,11 +305,13 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struc=
t
> file *f,
>                       return -EINVAL;
>
>               data->head.block =3D block_id;
> -             /* only ue and ce errors are supported */
> +             /* only ue, ce and poison errors are supported */
>               if (!memcmp("ue", err, 2))
>                       data->head.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
>               else if (!memcmp("ce", err, 2))
>                       data->head.type =3D
> AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE;
> +             else if (!memcmp("poison", err, 6))
> +                     data->head.type =3D AMDGPU_RAS_ERROR__POISON;
>               else
>                       return -EINVAL;
>
> --
> 2.25.1

