Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09923C5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66DA710E1A2;
	Mon, 10 Aug 2026 03:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JHVxfNEn";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC6110E1A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rY9+q/8kiGT34RoFblTWhtQXLCM1TBmVX6kUW+VEDqnavI9tJ0PfocnKRYUYFU714m3mU4jsfbSiNPUFhPcr86RjzlKD0dRRsCPO4g3jy1YL4qUZsQtcY+Vnxar6WCijnFWirmCS2CiLgSFEHKLPCLIraK4gcHReOg3NXvTI+rQHFf7Ob/dRrA7+YEG3ziW0JBZMHFHpL9UmHqNoHVk7UCxeFISR91hXPLCmSc+Bk6rUpc2eiB3WyazTy0pOgiNugG0BPfVHxuhjJYM6RxklXN8NTPOeANJa20tl+KBUjbzFQ52qWbgtnmJCIdn8VQK+MmKFEcxz3w3A/DmhV3RX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0+E2py/tIMqB8glpCs2CpLh7aiou2x0bWpiUUhoNEk=;
 b=sD3Ld8iEX+kHUQWyqHBs7dbQhsXYuV7DvjoC/pia/WjPzmqUplU6q6OiRUfrAKxnT0z+qzfwffSXdf4wNb+jQBvj9Aik3UJSmf1nn8jmJRA4aM/uud1965YsJM26QB9LeSOmeZfHuRFJ/qabrf4guk+bHZTkp8lOLEDcX696vpGbUMyxz1fanBash+fHouqewofef0Yzt3KiMUBeSILvNifNyE7pjY87i5zBbClzyf1ok65DwoGhlQrKOk6vtLT4LUSN7sZ6g4PZRYjo3ROkqeKd93pOaH4bjiCZj2AZiECwb0aCT9w/c98Qf2SkV97Jn4K3EWexTQR7sLOlq+Urzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0+E2py/tIMqB8glpCs2CpLh7aiou2x0bWpiUUhoNEk=;
 b=JHVxfNEnlHSqlX4Y1KBy1TVC+8xIjJieqGuN90TB0N+IChnkvdVJ2076ef5M179imFEzTkuRXwhAICpxZM4yk92N80pskLCRUx6c8NdR7rlgHZmC8kqRJ4LeqWfKJa9lppPho/FexXm570Xd8OKHgkrfKL1JU8zT4AZaJo5jAVM=
Received: from MN2PR15CA0040.namprd15.prod.outlook.com (2603:10b6:208:237::9)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:56:58 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:237:cafe::aa) by MN2PR15CA0040.outlook.office365.com
 (2603:10b6:208:237::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:56:57 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 22:56:53 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>
Subject: [PATCH] drm/amd/pm: Fix uninitialized mp1_fw_flags in
 smu_v15_0_load_microcode
Date: Mon, 10 Aug 2026 09:26:17 +0530
Message-ID: <20260810035617.3818797-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5a77a5-08ab-4274-70bb-08def6936c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: zJTytGK3Gh5z6fYoIoUv2SC/t80RCwoezmaEjVFrSjsvLx6sbjGg1FqBfRNqMg7Xfho0DODG9mzA0gvUS9ccKripBFHulIMbz0hI71om0h2wmgb5pnXNNKPOyEkL7BrH82CCvf5Gn/gf4CAcAcc8GNwdzpQt1SH6q1k4qewLyD84UZ9BDLs7L4XDveKvdlfpnJ3azRjklbK0zmS7t8pq2G8i+E7/ni5cbGxdylRA7NLOVyOCoRB9dvkPKiFH0pHPoP8FI3CVpn51ckv4gwdVNUJURD4eqNTFNtqBUCx/av4UDt+DDejDzwjW6s/C3IkDxiwZVLl3RI5vHTDCw3agjsQIfMZk8HiPmq4/6AABXGoBNu784Wbs9yKwDOQgh8uEWUzj7tyuwj1EYocdG1zgW766mnMOUtdSUpiCTkpWGrB3TISQw3TZOLveBUT3otDzXJspQdYayQX69gZMHxuvLu8Rl7mQ61LRrqTyR8daZpnKQ5kBwImoV3yxVROrUfQYpJfOuEcAmnGlgt3SX2QSzeYo3fII97+uuf+dOLLPL2mzXmlDORUlM+D52JwSBsbn1hplFNCa03BN2fkinIHRhCQjnasKF9TjtJ30YHP79kTUrqoXntHWyAX3aABq/ZnOIBspxijlaObHZ0dNSwP1aqc8Nxr1az4FzV1ZxYcgQt5ft8zIQSzLW544l+qgcLXnK9CpjsgFH4x9HZoboLFAvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XwrejqTzPyUdyqKjkovq14Y1slrAGoE78ulL+f6vh5kBuVfh66RM9fIIFiTTOQhP58rTJdE4BRiu5/zENKIwyc1rP9kBAMIMnSwowVcNUtmwiQbCln7LfXW6KzDU3ccqE75JFL+vLMB/ZLIjGWqI22Rwuckbv1QssYRIjg1PeaCG/uAewoAMQzeZUf1y+dSfHPTIQW5RNw2ecd9rPXr/1K84/2FEe7qHQVJ2X9IMZRAk3CRXVBAcOTw7eb6HPFOwzya7PDepVe2Yj6vw9xF2z/Wc/bE6eXoEesiKH/C29aYoO9b4TNOMPyvezP4zhRt2GJFr7cwR2p+nfy6MVSQ45ikdLbfM54d9XjNtl8tpnkyngDDt9mYrNar782FYBzAC6wnbmRdh0Xq4MNV+S+t4sYQiSC7oOwKYE5+SvQ58axKHOwc4wPJqEloOp6Pw8d37
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:56:57.4869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5a77a5-08ab-4274-70bb-08def6936c90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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

smu_v15_0_load_microcode() polls the MP1 firmware flags register to wait
for firmware readiness, but only reads the register on APU devices; on
non-APU paths mp1_fw_flags was left uninitialized before the flag check.
Initialize it to zero to match the pattern already used in
smu_v15_0_check_fw_status().

Fixes: c7fc0f372374 ("drm/amd: Enable SMU 15_0_0 support")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 4c0236196de4..f1182305d707 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -114,7 +114,7 @@ int smu_v15_0_load_microcode(struct smu_context *smu)
 	uint32_t addr_start = MP1_SRAM;
 	uint32_t i;
 	uint32_t smc_fw_size;
-	uint32_t mp1_fw_flags;
+	u32 mp1_fw_flags = 0;
 
 	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 	src = (const uint32_t *)(adev->pm.fw->data +
-- 
2.34.1

