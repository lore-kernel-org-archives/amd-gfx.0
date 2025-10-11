Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDFFCCD184
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 07:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 595A510E2E0;
	Sat, 11 Oct 2025 07:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NLZ3/I2Z";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92AD810E2DE
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 07:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVyKbiVcUhVHCKsPzOUxlzBHyWEc0kagqKSSaBHX2RMdgMct61mv5kZvyJg7uo1mVC1PCS02s9toX03nMbys8m/TxqXn5r5NdVfnFWP221gvF9O1fU6ve3rQXBIeJOKWRCrIvEbfa5lHnJXTzDj6sLZ1SiUV6O/f3osD0EzhF/SJLg4Vbqv+WjW/xFt62nV3iCwgzOc7up+JNy8RN4K2O6Fv4CCuG6x41JG5+h3u0suvKekJ8WPowN0mGZ602aLfLGHhJ7wASEf/h+dRdHoSCJcrsUiJG3Jii8PDEdayoYzOpNc3YBbZCXnsCBysInZBd3TaeBXgn3GmW0ChlyXCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oaUh7MnWzDiUKjG83gg2QgHSAiuxegUbGbduCVnpCU=;
 b=N7rEvBcofRNZBr+AP9aw+888hr+mJeRMp7+++QKe6XTxVwvydQQyKJu7wnNfGGuFbxBN2DP9/XqO/6TivlW84GR0oQGzj/FPnrskMuJoSGiZlfpMDzX3fZLrsOpQc1BW7CpY78rQOyW7ukxeIqcLRuFNkdbTt/uT35q7sjwwiwYzbSHAoWt+ZOGG4L8AR6WWMmySiVJoM4UdoOYSqVMXBu3vdPmlve5IJfd8K/DEquHy341aho+7rZH5EkfEvsNqFwqSiDXpZqCWxb18Q/9ohwWkk7uJQ91e6/EZtfAX72oL3QMn3wZcPdKiD5WpCn+f+8KW3tqIXgZfwte/EduDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oaUh7MnWzDiUKjG83gg2QgHSAiuxegUbGbduCVnpCU=;
 b=NLZ3/I2Z3eXH1PLDDcS4cn5WxUNpSoiPadw5sco+EPVV5Y9VgJb4tSNPBeLBUjUDXUiZEsIewo/FVdWtqkR2GwhzAyNLjikHmnOcxU4zsZ6AUecPBcSd7RrOJnmk3pw6QysTNlZt7MTQ7b03AwrGnxtGXyr6x2GtBVao032WBmY=
Received: from CH0PR03CA0077.namprd03.prod.outlook.com (2603:10b6:610:cc::22)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 07:50:04 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::37) by CH0PR03CA0077.outlook.office365.com
 (2603:10b6:610:cc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Sat,
 11 Oct 2025 07:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 07:50:03 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Oct
 2025 00:49:59 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/9] drm/amdgpu: Improve ras fatal error handling function
Date: Sat, 11 Oct 2025 15:48:06 +0800
Message-ID: <20251011074811.533871-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011074811.533871-1-YiPeng.Chai@amd.com>
References: <20251011074811.533871-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e84c01e-a052-4b0e-0115-08de089ac9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4jdYMEa68d8Nuk43dOtkWpgeM+xBgrcaBYGJsrhBoWc6mAvHlWq/Q3hQDRwi?=
 =?us-ascii?Q?wPK63eCEbGSHCD4aAY0/JT/zHk4LJRatRQCT5zyGQV6EfQf5WcB0FjMrCYrX?=
 =?us-ascii?Q?P+N9prh6hdST/2R0QWo9txlXSQ4+okScbobm41UN5CIQF0J6K65z4fzfENny?=
 =?us-ascii?Q?hUypcbANa4J1FUsGLhiXFS/H2yMivzOWoh07XR+AFyNMxk+3o+T3IfKPWcoD?=
 =?us-ascii?Q?5r/59f8b0ZmBe8xjEdQguxKODHLa+LcaNjDvEgCrmKzD2CTxNA7SixjCZYSv?=
 =?us-ascii?Q?0YYuzR8N7egA7W0saW3sMMEOKNzsgVUodLdewxafImTzVD0uh0hHcdn8ePex?=
 =?us-ascii?Q?7kC1I1QF5AQMzyvXisaovlzfp6JSIgewo4vb1c0iYPDl3UyuPnRCt+Ird3vB?=
 =?us-ascii?Q?sqBD2ymC1STpedby/IZTV8Tj6YAY/PzcAvj1jTAsv0dRaaeXqqsIyRQVTWW3?=
 =?us-ascii?Q?xSWJ6EbZbfLl+T4mUoVLh68g6f8ALzSm+G0uEsY6HbgGHblGbV5MMbHmraO+?=
 =?us-ascii?Q?gSBr+vEwbB5hR/M05FusTTYACcwVUzEyOE+6+oWA2BxR3IqIVF+2CrRAWlVx?=
 =?us-ascii?Q?8E6sRmH1zPww8z2os7o18Z9tzU25zht8y03Y4Ee+xgzpPDymnp8gLHZ2+vIO?=
 =?us-ascii?Q?3md5GHqPG9BGki5tgFF4Kw5cY/mqwpbPcLT4Y9j9qdKSVISvHmgQAttu++zM?=
 =?us-ascii?Q?dIqkCvaFX0y2vidonBhmUBOOf0S0Tsza9ibeIKvN5KxnAB2+iowMDKVD0sV1?=
 =?us-ascii?Q?cta6KwPvMyUzZZt73LXe3v0bYcYFDz9URWwxLgmIZxDnn4Lg02jEAYE8Bip2?=
 =?us-ascii?Q?04XF28Oje83buncggPLXTazmQeHpTYpsHWDGPwBAGy6ofU683Sn6zrCPPaqZ?=
 =?us-ascii?Q?0mUAizep3HxFRpIi72j3ZkKzm7Wg8027LqGcDyDNWsu0lnXv9okJIU2ij2gc?=
 =?us-ascii?Q?9faftBpY7/Wl0E/CgdYn8EZI8J/y2uUh4qrgp1cOna5G+jaPSNZyqSnclzk4?=
 =?us-ascii?Q?mqEeeE4pAZ+EdEdaCoJwTi11DYgH9489UzjIQLlp7ywGC4U4ldJHmqzYxrzS?=
 =?us-ascii?Q?7RYW7HEU650tQdKwcWyK67ymx4tqI7ObM8uzMh6kEyi2IEF7rnCjAkfdR2Ui?=
 =?us-ascii?Q?sjQriV/SCOdhx+xNVG2RCaDKtaLxWmZ0qG9Ihj5VgAddx5K7PWn5P9xFHMup?=
 =?us-ascii?Q?beA9tYhM9y6AVTJvvSGfzUXR3kFH7tAXlGDST9f+UhfrWi88sevKVeOi3ICZ?=
 =?us-ascii?Q?Oabfthv9qPGwXzfKy6uDyY2l5l6enT5Zdf/h4PfJXmAlkZkFaq7BHf+UCsnd?=
 =?us-ascii?Q?zLeCl+SsVvM7dkrJLRqT9z/AF98Ahrqr8h5REEHSLbcQPJJoDBiENQe4RNac?=
 =?us-ascii?Q?xj7/FkYRU2qnnLQ54hqP74Uib2QpW2iD+bB5c1V3eEWQ4CH40dAhf+Xg97eR?=
 =?us-ascii?Q?Yf027GkgXd3Cj3pWAx7JNEl+XA7SxoBefa7shNpGAZ92UlVNdegPIb5upq7o?=
 =?us-ascii?Q?KtBd4BEDyg6dzrn+09KMRHb2tKDvF5NaeukXSDCzDan9komTluY8roCPTb4T?=
 =?us-ascii?Q?0ujRcYnWEhOA3RJgt2E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 07:50:03.9368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e84c01e-a052-4b0e-0115-08de089ac9fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012
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

In multi-gpu case, a fatal error will generate several
fatal error interrupts. After improving this function,
the ras module can reuse this function to only
handle the first interrupt.

V3:
  Initialize event_id using RAS_EVENT_INVALID_ID.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h          |  2 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c |  5 +++++
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 025d8bcf02eb..9b7afddb4a16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4650,20 +4650,18 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type
 	return id;
 }
 
-void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
+int amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 {
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
 		struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 		enum ras_event_type type = RAS_EVENT_TYPE_FATAL;
-		u64 event_id;
+		u64 event_id = RAS_EVENT_INVALID_ID;
 
-		if (amdgpu_ras_mark_ras_event(adev, type)) {
-			dev_err(adev->dev,
-				"uncorrectable hardware error (ERREVENT_ATHUB_INTERRUPT) detected!\n");
-			return;
-		}
+		if (amdgpu_uniras_enabled(adev))
+			return 0;
 
-		event_id = amdgpu_ras_acquire_event_id(adev, type);
+		if (!amdgpu_ras_mark_ras_event(adev, type))
+			event_id = amdgpu_ras_acquire_event_id(adev, type);
 
 		RAS_EVENT_LOG(adev, event_id, "uncorrectable hardware error"
 			      "(ERREVENT_ATHUB_INTERRUPT) detected!\n");
@@ -4672,6 +4670,8 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 		ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		amdgpu_ras_reset_gpu(adev);
 	}
+
+	return -EBUSY;
 }
 
 bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 9f21b6cf8724..556cf4d7b5ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -910,7 +910,7 @@ static inline void amdgpu_ras_intr_cleared(void)
 	atomic_set(&amdgpu_ras_in_intr, 0);
 }
 
-void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);
+int amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);
 
 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready);
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 40071b876333..f21cd55a25be 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -29,8 +29,13 @@
 static int amdgpu_ras_sys_detect_fatal_event(struct ras_core_context *ras_core, void *data)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	int ret;
 	uint64_t seq_no;
 
+	ret = amdgpu_ras_global_ras_isr(adev);
+	if (ret)
+		return ret;
+
 	seq_no = amdgpu_ras_mgr_gen_ras_event_seqno(adev, RAS_SEQNO_TYPE_UE);
 	RAS_DEV_INFO(adev,
 		"{%llu} Uncorrectable hardware error(ERREVENT_ATHUB_INTERRUPT) detected!\n",
-- 
2.34.1

