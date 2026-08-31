Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8125C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4363D10E9FB;
	Mon, 31 Aug 2026 18:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VeVejAud";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C106810EA5E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLG5i1qdhSIi5lOoT61Unh1VPJKVzut9dNtCcppsREYHJgCNIBG6F1yuYYtm32bB4Al65QFlYhdzwzI04Y1j69BlIDPvgIWvNsvP1Yshk2RqvFhW13JyL9bQ8ht13uoU53xgSzq/z6h7lWzOfaoLdGsUzfRs9AO4hntqS3q+EmYSOU4uGv+43fbMMVj0Mq6S45YxAGwvX/3+Yh3/Or9kNAvF24so+YirAJA50NTThMH+kFqB3xZy6JAw/QR60XGJ8D38sbW+mxeoyQ5j/O1qdup71ms4f6Fli9+gu7cMzjx1fCk7Suau04ltIL+YMPdXhMqFgWsNi++2YkLrKWIVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCw+nyF38kxQFW15pdV9C5yyscUXPz1kriROBuhBJNg=;
 b=SXPDmrtZUixsGI1c0O4H8zdPdHzExsZLmHZ5KzQ+KD/JFtR+P1KBuALL+1ghKbNBnEehPJr3ohEbs+oojm/Br88LkOwSrR/kDr0Vh62pa+URE8cz3/lR7MgsGcfy17K8zRJnjUgzBTfW/FGdIBRdGA8HFPcunyA4ePEl881pgMTGFZ5ukx2anJzZCf2eehHrLO7hf2jXZdg8seTguVMf/mQpRj+xSrR4WEjsG8WyW3kHK+NHqM4l48jQdLkrQUWo28eaoHRLFOvtmZkUCLF66fLfsLQOSgvutkj2DrmWIz7Uhdkv8tvWMynfIwiioo982MHR0Xu0Z1cxJBz2ixiQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCw+nyF38kxQFW15pdV9C5yyscUXPz1kriROBuhBJNg=;
 b=VeVejAudtwNYXT2RE8yab75upZ5h4CnQwwI3zVNmU+OyVrmBU81pKdFW4tnCPpxINnEiOtJVQmjOOl7xYRpEJjgc82HLRhkm+Qm/+wHttlipD2DGW8kOBkYEyLu9OLibWBft9N4rMKMj5tiy5Pj6dAHPLXXqp2J0K0S75Q0zxmE=
Received: from BN1PR14CA0018.namprd14.prod.outlook.com (2603:10b6:408:e3::23)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:28 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::45) by BN1PR14CA0018.outlook.office365.com
 (2603:10b6:408:e3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/95] drm/amdgpu: Implement PSP cmd UAL_SET_STATION_CONFIG
Date: Mon, 31 Aug 2026 14:26:33 -0400
Message-ID: <20260831182754.1089811-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 5844fbce-8647-4824-9e21-08df078da703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: jdSTrXQFzo3zGkLEMu0NlkPhVZeEDoCnZSZ7ZjyB0n/+K1RxVm+CLA9XsKCJQygjl5Y3Ryzyyxs4tfsBA0RYoh19tHqCx3nTOyrFXEGtk6XIUdVGzofUthjv3W2nhPaFWkjuSL5eugyPqRxIel89YdSwqfbrDeeNTu25371WNkGVph5gCgukdn+c25f5q2/KdFkd20uE+7QHOMgnFtQRyivPw5E4z+UTnQAq3WAgrXBmuH+2r87DFrwivhCX7zLZq+B4UyQNOVBYIFMPyOk8qAU975ck2MOfFgHny1QbHvPrwZIKG+STMdTO7mWOfcZbOEgmAAoV8iLksz7JUYM1OIXiNdaB836itdauRGm81YxPM6W0M4qdLV15QBlnhau4udbXN79IZqZfvc1hSL4sLURXPAT9ykfvKOBLCCw2/xTHXmQPrtbaGzzn3DMT5Zmhqlc7EPS5TUpUKhcYWQi0QNFIYEhuCuvzxekb98slFSjw09Us+Scz3COpq5QYmCbE3Fvt6C9fySIDLRKL0ZPd3D/uDkHDbPxWOxhJPDJTrLx67txUqYufV0tA7c/P9MW/TUi5CXPpkd8+13vgn2zsRIafkSXCNp0vGj6U31tgwy5xbg+SNI7eYgzK10VW/8MvqTRfczcIW3eJ65fEsPfUAb32HbeH4U4M9V2PCF4d7XO0OXcEusF6/EY0HgDE9euN2Z/I1nxM8Z2McDo8S+avbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vqi0ykQy7M5OwGB6pKX0+mCrCbLsoynZ0CwiFvcwrf58nTRDLhZqY24anaXBc9cJJamG9gS0y/nKx+wI68CIauH5nTNwdydcSEGP5DtcyIFgQEqnwpdmjnFoDF1jqQCse/FwEbi4Z2FUXj5r6kOJ5GOYq+SsJvg2bVzfdZ908EuUvoMjWmUnsby8e2oX5NsLBP/csXDuSxvXWHUXMAYKRcPsmVDXLJEqvPJdKw19nOaNoXLA+T61KGJ4BCAMOVs6rNxAOjmcpnlYm4doqeHsHjmJX5gBAvvF7dUsDiYS8MPgNBj01ih9lxt/26axv+bd8/I5/VfayHMTNuvkhcSD6NiwNVsztiQoHlSYDO0BAPsnYMLV97+b8+H84CSdfkmb4zxMJ6xVAFBEJhuFNEyPGs2bg6tZYIfHcZZuPaulp9J2baIXgKWGO5UqmIDSx2DF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:28.3322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5844fbce-8647-4824-9e21-08df078da703
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799
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

From: Felix Kuehling <felix.kuehling@amd.com>

To set the UALink station configuration to PSP.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 35 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  4 +++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cbd85b27c6f6c..47367ff8c3903 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -835,6 +835,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "UAL_SET_PPOD_CONFIG";
 	case GFX_CMD_ID_UAL_SET_VPOD_CONFIG:
 		return "UAL_SET_VPOD_CONFIG";
+	case GFX_CMD_ID_UAL_SET_STATION_CONFIG:
+		return "UAL_SET_STATION_CONFIG";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -1357,6 +1359,39 @@ int psp_ual_set_vpod_config(struct psp_context *psp, uint32_t intf_ver,
 	return ret;
 }
 
+int psp_ual_set_station_config(struct psp_context *psp, uint32_t intf_ver,
+			       const struct amdgpu_ualink_station_config *stations)
+{
+	struct psp_gfx_cmd_resp *cmd;
+	int ret;
+
+	/* TBD check interface version 1.x */
+	if (intf_ver > 0x1ffff) {
+		pr_warn("PSP UAL interface version mismatch: 0x%x\n", intf_ver);
+		return -EOPNOTSUPP;
+	}
+
+	cmd = acquire_psp_cmd_buf(psp);
+
+	cmd->cmd_id = GFX_CMD_ID_UAL_SET_STATION_CONFIG;
+	cmd->cmd.cmd_set_station_config_ual.num_stations = stations->n_stations;
+	cmd->cmd.cmd_set_station_config_ual.station_flag = stations->flags;
+	memcpy(cmd->cmd.cmd_set_station_config_ual.lane_en_bitmap,
+	       stations->lane_en_bitmap,
+	       min(stations->n_stations,
+		   sizeof(cmd->cmd.cmd_set_station_config_ual.lane_en_bitmap)));
+	/* The remainder is already 0-initialized by acquire_psp_cmd_buf */
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	if (!ret && cmd->resp.status)
+		ret = -EINVAL;
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 int psp_update_fw_reservation(struct psp_context *psp)
 {
 	int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index d3bc3ba30599c..60ee3dc25113b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -709,6 +709,7 @@ int amdgpu_psp_irq_mgr_register(
 struct amdgpu_ualink_info;
 struct amdgpu_ualink_ppod_setup;
 struct amdgpu_ualink_vpod_config;
+struct amdgpu_ualink_station_config;
 
 int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver);
 
@@ -721,4 +722,7 @@ int psp_ual_set_ppod_config(struct psp_context *psp, uint32_t intf_ver,
 int psp_ual_set_vpod_config(struct psp_context *psp, uint32_t intf_ver,
 			    const struct amdgpu_ualink_vpod_config *config);
 
+int psp_ual_set_station_config(struct psp_context *psp, uint32_t intf_ver,
+			       const struct amdgpu_ualink_station_config *stations);
+
 #endif
-- 
2.55.0

