Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0313C7618A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449FB10E610;
	Mon, 20 Mar 2023 17:38:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A4510E60D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnXhJxFBsZOgMTix9bA2vj/fhAYKaT3GCeDEeWVgz6fPlQ7EM6oakiM6Rl/8rzz3iowRax1Eh47tabyZ3dDIyhLyuM3cVBa6Rhk/8B1qyMqdDqDKyJgwvSYZSJn2jlNgBL1HHUwDKR3yde3Ro3hbMSqYR12gwE27vR7Xt73aC5QJXOWYd0IFCts0VzJ4zHPvzA/Jtx2HwGYfXAf/xs+X6/OBli73LLdbjIYtPADPs38/v3v5d77fZJKB+HZXIH93vtHR7XRaIsVQJlNzSfkQ6WUdRwqeqO79sFAnRWZUDjDAuCsRgiCSUs6NTn8vaPExFljRFwu6KXTZYCCpO6yrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hLMtGowbb8uRR0t/vYCF4NCCxECZSVs8T0+zC0Pzo8=;
 b=oJZj7Z1NpQOyNvfAQXlwpBlZZVnfgguP/+9D39hzPZnrCQYkF74FssxifUG/wFyr1qQdIn/2P8EHLfg0re2KsmB4Jk1ZXapbVhOAURXj8cSQAWbOtcl9V1Mq19GoTOtPFUfuF9HU9ym9bUx4LqGAbvlgXOv2B47H4r1ATuxt5cHZwS/r2bEmmlyN/L59xTwzPGmoSMBV8pj7r48W0V5pyaJvGLM+56Wl7PXK82STPcu72rHoasZTjKiA2tmvngbRqxy1chvE66qaJ/Scj0ILZJNql666yIt8lck/YWv5hMWmQMLnt/Ngo+YfC73WQtCh4kUjm4SAE8NylxyFjUwgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hLMtGowbb8uRR0t/vYCF4NCCxECZSVs8T0+zC0Pzo8=;
 b=ZRFa03ap+t/Drx6PAqg9BsM0vp7Gp1PmTw0ObkQsPranDDbCC+t4k5RYbox3GMO5VRcVEE1khbIZ5kj04Yt7Gt18XQQeur/rjGAhPzgc1CtcnMjfOjJgrlPUuR+oM/WTwhnsrP/cWUBPUUZy7Ut2F+zLpFPj1PqCuUQMtDjAiUM=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:38:24 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::29) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 17:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 17:38:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 12:38:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amdgpu/UAPI: add new CS chunk for GFX shadow buffers
Date: Mon, 20 Mar 2023 13:38:02 -0400
Message-ID: <20230320173810.250835-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320173810.250835-1-alexander.deucher@amd.com>
References: <20230320173810.250835-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4d1667-d618-49c0-9e79-08db2969ea7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDbKAnzw9LA17gA92bpsilOMT1ToDQg8SeP+ZsuQgOC9SRcoatUiD4WzJYxfo9m5l6aI/zYFYz4WlEgaRUFUQmkLrov1cnczg23mXX4nfTdmwn4kKH6r+x0ZhEOz81+1ha7SP99uAttLEkfgPu8oZRgqkxSAkv+0AbrPmGIJ8Lv61PyxDa9mY+H4STKr/qtejKi5Aquy3s9L0J4Kqugw4TzfyexHRr2NJWuM+GyQ4+E/psRhG9wTnieFX3K8hg89ViI8pcjK0pKcp1bC0mvF0HTWGkVhTAII7TVVXSZP0yvuvlvNrT5C4OX095jQw7HMv+rWX/Yl+1MSycNmMyLk2xrz5n3rz9voO0S7LiQwLCtN7sE/c6sZ/WyvaBDG2x/tFTuuiArq9E7An0Ys1bPUeD4lGkh6lacawhbzzz/dRNmbHCuzPrzFC/84h4hteSWO9jbM1Elwbkl2phWKwWyMWc0R7oRGQ7mgZhawmBH0posFX6071KJT3MG1iO3leOYJGuxiR+E/8u1LLeVzVoguQZPObtkKR80X5X0TmmPXuBLXluG8kfFTIheK45oqpT32t0yTklx5mRbpFlrJGoyyQYztOrvfbHRnoxF+tu0UMKCIPRNJWqXJpJ4QsJtau55zx4FWJHekMTgtWWSEUwPsJmhxvjxJTyKDIfvWGapztRQBBG6hq/yJLB7xk3NtzgwB7J0b1Lg+i/ifsbbhOuG6PfDC9jVAiHAf/ECJQVhJt78=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(16526019)(186003)(2616005)(356005)(336012)(6666004)(26005)(1076003)(7696005)(40480700001)(426003)(316002)(47076005)(81166007)(478600001)(2906002)(40460700003)(86362001)(82310400005)(82740400003)(8676002)(6916009)(4326008)(8936002)(5660300002)(41300700001)(70586007)(36860700001)(36756003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:38:28.3613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4d1667-d618-49c0-9e79-08db2969ea7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113
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

For GFX11, the UMD needs to allocate some shadow buffers
to be used for preemption.  The UMD allocates the buffers
and passes the GPU virtual address to the kernel since the
kernel will program the packet that specified these
addresses as part of its IB submission frame.

v2: UMD passes shadow init to tell kernel when to initialize
    the shadow

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b6eb90df5d05..3d9474af6566 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES	0x07
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
+#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
 
 struct drm_amdgpu_cs_chunk {
 	__u32		chunk_id;
@@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
 	};
 };
 
+#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW         0x1
+
+struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
+	__u64 shadow_va;
+	__u64 csa_va;
+	__u64 gds_va;
+	__u64 flags;
+};
+
 /*
  *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
  *
-- 
2.39.2

