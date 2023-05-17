Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283F0C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D592C10E3F3;
	Wed, 17 May 2023 11:39:00 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA73F10E3F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKxfK3+tgFSJ3IYvSIPex15ybR1jDLYrctxhMheem2x/J6jC2MO6Kl/maaX6p0zgciD73gaamNJZrJRBGk+xPVX5WXgfRNrZuelxnKc43hPTvfSN0xhlTvkUrZ5aw9tCue5nI9r0LI5WO/yf5/+LRdYc3XdkZ7xt/tBnSdF0+EC563RG0ie/NNDum+4AzfSZIV/iv8EPjHnzYDvBJqWMeYFIzpfToEBV9xQvCiXKrPdzgXDsN9fF/AtsMZ8z65PF/+GrhaHz5bOjwtLFV8SyE7VLh3OGnHAaKovyX6uieEEEdjKjYeTrdgtnOTRvDAiyE4zBitqhBIAbHEJfdWTUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV3QT4ybuATNXReXxnDPNmEr5dThon1WkU3hJ6P+z7k=;
 b=jltMzoyYBtcFlVXQ05BT5D/x5z7hUlxTBfCV63cEvczKEp+m9AtlYjzcJbRQrB2cjAI+jQcHtec13b/wxzVzKnV2VwNBfaWACQP977pksjO93xewE0A6jEBLctdFX9Lk+tb2haE79kVxIYDqWzxDZPDYZxrszyUTK1MCHJAVuxFwP2nXMbCyKd+QKDcm3saVAaoPLo2dXAt4YS8pHGWIHfnJQvIBrFerk7xePyHUQBqt5berCfn8O6xtw09gK4tZrDfLMKCnC0BxwbkQAlBBgfIOuHV5ur4TryQyAd+DcXu7REYVtz9EVCEQutt8xcd9xW/WuKqeuEU8b+qHLVQZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV3QT4ybuATNXReXxnDPNmEr5dThon1WkU3hJ6P+z7k=;
 b=T0Y1iK/86NEHfijjXbAoLKTBOtNTxgjjeKjkRdtAb/spUkyA+iH8vstyRVzbNUlwUt3vMMRMuM/XFQPyM7K71Roc3F2kC07/bt9hWBz/nKnjC/OJQSPmVNu0FegBOwPk+gPqkbdYrD9BCqtTRvY+yq/KvtXjyHK9sn0a88645Kk=
Received: from MW3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:303:2b::15)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 11:38:56 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::56) by MW3PR05CA0010.outlook.office365.com
 (2603:10b6:303:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.15 via Frontend
 Transport; Wed, 17 May 2023 11:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 11:38:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:38:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 04:38:55 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:38:50 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/18] drm/amd/display: lower dp link training message level
Date: Wed, 17 May 2023 19:37:11 +0800
Message-ID: <20230517113723.1757259-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac3d03a-744b-41da-e05b-08db56cb4c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hu6fYiwE2rcK2nJqGebKgXoK5Njh2nODpYPVviMHBFn3z9yxdkCH31FFCMnfRNlrEqVd0fQB2eKuLJvHWG+JS9ZU+whQM1N+rlg9CO49n5hILHRf+wJ3xmU6MzqBNLOAJrtnTjcuBxCaJROtgE0bEF+BOOv/7NwV/r/GGrirPtUeZMvtbb2U1IKOKBVfYuumzdBpwnV2pBwXaqNgJmReLMN7BNx9GssAZ8VDlKF7vxhgOdosyGAfbkB2BJG10Pv9AWaq3ZGUVrgYL44RzDbk3IepOFIYTgWUOFBJ5176ZREx0/UiYLcBbt/7OiNKXgdmSPbn5kccL51cFYH4Uzd6g2I0OHH1Pnut4jnQdWnrw1F7nCRHkfAb6lLFywZhbo3Rk5gLid2atExYEZBS1h8VEEYJI+s7YvuIUMvq6fPoeQKFac5r77kIq5+rzp2LiFQfDp0EtCpIFPG7rKCPEh3kGZQei3DrDEChuJB6fSgwKoqkhaNlVPHT1jeSQipZ2mFrKwTCGlaF+/M+2ipJ7rY7a+iLBXUclnjDWXhbnDFhSyykZp6HXaqHwQdYaN/1WrRGeCdr8gq6W3T8ucCzK/27+gLvz0xZ2lsGNHDyyrfFeEzKfnXE+6sUpGzxP2dEKULaV+mXO8S4mMbvLIp7DxbUNrfXXxI/qCfbiNafq+/YodfqUzuSZtF6Ry70WTgBc1slPZ28+3V7vzL4rnTFoWTDOpJXSBcNWPuVryNZqgvaZViML8TDU4Wc6z5NatdyOLil66tcIsylETLxytKZN+PG8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(8936002)(86362001)(426003)(336012)(8676002)(2616005)(47076005)(36860700001)(83380400001)(82310400005)(81166007)(82740400003)(1076003)(26005)(356005)(186003)(40460700003)(7696005)(478600001)(6666004)(316002)(40480700001)(41300700001)(54906003)(70586007)(70206006)(36756003)(6916009)(4326008)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:38:56.3162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac3d03a-744b-41da-e05b-08db56cb4c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Jerry Zuo <jerry.zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why] some test apps report dp link training waring even dp
training pass. there are 4 tries of lt within
perform_link_training_with_retries. if lt pass within 4 tries,
it will NOT be reated as lt failure. for each try of lt, if lt
fails, current driver implementation prints message at warning
level. this let people think dp lt does not work properly.

[How] for 1st, 2nd and 3rd try of lt, print message at debug
level. for the 4th try of lt, print message at warning level.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../dc/link/protocols/link_dp_training.c        | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 579fa222810d..e011df4bdaf2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1653,10 +1653,19 @@ bool perform_link_training_with_retries(
 				break;
 		}
 
-		DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) @ spread = %x : fail reason:(%d)\n",
-			       __func__, link->link_index, (unsigned int)j + 1, attempts,
-			      cur_link_settings.link_rate, cur_link_settings.lane_count,
-			      cur_link_settings.link_spread, status);
+		if (j == (attempts - 1)) {
+			DC_LOG_WARNING(
+				"%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) @ spread = %x : fail reason:(%d)\n",
+				__func__, link->link_index, (unsigned int)j + 1, attempts,
+				cur_link_settings.link_rate, cur_link_settings.lane_count,
+				cur_link_settings.link_spread, status);
+		} else {
+			DC_LOG_HW_LINK_TRAINING(
+				"%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) @ spread = %x : fail reason:(%d)\n",
+				__func__, link->link_index, (unsigned int)j + 1, attempts,
+				cur_link_settings.link_rate, cur_link_settings.lane_count,
+				cur_link_settings.link_spread, status);
+		}
 
 		dp_disable_link_phy(link, &pipe_ctx->link_res, signal);
 
-- 
2.25.1

