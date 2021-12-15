Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADEBC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 20:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6458110FA17;
	Wed, 15 Dec 2021 20:45:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064BD10FA1F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 20:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fibiqkFgTivQf0YaKGDnAHYdPPgHNER4+yz4ceWcqsAV5FJan8DIXTXT6y5xhRERKNGwLqUM6oSVM3euhrt5qCji4vuv2whPbRZBcISi6FZk7/kodUvMHiI68WStnkj4EYCnljxhtlR/uzXNKszYmCVfiu57QdB6ugwC55JDyU/oMrAWTAb3rUK56yl65V7DnNWK272DC4ZeJ849TspnvPd03MQdBP7zdBVhOySxGjLaM1d/fG2cEEfkHwpZnABETgG7DTdPq51KeerIfOiw3+VA0PLfc56pgoHBSx8MkCBGXWIcqnMAbcJ1bC45OkXLEQ09geIFxhVs7xC1NUnfsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55YD9gL5keeCR2ICp0kZHWsvT2Te/x1tD4SwvmSnPyc=;
 b=jbKiy3e+ePabHOnIWziC7rqCMQlK4KClhDWNrqbdSycg4JBM+zLFWidmoG1Q6cg8QO6ig33qxuZjNF8BKXUgg3vxJ6XgU7wP0gRpinDC8aWPNDje68+uiJvLiuYHCR6JkaZ5Isx1ms/bxQMIR07DLOU3t12Qhzt5hAN7wvZvicMkqbaWHDDmNUkOD5QAhHeccYz88liWiDHlDG7nbhndtUC1q5WXZkeTlxETYdPCOhLMeZf2LQJ3MwCPfulgfenq+c8XN6ShWWXQYSNOqbF8uqlaSGR74ISPmnnX4ke95hmfsKwI0uOLxgvalaO6IAvu3inx/SsHdB6AMFMIITu2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55YD9gL5keeCR2ICp0kZHWsvT2Te/x1tD4SwvmSnPyc=;
 b=ApUPNI3LurKoMSj5+znL04LZPJyiyVlIr1ql73pTRAiFFdqlF9E57vcWyNq6bSEdJb/oKpGKRFebHWNmRNtjjb7jrjmuuX3tfiBkUkTS1Sc7JfFcrdG9G6HGrRY7d8iAFJ+B8jHgiAcMJILEOS5pPbPjR29+7NtYVoQslxnnsq8=
Received: from DM5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:3:23::13) by
 MW2PR12MB2588.namprd12.prod.outlook.com (2603:10b6:907:a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Wed, 15 Dec 2021 20:45:07 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::ad) by DM5PR13CA0003.outlook.office365.com
 (2603:10b6:3:23::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.10 via Frontend
 Transport; Wed, 15 Dec 2021 20:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 20:45:06 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 14:44:59 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v2 4/5] drm/amdgpu: Initialize Aldebaran RLC function pointers
Date: Wed, 15 Dec 2021 20:44:38 +0000
Message-ID: <20211215204439.7216-5-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215204439.7216-1-victor.skvortsov@amd.com>
References: <20211215204439.7216-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d7e284e-8e3e-4ce6-c8a3-08d9c00bc6fe
X-MS-TrafficTypeDiagnostic: MW2PR12MB2588:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB258822F21D4ADFF3BB1C10CA8B769@MW2PR12MB2588.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WOf5No7sv2K/frMQeH2Vg9A1bJaDjLSKMEkzPe9GBqL0qcXtvWt2wxW8heB1u9qZgX8z6t8JijmyUC64RsOgpXSCYNlduFvaQ87P6ws27+lVZb97pqsoPN0OaYqFXHgfTpCEWSQ7DjHbv76s6NFYNOvRn166OwVG6LJRrZxTGv17mZi+geh+jJfdoJBRh6Rnatz8zSkXGZ0HxZmAUDGAh/2Alh/AJ03Ug/0rFMj+Sl2mgya17k5cxcc9/7NZJt8ekw7QYfvy+nyDB6BJ0fWFGTpH/iY4rLlSCTT3pJb9lsuDoI+aKQE5xXe+A/MKOGLt9USYVhNqMmkW3uIAR33Uzi4ej1TorflDhvbE+LS2mHy+mDev4Yo7EuDZfqE3l7Ejrbw5j3JuVMb9IWE3hzz61gkNoAom3m3AjZHwH7kGkbhm0nfdiVQRTXSurUD4w8cZ4n3WXAOBgqKnAA5lnStw2j3Uv7TNn8aBAdtPaCGBQSZJifkicumNnkO6Vn4S1jMBLNDAQJ+nTt/FkZjMMJWQF17mmnpKH3vWy82oULSK5IF5iS9tWVuN+9OWJYa2tAYuU+5rWKLjHiY+/t6agQxTYttl2wuJVgo5K8re8uBPIWx40ueuOBm1BvPTlSAv47J8DwzAPpSYlvFa/4UQXkSK2UG9m+a9DR+v/U9OsPfpHsEVklUy60SuwYBzwbGPM/CJr6ruTNn0/MCnQgD2ucysrNuIOuAo9pOYNci4BTdR3zKDfiwggL4u1t7qMHV4IKCaWa5V8Hpwy5fzOOEsKVygRJiV1TKlcvJ/5MjofYgBao=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(44832011)(70586007)(6636002)(83380400001)(81166007)(356005)(8676002)(7696005)(426003)(40460700001)(86362001)(8936002)(36860700001)(47076005)(2906002)(6666004)(36756003)(70206006)(110136005)(2616005)(5660300002)(26005)(508600001)(4326008)(186003)(316002)(82310400004)(16526019)(1076003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 20:45:06.4546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7e284e-8e3e-4ce6-c8a3-08d9c00bc6fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2588
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV, RLC function pointers must be initialized early as
we rely on the RLCG interface for all GC register access.

v2: Make aldebaran a seperate case

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h         | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 65e1f6cc59dd..d7e1b503cd3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -842,8 +842,12 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 3, 0):
 	case IP_VERSION(9, 4, 0):
 	case IP_VERSION(9, 4, 1):
+		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
+		break;
 	case IP_VERSION(9, 4, 2):
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
+		if (amdgpu_sriov_vf(adev))
+			gfx_v9_0_set_rlc_funcs(adev);
 		break;
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index edb3e3b08eed..d252b06efa43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -816,7 +816,6 @@ static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offset,
 static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);
-static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
@@ -7066,7 +7065,7 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.cp_ecc_error_irq.funcs = &gfx_v9_0_cp_ecc_error_irq_funcs;
 }
 
-static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
+void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 0, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
index dfe8d4841f58..1817e252354f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
@@ -29,4 +29,6 @@ extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
 void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
 			   u32 instance);
 
+void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.1

