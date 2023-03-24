Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAED4C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538E110E4E0;
	Fri, 24 Mar 2023 06:52:16 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2761410E4E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR6DwrMHvBNscFkAxg+f/xezpVwNYJUoMo7DktSSOjE0dabb73YWrQAHsndtUHFKTVETqK7aDrzFj1IvPZKdf9XvxVG2RSUPhM35Q567HOwZX0KKXgnzmCz2PFukbGk6FqyC1YYwAOiLMkg5ViaMjEP5nn0leo9JwzAHsV7aj8kveUEqpgcEIWjmQXrUOfYopy4PW2ZnRtDQqIhk+zmC03I53F/UAC0sv5+mGWtt3nsKzsdm3VVgsr1/wlf/TjxL7MyB/cX28iZR7hOVBQ6kCQJFIcCkBF7xjJRxjeKsPjpPW6AimAU7oPFjnj8B48NR7NlIL3Zz2cPdI4ienP+T5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFXVKv846kEfgLdlRklXYcemWjJzWq40OMJDWMHuI74=;
 b=ZpLe0xq1futpUysjHYia+8ZM410xEWLxbbG0OmRhAtHdNeKg8OEzIVBGWKU0vD+vpFG5XPV6iKFc2lAafvGi2RjMOAOJgUCHUuGTA1fm+jkYQKU/rMFnzS2GkNmqgyy2NmtRRNAFgGpDuPNfYIclhzZHKJRjC3Y8fqIiB2PlzX349n+IyLKhwaqtRFmDhf0Ss0+HbIE0Cz023HnrJSjCJvzRK+BqfLkd49xt8GVQtiR1MSOeJ5JkXaaTuzP+4HPdnqeLARC7WJYLGl7sS8CMaOSzT94bPIkvYnsgakTBOOQ2EcgwFQvsgpP7okX/cAUKFRETNeviTxEqOkCo3t/O6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFXVKv846kEfgLdlRklXYcemWjJzWq40OMJDWMHuI74=;
 b=ztVKVd/21LdSFiewBUWI1hI+JJX4bLb4T7MuUt+i2up+SqdsmPXyRyXX727sL5jqJpGrwnf3kKqWycgtEoWhCw/48MqvUEDmFV1usxLXIDcOBBgcBZ5cNWvUmFFU9jfM4/UeGI/sVFOwRmoBZKwem775uSW3HIC7t7cHsv/nBRc=
Received: from MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::22)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:52:11 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::30) by MW4P223CA0017.outlook.office365.com
 (2603:10b6:303:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 06:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 06:52:11 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:52:05 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/19] drm/amd/display: fix double memory allocation
Date: Fri, 24 Mar 2023 02:50:57 -0400
Message-ID: <20230324065111.2782-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c60e704-a26c-44b2-3102-08db2c344b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smDIIXF/lHwmQma/iOghoMdahbCqpc1FvCVXkImGZaqmKBYqjgUYeasobPObwG0Y09UY7KQIuIuKlvfTacN3fOs4LuOCwkyrinJQxNCxgYOaG93J3e5DsmtmmEfp9FTUKAfll8uTIs84Ag+iFp8HSKMxs3BuwGGFVSyOO8UW4wxLQoFrrQYnLRtGz5f2q/dLmV/djdnz5pufTuptqHJG/iQd8nRz2RVFx5L6Q1Q3GPqVFkj8mz0CpXMVuVAH8VBQOzWXn8FSn6TuC90enjDLnjIichgIg6LSI6nDGQEs9wX2lqIgGGo3bu3tbHyav3tAQsjf1RUy4PRYtWpWR5AqhonyZcKw8MurFArhotII8k5aRk6LDSPL6p5jmkAkUlVYv0S/NvJJFLWXfd9VP5yblW0x+wo1RIW2eZGuE7qX+bev5rZSy8yxHVxMX9ZZsz67s/1l3A1LMfukdaAsodcQ9mMDSawUrk6i+sVOnEhyYZZaHrbLEumJCR/i0LXm7tQUpNwVF2s4NMBEcUZEVCWuAk98I38qd7hO8I1SeG4JWYMZe0YjSLlDHjg9fHEsDwpc2k4JL8OgAwH9aHzXSALkNzsx8NTcFIf/9VOLtwDOFArUThecYD5UWrxp3tmW6Lf/qiWaytKBvOyqwzyq4Es4JRc8dVo72PZlwYz/h4Sbl208ONVo4Utw1d1Jj60bmX3wIYdkrTQvJPUuSLF7+0JsfSxkMBB7FpunuzD+65g16W8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(8936002)(6916009)(4326008)(86362001)(8676002)(41300700001)(70206006)(70586007)(54906003)(478600001)(316002)(2906002)(5660300002)(44832011)(82740400003)(40480700001)(47076005)(356005)(36860700001)(6666004)(16526019)(81166007)(26005)(336012)(186003)(82310400005)(1076003)(2616005)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:52:11.6379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c60e704-a26c-44b2-3102-08db2c344b68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, stable@vger.kernel.org,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, wayne.lin@amd.com,
 Leo Ma <Hanghong.Ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

[Why & How]
when trying to fix a nullptr dereference on VMs,
accidentally doubly allocated memory for the non VM
case. removed the extra link_srv creation since
dc_construct_ctx is called in both VM and non VM cases
Also added a proper fail check for if kzalloc fails

Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Leo Ma <Hanghong.Ma@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 40f2e174c524..52564b93f7eb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -887,7 +887,10 @@ static bool dc_construct_ctx(struct dc *dc,
 	}
 
 	dc->ctx = dc_ctx;
+
 	dc->link_srv = link_create_link_service();
+	if (!dc->link_srv)
+		return false;
 
 	return true;
 }
@@ -986,8 +989,6 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 	}
 
-	dc->link_srv = link_create_link_service();
-
 	dc->res_pool = dc_create_resource_pool(dc, init_params, dc_ctx->dce_version);
 	if (!dc->res_pool)
 		goto fail;
-- 
2.34.1

