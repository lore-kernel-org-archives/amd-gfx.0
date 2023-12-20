Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12207C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984DB10E5F0;
	Wed, 20 Dec 2023 16:37:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8C510E5F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtfzatcxR3Mrp5hAQ4OJAxu2gsiNTmx4KJJ2+lrhrGaBHTwIBqgBo47S6O70SSMH/tx77IS3fsL/wlteboD0Sj3tYmH8duL7bPAa/W3a4LfSPZ42ko+GV3UfR6OCenC4CAiEy3IplVB2DW/nk6crGWq4fG2Wi51hq2PELVU4c3tDzVFd0CqJHl9qKl4P7KkduEm211pfpom02GyY8/c03WKPhkePpmRZz4f6asd9lbQR/ieWFYITYaaDBbB9PitfmNxXjPp5kTuVvyFQVvC3/PvFF0BYQYhreCcCPMOnFxZn83wcUYLSXcyVdh+pnLUewtkjo+wioRNisoD5e/xlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSMjgG3Q9+soAIAyq8WiKTh5cRJo+Jk+2hMz39gGod4=;
 b=AucNK4dmjop/ShGbBncYyYYhGvs+8XtquI7ad1I3p4ULxSoGpXDCiG9Z4Qpot7SOmeRqex+Q5Gqk7NuAXgPO7vF9a4SNfT46htjsUlhLqQTjjoZ8D17w3d6xBPHlADn0AxhhYIj5Nm0o5clDZAV+w5Ml1/Wp7KjuDQTOSESWyTqHOk2Tsh3y+usAeXvdcFBWaHtG0zaPcf7ZQiRcAqjoF4DqJruZiZVj1aXFggP51VFpP8QCXyWtaLkuvKXgpus0Ah8S5XJe5UX/y6kAzSnadevU0Iw9Wu0fEEN8vgwvFGg0DDUte4mJoxn/6+5Tf3PCrAVEpVpqVYSsilmCE+52bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSMjgG3Q9+soAIAyq8WiKTh5cRJo+Jk+2hMz39gGod4=;
 b=lal5BnVKts2DjnVNRen/hhv7JTkDHNEPM1iljilr4pHolDC6uELFejcxPxO3Zbnr4WoNt4bDxCxFamK9FPkzgfNzJa4x5WpP0LXizv7mDSKax0XHlKXxZpMsy3Yu2IPqM14Qk44KbEIaBlhWWrNVq0RawHRcu/vdbut6SerBbUw=
Received: from MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 16:37:06 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::45) by MN2PR16CA0057.outlook.office365.com
 (2603:10b6:208:234::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Wed, 20 Dec 2023 16:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:37:06 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:37:00 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/20] drm/amd/display: Wait forever for DMCUB to wake up
Date: Wed, 20 Dec 2023 09:33:44 -0700
Message-ID: <20231220163538.1742834-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: e8323db5-fef4-4b3c-9e0d-08dc0179e77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqLmzKM6cD6nXPPQHVhr5mY9T3zDzDnTJovlKTzqlPPnICWf6NCCY3qDKdBfjgZOvkgi5DW/Wg2us4jfKXuco1YBVCzk730vzVYN8Um47O1tGzp1K5FB4e6oGDvBK0JnxeNHEa5HrgX++q/1BewrXlgQG9fHPRqcsYoP2MZJTO5GUupS7OGCptmCg2bVe+kZeYf8mKe/4C41oOTpgZyyvts9JAH98BH8y3hOQ1Jq+hNazsEL7jiB8w/v4/fuTgw1BiXOHMnVeRMQijVgOaVH/PTFb/duplwHuCxtryGEwanU5AqQkN9nBArEwIzSJD6+j2IH/Ng5UAQaJyjp/vsMT0bASOjYRnvvXw5reNL5sgUuakKEd8n1k6sIKVKHjmcn1v3Lu5YTJHPtsfR/auzF8iCBpVUR21CNvO4rO0dAKNvX31+rjX54DPm6iyzbY/1BXjG372Pnuz8SKBRth5ewpnTqADBzSGCs4ILnVT4Mr13QwxT1zRZ57bdbl5b7afvL+6XxeP5dHnj3+SK0vMqlRG39s5qlyMHrNLJayAgxp1VemBLWDbSTfO5Yr6c3NEgnXHMOZZkXIU+yPPjKoiQRCUcERtNYRqrEMpzdJnN8o/saZ4MotskBQOFGnu/LXmL0O/hV15SdAnYB5noQMbaMjehoOyeyce6relpbycNRXYot+NFLhc8N9QaWs+HLS4X0DTtbi5vAWXcb+gSZCIq4xB4h4RUfHGcKIRXDEGz0hrV0Nq1WT+0TDMCbDYf1C9zoKAKICr6LPnwfu5cyYkGiOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(426003)(26005)(2616005)(16526019)(1076003)(336012)(6666004)(36860700001)(5660300002)(83380400001)(2906002)(47076005)(4326008)(8676002)(8936002)(70586007)(54906003)(316002)(6916009)(70206006)(478600001)(81166007)(82740400003)(356005)(36756003)(86362001)(41300700001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:37:06.5739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8323db5-fef4-4b3c-9e0d-08dc0179e77d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Sung joon Kim <sungjoon.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If we time out waiting for PMFW to finish the exit sequence and touch
the DMCUB register the system will hang in a hard locked state.

[How]
Pol forever. This covers the case where things take too long but also
enables for debugging to occur since the cores won't be hardlocked.

Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4ce8ac966cc8..7724dcadecba 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1214,10 +1214,8 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 
 static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 {
-	const uint32_t max_num_polls = 10000;
 	uint32_t allow_state = 0;
 	uint32_t commit_state = 0;
-	int i;
 
 	if (dc->debug.dmcub_emulation)
 		return;
@@ -1244,17 +1242,13 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 				udelay(dc->debug.ips2_entry_delay_us);
 				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
-				for (i = 0; i < max_num_polls; ++i) {
+				for (;;) {
 					commit_state = dc->hwss.get_idle_state(dc);
 					if (commit_state & DMUB_IPS2_COMMIT_MASK)
 						break;
 
 					udelay(1);
-
-					if (dc->debug.disable_timeout)
-						i--;
 				}
-				ASSERT(i < max_num_polls);
 
 				if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
 					ASSERT(0);
@@ -1269,17 +1263,13 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 
 		dc_dmub_srv_notify_idle(dc, false);
 		if (!(allow_state & DMUB_IPS1_ALLOW_MASK)) {
-			for (i = 0; i < max_num_polls; ++i) {
+			for (;;) {
 				commit_state = dc->hwss.get_idle_state(dc);
 				if (commit_state & DMUB_IPS1_COMMIT_MASK)
 					break;
 
 				udelay(1);
-
-				if (dc->debug.disable_timeout)
-					i--;
 			}
-			ASSERT(i < max_num_polls);
 		}
 	}
 
-- 
2.42.0

