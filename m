Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC2EECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 03:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2FCD10E3AD;
	Fri,  9 Sep 2022 03:50:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C48E10E3AD
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 03:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep6OPEkzTvepQD9aTXvJLjX5kyznGqXqmaNO3os2F9tuXMoe2UFaTaTp42E3PXXFKIgz1IAPGb7lDKdpv8u7AA55+1ArAUHQqUnVZjMDMtakUWLASAuxZg8ygTXvU6n2HsVjBf93CyZ7+F3P4QjqhXlf67Oz/AF+eIg4q05ztviFdvDC35itsERdLlKOLjz0ljEEVS+RCvZsQMg+nrca5ViCe7y+krTuLjaqa/uf/NLEAfTJY5T2SzQWRoBjDmzCvg8O0LRjFBTDUuF9BOXu4rdA+zvD2+nAIwON2Mk5zPw5gs92ORfIVcLO/fJtNxQUUYPQCp6u4rEUggGknN5aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOrGhNyZpIb0hnTewSZrAdcTdSpvPLdSoOmxWtnfn8Y=;
 b=TneAM9R69FsrOlLHyafrRS9oyLOjgO2J5lblfxCjDxZ7VhA7WbWybqutskf8SY47rZBAJrwd8iEkqXaw6+WIV9nJ9RJuMZeR3ktdZQdIb4zh/dhTr4iYT1HbMHO9KtOgJQBrKAVihLMm5Hd9lxgu7et3wsj5nZvXLQeOKfrLexkgxpoHNpguajOjbURb0MdhvJiVXCS7kuD4hRLcKVaS6oObmXSZ+NYsnkCGpFEPA2wuHa+HgWHOTqYwkUAEjpfuwpwHlDw0oaHi2omuJAVT3GofiivlhU6krQNKV02QVS7/JbTFkKYjNbm7a/UgY7vv4jitK0Sd1e4Y+OOIPeKjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOrGhNyZpIb0hnTewSZrAdcTdSpvPLdSoOmxWtnfn8Y=;
 b=azMA9Efm202IRPVqnmDbtcynkpZcL78s/a8dnP89T5NS1ZZsZRTroaJdJj4k7SpFXZToamcV3DYb76O2Hc/re5sXwSQWAInleHh4pmn8FEKno7HBFM+5aKu8OIYlXJ5j1UCpvxP0ybvgs3McEHfhZ+jcTvX7qMPxDO4+CxKMs6I=
Received: from BYAPR06CA0021.namprd06.prod.outlook.com (2603:10b6:a03:d4::34)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 03:50:03 +0000
Received: from CO1PEPF00001A61.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::b1) by BYAPR06CA0021.outlook.office365.com
 (2603:10b6:a03:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 03:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A61.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Fri, 9 Sep 2022 03:50:02 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 22:50:00 -0500
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: change the alignment size of TMR BO to 1M
Date: Fri, 9 Sep 2022 11:49:48 +0800
Message-ID: <20220909034948.3647700-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A61:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a87bb4b-d4bb-4d86-ed9c-08da9216604f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QlnupyuOmJ2JwX043O51C9MPJR2oh6imOcp1utfLW4MTYxj7b+P4qAkUjq8F/RXOCg/WwjrMOghWeSRZ+v0zFGlpmYz0McGhtXrO4dMyd7ZNtQLx+EVlcFXg1I86g++7aDR4hl4RuZzWyNPfwY7neGGgtUuXMaFJU/RGtCp37cAJ8IHgUAwwOvuMWmoqf9ZdgmSxggkknSmctgt31QKQQVxvoBEop5hrf7QgfaeC4t3CMI22JT83G6l/cC/qgHPuYahR8po5EVVzteUSsjzDemvwXqdeVxXbcIEPU14PHgQMPiSwFvXbiCkSyUwokTt8TkiaNjbXM+u1zfUllaF42k369FKOw+9oSj32OtpfMSpAXqPPG9UL2Me5P69Uzb+bPkN6Rz4bvV3OgX6lTge2rtvGyX1GO/GE4fdV8Zr9w2yEsom1d8/tOm0VNrH1oVIRJRCkLsWyn1Z3P7pi233v0rCw/Cigs9HcU0lNGGGdwEnwu1Cv+E5scUcYdzrNhk8sFekZ6zLh58toQY9SfB6bEWWF0xyeMaaykLfv8DA2eiwtlmZl4ZuK10SfQuVwzrpAbrIEIC4L78LJCljnCnHPoC0yzM/l/n+ToU4Dy8F8Itz7IVk3nrpkdcCTVtwDRVlnhoOChy+ez8pHrQuXdSfAW36V7ZkWO9J2T6n7kk7/+0IxCE7WOUUzMwW4WPl34RHIg+oqsfWGDHjBrShvwskD6EOOYoTOrFNdRFbYNpGdur/5DvlHIrIdRRtSMF4hihmGtGWVMXTZuUTl/7iTbHO30L6oKisWYf+jt9o+rl1NjFznu1tv1fho1j3PWSjos2Ke
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(40470700004)(36840700001)(46966006)(70206006)(82740400003)(36860700001)(316002)(82310400005)(6916009)(54906003)(86362001)(356005)(81166007)(336012)(83380400001)(426003)(186003)(1076003)(6666004)(16526019)(2616005)(478600001)(41300700001)(47076005)(7696005)(26005)(2906002)(40460700003)(8936002)(40480700001)(5660300002)(36756003)(4326008)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 03:50:02.7258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a87bb4b-d4bb-4d86-ed9c-08da9216604f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
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
Cc: Yang Wang <KevinYang.Wang@amd.com>, Hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

align TMR BO size TO tmr size is not necessary,
modify the size to 1M to avoid re-create BO fail
when serious VRAM fragmentation.

v2:
add new macro PSP_TMR_ALIGNMENT for TMR BO alignment size

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cfcaf890a6a1..e430a3142310 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -766,7 +766,7 @@ static int psp_tmr_init(struct psp_context *psp)
 	}
 
 	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE(psp->adev),
+	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGNMENT,
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c32b74bd970f..e593e8c2a54d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -36,6 +36,7 @@
 #define PSP_CMD_BUFFER_SIZE	0x1000
 #define PSP_1_MEG		0x100000
 #define PSP_TMR_SIZE(adev)	((adev)->asic_type == CHIP_ALDEBARAN ? 0x800000 : 0x400000)
+#define PSP_TMR_ALIGNMENT	0x100000
 #define PSP_FW_NAME_LEN		0x24
 
 enum psp_shared_mem_size {
-- 
2.25.1

