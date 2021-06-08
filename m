Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD6DC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFDB61285
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFDB61285
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF566EC22;
	Tue,  8 Jun 2021 15:38:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1FFE6EC22
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 15:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMV8XIX+jXFCL4TQk/nHrB66AkDcypVBdR9oU1HnJn1AiW3t47unYl2iwRTv44Fq2sCiwy+rDISESyH6VTra1ArfKMGy2xdSx1CS+ngTKEynHg49sOSAUssxjv9+qUVZK9ewRrt8HeCbrajHwEUpZ7ASj5xqwVTXSBzbetEMw+GqCDWmzx9dhiBHLZhRoB9ibNJeBoditzQfWgWoxc95ytxvrG5GJvl1u2rpFoSN7rGc2Yg1AxQ7oDXIrYm2rj6FRSKY4In06Ku6BHnzIFTcWodHEPWdeIZY7W0abI2D7pGiTJer8zCMgOxYiqbSUavMliUKjMK/Dh25g8YpfvIOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH1V6yu9cB9vPzV2ioOaUIxxE8WquVy1/nUoT2YjsuU=;
 b=F3UL550s2t7FO7itG7v1k0tzHtkxgIT8J3vx1LjqTuHqMtliyAs3k+KssXJ4TEGBjL96b1qsIKqbKQ9RjoWhnRDUg6pDIe7ttOhW2oqWSbF/tJzBLLEJH0YY4Iv5MmgFmXiTIvUbQlcGa55LUaHegEhpl5NzMyVROfFl8kOvFaiMd+xACKQPfxWNV/djbJKHWEHGTb84bEvQuVv91wVnxkSFo3+Ab88vKZs1Zlt/zxYh1XV9twMyPC3k5/X2ntPxIYCdwKI7fap0ibV1ET4vS9alFWTYDp3XkeSFW21EFFaxcAIWXkguC00XYcZQssXs3fmAPEXHt3yai5kdY1B4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH1V6yu9cB9vPzV2ioOaUIxxE8WquVy1/nUoT2YjsuU=;
 b=ZTjbdGzzdQgphlICYGwknl/HFd7XzfzRtdkS22uIb7EQsc3gGmZFI+MvNRAValTcoPBrMsP+vjMso6vHEAcv+4ysaUMzww4cmaKbbqsuvKxfpn6Cw+4uPkh8kIG/bHCKU1x82/ntET43mVQbNNGJVqaNcti0B0l+6suC+q8pkUQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4724.namprd12.prod.outlook.com (2603:10b6:208:87::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Tue, 8 Jun
 2021 15:38:02 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 15:38:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix build break
Thread-Topic: [PATCH] drm/amd/display: Fix build break
Thread-Index: AQHXXHwlcpDaRy6jlEqXcRhlUhvJAKsKP3X2
Date: Tue, 8 Jun 2021 15:38:02 +0000
Message-ID: <MN2PR12MB4488E4B16831EE941361DB7BF7379@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210608153645.796143-1-Anson.Jacob@amd.com>
In-Reply-To: <20210608153645.796143-1-Anson.Jacob@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-08T15:38:01.776Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a58db4df-9dec-4e76-5d25-08d92a9366fa
x-ms-traffictypediagnostic: BL0PR12MB4724:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4724F3CD61E83E34C1EF5156F7379@BL0PR12MB4724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27YP4Jcn6zqWIsHJBMHLiRpHcAe05XFqD6nX+tQSa4FIOkCAR35IiIbGA+y+zRIzI55wb7og0hkHjietqGGJyE77y8FEuHsIu+NoMjvx9XxwQpWuSZSAqV2WNEvn55aVUjgveRWmU5Nhlwti5UWhH+/q/MSmKoBBlU1W2ezDMdqqC2jK8HrnPYoBOAB1DlNX9bZaq3TKAxCtbNlGZlImXVYh5skgAUDVq/UtPV/6AaaOPm7rXMMSN5LlKbBYWjrb57ls+PDm7NIZbnamnUGXk26JiXInLeEtyPPkgSP1KiTnifmaR0Bo+7N9CRdrhef/HgkKxzcbxPSGspb3K8KcG6+qGIPdGVtW/7RCrM6db+LV0tLzJrHohPAEaSipS8Z9m0+7W/oC43JqieB56Jq2bwj3BJ6tFegWtfr5craxD7CBKJhJPZNySsUYOClMm70mfUPhB5xL7wsS6bu/A6Wa/S2zZjbii77nz2ZkQrvGQnCCQsKXPfT6tNjyD0+hC0H9K9jAp+RehXsptdb8R7cg+5MZJ5P1L1qK9ICbUfTBpAaKGtecrUXZJhPdNqj0QaYhd3zHIOsmvY+7CZTDtiGhYRXG4Xup+b+8PkZ75gLJCMR75nQN6kNhkwwnDi2iIGWUoQCM0PJ/Pw5kToxDM2CK3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(376002)(396003)(366004)(346002)(316002)(110136005)(54906003)(45080400002)(26005)(9686003)(33656002)(55016002)(6506007)(4326008)(2906002)(186003)(86362001)(66946007)(52536014)(66476007)(64756008)(122000001)(76116006)(66556008)(38100700002)(8676002)(966005)(7696005)(83380400001)(66446008)(71200400001)(19627405001)(8936002)(53546011)(5660300002)(166002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iIX3qwMY5a/Zbx3c5QvGiviA4xb5iIQJyDumGUfHhsBT6ZweU3/dP9kayrap?=
 =?us-ascii?Q?F8edhOX+nBHE6DU1l0RBV7VDm79192SK2AJ9P2xLixGcoOMZ02S2xXwInwSn?=
 =?us-ascii?Q?8lvIP0GgWU2wlecKW9Qi4Ml1lFPnTNo6vzYhEhQsRjkrah2NWEEdHHuYtda6?=
 =?us-ascii?Q?GE/2zfgg9x3Af9EN/j3MKwgUPO61pMslTG1B70EeAX+5R9hocKocNwjL3ggp?=
 =?us-ascii?Q?pectQQDTW/vETfmYpHPcXrdirkwqBLbh2+Ffihyc2e43nm/Xx2mduCfjyHPy?=
 =?us-ascii?Q?KUGoy8hWilDYBIAjAEulgJmUVDuGRTjWxtZGRZbXACLbgQnLaUc4jV5DPG45?=
 =?us-ascii?Q?ADlqTsdRiC0BDw37n7hSYHmnYml26mcxfgacJT+GRJS8TsQUDmH1oq2cHy3y?=
 =?us-ascii?Q?UKjkwfPDjEO0LIoZfIQWPGX5j6h9meLN/e5Sx/VtWhsj/SS5GPseijAtEsQz?=
 =?us-ascii?Q?DTjDERNsDQHPHcao6vcJu47FiXeFlMlSCPGQLvyw3k6+ZEWpHs+ZaXCyHyqn?=
 =?us-ascii?Q?zxvz/dZg36zCiwXyypgSUBgxAl7Ltue7TBpM3z3uwxYocR2hcmfKOl7Xt3SP?=
 =?us-ascii?Q?IQa0dANLQgImxdLvir75QqFM30wLuHlSyrnlSqNyilGr6wevbzESCIE+5wMF?=
 =?us-ascii?Q?sd1borI1NgLFbdlYAFNOmeLWrphjE5vLmmAsaCsI17PCtJ88XVxUnzu1O2tf?=
 =?us-ascii?Q?09P+dz/IMmPqQDXyyBVFp+bZIj2W2w8ghMdXFgpRYz6CB/pwpk/coA44i8a8?=
 =?us-ascii?Q?poNGggBMVQvbImgAxJo/A3aZQeHCx9qLu8RFS2iGL4Cw3Q4lTJwln0zsZcFF?=
 =?us-ascii?Q?Co+z1/0mEGI2cbKuRBUIqAaskoAZNyKHMEdZ6+1FuUXNysmnsjkdU2nG5oxN?=
 =?us-ascii?Q?DKVJoS+f6ihLHu5j+9fSElqv+mtbaKVa0WVCpc2CMH24zogl/ZPBZmde/BXa?=
 =?us-ascii?Q?8dhTFj9MyGqF4sKRlGxVSvS1J/AougbY51f2fiD7eEbDHpGXR9aP+GyHIW3e?=
 =?us-ascii?Q?3/Atuh9Z8QGd9uL/JE2FJzE+p30+Pa/Pm3GCFNGB8fUNxCV8EvUyp5+WDw4Y?=
 =?us-ascii?Q?0EnY2sQcQ0dELKh1olqj9ZFII6se+l1sH+1EJLM3ea0Nn0AUTWF0MM4WICLP?=
 =?us-ascii?Q?/zSLEQbPf4a08YxYm/hNX1mr4XZsTtJdvT3wBB2Y8yQzYiVkmhAHyIg+EqKB?=
 =?us-ascii?Q?ZwdvYmAnGbgFZ7pgZP50pnucyQB6L3vxNkvXND+fCnechABIMAJjo/jVp4pJ?=
 =?us-ascii?Q?hLMKN0SAGY4jMHvKNNLtNQIag4YR8jzSLKd2jrgaO0OHLrdiHCKjOqMRbA6K?=
 =?us-ascii?Q?Vd7MZOvnFUve31VKdYobLUZu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58db4df-9dec-4e76-5d25-08d92a9366fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 15:38:02.2931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 910BrILuRzkjaQqkqjzT8v9ebDgvF7w7PAF0M9q0L6bEuH+poVsu/aXHk9csWrvAJDF57K9Yrk1ssmD9X3riGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4724
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: multipart/mixed; boundary="===============1087607957=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1087607957==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488E4B16831EE941361DB7BF7379MN2PR12MB4488namp_"

--_000_MN2PR12MB4488E4B16831EE941361DB7BF7379MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Anson Ja=
cob <Anson.Jacob@amd.com>
Sent: Tuesday, June 8, 2021 11:36 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@=
amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.=
Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu <=
Bindu.R@amd.com>
Subject: [PATCH] drm/amd/display: Fix build break

1. Remove duplicate OTG_PIXEL_RATE_CNTL from dccg_registers
2. Fixes: 18827ee0cc28 ("drm/amd/display: Refactor visual confirm")

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h | 1 -
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gp=
u/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 6bdab06667c9..62904d7ca100 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -202,7 +202,6 @@ struct dccg_registers {
 #if defined(CONFIG_DRM_AMD_DC_DCN3_1)
         uint32_t PHYDSYMCLK_CLOCK_CNTL;
         uint32_t PHYESYMCLK_CLOCK_CNTL;
-       uint32_t OTG_PIXEL_RATE_CNTL[MAX_PIPES];
         uint32_t DTBCLK_DTO_MODULO[MAX_PIPES];
         uint32_t DTBCLK_DTO_PHASE[MAX_PIPES];
         uint32_t DCCG_AUDIO_DTBCLK_DTO_MODULO;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gp=
u/drm/amd/display/dc/dcn31/dcn31_init.c
index 69da1493b277..e3048f8827d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -100,6 +100,7 @@ static const struct hw_sequencer_funcs dcn31_funcs =3D =
{
         .z10_restore =3D dcn31_z10_restore,
         .is_abm_supported =3D dcn31_is_abm_supported,
         .set_disp_pattern_generator =3D dcn30_set_disp_pattern_generator,
+       .update_visual_confirm_color =3D dcn20_update_visual_confirm_color,
 };

 static const struct hwseq_private_funcs dcn31_private_funcs =3D {
@@ -129,8 +130,6 @@ static const struct hwseq_private_funcs dcn31_private_f=
uncs =3D {
         .program_all_writeback_pipes_in_tree =3D dcn30_program_all_writeba=
ck_pipes_in_tree,
         .update_odm =3D dcn20_update_odm,
         .dsc_pg_control =3D dcn31_dsc_pg_control,
-       .get_surface_visual_confirm_color =3D dcn10_get_surface_visual_conf=
irm_color,
-       .get_hdr_visual_confirm_color =3D dcn10_get_hdr_visual_confirm_colo=
r,
         .set_hdr_multiplier =3D dcn10_set_hdr_multiplier,
         .verify_allow_pstate_change_high =3D dcn10_verify_allow_pstate_cha=
nge_high,
         .wait_for_blank_complete =3D dcn20_wait_for_blank_complete,
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C5272e2b7a9204f8c5fac08d92a934655%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637587634302129644%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DVI3%2B4jLpN%2Fk%2BCM0o%2BnmGBEEeth%2FYhB9v%2BHuxu8npBRc%3D&amp;reserved=
=3D0

--_000_MN2PR12MB4488E4B16831EE941361DB7BF7379MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Anson Jacob &lt;Anson.Jacob@a=
md.com&gt;<br>
<b>Sent:</b> Tuesday, June 8, 2021 11:36 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Brol, Eryk &lt;Eryk.Brol@amd.com&gt;; Li, Sun peng (Leo) &lt;Sun=
peng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Zhuo, =
Qingqing &lt;Qingqing.Zhuo@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Sique=
ira@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Jacob, Anson &lt;Anson=
.Jacob@amd.com&gt;;
 Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Lakha, Bhawanpreet &lt=
;Bhawanpreet.Lakha@amd.com&gt;; R, Bindu &lt;Bindu.R@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix build break</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">1. Remove duplicate OTG_PIXEL_RATE_CNTL from dccg_=
registers<br>
2. Fixes: 18827ee0cc28 (&quot;drm/amd/display: Refactor visual confirm&quot=
;)<br>
<br>
Signed-off-by: Anson Jacob &lt;Anson.Jacob@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h | 1 -<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c | 3 +--<br>
&nbsp;2 files changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gp=
u/drm/amd/display/dc/dcn20/dcn20_dccg.h<br>
index 6bdab06667c9..62904d7ca100 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h<br>
@@ -202,7 +202,6 @@ struct dccg_registers {<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN3_1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t PHYDSYMCLK_CLOCK_=
CNTL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t PHYESYMCLK_CLOCK_=
CNTL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t OTG_PIXEL_RATE_CNTL[MAX_PIPE=
S];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t DTBCLK_DTO_MODULO=
[MAX_PIPES];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t DTBCLK_DTO_PHASE[=
MAX_PIPES];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t DCCG_AUDIO_DTBCLK=
_DTO_MODULO;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gp=
u/drm/amd/display/dc/dcn31/dcn31_init.c<br>
index 69da1493b277..e3048f8827d2 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c<br>
@@ -100,6 +100,7 @@ static const struct hw_sequencer_funcs dcn31_funcs =3D =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .z10_restore =3D dcn31_z10=
_restore,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_abm_supported =3D dcn3=
1_is_abm_supported,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_disp_pattern_generato=
r =3D dcn30_set_disp_pattern_generator,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_visual_confirm_color =3D dcn2=
0_update_visual_confirm_color,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct hwseq_private_funcs dcn31_private_funcs =3D {<br>
@@ -129,8 +130,6 @@ static const struct hwseq_private_funcs dcn31_private_f=
uncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_all_writeback_pip=
es_in_tree =3D dcn30_program_all_writeback_pipes_in_tree,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_odm =3D dcn20_upda=
te_odm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dsc_pg_control =3D dcn31_=
dsc_pg_control,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_surface_visual_confirm_color =3D=
 dcn10_get_surface_visual_confirm_color,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hdr_visual_confirm_color =3D dcn=
10_get_hdr_visual_confirm_color,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_hdr_multiplier =3D dc=
n10_set_hdr_multiplier,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .verify_allow_pstate_chang=
e_high =3D dcn10_verify_allow_pstate_change_high,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_blank_complete =
=3D dcn20_wait_for_blank_complete,<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C5272e2b7a9204f8c5fac08d92a934655%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637587634302129644%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DVI3%2B4jLpN%2Fk%2BCM0o%2BnmGBEEeth%2FYhB9v%2BHuxu8np=
BRc%3D&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com=
/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&=
amp;amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C5272e2b7a9204f8c5fac=
08d92a934655%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63758763430212964=
4%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha=
WwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DVI3%2B4jLpN%2Fk%2BCM0o%2BnmGBEEeth=
%2FYhB9v%2BHuxu8npBRc%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488E4B16831EE941361DB7BF7379MN2PR12MB4488namp_--

--===============1087607957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1087607957==--
