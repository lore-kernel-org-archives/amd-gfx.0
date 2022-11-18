Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09BAC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85F410E798;
	Fri, 18 Nov 2022 17:02:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D5D810E798
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcuXOTBIllkwxDUi3j5prjYNqgOL07Li2pV2VrrT/S1trUFXw87W2t3rbYlDdowZxsF4WtLGtLWcXoTt4PBM2nly7c5PmNtkngiVnLqFUS30GVRzg/W75W4/YOiz42ZSoLvKZCZ58/K5FoKZmqtFhLEpdw1MRKwl+OWBUoiSg9+WPDxWkKw5GlCAq0UizdYwGtX1EAVx9INYPeMLARE1kwe/WTXU2pHhKQUecoU14XpYu+DYG9O9OFY1FVses2nL3rwH3UavSy2CjQdLA1+WS40l5DnRhpvXbvhoyjLZJCtdSMBm9K/i0JQ/lWoNd0MEC3tf4EHG490NbubkAkCfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xfd/0tKjVgpb/726dchV6XerkwIWh51kGHuTXUMhDhA=;
 b=SRHPb0txh2GDGrGSlP+jz1KHy5ODFvV3IZ++4LUA9OY9411+gMQnVxllm+QMwbEDWE/TkavwkYgQaImggW3BtsNerzOTvZcNpc7Tvjoy72XlCCOa0Tx491vvw2P7qaiPVcs61K1nthQt8+3VCtMGOR/oPnnBLptukGYQDxJKhz++fOkDel9BZRt5wz1+wWiORAAaUrEOHYg36DxNp5a5XBPy8WB+5QvlznAoc+Pz0CQhJE5kN1iQPH9PrmKa0K13J/6vlpa5iddWgJxhbC0mU8C6dxPYZnR2J5hhPjMJWilzZ6LHpJpZRLgj4y6YgRGupDhVukyaCoDiAai/Uyu2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfd/0tKjVgpb/726dchV6XerkwIWh51kGHuTXUMhDhA=;
 b=LWpRxg2595cI9Ol1lzCUI5r3D2UCGPahcYN9AFbLbUKBuoFTv6poT4cbWhd3H7b6KPAI58RuiCJqh8yPhPwEaO8ri545Wbsl/MWZl1yTkGiQ16FAX+Yej/8aeKE5jM+Fb6y1EJNYGTuo+sS5NCL/Oj7N20579iklVFaKhMW03BU=
Received: from DS7PR03CA0212.namprd03.prod.outlook.com (2603:10b6:5:3ba::7) by
 DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.20; Fri, 18 Nov 2022 17:02:20 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::2d) by DS7PR03CA0212.outlook.office365.com
 (2603:10b6:5:3ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Fri, 18 Nov 2022 17:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:02:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:01:57 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:01:56 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:01:52
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/22] drm/amd/display: Revert check for phantom BPP
Date: Fri, 18 Nov 2022 20:59:33 +0800
Message-ID: <20221118125935.4013669-21-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|DM6PR12MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 1096c5d6-8e43-4663-cf01-08dac986a7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqVbc4sPIYHyoLtFgg86WQ5XGGz0TbrL0RQc/FnGFKv8hEfFwT2HOxopOdCWrDFxcoe3O68aEprnDuxFmj+W6cfNYThYW7v3rsUGV/k75MzjPYlGXzzCUgIbl8TJFhE6jxv+OoN0+FN10jERDeDKl4QxWU4t8WiM91QSnAE89JK0WQR3nDYk5qUTNaGN0wx0TjWjl/xgNOcvoiTe3MMRtBhzN5USk7uN5O9kaQAB2hqOPYcT3Zkha6Lit9OcjGGhILpE/bk8C3Izmqok4g+q20C6W4L8Ued9AloukezqqqvZ87kx1aVbUxnX912Kf5I/BDSBstSYoGlDPIaLPy++TB6hAnIgYiV79a3mOQ/6Bkn1Na/c1ERb3NdyWM9Cy+gxNSp/2l9cYETzLuN0t3nkKsMVd6NZ7yIveac0pwc9+iAIkHhcyeKf0jmdnBH+qTOZPNOnjj6bTsBg1sf4CT2s45rSrsqSAoXammDM/cntxxfN7/1zM+tqPJA4F2P04lEcAH32lPieP5ZCcaXLtTi7vEMiv8HVXlJYaNPDGYBTZq+tpSZhM/0gBsgCs5egYAXzN66wWDH0W9DGz0SmLOAlQGFl+swfn7MvsekDeKkRjvgdrwVPuV6Y+l6KtIo9XElYLWtN21LIfAlqdWDXiLWlbPnelrdqo2kDyZuNzmZLSP3EzPHwto0ALt0Dhl/5ObUGoTg5AhSA6ILtSKw6YNyZsdDsi1Fqg3K2ilTVSkpI1ePKvKogqSNFDLBqi4Mo9VqFVMm8B97K+lr6IHJsdlI6+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(81166007)(70586007)(356005)(82740400003)(2906002)(4326008)(8936002)(40480700001)(86362001)(36860700001)(83380400001)(316002)(1076003)(8676002)(54906003)(426003)(336012)(186003)(2616005)(47076005)(478600001)(5660300002)(26005)(41300700001)(82310400005)(6916009)(40460700003)(6666004)(70206006)(7696005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:02:20.0871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1096c5d6-8e43-4663-cf01-08dac986a7a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Revert change since enabling SubVP on 8K60 single cable
results in corruption

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index cb801eace8f4..820042f6aaca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -2306,7 +2306,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
 							|| mode_lib->vba.Output[k] == dm_edp
 							|| mode_lib->vba.Output[k] == dm_hdmi)
-					&& mode_lib->vba.OutputBppPerState[i][k] == 0 && (mode_lib->vba.UsesMALLForPStateChange[k] != dm_use_mall_pstate_change_phantom_pipe)) {
+					&& mode_lib->vba.OutputBppPerState[i][k] == 0) {
 				mode_lib->vba.LinkCapacitySupport[i] = false;
 			}
 		}
-- 
2.25.1

