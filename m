Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7125C77B75
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 10:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B12910E13A;
	Mon, 22 May 2023 10:10:19 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F52210E13A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 10:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGQE3rQuBZ/QxLzDEgP4aoq+H6BaFKplLlWVB7kb3PHGvHJdXKP1gb8f+/753R7oqIleWlNmECq1avGabZcxn5XjtfGV+HqXCFqTW30P0g33ZCCxLRX2tff4yh0nLkbpsqXK4ttRkCqHwM9sm/M0uoYw282SfbK9wSBmJZcxiuwzEbaKjd8KIWjulG2xa5mT6DSZY6BSyXa+wxeOWdbwedOnjB8IJSgV16U5hWfb8zRKl41lDK4Czyd5kUOxuA46WUCit0Zijm+o9Hs3x7RdglbuJgXeKHesjw9EMk+EGD9AqmRbd+dNqhhWzEI9uCFv83DaWN3JhT1XZOkqEGZmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YM9If1jGF4UR3mBDlw5V71InJ0vOzuP7jgQE44qNXhM=;
 b=lDVV/kXJJq12m+BCzSDWtLn7+uaZeKsXe62ymlkxEynfpNJPB6eU04cwhkj3rzgckYpA637zb5YyViAq0JOZCT6rFl7p8LDCsZH9iA5ykAXSph+SGvnx9UGSmkhwEH51TZRSK9pn7AUY2q6h0A3y23C55pVqGTKovY3oigMTz8HuwxCRJs7Io4vPbfIAv2aAiB9bgTDbtsh5nqydl11Q+41pjQ3GLLQBPZhtXGIhvPV6QBJO0v5hbtOaiemhb089i9tbyL3rUpAvcI57LcbpYSe9OYxxVihNdFNlNulh406ZkkIEbgHIa+k7yaSnjm5rFnlIjxxdI+H4/Q7C6jvQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM9If1jGF4UR3mBDlw5V71InJ0vOzuP7jgQE44qNXhM=;
 b=zX9qSBVojOsHtingmXAfi3IalLCjVHic5hg0uevjqmxPfsFs1CNnkFUHxVpl4AoHuFB+RJ96rEEXCevzojSAMlAeVbRWS8MBqldBc+UyyizzLcq2ACKK+pYIEU4hMYqscUN32YjLWqUBBKlGtld0/Echkm1An8vklA3Lzj1PbOo=
Received: from DM6PR06CA0057.namprd06.prod.outlook.com (2603:10b6:5:54::34) by
 DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Mon, 22 May 2023 10:10:15 +0000
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
 15.20.6433.8 via Frontend Transport; Mon, 22 May 2023 10:10:15 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 05:10:14 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] amd/pm/swsmu: reverse mclk clocks levels for SMU v13.0.5
Date: Mon, 22 May 2023 18:08:30 +0800
Message-ID: <20230522100832.1968912-2-Tim.Huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63E:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ebb995-1081-44e9-4126-08db5aacbd33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZslKll2Rv9Tv4SXVgc82ACyyUI8pjNiJFBmXQiH7UIJlm1fqPUkUGPWja1R+Z5rcIDqRME3pxZyMqlZS3Cb6JjM3j5vSaoze0J6ttkbZTDxfEKx0D9YtdMdRR4aKA5pTnDE8v9e8VcsgL18eIMS/KtubZ6FaE0lOJfQRkT7SUJ4JVi4KQy9OOjZeIrttSQr+U5Xz9zIAgHx1h7xTO76sTjxQVBYM7k/zlkLf3mf6/QL0/pTVBEZM/k51u41AyXQdmHxMY5Q3SeOmEMZWJomjxluiJOjOPsDWLntnrtR6VPXICPuOLDivxXEPV9aYT5gg9OQ0HwL1eo7kEZDJzXOYCbZwWFxCQ2Yp3U6WerbR0zCsxyMeOLzdi96y+8GKFYCfycjDEZvrUa/OgJE60w7jgipXT3WslJjF/+jBSYwvVVkhxUQHoHoDp16vML4QbgHoqDetETS8GZ0yUrWWTHtLpR+3yMf3NrLsGUoEr6MwXDw/0kpmwJKul+zy7LaF6dOYFM7WWFBoJlWUyrx4oanaYjBnSjv/i1TR2bJfUp5FFEF1FTKbLJatNOaBZ6etpUVdjQVGwq9mCJWP/Obu/oJCvOYgWp2dItHsZcCbT3AqORtP6kEfP+YRmMaTLyOeBDVOQUhL6/T9Mr7U4njdD36YeWcMCKl4bGaOp3H81XxDtd1lj8foYv/CDlLvVaZcju9w8Pr4/PVxSvqE4vsAPe1+rpRDbuqWWDCvV7q5x6xPnoH9h7iJwlD7d5G3cQDLDTmCrgYNarSvdiYUOuxaEAvZFfqbETB5NaJ9bJXcQzp4SrV92vq36IwWLfsjgWgLGjA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(8936002)(8676002)(47076005)(5660300002)(36860700001)(82310400005)(16526019)(186003)(83380400001)(1076003)(26005)(426003)(2616005)(86362001)(81166007)(82740400003)(336012)(356005)(40460700003)(41300700001)(6666004)(7696005)(40480700001)(70206006)(70586007)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 10:10:15.7403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ebb995-1081-44e9-4126-08db5aacbd33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
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

This patch reverses the DPM clocks levels output of pp_dpm_mclk.

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
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 165b2470b017..7c3ac535f68a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -866,7 +866,7 @@ static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
 static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, char *buf)
 {
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min = 0, max = 0;
 
@@ -898,7 +898,8 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 			goto print_clk_out;
 
 		for (i = 0; i < count; i++) {
-			ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
 				goto print_clk_out;
 
-- 
2.34.1

