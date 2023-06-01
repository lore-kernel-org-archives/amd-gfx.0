Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB55C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 10:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEFE10E22F;
	Thu,  1 Jun 2023 10:25:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFECD10E22F
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 10:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCqnvxwtSWWj1sP2e842fTG7eIfY5kRehgF1h2WzvgI0gQJ6wPOdDzgoJ++hQxJiptkJQwykubPPPt92lgynTrWim1TtY53dQVj5t8XuorCNlatQOJfwfoGSXB2onE1883BREsiTivlCQHBKLQ+xEEkNPgYXDj914M4c7asnOwMq+JydibeajAtCoMEkM2+IxtLWgjsEG9JTuLIgLjeNdPa5gm2F4GCdqIgILhCwd9M15qZKQNlRiwAemDob/h2z8eqzq2MEzsOqyBLfDmGAqZHv1dJwyFZizJ5cRih/38huKJYNJlrBZ/LFm1apwlLTMltS57UbfdP3uZQgLDVwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f//uL3LoN09G+57pvKtJAcnRfJrQXQh3vftr8sFcGag=;
 b=evN9+MSiiqHzxP44qBcd2vPu8oChWOjXJy4ZxBzqHGweMR5rxhgtkERt7sPfowGTpQGg6ut10pW3HZmRMT1hSZjv6p/yTUBlEwL0Wv5X0StSw8yvoeVTez1KUxWjems1JABCIciUKogQHGt1Ny6X5wjh6i+/36fbZWTgIHX7vnZMK8gs1THEJ6JFPfk1kmHBYputxHHXRD2te/UYry3jstm6eWKwhJ4n+PO2jxrwh0FsaTvJkIxdhmbd9xnkBqnOTSJb56n4k0vJhXanVg7GcbkNpQM57FfUIR79EoX/5qDSdEYLYnhs67AyuiS2i+hKIZGlkSnJQ1VLDGMMCO5b3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f//uL3LoN09G+57pvKtJAcnRfJrQXQh3vftr8sFcGag=;
 b=avzqv7wxKTS6AauegY2Ue8BazNxI6zm4EBbkKauJG013ZwN2r6rsK5fbp1LuplP2qFXf4jyGdOMBLxMiPb46P6T5jTf0UbM8KuOXR4+sqJaPLm2vyhjYRj+nanKOJiUS2zmO5nzg9JQ7JQDGWMh5lv/uBJJbTYEOGdxqtCCwAro=
Received: from BN9PR03CA0805.namprd03.prod.outlook.com (2603:10b6:408:13f::30)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Thu, 1 Jun 2023 10:25:29 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::68) by BN9PR03CA0805.outlook.office365.com
 (2603:10b6:408:13f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 10:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 10:25:28 +0000
Received: from bare-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 05:25:27 -0500
From: Chong Li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] [PATCH] drm/amdgpu: add option params to enforce process
 isolation between graphics and compute
Date: Thu, 1 Jun 2023 18:25:17 +0800
Message-ID: <20230601102517.1086883-1-chongli2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 219f027e-666f-4148-7a94-08db628a8591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTX+X0Z1FxhQQgeg8ACnH0pmHxo7ovvSvbVvraDeTRv5HsmatAWey1feQPuYU1oFayp0BxB018IOktecWn5sRtENleOS8ynCZGdDVlY+T24JFADrlSdRETPNSIdRONqkAiN03YJ9ahB9fRlqSyEltVY8VFeQrW06zDJu/ZYdPbK3lGrMKRUeKIh4tD0RrMKDnvksUW21ZXxyIBTPREVnaqAPAm4hKDFnnYE0iAO4ZDZvzJlnlBhj20kUGv1STgbYnlYCRyYgHFZ0Cul3GDR68lNqhxAWNsH58K0Fo1B0JWwzHRGKaDJ1uhPDB0f3VzKsrxoGW2YVRaWmbEmsHnXel+S22XrV3n3Kc0TBetqOr1pw/UFXd7j+9Ryla4L2Lh38V2GlUignyHBYRW1pX8v2MfAVCBjJ9G3vroQzpLneQ9RMFb9c66oWabLPqJ8glVbgvDcO4tk3iiCGJu8CELCUyKZ4FG9lI1lN2JA01sVsRy8eWynV/qHdaSVp9T507pdj4CyhRzcZRsKsBjWMCtpjbQTdgJVqJg1ZVkhvERCAchQiPR/eyTUL/oOc2tZniQv9MlSgfbsTL5Wlxg3+FAbd/O1V8ocw6mm4ViWA8TZ6WLAacARgn8NaSQCB2oiPwki4dn9+pXeBqBykkz1JtXUIUSLXgGzyq54k/T6lemYFWwMOBBIm1jzol7cUmDmVLCuPrZqCey9R0OLmtJjzQe4+d5RpdHbY1Zg+cx/3RJzccHJ2dqR5ULOFz5rAuYeTXOkEOWI3p3Z+WKjKgUbzJE0Fnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(16526019)(36860700001)(186003)(41300700001)(26005)(2616005)(83380400001)(47076005)(1076003)(336012)(6666004)(7696005)(426003)(478600001)(70586007)(40460700003)(54906003)(36756003)(70206006)(356005)(4326008)(82740400003)(6916009)(40480700001)(82310400005)(81166007)(316002)(5660300002)(8936002)(2906002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 10:25:28.8657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 219f027e-666f-4148-7a94-08db628a8591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
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
Cc: Chong Li <chongli2@amd.com>, christian.koenig@amd.com, zhengyin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enforce process isolation between graphics and compute via using the same reserved vmid.

Signed-off-by: Chong Li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 13 ++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ce196badf42d..48c5c547d85a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -215,6 +215,7 @@ extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
 extern int amdgpu_use_xgmi_p2p;
 extern int amdgpu_mtype_local;
+extern int enforce_isolation;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3d91e123f9bd..2e0ebd92b4cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -973,6 +973,15 @@ MODULE_PARM_DESC(
 						4 = AMDGPU_CPX_PARTITION_MODE)");
 module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
 
+
+/**
+ * DOC: enforce_isolation (int)
+ * enforce process isolation between graphics and compute via using the same reserved vmid.
+ */
+int enforce_isolation = 0;
+module_param(enforce_isolation, int, 0444);
+MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . 1 = On, 0 = Off");
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index c991ca0b7a1c..33efa17d08ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -409,7 +409,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 	if (r || !idle)
 		goto error;
 
-	if (vm->reserved_vmid[vmhub]) {
+	if (vm->reserved_vmid[vmhub] || (enforce_isolation && (vmhub == AMDGPU_GFXHUB(0)))) {
 		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
 		if (r || !id)
 			goto error;
@@ -578,6 +578,17 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
 		}
 	}
+
+	if (enforce_isolation) {
+		struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
+		struct amdgpu_vmid *id = NULL;
+		++id_mgr->reserved_use_count;
+		id = list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid,
+					list);
+		/* Remove from normal round robin handling */
+		list_del_init(&id->list);
+		id_mgr->reserved = id;
+	}
 }
 
 /**
-- 
2.34.1

