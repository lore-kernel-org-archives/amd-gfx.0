Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E10C5B552
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 16:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5EA10E2BC;
	Thu,  5 Jun 2025 16:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U4yrenoe";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5A810E0E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 16:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryJ58JWgVjsjwKL9qaVjZDF5kLvHPjtL5euIrEdyV7tb9zj9gWSm3I/jTAdRD6ErF8bXdLpZzmYSUhAkMLmAka5plcXGQD5nhGT8qBnx4jwwdOrQwbEJElm12d30SjaDCpYeY/siZmH5Mu/2I5TJZnByi0+Ioad6eeOkOOOxCP1vIT1LQd3k/es90PNGnGpd6vrZbH/BM9LO42XmADP2evO/e8YZ/GIPFqmIcVbHVECYCRINIn89089MFtdM2kruJ+ekPDlCtgv+3D4o1B5LZz6eVjSpB1rJOA0QoDR/vHQpvws6+2bhCWPud+LEuB7oRX1VEVoydo8qy5UFLZUMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pkAdIay7lK/eJadwb/wLQcFkAZFxLXXI3/+xksPlNU=;
 b=r7Kh5WCSPIdBytERyGkrKTkdpV0GGliBAafY/JTyL/UgzlCRFVlf9twqdSkrKxQLGlacTEl0bLvka7qCDMBv15oZt7A+B8yGiT48i0LJ5MsZDTGHW5wF/tz9ySXwSlGPJPJQaKNIw4mPygTEgZbqSD8eRj14mvwUcQ3VeErHylG5cNJoXHdZOASNQ+k0O83QiXKb6vF9gOWNCv9+wHRMq41xnGoFRkZr5ZFKBwXmgEGGfB6nZQN9FrXO6Htg3pPZ7M3T1fS1ee64TmAu0Ek124C2w2bWDBmOFXjmFX4b4hTtkSKf6S3z1GGX/RDnipYfiF+XWcNRPcaFSF41x82ZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pkAdIay7lK/eJadwb/wLQcFkAZFxLXXI3/+xksPlNU=;
 b=U4yrenoeRb0co0y6OFDhIlSlysTb4YhEI1vhqWLetP+GxLXCrKoJY+wyXQYnLupF/AQ4xkkbGrfDvSDwjy7y+tMYfFzTwFmECvMjaf3SfOHTBNagXm/kpdDaH5T8RBWsFqgOPD2UamgTKck5BynOEEqt14fYJVpwY9jz+Za/rTs=
Received: from MW4PR03CA0035.namprd03.prod.outlook.com (2603:10b6:303:8e::10)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 16:12:17 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::c2) by MW4PR03CA0035.outlook.office365.com
 (2603:10b6:303:8e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Thu,
 5 Jun 2025 16:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 16:12:16 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Jun
 2025 11:12:15 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: Add chain runlists support to GC9.4.2
Date: Thu, 5 Jun 2025 12:11:55 -0400
Message-ID: <20250605161155.1692134-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: f1906ae1-c3f8-4d34-6389-08dda44bbdca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qEKWpprS3BWEZcKsKuhNtaiLnNFdQDg74I8oOrPctBfji6XO8kL7Fu78VLJ+?=
 =?us-ascii?Q?vh0Ix1vfAgoElFXUyxjitx7neQ5nETbUgZ1aN0gpFXW+cPEwEyZWbUb7UusZ?=
 =?us-ascii?Q?SbLFZcs1lgb1p5nZ0Um/o1SvKYo+uPWvM7eDrqNfTgC93rrOdGf7YP6xrQGX?=
 =?us-ascii?Q?GCfS4jHoWjvxxHcAVOjXB5PUvMpXhQR5nzsD6LQqKEYuPfl5Rp/bpMGqIvWg?=
 =?us-ascii?Q?R1B1dLsI6LcZ0TyF1euQxrYKKdycxKkW/z73HWgQ0Yg/ju0SAmwB6xOB3I8I?=
 =?us-ascii?Q?1Na7O7/kpudvqV2YcGtU3wkjmPQu1GK/GCSKw8qIDn9jbQ1QxcK9zohMsTzA?=
 =?us-ascii?Q?rxucawHCiIAJXJMo9Ij58nUwTrCT4qNby/VA57we5isd8WrqQAwnlYlpp5+f?=
 =?us-ascii?Q?ahp5Jk9hy1pvskdB5VPDHqAAFeA6w5TYKIn5XyYWgsY+o2tKyn7mSUASYRyu?=
 =?us-ascii?Q?3KK2x46DGxpeBG3Jh1nzjqyaiMX5z3WMgbhla1J9CNHiSltsNVeQsoOuM9DC?=
 =?us-ascii?Q?zvVL4KvAJUO8fTcSQDGrtydUcypuUcoU04AIywCLRDMpckGeNQFRIMYRGw5c?=
 =?us-ascii?Q?I0ZcYM1f7bjsyGSBijv6TsxUVHdHWVhw/PrB/aBWnO6xOVweVjfSY0+7mD/6?=
 =?us-ascii?Q?Okg1tT/biopMNNILP36ZqIpAAC1XUD7o6C1AcZJs4bpem+xVsERi9+UKQSeS?=
 =?us-ascii?Q?bOIbNGjc//z5AzzaZSNUrsH0FOV1kxlzw4dyQB8UwrKCpCvlMfVKtB/PuO0V?=
 =?us-ascii?Q?ZvSJUzfuEJFVhvUzpf3sOlT84c/uP/nnOvU4Oh7/eZsOULC0LRZKiqvOx8hA?=
 =?us-ascii?Q?wMmEGGh+U3LA30ohOjvjBMU6ZovtRg8BP0vI9Q94apEOn3AXJJdN4Vg0cHck?=
 =?us-ascii?Q?jHatM3rdGk+mRShTj/G896mn2AxVhmkB7UulEKLwWbweC4bJmOGg6Rb1wDTV?=
 =?us-ascii?Q?7QojSPF4IpEiXitD2NY3SJQDM2pZZdxInZGbgSkPpu1rEZ9jArcwXOTcUAYs?=
 =?us-ascii?Q?5AfDQvPFVrOqDzth+MJe/RGfIoAPiauAF6owlhsDjcng6wPkuOrKCdXggyGN?=
 =?us-ascii?Q?pW8TQt0mlCQu0WBousWAin0urQbZaws7OT9WIBANriZLx+xy2s5C0Kq4/lsY?=
 =?us-ascii?Q?sE0ea2Co/UP1aCaaGTL5LE0mU6R5djgGjbKsAP0/AocZeGKIe66CBsK7XzUN?=
 =?us-ascii?Q?GbxaqnbPJpLJ2wK7K9q4javRfeMPhKjhl2GTfI9G/EPTu2ms2Evpib0r7Cer?=
 =?us-ascii?Q?pOjNmkVgJrFKkAQjE7cKIPTnzJMheni5iLIdEv+ARxTa9B1pEmJNVbKu9eTG?=
 =?us-ascii?Q?MHAEHy+WmPm87Ow4Sv/uE5Pu0I0qUN+6McT/1alHkT6gg5I0LYWiGp1LVg8B?=
 =?us-ascii?Q?3cv+KuXYlbP/+SzjbhqPYJJX34guJKcPvuArKZaqYa1xOsujupoFy6noqfV2?=
 =?us-ascii?Q?/nTmK8MTFV+ZpgWAnn4/2pfyHYQ/DHj4edEXr0APVYJJvFcGSFN5aq9NUUju?=
 =?us-ascii?Q?osj6KCjcNJwUbFMyBn67A2UZd9rwjpzvhe79?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 16:12:16.8678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1906ae1-c3f8-4d34-6389-08dda44bbdca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
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

Starting from MEC v97, GC 9.4.2 supports chain runlists of XNACK+/XNACK-
processes.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d377a7c57d5e..dedfc6c7f2cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2629,6 +2629,9 @@ static void gfx_v9_0_init_sq_config(struct amdgpu_device *adev)
 				!READ_ONCE(adev->barrier_has_auto_waitcnt));
 		WREG32_SOC15(GC, 0, mmSQ_CONFIG, tmp);
 		break;
+	case IP_VERSION(9, 4, 2):
+		gfx_v9_4_2_init_sq(adev);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index c48cd47b531f..6f40f3202f22 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -748,6 +748,18 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 	}
 }
 
+void gfx_v9_4_2_init_sq(struct amdgpu_device *adev)
+{
+	uint32_t data;
+
+	if (adev->gfx.mec_fw_version >= 97) {
+		adev->gmc.xnack_flags |= AMDGPU_GMC_XNACK_FLAG_CHAIN;
+		data = RREG32_SOC15(GC, 0, regSQ_CONFIG1);
+		data = REG_SET_FIELD(data, SQ_CONFIG1, DISABLE_XNACK_CHECK_IN_RETRY_DISABLE, 1);
+		WREG32_SOC15(GC, 0, regSQ_CONFIG1, data);
+	}
+}
+
 void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
 				uint32_t first_vmid,
 				uint32_t last_vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index 7584624b641c..a603724c1dfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -28,6 +28,7 @@ void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
 				uint32_t first_vmid, uint32_t last_vmid);
 void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
+void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
 void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
 int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
 
-- 
2.34.1

