Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34C6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 13:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CE714A157;
	Tue, 19 Jul 2022 13:17:45 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1AFC14A167
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 13:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHn+qGtf+QX7S5K4IN9jj7B5lMETJqOCcPfst05ZRidBbGalzRnTm5xPLELJfeV1/jw7lSjAJOcEIaKbCC2U9ugFddyJa5UpQ25GGnpOilYtIVbtFLclBBRhu1pBYy6yP5MGjKldT6XCOSfdh2toRjOUm+yRtnUZR9xp4doqlavMFzOiHfok8tqF965Jy3pzhrX+WHUODSMhLmwwkHRi5YDQN/4Q42x647wtGcLOyJvbZZe0YgGIM1k2P4tFIiA+BYh0rOLO7V3WUB25ImrOtNeu24ebnuM+pAVDIrsHfijLdX//ly/ZRrpniHRpDiHddY/+OKBUL8KWFsNIiZGE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjCy36TMGb9eIOc5e1hzhBYMesN/nlMvglc5kNRW9jI=;
 b=Y65VHsw7v8NciPqPHuixKMWGIQGJEnt0+16cm3nwkuwG/dt8KCI87smjY5TatGpAYo4aYBdTej4kKa1YqpP6gEqZx2M+GGQik6gEcWbFrakEEY+RAQu281uwqs61BZlCEIOaW2/EJtBkLPJcCDzJWZiGTU5tnodTUkir5JGvaBJX+jr6B+3a9HJCRXMQdQurcs6txn5V6LTrM2/ICBH+sqzQp8zlnEcGRzxBdLk727noAHc49bykSlPiTjBwRj5GL9bVaYBLgJZo6B7HfSC1Luetl0sM8dFSIkcHKZKCsoYQdBaoCd9GJb9D125KPAJkaTD1QnPZpAqElPUIgs6dbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjCy36TMGb9eIOc5e1hzhBYMesN/nlMvglc5kNRW9jI=;
 b=pAENvtdMXhwwybObJUHauBBsGvA8O63Ynvv/6Y7iE42nHUUVwBKKsUTsT6s8JYj6DofNalxlJkLWbS7fXlJYQGYxs5uqTLrvljqJQmszNFIa7H9K3b36vovG0EaDpl3CNlZCJC//ZPMx0x66WctCdJ8dhGAU16TGH2Z6LM1xgpM=
Received: from BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::9)
 by DM5PR1201MB0075.namprd12.prod.outlook.com (2603:10b6:4:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 13:17:41 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::fd) by BN9P220CA0004.outlook.office365.com
 (2603:10b6:408:13e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Tue, 19 Jul 2022 13:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 13:17:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 08:17:40 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Tue, 19 Jul 2022 08:17:40 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable gfx ulv and gpo on smu_v13_0_7
Date: Tue, 19 Jul 2022 21:17:36 +0800
Message-ID: <20220719131736.133958-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f23a7b27-ea8a-4a81-f5e2-08da69890f5a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0075:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7rHq9ClfbqDsr0TAh5Ah4/mPsddTNH1GM7nU4az2hyoep8Gwp0qlSd0uT3V+DeXzZgLe2iDaUXy0x5CrXqTpjy02HpnuPkj5yJza3SN4V75cGzzYQt9lobM32Naf03CcrWV0T68l97nNAq3b4TAd9NX0avVksOWWzDNGWwkOivWfM+crju23r0f7cIDHJp+EnROI2rSxw2ZdB5H38MI/lJoq5j7zgpyMoWTaXFElQVKRf5bJ6L5onV0D9BiYvMPoDHLvk9DQFYZXhsK4fF7ild98m3GURLbeHMpLH5MEkU8/cu5T4v9Ng9uiMkFv7887PzVJ+SirXsQRLb95VGkzxVGU3E/SY505d7tbQ6ICFS8kna1fL+e5EOq0sqQSfx5Guo0QFHPfIuiJp9SJvBdpd4MWuWX2yZXFUmGzNAcv2VZayMq10TPmriKzHrBp6KDqwelJeabUNfJznUTr9HQAgIBOrWOt9gm5+ZO7khGJKWHyKI/wwPbtCZJRfMiojk12DFKeD1B+3WIQzSgZEY/B9OpqfGupMOJ6V3R0LMbhxmVawQQWL9/rpyAgA/Jz3vWI8kPcivYe82E55IU9LIWhrRJpkHmdU9AZBx9RzwM+4TfD8N+NQbbUQuY63GKWB7G6Jt+3mAo4gjPRbDOSmJIoQW42d9zdkKJ8YG9n4gXN6H94ry/gy7lZQJIt4rPvf58Yz9uRr9Wfhp7EJ2ZeYNe06+fJX+/EOmyWOnbwFJY1zROwYLnXIkH+lD10r75oSCG5qvs67DsjhkME7AUUg9zTTiN+lzcZNO1j84rEcRxrciiexHC8UqK/+af7yWI7RBkHei4ZVYNfzjDMG94/gHuPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(40470700004)(36840700001)(46966006)(36756003)(2906002)(40480700001)(8936002)(44832011)(316002)(5660300002)(70586007)(82740400003)(82310400005)(8676002)(6916009)(40460700003)(2616005)(4326008)(186003)(336012)(7696005)(26005)(6666004)(41300700001)(1076003)(478600001)(86362001)(70206006)(47076005)(356005)(36860700001)(426003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 13:17:41.4620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f23a7b27-ea8a-4a81-f5e2-08da69890f5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0075
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable gfx ulv and gpo on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 6f0548714566..16eea2de8a2d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -251,6 +251,7 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK) {
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_IMU_BIT);
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_POWER_OPTIMIZER_BIT);
 	}
 
 	if (adev->pm.pp_feature & PP_GFXOFF_MASK)
@@ -271,6 +272,9 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
 
+	if (adev->pm.pp_feature & PP_ULV_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_ULV_BIT);
+
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MM_DPM_BIT);
-- 
2.25.1

