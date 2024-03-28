Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2B9C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 04:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EA210FE89;
	Thu, 28 Mar 2024 04:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ktLmwuM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0272F10EBD2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 04:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUE4J13g2EP7v+lbyL6HdLWObFrU9xMf21mFiYKIdvVYRryoKuOEcZQU0qCt3FjYWHaDSMi7xX9cRx50Tlxw0goSlmt8MVnwRh8gJ7a60qCr7yRDhkBnwaPtqTnd4Nu8GmZv1xBgSyZD8A0zqy2Gkmd/B8yXyfZI7cdHk9lN5RdPEIs0UeTyoksxwRjXjb7p2kRShlewtW+MDk7v5t5Xn4p/GqPCRmndoWy4ruOy3uTDyx1fKvPC7P3bjNQlt1d9mBL22VaZZCo9alkOthl2GGQPUBUyR6azHLLz1gzgPiAmZejYunEDGnpHiroUNcVJjzTw4fk4tLZk4jdX102ABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IijEUp8KBNFH+RRn5tNTtBVWfQhKoRh4JU+Ekr7XgRM=;
 b=ddao7h6T1M6Qre3iMj8qQWutnnrI0mtbnuVvidjmxH/fb7ncXJ6OVWcZstJBD2/t/s3TxGQt181N7Slpaiz71WKoTEwiEEktQrRCSMKoABMoZldf+FsDmBRYcveUEnVdaQNA9Y3z96SOnNpqpwsY7LDaPBprxF0lmlStnCsybSsZpnoNkfPGSX4PHbiMI9fK4WU6w2OQ5hHpjB8tvBJ0ro//hbNK8HKeBAzJCcvrqWihSIQHwRA/JnT2lIhlWE3WnaGsIwopaju5417SwCH1u5KUMRsHgJTp2bmX52adAdZoz9E5uN06B0CP8zD65O5b026sl/9JMF9R5aLL0GyIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IijEUp8KBNFH+RRn5tNTtBVWfQhKoRh4JU+Ekr7XgRM=;
 b=0ktLmwuM9NoF628WPPdApZ4SDsZaI82sSrQEHjBT2XhdIb+J1GHCJRO5j6TkdY5fNc+yGP0E2enhQC7yh77rwN4lFDOqgubu7KQmgg3Jp7+9H4mKHHtw/x6KfZ0wRp7fg9BjtNowDCwXG9zPW/dAosyQX7mvmwo+jz378ersakk=
Received: from BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15) by
 DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Thu, 28 Mar 2024 04:18:11 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::c5) by BYAPR01CA0038.outlook.office365.com
 (2603:10b6:a03:94::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 04:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:18:10 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 23:18:08 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11
Date: Thu, 28 Mar 2024 12:17:20 +0800
Message-ID: <20240328041720.276684-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6701a5-74b2-4cf9-4920-08dc4ede1413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPE6sUm+6QeSgk8QvJgRg0TN3e06Kmm6qdIci2soK6e3QW6D/jyKi9hCNE6gkbyDxfwvmNiMdRuYW9FTsxMfbDMHnwz/geBMWz+bF86ZWrImZOMwQpZpOReCu7artOMmeDuoHYKhN8Fbgk9sCDM3O7l7Qf1OeQ+n7CXfVifpM6J2EF881mYbB4qWCzlc3P+7P8YDTHe2j2jfFoHOI47hO96Ge2EZxyAmfLnvHct3Z2b3hF1VcZ3A5X8EsgCkJ+BW9l5gqIquyZLG5wL9rPslYHwJ3vVzFcEibD/l8KHDvXEF06bCqfg3X7t6YoeYd1gcTuhoi3J+Kx35pNj1YH/5UXz0qVikHaQTD29sbQZMPCIHtkivOPY9zo7BSUfoaAiMucsgBD4r7LAPfzXbPb6QuXNp2U6/JXjmlsVwwSFwzEq2B6BArqW47gLeQ3bqys+IMrdAKtg27we78dPnarLkCltAwkfmdOLS5AwdlXSmf3Jtz0a0Jde9nmyt/slvnrV2XiJjTbvnBiBMKxBoKbc6tRKIpJtpb8hKrHURdyU5K38TB3B9ka3oOVxE09f1S3ZOmaNXk3gnHbEAF7EZWcWjMGh+CdeDcD8rT8NNNyHiWeAhoESZ+1gnu5KC32J2w9W4FHHLnzr8Aa6lt749r+4IycXdzit71fN53m5KDIUxKY/nqq3TJHe9SYkxDO3Jgz92vgnco0jfI8zS2/2ISWHF3ScaUemVSE+rUF923PlOQj7ZVaaOk85QQauuRc7kuMPh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:18:10.4719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6701a5-74b2-4cf9-4920-08dc4ede1413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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

From: Tim Huang <Tim.Huang@amd.com>

While doing multiple S4 stress tests, GC/RLC/PMFW get into
an invalid state resulting into hard hangs.

Adding a GFX reset as workaround just before sending the
MP1_UNLOAD message avoids this failure.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index e8119918ef6b..88f1a0d878f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -226,8 +226,18 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!en && !adev->in_s0ix)
+	if (!en && !adev->in_s0ix) {
+		/* Adds a GFX reset as workaround just before sending the
+		 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
+		 * an invalid state.
+		 */
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
+						      SMU_RESET_MODE_2, NULL);
+		if (ret)
+			return ret;
+
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+	}
 
 	return ret;
 }
-- 
2.39.2

