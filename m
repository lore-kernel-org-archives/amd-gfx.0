Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472E6C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 14:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248AE10E221;
	Thu,  9 Nov 2023 14:42:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0423F10E21B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 14:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft9czZ1idWLn4SDcIgBB6EQGHMxbHi3H4Q3WQNIV+QChYdppUjflzgouFhsdBhSw+6t3ExOGF2aeSaKLOfHNYYpFUUj+6UHP8CLQ4/uLYEy5dk+xdU37eJw/4YgXtcZdg661rORFcXQYr+YpYv2lkw/1uJzCeeBhWXU/ttTWtI8fGZdEiukTVw02OGwb18IqrDFKR+IZFFPn4dqX0BQaioviQo0VJuRCAR8ztzlnQNVzk0kuS4FO0ZKNx0M8j/WNhu7wayzCcymWxWEUfb4z17kpXSYLk5B8Fk2ddCJNt3jHXqy0HWPdKcUO7gAjQTnYTpTZ5934q9TdpqXA8FD9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAbnx/IvtGuE0EG18CXOwDE9m1M1n5mm9iDjdGNXNXU=;
 b=IFhYChI6sqoYB6FIk0MwfiunQ63w8E7kuzumnOMcbEtIsBRUTNAAdJ6T5VxlP3l5/lIhk7CSndG27yBbr9x+kzWcgyEwbZllQFnSr0ji92iNW0FhPQZF4h5i04DN8Xy3+FW+mteXrnpvZVk+y72o2bZmn4LE5LD/hz51lOiQHy5vJx4aqJwIPE+j1CU8+C8PR/UyrTAozo40WJE6kgebUI4+GQsaadoODsWtj7nvjGb+dIPn2V75y1+3y+XAaMeDPyPcpD8R9+K2WOsZXs4wXqleKNJkIc2uOxHeA02+rt/sab/muPxGmFU39zqfm+FJwZVOgHSi8NGphnLntTYtFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAbnx/IvtGuE0EG18CXOwDE9m1M1n5mm9iDjdGNXNXU=;
 b=0vfF5VDv0jG9b3BXLp4EYPO3DMrrEFx0vg7wMQcYoIL/6jz3hGx0aqMmhv6LLYliXrqHj1Jkjnj+/30KIjNNTY08co5sADDCBJQmixWiG6z7ESYT4/+tBiLPLigrUBtWynOWyMuF7QwIbhMOVUmKTY/rIxp4FYjckN3iQYi4Ym8=
Received: from BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 14:42:01 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::b9) by BL0PR02CA0054.outlook.office365.com
 (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 14:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 14:42:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 08:42:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/gmc11: disable AGP aperture
Date: Thu, 9 Nov 2023 09:41:41 -0500
Message-ID: <20231109144143.502132-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: c19d04b5-7475-4262-8700-08dbe1320883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32i/keKRXoA9hW9xlwq74V/O2ARQ8aR+4zVvl+7Au/HtCTqd3zbF45rtczzwvLztiMPOjufR+Lk0M9e5T53NheSL3uBMzqYLaqS1n7l4rwquJA4/uoI4qiBpuYMAeYqMSBheT2o/6DIbY+LkmCzmtbhUcQVBxQpKLDGXkR2uUgFLrbInCQSD+g1YC/VxuD9rPTWbIiFw5K6Iw3VdO9Yc3HiwvKcmpryDIoV2KqdvhrDjVaFHm3A3F7msQP2JGCEK6A0WBwXJmvz3PK292mYduP44nwUUH7u774xeRJ4eiDlLhIlTMt9Ghp6pKMi5AErzpIo2PzZf1p1ORhSVKeOxz3FrnX27q6auiPjC6hzPl/iOaxnWyLdec0kf8+xT1ObvqHOTY3zF0JUvB/HV7omcarBMlFSr4Jv/urb8OpxXZ72jsEp5quz6pW0XT2NvLBQNtJ6vwWBezw06J/mV1+ommkJBk4DUqOIDliVtKgPyqfFRfJFqr+lIvajkEJmtlVKGrdqVYp/aEAHBzazAD8FIjJzUoP8+BDxB+QMonxoCbOYNVur5DycdtsY9JgWzAT6JtaNdibyTPN9snLFwVwbrZc9JJZ6SWZF9frkpHwxMmfy23cF5eVa+4+gd72181GH4+i1Qhas0ck87GWEdR3Eii6F8rIHbS8BRcOSgKs5uoE61CrHcdkQca42bCdVhbLcC58lIz/tMQTfeyB31UxLP+MlqMLGhINKWAGJcskHxJy08R2nQl00Q+1VlDyINl48ZNt7mYGg5NO2bivt/6Z2URA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(2906002)(41300700001)(4744005)(36860700001)(86362001)(36756003)(6916009)(316002)(70586007)(81166007)(356005)(82740400003)(70206006)(1076003)(2616005)(26005)(16526019)(6666004)(7696005)(478600001)(83380400001)(47076005)(336012)(426003)(8936002)(8676002)(4326008)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:42:01.0040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19d04b5-7475-4262-8700-08dbe1320883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
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

We've had misc reports of random IOMMU page faults when
this is used.  It's just a rarely used optimization anyway, so
let's just disable it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 6dce9b29f675..e1cac5da9c4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -640,9 +640,6 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
-	if (!amdgpu_sriov_vf(adev) ||
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
-		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
 	if (amdgpu_sriov_vf(adev))
-- 
2.41.0

