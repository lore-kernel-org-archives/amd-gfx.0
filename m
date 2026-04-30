Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D50FF886F
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 05:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5652610E03B;
	Thu, 30 Apr 2026 05:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z/QKwrRw";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470EA10E03B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 05:55:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkdOdC26fbZeDdm5cmk+U9vunm/F9mAZwJy9JUQX61AEssv8yAZZJE7yknb0l+YCvm25MFTNbKNVAYr9hXviKwzGV/04uFKzWJ0ipoLlSAu8MXdsSQIasduwkABYuyKa4yrADPd37bK8XpjdfApa7TvbHl1h9Y8YYXcHxBogHxBLFUJeyiDFCEqRdYfl0VnMpvZ1pLC8OQkoYyOpfwkG5xB5bEIlGezJIYjc4M6RcPBpI+wetT6Q0R9yPY4agEUNfVyBEVwIMkiNR0pouNXWYI92qMLGNYy+gb4wZJbkFTrcoaeHiFIdRNpIfi4UqJy3Axg/gE0Q/SkgWi3z5A6w6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4wORvkYHGNsvLYlVpoaDrAYdQGMnOiMbiBli34L7pk=;
 b=cVLDjvf6kUTI/PMDvKHMR2kRgQSMy0JWhoIxPUvB9G4yaP3A/5hvfgKZkw4+hUKIZAh6fQ0BKdZySD/aPXCSLzpWR/JVOxcJPrCe7teCUYNfYQjVusUAwN8CmWQSKqrtoH70LGzn+kjSkoClPyvFYIPpn8vMqzEzAvBLmIjMDtp5OY59ma3pAw7zAWupyPj3uL7ALPkiw3Sikv4jUsLYepJJJqdkM0FSyziCreZ2b8oLTgCzmW+4Tg59L2fThe3Ywt1aJCLb8WHxQ03X28TjRrOetoqUh7H3AVARKt4b8cHeNppp1TeYTumkQfYDNbhmeVv7y+7I1WLA6mod3UShjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4wORvkYHGNsvLYlVpoaDrAYdQGMnOiMbiBli34L7pk=;
 b=z/QKwrRwmUhWtgSd0JEtQkksqb81oYGuwa2oh0qNaAxFEXBqu81NSxPrUyycOzjcSZNAkeD8uNlpIRTC+8jtwA2+mOy7AOXbxS0FpyyH+4AxGx7naYmsRuqjtQfv3MNOVt7WJkxnZ5i6xYvGtTkCKCSY0X3xp9AUvOq3yWMncgo=
Received: from CY5PR13CA0035.namprd13.prod.outlook.com (2603:10b6:930:11::24)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 05:55:48 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::2d) by CY5PR13CA0035.outlook.office365.com
 (2603:10b6:930:11::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.20 via Frontend Transport; Thu,
 30 Apr 2026 05:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 05:55:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 00:55:45 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Christian.Koenig@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add helper to set gart size
Date: Thu, 30 Apr 2026 11:25:26 +0530
Message-ID: <20260430055527.4026042-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 9689bab9-41e5-4322-6ad6-08dea67d2052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: fo6BgHbmeFjp99/lkTk/M72FHBNsJPSnSihdwmGNF3+MKM49zHoMnE/tg3eL+P3ggx/i9LKZ6/32e2CBfgZTeFajAmlZ6YBp+MRPgmAbzyUPz/9wLyBXmCXGKOjhIiIY9Y2Ae9wBGTw52uzd2eJPXyCWi/f9BnAdjP76MaLowCs0Cxey4v9LShthZX0I7VcYtY4KY+mbI18QjpvAxbu8GPEWudL6KdQOaIjXJyW/VezHyK7f+9xeVq09jHnw0h3j8+ARogOGz2Srvzz4wAIkBiSlaWvBDUzVK3h6g27qzxUqbMCCppcacaH6ZRLl/ZtRqYX2m42leGqwXSwcYRw2gj8kYwGa6wy54vCNz4lkQOiUOO8r5g3AKT4gz7nsz1TFWDUqVo7R19K6pIDye9/Vztfi0EvGwb6a6sRe42+0XzXdmuvQnh9TexY67HJWTzznDzZAtXhv55z9F9A5tBckS3X5RfsRjsLqtSoaaIHTOEjvsgRjxvBPKXNCFl+EuCLHbNAmaJhZWG2DgvDvdbyOGWXBobyOInKGBVRXfBmZUkXjdALXQ38KK0wF6KlSByx1zS8qwAirARup26smmc+otRA2UaySJpBLWdgYy8S5sDdje0IbvigO7UYP2zD0j6sbRjEmFRMTF8APkxt5i1FKxpxAtuV5z8SRqpnWfkmnB/B8L+mVsdXftNoRyJtGYrN+5QU6+EyY8nNzw4mBa96tDhFGA9moVLtIlWqIC1/8DMHgtHsAUv00Qu4vyqRmlRAdwNPFSEUkwZdR4m1WS2FoFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KXHA2xO+E1PK4hBAGZeWXu9JTy4h9MyY2A5UYj/qR6CcF1IauhdqK0LH1WKTG+WUAewNB+wc2v8TqTDuhIiJHYyAgApjdcA01eUUfzjFp0ZUrR0I4D0qeX98GvgqV1p7MTR9Gdm2n90WyHsjSsGCH1jEOqDJSDk0YHe1vV6WaFHTm31AFk+DcaM4/tRBY/fM1D63bEYdkKK8FxuzCDxcDZ8xYWybEX8UObmFBbrFGIYIEBdfrU7pmevXm5ItzPLR1ufrHLaZ6LMzo/4vu76avZpjXSEoGSaOLVTHMz8IQebEhuhkm6qaNzFdjG98yP/hk9Js5V7nis2eswAzkrDFi3WQcfIvb1PrxP0zf6+Uv6g7B7yJt5kIQQ7ABEiNZ7SP/KSfwUk3GUJ+ieTMhDCmfHjzL9QraVE3ghVj/MPRgXWCfghfWvAclNn8SWhbYNVw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 05:55:47.5622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9689bab9-41e5-4322-6ad6-08dea67d2052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
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

Add a helper to make any adjustments to gart size based on other
parameters or conditions.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index e6f7d85a8725..13bec8461cde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -280,6 +280,15 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
 }
 
+void amdgpu_gmc_set_gart_size(struct amdgpu_device *adev, u64 default_size)
+{
+	if (amdgpu_gart_size == -1)
+		adev->gmc.gart_size =
+			default_size + adev->pm.smu_prv_buffer_size;
+	else
+		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
+}
+
 /**
  * amdgpu_gmc_gart_location - try to find GART location
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index c6d7a9e54eb3..676e3aaa1f27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -486,4 +486,6 @@ void amdgpu_gmc_init_sw_mem_ranges(struct amdgpu_device *adev,
 				   struct amdgpu_mem_partition_info *mem_ranges);
 int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
 		int *vram_width, int *vram_type, int *vram_vendor);
+
+void amdgpu_gmc_set_gart_size(struct amdgpu_device *adev, u64 default_size);
 #endif
-- 
2.49.0

