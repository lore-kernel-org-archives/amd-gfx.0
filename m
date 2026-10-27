Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A82606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jWZPb/Gv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1275610F47A;
	Tue, 27 Oct 2026 12:56:59 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5317310F466
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 12:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5ySAs+wc66J+FRHoPmrykSQFiBHYBEDYQqotKcsR23j2EgIPYcGzq2p8oXwoYD9rDrdGil05UfbdE/uR6fE9MuhDLDFZBoy6fYTifQwcDFeI0bn5aOFg8Ury7eNk/RxhMpJxTGEPw+hY0OUEh10Uz0rj39wir5/S44uw50LryX/lPOs65cHYvE4P0s7AywXrX7xcUQZ8oMoT3aDSYTxX1Js6z13jHwlfQP9ez1Fj6jV9kpDv0aCXyVTiVrS+5RdZA1iqbro8tLX4GHfPO44kuPcNa368ef+z7gQ3/JeoZeaJ7SDjCbc6ty3dQV+6DlQUUXEYzR2wgSttiDeJ+wFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQkOKGteAimlZ+uCDOHxcwxw2ST70NmA6vdsBqzrJ9g=;
 b=Y8GCO7jL1FOIzMW0KRCf2rqNy/ZWBmT4p3fmsXOc6+rsOy7fHdjbmu/96lclBh8awrpCQmgV2lYbu94n+kgo6Oi+4ISoM8r9jZCK8JTWYfSfJ3b5fY/2Bey18jC0LT9dvyE0BBw86JnWgGIgzfOdOohQMintqDs1kBMf7ayTw0bTCwqZOTUd/cU/4TQEYawRoh+1C8p9/eLMHtJa4e2wlVdiQ4QzXp6WVXT8PTCWxkYcBLvrHYTt/wMx0LzyfPAb8uGHe7jhGutZijAWoCexN3FcynKOD52GJYIsJsuIfZxnITw8QZKfqdNaHKrTZyPU6nwEdtwruLdOrFD8oe0/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQkOKGteAimlZ+uCDOHxcwxw2ST70NmA6vdsBqzrJ9g=;
 b=jWZPb/GvHvnbFfa1G45uzHqdY/LGm8oaesfJiMA++H17qXg8IZRBQtjG3/EonRyQg5OkJGj9icQS8k81fSlPeLyWFiFrfsQLuNutBrw6pB8y8j8OpmCFuLu8ukQrwQsX0ToRAOcSjLPNASxiqXsoQBfb0YMEFKqVDXJfZoWlf3Q=
Received: from PH8P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::7)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:56:45 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::96) by PH8P220CA0035.outlook.office365.com
 (2603:10b6:510:348::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 12:56:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 12:56:44 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 07:56:40 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Zhigang.Luo@amd.com>, <Gavin.Wan@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: Refactor amdgpu_virt_init_critical_region
Date: Tue, 27 Oct 2026 08:56:10 -0400
Message-ID: <20261027125613.6549-5-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027125613.6549-1-victor.skvortsov@amd.com>
References: <20261027125613.6549-1-victor.skvortsov@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: abfc68ef-c45c-4853-ab88-08df3429c120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|261026140227099003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1MEq9ddqklEO5H48F9UQjfceMVcUeeafcHwy3aSHzlH6akfNqZr3U8Klib9n85v2nn85syjh/JuoY+3Rydkx8oCoyQE7C06kYGI5byaGFVYBxFVFpQFDVDjM2KWV0pGqNFdOD8nr9/OQd+wxrIBsXg0/Kwv8a/ZiHVPPyZToMmZl/0HdnKZJehK8yLxHTXy0bwZ9DLYEBHAEEhf2hD6GokdBpxt8L+TcZt2oZ2Ae2FjLOWB690ow2vxTcPlqdyeK33LLTWTmWRrei8y3DZuWK72HLpUUKeli7GC7ozIYj7MWqC3Z2E4oOOzAfVdG0RYkRgNmXtFZGrkDseAetMgLpElTopMkwd3xDn0ODT34UAbaS5TmxOtDaJ8uDedmwFqCXW9YMdW49Iqlf9fytvTF5Xa80bp+lC3ujWhOKRSYFpCtiaPtAIsZsioTc/UAt8YiLIVSBjsJn0mG14BqogMvSdXw25tw+mlh6CDojLQZZEVXVUI8JX+Dt9p6j2et0aAZ1hMhxYCJFJXZDWrXufg7bqb4O393ONL0a/HLt8LyKtR336TyfKUsc7kGIXOdPh8wDoKIc9I0xi7mXeGdi1XUClrpVv+g5ZXdreDqTfrucmGY3Vr/2gB39bpmMIHAxb5WfY0/oIXwNJpjYkQLV2D/UF/d5taip+9dzhswI5k5yMiP1usCIVPXxsAXoiTt1pYMfpCdwR7gKXAlETakcx3STA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(261026140227099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PLLJdF2ldR9cYW1L5sYnseDE3FnwE4mqs85q0hCsNzaGIWEAqvrcn9vVMZT9kogmpGTrW5DDJGP4dJ++l8NPSt84SI0Hau9U7O5lKBxH4GLjk1guLI/2mce2TxXDbpZajQfbXiRmdmzy3ySLWD/68Ml9gW3riImY261WpHZFEWTc0BL/ZY7no7MVagTdMXtPM8iG/Dv+/NjB4HpA2w9lQsQaMyS2tM2qtVHepJGzZX0JENl/OVvE2Ms8bcG+vluVHYP+f1dnF3pt4VD9liYXiqIZWYVVolAerkcoATEfA+qBabQuHbc85gmKS+iHX4kCCW3RMztkIxBwlsZKS8e/BO4yOrkRPYXBfGKwaHKP0lUMDEQT4kwb6E4OZxXJ2nqykM9pU9ajsyCEWzgPOH6RoyN+BYjctaGXZkJLhZiLFli1VSOaE/kTuuH/khobBRRB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:56:44.7451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abfc68ef-c45c-4853-ab88-08df3429c120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
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

Depending on the version, the init sequence will be different.
Make a common entry point, and split backend init by version.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c | 54 ++++++++++++++-----
 3 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 54ef47126b5f..d286e2585c61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 				return r;
 		}
 
-		r = amdgpu_virt_init_critical_region(adev);
+		r = amdgpu_virt_xchg_init(adev);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 15d63b53285c..f664186c6a48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -532,7 +532,7 @@ int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev, int data_id,
 				      uint8_t *binary, u32 *size);
 void amdgpu_virt_read_pf2vf_data_early(struct amdgpu_device *adev);
 int amdgpu_virt_exchange_data(struct amdgpu_device *adev);
-int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
+int amdgpu_virt_xchg_init(struct amdgpu_device *adev);
 int amdgpu_virt_xchg_start_work(struct amdgpu_device *adev);
 void amdgpu_virt_xchg_stop_work(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
index 12d901e5c0ba..9f34bc1b468d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
@@ -455,20 +455,16 @@ int amdgpu_virt_xchg_start_work(struct amdgpu_device *adev)
 	return r;
 }
 
-int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
+static int amdgpu_virt_xchg_init_tables(struct amdgpu_device *adev)
 {
 	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
 	u64 init_hdr_offset = adev->virt.xchg.header.offset;
-	u64 init_hdr_size = (u64)adev->virt.xchg.header.size_kb << 10; /* KB → bytes */
+	u64 init_hdr_size = sizeof(struct amd_sriov_msg_init_data_header);
 	u64 vram_size;
 	u64 end;
 	int r = 0;
 	uint8_t checksum = 0;
 
-	/* Skip below init if critical region version != v2 */
-	if (adev->virt.xchg.req_init_data_ver != GPU_CRIT_REGION_V2)
-		return 0;
-
 	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
 	/* Fall back to RCC_HW_DEBUG when RCC_CONFIG_MEMSIZE reads 0 on a VF. */
 	if (!vram_size)
@@ -483,12 +479,15 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	}
 
 	/* Allocate for init_data_hdr */
-	init_data_hdr = kzalloc_obj(struct amd_sriov_msg_init_data_header);
+	init_data_hdr = kzalloc(init_hdr_size, GFP_KERNEL);
 	if (!init_data_hdr)
 		return -ENOMEM;
 
-	amdgpu_device_vram_access(adev, (uint64_t)init_hdr_offset, (uint32_t *)init_data_hdr,
-					sizeof(struct amd_sriov_msg_init_data_header), false);
+	amdgpu_device_vram_access(adev,
+				  (uint64_t)init_hdr_offset,
+				  (uint32_t *)init_data_hdr,
+				  init_hdr_size,
+				  false);
 
 	/* Table validation */
 	if (strncmp(init_data_hdr->signature,
@@ -598,14 +597,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
 				  adev->virt.xchg.offset,
 				  adev->virt.xchg.size, true);
+
 	dev_info(adev->dev,
 		 "critical region v%d requested to reserve memory start at 0x%llx with %llu KB.\n",
-			init_data_hdr->version,
-			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].offset,
-			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size >> 10);
+		 init_data_hdr->version,
+		 adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].offset,
+		 adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size >> 10);
 
 	adev->virt.xchg.dynamic = true;
-
 out:
 	kfree(init_data_hdr);
 	init_data_hdr = NULL;
@@ -613,6 +612,35 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	return r;
 }
 
+static int amdgpu_virt_xchg_init_crit_region_v2(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = amdgpu_virt_xchg_init_tables(adev);
+
+	return r;
+}
+
+int amdgpu_virt_xchg_init(struct amdgpu_device *adev)
+{
+	switch (adev->virt.xchg.req_init_data_ver) {
+	/*
+	 * Host assigned static exchange region location from mailbox.
+	 * Host assigned dynamic table locations.
+	 */
+	case GPU_CRIT_REGION_V2:
+		return amdgpu_virt_xchg_init_crit_region_v2(adev);
+	/*
+	 * Host assigned static exchange region location by mailbox.
+	 * Host assigned static table locations.
+	 */
+	case GPU_CRIT_REGION_V1:
+	default:
+		/* V1 cannot init early as BIOS has not been parsed yet. */
+		return 0;
+	}
+}
+
 int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	int data_id, uint8_t *binary, u32 *size)
 {
-- 
2.34.1

