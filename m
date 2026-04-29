Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9679DFF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 12:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305DE10E3FC;
	Wed, 29 Apr 2026 12:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uu4ryHrJ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 129AC10E3FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 12:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xo6UMbWmiNIf2uuF3izEBTEN6neq1KUc5Dllw05O0I39+NFMvN9j9zkBGQcG1X/5k9zpgHdBX7kD98LfoS9y840V2F+ysv9l7TPu7t+ZjDU2lNL+ptYgUWAZbaiFZFylwExHbBfPIDA77Y0Xoe90UFNahxR8zwfzl6cp2S/NcFZ3hTGOLZgfI0aEGJ56zVQgfu0XjOuMhFMMVS+lNjRXyWUAi9WghN/CQlFd3R029qcwt+rR3gduw5xwQD8ElyMrfzwg6hPm+MJJVCG2Drg0vtXC3w86FPJAQofVGgq+bh1tusA7g8ncTCBO0FV6MY4X/ySqpEN+dR0ng38WlnYjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDGAHg0pw3OP5W6ahd/wcWQ1SpEvF/f3W8Y3Di9vuSc=;
 b=HL/pUBikwJSwmrQpz15VUef3FF93Or49KnmMdNR8D8cXKrt9Azc2QY1hPLncjAODIMSC4kXPZwNre+VU1xo4+FFjWZmiDDbOZ7X8sefkHLAwnAjepbrsdXLOMR0ACoy/WBBSFX+2lfHUucb3YKgcRF3JUvQOPp4J0TjAP6fqt4xiQqEnyR1AZo7r7okXpHRMceirHm8GQwYn8wQEB8MsZSdyNuCna5krIAv1qLjWc1cnFim4PvperbB0UPNwwt7daHsr1DfAUfux+ZB2yfOtqwJugXP8Ex/dzg55okqlNc37iXSPrfoeA70cnP7fRn2IgDjKyi0IgFgMUOOQPORq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDGAHg0pw3OP5W6ahd/wcWQ1SpEvF/f3W8Y3Di9vuSc=;
 b=Uu4ryHrJ00mTN78FRUWXimdMDSi4KLVvn9ExEhDIbq5VMTiyz/f1aA5vphp4HdCmRK5fvDdpqxsQnVptc88psTwDOYB+fRQn/og8qsffFT57RyclSYys1cyPmUg+p2yHZmURqfle9oheWpeCeHm4gYkCApaE0oQJnbqg2CvQvA0=
Received: from SJ0PR05CA0131.namprd05.prod.outlook.com (2603:10b6:a03:33d::16)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 12:38:06 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::a7) by SJ0PR05CA0131.outlook.office365.com
 (2603:10b6:a03:33d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 12:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 12:38:05 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 07:38:03 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Adjust GMCv10/11/12 gart size
Date: Wed, 29 Apr 2026 18:07:45 +0530
Message-ID: <20260429123745.3930780-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a023ee1-0c59-4988-c6af-08dea5ec2963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Zx9CWksOQLB+OyBeRHA5gGTefcw2SF2l80pSvqvs/AO7vmN/uTANYpqzoJ+XBO2Lmfzvbbl30Di5iYFV0WGoFAP7CB2RWaV709XRpITR4MEmfCmpEV1mzWYjeHKH6AbsZIhi1vmtNLOqsFdrRjq/htI2CXod057xUNNvyyyxvIyKjkNJzpNpElcZEUufo6wDRQ+yBfagHksdsmkxj50xeHXllOiKk1eYkOvrzB4qICn0JTHsIYXPlrh+FbGUnbDwaJwF4yOXnvf2FUXdQnqYDB7QCVuipITeiLDNo7mGnv4O4vi3Ew7KaRHe6F2xzMmuD6hAkJVqwV27ubQx4eDiDv9FdosZC21QV7aeMith8Dn3FXp9bUlwczaaryerPvpXr057UN6sS35/9Ct1CJI3yPhJJbevYajghGP5vnLhyQiYvvY7XaSorLh8ucwfUdf8VpG+fqTiABUO+YsdR2qEQkMUIPOIRZXJMUbxXWKU8WHKf/zqdt1BKHgfnWLBucUxMc1m9HPXpgYbXMHfLLlQNnP+r6MpFzSBo2/TOM2q7ssEfxkQ2e7mqCadBCNOJx5OiAcOkRZChJR/4Bq78c8WVfq6nia50SUz13fy+SwK/8CzZSYeiPl4fx53pXrgc4gwZ+qW3ERV2an4mGIq5azwd1x6H7lN+mBQ1vdRRL287aVSW6PtT3kDTfC2T3FKbzsM8MiAUcVO4o8/4OvcY0TPZgAWJ73IN0qZayUSP0iYs9OrKg/ASTarmPJ83mN9a9+xrO7ZfLqTHnvEUraITbYJ7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m+w+a2J6v7rSKrRpADlpOyeagEuJLknjoJaPLTG6azWEAeuaWEyWqWkVrqtlSow+BDA5MiPNtjcbJHTGyUAVYCYFzam0UeZdvJXkaOJsUmgNcK8Bi/syIc1sndrJXwYWSSoTorKwFC4H/pOmZqm/fexqrAS9treeUp3W3t7esRbglJVIFxU4XuPetS4a3JzV6pevFXjTkjF9t4TKhAgM3CqG6qdjlUY5qvCHuNen0nPFCPwoeF2Ihh5OcC9LipWWTSE7pjrLorLYFQrdPI8319hMfXbMKh9iaBagScVqvBWQnj8mmkSj2cgKwg2r4aUH8iPI5MSkpCl4jAjgr2LFaYZLUsH6IoSrUtrp95nowoINfjrKCmBhTIUtMnpamNgzB4+Au6AzrAeij4AHUZtaEJKDmtkWbSPnpTFECbqy87punORDdqB01acYEBCSUEGI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:38:05.7111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a023ee1-0c59-4988-c6af-08dea5ec2963
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926
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

Adjust gart size to account for space required for firmware private
buffer allocation, if any.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e1ace7d44ffd..1c32e653a9ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -723,6 +723,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 	}
 
+	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
+
 	gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 94d6631ce0bc..2f6e338f2a35 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -714,6 +714,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 	else
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 
+	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
+
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 5bdd4b9b7893..e5096b9cdf50 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -770,6 +770,8 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
 	} else
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 
+	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
+
 	gmc_v12_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
-- 
2.49.0

