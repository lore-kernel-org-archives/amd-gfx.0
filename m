Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E70AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C8061041
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02C8061041
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D4B6EDDF;
	Fri, 15 Oct 2021 18:44:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EE86EDCA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUquxQ4MlxLWcW+RG5YXTUvHST9JU6qexa59DmVZw0EYRR1k404ISJEgGhLmoMWWAnuGEdi+Cou5L5y9BGnyIb77PsPmzE3JvJcpGf+Jima5y0/fRs5JhZR269kM3i+L110XZvBNbsDQSsDGmXE0I05BBgn8XRCsKK4bOyOXJBmk7EQw5gswN54aQ0CzZUAc+jxlX/c8fka5d5x6T5nVDerEm65+9jW/41kVL4L07wSHThW2gGodtqRzKHhA6qcIHPC6CTAn9iG4B38QMBB9xfkKyi/hK+i71q4/MntDaw05gCOhWpBAoKcd8Ba9bPCfhJuFTG1T/MkyLJuhn7x5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TistD9zLrpwzzlC5sZZfX25ezc/clCibxeviYP2gwxs=;
 b=ECzbFVftUQEOnL9T7nOWU88kZXVuRA7jvq3aE9Xk5xUoqyRVV8TU14lm51TSQ5dCVq9P0z6Blf5vShc2nc0Lx7h+EgqBR4gSxMIiFooItvUbBJZyha0hvZbzOpzDKVOU1bwzEjGqBh0MkWBEm59ANWiBnyJoyrW/7alWH8JmKQvwsxIxX1WjVQykEYecqDXoiv5wj+rD4GAVONCRLd2Xp/ZIt/JnO/uQTnk0bam5ARpND9LdYnSt1Di5i5hwAQQdAKyHNM7/Z7dEfYwlFGZWruXGCDeYNvZERdD1ldDhPqO7GX+9oIFOwrcjiF6ZJYcylV8GJjtwdcfuRp3ytmIjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TistD9zLrpwzzlC5sZZfX25ezc/clCibxeviYP2gwxs=;
 b=fkhw9wE4HCLCMENUH0LyS91UbzJny7MoaqjoU2AfRasSpeyheDc4CfOvNyp2e6rY+nmfatB3cWK4LXpgD8wGw2U1UOGaxbkXbtusqsZD7pSSBbkBXWudTPueJwkclwLlRpKJlr8Sk4tcDaQvB96jq+NzGqXHkIugTm0Sfnpixzo=
Received: from DS7PR06CA0054.namprd06.prod.outlook.com (2603:10b6:8:54::34) by
 CH0PR12MB5060.namprd12.prod.outlook.com (2603:10b6:610:e3::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 18:44:04 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::fe) by DS7PR06CA0054.outlook.office365.com
 (2603:10b6:8:54::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:03 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:01 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Dmytro Laktyushkin
 <Dmytro.Laktyushkin@amd.com>
Subject: [PATCH 15/27] drm/amd/display: Require immediate flip support for
 DCN3.1 planes
Date: Fri, 15 Oct 2021 14:43:20 -0400
Message-ID: <20211015184332.221091-16-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44c4f3a4-9547-48de-a1b8-08d9900bc2f9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5060:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5060A36433EBF881035E8148F5B99@CH0PR12MB5060.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qe5h20Tc0tE/qrDZMzRX9jgnX60VC7Q4JmhvYUwJ6iVIHYQGLkLbxG4Z/7D6B3M0y/K7HEJhYai6PFJxEPw7eAN5RQkKgCuXxOhXH4bfYrfKlJZGXb+faHIfeIVdQlAMN9C/9HB4ZnCy6tuGqYvqV3fO6lwGn9y11tl1THh4C0mSxuQn8TGJ9T1+BGnCOrWXJGwWBo5jal1etVrPYNBrffbFuB45WhshYlmFvgedRCCH0YAN01jXHtkKmj8+ttenEIoiI3pKr5LQYZtJmvkEp9uXCjLap881sVg/uCFiJKf82edPV/1U6+Oqw29yq0Ktkny9NHSAFbA62cUeEfVWghKn4wo9Kzt0qrDwoBXvuQKf1G5RuHwtSxxPox1u2Bi9jPzWAHKRSGcQnHbC76sxXyh3dSzYGd2rYxBjzeaZgp4dazV66FUKmC4W/zo4QjaPE4KVAeZun1P94+89I78s4HNHNcPMc0JRqgqRP4DDtQjQXTduoObdaaG72vsHWFBIDLYCSyvOJx/at7XCSvUlD5GeZsoGDrmo/Dbu+Z3HlCwtS6u7STGOnPz6wmzXL3kecelUz30foO8mLKwp8Hot/TvMdM2CHQ4Gcf+6l51N5ekcuIbbHUMiIrSDh6mS2O7VvQtAKv33iHaZTbe+lvtq7tuCw5OnyZRfqyqt8/vmjhlwXbjoNOJLJ1jTmMyrDb+nAixPr8J+xTaSgYusvnfcAVll9xhL4nSAoAcOU0YCIHfBUpqLJO1pJBpHUgYXteWgt+M1/SlU4BOT151jsx8h7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(426003)(36860700001)(508600001)(16526019)(1076003)(54906003)(86362001)(83380400001)(336012)(44832011)(81166007)(316002)(70586007)(8676002)(6666004)(4326008)(36756003)(186003)(5660300002)(2906002)(82310400003)(26005)(2616005)(47076005)(70206006)(8936002)(356005)(14773001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:03.8996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c4f3a4-9547-48de-a1b8-08d9900bc2f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5060
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Immediate flip can be enabled dynamically and has higher BW requirements
when validating which voltage mode to use.

If we validate when it's not set then potentially DCFCLK will be too low
and we will underflow.

[How]
DM always requires support so always require it as part of DML input
parameters.

This can't be enabled unconditionally on older ASIC because it blocks
some expected modes so only target DCN3.1 for now.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index a2e40405c97d..c9d3d691f4c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1778,6 +1778,13 @@ static int dcn31_populate_dml_pipes_from_context(
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
+		/*
+		 * Immediate flip can be set dynamically after enabling the plane.
+		 * We need to require support for immediate flip or underflow can be
+		 * intermittently experienced depending on peak b/w requirements.
+		 */
+		pipes[pipe_cnt].pipe.src.immediate_flip = true;
+
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
 		pipes[pipe_cnt].pipe.src.gpuvm = true;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
-- 
2.25.1

