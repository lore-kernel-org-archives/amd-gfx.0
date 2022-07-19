Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B35C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 09:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1422414B0A3;
	Tue, 19 Jul 2022 09:33:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6A314B0AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 09:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgsjGjzTeP4N2QOK8VNwPI6QQH9BWHz369lbPRGMC8CX/F+3nMAqCw47Tjf8Za8z4Wa9WLROWAx0LRjB/sXLSv7GGPSzwFwPDBzbi/GPWUQaYrqr8tATk7DcBBoNmk/ZaXPrc4+NXWf8gdtQcy08bfgBTEyd/o27Fugl+49KT17oRYiyaE2CqCoZTjvf4B2PM/0cD+iziEWlVROtneM57FQXgtvxjzLGUEsQ7HppW1JgTTsD6RCsJhg3kw4fL90DNP7f3XjCHkRi5isuIfLEeSjVED192K3BVUH/Q2nKb4599JH4na0cYDMQdnerJh/ZcDoYm7zaIVsGRtzJVONpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvZ9TlNP9amvNnla0e/e2CdRQI47PZ6PkLqbJKDXM/Y=;
 b=ABjB5QFPbA+WwkXlR2PbN6K98wOkiTGCAsCQvNbxUgn0+FhliHNtEDgefw3mAUa6qLBDhO939KJe/+Qoyb0JrRy4VArfKKj00uJWQjsSzCLJmu1DEG/jteNN92vIRyQU4EZGVqDTq2CMmpS3gnrhCrHzFJuTpmOlfxSiv0RPwucZ0NCjAyo2lweXwGITZtWMrUk4MTInVP4GjhcdCoM/389QBBQFHz3xKCLRPOokHqaRiR6z1+cTz/sGA7BfD6iNduhk7W5rkEdx8q71X5friqvZSotqvJAYF5FyDeFrXjdEG/xm5MBW1ODMKK3YBQo+T4a3sM6enaN/ytKIrVpj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvZ9TlNP9amvNnla0e/e2CdRQI47PZ6PkLqbJKDXM/Y=;
 b=15PTIOCvqFJYCfwU/TtvEUwj3Jm1K9JYTJ8K6n+exviN0a2aVvsT+U/5ecjwQn227AzjXFC+bb1A6mRDb5HTpY2edmZQWaNRFrxy9ouZUebse2wDIxU2gztZXSxKuLjhObyiZXdcHS8Rcq0ooPOk7xndNcGq5s5bf/N0NytT4nA=
Received: from DM6PR12CA0018.namprd12.prod.outlook.com (2603:10b6:5:1c0::31)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 09:33:20 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::35) by DM6PR12CA0018.outlook.office365.com
 (2603:10b6:5:1c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Tue, 19 Jul 2022 09:33:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 09:33:19 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 04:33:17 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amd/pm: enable GPO feature support for SMU13.0.0
Date: Tue, 19 Jul 2022 17:32:41 +0800
Message-ID: <20220719093244.27827-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1177d315-4cb6-4793-4a05-08da6969b79b
X-MS-TrafficTypeDiagnostic: PH8PR12MB7027:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVPedpmtmXtPZ6bo61zFLtWglkrFZ6BUpwxPiiewX9sNH158x2xV6c8/INMxcGfSOlj7IaJXb07ZJPKH6N6yDq4Mg6NDCI0JJE0RQQqvm7KzABQRzhCcGKZSEMcVxgqtw1aBiXK74GRL4vH3pkQ3wOetNJlStcb/8Rweo+rNMk2zTz8COqgQUhXI/E00qiNAkdODJNlhysjw+ZPWnhmOXZJK+OPIUsiGiV351uwt089Hot6+t0DziYKiPs+mY3OhMHuYYsEFaRXU7KHsowqoQ34u/OULNaGcR34XbMnSnQvKlJqnYWVn5UFjd3VFf8wXCCvqhU+fPaQ9APOuJOC0CfKfXtui2/6tXXGbW4ejMH2+A05fIfKeYp3IdfLRB9n3PqAygHZIzyuJexFbd7M+6Jxie0o/DK0FqIEdD1X62H9J77kG7osAW7y2cliY6ts05bw9+8BYIMlP6c3Iei6OnNCCeqWFPoRiFWmoBZu07C87mOcNunGTgQoD77MZzbYEQkDO4DOhGuyPc+raIBxUyR19OJX18sY1BIWtXRSKx7RRlWsbJE++026W/o0WpzOrWJVSKO61s28tJM1U7qVkdiAyYnPlbkwGLUpFivq9EISg0DlhmZM4YAh2d2TOhJJn8eJkgMbdMkLYT2TCyaapIagrkb2Z1NSafGQux/arqE9rSlXtlI7CsP3AqzfUcofLBcAW+6oOlVS1AiFpCDyI4Xs858Z2T7hSFB6u2EwYsO9xOBZHwpj6c06qBqKTajENumy0ncsOV0T8CVvVjzZk3aKS5uyztIGBs9nlVW6BEc1jizfpNS02v3wvAAQbsM82v9v7CMR+DaUjvEucjJtk2a8XVGH/29Nov6mbmC9dtEXu6DeM/ybOE4l2xh4gyJXg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(40460700003)(26005)(6916009)(41300700001)(426003)(1076003)(82310400005)(16526019)(336012)(47076005)(2616005)(186003)(36756003)(54906003)(70586007)(478600001)(36860700001)(40480700001)(2906002)(70206006)(8936002)(316002)(81166007)(86362001)(7696005)(8676002)(4326008)(5660300002)(6666004)(4744005)(44832011)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:33:19.8299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1177d315-4cb6-4793-4a05-08da6969b79b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The feature is ready with latest firmwares.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I581a7aae2618134a9d196cd383cdabf3516efec0
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index ce2fa04e3926..fe7528c83843 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -310,6 +310,8 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VR0HOT_BIT);
 
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_POWER_OPTIMIZER_BIT);
+
 	return 0;
 }
 
-- 
2.29.0

