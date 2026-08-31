Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FDEC61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD4C10E1AE;
	Mon, 31 Aug 2026 18:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aePjNC6X";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE5410E1DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2Z21Em/pdgXqClos3kzqDTKGm7XDFqSUWvHBS9a0LeMxYYYN/+ktRaBelRvKwNXztOp/Z0NgDiuhQUe8ciOsPZgq3KdrSoqKsLdtQnD2Y2Z/60ReNCfsOPZBWotBbOov1s6dObvWAfLn8uC1PnA/WYcjvXtFsty+FbQQkPHxR8G2jHEz0oNU8NKYC3PdtJcdNR98G84iFF1DzFRypysgxgpC+7bZdakQm/hd21vrArN9alwUqPHaMMAuSHZcBzx+tm5/btrN1PgZe4SWxb7rXR48MRF0+tBcdrS6WtkkJEMTAhg+WIbIIArlUnxQDiwmZtxyYOXOya6mviQLmA0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAzTT25Pu+ClcetQV9+HIbZFhH532Sv3dX79HMa99Ls=;
 b=y9mw0UEs6Y+DqGHWhbX6+CT4XrdTJtG/6tEPZ5ufKHjE2taVY9Hnl7eXx5QOsV+vhMXL98ZwiRFTK0+dLNv6Qyln1NEBv52ioxCJ+cWkHd5ZPmyYx372DQCc1nJDBza0C48PW6XVCtDJbhvWJQahJ7dZxDKdZzbTYzrib0YVPDnT+qpIt+JwVPdtJQq4Sv3PLoprNSR4hJ1NSez9Tolgk3JoTsEcFNg4YOWLzakeofZRjeLOeKHinsRMDLXpcJ+QscHd1ISrMenusEr9ejBmtaLdelAMb7upWCsmUJ0OTTymmWdVCDVLKkjS7NkCjAwG+fcP5kxkQG+tp7eVmnGLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAzTT25Pu+ClcetQV9+HIbZFhH532Sv3dX79HMa99Ls=;
 b=aePjNC6X9GcfkAjGu1dfschxvERJ+2laY64t4hj9jSy0bBYWlxJBLHMR83AMqYmUxvdEKm1HvhTRVxJIVDtlFoBvcmMZbq40Y44KS3DpvtBYyhd9KEL6RIIsk4r34v4JKx4ceM7sn0a4nwGgOUrcL0v1Kxt4mgtCduFna4q042w=
Received: from BN9PR03CA0642.namprd03.prod.outlook.com (2603:10b6:408:13b::17)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:17 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::d) by BN9PR03CA0642.outlook.office365.com
 (2603:10b6:408:13b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/95] drm/amdgpu: Fetch asp ualink interface version
Date: Mon, 31 Aug 2026 14:26:21 -0400
Message-ID: <20260831182754.1089811-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c04786-30df-4d0d-6fa7-08df078d9f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nbXks/Pg5gIaCAS6bEmjZor4+mWKTcpWOkhilerKyYVxcqv0rBvnhXJVn6GvhgtdTJ7UtgfVyIcAwYkuh7bOhWbtXyKxAC9M3t0sSSyKFYIhf4DoFmB3ER9Ym4DDZ7cE7W9czpPkQnyKMC9D8KLHYo11BowhKwxx5j6O/WpBEDJ1r0w2TpnhuvCbEW/qgTVmovqqAogL0O4KBPShWShir7rSB/0N8SjEltBnEUpVVEznGBJeVvSc1gri0wyGhya9B1wbPouyNvowH5pONVftrd9v6uAKfZGRUpRPXxAldEKHmaKzPcGXNyGiz/UpqVdjpTXmv/ydpXTmuqcN8wddiVs6L+xN7fMWN6577adcufGPvU59+sR5yUqO8D5szkAFPpY1Y18o8aBT8Gmhv16bsiHxXxZvkV3iTw8T7Ld4AaCG0D7HLJuXGfS5wKNZWtj564Wpzku/VPZ0gfsqNLIJSw9qG813WtTomufVh5y0CdAS/tJKr3PeyEqEj4loyS5K7f+pS/fSunvrGC7wUI+Rq8MpKgQCM+PoUqA9AEt2cfjVcAp3HlLZEVNt9f6E1UfsbouQgx5jj+NLqkOlmGADNFDeBnLbWJHrXy5DfW5+/UyABasJQ4m5RqqIIpxDUI5U8ghBvvPt9x6QN49KIAh0tbQiN8kDiHZ+kIi+0qsrYiXqYb/YY6xnp69ShLxHS0Izv7c2HLstBkOM9NjD+JYXIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tRymB3WPa9gU2Mqb30B7HI4Zf7yqgQO48pHUWqsTdNbieDoHd+7e5JZ0qVDWw2MWIoeMQp7xNrWryR+KpxD8bgEOblydWeMwsImOzc+WWAUT24uyRcBPsrdlM33yUv7zhagEWDn6ej1RV5cV4fBtYEYO/63iI2AnvOydAVwdM7XiJKVBW1SXWxc4uaVMfbkaK8HrJfGXgcWDYl50y5AWWeino6MNDwCZKZiPGbcRXVXVjeHMiqwCRK0oXhuZG1dijCTWnAz0Us8I2nE/hdsFXtJdNmgAmwYIAicFlu3m4l65VI9BT/zGuUYFUoRWw4Hgg8FpHYEcczcmuvBH2dlTxbT2CKgXbskki1Gjih13p0XfXz3EwcmuGYmlyLB/7rgGiSZi5KhTDTcN0NgZJOTd+ZRAhFeSFo2y+tHR56QpDboAWrqS4ey5LIRJa9tseUl7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:15.1685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c04786-30df-4d0d-6fa7-08df078d9f2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add interface to get ASP ualink interface version.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a0f6df5067e6e..5c82d1d808157 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -827,6 +827,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "NPS_MODE_CHANGE";
 	case GFX_CMD_ID_PERF_HW:
 		return "PERF MONITORING HW";
+	case GFX_CMD_ID_UAL_GET_INTERFACE_VER:
+		return "UAL_GET_INTERFACE_VER";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -1187,6 +1189,29 @@ static int psp_get_fw_reservation_info(struct psp_context *psp,
 	return 0;
 }
 
+int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver)
+{
+	struct psp_gfx_cmd_resp *cmd;
+	int ret;
+
+	cmd = acquire_psp_cmd_buf(psp);
+
+	cmd->cmd_id = GFX_CMD_ID_UAL_GET_INTERFACE_VER;
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	if (!ret && !cmd->resp.status) {
+		*intf_ver = cmd->resp.uresp.get_intf_ver_ual.intf_ver;
+	} else if (!ret) {
+		pr_debug("ual_get_if_ver: PSP status %x\n", cmd->resp.status);
+		ret = -EINVAL;
+	}
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
index 0aef9ee83bd0c..5968595647fef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -705,5 +705,6 @@ int amdgpu_psp_irq_mgr_register(
 	struct amdgpu_psp_irq_mgr *mgr,
 	const struct amdgpu_psp_irq_handler *handlers, int count,
 	const struct amdgpu_psp_irq_handler *default_handler);
+int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver);
 
 #endif
-- 
2.55.0

