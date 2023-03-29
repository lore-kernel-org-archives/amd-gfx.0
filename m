Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB6AC761AF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C31310EB6F;
	Wed, 29 Mar 2023 15:48:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F5D10EB6A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht4NUX1kOQwfXPNVHtBHlzJsLY0C5712ySohFEFrL+bvARzOfhBMdW7sTPVle7duLPRWqqGSZVa+xrTyQ+MbRO3S55tqGZ75DiL79IZYvmcGs+p6V5XSb/VR9sS+rMO9RyRXYG5EsKmpiG58xrGlwLx+9fkDGTSHWgIJzFyfO3S1PnG6RjO8yJ62WFOtjXevpcfVQw0+OrwR2RQgZ1OPAGbR5S9FQ8f2pMNi1n2Mrv8NsFf8PV+mj8Fxqi5D2ENyeZ7hU/YsdLDG0ZqqAs7o5hkEaZOqiuux5RRIMZiHpb0gtjMiCa1sQCaEL6XG01Sgndc5XSeaT4GAEnOb9XrbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7NOwF5LuPX1UZhTt/qUhRF2l6yYqUOrvtuQ0I/sKrc=;
 b=CIa6UwzxquAiSjf4d+ywxYPSg8xsDVz37r2rnEzhaFi7WdQcVZ5OJ+AaeRzkOdvJD98PSEdcEO4dWE3AOsUQ70AJneL6cz/nHfYoHjEZHknFXRQ3esvl/FEcXOVWfNjc5JwKxD7FnLA1aRunWIHDPzJQ4mv+tipIZELepppXzwUtsBXd18bnFz4xN2uq4LUf+4mRp53D5SZYCEJKuxXgrZOgji33argofREAgLJK+y/Bwg7hVt22+VZFdbc3GDGA7ohWEPiICS5eRHUBFopX51r+qGPNGR8KGrpmCFPMFvNlOIKo7Kp0666Cwy09NwM+l9tBT2Q/omWgjUfFAJq8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7NOwF5LuPX1UZhTt/qUhRF2l6yYqUOrvtuQ0I/sKrc=;
 b=QIMBzGQ5+RUXEAL8Bg6pnduetRR7j5G+ufWZ+aN5nPNg203Ofb17SroxUGtwOwjJoCvhadmJ1BCepBPvreVnXu3VtGbWcGUKmAyIr2edFCLyWwAeeaFLldMLBd8lVYJ4flAqMBZDlglxelRAmibmZwRHXqcbdAPRBPm0b8MztaM=
Received: from DS7PR05CA0076.namprd05.prod.outlook.com (2603:10b6:8:57::13) by
 SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 15:48:26 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::7f) by DS7PR05CA0076.outlook.office365.com
 (2603:10b6:8:57::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 15:48:26 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:24 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
Date: Wed, 29 Mar 2023 17:47:44 +0200
Message-ID: <20230329154753.1261-8-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f55018f-d04d-425b-5590-08db306d093a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMSP2W2vgLGAw5a9q9GvEL8jRa86tGzPKd1+25K3wIdPkHuaoo4Y0/6hQCAr8gDYkmHAcRjWMny0Nt9VyssrExfoL3rBBmQAhpJ3xiTKueNduoP/DUnSZBBNcv5NfEd1qTNF+4wrR/P82HeJcREkflc97PwtjUixaF/hvlv8vH20wMTG66+GurUwIEf37yxiZdElDRS6L0VGBteyMyGzA5vD4TcZCZ6KRq+7pqpU+OLUfn+HblCeq93E34SwYGCtjF8Qr3Gnsfapi40itpgvMxXAEXPM/BIoMDs9vCsHJaJXoJmxDDHwP39PygJEXSA90sz0prFXrdnzLIQwj/6IQjF02CA+iwjXQLcZVbCyWZGe+RAKqMr5kCSVI+WKPf2q6gRNdauEx36ncCkXlPYmECLB9uKyNx0fCKt1xgHfUBen9Cif6/SUio8F7/80QdVFOLE+g5Fzgd+rW+Shv1Zr33rLpXKcHyQx2ia2v7sEVYRDDXDpDsZKn0X90xR1qp95DllEZ3gZ20FHo614miLOtUYeccOjA8qrVXdjIGTZ7YlyYVZIxZ+nTG+2J8m7FTfKJ13D9z7tQD9V/W8LxonNhb+oC6KAiiQCP3p/8w/tj972A7ew2W4btAkoHY6cUT7Npe+9d0diFchF2k70PMXl0sIFRQV9fpSLOlmcXEgue9LyLal2AvA+Hx70QMNHTneVj6A91ZVrdxNbv+aPpLXRESZ4btO2rw8nKdkSzjGER5c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(426003)(86362001)(47076005)(2906002)(316002)(6666004)(44832011)(478600001)(54906003)(5660300002)(82310400005)(7696005)(16526019)(186003)(70586007)(36860700001)(356005)(1076003)(40480700001)(2616005)(4326008)(6916009)(336012)(8936002)(8676002)(26005)(41300700001)(70206006)(82740400003)(36756003)(40460700003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:26.6193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f55018f-d04d-425b-5590-08db306d093a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
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
Cc: Mukul
 Joshi <mukul.joshi@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch adds helper functions to create and free doorbell
pages for kernel objects.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index f9c3b77bf65d..6581b78fe438 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -27,6 +27,24 @@
 /*
  * GPU doorbell structures, functions & helpers
  */
+
+/* Structure to hold doorbell pages from PCI doorbell BAR */
+struct amdgpu_doorbell_obj {
+	struct amdgpu_bo *bo;
+	uint64_t gpu_addr;
+	uint32_t *cpu_addr;
+	uint32_t size;
+
+	/* First index in this object */
+	uint32_t start;
+
+	/* Last index in this object */
+	uint32_t end;
+
+	/* bitmap for dynamic doorbell allocation from this object */
+	unsigned long *doorbell_bitmap;
+};
+
 struct amdgpu_doorbell {
 	/* doorbell mmio */
 	resource_size_t		base;
@@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
  */
 void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
 
+/**
+ * amdgpu_doorbell_free_page - Free a doorbell page
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * @db_age: previously allocated doobell page details
+ *
+ */
+void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
+				struct amdgpu_doorbell_obj *db_obj);
+
+/**
+ * amdgpu_doorbell_alloc_page - create a page from doorbell pool
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * @db_age: doobell page structure to fill details with
+ *
+ * returns 0 on success, else error number
+ */
+int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
+				struct amdgpu_doorbell_obj *db_obj);
+
 #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
 #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
 #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 1aea92363fd3..8be15b82b545 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 	}
 }
 
+/**
+ * amdgpu_doorbell_free_page - Free a doorbell page
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * @db_age: previously allocated doobell page details
+ *
+ */
+void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
+					struct amdgpu_doorbell_obj *db_obj)
+{
+	amdgpu_bo_free_kernel(&db_obj->bo,
+			      &db_obj->gpu_addr,
+			      (void **)&db_obj->cpu_addr);
+
+}
+
+/**
+ * amdgpu_doorbell_alloc_page - create a page from doorbell pool
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * @db_age: doobell page structure to fill details with
+ *
+ * returns 0 on success, else error number
+ */
+int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
+				struct amdgpu_doorbell_obj *db_obj)
+{
+	int r;
+
+	db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
+
+	r = amdgpu_bo_create_kernel(adev,
+				    db_obj->size,
+				    PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_DOORBELL,
+				    &db_obj->bo,
+				    &db_obj->gpu_addr,
+				    (void **)&db_obj->cpu_addr);
+
+	if (r) {
+		DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
 /*
  * GPU doorbell aperture helpers function.
  */
-- 
2.40.0

