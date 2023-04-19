Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324F9C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 09:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6CF10E8F7;
	Wed, 19 Apr 2023 09:35:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D17210E8FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 09:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaFEXS2GjcRHDV4f6S5t6dNuiqtvDweZUaEdR831nvvBhFthAps9YTJy8B5Vsi0zzNIuMsALQuyRnlP3dOdL5Sj7V+tNsMlTHZFNAiVpg1TGfLrQ9MEmc4wkiCCmp7XKMcl9TqceCYv/MaLPpPzyqwBWgLvqzxSyELGkGrDytPKgDkm+yJTqm+M1mCPDZ3iDcFS5wNcr2PAaOm41yNtLotlrRfh5timkRZ+zUCDvLpPgSsYLDNwH4JVEyVZi8UuKCfu2MKcBot4x4QrXHgAIkbFwGYUZHGeBg+Vb8mQUNdeG6Q879UK+nSwcYsZ4CcQQmrIsWIirDnkoAE+Rc7ilWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3mAVovV2Q4S9evRgpVwRb7A+Fi2+mhxR5fWrVNhPbk=;
 b=W2asCTOsZ+jofeYoUVSCIfwfMj8y05cqT6poL6WaSxzbNtQTztCEcxW07Pne/krru9KKAos0Vt1RY76oLS0D1lF+TlL38IrRnCtpP6k5jgv58vw1VqxyMNYKNpwOeGxCV6cd9zV/kLJyWjr5T8r76kTaGQTjNPGW24gIKgzlS/0N/H0LPtjEZzjNU3bQJ47JR/CxZVpy0cHZw6KNk5N5RqPpijXKGy4pi+9hlYtireEUgVxlJ7SOVcyZIBQDad4Y8eRs2Dqse52rAa/SLZUdBezedNwdqQZrtUWCtxrzpIBEb17P6Z5QCdpw5ADd3fAZH6R0vtNiCP3x3tiEWMbjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3mAVovV2Q4S9evRgpVwRb7A+Fi2+mhxR5fWrVNhPbk=;
 b=0EHW/dRkve0yEWdJOI3HqHktafx0Zj4ypSVoMpNGoCm4FWm6U011okNgWJOKg76I3mlTfLH/w6lgPWluNH9Ndv/933hTaWpVZrxsEqc74zMim1Bb+m1nwv2j/YolNfRuedylXiug+BKwOHOqJOzr01N/LKy8E3XQ7niAHkZb14g=
Received: from DM6PR18CA0027.namprd18.prod.outlook.com (2603:10b6:5:15b::40)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 09:35:04 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::82) by DM6PR18CA0027.outlook.office365.com
 (2603:10b6:5:15b::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Wed, 19 Apr 2023 09:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 09:35:03 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 19 Apr
 2023 04:35:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix spaces in array indexing and indentations
 in amdgpu_kms.c
Date: Wed, 19 Apr 2023 15:04:45 +0530
Message-ID: <20230419093445.4168345-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e72e44-8f21-42a0-f48a-08db40b95a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyvrvf59otuN1axs2kXDS1jna1fIU3S2XYBcOoUAdR3FHaTX0JzJ1D8jXcn73XP9iGqcy/xYa8KmJJ0XrF1UmP1UakU0tUSJ0iW5oXms4k+12RMkRBhr53OksCKI9oXbskD2pTNxktU46K48Tj0XrHGWMcJJbHtPmkYigpKBXk8cw2jMM6uZ8HHZV8Gcs3ZGBhg9b0ahDCZCWq9Liz7V0Zq7FPfoARS/agMAeC6PEAwgBbIvXpn5E5rHNQpqv6fl8VF9HlyUNbRujub3KGTshr9xCmU8aZo9p6gMtA0IIvF6BlO3/k3d0njl5yVBAtLriSvM0flvBlXH9M0W8r51LB4EwY4e3AgS6RO8ErJDPPow0yvM4SGAkxhF8430gIvFhRG7kLpP9kWW0gFS78gr/oEpK8tTq2Zc1p/aICAuRkzXjOPie1OaZZtXexviWmKwjWjjGmE6k1gCER47yP6qpg7dcs1n+ty2UmDKtcr7a8S7OnGyt8k7Sx54YdNZPkj+TOcjQI9RMpkJxiGKNYddkIQMmZIOa3+ZodGMGu6MH15zt9C1cCg5aUmLpWSkRd4Y0b62ZM2XNTTysUW74lTfN5NctoEb+Up+IQXfdda9rDezdB88GlpdPir0KG7dloP0r1KO4mjeDKsUSolMuPHiSOq/rdFCNXHrc0xFn2gzTWmyjzunJX4zo3vSAweFA/ybyx5xXK8rmpRomUOW1xa3EHk+mNSwGaAScA49RkMpJaI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(44832011)(2616005)(36860700001)(40460700003)(478600001)(82310400005)(6666004)(86362001)(1076003)(26005)(7696005)(36756003)(186003)(16526019)(40480700001)(336012)(426003)(41300700001)(81166007)(82740400003)(54906003)(356005)(8676002)(8936002)(47076005)(4326008)(110136005)(83380400001)(70586007)(70206006)(316002)(6636002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 09:35:03.4983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e72e44-8f21-42a0-f48a-08db40b95a92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited before open square bracket '['
+#define TA_FW_NAME(type) [TA_FW_TYPE_PSP_##type] = #type

ERROR: code indent should use tabs where possible
+        query_fw.fw_type = AMDGPU_INFO_FW_GFX_RLCV;$

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 1a2e342af1c0..a5bae7eb993a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1458,7 +1458,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	int ret, i;
 
 	static const char *ta_fw_name[TA_FW_TYPE_MAX_INDEX] = {
-#define TA_FW_NAME(type) [TA_FW_TYPE_PSP_##type] = #type
+#define TA_FW_NAME(type)[TA_FW_TYPE_PSP_##type] = #type
 		TA_FW_NAME(XGMI),
 		TA_FW_NAME(RAS),
 		TA_FW_NAME(HDCP),
@@ -1557,7 +1557,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 		   fw_info.feature, fw_info.ver);
 
 	/* RLCV */
-        query_fw.fw_type = AMDGPU_INFO_FW_GFX_RLCV;
+	query_fw.fw_type = AMDGPU_INFO_FW_GFX_RLCV;
 	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 	if (ret)
 		return ret;
-- 
2.25.1

