Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381B0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B5F10ED32;
	Mon,  7 Mar 2022 05:50:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E65310ED0F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czxrbkcyyXYZFH3zxwueFBiduQmP1987k8viyQmalE8M+sHO37W+oJVBqBJP1wb0Ehx3MJpzE5bG8bkE0HQqUAuWNiwfstfIlC4tr/pol8xS036tYfP3DXr1OGmCqp89svTEDreEbPT+YgPam5ZUbqKx8HcmpZqu1L+MEvNQ2ub3Tmt55Voo0wnpkuK+8sAaATk7mPG7jAM9lsuUqkiGJ6Hp/D+x1SnxpIxGHbhctbMiITQ1G5CGtzsDvE5jdaJRkgp171gB0Az1RJY/Z/siKStuzEKKUUoUJkHLDpCUsnncs+ZmRHHgQ+ZeItc0li3g9b1Clk0iWgrw1DJdT52mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9ynmBW2NbgNT4STK2ZAZqF3hwyr5iQ9puWwNQQLtCc=;
 b=lEC6Q1XDLFJhb7L58fxJL8yRlN9E5rDkF6lOnX78r07qqGC4gbMNCOHazQ3WlmRrtH+slYtx5e9NRyZjBbWEYoc7pQ9Cc/YDMa5+lXJYsvDgSg+GMT0BrUdrUsY7gvx8yGkodOlDkwTpVDeXnLlAwgAeToKXOvclPYUbPK2CEhxkTNMBUZZGWQKHttYZxdP9COMMQIaOETCCLX5DrqdRE0SeE+HcqCxO1cET/hUR0EdxRmOUKr0b/BWzyOxneI0ai3Xs3MdjG4lMB/Qm78/5p209S01EPIMBPLjRucJ9pVw8Ajwv5mmmo+Gez6YUQ2+ELq++2dtUcwEgo7SQFZ1hlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9ynmBW2NbgNT4STK2ZAZqF3hwyr5iQ9puWwNQQLtCc=;
 b=22TIXDGvBrzq+MfnoKu4GwzyFRswuFZyKQ4Va3DY/M+xjNVD4j9/KcBUfgPvgWORPGk34zWnrVZyx5jhFW56tAhoc1/pg4y4VA/+qfY/D8N+IwGCyYP6t6YfCndyHUDcnnBTJ6fQKOUAdjXCHBV5PB/sT8kc5lJvQea5hFRlWfA=
Received: from MWHPR19CA0075.namprd19.prod.outlook.com (2603:10b6:320:1f::13)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 7 Mar
 2022 05:50:54 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::c9) by MWHPR19CA0075.outlook.office365.com
 (2603:10b6:320:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:50:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:50:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:50:52 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:50:48 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/21] drm/amd/display: add gamut coefficient set A and B
Date: Tue, 8 Mar 2022 05:09:33 +0800
Message-ID: <20220307210942.444808-11-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20af8ef0-7aba-4c38-1a61-08d9fffe7189
X-MS-TrafficTypeDiagnostic: MW4PR12MB5666:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB5666402F9A38AF63D6E602AAF5089@MW4PR12MB5666.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wv8wISLB378TtW0UKYrhRAGtiBjmiG4RaaFkwWG67ib7qA/tMrBV+sbvLocLXNdxSN54SaNdzYJXhGA/AM9znOTaWsYHz3KvXgxBFxr1mQZ1J2PydAq46mwuD0++5dr91d4PXedCzsJFfOYRiq8SeZDT5d2JUjyFtjHNK7gUW+WH7c4HzIW6W2n2aCojA3TZM3EgssgrHyRq5YzDs48q24M4oksNRP1LfPYZ4EC0XCpJb/6EVhNwYhMTretth/3K6oqMjA3nRCROvNTNmBcljFIcREOHFdmX66hqeRdIHNfdRi6vdygrZxE/j8dDxRhwngkGjhpZiG+zfF8TtVxfreeIw/IUqy+UNGxVLjBX+Q5Jmjg4dJVZtvpsQM1gZkzilwlw0j0jWLYAooLuv8Lu5EeGisv7p5+AeVelpHEAaKzuVXaktyWEZO8j+wQJdCc5MVqtnTkUD0ysk7BK4cuNLKiqt0wWc1GQjbNMvJL+c6+90ik1vNGsOtAgg1E3D1QSQF9dewjYuzSUZUKhX6O8og68P99n5qlr9xt3on+VcU2i1NgVbxuWB2ugFj9q+M2z4vEU/oDR+pLh5+YdnEjaZZh/jHdqlek/bb/C09XbodhhYX+lf4lnLqzECosWiTTcOUaaGHd6GUMybIEy2WnfP+lopJYksr2LBJq8FW7Vpjqhv/aSDIZCwyKxAXexEulR8HV1uAiQdoQQoKtYGPoc8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400004)(36860700001)(4744005)(316002)(86362001)(40460700003)(356005)(81166007)(508600001)(2906002)(70586007)(4326008)(47076005)(6916009)(8936002)(186003)(5660300002)(54906003)(26005)(2616005)(8676002)(336012)(426003)(83380400001)(1076003)(36756003)(70206006)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:50:53.8410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20af8ef0-7aba-4c38-1a61-08d9fffe7189
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Jingwen Zhu <jingwen.zhu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Jingwen Zhu <Jingwen.Zhu@github.amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jingwen Zhu <Jingwen.Zhu@github.amd.com>

[Why]
Screen shake on DCN3 night light SDR BR3.

[How]
Change the logic to use double buffer reisgter on gamut settings.

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Jingwen Zhu <jingwen.zhu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
index 387eec616162..87dbeca18984 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
@@ -408,6 +408,6 @@ void dpp3_cm_set_gamut_remap(
 			gamut_mode = 1;
 
 		//follow dcn2 approach for now - using only coefficient set A
-		program_gamut_remap(dpp, arr_reg_val, GAMUT_REMAP_COEFF);
+		program_gamut_remap(dpp, arr_reg_val, gamut_mode);
 	}
 }
-- 
2.25.1

