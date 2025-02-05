Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1D4C02196
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 11:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA15610E1C7;
	Wed,  5 Feb 2025 11:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CHnRh12M";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFB2810E786
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 11:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRsV43uXg0KKS6LTzkWdqZO2b/9/wL7RHsuSbAMv6/p/nPVoLizPe2uz5E3n0w/BqKyLZ2u/hNs4xFn96AItL22IPtDCE8zxe+nCdmLr27rjqh8+f9pzbs9mislR5Y8LqzWvIGeC1DuDuyAFVhuQEap7gk2wEY4I1a7mJwHOq8p841sYb7YHnyxqLR3D/hZXssr0A09546a5gG3yxs0HT/EZd1BiMoEiTLxhvEDyP4aYL8gmI0knpse9F9/ycMROigWu67bb0aAEEX4nQS+EQj6AAyJYSDiW9Wd8pczc2PuUP0qrpLeqvNprVgRRntHU1HsAeXC53rUm7ppmP5r8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/wlk9zNITgbEtPZJo2JkFeoicGw/W6pqpkCflHrLfA=;
 b=HratT5tHU2l9762E0vhppVvhO4OkaJ+9dunBZf9u/BYP1VdR3ZSDDXMWN+lFEpvG88YlKGHFdeafc53QYy03PN3fyEbVTmBzwniLPJJzjJo3kMLMvAIoKCb+KxTFGdwl7i3xA3wwyGeTYedMsceQ1t8KFXnHw4CA2ATgFzM0Ht/myekIHHesUs/rnkcp6eCXI1j7no3pPfraNlAX74zLlK30rU9LPB3DDvpspyuKr+IwnHh1AR5tS4BxI1Ueny5z3Fh/gvMbGAufgczKYQjbMnLMPi/ErkeFAdsK1y8Pq6v2pK0NnZ771Q8NTAqN89u+l5XuS3UiHuuv7gY5w+AKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/wlk9zNITgbEtPZJo2JkFeoicGw/W6pqpkCflHrLfA=;
 b=CHnRh12M3WJ0DCdTebuB57TnipCtG9u3/3yOyEyYc6RjLLt+An1av8jpg5eed3MF6utQZpGMiO2u3sh0V0J+ukQjFUMwryYLuS7VmdidhmlgnyTiVsR8PLDv0BhIjZdFMYvHtoHOOD5BFDIUs3SjtAxFiqSHlN+QdMPBoZoLfto=
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 11:38:49 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::28) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 11:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:38:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:38:47 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add wrapper for freeing vbios memory
Date: Wed, 5 Feb 2025 17:08:29 +0530
Message-ID: <20250205113832.1903614-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SA1PR12MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ff979a-5750-4f92-849b-08dd45d9a879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9k5WunVw254h+LJU7/H8OUudQnBHMS9/mzwBe+Zk6AfrAgDlZjRheReTvqeM?=
 =?us-ascii?Q?BVPraq3nEfXbUf+UN7+raDYBoLusm3VegwNh49n9YZeJLsPqlX+cytiARZ0e?=
 =?us-ascii?Q?cwlamQl3nXDU/PRGnVM27Q9207QZU6fsj/yR7xjIOk5E8LoheqzDHc2xVdQF?=
 =?us-ascii?Q?o+hjCLdG11eQzrX13BUpXYoOnJbzUycAgcc4M7AenfptoH43f8bPqZJUhg8Q?=
 =?us-ascii?Q?3vT253YQW660pQD74QTjr2NgGDTFC0xnplqiV8aWYuYEsDfmBxN4oXp3iLUo?=
 =?us-ascii?Q?gQsn5+2d6W3myuIDUcB0AojMxuz0G+Bg35BNyF3PVOlCnsuKtQljRWYjTzEC?=
 =?us-ascii?Q?W6TULw6ARXiGwyd4l+Wz02m+IzJUo+hrgQJEAb6Ulj9bvOZvKRdASUzMWN0p?=
 =?us-ascii?Q?P0zV9C0SmsucnIkq23zmmStY6AGVx2UYfGtuUKl3/SKCgxHf1q6El8bVAGF9?=
 =?us-ascii?Q?vmhWwRlEt/YfdvdH3dmgEvANo1Dpxwkaubtq909DEEF3i1FCWEtTkbCYUT4r?=
 =?us-ascii?Q?AQPp2EayT2/puryF+Vd8k7eQnKN1Pd4rmsvyT/Zdb1da2R8DV7eOyV0a+Ng2?=
 =?us-ascii?Q?HicUmrpqTgXlXRCFz9addMfs8quQ21AFCHKIvq+JXeUrSSRaEcH52aQB3lQU?=
 =?us-ascii?Q?x8A7rjsDsbTXPuw73C48eHn0j7BJ2fuRkAbaKf5rzzajp1gStxCpQtJ+IjOr?=
 =?us-ascii?Q?G4yEyuYNugDPwsmlYA9J90vL8hVByWeDKkEevlHdTE3lCvp5ddGd27NdDJU3?=
 =?us-ascii?Q?DopiwIdxgTZDBh4I4507q6JPOvvIuuaarBD78FOgKeQ26RUnhJTsAoMOXggX?=
 =?us-ascii?Q?FcaVce0bqpuHKzN8zVYjUd3Yw9OfZGn3heNvBkvs8KwQWgwvoRfRkqGAzxv6?=
 =?us-ascii?Q?yu8dpHbTxIN3g8ihHXicdfcZZc++TCUdxzZYZbvmjv0LQGcY49vIvm9dKlZv?=
 =?us-ascii?Q?9yTDFjiNi6PgJl/UiQzRuvXpRzWWci5osugDQzUxAuTx9adm4WyuPzh3QY64?=
 =?us-ascii?Q?dM7EY82Hk0ERZLoKi4tc2T8QzR5BVzKUxG9VmThmWWV9R+dB74ZFTqIbVZXg?=
 =?us-ascii?Q?HWJqZJ3G900ugK4nGvYJt6tr1dop63iooYlQ2ZmsJB8n8LdUMdWm3mNwITY7?=
 =?us-ascii?Q?73D4AnqkHbp+vKrCc2BKqHFfApB4cLEKMeC5ImjTY9e0s86U2/PmAi3ZRdoj?=
 =?us-ascii?Q?AfbDMJTxOa+8oQsHRfYUop2NFDkepE6bR4c7gM7TXWQZl1xi8PjDutFPBZPW?=
 =?us-ascii?Q?YRWTovc1QzbsKaHNj9IYY3N7ICbzrmeZyPKWoDS/guXb1+RpDJ4vZNm8MQ5X?=
 =?us-ascii?Q?GlNbvLHImc7IRH/ODvY5VbFEHE9roUBeuA436T6ekzpdrO2UQcfxKwQlBhmI?=
 =?us-ascii?Q?yn8W/Qx1nbU0ePsNkJqs07hf7Nkuwe7243F35yOGfwVMacRMrXw3gZzbQKkv?=
 =?us-ascii?Q?szeFMt1ki1Bdam24QXc/OO/Vi/SCGoFsmvaGcXfcz0HU5IMQ6h5Xj1AqHJQ8?=
 =?us-ascii?Q?uWYpKzfFrwgpSEc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:38:49.2609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ff979a-5750-4f92-849b-08dd45d9a879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489
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

Use bios_release wrapper to release memory allocated for vbios image and
reset the variables.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 423fd2eebe1e..a9b3f4702f6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -84,6 +84,13 @@ static bool check_atom_bios(struct amdgpu_device *adev, size_t size)
 	return false;
 }
 
+static inline void amdgpu_bios_release(struct amdgpu_device *adev)
+{
+	kfree(adev->bios);
+	adev->bios = NULL;
+	adev->bios_size = 0;
+}
+
 /* If you boot an IGP board with a discrete card as the primary,
  * the IGP rom is not accessible via the rom bar as the IGP rom is
  * part of the system bios.  On boot, the system bios puts a
@@ -121,7 +128,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 	iounmap(bios);
 
 	if (!check_atom_bios(adev, size)) {
-		kfree(adev->bios);
+		amdgpu_bios_release(adev);
 		return false;
 	}
 
@@ -149,7 +156,7 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
 	pci_unmap_rom(adev->pdev, bios);
 
 	if (!check_atom_bios(adev, size)) {
-		kfree(adev->bios);
+		amdgpu_bios_release(adev);
 		return false;
 	}
 
@@ -189,7 +196,7 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
 	amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);
 
 	if (!check_atom_bios(adev, len)) {
-		kfree(adev->bios);
+		amdgpu_bios_release(adev);
 		return false;
 	}
 
@@ -225,7 +232,8 @@ static bool amdgpu_read_platform_bios(struct amdgpu_device *adev)
 
 	return true;
 free_bios:
-	kfree(adev->bios);
+	amdgpu_bios_release(adev);
+
 	return false;
 }
 
@@ -327,7 +335,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 	}
 
 	if (!check_atom_bios(adev, size)) {
-		kfree(adev->bios);
+		amdgpu_bios_release(adev);
 		return false;
 	}
 	adev->bios_size = size;
@@ -392,7 +400,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 					     GFP_KERNEL);
 
 			if (!check_atom_bios(adev, vhdr->ImageLength)) {
-				kfree(adev->bios);
+				amdgpu_bios_release(adev);
 				return false;
 			}
 			adev->bios_size = vhdr->ImageLength;
-- 
2.25.1

