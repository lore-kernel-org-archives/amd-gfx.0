Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEEEC00528
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 20:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E07E10E03F;
	Tue,  1 Aug 2023 20:15:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9A010E03F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Aug 2023 20:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLfSVGM/Q6ub2eLmsxJLcCmgwO2KSiI/E2b8mBgcwmePVTetpRUXOJo403DfC4qK8htLBt7iWDA1tElAiGyILqw1ekOTmDDKDiSTMs4bkuNC19ZZwlvpnqUnmdfll6V98BQoqq3JYiVaNscIPvTfeToblFTmYi1U3mEcvLBhA/kQtGes4MS9ydaKMW/kv/GI4aelzs2FT3tzVoj//NSpj6PLFHOnIEWluW95GycaPtF8yJ5w5TtT3SDW4+lEOFri0DdFtIKT7PE8XuAW5KNv7e1OXlvNsbe4mc+lzvCxvtM+fCEocglEW+g/07yfz1fElG3tb+OLe1LTEuaJejikGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQvLwY3YKZ+vmKMQVdK6+DUaX7Y5GTWTP2JQ/3lvDWw=;
 b=E+lo8X284DJbjpPZPdUHcaxz3EOFlNjcjsOU5Dm8Lilr87hpfF4ERthXxkdTkBl+6a8U2eV/nu7cHphDdIk6gw7/S0dma3DBTKKHgpYUrnirJbAuCn2UX/5upYWerrpLnEbXCYeyV9ugONHvfggcrQHlu3XAtAvlY60FGlE6vRhuFbOf3kYSeaI5Nr1GNTYJHje4pZ+aWkNOSWAaRHl3//xYT6qLUJy7/jGslNRLpdNpkcnU9o8IOmBg6cKDwojQ2MfOnO9Nka8xTH+sJ+Ra3mKUMotje5Qdpo3HvEt4kOh1tqTQhHsVdRJg15NGQeKT4j6g2AtYcUndc9KE2YERcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQvLwY3YKZ+vmKMQVdK6+DUaX7Y5GTWTP2JQ/3lvDWw=;
 b=Vpy0w3ezPYKJUtTjF9eNOHgjrNIgkaqm60H7uTonl6161blvdkhcKLfVrSSvS3kguK7tggJpcvHbtEtKBc8m1JT/8HT0nDlQBkWw4xPZn26zHBrKNHEsU7IqePe8d5hnGBWW25QhGpiC/dxLUaDkSUmRsuOXRyo74tFYWUiyf48=
Received: from DS7PR03CA0210.namprd03.prod.outlook.com (2603:10b6:5:3b6::35)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 20:15:28 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::34) by DS7PR03CA0210.outlook.office365.com
 (2603:10b6:5:3b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 20:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.42 via Frontend Transport; Tue, 1 Aug 2023 20:15:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 15:15:27 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: fix debugfs access for discovery blob
Date: Tue, 1 Aug 2023 15:15:15 -0500
Message-ID: <20230801201515.26789-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 830ed871-846c-434e-bd26-08db92cc0c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSLIPmlB8uWvVoXdHwkPr66gcv+3oAhr1ywJsUXwcLPx6L6/UtjfNPNMpQwOYZpAoetaErGoOgYQ810+z18Y+O4g5VbD7jOSWZAx8BBB7V1ZHntwnasA7FgzjrjOFsOsyNxf77LBtW+nC+hqWUEBE2TBnHDeaVv5kXVOdruT0LI5FSr3eVZfveFyKKWDwbo4S+ng9coHddqxt+e/HYexIdmSzqmhJVsS54dn6fLfUpke1zlgZ+w2JDrMaSfuu4R+ULXbr3VNsBPuo0AxR84Nc7FcqmDhG5FIeweOXrSkGaImV5DfeBSRMUvGc94p0+KV1y9JRC7MXMANSi+6mkupmN3t3D3OZ8Tyr+aalh8R1a77VoVHOG42AiNfBW9fQgr88GyqL7plZVq/p3P9gOhKPFtw+uukLoquNQME0Gs3nHvYVWsXMa3W45O08IoIfQz5bc4S+0QtWraHtq6x62gyp3jjaIytXPnJDEjRuPP/ImJAH5OOdqAW9DfNXqkXpB2Y9F0l6KKWiVzJC3qofOv0GH3SBmjCEWP2zDj6x2E/cb2M4EcIKXsglN0lURxG+bb6u1+VibmQwJDJFkp0IPc7HGWqrHGdKEUexy3W+BhpCgEj2++Wg+PkmGQmd/u63MH3NdEfaNXkrH+G7OolDF0n5AFC6tTVueH9IUci/ZGmnoF/1CjrwB+ln2cS4SKhDepHs3vU7I/86hUThY6szu5c5JZs2ghigoAJ5Y4eYuAWy1/Y7w/IVaG7Rpy44LuLLMGw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(8936002)(8676002)(36756003)(7696005)(41300700001)(478600001)(2616005)(2906002)(426003)(6666004)(44832011)(83380400001)(26005)(16526019)(47076005)(316002)(186003)(336012)(86362001)(1076003)(70586007)(5660300002)(70206006)(36860700001)(82740400003)(966005)(40460700003)(81166007)(6916009)(4326008)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 20:15:28.1243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 830ed871-846c-434e-bd26-08db92cc0c6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Accessing the blob for amdgpu discovery from debugfs triggers:

[ 1924.487667] kernel BUG at mm/usercopy.c:102!

usercopy_abort() explains that it needs to be solved by creating
a cache to store the data.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2748#note_2023519
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 ++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a3b86b86dc477..66a2251bdeba4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -791,8 +791,11 @@ struct amdgpu_device {
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
-	struct debugfs_blob_wrapper     debugfs_vbios_blob;
-	struct debugfs_blob_wrapper     debugfs_discovery_blob;
+#if defined(CONFIG_DEBUG_FS)
+	struct debugfs_blob_wrapper	debugfs_vbios_blob;
+	struct debugfs_blob_wrapper	debugfs_discovery_blob;
+	struct kmem_cache		*discovery_blob_cache;
+#endif
 	struct mutex			srbm_mutex;
 	/* GRBM index mutex. Protects concurrent access to GRBM index */
 	struct mutex                    grbm_idx_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 56e89e76ff179..55ea5be14b188 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2180,7 +2180,15 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_blob("amdgpu_vbios", 0444, root,
 			    &adev->debugfs_vbios_blob);
 
-	adev->debugfs_discovery_blob.data = adev->mman.discovery_bin;
+
+	adev->discovery_blob_cache = kmem_cache_create_usercopy("amdgpu_discovery",
+								adev->mman.discovery_tmr_size,
+								0, 0, 0,
+								adev->mman.discovery_tmr_size,
+								NULL);
+	adev->debugfs_discovery_blob.data = kmem_cache_alloc(adev->discovery_blob_cache, GFP_KERNEL);
+	memcpy(adev->debugfs_discovery_blob.data, adev->mman.discovery_bin,
+	       adev->mman.discovery_tmr_size);
 	adev->debugfs_discovery_blob.size = adev->mman.discovery_tmr_size;
 	debugfs_create_blob("amdgpu_discovery", 0444, root,
 			    &adev->debugfs_discovery_blob);
@@ -2188,6 +2196,12 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+void amdgpu_debugfs_fini(struct amdgpu_device *adev)
+{
+	kmem_cache_free(adev->discovery_blob_cache, adev->debugfs_discovery_blob.data);
+	kmem_cache_destroy(adev->discovery_blob_cache);
+}
+
 #else
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
@@ -2197,4 +2211,5 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 {
 	return 0;
 }
+inline void amdgpu_debugfs_fini(struct amdgpu_device *adev) {}
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0593ef8fe0a63..1a3b30dff5171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2276,6 +2276,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	amdgpu_debugfs_fini(adev);
+
 	amdgpu_xcp_dev_unplug(adev);
 	drm_dev_unplug(dev);
 
-- 
2.34.1

