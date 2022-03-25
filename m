Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A931FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3741610E1CF;
	Fri, 25 Mar 2022 22:55:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD5D10E1CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIiHRiTglG/S2EeiOKKap0uBT97WhvXvQJCdPXfTtgtyP8UvKb6c9tSeza3IwLuvNMTqap6GjALUbAzggsMHkeQG+SJ9gbA0XKl1XfGGQr9QtLpW+rOraVH7l1sGnoNjnPobG26m3DWpgJyUgVo1dAdIHv7eH5l/CcAJYU54L1gXOB+5bN0OB9OFH8pCyiJrZxmX4GHF+trVN3MbDDHXJM2n5MbtjrmMva7ambWjlUgz0K3sFCYvYna7JPv+OxPc7mgQruqbTVHuQ5PQsw1SzvdK5+J8gfcElrCYVFGEx3dLGXB9YUHkOaOGmP/wkC9HwxqgbQnh78OZLZVfgs+fUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjoIQC8FTHSEVs1PBAOpTljvBWXi8MppVgVDJj8/SNw=;
 b=DPD88fOWZquy7kq+Bmfam+9riPAdQToTBPZ6m83Ozl9hWunQA56fjs8WHBD6GSHzIw5h6q5GULRsGFeGkvMoPn/IvKF6Ntl8xsZuBdnfNDsMMlnbTY16gdLgSGkqCEooLGOlDc6yJML46JGkCSnNN9CvYijKE6NLwP5QuIeboAyMHMt5mdeqrG0QfZAMLHlhoyEokdl87B/r6mrCM7O8a59OjVgd3u1CjFGcS9K2L6EENhK/A+Rgy7ktRBeaROCL4L7N6NVxC+EXeq/sZm2UziuBQveyaT7ByNi6xexDsO/GG2MyasHwZV95rpdX0wzScLNwAiONSyMy1AJQeLMR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjoIQC8FTHSEVs1PBAOpTljvBWXi8MppVgVDJj8/SNw=;
 b=d/ap3OdW2cSirjr+KZNjhcFKgOXmF2CDgAuvBHSKgNcZcvjjYVHJ5GTesC4XPeurTp9UrTluolm6dHPiOn5qCJ0Z8yP65YgN0FXNnPxGVHy0+99hr/LfBapVfAIEKNmfrWIIa3QQ7pqmaqV2kEb6EY/oJBCMjOcV0o9eK/qkV0Y=
Received: from MW4PR04CA0206.namprd04.prod.outlook.com (2603:10b6:303:86::31)
 by DM6PR12MB3625.namprd12.prod.outlook.com (2603:10b6:5:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 22:55:54 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::5e) by MW4PR04CA0206.outlook.office365.com
 (2603:10b6:303:86::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Fri, 25 Mar 2022 22:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:55:53 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:55:50 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Correct Slice reset calculation
Date: Fri, 25 Mar 2022 16:53:51 -0600
Message-ID: <20220325225402.469841-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89c5444f-d271-4900-ed70-08da0eb29d81
X-MS-TrafficTypeDiagnostic: DM6PR12MB3625:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3625A8BCB11A8135C23F2EBAF71A9@DM6PR12MB3625.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwpaIhe5wahE+p80/hEKSC+VDJw7yMU6BOp+LG5iJWPt7P2WhgL6MWfPT/blJB3bfgBYu78J0cQFN22LFgPkxWIUCsWVrnpAUKLzbQcXjY+HWpCUpdxdoMFx0vatfSt3EwYG+a3rmILry0k+3GLfTFRgj1IU0jLS8k2moaQ2b4eRRKBpmnIutad+qwEj6dzBipxq5ggAEciRiIS/v/VgdGJ8v6fbSLq2CG3cavAS3hmjYDexn7LgHLSiS27Tfqt03WcTPwaVV4+NOBLTtmIW6ziojBJ/duOEWHNQFcsCtUkfg1wRzXUXIo9T4NdllBJ5VfXVLRxASBD0VuiSUi5lS//i76lKAsK8ertwkz84FDXg/c6wN8EHP9Osc0BK47XLxMAf/E6f3UjM8hQazifnOClN6KCT/FBDjjL7s2stAP7ocIMGBurWw7LLPq+Oo/i83dZhvXTsy52LjAS07QoBttY3HJaGp9hsCHmgTBoXau4//J7v2cjgVC6TkpN9+IFgIgBJC7fEVogcUv6KqruHOSwKPySxk8XSO6mWReRC3HquoYnuJGBUfsP9bKRYETk1Bo4OexDeLbEpo7712VlLqxVhxps4ikHyISiMurrR/qRW3/yGamTVk4CCZF8p47I766FnHzsr/5IS8Mtt/9Mv8+GA9GFNpcHfmlUb8OngcRZAwtimV3SGnvhjBdSYPqPtLMPbQg6ZwiEEP9RPx/wBcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(83380400001)(7696005)(70206006)(36756003)(4326008)(356005)(186003)(26005)(508600001)(16526019)(40460700003)(5660300002)(8936002)(36860700001)(8676002)(47076005)(82310400004)(44832011)(2616005)(426003)(336012)(2906002)(316002)(54906003)(6916009)(86362001)(1076003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:55:53.3977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c5444f-d271-4900-ed70-08da0eb29d81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3625
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
Cc: stylon.wang@amd.com, Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Once DSC slice cannot fit pixel clock, we incorrectly
reset min slices to 0 and allow max slice to operate,
even when max slice itself cannot fit the pixel clock
properly.

[How]
Change the sequence such that we correctly determine
DSC is not possible when both min slices and max
slices cannot fit pixel clock per slice.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chris Park <Chris.Park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 9c74564cbd8d..8973d3a38f9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -864,11 +864,11 @@ static bool setup_dsc_config(
 		min_slices_h = inc_num_slices(dsc_common_caps.slice_caps, min_slices_h);
 	}
 
+	is_dsc_possible = (min_slices_h <= max_slices_h);
+
 	if (pic_width % min_slices_h != 0)
 		min_slices_h = 0; // DSC TODO: Maybe try increasing the number of slices first?
 
-	is_dsc_possible = (min_slices_h <= max_slices_h);
-
 	if (min_slices_h == 0 && max_slices_h == 0)
 		is_dsc_possible = false;
 
-- 
2.35.1

