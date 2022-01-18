Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A75EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 16:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E8C10E22B;
	Tue, 18 Jan 2022 16:04:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3997310E22B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 16:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgBs46XJPxxlGTnzYnY+TqDkMNFfK7Q96s9fl20hA+ZRPo4haQ58zZaPoFo8+6SOkGZWQCbTVKoA3U6qO3RQ6iwsR8PfwQacpJIQ668ceIUszG/1Cvfq/C1r3imrB8m7fLVcP424+YE78KjxRoFbopmaetFXwFwmMeUrO4gtZf9y/PDrBCDkWHi3UZbN89cBmNA8U/IsxHI3LlvUGk0IszfuwQOv4hOg5qaJ/bleQUscyJ/1QqwaD3AtKR1AjyoCZaHg83xqNF6VhDuU0hGC5xZXNLmMHNvyibsIdSL3t03rFLcnYSO51I6dIsiPYQAHh+CiLub2hzhW2zel6B0syg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8wUQXzo6p7lS8ZEJnh0vzzmfHIrGy9wl8OcIelaS6k=;
 b=gSwPc788PlgG9X+iirWHabFOvM0zoEOkcvhpzLe4wNiTn8d5nWUSUYBI4sEckM+2JKAppwiDYN/FgvEdOS0uj3vPICWnl8Ir2f9Pg5vlQFXiEYT4bUZRn3tvnshEnVwucnjSYkVzbhr4s7NKoYmTsP1Ndoo3NIl1+7Elj4gTOfTopuTPsGSwRTf+tcgxVVsqxhV8cIBJiZKUqsz+LDA7DopR5rejYU14llGgGf8pAyLQFxV9sLldXKCjBZryjwca5B9RXQ8oBHYaMBX6hDps1rBx7x30R8UpQduNdvo38Gqj+QzYGT3f7yNZaO04wWrfwJdOYuopwEN4qDv/Pq2htA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8wUQXzo6p7lS8ZEJnh0vzzmfHIrGy9wl8OcIelaS6k=;
 b=LzwczwdJe4eG43o+7OsVdSTfPIKzmH9npz+9phKZWkdF9Ebvx+5E+eNYeHq6RgEiIJc2z1LfFX5sV1uVHcYgfRGi1Ck7SMQQeA5hw29hCHQzM4PMJX4j1beNpTcg4v9IlerB3r8IHQAp2tsOzd7nH+IWgMgmV6PSCVL2aHrabiE=
Received: from BN8PR04CA0021.namprd04.prod.outlook.com (2603:10b6:408:70::34)
 by DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 16:04:31 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::86) by BN8PR04CA0021.outlook.office365.com
 (2603:10b6:408:70::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 16:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 16:04:30 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 18 Jan 2022 10:04:21 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Date: Tue, 18 Jan 2022 11:04:03 -0500
Message-ID: <20220118160403.10500-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 184396c7-eec3-49e3-2fe8-08d9da9c362c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1147DD5BBB90257F5E1A233582589@DM5PR12MB1147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aednhQQPBEtvcrP0JYKDcUFvAhqi27dKtukrpU0oIJ3ZpUogANbIjYY0vCI6pxH37y9HSE903ZTM6AHI71hVqujp7DBgVSwFZg5eA/cjacy8OfJqwEi8JNvXvlcUwwQoeu9jYyi/8jNIQ3f+CDRwAhKtGfAf4uNR5Vo2HlvIZ5T0s0QOkeOlYkHGAr8mi3KihzeQ6V7l1GFpCN7ucm1eXB+vfBu1EoMpfmasCICYFmbj+ru+btLQKrbn/0QuxA9hE+G6BFUdtNSbzjZKNlLIvcuajg4YF4Cv2NK85bJuWv2xuQM6s73PKQEAZSv9fMomA/nl3hprddD7/agRjyAYHh+0zgNbBi0C2ick6SmPxS2cl8LE50pXpeTSNa1fTgVkyiNLFH0g/tm5wAYvDzHLMFUg0Q2z0ekIYjrZPSrOWH+u/klxKUURgnas06UbfU044OveuEP2GqVBkRla8jQgROYVSCDeoddz4FMcQLI6TPpG9STySVCogJPt9z5ZYxiESGauNKoXogqZoA/EKIlpJSxSrpltHC4Ku1QbrXpr2b2LQghMUStF+Jj5W6rMsVtY2y7ckKOjRvdZmIAGTa2Eubc/k93qjlqrgacFzBVZRuXWLJc3JncGgq/EopPRq48lIMqWMV/MtOqMkxZNWxz4Fo3xuO66xK+qMNv/M9kYVQasggaoCdA1uN59cVezeT7Gks9UbpwwF5M0vVZfdsGnOzaupL6cmyicV/oMYD8FBhRgQnrRYzlDdW0+KBRYeBiJiNF7KeQLQMPZKoU5+t7g5vjeHOK5Ha7Iu7K/X5X7qDIkKb21p97fVsUImVcgIkRNcdqGYsofGEuEvCHR3WR3pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(426003)(316002)(2616005)(336012)(70586007)(508600001)(4326008)(82310400004)(81166007)(186003)(16526019)(36756003)(1076003)(2906002)(40460700001)(86362001)(356005)(5660300002)(6916009)(47076005)(8676002)(7696005)(6666004)(8936002)(26005)(70206006)(83380400001)(36860700001)(16393002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 16:04:30.7942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184396c7-eec3-49e3-2fe8-08d9da9c362c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA FW fixes the hang issue for adding heavy-weight TLB
flush on Arcturus, so we can enable it.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a64cbbd943ba..e1d90643731c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1892,10 +1892,12 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 				true);
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
-	/* Only apply no TLB flush on Aldebaran to
-	 * workaround regressions on other Asics.
+	/* Only apply no TLB flush on Aldebaran and Arcturus
+	 * to workaround regressions on other Asics.
 	 */
-	if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
+	if (table_freed &&
+	    ((adev->asic_type != CHIP_ALDEBARAN) ||
+	     (adev->asic_type != CHIP_ARCTURUS))
 		*table_freed = true;
 
 	goto out;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b570c0454ce9..ef4d676cc71c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1806,7 +1806,8 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 	mutex_unlock(&p->mutex);
 
-	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
+	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1)) {
 		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
 				(struct kgd_mem *) mem, true);
 		if (err) {
-- 
2.25.1

