Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE17FECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076F710E6C5;
	Thu, 27 Oct 2022 18:39:03 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9122510E6C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/p+1h5ebiQkABtQ6Hw6+JbCWAgaDJ3t22BG/rT1IOLqs6Kp10/KZHqf/6sU9tk82cAG98Ssv5dIt50Jf30MK6fLK3K6f+hNjUr7aT8XhP3dIQeJHlvTs1PUrSW7XPulnxcdsRC3EUC4V5TNNme2h+ZtbIiZvOaIs54x2WYzh1jspPypAOcN26Scjh3rXCWjPxhCilLM103eXo560DW8zQMHXlZDEp/LoLQGnMi8KQe2NeG/7h0cdExorNXwKvMzXjcVu/JmpgeyGRiCkcpkbAyePJ/FQAjNAcXP0WQM8BDH/PcE5uoqVLAy/OO/NuFMw44X02W7728ZOjSI0bzQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5R/JiPm78KfQso349ajw90QfzGoOFH8t0aHZs4msSM=;
 b=OBUmgTReESOmc8tMvmSzkPDX+YlbgMMW3yMnl81LHpQNM/HzrBqj+DWu+5+CtiS6GJJOLIAQWiM004xD4q+gFmtJBd3OxfrEKA2fXdi9cMyW3Xk6qKASvRXmzWaqgYpMGHLS+oBBHAROJJsKFhgNaw3w+Qz9YMNblWsvtjdEvtqYvpT53vza1/WCCt3dejtm9ReVCypaIhNMfTlJMJLHrUwJVKJ2FKc/D1MiCMiBC8HVxpbojeRaOR8bdloGZFruRNgxhUqO3sPduhdZGgekl1JA3QmYo1/ephAgW1tdsk7Irf/D5v7CZG25YlHlU6do7RIrUaqEocEdXWT0m9WcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5R/JiPm78KfQso349ajw90QfzGoOFH8t0aHZs4msSM=;
 b=fu0eqK39jQLwoPlMUQbeXWlE6sqDNec2eU/FYcudRNT6mbhi1sxMuz63l0mawUGaMImVV/DsFdKjY1IGtA+frwOT64JAyUAooBwHzBzQfY3zIf1LfQmi1llgXpkvAq9OfKipyyKhOWtV3q85qu/YMCVUcRqpCF8IhB1kNRNhzlA=
Received: from BN9PR03CA0443.namprd03.prod.outlook.com (2603:10b6:408:113::28)
 by CH2PR12MB4907.namprd12.prod.outlook.com (2603:10b6:610:68::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 18:38:57 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::42) by BN9PR03CA0443.outlook.office365.com
 (2603:10b6:408:113::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 18:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 18:38:57 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:38:54 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/18] drm/amd/display: Reinit DPG when exiting dynamic ODM
Date: Thu, 27 Oct 2022 12:35:26 -0600
Message-ID: <20221027183543.1117976-2-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|CH2PR12MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: e935b7ad-5560-44f4-86e6-08dab84a81c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8gvipw0nVhAqU+jHBTNxDNkt7l/IvienXN/j4BhLQ8KR8CYp0iMy8/DjOR0GoCw22P02WjJgmMjZ+U33rtTUKaHpmLMg7QsGES0BAbDQOb5nTmkCUGak4LClJvKO+NM3ceAMxfN+DD99Kl0PXkHLzN4m9o/qBlhHIVILtSX0D2dVFDgGYzdcJq3LCpdXHxMjKq+5OhJihj1YYtV2NBpejfUalOJMdVwDCiuWTJLG29BX7REFQ8uABh/+jhUnbTmJBHecFcSzWV+8HWf+8YDBk7v2qXbKozkyhHpsUJKkQLhEplC6v9T11rhBtQrVGKZBASAYRmPhtnd3zu3TPxFJeLNc6RNhilIiPHhkBNAkHNAFuCHe41G/wQite27wXhMw7fCr+ceGF9/IU0DUoJ+Zi2N+whXNlEFKWWSEERQH/FziupL7K5nP4iff+mW2XVi9ECipGyzjB04nUgsC6SZUIHIrhJDlyvYhw8PUeAL+zzvLtjePynMCr2F9B8CTK8DB2nJ7VoX1s2hFZjujIkWbu5D+Iher1JoI6WoCF8BbCKijgQ4QxazPJt4MO1fRVO/OVbMRJZOUk3pPEA6TPPo8YOSNUE4OFbsDBVBOQl3aZ2YXlsWEKrk+gBCm2FxJmRGX9GMVmbDcyeJT96R1rS8/g9JU4TatPJ5xQ+tTCakAw2vjFR7mRvRRYJxMwjPSetSzns6w1SXZc1mFVMdEntuudUVf+4NEO+5NZiYog1Y18v4NlF0f7jg0NZJXqFKf7hTOt2UsOJxGyhUyBt1FxQx8PL24x93GuknbDvcAgsdZN4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(6916009)(40480700001)(41300700001)(7696005)(26005)(4326008)(40460700003)(44832011)(70206006)(82310400005)(1076003)(186003)(70586007)(6666004)(8936002)(336012)(16526019)(8676002)(2616005)(2906002)(316002)(54906003)(47076005)(5660300002)(36756003)(426003)(82740400003)(356005)(81166007)(478600001)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:38:57.0396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e935b7ad-5560-44f4-86e6-08dab84a81c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4907
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
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY]
DPG must be returned to initialized state when pipe is disabled.

[HOW]
Reinit DPG on unused pipes when exiting dynamic ODM.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index feff834d5410..b465a83bde6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1079,6 +1079,29 @@ void dcn20_blank_pixel_data(
 				0);
 	}
 
+	if (!blank && dc->debug.enable_single_display_2to1_odm_policy) {
+		/* when exiting dynamic ODM need to reinit DPG state for unused pipes */
+		struct pipe_ctx *old_odm_pipe = dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx].next_odm_pipe;
+
+		odm_pipe = pipe_ctx->next_odm_pipe;
+
+		while (old_odm_pipe) {
+			if (!odm_pipe || old_odm_pipe->pipe_idx != odm_pipe->pipe_idx)
+				dc->hwss.set_disp_pattern_generator(dc,
+						old_odm_pipe,
+						CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
+						CONTROLLER_DP_COLOR_SPACE_UDEFINED,
+						COLOR_DEPTH_888,
+						NULL,
+						0,
+						0,
+						0);
+			old_odm_pipe = old_odm_pipe->next_odm_pipe;
+			if (odm_pipe)
+				odm_pipe = odm_pipe->next_odm_pipe;
+		}
+	}
+
 	if (!blank)
 		if (stream_res->abm) {
 			dc->hwss.set_pipe(pipe_ctx);
-- 
2.38.1

