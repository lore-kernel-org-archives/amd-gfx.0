Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B326C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC20D10E3F2;
	Wed, 17 May 2023 11:38:39 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BB7610E3F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGWrBORSRJnC6XlxYBAz9RN0YZjhefOZ7K9r8sCljJUEW7ImImTaju1pYczFYnCHjXu+l00/7VbQ/O4sgurvXxTtcjIEVGJSptu6k29ATlp+ao+AHU0kbS0OJHFgdtqSorZkgKOVwFPaJTzp9hzZ1SDq1d6vnYXZZgl7cGqWrd3c17VLuV68R5FRyNg1LyXEGG/obWTlEB6nug7jvy+rbOG1Honh76wrwcgh9HZ42hk9nYy75HmzNNYmEyeNXlOhgzx+ARTr0Jy/Ubxm/GO1sgQjRYF+0a3lH295JhiIcHAFi437AKzLp+yQ7u67L0+qwyd6rdF0dH877bi9Oqz7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjXechcmOIRhm8HJiWLvx2Ho71UVfOjDC8XDcSAyyqk=;
 b=nJcDqo1NtsRyiHdxexqUQhLBSavKA/VGAF99Fp2g1xxZ8RbjlGPn8ZlIOv6WQ9zne6eBocOL9qtqrqxV8BPdc0XGHDlyb4DAT/blAPwStinVJr3WS2HWKIPwo7+wI4zMzZ3wRF7ADMowvywR3MuBzFjwyWz1b5QVtEXG186+ZNj3G2vg/NgH6UkTMydS+6/nl5VWo6Cw4ErYhYSQFDMqoH6lq9wqtJzF1i6RplZUB0NISJlxSZkrMV2t+awJO1fqzqr4SFf8qaJ4jQr/MgD6QzVoZLqKWPiZwsMlNpuby8ak0XVNQ9irjAl+QvFf1FFYk4y/fC5HMM+oVxhrbniG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjXechcmOIRhm8HJiWLvx2Ho71UVfOjDC8XDcSAyyqk=;
 b=jHkB3AFJoIAp5oXO0/zEnsPEdu2QMw1RrnM87Vqktcafx2d+XoPsFopnCnV7ysifvrct7VyUR6jtPCVCF0e+uD62yAp5wq/78CMg9MeDXzsY1+z2h6uRIxd5HGnW2v6iL8I/TkB/XPEbOki++rMq5sZvDErKaWnbBso9HMh7N10=
Received: from BN9PR03CA0682.namprd03.prod.outlook.com (2603:10b6:408:10e::27)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 11:38:35 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::3b) by BN9PR03CA0682.outlook.office365.com
 (2603:10b6:408:10e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 11:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 11:38:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:38:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 04:38:34 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:38:29 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/18] drm/amd/display: Update SR watermarks for DCN314
Date: Wed, 17 May 2023 19:37:09 +0800
Message-ID: <20230517113723.1757259-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8937e2-9fdd-46e1-bc72-08db56cb3fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: moOzaCcq5y49hVmn4yYp1ew6ZUnboSrVsdJMP5qfCnceh+y2xlXIiO48jr8ptUt7Hjiz971EWKfE+hVMxmqC5JE+zOcpAeNnVjeSw3qS8hbx0X5+nu9mr5HxeXtOmLttMD44+tajWMMDlcZiD5JBbTiicfvW0avPrFiCiA7c7F+H2P3aJBpf16l3BHtgMDd13J6sSmgY4SF32OsqC88HUtljCg7mqJBwShZv7ImF73JJRknelRTZmNrEJxvPf/n+Ht7D3f24IV7eFXxTh+uqSMbOFGc/AHhc5uVrtJytmaS5YF+HQAHTfwUr4Rw5y74i3qV7da5YyDeOlBlbSAdIZd0h5uPO3PeL9Nmd0rFJadRosgUageETGK8tTp/N/aaG2iCH7gZ/WpnJO+1KeUz8yQTZLFWQ3vPdxSuThWHIJDT0Ts3RxTm8MFSYvDcAidXXm0aUHl51pRhPyZfh1SReJv5XWSTlo68tF3/VIAJjGfgbprezBrqTcmzvqZR0/EKUP/7LzoQ9jnevw8qUDZmvjhDxmHddz5V2UlmwqM9mZXWKsBZYgF8FBiS9veb7o5mel2V0t/dIKlchBzRovY5lCBhFzFrNK6uOUvv7gFaenGC4yGrHJPwiKApNrVYeuCCBd/RBRyJdY1j+VisR1+awD77iRxYI7CB0MILBvW4yelGcz6yhVmRZh+54cuKkOx1bqElFM4H3KjAdqCTk0fqyeolsZ0c9d1zRIAylfhxat5niDqHSbZSqzD8+fu2PDXyZSdEI4kzlhyDaxAt7SDf7Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(336012)(47076005)(426003)(70586007)(70206006)(40460700003)(2616005)(26005)(7696005)(40480700001)(54906003)(478600001)(6666004)(186003)(1076003)(5660300002)(15650500001)(8936002)(86362001)(8676002)(36756003)(316002)(41300700001)(2906002)(82740400003)(6916009)(4326008)(356005)(81166007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:38:35.1517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8937e2-9fdd-46e1-bc72-08db56cb3fcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
Update parameters for SR watermarks for DCN314

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 4d5cd59f6433..2a0c696f5861 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -403,32 +403,32 @@ static struct wm_table lpddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 16.5,
-			.sr_enter_plus_exit_time_us = 18.5,
+			.sr_exit_time_us = 30.0,
+			.sr_enter_plus_exit_time_us = 32.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 16.5,
-			.sr_enter_plus_exit_time_us = 18.5,
+			.sr_exit_time_us = 30.0,
+			.sr_enter_plus_exit_time_us = 32.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 16.5,
-			.sr_enter_plus_exit_time_us = 18.5,
+			.sr_exit_time_us = 30.0,
+			.sr_enter_plus_exit_time_us = 32.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 16.5,
-			.sr_enter_plus_exit_time_us = 18.5,
+			.sr_exit_time_us = 30.0,
+			.sr_enter_plus_exit_time_us = 32.0,
 			.valid = true,
 		},
 	}
-- 
2.25.1

