Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9F9EE57E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 09:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47CA10E88D;
	Fri,  8 Sep 2023 09:02:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6737D10E88D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 09:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKvKi7RmHPco2U4EpM2JzXjX5G6r+r4cr+wIeDdj3P60sGioJLPgc2UNQmoDWRRUZTQE5pZjyn5NNIRrhl0GoCd3nmh4z+HYognwZpKF6BL1TH+QrGajOY4Zgot87zrnta9nSL3Ws0xLxQhmod2uZgdAmdrY1fIEj6igINMsgYKt23FrnT2FJs1kY1nBsaCoZFf9Y79hiDTKu5hEjOqPMjRm9Z1Reos82Y0PnKGTGPJ6+s5uIZ1j0e5rJJ6qlETzjhDZyV99tzuPhXChT+an2zcI8AgO2A92QOrs/wak8YNKOmTcDNGi00hwY9Gsff+6qQycjz2SZ3sbE/i+oIfsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIbdxhDk39e5qWnzHErMSPtjq/rwxmD35bytFm12VzQ=;
 b=KWRpegMaB+O8Q1ddSuzfS6zvgETK//52A/k0cccyzLPC4UORaBO+8gB4h1J12h9iE1NjKpuC8ex/trTMW15085ZfFu8LWMQSK53qaL/y+7ynYNKYvfiK+jEh+Wz22heaB6TCZ067eBS67ESLasy3bb0UBHpJilhpe0gkoMEfZbAMZ4SlgiFpjyz9ndnYkBzOblgO/i6FYOLoEIlngXyThl4Mk4xFBLFZ3CrJiKmJnCtftdAkQR6IHUBvIH1GSDG3BnR5+qaE5+ZSVn+hqGB6EUMbjKEvmmPh9ZNtCBHCWFBtiQqOBJBljHPA0nwIExuExOouMCxXFUaQ+FG28RowRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIbdxhDk39e5qWnzHErMSPtjq/rwxmD35bytFm12VzQ=;
 b=LNf0PSyBgj9EmngO3mTLrhJBq7EJz1pAw5TT9iiC1y96y1YRYFdvB6k4+cPmKCsd8/mcNDNMOyuIuoZ5Aabgpu2NmG0uV4kSiO5YXlyDwxxAmws2DGrMBz3hkQsU33pVl31Hsw4GTxOSip2ufDn+y9lVLUY8EAcEgb3D98AUFzU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 09:02:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::422d:63c2:1a93:6a20]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::422d:63c2:1a93:6a20%6]) with mapi id 15.20.6745.030; Fri, 8 Sep 2023
 09:02:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amd/pm: enable smu_v13_0_6 mca debug mode when
 UMC RAS feature is enabled
Thread-Topic: [PATCH v2 2/2] drm/amd/pm: enable smu_v13_0_6 mca debug mode
 when UMC RAS feature is enabled
Thread-Index: AQHZ4i/3IedIaNtDREGR/TFmmwRqE7AQod6w
Date: Fri, 8 Sep 2023 09:02:18 +0000
Message-ID: <BN9PR12MB5257483E06B8BA7E828AF1B8FCEDA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230908083904.2509460-1-kevinyang.wang@amd.com>
 <20230908083904.2509460-2-kevinyang.wang@amd.com>
In-Reply-To: <20230908083904.2509460-2-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c34c3ab2-68b2-4646-a6c4-bcaafe578f2b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-08T09:01:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB7840:EE_
x-ms-office365-filtering-correlation-id: 95ad325f-0a02-43cf-1274-08dbb04a4e24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uXbBpRr5qUMPec2uFwpEL8ugEIILEYR8h66ZAD50vx2Y1PtwenWij6wUzyOjRSh0mXjv0wSshPsO+kvC38PHGPtooPWCbjVnwmbkAMN7yJxt8+TFlUy722uxQQe8+2ev0Sh7sA2x5SP+tlrQvYaq3MFEEjFPJzvM8s4TInkUWjL/6i5bWF407+TdiflFekTTzCxGrokQKMIMXCH0vV21MCkZp+9HL+Jk+luAepwUzaQegXz9Nidr8GT9zC284Sr2Rf623ZjRwmYfYg1wbSlJ2v4jOI7fqpX4MjSVACMnpPwH0inWsyM4oOtlwsfHkfnE6hU+jSA4zaYgfr1iaLDqdgPt/a78UvqiUbS5X53nQevjl3gvXfzVNfTqewVMVLVRBl7QyaQPTYZ1amgacZyaNKMP7FpCJSUJE+woHn/UpeYAM3mntabobKFz87XBz80zOpsMMqLceutKJdzFNq5VyO9wax/elfBZ5yr+oo2Jv+yuzx0UnwykVlSBJx2J/jfWaqFzbjKdhurSmLLxuMsq6GzvEOXepXyTRyeJuXcCDGxezVHR1DW+uuniU4E7fiUNLTmT8U5YBaiaWvqbSVqaeRS8j8h6v1xlpLyyrxGBmgG5iP2Muiq+jYuwu/guiuJK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199024)(186009)(1800799009)(8676002)(8936002)(26005)(55016003)(52536014)(5660300002)(83380400001)(9686003)(53546011)(41300700001)(7696005)(6506007)(66446008)(66556008)(66476007)(110136005)(66946007)(38100700002)(64756008)(76116006)(38070700005)(71200400001)(316002)(33656002)(478600001)(86362001)(122000001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/G5Ri2Tx0KeGfNe8VusVPCtlvSzkrAGxc/KthXXP6WAOljFxhJ3r0+VTe+Do?=
 =?us-ascii?Q?iT7AcgU5UDIFqjtAqaf/7EJx/enZK22NlhLlP6BXKIDdqa45qY2qv2lkA625?=
 =?us-ascii?Q?QMxgUhgs5sV2E19prvS+GYxyTyqx72aLzw7QrRTpu7aUemizCgpE5ybh4WaM?=
 =?us-ascii?Q?6/rNIAwAZKu1iGqIzk9iuFTkKbI71XN4EaOwbkOUfOs+L80PUKTZ3fiMmWfi?=
 =?us-ascii?Q?S2wGGA7gFmzF6K05in//Exglh7gLFncgZh9YoTBMK/JYfWzhPotizaXxyL7n?=
 =?us-ascii?Q?mrvq+9nelc9mqN0rJFhceAMgcKwm8uWahEvlq++kNhHsJs9xnyOz0uPaYcoo?=
 =?us-ascii?Q?HmbogP/lCuGQ1WeTDjBLvTmkNj/o4ab/PO6RotyR8NL017VyvbqP5tbPrd0Q?=
 =?us-ascii?Q?NxIGPtXFd7sHX/cBNQThfx+HavSx6cmA2WlOC3fx/UjWwMeN4u+W3AXbR4co?=
 =?us-ascii?Q?6CWy7+tjZWMOGPy+36aLjfuAwYHYYniP7KcBDOkaB/gPKwl4yLLpgN+6FXjT?=
 =?us-ascii?Q?gxdvsFbczMuHQNXDYPgIuxDk8Crmlm32w4JdSAMZZhGgGzMON8CtaOMivxcK?=
 =?us-ascii?Q?uKMyXGm8wzkHg4Uo2hChyfn+t+dCu5xZ4roV6ArCVvG9RsgIrME1By+ykiw3?=
 =?us-ascii?Q?RLSDxKQc6JpujoF5JR95SFKA5xN5pna/V1ukIgZMmAUjrE2q7WxIJ5N5KkhD?=
 =?us-ascii?Q?+A8u2TujoJJRVRyXCMgWLgt5M+QHbNPwaUgn/KQlTsoYU87Lh2QfLXpeZ23I?=
 =?us-ascii?Q?qKNWVksQCupMpeorKaACsQZ0m8n04Q7ziw5p0gLcuXIzTPmfvgtonOSRkZdb?=
 =?us-ascii?Q?gwLArzKIVh3QcNq+82tZos8HUr5q6MF+BAH1h5dJaHzc7lE8Z3oFV6vGhg90?=
 =?us-ascii?Q?4Sq3tbbRHc0FZA+POWndH9KuliZJhAeedaBzCDd60L4RtF3ZPb8Cv6J/20FD?=
 =?us-ascii?Q?seU6EcXfzDees+eFMf7rtFNfHqlU2VruZ13SH5dBeNc4qfE9JW4BN04dSYqv?=
 =?us-ascii?Q?DvqNT+l6jZksYTvCnRmSauSolt5V95V+AOJ2///duZKI7om77Mu9CduIJirE?=
 =?us-ascii?Q?ql/BDJNyxyS50LwVIkLgK0jG9t+6LmWfsA5hnL+1n1wRqflOYPUH7sZ+zjoj?=
 =?us-ascii?Q?DbzjumFKwWGJqWU2NpIatyX0JOq0o1qbeo6s1nv+UNxMaYo3K072BvqJQQWg?=
 =?us-ascii?Q?OscPx+zVg1tqBdr/e7LKzieiJSZ1CDe1vU3VgfkMU8HTSUvg5uverCP08Rf/?=
 =?us-ascii?Q?RfFPPyd8kFIj3V61wsT6fAg4mpzD/RhVYBmkyT8BZfNCdt8HbIaXFrbAVy6Z?=
 =?us-ascii?Q?O2e1UPxFZ5Fq7O6OBb1YTiGBodY7Se1ez+jRMXMiPZ0FSMPjwMWnV7LcfV/0?=
 =?us-ascii?Q?V/hiallHaTI+T7PERUuHCaQmMed1LC4EMrSVBh/dhZ4skT2WSJ68JVgNclS9?=
 =?us-ascii?Q?1XmrTFfcZEfM1a8fqUbtsSIUqaRFKC8dvqU5Tsi+zfSUuc7iCutub957vc8q?=
 =?us-ascii?Q?OF+iJ7bw6VYvu+q1azYNSSNUyaDmuAqT1Xgju+VQvca7EYbGWZVA9ScVvmah?=
 =?us-ascii?Q?CGc00/Y8SaBE0c17fPE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ad325f-0a02-43cf-1274-08dbb04a4e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 09:02:18.8064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOM1ZcF3RfCagICGoD4M3/E9RjfUQ+SyeU3RrBv0cwK8lbaWj4u/BYPBHv/lmzIhLKwQ88Ryq4/XhRYDniJrHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 8, 2023 16:39
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: enable smu_v13_0_6 mca debug mode when =
UMC RAS feature is enabled

v1:
enable smu_v13_0_6 mca debug mode when UMC RAS feature is enabled.

v2:
use amdgpu_ras_is_supported() helper function instead bitmask check.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-  .../drm/amd/pm/sws=
mu/smu13/smu_v13_0_6_ppt.c  | 26 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index ebc789e7a289..f762c01b98a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -247,7 +247,8 @@
        __SMU_DUMMY_MAP(Mode2Reset),    \
        __SMU_DUMMY_MAP(RequestI2cTransaction), \
        __SMU_DUMMY_MAP(GetMetricsTable), \
-       __SMU_DUMMY_MAP(DALNotPresent),
+       __SMU_DUMMY_MAP(DALNotPresent), \
+       __SMU_DUMMY_MAP(ClearMcaOnRead),

 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ff58ee14a68f..e69e82deae54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -133,6 +133,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGf=
xClk,                0),
        MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDr=
iverUnload,          0),
        MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,=
                     0),
+       MSG_MAP(ClearMcaOnRead,                      PPSMC_MSG_ClearMcaOnRe=
ad,                  0),
 };

 static const struct cmn2asic_mapping smu_v13_0_6_clk_map[SMU_CLK_COUNT] =
=3D { @@ -1393,6 +1394,20 @@ static int smu_v13_0_6_notify_unload(struct sm=
u_context *smu)
        return 0;
 }

+static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool
+enable) {
+       uint32_t smu_version;
+
+       /* NOTE: this ClearMcaOnRead message is only supported for smu vers=
ion 85.72.0 or higher */
+       smu_cmn_get_smc_version(smu, NULL, &smu_version);
+       if (smu_version < 0x554800)
+               return 0;
+
+       return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
+                                              enable ? 0 : ClearMcaOnRead_=
UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
+                                              NULL);
+}
+
 static int smu_v13_0_6_system_features_control(struct smu_context *smu,
                                               bool enable)
 {
@@ -2182,6 +2197,16 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(str=
uct smu_context *smu,
        return ret;
 }

+static int smu_v13_0_6_post_init(struct smu_context *smu) {
+       struct amdgpu_device *adev =3D smu->adev;
+
+       if (!amdgpu_sriov_vf(adev) && amdgpu_ras_is_supported(adev, AMDGPU_=
RAS_BLOCK__UMC))
+               return smu_v13_0_6_mca_set_debug_mode(smu, true);
+
+       return 0;
+}
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
        /* init dpm */
        .get_allowed_feature_mask =3D smu_v13_0_6_get_allowed_feature_mask,
@@ -2235,6 +2260,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_fun=
cs =3D {
        .i2c_init =3D smu_v13_0_6_i2c_control_init,
        .i2c_fini =3D smu_v13_0_6_i2c_control_fini,
        .send_hbm_bad_pages_num =3D smu_v13_0_6_smu_send_hbm_bad_page_num,
+       .post_init =3D smu_v13_0_6_post_init,
 };

 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
--
2.34.1

