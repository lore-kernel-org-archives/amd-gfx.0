Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905AEC624D1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E708610EA7E;
	Mon, 31 Aug 2026 18:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k9HNFMki";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012014.outbound.protection.outlook.com
 [40.107.200.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3499D10EA21
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW6r8uSUs+7CKpINpFlkSBuUfVbneyVyY1VABI0QrDM/dSIl8HhpuGNzennCpqlkkK8eTUAUDAkjnUPE2GfVqTBmCn42mS75B6OFieWk7e4b2C4D96qe8At4PCeFquNyE+aEsdP+YZ5E1PWM9Cvo+nHnyjXfLoDOhWjMmHdh06RWrHF9ItIpOSr4z9tDJK+6HN8untcp/EFI+YKGxnS00c9DLXuk9DxKGWdNMw0onq0+XzwCLrXKSXuvWRPUKPZnfGAJQ6eeHBs+5S8t2QFtzI8T/HT4O0Ok4IrrVypuzR6kiD6BUdf0Oso6UoRl2pqESKldDxikDNKDiG68O+Qdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNhaWko5S5RAkUwqOSGDIMUqqfsvefr2AWAYxddo3H4=;
 b=tYfmtbOUCAdzwE6bPtrAC3T0O4BOS8yGAxuOwjemvl6YZOx7xtk7YUiR8ftgMVSzEOmrhD0ZnUX2D1PiqbhQDdvUwqJdyuM4Wv4H1o9S3Fwe+0R0tknz5BoWOICp/xBh/fl2r39D925/JRZdPHCJJUqlJ8aWLigKJ0SslpzGia3NtwGzJutsxZe0Z9S0S0P2BWx+MFLAgxv/kgVcn7OOfSuglwL2OCDPlKfPmtk2nmChDmxx3vWF3077yokDOT9IlL6m2nyojRZn+KyPzbjaO/aF9bMX0hTWFQIKIRFNUw8s9eYsYiO+ucMJVXBbKfUoKZFYt0v9/TyXOoZ+UqTEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNhaWko5S5RAkUwqOSGDIMUqqfsvefr2AWAYxddo3H4=;
 b=k9HNFMkizzfgZ8kKrDBmOVSD8W8Vbi5RPp3svLhf++xKx2s/c8ljv3sw6My4px6t/IIqLKjuyZs7nJu9/xKbwNisqA3h22mBg6OScevQ45orqzN1AR+98WozzdIg6sRHyAALRqEo7Ltzbw/nc8D7z6BU0jIhi06FB6O9thaK7io=
Received: from BN9PR03CA0664.namprd03.prod.outlook.com (2603:10b6:408:10e::9)
 by SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:08 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::19) by BN9PR03CA0664.outlook.office365.com
 (2603:10b6:408:10e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 80/95] drm/amdgpu: Add support to send ASP completion
Date: Mon, 31 Aug 2026 14:27:39 -0400
Message-ID: <20260831182754.1089811-81-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SJ2PR12MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d344fdc-281d-476e-b03a-08df078dbf05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: hEnIuwTelAu8Yzt+WRS7W612CYTvTB7nKnTzyUkFT6gXh9pcWTbHcy1QiwZvpuLLmKMUBuJHBZrYdO5gOyTcpxWd4f+Jmap9qwS8JJ+IpCpnKoqBuohL4+BKP1ltTBtZ/BvXA3qLNY0bGva50ATh3H24LUsFz+N9DuxzjoPRNtKCKB34g6TtLKG+/fNkps3fchBXDCePWxyRDLRTtazMTT75G2RXZiIS0EIxPSdaT78CenmJOzjXkNbD6p6FZGVzLVQx5vHuwQoZsQCJLj5oVBw+6bgd77gb/16E4RvGijnpxv/7BtniGOQpIEQGoAJ+s/9xwEEXWHdOih35xjDKW0wkoEe+gwiqKZxS/cPiW/Ixbkr98YDkSOxf31ZMKxWHEYO7mbre10QD5OUN45TA1cB6RNHgO04XrGEpqraIka88k/gxBPFgyEkgLgMSe74f84IjcjFRh5XdYXKJBth8xCEnv5KmVkG94yiw+cXQE8s4TgJF9Q3w7Hmf4AhGY95aJSgTr8suth85vC71e5uu9lZ5Flf4nKOgtwg1pCw/YjmR9bBMVXP8mETbODqicRnGsmvO90a3nEmu2MSkc4YOBmen+CoSSa3E/jDKXIM0/pe6Uu5YcMvOjN6kBQgz8uGr+91i5sYVoP39VzVZ7uFD/fYlyOHC4fml4fCRcXeQtxsPtSyqrdWN0qwnNja07EOLph5bI1Gay863J6RODqUPxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9vvpFclk+jPtDK0vOubvtCxmDCW4uoLy9JotjIfJnuPT+hiWtibr/98Wvtq3olih4c9Ly1Gk35mLD/NEwCYO0i/rJaBa6jESRpfxxaBsf0OX3GHXfJwDdrN+Ja/wBg7Q2VGPNM6HnMFpdHS2ftbCEZ3C6pyIPX6JIjba2hswir1hZgumJupdHnyGouqZzkJ793tXk/SpoIX7QpIYk+3D5Eqwa86fKQIufBwwedb4nBj5VNq8y0iDYGMmTn/qrAJmo90O03Q6KUbwdaa5PmY9ivJovo0eKVhNywWo4quKsTt+hY69fJqKnc+r9EH2WYoLjCNaGJf/A83lcD1FngI36C8WiqR4ShaEboIwe3lAEwPGP1+p1VWJS//pjamg+l5uH4+ioAdFGsN1lAX5Bk7PG3MFvDL910ZcbHPyurQXFJaT7EXkw/j9Hoc6yNzmJI32
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:08.6109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d344fdc-281d-476e-b03a-08df078dbf05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867
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

Add interface to send completion command to ASPs after processing ualink
notifications.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 28 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4fc7aed58bfc3..cb34148269160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1426,6 +1426,34 @@ int psp_ual_set_npa_config(struct psp_context *psp, uint32_t intf_ver,
 	return ret;
 }
 
+int psp_ual_send_completion(struct psp_context *psp, uint32_t intf_ver,
+			    uint32_t cmd_id, uint32_t status)
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
+	cmd->cmd_id = GFX_CMD_ID_UAL_SEND_COMPLETION;
+	cmd->cmd.cmd_send_completion_ual.cmd_id = cmd_id;
+	cmd->cmd.cmd_send_completion_ual.status = status;
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
index 2ba7ced36b7cc..35839f42b8a08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -730,4 +730,7 @@ int psp_ual_set_station_config(struct psp_context *psp, uint32_t intf_ver,
 int psp_ual_set_npa_config(struct psp_context *psp, uint32_t intf_ver,
 			   unsigned int vmid, bool enable);
 
+int psp_ual_send_completion(struct psp_context *psp, uint32_t intf_ver,
+			    uint32_t cmd_id, uint32_t status);
+
 #endif
-- 
2.55.0

