Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800DCC5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 11:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C09C10E028;
	Thu, 29 May 2025 11:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O4YUYQZZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CF010E028
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 11:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCiu550LAT5ZUJOkawM6E7KSfijKrEOA8dspX6O+C4gyC8wHThMJoDovofdgW4dxkrRHwiKT47LjmXWOIK4PiJHvgaee7De1a+o5TFkpvlc26YfljctnyF9bcU2XAahddNrMgjCcOzPqrzxXsmeKCp7kyF7GiyL7/1Vtlnmal+akDpT1lUNh7nAJb17qgmdHO+AOvwL/E1vBuRs9HOfzFCRB7ECWQ7AyAVzLuUDmEpIXkQO2odBkmOp47IMmVhp3UInNexGXytXtssU9hFPVjtprO8v2nEEgUYrhjSLv5O7NL72Qd9Zkwuw0z38CFk1QSo83yoV/zoh5WPhdlYATPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqQd/Dr5fr12O8bQ5Ys+Lv11XfaLs2a8gdapwx5W/Hw=;
 b=LhEOKC3aukBPX8yq4RzbjXepGPQ1ymV87LCFrPaQ3F9+rkvouBr/kUe88WdX0h6T53J3LjFH2I0qAnqf23rtpD+xXcvhpjxnekJLhjlu39a/3GyM2Ga1zlkWISlvuqk+BOImLcAtctcRvBTsPAyE0LeR/rOK7irDJuBYrJQ4xqPvwlmUIhDVpm0BTYzOPoFvHpaGwsl6iUsoPiIWlDB8TQ5+O+cWpWwN2Lybj9zw1d2oFC4F2OmB/qXjnRK9u/4/ApDrlvW3isisnTk1LeYFFH2ZZ+GaKeqp7Fwx3qf2MWxVXpz6S0ynLzx9ofFqRr8MgDZragSB7+LE/62lDSFJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqQd/Dr5fr12O8bQ5Ys+Lv11XfaLs2a8gdapwx5W/Hw=;
 b=O4YUYQZZH+qFUfq6xJG2f5ZUsuefuKq3gz9Xse1UZtfIsW/Lgje3tmfL4uq1bCn3JmHyxARglhA5rC/Zj/BLJ+g0r0QAMG4pPf5zwAd0ktF7Vh0Cvsiq80OQSLvPHuQQpKI1UKb0RGCG+UTDNfmcH4xj9ZtH7o1ZdbZDw7cmrcU=
Received: from BL6PEPF00013E02.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:18) by CH3PR12MB8076.namprd12.prod.outlook.com
 (2603:10b6:610:127::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 11:47:13 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2a01:111:f403:f903::3) by BL6PEPF00013E02.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 29 May 2025 11:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 11:47:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 06:47:11 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add more checks to discovery fetch
Date: Thu, 29 May 2025 17:16:55 +0530
Message-ID: <20250529114655.592455-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c865fe-7c18-4fa3-8a46-08dd9ea68d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hqPcIUpr0OYOR4sZ05DxXyu/zI9GLPAyvvUBaBf7VQq9GSbiSm6nAb0Dcupj?=
 =?us-ascii?Q?DMOD1wncKre9lNvnQeBwqODfXO45noUm4pYUcE8wbrRUkvHSx7I55HZMgHn5?=
 =?us-ascii?Q?dNadPkdwT36sxBxoEOA1gBHJvj0fFhXTIOUCYWkCxQxDp09PqlgE4S4FloeE?=
 =?us-ascii?Q?7tGRfsndsQK2TXE71V7IGC5LIogb5mmxI4rFidr6d7YEr85G1K3LyHqZVaBU?=
 =?us-ascii?Q?dQA/aiVTffqQFh7Z1N2Xy294dFMGHcAbgjye1jVSaRS8+0Um95cjU16dqlra?=
 =?us-ascii?Q?PpeBLaQCe51x3Po+Wc0zwBI+9eyh1+4uoCADYh+sM8vDSABwgrL4T0UKH4Tt?=
 =?us-ascii?Q?Q6MO0KQ/WOUHxrDUaoEEMTmFrewc6kQqqwE710zslfBNb60j8b/NqDzUt7YD?=
 =?us-ascii?Q?6bsEX6PgSugYuCs9QiTrY6EBfM2ooVlAnB2lRUxY3ubZNATjK/A0iEsTXSTK?=
 =?us-ascii?Q?Moo1DMYqbxVI+Ot6WJjM4nRkGxg40+hertd50xi1/dEnKV2xGPFh4cXElTn0?=
 =?us-ascii?Q?8AzULuBb3fotS9N/Ski4JDMwxikVqHa5Vn0U/Aj8HgiXaCmAol3gwNp1Glm9?=
 =?us-ascii?Q?Dx8VJM8Wsbi0kRhMSbHwOOzHlnGZuJodKY3vpYukv9A9GIYail8okFpuBHsF?=
 =?us-ascii?Q?gNwBoFU7rnrleydYMHQIoyQCxuAVxuTME5a/RQV44kndX65ipmgEkWVLDZtq?=
 =?us-ascii?Q?AXnojT3Nmxza5hr/S++/HxD6T53YathrUTikgio3qBG5PN+dNnMr0VwR4AyE?=
 =?us-ascii?Q?95WZgwCqvxNAUgayeREhRgDuIUhU3/bdXKXZrRhK8Q3E7DVvPmDkC3YGMdaQ?=
 =?us-ascii?Q?dTL1cQqMz0P8G1F5PRalyU1UeQvk0dyxD5GyaBendyOVouW+6rpYCPYfdzuM?=
 =?us-ascii?Q?UD/D2ogFOPSERwFyO5k9rxB5MVoGhXEUqjSg+9NsZloTYTaKS9XiEZR1K+Oo?=
 =?us-ascii?Q?zmQ2V+NgvWw/irg2nuMiuGymrZ06QWF59uzp2s+46uuMH6c82W3nY7qGhTIG?=
 =?us-ascii?Q?Cyr0AaJDMRMbghzpS+a/ISndBG0WCI7MbC8QVn+TwtO9UyQCC0XPyEEKsybV?=
 =?us-ascii?Q?+kou5ktFoLsryddrhHkFORe8dOTXvFvxuu5sOJjs73ze8+QP3/fsfDe3JUdf?=
 =?us-ascii?Q?of7HpJ6ld7nwIPdlrsFax526sqlPCnjC19olcpbMLHsu7pIeEQCC6GNWaMzR?=
 =?us-ascii?Q?axtEYtnbXMUSOzJCXBRKzm5IktZR4tjQKq9JyRcT4gEZ2ONLo+B7TMbxrDTO?=
 =?us-ascii?Q?F65VRBpG8wV2mUN8TPtdbCSZ9urcbJ1Ss9cU++Zz4GmHSAvxvLclI6uquyvs?=
 =?us-ascii?Q?LYtvLmVq3BcVO8sxHIGEGo6Nyqrk/j5BSZXbAkE6wGBgN02i3eteojJK/LZw?=
 =?us-ascii?Q?R0w/Peg2eBJDq41ESVIVlWoYEw3iit6UvI2p0eqs7+GRg35gdVRmFOrdOWNx?=
 =?us-ascii?Q?KcgIrru9qtnXB95zJETOUNNhYjWPpIwLlBqyJeWwjMDvPnEKM41seUJdYSBs?=
 =?us-ascii?Q?pFME+g8OqLGPWtA0VezfFO0SVZhkmMYISLYL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 11:47:12.9776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c865fe-7c18-4fa3-8a46-08dd9ea68d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076
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

Add more checks for valid vram size and log error, if any.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9e738fae2b74..a0e9bf9b2710 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -270,9 +270,10 @@ static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev,
 static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 						 uint8_t *binary)
 {
+	bool sz_valid = true;
 	uint64_t vram_size;
-	u32 msg;
 	int i, ret = 0;
+	u32 msg;
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/* It can take up to a second for IFWI init to complete on some dGPUs,
@@ -291,9 +292,13 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 		}
 	}
 
-	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
+	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
+	if (!vram_size || vram_size == U32_MAX)
+		sz_valid = false;
+	else
+		vram_size <<= 20;
 
-	if (vram_size) {
+	if (sz_valid) {
 		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
 		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
 					  adev->mman.discovery_tmr_size, false);
@@ -301,6 +306,11 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 	}
 
+	if (ret)
+		dev_err(adev->dev,
+			"failed to read discovery info from memory, vram size read: %llx",
+			vram_size);
+
 	return ret;
 }
 
-- 
2.25.1

