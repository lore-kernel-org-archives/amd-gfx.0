Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BCBC47422
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A56410F64D;
	Wed, 24 Jan 2024 07:02:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB11510F64D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMgD3cMkkpg/suU9XxpezjtpUOwnUSr7n/7aL8PNXcv4sW7wfDRfk10gAaLk7HSU8zfLF7Je/ykCSOYf0wha6kWX5yUBcoDXryatt3yo+UDK+AxCbx8xpvqLFo7eD5M55+Y7KroXBt56k2hx/ZXEY2KVZ3MMt5Oa5AAFvjKUcHT+caGqUe9nGTk4MenuejojhHXCWAFmoY2h/PEhh0cxx+OTzPSVDaoHqYPgYzDnGGBY5dVgvcXkQaWC+zCVDochM+bfbM1lp+A689KxemeqxPTcARYvh4VpO67OqRkhqStDPIBQ/83SXj3cFhSTF4osPjLY06fAOI6L6w8tAy6jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t08Vj+5X4bAaliGgzNnqS2S81YF97Pqp6d1GL7tCevg=;
 b=cTOkJut38RFYXZrY6i57EaQWeMjUY6/OWQuOpO7bqzwv4yDx8qdGf1AYq6jY5mIY3yTvtpGNxzW+Pk45Ht76wPc04uQ6FOcd3hoAMrvgZmP471jhoLcY+sWdRRXU+5Y8gW+HFT6mpTQ2Vx46ZV5tKM8lo5Pk8cYAPRjgVNMAD8RTlqXc18zFMiunQzC1VsIwRJDWgze1B3y57CzA5zqAkYqJxmV0+U03ecfSt32+31K0Uti7ZTobqaFlG677TOYBK09gexX2RkyMGjUBa7oV6R1vw+x/ok4XPSb5I4L2T+KziiSlyiEEkwydvsEPRAKKrXOsUfMmU2lU01dMF4rY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t08Vj+5X4bAaliGgzNnqS2S81YF97Pqp6d1GL7tCevg=;
 b=oyVAfgh/M2OEo0vXTL5iDsobHE4daQ+z/7wx75m95OvEF7fi5UjaqIbuQy9axDewFb2+8nRTD+q9wd5iY+wTWbXGNfAkLDKMEWs2ZRsHAAtmjBMKPCTFSLGYUWFOznpJwNLGW7Ki2Ap3UPEp9S2zDy7xCJnUlIDJNfiuCkeL3O0=
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:02:42 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::5a) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:41 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:38 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/22] drm/amd/display: Send DTBCLK disable message on first
 commit
Date: Wed, 24 Jan 2024 15:01:47 +0800
Message-ID: <20240124070159.1900622-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc371ad-88be-4e88-c2b1-08dc1caa75a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqd57+J0+ov2zArHQkgUqf3m2r8rXYMNoPPVMIX4GHIyqnKDRaCQQAE4bemqInEB8+7esuCnIYgCuUQTqVu4ryOgvY/xs41dAtkw3c1Une9guqTX8gDsgKa4rlY44QpQi17EZvELE5xeAb6qMFbWoxA1/cfCYisC0gkJ4BYIed6R9XTLEsWtb6GtIY46K6rFWeOWv3JY1srQKVTCS/kp/8pvb01mkwkNZYvq8VTLjSb1iDlPzacDPwA4guw0eSbwHLzvpmt0P2dnykJKeRiPbw9sbfuhrDC3bAF4Yz5sGil3QXxTDF4ltZjWLk2pw1ybGO7COhC51wWN95Yz9GGrlPWNE9eH+Wvor6qB7h2RAb7DWiS74Suq47bcipl9y1yuW0I0sZkz9M97SSTFgBmJuDrg5bByq7qsJbim9L2vdLGpjAR47CgkSHBJbt0kA7zruU1G2oRW151DtDls6v1tZHEWsbMxB/wMXLdue1/NN92TO+/3YP/t0ed4gXSJof5RpVMapdA1oTaSvxRSKVtJIbt4hi8qdkspaXRHRlYA8E7L2P+StWgpdcL9Eyh+PCcRLFx59dk2TXQv2pPSJRC44RLM1Ukso5iLtyftPZQxU5bCJLMjDn3JWvFynIqDYID/hm1ek/yJDPRODrsJ01yz46iH+WX73qQEE88E/1n0qU/jX1F5Nbkh/enozP4arownLayptZSzlCQbCsFaTnCv4UmnLxg8Byufh5Ub3yBnzGkTpqtoytugkFhm2vlTqBVQSjglier2NyOmL7+s/Q8WAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(4326008)(15650500001)(8676002)(8936002)(2906002)(5660300002)(316002)(86362001)(70586007)(54906003)(70206006)(6916009)(36756003)(36860700001)(47076005)(478600001)(82740400003)(81166007)(356005)(7696005)(6666004)(83380400001)(2616005)(1076003)(336012)(426003)(41300700001)(26005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:42.2242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc371ad-88be-4e88-c2b1-08dc1caa75a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur Hassan <syed.hassan@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why]
Previous patch to allow DTBCLK disable didn't address boot case. Driver
thinks DTBCLK is disabled by default, so we don't send disable message to
PMFW. DTBCLK is then enabled at idle desktop on boot, burning power.

[How]
Set dtbclk_en to true on boot so that disable message is sent during first
commit.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 0e5a3184f01c..3d1a60cc2908 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -415,6 +415,7 @@ void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 
 	// Assumption is that boot state always supports pstate
+	clk_mgr->clks.dtbclk_en = true;
 	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
 	clk_mgr->clks.p_state_change_support = true;
 	clk_mgr->clks.prev_p_state_change_support = true;
-- 
2.34.1

