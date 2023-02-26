Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82386C64ED6
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Feb 2023 16:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120CE10E134;
	Sun, 26 Feb 2023 16:55:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928E110E130
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Feb 2023 16:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKNVH5SnhLR0Wz1yFhFgtvMBNaF2uVMdO4qNssFPFUnZtfF1qXC7ozCFhVW1NQwNFPNpEmoqmfAKGd7gr4vPifN9CVNyoBTjiTdNl/B3vlWY/ks/dhsohC22EecMgRiqjv49V8kapFnPNXpADUvHRyc4tW9roC2hJoS0BJpEOeOViQDknnluXhh8R7KKKOQtt7a7vBYXTV4j1aQ2uyfJiSdzh+G6kIhY4LXzi0WxyVUmrAWynY35jhd+mk/BOz0H59aqN/PQqnP5p1jXnFufzAUSvf2Wdh4PowVo8yXFSOdri+SMadVB2vBq7lpA5h37wQYakkOHO2qOhw8SEd68NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhH86rWWcro4ci4RS0Kfo9oR0r9xCBsnhZlTjejmyrQ=;
 b=dMUponlX+8rh6wnY/HNTDW//3TgJ985Jb6wkLmn3KcPQqKM9EUbzoqC9qhqUTI8QxTcflS89lPA5xb4zZQ/DfZzVRkCarj0mlCcokut33T4+3OaHvJdQRQqOSTk46FZrDBf5mH/d2nmbkLwOW777nwbRb9r9O5UWCGcdbyepz5UuyKyrOyBQ/Ln0f7hpzJhJaEc8D9ILvlIEJY+aNDiol6eWOLu2Lum5z44HVRldZqPjykfBrt3FxSt+CtU8uwug7ol2yYM5YaE5s1KQ4rUOtxY7sGIWE/KXRCi6ZBc+DtC4QpnTDOrFLQQRfZRE8A3E9XT+HVDW0MAGwNRgtexuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhH86rWWcro4ci4RS0Kfo9oR0r9xCBsnhZlTjejmyrQ=;
 b=s3JfXr142QPfR8R0iYnwhNdJ3dLhiXHbICOsbXHf4RTp3TwCfNaZpHXI0Zh9GZvyChhFS2pVnnAZ+ctEGE4hvZkTGfkTRyDZHgJDZDbLMGeUFTxQmJSuh/2pvpzI/JUS9T0XtOjUllx52O8SJpBLhGXAvExcM7VfSXhmI6JVqAM=
Received: from BN8PR15CA0030.namprd15.prod.outlook.com (2603:10b6:408:c0::43)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sun, 26 Feb
 2023 16:55:19 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::5b) by BN8PR15CA0030.outlook.office365.com
 (2603:10b6:408:c0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27 via Frontend
 Transport; Sun, 26 Feb 2023 16:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.15 via Frontend Transport; Sun, 26 Feb 2023 16:55:18 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 26 Feb 2023 10:55:16 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdgpu: UAPI headers for userqueue Secure semaphore
Date: Sun, 26 Feb 2023 08:54:33 -0800
Message-ID: <20230226165435.41641-5-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: d068c500-6b04-49e6-e583-08db181a3daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YN2EzqItsRxOzoeX5o9rSVJDRe8rgsdeJN2YWZsgAzsPI/prbDKHB6dWBO+joB/Sb8n99D/ewTk6uarFxBRFNb1jPfUZMFDx2ZR32e+0rPFT+vsLjPGqiNG9XSB6F2X/p3iCwv9OTSy34ifarP7N+5LgI1/HuhggBOSXKefj4jN9YMp+cQPxvgQtiwHeeuRBX41Jar9Qrvj6b1TsdzEdx6EmDiirTIIsO4IuOW6ieIOkrP6eqwGJY6o+gJ/wwyhq/c7icHwURk5HZWN+JyFDvQ2v6hfby0XUb5UxzCGK/zC2jQLgv/cvCuf4AIFk1GdK/2PZpgsQ4aBaGQnO/ASC1B89EJZfabeczqOLZ1qcFYXWW8vP9t2liSPtDlqZRZx+Z6tbPwfz8EqVjOVygcl3k/m2s5Aznu4w3e9MP6JTpzBrMhPJOaEM90w4og0nIfsr4HvoLSwIzgEk6f/X/UXjIIW82+HqINuFMcsb4+1eXFCZbf7xbKi+xrjL8Kdk4K5/PxMoW4+RcTu9lWsBQvxbOaRjk+gaDCVR+3rYo8vmMYTNNv9bN7D6bIiXu29k1vcT3EYQPDkxvku4IP4Iio9/uRc7eLsSoi78R8doFI4YZhPzNWDovrf/doO9fgKl0tLEkvzWtIsDBz0z9H8E3LqXcgtiV7DOxuH2c3E3nRkIvJ6IlYAxVYzMyVWYR1Dr2+MUj1EslAZ29ELEmtUHvJ2w+Ovg6pjumInAAoT1oHgORL8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(41300700001)(8936002)(2906002)(4326008)(6916009)(5660300002)(70586007)(70206006)(8676002)(54906003)(316002)(478600001)(40480700001)(36756003)(40460700003)(6666004)(16526019)(186003)(1076003)(26005)(47076005)(426003)(2616005)(336012)(82740400003)(7696005)(81166007)(36860700001)(86362001)(356005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 16:55:18.5742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d068c500-6b04-49e6-e583-08db181a3daf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 - Add UAPI header support for userqueue Secure semaphore

   v2: (Christian)
     - Add bo handles,bo flags and padding fields.
     - Include value/va in a combined array.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c |  1 +
 include/uapi/drm/amdgpu_drm.h                 | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
index b8943e6aea22..5cb255a39732 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 #include "v11_structs.h"
 #include "amdgpu_mes.h"
 #include "mes_api_def.h"
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2d94cca566e0..bd37c715f5a7 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -56,6 +56,8 @@ extern "C" {
 #define DRM_AMDGPU_SCHED		0x15
 #define DRM_AMDGPU_USERQ		0x16
 #define DRM_AMDGPU_USERQ_DOORBELL_RING		0x17
+#define DRM_AMDGPU_USERQ_SIGNAL		0x18
+#define DRM_AMDGPU_USERQ_WAIT		0x19
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -75,6 +77,8 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
 #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
 #define DRM_IOCTL_AMDGPU_USERQ_DOORBELL_RING		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_DOORBELL_RING, struct drm_amdgpu_db_ring)
+#define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
+#define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 
 /**
  * DOC: memory domains
@@ -361,6 +365,48 @@ union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_out out;
 };
 
+/* userq signal/wait ioctl */
+struct drm_amdgpu_userq_signal {
+	/** Queue ID */
+	__u32	queue_id;
+	/** Flags */
+	__u32   flags;
+	/** Sync obj handle */
+	__u32   handle;
+	__u32	pad;
+	/* Sync obj timeline */
+	__u64	point;
+	/** number of BO handles */
+	__u64   num_bo_handles;
+	/** array of BO handles */
+	__u64   bo_handles_array;
+	/** bo flags */
+	__u32 bo_flags;
+};
+
+struct drm_amdgpu_userq_fence_info {
+	__u64	va;
+	__u64	value;
+};
+
+struct drm_amdgpu_userq_wait {
+	/** Flags */
+	__u32   flags;
+	/** array of Sync obj handles */
+	__u64   handles;
+	__u32   pad;
+	/** number of Sync obj handles */
+	__u64	count_handles;
+	/** number of BO handles */
+	__u64	num_bo_handles;
+	/** array of BO handles */
+	__u64   bo_handles_array;
+	/** bo flags */
+	__u32 	bo_wait_flags;
+	/** array of addr/values */
+	__u64	userq_fence_info;
+};
+
 /* vm ioctl */
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
-- 
2.25.1

