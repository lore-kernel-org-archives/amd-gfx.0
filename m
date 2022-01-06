Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EA4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 16:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD77210EA1F;
	Thu,  6 Jan 2022 16:31:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9DF10E868
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 16:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlrXsH6qFEZzAwHp9mjDHG7rWGfTk9y5ifY4IO+miKWIGgEl9OCmchCgzEGZOv3UBzIwecY3OqGHYfO3/SWgQuQDm11NkQRVXfPrS3LCtPWT9mnnxLPtDZwNSvFEo28BuKVYkHC7GQpDLnNqCzDxI40r0r+EtkWoz6cTDasVn7S3+CgbFkNlDRFEMvIwVtNBTZEcBWQbIccsU70AWuKxiXGgXflDmg7t/fBO1Q050MHGvOdelgEQiSpdrhtXs3CuJl2ZXy0PYJXdjYVVhQmdtCjRplIUopvJgtQ5ECsb7k9t1KsVHrsRQT+WB7VQS/LmlX0Hlh7QMOhRq0W/eGhLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hG4/3y23gmCSWBbeRsHNdGeSPG+WZUvrvn+Uufv10/Y=;
 b=bHMnF8Cv0rbdFpebMSM0Jsu5cVm37AOqUDbg5aMKw5loLCp34KXtNMs/fuXSpFJEjcFsM2rPqTSbv2lF9DL10bT5i5djQBM+7p4Axh0jv602jVr/JKkHZquCYsxgOCJPtTqEvXmeVOeZsA15KuDFM9bENNLt1DsqUG0TNiO2cbswAWnotNwtG4b7C4Gg9a/0yh/vtDK+Z3+ha9rhqH1+h6jnJvnzYQJKeQpPsrtT364N2CE1ei6/rd+v6jgG5b+y4WJiwpeji7AcwzbhWRv9sUL8BeCvybfakl9xOlfsy5dTTC6cgOcbD50NYdcrD19Oh6kcfKbxNhKhq9ZcMfntfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG4/3y23gmCSWBbeRsHNdGeSPG+WZUvrvn+Uufv10/Y=;
 b=QbexhFN4dzvfGBP4h5LJZujIv8VDOSqxjoO/VwNUJgRMVw6qw5NafsTiSTa9yTz86WXib0IK576LAebw/FtalfaMw2OpIzSHeKI+SijVx1N8FMxPm6iaWq5uMewJdiY9O99OgyW4Bf5aERT9vzo2omjCfn+Z2NA70ZYvc0Jg730=
Received: from MWHPR15CA0058.namprd15.prod.outlook.com (2603:10b6:301:4c::20)
 by MWHPR12MB1680.namprd12.prod.outlook.com (2603:10b6:301:10::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 6 Jan
 2022 16:30:58 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::d5) by MWHPR15CA0058.outlook.office365.com
 (2603:10b6:301:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 16:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 16:30:58 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 10:30:57 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 3/3] drm/amd/display: Use requested power state to avoid
 HPD WA during s0ix
Date: Thu, 6 Jan 2022 10:30:54 -0600
Message-ID: <20220106163054.13781-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106163054.13781-1-mario.limonciello@amd.com>
References: <20220106163054.13781-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed221852-31a9-4ab5-6b19-08d9d131ebc3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1680:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1680A22330BF299919DF47F0E24C9@MWHPR12MB1680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drjErB124UhKlsreTnPv5jI7PHwJHAlToTuA0Ef7X8oRVIGif/VJTwvputsks/TlI5TbxQ5cfwctuLf7GTcycPDTfLTJyVyo0D/zybILFIEmD90Sg+9wLfZKtWC08w35azQlQqHUGd9viPcxwCWk2LkzJJwnh09eyEJDz+uTjuo99UsrZiKdzehb2OOL1Pug2BY0DP3jyHwAQHj8K+8fGIknVQ61jq/YpW8hMSt4tJyTtfe+4nkMB3EzZ5gNSuuJ8IRrki9u6JwhlnTo8J/WoToBKNXTeH3vW8xjGanQBgD9dRo2hjEVuE6BdMlm3sDL5rbJ+em08YMcOBK/jqp4AoY1jtFy5eKZu5W0Qe6Fp49+Xx5ZojVUHOONaeJIwqwjB+6HNDYabLaRTaRLpAFdlmP7hK9TXQpm3wVK+b3DAMNfN/JBsqaMYiFMTobjOG1A/ZyJTpdgRC/MqLVRcG8MWy6dQz8e7GaeYpRtZg1LncgBOigUipWfxxsRRMCVZ4fwcIiXpyIIQOf27nSTd/STQHs//kSwbsNck1uOWM4zPnF/Py3w7b/bS7cYIJQkwAjHRY9Xvbs6scuAFGeIL/GmJe4Z+210GXONIVQR77PSp4IpTFEdhxpTbbh8nhD+5qve2Dy/Yp1ZvFnlRMYf/UT+UvSfFLn+PwkokNnb8mPUhUygJJ+pdNmxd3MSp8J51bjiwmLra25FLCpUoQgGlb1ZLEjWc6K/WI2bwmjJdeLEVlsRz6X5l9CznWdY7KBCXXFUCiOmaGsmeNxYqI/bCYmJuGsriRKrSbUxTSHJbqShmTTDwEdNml+y5649iw+m7FjeY9aNntsZ5GW19Z14lci/9HG8Lx4KHY9S+oMDbm0865otkC7CCwpqiJQg770KiC+i4UWdMMalr8g7BMNbuGyAGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(47076005)(966005)(508600001)(316002)(2906002)(54906003)(8676002)(6916009)(7696005)(36756003)(36860700001)(82310400004)(426003)(70206006)(86362001)(1076003)(16526019)(83380400001)(26005)(6666004)(40460700001)(356005)(2616005)(336012)(186003)(4326008)(5660300002)(70586007)(8936002)(81166007)(44832011)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 16:30:58.7285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed221852-31a9-4ab5-6b19-08d9d131ebc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1680
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>, Scott Bruce <smbruce@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>, spasswolf@web.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The WA from commit 5965280abd30 ("drm/amd/display: Apply w/a for
hard hang on HPD") causes a regression in s0ix where the system will
fail to resume properly.  This may be because an HPD was active the last
time clocks were updated but clocks didn't get updated again during s0ix.

So add an extra call to update clocks as part of the suspend routine:
dm_suspend->dc_set_power_state->clk_mgr_optimize_pwr_state

In case HPD is set during this time, also check if the call happened during
suspend to allow overriding the WA.

Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reported-by: Scott Bruce <smbruce@gmail.com>
Reported-by: Chris Hixon <linux-kernel-bugs@hixontech.com>
Reported-by: spasswolf@web.de
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215436
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1821
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1852
Fixes: 5965280abd30 ("drm/amd/display: Apply w/a for hard hang on HPD")
Fixes: 1bd3bc745e7f ("drm/amd/display: Extend w/a for hard hang on HPD to dcn20")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v3->v4:
 * Move into new function
 * Explicitly check that current_state is active for safety
 * Change metadata from BugLink to Link
changes from v2->v3:
 * stop depending on adev, get value of power state from display core
changes from v1->v2:
 * Add fallthrough statement
 * Extend case to check if call was explicitly in s0ix since #1852 showed hpd_state
   can be set at this time too
 * Adjust commit message and title
 * Add extra commit and bug fixed to metadata
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c                  | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 20974829f304..d2e1938555dc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -129,6 +129,10 @@ static bool check_really_safe_to_lower(struct dc *dc, struct dc_state *context)
 	if (display_count > 0)
 		return false;
 
+	if (dc->current_state &&
+	    dc->current_state->power_state == DC_ACPI_CM_POWER_STATE_D3)
+		return true;
+
 	for (irq_src = DC_IRQ_SOURCE_HPD1; irq_src <= DC_IRQ_SOURCE_HPD5; irq_src++) {
 		hpd_state = dc_get_hpd_state_dcn21(dc->res_pool->irqs, irq_src);
 		if (hpd_state)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8edbb6c70512..716e055a61c9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3302,6 +3302,9 @@ void dc_set_power_state(
 		}
 
 		break;
+	case DC_ACPI_CM_POWER_STATE_D3:
+		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
+		fallthrough;
 	default:
 		ASSERT(dc->current_state->stream_count == 0);
 		/* Zero out the current context so that on resume we start with
-- 
2.25.1

