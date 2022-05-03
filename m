Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A790AC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389FB10F4BF;
	Tue,  3 May 2022 20:37:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946A710F4EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAIorJyCWb+jPWay0vkT//tz9+khNq1MQF0wmdyBFMDR4QApxlLIlfi9O2nPL4JzTH1XxA6TdajdloNX21ZACIn69SxFF076gi6fL9XKoBXinj27wMEctvGQkOmf/mI73FZjpzDABBdQPGC8wr4SiNHICkhdbspQfE1JHfiV8kPv7YIEinY4Dx8cwY8ttZ0jSziV0s5nZoz5yjQrb2ydFjUSjz8U95YB3RkPs9hd1CwO1S7bsn14qbRDEKoCJr3wKkVpbzP+6ax09JE5ww1ROzGaGSNNBHjHtQzGaKeqKi392lPAVnhECmOQpICo3R2I5ysjXvWvtDat6tU4HhCfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSGE1VOz6W0C5ij3QhkMQ5fgCrB0TASsBj3NeDil4aE=;
 b=jC9Q9tYwnhXcIb9UfgY7+FOcktyUwz2YLVWBtQMrVMOsVSCy5rku00v4Rwe3ACYykMTBoD4AQApDfATOsRvo2eMbDknV0LaymNVHkMcRVu/CxYtAQsgw0MEcNYNuWsjeBFqrSLn6y8RugUIz5B0V6TG+BAApEfPPu8YpnwavXZD59+JOdqCjt85ECudy9PmbsXVuNYuhjXatO1vZgjTxeSEvBNvb/FUKGk5kv6KjuxnBCY3Qddr5Eu8NQiftwB7NwtHX0dM9bfXfT/5gs9mUIHXl5qzgjr1sFE0cgdMPf3hMg/Loy1kWGXkZmcSsq7JLtA93jTy2OZCwu+Mr3MSzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSGE1VOz6W0C5ij3QhkMQ5fgCrB0TASsBj3NeDil4aE=;
 b=zgTrux8oBRUHeBoPcLtt1uEZ/vUip2V43cZOxOEQwD1q7/ki6Z4h7d6dHKyYQvLGV2+nf+c+YYxg2b9QOYuI2Vug9MiXk+dqGQjK+hIejTJvzbZiA2bR5duCkVJrvuU/KYGjKXen4OHWWwCQoyb4axGU+1Fh7lmX6rq+U1dhc6k=
Received: from MW4PR04CA0146.namprd04.prod.outlook.com (2603:10b6:303:84::31)
 by DM5PR12MB1756.namprd12.prod.outlook.com (2603:10b6:3:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:37:44 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::da) by MW4PR04CA0146.outlook.office365.com
 (2603:10b6:303:84::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/26] drm/amd/pm: report preDS gfxclk on smu_v13_0_7
Date: Tue, 3 May 2022 16:37:16 -0400
Message-ID: <20220503203716.1230313-26-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea51458d-31cd-4aa9-9da2-08da2d44c70a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1756F9B9ACBA16E360118A94F7C09@DM5PR12MB1756.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6HOieUqqY1AFbSr2UuI9oVtBfPb4OQxtqT6z/pKgrvbAEAjZTnXhXgSLjIvbGqQgyDFWf+IbGCZ6d1+zTwKvQYCHCxV3q0uucKrgv6aUPGOPykQztIZJWwA8dBG76l9uYPrmAKDIevqbSwZ92aG7LgQBozalrCsIAOKEq+6hSpeC5DZBHeWGnCB7Hr4/9PVstSx+cHyP41vC3JNo2EW8JhOgGBvYFXSHcUIDIvVS9kcgj9wOOQZxaSg6IOzHOtNfMHPLOLRm/aj28UBwPn6T1L7IhXnP4N1v36gCTTHYmsn3kc8aaEVg+gI0oI7zWrakrxcl5AwYQ+t/MBCP/IL5WIC3GAjq4yM8qYVm9DPMqNQWrCByWL+YWuMKFCm/OM1Y4XPi7TAMmCFqdAavjTK7VcEo2URvN44CgSpw/2L5GnAl/+1wTYXnulxQXp30X6aimzuev8qvSC3iwxfsfhIeF7QYFhw9Rk3Z9A8uA03KHpHbvcq72HVnz0pOg1a045gXs97ZbuJoTR2AJ6tEGzV1GGcOKn0vdtffDVvkWwcHr0BWguSP/C7I37iOCawkwuruuwyWHazagxTrG32pYa/3EJNV9eJsESzznEYhgcPbJMR58znYJe1k07RkfSDnD79dexm8vtGci4kbm/ytpb2QYzojr6yOtvHt9pAPsGYJVrNabKVe1S1m0tK34Lnfb7/YSKbMBRqjFhPR2ARv7jFbO3ymco3K2yVHWh58hlu8dDs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(5660300002)(2906002)(83380400001)(6666004)(356005)(40460700003)(316002)(86362001)(36756003)(81166007)(82310400005)(36860700001)(6916009)(336012)(7696005)(47076005)(426003)(16526019)(2616005)(186003)(26005)(8936002)(8676002)(4326008)(70586007)(70206006)(1076003)(54906003)(40753002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:44.4703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea51458d-31cd-4aa9-9da2-08da2d44c70a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
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

report preDS gfxclk on smu_v13_0_7 to avoid the test confusion

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index eff9adad0bbe..8e576054bee5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -668,7 +668,7 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->CurrClock[PPCLK_FCLK];
 		break;
 	case METRICS_AVERAGE_GFXCLK:
-		*value = metrics->AverageGfxclkFrequencyTarget;
+		*value = metrics->AverageGfxclkFrequencyPreDs;
 		break;
 	case METRICS_AVERAGE_FCLK:
 		if (metrics->AverageUclkActivity <= SMU_13_0_7_BUSY_THRESHOLD)
-- 
2.35.1

