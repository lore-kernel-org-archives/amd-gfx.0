Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9FDFA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F03F10E6D8;
	Thu, 27 Oct 2022 18:42:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE41910E6D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CW/9WzNXf9Q7C48wrdWIKCgzHVoFuntmcLi/OQbxColwMqVS1rUl/HS7p6DX9S760fSRcRPvXQPz30T6wr+wotpyH9DX5+e89QIylYYh3Cl7g6cXHXsbekHDQSX/pp7WtL7RcuYqI+q7oyjD8KL74ADaiA2PEGwwqlo2D1SQX4amrPUd5xphYkGhGAl7GwRQdN9Mk4cnayZoS9ZEej6eLXaYuJrYTXfG0wbRdGJf/FelL1mfLiBiUXVshGhqBU3RCHtFNBWv4iHN1PZ3i0/ZEtNkEoJTJWeC4A9x4PjDPjypf7xVjMCTeXJaCogPnKnX0eznQd8ytiVcMqs64rDrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXd8/pq0GPLdgUrDb6PrsrUfiUKynDwx5uaZ86uz5iM=;
 b=JJc7PXN7Aa4QUSweF1btD+tbUmIgT4Dt5s0bYKF8MjPgp1Hy0ZuVPTQqWJm34SIYF3enZzzsF6cVDU6Vo5XqBqblLNKtoi9OPFhLHZI/oulPoUdLuHTEBVJ24YBdY6jqsFenW3Vz4OgXMnxbgZU3ZSIrTJBzjAzPGWHVN0PMTcLKE4dDLmaZp44iYAiR/JTc7k+rWl1MWYKrU0M8BgR+Wk1jmDWgZJGqHA0Bs+XlfZrlDWY6r1YQYPXlfWMFpsHJp0VG8s2WXnt+EMaEELOL8FANKJNNzSSBi4exTDSEbHJIgJlR+oTQgHwCVyGm7aZom9h9OBlYECniIPhjkgVjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXd8/pq0GPLdgUrDb6PrsrUfiUKynDwx5uaZ86uz5iM=;
 b=lhRooXvloUJQeIhkK+IstEA9OLe8bfkItXOEkdbNkP7nDT/WMe+IpxL7T9ziXhRV9GQbMUhD4TpO62BS6RpOypvgtkV2tgk7TwaxZildrUQBVbGhfTnQNVZCHVONigPB/BNzNxA7S+ZqyAgmC/bsIkChbcS/wjisx2WgqqH8u84=
Received: from BN9PR03CA0523.namprd03.prod.outlook.com (2603:10b6:408:131::18)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:42:34 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::1e) by BN9PR03CA0523.outlook.office365.com
 (2603:10b6:408:131::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 18:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 18:42:33 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:42:31 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/18] drm/amd/display: Investigate tool reported FCLK P-state
 deviations
Date: Thu, 27 Oct 2022 12:35:42 -0600
Message-ID: <20221027183543.1117976-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: a20a0d4a-0855-4cee-3010-08dab84b0310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/HP9Vz24iWraCf+QMhlSLnvB/HfG1cPEDAAlYK9VoQvVteVZ0IZmX1REWWk+z//pgZPvffBYF8UvDkdodpy4a5nGFWEP5XyDh+BMwSH+4aGkBhQS/wrGL0HHN5Sg+HrPJMRxSOXXvAaiwEAUEhpzbFJ+btNOMbEChwXxNXOXZa1YTkuowhj+jmn5H2zJCDiK03/mAepoolve+AObG1V47s1Tb6JkQGIpUGIqVpXoImYWIy4LMFx78nL75R6LsgYgUgW5deN+zagwwDOjNwYBvxM4xCSK+HryYQGiAahTpDbNy4Z87bTg5XFfz2gGY71YVn5SQZZqRIK2GHNJy4wQ2VoBmozkILSMdY2LaDYV6MPle36mHYtRnUsHUVLPW1L25ihzvRImcBplho2apVmH+ftw6oahlRG+utgpelYvHTT3KRumDP2p45okI42NYfhfEFP2tMkXkt3ApQJh87AYMCUAQ3m0jnFFyzkZwCotBgc6s+r1gdjx/Vznu5/yMAVDT/iHeTsCsBk5af+5PPyv0I+bGRdhRNTSxRwMYih6b84NWRkgxA/YwpQsfx/2IBdczFOlxfS3d3Dy6fA88R4O8e10xXXnfx2KIIcHmN0i4PP8DeFCcpMD0agdtmBiHqPJSYio6FA5ZGxmsaWB20FM8jTAf3oRrGaVuNFkJS50Q50DrvlACC7GYGenIPmaVviMQZfghsBLh87NpVMkFooa0j+HrfC8/gZrLn2Js2GoWsdeBnlE6X0Okm0PIQ6NJoBS++NYwZjX4+R6r1HH57AFsxe6gTyOT4lusJifTd239RRHSwaGomwqiEaw93ioywk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(41300700001)(36860700001)(86362001)(82740400003)(2616005)(2906002)(44832011)(81166007)(426003)(47076005)(1076003)(356005)(83380400001)(40460700003)(16526019)(186003)(336012)(8676002)(7696005)(316002)(4326008)(70586007)(6666004)(26005)(6916009)(54906003)(70206006)(5660300002)(40480700001)(8936002)(478600001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:42:33.9484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20a0d4a-0855-4cee-3010-08dab84b0310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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
 qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, wayne.lin@amd.com,
 Alex Hung <alex.hung@amd.com>, Chaitanya Dhere <Chaitanya.Dhere@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nevenko Stupar <Nevenko.Stupar@amd.com>

[Why]
Fix for some of the tool reported modes for FCLK
P-state deviations and UCLK P-state deviations that
are coming from DSC terms and/or Scaling terms
causing MinActiveFCLKChangeLatencySupported
and MaxActiveDRAMClockChangeLatencySupported
incorrectly calculated in DML for these configurations.

Reviewed-by: Chaitanya Dhere <Chaitanya.Dhere@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 47ff0a8bd105..3d184679f129 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -364,7 +364,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 		v->DSCDelay[k] = dml32_DSCDelayRequirement(mode_lib->vba.DSCEnabled[k],
 				mode_lib->vba.ODMCombineEnabled[k], mode_lib->vba.DSCInputBitPerComponent[k],
-				mode_lib->vba.OutputBpp[k], mode_lib->vba.HActive[k], mode_lib->vba.HTotal[k],
+				mode_lib->vba.OutputBppPerState[mode_lib->vba.VoltageLevel][k],
+				mode_lib->vba.HActive[k], mode_lib->vba.HTotal[k],
 				mode_lib->vba.NumberOfDSCSlices[k], mode_lib->vba.OutputFormat[k],
 				mode_lib->vba.Output[k], mode_lib->vba.PixelClock[k],
 				mode_lib->vba.PixelClockBackEnd[k], mode_lib->vba.ip.dsc_delay_factor_wa);
-- 
2.38.1

