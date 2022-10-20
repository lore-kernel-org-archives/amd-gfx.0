Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A485C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F2810E4EC;
	Thu, 20 Oct 2022 15:48:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A6310E160
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFG7wV7U/6QKmlvfnJqz76NUde8042eeYUe54LXQSKUYOEXpsJttx8MSxIFzvBD7uYDc5ueFDHZmEkPGZwgd+CPMu1gZd3qPXXlC33XOfwedu+4ts95Hov4Sim3qJsmHCtkLHqiQmpQZumJQjrnpwS4fshTqN9FhqdLHtzVhrnO5U7iU2c3mx9m08b62sdLhzQciqpkc/zrflfvivADUJ8NZ8dn3NHEGwB6elBaX95sdW+nTezsxKmqxx2sWbbl2vlv7A3wxntUw2A7gPUEH1s5y0/h+ppo905XeTY4CkzyEfUGJ3Zs5BYyHAO+G+yCODKQIzTz4rGGcqVdqeY4LOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIhUXkCYWULAhNacdqCmr6uJ93QREh2jelZy9D2+4DE=;
 b=OTk8fm05iFD1+2HdvKfbVEewHCJZHahUwpdWatzwnOBgzMxTxbkJlYkQkCq27PfxfFUdTgybC/DIpGiP9u+NEizSl+CMQjuZ4zfBdsMj4JrUcelDPM/2fY+o7PfB43o/Qm7BkD8KIxgrI3/SDA734khQlR//mroD2kVbD9yI2+9Xqym1nK4j1BoMVH2V8UhfMaP3HaRfaxbjIJ/TI8OaoqT7IMOovHLWPQM3pez0Pyiqgssboa7AZayq301s4fWeYiIyjrJa6GMzcwZhqnOOvrnvFhQuIJcP2tzDrg+FfVploQ4nvvutyLzR9MiJrEvV4qbNq85gwp2tbcZ3PRJg1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIhUXkCYWULAhNacdqCmr6uJ93QREh2jelZy9D2+4DE=;
 b=PpUKl3N8xGzjSU1xoBoGsN6JOG/bxHw0fo6SJGDxCvxpCAoW7x8rqF1fzzZrFGFAciv9g5xI+VEqFTWob2eylUB6o/HyIy4G7wpu6luUn30C+Qu/T5opQA0gSJIarSO3AWXNMww+ehyHdwNjmimhyNoB+fAwSs0/ypRbwZ1x7rE=
Received: from DM6PR08CA0060.namprd08.prod.outlook.com (2603:10b6:5:1e0::34)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 15:48:01 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::86) by DM6PR08CA0060.outlook.office365.com
 (2603:10b6:5:1e0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:01 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:58 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/33] drm/amd/display: Update latencies on DCN321
Date: Thu, 20 Oct 2022 11:46:47 -0400
Message-ID: <20221020154702.503934-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|DM4PR12MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: b79859ab-e9be-4c87-7963-08dab2b277f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erTlTkYMAvDpWxJAvNQJRQ/YTALELp8WIPWwaUoZ94tI2g6kV6hPCnRpXB6CtqtN5GPfeINsHfO8fPJrsdNjJugH0mw7ppq54NRUGrY+KfWDEk6iFLSfECrHgzANiDgLKTHaJpjCIDqeNXGrihPK7u5gi6fVjlCxTKQaciU7RitRHYop6b2tE7OtbmGN7Gt2PSZJVMdC41Eznsi01C0JlE1SuEIIxrJ5J2Y6h517pEoBnVmivzaGyCd65VzUMhXQcoIIDaUrXKLGhWNVvXvY5kqcaan9/Dh/OzCky48RH/1DobBC+XfXrG8OJp+9EI6v460KLKhkNwnP2119XNGiHT19fQSolj7M4L6LAwf0kEFFIiF4se078iVTpv47a+W6gmx6i+J1MsphnBL7n9pEu+HewSLLqQbDyJ+Bv8WF687k7VdiGlIMlXPvEdtvDYTgKOnxKbSQAqt+Mk2BCJKe90heAeveqvrxKzOZTkYkwUfzbHyMJOCCrFjI+pgENYb6lBNhteW/qXC3X5bfhtfNuqNWzEd4d/G5ZCYWbYdaIDb0A6yXGMBOOeif+l8c6fPFq3b7bWPHGSmqigy53DeNucvwSQwP9ZnrO+xhS10ptD2aUhhSTuTtQWmoSVoKBeUs8j7ZsjRaRJSfJaHwdWVWeW0tfcyqgMBXR/nT687+O9wWd0UUyaBBIs+SP+JE05nuneXcl3cd8Ar3KJxy8A83ZHIX63KPGaFvXcI4WdUPtPEJZNJC5FGApoiRUjjcTS7f3xmlMcSNclg9/sGmZ8ylE4yMSCNk9gCbyo0U/cipslU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(26005)(7696005)(2906002)(356005)(4326008)(86362001)(81166007)(82740400003)(8936002)(15650500001)(36756003)(5660300002)(8676002)(41300700001)(36860700001)(70586007)(70206006)(83380400001)(47076005)(426003)(316002)(336012)(186003)(40480700001)(6916009)(16526019)(2616005)(40460700003)(6666004)(1076003)(54906003)(82310400005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:01.1933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b79859ab-e9be-4c87-7963-08dab2b277f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

Update DF related latencies based on new measurements.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index dd90f241e906..7352f7514410 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -119,15 +119,15 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 		},
 	},
 	.num_states = 1,
-	.sr_exit_time_us = 12.36,
-	.sr_enter_plus_exit_time_us = 16.72,
+	.sr_exit_time_us = 19.95,
+	.sr_enter_plus_exit_time_us = 24.36,
 	.sr_exit_z8_time_us = 285.0,
 	.sr_enter_plus_exit_z8_time_us = 320,
 	.writeback_latency_us = 12.0,
 	.round_trip_ping_latency_dcfclk_cycles = 263,
-	.urgent_latency_pixel_data_only_us = 4.0,
-	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
-	.urgent_latency_vm_data_only_us = 4.0,
+	.urgent_latency_pixel_data_only_us = 9.35,
+	.urgent_latency_pixel_mixed_with_vm_data_us = 9.35,
+	.urgent_latency_vm_data_only_us = 9.35,
 	.fclk_change_latency_us = 20,
 	.usr_retraining_latency_us = 2,
 	.smn_latency_us = 2,
-- 
2.35.1

