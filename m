Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117FBC05027
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 06:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52EA610E0B8;
	Thu,  9 Feb 2023 06:18:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5434B10E0B8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 06:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrLmA0mGIGpLW1J6/u99kD/wZnG+Mmz8VL4q71MPrnXaBTutpMXqhIGqhP1Yk+MZyNkVCdKOhgv3jUHf58gG28i5nQqGikjP5TlVHIBQkrHtaSwmaEoQCE7DG/0IdP7EH0Blv+y67h9sHH0Xa8FcNJubfpWm+ej/bv+oy7z2XGROFjbAxPYDRC60VWjVTnkj545FuCL7W5BGputQ1M2LW+IwR+l93Wk6WnlBDX91D1dL1d0idMnbnnugTz778q51OthZbiSW+/T7l8HwxuFMbrsitCbzMH6tuwiqSIhBQpEbQ7FofcD0xcKgoXjfQgsQ7Tllj//Nq+WYlbWv07Q/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opkYjPVrs297bjBNKZMlI+U2YMlXbKAMRl4rPRnoe/0=;
 b=lZvv++usCW3YwOmMF0EOePJZKKYL0EpCIOwgIQhXjPj0vVhvDIaDlUiyzFYoy/oGyVezLOUpXhhzkhsDKS95nTNhz1Q1bRbX9bI4x7hhXxi2hr4v6dKI+0+HMRS3fUn03d8hJMUO3Mut06n4oavBfh/k3g4Ozyu5Gt+2ODKrF50zhP9rUfbrwHYZN2wavGJA50vZ4g+ay9upUC+tprDNRntyJt45aWDyLWtjj4jP3JTkjZ09faEmUpG+hb6BuoOTHBW5MAOiqeRd9/+eqeoTmnW326dpwKTDkH1ZDh13ozjKmOzMPVU6Ds0LmgawtxrgbCPtranBYIWAkovLy1ys0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opkYjPVrs297bjBNKZMlI+U2YMlXbKAMRl4rPRnoe/0=;
 b=LRFpqQ1kvX6MktKznoSGvcHN8AK0LYj5Srq0taT1M14bN6vM33oUsOYrB3koEnnqn25Tcq3JhlJE0pcI2qKjjmwtik1rNSSjnM2Pm+uqSfCaFXWuJfh2Pl5js0zucgFry8wWL8eA/jy76Ht/HF1IaCPcFZKbAXPzFbi9kYoR5Sw=
Received: from DM6PR17CA0036.namprd17.prod.outlook.com (2603:10b6:5:1b3::49)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 06:18:09 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::55) by DM6PR17CA0036.outlook.office365.com
 (2603:10b6:5:1b3::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Thu, 9 Feb 2023 06:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 06:18:08 +0000
Received: from ruiliji2-lsy-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 00:18:04 -0600
From: "Ji, Ruili" <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: To fix sdma page fault issue for GC 11.x
Date: Thu, 9 Feb 2023 14:17:32 +0800
Message-ID: <20230209061732.1718695-1-ruili.ji@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f43566-05cd-4787-ddc7-08db0a656a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSelwO3hghjFcnObGhdcp+ww5+1dk+5Gg6GmdOH0AXI0IyljnODMVum2dtEKKHujP9hZcceBTME1EAwrAO0EVeM6DY/efqFkYwViQfI+epF1QqJI69lHMTVhDnqH+J0wL3/eIZGx/gPIBWiXpU5pmGPG+aKKU1Luccifa4h+C6ZYc6vz5VAwpuk3tz408MssdRtBTfzJlGYQZ78/2Ou4ofAs0N64s3vqz3hVItykJvY9m0rLos/bcTHT3W0l6JnHnNH7u1Uj0qU/I6Vzc8uB+CMe6FqpAMF6tHy2SJE6llcMqH6fz7WGl/mI1GEow+yunmcKWmlURgZFRYA7iRZfjYVJZvbTgdNvfK4wauNJkaJ3NOKoV2nMytiIDmn2MfgC5q+6U5UggXnbNX1FI/HIPse7T7WF7AbD/dvEBFro/oVJNc/zc4P7/5s1V0wxNH2ISMwFiO7XH8l1JeJLsG+tODuyeFnHG3HvRklsQew78r9QToTsYlExvCIIMyJWvLD3btLj9dNfdcCJffkQFOGIsg0spjQdSziKMXnKETr6mHZwqAy7nDba4FuvEd22arxt1nW1XgHvLiarGcLqrSormJsUwt29eyTmYKl3dfy3nLwwgCEyCzQPJ7wQEFXb6VQ4kOlAk3cpeXAW0OXRupDEnaAd4DU3RNU9gY8wv2tn/CCR+JJjaCYJCJOmXn4/qUh2YRK+l9/WUoRcscibbnYtCZud7sCO5B5NaXhuoiN9OZg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(54906003)(6666004)(2906002)(336012)(8936002)(40460700003)(36860700001)(40480700001)(36756003)(5660300002)(356005)(47076005)(478600001)(426003)(186003)(2616005)(26005)(16526019)(41300700001)(82740400003)(4326008)(7696005)(70206006)(70586007)(8676002)(6916009)(82310400005)(66899018)(1076003)(83380400001)(86362001)(316002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 06:18:08.9282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f43566-05cd-4787-ddc7-08db0a656a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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
Cc: Alexander.Deucher@amd.com, yifan1.zhang@amd.com, felix.kuehling@amd.com,
 Ruili Ji <ruiliji2@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ruili Ji <ruiliji2@amd.com>

For the MQD memory, KMD would always allocate 4K memory,
and mes scheduler would write to the end of MQD for unmap flag.

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c06ada0844ba..7a95698d83f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2373,7 +2373,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	if (init_mqd_managers(dqm))
 		goto out_free;
 
-	if (allocate_hiq_sdma_mqd(dqm)) {
+	if (!dev->shared_resources.enable_mes && allocate_hiq_sdma_mqd(dqm)) {
 		pr_err("Failed to allocate hiq sdma mqd trunk buffer\n");
 		goto out_free;
 	}
@@ -2397,7 +2397,8 @@ static void deallocate_hiq_sdma_mqd(struct kfd_dev *dev,
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
 {
 	dqm->ops.uninitialize(dqm);
-	deallocate_hiq_sdma_mqd(dqm->dev, &dqm->hiq_sdma_mqd);
+	if (!dqm->dev->shared_resources.enable_mes)
+		deallocate_hiq_sdma_mqd(dqm->dev, &dqm->hiq_sdma_mqd);
 	kfree(dqm);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 4f6390f3236e..4a9af800b1f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -308,11 +308,16 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 		struct queue_properties *q)
 {
 	struct v11_sdma_mqd *m;
+	int size;
 
 	m = (struct v11_sdma_mqd *) mqd_mem_obj->cpu_ptr;
 
-	memset(m, 0, sizeof(struct v11_sdma_mqd));
+	if (mm->dev->shared_resources.enable_mes)
+		size = PAGE_SIZE;
+	else
+		size = sizeof(struct v11_sdma_mqd);
 
+	memset(m, 0, size);
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = mqd_mem_obj->gpu_addr;
@@ -443,6 +448,14 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
 #endif
+		/*
+		 * To allocate SDMA MQDs by generic functions
+		 * when MES is enabled.
+		 */
+		if (dev->shared_resources.enable_mes) {
+			mqd->allocate_mqd = allocate_mqd;
+			mqd->free_mqd = kfd_free_mqd_cp;
+		}
 		pr_debug("%s@%i\n", __func__, __LINE__);
 		break;
 	default:
-- 
2.25.1

