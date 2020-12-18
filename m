Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C81AC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCDE23B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCDE23B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB5289C99;
	Fri, 18 Dec 2020 22:30:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271EB89BE8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPBSibH6M+hqSQEbOzgCyGQnHOn4zguGAPgsCe7TxNhjnbEvUKnY8U9W4/AanXQa+8iteuROMMCMbGDSJ2WXtkEscoFw+Ds1tgVD4YHusdsf6JrHtDSlSalGBOwJYxAxye281CyfP891edeBI8acWEFrJai1H3accxlOQ9LAbcCxmJV7YFgxcAsXzuyD9ev7v67/wNkXLYuPy1YLJDuzM63NlmfG1lwTYLTPtMNMrm+uFPCuCWggolp+9OQR9VAxyevsrUPUTCf8Fg9fy+MdbYBsczKjcddOEjjjSDIyDYm1G4lpzoCvNoobUn01oa6hxhyApxDBoyUQbyg/v8PJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5URX4eEh+RGiV85y1YBrkrvg6NMVRLVEu+wCsGATCec=;
 b=Rhbz8IBcpR/mbLBnltaBNAipmHtQzUHJCSeAuREb0ADhKiGhr0KCI2xEE2WbOqchDSor5li83rzOOQzifZOoWo8Ws4XGKrBUDags5QlaMM4L3oxrXaxiVj5bBDGwxcBvZZp6UceSzRq8spY2qaaxvws9jC8Kj8O4iQE2ED7ttKmKr6GZIp07t5LRhBtwl6O4RDppg+SmzHqkvTGHQCkUUKBWzzNqeDIzam9kycyHTvv3Q6HESHvD3l8ewSXCJ09c0yPTELtBRwLZQ+HtXJZ7K768RWBJqxtfjXR7mEAI6T/N7z58Lf1Gbxv94eak48kufpb8NCxBsOX22cRTmgUzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5URX4eEh+RGiV85y1YBrkrvg6NMVRLVEu+wCsGATCec=;
 b=DzHo6dC4RHjG+BR2XeQ1BN+F8BD1xX/NJ6DNVbNlyO1iC0Dc+a/cvT8JivflYyKWoI/TN606WvHGw8Sef2pxmbZlOOaBqa2A3nUCYPIIt8FfuVS3fxMXXE0zaE5VMmnBbf3YuzPjw/etcdRSnwfqohFdszVGmjIEEop+EzGi3PQ=
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by DM5PR12MB1403.namprd12.prod.outlook.com (2603:10b6:3:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 22:30:10 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::d1) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.21 via Frontend
 Transport; Fri, 18 Dec 2020 22:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:30:08 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:05 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:30:04 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: updated wm table for Renoir
Date: Fri, 18 Dec 2020 17:29:01 -0500
Message-ID: <20201218222904.393785-12-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 945c86b6-0b21-4824-83ff-08d8a3a479d8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1403:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1403EBFAD826AB478AA857D7F5C30@DM5PR12MB1403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hc77iU7ReWWP79K5A/ZwkWd8JNy7uWTebbGXK2tUi+SdpsrAhV5ziPedYyzqEH2rN+dC+vzWcg/OBNFxF1hyb6kAp/ogRXn3sprMePZMr7DGpbWFxgVviLN+Huo5VQpV4vo1V+5OUnU11xK0o/Qc3L1NlyQmsbyZhZmvgR8OA91JFBIZr6sfkh3iw1zYAJqdkXB+YYvLsvYWCdA3DWor8Pdb32mYXMw2Q1UcaQUA7eDwSftHFlGt3GhIKMZ7roBgwmDoGG5omQe1s49LY2euYYqEJeg4nR+MK7aGuuqcxJ3Xyd1v786QE39xm/C3Hg0l4T/W06BiT1ESbZy/M/oiZSRkNnvUfCLQ+h07GLB7gYxG3xlrhIbjYsbMEy+kCkLrakw27f05ETboknm2limjZiA1SdR5tL4lsdPwX6xo9pUuVCfJAaz+nDVl7k6j2XpQe7AKM7ooRDEdk8d2dyaMCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966005)(2616005)(426003)(356005)(316002)(47076004)(336012)(70206006)(6666004)(81166007)(82740400003)(8676002)(7696005)(4326008)(70586007)(15650500001)(2906002)(8936002)(36756003)(86362001)(5660300002)(6916009)(54906003)(186003)(26005)(82310400003)(83380400001)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:30:08.6692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945c86b6-0b21-4824-83ff-08d8a3a479d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1403
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
Cc: Eryk.Brol@amd.com, Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why]
For certain timings, Renoir may underflow due to sr exit  latency
being too slow.

[How]
Updated wm table for renoir.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 9aa1b63bb161..bad30217c7b4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -731,32 +731,32 @@ static struct wm_table ddr4_wm_table_rn = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 9.09,
-			.sr_enter_plus_exit_time_us = 10.14,
+			.sr_exit_time_us = 11.90,
+			.sr_enter_plus_exit_time_us = 12.80,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 11.12,
-			.sr_enter_plus_exit_time_us = 12.48,
+			.sr_exit_time_us = 13.18,
+			.sr_enter_plus_exit_time_us = 14.30,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 11.12,
-			.sr_enter_plus_exit_time_us = 12.48,
+			.sr_exit_time_us = 13.18,
+			.sr_enter_plus_exit_time_us = 14.30,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 11.12,
-			.sr_enter_plus_exit_time_us = 12.48,
+			.sr_exit_time_us = 13.18,
+			.sr_enter_plus_exit_time_us = 14.30,
 			.valid = true,
 		},
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
