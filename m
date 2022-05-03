Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE69C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E1F10F44C;
	Tue,  3 May 2022 20:37:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F63810F505
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDnTGjETlXf+pRDEidthTM/iK5z0VachAtUqRB0viUiNpZcSJtKtXV4H/7n5G7PDQ010N13SUZNCPCyhEdfEufr5/hhOfHWzKHUHkoHqMR3xCHwAaxrdczBwb3GKAWrkXfUvS3YUYB0wyvLmB+5rypkcZ1yIHCbfgK0Jjj1SQDYjE72+RH4TzdhdC1oxaEGQuZMAYXemgvpuD9sTHxInUVYEGxBjEe+tA8k9Ss5+O7UP0Fzg9X+SPhIsMp09LGD2VKZcZG34FgG0RS+8K96SQRftIjF2gq7HIM72GQLr1/aL1ZKtnjl0qxfv0PeORfQQscPCF9q42UVTFGDn8kWDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E41iS8bDfy2oAYyRaiZHOU2CmztT32R/9lCzfdKVAvY=;
 b=bNO2iYnl75XQwbcz06DoVuY7beYXtWK7RayzYLD1I95maXbai5AN8FEx+R6rYHJMSE2QmJsY1Z8d1ZG+7geLWIdEHBbao9Lbp4df2chDPB7LYqP6DS4ZiGBzgBOndzp76z0k0AGwd81C+leMftybcZp71onRROILgIkXKnIM11ip3YlI4KMubGB3gz0d/X2clJpySBYoBG8a+5WmAj0EU47OjXo3hgkKONi4sr2yNQCb5ci+iCepXSdXRyo+yqtLBR8jfY3MYXXaDTV5Vb6csVvANRxEh0r29Z6Qw2G+3l62IeY8zTQ0vv0urKM0TksLJXmVORoSyHnZyCoNWfDbaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E41iS8bDfy2oAYyRaiZHOU2CmztT32R/9lCzfdKVAvY=;
 b=fNnv9f3MPkKRPXbQ24VQkyXYierJI4eW7uiG2WMCOgzYPBMsVkbIzkVJBY5SbaQw5RcgGYPdBwfoV1WLavtqB6/G18d0cJKwCTNj+Vk9IaKOSBL7b7/SgyWTiE5tjsgCJbhYANqixKhwAYYAblR6IKzGBZwVRRgrjMLwszYecPo=
Received: from MW4PR04CA0138.namprd04.prod.outlook.com (2603:10b6:303:84::23)
 by MN2PR12MB2910.namprd12.prod.outlook.com (2603:10b6:208:af::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:37:43 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::fd) by MW4PR04CA0138.outlook.office365.com
 (2603:10b6:303:84::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:37:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/26] drm/amd/pm: pp_dpm_sclk change for smu_v13_0_7
Date: Tue, 3 May 2022 16:37:12 -0400
Message-ID: <20220503203716.1230313-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba19bf6-d6b6-4be7-957e-08da2d44c60e
X-MS-TrafficTypeDiagnostic: MN2PR12MB2910:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2910144D27B8131626DEA2D7F7C09@MN2PR12MB2910.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ppg4EN5VUF9Nw22RS+yiYiyB2AfB0vHvA+D+263pOA+suEd6ZdAU2DqMuKPSOITGDVj5Mh9PgaLzAqtOE8VYHDNCIIcYCnhGVTyjqsFPy9OpXtyYLcd85ttJA3HOhn6j9h+8GWxFw0Ge8f2MYLQzh18IcqtR4ZD05pXU7gZWQUlukU8e7DEvFj7Sfv/daXm+COe/02nDPwoZ4xaOPekS5lva+22pj8vehhw0dzcqNRvq+2sccC9p0ffU3ysbKWr24UU8AGaRIJenDswyVkMJ6JhgSu4xr0OMROKjl2zzFeyNFQQ/7tplClECymHlLjAYiyMSLLOw1tio9Zg6rHc25uyUTVslOAdg1+7xbAw94BVt2ekEFmcTFtx1qzQW56vtlIFzkqE49ouR0AtMHR4K/EzuQa+PQZy0ml5G6TMDgdoGX311jNGc6pR65/7GTs041BoofPcPtaYrmnWhWseQu/LhS/he9kXAc+bLCIJgTICOTuZW5lv7d+pJ2VH6QtYUrvejfShklnYskbZsPfOh3EUyR2JrL7G9AgFdUMFyfuDGFOk8H0/4hAbJjYREEXHXzjTa6LnEQ1ANabe7N7p1B+8dZX6dWoOq5dPyDP6H9+pVtNO4SwEc+ccjAaE+MI2Eal2f5b2LwadxUZCJdvqhGVJcrj2co99P3bYE2114YEeiV0a2Ssx7MsQN0uquVco34yvj4hnCYUDxmuSG7BgoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(83380400001)(2616005)(336012)(47076005)(426003)(316002)(2906002)(36860700001)(86362001)(26005)(1076003)(6666004)(36756003)(7696005)(16526019)(186003)(81166007)(70206006)(70586007)(4326008)(8676002)(82310400005)(54906003)(6916009)(5660300002)(40460700003)(356005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:42.8342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba19bf6-d6b6-4be7-957e-08da2d44c60e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2910
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

fetch the average gfxclk according to pmfw for smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 59f0eee1a1c3..d7e42cbe9fb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -667,10 +667,7 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->CurrClock[PPCLK_FCLK];
 		break;
 	case METRICS_AVERAGE_GFXCLK:
-		if (metrics->AverageGfxActivity <= SMU_13_0_7_BUSY_THRESHOLD)
-			*value = metrics->AverageGfxclkFrequencyPostDs;
-		else
-			*value = metrics->AverageGfxclkFrequencyPreDs;
+		*value = metrics->AverageGfxclkFrequencyTarget;
 		break;
 	case METRICS_AVERAGE_FCLK:
 		if (metrics->AverageUclkActivity <= SMU_13_0_7_BUSY_THRESHOLD)
@@ -844,7 +841,7 @@ static int smu_v13_0_7_get_current_clk_freq_by_table(struct smu_context *smu,
 
 	switch (clk_id) {
 	case PPCLK_GFXCLK:
-		member_type = METRICS_CURR_GFXCLK;
+		member_type = METRICS_AVERAGE_GFXCLK;
 		break;
 	case PPCLK_UCLK:
 		member_type = METRICS_CURR_UCLK;
-- 
2.35.1

