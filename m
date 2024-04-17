Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E970AC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 12:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A191134A0;
	Wed, 17 Apr 2024 12:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BmDWDAQm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D29A112946
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 12:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXQDayLC5xNsYsS3k8QKif2QQCJBHamkugsdVuEoxyi9xNIRbVYmnkAhL4k/XaSdDNHE+3QfIQemVawZ+btSWRqSmE6mWo0P18mjLUxHKE/auYtXQjxqC/ZFAO9EWeCHa9ofkyyVF9lJhOn8fJAvO7zdPKm/dc+jhg+Io4Um7M33RHZv1mVaGlodxxK1Xk1Dd1pNEP/Yh5Ru4lrqQ4xGTOYGhuV+rWyIR0+CC/cngoBJxsXEdJU3lIPjHTbl4Kh+PY/Eqv7L6vKBm5QS+/NnbWWazUjLKy8SS3+OdVlViYjSIuoitgdlrcTBfgTBTtkh3+I5IHIKRortWkkj/gmKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8gmaw/JUiGXzwpM8x0C/doVrua9CDpVsYv/t65Go3k=;
 b=d++FeJmGWUTYUsvafl2AnKBNYg+J1lYmUKbqFWWwRyYlvu+FXGixKxkpHB3aOTvLb4Zar7j/MWgc+kxi7E7yGzUE0Dj8+gkQCzfOvghp7m9aDxY3RAJUDO2xwRG73bYZhzgMc6MCf9zu93bsQkys4cJPKonvU2/7AQR4zIKdA5PwRSlOlXpepL+gg5xvfVqgUmROHozZMtdjroTn93g6Ob1M+BJtUVKa9Cg01kpuv3t8BvlZB3ocBU3RJFInIN6R2QGezkoD560Hh5QaukrXxvLP7NYBKD09z8xa8X5Sd3E3Pc32xdM36XoMrlGdzSm4jWnB2PkN8ha9p2VtYv67VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8gmaw/JUiGXzwpM8x0C/doVrua9CDpVsYv/t65Go3k=;
 b=BmDWDAQmCAtZzaonCYn3tkCGvNNbrHRIZmnfWYU/761DHg72y39be8eO5YA/YDaP2xGgDWKb4HmnfSRGCZ9nUG3lbxVjpiBxPckV55dDyI6qkaHeTnb+4uKFPNaLv+7IIfugpWy/gXe1F6i0eMdmp15g8R3FjvA7LqVpeVYzYn4=
Received: from SA9PR13CA0123.namprd13.prod.outlook.com (2603:10b6:806:27::8)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 12:51:45 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::36) by SA9PR13CA0123.outlook.office365.com
 (2603:10b6:806:27::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Wed, 17 Apr 2024 12:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 12:51:43 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 07:51:41 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <yifan1.zhang@amd.com>,
 <kenneth.feng@amd.com>, <likun.gao@amd.com>, Li Ma <li.ma@amd.com>
Subject: [PATCH] drm/amd/swsmu: add if condition for smu v14.0.1
Date: Wed, 17 Apr 2024 20:51:32 +0800
Message-ID: <20240417125132.306112-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db21beb-cd27-4ade-9240-08dc5edd2264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEaDb79eD96g+r8iaLF42haj/MTbEaNNKij0CItH2bXriG5RrJzSYHDbgR+UQRG4NLL1SksPM8izNJ+RnwkE7Ot3fTie/ayu31QqLHjXWp99vgwK46kSmfxPFJ+U9YHiyN+wvyVxM1tW5izFqPqxVXCf/hKkbw38PQLzmcaDowo112rWcA5N8LJMPvkM+U521F8FuZMPgncS7cg/1ESoDE/Bwwf+4CAw8WpjU7jLRzjtSXaCZV+7Ogv3HGOpDM3HffzIreEEE8Gn+WITT4j78Mq9+wLmXTDs7f+axRMqi+9OOk9TbpMR7+b5lOoHiOsro1FJqyjnfc7+rOaXtr3K9MxAWb/ZULMciTT9NoctNfAt3ZotU0cEnMnmGQq1xWqNKSSyl0ZDZoicu0EeBPh5Cc6mRukYop89fz6elXxowF0cQzvY5An9qcBCbNBtR9gAB5jX70WEah0Z8RFlscOoYc40evJeYzFxs2Fre3GTQsE4Pv9j10ApCKdBBSpZDAQJC3pkQTsaTBVs0AOUDIPPO8TTN3BYq4lfLKwoGrU970iSmXHdOO/yTEoBIpW+IN4m3Qbbzj6HvtWVSyEGxdyBeltXiSOo3dQDCVG3bjIqGZPEfSXfLBQ/CaqUWzLMdjBaNXD8d7JlnUWRbo2gAILhJ9hVvhY/PjqwljZUlvOlnyPrr+tH/MmpUnEQPT/SJ1EqDfQj/7ZeQM3dBraoTx5A1noIPy+CuWK62/HRKhiJrAdiUqrcoA0txyjQYiJhgbTM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:51:43.6942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db21beb-cd27-4ade-9240-08dc5edd2264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461
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

smu v14.0.1 re-used smu v14.0.0

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 3bc9662fbd28..3ad3d20830fc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -136,7 +136,7 @@ int smu_v14_0_load_microcode(struct smu_context *smu)
 		    1 & ~MP1_SMN_PUB_CTRL__LX3_RESET_MASK);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
+		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) || amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 			mp1_fw_flags = RREG32_PCIE(MP1_Public |
 						   (smnMP1_FIRMWARE_FLAGS_14_0_0 & 0xffffffff));
 		else
@@ -209,7 +209,7 @@ int smu_v14_0_check_fw_status(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t mp1_fw_flags;
 
-	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
+	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) || amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 		mp1_fw_flags = RREG32_PCIE(MP1_Public |
 					   (smnMP1_FIRMWARE_FLAGS_14_0_0 & 0xffffffff));
 	else
@@ -856,7 +856,7 @@ static int smu_v14_0_set_irq_state(struct amdgpu_device *adev,
 		// TODO
 
 		/* For MP1 SW irqs */
-		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0)) {
+		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) || amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1)) {
 			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0);
 			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 1);
 			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL_mp1_14_0_0, val);
@@ -872,7 +872,7 @@ static int smu_v14_0_set_irq_state(struct amdgpu_device *adev,
 		// TODO
 
 		/* For MP1 SW irqs */
-		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0)) {
+		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) || amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1)) {
 			val = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_mp1_14_0_0);
 			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID, 0xFE);
 			val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VALID, 0);
-- 
2.25.1

