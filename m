Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A8CC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 15:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7052110E514;
	Wed,  7 Jun 2023 15:28:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC16D10E514
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 15:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdxyws0g0MZmWtg9++vkJoYukm2PfKjWuJn/gkEu1OvRvBzkWsr8BzxEvVHHr/gSEyx2SCJPRfgbru0Ce9o/o0YYoXTJNLU0d8VVYG/7puS4AYivhLoAqeYv/1ln7D7zr1VwrBZOBLfWqvv4yLNTMQESAY58ZQqbL9uLtZ/wIace3PpeNuAyKPSc9tJNn83/BiXuHCZ4dLAzhcy/CSVFjj4F8SkbEiE/nNRO2hjXF6XdzEVqsMs+zTJvPmxoG3pjmKOVZ5VvcuZRZYV9iqQPB4siVFxVvB2jm4gbj6VvC1BLL/Unc5wxDaDu/BYPR7YCF+qxF98Qqd87/1MlO5AUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0BO+4YVA1eEjkXI4vq0l2JEDmS4N3R+Jhk3RLgGG/c=;
 b=F4D73Ev/0/6VwpHFjR3OURHtuqmxz2VtBxh1IEx1/HUsbRJaHq1G5qpUXQlFXa6M80RL5IINQ8MO1eADGjeTEBYcfOOGN4Ll06hcWsJybMIYdk7yn1MB0ghjRNuEGpkBHAB2B1ByV/I6qUz7Q0aHSfy0uewdvYzesFnMf0OgTjke4njiPs8i5bw7WwoxjDbnjRwcwq4fyYQ/Y+wMtos00ikKV4CstRoUmWeuOTq20vEf3yZJ+W8RZicaH2y38+qDZiL65sdICGYETJL0yXZQEJpnT04iqLu8oNtJ3gnUZpySamqqwlT87S+jPZ6mecfRD42khp8yUOWc0hq61k81Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0BO+4YVA1eEjkXI4vq0l2JEDmS4N3R+Jhk3RLgGG/c=;
 b=S8S/bGHvr+WcNXk+tMN/2f84p6DE0TjlRmavC3EsXek3c/gzv9e54y9dtFWYsyae9uZHrUix2X0OEdoHMa8PoSiTz5kVKZHGfdcpNaJVHD8xMRjXE3yodjmHn5bwgZuYNL81NNlDOR8buHgRynkgsI03wd4MQ6i1+AHIoEHf2EQ=
Received: from MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 15:27:56 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::6e) by MW4PR03CA0121.outlook.office365.com
 (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 15:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.39 via Frontend Transport; Wed, 7 Jun 2023 15:27:56 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 10:27:55 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix reserved SDMA queues handling
Date: Wed, 7 Jun 2023 11:27:41 -0400
Message-ID: <20230607152741.320428-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1ef56c-2558-4f1e-3559-08db676bc4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mtww0lsxkJgv/L8tCUoC3WbylvAKSCYMud6HznFaWEDVrb2BBB1DumIKDNT8001jv6apuPrcHM+FIbTtoMOXRCH56/qfo8WXXonBi0pEcvrKkz8+ut7Amk2upA/LL7X39aOCccHuXhDVi1jH3G54pOS481RGlctDmBJIKZ0ntEAgBo7MVgmxYEJjtbIYsv/FVeOAiQE0G81pTb+J6T6MoWfqAFNY6Pb+06KCPVbNh4HLyZVxTbMCaMA1hL28vxmfG5GIulYcCdrjQImxZNTy0u+4Sj7/5uLZFSKfpDdUGXkLz8lIj3r+czPiQP9jhj/pHQOQPyd3b1+4J63Pey7gl+Ra8aCZ2N6ifn9BlL4vpxB8NblGAx+bWGnSZiQR/wlafozuFiV5FjnL3NB96X2844Rt1qtbajJoDaiTIxiJp9N1LsRYwnzDtkA1g+Kuvzc9+tfSYgkGoMwJpn5lEUGXoclunaA4m4LmkqxitpYE64Cjdc1omL24M0r2VTXZZiHPHOWH+1ltW0YVhtO1mjV9qAyva3558nA8iw/Q0zKVHT4nUxWMDLWNyBDwmsbaIhoII15Fp5UmAqqx/raRdF3ana/45dQE3btcrttymPOb4UKJ4vyL/dL3m/+MtJ0mZrf7Pu35TlrZJmve4JhRQpyTbVg4twUJmOTTcUx2+I81wANDjG2rGvovgFOGzF6yJ/sMk5l3dGJgHU7489IqPPU/GgK9p6HhV/+R92fxdUx/E+W58Vcl4t75quCLYz+UJn51TDLG5exOb9UipddDIFXZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(7696005)(54906003)(70586007)(82740400003)(478600001)(81166007)(356005)(316002)(6916009)(47076005)(8676002)(8936002)(41300700001)(4326008)(70206006)(2616005)(186003)(426003)(336012)(36860700001)(16526019)(6666004)(83380400001)(1076003)(40460700003)(26005)(86362001)(44832011)(5660300002)(2906002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 15:27:56.5151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1ef56c-2558-4f1e-3559-08db676bc4f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch fixes a regression caused by a bad merge where
the handling of reserved SDMA queues was accidentally removed.
With the fix, the reserved SDMA queues are again correctly
marked as unavailable for allocation.

Fixes: c27842c84a848 ("drm/amdkfd: Update SDMA queue management for GFX9.4.3")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c             | 13 ++++++-------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 10 +++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h               |  2 +-
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9fc9d32cb579..9d4abfd8b55e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -106,20 +106,19 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 		kfd->device_info.num_sdma_queues_per_engine = 8;
 	}
 
+	bitmap_zero(kfd->device_info.reserved_sdma_queues_bitmap, KFD_MAX_SDMA_QUEUES);
+
 	switch (sdma_version) {
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 	case IP_VERSION(6, 0, 3):
 		/* Reserve 1 for paging and 1 for gfx */
 		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
 		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-1 queue-0; BIT(2)=engine-0 queue-1; ... */
-		kfd->device_info.reserved_sdma_queues_bitmap = 0xFULL;
-		break;
-	case IP_VERSION(6, 0, 1):
-		/* Reserve 1 for paging and 1 for gfx */
-		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
-		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-0 queue-1; ... */
-		kfd->device_info.reserved_sdma_queues_bitmap = 0x3ULL;
+		bitmap_set(kfd->device_info.reserved_sdma_queues_bitmap, 0,
+			   kfd->adev->sdma.num_instances *
+			   kfd->device_info.num_reserved_sdma_queues_per_engine);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0c1be91a87c6..498ad7d4e7d9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -123,11 +123,6 @@ unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm)
 		dqm->dev->kfd->device_info.num_sdma_queues_per_engine;
 }
 
-static inline uint64_t get_reserved_sdma_queues_bitmap(struct device_queue_manager *dqm)
-{
-	return dqm->dev->kfd->device_info.reserved_sdma_queues_bitmap;
-}
-
 static void init_sdma_bitmaps(struct device_queue_manager *dqm)
 {
 	bitmap_zero(dqm->sdma_bitmap, KFD_MAX_SDMA_QUEUES);
@@ -135,6 +130,11 @@ static void init_sdma_bitmaps(struct device_queue_manager *dqm)
 
 	bitmap_zero(dqm->xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES);
 	bitmap_set(dqm->xgmi_sdma_bitmap, 0, get_num_xgmi_sdma_queues(dqm));
+
+	/* Mask out the reserved queues */
+	bitmap_andnot(dqm->sdma_bitmap, dqm->sdma_bitmap,
+		      dqm->dev->kfd->device_info.reserved_sdma_queues_bitmap,
+		      KFD_MAX_SDMA_QUEUES);
 }
 
 void program_sh_mem_settings(struct device_queue_manager *dqm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 023b17e0116b..7364a5d77c6e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -239,7 +239,7 @@ struct kfd_device_info {
 	uint32_t no_atomic_fw_version;
 	unsigned int num_sdma_queues_per_engine;
 	unsigned int num_reserved_sdma_queues_per_engine;
-	uint64_t reserved_sdma_queues_bitmap;
+	DECLARE_BITMAP(reserved_sdma_queues_bitmap, KFD_MAX_SDMA_QUEUES);
 };
 
 unsigned int kfd_get_num_sdma_engines(struct kfd_node *kdev);
-- 
2.35.1

