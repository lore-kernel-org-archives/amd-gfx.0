Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20765C77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80EA910EDF6;
	Fri, 14 Apr 2023 15:55:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE8210EDED
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+VGxaUgkgAaGt0SfC/6y+Yk+k4QQV+bTWUeOUM7ODH/ABoQjDSFDHCDtU9iMzrHPXdzSuuJeIuC7dbGBBtEb1vRLYCs1CHy8MPzFApmDJQK5pvDT05RfoyjcH6Xe9kl5mJ806yrJAWqMZN13MIfdGhuu7F9fO+1FeKNcpOxFTPltnp8sGGTHa4S/97ZuYBvJ9Fa338/C4EusGKVm4qFwfnjZ1JKrN4XhBawal+0sGCEtIflyElt9ufOZgcAUMvC4uT6CtsbAXT1eKY/niJ46eHk2e/hH2B31s34eFoLgiSvlU99YUdQ+76lHYg4Nsw8Dcvp2fw809Vp4gxfs69WsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azEVvl08Z1HzWmsSY2MY7jeozmnPnZzQB9eZB4jZJWQ=;
 b=OjB9bZNpHkUGTocrZ99Z0SNB3OTvQy2KRs6QXrfS2urGDIonNzfHryIK6chZYrHMoXEQ32F4YTjQycoAh2r9Ux53O8ZACl2s7N0frooB19Mcbb8MCB2Wwph4djAc60fcnnFnbT7e5Jp9nOWuItsc4MCsDlzkdRUXNsACUEKOkVdd2Am4Y27SlD3SgcnqK4p+I+xz4NAAgLe2wYM/yiFtpr+KS3wWyNZHLebBJhWJQ2DSlybEf+YeIRAvxT9Jx/cz+PfabKhyPmWzPrA73tQhbLvCk49WiC5CDOItvJ2WjmhHPZkS7wupo/KjfBaZ/quYzi9ladb0a5IQfXFiaHd6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azEVvl08Z1HzWmsSY2MY7jeozmnPnZzQB9eZB4jZJWQ=;
 b=WUs7ncn/jUcKIdlNufQM3ivyF0J7xFt2LQtJUS51ceyvy6DuQwhYtwGQDfMIw4rVBU8EFM0Vj8RcJKJVpCWrWdU8qhmy2/RouQGe2KI/dT9khcqw2UmOO/m3dNN3dGRdCaTLlXMxlN1rZLiHCt1+YMWOnw9N1PI5bT00UQN/vcQ=
Received: from BN8PR16CA0010.namprd16.prod.outlook.com (2603:10b6:408:4c::23)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:15 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::94) by BN8PR16CA0010.outlook.office365.com
 (2603:10b6:408:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:55:14 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:13 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 58/66] drm/amd/display: Adjust dmub outbox notification enable
Date: Fri, 14 Apr 2023 11:53:22 -0400
Message-ID: <20230414155330.5215-59-Qingqing.Zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ea622a-721d-4d64-a4b9-08db3d00a32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGz9oahZpXXVzsEZi+s2JMhy08UPRp3Ir+v6zF3d8NMdotPsg17otMnB9U/xg5jY/1NiH3GSpcWdUQ9h5wyZSGOGkZOcwVQoD/qC0wE5GCOC4W/QymZAgOB/OXXX0+QUktya0m3Rp4q40tO7hVdeFgNSFQMCgHNMBUzYj+e4IYR4Hutl4YoRspnmqdKgirbFPflAf+BFw6+kVuWjp3WLxGM+rYqDMrdOTNMEnulUJpX+YN6qDH4C52ClNCSeWJxExtawS40cvVZ3XgwZTHq7SvwMFMzqPyjZbrMu2mb9Gu1uPEZJ271kzGG/9EOQpJcQlbiztPQqsEWpf5d47jG0Q8nT+dQHOv7PHxcOJc5WR2xzLI1KASIEyb+9nY2MPdy7L9Xyi/ouqvTamJYJb1QdnDQLBxIN3ZiaquV0+NUj0Fan/yWGVz2IFmBU7DPRpF6CbfMvQUeZKzEDiop4Aq2C0n9Wsq1Gg6SrCs9dRHg/M0ALx6J07qn9FyXF6ytYFJrzArCs2ntZdDTWxKJXUZF8tY9b4R21f2dgMA02dvWtU5T1fu7Rswora2bbfyngxdKj9Ox0OmLzyUdz32O5yTG4ynDoav+9OLEnvJ+bJxiw8QFC0zq/HCsVWxzBjgEeQW1ftA+BSmNeMW/xGj2nt8UUPqI0WUETjIf7qDB4r4nL/3npfmBtnRxCcxj9zIBUlipPwXlG6WiX4q+UpplH9hqN5Y0Kyx++Faz9/brBOq3c7Os=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(426003)(16526019)(36860700001)(15650500001)(36756003)(5660300002)(356005)(82740400003)(2906002)(86362001)(40480700001)(8936002)(8676002)(6916009)(70206006)(70586007)(81166007)(4326008)(82310400005)(41300700001)(26005)(40460700003)(83380400001)(478600001)(336012)(2616005)(47076005)(54906003)(316002)(1076003)(186003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:14.9429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ea622a-721d-4d64-a4b9-08db3d00a32b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Meenakshikumar
 Somasundaram <meenakshikumar.somasundaram@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Currently driver enables dmub outbox notification before oubox ISR is
registered. During boot scenario, sometimes dmub issues hpd outbox
message before driver registers ISR and those messages are missed.

[How]
Enable dmub outbox notification after outbox ISR is registered. Also,
restructured outbox enable code to call from dm layer and renamed APIs.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index e0c74868d2ee..890268d95495 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -197,10 +197,6 @@ void dcn31_init_hw(struct dc *dc)
 		}
 	}
 
-	/* Enables outbox notifications for usb4 dpia */
-	if (dc->res_pool->usb4_dpia_count)
-		dmub_enable_outbox_notification(dc->ctx->dmub_srv);
-
 	/* we want to turn off all dp displays before doing detection */
 	dc->link_srv->blank_all_dp_displays(dc);
 
-- 
2.34.1

