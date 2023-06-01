Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BE5C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 11:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D461F10E224;
	Thu,  1 Jun 2023 11:15:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A667A10E224
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 11:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFJ8azBFLul4mRe0ABtB7v18Jaw43ENg2Um7jOu3imkZauusn5KFdcKKeIJWNSf5Y8LuEQYj+ot26Pyt7xVTo+LfAb2S7ZvsbIXL650dxgkQqXhe9wV5EhVrC5cbO7aweWJ/3e2pVMBmhhYC7+m656Vg4YoawrGUNDi3EEPY70/5Kz258KEWJdnvBcfqx0k41mYh3tgjmOeXHuyCkjs2bv70cjZvLuL6TVE0KXI7XskJn3tmQ7+BMCktK3X/6+n6WegMhFlcsFddPyLpCnuZFX8w0xq8WzE2aK7THJPmjaGK+H3WeIasu+Futn/C2tYg6MlzNp8jZS6ImPyFTPUZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f//uL3LoN09G+57pvKtJAcnRfJrQXQh3vftr8sFcGag=;
 b=c7gXlrvieVbwidzbojqMKsvM2Xvs8b86qe/5wM3LGoXCMS45zRQ/riE01tgHpkjUjESBxOxftI5RW8GcxD3wxxw8Lbzdq/McxLy55e6RWoHorvi6YNAoh5g2DGLYG2CnvoCdZnIbN9dvFmwQCcCo6rHgCNb6iBoIEuurQLUCb8zcOH4DZCHyvTOamwNf0Cd0LXynesSrc7KMt82ym8mymVDi3JGlgZIoQVZFSsfPSujNoFh38e4cZzPpuVvjvzuuDynUbLS7FBZyIBQjU9XjqN98pU7e/bN2pK3fc7v/NvKVrwV6m1D/D+aIAkkAocj8gOry63TMVH9LxRKPg1nZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f//uL3LoN09G+57pvKtJAcnRfJrQXQh3vftr8sFcGag=;
 b=oSMsypy4+5hTNl+wDCSCB2W+Q1Gf9u7J4KLK5lI0LV6gkfxTsDQI2zCediDziLlpmYsBiIIeq9OjpPKw5s7BUlJA4tn3bdAeHvWzg6YU6VSg4FN9oH1sVGysdoTjQNNKq2dngPQffnjX56xVBWn+Ddn0l4jiFn8RNH+a1FUzH/8=
Received: from DS0PR17CA0023.namprd17.prod.outlook.com (2603:10b6:8:191::24)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 11:14:59 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::ab) by DS0PR17CA0023.outlook.office365.com
 (2603:10b6:8:191::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 11:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.18 via Frontend Transport; Thu, 1 Jun 2023 11:14:59 +0000
Received: from bare-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 06:14:57 -0500
From: Chong Li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add option params to enforce process isolation
 between graphics and compute
Date: Thu, 1 Jun 2023 19:14:41 +0800
Message-ID: <20230601111441.1088083-1-chongli2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: f40b35c1-3f0b-4e4e-3044-08db62917036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDbKY2l0RSFHHu59Vrffq353zEQjRX1JYkFPbsdrRdgADGUr3+wGJTE73fBfIZEKmR7jx1jaIAbRkGD7WidakSlTofgLRc+CY9Se4C1fKskmwzBKRhoCUSVbvbRvNJPST+wrv5/HzMAXTAnudA+sh0x5h26PdJ5AX7KfbUEKvgICiwi1Vo3WWSMaA6nOLuPhl6clyB0PbrXtyGQfZq3yDhT2cmTj4Q/xyQdSRN1uCRle8kkBmWpYU2XUMBjk4SlYERmm6aBj2nH4QwlWXT5nHNHVoQvvoyDmlwD/mAAJf6ZRYPNsSQRvPJnfYN3r1SkaBU2la/qxohWJOnryVpz0RuJs0mc+h95OV5sOHKFCZAEFkhrn0pprH9INNqqNhUfVaIT3ZYxGP3snbiTW7wS94XDHr4pStMngcEWZngBz/L6MmjVEvYYiCUb9m8JhfxkxrqX1xYBABDPMtkvyNFvXB2pzluhBX9IKJt+X7DiYHfON0aWP7ojLH5HIASYckvQpuN/RFg2SxR4aYZktCLoMxLOax2xVOeiNBLLLb1owq6Q1JtyPnXONM4AWnKiKVI6CU8G5lyTnTqg84ujHWb2HHXmh2e9i3jfqIKKNJDsEGrOd/Cv8rNthQ0DehuLJqRbCMCHh1ZvVSVXSzgu+aITV8T6CO095yRs2XlxTOxbEy4uzDXE0j4w2ULyrgJRtS3dRurgtoaehtdnzMWa0vo6EeiICMNYDFnw3zsfh7//Jw2fSEvXOx0noNYKtboqBvN4JKrKEMxH09Xd63xy675CcRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(70206006)(70586007)(316002)(356005)(4326008)(6916009)(82740400003)(81166007)(2906002)(40480700001)(8676002)(40460700003)(5660300002)(8936002)(1076003)(26005)(186003)(16526019)(82310400005)(47076005)(83380400001)(36860700001)(2616005)(336012)(36756003)(426003)(478600001)(54906003)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 11:14:59.4342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40b35c1-3f0b-4e4e-3044-08db62917036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
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

