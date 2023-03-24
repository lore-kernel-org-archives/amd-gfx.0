Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF83C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D5110E4F8;
	Fri, 24 Mar 2023 06:53:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E64E10E4F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMRN/GAgjtHmeZ2Htrm2Z39bsnvr7fGw9IiLekI66WEsBtVUBWAov85r+RtWbMnXlvZHN8HgjkAIUZ56A5V6iwy2R92qo69MtuFlAL3o10/4o0Y7HqJNJYpgUdPBPkTfz6vjln7FIO1leHJO8ooH050c8fqjnspNI+Z46nXBTsZUmpRdtrfa9ThbZv2eNpRzUm5hwd3JtibklJjMUYlU3XGF1pJnTDerARPrMpwiVi+kSBMW2THvdKC0EJo/HxlPOH/uW/xXpeHgLyBfFU0gfRyTi9OKBFuWomdnapDz6IR6oUiBbYJ01hYDsDrrRFbJVApxC/q+YDYwA+0Pi16aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOaqRCFZlb1nzbWQ0WBbOD5SRsRi7qUINFoaNkdaWK8=;
 b=jan9u6IRAttAYV5zGGGFdcpVP07K4VV4gb1v3mMy6ro3z+dy3HO5AdzhE/NI4ymXZSBrLp9KDDB5pdxshCLSV3heyN48WJPKRcw8bUB5VT9RVekIWXflR9uD1PhGstKA4APICqxWGjuK+scmzEY9yMCu6BCj96cXvRrzuHPbo3vK9oOC0/6K9IuXykocQsdBJt8Hkt7vVdttbStspdTrTKARYtipvKA4ZdVh9Ksm/FN72eLxeX8GmQzK0KxkmfnBPcaZaHm7x8t0b+3Fr9xNA1nEzhyBR2Deiy0ytjgrixZVAngzRRjuMQhOgtf00xhBYxsSC3csQHnLK5p/WZ2/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOaqRCFZlb1nzbWQ0WBbOD5SRsRi7qUINFoaNkdaWK8=;
 b=ZX40jubFybWf/LzFsnRLzYlBg0p3412dKiCFHdDx3ox9T05NitjUNxw7G3YGIW7cb/C0BlgB+N2Zf2TD1Uxq9Z/af5lZE+1cefQDniWxJlLc6LlmrcA0lVxT01q6sV5ffn8T3xBNdPRKZ37+fKK5mrSXfxTdZioN1bsfRq8WYSs=
Received: from MW4PR04CA0236.namprd04.prod.outlook.com (2603:10b6:303:87::31)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:53:13 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::b8) by MW4PR04CA0236.outlook.office365.com
 (2603:10b6:303:87::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 06:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Fri, 24 Mar 2023 06:53:12 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:53:06 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/19] drm/amd/display: Enable FPO optimization
Date: Fri, 24 Mar 2023 02:51:07 -0400
Message-ID: <20230324065111.2782-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a52ba93-e8b3-410f-e243-08db2c346ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRrIskmtZUSzLcwv8MATqeT3ZCIG68EOQ5ktezlc2BZf1ojd5/FUYNh/VzHCOmbzDZyTDGj1KymjVLKJqGZdGjip9axypyDrVEltFac8Mt4EyDHmzzslRDWY00LBZZFQXfz+XFrhg2iovOBYlhoMmcWZAmfTl23fBuYnur1Piq8ZdCG3cxblYKA66A4Nsty5u9HGC6X4N76mPKPdJG9ww0gIfSS/evX3eFKvj7T8VkJH2ruLlL/Laj6k/ERQrlzxKqnLQpzYxuEv6FoIn0psF6/vYw/GGKUH/v1EQALyEoPjVo3AQpCy8OlZ2X+kbsqh1pnfavrnQBgCBxB9vM2ngXoqKmM583DfKQCDlHTS92M2xq13SnNnZoZuHGDb+JucsD0PUt8WjmNkxz1IlXjc3OguClFpf2F4VNY/wLHrXoaLKM1wq3Avcf38dFDdC9Dv82M+bOe51mIf3FjBd6MlJ0ygYnu3H+FZai0TTQOGHKhUqVXSGXPiif1q7QwkWft/16eq0F4nTzLP8Bd+hOSJSh0uFlHcglufNZp6ZjK12sP+tr5SliaU1lSWU98F0yDpiNxXKECCVNji2sBU8ohs4O0ZVNX7/pzRt8jnXmivGbs658UtTPILv0SYr1H9GwM31t6yi7cCLnMG7eRgMRcDZmbISkc3O5QycFP9rOvj7Y1sEy2LxW6QS+FmRHBZ5C3Jo9Fz+w/sE5iIxYDafJvYXrVB55nS9k8L1FgV+Qchi0Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(8936002)(2906002)(5660300002)(41300700001)(40480700001)(70586007)(4326008)(8676002)(6916009)(70206006)(44832011)(478600001)(316002)(54906003)(26005)(36860700001)(40460700003)(36756003)(186003)(16526019)(2616005)(336012)(426003)(47076005)(83380400001)(86362001)(1076003)(82310400005)(356005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:53:12.9630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a52ba93-e8b3-410f-e243-08db2c346ff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
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
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Enable optimization for preferring FPO if it achieves
a lower voltage level

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index b8c1de357e5f..502f990346b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -725,7 +725,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_prefetch_in_strobe_ns = 60000, // 60us
 	.disable_unbounded_requesting = false,
 	.override_dispclk_programming = true,
-	.disable_fpo_optimizations = true,
+	.disable_fpo_optimizations = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 5e0b1484dc18..79664ba7e7af 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -723,7 +723,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_prefetch_in_strobe_ns = 60000, // 60us
 	.disable_unbounded_requesting = false,
 	.override_dispclk_programming = true,
-	.disable_fpo_optimizations = true,
+	.disable_fpo_optimizations = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.34.1

