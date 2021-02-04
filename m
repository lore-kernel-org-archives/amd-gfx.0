Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB798C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 03:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CED764F5D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 03:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CED764F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF826EC6F;
	Thu,  4 Feb 2021 03:32:52 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4041E6EC6F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 03:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjaZGKSJ5OyHhKTJPpImZPqTXh90greZnVBTq4OdgptXg8+rkvVRtia6oL3sJx8yWaUyyzFeBv2RWrGGsQ01BLfG6TAe0jHCGNhqV7YgJHmD4shWunrohk97v4MM6HsTQB6WWVewIJzCQkHM8OJxBK05lMgbryqglyjUgCnmqPaREiEPQ6KGkvCP1LeOs0hxVjDeMamq2hKSC6BDQ68xtDSwrOqn77IqDDmRg8Hx/HYi71UtLTGnk0o7KF3qMy7eR74V1uBHud9xxX/wsyHf115xCojENvkfws+rjNL0hPxYQUcmhODwd/OIYVtZFE8iDlOreIrZVsOcf7W5rDXgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxSRlwDcELuAle+QBSQGt5WmlTK9DGOY02UM4klOZfw=;
 b=LF7L3eYtUcjre86KMWEZgXXylvhieOkGwezLbxPtj2wyThlvFjUed4p/Qa4brG8UoX2bjkqyLEgZMsmVEa5UTZ+Y9tW07dKfBJGfpesYIuongmeVIXdFeRaHeU/SHcBend4JVuuejEg7+kQAuT92Kk327WxDfkLLQA/8w0FsmzlTeRQnrAwOvmxoeTnjCvgzJCOHBxF4W2oPv1113nJfGC/Eb7U5nreZZUCjZct2cK99Hpr6TOlJdslaCBQkVjzFq+ufviJkEgSTNpaTLljqceQAY4peLG8HHXIrpI7qysuo/SyWemhN+1ZDYukJEES3Yo/kysoVBbrwHl/MTg7J3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxSRlwDcELuAle+QBSQGt5WmlTK9DGOY02UM4klOZfw=;
 b=R7518w4zUJ2VZCRGq8J8bS3dSLV/yNrLJJV2xnloEbb45ch9BGCtA7h8zEmVFRAUWmLaQYQtsYdOvvIAJYY4sAP9fHdEXqzD1QCI6DbdvmO2za7fOrXKTUNp9hMWux3QddAVj3vx68HhwEZy7l2PgTqHMCirlhveyrgAYu/WUmI=
Received: from DM5PR2201CA0001.namprd22.prod.outlook.com (2603:10b6:4:14::11)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 4 Feb
 2021 03:32:49 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::8b) by DM5PR2201CA0001.outlook.office365.com
 (2603:10b6:4:14::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Thu, 4 Feb 2021 03:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Thu, 4 Feb 2021 03:32:47 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Feb 2021
 21:32:46 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 3 Feb 2021 21:32:46 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/pm: enable DCS
Date: Thu, 4 Feb 2021 11:32:42 +0800
Message-ID: <20210204033242.3205-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f53ccfa-3cff-4600-f5f0-08d8c8bd8aff
X-MS-TrafficTypeDiagnostic: CH2PR12MB4102:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4102DB17990F46DA4A2DF3A78EB39@CH2PR12MB4102.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfBqt69ZIjGIeBSGEJLfpffMVSn3FM1+JdwF3jjHPrqH1L9qhjaRabzU8kI5ngYou7Sl/5+ZogB+KaAPA9tGdEyc3FA+Dr7WYuVE7AjcyHqRbePpsiEX09Do2ip/IMgKMYFgw/303weH3UNjslFkRsKg2Fx2J8AD3eUE3uQ8EClMl2coGh8Hc16Ja9Fw4tyQqWpc7YCoAH+YtCzKC2ejaipGMX37nBMhOlfyUWGSMQYvPBjZEUGJgX74Sb45VGtZX/aYIa+i5gWkzyrHLTNfrWFT8bynKF2C6ZTjHTTmb9CiVoyaL/jHP/hg1SqJ5vCctOLG66mzhpD8MECvepvPGw+361v0LMFYQamg4WVLljY8d4JoJMpcp/ZHUKD/Rf/aJvGdBtcaxffBU9mryni/hsliKKGXmaeMPB0y7eR+djs/vvR5TVDtFUUmSweqmqanV/+3FPeLW5f/tVpLB4w8kwhOZFIrNC7A4A6ufWSJjpf8g7WDE+h3NBvpxf8zfMLPMKNpTlUDK4/0tkbkm8xAWRyRx5jGwp1I1x5IHxMCjIGGUaerRueHH6NPJDnR8vX3PsKVfrmJsQ2MYQP/fcNNyVFm8189oRyJmejI2Y51ne8kUhPNWzWrWzrAX2Q0rse3O4vF6qQK2jdRWe75g6fgB9ByIHtf2p51pbwW3xrCiK77IPO0J60DkWq6RDciRGoP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(316002)(7696005)(70586007)(70206006)(8936002)(5660300002)(83380400001)(1076003)(47076005)(36756003)(26005)(86362001)(82740400003)(6916009)(44832011)(82310400003)(4326008)(2616005)(2906002)(6666004)(478600001)(426003)(336012)(81166007)(356005)(186003)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 03:32:47.8450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f53ccfa-3cff-4600-f5f0-08d8c8bd8aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable DCS

V1: Enable Async DCS.
V2: Add the ppfeaturemask bit to enable from the modprobe parameter.
V3:
1. add the flag to skip APU support.
2. remove the hunk for workload selection since
it doesn't impact the function.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                 | 8 ++++++--
 drivers/gpu/drm/amd/include/amd_shared.h                | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 5 +++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2fd3a80bb034..ca3dce6d463e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -131,8 +131,12 @@ uint amdgpu_pg_mask = 0xffffffff;
 uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu = NULL;
 char *amdgpu_virtual_display = NULL;
-/* OverDrive(bit 14) disabled by default*/
-uint amdgpu_pp_feature_mask = 0xffffbfff;
+
+/*
+ * OverDrive(bit 14) disabled by default
+ * GFX DCS(bit 19) disabled by default
+ */
+uint amdgpu_pp_feature_mask = 0xfff7bfff;
 uint amdgpu_force_long_training;
 int amdgpu_job_hang_limit;
 int amdgpu_lbpw = -1;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 9676016a37ce..43ed6291b2b8 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -213,6 +213,7 @@ enum PP_FEATURE_MASK {
 	PP_ACG_MASK = 0x10000,
 	PP_STUTTER_MODE = 0x20000,
 	PP_AVFS_MASK = 0x40000,
+	PP_GFX_DCS_MASK = 0x80000,
 };
 
 enum DC_FEATURE_MASK {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index cf59f2218b7e..fd090d057d26 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -261,6 +261,11 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
 	}
 
+	if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) &&
+	    (adev->asic_type > CHIP_SIENNA_CICHLID) &&
+	    !(adev->flags & AMD_IS_APU))
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
+
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
 					| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
