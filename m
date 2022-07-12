Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244D8C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 14:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717DF94BE9;
	Tue, 12 Jul 2022 14:32:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1732894BF9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 14:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi9E5OKaR4RBCFk70HxsrHsOA0vL48THhPM9mt1+wZsXfEY3UvGR5wVfzAiREjsviK3kLMiLLhW+4I+F4h+wJgZm3JH+/cYMPVlD8ESFx18fXRU4yWelfGJbRkekDjcOMgdjwpy6TDzt54mShCi2Uql6urhSa3e2Syw+v+ggxvwSwGajn/R4k5U6xArwVBosAN3YJwG1GRJKn7lm/yYGIH9j/pVYTeYwOqDnPqHyqeWGpqrbbwcwm9o55C432z4nVpAc6YwspuUWxlrrY82HvR1LCXxEUClKCP+H20Wr0J3/YA/a4Xd/UXKvIUapmSnfbZkWRDO7u6i9f5F1ZsE1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHEPFrqoXpA51Fy9+muPaYqkDFbFPbcgXTsVlfH99Bo=;
 b=LrR7/lx9sQffKFFQmcXiZJAZ/yGEzaYlIrUupksVtzHXcvH3hmkt+Gzmhd8aDWlQK3COB8d9PPrVUp+Rv3vAg6CIvtfYzkSa410YGeP/+7eFT7jAiTox4h2TTPSrLPdZK+f5Muk0QEJvrxd6knOqtKME4J34b4twmHqCXLhBIfjrk2TcHowgddlauSbvL7MxFWy9nXY82V8FL8v2x2o3847EJwtwBum0OFe0bk5xNyQ/c6pDWih4QxC9RmALj4y+719PCNuwK4zQZbzeFn0Mzw05XsO5/BRF4PbY9y1PdTa9+f8gl60S8ylbjdx1WbLV+2MtJ6mTH36dHc7z1eja+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHEPFrqoXpA51Fy9+muPaYqkDFbFPbcgXTsVlfH99Bo=;
 b=osAXUcfc629OrceoK7g+h0NTVOlbPuFMeFq34HSBA3SkPH8CHOQg0rPTALMtpxhLCpnlEI1QzwpKddAGY3hI1l9f4LwmDIX1YntBG73NEOHf4y3KYR/FI4c1QajLHV880r+sh5x5ozRYHhZ3RQQadiS0yeu9uozjQqazqePw6Uk=
Received: from DS7PR03CA0110.namprd03.prod.outlook.com (2603:10b6:5:3b7::25)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Tue, 12 Jul
 2022 14:32:11 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::c2) by DS7PR03CA0110.outlook.office365.com
 (2603:10b6:5:3b7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25 via Frontend
 Transport; Tue, 12 Jul 2022 14:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.17 via Frontend Transport; Tue, 12 Jul 2022 14:32:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 09:32:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: fix comment format
Date: Tue, 12 Jul 2022 10:31:58 -0400
Message-ID: <20220712143159.2700970-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f4c85cf-3f0a-475f-4bd5-08da64134efc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgGRIdcyhUHLrjC9y1ag6iftRL85iiOxdmLiduhfgrbPvt/pRn2oA2d7nlDKh4bsBcVZy8AW0XW/ehO/QRkNCHMocu/fHjbSknVT4bN7ZVKERAq9pycgjJFqYRerXNIhzRaBCC+SdfopqtRgWweFWJ4FJ/9XCSNYLnW5IHNo89aa5xlXI7YuULlZIrUOQvgcdNdaEuQKPLEa4bi5byw6hz3iNh4hsLyJwXpVA7PBttP/6dohcxzzyYynO6lqXz0hQJJCfb5PqsebvjWfq5cLxbKafdCalzoP9zRvWgzNKi4iWpcDfvvJRHLq8Im6RXtOxAcGRCajS++5CXEwR5Oo3Wpx+0vUyUHLVM0SRZWAyl0ShXQupRhghj+D3LQRjOXgidwv3Rn5BUOOAyso/yUWsRsseLog43w6458/wJ4YAw0sKOdz+qm4YHtmGsaLNeZHKNZD2lrKWrxh8kPuyu+KqdNWAKQ4gjoLB8MBCAa423plF1xiQvVbJ1dYh+xiWretKPQzu2vlStZ6p6AAp0pt8+WsAS8QUkLx1mbEL2wVnQlAQNEFRf5Qc4VlrtuLYOjgIkdouQR9WQZDov0AjFvcqxGoCPjKygPKQsGu2jkGBYjQFgL+s12QHqC2ceoIFbam6G8uMSIB1SmwnGdsmkL/aIEn+7DDIqNP4PlcyuMJJtLsDnkVh+YHXNUqDfwdnEX4kG2hBNMOqbcX4QyeLhs2uyR+y2M9ftfCcyyiJU/M9dZ+FayYP2lnrW+wW52KGqWspl8rNGHA06i5VhSQeCMomSskEqdd8CC7EOQDJBat363HQiiYXkqG0ZEFEdXUXtrSmuH+1WxH5zv5PbPUdaKisAN7ISgylaAjdMXYxnDVN5Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(40470700004)(46966006)(47076005)(26005)(186003)(2616005)(70586007)(16526019)(1076003)(2906002)(8936002)(81166007)(82740400003)(40480700001)(86362001)(426003)(336012)(356005)(7696005)(83380400001)(316002)(82310400005)(54906003)(6916009)(478600001)(8676002)(70206006)(41300700001)(36860700001)(5660300002)(40460700003)(36756003)(6666004)(4326008)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:32:11.7722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4c85cf-3f0a-475f-4bd5-08da64134efc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is not a compliant kerneldoc comment, so make it just
a regular comment.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
index c4a5f8198209..436c3545a983 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
@@ -42,7 +42,7 @@
 #define FN(reg_name, field_name) \
 	optc1->tg_shift->field_name, optc1->tg_mask->field_name
 
-/**
+/*
  * Enable CRTC
  * Enable CRTC - call ASIC Control Object to enable Timing generator.
  */
-- 
2.35.3

