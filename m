Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA822C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9348E10EA3A;
	Tue,  3 May 2022 20:09:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC0C10EA33
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdQW3sRlMJz7o51BKuTeRYLNFvL6oSzABXN+Kyry16tyhkZOwZ8F67fF3TMUtkQJzRd9ndn4r8MxYOR+T1VNmXTF/sWstRXuswqIZCn/cK1QuEAzoDGRgh69QsbOpULTCBxl1tfTb5Ix7wkR3djkuliGDdc914d/QcyAAzV2Usn+u5N4+SHkm7xP4W2hdkQdKbObseuJseKxzdAtl/EU8HP53PDKAnUV4/Asn8h5v8ziqQ6EFqm6ZPLsff7v0djNxTcQrl9QPY1AgpIvcOXRmAUxTpKh0PZ0kTJ7/ChyRV/9Jund9rgM6xO5skbKa0qkC/51StrOzmGPtiOitrRe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ICWBNTYlphbpVceC0mDD/ppKksaxFUv7teh+WZ/4VI=;
 b=kd9AO868il2pwsaVzRbm98zATCFfC2GjUVfqe/mn/e3wkAJHWgVHV4UsPJhiKc0UlzOX9b/EYiSqT5mxyZsTrsKcvW5Azsa70N3zJ4KLrM3ysA3NGDjOj2zxvCPmbywXP5iecOw0WvZjYyEHYvlyV4/M83kU7agCwTc0NEA1pYdUWX434giOecXHsrOJLuBs7pM4t2gTReBP8U3FoXO01qAWfat0nzMAF0duYmz8eA8H2VVWr3RamC4Ch4YA9hje3mtyYgBIvUglBt37vYt88F19BqSFCOeNBb2wQHQ5O8xLPP2AQdeM4fhtbLZpKE82jLSOR68KpyHKJEUiKvZU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ICWBNTYlphbpVceC0mDD/ppKksaxFUv7teh+WZ/4VI=;
 b=d6xjW4MbZHaCQdFSDzqudj0hVQgKmEblEIIeVjI0zAlHSlaIZrv+NT7AK6wc+ABuR6l74g8bWdhJvk4n5q0a6dQP+p9QrcV2FKtMWT+x0BC+mBFt2+C564mCMRiKp5ObiwpQ67JrvyM5swk1B5mVkbFDEz04YghtfnCDWTYpfI8=
Received: from DM6PR06CA0062.namprd06.prod.outlook.com (2603:10b6:5:54::39) by
 DM6PR12MB3641.namprd12.prod.outlook.com (2603:10b6:5:3e::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.23; Tue, 3 May 2022 20:09:18 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::21) by DM6PR06CA0062.outlook.office365.com
 (2603:10b6:5:54::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 3 May 2022 20:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:09:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable more dpm features to pair with PMFW 78.31.0
Date: Tue, 3 May 2022 16:08:42 -0400
Message-ID: <20220503200855.1163186-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b2d1c15-bc57-4b92-0e0a-08da2d40cdce
X-MS-TrafficTypeDiagnostic: DM6PR12MB3641:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB36419E03C311356AD6414E1CF7C09@DM6PR12MB3641.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hq5nBDGNrVOGvy0qmYMfAI4FzCeI/+1jXwNlJQmMOE5WQNxidObZhVQC4yYbHRo89bEw91ZiGvDvqiJMxX7J4fzh5Jh8LgB2CZvN5jFmDpWv99AOEFpD9FsLV8D0Xxxo9Q5FiXBJf6nZ7zTIJoDq76bEcYdPgbU5Qf/kFkK3IpdCQHKb9MFq4+kPYejkFujbC3QBKOKs1sZxoReMKeydtSoNh5ga2uj7s8NZffYNebj6gIjEpwCGqTUnuQE5cM/ajmkWUJIcuXGR2GL7CoCCRogwKY3AQZFJ9DPaovbWis5sPXsO9yCNc9jr4cfhQNt5E9/cKPz94O6m/XwKiSRL2nLkPM6ZyBCknCcxszZRHni0Tfti9LZevXg3swH1+lrKBnIDD53z8i44ciHM8JH71GlKKppwFAYTcpe1/NKaI7ELH9ZIdM3j+YDi2Dk0LoAAOJ2Vsv8mYGqYLy2tcclzRkKZrsPiz12jxCaCTS60SMxYUzc3atxmlaYHymLFDHxQ1EVqt02xOfONquMe8mVUf5Of6j+5l8yptKzOF41n8mX/XNqjUArZPcUAYEk0Kcv7eh+B7yvjcJiVytdw03AE203I6Hi9WBQOaQi7NzYUtZLyYipJnkBtn4+3qaxYBGm/STviNDYKVoSGsaOPNUoIkUbYzkf5oPV2egOMFEUh7aDpLa3Ts8EVBbazEwOUmpTN0slfUljirbb3AcevsStccA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(4326008)(8676002)(6916009)(81166007)(5660300002)(82310400005)(70206006)(70586007)(8936002)(316002)(86362001)(36860700001)(40460700003)(47076005)(426003)(336012)(26005)(1076003)(186003)(16526019)(36756003)(2616005)(2906002)(356005)(508600001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:17.9242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2d1c15-bc57-4b92-0e0a-08da2d40cdce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3641
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Enables the support for DCN DPM and DCFCLK DS features.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index b410420178ae..b595497e9bf5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -250,6 +250,12 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_MPCLK_DS_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_MPCLK_DS_BIT);
 
+#if 0
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_FCLK_BIT);
+#endif
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_DCFCLK_BIT);
+
 	return 0;
 }
 
-- 
2.35.1

