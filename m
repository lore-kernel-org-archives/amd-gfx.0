Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB48C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D5110E5FD;
	Wed, 20 Dec 2023 16:37:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721DF10E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsKc33kOUE31H+vQsJwUACj37euxY+sHvlU5MnbrGdcUsf++ZeiNyL22UtW2bTN5+oz6BCtmK1MecqzZOcQ1C+VwXJMvNMsF4b26rGc3wBypFrbav+36NTfXPe1EXuPa5XIoEtZHsPkoXBNi35Elmrs/Oqlid/LBN9wHq23VwOY/lLNUMNqNYO52cvNzxZ+l7lFqZ00VMMr6yLlU5uELHjWvfe8rN8F1faFTp+d9DGedIo9hzhAQ8LzsATVfjj5eckFut8MzhyAx1jca1vedhHiQIhMHQIcqiZc7OLtSJVygRdMIUpA6n/g9XzovZJKzmIF96r8hRslkYly9gbqKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1esl/d5lTnlqxQ9TFXvBBO4AiVMbSVDdijuzOVKXdgg=;
 b=i1B9oSmtgTzG7SygtLbWc6d3lOiMirE3gK6jlIZA2xMUYJDMUpfoCTO0BkrXmMUGFopzQlVByAaWwglupxRQyKvOHZVDiX0LzGbduQZEd6Dd9ORWWC1vridHoo6HN4k88wZ2R8BK1NsSgIhq+sF67oGsGMBNQyF03oXxVHg/sycmxw2GrLfmqBXB2n7/GK1I+2SiFRE+8YwHo872BvOr9lgvlc105IWwrikRAu8ltvYOJ8hBpc4MW6g13x1k/q79oiii9OXSTm2dcYsAWpB6pG5fJ/WSk20Qv8fkqaqCYyNHnjPQ24Wwf16e5cGwIr5Os27OJsXFTCdFCf6mQ1RQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1esl/d5lTnlqxQ9TFXvBBO4AiVMbSVDdijuzOVKXdgg=;
 b=oAtplQB3emhCavlgo1Om+Qpt/9BCSiqoRTEd20EDo+FoBKYUBr1oZfa4je39vOEx5LWUlv/U8qf/OfiRXirWWoBhqYy9WsX7awE09ctO1iKpy5kKK+RE9cFUXx1Fw1nBq6P1OeV5kVhmzWZcz/ubhdfm++tX+DJseefbSyZXsp8=
Received: from MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Wed, 20 Dec 2023 16:37:17 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::80) by MN2PR07CA0003.outlook.office365.com
 (2603:10b6:208:1a0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:37:16 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:37:11 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/20] drm/amd/display: Verify disallow bits were cleared for
 idle
Date: Wed, 20 Dec 2023 09:33:50 -0700
Message-ID: <20231220163538.1742834-19-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 54809b85-0986-4fd4-3566-08dc0179ed90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cefhOzBPxvh3v2MgKXdyyHjqUDnfcar0au/6zKXNROEwb0lzINFGZt0L+d92+qVR+lHikCNxqrvZ68kZmPGedXufJXn+/UC9cHyvMlK9rA8+9sWHzNTrBmBmvfEaBzxrqGtLJa8QWMn2sIqAZvGtFIhvXrvNMAl4+Pg44lTRg87rybUu6EFPcCVp/hRy3MyNVp7pYmqLGPUxx0jDxy7/srHiyo6SWis/5jk8iO5HMTWRAJ4J5N6RSuIVJEC4yKToTk7mmyB7il9SXrIOdCj+u/D89Lz5S2rdVMKUuVtszovc4BaBpu2GjE9KHnYJEfiJm+36u7c0SGznlO44upI8RIa0DHtvYfUTZgVT39uIt+ZmR8kThoA5amPybDI9ToxjZd2E7D53yTwneFd8BoYmwtRoxxgQngUcgLx0Wk3bmv0EEN0GrWjEh6AAbzHdM0SvUscq+yXRPSPWRn885M8GuqqaxOFs00M0lezFJr2f8gvQYgf5HJvuwrgraoOF5Fvfn1hYiu8pkStvWQjLFL21D1NHigc013Bgu4Ofehws3x3R6iVRTtQX8jxCoGexTLClVsmbUb7xSnYukB+ScELAiqNwXQ1kV1Ge3/AGcB+c4h0zlwSRfOkQC7kykwFkhH6UVAV4UMv6aNsyf+DURPvbiBfGkKrLodjJmw/brUvtFVnNlTatlzwAQIpLjCnoY44c08jDCsBkaoVzXdhyKDIxy1q79g5QXo8Qj0RV7noznpiouCHnHMcvdQQRnfAjCYabH2EpPN+CAhdJ1xOsJi5gcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(36756003)(40480700001)(1076003)(83380400001)(6916009)(316002)(54906003)(70586007)(70206006)(8676002)(47076005)(4326008)(5660300002)(8936002)(82740400003)(36860700001)(6666004)(336012)(2906002)(426003)(478600001)(16526019)(86362001)(2616005)(41300700001)(40460700003)(81166007)(26005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:37:16.7620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54809b85-0986-4fd4-3566-08dc0179ed90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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
Cc: stylon.wang@amd.com, Hansen Dsouza <hansen.dsouza@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
A hang was observed where a read-modify-write access occurred due to the
register for idle state being shared between DMCUB and driver.

dmcub read - idle allow / no commit
driver read - idle allow / no commit
driver write - idle disallow / no commit
dmcub write - idle allow / commit

Resulting in DMCUB re-entering IPS after a disable and keeping the allow
high.

[How]
Long term we need to split commit/allow into two registers or use shared
DRAM state, but short term we can reduce the repro rate by ensuring that
the disallow went through by bounding the expected worst case scenario.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index dadeaa9c92dd..a65c485b0b49 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1233,8 +1233,16 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 
 		if (!(allow_state & DMUB_IPS2_ALLOW_MASK)) {
 			// Wait for evaluation time
-			udelay(dc->debug.ips2_eval_delay_us);
-			commit_state = dc->hwss.get_idle_state(dc);
+			for (;;) {
+				udelay(dc->debug.ips2_eval_delay_us);
+				commit_state = dc->hwss.get_idle_state(dc);
+				if (commit_state & DMUB_IPS2_ALLOW_MASK)
+					break;
+
+				/* allow was still set, retry eval delay */
+				dc->hwss.set_idle_state(dc, false);
+			}
+
 			if (!(commit_state & DMUB_IPS2_COMMIT_MASK)) {
 				// Tell PMFW to exit low power state
 				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
-- 
2.42.0

