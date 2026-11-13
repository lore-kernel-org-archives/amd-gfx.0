Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF267606A323
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mtag4u66
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF1F10E7FD;
	Fri, 13 Nov 2026 14:57:46 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0C010E7A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRgt5S2hXLytNqn4WMWeiBh7xB31pRG5GSDvud4MdTDs5eVmbUSOXi3w1YYc2951hMbxugv8SoqWYKXOaTqtNuOS+X+mhBKyam8xVgJvfKUbmYkNMW0Ktd3eeCKilvcNQYIj1khfmhBhCBBB9C0vM6fMMclSPNbuQos8SO3FWtO52zMwnOsZ9Mhaixn7dj+tXK61ZpLQAB1wlGOqjCrzVT65QnYJlxruDK0UZGSL2ioOKs+1CNNnuaB6RduxQGLAd8th0vYNOLRp+ryHsH+axPEAqIehxKfBry3BFCCg5AdqqLMJy9LKd4N4eSB6Aa4ovCWgsIpBttXy84qoVHYVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMOwOXffAzf7bpwJLOY+Kl5Faoab7mlHgowFXwZECMU=;
 b=ylSqkzVF8iw34NNKd71Oitccj5Z69UuiK2C4BTTAd5RIGJpZoKpJrQbbjB4zVbZTbA3ghhpq7FeAI0UMveRreyPjud3NV9VDC0tu6NfLSYnpS94k6vSS1taOYzzOlGG1Zk+zNW6T01X8VTHtHkcjmYnlGoYIjSE6WL4qyddfR/xlQouVeC/OmQ5pmZDHnn4rbT673+aFH00GHbGqOEqjKOzUXicCdgQAC1wZSyEktjkOrlJXUevRmd/lGErOD0NfQtdeY6Mi4vsuiVHpYzPHWltDNWSPbgNyymDHiiOZMzgimRtiFYqox3xW14mX7vYxL6BoxYCJwH15Iv1ok66U3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMOwOXffAzf7bpwJLOY+Kl5Faoab7mlHgowFXwZECMU=;
 b=mtag4u66iohqKdn7b1Q+0z15fC9jJfKfRTo4spyjDESgFOQm1gtMKYQWaMX6mOgVXttJ4buS2S62ZnceB0CIL58reQ/1u7wJ7tH/wCrs5AMa1seY69xzSGdCKojr4FnffT6hG17Y91q7chxutojtkfkuMEhGNOUWIjmkzZ8rVk4=
Received: from CY8PR19CA0032.namprd19.prod.outlook.com (2603:10b6:930:6::23)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 14:57:34 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::1a) by CY8PR19CA0032.outlook.office365.com
 (2603:10b6:930:6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 14:57:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F3.mail.protection.outlook.com (10.167.247.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 14:57:33 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 08:57:21 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: align the sysvm GART start to 8GB
Date: Fri, 13 Nov 2026 09:57:01 -0500
Message-ID: <20261113145702.323968-6-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113145702.323968-1-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: b1115eb8-0307-4da7-198d-08df41967309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|261021121427099003|10067099003|261021123027099003|261009223027099003|56012099006|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6YWuRQ5uEMbQuUmx/AvtDZHeVngiMVuFIZuwsJVOaiGqFf/D6vmYTZVTSuStB/Ae/iZO2IZetkb1N9Yl/Xf4sJm+48mondZaBBKvyoR8eBCyUpbcje9ghGEbgOl/AKaIKcomVFx5JiG87qQblF1NU1w/m2msB5MG6syFz8FvxRqmg/Bs9MSnqNo91zvHRrSwyJZ0EkkN3+FTTJXkaJxhhaOSYKCPQ4lyPMdxf3VuiET710dfA1Zf64EdLmRUlPOZvhJhNXICQRNPRua7UfHiuebb3RgdzSKjWKOf/5L+T0lYp7jAZ5sUSG4GNnuKvQZ60ueDshK0ll9NOvupuBIxGO2izqxEaa8TwrWb4lr92b7nzMfdmYrpkgxezKR7trVhsUhZlCl9a00HwjvkZ0TbmkH/fMACfuonMsLDIRwwnwi5SYV872IxvMfBJJXb1jPnYGsokmVxagyS9GVhJOKbIB5qetPoUwqLvfHSUtHyTDvVtnfKcDL9yuKdarhBz2pS5S6bFkQve2DCjCEjIfgGKZevf43w6dATKw70NE/0LUfSrG9Z+kfPXz5hs4n4TT9qaXZbluNxMAqYBIvREEOsZD9RnxarspWt5ZGpjTi15pVSIQgdemcWM6ItemQdxioYEjkHQFtHhbrKOgqaXIOUf9NSWUbTx5TMJzKeeZziJWwjdGBQ/ZEtN02uL1bkuiG4/0XR7NuRx/NI0BsaM8LqIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(56012099006)(261102123227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uBty4KZ8IrgNxdbjqz4n1tCgjmb+T+MKMTlcK9HW8VINwdM1TJo9NNvr0E6MDaY33Uy7wRjn5iPcd4UUKSKlZlI+UnjkwjzgOEV8nTxjf9MYIMHGxkY/IXwh9CddBBYA0TLah5QJK6mR75IquapDkkB7dDHmKs8shpe0tXkUAEv6u81lQ4tUdlgRm1jkQqpi2iDXD/qts5TRJ8tPT7YdEgS4a8CiC1NtIIRhktfC9qbNjb2Vo153VCVLRJ3MTfZIyH/KNNoyD0w6JdFEXnVRsgpvyGgAxF0Rk6mqVSj/kYIBRvdagLcO9FjvkpN9fh3s5NkbpoKSlwwcaBVmiKhZNYfkaH89AfEBeTMMg2YNpdHW+I9poLmj2Bw1DGCcowHx8+NeE11NZPXETpf1LQMOStQAnQvVg2EME0G2nsG/P9IJk8uN9U0aJ/Dy04BJrFXi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:57:33.9890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1115eb8-0307-4da7-198d-08df41967309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PDB0 block size 12 covers one 8GB entry. A GART start aligned only to
4GB can land in the middle of that entry. Align the sysvm GART start
to 8GB, and use SZ_4G and SZ_8G in place of the local size constants.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 04cf02dd22ac..8a62f4f3aace 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/sizes.h>
 #ifdef CONFIG_X86
 #include <asm/hypervisor.h>
 #endif
@@ -41,8 +42,6 @@
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
 
-static const u64 four_gb = 0x100000000ULL;
-
 bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
 {
 	return adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev);
@@ -261,8 +260,8 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
 	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
 	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
-	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
-	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
+	/* Round up to a PDB0 entry so GART starts on the page-table PDE. */
+	mc->gart_start = ALIGN(hive_vram_end + 1, SZ_8G);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
 	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
 		/* set mc->vram_start to 0 to switch the returned GPU address of
@@ -313,7 +312,7 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 	 * the GART base on a 4GB boundary as well.
 	 */
 	size_bf = mc->fb_start;
-	size_af = max_mc_address + 1 - ALIGN(mc->fb_end + 1, four_gb);
+	size_af = max_mc_address + 1 - ALIGN(mc->fb_end + 1, SZ_4G);
 
 	if (mc->gart_size > max(size_bf, size_af)) {
 		dev_warn(adev->dev, "limiting GART\n");
@@ -328,7 +327,7 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 		if (size_bf >= mc->gart_size)
 			mc->gart_start = 0;
 		else
-			mc->gart_start = ALIGN(mc->fb_end, four_gb);
+			mc->gart_start = ALIGN(mc->fb_end, SZ_4G);
 		break;
 	case AMDGPU_GART_PLACEMENT_BEST_FIT:
 	default:
@@ -340,7 +339,7 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 		break;
 	}
 
-	mc->gart_start &= ~(four_gb - 1);
+	mc->gart_start &= ~(SZ_4G - 1);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
 	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
 			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
-- 
2.43.0

