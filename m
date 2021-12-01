Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5514C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31696ECA1;
	Wed,  1 Dec 2021 10:53:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55CB56EC23
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr4Q3oxciG6gAVNEX7o46pzFp3Sss/nI6qdI8Tk32IANW0fbW1rUaufpGh3chjwstSL7QB0D3oGCqtWuGAJpYI0drBSOSNfWeQ0+G22EAcy/RxyiIhz+7cSNpnG0vxyf/KWKChoFMYlsa/xIQahOZjZCLjw01BRZqKpFGTcsWpb5xRrwCqNbi2eKoFN7BbMAJlynLtAPE95+D4VH3tAhJvFkdRjKbNaOwPfCM2SCyeoqauqfxa9UeWEnvXept2Afm4DgO0Zp1isteX6Hgv87510AG+8nj0IKGIf5hTFEdNir8USeCDnPz9WSv1LaQ8fa9RDmaP8h1JYI9vp35Ia14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZCAs6YRYqtzDuxM+lC3KDPQ83pEgjrvHHnNWIrG+l0=;
 b=PpqF1KWW/hJcZq8HxX1vAUFxU6UIi2qwPxC5BgbONNtX7N8NDJWKGpB+dkNtlt9BbjHL8vbtprzU1eM6U4k0IADaySjVkiKUffgB49Fd4IDoJ6RxfPd0JngDgGQSw7Cofoj0DzDVMqJHJo0UPixzQ3E1EVGsK0skp/+s97FN726dDdAiB2lkxYOaBh3XK3xecB2/CiMo9cLTQ+WXx8QPEYVG3fUDumn1rHVGqxDmBtKbjR8DlxAA4j2HwjL+FG3rngr3F4Qs30gA4qEnGXeCA6Vkbu6+tpR5W983UZm75wsuXnj5ACqlueFTEhDKXjNK1QTMTelGJOm7/PpMjukm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZCAs6YRYqtzDuxM+lC3KDPQ83pEgjrvHHnNWIrG+l0=;
 b=uAiLNAnHBBtzqDZCTT3WWqOyohRoMa2kKuNN1QL+U72Dt5hLqKS6sY+/30agq0JAZSmESTl0Qpm8Uqb4yqq1aCQnnwxwCS3leZ6jXDJUVN4OGYyDSt+XefpGwPm4JuX9ATw3L9SeVsm8Und2zG/ubKDifgAZAi4gZpwEbIXjzEU=
Received: from BN9PR03CA0220.namprd03.prod.outlook.com (2603:10b6:408:f8::15)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Wed, 1 Dec
 2021 10:53:35 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::93) by BN9PR03CA0220.outlook.office365.com
 (2603:10b6:408:f8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Wed, 1 Dec 2021 10:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 10:53:34 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 04:53:32 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 01/11] drm/amdgpu: Unify ras block interface for each ras
 block
Date: Wed, 1 Dec 2021 18:52:40 +0800
Message-ID: <20211201105250.298525-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d987a81-e565-47da-9b10-08d9b4b8d272
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5317CA22A99FDFCED560D646FC689@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmgBg01nJHL/KOOi4LLDxE13Vo6yASWRAsFeV2ymE5BP6eLvlZwovJSALtVLmcPlGFpdsw751dfP//5UYLCeN22cJT0ggk2gKugH/MLAxtpbzSPsYc8+X51YvTVkwMSR0e6G1AWpsWEt/fKBUb1LrabA2Ae0GktoTqgUxGIl6eEVv3+Ckx2Rgd61G9wrYTyYm1Ntx6tbx+rH6vIoaiLHiZCKYAGCETmxoTVavah14vSGBR0wzq55a6PEHFsMNBalHpwIgcIHTGBQls1liGMXGUn8wmguJv/g6n8TA4ZsI4TeHvG3UVZpGl0nWKlyj4KgFU6qZp7loQGs867Tq9JBHPWr2f3RAyBskPhozVQ2ms09Ll32h/9kCq4xR4EyDLUQq+Ac2u0oCHDv5X9BMqovsezVMBDAfuKSHnZnFGYXCc19mtWsyqLr61vPj89ptyEKeb77oLLCujzlE82vlGyCwjpmEvBS7ywuHuusqBRy2fglPcD7dO+dPh5duaSJrEzReSuKHma45X7DlEsSn6A7E/UG1OO8cnSvdL0gDaDxfY7RB5RL/khca4h68qKQyBjOOdG/hUpvff7ycH2DaleixvtOZgkDvafq07pzEtVBDtut4M8KCqDLxLkzzNeuiqd7whbv8sXXYxv+zJ0ktCIVsaMOlvGDzqrF8JDtD83EmwW00UdUF9ZMCDC4raqM5Qn9dcke73PLn9dFhX8MSF7ihTF3NQqU7mLpgTc1eIuTaA8CyegnceswWNJp17VzYsdZdIwZ+dfOzjWxnQe+YwJBzZbAK2ujZ4fcsUBq2Wfr3NujauLKvpgh/L6nV7f6wQvw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(8676002)(2906002)(81166007)(54906003)(82310400004)(86362001)(2616005)(1076003)(36756003)(316002)(7696005)(6916009)(356005)(47076005)(5660300002)(6666004)(36860700001)(16526019)(26005)(336012)(4326008)(83380400001)(70206006)(186003)(8936002)(70586007)(426003)(508600001)(40460700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:53:34.6875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d987a81-e565-47da-9b10-08d9b4b8d272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, yipechai <YiPeng.Chai@amd.com>,
 yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Define unified ops interface for each block.
2. Add ras_block_match function pointer in ops interface for each ras block to identify itself.
3. Define unified basic ras block data for each ras block.
4. Create dedicated amdgpu device ras block link list to manage all of the ras blocks.
5. Add amdgpu_ras_register_ras_block new function interface for each ras block to register itself to ras controlling block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 12 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    | 29 ++++++++++++++++++++++
 4 files changed, 45 insertions(+)

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
index 90f0db3b4f65..8713575c7cf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2739,3 +2739,15 @@ static void amdgpu_register_bad_pages_mca_notifier(void)
         }
 }
 #endif
+/* Rigister each ip ras block into amdgpu ras */
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
index cdd0010a5389..d6e5e3c862bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -469,6 +469,34 @@ struct ras_debug_if {
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
+	const struct amdgpu_ras_block_ops *ops;
+};
+
+struct amdgpu_ras_block_ops {
+	int (*ras_block_match)(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index);
+	int (*ras_late_init)(struct amdgpu_device *adev);
+	void (*ras_fini)(struct amdgpu_device *adev);
+	int (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
+	void  (*query_ras_error_count)(struct amdgpu_device *adev,void *ras_error_status);
+	void (*query_ras_error_status)(struct amdgpu_device *adev);
+	bool  (*query_ras_poison_mode)(struct amdgpu_device *adev);
+	void (*query_ras_error_address)(struct amdgpu_device *adev, void *ras_error_status);
+	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+};
+
 /* work flow
  * vbios
  * 1: ras feature enable (enabled by default)
@@ -652,4 +680,5 @@ const char *get_ras_block_str(struct ras_common_if *ras_block);
 
 bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev);
 
+int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct amdgpu_ras_block_object* ras_block_obj);
 #endif
-- 
2.25.1

