Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50712C74A5B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E398910E320;
	Sat, 18 Mar 2023 07:57:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B257B10E32E
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfLfBz5121ZE0lc6AIje8Cn9OlM7NVQe0Rl1SXZyEI3NMLdgWGU6SZps4jqOgxLdmK8O9T+hzr2fTZVXi+LZgnMlogubP5ZAZRH6khWIq1pPGlTRUgrVV8ckPPHgA4uT5N5Gb5CDLOybAWPaiJo1dtEQIrj2BF99cZTD//CB/S486jrprn6xb8qeQd7oUJyxAnpIbnZoZ0baPlaqyxQc6b82X8n9n88P22GU7QP3Fu/kIxdHWZq3q2XEdI2rwHnnEEQyOBeIWXzUxaiyzfo690wdO3K5caRiUmYKLw8oCG2mcoiz7GaTzjlkq/FNTznb1jDDbXeG9vgHWsf5hVZfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaIvhj92XXM1MWyRSbaFU3aojPsh8kj0WITNDdXz3iA=;
 b=H6ZvUv9KBY1/SNpwPYduwHGCmYeHwBJpqXnOZl8l22H0GHXvp3Sn1IEdI9HchWDtpZFLcDa+5+b61tGL4dUHJ7C7xb5hyDu8Pni2ttR54lTe/2WTxK3dR5pp8G8FvuCb6eEQ8zbnPTk7qL780ULkO6BZQnsbEQ7lGs5ShiWnb8paM7M8gliMItArpmUoKBE13ZGid9RPXoRM9tcSBaAIcfN+ALmhY885yyVjiKTYAm22ReKpK/i8bqnBdgy0xhCXSrkGI60ruq8GCca85sheu959GLY8RvLCnV4kO1WWuPL9HwxFH4C8s/jdtfpct72T+SQw4lhfrZYJHNvfGuAJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaIvhj92XXM1MWyRSbaFU3aojPsh8kj0WITNDdXz3iA=;
 b=PV8tzvjmZ8/BmEl5cFD02ZBtQJZYU+T9YjW1CC28k3uilJv1+OGwASQTi2WVOzLNdPdV097Yssqms4iZDMU7xG8jAkmcGRtyF9DacJYG75oOdLCBTsntaNmAns4RdBP2kybN5li2IG09zEFMwJb7/b4wi+RN4z8jEPAmqSoe4KY=
Received: from BN1PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:e1::21)
 by DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 07:57:16 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::89) by BN1PR12CA0016.outlook.office365.com
 (2603:10b6:408:e1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.10 via Frontend Transport; Sat, 18 Mar 2023 07:57:15 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:57:11 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/19] drm/amd/display: initialize link_srv in virtual env
Date: Sat, 18 Mar 2023 03:56:04 -0400
Message-ID: <20230318075615.2630-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|DM6PR12MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 367a5e53-31dd-41a7-12f8-08db278663d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eY0oW7MNQJH01NOi40P4f3QD+b/hmaxcTMsVXvXrS45sdgfp19IIqk1d5m2J6ZCanRGtdvtrd4H9ySiluKckOn6GjGyPljdh21t6PcSQk+S82HUiafBvh10Yq2y82sDrJuj9CYuWgyONrGpW+3j7krnxKHeZTLEPoVZu8Qb+HINJZMI9H0e4ViElXrl3ZcQ5YGkTY8jF6NQtvtQBaNELNzL3o+cYjGsLAbGLpg8c/kQK815FExmOnjlmdDSGekBaCd1OOwS248i59DqOWIJr0/kQi4gMdwyLw8fEpNVYFsYPSCL4cgSpKtMYQYpcZtxHB7nawhwE1rvWwB4cHJAHJhTTCuq3ymPaJa9d34c7+eebhhs/oVn2t6z1J1+yr37zQKz2KMShjbKyBtVA883+/taD9upi1aFW8gm8XYiCSyYWJXOlGhFTHmUYI9QKW7/me7MZsNXtv4Hb+qLV8UIBPtnPFNzD791BjypM4+Bt2I/W7Tow+3AK8QdZSda0w5Xz7aQ1Q/9FElL2wf5X0UngHvgTjBOhldrMPNGna65OWssNlVg1+0lJtdn+WgiZWn1JgSqyICpKDE5luaKsEhIuP6mskTWV0PAIQcTJcTLFaDInzNbDUtG9EFFbbSX0Lmdt8ZRMD+XHAnlCk53nEr6RYBydJrm+ez6esgckK6Q/zxtsS+wbKibhnMxEQiO8Dephpm91MU5xsFr2stEklMHTZj0wUGaG7c+Bzs7jlw+D7vQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(2616005)(1076003)(26005)(16526019)(6666004)(336012)(47076005)(426003)(186003)(316002)(8676002)(4326008)(70586007)(70206006)(54906003)(478600001)(44832011)(4744005)(81166007)(36860700001)(41300700001)(82740400003)(8936002)(2906002)(5660300002)(6916009)(356005)(40460700003)(86362001)(82310400005)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:57:15.6728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367a5e53-31dd-41a7-12f8-08db278663d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4545
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Leo Ma <hanghong.ma@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

[why]
when refactoring to link_srv, we did not include the
virtual environment case where dc_construct_ctx gets
called instead of dc_construct

[how]
add initialize link_srv to dc_construct_ctx as well

Reviewed-by: Leo Ma <hanghong.ma@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ae5f1b7b4fef..dc67256f565d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -887,6 +887,7 @@ static bool dc_construct_ctx(struct dc *dc,
 	}
 
 	dc->ctx = dc_ctx;
+	dc->link_srv = link_create_link_service();
 
 	return true;
 }
-- 
2.34.1

