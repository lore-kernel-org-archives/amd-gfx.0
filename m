Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CBACD98CE
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jun 2026 03:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 790B010EBED;
	Sat, 13 Jun 2026 03:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kKPnhmoh";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC04410EBD9
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jun 2026 03:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGzs2yszGmZPWg/Pr5OefEr+gFabUaX4S8Gduos2sQwl7b9ScKiF2PR/zWgUsxhFsZ+y/VqEYfTvarms1PegHCY250y0XiA8zWW8SLG53cPG8f72spa05ZcIvVxPOBhT0o716DYb+faXXJwgZBo7/iF48wo6r1wVBd35eotTFNa0OjoQhtsOOoJdMVgLBevFwSunp8E66VyjTr8R5QgkYYHJ6Y9bg1N0xSmc1HvUrAyZUvHLBCDRLgSvfMkKruecGgiyh4duvOgtlGTxI9Ew6mB3qck0nuAGrKnw1ytCDV9zFsWT9NttRsjhzhIH3NvC4hxt7jxxq6D3KqNzTsvZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olz1ZbOFyXkMcvykVaqH68mr21JVNuTR0owgRSsvs78=;
 b=vFmYVP+ZFCW2z6OMwOAvh0+aOOvg7R0dAd/XSs+7VbIjw2jX2rgr6D6hWO7Ym/jZftU5yCnvcE0T0btIxr3Q8KkxdzIzV0CaZpRQEBi40VhD0vWaTqPXkm2YoXHbop0iEPhfehWZ0jKKsMI+1+Gy8dr0hFZTi6p3c1Wi0VG/h1Pzr443W3XYa6tV2SU6irPg8Jv02TkrMauVJXJth7CLTQZotFX0Mz1oQ1KoP+TVjuFYlS9fNRXgEMbDFuGlRuAjsnxyruIpq/lJ1VFb58M9F9kCHDpwxT7sYYg7mUq9SUSJwOeAC99A1M3pZBlu5UTx0SxxySthKxF8GEqCJnGpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olz1ZbOFyXkMcvykVaqH68mr21JVNuTR0owgRSsvs78=;
 b=kKPnhmohVLZ0jWxQAJuOsQN62DuKF+74qxgxr3vmr6IfvvIgR0MmSgB58EPbDc15vCyJyDImAvpAyZrpbrp8HWeTASXGvf8ItjP4UbEHbAL27WUWGMXKNOcNkqn0AOrr0690YFGF1uY6i7M+OZ6x/AxVXBFETkaLa/4bpc1BcsI=
Received: from SJ0PR03CA0370.namprd03.prod.outlook.com (2603:10b6:a03:3a1::15)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sat, 13 Jun
 2026 03:02:15 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::37) by SJ0PR03CA0370.outlook.office365.com
 (2603:10b6:a03:3a1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Sat,
 13 Jun 2026 03:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sat, 13 Jun 2026 03:02:14 +0000
Received: from rocm-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 22:02:13 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jesse.zhang@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdkfd: Add gfx11 queue/pipe reset support to
 topology"
Date: Fri, 12 Jun 2026 23:01:51 -0400
Message-ID: <20260613030152.945160-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 812c5ed3-2f35-43fa-d15c-08dec8f82bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 4PLVgDXnzD4kdOeuKxvIiOKARQKvaujSS3Krkk9WKtkEku2iW1Pemk/IDQbSA+BLfsItlFanFtG4o+5Ge8NAYwKPeEsvQ6ExBiMw8I3q9M58kdhxYpH3P5dDeXhd0zDbAHyRZaYbzO7TNUHLCu8x9tMJZo+15/Kf129eA5DW5Kf3qOV6ToDPDyqPp5bqRMrE10YuprA9k+jFNTxBSTmJC3LaDK9cwjUMBv4Iy0tqYb7S8ZiBVaogry0jd88LyZneYAAr+s6VesTCk/bOWoVf37HbBtBVkDvj5iTPHEOukERP1ObvdFq2nYDVgnTC2eSRdlYJ/rbsDz0od/F+rxX+cb43SDNghRiuSzRpPHjkXusTK4EvoukBXfRhW6jhG4fo4kt56WN0OwldELtxQ1V5YAU6ggPjMJfIb1hyasjT9xZpUxM09ubkkKRYAkzaWSsHvCFZBUg83TlAb+nF3/wYmKSM2LkZImV3uHacZWe+VE+/iUs8npbxTMe761Qm+tsqpw47/AuZfeMjA2uFLx0EttyVrsDwaA/SliRqS6UEmbNlAxh4ie46WGBXyd4OT7BfObIEpBe3oonXNBpUFEco03WHsrGmPAl276yhQCpnVfxFyuttVrDN0QXLd7DmIDLysGveUDLFLQYE7cldE665egFidTGdtOz3Ixz4LZAuE8M0493VprVFjyINwX9+baMAcZJuze4YMxw0f+h4XNs2POz6PmK8xU5jEhHO+YymIrY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FYWdge52MUqHAf2JrxYtmBH4rVDZ/qPxFcSASlYspATdWvcw1ac4c2eXUP5DyHDmxSIBQoqXxSO+G6JfK5VroQQkDSC6VRn72sw68Uy6WgXsjRsfhqZPcPpjpggxU6neAS6cTh0DRgf+stFZmelZhasY3E/gOxEBkUAdhdPfWia0vvaIOH1TBczPj7uvzPltjAdHJtfstKDGSPuPYGBb4YRwvacLHT5yQoJpHUpxjm3FHRibe0qCevnDbbothh0qS+PllsXMesx4TDpHvGBBzRiT0FzUOv+TxQH0gjpkbln6jNTJWYTAqYFj9sbbxD+FsgJZ1jseNtbXVG2H9hhRIIlTvEisnXhkzLCfnc0qhw3zwc8VF7Xug4G6RtJxzmWcoBlzOASZvFvbIzX5f8iPPkL059QkbQbYvPmaR0Q4JFxi78mtwyZi0BLZHoF5Xzt2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 03:02:14.7606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 812c5ed3-2f35-43fa-d15c-08dec8f82bf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999
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

This reverts commit edb0257044b4b762d04542ea26c70673b8a87f2c.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 13a021b0e6e5..f00c522fba74 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -210,7 +210,6 @@ enum cache_policy {
 };
 
 #define KFD_GC_VERSION(dev) (amdgpu_ip_version((dev)->adev, GC_HWIP, 0))
-#define KFD_GC_VERSION_MAJ(dev) ((KFD_GC_VERSION(dev) >> 24))
 #define KFD_IS_SOC15(dev)   ((KFD_GC_VERSION(dev)) >= (IP_VERSION(9, 0, 1)))
 #define KFD_SUPPORT_XNACK_PER_PROCESS(dev)\
 	((KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) ||	\
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 6c3734db38ea..0ff793a17857 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2024,9 +2024,6 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;
 
-		if (KFD_GC_VERSION_MAJ(dev->gpu) == 11)
-			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
-
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0)) {
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
-- 
2.34.1

