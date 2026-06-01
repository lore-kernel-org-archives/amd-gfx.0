Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE306CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC24112F34;
	Mon,  1 Jun 2026 07:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kIMTB3IR";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A81112F35
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 07:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzeE4QumbGR3ECLtT/6Bn1WDZuxUuv2X9Kp4pUvE+lDoAw6WM+yIDC8PcG6y5WMUw8MGWAWiggEkme66jwXlGWSe2ZNejKTCEGqEGPGk5Mj92nj2yHNpO8swC9bGx1PR+ljkkCKXwo36G6UpoSOnGAm4BjiYXnun0+60e7kfb0bY54RAeCKfzHPi0+QBw830X6pDBLEUWyfnw1vcNPT+D5b+MWNbbRQUdhM2AONZY+eZ/DaZ1v+XEjXoZSv+nfVpV/bgjFcBiQp2XEU3fvJRS5AKZ4vyv7NnjM1hcTv5MqSlL5vapGW44l8L6wmcF3LtHRRSB3L1+t0BZ0/BUa03BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLDu4uV1dj0GTa3ZzOSKQ1pHqMMsMrrWMmYp06bUsdc=;
 b=vXZhzxIPwgkGWrEoOVcXLX5ggybjk0LwM9pMqF0E6DV1/Pa6Um82CiiOg03pfiG/eQgFVlPd/ieXiUCcUtTkNgLaL/kw7JP4Q2KYUnOONcDEU8EF93Hrs+Px21kYy8o2fKXTktYTX6xa5kLRs/eHaGAqiTw8gjjhsBRkKsfHkxUEnpVGuypgpP493beq6lCDOKNc8ZFjAzkGN5BnpRmalfNkRatVRsraUc7ZL5yM9G9gCERPb74murpyCwE8c1D1wzDHDsasp7ss2M3bKIgVsOxEUHYtdjiqh0FSadtmGBJqbiIW09sptimKPW07R0Y4lRTAnFCIxZHlMcOgIoE3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLDu4uV1dj0GTa3ZzOSKQ1pHqMMsMrrWMmYp06bUsdc=;
 b=kIMTB3IRVDolHC6/kAi7Xm2RXWoB80sMja3x7mXoevLtxhLpWh1DQVsZ0e6dtLbwqqBFd22Ub1c0/aIeWskPe6NGtKq9T2GYxTelwXtyhk3C8XgbJVpFo1TrTcgasl7O0rFEMdB1v9RdeLfSqjDDyrFfHavdjpvfQqCUnT6WTcg=
Received: from CH0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:610:75::30)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 07:56:45 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::3f) by CH0PR04CA0115.outlook.office365.com
 (2603:10b6:610:75::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 07:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 07:56:44 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 02:56:42 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, <asad.kamal@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: zero unused SMU argument registers
Date: Mon, 1 Jun 2026 15:56:32 +0800
Message-ID: <20260601075632.1557596-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d511463-7e0d-4f2e-a04a-08debfb352cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Fu1i3k5g8R3p8XzPBaBOCU1QLDizq90J6NcV4c4k49bD38jVhTGuN2jrpnmcQ4Vy3XuIe9HCRvLR/it2kyV99EzoSjQ65OUFEkqNJp7Aej1+/Xx4WEdw5cs7Wt2V47eK89o1VIKNsFcpenn0wC/QOeLcRaEMMIQfy2Vti2Xeqsj6ULiPCQtnoygcjN7XFgucMp8KtQ6Zxk3IPnBIButt7ofnwkuFt2TjXORY8PMx21TWS3LIMBPlknmd5D5e37KmnBckmGJDmRBUrWq62gEGpAWl1T+5VGyvbPwPC+ySaLXZQh8KhmSfyG83Q3d+7rlNngyH0qsNw0+JbWXg24JU3WzFQGRLSWGT2NnzBZPYlfMbvzp0IlX05UQOv6nVt24Fej/OFNcNDG+Cr49KYIFhdNcY01D3d3EjbEJMh1VytbUkQnoo9AWG35L8eUCS4G1ibFnuWiHDhHmjYpTx9AwslO9hbxvyMB3vGa3FwuCUdG7lcbOu18yhNjoCusjB7HfHQiMuI6sVBMcf5fG0y2yr2F3E7z890J9x+8jBZA8X8YEU6XgmELJEFfSn59gbeLfvwkv9VOsao3LSjhDnYounB3S5c53wKNNibu4dhooJX9IF+243S0WsIBXRARWkLHsz9Ar3k+uz4nbt6F7nC9oGpYGydOvBrBdGPfz9/blSGQYZUKsxau7Z4RIaG6ktX17538CRk1DF920caNXHkXpYkJjYxUHe6AZ2EhIGbW9P6Sg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7k+sLVEkCc0arTmqZ/jaM3lifmzzlj3KyaBpC8ueNFaiiEqkNr/Za87sYngBITGTADPIR7eMi1B58waXsvpJUuNaZMHwTx2UHlNwORIFkUotIoftU3UVc0dpsr3aW8BzFjSpyCPZBucsY/OSAmV8whf9VjZW9QKYj2XJGDr0dpgwLgenk+AVDbvFOLr8ZXws4M5iY5ANGrPfKhsiBjqeZIzXO25zqsNNwbWPKEC/+Do8mj8cxNrLppbIVv129nhQidpV2OxJU22WRbEpegKA/TiDOwBWTNIrq++JRYIhyMsvkKULLwuz4YVIOYwFsKlEKWTTl3l/kkoQ2mlh9TJa/4TWH6D8KkzjO1qHdsFWA6lkxu6q2lIIu6XMiAY6Iv7xuCHP4ygXvWDd4BNLupGLhkwSSIQ2NyzPW3LI9NCo5Z2+cqZDQmUko14qF9TozBFJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 07:56:44.2033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d511463-7e0d-4f2e-a04a-08debfb352cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941
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

SMU messages may use fewer arguments than the available argument registers,
the previous code only wrote used registers and left the rest unchanged,
so stale values from a prior message could persist.

Write all argument registers for each message and zero the unused tail
to keep command arguments deterministic and avoid unintended carry-over.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 546e64e3ba9c..85e7a8b347f7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -313,11 +313,15 @@ static void __smu_msg_v1_send(struct smu_msg_ctl *ctl, u16 index,
 {
 	struct amdgpu_device *adev = ctl->smu->adev;
 	struct smu_msg_config *cfg = &ctl->config;
+	u32 arg;
 	int i;
 
 	WREG32(cfg->resp_reg, 0);
-	for (i = 0; i < args->num_args; i++)
-		WREG32(cfg->arg_regs[i], args->args[i]);
+	for (i = 0; i < ctl->config.num_arg_regs; i++) {
+		/* NOTE: Clear unused argument registers to avoid stale values. */
+		arg = i < args->num_args ? args->args[i] : 0;
+		WREG32(cfg->arg_regs[i], arg);
+	}
 	WREG32(cfg->msg_reg, index);
 }
 
-- 
2.47.3

