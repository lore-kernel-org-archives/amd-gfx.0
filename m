Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12644CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A194710E81A;
	Wed, 29 Oct 2025 17:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e3xo3ibR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36F910E81B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSxYzZU6rpxbK+oYJIp1XCil0uljpn6gk9uVny71gXz/4u8pSpDR/r7R68F+w0kH2Y+DoJpd8TwlyM+pmy1Tczd/HOpJBh1H5CWIYH19EOjx1R3hVgPrDR2C9+CfDDGDEeccvAAzTb3do91mUWDwUufUtagOpeWi9FnHFQc4p8c/ki1QDWuviOd9VfmkxAnToRmf8fKmxJjIQkSh9Lg3MdarY4UiZ86XP7iviANP0/c8JpTXV31goJu7o3lO5y1sc6gicLr3WQm3im4KKKotGXi/ihD13Qy3PNhQqjcuzTQqrCH3cz+YqtQSd33ifUM3IAC2l95LeR8w1TFWea7Huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxN6cwIRyw80y46YDi7A3q/K5P/f4hRxAmR9HvjJNCE=;
 b=dOUG24g8CfFx0VNzytaahpsWRUpK3N5GXmRfbKpelf9PM8KOUhKrnbgxLIxWBxLDY17cwShWbupDS1raSE0EA/AQgmoBzZOAzX20QOAC9K2vVIOEA6bd5ffPTluR4B5+4hvv3hzeSFIzef+ioRg2coxsYrZ2jbiR3ZJbowQzF6olZoxQENTieb9VkJTO5CARp3vb93b9q33e4rjSJLkIqKAn7dqDDmcl1APi0He+EEBYEDtJOtPzVA9gO1xtGgXBEH4JtrvMRND6v2AzNMhSXaY3S4CsdNc8E8pxRB+TbLKl4y0hi/KW5YD3Krag2eDdYxJnpbsY3h1Rxfod4E5Law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxN6cwIRyw80y46YDi7A3q/K5P/f4hRxAmR9HvjJNCE=;
 b=e3xo3ibR7WuyNmHd4uEdgfftiQGtJqnyeZMh83783ow7M/8AgY5tU5EcYuE/wKRnETGI9hStPl7+9iigx1YoUGTlQZMmbrd/Jq1RpGe/piEJGYvNiGbGjRKTZIEiP3l2XBgjJdudPTMJNNA39eV6ht+PBzZA7NJE4tuH2DS6uzI=
Received: from BN9PR03CA0654.namprd03.prod.outlook.com (2603:10b6:408:13b::29)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:56:22 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::36) by BN9PR03CA0654.outlook.office365.com
 (2603:10b6:408:13b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:56:20 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:56:15 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: update psp_get_fw_type() function
Date: Wed, 29 Oct 2025 13:55:56 -0400
Message-ID: <20251029175557.2862156-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175557.2862156-1-alexander.deucher@amd.com>
References: <20251029175557.2862156-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f99ff99-a841-4ea6-7ebf-08de1714775d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tA+d27RUqMxhLClNLKjL7ROxFbtmtTOh2LiujlpRlVDWbCdzz4xS5gHfUIXZ?=
 =?us-ascii?Q?Mbxa8pdEbGcOsihYTsuAwjKvjn9cD/PpNSMOO9Eb0c0j4GWtIkj0vhiE5Jpv?=
 =?us-ascii?Q?03juy5kv6geDhHn2ChxdozRWdBHbuW4eWEkne+qs7UccZQithfPXQc4IF4KI?=
 =?us-ascii?Q?epwlL+8XxUqBrcdbDYVFlAktgPe0jQILJYyG8TJ8KH7yJQkENWEqfwCHvi7d?=
 =?us-ascii?Q?k7E3gKovN8n0YULWrsgi6FSjnFRlvUjqqmZ48/nx4RBuD6UB8y7h6bPO+bTd?=
 =?us-ascii?Q?7RVAfErCYC9BF0ZHW22Za6V3GmtTmTdzLoDD56TEqMjNALxuWoTO8iyYN1Dx?=
 =?us-ascii?Q?moJ0j9hsTIGQef6YH4+O5oFJKPyyFeoa0NJf5NuNpVKaut5VYMltFcyDOBOh?=
 =?us-ascii?Q?P3yIGdDs9mCTlXQjoUyslloasEcg/rkPWZ23CYh7AzL35yocEAdEkG35ssH3?=
 =?us-ascii?Q?doS4jy/YfJ7fkWLxhGmaTicyFt17Ew0rzykRUZAaTWpmy0lB1G1qkGlLPJ8S?=
 =?us-ascii?Q?IYy7MmOtGz4w6I8j/ff16W9ILZMoVeG5Q1sG5jl3sMxHjRgt+wprHrk2472N?=
 =?us-ascii?Q?Ne6V7d2/fCfr+BD6zip2cpLLeOg71UvWFktDJ/Lq96GLPvPGI+Ie3snR/zRb?=
 =?us-ascii?Q?iWuUmps9TTpH7vKPb6MNIrKgMSSx0ibkVk3/LjjW4FHgqamV8QfifrPNaUGd?=
 =?us-ascii?Q?YsPhSN6GtluLds5K/H7sXr06nMU9M9bVaujASXSkQeALyvUfg+W8+2v9TMTK?=
 =?us-ascii?Q?6WYM14MF3mw8BwC3XsAGOtAyrL3+SHODKJXYibzwOKIbB8C53aV5fC/VZTUo?=
 =?us-ascii?Q?g49XFw8/GrYVA1mlAuEHG6to1OOSdecWF6P1936TTOwhyJx+pgM2s4ojPo3c?=
 =?us-ascii?Q?BJL06QzKHsKk7+78/VjIsvkuCi9+sSsjbJ1F7gFxZj0NMHeYu0ts1Tjf33Ua?=
 =?us-ascii?Q?3WwSCLN4uXFwoFi7Z3SnM13pkfhEdSQl4DsxtolftI65X2MbWIctFUzAqJel?=
 =?us-ascii?Q?aAU5JIfm268y1GWozaVEj1nWdUf4wRthsIQeDSrfpQrNMI0uDk0d9uS9mQkR?=
 =?us-ascii?Q?OvzVf3icNxVkkyhSNA8d3EcE2fgkgCYN6Fl3Zxi8Tj8oAWvKA5gESgW/qxkw?=
 =?us-ascii?Q?GHO1WXmGeE/dFUgHPNivSzbwT0gevcP0c1n49Og8PjDZVo3nDxkizJRGXzUX?=
 =?us-ascii?Q?kC/rZKbvpDc5C8DM9lCagDFxsriOwPxcKcDvTjMyNu1geONWNQJ6gP2bWyYo?=
 =?us-ascii?Q?JEb/U5R3pxqsgpi/29Icy2+1FIV8Qa2+SoJ6QBYrePNJ3P4OaYfZP4svuKyD?=
 =?us-ascii?Q?GEEftNd9K/q99fCKRc1qf2kzz8PmiNFfsJ3BGxKNOjg2Lk+VJAm3ZUYRv3aG?=
 =?us-ascii?Q?BWTodAU16JD6Pq1fGU9Nba7h8v8+xO+JBezyTww6FMCt9M4iphMW8kZR9rq1?=
 =?us-ascii?Q?RqHDLcu+OgF/8oNOVZ6E5YtOsUsD3yBnpxt3iQePFGlUMOND/sbu4q+f7V6m?=
 =?us-ascii?Q?durmD5sxAoUwQPRdOxklZIuO4Pmf64s4+vL7NIPJG52rhUFKZrDgxnPFGeGy?=
 =?us-ascii?Q?45HSJWS1IdsTFPbJg2I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:56:20.2134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f99ff99-a841-4ea6-7ebf-08de1714775d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509
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

From: Feifei Xu <Feifei.Xu@amd.com>

In psp 14.0.7, mes and sdma GFX_FW_TYPE have been changed.

Define a psp common function: psp_get_fw_type().
Hide the GFX_FW_TYPE Changes in each ip's psp->funcs_get_fw_type callback.
(like psp_v14_0_7_get_fw_type()).
If no GFX_FW_TYPE change, reuse the amdgpu_psp_get_fw_type().

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |   8 ++
 drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.c | 140 +++++++++++++++++++++++
 3 files changed, 150 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b17004c190d90..2d4bd4f2f9b93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2620,7 +2620,7 @@ static int psp_hw_start(struct psp_context *psp)
 	return 0;
 }
 
-static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
+int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 			   enum psp_gfx_fw_type *type)
 {
 	switch (ucode->ucode_id) {
@@ -2908,10 +2908,9 @@ static int psp_prep_load_ip_fw_cmd_buf(struct psp_context *psp,
 	cmd->cmd.cmd_load_ip_fw.fw_phy_addr_hi = upper_32_bits(fw_mem_mc_addr);
 	cmd->cmd.cmd_load_ip_fw.fw_size = ucode->ucode_size;
 
-	ret = psp_get_fw_type(ucode, &cmd->cmd.cmd_load_ip_fw.fw_type);
+	ret = psp_get_fw_type(psp, ucode, &cmd->cmd.cmd_load_ip_fw.fw_type);
 	if (ret)
 		dev_err(psp->adev->dev, "Unknown firmware type\n");
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2733a7bf4ad6e..e8457715cc140 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -172,6 +172,8 @@ struct psp_funcs {
 	bool (*is_reload_needed)(struct psp_context *psp);
 	int (*reg_program_no_ring)(struct psp_context *psp, uint32_t val,
 				   enum psp_reg_prog_id id);
+	int (*get_fw_type)(struct amdgpu_firmware_info *ucode,
+			enum psp_gfx_fw_type *type);
 };
 
 struct ta_funcs {
@@ -524,6 +526,10 @@ struct amdgpu_psp_funcs {
 	((psp)->funcs->reg_program_no_ring ? \
 	(psp)->funcs->reg_program_no_ring((psp), val, id) : -EINVAL)
 
+#define psp_get_fw_type(psp, ucode, type) \
+	((psp)->funcs->get_fw_type ? \
+	(psp)->funcs->get_fw_type(ucode, type):amdgpu_psp_get_fw_type(ucode, type))
+
 extern const struct amd_ip_funcs psp_ip_funcs;
 
 extern const struct amdgpu_ip_block_version psp_v3_1_ip_block;
@@ -622,6 +628,8 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
 int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
 				   enum psp_reg_prog_id id);
 void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
+int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
+			   enum psp_gfx_fw_type *type);
 
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.c
index a13fd866000a8..27e74c340330e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0_7.c
@@ -186,6 +186,145 @@ static void psp_v14_0_7_ring_set_wptr(struct psp_context *psp, uint32_t value)
 	} else
 		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67, value);
 }
+ 
+static int psp_v14_0_7_get_fw_type(struct amdgpu_firmware_info *ucode,
+			   enum psp_gfx_fw_type *type)
+{
+	switch (ucode->ucode_id) {
+	case AMDGPU_UCODE_ID_CAP:
+		*type = GFX_FW_TYPE_CAP;
+		break;
+	case AMDGPU_UCODE_ID_SDMA0:
+		*type = GFX_FW_TYPE_SDMA0;
+		break;
+	case AMDGPU_UCODE_ID_SDMA1:
+		*type = GFX_FW_TYPE_SDMA1;
+		break;
+	case AMDGPU_UCODE_ID_SDMA2:
+		*type = GFX_FW_TYPE_SDMA2;
+		break;
+	case AMDGPU_UCODE_ID_SDMA3:
+		*type = GFX_FW_TYPE_SDMA3;
+		break;
+	case AMDGPU_UCODE_ID_SDMA4:
+		*type = GFX_FW_TYPE_SDMA4;
+		break;
+	case AMDGPU_UCODE_ID_SDMA5:
+		*type = GFX_FW_TYPE_SDMA5;
+		break;
+	case AMDGPU_UCODE_ID_SDMA6:
+		*type = GFX_FW_TYPE_SDMA6;
+		break;
+	case AMDGPU_UCODE_ID_SDMA7:
+		*type = GFX_FW_TYPE_SDMA7;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES:
+		*type = GFX_FW_TYPE_RS64_MES;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES_DATA:
+		*type = GFX_FW_TYPE_RS64_MES_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES1:
+		*type = GFX_FW_TYPE_RS64_KIQ;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES1_DATA:
+		*type = GFX_FW_TYPE_RS64_KIQ_STACK;
+		break;
+	case AMDGPU_UCODE_ID_RLC_P:
+		*type = GFX_FW_TYPE_RLC_P;
+		break;
+	case AMDGPU_UCODE_ID_RLC_V:
+		*type = GFX_FW_TYPE_RLC_V;
+		break;
+	case AMDGPU_UCODE_ID_RLC_G:
+		*type = GFX_FW_TYPE_RLC_G;
+		break;
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL:
+		*type = GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_CNTL;
+		break;
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM:
+		*type = GFX_FW_TYPE_RLC_RESTORE_LIST_GPM_MEM;
+		break;
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM:
+		*type = GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_MEM;
+		break;
+	case AMDGPU_UCODE_ID_RLC_IRAM:
+		*type = GFX_FW_TYPE_RLC_IRAM;
+		break;
+	case AMDGPU_UCODE_ID_RLC_DRAM:
+		*type = GFX_FW_TYPE_RLC_DRAM_BOOT;
+		break;
+	case AMDGPU_UCODE_ID_RLC_IRAM_1:
+		*type = GFX_FW_TYPE_RLX6_UCODE_CORE1;
+		break;
+	case AMDGPU_UCODE_ID_RLC_DRAM_1:
+		*type = GFX_FW_TYPE_RLX6_DRAM_BOOT_CORE1;
+		break;
+	case AMDGPU_UCODE_ID_SMC:
+		*type = GFX_FW_TYPE_SMU;
+		break;
+	case AMDGPU_UCODE_ID_PPTABLE:
+		*type = GFX_FW_TYPE_PPTABLE;
+		break;
+	case AMDGPU_UCODE_ID_VCN:
+		*type = GFX_FW_TYPE_VCN;
+		break;
+	case AMDGPU_UCODE_ID_VCN1:
+		*type = GFX_FW_TYPE_VCN1;
+		break;
+	case AMDGPU_UCODE_ID_VCN0_RAM:
+		*type = GFX_FW_TYPE_VCN0_RAM;
+		break;
+	case AMDGPU_UCODE_ID_VCN1_RAM:
+		*type = GFX_FW_TYPE_VCN1_RAM;
+		break;
+	case AMDGPU_UCODE_ID_SDMA_UCODE_TH0:
+	case AMDGPU_UCODE_ID_SDMA_RS64:
+		*type = GFX_FW_TYPE_SDMA0;
+		break;
+	case AMDGPU_UCODE_ID_SDMA_UCODE_TH1:
+		*type = GFX_FW_TYPE_SDMA_UCODE_TH1;
+		break;
+	case AMDGPU_UCODE_ID_IMU_I:
+		*type = GFX_FW_TYPE_IMU_I;
+		break;
+	case AMDGPU_UCODE_ID_IMU_D:
+		*type = GFX_FW_TYPE_IMU_D;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC:
+		*type = GFX_FW_TYPE_RS64_MEC;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P0_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P0_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P1_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P2_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P3_STACK;
+		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_UCODE:
+		*type = GFX_FW_TYPE_UMSCH_UCODE;
+		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_DATA:
+		*type = GFX_FW_TYPE_UMSCH_DATA;
+		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER:
+		*type = GFX_FW_TYPE_UMSCH_CMD_BUFFER;
+		break;
+	case AMDGPU_UCODE_ID_P2S_TABLE:
+		*type = GFX_FW_TYPE_P2S_TABLE;
+		break;
+	case AMDGPU_UCODE_ID_MAXIMUM:
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 static const struct psp_funcs psp_v14_0_7_funcs = {
 	.init_microcode = psp_v14_0_7_init_microcode,
@@ -194,6 +333,7 @@ static const struct psp_funcs psp_v14_0_7_funcs = {
 	.ring_destroy = psp_v14_0_7_ring_destroy,
 	.ring_get_wptr = psp_v14_0_7_ring_get_wptr,
 	.ring_set_wptr = psp_v14_0_7_ring_set_wptr,
+	.get_fw_type = psp_v14_0_7_get_fw_type,
 };
 
 void psp_v14_0_7_set_psp_funcs(struct psp_context *psp)
-- 
2.51.0

