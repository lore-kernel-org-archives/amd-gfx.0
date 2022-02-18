Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21164C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857CE10EEB5;
	Fri, 18 Feb 2022 15:04:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE7D10EEA2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8vv5JIk/dYKcZzFdmIE+A/I57WlbgE7eOxfnvsJ97eyv6u8huaZU1j4/s8Ezo2ySiILCo77bZas4pOix0YKmcZAo1ubMlY14u8hBE0aYxgtT16el07m1yvKRlb5KNxoTu3mVeIPvow8+DiyZdueTfvIBaMu406831hMuMUuSEEk50fRF9H6mcTExk/KK/mnLadUnvdm5K65NvYFyBWASk6I1fhgVKTBO/DQjS6wdPYEREGFw2Y+pofiwDgGPQOdNIydDcgp3m1yNneS1LRL0kNhpNlLp6hZN3HsfRyg9LyJkQ9tcMcs5AzXJtMFhzFhiUyboSEhb9zF5jyhedMCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flLrSikf4K5LkFsa+lE0JuTy9ELVijIUQ2Mw/MxAypw=;
 b=eyoEq0kiGydkW1Bl5f4TXEEVwYqN1h8JtCXZ6Dw3WdLQYZ/s11v9SigvE/QhhSvJ8km2nYst89lNcm9yka7APO7iBsg+mg9fo8u3meVluNv40jrYJOFx/OjmAsMBKZrK+NKMz07zm/gF1BH0vEVPFVomUgJQPxZXUC0gJMs85cXiuat0J5NiY2QU0+nOz3hCQsdt+StBfBK5LYo8VP1gsckq2Mq9wkgEf6GryV/0tNV6XXe+QqBHkjQtvHZ8mGFyvxz34nhqqeayus9iMa0WUJwa1KyOHDeAj1LyrsQVaPDdoMBvhzsVwRXqwVaeweQyL78B3WnKw23z7qP5sQHtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flLrSikf4K5LkFsa+lE0JuTy9ELVijIUQ2Mw/MxAypw=;
 b=zjKCSNMUcDcBlmYs1XkKzo45t5aF1JzaA44s1PIEcya5t+aLbQ5NzpHFkCYQhQe2HlWqP2b9ubXQqa9uIj/6kdprP4KePEZmsj4k43DXsC5upCXwotz5fV0BfU++/G6hRIXkMrT8oRGflTayi8xGSHXRFVMX6xrbp/QTfkiKaEg=
Received: from DM5PR16CA0013.namprd16.prod.outlook.com (2603:10b6:3:c0::23) by
 MN2PR12MB3664.namprd12.prod.outlook.com (2603:10b6:208:159::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 15:04:12 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::61) by DM5PR16CA0013.outlook.office365.com
 (2603:10b6:3:c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.23 via Frontend
 Transport; Fri, 18 Feb 2022 15:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:04:12 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:04:06 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/display: lock/un-lock cursor if odm pipe split
 used
Date: Fri, 18 Feb 2022 23:03:19 +0800
Message-ID: <20220218150329.7976-3-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9446d148-5250-4b29-c5a9-08d9f2efec23
X-MS-TrafficTypeDiagnostic: MN2PR12MB3664:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36647E25AD2E758FA380B15997379@MN2PR12MB3664.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jt+ABVj+qzd3d+VHIF9oba1XYoLQ9Nq9S9cvvRvGvEljRaDUfVK39lNLJZ67jjzr1OdV4/i6prap5ML1elQcagTxs/k0WXFWQUXNgXcP+nDQu4O6zanl+5CK3/Lyn+XqFELq+5jbmKhuoCIKvzbH+BwquSJ51Q25ksEBPLZN/1/OHZyyDtoTgtAwCVHBiYLzACnb/XZ9bsC4asIUYezNUG2XJRQv8C+kOUw8jCD3UxZT6mkJSCmv8V30KKNlEQ8yTs7Po2o+QHbOaQU0uiQyfxJHpZZoUohQPimLnlx2PGIzE6tPXhdlR8Ilj2TsfkFPBdSQ3rcMhDE6iiMMVnOWEveQjvCIVFFZkI6A7WAUTboVKFym1Ns2/8eqVX1gRO7bAoU3ne70HjdcPbfmjx3AQw/hfjk6+MIsOjL05OhPdhfnCjutu4ZnmRX6pFJE1szlNjzxmfXWykjA3olIOlgF6kHVVdGnuPkt6vGd/ny7Sg9IeR77WG6D1Uc4u/DYHTWAIq+hoBwZmcQoUO7PrGz/xId4HvSeH3hq9Qweyudmnw2mlUkbWK4YahsEV5/3ZC37RobKmRiNAuSNXCgGtRBo1SwcJr0DdGLv6p3qM10KQCP8onjVBRpfZ6I5o9j6kA/JCAp5rprYAK1ZUiC7A9DbQHB6STYkE9hL6qbSceZp/pxsE6Ai9hcD19IEsOUYFRXyrqOSTkHefKmfMUupfn7/tQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(316002)(54906003)(6916009)(47076005)(86362001)(81166007)(36756003)(356005)(2906002)(82310400004)(5660300002)(1076003)(336012)(426003)(508600001)(4326008)(8676002)(2616005)(70206006)(83380400001)(6666004)(26005)(186003)(7696005)(8936002)(44832011)(16526019)(40460700003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:04:12.1415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9446d148-5250-4b29-c5a9-08d9f2efec23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3664
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Paul Hsieh <paul.hsieh@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
When system resume from sleep, the cursor lock will be reset
to default(lock status). And the cursor programming sequence
doesn't consider about odm pipe split cause cursor can't be
enabled.

[How]
If odm pipe split has been used, lock/un-lock on each pipes.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 263f9891ecbc..dc5fd27b031a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -273,6 +273,8 @@ static void program_cursor_attributes(
 		if (!pipe_to_program) {
 			pipe_to_program = pipe_ctx;
 			dc->hwss.cursor_lock(dc, pipe_to_program, true);
+			if (pipe_to_program->next_odm_pipe)
+				dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, true);
 		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
@@ -280,8 +282,11 @@ static void program_cursor_attributes(
 			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
 	}
 
-	if (pipe_to_program)
+	if (pipe_to_program) {
 		dc->hwss.cursor_lock(dc, pipe_to_program, false);
+		if (pipe_to_program->next_odm_pipe)
+			dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, false);
+	}
 }
 
 #ifndef TRIM_FSFT
-- 
2.25.1

