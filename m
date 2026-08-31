Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D540C624D1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D7E10EA53;
	Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G9xaGoVX";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC8C10E654
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDtD3x04nEbNx9ylivPqxZ5xQjvEF6SHxAbJxC6S/tTFXDD/zK39g2+rJV55HOJhoK6KZLYnp+JQLmYC7L5OdgnymWIrZGNXvTBzPRKhsrh+Ug8g/ms9YojmVgJQcXlfImwLLpSTD7IZhTMehgxEON1iJIPMNCKDSha8N5cYizibwBp3iEC76ULil5iXDTZWonG791r7vl3ewXmUOJsMA644voBQi2BugutMArjm24vp0sf8o4XBYdatIUdEW4R0amyxLERGhNRwNfi3NebJ47Ms4ktWTxOcEBtB09gkVsqPLsWnj2/qb/N2jwp8KCKnUBuwhOddoKpnUXyRxI25Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZy7Bx1krt/K0mLIVSYBYuBxgW7BnKBp5Fs8aEv7WGs=;
 b=yn5kTNNhTOxskPLc2B6qjMs8RKA4ozXE5RkrrmoDyIX13zyg2jTFXsS57jCoHLo0Ut8fRrk4KyErgyjadp7lU5CrMSSMfxTVIhwACnqY94VOybzYVmvHWTBz85GlcCUKh37lt2vG+r4ognuDbiw/mkq46P0y8eTQ+3KCWpMGyTpgcEdESdRVDYWUThFr0EbE1s5blf8iMHMWF51Kru4K8Og0bieSG95kDcibBQY8uSNgY+viNz2kW7FKIl5So6QPPzZVj0G/bfqzQ6vL5Ibp8tvC3x+9jRFgKkLeBTiKe0Z1bS928bqhq3ljVOkh//iUDPIXxkt1pf98rxwIcQM29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZy7Bx1krt/K0mLIVSYBYuBxgW7BnKBp5Fs8aEv7WGs=;
 b=G9xaGoVXqk4xN5MjHdtV+UbvH/QPnOag7kboC7zt6kKjYEAXUTdZrUgV2aUqZPQIeP4T/JprWc070A5PcUibmK9P/nq+2+p2b+a718IijsMxFlEcit8MuhpCV1GA1EC9ubNxDKaaNY9qiyVK3w51dMKeogW4G3BhBlMUi+BmegE=
Received: from PH1PEPF00013312.namprd07.prod.outlook.com (2603:10b6:518:1::d)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:23 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2a01:111:f403:c801::2) by PH1PEPF00013312.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/95] drm/amdgpu: Implement PSP cmd UAL_SET_NPA_CONFIG
Date: Mon, 31 Aug 2026 14:26:35 -0400
Message-ID: <20260831182754.1089811-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fdfde45-cc61-481a-666c-08df078da380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: QUTeXRcZ98vK+FK/kQpoOotz0YXkUvJNF28bu7ImBgr96VXlNmDbfP07msFs1wvLoDPh77RuLaxI5ax5+0XDfZYJbRLNW1Iyt56DKtwwd3/QZ8CdrcIeQFP5woEIgOVbWO8dtGYPMqu3DaPHijCw+SQrKCxOsuBT0GdiMJGQanvdCPViirhQEGVSv95yzhGFTcEtMyvw6yaHeI1EDbmVmyg9b/ane5dxDyLvx9ItovMtlq2rO4e5d95z55mMX4YGKo+lGvLfTIks0LTZuHGsbSevLh2cQ3yKonyKm/09FDtTqpyhG+4e80H3R2KF5neiLefG9IxarSdtVQS411k+J2ZO79CcoBOjReq1fufVRECI4/sB8JfXC9VIZxHGC7GMHFXggXFwa+nLEbHDKSZosFNiqdQToc1Sko1dL4fUMYTNf3DgA9d18QH9RVJLt09f+eN0zVDj0OpbcFg3PlZ7riV/tL730yull6bJonpBhApuDPGcfD1PkujnqTSoXhyVGCDo+4zpUgLZ7tcbwkbx8vfXpGqcUezdpGkcEXWlPRheqLxYvIRItriMBGcijPeqrjeGlXq3xYR7VWAjAuhv2DtHM/WYbnqzeR3M/CBmqT/emTX65Re56UC8fV3WtRD33XRGvnei9GFJBIa0LHJCU+XDbSuPwVSs/CyCS20mV+taZ1x0GuBfl75jO3nRoLLWZ8qGn+5aGp8kziO9Jrr6TA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mgQ+rzaFIAwXbeUNc0acz4UOk0uNzaakXtPVC/Mrn6/nS75lYuY+vpaEXBSNb4cGkOs8NbOOupTYgshRdOP2LnACG76WkydfhIQ6BjV9wCM7GsvK2PfZ4BsRwGfnUKE+63oLFzeWS41d7AUwe8OjhxyzWMu+kM70zFquCbDe+a3XP4Y3JgTe6qJSmoJVXBiH79Xc8WVP0+IIGtSv0DI/L4O9CFFlmEOSNMmPvZAywjWVTJLF9ufRWJ8z0K2qrr46hrWiVI4OVxI9TErlkcjEod0OLbSXs7Ohf9krgLFVW7b1HX3QWNOxnh3/RFlL/4YCOL6o73YLvbR2zLLicWumK67305DPvoN57Rgy9FDrRh3dWFl1YUmqfnt5mndBst6/44EqEDkmvUk8cZbjCNdgPTaInjGviV3Wvb7fZalFvcOOOtOtUWRwAAWFBn4n62Lg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:22.4158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdfde45-cc61-481a-666c-08df078da380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
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

To set NPA translation configuration to PSP.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 30 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 47367ff8c3903..d68b1e5118732 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -837,6 +837,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "UAL_SET_VPOD_CONFIG";
 	case GFX_CMD_ID_UAL_SET_STATION_CONFIG:
 		return "UAL_SET_STATION_CONFIG";
+	case GFX_CMD_ID_UAL_SET_NPA_CONFIG:
+		return "UAL_SET_NPA_CONFIG";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -1392,6 +1394,34 @@ int psp_ual_set_station_config(struct psp_context *psp, uint32_t intf_ver,
 	return ret;
 }
 
+int psp_ual_set_npa_config(struct psp_context *psp, uint32_t intf_ver,
+			   unsigned int vmid, bool enable)
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
+	cmd->cmd_id = GFX_CMD_ID_UAL_SET_NPA_CONFIG;
+	cmd->cmd.cmd_set_npa_config_ual.vmid = vmid;
+	cmd->cmd.cmd_set_npa_config_ual.enable_npa_translation = enable;
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
index 60ee3dc25113b..ee37170c1c2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -725,4 +725,7 @@ int psp_ual_set_vpod_config(struct psp_context *psp, uint32_t intf_ver,
 int psp_ual_set_station_config(struct psp_context *psp, uint32_t intf_ver,
 			       const struct amdgpu_ualink_station_config *stations);
 
+int psp_ual_set_npa_config(struct psp_context *psp, uint32_t intf_ver,
+			   unsigned int vmid, bool enable);
+
 #endif
-- 
2.55.0

