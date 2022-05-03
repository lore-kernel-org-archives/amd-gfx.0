Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01369C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D06C10EA10;
	Tue,  3 May 2022 20:09:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A26C10E9FA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug9b3XEoOMzxXH4V4Vmcqf9KuA5yrqPnM+h5djm9MXZE7pGMybAC6bgz2JgH38lB5XnZeWMLwYSuMPSxzuPawKvC+XxDnXRJhB0GXicYKF0f8amo634B3nnVHDDMwUJngvGAZnNN8mamKUe93lcIT4nJMowsSH0aS8gq6KBx3dh8W8scGYqQ6eKTvL04m2UKlDiVZtpxp92mXOOH3tuuUNfHi+N94f2iVjiBG8hdfrih821b21V7l/PTe2GdRrZTeA4+qiWsRSPXBTEllQWcbeh4pcN39HP3yDGAxyJ73SQmonKjifRvRMvZNQs2YSLOBhZQtutmo9pJ9wypJXc1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjF/mLNsJwxKHH3qcdl1YCJwwxpCgQ1twSfVSBc9onc=;
 b=gDKNeE2LxHTUMy6IjiqNbbYJKyQXSpUq82cVcwARPLmidEwUHKA/2nPxPsftSqp2CbdrkNunLqnzGxyQ2gg68EUoR5K6wJUOAvWxI0JNNyKj8ln6iOz9ZrjZzf8n7eLO+/PSYyi+NoPNLZ7/hTuwzs1f0IqKINLz7a7ZGxi1kW0iuNoAhy4VlVJ47aqNP48jWXHJiiuTist+d88/R9TO5mBuUZDme+9ZI6H4sdsRdqjdrxBKaI+4CWf1tjHUshgCoH1SsnVAUVYR/ncvOs9ge7itFyhmx2Etewe2HTr/4w15vtxUjRplxNhTvMIZ0pfwSzNqsLw5N1YR3JsBYBCfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjF/mLNsJwxKHH3qcdl1YCJwwxpCgQ1twSfVSBc9onc=;
 b=yXEX8jZW7q13qSTBWsoqkWQ7rA4R8R5Pf2KTphnZwdLuo7GDSp6wH74XRPXBoVG1KkjV+QE9h/RLSkkRGY3Nwx/C2SyIInztkixKdjas0r+cuSIVO2M6Sq/kdXDme0SOfyrVqL5nucQ0deT99FAnw6xvGBJoVq06a1Ldh2EJXxY=
Received: from DM6PR07CA0041.namprd07.prod.outlook.com (2603:10b6:5:74::18) by
 DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Tue, 3 May 2022 20:09:14 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::2f) by DM6PR07CA0041.outlook.office365.com
 (2603:10b6:5:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 3 May 2022 20:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable df cstate feature for SMU 13.0.0
Date: Tue, 3 May 2022 16:08:37 -0400
Message-ID: <20220503200855.1163186-7-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5d54843b-a79c-4110-ba80-08da2d40cb7e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2504C9DEDD34DA899A598169F7C09@DM5PR12MB2504.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBhAIx2Exsj63k2zSHwMVP/a6F+nBjBfLHtA5DGAlkorJ0ZMyQn2GMbv4PuHMsQWb6cCINbL8K0KHlCleSY0vNZq3o039z+cxTB+RryHpNrH+v3kbUdGBodbJsb1btnsYoge62Cb5c0m2OvMTgXMdRbVPu+QPQVGw5P5+p4W4ZPFesosswfzG8iF+foC/bw/qemJ7VvYSpOHDSYW3gMc+lAiD9L7PVx44lhF6a3ZV8LMaTZ46o6kV6ayzxQo5xFp+nOiCmBowDJo9s5K7wI6+3cocL+S1mpWI7F1BlRssrEkv/ExAHqkUp2+CtO07IltJE/THqhvIv0lMHQekoE9Kyo5N2IahAkuBAI9Lr6OHh0m9cBxldD/sr75xmkk3tliza9IAkECpU/LKMQ4ZK79EwIi2VsLMJ0uLgZv7C6G93Q2wSucp8/P7MkLGbW4pkzpEP56nyKg9RYlq0DTBw3YK8ptGqv9MplFu56S5KSQEU4ceuqimj3MzmZ+Lvd584OlxGMD0vkFqOnasRwe+fWx5y+n4SBrBSWPAKdF5al2dRqXd89mkUzGlTB28AcIAV19DwkxMagJTlHTfT4f1/J3/te63sm/DUhWDZD3g8EPfXp7il3f2A5HCcetnxdXXN04H8HA2M76DjVTyZ0p6w6B9Dz2mBsIS9nkWyODx58zn5qXvyiH3LzBPSIQ+/T2rX0CcgxSACJesptMyQxvfCr6fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(36860700001)(6916009)(86362001)(1076003)(36756003)(16526019)(26005)(186003)(508600001)(356005)(47076005)(4326008)(70586007)(2616005)(8676002)(70206006)(4744005)(81166007)(40460700003)(6666004)(7696005)(426003)(8936002)(5660300002)(336012)(316002)(54906003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:14.0489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d54843b-a79c-4110-ba80-08da2d40cb7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

As the feature is ready with 78.29.0 PMFW.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e3c31ac7a63f..74d7fa3dc00d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -223,6 +223,8 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_THROTTLERS_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FAN_CONTROL_BIT);
 
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DF_CSTATE_BIT);
+
 	return 0;
 }
 
-- 
2.35.1

