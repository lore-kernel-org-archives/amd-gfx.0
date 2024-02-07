Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D41EC4829A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1DE710E2D5;
	Wed,  7 Feb 2024 20:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v3KbqBPy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC07510E2D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQn5qOBJb9ouULD317wXcGmDPOzbm/FOdPa7yJfFWlVaTNMDgP32AcdCjpxGC3SMzJlzmJ2zpogQt87/Jp7fWYUf793nmT9XNnn7a2vPH98n8lVC93rIU/Zs3vs9S7JiRTPISKRdM6MY7oa9WWeFYGuR18cbcUOO9HEa1PrN5XojOX70exMq3vYOA9I/RB1odHtTONqsiIfIy0EQRRRtJX9kYYsCgr0NwazYWcE6K5Mc6ELQO+Le/BhiRBvK7tPsWlHgwylKS2GdigUpIbUzRgmWnENUE2fglqvI8t0iKLoyZ0C8xBMhzYYk612wD3cJq8Zo0zzazImNyTecoyE5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb12Qll+4H+Dyw8miZUFiFeHnDQc2udk5EBkvzHu8oA=;
 b=jU5PF0hmoH5ITwahlSTMMR/3ZoA9+wZI1XafKtWfC6i+2xVE8lRmXpr2us9Ub+BKL+0h2ICVOVTSna8gD3x7cnvps8C4HDmenHpZZaX3K+RGcdCQobvuzAViiJL9QF8PGAuNf0oG3OoULvjocDaPlh6LP+lnk6S+qBI+BlJ0aELcYJqYJO1N3S+gA22ORde1vwy1C2sD45QAbdbQ26snvR6d9VrH8drCuY67AIWJRlrAnABJQDnTnFa9XzG76TH4fsGCpPIWSBgstLou6ShXFR1ArpwDb31rQmlZQfTjIIy89HAPgNstfGli98WRfXmavI9jZAtD6cQgj12YJYbg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb12Qll+4H+Dyw8miZUFiFeHnDQc2udk5EBkvzHu8oA=;
 b=v3KbqBPy6LevfcQ882LR3/dvZnx3t5JqLme+HFqriwccVUg3rOdLxmmzMrL5+P7SCYvbRyvOKXnqyC7B1HK00QMxLa+/pteo4Xduj6QrpVcegX5YGe4ck4HNRk8uSIWrQ//CMLz0G/QRLShPasw0x6Abey9kPXM4u1jXg5QAbAQ=
Received: from DM6PR18CA0024.namprd18.prod.outlook.com (2603:10b6:5:15b::37)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 20:52:11 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::5) by DM6PR18CA0024.outlook.office365.com
 (2603:10b6:5:15b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:09 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:09 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sohaib Nadeem
 <sohaib.nadeem@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 02/15] Revert "drm/amd/display: increased min_dcfclk_mhz and
 min_fclk_mhz"
Date: Wed, 7 Feb 2024 15:50:37 -0500
Message-ID: <20240207205200.1608684-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: b386ed9b-b5a6-46bd-e87e-08dc281ea7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXo8bmrDK+IM3fZfQGHUgDzrFAXbEXZCqZaZgPWdaMaNs4mIuVER7vYY/4SXuG3MipzVrB5VMcQNVlbWBd+980rtBSwFJUfVOwMTO3soKPzNnJ3RgKRKdc2kAZujkw08RoziGFO32pEcFpLz6b6DAmN1s62aJN9LTeEJ157lifRcDaLOtk34X9GvDK4POLtlrNobweO/LOl7+vL+du8QpA/aNgILsH06dVDCvED3JaFajzPcyjPM57SXjZ9rFTTTVyH9AIhPc4V1SG6w/SdTZIWXiZPCfcwHN9LBh6KVvW+6TaXeRt5b1UqYDpoDkKvUsSJ9AvA4NTRHYOrvFGhluPCnqy5+GRCge2Oh3GznA88L2EWFqFiVd7cU3iR1XMyh9LRhdP/uPjyGwSq6iLHnzPFVfB7WtPqtW/mBjP+QKf97l1ke9A1v37lPrtvpEptdZalVwdzN6gImui2eLBXdAgsxznBuGdof57Yu5Sdidy6dfz53aASkDTcYZQ/tdDyyK2odpwupSM+sLIhFUKGIbexEM7Y5j+c2CJUJxwfFoWo6WRKu9PLurNhVvtYA6fSnSYcSLPAJwQejnAbN4UALoFnS2ZTCc4548ejQu6vEVnk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40140700001)(6666004)(1076003)(7696005)(36756003)(86362001)(26005)(336012)(356005)(82740400003)(41300700001)(83380400001)(81166007)(426003)(478600001)(2616005)(4326008)(44832011)(8936002)(8676002)(2906002)(5660300002)(316002)(70206006)(54906003)(70586007)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:10.9731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b386ed9b-b5a6-46bd-e87e-08dc281ea7e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085
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

From: Sohaib Nadeem <sohaib.nadeem@amd.com>

[why]:
This reverts commit 5abbfa320b88da6034fd4121fa68c2b0e15e97ac.

The commit caused corruption when running some applications in fullscreen

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index ba76dd4a2ce2..a0a65e099104 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2760,7 +2760,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	struct _vcs_dpi_voltage_scaling_st entry = {0};
 	struct clk_limit_table_entry max_clk_data = {0};
 
-	unsigned int min_dcfclk_mhz = 399, min_fclk_mhz = 599;
+	unsigned int min_dcfclk_mhz = 199, min_fclk_mhz = 299;
 
 	static const unsigned int num_dcfclk_stas = 5;
 	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {199, 615, 906, 1324, 1564};
-- 
2.43.0

