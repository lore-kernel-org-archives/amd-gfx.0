Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D612C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA8D10EC8D;
	Tue, 18 Aug 2026 20:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0jQdFBJX";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E9310EC93
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIDaEa1zPf6gR1JU3Vd0YHij15Tm+KyoukR3L8eg08u87M/8HHTF4ib22/BH46+nvo6UsBAgDY+XFkeshmIxLrwd6XL7grqWXA6iboPMyAp4hdtCX/EAk9q5d75UbPjaF0kXYj+S0gXA5tawihJ0Qkm4NtapYh1L23eTMNhJnnK9rQ58Q5yKtMMtEfhQy65quTlcKl/0q/TvUMXBfrifkrKKsjtda0mNOz2xbAg+QmP5xfu/BAaTCnKg81ktikWjBDRWHDiEKTlwzEhCEQ+tJpcHDcehlli7cd+phY7Wus9vabkazARe8lHGo4BMbnI4C3g09GxsAxYTEfwIJEg98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIKTPwB/JdJiN8co/JMxtANkjcMN44xuZ44mod6d6A4=;
 b=oC4Vcg2lrfkEx8ByqJwZQHLMcLjzwhRc0QLLX0y/NmiV0ScHvLnqFuuevJ+l2jVdihmoSo9DmvqJ6AcHGyLUoFzVtu47AFUWKGK/choXVoqCUpa/s6N4uAxLfPMhA3SJfAAtjLwbnM/z2PnrzWND6puvgP0JpmoffvRT7VFXEJdxbhCq18FQir4w6tQKMoZ80lbyj7/jWXEJuvDCocE8G04HwX++AjXQNpQcijYPviTq9DQU6XXm/CXG9KVX1bTluvL0JNuA0aPlSXlYahL2BGX4BCLORiWE10NiiFJ8HUO1ANeLBw4tmJzX+axFEmXQO8dV3dpt0W1BYP4hWGwX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIKTPwB/JdJiN8co/JMxtANkjcMN44xuZ44mod6d6A4=;
 b=0jQdFBJX28EBMwy69mSuBb5rGcnCI9YGrxU6UNPoiVmSY8TgWr518x+qUTjnw6sajwKblzhcaR7Ic7il2/1zp4YPN1v184Y79/IvZmPcAMiyGqEqQyxvSPHsdkGzdIJ+BfmQWxE1AwEgd8Y9L9jSvbkPJ5xri0ATUqdw+8d5PBQ=
Received: from BN1PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:e0::20)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:13 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::38) by BN1PR10CA0015.outlook.office365.com
 (2603:10b6:408:e0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:04 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:04 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <Dillon.Varone@amd.com>
Subject: [PATCH 15/82] drm/amd/display: Disable alt-ch until dependencies are
 ready
Date: Tue, 18 Aug 2026 16:15:07 -0400
Message-ID: <20260818202139.4172592-16-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: f8139141-66cd-4196-7389-08defd66632a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 3V2BdTPsTjoIIdeUfjyqqYXr776g7QUsMNmSu6IXpjWzc0vvTfiSw2qudsyHXIULVXGvS0dVSqOtz6e4jFt+jpVb4nZr/2vvOrSL3xudqlGZpkrB8kQsq2LLc2FSpu/iB1fnxCHfWnlIZfkP4yWlYFoD7T7s1DPp51IXEHG33oNS7lEHdtW+mo6ZNTfuGjBDR3s2EomECwIEt0Gkwqf16Zfg8pLtrpf6QEWY3cwsHg7Yb2BzveCres/LNanB02MJUidDkkRQoQciASheiOXs2rXDCuAy5NFxfKrHmatzgiyW+u3G4lr5zrIDDFLOzUgxpAXlztWYmQaptT2qqQ5EHJ4+dhBgDIUtbS/o0+RLkJnK4Km+qXN/lh8Apfi+s+ZM5TMINjziviRxjRFxrmYtsRHeJsClZZgZqP3uUcPRhRxitf+wlVnoXXAgr0RKo7tb/Cf3+VFJU7NrjZNo/DILlqrZamVGlpAKU8U8RvirFzVJwrWKgBxF+gBZkJV+Z7aFig+xkbmFs8dsKEddNQAFxwNpir+NmT0c43usK0KzGte9K6plHEvOmqSoV3VnzP3xUbej/lK8uG2RG0zz45d+6QMU0IAYor08E5K65mFLIhRzJFvgsvKc5MtSB51/PM39WfWQjfWA6dFj4R285r8LtjeQedO4xP0FnXASKTaB0IQMXultqX7o33el5PfpJkRzWt0rSBiG4Vl7OItj/H/bxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VqbVxkyK6QHdyGom9En2KmCuleobV+myBW0aHQF0GxdA2NbvUn8wUnBv/5Gu6RuLkGkI4tXc72W4pbREXe2oeuA99c1t76bsSE/sJFi2z55xFIaCQ0J2CdKjV5A+pUugNS/ohD55E48Hk/ATJd1UfoVYA+Cn+qt1zVnxRlDenZcI2Nf7dL7pXDyufsLfPRp34BcEbqrR+YgtP+W/xuxM/qqe0naK2z3xx4KrrTFQv8MNyY7WPXkebFJ8oPH5+3b/B8PDlyudaeaZqQyb1wV9k0c2atn4lLxy+VJb7PONEBIL684UBMZWglQdRyhTqHK18DbHeHPn2pRHxtV+s0zEu24eU3ZAgo8Njmll+THXV3NNPl4m6qMosPv+G+22aMxxeOCz4vfU/jYMLkzhvp0lrXzixXzeLXd+fbV4vwgoyt/cv6VegYOfhGYooRzLjrcp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:12.5014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8139141-66cd-4196-7389-08defd66632a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Alt-Ch cannot be enabled until all dependncies are ready (SMU needs
  to support double p-state + IFWI needs to support G7 regions
  enabled).
- If PMFW enables UCLK DPM without double p-state support and alt-ch
  is enabled then hangs could occur

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ivan Lipsi <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 7171b237c4278..d7947105af223 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -671,6 +671,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.force_cositing = CHROMA_COSITING_NONE + 1,
+	.dml21_disable_pstate_method_mask = 0x20, // disable alt-ch unconditionally until dependencies are ready
+
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.43.0

