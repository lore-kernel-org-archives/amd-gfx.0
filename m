Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99907C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3783610E4CA;
	Mon, 31 Aug 2026 18:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ItYJByDv";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6055E10E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGUQjDvfVRKvXv9B1KttW8csqYuNgSEe5VYyI5vfe0h2HWh2x8SX2HNoIxdGDuDIzy1BvZiiPR/HWgjmoWs+djFgvExVE8JgnCBsLUoxALdLtSRw7PBpfNruRBzhtW6auKLoGSVzQTxQL6Gnm5N0VH/6glCjeFF1w26LphOQcR5dcwQrPfGL7BSPfI8nOACPgHtfArmhXhxBlDN4PLdNOp87nxxRmzyLTMW9R+Q4REfmOej3MUsT5hnEtrFWgWjFVyAZyyxdSu/wZwCmKZKx2u3KajI/8LZw8eQfPvPugVywcgi+OkMYUDDTO+TjraoxSXnvHH7SdGEOeJX3iZloBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vlarRKaOdMTwU8Z/bsKUhiGLYMLe/u2ozFk64MHMTU=;
 b=YNmsngu5s7MGvvR9Pb9AH6RJyukFHrKPJMinHmHqZ6UOVWkDN+rP/shoR65+X3R5P4emi1/l325o16VXZ7iMeH/KTN3VYy7J1rqgmmQJIHVdcFJ+/dHz6hDWbJAH62UVDFE/pd0n8TithtGvizbtVhal6e6UnOBz3GA0A+SzVec064SfgbfmasgYOKijQMiN0AnLmIAr5yMk95Y8as8LQvNBcNGorQJLSMAZfnxOWCqkB6a+ezuRZ/RTKOgpCDIE9X/J/L9R+5cEkCYuDtZRqx/FLsDZYFWUkhZ3I55dFhk6HL5EZ0vKzB1vy7uMPUZCxHz+XKiAqkdab11V0lJ+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vlarRKaOdMTwU8Z/bsKUhiGLYMLe/u2ozFk64MHMTU=;
 b=ItYJByDv0aiqGJfRu2xbc6Cyqw7d4HK9CWpwSD12jsl49qeVpPsxH/4Ao+FIUw0mm+pW0SkqZeUDld5d8rXf6vgiR3/B1U4UDm9p0igqPxW2kPF9Ia/DbWNuqVQm8dP9M7pDjwiDFKcY8pHIV+rpt8q/h0cCnl6Y9RTGYBN8bCQ=
Received: from BN9PR03CA0647.namprd03.prod.outlook.com (2603:10b6:408:13b::22)
 by IA5PR12MB999300.namprd12.prod.outlook.com (2603:10b6:208:608::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:21 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::7) by BN9PR03CA0647.outlook.office365.com
 (2603:10b6:408:13b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/95] drm/amdgpu: Add UALink manager core infrastructure
Date: Mon, 31 Aug 2026 14:26:26 -0400
Message-ID: <20260831182754.1089811-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|IA5PR12MB999300:EE_
X-MS-Office365-Filtering-Correlation-Id: d740c83d-f66f-48e8-8238-08df078da27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1pqDh8hxpvKZ05XqAHe1JwFRNumrSuIxpY0vN5oX0P7GRR9p+hJSvmDptuQvULKeVoWPopRpOuZMhyP8svmbvaU7lmOS7uGmeMFLI9ZlSuAwuLg1QTqcghRWGIkTsvfy+jNQUww/4XAm5cgsRkZG7ylhOvp8CErTREDHUXYQEdX6inc2MqUMdUxOwh0w6uy3Z4mgLQEizTD9XwFPoYNENZJQDhkmNykLCc9VqC1H7EiTgUBVQU0KR+HIG/v+WN4h022DGUcMlC/pMMerLXf7pIGK6eJMytFCTcbgZp3Qi47yp5O8Wl2geJIm3Y5BK4/RpQwDEsWNhr8WyEY1bTDeDwNxLV8t5UXiy95CShbbhjW2CCDEJ1JmJqLlmLqia5UhbSRXgzpGsuoBel6bTSddDtrxIiFgHN9t2qaIGIRTa19pmoEqBUJL0pM+ovplTvDBxNmAcGhHVv0F0wnT2cjjrQsyZWmtBGzUSV3lZfI3noc74yGHOyS1Fn/oZgmrA+sds29Vyx8Fxcwr6DLfIkLzMLziMb0VjuTYyui+WDMO5pafKba2fIt9sdimkbP334PWbWfnTfVZbW1k7qgK4GalTLfSsiJ6aucprHEGfgutMv+63lNXxRir9j03wzomV82v8GBrH6UJBfjrN+Co5v+N+80c+uc7B6yB5+q/oC81y6wpIXpkE64YjDe2yMyeX+M74ykFrOoPyA4enS0GIovpKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0/EIC1NJs1CHPbEGkTEdKzcDF9+uHC3AIRMrBXugCCbHFiFdGfZYsHcs1Wtkl5Or6N1KNk6ZTEVmk47Ff2wXUPpw0iu0gUBMzZ/TO01PDYAuNLOdzFnb3zN6oQDAgDTaSpPRM5iv+iWTC7K2beb7tGlfZ9RzxP7nvdraWX79YqzxmSTJaPopBOO+hjzj53exrRWL0eXbv9H8YZs1ASLIHdwbeD04qt3kC02BMe4WHKxQqoQz/CHAwC/FDScj1AQ3epmBD8rxgvuXvV+5nnVfXfcD/q/liu+c87E1q2rxg+w+Q7ffZ/a3VxoLXpkG4A8BTgnCUseC0deZ8eqPWSrxf/DIRWuyVOgEtY7+4Gpjt6PqhahDUcXesIkLb5sooJC88i70gKkHdsfzMpdvPi2VA/Bx+oAElTnl7zBmJ67VATONa60M3qblphIm1MIok+il
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:20.7255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d740c83d-f66f-48e8-8238-08df078da27b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999300
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

This patch introduces AMDGPU UALink manager core infrastructure
which will be responsible for sharing buffer objects across
multiple GPUs, with each GPU running their own OS, in a rack scale
setup. The core infrastructure of the ualink manager will include:
- Store BOs exported from a GPU.
- Store BOs imported by a GPU.
- Store connection state with different GPUs.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 42 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h | 41 ++++++++++++++++++++-
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 3bffb3cb21681..d91365399c767 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -22,9 +22,10 @@
  *
  */
 
+#include <linux/xarray.h>
+#include "amdgpu.h"
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
-#include "amdgpu.h"
 #include <linux/sysfs.h>
 #include <linux/string.h>
 
@@ -1003,3 +1004,42 @@ void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
 		adev->ualink.info = NULL;
 	}
 }
+
+int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	adev->ualink.npa_wq = alloc_workqueue("NPA WQ", WQ_UNBOUND, 0);
+	if (unlikely(!adev->ualink.npa_wq)) {
+		dev_err(adev->dev, "Failed to allocate NPA WQ\n");
+		return -ENOMEM;
+	}
+
+	xa_init_flags(&adev->ualink.exp_xa, XA_FLAGS_LOCK_BH);
+	xa_init_flags(&adev->ualink.imp_xa, XA_FLAGS_LOCK_BH);
+	xa_init_flags(&adev->ualink.handle_invalid_xa, XA_FLAGS_LOCK_BH);
+
+	for (i = 0; i < AMDGPU_UALINK_ACCEL_MAX; i++) {
+		init_completion(&adev->ualink.conn_state[i].hello_done);
+		mutex_init(&adev->ualink.conn_state[i].lock);
+		adev->ualink.conn_state[i].state = AMDGPU_UALINK_CONN_NOT_READY;
+		INIT_LIST_HEAD(&adev->ualink.exp_handles_list[i]);
+		INIT_LIST_HEAD(&adev->ualink.imp_handles_list[i]);
+	}
+
+	return 0;
+}
+
+void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
+{
+	int i;
+
+	xa_destroy(&adev->ualink.exp_xa);
+	xa_destroy(&adev->ualink.imp_xa);
+	xa_destroy(&adev->ualink.handle_invalid_xa);
+
+	for (i = 0; i < AMDGPU_UALINK_ACCEL_MAX; i++)
+		mutex_destroy(&adev->ualink.conn_state[i].lock);
+
+	destroy_workqueue(adev->ualink.npa_wq);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 2d685f6dd7e7d..3882f29ccdae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -35,6 +35,12 @@ struct amdgpu_device;
 #define AMDGPU_UALINK_LOCAL_ACCELS_MAX 8
 #define AMDGPU_UALINK_STATIONS_MAX 64
 
+enum amdgpu_ualink_conn_state {
+	AMDGPU_UALINK_CONN_NOT_READY			= 0,
+	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
+	AMDGPU_UALINK_CONN_ESTABLISHED			= 2
+};
+
 enum amdgpu_ualink_type {
 	AMDGPU_UALINK_TYPE_UALOE = 0,
 	AMDGPU_UALINK_TYPE_UALINK = 1,
@@ -119,14 +125,47 @@ struct amdgpu_ualink_station_config {
 };
 #define to_ualink_station_config(ko) container_of(ko, struct amdgpu_ualink_station_config, kobj)
 
+struct amdgpu_ualink_connection {
+	struct completion hello_done;
+	struct mutex lock;
+	u32 generation_count;
+	enum amdgpu_ualink_conn_state state;
+};
+
 struct amdgpu_ualink_mgr {
 	struct amdgpu_ualink_info *info;
 	struct amdgpu_ualink_ppod_setup *setup;
 	struct amdgpu_ualink_vpod_config *config;
 	struct amdgpu_ualink_station_config *stations;
+
+	/* Xarray to store info about exported BOs */
+	struct xarray	exp_xa;
+
+	/* Xarray to store info about imported ualink handles */
+	struct xarray	imp_xa;
+
+	/* Xarray to store handles to be deleted */
+	struct xarray	handle_invalid_xa;
+
+	/* Array to store connection state per remote GPU */
+	struct amdgpu_ualink_connection conn_state[AMDGPU_UALINK_ACCEL_MAX];
+
+	/* List of exported ualink handles per GPU. Used to quickly traverse
+	 * the list of all handles exported to a remote GPU.
+	 */
+	struct list_head exp_handles_list[AMDGPU_UALINK_ACCEL_MAX];
+
+	/* List of imported ualink handles per GPU. Used to quickly traverse
+	 * the list of all handles imported from a remote GPU.
+	 */
+	struct list_head imp_handles_list[AMDGPU_UALINK_ACCEL_MAX];
+
+	/* WQ to manage revocation of exported memory. */
+	struct workqueue_struct *npa_wq;
 };
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
-
+int amdgpu_ualink_manager_start(struct amdgpu_device *adev);
+void amdgpu_ualink_manager_stop(struct amdgpu_device *adev);
 #endif
-- 
2.55.0

