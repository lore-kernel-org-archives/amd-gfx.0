Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A30C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A5D10F646;
	Wed, 24 Jan 2024 07:02:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84AF010F640
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THqkntbZqdVZ6W9aYitd/prYHQmamTDCzqdlvRolhxCcnjMZLYXo4xfCumMDUCE/+uZ907zsmKjd9xt2wjCkZAxCFrVOZC+p0NYp5vqED7uk8hKbt9AlGrlJzLXsbb2o6oe41yBSt44/Vamjnc9Q32H2dyLPmjzESKDVd10xKj0bcQ8B8kb4uLBN+trNzDBApAPjf57U4qs9EiCTpMmwGrATFTdzCMyxyA2AnyeizJcMrG1k9JFsNDeTK2PWfD5V+Yd7UFhs5Hh1l7NP/pP5ccG5RE1uGyHHPc5J3EzyMJ5ktsfjUBlvFGscVo7wpM0eIDJO8Pc3WmKJoGUjjc9hng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIpPhYVuYHMpwYYKy1gz6LsaQRgNJsQD6o4FYrHjw7Q=;
 b=PgSj8zNWgqFl4pFDh7YH77vYKChtl1FM24ApR1xr2deVGSQ6ZjyGjmk8nYL+1VD4TGhEeRxXYo+XI7/ClWXvNdi4AnTiE7mVGZqt6nnDWWcC82BLrOiD924ri0wkSCnYCOqaEaWO+Pg8Wy8kzfuHtS5b9yj5TSt7q+4i2QjzoPaKuC8Kv5OakOyUX1iNDthrgv/MUZUPNFI3V/r0jdXbc/zMfzlYfB26ijGTxF1DQwqrXEdWxAvyTl6xE/9z8bUFoIDRXkBwrrBpYPNpTAEvx+mKgHCDla/Fj2Q9+n1U64F6uMyJyBqFm8bcUetw8Zc9at4luoJ3D87hLzK/h+vL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIpPhYVuYHMpwYYKy1gz6LsaQRgNJsQD6o4FYrHjw7Q=;
 b=lGJol6zJPGcBt4w1VQNp0vu7XjuCREWWlL39nTw5ZQUUZyFkwMqP7C77sGbPaBQkwFIyQGMYJUiQ41A0i6ILAKol0KfKTZEqI3XZZ4itkHS0Z685B5FGms1TgUT66YmetQ6P5AEfJ6BCHis3nC0KqtvoJ1igrdgGX+ca0ku0n9g=
Received: from MW4P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::32)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:02:26 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::30) by MW4P222CA0027.outlook.office365.com
 (2603:10b6:303:114::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:25 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:25 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:22 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/22] drm/amd/display: increased min_dcfclk_mhz and
 min_fclk_mhz
Date: Wed, 24 Jan 2024 15:01:42 +0800
Message-ID: <20240124070159.1900622-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: c57338e8-0ab9-460a-33b0-08dc1caa6c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qj47Zm68zPTaBrI/N1LfLXf34R2By7UQJmqyhcUv9ThRWJO37eMxoPxuS1Bv2oenzXFmZSuvQUlrO2yU4jr6wPpSBR8MUoGCy/MWR7a9XpC5z2mA5NL6UknWyeUf03KsEZ2W8YKof1eiE6bO+CymrPJL03PVQd4aBXJ/RzyO/Fe1ciOFlH+Tt6jMd7rbMKHo4k8uZO8zCzqelFgOMPhEswdGBcPXYPC18XeH8gcY4Wkety+ZbPc+UiDXVJXZUKJbdkjVrbieQNSmZOl6oHgcZNo4+JClqmQJgJ5p/Y/EGZhC69fEr8rSZ7U6kxjjVbnw93TRxYofQYKKeLxSund81hr7IjjQClETC4roqH+uxLZZ/ZNPST5oEE5pfv8tVNcAnuAI0LBabHcm6IpWBb+wi3pLuZ2XmgY/4OzibQ3nSj2Wuz/jdkBQFYvotZs1E9jrjE+76nQ64BFiWcRLvCBz3jzdWxLrBFxNEE5uxdfPbFbsP+FrccMwJPW+AVS/jrKEGAx+aqsQ1Q8K949QM00aVgjoon6xQdsiZsm81JNkjWKkvaBoIMthvCLIP81cFZO2IkPUiWrlH3VJBUh52uXfgFvXpGGiQh8aUpZFnbuZLlg3xgpzPjfYO55ui9LyTL1Rtfi2up6gzjHiKAimkffRy8jc6m4U/weAlX73eYe8sp0Kv91rvfZMLXegmr/khbGOSy7wJz7fglPOjxQ0daN8wPtX+L7pmTbtD3uLiin2fn+0TLYscb9QYdl+bgbe+AciYy0DZr7EqTu1hG4gwYJ/Bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(70206006)(70586007)(40480700001)(40460700003)(2906002)(5660300002)(6916009)(54906003)(316002)(4326008)(8676002)(8936002)(81166007)(356005)(478600001)(82740400003)(36756003)(86362001)(40140700001)(47076005)(1076003)(26005)(6666004)(426003)(336012)(36860700001)(83380400001)(41300700001)(7696005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:26.3805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c57338e8-0ab9-460a-33b0-08dc1caa6c35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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
Cc: chiahsuan.chung@amd.com, Sohaib Nadeem <sohaib.nadeem@amd.com>,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sohaib Nadeem <sohaib.nadeem@amd.com>

[why]
Originally, PMFW said min FCLK is 300Mhz, but min DCFCLK can be increased
to 400Mhz because min FCLK is now 600Mhz so FCLK >= 1.5 * DCFCLK hardware
requirement will still be satisfied. Increasing min DCFCLK addresses
underflow issues (underflow occurs when phantom pipe is turned on for some
Sub-Viewport configs).

[how]
Increasing DCFCLK by raising the min_dcfclk_mhz

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9f37f717a1f8..b13a6fd7cc83 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2753,7 +2753,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	struct _vcs_dpi_voltage_scaling_st entry = {0};
 	struct clk_limit_table_entry max_clk_data = {0};
 
-	unsigned int min_dcfclk_mhz = 199, min_fclk_mhz = 299;
+	unsigned int min_dcfclk_mhz = 399, min_fclk_mhz = 599;
 
 	static const unsigned int num_dcfclk_stas = 5;
 	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {199, 615, 906, 1324, 1564};
-- 
2.34.1

