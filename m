Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C8BC4338F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5311C61163
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5311C61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA6C16E053;
	Fri,  6 Aug 2021 16:36:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A776EC2B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD/OWpqtZ2K1jSlPzMeORRMwsWE4C5q2ok9zrmS8QQmYzqjZNiZncekvOV3yPRXblbvJLykQCSVQlK3UeqYFRvPqjUTp5nMia3vUkqpFah346SYratvD3W1bJvKlwCs/BI5TOTpWdN8tGxCeHGtQPMgaF9Q7x3X3cC04AqCKqKOCOK/p7dHeSP79LtWHQexHGmFDD9M1n0h59n+PqNRwkwFp7PKaSOsYBx+z3prqugFzcacPSI4/zci5tKmmnIqr7fspigl074VBKWCq9rYdOGt3b5ZjOio6MUfLuyaaOpF7C3wRAtbNe8QFDvMX9+vYETMaSk7qjo6TIPOu5da5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJrMMG0ljY9GS/cbd9h4dVBjWwjAs3rWH/ms/WwRGDw=;
 b=b04KpfzXEUarybmgGBlHKWxQujjwgpaSTSLy6wDAOj2rIdFVLXsVzNgutD+vfGgIl37ur+978/MFrIEZ2MB+UFjFYhE/7ZBlhpAqgDPayCmAvczN98GL0np3zrMeXm2WSNnB0qBoN3yPNbV49LgBQyBMIuRfyTtx7QnBbuUdMSH7KyFLfBD5P790HGt2MshpGf0ylMhrFdM7ApRYwvDma4bRmqjnQXQ6s7Lqz4PCWehi1X/OMV4Va+HjdMPmn8OoczDYmourY2WJKYpRQ0E8JMnKJAqhHEBsD6w4GS3+ozLY0V9l3LEnbhx4qCHVRoG7FfvDAXPZhoUrkvmoe2znsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJrMMG0ljY9GS/cbd9h4dVBjWwjAs3rWH/ms/WwRGDw=;
 b=OZV5bLsTPWJUZaueDrQdDMigGJkOUdiUOadIAUvfhQcV+gKGh941jWNZLnEDcTblZBv60zoD7+mEzUkflKqVBKYNF5TJUDI6In05Pg3do7alJLybUXUnpan4VI7FB/SRlBkx13Ompk/UqLtR1cT+cLIpf9FSje4hQsNiwqvECnw=
Received: from BN9PR03CA0302.namprd03.prod.outlook.com (2603:10b6:408:112::7)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Fri, 6 Aug
 2021 16:36:01 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::7c) by BN9PR03CA0302.outlook.office365.com
 (2603:10b6:408:112::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend
 Transport; Fri, 6 Aug 2021 16:36:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 16:36:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 11:36:00 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 11:35:57 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Eryk.Brol@amd.com>,
 <bindu.r@amd.com>, <Anson.Jacob@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 12/13] drm/amd/display: Increase timeout threshold for DMCUB
 reset
Date: Fri, 6 Aug 2021 12:34:48 -0400
Message-ID: <20210806163449.349757-13-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806163449.349757-1-Anson.Jacob@amd.com>
References: <20210806163449.349757-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94676b06-1a85-4ccf-d021-08d958f84686
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2860A5F9A03F5D0C6F827D50EBF39@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DkJR09w8B36Ah5ktvC3g5HruGzxxO8W3ejkJVK0l7puNjWG3ie4wdCr4XIT3CMG0Il2m/t4Vuldpm/VfniCk/P18UcDtQ7xhNshHUWFooX60+0wZSU/xKJ66c6xjcoeVrCVRIjnRc+/tjzWWIJpwP09lZiko3e8BFJvCj3nsIvjUPuIwHUWP5e6t0Lp/r0nwwW1ysGV4QvHJvtA8odAjPePERaC04EXQH618ob6QhOAhWnp2ml/dNGg3UP6U/Bx9SFilOBYs9TXRVH62yLRLCvxxsc1YoK/bZYile4qaQSdu7W9NCjiz+WNZzSdJZdikZHeMzV9lE2PthaQDW3hbIrk12VZIFNDiqQZGeIzdEe5GRL//nW0qgN8cAAaNOFZTqoMc76rKDYesXcbWjZNkqvCU39v8zAHNLUegOPHuI67zqp7Otd++prWQ3b6EqdKMymDtOTqNflJkG0oqh0Vm5VF5gp5nbfbz1ZktJcwmqsLwGevMUYxnzEVw68KRj+MzgtJNTp3N2xeFw1syI35klp/CV4VliWOJ8UicLzFaSHN8tTaXxdhgSyx5opACNCKft8GqZ3IOOpyq+UsuwlDB8yzim+Ktq0i0me5Hr96JhDT+dX+iop+ZgLjt/8Yv8xfu/iaNyzGe/iWLRGKA7nLU5NAPlimTL52rQ96xlj+yv4EcpSfSNM3AqJlrjPyoWG4bRUJr7+5i/AMGR5fTVHBVpehZw27XNRLpVZlaJMyoy0Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(2906002)(81166007)(316002)(54906003)(2616005)(426003)(83380400001)(186003)(1076003)(8936002)(36756003)(26005)(478600001)(86362001)(336012)(70206006)(5660300002)(36860700001)(356005)(70586007)(6916009)(47076005)(7696005)(82310400003)(6666004)(8676002)(82740400003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 16:36:00.7570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94676b06-1a85-4ccf-d021-08d958f84686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If we're backdoor loading the DMCUB performs more work than just
the PHY reset so we can end up resetting before the cleanup has fully
finished.

[How]
Increase timeout, add udelay between spins to guarantee a minimum.

Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 19141bf84a8c..fc667cb17eb0 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -83,7 +83,7 @@ static inline void dmub_dcn31_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn31_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 30;
+	const uint32_t timeout = 100;
 	uint32_t in_reset, scratch, i;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
@@ -98,21 +98,21 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 		/**
 		 * Timeout covers both the ACK and the wait
 		 * for remaining work to finish.
-		 *
-		 * This is mostly bound by the PHY disable sequence.
-		 * Each register check will be greater than 1us, so
-		 * don't bother using udelay.
 		 */
 
 		for (i = 0; i < timeout; ++i) {
 			if (dmub->hw_funcs.is_gpint_acked(dmub, cmd))
 				break;
+
+			udelay(1);
 		}
 
 		for (i = 0; i < timeout; ++i) {
 			scratch = dmub->hw_funcs.get_gpint_response(dmub);
 			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
 				break;
+
+			udelay(1);
 		}
 
 		/* Force reset in case we timed out, DMCUB is likely hung. */
-- 
2.25.1

