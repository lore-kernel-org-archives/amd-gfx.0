Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C701FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B9360EE2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94B9360EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C0B6E442;
	Mon, 11 Oct 2021 08:33:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 853C16E442
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 08:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJw+etabm5rzGHFZLT2pMI8kL0LKpcRqLpom9eLwPuTEX5ReBiOHhH9unddYUrtG5hb80AFPzR9873FgAA7z1EitjcvOZNN9inESk6KOMD5NzeJNcfPZ+WHovw4M45wscEpQvoQB3zSLP0ni6nUSdFzfovhhWaPDsZpSYqnF0D/I8hTFg7zH2qLBBlP0j7H9gAgemH90qARielD5Ifvs6RgQNd+gx3EMJkRJZHR7RhYqSBltHkNgbexf47bSs1w26NG/ejp5bznSMuTaQpkzMm6DL1iwBDESHFCYipmCRgosSoL7XnUdvP+ioizv92bhvrLFfmEZ5L4CFSKe07FtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV/jrogz/b/Fdmj+blOSgd51YOi5IhrhHdfZ3tvXrNg=;
 b=nqNFlOu28I9PmsICybbssg8nf8RlPGQAcfco0X0kdrgunKEWARW2I6KGo6pvca4aTMmm8dQcVITMr3gTwphcysljFfa/tiH3psLXqAc07DLJAw8qPJja/QT3S2972B2nWsQLMztgPiQzIBLnAEy/lRbeZKmSnLKfcgKDZr8BtsJtxrWMSlVd1UQXuP11iFOwHZMd/Ad6DYRv3+DzVUSw8mviGret3gUliIp7ATkexMNU76MQljgi7fHvoJvC+jYHLp1lkl86RRhUrA2ZhJb8q7Oq3ukC7sqg1dkNmY4HK+6VTq9TSS0x58M1cSSH7LxwcLrDBSNOHBBCQNezmLH65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV/jrogz/b/Fdmj+blOSgd51YOi5IhrhHdfZ3tvXrNg=;
 b=uzyHDrku6sJwaxy56o/49ITHkSFavvg022HXOS0fsGoBOzv6KALE688c8uNgpJLpiT1esBL6jqMUliyz0FyTqHsd+w8e7m2cHD+4+nWKdQkZbA7KtR7A0zb3SjUK1dIif7iZxEY19vXyyx04zF8NVR/hTp20bztSTc8zZWOQkTQ=
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR1201MB0183.namprd12.prod.outlook.com
 (2603:10b6:910:20::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Mon, 11 Oct
 2021 08:33:45 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:33:45 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yu, Lang"
 <Lang.Yu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: query default sclk from smu for cyan_skillfish
Thread-Topic: [PATCH] drm/amdgpu: query default sclk from smu for
 cyan_skillfish
Thread-Index: AQHXvnp+7u+W31dGeUa3O9SnYED/d6vNeGLA
Date: Mon, 11 Oct 2021 08:33:45 +0000
Message-ID: <CY4PR1201MB0246E1DF93EF5BD22085C6D6ECB59@CY4PR1201MB0246.namprd12.prod.outlook.com>
References: <20211011083147.577024-1-lang.yu@amd.com>
In-Reply-To: <20211011083147.577024-1-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-11T08:33:43Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=77c3b63a-9061-4bb8-b2c4-a12510ad7440;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cc08e16-7652-4e96-8e68-08d98c91d734
x-ms-traffictypediagnostic: CY4PR1201MB0183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0183B8193C5DFC13B7CC176FECB59@CY4PR1201MB0183.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C54Pa8g63m0Bh32fr0IOif9mAC4svjyNWT3bK3S2LqUrfACzAaoeNyTt6B0e4hSvU/f4IO40rJT6N6DZB6idnrFnLTKmOJivH1Yw2Z/97mpz6chi5a1RfJ6vNKenjuGnxnEVIZCTzmUFphev+3/6PgJH83hSP7m80wc6yhDEV25BGw6papPmC8BdmTbbu3gmNBLXs62qGu1qJU1waBACxJkWktVhhhphEDAIA3F9xWLR4i1GJK65JeuzQfpZnQDMS+bIqNTWgpgZBVaTlAtPgohyRdEb9cli3SrDVNMRCWkZGh1wvV9GrMtgBYuywM0ldpIWNZVuQeqamCE0R6pM+hYx01me4InOOzzR1/B/n6G0jz8BU3nH+Z1iaUjiUN2OFIk4BUoI2fDL4wnUIAFcasy9h7VipeBGrZxGEAWMHiOihNNLmIIGLjAi0wDLVriz6hEjeOj5QFRRrFiiMokI8fuKCviCvp67NeFObVACNLQKviC/sWofuDEV9NHUbB63RI1dA3K/xDg4r+w2XSzkdhE8RHPJ7SncVsE1hXfeGLuo92DHCVniYzhMGe8v5Mcj0Oq/Ak1QshvkBg8/mzX0VPJ3DZjOYDqWDweqqvSSuHfKaP5YXcAmE1K9YHn6IgVGBcOJ+hhFKS9/Ott7hFBXHBdBCIfokcCLfXz/VXL8iQCDB7FqyiR/GO63q1dERp4LpwxXnMREjhc8l38Lu1zwOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0246.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(26005)(122000001)(38100700002)(52536014)(33656002)(186003)(5660300002)(508600001)(55016002)(53546011)(6506007)(9686003)(38070700005)(76116006)(2906002)(316002)(66946007)(83380400001)(54906003)(110136005)(64756008)(71200400001)(86362001)(66556008)(66476007)(7696005)(8676002)(66446008)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gShqxBvKteSw6O6Z5HuxoLeFfpPrnFF8ATbORQyVj9badngOV2+JxRpYjt2Z?=
 =?us-ascii?Q?c6PCZp6Z0FjjvX0h/3pUym+R0i9WxSi2WRvdJOpVIw42NvWZ3nbsRtVIHgHi?=
 =?us-ascii?Q?6GVf8maPdxgw8l5MwMmVCOCnTsx3HaV7M5ukXnNBZeLzT0zOjn5r1wJ9Y5pn?=
 =?us-ascii?Q?xABUW/ifJnDb7SSgZn318rrDCe91b4zztfD+5WSAZFOCcT7J+oX2eYO/3F2R?=
 =?us-ascii?Q?glddFcbja78LkuIgxWjrsxio4Opg767mjz5yx7eA6xAj4pGxvs6D3bgWHmFG?=
 =?us-ascii?Q?zYBX7vS/pjcktsb1V5RsV6XokaW2QJHj73nTYx3+GN8MnyuBdP95tUTFWQYr?=
 =?us-ascii?Q?RXn8NDvOvnpImWTHbBJHe1vFqfBWnpKRMwyD08T+hkqlKYlr9iFTzeKbvgyI?=
 =?us-ascii?Q?TZc849lWic5lfESQ98I+CNmC7z6hLqkuo5vH6hWdoMqWQ7X0/mhGNLQVhv0P?=
 =?us-ascii?Q?CB0+io5gtg5lTYlVOLKvfwemZTe3EYpqMf1ttq2UNOhedJqcU9pNF6bUyM2e?=
 =?us-ascii?Q?LcBB5UEa195yggyMNls/spcbprns93BNKGlu3k9wfZxSF8PnTwofI8qIuh+8?=
 =?us-ascii?Q?JU1e62fdOWfOHyMVqvYJZcRih46/E/Kg39Cl/gjkOredjHY2Rsk8fRLpH9Ma?=
 =?us-ascii?Q?LINtxKkzHlu04CCeDfaXXkPq2ITPYcEbOGLqtsWTj3UAVWqwUfZGZ8HWdwWo?=
 =?us-ascii?Q?XtCleKgzr8qPEv2IZcCb7vJtXcy7hwTmxZ0rVoCOk7+q+zhhff/VjQDdrDAg?=
 =?us-ascii?Q?EJiXwcV7M+btsMHvo4BFDjnFUsNC/JZVu2TE0vUFKVdOIHlyOVgXPW79LS6g?=
 =?us-ascii?Q?CSAIDZHpz3x9Hui8CzdDFXLEW0JvCs01fh1A+R3/k6eG7/zLZ7zrfTMyS417?=
 =?us-ascii?Q?dcIx2cXwh3f5IAAlshEjzOG73sWgDr32bNaubUGZ4mbul0aa5lyLSCrPMxCu?=
 =?us-ascii?Q?OOvH5IejfhtCjzd1jZIsUE5Ah6NVMsEhBFhCXgXNYryRiLsBFsbwfq2XAiIC?=
 =?us-ascii?Q?mCrDJ8oDkmxplfywtRQQd3/PbWAOlAFODGJHvFpF4GAb7KoMAR5kjfBSnke7?=
 =?us-ascii?Q?QU9sDc8dWLRn9OJbf0iL57WWkz9DE9CLH38fKVeG5sinr5ZZXppqmDsQNVNz?=
 =?us-ascii?Q?7Ve9rj9s55MGGyFXWIVhoI4cKpsCbJsxBU5IztyDxkyYlO7ZK7Sts8rMXV+u?=
 =?us-ascii?Q?OAHnIzFl6Y/2qcUjeTCnHt/of7IIKTb9hwRjenIHcpnDHMENngem/o7fBqCP?=
 =?us-ascii?Q?l6bv57bkPIO5alZ6xABQJNLG+eO/SfxNEHbtYSto1vutWfT9X8vcKu7JCNL5?=
 =?us-ascii?Q?mVjez2M1erZY6ZdmnoAYAZ8b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc08e16-7652-4e96-8e68-08d98c91d734
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 08:33:45.7268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOHV8ZKAajHNK5aUjngeU8aLqJ5+uFR2XrNyYrbE3GGiEBZ1t1UV6N+OT3+IHltXTeRf4t3LH0G3oPURhkFEUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0183
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Acked-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lang Yu
Sent: Monday, October 11, 2021 4:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: query default sclk from smu for cyan_skillfish

Query default sclk instead of hard code.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c  | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 3d4c65bc29dc..d98fd06a2574 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -47,7 +47,6 @@
 /* unit: MHz */
 #define CYAN_SKILLFISH_SCLK_MIN			1000
 #define CYAN_SKILLFISH_SCLK_MAX			2000
-#define CYAN_SKILLFISH_SCLK_DEFAULT			1800
=20
 /* unit: mV */
 #define CYAN_SKILLFISH_VDDC_MIN			700
@@ -59,6 +58,8 @@ static struct gfx_user_settings {
 	uint32_t vddc;
 } cyan_skillfish_user_settings;
=20
+static uint32_t cyan_skillfish_sclk_default;
+
 #define FEATURE_MASK(feature) (1ULL << feature)  #define SMC_DPM_FEATURE (=
 \
 	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	|	\
@@ -365,13 +366,18 @@ static bool cyan_skillfish_is_dpm_running(struct smu_=
context *smu)
 		return false;
=20
 	ret =3D smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
-
 	if (ret)
 		return false;
=20
 	feature_enabled =3D (uint64_t)feature_mask[0] |
 				((uint64_t)feature_mask[1] << 32);
=20
+	/*
+	 * cyan_skillfish specific, query default sclk inseted of hard code.
+	 */
+	cyan_skillfish_get_smu_metrics_data(smu, METRICS_CURR_GFXCLK,
+		&cyan_skillfish_sclk_default);
+
 	return !!(feature_enabled & SMC_DPM_FEATURE);  }
=20
@@ -468,7 +474,7 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_=
context *smu,
 			return -EINVAL;
 		}
=20
-		cyan_skillfish_user_settings.sclk =3D CYAN_SKILLFISH_SCLK_DEFAULT;
+		cyan_skillfish_user_settings.sclk =3D cyan_skillfish_sclk_default;
 		cyan_skillfish_user_settings.vddc =3D CYAN_SKILLFISH_VDDC_MAGIC;
=20
 		break;
--
2.25.1
