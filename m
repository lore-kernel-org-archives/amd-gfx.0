Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1508606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=o7BSeXPc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1039410F1C0;
	Mon, 26 Oct 2026 23:03:20 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D880910F1C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 23:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTIugbIpyIpnXKN3fmcT4JXGhjGqFDN0l6BSkRDFcpjQyzuHzYcgLWHSSzLyo1XP4mltr1kipMOiOLe3K1ldp73zLDvVMBFIQ8pj7yr2AqOt+ihRHYZZvCR6FV6eVLoMA0MfTZlvjX71oyt7gQVMhhyO1xZ9xGqm6xAxByfI12i7lm3r/VtH6F/XuXXAnLqb5tYUX0HMo72PkE2Qqvg8HEim+/UANHNcsZ/5Xb9wIt9g/ZjQiopcOVGrjiGsOAufeWZ1/XmEoe4CtFSoH6x17Jhbqij9n64j8fin0GRlOeXIa9PbtrNwfydBStNeEHNITRuCSaHQr1zLR0jL55Lg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5vVjQgyJvD4JdhJLz3IHs9AHpFhyY7zCC6nib0wyn8=;
 b=oyf6+y6PGAMHbUUFUuh8RwmycVrNpDc0zDsplyqJYt87arYiVrdMhPg3DWNSOrY7glTsrA3lD7/soSusqazQTP2wi/YXyYFBYePTFCgclo1TcX3IMseEj1U/q7IUitEmuT/t1Jl0vo/TFHbgqB6udZs+LpJFFG5rGKYqjS005BAuqUzDzglUh83qmVh8K1NwRJjmrPAC3LjH3V4zizNdymkxl/ZjObrGZD4kReEfqQkaebV82QiFoS2YZ/YmsADerBsAz9H2RUwfJVv7B50m9Pf+Q+hUuCsv572lEIMIoCdn8HB2D9ebD8FOKiI41HwfeV6aTIWl7EkXjxAljcohAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5vVjQgyJvD4JdhJLz3IHs9AHpFhyY7zCC6nib0wyn8=;
 b=o7BSeXPcyUBJel0B8UmpraLzGZsNa7yPCUpdYz3GYhXqa9mqukXhQSOHar3dkICmV+uac1gkVHtWN5MAWk1GrxjLK7hflfQ1CKRdT1yrkyKKGGyMTCCal1tJ4LnxDfU/ikrBubRLebnZetlE1Q9w53ibudbo6mg6+pt38jOuXc8=
Received: from BN0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:141::9)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:03:06 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::2e) by BN0PR07CA0019.outlook.office365.com
 (2603:10b6:408:141::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 23:03:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 23:03:05 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 18:03:04 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: Enable UALink loopback mode
Date: Mon, 26 Oct 2026 18:59:28 -0400
Message-ID: <20261026230248.1597606-7-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026230248.1597606-1-mukul.joshi@amd.com>
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: a43171b2-0e86-47cc-0d66-08df33b54b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|261026140227099003|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|10067099003|18002099003|22082099003|261026121527099003|6133799003;
X-Microsoft-Antispam-Message-Info: cmPN3XyLmJ4RXv6HoKVoXieyedcITKDU8GuwkM2evTS8wfTr7x09XLaqO7eaGDmXBy4bFg/kN3G0s0Tk01pHQVsrC1ifpy+WJxYkirtxotpC44uSmHuA0DV7vytd0fL4umAZUSEeGkq6m9cmGpjXAMmNvYfu3ij+xx+y26COccs2E+GK4UA4S5zwPh5Xhobx9gN9cnyeVz0QqUzpBKK7Wnnuzj5+myp5HFlyGE/P4gWa8lDfSv5jIW7NX6FQiJVqKlAzRTauPuF/RhL9hU9fO4ZzHrOve24P1wzE4Ra/qUvKNhPH1V7PYpvmjGSF7H6q5JlVLECc2ZALWb37tNmWRqXvBMUMqa9E92N4IzkEv1D3xtqAlbm2Upg2MsdBzdzVrDqvIHC2tnxXxs4LsyVCRGtnyefQCS+9h5yzxVs6IL8XCOdKyU9Q5lon3Vq3M0U2nrTPYemojehwWN2GBEFHZwREvhVQNJV6lkwq3HRHCCV+UgabiwgCNlbChFj7K86TqBor5KRzf28twojfxu36MBz2jode7VRMzVwh8F3+xyi0um0KnmdH2EFkO24rZEm+KIWBctwqlpyuvQ6Ir9mqadEhd+KZTGfn3V2K/MWczuER5eGr5zsLuKza6c2/ooAA1CmYZJb4tIDQM5aEN6UU2wIqOQ9YqswEjbngoXvDIhBedNMuatsi9aeFxpDRoYZcvM0Tki+gna5Pd89VsBa49g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(261026140227099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(261026121527099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TKFZ26EJnyBZdjaM5R6YfPISaDoWd6XxkYEGIZjtu6Z11/owbctOO6gvY/IvRSqDd981Q6FFxyHSRMRPim1Hjg8soLj9BQ+z+JTcNTvLWLaEp8plXVtrZfMVbiq/GU9xyc6c0vHZlKvmFUqNY30LNue1TZ+rfbSg/OGVEgBNobiVSZ00/11C7XMkjvbHLvy6/Jorgh3ds3pNG33m3iSQ3bkLtFm3I/ReSV+AyjIC7RzYNZ5XzwexhLhYMsYGxXxMFPcxcQtGZPSOPvA4n5jKAQV6JTCL4f5Yb1zwK+SD7s78tmQnFClqDGZrNLS1MXHiZPg48KWGi9X59dniwbSGcAQzBQkmiaWq2KE70bC2xi8scebmRd8qlrnK7ynHtHXwAsO66+Qp7cM7QGUnuxcxCLDlodK6DJ5t6XBkPtfu+gFN6q7lMZbGrZty00XFfabS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 23:03:05.7995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43171b2-0e86-47cc-0d66-08df33b54b7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In UALink loopback mode a single GPU acts as both the exporter (accel
ID 1) and the importer (accel ID 0). This lets the existing tests export
a BO and import it on the same device, traversing the UALink HW
pipeline.

Add amdgpu_ualink_loopback_detect(), the single place that decides
whether loopback is enabled. It runs right after the UALink info is
queried from PSP, before any per-peer setup. When loopback is enabled:

- There is no user-space agent to configure the pod, so synthesize the
  pPod/vPod configuration with both accel IDs active.

- Activate the device directly instead of through the cross-GPU vpod
  activation path, which needs peer GPUs and a user-space vpod commit.

The mechanism that requests loopback mode is added separately, so
amdgpu_ualink_loopback_requested() returns false for now. The normal
activation path is unchanged when loopback is not enabled.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 128 ++++++++++++++++++++-
 1 file changed, 123 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 9326836f4f4c..1e30391e2e18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -62,6 +62,7 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
 						 u32 sender_accel_id, u32 dw0,
 						 u32 dw1, u32 dw2, u32 dw3);
+static void activate_accelerator(struct amdgpu_device *adev);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -92,19 +93,130 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
 }
 
 /*
- * amdgpu_ualink_loopback_init - set up UALink loopback mode
+ * amdgpu_ualink_loopback_requested - check whether UALink loopback is requested
  *
- * Called once loopback mode has been detected. Allocates the ordered
- * workqueue used to emulate exporter->importer interrupts in SW.
+ * There is no mechanism to request loopback mode yet, so it stays disabled.
+ */
+static bool amdgpu_ualink_loopback_requested(struct amdgpu_device *adev)
+{
+	return false;
+}
+
+/*
+ * amdgpu_ualink_loopback_detect - detect UALink loopback mode
+ *
+ * This is the only place that decides whether loopback mode is enabled. It
+ * must run before any per-peer setup, since enabling loopback changes the
+ * accelerator IDs returned by ualink_exp_accel_id() and ualink_imp_accel_id().
+ */
+static void amdgpu_ualink_loopback_detect(struct amdgpu_device *adev)
+{
+	if (!amdgpu_ualink_loopback_requested(adev))
+		return;
+
+	adev->ualink.loopback.enabled = true;
+	adev->ualink.loopback.exporter_accel_id =
+		AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID;
+	adev->ualink.loopback.importer_accel_id =
+		AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID;
+}
+
+/*
+ * amdgpu_ualink_loopback_populate_info - synthesize pPod/vPod config for loopback
+ *
+ * In loopback there is no user-space agent (AIFM / xncmdclient) writing the
+ * UALink sysfs nodes to configure the pod, so populate adev->ualink.info
+ * directly. The layout is fixed and known: a single GPU alone in its own
+ * physical pod, presented as accelerator ID 1 (the exporter) and also owning
+ * accelerator ID 0 (the importer). The values are made self-consistent so
+ * check_vpod_info() would pass and amdgpu_ualink_metadata_init() programs the
+ * importer's ring buffers / GART NPA mappings / MP nHT receive metadata.
+ */
+static void amdgpu_ualink_loopback_populate_info(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_info *info = adev->ualink.info;
+	u32 exporter = adev->ualink.loopback.exporter_accel_id; /* 1 */
+	u32 importer = adev->ualink.loopback.importer_accel_id; /* 0 */
+
+	/* Physical pod: this GPU is presented as the exporter accel ID in its
+	 * own pod. ppod.size must be large enough to contain both the exporter
+	 * and importer accel IDs. ppod.id must be unique within the system
+	 * (matters for 1P4G, where every loopback GPU is its own physical pod).
+	 */
+	info->ppod.accel_id = exporter;
+	info->ppod.size = max(exporter, importer) + 1;	/* == 2 */
+	uuid_gen(&info->ppod.id);
+
+	/* Virtual pod: mark BOTH the exporter and the importer active so the
+	 * per-peer setup (amdgpu_ualink_metadata_init()) programs the importer's
+	 * resources for the importer accel ID. Preserve the address mode queried
+	 * from firmware if it is valid (keeps source-identification HW working),
+	 * otherwise default to source-aliasing (MI450).
+	 */
+	info->vpod.id = 0;
+	info->vpod.size = 2;
+	if (info->vpod.addr_mode >= AMDGPU_UALINK_ADDR_MODE_MAX)
+		info->vpod.addr_mode = AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS;
+	bitmap_zero(info->vpod.active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
+	set_bit(exporter, info->vpod.active_accel_bits);
+	set_bit(importer, info->vpod.active_accel_bits);
+
+	/* Only the exporter (this GPU's own accel ID) is a local accelerator;
+	 * the importer is reached through the (loopback) remote/NPA path.
+	 */
+	info->n_local_accels = 1;
+	info->local_accels[0] = exporter;
+
+	/* Mark the pod vpod-configured so the activation path proceeds. */
+	info->accel_state = AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED;
+}
+
+/*
+ * amdgpu_ualink_loopback_activate - bring up the UALink manager for loopback
+ *
+ * The normal activation is driven by the sysfs vpod_config/commit path via
+ * activate_local_vpod(), which derives the local accelerators from peer GPUs
+ * and runs a cross-GPU integrity check. Neither applies in loopback (the
+ * importer is not a separate GPU), so activate this device directly.
+ */
+static int amdgpu_ualink_loopback_activate(struct amdgpu_device *adev)
+{
+	mutex_lock(&mgpu_info.mutex);
+	activate_accelerator(adev);
+	mutex_unlock(&mgpu_info.mutex);
+
+	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
+		dev_err(adev->dev, "UALink loopback activation did not reach ACTIVE\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * amdgpu_ualink_loopback_init - set up and activate UALink loopback mode
+ *
+ * Called once loopback mode has been detected, after the initial pod/vpod
+ * configuration has been queried into adev->ualink.info. Synthesizes the pod
+ * configuration (there is no user-space agent to write the UALink sysfs nodes
+ * in loopback), allocates the ordered workqueue used to emulate
+ * exporter->importer interrupts in SW and activates the device.
  */
 static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
 {
+	amdgpu_ualink_loopback_populate_info(adev);
+
 	adev->ualink.loopback.wq =
 		alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
 	if (!adev->ualink.loopback.wq)
 		return -ENOMEM;
 
-	return 0;
+	dev_info(adev->dev,
+		 "UALink loopback enabled (exporter accel %u, importer accel %u)\n",
+		 adev->ualink.loopback.exporter_accel_id,
+		 adev->ualink.loopback.importer_accel_id);
+
+	return amdgpu_ualink_loopback_activate(adev);
 }
 
 static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
@@ -498,10 +610,16 @@ int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_ualink_loopback_detect(adev);
+
 	scoped_guard(mutex, &mgpu_info.mutex) {
 		amdgpu_ualink_info_set_accel_state(adev, adev->ualink.info,
 						   cfg_state);
-		__amdgpu_ualink_activate_vpod_locked(adev);
+		/* Loopback has no peer GPUs and no user-space vpod commit, so it
+		 * cannot use the normal cross-GPU activation path.
+		 */
+		if (!adev->ualink.loopback.enabled)
+			__amdgpu_ualink_activate_vpod_locked(adev);
 	}
 
 	/* Treat this optional, no error check on failure */
-- 
2.55.0

