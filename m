Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3842CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 01:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6ED710EF77;
	Fri, 10 Jun 2022 01:28:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99F310EF77
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 01:28:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gymtakCFUJ93GtbluxUSwwvdm+571X/ZpcMQSoycIv388wCS3QgVfVgo4HgKB0hLxqXHALU0lbNahoI2dZRDw/AyoV/LENBcWdTUPxXpx5y9iWylOzKa0yu9kxaJUH067902Nr3z5sfdjHnaLTglt+XyiC8QMrihVPR90pAZhg9nqqdhZVkj/VK3crs/hjdumSkk/Q4mXchGX+l7t7OpgEoXth6vg0lpUyvfd9e54pHUG2O6U+SH31XSOViNsgMNC1gnYM8UDBXD6fwePZomk6MqEBu6/0SHp6dG4Gxl8h4xjnGdpwAiKBAMmrN4FmAGfdJnNVXbWGI1zUTQR4yycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJgbms0R0HiX8HKdmgbiSVy2NiBTy5ZIiY/xwVwHZ90=;
 b=d81pBxfwEfi92FUbEZ3AFszcXhD42nMTLOpWhq6X3eY4/Kcwv+68ecT2Ut5WimASrCQPPUqXkcR1VaPg3ay0rtZ2mjipcZn0emfhKDq7+ciIlTSoeM3gOqoZC7T1lip8yg+jbLYuKqO8/WX2piRplDc+iu8Ui1TOxsAHgth4A48fM3GyCzIFhwHZ4UPtNhZqUjycGkb1W43SE546tbnpudk3uB4EJDwMXXFazO2xdUFcA2go7UxnS6LnBl7YukDX84B71cT5EF4+iCX1YAzzCAKHAOcHE1X+KtY1vURjt92rXKGO/4bHO6yJJuI8s8g40iL/H2pcmqcw0R6P71KzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJgbms0R0HiX8HKdmgbiSVy2NiBTy5ZIiY/xwVwHZ90=;
 b=20sDlkiNL3lDxbiUpu3wU4YqIRit99wyeCLSseI3YkuZAvC3QG72N1W+Gdee1Idl5LRw6Ra0E71us599CqWSnPJqDWL0uEjR+e3iCg7D9aWRY3Th+8qUYeaq67i2RL76XveY+o9lPVu4EJdLSxjxDBDhIgjHCi2DPa7J7TP7ubc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 01:28:18 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202%2]) with mapi id 15.20.5314.019; Fri, 10 Jun 2022
 01:28:18 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Olsak, Marek"
 <Marek.Olsak@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: ignore modifiers when checking for
 format support
Thread-Topic: [PATCH] drm/amd/display: ignore modifiers when checking for
 format support
Thread-Index: AQHYfA0QxvDHSR0T40eyaoSCrB62DK1H2kaA
Date: Fri, 10 Jun 2022 01:28:18 +0000
Message-ID: <DM5PR12MB24693A6DB8AF22CB79B0477EF1A69@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220609142725.28973-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220609142725.28973-1-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85f8452c-825b-4249-0773-08da4a807f79
x-ms-traffictypediagnostic: MN0PR12MB6271:EE_
x-microsoft-antispam-prvs: <MN0PR12MB6271001A425FFB1B67F50858F1A69@MN0PR12MB6271.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ItP09GzMg1ZFh0eIrcgbOWufQW5t11f8tSzBJHSo0H3vAqcKzcyIGO1ATKeRgDeXmyw4g2+5gj0ylCJ2fjT/6bOP6FUqqGQTZNaXmE5WwUs/jdFkSzqmeMhvXPDkteYvuruUCkcrDqZYufFmhW8d+Ldm8PC1/0HbFkrgXuhMtZgrwDvAZ2lXSBu0aruaP87kqE2v+tziTfo5klJLPZabdlj2m5WO5lMOMR8dPQzCCgEx3RUq/U/RaICb1DeGw/g+eHi4iQEzRrIJfmXZ6f+pbjk9WfeqJfCKeALEReg/MqYumQ0pgxu7lmM7dKruJgH9NX9PtlwXOZsIR4q6GElS2017aU/eMx39GYQ8pS5Or2raXb10MMp5wGmXmiBJ/BqqR0jpRP4gSIb4RCshpbgBUIt2zjd69VwVmE4cSDvJVmfHvaGpKQh3Y2U8LMpPJKgJryFitD13ISGhgVuxfVeTl2LYSQL+ioKDwQ8WFDSW0lYqyFpX856CqrfyFuHGFwbZT3ZZiRTSES2HQKxSyfXAZw4S6014PV635+KTZMZofybITK0sUQyHqPx3YGBhRR/WYgFs9Y3mX59vgfXKx3hrLJdsGUqtnr8qJpbbzt+6rDUqBGHY6eqK2XcQt1wiAi8efOIA8ZhX36zge6t+RPbiQtnEJ3Ft9UsiQjNJgyH52kZGtpJIL3DF2FcPyP8YAxzFA/nbqKoGWmRpiLFBqqQS2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(4326008)(86362001)(38070700005)(76116006)(7696005)(6506007)(66446008)(66476007)(66946007)(64756008)(66556008)(26005)(186003)(9686003)(55016003)(8936002)(8676002)(52536014)(5660300002)(2906002)(83380400001)(122000001)(38100700002)(316002)(508600001)(33656002)(71200400001)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H9kYPUxzDUp6nC1HvwsxaXYHJ3asIGD4X3yn+kt1pf4mqZ+/HJ2V7dwUp30V?=
 =?us-ascii?Q?CVRVX2EZgw2MI/miKj53MevWEdYaLPmXy12Fs7THQZ+bMN9S0TlCSW4Bg0jC?=
 =?us-ascii?Q?32zrFUKP9RfwrxL+dDftCWQtFwtE0YHK8odznAK3tlxAfQHxDGGqVMh7Qufa?=
 =?us-ascii?Q?Kibj0kZVeKAit05Rk6DXcuuhefUazvNWKXATXmqnbjHm4RGl5emOVVpirUAC?=
 =?us-ascii?Q?iSeAaeX13qTaSkTOmNZGhp2dWP2riuFLEvWCARyFFqW4ppwu9F8jIM57IcaA?=
 =?us-ascii?Q?nkn0Lk3jb3OkoxVwWIGHNmiVu7Z2bRKk1fPENAMovD19W0ZrqF6+jqGO1Yis?=
 =?us-ascii?Q?vpuuxTeEkg48gwHq9uCwqAayWBSQd3hFnFlC+CmjML/pGRR3Pnsy5tSsIg3l?=
 =?us-ascii?Q?eITXgL5L5SiIkVFpnitRw0zplcNS8yo9x74j6Q2KyZIQKCAJIrnFN26XoZDZ?=
 =?us-ascii?Q?y/B8E8Tmy+5eMJWmqfu73JTxpiQNZ6DB33s2eiqpY3CZiWd5Hk5MsUf7YULq?=
 =?us-ascii?Q?bWpMUmdfbH8zRP1Gud8fA8yXvcSajd69hYfCy+fzzWJJm5G67E1eVDjKVU2a?=
 =?us-ascii?Q?CFx6sECidhoJqCrVN3UK1clslW51P0zzzCuA88CVF7+hZ9toJE4MGBfV7hux?=
 =?us-ascii?Q?XwJWFiK/LHsc3ZViK8+C+DW5WuSuyQM4trtGCm7lqLHsqAwh6Hf0zoer6vLr?=
 =?us-ascii?Q?5WtchG5tNsd3YOsLNnWHZgiuLRBQs60kVKgcjY/WTgMtm1CKDV3WYMly7ztP?=
 =?us-ascii?Q?kFFmOhykkbBRcakrvWBbVVot/dN3JdPYURXZoxIJoaTCOQOg9AaVEsB8KfNP?=
 =?us-ascii?Q?VqSjzq+mdOiTSQM6p0L1Hp79+dGgxB1QHQmLY4dChpfaUwuEHSml3wFxcCeT?=
 =?us-ascii?Q?axTeOo0izmqmScKo4D9gvbXU+EUwcG3psENm+vvv4ejDw26UiW+iqApBjNud?=
 =?us-ascii?Q?furtlbNRtNEiXlwoQWCioYPHJr5VlmAPO9o8tai2Bjx96l5n0B13iS4pUU3M?=
 =?us-ascii?Q?o7skGK14Yw9r9FN3WNTBiypMNGYVurWlAlgWUUVFby4CwEPJObhCC7BQUKVg?=
 =?us-ascii?Q?zCCFPETtuFgUES5vgCrNQ6d5fC71Vc7FG0pA5W6YHKeXpP7Cw7UGl69JatUP?=
 =?us-ascii?Q?m1jwdrHB6nb3IORm+hsW9yYZcrJLuQwsctjABJOLZxmn7VoyWzNWS9kbDtEl?=
 =?us-ascii?Q?a8uom3+1igj0xAS3rcf8oMJEfBIm74WwGv5Vi3ULNLf5zNNeqZ9nh+cZNbEF?=
 =?us-ascii?Q?pN/iMNuBOmQ5BHmBnklkm75l3f1g5jPiLS5X55ITVpdyqPKis8Ghb6BtVp8c?=
 =?us-ascii?Q?AQZQ74+9yDCSdx17G0MMa0jA66Hh8Ua49I4YdIgBVFpApJKDtU/dx7mr8oPo?=
 =?us-ascii?Q?lY3aSFzXpcMVyJHkoblU0kONBg+klxWvYPHER7CAFCuw/ZQUmJJG004aY4U9?=
 =?us-ascii?Q?OEctepf2zeVBMjALF/VMH2d35U1l7iXhMnOckhgN2ILfrQM1jvrV34YlEwQk?=
 =?us-ascii?Q?0VrCt8RHZoEUNMOL0EOo8qaut/j41pG3+ls5k+wD02vA39wlSYWLlXT4RxnM?=
 =?us-ascii?Q?p8ZSv/j3KzHN2Q2oWhbKLwSd2elvNm42Y+zUkQQV9TMCxSorMKxoNl9BTbud?=
 =?us-ascii?Q?MTzNrAGuiVgjm8OE52PX8+NeuIMfLFzh/KJZvEvWJaHyO6+Ntawu69zhTW4h?=
 =?us-ascii?Q?fsPdOw22NtLH1nals8/j1uMXdph8WsAdvaLYVDqxlFsgmxi4PZ4CxPNTkA1p?=
 =?us-ascii?Q?uWd/Q7b/9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f8452c-825b-4249-0773-08da4a807f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 01:28:18.0941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /o7c9ZwR/cTfVhb4D+TiBfqgMaq3RT2rMXUNn8dXWYB1i4ldrpfZPXQjwPNs0L4WAuBH+youSFblkTNrDuaH0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Qiao,
 Ken" <Ken.Qiao@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+					return true;
+					break;

Possibly a coding style problem, 'break' after 'return' looks redundant.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Aurabind=
o Pillai
Sent: Thursday, June 9, 2022 10:27 PM
To: Olsak, Marek <Marek.Olsak@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siq=
ueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Qiao, Ken <Ken.Qiao@amd.com>;=
 Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Deucher, Alexander <Alexande=
r.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
Subject: [PATCH] drm/amd/display: ignore modifiers when checking for format=
 support

[Why&How]
There are cases where swizzle modes are set but modifiers arent. For such a=
 userspace, we need not check modifiers while checking compatibilty in the =
drm hook for checking plane format.

Ignore checking modifiers but check the DCN generation for the supported sw=
izzle mode.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++++--
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2023baf41b7e..1322df491736 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4938,6 +4938,7 @@ static bool dm_plane_format_mod_supported(struct drm_=
plane *plane,  {
 	struct amdgpu_device *adev =3D drm_to_adev(plane->dev);
 	const struct drm_format_info *info =3D drm_format_info(format);
+	struct hw_asic_id asic_id =3D adev->dm.dc->ctx->asic_id;
 	int i;
=20
 	enum dm_micro_swizzle microtile =3D modifier_gfx9_swizzle_mode(modifier) =
& 3; @@ -4955,13 +4956,53 @@ static bool dm_plane_format_mod_supported(stru=
ct drm_plane *plane,
 		return true;
 	}
=20
-	/* Check that the modifier is on the list of the plane's supported modifi=
ers. */
-	for (i =3D 0; i < plane->modifier_count; i++) {
-		if (modifier =3D=3D plane->modifiers[i])
+	/* check if swizzle mode is supported by this version of DCN */
+	switch (asic_id.chip_family) {
+		case FAMILY_SI:
+		case FAMILY_CI:
+		case FAMILY_KV:
+		case FAMILY_CZ:
+		case FAMILY_VI:
+			/* AI and earlier asics does not have modifier support */
+			return false;
+			break;
+		case FAMILY_AI:
+		case FAMILY_RV:
+		case FAMILY_NV:
+		case FAMILY_VGH:
+		case FAMILY_YELLOW_CARP:
+		case AMDGPU_FAMILY_GC_10_3_6:
+		case AMDGPU_FAMILY_GC_10_3_7:
+			switch (AMD_FMT_MOD_GET(TILE, modifier)) {
+				case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_D:
+					return true;
+					break;
+				default:
+					return false;
+					break;
+			}
+			break;
+		case AMDGPU_FAMILY_GC_11_0_0:
+			switch (AMD_FMT_MOD_GET(TILE, modifier)) {
+				case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_D:
+					return true;
+					break;
+				default:
+					return false;
+					break;
+			}
+			break;
+		default:
+			ASSERT(0); /* Unknown asic */
 			break;
 	}
-	if (i =3D=3D plane->modifier_count)
-		return false;
=20
 	/*
 	 * For D swizzle the canonical modifier depends on the bpp, so check
--
2.36.1

