Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E535FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 05:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E9B112BA3;
	Wed, 25 May 2022 05:58:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD37112BA3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 05:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVsoFKauuoZfqkYx4fQrLDCmi1QJkUYa8MkrQf9FK3PI0z4jDiGz1NRdb6e+fu/YkOVxPSUPmIUnueLTUcUbJDKz+kjExYS3QpfJrg5QOeXHkc3lyTupfztoWpQ+7GhxMoB4vH1wu+1zNThOOg0JBLbFrR3TdDL0h05xE4+aoHCjO7UF/lx4J1QXDnUfM5/nhcgr2J4jXbvrpCGwk0oi8DtqQk1vgUyjoZgVPu4u7V2spgj72rVG+GAz6fmN7TY74Z+so3UXHLFQNtj/vsA8BjT7rtii3cVfnTax06YxuzyXYiIwTJ5/AowXb7msdcAHtIK9SPSCgmvmI+CWisFKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFqznigEmy8BL/dlSdxjjFYWxqqcFtYzkNb63AxV7Xw=;
 b=KCaFbopghAe618lJpryBwUIXaghoemq2C9MGRyvV6U0sdVpPNymUQNr3yLlfIMcm27xkgNzJ3Z1aCX0gQ1D1LnB1zXxv6N7DDXpljt/oJ76jwBPF8MFRg4Y/Eyle+Y14DSKJUAuASCHRgrVx4z1WNliCqXcB5RfghyrCBPnPhy/bKkJ2gMROupW2wEdCco2YKjDFRlbp3QDFBF0lnRM1ziQvtqqHRuW3TZqJkx/sR+e17x21JgInmtbHt8nm3RauufNyHow70uJBNtCA+Aa/ja4z/M7G1Saw0A2j7MPrmzaJIUzXqmUhr5l3UxLF0Ilmw8+7Aa33ES26dSeQQIZkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFqznigEmy8BL/dlSdxjjFYWxqqcFtYzkNb63AxV7Xw=;
 b=oO7os65mY7oCNfMDk8PpGNME4hZJR2QR7nbRMaK8I4v06iTe6mYiljhDLpyc465WHGEGstUBJjtAumEBFKF1VpL7hz0uPYJpnjAgLiidbBxZD5OM5gYM4WlQqUoFhW8inbnxC74mze4XjerHRMWgwnwtINAY22A/8N2cAmt9nKU=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH2PR12MB3928.namprd12.prod.outlook.com (2603:10b6:610:23::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.19; Wed, 25 May 2022 05:58:11 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050%7]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 05:58:11 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify amdgpu_device_asic_has_dc_support()
Thread-Topic: [PATCH] drm/amdgpu: simplify amdgpu_device_asic_has_dc_support()
Thread-Index: AQHYb9yKwWq43WW66EqKw29SVvGimq0vGQ5w
Date: Wed, 25 May 2022 05:58:11 +0000
Message-ID: <DM5PR12MB24694F4B53BC85A2670BDC87F1D69@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
 <20220525020926.1951685-4-alexander.deucher@amd.com>
In-Reply-To: <20220525020926.1951685-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 475a01c4-df8d-4a2a-26ed-08da3e138cdd
x-ms-traffictypediagnostic: CH2PR12MB3928:EE_
x-microsoft-antispam-prvs: <CH2PR12MB39283AF2DB8C669CF72C482DF1D69@CH2PR12MB3928.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TxI0t8EyGNdqsPSojMGC1XqOReB+86YWWTx8/+R2yThujKPbkx4yba68kUU8I8xdoFPPIRRq99Lx4uPGGVystfVEEYjIcOia+R7SGP41LB2xb7QZk2Y+nVKAMxPg06KyTDSRy5gXghmNg3PR6+o+dlxK8oaC7vBGxZrtYs15u5LxxK6+SaKzjFYDoZpvB5cXNdUU5u+p2HR1wWBfXCd54ARGoeDKo5m/Rcxg6ALw3Fij3YEAK4iUV/EYKcALb8suQb13iafw0OLPj/3gt+f0zIoUCiIDPq4QBp2f3lYc30hAdTdQnD6Y6Vu82rIXTaEQm2R6H0bhr/CJOB6wB4qvcocnaqY3CgmB9fRMlXWC5X7IsEIA8sluIVyxWlJ3PvGZQfWUyGLjcjdjQxBN7CV4d5F6LnwI3wqPupw1x2vNSpzGbUOYf6PnHA6U56EjZRIluqEAPH4AqpqN4aZb/KvN6z4aDKDSLcmRKeIVR7MbssJ5iXByVCkKdOg0/fD/evB3W2/M3VRv+S7kxJgUr42HZefY5TRwgwFQ82UpOaHi4zFCvh4s8/3uTalXex5/U5u3iJxCWYJ1bw72li3hkfnOwzIpOu/+P/LNO+28ssz/LVvNCFm7EuBO/l5Qbbz1G/Csz7ed8VDhaD0JzmYizdxOLD4dZ0RC51qCFJr0qe/CbGOfps/I7YO8VMNSWPmo0wgu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(66476007)(8676002)(66446008)(64756008)(110136005)(66946007)(86362001)(76116006)(316002)(38070700005)(66556008)(4326008)(38100700002)(508600001)(55016003)(71200400001)(5660300002)(52536014)(122000001)(8936002)(6506007)(186003)(2906002)(26005)(7696005)(53546011)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J/N1k7KdWlTVVwIUoIgF5/q4Mxw0gnOzEjVJ6SyeMCz0siOkWh1OJaI6Onks?=
 =?us-ascii?Q?6mgAIoKd5ZY13C2MV67+oR208kDBYYIOA2d/iUVQGAsR7eKJsTdVKqbPK7Iz?=
 =?us-ascii?Q?eJvG2e59u2iEpi7Kr2AlUKi7itK4i8dOVbSgd66dOETrkchlMD0NK3kO0fjy?=
 =?us-ascii?Q?kK6a0QGnHPReNozjTvf5oSpsnrikFODydigBaDYhcx9OvPzwFWDOFysO1OkT?=
 =?us-ascii?Q?QRfxS+HBD31vPsShnYBnF7o1OfNMUNr0fS8a6wEbYLcyRWkeFeArAJAKFukl?=
 =?us-ascii?Q?AYTDVo1wqe4tRHg63lGD4tmlrN6OTjq80tyAXGlqfbgaaWmRYYXaj6l2neys?=
 =?us-ascii?Q?NU6kHK1aHoXPZWiYetV5zvBtgI49NOh6WJ2iIhz6BuTnDlrNdeJe4sw1Ou8W?=
 =?us-ascii?Q?Tv2M4gWIwqtfLSo6kM7QpBKzOcZFA584KzAw8WvZcbSy/dhB/7luGGP5qN/V?=
 =?us-ascii?Q?PUAl4ZQuxy5kpjtiw/cE1RWiwSXeoGUqHdwhvAYwn7cNqWe0vaNWY2is17tu?=
 =?us-ascii?Q?QK66XNTDufPnWpPOkBgP6FJAsV4UdY6cOPDDos4XGWRxxtYaIhQwOjMGv/F0?=
 =?us-ascii?Q?vaqydTJ1qbGKh/zURjpd3t0uF5QxDxAupQv6QPDtm0Ksh/nIV7tB47iF3G0l?=
 =?us-ascii?Q?pP0kbzQ58fuJgU4BSvoK0ND1Wjh5P4X5LnQcS4cI6X5bejrLoecs5hBhd8rg?=
 =?us-ascii?Q?lXMMRI1S6/D5MEGg1iXr9yKR5U1+t0szCKR3xkUH/bArlDcuL2EJCgm2zPz3?=
 =?us-ascii?Q?SnSbc6DZtug2MwFTxefPcrWnORkOC/aMti6sPPXxuRLB4NVytqAW8qiHUvRj?=
 =?us-ascii?Q?EZCsdlQ+njUoEFfCoE4S+7RnDpVGsn+Txk3r0PbMiwWYcNh5b8VqnvR9jLDA?=
 =?us-ascii?Q?Go0J6arP7JBwsTA7KjzWZ1q/P6fG/oC4Wl4QmExxQ+b8IfWadADENuNa+iib?=
 =?us-ascii?Q?uDYQhN7XU83v84FPtqYWmQgLGmXAVXDRnsEsaePRp/MiAuhtHiz/dITRjYiX?=
 =?us-ascii?Q?pOojlrbtp6RInt9gqkRiLqTbBMbE06y9o7McKaPaN0z35oivBZiMuxZVLeSU?=
 =?us-ascii?Q?09Fnl2Ntn1ZlbsvkCywoydldnWpXrlftnXkO9MMcOq7hAdUPFl6JKatP2sk3?=
 =?us-ascii?Q?kAHN+FhjmtFusJqG8Yk45iHqHVah6cZw1xCB+oveEDeQoJVrma4qldj1Bt9g?=
 =?us-ascii?Q?secxoosWIG61/a1WR0JJWnt9GNyleRwcKlfO9c0bgsgfzY2BG5Nj4UdQtbX7?=
 =?us-ascii?Q?uE1gx0YiskM0h1rxJTAGFgWqkqJOFUHJ3nGL3oiFU5SBOXL//TB/1Wh+DfQj?=
 =?us-ascii?Q?a/1j67qcUEZiMA6AW62zh4SlOQBWkyTe1wWtfHOaCAMAhag9Crx1ylHpDals?=
 =?us-ascii?Q?fLRkhqfV9s95LcX20QDBq0XsSCuOwdnGij/CSt0yH9yLAb9icZCaM609kPUc?=
 =?us-ascii?Q?s6SxHe+4wAiuuIWvp9b6detOxVgRtaFU4Zdt0IlS9WQKT1dMpnzfL8wgD56Y?=
 =?us-ascii?Q?eMjvFQzJ/yX6Mwf+Xwvjb2WBOPeAupTkYNUVYIT689WSGDF8s5QjIQnsmvqF?=
 =?us-ascii?Q?J88iAbnmv5cudTRYkXyDgNSE2jH4oLslmmgVpM7PdZR74NKcZSvWfTNbwPC5?=
 =?us-ascii?Q?O4sJsTERNEEjmTPXx8aXpfWbTzKigJtGF0qJKZtRUvd0LZj3hmvB9tkWA45/?=
 =?us-ascii?Q?3B5kqMumpQhFdFPrYJZ8S9ysYCE1YSyuTa4gaN1CaU3R8YGE2ZO/jzAxS3zA?=
 =?us-ascii?Q?lGG5c9ui9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475a01c4-df8d-4a2a-26ed-08da3e138cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 05:58:11.4482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHS/zo09NbPWeIOMM1GjJCKSd4CXVmzDsiMnlOcuRlPMkamk+SjvH3QQUZ/lJd4PdaXJVUEKWsGLSSWacaiFxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3928
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, May 25, 2022 10:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: simplify amdgpu_device_asic_has_dc_support()

Drop extra cases in the default case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ----------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7f7d475c46b4..dab0c59bfb1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3292,32 +3292,6 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic=
_type asic_type)
 		 * cause regressions.
 		 */
 		return amdgpu_dc > 0;
-	case CHIP_HAWAII:
-	case CHIP_CARRIZO:
-	case CHIP_STONEY:
-	case CHIP_POLARIS10:
-	case CHIP_POLARIS11:
-	case CHIP_POLARIS12:
-	case CHIP_VEGAM:
-	case CHIP_TONGA:
-	case CHIP_FIJI:
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	case CHIP_RAVEN:
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
-	case CHIP_RENOIR:
-	case CHIP_CYAN_SKILLFISH:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
-#endif
 	default:
 		return amdgpu_dc !=3D 0;
 #else
--=20
2.35.3

