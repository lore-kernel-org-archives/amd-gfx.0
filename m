Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227D1C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 07:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6820A10E780;
	Thu, 24 Mar 2022 07:12:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4954C10E780
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 07:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+RbQc+UiAp+ukUKQJKX83sfYEqSESwZ55XbwUfFUHpi3FTh4LVYKIzGtc8KCrqLV5ix6nNjZ+qppbI3K93xhsbsEsbycWcO37jcbeBSg4BTpBS8RL0R8pKLytvdR41X9v+/08FQ7IGqrlUqZr6072g2reS6934mi9y+I8NSSLy8XUMpBpXsc6UF46rDsw3OIvpxYQIwaoPDAdikVGxkernXPw6HfphNC7szey8lJ2YFKPz8nvgQ5Kt9xv0qO+nOrDHHzBhoiPEijAYk716KxmwGaNrSrHCmEO7FCB8Yj+G/TfvHWhDyen/BOr/S5GSTkOUoc0omE9etM6H8yHSWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9q030MjPlPlfUHCoeMGujwou0pAZ48Yo3jzSPIZN34=;
 b=XARrLdDw7E9Cf2aomdZ50dshdGaIRWg1F1aARcnYQyFoAnjSwrzADYjso+H/Nty/06GONiUo2SrEkjma1PI++/T0RCV9Mlzqmc6AhaiRf322mx2qrIjFMv0t76gnz4ZtrezyWGodsHGNpNkAO+vuc4AXWvYWIjLE5K1+aJXTH08ftZWt0Cq5h6iuoPyjtqPjdXLsT1l4HURjj54t8TnR1bK/Cs5vfomkon+gw8ZYFqcFkjPuJw+WaUoZ1X2qNr99FgUtKBwrvT8JsGSNLkvaZccuPS5Z0aenXPkZ0o7fERvnOqTXR04Ws2yjif2pM28Q7JRgGpmaDIiqvdZcqAY8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9q030MjPlPlfUHCoeMGujwou0pAZ48Yo3jzSPIZN34=;
 b=r3u9a6/4lLBvNWj+Fy/W3aoeJCYhrSKC86xxVivAY0MtNFbvSvHajqHZiCYXuJUxw8Ch5CeMjDovRN4w+WZY4MXtoceK3YD/QIxUwkCJHEzZLKAMJ+WWc232yc1Mdge4qMeWtEcV8KwtynIOdGG8whaEOQnR0rtibWGA8nWzTL4=
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BN8PR12MB3428.namprd12.prod.outlook.com (2603:10b6:408:47::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 07:12:19 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::dd81:c0e1:45cb:18a7]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::dd81:c0e1:45cb:18a7%6]) with mapi id 15.20.5102.018; Thu, 24 Mar 2022
 07:12:19 +0000
From: "Chauhan, Ikshwaku" <Ikshwaku.Chauhan@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Program color range and encoding
 correctly for DCN2+
Thread-Topic: [PATCH] drm/amd/display: Program color range and encoding
 correctly for DCN2+
Thread-Index: AQHYPvo2wyblpqb0JEqDTPCdstkLCKzOFs7Q
Date: Thu, 24 Mar 2022 07:12:19 +0000
Message-ID: <BL1PR12MB5176D4F2B0390A8E87BE2F239A199@BL1PR12MB5176.namprd12.prod.outlook.com>
References: <20220323210845.182507-1-harry.wentland@amd.com>
In-Reply-To: <20220323210845.182507-1-harry.wentland@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-24T06:42:50Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3312a951-2a4d-4dd0-8d83-7c56e5545710;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-24T07:12:15Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 01cd827c-2fba-46fe-a3a4-d9337d070ba5
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44c168b3-5a01-41d8-0329-08da0d65a2a6
x-ms-traffictypediagnostic: BN8PR12MB3428:EE_
x-microsoft-antispam-prvs: <BN8PR12MB34289FC32D8ACB7A1F511E429A199@BN8PR12MB3428.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e7EurQm2DKZ71fdcKDaDi27T7nkHhrMJERWofD4rzT94O2aWg/gf+aKtAy1QxwbHrdqUOCUpkYb0dqF4cFjkaIagjJm71qVshzzKHeGkVUhftPgcRmgNQ7HCpS8fqdCRmW+1EW0R6v4M4oHP6e94H50WRFEntCuaJQUJl+hk4CmIzldNJWjTtDqbdrx8do758vrvAxsreDQRu77ge05ZGDj7gXza8VG/1BIdAEwDryjI3qdm9fGYdN/woP7bmnulDRrtSgyDkDK/doU+wEhVmjCplL+TJptZvfyPXxAGx2Esrun1Zvldp7GjSkany3ZVN9KEUFKU1qfUnz5GAHza4wP2LofKuQneSobcfHKa4fh/x2Y8j6cICHjJEd4FGbcl1NVlqAD7YkXbLmE+JHPR0yhiBETyBs6kB1t8avDIS+zJmJHBS/qj031WONvwbYXXoUfZc01RYVr4SN6J+WDMOPhGAkBVioCWg6DcNEWPZtmE6HNS3AdnVd7ZV12q3eyM19r2ddSupP3b9/Kp4ZdZ9ibT62g+L195qCru6Tuh2ZN2a5aMt66d/7lSJesf5W5GsUQZIedHd2slhm2S3SsLeki269eGDHE798BKP94IMMyxF7CNkEZoTgwDpLZvu2QYGagzYSFG1O3ZeH/B6cWE3XstigErUjZ8Mi3PC3Kk6CcVL1cB/RvRBhoUpHgkVcX2Yrj/mHi30DIkBgMB5cxz6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5176.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(5660300002)(66476007)(52536014)(186003)(26005)(76116006)(8936002)(66446008)(64756008)(66556008)(9686003)(122000001)(38070700005)(7696005)(38100700002)(53546011)(4326008)(508600001)(6506007)(54906003)(71200400001)(316002)(110136005)(8676002)(86362001)(83380400001)(55016003)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lt9JGhOBLKbPxQogzI0x7i1f5VYQFxihxJoJww8G3JBuNpe05uUfSdY/Z6wH?=
 =?us-ascii?Q?fET6HmfdCZ+f9gnZZeHO2jyhTPrwTiGmY2dSb0hdvL+xI14keIMjbzeS6GyC?=
 =?us-ascii?Q?sonlYAyvYRxFqzlhriBkviNeKkEy6sIcmJCFH0Sivolad+nw+fdwJO/tImxU?=
 =?us-ascii?Q?y9eCqy5tDH8Oi+7xi7Mj9QKV0MyTsRCzFKx2Nfz8e8fglaTH0ujtfXLpLexf?=
 =?us-ascii?Q?m/7bGmSf7ToiQbiHzEJh/QLae07I78H+bFzvZ7mGCmy8tGHh738n6WINLxLF?=
 =?us-ascii?Q?HT1beuXiNV6DNTEL9Vx9de8gZlOhL6nxdJ21J9hTzxUFViak0EAAcQW+mtdY?=
 =?us-ascii?Q?CcJu8CLeMayXVzh3rwEY/pOdOw6zNgoiPNE63u54/r7nP52Q1BJXBX9ylixO?=
 =?us-ascii?Q?m8yWLn+CyYH8YwZVJRFhq7Vh7XrcSl7mciTF0NQZUru6vRF/KFknYa8oRyR7?=
 =?us-ascii?Q?+BNkShPsaPR032sjAQ5e+IJhQSVWAioe2kkFvfNV454U8Yn6g7wmhOwQdRik?=
 =?us-ascii?Q?b+AxtIcPaCHpsKw0BAWGBK6BxrWVL8flozOEfgFIzrn14USGDas32kwzhDgF?=
 =?us-ascii?Q?F09HP6KxhCz0oSVZaSorikvwD+93NlGoRbAqUNILbagvz30s/haf/tB3uklI?=
 =?us-ascii?Q?808xwSPs7OPsdreoec3XcVgP8P3w3Fc+jxJEICkYepI9QpyQtMk1ah+ttSSG?=
 =?us-ascii?Q?41Hp6fAYff1xds0NP1ywbF3rcLDMMZIu5ntjDvmUXgc6qqh8XUi2vBf9NhDY?=
 =?us-ascii?Q?oN+rgxrkbBsYgYOjXSWSCdClUrwSRQ5ny9I+DXQPnGSCFkGnGWr+eg4UfblM?=
 =?us-ascii?Q?IIR5uUsi9jVyvGjIWeVnADZNMny61KYjXSV5/aICKkcH850uoPq7wbv2jcSa?=
 =?us-ascii?Q?iZXpfWBlxJdCcQB3LKQDLnG23JNl073lkBoPfGwVpu2Mxw2Na3y7ai1b3uYV?=
 =?us-ascii?Q?Ckd3DSX4WrgZzDIKUQ1ijGka530eKL4iOtzCD5FR0Jnq2jWGtMDI3J8jClFM?=
 =?us-ascii?Q?RPv29cIYL1bkUO5m3cijj5Ht+4O0CQPLf+dxQmmVpu/Fs1UKQLnWUNC2da5v?=
 =?us-ascii?Q?qs8mbjPplugjaxtPDssB6R8wIIJohRPi4RPfhfQcVU0+ccGhzpJ0NKNuzMl/?=
 =?us-ascii?Q?48SOSOFJocBUWSaxKmpTdAYhx6DBtKq//7JuL9fjw+47UEZb+zcdx0jLeLP5?=
 =?us-ascii?Q?QP3ZamZoo/3208nEnbtUfsWvuDZrkRi4+JaFiHbM9zaNT5NuJLv+JyW3rL1X?=
 =?us-ascii?Q?2mCsoVuaulTb6O5ItnMHUwyAWIr1x2Wc98w7a72DYmusogqZckzIF7wUqm5T?=
 =?us-ascii?Q?X4DknM9ksSe/3LKJCkrzIfPhwBrdTcvDZNHC9JH1flEPI3c4+3zo2XqvIEva?=
 =?us-ascii?Q?SB4NetU9gG6Mjts3nkul66AKDd7vC/2JG1G1bL/HHuHruzxFueOhmlbBIEme?=
 =?us-ascii?Q?rvpPvCRw0xoCEII61RxQHBr5adPPeK6/YukaXCcyfDyZlghDXbBSoblFp4zM?=
 =?us-ascii?Q?SfRrRNDetmR3PlcLCo1xHDkeBkS4dKMOTc6nB6skaG0btWqfeypJAYAeY2IV?=
 =?us-ascii?Q?Pg0y5JkD0/e3cihalcdlMyKfIh7US2OcvwVWegBKFjDwu9YjFU20AU0Dla3j?=
 =?us-ascii?Q?Ob7FjJ4O79pptLT1BImvLtldfyNB3qkgizIAqF4EAk4GHBSDycgWK2zRbi7M?=
 =?us-ascii?Q?V7BgsFpaK8V9I+hvPatu+dQL3QOu51ud7k4i9HHMaYSxLgKQFKqKIbeupSYV?=
 =?us-ascii?Q?YHWzH6ZorA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c168b3-5a01-41d8-0329-08da0d65a2a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 07:12:19.6743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tLo2vupgzMsPB/EGPm5JsBs9p+SBK2rLBr6YfNfow2WmmtuFRTNf3siubDSNMjl+ZoXTn0yAKhoFPWaZUAgyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3428
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
Cc: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>, "Wu,
 Hersen" <hersenxs.wu@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]


Tested-by: Ikshwaku.chauhan@amd.com


Thanks,=20
Ikshwaku Chauhan


-----Original Message-----
From: Harry Wentland <harry.wentland@amd.com>=20
Sent: Thursday, March 24, 2022 2:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; stable@vger.kernel.org; Wu, H=
ersen <hersenxs.wu@amd.com>; Chauhan, Ikshwaku <Ikshwaku.Chauhan@amd.com>; =
Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; VURDIGERENATARAJ, CHAND=
AN <CHANDAN.VURDIGERENATARAJ@amd.com>
Subject: [PATCH] drm/amd/display: Program color range and encoding correctl=
y for DCN2+

[Why]
DCN2 CNVC programming did not respect the input_color_space and was therefo=
re programming the wrong CSC matrix for YUV to RGB conversion, leading to a=
 wrong image. In particular blacks for limited range videos would show as d=
ark grey.

[How]
Do what DCN1 does and use the input_color_space info in dpp_setup if it's a=
vailable.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Cc: stable@vger.kernel.org
Cc: hersenxs.wu@amd.com
Cc: Ikshwaku.Chauhan@amd.com
Cc: Nicholas.Kazlauskas@amd.com
Cc: CHANDAN.VURDIGERENATARAJ@amd.com
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu=
/drm/amd/display/dc/dcn20/dcn20_dpp.c
index 970b65efeac1..eaa7032f0f1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
@@ -212,6 +212,9 @@ static void dpp2_cnv_setup (
 		break;
 	}
=20
+	/* Set default color space based on format if none is given. */
+	color_space =3D input_color_space ? input_color_space : color_space;
+
 	if (is_2bit =3D=3D 1 && alpha_2bit_lut !=3D NULL) {
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1); diff =
--git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c b/drivers/gpu/dr=
m/amd/display/dc/dcn201/dcn201_dpp.c
index 8b6505b7dca8..f50ab961bc17 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
@@ -153,6 +153,9 @@ static void dpp201_cnv_setup(
 		break;
 	}
=20
+	/* Set default color space based on format if none is given. */
+	color_space =3D input_color_space ? input_color_space : color_space;
+
 	if (is_2bit =3D=3D 1 && alpha_2bit_lut !=3D NULL) {
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1); diff =
--git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/=
amd/display/dc/dcn30/dcn30_dpp.c
index ab3918c0a15b..0dcc07531643 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -294,6 +294,9 @@ static void dpp3_cnv_setup (
 		break;
 	}
=20
+	/* Set default color space based on format if none is given. */
+	color_space =3D input_color_space ? input_color_space : color_space;
+
 	if (is_2bit =3D=3D 1 && alpha_2bit_lut !=3D NULL) {
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1);
--
2.35.1
