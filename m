Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB138FD45F9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 00:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A80410E079;
	Thu, 26 Feb 2026 00:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mlF3cCw6";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010008.outbound.protection.outlook.com
 [52.101.193.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9047F10E079
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 00:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhL3Z7flwDY6t1jxhUx4b+D9C6yX/YVKuqjb1ZanjoU0Ebo2wIVaIKLKgXDXAFVxL8g61sg2t87lBDjIkFD+VEAuqqxSdDlcczqg4th1rpv+THPrZ+yCpO1OaLsBfQfN8/sbNmPhw3xvtQS5z5zI0qFNSdWnzpP60c2HcrnHD/4mX5/1Sj0rlMHQsjDOSvgFBSayyLzjnax4RIs9OQRQOt4xAttx34u/90Gcv6IqfFgekvSVKB3Qprk8B3VozJe1MewMELZY9paqDzsHu1TTr92NZkwjcvfRy5CvUl9ln4kI7e6TgOkVPIEAkwbxxiYFjrtAPbdrwclgppq0+fC5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se/YEZBzSjKzxV9Ct3UaNtYjJIZgY+48O8ZB0F6ENKI=;
 b=gD4HbM+I39kEscAB8D2C6WeCokbc5wHZz4/A5q8TQrW0JFMS2NIhbbg68K4FPCTiibO8mwX5HVh4RgCWdJPjQHSjxPywt/SZJenwY5+OpHSt5E94ST3CB6Rxc9THPSABoJ0AbCn961Mqc/XlFyV8hMBtZAg8bPjj98jTSLFgLhTHABcOXuIzyy97jp4cH4mDUqhiLevcQWci0PeiqdRMt+CTs6+/ME8qZp/mWi+8l3nescgCzzY3YakNU4tB+omzLdScgBheV0P1Xt21RZmw+2cUT+mA7zSMraSGe8UQQeLDeKLq+6CW655k+UbyvG87ddUQsdspAVqUtbW9oBkggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se/YEZBzSjKzxV9Ct3UaNtYjJIZgY+48O8ZB0F6ENKI=;
 b=mlF3cCw6Xq7lIt+g/WNFAAzQmL0mVZbYvXcvsh+ZQB+Q7svOvIo40ifoZTs1/XAQOnBHEaZQJp51bnL9z1epj/blxmFEAUN9uxa1ebiDarbSMAgtVbh65nHqOeXFuZP34zadlq+51QaGjE+yENb30Da3BgZ8c6J5lAOmet/QXb8=
Received: from SA1P222CA0125.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::19)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 00:01:46 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::c9) by SA1P222CA0125.outlook.office365.com
 (2603:10b6:806:3c5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Thu,
 26 Feb 2026 00:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 00:01:46 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 18:01:43 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 <stable@vger.kernel.org>
Subject: [PATCH 2/8] drm/amd/display: Fallback to boot snapshot for dispclk
Date: Wed, 25 Feb 2026 16:57:41 -0700
Message-ID: <20260226000048.68030-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226000048.68030-1-alex.hung@amd.com>
References: <20260226000048.68030-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d29377-73f6-49b4-0719-08de74ca3b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: psGFtkpMGNkyndD7B/ZbsYUZVnB9cX0tbgAugkf9mQaKHcbYRS7rPVxjPmwUBjYIvmiUCdcipezozsKo9xD4cDnADdnyaJMnH1VOJDHTq2DjlvO/K/N0Kg0ZqSMiVVaTBKMikYH397YARizS4GMyUarsolM8dnj00v1fzw9QMpl0JnVF4qrFvAeI+u6XuJEQcoyBnTY+6oq5OIm7XoAnX/q39uIprVlq9EQ8f6tQ/kGPdxe6A6axPIfujbuC1o1rVSGVuNBvjTJgRwrTG3lTfgxpsq3xahMD5b8OxlrM9CCBxLPz+/xbxHFazf7En5xOufu4tNX7OVKOTVKs/GmoyV/FBKD/804V10kjEZoUgD7cp21kU45e2Maos1EHVj2V2/gigAnLXFS9D+9YgFeiUYunAce5TVMg4Acnc1KnFwxXSEo1oYiUsf9m7sFOVBfDaMYa1LdQAkFugLQBv0q7MQkgVMVyHaof2u8wIRqVZz7y7YcX3JjfZJpvz1n1te9mr2OcapkUru4gMeUKrCypOkMoa4xbq/sF5FyfKO1+24ZRC/tN45qsiC0Hp/OiTYf3WAhY2WsSW70nq6OZL3H0WXUsp+zP4ozhLuu2Lov4ohEALfxzXWu69vlc8QaKj5X0giimXv9X5fxpoXwPDCMLeWJCzrumj72AcHr2lPkxTbzS7l1RLxBRTu7LpeN92PwiFjIpCuutXyPYiQBVMUD6sMTqfIOsSYPdpPvCGLYtxWcytGAgVDbmG1jY9RxP5g7Svgr/4pp9ER8XxIYNXgHWGN1cyzwwaXf9lviWUdeUv/TfFN4G+rzCkeq1cPXOvIKY0h00i5KFipKcNOLwlZc+MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ELKaNUzgWJwxE5jpqqoQ6xgNQ1iQKeKZRlT2aobtgMD5cmL7iDOyv9f3DmYWguE5dlIZdLpFZx8FxESyBYmUwSWY0QZHGYmEC4pBkvs+oXXzgVxZtIIMa91nzHs8dA6cV6QadjCepDMhSJY8ptg3Rh4qcl/EN5TCOqYn1omfZph37j+lzSZnfUoh8xy21B/5DPAwG2F2EcyEvMPUTOs5A69f2y6lL7KNM+i/hoqVs5LBazUk2hLmOfrF2iz8dOjl+j6C242j0QQfueWD0ybF/sCzYdNYUH35aXZahgeG7Q9jpFYuepvVIvEIk2aba6SA82qetMMtclsMM72kcw7WeJ2ilNeSCzGPNGxakA0AZreyPo/SbZCT6ciEXuD83uFBP2tXlWL7CvdMz3cdER7aNv5bGv960+7zhJqkqy/ZFOviW5rgoeZ+yLK5pMBso6jt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 00:01:46.0664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d29377-73f6-49b4-0719-08de74ca3b5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY & HOW]
If the dentist is unavailable, fallback to reading CLKIP via the boot
snapshot to get the current dispclk.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 95d9e17a269b..69cc70106bf0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -72,7 +72,11 @@ void dcn401_initialize_min_clocks(struct dc *dc)
 		 * audio corruption. Read current DISPCLK from DENTIST and request the same
 		 * freq to ensure that the timing is valid and unchanged.
 		 */
-		clocks->dispclk_khz = dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
+		if (dc->clk_mgr->funcs->get_dispclk_from_dentist) {
+			clocks->dispclk_khz = dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
+		} else {
+			clocks->dispclk_khz = dc->clk_mgr->boot_snapshot.dispclk * 1000;
+		}
 	}
 	clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
 	clocks->fclk_p_state_change_support = true;
-- 
2.43.0

