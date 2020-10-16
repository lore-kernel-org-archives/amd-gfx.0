Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D9AC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984A1206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zK8BuSfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984A1206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117796EA7F;
	Fri, 16 Oct 2020 03:28:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D981E6EA7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG2PYQG8MZNiLuMjr/ocIFKAPA3fbYRpnJewYCmMY7bEIDUw+DIwxOvJZDDlYImPKfETG23SJYIwdL4wqkoNAIhl5YHv+IauxHfjn8WwBiNtDtpe9T6HyV9L2yrvdaYh02lY3l+FCe23UE0fpEHmDAEXp4pF6M+o9+HImIg7FUHdVLEGa3+YAaURphfTwokPmkJSEdy2fv73bkyEDgfZ/3D987jl/qgridV2eU4ge9o1U1Mmdw3D73SFw/FSZ8ZybnVZXzGauoKXgMH2wGGs1oBXpT6Eb0v+3SqHhHAvmazhYv3CxWu5EmQ1H4UAdGYW++FdruZHYgI6LpK4PnVviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV9gw41MuFooDWGdVSTrIBqCcpZbOeBm7sK0sjwFFYA=;
 b=gBvaB87wJgj0BqfIp8NCHtjfNGP0baC/rCCQOwbBqFHFum7KbK8COa5sIWDLKvgk7hO3/jknmiBBDqCpeevRZrL649/Mi8138ZSHKfT7Nd/emuySoXPXAb6XNlE9OkXf3i7z49aqO7VmIayvlhrRRvjn5AITq05tXV5xSWG74vmII7+WSZPkZQ2saLLciwak4FdQri2Soo3Q9zsZ9ODjBXKhR2lCvjyWnb3nVwaRdHS0Jafbi1x8aED1vpbyHrrVVGWnzSBgK4SWNChsJHNMeNAusw5TyPFFIGxLi5aUbaftx6StWFuAYlN6AZubV6Kd+Nx8hLjRnNyTZEqM7flKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV9gw41MuFooDWGdVSTrIBqCcpZbOeBm7sK0sjwFFYA=;
 b=zK8BuSfodOqG8uhE90irwRJjsCo3ULsvmrEM5nhpXeVFSxHaMQ9LIkHb3Pj6y8hNHWlhu2CcaWypKryoWYtV0QmwX6vUDtIYzpKhW7hVz6lv/LAUAwbQi37PF2LYbwp/x25afBvYu0i/bEepfTNNJXHnnqRpj1uxbacSaO+J2+o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:06 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/40] drm/amd/pm: add edc leakage controller setting
Date: Fri, 16 Oct 2020 11:26:31 +0800
Message-Id: <20201016032652.507-20-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ecef27a-73b2-47f7-7c6d-08d871837f1d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354FB68752E4E2E5E3BEF97E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/h4YcK43GGX4CEIDPkKoXoyMNI2+jVk43ZheLYiMaN4c1f2sMqp0c3bM4zjmQlZYEe6f8fxjRez54GmoddVXurGa9hscv8Ea4P5Jxr1F2C2bAZw/OglmNO8zifgbraTynOXUxCbAMQHwO9J2SWluVTGMC127nJtbtSQIDdBm8gJtdsiOXdoeoI5AXVlBpV73B0bVHIwajy4bc079s63GObL9a+eEDst7uRfL5ZusC6gBmeI323rXqnMxXPa5MVTLsOJIjxDVChjSAyX4Mlc69Yr1ZuhYkk12jFFonAGVUH2yzSWt0ipgE1HBOSM/7VXXirYrvYw89Qtd0o56OtyAb0D9OLZYFK3i4P0W2lcf3IS3WOHlmF1GCYCdtDNZoVv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(30864003)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Na1IJBGimg4fxal0yXHsaFE95Xl0ZatyKCP9HDEVGZuc2cblpJEgVbIyi5IuEc7YJnegKs+qeq4B2fY+trDmoKl99/EoPdw2aMlA5zombWFlP3lEfMLkoAr2QLrfJ/n33XbP/6m2yWbtUkcco0lGFfTEp4XLc7FTqFtw0Zou9shArwglY8oGPN1rJEUmSH2j0wvxXJklqm8xjSCo4GFdN9rmyljjE0tvip9EWPPgufRq97CsU/HSTsY2Sn/WO7u/AiP7dDHGD84UbdH0WspikwEYgcPaorUY2jD2hJwmDaB3gFVTwuJShPj6+NxBDwItpvOouJDkA0l4/s12bVzK/2rsIeuM1Tbb2W/R2h7SnTcsNqJRwYrVSjOzdI9X9XxudHuLPQJbwRQgfFtYqO5e+Zl5y566zZXsbLSFZaT0h67pLgVi21cxgU4BLHweUoTENpt/KFnLZHb83rvmWGh005/6yJbRSrWARKUoCwWO6Jox+8k+6bxGuGL1pptg9mNeuBHiIt9gE4r7gDjYBNIlEhGq3aw7lx87kAMErBfPNoMiJw5KF2Nrt9R6kYyAsI0xrsjXhd59AhG5RWC80wx6+lne5Jecxp3x3YESwnNIhO8cbXu+dGn7OEYRAbye4snxj3QuXsvN59L6M15f++nX7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecef27a-73b2-47f7-7c6d-08d871837f1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:06.1797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqXvdxe6rueHMYF3kLAootA82HCWHHUqmPKWNWvoF713p9gokmSY1S9NhVZwb+y4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable edc controller table setting.

Change-Id: I38a1873b94f95c3ea8cfdca626bea3f30657bc31
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atombios.h        |  16 ++
 drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h       |   3 +
 .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.c   |  53 ++++++
 .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.h   |  22 +++
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 154 ++++++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h   |   4 +
 6 files changed, 252 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index 8ba21747b40a..e6548bb6cad2 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -5655,6 +5655,22 @@ typedef struct  _ATOM_GFX_INFO_V2_1
   UCHAR max_texture_channel_caches;
 }ATOM_GFX_INFO_V2_1;
 
+typedef struct  _ATOM_GFX_INFO_V2_3
+{
+  ATOM_COMMON_TABLE_HEADER asHeader;
+  UCHAR GfxIpMinVer;
+  UCHAR GfxIpMajVer;
+  UCHAR max_shader_engines;
+  UCHAR max_tile_pipes;
+  UCHAR max_cu_per_sh;
+  UCHAR max_sh_per_se;
+  UCHAR max_backends_per_se;
+  UCHAR max_texture_channel_caches;
+  USHORT usHiLoLeakageThreshold;
+  USHORT usEdcDidtLoDpm7TableOffset; //offset of DPM7 low leakage table _ATOM_EDC_DIDT_TABLE_V1
+  USHORT usEdcDidtHiDpm7TableOffset; //offset of DPM7 high leakage table _ATOM_EDC_DIDT_TABLE_V1
+  USHORT usReserverd[3];
+}ATOM_GFX_INFO_V2_3;
 
 typedef struct _ATOM_POWER_SOURCE_OBJECT
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
index 0454ec990a5e..97302aae4b27 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
@@ -404,6 +404,9 @@ typedef uint16_t PPSMC_Result;
 #define PPSMC_MSG_EnableDpmDidt               ((uint16_t) 0x309)
 #define PPSMC_MSG_DisableDpmDidt              ((uint16_t) 0x30A)
 
+#define PPSMC_MSG_EnableEDCController         ((uint16_t) 0x316)
+#define PPSMC_MSG_DisableEDCController        ((uint16_t) 0x317)
+
 #define PPSMC_MSG_SecureSRBMWrite             ((uint16_t) 0x600)
 #define PPSMC_MSG_SecureSRBMRead              ((uint16_t) 0x601)
 #define PPSMC_MSG_SetAddress                  ((uint16_t) 0x800)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 1bde79dd30c9..3aaf2d64cd98 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -1566,3 +1566,56 @@ void atomctrl_get_voltage_range(struct pp_hwmgr *hwmgr, uint32_t *max_vddc,
 	*max_vddc = 0;
 	*min_vddc = 0;
 }
+
+int atomctrl_get_edc_hilo_leakage_offset_table(struct pp_hwmgr *hwmgr,
+					       AtomCtrl_HiLoLeakageOffsetTable *table)
+{
+	ATOM_GFX_INFO_V2_3 *gfxinfo = smu_atom_get_data_table(hwmgr->adev,
+					GetIndexIntoMasterTable(DATA, GFX_Info),
+					NULL, NULL, NULL);
+	if (!gfxinfo)
+		return -ENOENT;
+
+	table->usHiLoLeakageThreshold = gfxinfo->usHiLoLeakageThreshold;
+	table->usEdcDidtLoDpm7TableOffset = gfxinfo->usEdcDidtLoDpm7TableOffset;
+	table->usEdcDidtHiDpm7TableOffset = gfxinfo->usEdcDidtHiDpm7TableOffset;
+
+	return 0;
+}
+
+static AtomCtrl_EDCLeakgeTable *get_edc_leakage_table(struct pp_hwmgr *hwmgr,
+						      uint16_t offset)
+{
+	void *table_address;
+	char *temp;
+
+	table_address = smu_atom_get_data_table(hwmgr->adev,
+			GetIndexIntoMasterTable(DATA, GFX_Info),
+			NULL, NULL, NULL);
+	if (!table_address)
+		return NULL;
+
+	temp = (char *)table_address;
+	table_address += offset;
+
+	return (AtomCtrl_EDCLeakgeTable *)temp;
+}
+
+int atomctrl_get_edc_leakage_table(struct pp_hwmgr *hwmgr,
+				   AtomCtrl_EDCLeakgeTable *table,
+				   uint16_t offset)
+{
+	uint32_t length, i;
+	AtomCtrl_EDCLeakgeTable *leakage_table =
+		get_edc_leakage_table(hwmgr, offset);
+
+	if (!leakage_table)
+		return -ENOENT;
+
+	length = sizeof(leakage_table->DIDT_REG) /
+		 sizeof(leakage_table->DIDT_REG[0]);
+	for (i = 0; i < length; i++)
+		table->DIDT_REG[i] = leakage_table->DIDT_REG[i];
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
index ee14635dfadf..c6276ab073b7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
@@ -278,6 +278,20 @@ struct pp_atom_ctrl__avfs_parameters {
 	uint8_t  ucReserved;
 };
 
+struct _AtomCtrl_HiLoLeakageOffsetTable
+{
+    USHORT usHiLoLeakageThreshold;
+    USHORT usEdcDidtLoDpm7TableOffset;
+    USHORT usEdcDidtHiDpm7TableOffset;
+};
+typedef struct _AtomCtrl_HiLoLeakageOffsetTable AtomCtrl_HiLoLeakageOffsetTable;
+
+struct _AtomCtrl_EDCLeakgeTable
+{
+    ULONG DIDT_REG[24];
+};
+typedef struct _AtomCtrl_EDCLeakgeTable AtomCtrl_EDCLeakgeTable;
+
 extern bool atomctrl_get_pp_assign_pin(struct pp_hwmgr *hwmgr, const uint32_t pinId, pp_atomctrl_gpio_pin_assignment *gpio_pin_assignment);
 extern int atomctrl_get_voltage_evv_on_sclk(struct pp_hwmgr *hwmgr, uint8_t voltage_type, uint32_t sclk, uint16_t virtual_voltage_Id, uint16_t *voltage);
 extern int atomctrl_get_voltage_evv(struct pp_hwmgr *hwmgr, uint16_t virtual_voltage_id, uint16_t *voltage);
@@ -324,5 +338,13 @@ extern int atomctrl_get_leakage_id_from_efuse(struct pp_hwmgr *hwmgr, uint16_t *
 
 extern void atomctrl_get_voltage_range(struct pp_hwmgr *hwmgr, uint32_t *max_vddc,
 							uint32_t *min_vddc);
+
+extern int atomctrl_get_edc_hilo_leakage_offset_table(struct pp_hwmgr *hwmgr,
+						      AtomCtrl_HiLoLeakageOffsetTable *table);
+
+extern int atomctrl_get_edc_leakage_table(struct pp_hwmgr *hwmgr,
+					  AtomCtrl_EDCLeakgeTable *table,
+					  uint16_t offset);
+
 #endif
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index b32dc0d6e880..27ca0e6b724f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -109,6 +109,62 @@ enum DPM_EVENT_SRC {
 	DPM_EVENT_SRC_DIGITAL_OR_EXTERNAL = 4
 };
 
+#define ixDIDT_SQ_EDC_CTRL                         0x0013
+#define ixDIDT_SQ_EDC_THRESHOLD                    0x0014
+#define ixDIDT_SQ_EDC_STALL_PATTERN_1_2            0x0015
+#define ixDIDT_SQ_EDC_STALL_PATTERN_3_4            0x0016
+#define ixDIDT_SQ_EDC_STALL_PATTERN_5_6            0x0017
+#define ixDIDT_SQ_EDC_STALL_PATTERN_7              0x0018
+
+#define ixDIDT_TD_EDC_CTRL                         0x0053
+#define ixDIDT_TD_EDC_THRESHOLD                    0x0054
+#define ixDIDT_TD_EDC_STALL_PATTERN_1_2            0x0055
+#define ixDIDT_TD_EDC_STALL_PATTERN_3_4            0x0056
+#define ixDIDT_TD_EDC_STALL_PATTERN_5_6            0x0057
+#define ixDIDT_TD_EDC_STALL_PATTERN_7              0x0058
+
+#define ixDIDT_TCP_EDC_CTRL                        0x0073
+#define ixDIDT_TCP_EDC_THRESHOLD                   0x0074
+#define ixDIDT_TCP_EDC_STALL_PATTERN_1_2           0x0075
+#define ixDIDT_TCP_EDC_STALL_PATTERN_3_4           0x0076
+#define ixDIDT_TCP_EDC_STALL_PATTERN_5_6           0x0077
+#define ixDIDT_TCP_EDC_STALL_PATTERN_7             0x0078
+
+#define ixDIDT_DB_EDC_CTRL                         0x0033
+#define ixDIDT_DB_EDC_THRESHOLD                    0x0034
+#define ixDIDT_DB_EDC_STALL_PATTERN_1_2            0x0035
+#define ixDIDT_DB_EDC_STALL_PATTERN_3_4            0x0036
+#define ixDIDT_DB_EDC_STALL_PATTERN_5_6            0x0037
+#define ixDIDT_DB_EDC_STALL_PATTERN_7              0x0038
+
+uint32_t DIDTEDCConfig_P12[] = {
+    ixDIDT_SQ_EDC_STALL_PATTERN_1_2,
+    ixDIDT_SQ_EDC_STALL_PATTERN_3_4,
+    ixDIDT_SQ_EDC_STALL_PATTERN_5_6,
+    ixDIDT_SQ_EDC_STALL_PATTERN_7,
+    ixDIDT_SQ_EDC_THRESHOLD,
+    ixDIDT_SQ_EDC_CTRL,
+    ixDIDT_TD_EDC_STALL_PATTERN_1_2,
+    ixDIDT_TD_EDC_STALL_PATTERN_3_4,
+    ixDIDT_TD_EDC_STALL_PATTERN_5_6,
+    ixDIDT_TD_EDC_STALL_PATTERN_7,
+    ixDIDT_TD_EDC_THRESHOLD,
+    ixDIDT_TD_EDC_CTRL,
+    ixDIDT_TCP_EDC_STALL_PATTERN_1_2,
+    ixDIDT_TCP_EDC_STALL_PATTERN_3_4,
+    ixDIDT_TCP_EDC_STALL_PATTERN_5_6,
+    ixDIDT_TCP_EDC_STALL_PATTERN_7,
+    ixDIDT_TCP_EDC_THRESHOLD,
+    ixDIDT_TCP_EDC_CTRL,
+    ixDIDT_DB_EDC_STALL_PATTERN_1_2,
+    ixDIDT_DB_EDC_STALL_PATTERN_3_4,
+    ixDIDT_DB_EDC_STALL_PATTERN_5_6,
+    ixDIDT_DB_EDC_STALL_PATTERN_7,
+    ixDIDT_DB_EDC_THRESHOLD,
+    ixDIDT_DB_EDC_CTRL,
+    0xFFFFFFFF // End of list
+};
+
 static const unsigned long PhwVIslands_Magic = (unsigned long)(PHM_VIslands_Magic);
 static int smu7_force_clock_level(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, uint32_t mask);
@@ -1334,6 +1390,50 @@ static int smu7_pcie_performance_request(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
+static int smu7_program_edc_didt_registers(struct pp_hwmgr *hwmgr,
+					   uint32_t *cac_config_regs,
+					   AtomCtrl_EDCLeakgeTable *edc_leakage_table)
+{
+	uint32_t data, i = 0;
+
+	while (cac_config_regs[i] != 0xFFFFFFFF) {
+		data = edc_leakage_table->DIDT_REG[i];
+		cgs_write_ind_register(hwmgr->device,
+				       CGS_IND_REG__DIDT,
+				       cac_config_regs[i],
+				       data);
+		i++;
+	}
+
+	return 0;
+}
+
+static int smu7_populate_edc_leakage_registers(struct pp_hwmgr *hwmgr)
+{
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	int ret = 0;
+
+	if (!data->disable_edc_leakage_controller &&
+	    data->edc_hilo_leakage_offset_from_vbios.usEdcDidtLoDpm7TableOffset &&
+	    data->edc_hilo_leakage_offset_from_vbios.usEdcDidtHiDpm7TableOffset) {
+		ret = smu7_program_edc_didt_registers(hwmgr,
+						      DIDTEDCConfig_P12,
+						      &data->edc_leakage_table);
+		if (ret)
+			return ret;
+
+		ret = smum_send_msg_to_smc(hwmgr,
+					   (PPSMC_Msg)PPSMC_MSG_EnableEDCController,
+					   NULL);
+	} else {
+		ret = smum_send_msg_to_smc(hwmgr,
+					   (PPSMC_Msg)PPSMC_MSG_DisableEDCController,
+					   NULL);
+	}
+
+	return ret;
+}
+
 static int smu7_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	int tmp_result = 0;
@@ -1400,6 +1500,13 @@ static int smu7_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 
 	smum_send_msg_to_smc(hwmgr, (PPSMC_Msg)PPSMC_NoDisplay, NULL);
 
+	if (hwmgr->chip_id >= CHIP_POLARIS10 &&
+	    hwmgr->chip_id <= CHIP_VEGAM) {
+		tmp_result = smu7_populate_edc_leakage_registers(hwmgr);
+		PP_ASSERT_WITH_CODE((0 == tmp_result),
+				"Failed to populate edc leakage registers!", result = tmp_result);
+	}
+
 	tmp_result = smu7_enable_sclk_control(hwmgr);
 	PP_ASSERT_WITH_CODE((0 == tmp_result),
 			"Failed to enable SCLK control!", result = tmp_result);
@@ -1697,6 +1804,13 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCE)
 		phm_cap_set(hwmgr->platform_descriptor.platformCaps,
 			      PHM_PlatformCaps_VCEPowerGating);
+
+	data->disable_edc_leakage_controller = true;
+	if (((adev->asic_type == CHIP_POLARIS10) && hwmgr->is_kicker) ||
+	    ((adev->asic_type == CHIP_POLARIS11) && hwmgr->is_kicker) ||
+	    (adev->asic_type == CHIP_POLARIS12) ||
+	    (adev->asic_type == CHIP_VEGAM))
+		data->disable_edc_leakage_controller = false;
 }
 
 static int smu7_calculate_ro_range(struct pp_hwmgr *hwmgr)
@@ -2611,6 +2725,42 @@ static int smu7_get_elb_voltages(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
+#define LEAKAGE_ID_MSB			463
+#define LEAKAGE_ID_LSB			454
+
+static int smu7_update_edc_leakage_table(struct pp_hwmgr *hwmgr)
+{
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	uint32_t efuse;
+	uint16_t offset;
+	int ret = 0;
+
+	if (data->disable_edc_leakage_controller)
+		return 0;
+
+	ret = atomctrl_get_edc_hilo_leakage_offset_table(hwmgr,
+							 &data->edc_hilo_leakage_offset_from_vbios);
+	if (ret)
+		return ret;
+
+	if (data->edc_hilo_leakage_offset_from_vbios.usEdcDidtLoDpm7TableOffset &&
+	    data->edc_hilo_leakage_offset_from_vbios.usEdcDidtHiDpm7TableOffset) {
+		atomctrl_read_efuse(hwmgr, LEAKAGE_ID_LSB, LEAKAGE_ID_MSB, &efuse);
+		if (efuse < data->edc_hilo_leakage_offset_from_vbios.usHiLoLeakageThreshold)
+			offset = data->edc_hilo_leakage_offset_from_vbios.usEdcDidtLoDpm7TableOffset;
+		else
+			offset = data->edc_hilo_leakage_offset_from_vbios.usEdcDidtHiDpm7TableOffset;
+
+		ret = atomctrl_get_edc_leakage_table(hwmgr,
+						     &data->edc_leakage_table,
+						     offset);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data;
@@ -2672,6 +2822,10 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 		smu7_hwmgr_backend_fini(hwmgr);
 	}
 
+	result = smu7_update_edc_leakage_table(hwmgr);
+	if (result)
+		return result;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
index b10e5bbffdf5..c1ed6fe587f3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
@@ -331,6 +331,10 @@ struct smu7_hwmgr {
 
 	uint32_t                              ro_range_minimum;
 	uint32_t                              ro_range_maximum;
+
+	bool                                  disable_edc_leakage_controller;
+	AtomCtrl_HiLoLeakageOffsetTable       edc_hilo_leakage_offset_from_vbios;
+	AtomCtrl_EDCLeakgeTable               edc_leakage_table;
 };
 
 /* To convert to Q8.8 format for firmware */
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
