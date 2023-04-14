Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA159C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1391110EDF0;
	Fri, 14 Apr 2023 15:55:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7773210EDED
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWJVrVExwA0NKFCt96VnCr5VkqSjzbMyb+h0K+bBsy/p7vdK4az/sbnjamLjZnEfLZHV9L/rcQDsg8ZxH8xAYIBKzKUTcz7XrJp6ciKati2CgLWMTfwE/h/urRmNcnqBZw8FcGOqTdC2IW2qnmXvvvDGRwcnugnmlk+yb2yV8b0sKnnVnH4JhCRczXk8U79ASjxMffEiOYpl4pOfWQZsPgwnH8P3Kw9dK7wMmJX3SAvz0+tsbvR5LmCc9t6BpKQNKI5YSdETfAknVcujICAhhQKYpntMitu32PtOC7mBE6OUYr481PUCv8Y8x5fpUospXa/fojJQKTnJJRy2KvRj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEfjnmMGZtIzM/OPmgFQVtmeBs7HM4CE0fb5Tjb0NQE=;
 b=bdes+iiIhzbDEQbQsCjAqvf3NcVwdmzwRfa4YDZDND5Q0tPXGkvvppy5LnkJNHRNomw2lmYv6qhwIh2vY+gYvAQ/I02nLC4/Y5R65CZHCTetOTM9zffLMsz8q4L3x+kp8v3z3PXK75HC4wuRneWiilBiwT864crwBnokhDk6ml6gENVm3hezbCY4TQKJ4RoJ/Xx4igQt0Tc64s3IRxrtjJiFnnBNs8H//HiiewNglUVX7FOc1TBtWxSNYcS3uYjesnfAse+VuyoEElGF6xcBVE4nMBK9nKrQeX8eIRzggh1QoPf/JlANFmenpmk+yMwMVcjQ0hI9a9aFmS2GQpw2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEfjnmMGZtIzM/OPmgFQVtmeBs7HM4CE0fb5Tjb0NQE=;
 b=kziOPt9inwkCBSubmKZLH+f36mgKeJ2hUw/mPfGPZ0AoMg3lM+tvegrPXV+KdcVGPdOFcUMhxDw43eM07t6rVZyINsENQMJIfH/8UPwfixR2qYyw5MPlsmYW2ZWFJB96RyVumMkVBwyueMqUIq1Y6f5i23/lBv5saxOKrX1eri8=
Received: from BN9PR03CA0208.namprd03.prod.outlook.com (2603:10b6:408:f9::33)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:08 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::bc) by BN9PR03CA0208.outlook.office365.com
 (2603:10b6:408:f9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 15:55:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:06 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 53/66] drm/amd/display: Isolate remaining FPU code in DCN32
Date: Fri, 14 Apr 2023 11:53:17 -0400
Message-ID: <20230414155330.5215-54-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c72d4f-5720-4514-aa32-08db3d009ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mc8XKfWmx4Xr2BqZ6pnu+rTk2OxWj4E2kmYcvQ9wreSoM6ID5VZE6dft6Dq7IMBnRggBg3JpC+DHJTPvVjnNnuVPbcAj8V2dlQRAQFZqVIcPkU+vnodgQElBPqn9JXvhg2D76zzIz97sg/8WcZr4WOT5LagAU7lD+JEZx6IE9nVBYyGJk66MP/JmS3YbHCjjeQ5t8uYGVczZMQxWMrG05V/5tXTdfSQvCsPx0YI4Fz5/ibAjpSPVbD5+/kH3c+X1rSy7TDK2UsTO9At3k7og8dVM5anl4RqNFub6gP/bGZjkqdXPWfZB87Ww7MNZU6T9nA0ueN/XTUMSOp0l7EB76M/AWzIBdvZBBFCDc+mGBa+vNKJO5jnO/nOyhA3JplOeRnX88NcrBx3TQFXWJyV/g0iZuhD5l0DiyGX+jrSahexuxvZQrFhtmrBBsst3HDQXVtw2mrkML1APYDuY8X4q4EdhC5TozPanFfCDw8cKYN/aZE7XXwFuIG4rS9gRPAnRmQ8+c8+e685/ad0h8Es8+aOr1c6Hjldc1X0WBCdVh7w6oqQAC1al6W1G8cp3I4daNPH0RjCTyhLTEUJ4PchragB3mFAvGP3/ot0LnzrNou1hT3yARdetqMi7OU/0uYY1pHeZ3Axlfwfxpa9XJMU5hw+yQUyX/94AXsw8jSZMw+8EZp2I76RZAV+X+kAIhS9paevzoPDsRBxwYYXp0Tec2aQrYFGJ8nuwbJ3I6Jrd24o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(186003)(26005)(16526019)(1076003)(54906003)(40480700001)(478600001)(81166007)(356005)(2906002)(8676002)(8936002)(36860700001)(83380400001)(41300700001)(426003)(5660300002)(47076005)(2616005)(336012)(82310400005)(6916009)(4326008)(316002)(70206006)(70586007)(82740400003)(86362001)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:07.7734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c72d4f-5720-4514-aa32-08db3d009ee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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
Cc: stylon.wang@amd.com, Jasdeep Dhillon <jasdeep.dhillon@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jasdeep Dhillon <jasdeep.dhillon@amd.com>

[Why]
DCN32 resource contains code that uses FPU.

[How]
Moved code into DCN32 FPU

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jasdeep Dhillon <jasdeep.dhillon@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 2f7723053042..b8a2518faecc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2881,3 +2881,9 @@ bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint
 	}
 	return vactive_found;
 }
+
+void dcn32_set_clock_limits(const struct _vcs_dpi_soc_bounding_box_st *soc_bb)
+{
+	dc_assert_fp_enabled();
+	dcn3_2_soc.clock_limits[0].dcfclk_mhz = 1200.0;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index 9a0806a0e2ef..dcf512cd3072 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -80,4 +80,6 @@ void dcn32_assign_fpo_vactive_candidate(struct dc *dc, const struct dc_state *co
 
 bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint32_t vactive_margin_req);
 
+void dcn32_set_clock_limits(const struct _vcs_dpi_soc_bounding_box_st *soc_bb);
+
 #endif
-- 
2.34.1

