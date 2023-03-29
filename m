Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDC0C761AF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7757C10EB74;
	Wed, 29 Mar 2023 15:48:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E36310EB73
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4Z3BPkMyMoAxoveppqI5zKD753mIgtqfGp+QJNw5dXX27GQ56PcUrxlWb4y15rVJj/SCeUk/utFf0El8A21o6ZWV/8TIWQZu39GN/EGKb0rw/0DO2s8tpLcpxqOWiNLTtIJp53lAaqZCd6TFhYQOgbXMbFQDrAaQrmv2C0ogeoYmF694V+rwMBSHP5czs3N604sZbVgAGUCxea6noo88Du1YrDqnvAUOva/Xpe6K4qPJygBKGywIUNMgawnGWNh4o+/7KsS+GNsJ7hznZ0KH9VsTOz2gHI+0dKkriqZo3I7F0ZiSrA9g//pN7Q2r5nGWEhOy6Yvy4kQN1WQTkSEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YqCeHJn+9uKsRApqCl/VVfQAV4VvWab3TjKpfE2/E8=;
 b=dDHVdDFY114bWCix8IjZw6D4kgpBVIQHi744pBsK8+Aae7cgTH54QZEQV/v+vd1gtGIlyF6ebe1fANTSJDGd6x9e5v9b80bWm0oZb1eSVJSyu+72Pahz/B9oWFEn2337DFr1Q4IpVvYWJuwSGVTQZEn1a/NjowjUns+O3IUgUxtBxWD88iKK/UZjK5Hu/PIjacBfAZ1R01bj/HgtufnsWdgt1pfBw7NP0hw8m0dqmoP5zrNJA5U+51BxrMNqkAWhMlLoTcnEbAOkzQ3yq+YXTYGpqdRpeUb+z/IKUYGp+qy2SXqfC7r6U2tTsc63WqHd4Tm9CElKSm3QH+y66M9b5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YqCeHJn+9uKsRApqCl/VVfQAV4VvWab3TjKpfE2/E8=;
 b=fYSxYmDzLkZeva2gSHEqU5cY6RReuJ8Bj/z6nIfXS7rV6xUqN79LmqHja0DEo7GraBWv5dz5BoJ3g1Fy5ylZb0Zm6O+n3dHKuy4+6GptHp0mzITxNGrpvie7lyTHtB3DNGjEbo5RcvtZTD2vo6Cs2hGc7fYyMY5QzDWWw0EEAR4=
Received: from DM6PR02CA0093.namprd02.prod.outlook.com (2603:10b6:5:1f4::34)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 15:48:33 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::8c) by DM6PR02CA0093.outlook.office365.com
 (2603:10b6:5:1f4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 15:48:33 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:31 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amdgpu: get absolute offset from doorbell index
Date: Wed, 29 Mar 2023 17:47:48 +0200
Message-ID: <20230329154753.1261-12-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 59055955-994a-45d6-4a1b-08db306d0d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6EXYJoYkfuK3gxY4bxd07+sfdVBzfY/obCfg/0dNEByPIj4pniqXkbHg9Z53R0576Wd1fu8+kBS8SLeO95bAL8tmzQk8qxLs5LBGYXFhDX4YMtrpW02n/2SF6zZk9xbHri1cnmPrON9KLTAy2L63j/AjOs4YuLOjqfHA6YU+WFv1buXR4pNRLU3S13SVii0+NbtCoU687nMQFUZHMvLktOHEEExL2dopLz/AKF4+4s6uJ8gDqMrnvSY48CBEpk+t4UOIuJcA5CXO1LvaPRq+ST/PZl61CqSD1CDJeaR7FRmkzLoinTaBg6Pe3mhVLhvkcE/xEwa2lsB84+7xxGZn8yj2s/xl69CJWH7DAKshmuC5Euvmv3ezywiJPCByjFEI3WDL/BV0oxL0L1uwCheGjNKJ+6EcRsJPVS+0Iy8iNHoCLuqoDeByprf/SkMTWJX+ZvyEaVlHn5HagB+kd2haOZE3cyWgDBaPimCDpte05Lg3jRyJiAQudZsRPMnAxi0Z2fNeXIE/yNpckMxfpGYV3U72v37imXfNpM6Q3c4IGQziez7Vjnq1a45orTqjv0YlIWcHjVP6r7nTJITCeEDGimbAoN/TpjR5CaiUMMLABKtn513iMd7sZ4YioEDLxcYi4IIXQt+S4ckaIN24NeKpagg3TamV3Qn6i2ovDcJFjqymCOtSrmnajzm5ya5eQs7cbLqbXFyPM0y5B91DVMv4B0st85OQtmCkSl1wdCHZHU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(26005)(82310400005)(2906002)(47076005)(426003)(6916009)(86362001)(36860700001)(16526019)(40460700003)(81166007)(2616005)(336012)(5660300002)(40480700001)(356005)(8676002)(186003)(41300700001)(70206006)(8936002)(70586007)(82740400003)(36756003)(4326008)(44832011)(6666004)(1076003)(316002)(7696005)(54906003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:33.6914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59055955-994a-45d6-4a1b-08db306d0d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul
 Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds a helper function which converts a doorbell's
relative index in a BO to an absolute doorbell offset in the
doorbell BAR.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 15 +++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 26 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 10a9bb10e974..3481e9d83879 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -383,6 +383,21 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
  */
 int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
 
+/**
+ * amdgpu_doorbell_index_on_bar - Find doorbell's absolute offset in BAR
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * @db_bo: doorbell object's bo
+ *
+ * @db_index: doorbell relative index in this doorbell object
+ *
+ * returns doorbell's absolute index in BAR
+ */
+uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
+				       struct amdgpu_bo *db_bo,
+				       uint32_t doorbell_index);
+
 #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
 #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
 #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 81713b2c28e1..c263bae6b0c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -130,6 +130,32 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 	}
 }
 
+/**
+ * amdgpu_doorbell_index_on_bar - Find doorbell's absolute offset in BAR
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * @db_bo: doorbell object's bo
+ *
+ * @db_index: doorbell relative index in this doorbell object
+ *
+ * returns doorbell's absolute index in BAR
+ */
+uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
+				       struct amdgpu_bo *db_bo,
+				       uint32_t doorbell_index)
+{
+	int db_bo_offset;
+
+	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);
+
+	/*
+	 * doorbell index granularity is maintained at 32 bit
+	 * but doorbell's size is 64-bit, so index * 2
+	 */
+	return db_bo_offset / sizeof(u32) + doorbell_index * 2;
+}
+
 /**
  * amdgpu_doorbell_free_page - Free a doorbell page
  *
-- 
2.40.0

