Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7352AC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 14:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084B510E30E;
	Thu, 19 May 2022 14:35:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B76B10E30E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 14:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKFp94t+ZjGF+ODPCJ8pXkfXFFP2nHMZN+vpu+KL7YomdFC9J2TXTfgui5d00ERmZ9J7FIzS2Q7fJuqBXTTOFcyqo2vd619sYeL3mzstyCkiCKTb3D5q7S449mN50AMqCqKTvROd/Z8tpBTgF4DxneYheHmbnjVdsvdbreLSp/pEc+1qzBqelKzLHey8PzuYM1BURWn7dpi2iWQUOG3/ZHUtOl8jHXcvnqXyj8nIDDeQPn3v1KOJXqahUdSPL/Qh1ncjNv6brfJhWaiBIsoJO3Nhg5bDj0PrNVEmptlUmZ44vs87sg85RgP8RbJ6ZADsB9o63fHHQMfObCFH5WG4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icoZA2cjdN1s/ozmej950ugOGbE97Zh2dXstDE+QEbQ=;
 b=IdizDd+koE24i2KNlRfqsPU13fC0MxvIjmVXpQ2b/kNRHG9sKE4dBtoXtAxgIXMKSvh5DlAuhaBP/kX7DkDwmHyJRiasC6wBTakOJ/CwOY5Bzaudqu2LHj97EjfSqZU41UTmHl+UqjoHr9MLgPBkXouzf+EqF/rRzcQJcarWyxhpXiANsCEtlQsILnnt9kSoksZfeO4eu08oBGOUL2X7WTvsfs3FwEQ89XKg+NWqJsVbTlfLNOpTIZsUY4J8BndLt1FpdDV2iK8UCAzy2AHDATPWzHrXsAhsherfcbVsEOQqxZZGbbMsIF4AmRWm3hzzv3+cLkjOYFKCWpUFCxUVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icoZA2cjdN1s/ozmej950ugOGbE97Zh2dXstDE+QEbQ=;
 b=QoMSx9aFxXjUM9BRWN5C/BSN5n9QB5bSoLHh8hskStmuZhkQmCL9ehbLlO6SLJ/ZY5gVtpqFV3ug7FPlNhaqH9iDcymkFAO0UexMwXfI0lymWJn6ZP3akZtEwN0jsrAEMR51zUK3OoIvzQlttnU6Y42q92m+mHXspkaFBQALOAk=
Received: from BN6PR12CA0046.namprd12.prod.outlook.com (2603:10b6:405:70::32)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 14:35:00 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::ea) by BN6PR12CA0046.outlook.office365.com
 (2603:10b6:405:70::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Thu, 19 May 2022 14:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 14:35:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 09:34:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Adjust logic around GTT size
Date: Thu, 19 May 2022 10:34:46 -0400
Message-ID: <20220519143446.74326-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7948dcad-a6a0-41c6-8a24-08da39a4c118
X-MS-TrafficTypeDiagnostic: MN2PR12MB4535:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB45356FB8D99AFC9769EF19FAF7D09@MN2PR12MB4535.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ck+u5CwyKUJCvV00TB9onIzwfAVs5k8fv/oU/K/gUnf1wv/zTx1oZeQdCKI149Fm1jU9vVMRLeeALcTdtM/6+Cj88nkRB3bnb3Qf/QLrzIcScJc8t27P3nm1OnMo+m+Uc6XaWSrzL2a5fvnfwOzA3jvUzkw5blh4JPS2GX0nms/F5PwRcVZA09dPZ0XvNifGuRAk6bAiYo9nqVrH0OTmRAZjWQvCr7I7XvLOd/zD0TFnP+2y4WzIRTLJYmN/4ubeVcGJAttCKPUIT30Jqup8leVPRrks28RlGptwbxEi6M2+cqlzn3U8jN6BhEsv8G855IRiXyHonS1wefpC8A1gh0lkRcUOgEnub3nBvzq+Wu4gwxCEgtbUW0EL3Vm5vbuNJZ97kYnMKh9+xo89A3XqD21FOY5LUJNialkmvCcgTKcf2wVOzRnCRo4qmFDcq9l55c97reDhZj4XZmNRCY5KDshO8hKvf/T0LSs6M6Th+QPLDV++MTfG7mtn+6n4K8MToJy0vUB4bS8vXft13IYXbHPBKwQ28sVGeV/IxBSyDU6dp5UgKs2C3oYtlfLRPGyHPCPBD6VdF/f47tljmOWMO4CCH7SYS2BZe7dimdhC7+R67DUWOYm8BD1th89QK183rcgjDi+z5eluTXNiZermBE0HBOSNN4hcQgzwc8MgL6djs2BFQGyYTMko26zLvlpuPAZE9xeE0hVlTwOh8E6uVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(81166007)(186003)(5660300002)(7696005)(2906002)(6666004)(2616005)(1076003)(4326008)(47076005)(336012)(83380400001)(40460700003)(426003)(26005)(16526019)(36756003)(8936002)(508600001)(82310400005)(316002)(6916009)(8676002)(356005)(36860700001)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 14:35:00.2752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7948dcad-a6a0-41c6-8a24-08da39a4c118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The current somewhat strange logic is in place because certain
GL unit tests for large textures can cause problems with the
OOM killer since there is no way to link this memory to a
process.  The problem is this limit is often too low for many
modern games on systems with more memory so limit the logic to
systems with less than 8GB of main memory.  For systems with 8
or more GB of system memory, set the GTT size to 3/4 of system
memory.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4b9ee6e27f74..daa0babcf869 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	/* Compute GTT size, either bsaed on 3/4th the size of RAM size
 	 * or whatever the user passed on module init */
 	if (amdgpu_gtt_size == -1) {
+		const u64 eight_GB = 8192ULL * 1024 * 1024;
 		struct sysinfo si;
+		u64 total_memory, default_gtt_size;
 
 		si_meminfo(&si);
-		gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
-			       adev->gmc.mc_vram_size),
-			       ((uint64_t)si.totalram * si.mem_unit * 3/4));
-	}
-	else
+		total_memory = (u64)si.totalram * si.mem_unit;
+		default_gtt_size = total_memory * 3 / 4;
+		/* This somewhat strange logic is in place because certain GL unit
+		 * tests for large textures can cause problems with the OOM killer
+		 * since there is no way to link this memory to a process.
+		 * The problem is this limit is often too low for many modern games
+		 * on systems with more memory so limit the logic to systems with
+		 * less than 8GB of main memory.
+		 */
+		if (total_memory < eight_GB) {
+			gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
+					   adev->gmc.mc_vram_size),
+				       default_gtt_size);
+		} else {
+			gtt_size = default_gtt_size;
+		}
+	} else {
 		gtt_size = (uint64_t)amdgpu_gtt_size << 20;
+	}
 
 	/* Initialize GTT memory pool */
 	r = amdgpu_gtt_mgr_init(adev, gtt_size);
-- 
2.35.3

