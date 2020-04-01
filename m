Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E2C2D0E7
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 07:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DF5206F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 07:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fHgBn+mP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DF5206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3F86E8EF;
	Wed,  1 Apr 2020 07:14:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE426E8EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 07:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/u1Yf9fkrAmM+UYlKSsQum0m0EWFgzRgGymzKtitr90068UYBBSulXVUYxWLqAo83xiqr1YdDoY3tQR0oC1iaw6U0Ci2k04vQia0p5oCAW3sorl9dijezAFGf/OumKMEYG5sSaySoxw9F/I8twgQ0EjY7ImtfJM8wjJLDTw3VxIp4mkLjYCXmH3lXtUvrLkEZ/+T2zoPaIHGyOiCx6vrOA73k7nxav2tRhDmpGTf4Zg8eAEfw4JwM9oA9cHqofP59rtuUHJvH5BhfM+e7OeVx0g5Xxq9r8NVZH3pGW51ZktXURFl/hP+bQey+GtUpRMwZTrwzZ0vWYW7ickStvI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26GwRPCztKRca1E4588WzFrsJbjwYTs/Zn57sPuQyOA=;
 b=NrM0eSY0LCeGv3OV9yLZr8I/k436RFIO5syY8wmMrubQlAoaUCp7GknsR0KI2AT4ZY3PP0Y3LMIfHIXfQvnnJ77H2fAs1QFcc+5OCNclCDYsfQUAk0PMqUpjGAqCeKNfSrzfg+HODw1GjBk6QxJIj60jk/8hANWHLjFLu5Gs14eocjNvCu64v6IyjfoLD7+JXjOIb7FlTwhc8EPpaqwguhNWceUz+cw6Cm/6vIZ9RB6cQ7iHPMWYLdBcTGSuTP+E+iCuQ6UOY9fsg9NYmdKq3VnZpQmHxXdFMtCc1Nqp5rqBDZCR3LAzLTuIQUnWJEKKl27RZN59/N1YMcYrsOPSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26GwRPCztKRca1E4588WzFrsJbjwYTs/Zn57sPuQyOA=;
 b=fHgBn+mPxu5yZ/WHUSjpXB19zhxiNsI/X47MemN5TPTv8x4fJtt9Pz/COoBdRk8OmpVjbrrLYtkmRY+4atuaVvsyz0h2BQqsGOv9+xdAqrBnDTyszNnMB6OWl++MLnRXJRR9xZyDwnxYiBsDU7kDelWIQ3dPhTAOcaNd6MzzK1k=
Received: from DM6PR11CA0050.namprd11.prod.outlook.com (2603:10b6:5:14c::27)
 by MW2PR12MB2522.namprd12.prod.outlook.com (2603:10b6:907:f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 1 Apr
 2020 07:14:27 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::d7) by DM6PR11CA0050.outlook.office365.com
 (2603:10b6:5:14c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Wed, 1 Apr 2020 07:14:20 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 07:14:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 02:14:19 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 02:14:18 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Apr 2020 02:14:17 -0500
From: Yuxian Dai <Yuxian.Dai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the MCLK
Date: Wed, 1 Apr 2020 15:14:15 +0800
Message-ID: <20200401071415.16408-1-Yuxian.Dai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(428003)(46966005)(86362001)(26005)(6916009)(70206006)(4326008)(81166006)(70586007)(81156014)(8936002)(5660300002)(478600001)(54906003)(8676002)(7696005)(82740400003)(336012)(2906002)(316002)(356004)(1076003)(2616005)(426003)(47076004)(186003)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3930c28-a191-49ff-518f-08d7d60c4bef
X-MS-TrafficTypeDiagnostic: MW2PR12MB2522:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2522CD9B450957DA061B239C8DC90@MW2PR12MB2522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03607C04F0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8r+bFBppZKOzK/JpZhiqUJkFp2/ag/Z/Ix58BacW4iuvH0L0I27yv8BP49NQODfcWGooayrTAPfHhmjCb8HxDaBL7jFi9y0YJdkybr2mejNQqTxU/jA00aYktCMvlBEFiIDooxYZbfDk3kRO+2Pr+mFsbVDwcQ7wwWmgyxCRDEcLlWHjNl1yZqBjah7rrzehX1v4Y1rnAtS/4YADO0zNWXkIwdZdHXuTRYL0lDCPTYx38N9vHlh48M3OEAZYsKAulc4HGWzWLRwfE7hbc98u+DZb08U/dqXDOi++5qUAKCD/4Ly+BNBG2sTgun1bygMuE8WbaW+mIolb4qwD+ghOwDNe+2jX+UnoHmZ9CYSNYUDpPi9KmlfT60bCrhx6imMi4i4PiDJTz8AXghRD6w6LN3Udi6OGSEH+Z7RF+Pl+Dxkdg//ks+X3uYKpKCINEYJfN8seZ5JnDqf4eflQ/mngntof3xJroqbK+0mv5sixMxait6NgNsQGjIp1FL33ouelpqacnA9A1+6VcWbDfGw6Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 07:14:19.7301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3930c28-a191-49ff-518f-08d7d60c4bef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2522
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
Cc: "yuxiadai@amd.com" <yuxiadai@amd.com>, Yuxian Dai <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "yuxiadai@amd.com" <yuxiadai@amd.com>

1,Using the FCLK DPM table to set the MCLK for DPM states consist of
three entities:
 FCLK
 UCLK
 MEMCLK
All these three clk change together, MEMCLK from FCLK, so use the fclk
frequency.
2,we should show the current working clock freqency from clock table metric

Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774
Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 7 +++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 7bf52ecba01d..3901b20196d7 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -239,6 +239,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
+	bool cur_value_match_level = false;
 
 	if (!clk_table || clk_type >= SMU_CLK_COUNT)
 		return -EINVAL;
@@ -297,7 +298,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
 		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 				cur_value == value ? "*" : "");
+		if (cur_value == value) 
+			cur_value_match_level = true;
 	}
+	
+	if (!cur_value_match_level)
+		size += sprintf(buf + size, "   %uMhz *\n",cur_value);
+
 
 	return size;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
index 2a390ddd37dd..89cd6da118a3 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
@@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
 			freq = table->SocClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_MCLK:						\
-			freq = table->MemClocks[dpm_level].Freq;	\
+			freq = table->FClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_DCEFCLK:					\
 			freq = table->DcfClocks[dpm_level].Freq;	\
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
