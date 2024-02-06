Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89925C4829F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F68112CA6;
	Tue,  6 Feb 2024 15:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CoRY2fBh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8E310FD8A
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYLIPkcawkJUIa8s5fT1nKcS6HyY54lPnLYjtYSOGPPcbI2tkiMH5hC7L+hSFnkzRUNMLaMGv2SJ1Vl0FF+ItaloDbJGNATA6C5S1ypKNipyJfxqx/bVcYsHml54YbSxOiBYIoVC8QVVgIzxP6SD2YnS4vLVDVHLTwx5ouTQLSdXlNOPUXeD78Dc5CBbJJhnKho4ZNzOymqXzz24W4Uk/G5h0qPq429Ph3r0cc2LHU0oe96W0FxKNiE832owMvVFqLlpSACcK1aXzXNYDnGclkOLMAGkwuxNqnKNDQP/bTwPzW/QdrkjH4r0/SNuDXrgpPSPwZou0tlMsLZVVk44vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fn37+D8wmJCLraWQdtlgCzEo5KAUR2K5262flJVZOxA=;
 b=VB+ysnChVn/lspbqEEIZxtmfH3mYhn1dWXL6fVix4m0YMmjohxv6z12udbo8DD/CxC9OxssXFVt889l9mYuyUKnfGYZZMEKOwGdHN1r4U2SodEnl7u1wZXFSaWB2VOGe1zR1wuN2gwfKF8ZClzAHR6of11Xl2zD9SBkBJtX6le5GpVBryYwG0vH+HdoEKx35k4NgMf/K61KZBvUHwC+9tyUnARnOLkvuYj8WKRpr5KiS6uTPpoAxCXSDxMXJm5LbM7EnBWjsNmin+dCvQwPnDn0pzBuQ9UjeJ8xTbSbRkJ2g05NXSxH3MqHuV48mHR1FggeiSZTVtSdUJWUEElUKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn37+D8wmJCLraWQdtlgCzEo5KAUR2K5262flJVZOxA=;
 b=CoRY2fBhquoxl25/wF07UWpdBwgd5S+WNBST4jJHTJkXUt2pNU2p1ZJic8UG3qme9BkIXZDLLrZia9BWcNUP3ngWGrWKo1ZOmVL+YfATqRMmj2zqqnIV/W/Z05Wc0Ulg02a1hPIIMW3JX5BfTQ/2hG508NcAOsjJyaSQDA/chPM=
Received: from SJ0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:a03:39f::30)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.14; Tue, 6 Feb 2024 15:59:38 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::5f) by SJ0PR03CA0235.outlook.office365.com
 (2603:10b6:a03:39f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:38 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:34 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 06/24] drm/amdkfd: add trace_id return
Date: Tue, 6 Feb 2024 10:59:02 -0500
Message-ID: <20240206155920.3171418-7-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e973f9d-9baf-4e41-f3a3-08dc272c9f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnICv2XcyLgPagA7+T3avOkXCgD5kNOtupAP0y1P5OQ57pAAptr+XV/NHpLTz/xP/OhVL+QgRdsUvcaNVUdRYYpmWGlhF8AKVrvbO5sFp0a2L1RsQY7B54BBXYE66CFezCKbWo5qnBZsj7maPouXa3FfTqC8dqxmS6SLDHqC4Pxt6LAj+0L7cWzXOwWY0AmTuWP2s2calwWkN8pONYHNBRFIoI2plDZosG4jlVhzMkU465+OzI94XHyAGxLIY1XdzlKOgXs0gR19nbgE3pQ/4Xzdj/4+9J7xwcmXSkOZvspdi00jGhUoeVSathlPRjsOCxjqJI4KJS9+draH+VZ8NMOEfQAKrYty17l24iko2cypzzIKkdiSmg1d+pKkBW+bbTfQZz9UOHHrDOik9x+kdLz6c3PaVOEbYgZ+B88Vqtkar+D9lgsB0+RYK7ryznDyQUPjvWMyqGVM0VffLx5CzCSUDBbAOWk+tHe+ziysvVu8uncfRTtxNsS1JPT6XkCGndkXvbgIYbnL4mRU5/3Vs75WzFdcRpywyO3lXK0weyXeLQxRN9Kg97XlQQIL26AnXPQJTZc28EBa23A2pN374sHHhgc+nyy+UPAkEntA7c0mm+5lBdt2wIH2o+AK6Y7DNL8RXw+jmb00g1Y//UrskiEWeP9TEkqYmViiR4LNOZ9Caq77nI6KE1hnDP6hDteQSYBnbPOPa16iKfomFaxEGSpdL+bGdrMF6qFnDlatve0BhqR/5Y3E4aWOyIBTpZvugmgh0Kzz8ID3V8TdvmIDaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(478600001)(16526019)(26005)(426003)(1076003)(2616005)(47076005)(356005)(82740400003)(81166007)(336012)(2906002)(86362001)(36860700001)(8676002)(70586007)(4326008)(316002)(6916009)(70206006)(8936002)(7696005)(6666004)(5660300002)(54906003)(83380400001)(41300700001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:38.4105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e973f9d-9baf-4e41-f3a3-08dc272c9f66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
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

Add trace_id return for new pc sampling creation per device,
Use IDR to quickly locate pc_sampling_entry for reference.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  6 ++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0e24e011f66b..bcaeedac8fe0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -536,10 +536,12 @@ static void kfd_smi_init(struct kfd_node *dev)
 static void kfd_pc_sampling_init(struct kfd_node *dev)
 {
 	mutex_init(&dev->pcs_data.mutex);
+	idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
 }
 
 static void kfd_pc_sampling_exit(struct kfd_node *dev)
 {
+	idr_destroy(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr);
 	mutex_destroy(&dev->pcs_data.mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 9267de0bbdac..a607fc148958 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -110,6 +110,7 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 {
 	struct kfd_pc_sample_info *supported_format = NULL;
 	struct kfd_pc_sample_info user_info;
+	struct pc_sampling_entry *pcs_entry;
 	int ret;
 	int i;
 
@@ -157,7 +158,19 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 		return ret ? -EFAULT : -EEXIST;
 	}
 
-	/* TODO: add trace_id return */
+	pcs_entry = kzalloc(sizeof(*pcs_entry), GFP_KERNEL);
+	if (!pcs_entry) {
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		return -ENOMEM;
+	}
+
+	i = idr_alloc_cyclic(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
+				pcs_entry, 1, 0, GFP_KERNEL);
+	if (i < 0) {
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		kfree(pcs_entry);
+		return i;
+	}
 
 	if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
 		pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info = user_info;
@@ -165,6 +178,11 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 	pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
 	mutex_unlock(&pdd->dev->pcs_data.mutex);
 
+	pcs_entry->pdd = pdd;
+	user_args->trace_id = (uint32_t)i;
+
+	pr_debug("alloc pcs_entry = %p, trace_id = 0x%x on gpu 0x%x", pcs_entry, i, pdd->dev->id);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 96999f602224..2df240518d1f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -271,6 +271,7 @@ struct kfd_dev;
 
 struct kfd_dev_pc_sampling_data {
 	uint32_t use_count;         /* Num of PC sampling sessions */
+	struct idr pc_sampling_idr;
 	struct kfd_pc_sample_info pc_sample_info;
 };
 
@@ -756,6 +757,11 @@ enum kfd_pdd_bound {
  */
 #define SDMA_ACTIVITY_DIVISOR  100
 
+struct pc_sampling_entry {
+	bool enabled;
+	struct kfd_process_device *pdd;
+};
+
 /* Data that is per-process-per device. */
 struct kfd_process_device {
 	/* The device that owns this data. */
-- 
2.25.1

