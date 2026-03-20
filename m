Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC089108B8E3
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 09:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689F810EABC;
	Fri, 20 Mar 2026 09:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UK/vYyGC";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD7610E197
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 09:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr+ss6Lysv34VrM7O/Zia4rH71s2i3tMqmTiCEWFWHm0/NYKK6RgWghP9uLr502NxavAvVizgK8IIQ6RKvWMyAhZUoTbXK4WSekspaZf2i8HsfGYbJQEXmQTGjwXXvbHvM1D51VvG37TC0+PtcnT4FpqTKD2wi9clGra8hw5/i3HOt6HFMxHBiEQ7wwXcO6/QfuOoM6OwLjg+3ev8zONEFvYllYYOYTugvUkBGKAkFHC6CVuVZAvC4Svm7D2DM0OFGX3wRlmjWoQqNkuQdE5TbXtzWAhPXAly5SFz1/ctuErPwaWTV63SFLrA13rUqi/STZC+cti1tIRsKWK1W8JaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uRqF4lj4/dB3AilPBKjno9mXM+Z8kgAyoCQQFiqxDo=;
 b=r3F2LKkFNeeojx1y1gMb9q+9ksVI6uoXdMv3cvn742fDUs91Q62bkNwcWDtYZW4GAXsdHjFYupJqGoE2LmJIJ6xTAuBddE8QUcHtcbv9m+tYl8Ko3a0Xc0ln8thG2XFq3QQ5Lt5+dmOgU7ktTEMLewRYUG9R7N8V2ifyLk836kX1bgiJz0/DsOJFcGOTWyzMe5lD5ip2zmhHdaV8RomCadQ4+N4StrsmzryfAeNeQVv7AHFK8MOn/tnZQn3TNvqOuDFcFcypgXxLtkXqkv0ljr/F7I5OFZPZUXvWWnVoYypxnfEogmiOZm0Cf7as015yfex4LxzOVe+IdF5S5PUVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uRqF4lj4/dB3AilPBKjno9mXM+Z8kgAyoCQQFiqxDo=;
 b=UK/vYyGCDXydr1KJjGKVGBi/c8MighTpgthJ59wxUzNShI8oKrWcjCTpj0Xg/6TDOQqHhNQ2GaxuZzmZNJ9UafKG3HvXz3FzbP/hkSNyCF3Hy1LwIFRGQjHM+NN2BUm9rLfSO66vlATR8yZqx3NA0nNQxm9qJjekWo+ovw9/YEA=
Received: from BL1PR13CA0147.namprd13.prod.outlook.com (2603:10b6:208:2bb::32)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 09:57:45 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::cb) by BL1PR13CA0147.outlook.office365.com
 (2603:10b6:208:2bb::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 09:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 09:57:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 04:57:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 02:57:44 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 20 Mar 2026 04:57:38 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: harden discovery TMR buffer allocation
Date: Fri, 20 Mar 2026 17:55:27 +0800
Message-ID: <20260320095737.238247-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cade9c1-a5b0-4a57-6ab6-08de86672287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: XS8IR8jd3UdOTJO0jt+Fruqva+0L86UvKAu1u6m10Sp1qGSkSN2noHPHZf3xgdozlwUGKtjxqSEdtFExWEOad9f0pIk/6iuPZEHLmjN75aSHrQr2fai+2+0wSvLp+llxM2FbRZBqlAgWqcV+SWn4cAoHXNkmiTS7sJwU3emavR3LCXaZYHPsDb7qmp05olUNcAA9l53GbLG0mnvqKYBWQ6MCLRj1JPEl4QQcqVKXv2Yu9qCW7Q4D2eSh+GyiPGValqxXfEkn8kgIUC5vLcQgFa9mGJIaFiAYXCzHPlAJ77ecTpobKu6Op/Ga3EGwowuy4AXLDdiOzE3xkpol6xF3/SHf001vLYsTevn1BxsCYTAQIo53kTYDDnFWm/+s1g971+JjHE9dUk9BQfJooi2erNOM1bbCssB0U3NjT2NwNDsH6sJ1o6ZrXmwYbnWRO60/xBdX5Ss16LVl+k25oWTqgW9Qevi0rlHT6jBLvtKkJx/1afZVkQ/LHLTO8QEqVK2DBrUEyFI24swOLvuOaT9OTUAGqADRRhHuRrHige4A/63PPqNI84qyDeOqZKJZs+YXrQ7F8XL7FtLS/by8zmsHk2EjKMJv6MkYll4+affDz3ugbX2sduaxGV8xffmtdgYu7/sYFyhVJhi2NZcDdlhyK1fIf/kdRXc4luupG4d4/SouN0H3SD+AihEs1Opo+da33zrInKyfTGxlHT7qpgzjaZPYsDsedOJjS8fHr9GDYMUEs1dCkbYFn3q44Nfsb+iGWpqgeA08/dxWM21EwCn5Cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tWLIl5mk3i1E8Xs78HKDzn3RZuc3FbmET3VebODN6EhV8v3EQw0P3fYoZKiE5iBkE0uvxTuKo3Wb6KZjkByKJlr351JtG2QoddoPtpAz3HJPiliPDjbUeYMgiah+xZobt2B7hXanYPOPsHPSuOfgtHV6J7uFT7/tf3+w6AlWbgZnWqP3tO7ysOdFQAzd+ty4UWvGxkh182EJLaNxl7NSQ1G6uLQN8kFywDPzvDWI9+LOSZ4tMFOZr9TzpEc3P8FaNSABtnZg6BpC4QdgVbxqpemxS0RPYZKns+AvNVOwdhYQw1nW+ks8cf/lt2jqpUZVjHoFb0+Z0gvJ8/64bIb0Vhd2vW9wjiBr/Endh6r/+Xi4FwjupT8l0lHembEnv/JTE5mNpeQN9GQ+1HSpNfaFu9JkiH4OwWRNgKg3lsgr2BQeORFCXZ8ZKb58YVjC+yye
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:57:45.1806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cade9c1-a5b0-4a57-6ab6-08de86672287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
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

Some platforms report an invalidly large IP discovery TMR size, which leads
amdgpu_discovery_init() to attempt a large kmalloc allocation and trigger
page allocator warnings/failures during probe.

Observed log excerpt:
  WARNING: mm/page_alloc.c:5216 at __alloc_frozen_pages_noprof+0x29e/0x340
  ...
  ___kmalloc_large_node+0xf2/0x130
  __kmalloc_noprof+0x442/0x6b0
  amdgpu_discovery_init+0x161/0xa00 [amdgpu]
 Fatal error during GPU init
 probe with driver amdgpu failed with error -12

Fix by:
- validating discovery size and falling back to DISCOVERY_TMR_SIZE when
  size is zero or out of expected range;
- using kvzalloc() for discovery buffer allocation to avoid high-order
  contiguous-page allocation failures;
- using kvfree() on all release paths.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5a4e63e1ad93..a6b49378c495 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -329,7 +329,20 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 		}
 	}
 out:
-	adev->discovery.bin = kzalloc(adev->discovery.size, GFP_KERNEL);
+	if (!adev->discovery.size || adev->discovery.size > DISCOVERY_TMR_SIZE) {
+		dev_warn(adev->dev,
+			 "invalid discovery size 0x%x, fallback to default 0x%x\n",
+			 adev->discovery.size, DISCOVERY_TMR_SIZE);
+		/*
+		 * Some platforms may expose garbage TMR size through scratch/ACPI.
+		 * Fall back to legacy layout in VRAM when available.
+		 */
+		if (!*is_tmr_in_sysmem && vram_size)
+			adev->discovery.offset = (vram_size << 20) - DISCOVERY_TMR_OFFSET;
+		adev->discovery.size = DISCOVERY_TMR_SIZE;
+	}
+
+	adev->discovery.bin = kvzalloc(adev->discovery.size, GFP_KERNEL);
 	if (!adev->discovery.bin)
 		return -ENOMEM;
 	adev->discovery.debugfs_blob.data = adev->discovery.bin;
@@ -694,7 +707,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	return 0;
 
 out:
-	kfree(adev->discovery.bin);
+	kvfree(adev->discovery.bin);
 	adev->discovery.bin = NULL;
 	if ((amdgpu_discovery != 2) &&
 	    (RREG32(mmIP_DISCOVERY_VERSION) == 4))
@@ -707,7 +720,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
 	amdgpu_discovery_sysfs_fini(adev);
-	kfree(adev->discovery.bin);
+	kvfree(adev->discovery.bin);
 	adev->discovery.bin = NULL;
 }
 
-- 
2.49.0

