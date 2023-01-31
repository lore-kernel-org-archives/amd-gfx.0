Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3276FC636CD
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Jan 2023 18:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA5710E2CC;
	Tue, 31 Jan 2023 18:13:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A1310E2CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Jan 2023 18:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgwloDTztyFF47/vBnVnZotc5DN6VBEqO3U2ggDeeLqQN3lbjTWUW5AcCZpP3PLsPe0lDdyUK2A3RdAB5m1sgXCkJX1ofXzP5fkt945DRBRzSUlXZs00+45WZZBcIxIUiLX8t4b3f4hkU23+YGliQ2egWa7wrhWhPWkqHFF0tY+YSuYT/rnM0+j0QLVNrSyZUaQGV32hCjZEIZcEmHfBo1SSTIEI+ZT5Y+0K20YlBCw7fOW5Dx9FYpXAetFRYDu4jZopaqfGV9ywzWHOGvxBBU/6OQfdE2orPi8x1Us1uwVQN4lE+SCJ5eEvUAHbM9b5AQLTrz2UgAHQ2XfEzwFU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zD7cUC02OAIqdbmtIV1I9aZMLbD5uCCbWYQpDRJaS00=;
 b=E+MXv3j0LPrE2qKVa6xQApkUbgaAWEDdrsfMW4xNmaihluwmWdNqVPRgWF+3NGG9v+u6i6fNz+3vYKSACvQhVp0vIZY4TYDINBlRTCpjSsuiXHsNuvm4IajslXjabtDcJT6lD4ZeCR9Y4C6gZRAw5WtOxbePSxgoYYedOFmuZNplbqDiT4v4J2i8Lbyx2TVL+R2/9EiMLY1kkdI0vhlCsGV4k4x0sz5p/cWuaI9VGDEP7e7p2Bjjj2DkisN/TwYXDVD5E375VKdno3hCQMuzvAOxIp0aLRwQKv1bRSALl0ERDf4KU3+IeySEqKGUCzD3Ror2ytPHrFW+4b3xCUC5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zD7cUC02OAIqdbmtIV1I9aZMLbD5uCCbWYQpDRJaS00=;
 b=n+ZDhS0zPdnWuYdW98TAtfLaXzZfFCYD8P9sObBg/pnST9S7q5eiVyKbWFXhL10jIhRmFxXbpfSiAQCntDtJryTKjVWnx0DEGG8vgYNZHmwWQ5IU/bcfjoaKgszqz85IKbvW/jFHj6HdWEy7EP1vqjlA87KeqtOoavo8+6+zQ5o=
Received: from MW4PR04CA0328.namprd04.prod.outlook.com (2603:10b6:303:82::33)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 18:13:46 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::4c) by MW4PR04CA0328.outlook.office365.com
 (2603:10b6:303:82::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 18:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.36 via Frontend Transport; Tue, 31 Jan 2023 18:13:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 12:13:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amd/display: disable S/G display on DCN 3.1.2/3
Date: Tue, 31 Jan 2023 13:13:23 -0500
Message-ID: <20230131181326.3507396-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230131181326.3507396-1-alexander.deucher@amd.com>
References: <20230131181326.3507396-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a342ced-606a-4492-c9c8-08db03b6e481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gG0+sOR2qXE8t1E0zUu+qZRNKuoTkRpQYCKKsV9m8Wg1CPwlVoWV59yc2Ps+lWHCr9Bm7yOl7KlBfi60q0HvQfJ2KYdpSO3SFaRYKHONbDDDjG0uD5T1pQAAGyhnpsIRvHnVrKUgj2NZ38KFZZ8VIhNGXWl37ePTJbDblcwHzbulvgQ8+ZUkpQSNJj1CMptfQwEOI482dbySUWLuMSmdepO8AZhBHuxgFP2bhgKTWu14ViUq5cusyGDTOUL/p97wuLUdV88O2n4TCgBMyvq6NzE6MIaYeA7ZGk6HM2TrN4IX8xRmlt+dh2ykBr9SsYOIabmqZVNainDJhEGvm2AfMP3eHT+CXuhBxdGlU9Cl5SYA5C0dxV0xifIKOI9DzK7kUu3dSUih1Gk2/9TvYoSODmZZ9+DSwQpugwWlYpnFtgB8JXOgCO5ZhrO7YX8hQkV7Bp9InaHDbQsetrcVA7SaHn/g8mrZ5pZW5dz52+8O3UOuJcayoS+mfsE8T97Kp+m1XU8LfiYK7fjcbtAYQBqc74xeIuJeBbxSvjxE7bF+Trz0nBTPBw1sfWaRXWcIqgOjKu51Lk+3gKi5Ma675l6q03Nk/spVd2GBNYDk5QXsKyX8UFt7MIJKOPZ0xcMF2h8WSGFQJcGu6ZGJ68X4QIndl3bLGYI1qTtAWEqSinhQvv0i1LcPcQP9zvqzt4cDKLII
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(86362001)(40460700003)(70206006)(47076005)(83380400001)(82310400005)(426003)(336012)(41300700001)(6666004)(478600001)(54906003)(1076003)(316002)(26005)(5660300002)(7696005)(966005)(2616005)(186003)(16526019)(8936002)(81166007)(4326008)(40480700001)(356005)(70586007)(6916009)(36860700001)(4744005)(8676002)(82740400003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:13:45.4293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a342ced-606a-4492-c9c8-08db03b6e481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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
Cc: Alex Deucher <alexander.deucher@amd.com>, yifan1.zhang@amd.com,
 roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Causes flickering or white screens in some configurations.
Disable it for now until we can fix the issue.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2352
Cc: roman.li@amd.com
Cc: yifan1.zhang@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2e4040f1a357..1736a5488762 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1535,8 +1535,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 				init_data.flags.gpu_vm_support = true;
 			break;
 		case IP_VERSION(3, 0, 1):
-		case IP_VERSION(3, 1, 2):
-		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support = true;
 			break;
-- 
2.39.1

