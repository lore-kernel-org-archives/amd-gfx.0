Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B58C7EE2F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 14:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC4D10E2B6;
	Mon, 12 Jun 2023 14:46:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A6C10E2A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 14:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMaqt3NFpTf3m8qVJQC+pXPU/1QVGmRspl8hqrm18Df4+Jyt+K31DfOdQ/u2T8TMVRnNAIxvTG0n8Sr41a3Vupir6KKFZjSaTwV65mKpre4ytKqnmVb90ZN7cjLYLEyIGhzWiJh+QbBvKgEypykb304OLfcHomq8ckV4oxnhdYyrQd2NIPWErNSFvl2+XMElxP2338smurYhvFRSGWAygpb3Xj68w66HcEWI92PWSY7jWN8/Yi3RGbUl4kIJaMn8nS3WSh5XdC9f1CLnDtNaUobj6Q7oCg37CqB3MZHYIWhJfnm36M11xu72s+w4vp/JUv/tLUTUlYxQ+9CedUKWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnb3jwPqTdYHMhfjnU2B1687Cli4g2ld4GpqXRNr7RM=;
 b=T3tOiIQGuGjWj6PoriCGLzwyiaQCBORGcRjGmC2hoJGUMGBI4LZwpgXZ/P4LV6aEM5qSIo/jsGnSysy3grCZyMoq6d8uX/xeX7egYO3SLVqVGxte3gqG7QSg1XqioKA35enIDux4D6xFVus9H673LvEL5HxD+Y//JKukub0G79J+CYYz2mnLbrLmHhL/v71e1+s/+tBP7jkufL0FGxemeFCHXpX5s6u+1kdoT0sGzOf5Vj9Bw/KI1bAhg6heMFpmxXMZSDraMGO6MhO4o+me2a2r3suSeA68tHzp75dUfXVVs2ZDe/m61gY9bX3voPTd2yal5ZkPRIx/wB7tjGhddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnb3jwPqTdYHMhfjnU2B1687Cli4g2ld4GpqXRNr7RM=;
 b=Pc+3es45buzYXfE4vkOBeFqeCJMhd51g92zF/fiU/nhs7uz9J2MGpG9vDrcSjpWh3JVEt93sh9zoedn4XcQ7InzX/aNGFHVPGuhqFzDVkHDCgPsypspUctaiA+Egow3mesi8wakuFc2VvqcmgGJyJP81tfkH1GljIrncYcrcXl8=
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.39; Mon, 12 Jun 2023 14:46:51 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::34e3:4867:66c:e52e]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::34e3:4867:66c:e52e%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 14:46:51 +0000
From: "Lee, Alvin" <Alvin.Lee2@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Wang, Chao-kai (Stylon)"
 <Stylon.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/display: Correct kdoc formats in
 dcn32_resource_helpers.c
Thread-Topic: [PATCH] drm/amd/display: Correct kdoc formats in
 dcn32_resource_helpers.c
Thread-Index: AQHZnTYz8VMhlkpjL020hpE2OG0ioK+HPu1g
Date: Mon, 12 Jun 2023 14:46:51 +0000
Message-ID: <DM8PR12MB540095F27B7CF4916FDB4D66D154A@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20230612135938.2301377-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230612135938.2301377-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=80b04477-b97d-48cf-8405-52e313e008a7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-12T14:46:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|PH7PR12MB7967:EE_
x-ms-office365-filtering-correlation-id: f1dc871c-88e6-4558-7862-08db6b53db67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dq+S66xjpxn6CwCZ/sv3d4F2EVy2lr+AP1BkL4gW4sAfocFPQzWvjKDU2TjQWx2EwqAqNYyUvWILsmADUncGagCUNeGnp0A4OD+iwntuHXBEk/hJ8cZTsvFMADCVEHrB8h8jnaf/qRY1u7e64x3e0aeSgP/5ZO4JP0x2zjw/yPYFbLOzz1yHe4lNCZ0MOH3RCCSxNznCLEiUB0ruRXp/hmnFK6+QWDrqMlo+dhvC3g5ohZ6cKHJBsghfjKKn6LXNjwePSnpLOKcSxLnItVi9MN25SdNazBzIWOSYr10HJ4VJSmGyFcSFTh1UbqvFxTbJLib/9uoe+FkAO6lPOekPX6mjvL2/UrOUw9ASZvWG+DAUoFgcO61Nw6oeTtA7S4Ew6CSmyXwEU4EQDddcIxRftcAuzu8fkfMmKId98bQbUWBnSHw7i3i68h/HFe8pTk9TBar/jCg2ordNsTRVYT2UkvB7sVPtCzs1qXewmT3ZzcttOw60oq1mXcst5Zrm/6H3XjkbqMkAwoS+XuhvgWsMdToE5v8nrzrm1VX10vrsPBUhD2F0bTbeu2DteOZPWVGsaBjSrArGpCf3CCViyV0YBg0jdjgSvXRZx0CcwD86Rxvn2ZnBYSgSRfT2xLdjjvZDnMziizpXmqfmDooQ+uELzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5400.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(64756008)(66946007)(66476007)(66446008)(76116006)(66556008)(478600001)(54906003)(110136005)(8676002)(5660300002)(52536014)(8936002)(71200400001)(4326008)(6636002)(7696005)(41300700001)(316002)(38100700002)(122000001)(921005)(9686003)(6506007)(26005)(186003)(53546011)(83380400001)(86362001)(38070700005)(2906002)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VJgyHcxgUMLEmy5GGxMDappOuPQDVom9lttZ1h6OnfG1fXGqiRAhn/KQ9Kk+?=
 =?us-ascii?Q?jUEQGX1RyDJBliMAInOiEX+IKq8SWcgfUcjwnu71r63f58GHoKTfh3e6KWnN?=
 =?us-ascii?Q?h4MhKSWR4FmAg16SG/RxspYeCeYFaXONxY1BKgOaqhdtSAQoBvUU3L2kmE19?=
 =?us-ascii?Q?IMjHa7DL5cHCKrrlthSJ8IpgQ9n7dD+JDVjuGbd8Zj3JRteeSep90x5pMYO6?=
 =?us-ascii?Q?M2g78tIVSUBew0b9lKWgAd2Ds9olxJRAQjqa6amzU2uicKv7mLfueD0tCkt6?=
 =?us-ascii?Q?ko7cuzy3DdhcaSQRgdFUXPuJzmJKG2wBx5wcEbDilFYKXiFgtdv8kFBKr5hF?=
 =?us-ascii?Q?YNuFfylngKlhytCyF7dTATDBRMWd8O8sgKjL0I0EQvEAImccmpU1AqsukQDI?=
 =?us-ascii?Q?tek50lHUWGGGyWQJk5wMw2ZXEhuvEr7JHM7lFJqoHTxb2VWDJwd2khVpz4ma?=
 =?us-ascii?Q?mr6vVeEYiu/r5ybd0M/ER/NqfykCRyOJYwSvfjZRDd35U0NLvqz2OlSp0798?=
 =?us-ascii?Q?xpoVVBC1D9PbsxdUg//UYkl4P7z2166rh8QS/sHDLObIrFHHYHbe0ig7cOck?=
 =?us-ascii?Q?RFaYPguRcdl9/AhiwWiintSAXEqjqZPf/pEdbdVGLWq2e6qvdLo8zidCZhj8?=
 =?us-ascii?Q?62M3jDuO/BK/z+Tr+Dq4FxY6MDpzlQBt8piXl/9mPVmJEtXR2U99+JWQ0n/T?=
 =?us-ascii?Q?nREeJliAAiHfYw/qoBUrUCZgWjSH7TQlhGMcG3E+lgJUsmYSMGEmB3C5ek2b?=
 =?us-ascii?Q?ABnJE78JXOLi9Uju3J4cym8n61KWQCYJX2tFsVxCNTB4lSCgo8Z4CITBleHQ?=
 =?us-ascii?Q?KrA38FyVCOanwoFUoFwZLFv1iczO5UuTS9tfs3JXbV3MQhNF9nEtL6vXYTIH?=
 =?us-ascii?Q?7QS4Sg2zU8xDWmJzbdYLVD69cm9zsglbtBXHKt6J7acBDJIzAO9cZ2cSdUei?=
 =?us-ascii?Q?+1S835L5Lo6U7W6lrMY5o+vzR9r5LLnTBcjVw25Y3HUD9XtMBPJK+HIjyNeI?=
 =?us-ascii?Q?OndjVOhOihOXZBaUdHVWGH0AULB3qFHueae+Wzms8AsXYawDP0X/dnUExt9h?=
 =?us-ascii?Q?kxyMfJUS5T3bAPyuz47wbOGTKG06eKjCBpxjdM1D35+C7UAYs6BU2uLI4Kqy?=
 =?us-ascii?Q?QPRd1dO3kPSLLQRWHeB+i3FT/vFR9eqmARaVf2eYxgyFwShIjTemL180PboS?=
 =?us-ascii?Q?zBVqhAXjJSY+Tjh76yGVuCEHxnWOZRmm8JzMT32JKGRRCx1BMcgsdHuhjor2?=
 =?us-ascii?Q?5WJWNqnm3jA3Y21YSnb942lfUYRFypxfCByZXu0kqFI4YV3iNiCoLC4y17K1?=
 =?us-ascii?Q?emsFXtcOqNinUVHHhzurdZh/oPq554sq4EmElzAcn4EHOmlOv45GKUDD9kiN?=
 =?us-ascii?Q?/ooe4zUtBDuf9XUWyAQ+WQd7+saTGKTV3irS+OcnY41bAjwZgTE7miRGu5bA?=
 =?us-ascii?Q?jxqye733ICv6ZT+WEGV1Ns0Q0g/jiRyfU0JkQJRZkA9yTwK+4VT0aq9Hyumw?=
 =?us-ascii?Q?VeGT8kptJYVWGVqrXgMfJ40PVaHpRVs2iTjTJtaI4uYX8+VsLqWcGayGOUhr?=
 =?us-ascii?Q?/AF6wldpu3woF4eVQPk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dc871c-88e6-4558-7862-08db6b53db67
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 14:46:51.0423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDbXWAd6jFKYyA+wBd8DVKr7oX+iPbts08C20k+eQAJgSn1TXNAodJhciAIWRcIL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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
Cc: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Looks good to me. Approved.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>

Thanks,

Alvin

-----Original Message-----
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Sent: Monday, June 12, 2023 10:00 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Siqueira, Rodrigo <Rodrig=
o.Siqueira@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Mahfooz, Ham=
za <Hamza.Mahfooz@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; =
Lee, Alvin <Alvin.Lee2@amd.com>
Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMU=
GAM@amd.com>
Subject: [PATCH] drm/amd/display: Correct kdoc formats in dcn32_resource_he=
lpers.c

Fixes the following gcc with W=3D1:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:285=
: warning: Function parameter or member 'dc' not described in 'dcn32_determ=
ine_det_override'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:285=
: warning: Function parameter or member 'context' not described in 'dcn32_d=
etermine_det_override'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:285=
: warning: Function parameter or member 'pipes' not described in 'dcn32_det=
ermine_det_override'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:624=
: warning: Cannot understand  * *******************************************=
**********************
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:676=
: warning: Cannot understand  * *******************************************=
**********************

Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Stylon Wang <stylon.wang@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/dcn32/dcn32_resource_helpers.c | 29 ++++++++-----------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c =
b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 4882c3684b82..a9c41ef0751f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -273,9 +273,9 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  *    among those pipes.
  * 4. Assign the DET override to the DML pipes.
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
- * @param [in]: pipes: Array of DML pipes
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
+ * @pipes: Array of DML pipes
  *
  * Return: void
  */
@@ -621,11 +621,10 @@ bool dcn32_check_native_scaling_for_res(struct pipe_c=
tx *pipe, unsigned int widt  }

 /**
- * ***********************************************************************=
*************************
- * dcn32_subvp_drr_admissable: Determine if SubVP + DRR config is admissib=
le
+ * dcn32_subvp_drr_admissable() - Determine if SubVP + DRR config is
+ admissible
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
  *
  * SubVP + DRR is admissible under the following conditions:
  * - Config must have 2 displays (i.e., 2 non-phantom master pipes) @@ -63=
3,9 +632,7 @@ bool dcn32_check_native_scaling_for_res(struct pipe_ctx *pipe=
, unsigned int widt
  * - Other display must have Freesync enabled
  * - The potential DRR display must not be PSR capable
  *
- * @return: True if admissible, false otherwise
- *
- * ***********************************************************************=
*************************
+ * Return: True if admissible, false otherwise
  */
 bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)  =
{ @@ -673,11 +670,11 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, stru=
ct dc_state *context)  }

 /**
- * ***********************************************************************=
*************************
- * dcn32_subvp_vblank_admissable: Determine if SubVP + Vblank config is ad=
missible
+ * dcn32_subvp_vblank_admissable() - Determine if SubVP + Vblank config
+ is admissible
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
+ * @vlevel: Voltage level calculated by DML
  *
  * SubVP + Vblank is admissible under the following conditions:
  * - Config must have 2 displays (i.e., 2 non-phantom master pipes) @@ -68=
6,9 +683,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_stat=
e *context)
  * - DML must have output DRAM clock change support as SubVP + Vblank
  * - The potential vblank display must not be PSR capable
  *
- * @return: True if admissible, false otherwise
- *
- * ***********************************************************************=
*************************
+ * Return: True if admissible, false otherwise
  */
 bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context=
, int vlevel)  {
--
2.25.1

