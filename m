Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B387C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 08:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045DE10E6A1;
	Wed, 16 Feb 2022 08:09:12 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27B110E68A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 08:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2/TmP3o2jNj9V7G6bz3EvUivVLz+fI/lDUXuAW03bwLHDkpe6eVKQLlMoFbCkoNzb0zdwb176szaBQVzred5XB6A7o//iW42RqOT7wBjaB78MfhSzUfZWBJ1hItlBfLKGXFiyGVbsstfkzunkDLCO1+MQbs4XC5cMqPEqB/pFjeZdsZ8KbBykXYB2maU005YX6TUoYLipM3NwgiC2adqeSV7OQj6UM+/x4ayoroDc3sPlM8JTh3gg3Q7ilt1w+7jcCnrE9K5A2i+WOYhp5u1YwxceYR6asdLr64mzsbRiol3/ODJyypWX7wN2yf2NH6+d/qiUq9opAOFzofh74xrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUSJHtEy2gGQJYTLlDON4HC8hLr3CXewfn0uIh76GlM=;
 b=EPE+UesvaRzzSYVgGfGn9XB2HNZYhn53FM0kCtjYAVwSgJ6Od9E/clTB141icR6fxL4UGRNZw5cH2swDaUCAybqzT6cWjCM+BR2RTAyECIpAE+AejsSe7qmKoS58lYfEeqSTxU+doMn74DLWLkexqUeHjgDgfVmpxNcKEpIS5A0v+bLmyshRKnCWSrKptEMunmknZb1p6IPe6VYXSivg0xmv4oakGByFyOBu4FwYFq3SYaZ/MBD8iRpdRXxpOkwgy2F50Oc/xPTloGb1+SKDwGu7EBLysjNJY9DopbpodBObDvsXijg+8XQdFnhwlZ8YjOKmpONCn7qehmwV+/1YIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUSJHtEy2gGQJYTLlDON4HC8hLr3CXewfn0uIh76GlM=;
 b=D28dYQuXP2QGO7bQe+mbieZDTqRB4YjNa5NHjtPbFo4Y42rprneghC7zSt1IlC4N11COiY3YuQJU8RACM+FHhVtGr5jE/q831eIwoFXnOgDkz+xTATqm6vlfHbJkIsHq/dJxVaWZkBQgyh7deNbZfIRJa3he2qGAOmqfo3s8By0=
Received: from MW4PR03CA0294.namprd03.prod.outlook.com (2603:10b6:303:b5::29)
 by MWHPR12MB1310.namprd12.prod.outlook.com (2603:10b6:300:a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 08:09:04 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d8) by MW4PR03CA0294.outlook.office365.com
 (2603:10b6:303:b5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 08:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 08:09:04 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 02:09:00 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/7] drm/amdgpu: Remove redundant calls of ras_late_init in
 hdp ras block
Date: Wed, 16 Feb 2022 16:07:59 +0800
Message-ID: <20220216080804.3560484-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
References: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab788302-c834-463c-7c3d-08d9f1239934
X-MS-TrafficTypeDiagnostic: MWHPR12MB1310:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB131063C2782527E50CD4DFD8FC359@MWHPR12MB1310.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4hwRxi+vV72BVxGfdNoZVQ8eN2TNyzPRYgOkeHQTuRN8uXUu4WBxuK7VlXMSz2G3AqElGiqWiNKZDRzpQko4kLoGuStOL7q/Ph5rHffNce8eSpjcOOPAHbDPGZTW/4qNkoGLp1jTzJGulJ7Dn/o56If/JSJiIR1CXbnsKF8hy6cMBlAwOA4+w68Nx/XhaINZEShA8ONgbpnA8Np5uBIRGQbaBCBO3yMWI1S4Qd0Nm5HdvnWVXnSrnAoLUyizGpoyQNouLGurioUlLYIjQ3FuJUD0QoYzpalm+3+17hmU+ENXXYMgYLHxm974dOo0s54lVgfjBKkbKW59WxDgCWp6UH0fsxZ5rOBS7pdtZ8/Jevb5dGDtio/eck68bM4xhTm4mjiNDzkpENpMEl9PZ/E9owHJfmaY/B2z0+6MHixc+l6dut9V9CQbwdi/o02TJRk6yMqcQKzn6QgIUQN9xc/5GoHcwt9EYkR7WRZPBs316OvUbdpJnsvYMYnsirgg2GdYeOYuipWDyQ8OIHFoqxMLaS8LA+VLDqORvk7r8gQRza3O2ko6DLBUCUPRpKwU+PqXbj4XWeHTExR4mqhAUtARtM+T1f46kcZTqw6EssL3aA1JSISplj/DEhGrO/ntjQFwHtexscsP5A44+QfnRujwjtUM9HOXgfrTajwkZtk9Ln5c9WnM4ZE3NI/iNrZ/bn4b7I/Igek6kXhnLIrU+ld0FGZmoBb5cD9tn9+kAoNtsk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(356005)(2906002)(81166007)(8936002)(36756003)(8676002)(82310400004)(7696005)(5660300002)(4326008)(86362001)(70206006)(54906003)(83380400001)(26005)(70586007)(6916009)(40460700003)(1076003)(36860700001)(426003)(186003)(47076005)(336012)(2616005)(16526019)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 08:09:04.4264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab788302-c834-463c-7c3d-08d9f1239934
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1310
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant calls of ras_late_init in hdp ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 956cc994ca7d..67a7d1cb89d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -470,7 +470,7 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_late_init) {
-		r = adev->hdp.ras->ras_block.ras_late_init(adev, NULL);
+		r = adev->hdp.ras->ras_block.ras_late_init(adev, adev->hdp.ras_if);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 70a096160998..b7fbc114a175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -24,11 +24,6 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	return amdgpu_ras_block_late_init(adev, adev->hdp.ras_if);
-}
-
 void amdgpu_hdp_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index a9ed4232cdeb..c9e931f046f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -163,7 +163,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
 			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 		},
 		.hw_ops = &hdp_v4_0_ras_hw_ops,
-		.ras_late_init = amdgpu_hdp_ras_late_init,
+		.ras_late_init = amdgpu_ras_block_late_init,
 		.ras_fini = amdgpu_hdp_ras_fini,
 	},
 };
-- 
2.25.1

