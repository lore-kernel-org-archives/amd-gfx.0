Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E22C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88DC690948;
	Fri, 22 Jul 2022 20:43:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A062190577
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRKHP/RrhgEPl5L/pQToPnH54zBBNnBO8TlW0cQxHwzY4TngnD0mB9J1RZFBMrZhPa7cP6JL/x6YoCE748GbC8QLswFNq8Qwnkpy7vaF63cBX2VIumzyT7PjI+gBFQpIyT6a+Gpblr2By5gnrESb3+stY3/ixuYW/ISRjCRsafT3XNSgscH6TvgnhV27yk6BE343hovER0j1jTte1uhKlsB7cXzoR0WaDdIh1x4BKFLUtI4DjYsahP26CgAUr9Nvy80wb+yy++DQL/XqotY1qlZHnGggQsACYtvvC1L9oiPDA0J+RmIyhlxZ0cAm9N02rXI3U1li8C0DGudmYUFDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il9u7izURb0ml4otk992ZM05gOf2EinDuIRDgmh6Fc4=;
 b=jjAGVrZ1DcgADGEfBOnAnPgZlJVUcT4yRK3Hg5PZ4sgENdgFKIQBtRTSIB1pHFiXzhCfq1CY41RVIWECmhNoNr2AEvf2Ln1mjTV0JFUZ7sQ5wS+hwcPvxEPh/MXqbQhbwvsdCioNTN4y8DzgTa+3dv74uMnXRQtC3Dm/s01JCHYqXxh8veAA9l+3dRBILOwLCzl1CAkaiNemX+XHhpAXOii+lp8Cb4Oelo/lIkm8qsNZcxWvol0ZBOOOM8D1yIp4NQyXXdsjrG4ODH7JFs6hYkpftaTj+/uN2oo61qQISTb3YTy8B04YMyDUdc4V0vzmb6adIWEKuuEX5Poupv+WIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il9u7izURb0ml4otk992ZM05gOf2EinDuIRDgmh6Fc4=;
 b=I81X2jKwvkmw3AkUOdPHv3IZaRzVu3pfkjvStYWdxM2z32i1GSt/iFOMQhAYt8gVOFIxtA/0FAg2OWndtIE46EqZuBvGTs4p8yoCOCOZypwh+KBEn1/ffrklAd5jrytgaVDj5Hc+A31P0CMIfLylTagn3RwGSKwhPHDt7Tp+Drk=
Received: from DM6PR03CA0023.namprd03.prod.outlook.com (2603:10b6:5:40::36) by
 MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 20:43:17 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::69) by DM6PR03CA0023.outlook.office365.com
 (2603:10b6:5:40::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 22 Jul 2022 20:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:43:17 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:43:14 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/31] drm/amd/display: Update DCN32 and DCN321 SR latencies
Date: Fri, 22 Jul 2022 14:31:32 -0600
Message-ID: <20220722203137.4043516-27-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 671e41bb-86cb-4bae-f601-08da6c22ce56
X-MS-TrafficTypeDiagnostic: MN2PR12MB4208:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BLhW/JmEW2RHoYg1ii+qMn7wQrSBhxHStd1G/2lhy5IGwAlP2etVGlrPj93R5hPNiz/+kiQADilJvm+1q0W4tp39w9xMKZaF3QLpaGo9lxZMPD82IXW5xH6FBbxoKAbneY+mACEiJx2M141pln44QitfuOjK918XexSh17GbNhrAKs08h0fRawy7Jg/9yHUO66otHCH5mtDcFxPOYHhAhx+eomX6HvjAnz6ifYukdujXCUI2roSFuo8Zs+oEs0TnKHTi8tGEhOD1RwYO39wTtP0Mh2Ti3xuvaD5lpKPxHksWVSE9hNws9EgVyBTPbfgNjUCjFDc/SbAwh2Tgrdari3f66R28xId1Oxaf1Wjj4ydJKD6F5hziXAcE6/gJq+uKU14uPnzHW0M1gnomDZR+d0ySpE1NxsqPgo6bc7VNyjROwYE35SgthXroyumXmSgCFcZrZG3IroayZ6mR2B1uZmVZixqSYQi3kOXDSHDTI4GU+NLqK38q7NXDceWB8rswEuAANFZfMzj1JhmDeUrqKWjMPUf49DxanREDUpw17rkjAWv8abb/myDXCyaxdRjnndfqa5OJZiwgBjRV6JPzQCrdPzYPzDXOtI0lZzTp0LawpMopRmcy7PFyQEqEj5dy0qU4cSHvQQaksUEP8soDM5iO8P6xH8WzIPbbKV4FRUdeLIGF0UAqcObj30PbghtlCvV8CdbZi4KMeBomN+qAU0TWbp7hQoKtLUsPe9KF7vkCVCBREoAvbFxE0c4kAB8rmP086C8BCNxdtgRJYiY5FLXdL5+F4RR1aA3oUezrIXHoEjVwhQze9l7uCixbg8Rr+I56yxSpx5+Zwq+/iVEoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(40470700004)(36840700001)(46966006)(356005)(8676002)(336012)(82740400003)(16526019)(47076005)(70586007)(2616005)(54906003)(15650500001)(4326008)(1076003)(83380400001)(186003)(70206006)(426003)(2906002)(8936002)(44832011)(7696005)(40460700003)(36756003)(40480700001)(86362001)(6666004)(5660300002)(316002)(41300700001)(26005)(81166007)(36860700001)(82310400005)(6916009)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:43:17.1746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 671e41bb-86cb-4bae-f601-08da6c22ce56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

Update worst case SR latencies according to values measured by hardware
team.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 01e272f0bb05..66453546e24f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -121,8 +121,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 		},
 	},
 	.num_states = 1,
-	.sr_exit_time_us = 5.20,
-	.sr_enter_plus_exit_time_us = 9.60,
+	.sr_exit_time_us = 20.16,
+	.sr_enter_plus_exit_time_us = 27.13,
 	.sr_exit_z8_time_us = 285.0,
 	.sr_enter_plus_exit_z8_time_us = 320,
 	.writeback_latency_us = 12.0,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 6e72336b7975..84b4b00f29cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -119,8 +119,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 		},
 	},
 	.num_states = 1,
-	.sr_exit_time_us = 5.20,
-	.sr_enter_plus_exit_time_us = 9.60,
+	.sr_exit_time_us = 12.36,
+	.sr_enter_plus_exit_time_us = 16.72,
 	.sr_exit_z8_time_us = 285.0,
 	.sr_enter_plus_exit_z8_time_us = 320,
 	.writeback_latency_us = 12.0,
-- 
2.37.1

