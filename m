Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1C9106F2E7
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0565D10E997;
	Thu, 26 Mar 2026 07:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p5xQ4X87";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8446710E99A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1Gu0bOIwM7QOTPKIxq5kl78nKcUIkJOVeZwLGPPyusIHmKR5npgqg0Cikt7FKCft8OyypNtWFVBvUYIl0FneJwFz+SCGnAV19T5+udwtVxzbCl1UXieKGXOLivjpv3kFvIlYmkOEpL2Cx445XxmugIbjqVpR+lukL9kqhqnxJwE6NhpjR14s3gf1n6I88GrVipWtYXnbbwusTIXPFYq849Kam+JppbPW+CYPgktBX1Y8efKPa4lyc9q/jhofa2m8N4dlcvVHUUi/8MyIlo27+cSx4dGeytdtLThtUbiP+Y136svpIBKITOyI652pkxTx8NoTkl+70RPnkwzB+Gu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu0byTHswdkKNpt9O/HprDvAkvuo2NDWmcFdl2ajTkM=;
 b=wGHM5UDDLhkB/W6p96YoM51dFma/0U4s95yNxvKyBDTqCHXg65Z3sGCYQ0VZsUsrGoGccT1Zdnrv9O6rUy2Uji7DpxrC6mVXmyYdJT0+96KfzMNj64ndpRboVlR0FlU1Ww759ts2MRt0CxZ9OLU6IRYqwCqDp4QcpZfKzw0/HwxcIJZBUhic+l97wT1ZbyRUqdYSa/eSJgOKf4aFgjmhN5bzSfkU7ggsNdfMDx9F7fks8jPZXCOAMem0ZPdQo3ApvJ8lONPUTcqWirSoHF1x3Ga5UWq8zz+xFvOD/iZ78JRicqKwg4VJNuArFWLlRxv45syWYd7siGQnYuIZYulvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu0byTHswdkKNpt9O/HprDvAkvuo2NDWmcFdl2ajTkM=;
 b=p5xQ4X87BYvquXEwQMTCGvIhThF9a9nEBNkhDZF239azUI/6wjweISiWSsFUFZYUCRDSWpQW8+KcL4hxJIU6z9de9XluWiRnEkdDNpe0R7QVfot5VQB4hKhjjzl/HKjXYES0ppA1UKdY1MdORIDZyF26YGngXWgMR35hUvPmrMo=
Received: from BN1PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:e1::30)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 07:55:12 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::5f) by BN1PR12CA0025.outlook.office365.com
 (2603:10b6:408:e1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 07:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:55:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:55:09 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 13/14] drm/amdgpu: Move validation of reserve region info
Date: Thu, 26 Mar 2026 13:15:34 +0530
Message-ID: <20260326075412.1378411-14-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca6dc80-1646-4cf7-eaf3-08de8b0d01d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: fzs0Pwr+6V6Z4Ng09l5KHQi6jV/coSm9HI2xsvXH4PZ7wlsnVEyQKDa6gZS7gJ1WAfyUf4Nx3iOQFQ9OP4e1OPZKuzLSiSxzeIWL/ks0Iuiy+MfKIRzHGxl1j/XiyQ/UuLK6bKqw6amtPVne9IUcX3IwNlJp2Z29jig5FE7f9n8yIhMQ6RZUFlieswm7xPuL2pmcFex2WRI+UEIEvPOCkDhnNZAqLZKGI2JjGeCdByvIgBj85VuiwqfCjljARg2Y8wif3v7sWXDphbE9zq/WhE6q8qDaqnJkWGDKns3IPAQsZIpyK87w/IUbz9hP5e+q71kqA/W/D6w/tr4ifyMKIL+AOgfn5sjd0RaP9tPuLUq3P9plVU7RTgOiKlJVyXl/HkUcHAh2trpzcgUZ8QPEZ7w0nhA54/LmXAVlpnsfm3a4Cjt2Jq6dsLDsyY0KRcWd2supWjOf/Gu5cqvrwaAp12y/Ugsif67P/najAci/8MlwPKailodcDvyyWSbEGnuGpaOa9Zwd7Hf7YN7g6wxJ0ROlL8+yGU4/TBp/QC1QvI5NmrftFrQps0S92/bn9GGDQ6qSWgSFBl38SQjbeDyxAs69YIJ+GzISW9Q8VTU3JfUxqez6FqZ9g2VyPh3lq2LM+RUbeyLlnpLBxof9DMrn9PE0XJ9hKuxIoLbJnezyDhaMgHGWmamORfQ01tlfuTOABgQGcWU+iusJzg9D3hT/MyVUtx7JZCwY8p4oG/HmDbIG34crseej0fQbXWvOE4Z3ZL/WCpVkzTc23eed1OGLsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ILoq1AvfJGilK85qAruOW+0SKJiYbiUTO/j5BgzjcdN02sdtkISxR6MIBLB+xO+OVMhRO8EPpO6jHnpg2R5+gFzZSzU7e72tXu7qjEaO6G+nTLHd6K5lfQdjABHf4U++7xhHCM8bUzS3ZOmDtQe3Ax8aUQyz2SzVQOX8NhoOF3KBJKU/+uTb+2ZirMEO52J39BmIIb4i5tr2tOAzAknCh4ITJ6M/fB1YNtZJO73ixLZuI1nNMN1vnaMxRLsakTyYu2jUTP0PLeU60DQvZ2cudbnFfChNzOxobKD1mnF7hPOUqzMJ/z8rPlCYm3IF4q+cLWEAUExWpJ7nU4+OVcl5XONjrYoElhnJuFu8m9ZtkOJeaOeLV0z4jLtnmXP9nUbcdmEGFmnOBazSVwOktzL2UofvXbAiE/i08H3+NzuTNaovKEDZjTTrZFVhxxecNydX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:11.4410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca6dc80-1646-4cf7-eaf3-08de8b0d01d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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

Keep validation of reserved regions also as part of filling details. If
the information is invalid, size is kept as 0 so that it's not
considered for reservation.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 30 ++++++++++++-------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ccefa04f2cbf..d88d75a1eaeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1754,6 +1754,8 @@ static void amdgpu_ttm_init_mem_train_resv_region(struct amdgpu_device *adev)
 
 static void amdgpu_ttm_init_vram_resv_regions(struct amdgpu_device *adev)
 {
+	uint64_t vram_size = adev->gmc.visible_vram_size;
+
 	/* Initialize memory reservations as required for VGA.
 	 * This is used for VGA emulation and pre-OS scanout buffers to
 	 * avoid display artifacts while transitioning between pre-OS
@@ -1762,6 +1764,12 @@ static void amdgpu_ttm_init_vram_resv_regions(struct amdgpu_device *adev)
 	amdgpu_gmc_init_vga_resv_regions(adev);
 	amdgpu_ttm_init_fw_resv_region(adev);
 	amdgpu_ttm_init_mem_train_resv_region(adev);
+
+	if (adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size > vram_size)
+		adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size = 0;
+
+	if (adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].size > vram_size)
+		adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].size = 0;
 }
 
 int amdgpu_ttm_mark_vram_reserved(struct amdgpu_device *adev,
@@ -2129,27 +2137,17 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 *The reserved vram for firmware must be pinned to the specified
 	 *place on the VRAM, so reserve it early.
 	 */
-	if (adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size >
-	    adev->gmc.visible_vram_size) {
-		adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size = 0;
-	} else {
-		r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USAGE);
-		if (r)
-			return r;
-	}
+	r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USAGE);
+	if (r)
+		return r;
 
 	/*
 	 * The reserved VRAM for the driver must be pinned to a specific
 	 * location in VRAM, so reserve it early.
 	 */
-	if (adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].size >
-	    adev->gmc.visible_vram_size) {
-		adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].size = 0;
-	} else {
-		r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
-		if (r)
-			return r;
-	}
+	r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
+	if (r)
+		return r;
 
 	/*
 	 * only NAVI10 and later ASICs support IP discovery.
-- 
2.49.0

