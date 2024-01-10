Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36EFC4706C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 00:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6794310E540;
	Wed, 10 Jan 2024 00:56:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D089610E542
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 00:56:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbbrsj9N9IDRBL9eJwosnbc9ED67qgL0W1MPbNiA2uYe0jdCEf0I572zcrDgXUMOnRhn+nywzLabCcxZpRlJVkmuJHWXiC9rCxhzi9Eq0tJyWUqGRQkA2EALh5PKFl5DswFZtVu5PAiC0UTcnBpT/NwLtSjOJJo8SitnZypW80V6xZzlYT1fZ/UiLD+WmnCzp3Pv7Bj+gAJbd7bjuXmnm5sbHT/ZNWDRo2Pgj4odu/aUxIZ/0ACbdQPpqVyrTrZIDwiBoP9go68utDaXYz9NZ+Qg4jwRqc1hrEaYgO0hmEaVIAUFKMk3e0ZBMdAlqh1ZhAxfaRTrmr3X6PcXWPKXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6E18YkOdIaPZlrHCgb7/kUMeRBWyIbKOqxqOOWN/h6o=;
 b=UeRLo6pqwsxmgVteNz/vmzB9I7Fg8xWxKQBMFHombS2KOD4r7WS468dw1GNYJdZMB8YBORZP/1LQ60rRywVbHh2tPZrP2lkUBlcy2Zk11pHf1v7M0m3K3oOmc+30VD5KgnLayo2YKt2SUL48DMOFLCphpAp3OLrR1SjqMdb5Zwl/lqJ4vzRtK6WluHhlLdpiaxmHD67XUCmzNfb4aAD0gCj1STGXA5xye/8RjE8jCNlaOcY/6OYukL6oCnLelGH1zthY2c3f9G/RFTJmlm+5CF/yajylK9ZuM+USrgGC/QEWvujAD95x6Bq8Gq35Ae100uTPHVB77iyELdgBdhcBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E18YkOdIaPZlrHCgb7/kUMeRBWyIbKOqxqOOWN/h6o=;
 b=llXo14jwM3poC5wQR8ktaad4lp0Ya8L8yXk7aroKAWfeWmwiNjsjtrRhqL5IJgXT12dq0eHJ+jo/tD84HR4wHOCl7v/GVnpMvWPQcBOpHLKcG6BscygtVX3SiziIUOsZaqYvsForzRBQujHisytAurFsDvj6YQPAXOze1vVkKsI=
Received: from DM6PR04CA0012.namprd04.prod.outlook.com (2603:10b6:5:334::17)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 00:56:03 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::97) by DM6PR04CA0012.outlook.office365.com
 (2603:10b6:5:334::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 00:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 00:56:02 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 18:55:59 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update regGL2C_CTRL4 value in golden setting
Date: Wed, 10 Jan 2024 08:55:38 +0800
Message-ID: <20240110005538.1151650-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 67db6c1c-156a-423e-0611-08dc1176eb1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKvomRZEFkxCkkdbw58TxH/ukKjLmz39x1+g68TBYms1wv2JyzS3o+v7DzcNDv5OZ7XKEZDN8yYwPndEdE+0b3WZ+s+F3XsQ13nMjTpbYQb/6aR7XOI6reVZ5TLWX5t6B9qauwL/obgp4mqxjWzWzbWfbdkb1ruhfVkwGTLJGx/jAKBYmY97NhOW61xxrfly8k62d3w/K1aj7rpQAUiIVLQWAPD+LT02wV96m0kyxbKWWnXF5ZBIZ55YJiDGETqG6lqHU4+OAT9Q094PhbDWFqSvw2lXgxd+78TryQq+3vcyfb1whDdSB0eCYGAqtPwxuODh0BG6qHCUag6U9mgiwj05nOpXr+PJUQ0jc3KpBSkkFIv0+HH/cLoRmQNOsYYNRMUKGpzpcAtlQV5v4++Y+KYGvlvAl2OfBXaRz6HH+o/HApryZOQtBoRPZ5asJBPodSQ+uMHYMFi6bm+4l51G+vOYZAS0x7VRUvhzJQiaOoXRYeqpY8sUFxOBQzQUBy7+2/n1HL6kKgUL3+Vo4vBMMrhxEy3trOZLi4/kuYbFOLumsmeA6ePVvavAwiV35XrrFdueZ6MC1SiXduCCJcABuYZSk5wsgQh8ocU8X/Wp8Aj1Hf5cvSqQGQneWar96c0ypLmtDT7Bwewf4x2NC1SJaDS8bkdukc9/w5kU8dvyXe8VhOXtSkIzU1ePC4srI4vnpRHvwJw8vCz8V+9zFC6B4LbF4gxUES1M7lEApUvm3DhEbstuAmx8HMcK1LnBKfZ4zbqRVAOQXgDh5H9DtAyptg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(36756003)(6666004)(1076003)(2616005)(26005)(426003)(336012)(478600001)(7696005)(47076005)(36860700001)(5660300002)(2906002)(15650500001)(83380400001)(41300700001)(6916009)(70206006)(16526019)(4326008)(70586007)(8676002)(8936002)(316002)(54906003)(82740400003)(81166007)(356005)(86362001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 00:56:02.7347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67db6c1c-156a-423e-0611-08dc1176eb1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Lang.Yu@amd.com,
 Li.Ma@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch to update regGL2C_CTRL4 in golden setting.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 36c4efd89dc5..43dec9dfb3fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -119,7 +119,7 @@ static const struct soc15_reg_golden golden_settings_gc_11_5_0[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL, 0xffffffff, 0xf37fff3f),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xfffffffb, 0x00f40188),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff, 0x8000b007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff, 0x80009007),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0xf1ffffff, 0x00880007),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regPC_CONFIG_CNTL_1, 0xffffffff, 0x00010000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff, 0x01030000),
-- 
2.37.3

