Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16ACBEA7188
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Apr 2026 04:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6687310E054;
	Sun, 19 Apr 2026 04:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="weCf3FPX";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56AF610E054
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2026 04:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Abw+FbLWBrIrMi7LW0PD2mXzUcC52vWRb6y2fULuuofcH6AuklFQg1nafNOOLRlMfgxIoj1ePMs8UAEEjJFbBm+aNibCFKRT6EjGUeusMghI61hqvqRNXYeI9GI4eUuKOyGXwzvJHLh7mqFISMncA09tra30D7lFUG2Vr6sXrm1l3htHoV+00BKq6JU6gPWxA83hxC36AytRIPHrgQaMkYSDmT+GDVWc+3gCdUfzn9ORbpCWb/cHVBBgEMg4w2Sd12q9yzwPKpjvWI9Q72tH5CA8ySHqnJYbBaJj0hLKwclxgNLBImgt20PcROUugG0v1ClBX21sqZfSyL8JQXQXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtQZ4fvCdqMvoMZIHtd3XpHywmoRwg27TatBw7UfdNM=;
 b=JdjiHPLHH4oWNYFlrb1p5Al00r/WiAQ8SAS81HfeVO5oHjH+IhBm6m5GLDR2ILTHmnhJACuNPCmVEwNxtbfFoAOsvXB3aHNLHm9R2JK3RXXQOLrmcJioGdjfJ3ENG/8z4NFjVaL89FnBhkgrqa+VTbYuQYDO36tHEAoDV7c+WoK3BQcQeKjH3pLyC0a/yA1aZG3XIqqVxyCjKLU0hvN6xidBrfc33pZOu7twyDbIRWdFL1QVSadcCHdZiGe9oPkNkF5MwNglG5m6ogKQ9/A5ZJX0gXEbDwYDW33+kINFBa0kNpdMVJZvumCzKWmMTlHHVnEhWPar5agevJFCPjVz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtQZ4fvCdqMvoMZIHtd3XpHywmoRwg27TatBw7UfdNM=;
 b=weCf3FPXlz4E5z3gjNpdGR6XrYwqyM/KZ5z+0sln+Td6D7AeClVeaB40NPkucDraynMewVnYqCsCyVQEMNydNwJaxB4rJxL3wL/5Ez31Uq2H12KeghNacZbgpQpH7lT+OTI5JeURiwFlyOf7SXEPhYEP7D90UUBzj0l/ETD+HFk=
Received: from BN0PR04CA0148.namprd04.prod.outlook.com (2603:10b6:408:ed::33)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Sun, 19 Apr
 2026 04:17:06 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::a4) by BN0PR04CA0148.outlook.office365.com
 (2603:10b6:408:ed::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Sun,
 19 Apr 2026 04:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Sun, 19 Apr 2026 04:17:05 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 18 Apr
 2026 23:17:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Adjust ASPM support quirk to cover more Intel hosts
Date: Sat, 18 Apr 2026 23:16:52 -0500
Message-ID: <20260419041652.17673-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a10561-5731-44c5-783a-08de9dca83ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Rz+bzqGS1AsylBqF8yZReWj+vphhBtQhEZPIVqdK95Ukkju1smyD6zJUNwqrW8T4jDNfHfcoK9I78oH/pcSr/N8FLVy++B5jZzR7kLpfss3FPTAoHB2uG5hP0/W74SAkaB8IiE4A/pGKzU3ckR5tOdPFt4Msi0q0Pr+lYe/WcqyVNF+ZLwQewctarfFfWk8yqsinfWW0Q1qZfRbDF0wMzke3ucMUp7DJxgVPHCsLMNUlKfE9s1NiRiMrFKmsC/uh2g+6k03BNfgCis5H1FuRIOxJjgFPZz8uuJLzmuxKzv6X35j0Cz+/Sy09OG8Yxjod3dnOLidHuZXqFYZIapSJLhkFZPyTmTpXpufoZqH4bVVUvpBAdLa6qgXM71h+bP0Y/ikdK4+ICZbhScUU3oWSdrYgzOTi2QX9hfCpeXRgr/6Eywht7vW8o7uqae77uwagiqq5X/wneRFgZNKgKOzAc1TDECXavxuT9gG9HsarEmSfXuou9NURFDpXn8kR0EXNmvMIYyls4o/Xa4fEk6RGDOtKXxI2kHPGS+qTsRGgj1lNDdlHTyj9SJALQbdv12O2d8wpywNW0Gfonat+Qe7yAe1RRUoAuTFychMc4dD7oh18/lyM928DzF2Yb4PkLUWEnUFp6ITTpVTj1x9kvbMge+3+PqJf12yNQ/3oWIL/3S959yE9lHxfAyk6TuNBBjn3xhPy1RwGo2tXWgvRWNSrqdMmEWr3VSKxibrmjxWU7JE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zdg+fBsHHheUuiAbdgZI+cODm3wY3XC89xwlSzaksfviCQHDDYdTr+Fk4F+hUzR9d1yv8f9Zw2RzSCDa2MX5utILCP6PT6lmUdJfy0Q1vre0UVwurG7kfVZupEV5WyxUFQtNknYnzyzBilVbQDa472C5VGODBU4K/2jQtNqY52O3VS3xBcS+UyAki2C9CJEQK4DEznS/orCKkDTW5yzO/NNT+jMyW4l3GRMsiK3U9byQ53aU8MNJsoxkqw1u7zs3H4hfz/zaCdPcD09ar3yCxkdgZP4gPwplpHoUOOfivHDJZv65W/BG5RfjZA5ScuPzIMhPcWZSZME6IoeSD0X4d2JJvAapVDBTEARxiU6+bUKqfX4J+vGpaxIHz2p9GqUGnzS1sTqef/eVoVP5zVxRcbQKc6dOLUQQXFOdLHTNX7GyPYE/9v9HlR2DtFSOWEAo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 04:17:05.0523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a10561-5731-44c5-783a-08de9dca83ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
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

Some of the same issues identified in commit c770ef19673fb
("drm/amd/amdgpu: disable ASPM in some situations") also affect
Tiger Lake systems with GFX11 connected over USB4. Widen the net
to also match these hosts.

Fixes: d9b3a066dfcd3 ("drm/amd: Exclude dGPUs in eGPU enclosures from DPM quirks")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5145
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bc7e96b58d3fc..b11c4b5fa8fcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1334,18 +1334,15 @@ static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
 #if IS_ENABLED(CONFIG_X86)
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
-	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 0) ||
-		  amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 1)))
-		return false;
-
-	if (c->x86 == 6 &&
-		adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5) {
+	if (c->x86_vendor == X86_VENDOR_INTEL) {
 		switch (c->x86_model) {
 		case VFM_MODEL(INTEL_ALDERLAKE):
 		case VFM_MODEL(INTEL_ALDERLAKE_L):
 		case VFM_MODEL(INTEL_RAPTORLAKE):
 		case VFM_MODEL(INTEL_RAPTORLAKE_P):
 		case VFM_MODEL(INTEL_RAPTORLAKE_S):
+		case VFM_MODEL(INTEL_TIGERLAKE):
+		case VFM_MODEL(INTEL_TIGERLAKE_L):
 			return true;
 		default:
 			return false;
-- 
2.43.0

