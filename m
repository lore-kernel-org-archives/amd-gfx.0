Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7511DC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0671011393E;
	Thu, 18 Apr 2024 03:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FqbeUCsY";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5F611393E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfYqFUlu79z+bORlgBnU8nFgZ6IE51HlADX65PqiTO80WY3jIZD47vi8d3eBulASFUPVqYqX+pm4W0to8hHjJ95sPyPDrESkrX7La76oyzfQ+P+L0GB2z6Zvcu4/QajuOcvTbAzVozmBasCtCvBjbzYnRMS7vO9TVt8vNRlY2GjcO7i8rZ8PQNEFzeeVEvhoDhU9CE/kv5nZnGG1pMXKslDAsmynV3xCn3u3VUZJT+AALLsF44sTFNDBCHuMt+QhaIp59N27tBqF4KKf4E1BMskKnJ4SzV+Lx18WwQCmeRG76XlC0UATYbryCFDgRK1Iso69B7wsarLz3au0YMT+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc4Odm5WngIbfC0oUkGagifzembFjU6t8oQPbhLeOwg=;
 b=JTmUkqv14E4H2+91UoQRrcShZ0amcCqY/Bg5qTke9VEYmLr4Q1Gh06ZTi1qO6+grwVfcqkYAHSHJlUfPnbfP0YySt8uAyVHeltBm8xRixCeCvwdyNHwT/xu6Q/eRg35nT+pqB8BJisInJXxOcwm1sUwQ5whBQI379js8gdHl/4mFhZv2XLSyePW4q2gmT6IaiWfNZ7Y+w72V5BlwvBkuqz+iJ6RDQ3i5cP5In9ULx+276Kvt08zlgulUnfgzbzBp2hNHzzaprmLmSFHvZ0nXwhc6NUdoL3qCNUI7FtFzca4SVe/jB98SWYMjoZKJdW80TaHNagqSlkw1SGJuLoLIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc4Odm5WngIbfC0oUkGagifzembFjU6t8oQPbhLeOwg=;
 b=FqbeUCsYt7mD6tjVIgICovQi90r6eiLykEt65IJ0HSsO4qYFmWj7RXHSAy679GGu9pH1YFeTWQ1D+TXj2b+eLDemsb+kM74gQItW5epPcs53qjgt6yCK2NiKxD6ghFwxnZR4bH99v+5lW/T+XF2FJAP5OWiuWPtTDfmuEiDC6Y0=
Received: from BL0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:2d::40)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 03:01:22 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::8a) by BL0PR03CA0027.outlook.office365.com
 (2603:10b6:208:2d::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Thu, 18 Apr 2024 03:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:01:21 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:17 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 01/15] drm/amdgpu: Add interface to reserve bad page
Date: Thu, 18 Apr 2024 10:58:22 +0800
Message-ID: <20240418025836.170106-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: f521fe46-80fd-4dbc-f49a-08dc5f53d389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OK/Q1DTRnUadENPBOZL/knvYuxzMRK9+K6eqM8gb1LRwWqMWVVxjJd7zuvB9oBb9mChOejr0oAr55tmwQj4VRnFCsPFeVgkM8Pi4HJUWm1Bsie4+qJ6nMdLuvzwJZuyB0ZdNJGavM3ZvQq1wNOk1CJAcyYVPB5qbcUX1B+F1woIa37/dsufwu9sOby6h8a9MWLcTxJExXNSTWGxCAhSPfh7OoUv7u+LpxhK73UeCAJaH/sIkeMS15fqQEC33tzR8A/Tg3T9IYBiwX0Se9K6+ZB5RsZIKEaXNVPX87i/OuZxAzZGOkO+KR4mpSFs9ccreORyAvAOIX+2u1etkyc22S8eWsqG/X/UvX5o+CTnz9aduPvmxT/YcjroVY8sCXqJaceU2ihDW8IcYSx0jmoR/moGlb9liY/wdxCw2Fs3/pIzdQPg8CvWp++J6NCGTz0i9qlAhSPmTreYUsDFHSV9Bb1hj4v6ayy8SeDNHai/YfWHmUp17wBvxCFXifCNz7iUm1KqemgP4E6bZs328Sy5HWrc4RJBm0VJuiL5j7uV0jrC34jyvkUkHoaQWziTzFNtYzsoW2w6RhZ26N9JaLRhCUlhrYuQf8o2tL1FldK0vVKYTN9iWUayC7/InadaY1Nk/QJZTBJu6khIUWeJD2S+RwUKkbSGwmBEDqkyp8z5c3JCPH0SQ7J88UoaTrQjPvcBGUX3MeCG52rJFrl2Rfj5L1vJPuBFuxQqOcAosmmnUa9Z2BNJUzNRc3MmJolD5Chdl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:01:21.3381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f521fe46-80fd-4dbc-f49a-08dc5f53d389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interface to reserve bad page.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2c97cb80d79a..05782d68f073 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2782,6 +2782,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 		}
 	}
 
+	mutex_init(&con->page_rsv_lock);
 	mutex_init(&con->page_retirement_lock);
 	init_waitqueue_head(&con->page_retirement_wq);
 	atomic_set(&con->page_retirement_req_cnt, 0);
@@ -2835,6 +2836,8 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 
 	atomic_set(&con->page_retirement_req_cnt, 0);
 
+	mutex_destroy(&con->page_rsv_lock);
+
 	cancel_work_sync(&con->recovery_work);
 
 	mutex_lock(&con->recovery_lock);
@@ -4278,3 +4281,19 @@ void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 num_instances)
 			amdgpu_ras_boot_time_error_reporting(adev, i, boot_error);
 	}
 }
+
+int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
+	uint64_t start = pfn << AMDGPU_GPU_PAGE_SHIFT;
+	int ret = 0;
+
+	mutex_lock(&con->page_rsv_lock);
+	ret = amdgpu_vram_mgr_query_page_status(mgr, start);
+	if (ret == -ENOENT)
+		ret = amdgpu_vram_mgr_reserve_range(mgr, start, AMDGPU_GPU_PAGE_SIZE);
+	mutex_unlock(&con->page_rsv_lock);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 8d26989c75c8..ab5bf573378e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -500,6 +500,7 @@ struct amdgpu_ras {
 	wait_queue_head_t page_retirement_wq;
 	struct mutex page_retirement_lock;
 	atomic_t page_retirement_req_cnt;
+	struct mutex page_rsv_lock;
 	/* Fatal error detected flag */
 	atomic_t fed;
 
@@ -909,4 +910,7 @@ bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
 
 bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id);
 u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type type);
+
+int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn);
+
 #endif
-- 
2.34.1

