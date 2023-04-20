Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8FAC77B78
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C8810ED46;
	Thu, 20 Apr 2023 23:50:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C72510ED4B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvRBO3vO2kP156q10Hijve5GA2KFe8GcBNdmGB63BdGtIuOSx2CURwwp/i+XjsalepO1YMyxdM7euFx88BofBqrjA38fmbtlweHwuqhV4hH/o4n8p7aps5gAsvhXvZHb2FehwJgkJWxsByZSnG82q35WVsBfHzt6omN6CgxDL8jgPth48bMVtBlpkwIv5pbSESgfM70rkHaL9PPwbbvi/whVeSnMju0DOtOCl9t3fe2icLzEw4rrHDntOz6W5RAkFKJqCYpRfQ260s8XvO53IWmyiNjt149ovH1lZp5UKbBZptfM/6pbj/mtTnY+V3mytivmLskpEBkMBDJq2prmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldt+f/2Y2lGH9mBgx5YWIL2scYklP8IIdHnLh2GJuUE=;
 b=EVv9YnByfyG1tU7BYSxBORAnKcIrXQLVBuUeuogRFrVyhoFXcG02eqeO/ZDtavJneMi3QEId6+zEIjBFAqivDlx/k7xDMIsfKkf8vPJV3c43RACvJiA/+AlPEERKYuJtT6Ug0HtHpPw77Qn8qUSnVOU8/n47+ba4JN1e8TRB3e0etZclIxv7Rk103DuTBAsosdo9KS5yLRm+q5XOncrcR1AH26uZbKpKV//xnfgHgRaHUFUlVYBPRIXk0Ox3znIi48qcZ5D9yrTQobfIakXmiYjAYxHzONq17v03LnS5NHeyP1Kr0yJIb5WR4vZdH48PQ6jDUey9xMI2bI7gK/noCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldt+f/2Y2lGH9mBgx5YWIL2scYklP8IIdHnLh2GJuUE=;
 b=syAjxBTZEGVuzziJjZqmlWIosj9BQ2odVNWGGLGYwmdup+N7g+FlA0w28k63RZq6tLq2qiSLzigw4RWjpCOe7n3h3nDaAsDnzjXiKPaRZCq7G1hRfYERLUVJREVWLL/et+PZICpEHXl/8qTAHhMPROTC/qx5KXC+9PGySW8rQe8=
Received: from DS7PR03CA0346.namprd03.prod.outlook.com (2603:10b6:8:55::9) by
 CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 23:50:18 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::e) by DS7PR03CA0346.outlook.office365.com
 (2603:10b6:8:55::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.27 via Frontend Transport; Thu, 20 Apr 2023 23:50:18 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:16 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/21] drm/amd/display: Update FW feature caps struct
Date: Thu, 20 Apr 2023 17:49:36 -0600
Message-ID: <20230420234951.1772270-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: d6dad99a-033c-4944-b9f9-08db41f9feec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zYM3suk9jPYA+/1N8CRtyno/KqoVyF4YiCGXXjZVskHnXVC/4DAHNGRCUQu/mPGRy4CY3pMj69knBh55KwF7lu9Zb4l/yCrlcAHM0QJR/GyKWiwvabWhFQHc3IL17WD/8lHMLbwaTAPn8URP6ZY/ARrfMFEidpVijJUDyn8m5bmbAwHmsa+55p3MMv2PjA1kszj3uD2sv01h0oCWkO114+Hy9yiMgy8LxyCZDLl/6/sEfxXQZbhvqgYBGmUngVoIwl9GDfYBxqRixK3myWwYV68fa5FcZXDM3GwkCURtmRm63x9AK6QmjJDzcSm397H4oko4rJ65rNNXI0czsQX6CooFgC20FbfOY4hBFFqtDwtsMqJmzkCv+L2DmbdEnfpV2YrvHNzszTHj5m97c0RiW8bUlOiy5Lkv6Vz8I8/dH7aY0ssfw2IqAP1jnerD7lwQUIGv5vkEzmWY640JqZRbMwO9LqbCr7R+OhOX0mdHF9/GF8uA9szZkN6ZmbJaOwHyp0WR+QF8K5O59BZaN+rG92+Q3GrO/h04ioDpPyECGIaYXXYS5IQMHjrIiONBDpkegnOGVU2gG8X4AmyApkfqBQ5r9F1mJjfKugTFLCJHkXvIUPiM7dNvZuc9tk/8gspBjSiIS3+jnb66Z4zImPpWUrnHI8wb3CRE8HSZjW37ZqDm4QYruz6Rken88GFwAQ8/j0i/zTJwJlke+7HVeO357qD3i63bu8XCki9MkQzhDg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(4326008)(316002)(6916009)(54906003)(70206006)(70586007)(40460700003)(16526019)(1076003)(26005)(47076005)(36860700001)(2616005)(336012)(426003)(186003)(83380400001)(40480700001)(41300700001)(8676002)(5660300002)(82310400005)(8936002)(478600001)(6666004)(36756003)(82740400003)(86362001)(81166007)(4744005)(2906002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:18.2021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dad99a-033c-4944-b9f9-08db41f9feec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
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
Cc: stylon.wang@amd.com, Sung Lee <Sung.Lee@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

Reorder FW feature caps struct variable order to ensure backwards
compatability is maintained for older FW

Reviewed-by: Sung Lee <Sung.Lee@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index dcec8955bde4..09d4d0d9b92c 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -257,8 +257,9 @@ struct dmub_feature_caps {
 	 */
 	uint8_t psr;
 	uint8_t fw_assisted_mclk_switch;
+	uint8_t reserved[4];
 	uint8_t subvp_psr_support;
-	uint8_t reserved[5];
+	uint8_t gecc_enable;
 };
 
 struct dmub_visual_confirm_color {
-- 
2.39.2

