Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66148C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3A310E53B;
	Fri, 22 Apr 2022 16:47:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F64410E540
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw/IIbKbv+Hf1GXpJCkV1Yg80XzxIdx3DQQIiSENLcIb+cDJ8fBd94ZJ/rS/qrBevr0YJ1Mf5HTk88opXHdMCW3oXYUflNO4D9Rm+e4qGMaUHwULKbe//NqyJucF1xB75R6P2y5buDH9aMRUic+IjHsVPS+7xXO6gC2dHNhszjS9nJDqs+J6bLXZgNNShS5pdTXA8+jGbM48fOocypQLljIJSMgELXnmC+DZ4HoRbH6oXHN42p+T+BrmyrdUWGMgJbLxoK0VHP3sqIT3ENODgBtBhHm6WUmBXq2gSq035NiQMBHalszBF7OeiUkVG0wEGmOPnfZ7Q1XLWc1BfDA78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whNF3Cyhs4GzKbFJbT+z0Y/TI5Aw0APVuVwgOnGANPc=;
 b=RTMtk8i2Dhi18krUZ1BjqV+S+vRwOq7gtqb1hk9KzCtwC+6PnHytQSbJMgraB6HHxh0QXB/eQGCj2YIxlLY6GYQAepF99gbB86Tde61x0qbRljo3my9xpQcK3nWXAgNySNolNuC00jKu/3HwR6pP77Bk10y4WJbHslmKIj9Ir+BFASK/jAM54eulasxLTl4hUXwMcTpvQhgAxulH1RFRgUp5Oc7c3am/3xt9eICgWntXSbY0ee3K5fv3ykT5WTexleqg5v1/LwcmrSspqn0HrIR9GXrrG7dZ84P9a2B3FGAYFtIUSCMCYhgYtZmzC7MxuQXafmTAl5xwS9Xd5yFPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whNF3Cyhs4GzKbFJbT+z0Y/TI5Aw0APVuVwgOnGANPc=;
 b=EXqxMhL0oXi+gg6giN6s+tiaWkcMb95MmgMXP7j3VPYGtvFqgU3dt+YwV+83oZdaWjr24r5W3TyQwdPveS+07kWCDOuzdiDmRgu65AkDL1uZUDduAAlEaR5DbmfedtF0Vq0R4Vjvc9rl61ulkY/pbs8gDKO5qCBppfEeIv3uNAs=
Received: from DM6PR02CA0052.namprd02.prod.outlook.com (2603:10b6:5:177::29)
 by MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 16:47:26 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::f1) by DM6PR02CA0052.outlook.office365.com
 (2603:10b6:5:177::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Fri, 22 Apr 2022 16:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:47:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:47:23 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:47:19 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/13] drm/amd/display: Remove unused integer
Date: Sat, 23 Apr 2022 00:44:55 +0800
Message-ID: <20220422164457.1755751-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03fdef71-2d69-4e44-494f-08da247fc7cc
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2941328504267929F089BE6FE6F79@MN2PR12MB2941.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8ueB31aO6dRH2lrR9YPxheOGau3ueX4Ry/gXiCmFyQAOS0GBPGvNSS6PsvrjVJ7oYZrhhMs7zxw5pES0FtbChyo6KaVi/PFNjXx+sqYU08cMC0S5SolJ+G/ksoTUy2jQH62H1U2E8KUeRzXeggYYJ+l6LDARgY1C80XnEbe28xn4+HMkfFKlSGia6MsDBRkir/au5t+CRvQa79fX6MZv2aUdBJTnfC9BkilcVa2YeiCeUxGtjUwhzhr/zaEWVfx5V2l0U408ixSTSkxl24Pl8GLse/qmqp5+FCk+CQcYF2smuLqwwxIxVaz2MLocNHcYgg7Oo6pVRPNuInluQOQdo9a/O7LBEaUfWUN6E/4kDdi4V8EL6KqEqiNf3Jw5RWHABpP8595BF1DYs4FykSq5M/+f3fPu77+UZbzR22EkudKRYUmwDFBCQ/kkaxENiB1OwY6fLjhLQlPPYY8WUtGLY/kXY4od2J1+m9ggyf8f6g0U1FwgHM/JWERye6hdd4OJjxTL3E7WbJUwW16nM8M8GTtoBRzSH1Y8Moqww7znFexaRbsU2Nm6jqTAsKnCxllMOVqjHsGdmUFBGd8TlcaQcSANka8hRFX1+eyzYpQQEhLPhIDfZjSEXFkn5D1sTeBSXoESYfLSPqObg+gu4B3/dZPsTloXrrjmp/vN24Jin9Of4gJPb5QshbLiytbFNB8rnrIXp971Sf3GoDmRsHtHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(356005)(36860700001)(86362001)(336012)(6666004)(508600001)(186003)(5660300002)(2616005)(47076005)(83380400001)(40460700003)(1076003)(8936002)(82310400005)(4744005)(36756003)(6916009)(26005)(7696005)(70206006)(316002)(81166007)(70586007)(8676002)(54906003)(2906002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:47:25.6753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fdef71-2d69-4e44-494f-08da247fc7cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2941
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

Integer no longer needed.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 78b9df776503..47b56d2a6125 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -423,7 +423,6 @@ struct dc_clocks {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	enum dcn_zstate_support_state zstate_support;
 	bool dtbclk_en;
-	int dtbclk_khz;
 #endif
 	enum dcn_pwr_state pwr_state;
 	/*
-- 
2.25.1

