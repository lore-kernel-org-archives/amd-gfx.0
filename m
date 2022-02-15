Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5955C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 07:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75D010E3C9;
	Tue, 15 Feb 2022 07:42:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C2910E3C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 07:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPZZvfGEdXUwo0wgdLJrTljCzcfmMieii0SO0/XiDbu+EmqUOQW6VaiAyz04Ufw5SmXGSRxCuvFZBhW7keFjHhgL6nNwi/n8p5bgo77XSoYVFLWJSLxe4thAPKNvdw/wFOEjeUg4VWkYJF/7Dgpmbu78pWpZXmfdtnan2aRmBAoBFthUBLnOpseXH+mnyWAgYTT8PPxPkNRKpGhEhZVYgWfLX6LD7gCQibcHYY6gDGRedoDENASb8pOI8KkmLAaG/VGUFI3DJecwr2HmlRdlJmYjx2AXi32DGOOyanRrX+62B07nVfm7nTyce1i4dr8pEVrMODiL3UxmkBTn7X4A2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5dXTTOIt3wkdXtVTkjaaq0yNSiZdL5ebYp0aoOSvoQ=;
 b=dzS8fgjbdiPxh9xbW9FSfmomZGTY34aGEqiSlQ5aAyaQefrlh3pfi8cUOnHhEGFtYY7D8jTUE1I1E8jP2GoH1nslotkPvSZhY4B38bcxyp6OZN8D3+kzGlIY9GP7uZ+5YCsg3y3D+aJadmFW29+5MjSgcDRyTR7Auoq3DItTyCgHwNgWNnkjudZbIs02UJUdoSnXvCaB6Qq0zYH5JksQORTRod3KzYsqBayA/LX3eh3uDHhVb2e7+a3gC1LltMRt7PRdh1PF3HAUxukkCC4LUWUOQbP93JYepwP9YASE+bfhwz5TZQdhnMc+SuYVUfyzwOa8rPzMn7zRC5KzdbdrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5dXTTOIt3wkdXtVTkjaaq0yNSiZdL5ebYp0aoOSvoQ=;
 b=xe0JWekrsddHVU8Q7gQeHsBJC2Vj/pOy3t3BwSQLHoPDQ26GK7EwZU4n1r+vpMfwlo4oUzdy006DywwOl/acdyopU8FcxN9lLsAjRIfjugT/EP18lJwVIoEcjAbAPRVAw0M7qaj2gC/iIFvZc2sJarMD+qrJyeIZh/BQVR3i+wY=
Received: from DM5PR15CA0027.namprd15.prod.outlook.com (2603:10b6:4:4b::13) by
 BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.14; Tue, 15 Feb 2022 07:42:09 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::d2) by DM5PR15CA0027.outlook.office365.com
 (2603:10b6:4:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 15 Feb 2022 07:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 07:42:09 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 01:42:03 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu: Modify .ras_late_init function pointer
 parameter
Date: Tue, 15 Feb 2022 15:41:18 +0800
Message-ID: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 753061a3-ec1c-48b7-5f18-08d9f056ac04
X-MS-TrafficTypeDiagnostic: BN9PR12MB5132:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51323A50E4CEA79C91679755FC349@BN9PR12MB5132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:139;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Khv/u4l88Mmie0dAzJPOKrPhw09jEYSzxRnN/Pg66eDqzjHkQ2g/zevWa4duGRb5GGF/guX1LMRHQLGIbD/ryLTsbvlMoqLpXhjGyoS0FnJbved1lfR8F5DfP5wle6vxVVTtWbNO0lQL4g4N0o0gLdZ6Dh+tFvX1vqCJFBTmFDvLAwiu3gxpZX4wekEUKY46zk4oHoCqhrsKHuuIJamCvSKzWfa5uQikbbPtOERHDapjw3BOSbIuwqMhBz5tevvOx2/DLi01Q0+oDBioHh9ujUiiayU1P5vtklrL2bmxeBECNGJGmiSB8kG8R2ZnJlXwYxxg7PKjksNDc0C8KfxW+aQjqnWVvZsR6fITsKf28XYgeFoqPp56dEibuwetVpQyXkDQf4R3vsWfKbmnS8ICD1n7izgO3r/uWHdb2gcOFqgZvM43niWAqJJSsqIiRUOPucK5EsyVQHz6ZlpcGuvPI66DNle5ZsMwGHVWxqshPwU7HEcXXSrxxOjpWfEkGQQ4uDyE0v9nEdzb7ftFEEbbIkIAIU6/e0ySFjqj2/q/puo7dvyjm1l7mX6LxzcUjQPE0vc+AA8QWQnTlw4QboMkLWxWeYC81MME76Xv4uEHiYaA+Iek7s+za0TrKOTCUDMLujXHCmDxZ0S6d7f9oKlzLFIcOgr2QaM7K2OH9VMbcDrdnUCfM9KD8Z+Jq4+UAbVEHYtUoXxd72KHn93OOriZmT80Mbz4AkGMTKdb1vg0RM+5+YYY6Q6kMb4NTB5dsGC7iVmozbVL2CC40J0+KXoN7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(81166007)(70206006)(8676002)(316002)(6916009)(356005)(70586007)(508600001)(54906003)(36756003)(86362001)(426003)(8936002)(336012)(47076005)(36860700001)(1076003)(2616005)(16526019)(7696005)(6666004)(26005)(5660300002)(30864003)(82310400004)(40460700003)(83380400001)(2906002)(186003)(43062005)(142923001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 07:42:09.2519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 753061a3-ec1c-48b7-5f18-08d9f056ac04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify .ras_late_init function pointer parameter so that
it can remove redundant intermediate calls in some ras blocks.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c     | 6 +++---
 15 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index fe392108b5c2..b7470ed7bc25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -622,7 +622,7 @@ int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)
 	return r;
 }
 
-int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
 	r = amdgpu_ras_block_late_init(adev, adev->gfx.ras_if);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f99eac544f6d..ccca0a85b982 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -386,7 +386,7 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
-int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, void *ras_info);
+int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_gfx_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 21a5f884dd2a..70a096160998 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -24,7 +24,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	return amdgpu_ras_block_late_init(adev, adev->hdp.ras_if);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 4af2c2a322e7..aabd59aa5213 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -43,6 +43,6 @@ struct amdgpu_hdp {
 	struct amdgpu_hdp_ras	*ras;
 };
 
-int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_info);
+int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_hdp_ras_fini(struct amdgpu_device *adev);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index 2bdb4d8b7955..ede98db8c126 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -24,7 +24,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	return amdgpu_ras_block_late_init(adev, adev->mmhub.ras_if);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 7deda9a3b81e..75815106f2d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -47,7 +47,7 @@ struct amdgpu_mmhub {
 	struct amdgpu_mmhub_ras  *ras;
 };
 
-int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, void *ras_info);
+int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev);
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 89e61fdd3580..92fd4ffa7779 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -22,7 +22,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
 	r = amdgpu_ras_block_late_init(adev, adev->nbio.ras_if);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 4afb76d3cd97..f9546c7341b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -104,6 +104,6 @@ struct amdgpu_nbio {
 	struct amdgpu_nbio_ras  *ras;
 };
 
-int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, void *ras_info);
+int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_nbio_ras_fini(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 5de567c6a8f7..837d1b79a9cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -490,7 +490,7 @@ struct amdgpu_ras_block_object {
 
 	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
 				enum amdgpu_ras_block block, uint32_t sub_block_index);
-	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
+	int (*ras_late_init)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 	void (*ras_fini)(struct amdgpu_device *adev);
 	ras_ih_cb ras_cb;
 	const struct amdgpu_ras_block_hw_ops *hw_ops;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 242a7b4dcad9..594454dba4c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -87,7 +87,7 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 }
 
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
-			      void *ras_ih_info)
+			      struct ras_common_if *ras_block)
 {
 	int r, i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index eaee12ab6518..8b226ffee32c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -117,7 +117,7 @@ amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
 int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring *ring, uint32_t *index);
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
-			      void *ras_ih_info);
+			      struct ras_common_if *ras_block);
 void amdgpu_sdma_ras_fini(struct amdgpu_device *adev);
 int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 9f1406e1a48a..7abf9299e0d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -136,7 +136,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 	return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry, true);
 }
 
-int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index ec15b3640399..e4b3678a6685 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -72,7 +72,7 @@ struct amdgpu_umc {
 	struct amdgpu_umc_ras *ras;
 };
 
-int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, void *ras_info);
+int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_umc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 		void *ras_error_status,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index a785b1e088cd..91f788f6f6b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -732,7 +732,7 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	return psp_xgmi_terminate(&adev->psp);
 }
 
-static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (!adev->gmc.xgmi.supported ||
 	    adev->gmc.xgmi.num_physical_nodes == 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index c442b34b9472..72ce19acb8bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -37,7 +37,7 @@ static void mca_v3_0_mp0_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mp0_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+static int mca_v3_0_mp0_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	return amdgpu_mca_ras_late_init(adev, &adev->mca.mp0);
 }
@@ -89,7 +89,7 @@ static void mca_v3_0_mp1_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mp1_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+static int mca_v3_0_mp1_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	return amdgpu_mca_ras_late_init(adev, &adev->mca.mp1);
 }
@@ -127,7 +127,7 @@ static void mca_v3_0_mpio_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mpio_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+static int mca_v3_0_mpio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	return amdgpu_mca_ras_late_init(adev, &adev->mca.mpio);
 }
-- 
2.25.1

