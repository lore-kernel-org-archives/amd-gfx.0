Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB6606A68E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0f1lJ6Uj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED6C10F58F;
	Wed, 25 Nov 2026 06:56:44 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E019310F58F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URovmJG5RKy5DVTAHkSptuyh5N2iOSqJEwAOBIlQtiksFtDHVatHFxUtzvFdJC82piAoDMuJbrcGBG++5IWQlbc2QjVCvU/LN7qyRF0q6kCdSw25UKXS0/cUzdQQZFk82tJsJ8Uysga7NCQi2M5tK9aejMWz0c8NOEXemo66IXUBSBZUQotsp+n3szTxru+zovdJ7lD1fMt9WbljqFtemw6eyE62D8Ko4w3q0ErOr3zJ9w4imo7gb2mhshcq/RLmglGrYgQ3MLkNTLDf3Gcp586cuDoDgm9DIPUYTAvVaeXin9NVv3nvRwHzlx+RE0DjF8XaP1yMogwvXUhOTDx3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XuCXoxzzT9Pf9cv+3QmL6NwyIxkdKOc0dhoJSuBRDg=;
 b=HyjKcfJPtWV7fX3WZwjachEGIuCFTXkZ4LtfajXtxmXezq+P96qTXPwH/5AdtkeHhRCszCSGYS0jbucuPE6r2VKjuIFJjmt31D72wQnW+Z1BeJEh9Zt2D5mnQDjeegJiwA2ouMxiqmiHCJ2D74taVVTfqeU7tkbLWbT1N/e9KTeDSl9QQ1huEolev3/+oDPzkwUL5VktVWt1bMvpyBLPPaQtWtcIbWqqcJivV1RsBnv87jnPgH+scugJZitUsMz0x7s/JOmkrG2v5a9Dk8Ysoovkdbe1jbQGLRqyRZ+YLeZdW5F97fvwbBR4t2m/atbVwFNhp+3XSEDdfsMoP3apcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XuCXoxzzT9Pf9cv+3QmL6NwyIxkdKOc0dhoJSuBRDg=;
 b=0f1lJ6Uj9D6ekNLt/27sIC3qj5NuS0jHpLEOYOZAJtvmCzlzMW84u6TU70kw79W/lcPBg+kZAGKHmphKmf2SLcITMtjvO+dQ/r7eG+KOTxxlz0L0LP5kfIHtMzS57q0jzNa+CWpN+p9zpAclUYnI2Mo5dKXC6AjaLfWMjX2KU0I=
Received: from SJ0PR03CA0111.namprd03.prod.outlook.com (2603:10b6:a03:333::26)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 06:56:33 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::48) by SJ0PR03CA0111.outlook.office365.com
 (2603:10b6:a03:333::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 25
 Nov 2026 06:56:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:56:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:56:32 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:56:31 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:56:23 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <dillon.varone@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 09/27] drm/amd/display: Derive DCN6 DSCCLK range from DISPCLK
Date: Wed, 25 Nov 2026 14:54:58 +0800
Message-ID: <20261125065631.3889665-10-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: a094e71d-c403-4f74-9bfd-08df4ac13d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|261022105027099003|10067099003|261026140227099003|261022075727099003|261028144727099003|261102123227099003|261021121427099003|261009223027099003|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: KcgFY7JmfuTDCG6D48f7F9m5xKQh0MS48C+8aN+yqEa5c0jQneICVUNekfrlvVrNpU6nnIpNCGSrXDL7ozpr+lppv5nY8Ue5N9A7ZooejbV2e9g9eFSpoln0G/qa92A5zsEhQ7aU3/uGkFc3bOEOpJDB/oPdHJvWPvhSUIn/QCX+rXF+RIKF9oRJUy70qQLQMyDz1EWcJxzyVSs5mvJTx9moQo/E68aFkGucPlL3dmUAEgA6eayGS1zlZvjj7s0Ht7K+P8VwP7sZ38B4+4AmNzCYopGG/aq4Wj5HVquAWOmPrqqgx0kTkDhs1y2vksGmglrRHFJCtY7n2/cfiL1UEa91jifE8JllIDQ69EFbJ4FSa6XyJ+v6jw1Y7o4PN5L8SmjEd+zOfk/VqSwaxUDpWoo2MgLJrhtf852JjPTUaO5xFp0US4IXx9wNJW5pswblwoxlnsfH11g4rkK5ZQNPpzQK23/df9xaHibUh67mpi2z5PJwzplihAINLBWwobhfoazn3FZL07IV3R3aU9IllRM49Dt5I9wlTcxeW6GxQAPnLx/KKMRYzKIe51pMK9nUdL5sK8uU1cH2SIDq4kJwRatx/N2ruY2Ya3WjS2SdikNT8ugZjLpINhuH/KpRc/An4//pYJnRhLfrArebQ/Cch8jlsVLhmrWt5EybkU8Z06Tc9tA4dw/OAoaT5rjE/5OjiJVV0UP7YeauNRnLc+b41Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(261022105027099003)(10067099003)(261026140227099003)(261022075727099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /T76sp4Yjv6UwCHKlrt3S2PwY/m8/23J6Ehl8yvwdpGukKZbrqCnDP4UAS5HwERJlCnzWRQhA9qO1jav2KCy0ANQoQklOWE7Oa04nLp5dnJC63nzMdLQrtWWtWswhaFAPSXj/tcYZ91nXv2yrvhRcvn/m1krSbQqWEz2ESY2TBckwtO+6nA5URSxCPA6hBpLPO5FDlwVwXZS451jXFs0ezrq2PFMxbz0V/uIuhNpsnSTId21OfE03/t4taUZpv3kNfO9LZ4G/xBbfGaIRYpl8EHHLOI3LXzNFJ9ar7VoO3OvWmnNq9Ax4gMVtIBABmKIQyIG0vLKSFYuQMPxSJVIlA7wfTQJDJP8Ilk+FBZ75zbGm+aqPLnHSYfiSKRJH508Kfo8k07RBmdZWUYNSw9wKb9Txo6W3jJ3cXoQDGFAD7YkpppiocF7/BbVShmDHOdr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:56:33.0010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a094e71d-c403-4f74-9bfd-08df4ac13d86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
DSCCLK limit should be derived from the real DISPCLK instead of static
soc_bb values.
Set the min to 0 and the max to max_dispclk / 6.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../dcn60/dcn60_soc_and_ip_translator.c           | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
index f33e818d1b1e..9c92c5bf7a0f 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
@@ -129,6 +129,20 @@ static void dcn60_update_soc_bb_with_values_from_software_policy(struct dml2_soc
 				dc->bb_overrides.sr_lp_enter_plus_exit_time_ns / 1000.0;
 }
 
+/* Derive DSCCLK range from the final dispclk table. */
+static void dcn60_update_soc_bb_dscclk_from_dispclk(struct dml2_soc_bb *soc_bb)
+{
+	const struct dml2_clk_table *dispclk = &soc_bb->clk_table.dispclk;
+
+	if (dispclk->num_clk_values == 0)
+		return;
+
+	soc_bb->clk_table.dscclk.clk_values_khz[0] = 0;
+	soc_bb->clk_table.dscclk.clk_values_khz[1] =
+			dispclk->clk_values_khz[dispclk->num_clk_values - 1] / 6;
+	soc_bb->clk_table.dscclk.num_clk_values = 2;
+}
+
 static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
 {
 	/* Individual modification can be overwritten even if it was obtained by a previous function.
@@ -140,6 +154,7 @@ static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc
 	dcn401_update_soc_bb_with_values_from_clk_mgr(soc_bb, dc, config);
 	dcn401_update_soc_bb_with_values_from_vbios(soc_bb, dc);
 	dcn60_update_soc_bb_with_values_from_software_policy(soc_bb, dc);
+	dcn60_update_soc_bb_dscclk_from_dispclk(soc_bb);
 }
 
 static void dcn60_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
-- 
2.43.0

