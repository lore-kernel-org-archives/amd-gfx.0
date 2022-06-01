Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E75C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 17:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4753F10EF76;
	Wed,  1 Jun 2022 17:10:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2DCD10EF7A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 17:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYkyLV0TIYPN1N7wrqtie7SUfFPMxgWI8zGiwFtpvlxVroFW1fn+52lPRQj92foX37eWkUhQqmlDnlEqZ1BpFNNV6lnTswuHeyKp0+cRvrm3xTSrIGTxbUkwMrelZ8W4EllA/o8W8omWK0rLc5t3AjCLcSaNLfmoQ0nYYdLzo940niZMxEyl+7YWTgBsHaTQKenpX9ViYkrHAb6HJpQhX4200X9TPGh7bAnF8bSgbleZOhIa6/6nSeCyiFAj74UHq4dsoyavrOCYJTSJN+SCwuQjpYkDg8+ojUXydEcZE6lhWSddmK4i6OB6e6zDwh0XLpQZCPPvqRFTqX4QpRXZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHZ18YW2w2lP1//UGXQKQW0NBEeehnVfZCHTVIg0CfQ=;
 b=ex9jHLtFSghZClPNuuidGPBoxeP1buZcT1wVibBwfi+McR7RDwlqjFyGwenNoQYKIyMPOLioeG/4eS/uyZwFwFKKrALsForXyd/bGsISvoo6Pfru76zX/pIc8MbdJOMaEfHKXEI3LEIiAxsNejTFYxA9mqwyznmkqRZZAE1VN06xGX9j5SHLipymVQHqxeEY0tvAjCUy2IxtPJci37habgHxEIkK3ovgoqAacOliCCr9KRn2mYuoqdm0HSNwxt4rmcIKtB9+lQEM+8kx3J++jq0aHfqyhhCPK2PiOZv3gimsvUJKgj+XuZWgGwkUqVCOKaCYnE0XuQm5J6jiB3Orxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHZ18YW2w2lP1//UGXQKQW0NBEeehnVfZCHTVIg0CfQ=;
 b=NtYss7MNO0IA4rAXKZ47rN6208UmDLWW1A6/86uE3BlKmytEcvs9EZu4PdKhlLwHF0Bk/ffJyKqaqyYSj2X4M1U0axIVaCPGeBlMhIMqg/jod2Hlw0RGmcDjAZ++5gBEdtnoedvQ8AmE2i4tdunhpmVhn+RA7L0td1yoSGfflh8=
Received: from DM5PR1401CA0005.namprd14.prod.outlook.com (2603:10b6:4:4a::15)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 17:10:30 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::41) by DM5PR1401CA0005.outlook.office365.com
 (2603:10b6:4:4a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 17:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 17:10:30 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 12:10:29 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Resolve RAS GFX error count issue v2
Date: Thu, 2 Jun 2022 01:10:05 +0800
Message-ID: <20220601171005.27106-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b3d4c25-59e5-40d7-9049-08da43f1a1ba
X-MS-TrafficTypeDiagnostic: CH2PR12MB4309:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4309A3C0872FCF63D7669BC091DF9@CH2PR12MB4309.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWAe0HEuYN87fLE2zugZ/a8RnMwWvFwmt9nHWkHBaQXBfVDJ14O6lWxVOFr02lPTC+VeIcDNf8E9oqT275lO4f27NnOMU7PWuwLV8KooWhLhLIjQaEy877w7VXxZxpqRSXUbuXxYs2hpljVqlTLjirCR6gr2e5mD7o3/3/fA70nEbgcf6LnB0uxl7uZYVPPK0ggQzbaVX2IWEe1YDPOc2mwmc58VjJMOM3e+5oyrSON0o0srj4yTUChqtG5JcslZ0qLViqsDIrkRcZnmQNE7FU7C1yxxcjUk3WPgbwzR90Flx56bnR8cagpflvDZZHa24Cpp3C77+WA+M1MHc0dl3CBo9dPnYiyUwlhkpCAlI80s33bNpt0Hj4k5aJirGzIlhhkhRFLIKIWeHu9ohCfw2EiCpUxd0Mcb6sDrdLZSl6yR9/Vb7dMOBPJOlr3G9E4uHRLtqFGQ/DLW92E6wB/2iUVmgxcdXKLTmEYLwEK/zKS3Pzk2mWSxqNQVnboW6JRPoi51guJl+TjzeLq4JIuWjpucY30UFay3xsvTt5l4zHHhg1JYVjuXxfHb6a2De9QbdHTWzTEIfaYP2RK+z4KeTbCNtKWelVv2KCmDEzkDsr1TbXRBC+H//P4VEQUF7KNYAeV5bkqrCgFKQTmds5mvkj/sS5NbcHZjtdvzUAGui8+acy/7hur/gpXaPmr/HUBXtRylC4vjlk83dqYATgwdsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(40460700003)(2616005)(426003)(47076005)(316002)(36860700001)(6666004)(7696005)(82310400005)(86362001)(36756003)(6916009)(83380400001)(26005)(2906002)(44832011)(4326008)(70586007)(8676002)(70206006)(186003)(16526019)(4744005)(5660300002)(356005)(8936002)(1076003)(508600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 17:10:30.4790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3d4c25-59e5-40d7-9049-08da43f1a1ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix misleading indentation

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 99c1a2d3dae84d..424990e1bec10c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -599,14 +599,15 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 		if (!amdgpu_persistent_edc_harvesting_supported(adev))
 			amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
 
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
+		r = amdgpu_ras_block_late_init(adev, ras_block);
+		if (r)
+			return r;
 
 		r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
 		if (r)
 			goto late_fini;
-	}
+	} else
+		amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);
 
 	return 0;
 late_fini:
-- 
2.17.1

