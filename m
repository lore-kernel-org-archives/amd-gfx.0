Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D57C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD7B610E8
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD7B610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 372AA6EE11;
	Fri,  2 Apr 2021 06:44:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242466EE12
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3aGDUxzWrFc6+r+6UbDQSWAy3cKy8wtPm8JZc4GRA+RMHwR2jrS0wQK6ZanK3851BAmGqRKf8BtCQSljvWvCq37WnMP+HoBU4b6l0jP2pTag/rPxMISYXfOLDzcqnEn1e/lMOa8vJA29bl1+GwZ0d/L/ruf5cG9bO/o71jFR6qy67JmTwahZHqQWFmFGnQZyNplBJnJpgjxKrs8ykChA1jDdpKYUjE7nAhLmAzaUPj04RjvfgoGexdKjSQ6bAAC0Gcv7UrVXcU7DSdGthn8Rbt9umqLtmHYZWzjvKbKerNnlpFRo0imcw4qPaOYa4zOq3xy6fQ0AMEoiK19YwskdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra9Yqx9Neb841oXpXgBMWMyUvox+NBBI5udDg1mX4uA=;
 b=cFWakkztxgbXtbW7VWeBZzIgWq7QVLVe803ECmgvTQec54egk3xoYOTVO/AUFb3UUjpRUs0ZvRTWelCUm1VefLkyrM4FxKotKPZjeauaG9za1PCzHCBey3tzW4tBZnBKIEExiAR/UN9UwK1dcOA1KdoYWcbAthM/Io72x8CHyh9vzf5Wz6Pe01bC23ahsS1q9i0FAEW06WHkNrZk9iH917Dou54Qcp+NLLdZ2vxBLSdDkgADzIu9t5dnCYxTdlV5DZCNlzkytKffe1wgxdQ/G27FW8xMTQ0Y0TGjcq7A0Na5uWR5V8RJlAmjZIQkI7pZlef3NoJ8MrHy/OwqPNNGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra9Yqx9Neb841oXpXgBMWMyUvox+NBBI5udDg1mX4uA=;
 b=05Q8NBVXIVo2BHWjF+TF8b2Ksx9gxZ3jbcA6Tmob9DEI7125EiOxhsOxk/PhgKtYCQtEtLxdoKx1iRaJC4TERVWD9GE9Z8fc9BNOr2Ye9+yAcaiHI+RlBrUiDTD6jqLi+NatdPWtRHMW8Go63nKOGiC7/ssTeOefXsiPrhCDkW4=
Received: from DM5PR17CA0064.namprd17.prod.outlook.com (2603:10b6:3:13f::26)
 by BY5PR12MB3892.namprd12.prod.outlook.com (2603:10b6:a03:1a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 2 Apr
 2021 06:44:16 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::63) by DM5PR17CA0064.outlook.office365.com
 (2603:10b6:3:13f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Fri, 2 Apr 2021 06:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 06:44:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:44:15 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:44:13 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/11] drm/amdgpu: split mmhub callbacks into ras and non-ras
 ones
Date: Fri, 2 Apr 2021 14:43:44 +0800
Message-ID: <20210402064345.14093-10-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064345.14093-1-Hawking.Zhang@amd.com>
References: <20210402064345.14093-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0746afb3-e3cf-4f19-3b74-08d8f5a2bbf1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3892:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3892E3FB1FC6A73C50FE1C16FC7A9@BY5PR12MB3892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:154;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgGLL8cQ2+MWnc+FlWzJgX9EBiplJTI/NrDqFyvE6lu+IpLHi1hVP9QZuMK9M/Z8gM3QCGbhBM9CMg2i2VGbesvm0jStvJpx1pzDmAbQFth7oUhvDm00FEPFUHzkL91YnXGZhISEILNGbRRhA7DZzVchOYMhD3/8UdX19NP1oI9H66ZtWA6flrBbs5UteMiNX9KEIlJEZOfQr1HQhiLdvpNBnoBkaKxXyNSMz5zfsqzpSVdElaTVV5n6AeIkGwD3riVw7DeuKMpo7kKhzQlKNnxjh6Jy0KfJjf7uKurTnTZE8zxYLUrmBybL15j+0RbUNEq+sbgX5LNWM0DTHuc1rcmlm4xqP9ceE/s61URPdY8RRc40jxx0eq93HogKUCrgdH38tJfuNZGmlKUYdGLIbvtc4An04qkRd/CMoEGLQX6Bqc9OMnNwVqjyoMF+gNuRa/rfE/G4REgU5wmDVFsppPO/ZCgnFy+GwnIJwcEac67J3X9gQu/JXx7Be9K8zsvkw1siij/aYCS9+KU1QoTD6oFEkjbBFGfJJOt//hm1rczBWdbCPzVUfVeHorIEFKZUHuraULJp8oLGzPVlbqaJUq3XDyYAVUdw/AkM0veqTXUfqzudoHye3pdhNIj4UAygLxU2vCQf7RdDMzD46hV5gpqRpYm8czbGaLmCBh/AEo1fUGIPKw/y1VMlGi/JaLej
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(316002)(70206006)(70586007)(1076003)(30864003)(4326008)(7696005)(426003)(47076005)(356005)(2906002)(82310400003)(82740400003)(110136005)(186003)(478600001)(36860700001)(83380400001)(36756003)(8676002)(5660300002)(6636002)(6666004)(336012)(8936002)(86362001)(81166007)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 06:44:15.8601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0746afb3-e3cf-4f19-3b74-08d8f5a2bbf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3892
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

mmhub ras is only avaiable in cerntain mmhub ip
generation.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reivewed-by: Dennis Li <Dennis.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 28 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h  | 12 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 20 +++++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  5 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    |  6 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c    |  8 +++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    |  8 +++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h    |  1 +
 13 files changed, 74 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 438e2f732377..b4ad1c055c70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3142,8 +3142,9 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 		if (adev->asic_reset_res)
 			goto fail;
 
-		if (adev->mmhub.funcs && adev->mmhub.funcs->reset_ras_error_count)
-			adev->mmhub.funcs->reset_ras_error_count(adev);
+		if (adev->mmhub.ras_funcs &&
+		    adev->mmhub.ras_funcs->reset_ras_error_count)
+			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
 	} else {
 
 		task_barrier_full(&hive->tb);
@@ -4378,9 +4379,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 
 	if (!r && amdgpu_ras_intr_triggered()) {
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-			if (tmp_adev->mmhub.funcs &&
-			    tmp_adev->mmhub.funcs->reset_ras_error_count)
-				tmp_adev->mmhub.funcs->reset_ras_error_count(tmp_adev);
+			if (tmp_adev->mmhub.ras_funcs &&
+			    tmp_adev->mmhub.ras_funcs->reset_ras_error_count)
+				tmp_adev->mmhub.ras_funcs->reset_ras_error_count(tmp_adev);
 		}
 
 		amdgpu_ras_intr_cleared();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3411c6577a18..013efc746821 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -30,6 +30,9 @@
 #include "amdgpu_gmc.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
+#include "mmhub_v1_0.h"
+#include "mmhub_v9_4.h"
+#include "mmhub_v1_7.h"
 
 /**
  * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
@@ -398,8 +401,25 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (adev->mmhub.funcs && adev->mmhub.funcs->ras_late_init) {
-		r = adev->mmhub.funcs->ras_late_init(adev);
+	/* initialize mmhub ras funcs */
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+		adev->mmhub.ras_funcs = &mmhub_v1_0_ras_funcs;
+		break;
+	case CHIP_ARCTURUS:
+		adev->mmhub.ras_funcs = &mmhub_v9_4_ras_funcs;
+		break;
+	case CHIP_ALDEBARAN:
+		adev->mmhub.ras_funcs = &mmhub_v1_7_ras_funcs;
+		break;
+	default:
+		/* mmhub ras is not available */
+		break;
+	}
+
+	if (adev->mmhub.ras_funcs &&
+	    adev->mmhub.ras_funcs->ras_late_init) {
+		r = adev->mmhub.ras_funcs->ras_late_init(adev);
 		if (r)
 			return r;
 	}
@@ -423,7 +443,9 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	    adev->umc.ras_funcs->ras_fini)
 		adev->umc.ras_funcs->ras_fini(adev);
 
-	amdgpu_mmhub_ras_fini(adev);
+	if (adev->mmhub.ras_funcs &&
+	    adev->mmhub.ras_funcs->ras_fini)
+		amdgpu_mmhub_ras_fini(adev);
 
 	if (adev->gmc.xgmi.ras_funcs &&
 	    adev->gmc.xgmi.ras_funcs->ras_fini)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 1ae9bdae7311..11aa29933c1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -21,12 +21,16 @@
 #ifndef __AMDGPU_MMHUB_H__
 #define __AMDGPU_MMHUB_H__
 
-struct amdgpu_mmhub_funcs {
-	void (*ras_init)(struct amdgpu_device *adev);
+struct amdgpu_mmhub_ras_funcs {
 	int (*ras_late_init)(struct amdgpu_device *adev);
+	void (*ras_fini)(struct amdgpu_device *adev);
 	void (*query_ras_error_count)(struct amdgpu_device *adev,
-					void *ras_error_status);
+				      void *ras_error_status);
+	void (*query_ras_error_status)(struct amdgpu_device *adev);
 	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+};
+
+struct amdgpu_mmhub_funcs {
 	u64 (*get_fb_location)(struct amdgpu_device *adev);
 	void (*init)(struct amdgpu_device *adev);
 	int (*gart_enable)(struct amdgpu_device *adev);
@@ -40,12 +44,12 @@ struct amdgpu_mmhub_funcs {
 				uint64_t page_table_base);
 	void (*update_power_gating)(struct amdgpu_device *adev,
                                 bool enable);
-	void (*query_ras_error_status)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_mmhub {
 	struct ras_common_if *ras_if;
 	const struct amdgpu_mmhub_funcs *funcs;
+	const struct amdgpu_mmhub_ras_funcs *ras_funcs;
 };
 
 int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 459a470744f4..b55f470eb747 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -799,11 +799,13 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			adev->gfx.funcs->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
-		if (adev->mmhub.funcs->query_ras_error_count)
-			adev->mmhub.funcs->query_ras_error_count(adev, &err_data);
+		if (adev->mmhub.ras_funcs &&
+		    adev->mmhub.ras_funcs->query_ras_error_count)
+			adev->mmhub.ras_funcs->query_ras_error_count(adev, &err_data);
 
-		if (adev->mmhub.funcs->query_ras_error_status)
-			adev->mmhub.funcs->query_ras_error_status(adev);
+		if (adev->mmhub.ras_funcs &&
+		    adev->mmhub.ras_funcs->query_ras_error_status)
+			adev->mmhub.ras_funcs->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
 		if (adev->nbio.ras_funcs &&
@@ -857,8 +859,9 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 			adev->gfx.funcs->reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
-		if (adev->mmhub.funcs->reset_ras_error_count)
-			adev->mmhub.funcs->reset_ras_error_count(adev);
+		if (adev->mmhub.ras_funcs &&
+		    adev->mmhub.ras_funcs->reset_ras_error_count)
+			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->reset_ras_error_count)
@@ -1515,8 +1518,9 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 			adev->gfx.funcs->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
-		if (adev->mmhub.funcs->query_ras_error_status)
-			adev->mmhub.funcs->query_ras_error_status(adev);
+		if (adev->mmhub.ras_funcs &&
+		    adev->mmhub.ras_funcs->query_ras_error_status)
+			adev->mmhub.ras_funcs->query_ras_error_status(adev);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 27f692904791..64cd08ee8290 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1245,8 +1245,9 @@ static int gmc_v9_0_late_init(void *handle)
 		}
 	}
 
-	if (adev->mmhub.funcs && adev->mmhub.funcs->reset_ras_error_count)
-		adev->mmhub.funcs->reset_ras_error_count(adev);
+	if (adev->mmhub.ras_funcs &&
+	    adev->mmhub.ras_funcs->reset_ras_error_count)
+		adev->mmhub.ras_funcs->reset_ras_error_count(adev);
 
 	r = amdgpu_gmc_ras_late_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 0d5620ce66a9..1a0bb9b1c25e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -775,10 +775,14 @@ static void mmhub_v1_0_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_mmhub_funcs mmhub_v1_0_funcs = {
+const struct amdgpu_mmhub_ras_funcs mmhub_v1_0_ras_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
+	.ras_fini = amdgpu_mmhub_ras_fini,
 	.query_ras_error_count = mmhub_v1_0_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v1_0_reset_ras_error_count,
+};
+
+const struct amdgpu_mmhub_funcs mmhub_v1_0_funcs = {
 	.get_fb_location = mmhub_v1_0_get_fb_location,
 	.init = mmhub_v1_0_init,
 	.gart_enable = mmhub_v1_0_gart_enable,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
index d77f5b65a618..4661b094e007 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
@@ -24,5 +24,6 @@
 #define __MMHUB_V1_0_H__
 
 extern const struct amdgpu_mmhub_funcs mmhub_v1_0_funcs;
+extern const struct amdgpu_mmhub_ras_funcs mmhub_v1_0_ras_funcs;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 29d7f50912ee..d0f41346ea0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -1312,10 +1312,15 @@ static void mmhub_v1_7_query_ras_error_status(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
+const struct amdgpu_mmhub_ras_funcs mmhub_v1_7_ras_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
+	.ras_fini = amdgpu_mmhub_ras_fini,
 	.query_ras_error_count = mmhub_v1_7_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v1_7_reset_ras_error_count,
+	.query_ras_error_status = mmhub_v1_7_query_ras_error_status,
+};
+
+const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
 	.get_fb_location = mmhub_v1_7_get_fb_location,
 	.init = mmhub_v1_7_init,
 	.gart_enable = mmhub_v1_7_gart_enable,
@@ -1324,5 +1329,4 @@ const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
 	.set_clockgating = mmhub_v1_7_set_clockgating,
 	.get_clockgating = mmhub_v1_7_get_clockgating,
 	.setup_vm_pt_regs = mmhub_v1_7_setup_vm_pt_regs,
-	.query_ras_error_status = mmhub_v1_7_query_ras_error_status,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
index bf2fbeb172d1..a7f9dfc24697 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
@@ -24,5 +24,6 @@
 #define __MMHUB_V1_7_H__
 
 extern const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs;
+extern const struct amdgpu_mmhub_ras_funcs mmhub_v1_7_ras_funcs;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index f107385faba2..da7edd1ed6b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -689,7 +689,6 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 }
 
 const struct amdgpu_mmhub_funcs mmhub_v2_0_funcs = {
-	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.init = mmhub_v2_0_init,
 	.gart_enable = mmhub_v2_0_gart_enable,
 	.set_fault_enable_default = mmhub_v2_0_set_fault_enable_default,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index ab9be5ad5a5f..1141c37432f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -616,7 +616,6 @@ static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 }
 
 const struct amdgpu_mmhub_funcs mmhub_v2_3_funcs = {
-	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.init = mmhub_v2_3_init,
 	.gart_enable = mmhub_v2_3_gart_enable,
 	.set_fault_enable_default = mmhub_v2_3_set_fault_enable_default,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 74c784b9bb8d..4e2c5f117cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -1650,10 +1650,15 @@ static void mmhub_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
+const struct amdgpu_mmhub_ras_funcs mmhub_v9_4_ras_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
+	.ras_fini = amdgpu_mmhub_ras_fini,
 	.query_ras_error_count = mmhub_v9_4_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v9_4_reset_ras_error_count,
+	.query_ras_error_status = mmhub_v9_4_query_ras_error_status,
+};
+
+const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
 	.get_fb_location = mmhub_v9_4_get_fb_location,
 	.init = mmhub_v9_4_init,
 	.gart_enable = mmhub_v9_4_gart_enable,
@@ -1662,5 +1667,4 @@ const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
 	.set_clockgating = mmhub_v9_4_set_clockgating,
 	.get_clockgating = mmhub_v9_4_get_clockgating,
 	.setup_vm_pt_regs = mmhub_v9_4_setup_vm_pt_regs,
-	.query_ras_error_status = mmhub_v9_4_query_ras_error_status,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
index 92404a8f66f3..90436efa92ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
@@ -24,5 +24,6 @@
 #define __MMHUB_V9_4_H__
 
 extern const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs;
+extern const struct amdgpu_mmhub_ras_funcs mmhub_v9_4_ras_funcs;
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
