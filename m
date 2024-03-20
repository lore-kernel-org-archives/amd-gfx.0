Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889C9C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CE910EE72;
	Wed, 20 Mar 2024 06:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1DrGIoF6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6281E10EE72
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU+bM2/TOKDB2G6tkud+7Sj5HcPwSeveoBw9ocsUI+DAxIo1MUSP6pa/dWyJCyz2SE360qx+wDZs73TZQYbPm1riuOqRWEZcsLdhSJkY0p7baxUpAljruAMxIdERQr5/Ye/pulXIdt/dGCrvw2D9pjFwhyqpp5GqP5smfmnDCr27ZJnTqofPimxM3yfYxlMPZ/k4wkl6HTXJzG20IKsyI5s5/ZmW3QdupEpCCYzgGCiFGXZGTsYnhvONthi/U0/2fpxwxUIltSFvm00wvm/4HvICMA6h//GAYpa8WDjiowR5wxLvZVMYE+nWjIloEyy2oYRQBcv0O6NJuEBnXynFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6+ufv2UWDPqaL9tAmqcsR1DQiRlroP6SPlhNZXsnZQ=;
 b=fRcd5iadXsnzPFqbaTgpTTim0FG6W9g2qAy8LdYyiIQoswCqnV/oWgeojL/klYXpB7Tslm9NlMMGPiyycO00SfKkHvQCWE4X7gMrC1Saag9OCDpfsxXrvbn72i0Gbf77MNqgEjWExskGopcg3t5o9vocQYZUBpX1+z+tolt++bBNZW2GIgRhCdT9TXYVn28hM8cnav8qcznDd/C7fzGDhZmDLmuU8zZ8z93G+nqOzg10w8rXkBY1zYPs26sk2mlcWyOFQHBb2g65eR2MxOiROpJcEr1Xmn7Zg1UsMUs5d0tfzAyPEhq0Syw7SMNlA4oi05tbsub/tNOfFoCHIQBJCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6+ufv2UWDPqaL9tAmqcsR1DQiRlroP6SPlhNZXsnZQ=;
 b=1DrGIoF63OQ7fh4tXgfiG9cShyJ8Xz5AvgoydXrtPXGHp2wMKvMRu5+Um4V0dIh9JkwX+HASTNV1hazO2rvefrs29Ivm81w8x0CKRslR/vhVNRr9zoIPYBjQlG2z4oEWz3L6fjIiyRFD6p7Sz9pMd2nOqGOG2l/UE7tG3lPWjAQ=
Received: from BLAPR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:36e::6)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 06:36:56 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::49) by BLAPR05CA0001.outlook.office365.com
 (2603:10b6:208:36e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:55 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:47 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 <stable@vger.kernel.org>, Sun peng Li <sunpeng.li@amd.com>
Subject: [PATCH 12/22] drm/amd/display: Fix bounds check for dcn35 DcfClocks
Date: Wed, 20 Mar 2024 14:35:46 +0800
Message-ID: <20240320063556.1326615-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: e4796009-7048-4aa1-6521-08dc48a8235f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oREBYeAvTTh0t0bBN0G5gsXIWbhybDf2G7gQ9wvNoF+cy1N2/VT4emBnJgJoxyC9TgnE6BO+NDRDIImXL0NyqD5zfO7UUXLnefK4foCSgCundIORCZtrwcENGw7y1ieBR4f0ssrbDEGt/Dk6gIWgE+9NUSNvUlpJwcjqm4PTu56b9dY2mbsGX+IT1zX4lFWzFNTsAkpyuF5K4nxaPPbL5FzX7onCwWoLGqkQisumCIz62vz9fV23imzcy1q81j2w+FmzweL7Kp5qjCsexePefnpfX+FUCIlRDnLPsCFsqV0pb5haT/tIJxgp1jHgZchnsRQYgUtnjIt67l5MSAUjJdNnCfZYLUKWHCHYa8fxI4wNwibmqr2zPGcfXoJ7/GL96dBTDy7P26QuAWEJ0Gfe8TFMy5nXYEopvuogd/imF9dA1fMOmsdYkAmi9MDxXNkCf99BBWIpLztSI9/WnvApDWnB1I+H1BuuAow7aQ4ODgo1rL3iORGwit+s66B1oQE5gWdiP+vTqElRXvFjyafyzSFte+w25UxUWgt0iJyabGa8SB2uEN9MbXQzfiLsH5P2hKSUeAEREN3ZcrG4xb9DVXMc3kK4INoco1YkHaRW5Oyh20MLx9HozRzU0xDU8R39qEKmG2Uc1Qh0kYEe82FMtxfc/9i2HCaKU2cdFSvQlUlGmCBb2evsxtKtw1hYvBmVSGeS1z2Tr1pjBaimjNaIaD9Yedr2Qn/imABp13gnRsCLOUqRrCdwq8wkPRNGLC9i
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:56.4615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4796009-7048-4aa1-6521-08dc48a8235f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
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

From: Roman Li <roman.li@amd.com>

[Why]
NumFclkLevelsEnabled is used for DcfClocks bounds check
instead of designated NumDcfClkLevelsEnabled.
That can cause array index out-of-bounds access.

[How]
Use designated variable for dcn35 DcfClocks bounds check.

Fixes: 6b8d9862159f ("drm/amd/display: Fix array-index-out-of-bounds in dcn35_clkmgr")

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 928d61f9f858..8efde1cfb49a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -715,7 +715,7 @@ static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 		clock_table->NumFclkLevelsEnabled;
 	max_fclk = find_max_clk_value(clock_table->FclkClocks_Freq, num_fclk);
 
-	num_dcfclk = (clock_table->NumFclkLevelsEnabled > NUM_DCFCLK_DPM_LEVELS) ? NUM_DCFCLK_DPM_LEVELS :
+	num_dcfclk = (clock_table->NumDcfClkLevelsEnabled > NUM_DCFCLK_DPM_LEVELS) ? NUM_DCFCLK_DPM_LEVELS :
 		clock_table->NumDcfClkLevelsEnabled;
 	for (i = 0; i < num_dcfclk; i++) {
 		int j;
-- 
2.34.1

