Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27CBC624D0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E067C10EA52;
	Mon, 31 Aug 2026 18:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wyYzPQH8";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B84910E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKANc+8vg94O8Yuu+KHh1I7FVqqmWQDffAPMDy1NxAA3RkHWaGhbBaSk6Pu7pWXptnUsiZ9VZ9HQb1/1zyGmF4B3tfUolwp0PstUmAAGPDjEwKvT+Fao8nLcbQb7yCh73X/8bTB3C+YrHMHYEQCT+lW7ZpNLyWr2EK8111XAI/4z/rhdK9sW3FJfMvDVgvXIVpg+tCuQFFr+pUXuvesCJDllzWTZ4UjI8bXvyYouPe3szWuWNf8xwJEMuEViPf++1TRJVH2CI2H4O8xcb2cUhxKVrVFUFnbNyvh2lz+mSkHNu4Z9xCdj4aX3cD4w9nj+btCRNM/NJYU9CdBCF3Ximw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BfQit7LCtIL35ZG2EQbwp5mvGOADvbpjsMiQMk7DvI=;
 b=GNlTk+4OFshvaTK5K3YoTwgx8JoISEjBfmeNEVGewWimKU3UyM6qkplwyDhw+qr0h4Vw0L4UdRh3Fzasxkev7FOXfRK43oEMIdwtGvmK3f1SMCsae3NAurV1M9QQ4jmIYLNxYrKV5dqDefw5iVthbdfw5DASKstOU9uz9evhytAK5BUWZ566GQFMdbRUpD0MyFupJAwJOfofJs8T/D3Cdo6Dl3m907Kufc5oLt57Npt8wE0X9n83dcPTvhj6GZjXgLEDaurCsKWAkZNCG3tzV+r/3qtdIzflP3+p0Vsthz6tEPv2RMf+EVb9FIR2cabOnnbQrMqBy9Dsl0vDS8K3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BfQit7LCtIL35ZG2EQbwp5mvGOADvbpjsMiQMk7DvI=;
 b=wyYzPQH8liiAALTLxonft56MQBB6PISFmVQs8Wwv3JYHhHzUqJxPis5eZZ+2I/9hluyMXhqW3f1GBjYFSaKO0KpyRRY2SkUtawQz/lC6mMqVvhjaXonUTBRkfLEJAwCJLHVybT22XpNeQ17eA1Sx9xYTve1eQ8saVg2T0nz1980=
Received: from CH5P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::21)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:36 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::6b) by CH5P220CA0003.outlook.office365.com
 (2603:10b6:610:1ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/95] drm/amdgpu: Initialize VM for NPA addr management
Date: Mon, 31 Aug 2026 14:26:44 -0400
Message-ID: <20260831182754.1089811-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: edc69489-09cd-4113-4565-08df078dab7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JO9PpJe/y7H/+RXCFwdSe00uDHwheh7OlL6ys6Sp5p0KamSCXKdrGl8gziH4S+NwspAWkxmaTNeoiCzjSic/yhHl8QF7otou0l9MKgNmuI5mMnBbKdv5hiMnSuoqPwHQHWTkDPODkPyuj19TwWV+V+xHAPUhomGEM2R7gzz6FQa6+qOmAhdM9gQ7vucwTcwIKJ3ObVu5umjaypmvRZ9ToqQ5ztjLiCTGcxJr3DycgK8Ik5QfXOjCnqHGRhKFIFnitGexBweeIJHmeCjZRa4DiznU2WPoIUycbUZ00elwS+FX4qzXKg1UriM6srlPZg18S3PGEZ6ziiQ4maQEZatBOb7Eyp/N2DSNjF0bmraKPw1Mw7ycXnO7NzwkJ/04b6pfvD/Epa44QBy0n4IgIMQwVYGo78dEBytLrSelMxzg0KHYcp68KOrn5ic6ZobLj/C1T1vA4BcKtumCPbFJKHufhRri7r+N6FLj1RqmbWtQakP3AB1AjjDfIEDM7lx3nk7aGcCD27FHpRpzXYYSIekMAQ12wWM9TogGSy1G2hL17NOJHAHGMo6OLxlOw4KKSH00o39x4DksKNmPBAMg+5Q9HoZaoZR2sBnRv+p7YXrX8KE7VWxTj0WJSYMDsH4YoeqgX5tfeHz+p+SsI3Ld2+e3H1Mt2e39ejF0ByTECiJ3xPPNnQJ78fcWuWNtlh9XU3V3z0FwItGvIMdSXAILHnUnOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VyLfxs80Iof/oxBbcjcey23Xlxsof3PiBeeo9NVuCH3b1yFNCLPrt8pXM9DWzksBMD9AzawC2pkgvYFINnW6rdS33lz0oZxkym0gXLh2SgS8FjkNyGDddg8qzKsZd0xKqqxJX/XRyhNYpTWQVeG4BHxBS/exoZxBZA2g1soeTnUCcMHaqNQrv+4Y80fnK31BdamNL0Ky9TUpSw3rHr6HLlsC6Mz/wLbHvmwwMdac6pRA91Xf9kHAAAs4zkAtAtDwZBdNG+/zSeDYMlNjo0cmQbXnufRgyl9dyudw2Qpvxc3UuM5cxh5oA6vVMttoE35On50o9mOAfAKhmjLz8xxQvLDEt0VDjoJsUFa4N9is9pCSJVLllq99fhR+/4QhCOI3yRDIqqmdAsse8oLfvNUAGszj2COmiysm1oNqq8HkAt2Yd/zFONgwBT4sCQ4T3tmw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:35.8289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc69489-09cd-4113-4565-08df078dab7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844
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

From: Mukul Joshi <mukul.joshi@amd.com>

Initialize a NPA VM for managing NPA addresses on the exporter
GPU.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 4582299d96c4f..9d550c21f69aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1156,10 +1156,20 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0);
+	if (r)
+		goto out;
+
+	/* For using CPU for page table updates. */
+	r = amdgpu_vm_make_compute(adev, &adev->ualink.npa_vm);
+	if (r)
+		goto uninit_vm;
+
 	adev->ualink.npa_wq = alloc_workqueue("NPA WQ", WQ_UNBOUND, 0);
 	if (unlikely(!adev->ualink.npa_wq)) {
 		dev_err(adev->dev, "Failed to allocate NPA WQ\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto uninit_vm;
 	}
 
 	xa_init_flags(&adev->ualink.exp_xa, XA_FLAGS_LOCK_BH);
@@ -1177,6 +1187,11 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 	amdgpu_ualink_npa_mm_init(adev);
 
 	return 0;
+
+uninit_vm:
+	amdgpu_vm_fini(adev, &adev->ualink.npa_vm);
+out:
+	return r;
 }
 
 void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
@@ -1193,4 +1208,5 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 		mutex_destroy(&adev->ualink.conn_state[i].lock);
 
 	destroy_workqueue(adev->ualink.npa_wq);
+	amdgpu_vm_fini(adev, &adev->ualink.npa_vm);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index a056d89d163ba..c32b4fd3c3220 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -174,6 +174,9 @@ struct amdgpu_ualink_mgr {
 
 	/* Memory-manager for managing NPA address space. */
 	struct amdgpu_ualink_npa_mm npa_mm;
+
+	/* NPA-VM used on the exporter.*/
+	struct amdgpu_vm npa_vm;
 };
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
-- 
2.55.0

