Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6355C83F33
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 13:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F4E10E335;
	Mon,  4 Sep 2023 13:10:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E6110E1F6
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 13:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBxG6DOr3UTXxBTrY687QhlO8q+IB0ZALoUn4yC4pZxGc2ps5jTowCEQCIRyMHRuDMjp2KMG/gTveltXHBwc0sy+oEFe8TZW72aFIR8FhXdBx53oTPHqYCb8GHhvWPhXh0iMdfLv5LIE752+qrgdWhrv+5ZOqKhUs6/LDBUevGGm9YFlXscBUk0cKW+zNXz6uZLcmJ4U+OdpindN4YgXUE0DCEUUTAVPWI1vZJjr/sQoCwdVPQw0FLQ2dDwpo9qzxbHIyeFR52ujS28kedL7cCVo6upH9Ifn2vaHZzw0ik8GUlclzdhbwEZtsLECjpO36I5LNp1EcoDD5xxIn8/ZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5BnYth9IEkJSKifJgE/Ur5vlchWQTY+gGneiQm3egQ=;
 b=jV9xVDk+D6xsSioqN32uwueTCI+YSHDACtwk8WMJ7wamL9QZ+zEHka0tdytEF+xm7q8wzV6mXRaUKkykwDqCr4gzO0stAmWSVjCUy+75fBMH8IBpMOPYevab28qBk15Rc7mklCHLKKC3Gj5Y47R3/7kWBMJCZHuXEe2xKM4im/VuzmMk9LLv8hLakcEQlSv+2FjAQ5bASIpS1RSMlmy5OgJMOISKxaqw9ICIawr+FDYxhOk/4m+0E0ny/th1B8NV6hhi3Y93KNYq4QT8jrn/wM6dn9h5au4d7I0xsMZk0DqGPgsBBYkmMMdhZFMXdGELxlnE1L7hhIlytx3I9+BPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5BnYth9IEkJSKifJgE/Ur5vlchWQTY+gGneiQm3egQ=;
 b=KhxvqvdrsVvZebv4PO5i5kvzo5ZOBVCtKG5iju05BP4+exoZaFqVLMSOpilGtdzNTyoVi2si3rw67t3zA11zEYUw9hK6cJzi/TQu4tKe2ZiXaA/ulsrIaMNFvPk57x+1bQ+dOAgllNKTPyZFpggzN+Y+88rAdYiYTGwsTvgIrrU=
Received: from CH0P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::17)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 13:10:52 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::ef) by CH0P221CA0021.outlook.office365.com
 (2603:10b6:610:11c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Mon, 4 Sep 2023 13:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 13:10:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 08:10:49 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm:Fix GFX deep sleep clock reporting
Date: Mon, 4 Sep 2023 18:40:26 +0530
Message-ID: <20230904131027.912234-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230904131027.912234-1-lijo.lazar@amd.com>
References: <20230904131027.912234-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4bdd3a-f36b-4436-7765-08dbad485dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MoIUss+E5DKmKCIfmlfBRGd4WyizcVStD/uaigq6JbDojpfVII9UqcDm9YnVC+QYI+UP4oR7ocCZFQ8c0YHLlMkk5PqsCTy/NeMso2cFJBdYusugSA6gs72Z976f3E0pnT2qfoiayBKG53n6DnfGeXexwTct6jkwkutU8fkCSSca5L1XSAZPQDeIvG80cGn2rPajpnU1cB1jorPRUn3WHgjvK/ZJQj3ODsnuJSmXoWHexERotnVdc59yB0MeXZMQjiwVeysAe8U6Mo1Nq0fz7EKXF2HW4tTzyugIK+tS8i9auV+ZkBAUJEE2o1q+4fYDsKej8BQsNetjcdBFSU/U3Xit/oA2x0sGW1fYWAoYLR0RT+kwYdoer3SwFQH2LV5PMJOrWTznODUhkYIVaDI6FS4jTWo06kAhFCTaY2U87KwYci03nE5AqZ8gnwxQtpdpZFTc3S4YV/ZVpHmSeG/PtKxUIZhonixslPhXDHnnpLUN/hGVLpVydUW2/eKruHp5XroMqTwG1EZwJgeVUYNpGtfNOjmD4PRIKW4PKEmz8QCn4F/zUnKz4rghbBIYEBfn5SsWoB3i6AzdmKR6lBThGNC+fiESsbORYkhCHNZJO7+kSHXPzLVwTRfwcVXc9pcbgNlrwYtu6fKhU6ylAPq8uNLYgH7xcj9jKyy+0tmkwxRnMXhkv51R0eTp/FN0Kj9mV9ucUZvzI5c62JBJ1BtVQLdIxYG9t2KAI6uSnyxwib8xYGW+elcHvyOqccUm6NwTxDthCLXNn8L95525Lqz5wA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(6916009)(36756003)(54906003)(2906002)(86362001)(70586007)(316002)(70206006)(40480700001)(44832011)(5660300002)(8936002)(8676002)(4326008)(41300700001)(40460700003)(1076003)(47076005)(336012)(2616005)(83380400001)(16526019)(426003)(26005)(36860700001)(478600001)(81166007)(356005)(82740400003)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 13:10:52.5116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4bdd3a-f36b-4436-7765-08dbad485dcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SMU v13.0.6, keep GFX deep sleep clock reporting style consistent
with that of other clocks. Sample format below.

S: 78Mhz *
0: 600Mhz
1: 800Mhz

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8fa01c5570bf..06a1a6742561 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -869,7 +869,15 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		min_clk = pstate_table->gfxclk_pstate.curr.min;
 		max_clk = pstate_table->gfxclk_pstate.curr.max;
 
-		if (!smu_v13_0_6_freqs_in_same_level(now, min_clk) &&
+		if (now < SMU_13_0_6_DSCLK_THRESHOLD) {
+			size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
+					      now);
+			size += sysfs_emit_at(buf, size, "0: %uMhz\n",
+					      min_clk);
+			size += sysfs_emit_at(buf, size, "1: %uMhz\n",
+					      max_clk);
+
+		} else if (!smu_v13_0_6_freqs_in_same_level(now, min_clk) &&
 		    !smu_v13_0_6_freqs_in_same_level(now, max_clk)) {
 			size += sysfs_emit_at(buf, size, "0: %uMhz\n",
 					      min_clk);
-- 
2.25.1

