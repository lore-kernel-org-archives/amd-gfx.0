Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED37C04FDE
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F2510E576;
	Fri,  9 Dec 2022 16:38:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2F410E565
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViNe0Kq+gL+LYaA/24+FzuF4u/a1//rr67winWtdk5qBWpErtUUpipIctEyCxMoT7/APEcn1zJ3aHFT5s+p8x1ZF6zj5MeCJyLl5f1TCXq1ka1UU8kRPVFTKpsP86wzNf41E8B90ZVJWwqZpgZxKt7Ls+KsKSXioOyUxOPy60+P+JOFuJoKx+86g55q16YJKKhJWJGsDhbh9olUhSDMgpiBNL3a2c2n45T0tfSoPdByu6jjPBsgusLEhs/g4Ul0lIhEThBWkR9gWVQCng4E9LaW8bbz9kEVcXB7T8OfF7HVMcSGVO24k9kTMXOlMNIWcXfv4deY8QzO8DGJmujTYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nscUquQlqzRHd1UICy6IUPy0TK6/2Djo5PF4r0shXoI=;
 b=BpkxiE0FysDYlx5RuKxu3DKDMStXsidE8JIN8NmRNcOh7S8BTZqvjytzQLFXajMLrqRqTsubK8MWSm8s7ezTcKmeeeVsvyLAl+NwLMHlkbT0f14mch2Oyfuwge652+cgJoOoLw5UfPEOjWdiyHJpmE9T+Ct10OLwCe2hZFmgHnEbdTuTk119GRuYnq+wln/DBF+WXmKCAAzWEcCWAEI5wOqBuyW8qtba3KyoF8ropYxNRzggTRGeqmRAGDqmU1k8i6xFHhswPmIJU7FWu6s1S5A/2M5JBhbZKQx3NKGc/xbWifRkROe4S+1yT+XW/LqWFf15SGb46dQW9BXuai/vpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nscUquQlqzRHd1UICy6IUPy0TK6/2Djo5PF4r0shXoI=;
 b=nhXp/PfmHw9VgmzEe8Btf37ywweOfGeNchI7P2jTBwvCsencRp1qbTCcBpzJ98rTd7pF2ikkyYhv85SL/YSDw5IL3MOW+pR0A22lMr0DWBseFBsQhnuIaikWrc/XHsK/5IB/yLUAr/ltWsg2QtoPgr+pZ5C2uNsGUvNPlPzsKRs=
Received: from MW2PR2101CA0032.namprd21.prod.outlook.com (2603:10b6:302:1::45)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 16:37:44 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::c5) by MW2PR2101CA0032.outlook.office365.com
 (2603:10b6:302:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.6 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:44 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:39 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/23] drm/amd/display: 3.2.216
Date: Fri, 9 Dec 2022 11:36:47 -0500
Message-ID: <20221209163647.25704-24-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f2770e-3938-4f8b-cb32-08dada03b2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGoQWcE7TcFflww/swEq2xWZPRAB5vvC4FNMMVR5pmt7N+UeNEmUdWVAa8Q/MXYH5kCEBFQNdoOMTKNbdcC5e9q0aDwzTj/jQU+1OuKlwRdGh7HAGYX9wSTQE+FCF1LUy55PTu4DLcreNvpwTZlx+2uIlTCi/BjPNfG5xsB6/7Mx9Yhy20VYwL0wdUyb66maMa61xPBADov2U8jz4QRTfqxRKsooqgvQJ/Lt/zLo9ie8A0MnHcvQhNSKYVLm3Na5Rv/xTEdbUytGJ8bcu7pNGP+o3iVxSH7y6A2IZ5XiQ1ojvnX5valp9NEA6xVaxHiumIGKc2kHF2qzaReSQMU9Tbz63OxrKWoIeY5pPJ1IUGRu/dQEU3IJdB8JW+NemBO9u448kYG7n8acuZmq2Y6O/jU/gntb55+/nYte2+l+Xh0DMr+2DIYLWV2Qql1pnwaRsol5FTbqB4AP1ilZ9F11Rc21tn4tEtSv2ZxmWZP9ccR+CTvldahpvM5OYnMpZVlHI6uh8WWCXtTn0nxnO51IDXUIqYWIWLZWX27d8WAO/DszLDwrhtKwwROY9d7sTmfDahSmkLlSzZtbtd4RBFjDkdWPGmFuToV6Zakk9mBUGPTfjmDlafAgFUAVIhQbQ8SjREQTJ7rbd2dLTkO97XY8+bs9MPsyd5SSNjfAvnPNGOlxQGcA2rFKdbViMRZfZ/R3O9QZqbMtIBjsP+hWPdViTvT2+zP/7WIY6dlZP/sNMR0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(4326008)(70586007)(70206006)(47076005)(426003)(5660300002)(4744005)(41300700001)(83380400001)(54906003)(8676002)(40480700001)(16526019)(316002)(186003)(2906002)(6666004)(6916009)(82740400003)(336012)(36756003)(1076003)(2616005)(26005)(478600001)(82310400005)(81166007)(8936002)(36860700001)(40460700003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:44.2471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f2770e-3938-4f8b-cb32-08dada03b2b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

-Fix array index out of bound error
-Speed up DML fast vadlaite
-Implement multiple secure display
-MST HDCP for multiple display
-Add DPIA notification
-Add support for three new square pattern variant

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a76031d7e202..c14205e3183f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.215"
+#define DC_VER "3.2.216"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

