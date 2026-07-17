Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CF2C4450A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 02:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C71610E40E;
	Fri, 17 Jul 2026 02:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yzIcOk5q";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5982710E40E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 02:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dW+eqvMC/YUjphjE53pCUy0NTKlYmCwPmCRYsIGnvxVIN1sn5fUJu0QmfJTZVMCNV9UufZvwZKFniJ5CUOD0JwzAwKgTlsVMBOUD8gZSPP+BolMFzg2nzJVrpVKnxUKxb869gyADwhsU/IyMy03fvVlKR0xq44FHMfIRvsYVi+2HcCwE5rtRMfCUZDaifnbtuGs1fnfNxAitt8bzpyX8oKWhvFqDS/ZguQJ19r4HWaIrt0u2RZyfLUHIPMRxXjleFutvfM6JGpGNhFGn4lU4s5cgqyqir2rkI2/Xou+8mHdH+9u1fuIKf2OjmP3gbthhgVKCsj7+C2O3aDGTfVSz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPINIb1J4mhWPKjAPGahjLEAzep9G1zVVAcWWH9p+0c=;
 b=taXNNTJZRQ4IpVAIdflUg0gEBU5XpQYGhO/PaRsuiKRm7lMxaPnUDLJyDLVXJ7rZV3a1UNyBacvLMuYJs7A7+401evYFw3u4yCKOoNN9DESzJzMKjjUSun+btEJWIY8u6YKmZMwpGYTqcUKbhTBcGMS69/MMlIbXAPjs8ci+hqoSFhYNUTJjZU2pgcHJAgrlUAySQHxiNglX4XnDTwxDLwYxONWny6O3pLKoa1g9hXY6bTgKAwaRF4xGIUDVIU/+zA41dfCoStrFGFfwixV2ia/9ywq7PBY3B2AHW0s9kVO9+u1fHE6Z1hHvlWq4COE/IEogKrSt+ytAU+v7+eMi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPINIb1J4mhWPKjAPGahjLEAzep9G1zVVAcWWH9p+0c=;
 b=yzIcOk5qx7Q6+C71GZPiiH5mUKLGyinvdWOrzHPEgR6CNzdXnKrJYqTqvH0fnkZMUGhiwDUpLjoMlhp1avmCFAJnqRI3gFNsr/qkYG49njADH5E43Sp1aXqvc14qAIYIVJ2ZSfrg2EI9fp098hl7EGESh9ielkE9UOpb4iVozZ8=
Received: from BN0PR04CA0162.namprd04.prod.outlook.com (2603:10b6:408:eb::17)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 02:43:46 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::88) by BN0PR04CA0162.outlook.office365.com
 (2603:10b6:408:eb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 02:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 02:43:45 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 21:43:45 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <aurabindo.pillai@amd.com>
CC: Fangzhi Zuo <jerry.zuo@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH] drm/amd/display: Dispatch Compressed FRL Cap Check Inside
 dml1_frl_cap_chk_inter
Date: Thu, 16 Jul 2026 22:43:29 -0400
Message-ID: <20260717024329.2609156-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 79311d5f-30c2-486a-9067-08dee3ad3917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|56012099006|11063799006|3023799007|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: uu+InQaGvLWvfPfd2HeQWvOxmZYVDgArJLwQLa/bqKDJP/F63AyWxuH0NsgyiQKzJBhPyiDtF+ZrR0sa5vv+LNpXU+SKGkswiREQcY928Io24knLG/2vsekQupTO5QBwHdNqzYJ7Rxm7Jg1v5W58eJLTlCp5Ut/lwQ13shxBBaGsb90dGlgBZ1FP9SJQkykY095c+eV8Oozn4VT8n37EaPTgCftQ0XW+4haLjJoE/mAO4c8C3hwV5CFXz533kMt14LSoEPMNDdcAma6dsQCBgC1hKRfOyMwiDqEBEKCvGS382kne0PNEvrwMPhJPVxkGAvuWzkGCOhNSXIMBRPI0a81DPFqFHCbEsMEdlWrUfl9mHnsjlxpkTTidFAN7x7DD0LbMQNQqyk4UzSMLSVmdkKJzftFjHPft5TCdNc66o66c2pqIUBmQiF60iuiQQpKHQhJIy9mShzlT0fqFjZNf09L6+xq/bl8OCwBlYYlcdz0rSy50V91EmhOVtJ72GKwjGWemd2MHm/x7wxfEsGaT7aFj9noLSAgGCBOnGQ3QQBXbxrUXTVy/vvJYhGIHYDpfuH9FcPMrbfeiQJX++fqPOvMXfMID0C/lZ+UCSzDKzx/OJk3FTea+i/iipLJe+UDdU4h8p5rdmWN/NScBL1qRYgR4cPY8OntMPKavBwahFyIBl3fkw96cA10SrcxiehVKvxszsbVvgLNG6hvXRavdmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jYdxEtz9XATa/DQjL0onWtNWZQhkAAQw4S9GivCOrm6jRK18rjACOSk28QOGr1zaXhokXaQzW61zlFx/FfFDpn3ieOrcnBT9D1P7Wc7p3OruWLWtJuSYcPkATZpxTnyAb+GfviImcoSZc/ccwvwgd+sOCoWGnV+cJbvSZ0bxqrPeIKBbRXegbTv+oCiOZCgqS560uZ7YoZWZjNDiT9KLECE9kGKpoO0Vw7WEVXPZd4EW+M+QvpmuKOle+jhk2/bfiBBCh0v+uLC1PfKjTaerIkNvMCdjV3d2xroT5fyiUH8tiaDeA6HloMNyHIsMc+wXMQF65bfORs3rwsuJQxsK6uSKJXFRiwI4a3YVPGAnjQlv3lm5gRUvB755URFIbAbqK/bjAAMgoW1XrMW4tRtvBab/2/0q3LZ2ExmG9BXuz6NOFrFggIlQg2zBHwI/bAS/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 02:43:45.9459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79311d5f-30c2-486a-9067-08dee3ad3917
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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

[why]
DSC over HDMI FRL (e.g. 4k144) was pruned by DML mode support
because the compressed FRL cap check was never reached.

dml32_TruncToValidBPP() validates the FRL output by calling
dml1_frl_cap_chk_inter() directly. The compressed-vs-uncompressed
dispatch (if params->compressed -> dml1_frl_cap_chk_compressed()) had
been moved up into the top-level dml1_frl_cap_chk() wrapper, leaving
dml1_frl_cap_chk_inter() as uncompressed-only. As a result a DSC stream
routed through TruncToValidBPP was validated against the full
uncompressed bandwidth, failed the cap check, and the mode was pruned
(vlevel == num_states).

[how]
Move the compressed dispatch back into dml1_frl_cap_chk_inter() so every
caller of _inter() (including TruncToValidBPP) honours params->compressed.
This matches the internal DAL tree.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
index 260f58a97fc7..da2c92e5c02f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
@@ -630,17 +630,17 @@ enum frl_cap_chk_result dml1_frl_cap_chk(struct frl_cap_chk_params *params)
 {
 	struct frl_cap_chk_intermediates inter;
 
-#if defined (CONFIG_DRM_AMD_DC_FP)
-	if (params->compressed)
-		return dml1_frl_cap_chk_compressed(params, &inter);
-#endif
-
 	return dml1_frl_cap_chk_inter(params, &inter);
 }
 
 enum frl_cap_chk_result dml1_frl_cap_chk_inter(struct frl_cap_chk_params *params,
 					       struct frl_cap_chk_intermediates *inter)
 {
+#if defined (CONFIG_DRM_AMD_DC_FP)
+	if (params->compressed)
+		return dml1_frl_cap_chk_compressed(params, inter);
+#endif
+
 	return dml1_frl_cap_chk_uncompressed(params, inter);
 }
 
-- 
2.53.0

