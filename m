Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28547C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD45910F6D1;
	Thu,  9 Jul 2026 21:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="StGJgFoL";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012004.outbound.protection.outlook.com
 [40.107.200.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A38D10F6D0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzO2GTsZvelSTlXXNxLzr8H1DwdHuOmEjKMVGg3yOPmdUFJFkDptoyZiwMu60mRVQEu7LcAngcAgibjQ8EsEoG71Mc/c9VsuP9gRFU7EKHeKnGXlvc65R8xkgB+nfmNiDOTejgqdPpPHO5xt7WZRHQO4NUMR+rhmoQGIHV9ozyIRp7KR6yQ4EDnloEU7hr4oxKU1VDgk+E8TIhMwU7SqWyGCAmYpACH7QTNH2KuljSSw+U03VDiIbg+cwTBF9Q+HZgtp0GDxDwyQEXHbZP5r8Cl9E72nLmKZasa73Gz1OPl8T4w4bn0VTq7tsAe//WUPjo/5X7/c1m3wzwkNs57f4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YchxyocbQd+dJPB9foq17gREtZphNLbp0OEkNUUpbeU=;
 b=ub1NLsIUtOkMXUNSOYF4Bf61pUwOhv5xqtLxOoWAKcc9Cc9artD1Ud6oBTo6N9MzImYMYxVwjvuV9+2qaDl3xNC2FNdO93FMOTP4KkuEHBGyfQEk8ciA+geNPJFc1xqbQu9evBibcUq/yZUkl0Xn1n5xmRYf04odupFx/XA+lBW8FJzW40mwMtGyhK7iiH0HHB/H88VDSowN74ax89RJRk5Uvb1USYxhIGz3xIXKMY1NX7wCxoxQ6keksLaAgPLDo45C7dEpL4tyTOpARnP0B+slk66SvevO1TtOX+rAl0szDe4XEkYE0S2lEqZVgO9UCQZybqXalI/eOi4rBN7BmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YchxyocbQd+dJPB9foq17gREtZphNLbp0OEkNUUpbeU=;
 b=StGJgFoLkRKN05+vjpRi5Locr/2V6vVBJkL2QidSqin5qInKT7R7pCQqDzWq4+DsWMiKwP4IP9fm64dpam8Lb8Yx3uhQVBoVekTECCFekuLUDK0UCm/GZFsC6MQnd7eNxc/JbV5+wuukKcH5np6IGc7m10D4qmJ12qyYxZIh+lY=
Received: from MN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:208:52d::30)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:06 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::95) by MN0PR04CA0009.outlook.office365.com
 (2603:10b6:208:52d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:06 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:46 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 15/80] drm/amd/display: update memclk clock table read for
 dcn42
Date: Thu, 9 Jul 2026 16:47:43 -0400
Message-ID: <20260709205936.5719-16-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 571f6888-417e-491d-8edb-08deddfd5565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: PMWJk8KFZ/nfww3JCrzMbK9Hym+ynQKG76VxNGy+S/Om3dZdHtQQVlx8T/pPSYMwlSSVvEwmmYAGwUVgZNZNuAxywQhHi1DdpIeqD9AeBl4awrEJLYw7woEPpIuTc7PiX3UOK/tfAwDjYPUxeWG/NWAVS5IV8NcPlwnepV8bc1f7ABxhBlQu+FA3bVU1p64kf6fT143N523NKXP29S5bCp2Y3/RoDurR3BpcUrB3pB5vkFqmaS7UzXXVqC3qBE+mRe6vHAgtipq87c4nr8czHqo6eEmgORbQoQblUZaIYD6PTuZ+oBn7aBObYd3zOeQbkKr0fTx+7r1upgfgJoXRIzqxXshfHcfdYgulWw0VImlq3Em4OuCRoDCaQnXjSMc+SL7+4wkVvTJGnwgB9GO/1EDag8aWYplocC9H9GQECLx19Uv5iEKw7O/ddd4jiKhyW47APBqjWzgwYSGIPjwSC2tycQ5bgAYyNEyqyIzoQnrzZ/KpDiprJQ+bwAFQHN0P2wf8OFJhd9O8NtxL3MJ2Bhn1amchqIJLeaAkmFe1W2BpUJTP4Ii/mxjtfHvgv3o3xLqzUn0DMXpifdGSJsLTJxGHy7njgEDKLgM2sVnuJJHsrWfE42cPH/sfWu19XgGUQgL+zV/QJDIsho8b7wDRiHL/EnvD5Kf7pwbdUX0GOTYqDtkDsBuxcZp061fIeJCtTO8eDz4C97rdI1Zy0x74cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4q2uJIrahF7omyePT62UZisQyGpqwLgPOkMuWAdR35MITc75ydQkV7u2k0WPALBBQGIKCs2b46WJvqP8rqyaAg/UDqIOWkcyLEf6dr1oz7Hegt1626rI8e30rUpEYetTrNQQwzAYRVp+aOlAbWc56+YTkzTN6klq0L+MFg0l6xcRkmqNCA2ASYGpj31eN7X+lQ+QsCT5RMVDc0wXe+z6EJJ8yt5WrzRzfJERc7AzgFAVUxABl7y2j/u4Y5OH9LNpNa33vObkyUbM055YDS35NQE4KbiMHuWoA24VR3CoSVPUXBZE4hUtbHBpjmsAfRpAkUum6QlSq8rAfYVXrIYfYgTg1nWeJIAndPIW4w04EaJqZkzbd0Hknb8KOMPQW8ityJ6KXTKd74Pp7QQ2E5kzaThSbhu4sW7ua2prRCn6h5D6eFytXDXGQr3fSY/2DXVS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:06.1982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 571f6888-417e-491d-8edb-08deddfd5565
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

Change memclk table to match dcfclk size to avoid fine grained mapping
in dml2.1

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index d01e5969a670..3baac7fa313a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -999,15 +999,21 @@ void dcn42_get_smu_clocks(struct clk_mgr_internal *clk_mgr_int)
 			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_fclk_levels = dpm_clks->NumFclkLevelsEnabled;
 			clk_mgr_base->bw_params->clk_table.num_entries = dpm_clks->NumFclkLevelsEnabled;

-			/* Memory Pstate table is in reverse order*/
+			/* Memory Pstate table is in reverse order for dcn42. Proper way to map this is for pmfw to provide an fclk indexed uclk key since we consume fclk matched pairs.*/
 			ASSERT(dpm_clks->NumMemPstatesEnabled <= NUM_MEM_PSTATE_LEVELS);
 			if (dpm_clks->NumMemPstatesEnabled > NUM_MEM_PSTATE_LEVELS)
 				dpm_clks->NumMemPstatesEnabled = NUM_MEM_PSTATE_LEVELS;
-			for (i = 0; i < dpm_clks->NumMemPstatesEnabled; i++) {
-				clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].memclk_mhz = dpm_clks->MemPstateTable[i].MemClk;
-				clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].wck_ratio = dcn42_convert_wck_ratio(dpm_clks->MemPstateTable[i].WckRatio)	;
+			for (i = 0; i < dpm_clks->NumDcfClkLevelsEnabled; i++) {
+				if (i < dpm_clks->NumMemPstatesEnabled) {
+					clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].memclk_mhz = dpm_clks->MemPstateTable[i].MemClk;
+					clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].wck_ratio = dcn42_convert_wck_ratio(dpm_clks->MemPstateTable[i].WckRatio);
+				} else {
+					clk_mgr_base->bw_params->clk_table.entries[i].memclk_mhz = dpm_clks->MemPstateTable[0].MemClk;
+					clk_mgr_base->bw_params->clk_table.entries[i].wck_ratio = dcn42_convert_wck_ratio(dpm_clks->MemPstateTable[0].WckRatio);
+				}
 			}
-			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels = dpm_clks->NumMemPstatesEnabled;
+
+			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels = dpm_clks->NumDcfClkLevelsEnabled;

 			/* DTBCLK*/
 			clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz = 600; /* Fixed on platform */
--
2.55.0

