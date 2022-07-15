Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C4CC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B98510E2F5;
	Sat, 16 Jul 2022 14:35:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1247610E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU6+JplaXzYOmmyZ+Mp2ATydIk5r5a6ykgX3ERmLB/B70/HND39213EvMiN6V00pc8MlzVu3FZdvc59X43QmNyz5g/64+WIeNR/T+HTXrnbvs3P4VcOOu5ha4nVXezyWhM/GsmaitCtNhnaYMSsEXgqNAqovDnqXvsWZOeoieJkj226XLzErpWMNHfbVXrNg4zevpF9rEAkE7YW7cHI3ipx4DOidJTStpprcsXmvGqqX1FcqsSOG6XdC5So9/DpVbNngvbHw8MsJlV6ziNt+fIhER2wSRCQ5S/JNAXZ6XrjT8iR4ZF83Tk90fyrJHdm/mnmbB0Olb23ZE/t5OQNfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNoDpQopWnYQu5eRU45rhZO8OgQuQc7awhx3gTjUsOc=;
 b=mkAXeo4LyLF5I35AQTr6sCeGZCRV2lmM6WK3xeFwzc8rEogpXrKlnS/D2K15+v7+/PwmnlVOmSY4m2R3KUrV5ChdeFJRdyseQ37Wv6sx1AhNeL/ONBRrMro7rbLSUp6W9qa8aUPknoQA80PcF75n/EHFclRZNuZld0WVIRR4VpPl4Z2GPEEZ0i0dCBn2XG2UmFMsczXqfkaj1IgPIRMN88sybwy2NoYo9cg/YPaljqstAcbLMfNqvWdMP7wviz6m5D0GQ+5c0cyLcJCt1dUPkXMgW6sS9KmCXz1HQMT34rkW9AYZV6vM3ssnNOTT9S/gcSYikVaz5fIja+6Go09pnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNoDpQopWnYQu5eRU45rhZO8OgQuQc7awhx3gTjUsOc=;
 b=v6XtNQj9hRIdpotp4jaFRvbSB6nUXjhqS4YgTDQ8Z6jUxlLlKPO25EPBP7lVAq09vGwMDOYcoKxxVqJq10wog2BDKv4NjpAE5Fi77aXLvUb3oFCh0b/x8RcfxVGkQWj7dpogSoNGPyS+X5lCN7zKj81AkxWqSULyQPRqD73npk0=
Received: from MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::28)
 by MWHPR12MB1374.namprd12.prod.outlook.com (2603:10b6:300:12::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 18:17:45 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::1) by MW4P222CA0023.outlook.office365.com
 (2603:10b6:303:114::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:43 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:42 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/31] drm/amd/display: Loop through all pipes for DET
 allocation
Date: Fri, 15 Jul 2022 14:16:49 -0400
Message-ID: <20220715181705.1030401-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c632992-02ea-49ef-f4d2-08da668e50c9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1374:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgpYjdgszzj4qaN5schoz16j8BhR2fjMhVuxVfSGfLq0Ujc/ZG48aMyiXO2DKkNsHIhpnAwe7kPJrppvAIPV/m5HUxvgukWctDE6ePJsSAMQgDa6OGho3OVgtgugDBuqqjF2Xmqx5QIqhhEFCWedE3afqTxKc4b4Tnx8HDxxaarn+1avzwTjFpeKrttrigJav5udIKNBJwIjZhhSsl8VhObDSAUOlL6EAZSwjI/Nvicnb+QQpKbQtGjoOTFcTwev4cuonajklTccTgw3MbCcUSXfV01VIM5Gg1XqIQqm7rV4QdsE9qZZLUw0v9bLWGWA4euba0gS4Vg30Cnd9r3J2/sDhR5PV3/mDPyTmQCXvQGnGDqDknFV+VTcg1/XImtfzIWqiI3Sq9AuURGSJjdLKXI5sZuYFu0Gh1gzTF4j5r5Iqb8GrMYXYhmHkAj6PG+Y9aN9nGQ4trSufStjlXvsHrXXMIZefwt+GKWX29lXi1zuAmVQj109gfNErOIjiUvLwqhsMxeikZrEwvdxbrhLQmDtd8IicFDPY3CXY6SzAdTAA2NdC409mDloWKPKuyjdz3qxeeKQDxf0u3IhNUyMLdOgA8Q+xAT/CheKSMG6m6fj8Wae77/7Oly/YNJS6DzHR5EHoDeQI7Scm6YjmYtS2ZtkBYlxDLDJfP1eh/lPdwv4OWna8a6UlZFrAw9/GjImXfblOvWv2epNIbnhoBs0153nVdbNMNch7XYRxLSwZx6ZUA34GP7uxd8byYqqyNecSNvqaxvQ0ri8OJpQcMoEG9iZl9xF9slx2SMw7NohOjDnmDiSRL2b8Ld0n4Ybzvq6SxON2hMVpSh6GVj63swphJJ5H5ee9+QuWuoXGGwZaw0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(40470700004)(36840700001)(46966006)(40480700001)(82310400005)(2906002)(36756003)(8936002)(5660300002)(70586007)(70206006)(4326008)(40460700003)(54906003)(316002)(8676002)(6916009)(26005)(186003)(41300700001)(426003)(81166007)(478600001)(47076005)(36860700001)(1076003)(86362001)(336012)(2616005)(356005)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:45.1273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c632992-02ea-49ef-f4d2-08da668e50c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1374
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
There are cases where the pipes populated are not all at the top
of the pipes list under context. Loop through all pipes for DET
allocation instead of just the number of populated ones, even if
some unpopulated pipes are iterated through unnecessarily.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 0cb44ea9753b..32da47e24839 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -3068,7 +3068,7 @@ int dcn32_populate_dml_pipes_from_context(
 			}
 		}
 	} else
-		dcn32_determine_det_override(context, pipes, is_pipe_split_expected, pipe_cnt);
+		dcn32_determine_det_override(context, pipes, is_pipe_split_expected, dc->res_pool->pipe_count);
 
 	// In general cases we want to keep the dram clock change requirement
 	// (prefer configs that support MCLK switch). Only override to false
-- 
2.37.0

