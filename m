Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1A31061B2C
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 02:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4690710E831;
	Tue, 31 Mar 2026 02:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hgrzhiQK";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7CFC10E7C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 02:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQohAobwrrSJ4Yph7WRokz9gAwr0MZxd5CkauTIj7v+TckM52BRGUOhZ34w5FoOkfzjXmZKKJofDFZ0al9q2pEQ042yfsvdjA+ce22ITG3pn9RgNAYmo1p0zZGpi09Mt5ymGwdQLkHSZxXQtKdmiI9HIra0+LwtgKnnDhTrPBH63vbmeisXyt1TbqvMST26TUiiYzIGb4yJqgqgCO4EAhovfAPPif67OpTKRsCpmfwDl6Rzhtxfb8umgKO2+iZh2Emp7TwZCdYv3YO9IfA6AOH1EQNN/23LBL702O/+vQGrUj2IlCStyY/t0/HfWfihfrem3txjPED/C591smqJSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT+0JR8XjWfepf9CSCbvj8doxoboLbT3UwFIYpAMGTU=;
 b=B4rI9OREVsI0mIqvFnYBI/tPA8KvDj4CJEyAsIWN+cust0Uv8anFJu3m0tsCktflS03JpNR2frFZqm7rYHzsUp7I7CeywC/FjIA4QDCyW41xrwaXitWGVV9h5XofzmugJzLlWorNUwG7SYI1MfvgHcVa7GZK5lT0xbtL45PPkZn8JgDtuyCx7wHhyYCWmsTcvp5sxVdGwwGwhnF1/JfqQurn9S5KDLGieLY8M18JUOkoDC1Lmz0eCQ0q0V+SHjByEYBv7BwNyiwsPgFcae6xk0H/81lo5WpZ7zywn+XEqFJj5NrowwQRk126p55dACDdHeaH2++LHwO+HeaEeEERfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT+0JR8XjWfepf9CSCbvj8doxoboLbT3UwFIYpAMGTU=;
 b=hgrzhiQKrRDylKsFbDY7ApbNM+l+Tx+49S/WxwXsG7Er4VM9QkDVNPpHhYUkJflHpCqUzSvRkkDYt0jOiXhB+PXb3MCQnWUGcjJA5/JD1NdZDuQgeuHCPrdULDnHOIiOoNLAR+LL6joQA/NGo+nLG6MuetnA8Ud7hIZFRra5uSw=
Received: from CH2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:610:4f::35)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 02:47:21 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::44) by CH2PR18CA0025.outlook.office365.com
 (2603:10b6:610:4f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 02:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 02:47:21 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 21:47:19 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <lijo.lazar@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: optimize logic and remove unnecessary checks
 in smu v15.0.8
Date: Mon, 30 Mar 2026 22:47:05 -0400
Message-ID: <20260331024705.1361626-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331024705.1361626-1-kevinyang.wang@amd.com>
References: <20260331024705.1361626-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6344e1-f57a-443a-2bf5-08de8ecfd4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: pdvKCKqMtJnRgHzkKSh6N/p+6YAVca8pWHEqQ5Efx/CQ9wGgseZNfQzZxpybW3WqkyU8owc5kIgyeJ8GQK439kCf1R+xbSnVKOhjulKrxAf+eqQ90PTT+7YB2oSp8ctN/+YZ/4S4sWgdxWvZmGAvSDBpmm3BhVRU93S0aM14Ml74x74L805Inu3G+v8H/6fzV8QTIqqF6GW9oK1PbbU5w4CSCaiAGtj3Q+4MeWvLbDNJ0El/EeiB56KTOOwSgGDFCSCGO1ttAT9PGFnLj+clJhBo60QGDtweCJe/ar6fMgqyzdhl9FyuCINP9lNQw8Jdkt7NOQgL7tGgj7As+kLh11m4MZWBojcT9CJ7iGZcscPGafH6FA5T8dw2j5remePxq5FwZDTPOnwjzMcjWeQ0d2DTF0KVSxqjuq7gqsk4hPurQllOfwymQFNd+XNe0mwzbu8Y4HgpJsj0FChl+4XhMkaNWp9dcCVac9Neno/AwtICA6LBc0xyXFWbHJDO/Y57eS7UBfC1X6NnEl01tsk0WSl3MrA3BL3oh6rCk0xGxEKI0UCy6lZMNK2IosY/3ipEwWFQF9Y/wTcq4zF6eIj3mkMsj8Ev/LT6r6ciqWtRMQAXuxYAMsGtWQ+Y2JRLN0AFpAykLA0Vgi/M9BcazBpk/MdmTYaoGCjGVIzMD1GZsi+ChY4RGCz7p4pegDPPRO6Bv40665vmj2gMWcRrJ/r/qMS/XXHpvt1ryCpPt8/anJxwCNH30+QTOJe7kSymXDJmAvkNVpo0nSHDLJbaCh9Gbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AXZZZB7+p/luyj3HaNu44j3uRJ7B/NtHk2sKUU9xtb+Dwg5jtxIQk617B05CseSsWqBJFKLXWx3A9kE4/Jty6w3REe2meWoY5n+iIfffXoite01UZl6ZQeutt7CGAS9MS/VWHa5bDjjv0NTkyhgNKV9h2eASRTx8JlugrSI2NYzUSDluI/uzJrMu+zcUuRN//jqRCBQmPsJbn2mNctkJZ2I9aLMcoWsJ3U+N5+VSR6dQdZ3PxKM4JEabdW/5il6Xobg+HoMvC+QQ9bcZZwJyPcpEL5XPdjk1wBCDL73Cm1y0YuWc/7u+6FCbIhexm/qRZSNhjZu3n3Xo17PLENQCboskjHL9+4WIonmORCBF5jqk49QlUvsfRLXjQ1O4sSt0vcnx36V5GrTSDGYn6zRMQl39YcUFl5P/5MYsSJjfb6f40Fs3o9jFPyBJAxAfxRv5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:47:21.1309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6344e1-f57a-443a-2bf5-08de8ecfd4bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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

the following two sets of logic are clearly mutually exclusive in
smu_v15_0_8_set_soft_freq_limited_range.
remove unnecessary code logic to keep the code logic clear.

e.g:

if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
	return -EINVAL;

if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
	...
}

Fixes: afb58cd13e81 ("drm/amd/pm: Add od_edit_dpm_table support")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 52 ++++++++-----------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index ae43edfa93a5..a916cad40dbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1899,42 +1899,36 @@ static int smu_v15_0_8_set_soft_freq_limited_range(struct smu_context *smu,
 	if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
 		return -EINVAL;
 
-	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-		if (min >= max) {
-			dev_err(smu->adev->dev,
-				"Minimum clk should be less than the maximum allowed clock\n");
-			return -EINVAL;
-		}
+	if (min >= max) {
+		dev_err(smu->adev->dev,
+			"Minimum clk should be less than the maximum allowed clock\n");
+		return -EINVAL;
+	}
 
-		if (clk_type == SMU_GFXCLK || clk_type == SMU_SCLK) {
-			if ((min == pstate_table->gfxclk_pstate.curr.min) &&
-			    (max == pstate_table->gfxclk_pstate.curr.max))
-				return 0;
+	if (clk_type == SMU_GFXCLK || clk_type == SMU_SCLK) {
+		if ((min == pstate_table->gfxclk_pstate.curr.min) &&
+		    (max == pstate_table->gfxclk_pstate.curr.max))
+			return 0;
 
-			ret = smu_v15_0_8_set_gfx_soft_freq_limited_range(smu,
-									  min, max);
-			if (!ret) {
-				pstate_table->gfxclk_pstate.curr.min = min;
-				pstate_table->gfxclk_pstate.curr.max = max;
-			}
+		ret = smu_v15_0_8_set_gfx_soft_freq_limited_range(smu, min,
+								  max);
+		if (!ret) {
+			pstate_table->gfxclk_pstate.curr.min = min;
+			pstate_table->gfxclk_pstate.curr.max = max;
 		}
+	}
 
-		if (clk_type == SMU_UCLK) {
-			if (max == pstate_table->uclk_pstate.curr.max)
-				return 0;
-
-			ret = smu_v15_0_set_soft_freq_limited_range(smu,
-								    SMU_UCLK,
-								    0, max,
-								    false);
-			if (!ret)
-				pstate_table->uclk_pstate.curr.max = max;
-		}
+	if (clk_type == SMU_UCLK) {
+		if (max == pstate_table->uclk_pstate.curr.max)
+			return 0;
 
-		return ret;
+		ret = smu_v15_0_set_soft_freq_limited_range(smu, SMU_UCLK, 0,
+							    max, false);
+		if (!ret)
+			pstate_table->uclk_pstate.curr.max = max;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int smu_v15_0_8_od_edit_dpm_table(struct smu_context *smu,
-- 
2.47.3

