Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569CDC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9AB10F47C;
	Tue,  3 May 2022 20:37:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C9310F45E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6Src1/15E1tWSaeMJ8VdNH8lnYnJsb6LgT4OwtUCoCCZQRllvQCixfUcEZ5ElaFB8EIqQA45WPslwVGVCDS0pKWlUYhCHzb3eH4IcfQGveWsDHAHkc9YXJ54KwoOktchFEHBQ0CXG6hEKpQAbe3RYw76o5ZMcKyjDUoSw4WzqwVUO42ZgiUGgqBpFlkbll5AcKVcPlLSGF3d+XjeJoJVZQGtWsmfnHx8AdachGQKXtg80/G/o1ze+y60irZK38TlPmyyQpJD8FYiJaA/yCfFZVxtZMx7VCzWD1/tLnn6P/1puLjYLcs7+nXiz8I5VFKqvkvGfbu4FsFZYB8Cdci5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2RMwTzPOccXZke8bjYKIeXG2KRECmBwJ4pYJHg8Yw8=;
 b=U+DYmtJ9PLwwWj0C/w/DKFENJmf5INf9Pj5oO3bswmbHQ4GZj3wznAsdaf/TVDBjjYsT9BRBJnscBCCrFuOaCOVV1PuY2dgUiv1lbJLcDVO1PkesP4Mr1K8qdL1hUggRobqGn3x9KJdYiGXHZRH6CoI8WdMSsBJCKJsRdeLyrPYAFJzJONo7o+Q7Iov9qFR7anB7BaqT+PUoW1YpRBrqmS/at+/qCHwY16/PT49uJi4SSjzAoife5cDQl5GI0pjKGrARAqM+GkAkuJHg7F1vksxsXLcvjRLp4MMTJObgsIshfk8IC2ltgWJOhqte9TwWjf/FqR4tcQ8CCP+92t1e1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2RMwTzPOccXZke8bjYKIeXG2KRECmBwJ4pYJHg8Yw8=;
 b=BwH9rD0CPqdNNwVZxxnIEw0SKZFEZASXhg7yIf3CXOWBSpYwGoSj2kV7ipYEmWEDOG7p0BlN7hYx07wc/AHt4C2dtoKiJ02MeTft+Taf4vgHlNgum/5fdUxAo0aYbADinflDRraowsPCDLfxw7VMDxnbYLcv9RWIA1K1Ui3UPws=
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:37:41 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::c7) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Tue, 3 May 2022 20:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:37:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/26] drm/amd/pm: add the pg_flag for athub and mmhub pg on
 smu_v13_0_7
Date: Tue, 3 May 2022 16:37:08 -0400
Message-ID: <20220503203716.1230313-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adee2b22-dc05-44d7-8f17-08da2d44c541
X-MS-TrafficTypeDiagnostic: DM6PR12MB3930:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB393093EBA3DC71D0A54071A3F7C09@DM6PR12MB3930.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Wrf3fT1AN/ML70ADRtwdFYduwZwpXZ706OftSmc08lJQsEYoMo5ktYy8hOTcFPjwToVQJCkVpU9E+7ZM55oDI9zq44CZjlrwWWJjR3E6XOExFKBuU3cRgv1Adpczn1D99O3jx8bn6kzh9N0LR39ayminI/8VGRYY+OCC1Cyj/d5K8uRVxNt/DdpWB98F5XK5Kyauhz8EWxLKvUc9cNrr++IxYoG5OiM5UJfOM1IH2HfG6qgr6BCI/N41Fgpll5Ct/rEGBbrcvB1KkN7XeYVsrTCEhAApxpbxv/qgjtMbPsLxL1WSTCfQJE1dV1UbQweEYIe5Sq8td/UhG6om8eEEfbwx9bc9L8FZMyzzz3gJ3Tv6jIuDgQNNu81cvBzgCUNafuyMc5JtbrRXej7WdHOsX0DT4N5PyOQBq3Yrn+2Kv+4nzZUAVfnXuxBe74foyLk3VHI8LNqYhVoIKCiXWx8cc6x/EdcKejVLr9dpEAP2Iqt2T4+jsdrYdbEfF4V4FiBNjhIWHKYi/xB+X6fOIyGUevDAQIAaOOz/GYN9b/CrMAg9Fe1US3jEtcMH33Gszh7Yd4YDTzhYOFcQYrbt5+ulbG0PTHlnc6H03V+QAvC9W9uJWixCFYSlXcgqS7N72bZjrQK/FAn4wGVog7PiJldzQdkLrtsXD03I9n+jkghMriLWD8a9JnNQxkKyQ5XToaCpsbR3F2GajAIczBaZ2bPPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(7696005)(26005)(426003)(6666004)(6916009)(54906003)(8936002)(5660300002)(2616005)(186003)(16526019)(508600001)(1076003)(36756003)(336012)(356005)(40460700003)(70206006)(70586007)(8676002)(4326008)(82310400005)(2906002)(81166007)(47076005)(36860700001)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:41.4905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adee2b22-dc05-44d7-8f17-08da2d44c541
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3930
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Jack Gui <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

add the pg_flag for athub and mmhub pg on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 6346a334bc76..ed7500a292d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -229,7 +229,6 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFXCLK_SPREAD_SPECTRUM_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MEM_TEMP_READ_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ATHUB_MMHUB_PG_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_DSTATE_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_MPCLK_DS_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_MPCLK_DS_BIT);
@@ -237,6 +236,9 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
 
+	if ((adev->pg_flags & AMD_PG_SUPPORT_ATHUB) &&
+	    (adev->pg_flags & AMD_PG_SUPPORT_MMHUB))
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ATHUB_MMHUB_PG_BIT);
 
 	return 0;
 }
-- 
2.35.1

