Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CF6C77B75
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 10:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F2A10E2A0;
	Mon, 22 May 2023 10:10:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA14010E29B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 10:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImNzJ+ouWe4kFpxwlyzT/xf1t6zoLeCq2buD6Ijj7Nm+d+tnLTTQXXf6ysPd2dQwwvr+iyUElxMsYeAweMVeQMVuAY66CcIDUUBohSFagJ3tKrNLfUkmhHj2xpRSPpb5giMnHCjW9KAkcEm2nfIYocjDx77wYcqIRWvd2Zu5sZXL7rlGLXQM+SNT77dP+k/3jJE9mrRtFtd6Aelu7IgTHIkmK3u7Qi+p3A0ea1DJrfITRIzZEyre0RAFBp/0ityUCQcz3jjfKsz2xgxsuedtOqF6nGgRmv55Rz5R5WMXRVaIwkuwA6QyJMfAkNvuBLGR9HZueAU3FUrqoujWAPAH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlS9h14OUx6rXahM7aMnQtRdz2oH7Xi83mL0cuH/jBU=;
 b=QsLViwh4jYNqcwDAB8bn5b7jYn1UtfOXA+zuVNd+4mYUOqXF9jvBHcc2oo0dUKlc8RCY2SoMxxhELwdsmaNkaj9hGpizAj3dfW+WE6HCmznKJXDj1MxzVax80qypXlVx32KXGhKq+Be/LcmGU3A8pQ2mY62RT0v0tSfe8DAXQ+UZ5x0NHcrs4Ra/Wpvso1tbNqJAtC9S0PgKlUolzeMj64VCBH+rkC2JC324+4RnLdJfuVATTuEoM3svPC8qLVbrYp45RSwC6uzkwp64a2kVgZaY0apluc3m6HQYeE8VULMzhclIhdkfyYZTw3wsoOZsRaYu2pOBM1pbfM8J9o0KYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlS9h14OUx6rXahM7aMnQtRdz2oH7Xi83mL0cuH/jBU=;
 b=3ws1jiZFpCOostixYzdIIUFT9BHuAahjj55IIbawpe+YvRSmE3xdxZ68FZDF64wxYJVa/MWh2+9jSoIhRxVLOu1IP6tmNx+MOOwrg0vyFC/5SXkndTte37yPmZ4uoPWY92pgbT8aSGNl7qdn0tgawDIk7qCKGNng7poEIMPZ+LI=
Received: from DS7PR03CA0267.namprd03.prod.outlook.com (2603:10b6:5:3b3::32)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 10:10:17 +0000
Received: from DS1PEPF0000E640.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::7d) by DS7PR03CA0267.outlook.office365.com
 (2603:10b6:5:3b3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 10:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E640.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Mon, 22 May 2023 10:10:17 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 05:10:15 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] amd/pm/swsmu: reverse mclk and fclk clocks levels for
 yellow carp
Date: Mon, 22 May 2023 18:08:31 +0800
Message-ID: <20230522100832.1968912-3-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522100832.1968912-1-Tim.Huang@amd.com>
References: <20230522100832.1968912-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E640:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b366504-2753-41ec-954b-08db5aacbe41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/mvPSi0aJ7dizmUxpSDSValoGLIkZD6qofQqRP4CMCLDpZWvwaLXyF+O8WIo1IwkGUAZp8EccrSBNf2H+5Nh2j1IB27kERcDcFOjjEJTweZdAu0RXUOupzf4DbFy50smRkqg0YfbybPh07kehOk+NLCk0P/7c5lFtYsDjTxsdIHhek22NuT9Y6+1pLxLHXoMRPSecUHvr73r4JRNnzuTMqD5LQWwOwVw0r86vPmDdN1M7zRvYP5QJcsrVj3K6FEv1xD4SwRN9JY4MgQ550+3OxQW11aU6C1x7xP9rtczy89HtdK/0LwtY9sj/Wzh77xIN42uSPi5WdCZMaIPhgcBxkntRI4j3avHVJMRP3SgkZQ1oNOoni7XRqVB6mzAZdbZB3CKuV4xq+wAxTzN4d7ofHbWLHJgMvg2PcE8utj629+NforTmYeE3Z0NTw2hQpWfWfq41pQTNTkcGjmx1+4bm0zxhfWr4SAppodBz58TN4lM5YF+OLqCSs4GgMk6DyJZY6kzV82enTdK1nzXiY0fiClITqjsUNfe2Duh/QU12RtnoeJwSu3rI60V+nzAyYYbBrQ9dPTiVhNyVYfCkPNaoqaHnK108d9G4dlksdjsOKfveSiYlsj3cdQvT9rQyTLMnYctslSjFygIOcL4Hp+v0sLXXhcqIJKptHM3yKhVPOR+x3Pbm/7KcyjEqcp5YyhW9XGM3RBNG3oti2VwuzkCNCCpoFaO/wcbXmpOincsiyNlnCspWqtXkpQqTF/68RluplJR0rHl2GbjzHtYER+nA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(81166007)(356005)(82740400003)(40480700001)(40460700003)(86362001)(82310400005)(36756003)(426003)(16526019)(1076003)(8676002)(8936002)(336012)(47076005)(2616005)(2906002)(186003)(54906003)(478600001)(316002)(4326008)(6916009)(26005)(41300700001)(5660300002)(6666004)(7696005)(70206006)(70586007)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 10:10:17.5119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b366504-2753-41ec-954b-08db5aacbe41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch reverses the DPM clocks levels output of pp_dpm_mclk
and pp_dpm_fclk.

On dGPUs and older APUs we expose the levels from lowest clocks
to highest clocks. But for some APUs, the clocks levels that from
the DFPstateTable are given the reversed orders by PMFW. Like the
memory DPM clocks that are exposed by pp_dpm_mclk.

It's not intuitive that they are reversed on these APUs. All tools
and software that talks to the driver then has to know different ways
to interpret the data depending on the asic.

So we need to reverse them to expose the clocks levels from the
driver consistently.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index ac5fcca0e47f..a92da336ecec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1000,7 +1000,7 @@ static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
 static int yellow_carp_print_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, char *buf)
 {
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
@@ -1033,7 +1033,8 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 			goto print_clk_out;
 
 		for (i = 0; i < count; i++) {
-			ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
 				goto print_clk_out;
 
-- 
2.34.1

