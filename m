Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904E8C0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1316710E46A;
	Wed,  9 Aug 2023 15:09:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4866210E45D
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXqmI2NVZEcSPGaaVkts0XBRW6TEVJ4QFlED/h6WuYseTypdvebfP3FoFDhFzgJTjkIS3JxMIuWJ5XbC0qtO7IJaW2AMf4wBFbPpVoqkXiexP+4ZNl66xFmIOehNRodhVjzuEABA4FJm3I6VRIfAO7Kol9LrVECkxL7LOt/EoZ3JAcYHPX/5FSqjVUo2DZzeqA9T8MJ7/lKBFXbfyA6EOG+YyA0ri3xt5Ehq4gw0mnw4nyzf695853ZsUSpi/RgkpMOJNNOkVHcB/y4WdhrHbRjzSbRebl16zFWeeeU3SCsLMnEw3/xbOyrABbs5frvZehZ09/GYie/cd30WSAQzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyvK8DKOSlksY6B9ZudaqOj8Jq9WSDQmQqOBuq5XCKI=;
 b=TtcOvLCoxw4BjITLy6pNO5PZpr0+LMQid0jHuTZu2M/kCtZg+LB0NaSnF+dNAJn1w5H2BxZ5BWUOvR7f+DDC16Bd92ehKFE9nIwMknj6xcZYAu5DNx5E7BgN3AcWCjmutumcRhf7qKglob8NaDx0fk08i7SXS8piA4XsZy8xmLbHleir0tWa4n9FSwwoF/5XMIm+0Hg52E5GtQuoyyg9BD674K+w7Iyf90LqDLrF4S1eCA7IVKzyei5mLq5Whz7lf3LFGkCW2JSo92MW2bjXv8LhIAQS0LvYwMrymHwnROVYLqQrfFTiybFbobExE77g1OBOJ+SpfTnw0x7PbWkidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyvK8DKOSlksY6B9ZudaqOj8Jq9WSDQmQqOBuq5XCKI=;
 b=RkJBZG16RGhbf0kd7jhcGo+aLDae2GCYzLZUVjHesUE9P+obffUJe9biMHLl5BHEvKfg7+f5lbm+LKsIfqUzT4DdR2oU70xUM6pDx08LhhOPMxjmDnlqm+4rAqvR0AwfUZ+D/pud6nG73PHFYUChvzz0ghiOoTYfOi7uD3jsSbM=
Received: from CYZPR19CA0014.namprd19.prod.outlook.com (2603:10b6:930:8e::6)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 15:08:57 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::f6) by CYZPR19CA0014.outlook.office365.com
 (2603:10b6:930:8e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:08:57 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:08:53 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/15] drm/amd/display: enable low power mode for VGA memory
Date: Wed, 9 Aug 2023 23:05:02 +0800
Message-ID: <20230809150620.1071566-13-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa1106f-d1ae-4646-7b94-08db98ea8deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHaOYswMTD5MhOfLkuCoomTE3DDBQ6jEX7fhH2+9OJ5WAIfxZThOBAgpAwxlZlJA4ZIub9yMkBwAXtchCsMQx6koCyMefwUZajA3YD2Bnkl/SQQUWPhOnnmWLVZrn9T7X2uPRcVlCM8VSY+MGhRr3pnHHYmvnq9HvRBLUWCOsSqgP/L4PCvCCtVrkVlwuBRopUd5SDYQU7CnrujFmueapXyFEoQaoyE94ip20xnGFoixZQ23Yo+yEaj2bt3jDILKsKUZh8TDCNRVfnBUD5WEeubYYREIHuvDzF6ZV1j/m580FO5DQXjOMMgAl5lTIgm1vZFB/HFQFxJm2z1qXF7FxA3H/z2sCt+0pcxyvmb1V2sUAzwyWWjwStcdxDiZYPA3fCVSB9cMcSrMZI/2cRfPCKfLtv2cQCk7w5KvHskzUOq7DycJDxiI5IKBou24JRXeqBztnG/yxW9Xppykfx5P4eiC6VJrT8ZHfUFwPCw4IppcuJg5WWOWXd8LVgGrBmVjDyealPkDkVioWUoFh70TRWToukyVmYlHrEJk2HbzTrzsNWjKBafS2GmxxLLbKOAfHmxHk5oX8aLn40QATxC7KI5I2ZFcf+K60aeGOuTwJijkMI+hybW6bDpvjWLaGX83iQSQ+PA5TcgCV8z8CA8xFQ78R6yn/iCt/pJmBpYYyp+BLvFal9gBUdmdJDcieCilu+br9Buhgn3orgElBSFv2quI3FYNVAJ6mNJu3A3+ZsjW61OHGWHfmFo+TH5YY+HJ/x8IDMWgktHOo6iQr7svOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(1800799006)(82310400008)(451199021)(186006)(36840700001)(46966006)(40470700004)(82740400003)(478600001)(40480700001)(81166007)(356005)(54906003)(426003)(2616005)(86362001)(36756003)(26005)(1076003)(70206006)(6916009)(7696005)(336012)(6666004)(16526019)(2906002)(47076005)(70586007)(40460700003)(4326008)(8676002)(5660300002)(36860700001)(316002)(8936002)(41300700001)(44832011)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:08:57.2908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa1106f-d1ae-4646-7b94-08db98ea8deb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why]
When unused, all memory blocks should be put in a low power state

[How]
Check the value of enable_mem_low_power.bits.vga and set
corresponding bit in the hardware register

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 4cd4ae07d73d..6cef62d7a2e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -461,6 +461,11 @@ void dcn30_init_hw(struct dc *dc)
 		REG_SET_2(ODM_MEM_PWR_CTRL3, 0, ODM_MEM_UNASSIGNED_PWR_MODE, 3, ODM_MEM_VBLANK_PWR_MODE, 1);
 	}
 
+	if (dc->debug.enable_mem_low_power.bits.vga) {
+		// Power down VGA memory
+		REG_UPDATE(MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, 1);
+	}
+
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
-- 
2.41.0

