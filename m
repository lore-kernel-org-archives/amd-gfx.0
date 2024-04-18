Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF1CC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1343D113941;
	Thu, 18 Apr 2024 03:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xS1co7Tk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C36F113940
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWK8f2YfcOn44rdfxIZgjdbzUmgzKKgsJONCb4gOSvpIJe1clQO0IMRpfsy/H7RK3uy9FVlb05bpG5a3cqgM62lDEmS/TuE59E5etEu8cbMZYQerguso+KIaxgxiumHJhtiggimCTcEQk8NPi1WcLJ7ODiMcCZWHFbxso/DH7qFuQ6HbPFfjGUxrIM8Y0M20EbOVBUlDllhRCsYz6cLQZqQwsxv5jxFfUknJHMm857ln9lu9QSZG7TYKTR0Y84a9xjkbZPjSqC92ZXwaSWRVUR4olUJK8lLHiJdn12IIjwzSq2qYi0Io3euACJg+Mnb8bLuZ28fk7sRt/qMAv4vgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/UOjmyfVWAVM+A0CP3fChMHe3DD6nvlduUBsNj4AnM=;
 b=IXwjTYaXik8Mky5XIAR8R+jqff7SHnlv3N5XqmEVBeUQg7fLvoljAVKFHIRcmgT2tedhvDiua2yktx3sW/Eb7b8ELlRidXbo742Qm7j+tl2pRx4CvdBD207F3jrUzJBK/Eq6xOiTLZ9mlRMqharjl/1h0wfcV1XdwX6PMyMz4xd5iktjUHn2T0Z94FdrKsR594/PRrGQrf81exVu9UlXIbl/5OAxSo32BQIQpwfJov6ukYkIN4v3Ynru3RgW8BWQMGoMUC/JazZ+RMjaPkl9Bq7a8V/nlo2nOz3nskzYPHzW/uQnnQRAlG2MNj7YE5GP9GSC6HWTBVFfFtraB4q9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/UOjmyfVWAVM+A0CP3fChMHe3DD6nvlduUBsNj4AnM=;
 b=xS1co7TkbZCVrj7kfTWutFQmC2TiqEUOGa9e8MuD+3qc2e56y/crheRcvP+o0lBj35HXQ5THdqTejohHqgXDoO/+ZPulG94noW+EZy42ccrdJWAOT6x4Q4iMZ4kx0MJaPqYN2jV1iTXWJ++xy0WEW4o+9ow22j3GkqoVHZJRiDw=
Received: from BL0PR0102CA0027.prod.exchangelabs.com (2603:10b6:207:18::40) by
 BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Thu, 18 Apr 2024 03:01:24 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::7f) by BL0PR0102CA0027.outlook.office365.com
 (2603:10b6:207:18::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Thu, 18 Apr 2024 03:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:01:23 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:20 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 02/15] drm/amdgpu: add message fifo to handle RAS poison events
Date: Thu, 18 Apr 2024 10:58:23 +0800
Message-ID: <20240418025836.170106-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418025836.170106-1-YiPeng.Chai@amd.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 4564bbab-df61-4817-32a4-08dc5f53d4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZaRM0fnaWS85y9Yx111+BXYhjosNRjR7LixLYXUsccY6vOK6ZokdRvh1wzIfQRh7boyA81fNouGF6zRTZcdMP7/XEFjtYUkNOp57AkU1BC7MHulzKEuLf763EFXG/IzUS/TVdRSmMELCvWhzzHMhJ1ZoAwrvqPTxxjzZjUwp+c6tw9s1xL0DfXDrR40RZBi7smMwnUDV4giCBd46oN0JmuMDnXxrTR4QLsmDPVNDwbrTy4TUsNqaYM9W966ClIOc9+CtoLrcJUyZucUsa/2FXyGeb+62UkPsX/3Futsox8rKR6F+bJVJ85Mb6ltBb7HzXgQ2Aq8pTi9YwirrROFQJG+sJJ0Xlu3YIBvC4nJeAH04ksKRiUXSg4l9rGefuXOWEBdJo4gjvFkbdmW5zdtk0NUwLeUPqQh+BBmkOvbN2GUqmmuUOj+JExHeTT+xiVw1jhwZcsdQlW4/QL6Q8cGJzFdpMdRyIbW4jg4HkyfDWW9BHwgjXA9po6yYt3Jwk2fNBCkhMkychJg/fy57ewSC0IRqnCJfXavRFotANJwkEzX6sBzULWckxAPra787CH3spa7gKlBX2d2NnNNqaOZ8PLn9JMy1ocdVGtR1prHXRHPxGyOz7XYMGzLJJAr7l8VpjzksoNz/63S/MKmsOf6y6sRL1TAtGJN67kUITJ5bGHdlRSZJdBpGxKQq5ab+KvJ2nSgy1y3FLhizZQcZkrpYJSROLVKYwWsPN1WgGc3gBrwFJCwjaan8UJUTrm8ZAiTk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:01:23.7842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4564bbab-df61-4817-32a4-08dc5f53d4ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401
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

Add message fifo to handle RAS poison events.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 32 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 18 ++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 05782d68f073..0de5a22e7126 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2693,6 +2693,37 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 	}
 }
 
+int amdgpu_ras_put_poison_req(struct amdgpu_device *adev,
+		enum amdgpu_ras_block block, uint16_t pasid,
+		pasid_notify pasid_fn, void *data, uint32_t reset)
+{
+	int ret = 0;
+	struct ras_poison_msg poison_msg;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	memset(&poison_msg, 0, sizeof(poison_msg));
+	poison_msg.block = block;
+	poison_msg.pasid = pasid;
+	poison_msg.reset = reset;
+	poison_msg.pasid_fn = pasid_fn;
+	poison_msg.data = data;
+
+	ret = kfifo_put(&con->poison_fifo, poison_msg);
+	if (!ret) {
+		dev_err(adev->dev, "Poison message fifo is full!\n");
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
+static int amdgpu_ras_get_poison_req(struct amdgpu_device *adev,
+		struct ras_poison_msg *poison_msg)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	return kfifo_get(&con->poison_fifo, poison_msg);
+}
 static int amdgpu_ras_page_retirement_thread(void *param)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)param;
@@ -2783,6 +2814,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	}
 
 	mutex_init(&con->page_rsv_lock);
+	INIT_KFIFO(con->poison_fifo);
 	mutex_init(&con->page_retirement_lock);
 	init_waitqueue_head(&con->page_retirement_wq);
 	atomic_set(&con->page_retirement_req_cnt, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ab5bf573378e..2b15996f1ede 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -26,6 +26,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/list.h>
+#include <linux/kfifo.h>
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
 #include "amdgpu_smuio.h"
@@ -442,6 +443,17 @@ struct ras_query_context {
 	u64 event_id;
 };
 
+typedef int (*pasid_notify)(struct amdgpu_device *adev,
+		uint16_t pasid, void *data);
+
+struct ras_poison_msg {
+	enum amdgpu_ras_block block;
+	uint16_t pasid;
+	uint32_t reset;
+	pasid_notify pasid_fn;
+	void *data;
+};
+
 struct amdgpu_ras {
 	/* ras infrastructure */
 	/* for ras itself. */
@@ -501,6 +513,8 @@ struct amdgpu_ras {
 	struct mutex page_retirement_lock;
 	atomic_t page_retirement_req_cnt;
 	struct mutex page_rsv_lock;
+	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
+
 	/* Fatal error detected flag */
 	atomic_t fed;
 
@@ -913,4 +927,8 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type
 
 int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn);
 
+int amdgpu_ras_put_poison_req(struct amdgpu_device *adev,
+		enum amdgpu_ras_block block, uint16_t pasid,
+		pasid_notify pasid_fn, void *data, uint32_t reset);
+
 #endif
-- 
2.34.1

