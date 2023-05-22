Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F05EC7EE2A
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 10:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 405C810E29D;
	Mon, 22 May 2023 10:10:23 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044C810E29B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 10:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD9pPMjs0aJEOgONoX7N8NRv2SSmAcBTDolty4Ga3SGUSYevdn0JW7ZXzoaXK+aIjfR4ghCh0XSZyTa7zDO69oix6KEwBsrw1Mwe1tbeamgHAZbPcKZadtWTpsT76oyPAHyTTa1eoCpgC+TZHT9wn1Y0wLhlW0maS8ZSJOG4goVKIu7XjMBHMeN/9Q5/I6Ip3LShiZYdJyrv/To3a8FPjxBsTlueop2oVu1uj8VxCjeVxejNrqd+Noc78QfJkZaajSpnPjxlz8cmgmcBNIWNwX1RkXbqLZil07rMk6LeK5Hz0YD2M4rWIT4rKFb0JZxT8/nIZAT/1YdyV41NcxOl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxZZ+lszbOmwsrppzP8fEsHK0GRXq10AvWAh/Pv5Yes=;
 b=csl9d0xImzbPmTC4JutL+fPqvswe9Qz8+i6GnSOEWXucJvwBuj/j4gZLLMSj0mTnfPM1ujWTGBSKOgEPUuDLcRfoXne/X9H8Sy88o0DlshN57kwkenkBSUY0Yqo4Buz8mtT4fPcrrDeKhd/t4chIpOSFYcLNrwKSzG/rujAIHGQKRNL86OXuO8+Gf+X57JllNcbpqHPoaz7ijq2FgAQPolYtNWUz0+aobXOyh8IihyJwMEkCaRbNG8CHQlW1tk2yeTG9MxI3al6ILIIYreaVmeEoxbxPHAk/07s0eBRA2jC9WLin1PWYAy16F603nk8tq3mMTz52M0rUsfBLzIRWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxZZ+lszbOmwsrppzP8fEsHK0GRXq10AvWAh/Pv5Yes=;
 b=r2ioUTs3RdNhM/a6pQn67ghMsACbaqoWu4Y4VXYGRKTepW39ITRzfAQNChgc+qXFfrODnvPSlddqt2KoCc+EU6GckOgj5DJOB5/377we53IRlWjTfk3lVQ/H68ljZpXmlIDfVLx3SJ8UAwbzdRUSNBaa5TKHC+RxGRVighDuzhI=
Received: from DM6PR06CA0057.namprd06.prod.outlook.com (2603:10b6:5:54::34) by
 SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 10:10:15 +0000
Received: from DS1PEPF0000E63E.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::5) by DM6PR06CA0057.outlook.office365.com
 (2603:10b6:5:54::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 10:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63E.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.8 via Frontend Transport; Mon, 22 May 2023 10:10:14 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 05:10:12 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] amd/pm/swsmu: reverse mclk and fclk clocks levels for SMU
 v13.0.4
Date: Mon, 22 May 2023 18:08:29 +0800
Message-ID: <20230522100832.1968912-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63E:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efccec0-c417-4d67-46da-08db5aacbcb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWV6a/2mZB1cLInVVhaWHXKVAg4owTRPgOIcyuiOI41H/t2svV59bgM1TGDij5zJxfQiFovZOa/st0o+FaJ7FijZuTeZFnHGs9sFHvS9rA0d0JFkncPTlz1HRqvT46bFxCH9yyKsyhEZNjzL1pCzAZ19wq5k+SJMsRkfx0qIaSafgUixMNzt9pLvYISBa2hy4Wr0fxYb4D87ppEy8PhGpxxyxdSUr9aEqgXJPmfhCT7Pc+IkdWldhVhTydRyHTMJrHd8Y/FKkHn/xYqPl+3Gc/02VSswEUN/b5q2Q3rV0pD5dYJvbGUHIODGaE4axkf/++19E9ju3b3Z9RGoTSv3OE2FGAoYurSmSc0GuVLGC6jcHxrnl66aFoB5XA5+CezLHHDVGkPgz/dYYqUEhiUXW6HXX3AtWcNg/VEnVW4QRSduxpuvwDn9PnS7gu3KS+zBf/m+Cj2wsCsVB9IDuvT90x1ZKO8oSLfKEKkEFuHOf+I53j6MqaAdHY6oCA/QXXvbMskOv16l5YNsrP3IXtIe1z7AOmNamZEAKBoC7Mot05She1Hby5eXQTz4hEPoKxIqcKl2Q29ENE/Z9ertfRmTMnhETD9St/I0/NAjeZUH0plVnA7p7yzflwnNHv5yp4N5P6ARd996TjfAk2KLh16/WLABM0N3Y/oAt5sTNzWY3LnxvBqsX3Fc8JYPmpanSwa1ccrN/I6qn7eOeTNS83t4kYRClMY56z/AeE4owq8NrD65Dj88kt84uNz018w5rzjkjxQpefNxa1+VGh+53F0c4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(336012)(426003)(47076005)(2616005)(83380400001)(186003)(16526019)(2906002)(36860700001)(4326008)(6916009)(70586007)(70206006)(41300700001)(7696005)(316002)(6666004)(54906003)(478600001)(26005)(5660300002)(1076003)(8676002)(8936002)(40480700001)(82310400005)(82740400003)(356005)(81166007)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 10:10:14.9278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efccec0-c417-4d67-46da-08db5aacbcb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
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
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 0a0a7debb3ae..46a8a366f287 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -478,7 +478,7 @@ static int smu_v13_0_4_get_dpm_level_count(struct smu_context *smu,
 static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type, char *buf)
 {
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
@@ -512,7 +512,8 @@ static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
 			break;
 
 		for (i = 0; i < count; i++) {
-			ret = smu_v13_0_4_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = smu_v13_0_4_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
 				break;
 
-- 
2.34.1

