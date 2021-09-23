Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0988C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 09:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4CB60F39
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 09:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C4CB60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0226E6E0F7;
	Thu, 23 Sep 2021 09:11:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491E36E0F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 09:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is59JVAS7S2KGg2iF9hJWBPUhU03LKMLbnJHaQC+pXhmsf0e6zzpqarljB/NnRWNIM8NhT/AewZplKdI7NIlcPCF0paJM9tnNKj7VmWOuZXnMLj7oIUmPHLJwB5GlovIBtEhT42z0OqwGgkrmcm1iIhvdhX0Mucueq/f1vXC8G28dh1tAzSfvnUDoXYjQOAv2Sn3wGKYZ2x6Q7RzY6PJqf1iK4sTKyeLnkqGgVb0XecHUwIVq+jqJjOAMVVy292/RQKOlH2lzd0qOUz8ZTWa1/Krz0oOVg3GCJFW+DZM/Pww7IShdp/LAi3vRLTJZ93Xv9XsAF6mU5iTH0HW2DKCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=VgNsP+1KKefr9+JRvDO5DR8oGXnkaP7w9DZgDFkZrRY=;
 b=ae1aFVvwe84GBemb5jdFKTC2MOi9JSMtKWDGvrgJu+SHHUikCPLVtYcElKZHkcOSg7u4y1COob8xdRHMfN7R5+mPa3fMmWwtFgG36BFlbFIMeVg5LBOGCptfGo8Mc1cqjS0eYwDDwS6jihNY3Ve+BSg3I2zXaMmvznnO8h906+fxXz81JXlO3FwW3MN6CiRXbCJU620gCZzmH0sBWTTBwnSdKuHkPEsB+7kC3sdSVvIiSiuYyjNP4bYvHAjWWF8HVm8eYIYjn0+Oyh/SBy0RFzHt6iVHY4Cpw8CCcF7cL0uX9sJDFV0fCDM4LSF0erjsXB6cb04k5ZYhMCKLJ4+NMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgNsP+1KKefr9+JRvDO5DR8oGXnkaP7w9DZgDFkZrRY=;
 b=5QB2Ocqv73QuO20Wnu5XtxSKFVs55jhI4rn9HogoPP9HFNIIuODf/paQV1BWahTlYoSBNeZZLutsrSN3QTaib86SVy8Nh+oWHQTpuwwfrxeN7jawNrCw9eq05w9Ep+5kpDiR6yPrmrtJUvE7yk5UmUGWRZ1Ulag74vzj+Q0Ijp4=
Received: from BN9P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::19)
 by BYAPR12MB2949.namprd12.prod.outlook.com (2603:10b6:a03:12f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 23 Sep
 2021 09:11:50 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::dd) by BN9P220CA0014.outlook.office365.com
 (2603:10b6:408:13e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Thu, 23 Sep 2021 09:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 09:11:50 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 23 Sep
 2021 04:11:49 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: John Clements <john.clements@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Remove all code paths under the EAGAIN path in
 RAS late init
Date: Thu, 23 Sep 2021 17:11:36 +0800
Message-ID: <20210923091136.29080-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 641992eb-208e-4d98-d859-08d97e722da2
X-MS-TrafficTypeDiagnostic: BYAPR12MB2949:
X-Microsoft-Antispam-PRVS: <BYAPR12MB294991278831729C5DDD7A2C91A39@BYAPR12MB2949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wObQmQr8TVraTCfbYGo6H3bFX55qlY+sXfYDg7QcFFRYfK8E+AZkrBELfKVg7F+Z1xV42HUmhZGLeAVnNdJb7F4Q+nUbZkNb1GbRlXpKK9RmhJtMQPSXDiWlypjNlpsqfSQaA37ehg4zYt+3rXkrVPZsZwoHnKQtqvYTKVHquOUlH+vLbhZ3pQjaHnMN+seSeMr8slmkTGzJFXJhLbTU8BI+vRiWQzHbnKlFZ2qxuetGPqjaNy65yB+kJVjnJSlASW0hQVsf4Ib+KWcEhVWAVASLRF4raJ5EvhnBTleo5fyUwZ/UPrHzMH6+2OZDJTmB2Yg7UjNb32VjvsIM+zsVLzfRW1FWB45InK+12EyXskEfkCiz0ykPMkjltdoXXhgqW9VVfQWzU93YLpiS41OgRL0pAqWe4t75UUJ6PXHljybdSBhrS5jM3q/JMdKin0jpz+CxXtzmtCpra715Byx09KTJlCB0oV08leryt7i6JX+rP0+2Z0QaxqIphK6SqJJKOES8NZFVsYBUvrjPmC2X/LpUXmNn/2b2j8r7NJBh7F0Y5BIICRjyjGVlOvtf3HWMrFnWb3CqkZ3WJItn/FD97mTe8ZJwxlJwvWY+tWu1FDPKoSRAwYZBDjjc2EUQ62JPJMJqpiscVaWY4aYijthyHKIddPc7o0EtG/3NFOKFU3xdpFx2iuzc0hgr4VEGruup0xg9yLm8h8kALqavWE9WcnCpx3c0zR7gO2viDg4aIg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(86362001)(54906003)(2616005)(2906002)(1076003)(7696005)(82310400003)(8676002)(70586007)(508600001)(6916009)(83380400001)(70206006)(47076005)(44832011)(36860700001)(316002)(356005)(8936002)(4326008)(426003)(6666004)(26005)(36756003)(16526019)(5660300002)(336012)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 09:11:50.6224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 641992eb-208e-4d98-d859-08d97e722da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2949
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

All code paths under the EAGAIN path in RAS late init are unused.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 33 +------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ---
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b5332db4d28730..6cf5f6e06b76ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2060,19 +2060,6 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 }
 /* recovery end */
 
-/* return 0 if ras will reset gpu and repost.*/
-int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
-		unsigned int block)
-{
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (!ras)
-		return -EINVAL;
-
-	ras->flags |= AMDGPU_RAS_FLAG_INIT_NEED_RESET;
-	return 0;
-}
-
 static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 {
 	return adev->asic_type == CHIP_VEGA10 ||
@@ -2310,12 +2297,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 
 	r = amdgpu_ras_feature_enable_on_boot(adev, ras_block, 1);
 	if (r) {
-		if (r == -EAGAIN) {
-			/* request gpu reset. will run again */
-			amdgpu_ras_request_reset_on_boot(adev,
-					ras_block->block);
-			return 0;
-		} else if (adev->in_suspend || amdgpu_in_reset(adev)) {
+		if (adev->in_suspend || amdgpu_in_reset(adev)) {
 			/* in resume phase, if fail to enable ras,
 			 * clean up all ras fs nodes, and disable ras */
 			goto cleanup;
@@ -2407,19 +2389,6 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
 			}
 		}
 	}
-
-	if (con->flags & AMDGPU_RAS_FLAG_INIT_NEED_RESET) {
-		con->flags &= ~AMDGPU_RAS_FLAG_INIT_NEED_RESET;
-		/* setup ras obj state as disabled.
-		 * for init_by_vbios case.
-		 * if we want to enable ras, just enable it in a normal way.
-		 * If we want do disable it, need setup ras obj as enabled,
-		 * then issue another TA disable cmd.
-		 * See feature_enable_on_boot
-		 */
-		amdgpu_ras_disable_all_features(adev, 1);
-		amdgpu_ras_reset_gpu(adev);
-	}
 }
 
 void amdgpu_ras_suspend(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 1670467c205463..30a3eafbf6d095 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -32,7 +32,6 @@
 #include "amdgpu_ras_eeprom.h"
 
 #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		(0x1 << 0)
-#define AMDGPU_RAS_FLAG_INIT_NEED_RESET		(0x1 << 1)
 
 enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__UMC = 0,
@@ -488,8 +487,6 @@ static inline int amdgpu_ras_is_supported(struct amdgpu_device *adev,
 }
 
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev);
-int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
-		unsigned int block);
 
 void amdgpu_ras_resume(struct amdgpu_device *adev);
 void amdgpu_ras_suspend(struct amdgpu_device *adev);
-- 
2.17.1

