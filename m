Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905E3C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 10:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7FE10E437;
	Mon, 20 May 2024 10:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UZnW3XNP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D0C10E437
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 10:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0hR7kBsjQrFPDllXI0kSWzOL1T2aYz9tBVmI7N7/3yObmYZ2FB7kLSlDsAd8hwc8thddIQeZcPfuzXppVD3Av1bchRlOxy1CNvxN+amRQUA+2mqUD0e7WyBWxya61EkmePY8SeYOV/nKPBNb/CHzApfO/nXqgU9aDpfXI2g1mmymy4Qb/FICfGKsOd23cE8VW8gU+Z8NWF7kNaogNVmrtjx8ud41ngmKdDaEfVehgOeJ6vd2SK7mrCAAF/DNpCNVIaoHEi57ohr4sOZczTGEolax7ZJFSNM4kpBDSa+9Eb0CPzwun8Ba9H2rZTQ7pAcnfoEb/z5DEGHjiM+jfDezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfiOfVKPJkap5AbZVKv4RxlDMnwnuSm5KmpBESqk1B0=;
 b=iIzLCA0BKwQJ5DxzBhNZM9XWVHXt/rKxERb3Z0CW8cWVd5M5Je6TkBpUCWOw9Ww6od/e/CZ56rD1889/UuROvopdZE0F/fFB1WukmfNwSZsI/ibpZFh0xR8fStDcZmO8/MfXIZAZmb2Qe3/EcjzIPLyDDtzXvTOzCAAXolxHK7vv4Z9wTv/0/Eu57WrJ5GgVtQ80oBfdrU71xl4zKEK0k56ofgC+UB0esqebsS4GaI2rP/9cRorjw6ejZgHth1t5uqRjUjIVk96T941o1rnm24D0oDiX+eTncjBgRlJnXmYV3ifsQB7i86ZeV/+7yfEp3IJfkt0EzxZYWZih2otk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfiOfVKPJkap5AbZVKv4RxlDMnwnuSm5KmpBESqk1B0=;
 b=UZnW3XNP40q/sdh9YIoHL4t8MeHem2eOH8rRZKSGRRUonzgZp6zcn/J2yMEFk0vrhLurf7KjrTyPpsmYYpUnaO3ewN+5zp0DW5RChoE/Ir3u3ARlD4ALnvrchSjPrnltC0F446Xhycx6OSv8u4DNU/kwS9+8yG0JG/ril5l2CRY=
Received: from BLAPR03CA0109.namprd03.prod.outlook.com (2603:10b6:208:32a::24)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 10:59:14 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::8f) by BLAPR03CA0109.outlook.office365.com
 (2603:10b6:208:32a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.33 via Frontend
 Transport; Mon, 20 May 2024 10:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 10:59:14 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 05:59:12 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>, <tim.huang@amd.com>, 
 <jesse.zhang@amd.com>, <lang.yu@amd.com>, <jiadong.zhu@amd.com>, Li Ma
 <li.ma@amd.com>
Subject: [PATCH] drm/amdgpu/atomfirmware: add intergrated info v2.3 table
Date: Mon, 20 May 2024 18:58:58 +0800
Message-ID: <20240520105858.659694-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8cbc7a-ef61-4a0d-00f4-08dc78bbe337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OO7sX1Imk4xgZkczYOkwQmtIy3sru0Y5BsZlu7r9+PoOja6PSk28jjxurUuT?=
 =?us-ascii?Q?FRMty+Ua4xfYQNTquHC06hddGaNPAmBvubj9PLABc7QWYScEy2nG8ZcdT4ON?=
 =?us-ascii?Q?erEDbt/dFInGoD4LTkVntytKEFXCPlBd4PtkOJBwjks3R1qHJZv27vjKz1eO?=
 =?us-ascii?Q?4sW5FtdxQK69J9+0yriF1iPrHeVlMfDf+OGf96x647L+FP0g0wpelZPMp68D?=
 =?us-ascii?Q?zhqJpjaCJmBnOnIXrMSHQlGmx1BBz1azADgRU4qjeUkIpc+4D10B9pEys1gy?=
 =?us-ascii?Q?K1smcTpYG1EVhtA6zSUcW3E9f0bgS7G/4IlpCoPRzvtSoRtniMCyGy5Ad7Xw?=
 =?us-ascii?Q?QOaRtzvt1zYzCOSuIvMUdqD0+/+45956Yjh5kDTA6caNBpB74PS3wbMzcZY1?=
 =?us-ascii?Q?aVvjuYrtK0ueMQfGWxFhc2y6JIawW+T2mYDoF5OEdFhOZu/ca3yzTVNz8HxZ?=
 =?us-ascii?Q?Kc9fbBXeOz42xbtbyDtDNb2ylPrrO4DOhRxPvS2n0PJh8dpebELQzg/XrgcI?=
 =?us-ascii?Q?RK4WsXKxoZpC3ryHahkK/PaQD3BTQD75bZKeptXzfJFwQtAg97upkRoYyhBJ?=
 =?us-ascii?Q?EhxAYl10K0fY9OEJNkPodZJpXzKMH959j60KGIJwEM/oKJJ4c+2Ud8YY/fTl?=
 =?us-ascii?Q?fqJUn5etI3HSXzYwEUvTFunZvPsXWGflnlbkacRCLTGgCevP+e8zudbCZ2XD?=
 =?us-ascii?Q?oj4ysIHr8BBEjwKFF70t+HMghO50Z64E0wfwI73T9qSrLzi9TzOQkGKenuTh?=
 =?us-ascii?Q?LIlLpMoCaz616KopCrSTkzh1QDxSyqLBVzrpyVCyThk5qZDGGj9KHgmsEc5b?=
 =?us-ascii?Q?sH0z+psUPCO3aJjxjjE185QLQqbnvNpBedhjqscIfbb01ZFx1L7e5cbRaYHc?=
 =?us-ascii?Q?RhiIAyhRcMI9S/3WxPb1rTeou8DnEN3H+FIpelngD6pcgFhBmgt8dAmsxheB?=
 =?us-ascii?Q?XxQyMaBUtjb+ZFiEPYL9T1K7jn1EZMgEtjz+TR6EjM4OHLEkdiY0r+1LnHAe?=
 =?us-ascii?Q?pUs/CfGEopm3PwApqFmbI8EYQAumFnsG6RE+Hf5bb8IZmhIfx0ceVPeXGxZw?=
 =?us-ascii?Q?7FfEynPkC2E3xjTcGYj/60T4diGEqYCm84j5hhXGzgcJepTM6Cy8nwHsJz4D?=
 =?us-ascii?Q?18Q0Tdu1XBZjwwYVjhKGuIKYgZRJ5kCHiWLUv9VntVTonYJn13gtSv709+JD?=
 =?us-ascii?Q?i/HgYAkQSAf8NtYiITNyDUSzol6623Apy2Vb0Fs0Bjbge2dbYyPgnY9cUiLe?=
 =?us-ascii?Q?86+3CKNyhy68tRN8Oxnwif7ylmViiRXpyjPlHIBwlo4AxG8Fyf12RIcEpQaa?=
 =?us-ascii?Q?Q4QFUST+RHxK6qK0lz1GCGCcijW+ahUNxIwKDcXRM0jre8PzIa6dKrqSKfOs?=
 =?us-ascii?Q?oDC6RK2R5KcKl8nBf4WAchJDSH2T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 10:59:14.5549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8cbc7a-ef61-4a0d-00f4-08dc78bbe337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
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

[Why]
The vram width value is 0.
Because the integratedsysteminfo table in VBIOS has updated to 2.3.

[Solution]
Driver needs a new intergrated info v2.3 table too.
Then the vram width value will be correct.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 15 ++++++
 drivers/gpu/drm/amd/include/atomfirmware.h    | 47 +++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 6fe84151332e..f932bec6e534 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -212,6 +212,7 @@ union igp_info {
 	struct atom_integrated_system_info_v1_11 v11;
 	struct atom_integrated_system_info_v1_12 v12;
 	struct atom_integrated_system_info_v2_1 v21;
+	struct atom_integrated_system_info_v2_3 v23;
 };
 
 union umc_info {
@@ -366,6 +367,20 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 					if (vram_type)
 						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
 					break;
+				case 3:
+					mem_channel_number = igp_info->v23.umachannelnumber;
+					if (!mem_channel_number)
+						mem_channel_number = 1;
+					mem_type = igp_info->v23.memorytype;
+					if (mem_type == LpDdr5MemType)
+						mem_channel_width = 32;
+					else
+						mem_channel_width = 64;
+					if (vram_width)
+						*vram_width = mem_channel_number * mem_channel_width;
+					if (vram_type)
+						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+					break;
 				default:
 					return -EINVAL;
 				}
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index af3eebb4c9bc..8c031bb675a5 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1657,6 +1657,53 @@ struct atom_integrated_system_info_v2_2
 	uint32_t  reserved4[189];
 };
 
+struct uma_carveout_option
+{
+  char       optionName[29];        //max length of string is 28chars + '\0'. Current design is for "minimum", "Medium", "High". This makes entire struct size 64bits
+  uint8_t    memoryCarvedGb;        //memory carved out with setting
+  uint8_t    memoryRemainingGb;     //memory remaining on system
+  union
+  {
+      struct _flags
+      {
+          uint8_t Auto     : 1;
+          uint8_t Custom   : 1;
+          uint8_t Reserved : 6;
+      } flags;
+      uint8_t all8;
+  } uma_carveout_option_flags;
+};
+
+struct atom_integrated_system_info_v2_3
+{
+  struct atom_common_table_header table_header;
+  uint32_t vbios_misc; // enum of atom_system_vbiosmisc_def
+  uint32_t gpucapinfo; // enum of atom_system_gpucapinf_def
+  uint32_t system_config;
+  uint32_t cpucapinfo;
+  uint16_t gpuclk_ss_percentage; // unit of 0.001%,   1000 mean 1%
+  uint16_t gpuclk_ss_type;
+  uint16_t dpphy_override;  // bit vector, enum of atom_sysinfo_dpphy_override_def
+  uint8_t memorytype;       // enum of atom_dmi_t17_mem_type_def, APU memory type indication.
+  uint8_t umachannelnumber; // number of memory channels
+  uint8_t htc_hyst_limit;
+  uint8_t htc_tmp_limit;
+  uint8_t reserved1; // dp_ss_control
+  uint8_t gpu_package_id;
+  struct edp_info_table edp1_info;
+  struct edp_info_table edp2_info;
+  uint32_t reserved2[8];
+  struct atom_external_display_connection_info extdispconninfo;
+  uint8_t                      UMACarveoutVersion;
+  uint8_t                      UMACarveoutIndexMax;
+  uint8_t                      UMACarveoutTypeDefault;
+  uint8_t                      UMACarveoutIndexDefault;
+  uint8_t                      UMACarveoutType;           //Auto or Custom
+  uint8_t                      UMACarveoutIndex;
+  struct uma_carveout_option   UMASizeControlOption[20];
+  uint8_t reserved3[110];
+};
+
 // system_config
 enum atom_system_vbiosmisc_def{
   INTEGRATED_SYSTEM_INFO__GET_EDID_CALLBACK_FUNC_SUPPORT = 0x01,
-- 
2.25.1

