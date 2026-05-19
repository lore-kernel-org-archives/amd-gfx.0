Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFBACD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD2910EE30;
	Tue, 19 May 2026 18:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5U6ztRJf";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD4B10EE2F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8Kx2wuBVpbycoNQ6qI1/UyFUUNkUma5v2pH4m70GtDfiWvMczAGqsO5qvdaL24SHCMSnsQnUVN/SN3W/nTXMzrkgLhztTsRw2oNGNdJaGL+O/wOpNIB1iChgRE02l51GkVl//e2gUc7qxqIqCcivE/5WGz9jriERNw1XkcrPR/PO2IXmxV/LPkh7ksGBJL6jUpq9qaNgBVqaXRyy//2u+XiA+lRmK3SIDj3LZWSDp4CCAeLcj2iaUia3etBr00Z34ne2ZCGs6tixBR8+hWruSnZo0kUaSlH3viAVBF+4O+Po8+8t12SbfrVDB/9Y4Q7qPJlnDLvcqhLSziN/JsPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozWPuUPXlIYFoUnOGBkf/37/XiLP3RhlSMCo91FM5vo=;
 b=jAKyQ5N7JUD1CmGw2+EGwHTNsbrIAt+z74EqPW0XOPNgfG1AjWxQluRz7A4kUqU52sa8hyz5TiT/Awbw05Kctwh7xJ8AjEcxrsQnRT0FsH7aUdIsRmmRZCFF6iRbDqmsp1XHVdaZo1ZeO0Zg0GRU4v9vDf9qILqiyB3k5UMLKYsM5BijrOUkGJFMfqoE9lN3I2NZ6/pG/MrVSzSDZgvuHxyplehzGk9lO73Pet6ZRUJvhDZGA/a0G2PVMRsnHncubvgBRItFXABfZTk51dQ6IiVFkbUlvX5TpuWR/fQ3XSUZwOPqqC9itOmfeJTW7s0Ri4T9m4LSRbEHgUI8Ya60KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozWPuUPXlIYFoUnOGBkf/37/XiLP3RhlSMCo91FM5vo=;
 b=5U6ztRJfiox+A9BfuEDfPA3EP7/oqgTTgHwNupRmHU/g0WfelKgYaYL/xR5KYX94RJ5kkF0ZPFzZr+8x2dPjiucw0+S8WZd/eHYQLumBkj/EQ9YPnm2g0jGCgPncUkv/GkqRZczaTj2yRXYS+BneeHrI/d9Fr5KWsly4Z+Yzgzs=
Received: from SJ0PR03CA0146.namprd03.prod.outlook.com (2603:10b6:a03:33c::31)
 by BN7PPFFC4F04B28.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 19 May
 2026 18:32:15 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5f) by SJ0PR03CA0146.outlook.office365.com
 (2603:10b6:a03:33c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:32:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 19 May
 2026 13:31:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 May
 2026 13:31:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:31:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu/gfx12: only need to remap KCQs when reset via
 MMIO
Date: Tue, 19 May 2026 14:30:49 -0400
Message-ID: <20260519183055.22275-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519183055.22275-1-alexander.deucher@amd.com>
References: <20260519183055.22275-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|BN7PPFFC4F04B28:EE_
X-MS-Office365-Filtering-Correlation-Id: fffd910a-071d-49bf-e8ec-08deb5d4f29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1rGZ9Z6sJMwxF0TiXeRqw1OUnSc1yVrfjNB3aq6KQZKp5XKQ0Iq9NngAtacCdHGXF6G433UX4sUMchd1tgv2Fw9jZh5ozm2tMVyZAUyRvrUvlcsWCeZwmDK7HeutMnld9tpTJUfUj4Urqh0irnSX4gWr/WZBO4saPbivdIzNSOuK36Olvtp3TBvI+kEKl/xuX63+HU9KUrKN0Tb8oCc7CM4RPrmegX94KpzLXd/aMp6QMxv6KgIdwvyWVSaIiDZeBEoxe+lwYOA1obj/L1FHM0WCj0xzGG4XC5mn1PyWy4yd40IRLCGQ7SaMy5oK1AdnbtHhwdd6XGknp1hJP9A0/NXE4OhMWBogiWulMbTb3zHvb3FuhSoMA6JUAhdKPmkC+0TTL1J417cCP+tFc8g25IZyL5+r6lsb1bZuU7cSpm8G4LQvASNj4QzuYrrXJM26NTRjptFiOzlqqNDoCR1APKG2dddNr0PQLS6opGrZsq9hlhVSxjONPFft1mv5Ow/HaFlxJ7PwcKmtSZ2LdW0bgWhiKW176Cz6oFaSbu+lLbSli1P6PBbvVoUfQCOBRc/NyCuDbAS8tp9dJijzBMpsgmfKJqOCiaRRS5ALEejpPc240LFwGSxnfpDG63ELgBV9myj5cIEMFuIusjP4rpyTbZ+m7NIDsOOZPGzrJPZBeUTcVmljLAxAkErgZ4CUmJnJVnvWGtB9gh4x1kCCA5QNPhQPchAy7LtYNapoahGF/PQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 46vsWKkBgKmYD5UAcIkgrE+k5Kv4Rx+3vphj3WwATGmw1IZs09AKMmQ/lnGOyyvSnq/EjLcRZF7MmRS1wpFfjq7VRDy1neCFTCtXo22y3mjYc384UvRpW3Q0bInnphmBtfIj7GE2uUAqHgUOgfcwAC8EyKMxM6c40G/fg9BY6lCsawhl9d2u5yo8O6z2tWDS2CSo43BN1LJUuz8joYAc19bGUM3bzF3/iS86ejQ3vV1pbiWoakPbKyx6cZPVBqLdzXKI05CRORDT2fCN3u2ygtYlPf6CdX7sz2HWoZ06DXKaJaG7VA1HSdfEnaZtM32iXDfJNIvDqn7NZ87tUWxGqoALJ4DJptba1QaczIgvyhaVcje9d1F72vjbABq3Wlm++mS8aDVQ2cS5TYaK46GKmSlY3fRSQfFROLhvg+/EdLJfxLVcK09dr5/BRIQHNmo8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:32:13.9855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fffd910a-071d-49bf-e8ec-08deb5d4f29b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFC4F04B28
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

MES remaps kernels queues as part of it's reset sequence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f47928dcd8480..4be650ce1fba7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5397,11 +5397,12 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool use_mmio = true;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
 		r = gfx_v12_0_reset_compute_pipe(ring);
@@ -5409,15 +5410,17 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 			return r;
 	}
 
-	r = gfx_v12_0_kcq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "failed to init kcq\n");
-		return r;
-	}
-	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kcq\n");
-		return r;
+	if (use_mmio) {
+		r = gfx_v12_0_kcq_init_queue(ring, true);
+		if (r) {
+			dev_err(adev->dev, "failed to init kcq\n");
+			return r;
+		}
+		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+		if (r) {
+			dev_err(adev->dev, "failed to remap kcq\n");
+			return r;
+		}
 	}
 
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
-- 
2.54.0

