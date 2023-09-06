Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDFCEB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AA510E62C;
	Wed,  6 Sep 2023 12:49:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 355F710E62C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9eLgA2qGxGCgpaUOHQOOTD1JTZ8duz56KE4ZQjqKLgQUdGDP0K6xHnsFfqNqL3hbSKKNpH+9IdqjcB3aG3IoBpEHyLSX2alb1Hcsmn6uQ7YpvQppbr3qLs5wFvTMiZYUynAQxsXrw+CnOkUT9z2Fddnnjk8EwAIDpx380PZ4zPP/ii+D5cSry/KRqCfOPdo9dF8yZ2JMsjbAs+9Ay1MX0dvx0ocRlrnl870XOm0ACOyYWzeZj4ebAIjMhunu95K6v5xZon1gVmwL2is7LFTx6aUW7mmSF0dvHdSrg4JjCVm9BcgjHspgja5pYit0iYDn6MfwWjrQlb+69Zza4bU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDI/DwQJUCCL5eYBtl4/CfGRvT6fOMrdXaJ1bSdaxvI=;
 b=R6XHmIB/5u+cg6Lk0RpIsZ3JuXVIv+3JLf//VbLoyeZOuupayWEVO9ueVQYNyLjCGsJ+5aVix1U+3MMypQ7eTgyYEo9ieu90FKKFlr/7JcNnWioD0trM/ARl8cbo4mOlHEVjYLu2AL7bf8uFspB6v2cJekUFJxS+uzLus7VtEpOSc059J6mLEGnicTME8CJjmOAbO37vUplkbABVi7geWr25n+jFT42FF7BvkihsaohSaBjiAEBW1RSmTyUEuVOYyVNG3PWRx4gPMfj3Ul6ruFj3TxlnkFjEFdZ/GiCzU/6L1retuUCTzcYOzsEj7GobP/7RgM2ZH17ewrywgmQHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDI/DwQJUCCL5eYBtl4/CfGRvT6fOMrdXaJ1bSdaxvI=;
 b=JNE/3h1RmxY1Y86P0Zkk0V4wuh7zayQn91Y6YdpnjdSAG06POs+Bwk1SgPhr5MDtcFpDHf3DpqfaXoEP8qKIBetV/xacPDRugdcT5605ZCQLwy0WX+D/+lJyU0fO1CR9SnY6ZHmfwHvu+piUeWdblSVIsuYks7bWjhEQDzknSXc=
Received: from CYZPR14CA0029.namprd14.prod.outlook.com (2603:10b6:930:a0::23)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:49:15 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::fd) by CYZPR14CA0029.outlook.office365.com
 (2603:10b6:930:a0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:14 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:10 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/28] drm/amd/display: set default return value for ODM
 Combine debugfs
Date: Wed, 6 Sep 2023 20:28:08 +0800
Message-ID: <20230906124915.586250-4-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc6c7aa-04d6-49fa-90b4-08dbaed7ad3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/nAZCoIMYtCPyHo5GxKKaJi9F1hdCw2uMYkQHAzusmESWWFDCIMVJ/coyDwqfNi+gILaAx0QBJmor35Fv8STVPJqH33/kb/hAzLumsCMa/CCq1Udv4hJevHyO0yxSCB/6M4VmZ0oASxcov5pfvlhZrRtd5CgJwbZVgx04g8zwJQdV/TXKTMLlIHIicyxrFx10SeMMBZwLuV2bm00eqYhXv5aAklNLTDD0yMh3jxIIjj67iBzL2eu6X4o9I80dCn6HWF/LedDJKsFGfYQOdqpS0GtLdhVoEZDaY7OAIHzjRFgrl7cRBhqp0cs0XKns8OAYGAoemXynteVqi0gGw9DAR7BDxeSDN6M+wGoFtHp4cp4K0hxy1utfHqEBSSRm28dquII/2GVx8HVrG+pxQt6VdPf5vLs9K4e9wxLXl1AtbPzE8w0appEqXmJWMd+sZqxwev/c54xv6KIqUZFWtMegZaNejs2rRNazp3hOCn3D/M1C9dDCeBFzr85DN86n/7pbMNjN/3zSPnEoCJn68l0k46Mav1SmN1muR77Y5rbix2nbl0/nGbt4GG1PoszwVty1Jo/1cJ8PuFPEOCbXnnqB9zUw9Bm0KKvkX6aFrsq0W46iCgrPtx9P4Hr1j0nLl+AZ0b0veufZWXU2ONOav01fnzfHVKdHNclC3fn8AJ9bi3V8R64c+MpLdeD3x5+G515TRPAn0W5iHcXk0AKwbG0c5tgcE6YyWxpyoivtYiUyTnPGVlCqTbGWfgZEC9/clVtf5PrJ4iAKZncrnIUixzYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(36860700001)(47076005)(40460700003)(2906002)(36756003)(86362001)(356005)(81166007)(82740400003)(40480700001)(478600001)(41300700001)(7696005)(70206006)(316002)(70586007)(54906003)(2616005)(6916009)(1076003)(8676002)(8936002)(4326008)(336012)(426003)(83380400001)(5660300002)(16526019)(44832011)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:14.9789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc6c7aa-04d6-49fa-90b4-08dbaed7ad3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Set a default return value of -ENOTSUPP to indicate that the hardware
does not support querying ODM Combine mode.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 17d1990ea832..05c1ad98a1f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1211,7 +1211,7 @@ static int odm_combine_segments_show(struct seq_file *m, void *unused)
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct dc_link *link = aconnector->dc_link;
 	struct pipe_ctx *pipe_ctx = NULL;
-	int i, segments = 0;
+	int i, segments = -EOPNOTSUPP;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-- 
2.42.0

