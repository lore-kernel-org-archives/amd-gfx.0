Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D49C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 285B810E398;
	Wed, 29 Dec 2021 06:32:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B64C310E36F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Shaps5MmfMaL8J+6J2P1duiQ9ji53ao2Ozmnv7Lim57oRDegwy0NmcIggPAtj03cYQKgGhX8r6hw9sO84x0pkBRsotBrdJL39RGIsjQgZ46d9dLcUNjzg/NGPFKKglfKtdMrQwJv0yRvEW2E+83FPY/jTgZCWXvlvaQ3jXHT92etLmZwj6QCVRVTISXgdYsXcizM5k8j2NzFJWj8QJKZQQF7m5vYcCmlNZNHVW7bxXSfEfLT16a302o+DNa+xBQznDtF4hFjyh78pqsQhEJG4UsnRRKkR25mW7/pBicQWNN62yzFz2uu3HQBQtphDL4LDaqriM+tldrf4ZbPYJwlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeUTzjHSYo3192vzOy96wJcAJ0aXeqMusF8n+lDSH8E=;
 b=nI0m8ArM6Th0wRtmcgn/n/NO6Hy3xUMjRUd0YDpg5GWxoKXIVUsqMUFFBex45Pq+84L1TFmuDh5hWd1XLAINHuDCM6xrGlWiUZ5IYm2mHLChZ94amzbkA9lIDAocfZFd1nEZse7Dg8KZhUUxqOIKBLlCye1db5d5bwhhwD9Kc/346oEA0NAZcBCLFWFsdCkTsY49iFw2Ox9eZ9Jlf+x+nEiHvl0yvZEGLkspkc6jR4SeClPCDbmZXeEcexITxtrNLCGZJbx/DAsTY41NKB7PWYQGUuF4eBKyscOyuZESPfzNDxWf46+o9mX6ZZHRLNOqlSJLAIh26X0qgKVdkDqdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeUTzjHSYo3192vzOy96wJcAJ0aXeqMusF8n+lDSH8E=;
 b=RpUwkCrUVNXou8QrPxjK42cuaNjlBFXnv67qzbSz1tPCd9uokAIjlvupfLZbYGMmpk2B/+PIhQhHATiPrVFdSxdwr2lT531ONQDOa0xgWzkONcwH0J8wXbntE3R+HO7n8iMnk07vx8bvHUm+2uEAapiZ8Dy4urRCynWAozxwTRI=
Received: from MW3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:303:2b::9)
 by BYAPR12MB2968.namprd12.prod.outlook.com (2603:10b6:a03:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 06:32:53 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::d6) by MW3PR05CA0004.outlook.office365.com
 (2603:10b6:303:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.6 via Frontend
 Transport; Wed, 29 Dec 2021 06:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 06:32:52 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:32:50 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 01/12] drm/amdgpu: Unify ras block interface for each ras
 block
Date: Wed, 29 Dec 2021 14:32:00 +0800
Message-ID: <20211229063211.43840-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6e5539b-d67b-4cb7-9cb5-08d9ca950ad7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2968:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29681C190909C1078256B340FC449@BYAPR12MB2968.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1oUfYyW2VDVl0zDTmicoAmqdMjYWccbW+bAHX/NS2j3vu05oPvzZjbT15UjSbBoASckLbbrrUzZXD65eX2eQ3pgWv1Xa1cdf6fuofDF0C/KmFwQdMERlsX/mUc1wyIQQjffKj8YqXngZaSltEPx7zL5/r58stFLk1TqUoH5e1PXP9XVubaQDuFaVwX8GYwXK2w6amzN08M0/NrjHan2KqsGjj842uD7LI2j6C2zd7/HK3bGCBU4+6ufDuV3I6W5Tj81DE+lR5VUkDBO633kC8GWclqye+6ShsDR9mlP7N29I3ktO+xGpLjK8Ni8n/R2D31EdrMlI10ZR0JimztQ6L/2Yr+/gyfWvuEWpjgyw1TNImZcfIRPWNYX7cosegjb8dbeqbxicR4Js1xgV1fb2nl8m4a/TqpEv8Mwtb7pQd4q73+QaIe5c53Irqu0iqUbWr1DzkbvH784IrqPPvpYA6KeYZUkw0rREEg0fwZUpUHTRzRWqBwsf7KAlJTiRjSu+n8R2PNJjLJaqCMhJb6dA4VtfoMN0Df/5oah4FeaTUQpgoNpvnJGSkkezd8qrcnFxnEwKAiS1uILNqMHWmK9GNO4Oz4u39G9kPPuGpD0ahTqxHlZCJhhvoIUSm6GmYADX39vZI1OCsbGwFSlVBrP64FJckJyI94t/vbPlljuERic8xrkEXy0lcQzTJUxpd8NOoNmJ2K9W8o0MNZ/3+NhLSkJONUNwkNvEHkCnTLZSoxlZXURYeaoPAgbesZekd/OSwCUhT2672mrO9xwvBV4SZ3wPCvqWIPf3HhVh0m6a5GlySfPbHuWAN9uSRK4vpCkRa/EV2E8lPGJ3rNy9dacSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(1076003)(82310400004)(356005)(4326008)(47076005)(81166007)(7696005)(336012)(36756003)(6916009)(36860700001)(2616005)(426003)(6666004)(86362001)(83380400001)(40460700001)(70586007)(70206006)(2906002)(16526019)(8676002)(316002)(54906003)(5660300002)(8936002)(186003)(26005)(508600001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:32:52.8601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e5539b-d67b-4cb7-9cb5-08d9ca950ad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2968
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

1. Define unified ops interface for each block.
2. Add ras_block_match function pointer in ops interface, each ras block can customize specail match function to identify itself.
3. Add amdgpu_ras_block_match_default new function. If a ras block doesn't define .ras_block_match, default execute amdgpu_ras_block_match_default to identify this ras block.
4. Define unified basic ras block data for each ras block.
5. Create dedicated amdgpu device ras block link list to manage all of the ras blocks.
6. Add amdgpu_ras_register_ras_block new function interface for each ras block to register itself to ras controlling block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 46 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    | 28 +++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index db1505455761..eddf230856e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1151,6 +1151,8 @@ struct amdgpu_device {
 	bool				barrier_has_auto_waitcnt;
 
 	struct amdgpu_reset_control     *reset_cntl;
+
+	struct list_head		ras_list;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 73ec46140d68..0980396ee709 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3578,6 +3578,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	INIT_LIST_HEAD(&adev->reset_list);
 
+	INIT_LIST_HEAD(&adev->ras_list);
+
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
 	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 90f0db3b4f65..9dd698354e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -862,6 +862,40 @@ static int amdgpu_ras_enable_all_features(struct amdgpu_device *adev,
 }
 /* feature ctl end */
 
+int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if (block_obj->block == block)
+		return 0;
+
+	return -EINVAL;
+}
+
+static struct amdgpu_ras_block_object* amdgpu_ras_get_ras_block(struct amdgpu_device *adev,
+					enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	struct amdgpu_ras_block_object *obj, *tmp;
+
+	if (block >= AMDGPU_RAS_BLOCK__LAST)
+		return NULL;
+
+	if (!amdgpu_ras_is_supported(adev, block))
+		return NULL;
+
+	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
+		if (obj->ras_block_match) {
+			if (obj->ras_block_match(obj, block, sub_block_index) == 0)
+				return obj;
+		} else {
+			if (amdgpu_ras_block_match_default(obj, block) == 0)
+				return obj;
+		}
+	}
+
+	return NULL;
+}
 
 void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
 				       struct ras_common_if *ras_block,
@@ -2739,3 +2773,15 @@ static void amdgpu_register_bad_pages_mca_notifier(void)
         }
 }
 #endif
+/* Register each ip ras block into amdgpu ras */
+int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
+		struct amdgpu_ras_block_object* ras_block_obj)
+{
+	if (!adev || !ras_block_obj)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&ras_block_obj->node);
+	list_add_tail(&ras_block_obj->node, &adev->ras_list);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index cdd0010a5389..9dbe8d49b891 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -469,6 +469,33 @@ struct ras_debug_if {
 	};
 	int op;
 };
+
+struct amdgpu_ras_block_object {
+	/* block name */
+	char name[32];
+
+	enum amdgpu_ras_block block;
+
+	uint32_t sub_block_index;
+
+	/* ras block link */
+	struct list_head node;
+
+	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index);
+	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
+	void (*ras_fini)(struct amdgpu_device *adev);
+	const struct amdgpu_ras_block_hw_ops *hw_ops;
+};
+
+struct amdgpu_ras_block_hw_ops {
+	int  (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
+	void (*query_ras_error_count)(struct amdgpu_device *adev,void *ras_error_status);
+	void (*query_ras_error_status)(struct amdgpu_device *adev);
+	void (*query_ras_error_address)(struct amdgpu_device *adev, void *ras_error_status);
+	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+};
+
 /* work flow
  * vbios
  * 1: ras feature enable (enabled by default)
@@ -652,4 +679,5 @@ const char *get_ras_block_str(struct ras_common_if *ras_block);
 
 bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev);
 
+int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct amdgpu_ras_block_object* ras_block_obj);
 #endif
-- 
2.25.1

