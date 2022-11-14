Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBDDC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 21:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA7610E0CF;
	Mon, 14 Nov 2022 21:07:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6605B10E0CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 21:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmxFMTLC1QohW1nBiWHASFO/zbBKkESAz2yoNlTZtEyAMDVH2LCpUiolsJNLh1OhHhQOnoT/O8r0VCCX44T+zBdeHLBj+7ba/lmBfIAc+Ob+t1l5OJtrXlQO/Yr7STBvrdKSvUd+1vU65tTLnljYtfdPoQhGLqEcg9uwYmfAH2oESQyI6KMoL9KvV6gQDXxgutN5wmIMnVIL4ROiL2eawdE6xj1oX+9oIiE6Ipjf1T3+rwSV663gMLJTqddyhzTH+RGjKxl5qNte4F87M8GPl/kUnztgRyM8Jxvh14+5nHvHL6UqcSayyO5Wz3LL8IyJ6cdEnATNSsw6UExx9oLv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUcKdslUSq1HUdkBLOuDSjCYXJA7yzYNy3RrQfFsB5o=;
 b=E3xeJp3OuChUJJi2Ylfw2D/iMbkmyElV5Rx3ZnfpuCN6V8S+K+fBYiHVsxwr/CTdjIxmmeQZKOUtT2+fsC8svVr0SeCdE63RsmKqSOxOVUz6NbUI3ChDM9raFkKyRlIwm17/r7NTLGQM/nAOEMwk0teQABEv2wyzUAEgpXsWmBPNvcxRCmOr9uMr8+v4SdS+jscv/jMz+5blUJtdkcL7+VYSNYVgo8mqyBXg9JzQaURSIpJi0I4YoY7mjaQblCWbmOixq4djB8Sfr9IVXfFBNP7M/l4bc7yhpO9S25KIy6ohq19C3mTc78lPsRoT9sKKtCb57ytaspFJL9kssCCsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUcKdslUSq1HUdkBLOuDSjCYXJA7yzYNy3RrQfFsB5o=;
 b=qXga1BNZr/z3lGSfbNB20DoCpFm4UN6PuSTdLlvo+krAtDldyQKLpNcpzL7xnbAI7ScDxRdybgGwLdOChAGrGcfO4ZXTyk2TmBPsw5+zyLVVE8u9n3hzmR32aC7w7GOt/xuI5ztBK/pZKYBAj1WGwUTFKGkXbCoRjcNtzDEtya0=
Received: from BN9PR03CA0876.namprd03.prod.outlook.com (2603:10b6:408:13c::11)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:20a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 21:07:09 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::e9) by BN9PR03CA0876.outlook.office365.com
 (2603:10b6:408:13c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 21:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 21:07:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 15:07:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 15:07:08 -0600
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 14 Nov 2022 15:07:07 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <harry.wentland@amd.com>, <mario.limonciello@amd.com>,
 <SyedSaaem.Rizvi@amd.com>
Subject: [PATCH] drm/amd/display: Align dcn314_smu logging with other DCNs
Date: Mon, 14 Nov 2022 16:07:01 -0500
Message-ID: <20221114210701.23185-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: c23a0db2-87ce-47b9-d12d-08dac684313b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/kej/Uw5c9k83pCXig3YqYerzZ63P9Uc+RD7vw+Qk0j8mqRM6S3Ui3Q7EbxgXAUcGkO86pFCn/0nL023qTDh0IGi22PLFS3xk+Td5vERP6OGYxIxzWXhMX1HP342naldivI904cfStSJV2e4OKhmsNI2r5e02JAbQDuqo1Y9QOf6uq20gPDpCwofRX7QoKcZRh4MSISSMjg3ytIVRoHHQLXhKp06uxZH9hYKYofmYHAkDcMTvV6Xk9PxxDlhK7ZvmmxHUkjm5QE6GWgmbDibm7Mk5ehnpDFaEFu6Nx2eZwcwfffRnJDIV+/yDgiNytAMQZLLfyIqB3/Be+N8o+z0F2YbLkGYIvlOra3WIZO7yLaMbrO6GBuznfl3htCi3K3M6IC2fCd8H32wQQg7W15BEDsNN5K4FWc3rYFo7HCgcwVNBL8c/w289YuYpSa/UT6rt/m9O8/lnngNHC5HbEIWtztpWpTYihEmDT6KSPQRaJd/FCLhe1HD0/0a9Px5jAT2M2Ln3dk3vMqxugj82Y4dawQ0azzS9Qwr6moNSKwyjwiYmASNZIQWfy7xNGRUqAIQEfrqlGvIxCWgS34x7Rr6PABZolo+KHFxdLnJ9US3Y3pWZQXK93/Y3uLf4ud9ZhZ1ZwAIaJb4d8HoJ9Q5n6vUxl3sGB4AHKCcC0V0IUjv2SieiRG1VDS6uYy3UPB4w0+Fr2iR8Z/+t6zwrKTHlyzs9U8Op8fqlS09M5PW/gAKLPG35BFrbVEdRVOdV401u6dz8lxnb2v55nnJfxGpao4Js6AqdMrWUFpDeNTXpRXegby+xSASL0oVNRDxWNZFfMAWnEz8ZhEiLfHVfcnVuPGOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(81166007)(356005)(47076005)(186003)(2616005)(1076003)(426003)(336012)(36860700001)(82740400003)(2876002)(2906002)(8936002)(40460700003)(40480700001)(82310400005)(478600001)(7696005)(26005)(6666004)(5660300002)(8676002)(70586007)(4326008)(70206006)(41300700001)(6636002)(110136005)(316002)(36756003)(86362001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 21:07:08.9864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c23a0db2-87ce-47b9-d12d-08dac684313b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
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
Cc: Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
Assert on non-OK response from SMU is unnecessary.
It was replaced with respective log message on other asics
in the past with commit:
"drm/amd/display: Removing assert statements for Linux"

[How]
Remove asert and add dbg logging as on other DCNs.

CC: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c    | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
index ef0795b14a1f..2db595672a46 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
@@ -123,9 +123,10 @@ static int dcn314_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 	uint32_t result;
 
 	result = dcn314_smu_wait_for_response(clk_mgr, 10, 200000);
-	ASSERT(result == VBIOSSMC_Result_OK);
 
-	smu_print("SMU response after wait: %d\n", result);
+	if (result != VBIOSSMC_Result_OK)
+		smu_print("SMU Response was not OK. SMU response after wait received is: %d\n",
+				result);
 
 	if (result == VBIOSSMC_Status_BUSY)
 		return -1;
@@ -216,6 +217,12 @@ int dcn314_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int request
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
+#ifdef DBG
+	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n",
+			actual_dcfclk_set_mhz,
+			actual_dcfclk_set_mhz * 1000);
+#endif
+
 	return actual_dcfclk_set_mhz * 1000;
 }
 
-- 
2.17.1

