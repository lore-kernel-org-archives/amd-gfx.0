Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE858C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 01:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2888310EC46;
	Tue, 30 Apr 2024 01:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PIqDYJbG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A328C10EC46
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 01:09:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+ItLQszVm/xDQLfVWZTG5zyaVhMDH9Cl3LqDlNjnI6gpmJPsKZe9vr3UNA739YC208GGpfNnctxYyPVHdBclgxGYdTk+jbfjuOsMp5Y83RcdlGR5zxwVblBaSI/j1PjGfgFIdYaz7eBvQcMlr11crQAIVaF04o7J/E+ClCcb2u198ZOUCJYyLzRp7/54SnUvNlAi9J4brVnNN3YdOm1GV2SpfuU1hN/a3P5LRC+513qP9jAJmDcTTiomCZBvxF7MXwZcXSvDctfyNY7UQJ2ZXrQVnnIVcDzMhFxS98utHB/VTUsiBFCtT0eQ8DyzqN4/I1JG/TbAnXLDKqegN/WTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlVfUAxaRDYpbWwc2I/zLU4Y+rn1mHLM9Xsp1XbbZzc=;
 b=HT52/rLyf2G1hji0vHA8VgxjjBSpjqq/0w/0w92/utI32+6oWp+Fi6YaIfe1TKEm2Nh2J8I5uUDl/L6I4YsYIHNsVEb05rLwvIFJiqPifuY68goMCgiSQlTzBdgNc7JaZokclPhaPmFyv0k4IM3ZJLDT33zp07B8WBr+TrCZhv/pXwxHMZzNhRNGA7qpEQqH69//l6LWZDOiPhjoyjqiIh5UaerATsSpH6fXTQPvP7cJbXBIXb95yodaOe9+TZbCYAvm5CrNkhL4ZDBn5bGIbPGSg8Jw4bQM9vuifiFUK5pdxPYW+QOEL7p7tDvnPNPqDU3Yd+z6ANNkSRO+9SVxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlVfUAxaRDYpbWwc2I/zLU4Y+rn1mHLM9Xsp1XbbZzc=;
 b=PIqDYJbGb5Z7VVaPoq9uqY/23pP4AWiXwOEok/hunnEhxgrukxW8028gGoG8jkUx7nCyJhyicwC7UUmidsgvqdgNoZAWCvLJzBtsMhsjCdKLmwl0RK92wsonOORH/ghfyiHtiCalFqR5d6idMxbDbgwsOi8sQcM0ayonA3OVrdA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 01:09:39 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6d24:19fb:11d3:b00e]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6d24:19fb:11d3:b00e%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 01:09:39 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 1/3 V2] drm/amd/pm: Fix negative array index read warning
 for pptable->DpmDescriptor
Thread-Topic: [PATCH 1/3 V2] drm/amd/pm: Fix negative array index read warning
 for pptable->DpmDescriptor
Thread-Index: AQHamU/VYjCQbN3/1EG9qLRJFNas3bGAA20A
Date: Tue, 30 Apr 2024 01:09:38 +0000
Message-ID: <DM4PR12MB51521E66A77374B2E2A6A135E31A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240428093816.2035537-1-jesse.zhang@amd.com>
In-Reply-To: <20240428093816.2035537-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e74de1bd-cf88-4adc-8051-bc5142440cd8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-30T01:09:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN0PR12MB6320:EE_
x-ms-office365-filtering-correlation-id: e429767e-90e9-4452-c817-08dc68b2357b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Tcf18QmtLS/IiDs3qUQLRNhUUaC+f6MAPoltHkmyN2V/USVsZUbrd9ASDJCK?=
 =?us-ascii?Q?NSXb4j4vWLF6kVbOdFZsIbZR0oarsSpTwxh5h39pX+SCnonuBrFfgtMKt2vz?=
 =?us-ascii?Q?EWfNJ2h5823eLW2l5Iy6EGA+8epDI/G01Cuz8WZzpBQsYL4rnwVm+DZ1wWKF?=
 =?us-ascii?Q?p88d6iv4ryRWgrEsjzsr64M7L+4M2UXqfBSdfk7qgQRHH9HCw1IGy11S3Add?=
 =?us-ascii?Q?BaKwJqlGcZJjGeM2CvrHuxaLoCvJYsxo52ImrgejwzYYkgBSLd9HJv5QQMAU?=
 =?us-ascii?Q?rn29l/OYQNQoOVu4VvasybbHp2IdBavJHWHQBBRagqZ4nAF/ZEJt288XcpOj?=
 =?us-ascii?Q?8BcAgE9ky2kMKg6ch1kt6HDaPAdtZwXVaAmj9HZcWB2eJ4ib/0IAG3c24sfk?=
 =?us-ascii?Q?8dlGG5mWDY9H9M2s/yoN7MK3bxLFeNreitTXerBoHZpBioq8VH/tvraLVIJw?=
 =?us-ascii?Q?292+og1hd185ZhoEa1JFkcmNE9LCuEPajRVtCv3dEnfjqRkWLOK+7Rap+3jC?=
 =?us-ascii?Q?51xBY+NXBdpyMf0hRBUuPOmpyg+xuTgQopK1omZXGsua/k7sP08oSCDYWcFJ?=
 =?us-ascii?Q?RBDVuimc+xghAQmwVzCj6dMHkIOPxWuVXjAd0vS6iij7jEEONBwrWctp5i+r?=
 =?us-ascii?Q?guvwxv67dKCGMcJqxle4MxyxNLf64MmIPpB2v2/FH30b5e2TvMi7BhZgjIGg?=
 =?us-ascii?Q?zqTC0P5vtdqNwlider9k1rAe1mxrNvEx6dhYGTDna56vZA6UuWG81fHlloIQ?=
 =?us-ascii?Q?8dmJiAznAoo/PIFq1tgGRKSgl3wPhFEdG7fKSqy+9KgJHgqvB3c9/BGzn5oR?=
 =?us-ascii?Q?DknaHKg+Pa4NJYc2Wu2p70D/H5ffFpPZBIPNqrHKybW82YTecHoartKTuqIX?=
 =?us-ascii?Q?cjCwYBzqIL45Xk9qR3+3p8ctadq3Teh69Cr52DUIoQLiAMfTLUQUXr3nU4gG?=
 =?us-ascii?Q?A1tGFKJs4AwS+GXcYN+Mflm6HmYfXA0hf/dyb7CS2XQvvmYApFN6ZBqfw6iQ?=
 =?us-ascii?Q?Ciu9+gH9uiZToHyiJq2y5xU597rdsAHvLjcDu97xZbsGLHLzPqndicwmNYc7?=
 =?us-ascii?Q?m4b6iayaH2AarnCT3eEzhAwaG31dlcWMLj6Rs8tbUUeA4lsO9U/aDpasHZUb?=
 =?us-ascii?Q?Cp/wDfnzwA2x36AHpmB6zwGxP7Z8eGBEsTM3N0a0K7xgDEAVpHVX6ybVHMx/?=
 =?us-ascii?Q?phryBF6MHiAH4LoG9gfVrONwoDgW0OTJxMbhx+L3WcJEhsVCMt/dW6gEcDNG?=
 =?us-ascii?Q?ZqKpdkJcu2tcb3mxkLhfGpqdPkHVKymgFtad6jTDU/hiNqm5hta9RQZamPJv?=
 =?us-ascii?Q?Tvuabu98FPLXB2LYi9HEvBew?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MnbDhmOFcIg0eSnjbIIeng4t8zNnYQ8DXXvTELaAFwQBWL1QHQKT9wBrKzGC?=
 =?us-ascii?Q?Y1Xn+K1uCmflRUK8dL4cNZImmk4KVdpRDm3GyvShQZSK8j0SMA6KMv0QPH/K?=
 =?us-ascii?Q?ThvGo0Ty7er1YjU87nWknac+h17Up7Opb+99v6AHdhoZ99ps7yqMRWg/ie3+?=
 =?us-ascii?Q?7sgNTFASzk2hCF7S9r1gYM+8ZWQsZpFlhBYPUTGmz8sAZgLcL3D6Vi/YPzLt?=
 =?us-ascii?Q?G+JfWMSc/BZpjDY4X6DO+KhCrRa3M7XSL7sFAR7YxxRAXC6q01XYJP8pK9Hn?=
 =?us-ascii?Q?/4H1bx4iMrDevXjy8A/sOYtptqapkffFm+Cz5em11OQRtWyXbl/LgjBP4fEP?=
 =?us-ascii?Q?+09b+7Bqb9DxT70VAKjbmQDDaChbjfBWpth7KWvBSXAyVKKGKDLz/Iw/YHKD?=
 =?us-ascii?Q?yeEqRsz4e8LW9Qbrv0/0eo+om9Oc1uLRjaZrMLVmF+sMMXHuNQ9OUS6cdp/m?=
 =?us-ascii?Q?/wkW4LFzyutVLnTvMwhThm+I5HFZT0YKqxXuLw4i8kX6FkQ6J9xXiI+3wfi/?=
 =?us-ascii?Q?nTUxPdnLQD1XNJcFTAIvIJw0g/taXALBcsWtypkMy2I2EjHQWEdemMoyuYg6?=
 =?us-ascii?Q?SPcghEPobqcF0gG0YS2I2EEd0mgnfsg9mx5E2bZS/O+coeJz5EpPHYuid11P?=
 =?us-ascii?Q?sd6p5qqa0I1aIkJ+SrbXyi5P2EfgIRrkzxcUqRXfbYQvHzzEgUcCeKILZ3pR?=
 =?us-ascii?Q?ho+zXqqCEJtxHvzyr56yllCyQsX3HaApvigibe8kMgOiBQw2x3fN++VbJygg?=
 =?us-ascii?Q?syP0+YNWtMIw382xFnJs+QnT0r27khJpU+sOEXv7IX4JeP4fWr6JtR1qLf6g?=
 =?us-ascii?Q?G1FQ3hPJf8hhkQl/+tUcd+R/0BtjBhOWovLm9Vry/M6Aotcb5p2cN+uQ58DK?=
 =?us-ascii?Q?piJ8ZwnIYe57FUvddKDVinhvHCIDNJIjMVFXWSKK3m2y1anmglkUJYeMTvUy?=
 =?us-ascii?Q?Ki2cEo3IyyLH+L7/H1oo0OXsH3F93s4YLX/ujyUr/TyFdBeueVFbjAP2rmfB?=
 =?us-ascii?Q?MeX/aonbn5/0ISAjtohR5rk48bRP08Vnux19LcJUcHO41RuewhEZMBAiD959?=
 =?us-ascii?Q?2oWq5VCDDrFxwxL35+6zfbUvQ4zxTwefmRRo4xXYyX7qmTRNW4G2ffYFccj6?=
 =?us-ascii?Q?68ldRmRMf6xLwp4SdfVWx1E/pancIPSHkWO0CSXNzVZcgO1UK/V0f2HKD3xa?=
 =?us-ascii?Q?dJI8bbJE/1uD+Du7jPWUz3BF/xHUq0fRyMwdokPA/52k8lILqhjGXgii0BGo?=
 =?us-ascii?Q?5RxrTPQa4VjYySvKIHllsDDPqsGxlGSuFqqjlHCJbp0WiLPDDHnW7Il46ApL?=
 =?us-ascii?Q?OwHfSFjRtRyu+CkbGXHLU9tkwtMIkgXTg8WpuJMUvNXtlMCscUMTHH7al2zP?=
 =?us-ascii?Q?ukE2hZhjn5AcjqC9dHVqJiK/4hm+DmXjeJO+oZmDVpmdpURA7IcAt40Bngqx?=
 =?us-ascii?Q?V2WYWvH5RTFgEyRtIVlnaQ94OpFLAswZi5J7X6afgTUWrKYEx764Tz6fbmpW?=
 =?us-ascii?Q?nj1RPUpoHgF8brV8zBAdGLAaStE2mpwBmHfJKv4iws+q8MLnnbUmFscQiGmz?=
 =?us-ascii?Q?AYxShMjTsh/pRlJgi2k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e429767e-90e9-4452-c817-08dc68b2357b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 01:09:39.0081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTR3SQUmpDAmarbDnmp/fyIu9+far6iR8x2cRG4iv0ob11JMcX+KJfllHCZVlO52PUdZ/5aE917HATF28UZU/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
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

Ping ...

-----Original Message-----
From: Jesse Zhang <jesse.zhang@amd.com>
Sent: Sunday, April 28, 2024 5:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3 V2] drm/amd/pm: Fix negative array index read warning f=
or pptable->DpmDescriptor

Avoid using the negative values
for clk_idex as an index into an array pptable->DpmDescriptor.

V2: fix clk_index return check (Tim Huang)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 27 ++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5a68d365967f..c06e0d6e3017 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1219,19 +1219,22 @@ static int navi10_get_current_clk_freq_by_table(str=
uct smu_context *smu,
                                           value);
 }

-static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, en=
um smu_clk_type clk_type)
+static int navi10_is_support_fine_grained_dpm(struct smu_context *smu,
+enum smu_clk_type clk_type)
 {
        PPTable_t *pptable =3D smu->smu_table.driver_pptable;
        DpmDescriptor_t *dpm_desc =3D NULL;
-       uint32_t clk_index =3D 0;
+       int clk_index =3D 0;

        clk_index =3D smu_cmn_to_asic_specific_index(smu,
                                                   CMN2ASIC_MAPPING_CLK,
                                                   clk_type);
+       if (clk_index < 0)
+               return clk_index;
+
        dpm_desc =3D &pptable->DpmDescriptor[clk_index];

        /* 0 - Fine grained DPM, 1 - Discrete DPM */
-       return dpm_desc->SnapToDiscrete =3D=3D 0;
+       return dpm_desc->SnapToDiscrete =3D=3D 0 ? 1 : 0;
 }

 static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdriv=
e_table *od_table, enum SMU_11_0_ODFEATURE_CAP cap) @@ -1287,7 +1290,11 @@ =
static int navi10_emit_clk_levels(struct smu_context *smu,
                if (ret)
                        return ret;

-               if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+               ret =3D navi10_is_support_fine_grained_dpm(smu, clk_type);
+               if (ret < 0)
+                       return ret;
+
+               if (!ret) {
                        for (i =3D 0; i < count; i++) {
                                ret =3D smu_v11_0_get_dpm_freq_by_index(smu=
,
                                                                      clk_t=
ype, i, &value);
@@ -1496,7 +1503,11 @@ static int navi10_print_clk_levels(struct smu_contex=
t *smu,
                if (ret)
                        return size;

-               if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+               ret =3D navi10_is_support_fine_grained_dpm(smu, clk_type);
+               if (ret < 0)
+                       return ret;
+
+               if (!ret) {
                        for (i =3D 0; i < count; i++) {
                                ret =3D smu_v11_0_get_dpm_freq_by_index(smu=
, clk_type, i, &value);
                                if (ret)
@@ -1665,7 +1676,11 @@ static int navi10_force_clk_levels(struct smu_contex=
t *smu,
        case SMU_UCLK:
        case SMU_FCLK:
                /* There is only 2 levels for fine grained DPM */
-               if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+               ret =3D navi10_is_support_fine_grained_dpm(smu, clk_type);
+               if (ret < 0)
+                       return ret;
+
+               if (ret) {
                        soft_max_level =3D (soft_max_level >=3D 1 ? 1 : 0);
                        soft_min_level =3D (soft_min_level >=3D 1 ? 1 : 0);
                }
--
2.25.1

