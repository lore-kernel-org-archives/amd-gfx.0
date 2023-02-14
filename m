Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0E2C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 16:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743A510E91E;
	Tue, 14 Feb 2023 16:16:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A93010E92D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 16:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cY5OeQKkrDDBesVShAsapHNJesHVOh/XICRR8wYukFq2hRxWQfQ1q5bUA/Mlpr7r3Lk0Bvhf4kkjCDYB5VszGzcW0JI1IRM/8+YCUPfI/IHE/4ijmqI2rxDriJZTdBou/grExcvDPiOH3lpHkcWmrmiw5mWDnXVL18bDPNA0c4uWxaURH1VBxODWMawwldfVKhCxw1mfhOIWyuwh9D/q+MXR6wI/G2kSXa65NMvEaL3980v2gf2leGgEsNrb6cy9JLaGIZujwyZLyuxbr91lyrFtKh6xbdOjsuFV4YaiJlpDRnpf0bBzWFlvD+d3f1/Rvh9GcpBvSKmEiu8eKAIwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpAEDo8JFkD9YP0aBskNQOPhmwbrGBEDlemXD/2+iyM=;
 b=YbzTAlGXqH5/OrO8/j+lJ3KVzGp6s/cNhM70QIGYamxr/6ub2xFevt3rsVmFnIrK/JRcvSO0odr1bd9s2eExSalJ/0WoO9Al7fPy1RPDZK5o8es8tu6bghQNRTM9JJlYBgReoFlKGD5awKTKNagFeMw4TQ42EFcs6/igul+k4KcFP+/mjBe62w7CNoim1ukxVUd7V3V6g3U4ITyPCHMObxzehFKo0Ok7p35mx2//FHMSXETxEKwj848fXoLrB5jHamhfiEG63mXC2X2LS8dW2hZaM7KviC1SwGjkqxjzRwyULd41N1FePbuxsIllBAYCoVBTNBd+QpfNprlQhZPU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpAEDo8JFkD9YP0aBskNQOPhmwbrGBEDlemXD/2+iyM=;
 b=OgjigQMf3ZJ4i+ZThFzRbi2o99duOo3j/zUBolqyWLbkGHi9ij9ih2sOcFiTZ9DH1C30NhZsQKeGt8LrydMiXGC/3ECkZ7PKhs7w/BNp+DlfZnr80CN+xyZsTg8a12g/Ut9cq7ViViz90Hz8rgSciTdIt+r+vQxXYK62UB3DqiY=
Received: from BN9PR03CA0084.namprd03.prod.outlook.com (2603:10b6:408:fc::29)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 16:15:57 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::ed) by BN9PR03CA0084.outlook.office365.com
 (2603:10b6:408:fc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 16:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.26 via Frontend Transport; Tue, 14 Feb 2023 16:15:56 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 10:15:54 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 7/8] drm/amdgpu: create doorbell kernel object
Date: Tue, 14 Feb 2023 17:15:09 +0100
Message-ID: <20230214161510.2153-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230214161510.2153-1-shashank.sharma@amd.com>
References: <20230214161510.2153-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9f8ef0-0982-4446-59db-08db0ea6c101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5h1y1PEE7jhwlvKP+AYx3XKRuMGeuFl+pNWLm9x3MPIjWpbB/RKde15hvi9QHl4bC21Bz4KDmkWoioe12tRU8gqrR8HsChuHtf+/CHsfv5X+CYsi74DXuYkXmBQPxBhru9k0h9gdm6r+UUos6b1nJHY5C2peNtEfi7RJmXAgM9jIa0EOjK9n6K8n1X0IZZ6mt2ic5zmKNAlquFKeYPMAtOLeEkCkYTUbwgm4lKHr2So1je4k7uFjbfJx7yplZHClYsc6iI2SLevzB5BNTk2bwrjoyU+UuAw/Z6a49mLyG8vQNOd4ymfPHKqUk0ha8Ht61kDwO3C7LvZNBDR4cIGDE3IowJkyibncA1VeyKOwPHK1X9vwu4D04XOHHolhlOsXlhU8h52rInFTHpIzSGgrLBLmVcgLVf0DJInL5lm5bkYVLlzmq6TO7jiq1Pd+PzcZewKNSxNUPFKtvq8wOqnBydywEDAsrznYnG7/uZZRc/ZzTbl3qMuxXBhEZ/SmR0ybG7o0MqHL/834AOaEtYSOtOjY9/NV9T68aNZoNub4lippzUliFX7zQy54Bj8sS1UB8tVylSG13rzEywfsncUDzYMHtaxaBm6JGXj48YgKOTGw0SEFUNOZY2nlyjJbmfCGBiFZn24pmikaYgpuutTPl8qSxjruiD579B38tiFXiSo6xVjRcYv79GQwACYUg23OKIHoqr7CbiWcyZrGs/v9EYV7ON9BhNxlLFJZP30jmnU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199018)(40470700004)(46966006)(36840700001)(44832011)(8936002)(426003)(5660300002)(82740400003)(41300700001)(16526019)(186003)(26005)(1076003)(6666004)(70206006)(70586007)(6916009)(8676002)(7696005)(40480700001)(478600001)(83380400001)(4326008)(356005)(82310400005)(36860700001)(86362001)(2906002)(2616005)(47076005)(336012)(54906003)(316002)(40460700003)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:15:56.8039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9f8ef0-0982-4446-59db-08db0ea6c101
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 Arvind.Yadav@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch does the following:
- Initializes TTM range management for domain DOORBELL.
- Introduces a kernel bo for doorbell management in form of mman.doorbell_kernel_bo.
  This bo holds the kernel doorbell space now.
- Removes ioremapping of doorbell-kernel memory, as its not required now.

V2:
- Addressed review comments from Christian:
    - do not use kernel_create_at(0), use kernel_create() instead.
    - do not use ttm_resource_manager, use range_manager instead.
    - do not ioremap doorbell, TTM will do that.
- Split one big patch into 2

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e9dc24191fc8..086e83c17c0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1879,12 +1879,32 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.doorbell_aper_size);
+	if (r) {
+		DRM_ERROR("Failed initializing oa heap.\n");
+		return r;
+	}
+
 	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
 				AMDGPU_GEM_DOMAIN_GTT,
 				&adev->mman.sdma_access_bo, NULL,
 				&adev->mman.sdma_access_ptr))
 		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
 
+	/* Create a doorbell BO for kernel usages */
+	r = amdgpu_bo_create_kernel(adev,
+				    adev->mman.doorbell_kernel_bo_size,
+				    PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_DOORBELL,
+				    &adev->mman.doorbell_kernel_bo,
+				    &adev->mman.doorbell_gpu_addr,
+				    (void **)&adev->mman.doorbell_cpu_addr);
+
+	if (r) {
+		DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
+		return r;
+	}
+
 	return 0;
 }
 
@@ -1908,6 +1928,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 				      NULL, NULL);
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
+	amdgpu_bo_free_kernel(&adev->mman.doorbell_kernel_bo,
+			      NULL, (void **)&adev->mman.doorbell_cpu_addr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 9cf5d8419965..50748ff1dd3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -97,6 +97,13 @@ struct amdgpu_mman {
 	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
 	struct amdgpu_bo	*sdma_access_bo;
 	void			*sdma_access_ptr;
+
+	/* doorbells reserved for the kernel driver */
+	u32			num_kernel_doorbells;	/* Number of doorbells actually reserved for kernel */
+	uint64_t		doorbell_kernel_bo_size;
+	uint64_t		doorbell_gpu_addr;
+	struct amdgpu_bo	*doorbell_kernel_bo;
+	u32			*doorbell_cpu_addr;
 };
 
 struct amdgpu_copy_mem {
-- 
2.34.1

