Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8135E8783D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5DE10E6B8;
	Tue,  3 Feb 2026 15:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vTLor/wf";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010001.outbound.protection.outlook.com
 [52.101.193.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F1510E6B8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwynnZlim0HQnenXcIhXyDu4l8zHvYuQD4Z8iXCBQ5Ap5IKOBRB9iE2S5g50sOW8KhOgfBvq5riCmoMYh6kAhgxDjBThmP32n4dtZlh2s5O/dyjp5gY5VHc0I/r1nJycPQcVw3ZR6D9OEkqRRZWFikjdX4CHpK3d9ed003v0JvSEy2h5w+FJZRZtfqNlZJ3bhuCZouAuv+gXpJoV1kf2BYcpplZS3+DA0MKfLwyDI3K0KSHDA5DG4/sHcRFyYBL0MWI/lyGA498JX3fSvbKtcZI2TMsAyBiS6BNXw/QVNCtzQrBXLJZBDAxV2+3DhRrTICR0P98+MdWbs87ZovLexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9Uixqpeg8GEMPZRl0Xcs0mddNSvRCllYpm5dXD8uWs=;
 b=AouJdAg+xYeXIjws4L+upY1ygV+M62mVkSOQJExCATZ/PZnH+Ev+Vk/NxLeS/y5jRAzN56hfXUEC+iP4BuSn15eK79tokV4igYtFYeUX1nHqeAzPZ5xVOznVOLhuIj0wFYaUJlfxLIGaoiSNT8FL7Ljg3ZwHp1pdNP5V+8zRM8GyTjoDlu/lUjcLFqr3HVdcbWdmpIv5Dmshl6MS5GLMk+yfCuxQHAPr8C0VN0RGUc4+QhN1ox7yH/bIW9SOVGpE3HnzEM4pDdrdYK6tNtfsyqU+9w9FmGjoDYmsll1xxJKER7GwKB2bSr6mxFGEMT/ifEPaUR0dq69hhmu3tuHMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9Uixqpeg8GEMPZRl0Xcs0mddNSvRCllYpm5dXD8uWs=;
 b=vTLor/wfdbjLWMT2HZc2Qpve/r3IqsHooN3SfTfNw2jci68K1wYBHEm5fMcDHDLLY+oyGsZUFjWCRaWpXYoY6n9mYXNzhjIeq5jdPXC5fVZxNKizfH1N9MVvEc0iJNFLwYasC38UNntHrh/yJt6SnlkCuNXqxasYnZoS+mYTX14=
Received: from SJ0PR03CA0093.namprd03.prod.outlook.com (2603:10b6:a03:333::8)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:13:54 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::59) by SJ0PR03CA0093.outlook.office365.com
 (2603:10b6:a03:333::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 15:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:52 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 07:13:52 -0800
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:49 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 14/16] drm/amd/display: Fix the incorrect type in dml_print
Date: Tue, 3 Feb 2026 23:01:56 +0800
Message-ID: <20260203151229.3673042-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b55cc7-1786-4b59-5502-08de6336d808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UDG3WUzyoLSdJ7tX4OjywJ4g8RfpaJ4fLvAdVVIIUs4/+gN5xkuOwfGXPNZ0?=
 =?us-ascii?Q?gsC5113g5tRsr7jktvbW/y45BfhG6TbF0wWQkCQHr/ON/m8cwiqnU4e72+ce?=
 =?us-ascii?Q?Wq7cJhxLFBr/5nsp7RGhzxchg6VvjJUmSAsvWh34oeBIPuaVWAR/QC1Uvbs4?=
 =?us-ascii?Q?JkeNa+OyVtXv+ZaYUhnFhMKyMrH+ayn/FZN4KeiAGhBYLGKGMwyCqEpD1e5y?=
 =?us-ascii?Q?c09I3kUhUqWjZNjJniPJuZoEAVf7NcD0gf23QS7nMdibIjHSkom+iThl4AZa?=
 =?us-ascii?Q?GK9qpxFS0gCQQx4+sKvPN+l+sexYx+1UL/83MW6V7KBJXQiYM17kKnk3g19M?=
 =?us-ascii?Q?J0GdTH/OgwZt8A7Zimj17Drkzd6pzJp2Xa5ySpSk+QNU2T2AsEXpeAWtR3ol?=
 =?us-ascii?Q?cdGf8tDgtpyNlQ3oxh0BMua8T1ueaIKdibftCCcxvmZZfpZaaTsRzX3qT3YI?=
 =?us-ascii?Q?JRmbkpJTXb2FmcgKYLm23UfmtEkrEXOuyMIsbMMugKzwcuS+ONBeHjc1NJDZ?=
 =?us-ascii?Q?u+i6//GV873d6jCA2x62y2yLaL/kINg9pztHtfsj4FuqH4FYOMryjC4gL65V?=
 =?us-ascii?Q?OYdKdrzX5Veeyxd8gNDzT5VUVeeGBA6F0PDD/+wgoNEF/brL5pQM4sYCg+Hs?=
 =?us-ascii?Q?5x9Y4INnBjY3iE1yGOISJAMom7WUiMpbT4Tt1lfFxgRjCJqBe4hsdc0x9+71?=
 =?us-ascii?Q?t34lz1asHuM1x4UwFbx/xvWLdnA+PpRLW/wpras6QRdPnsZKojSMYSrLCGAF?=
 =?us-ascii?Q?oQCka3dxF3mnqNWWupP8CP9bluYpybFQCEwRe/H+sMwsEf4uHuay5e0lv48/?=
 =?us-ascii?Q?Pcu8UkTAkHSGZgVi9n/eNL2IdG6zpKSb7gfRl8G8ZL+sMTfCpziM2IyYweMq?=
 =?us-ascii?Q?c3G+wMu0YLZfx5Rn1lOU/b1N/vZVFgVPNqkAfPLsORkWbyMC/IItrmcna+aK?=
 =?us-ascii?Q?uVLwBWH13CK8AkiuDfC81HkhTzwNQgrtNvTtcAX6a1wLbi8IJci3mfwsh55J?=
 =?us-ascii?Q?m2jbt4dAmz/dibwfqR0U7NRKjqnjF5F+KPKJ6dphwqLJ4+KTd0siL3i28zyd?=
 =?us-ascii?Q?wWeHrM4SvWY0KqbzqsbldQRe0bGE1rPiUH0tLxkRjt0F9hKfUW+on9L5bkiO?=
 =?us-ascii?Q?j8OrD1NJUfOHh0IZ9/J8LjWQmJuwKBnrFXWiMi7ZuYntLqTIDjK3H2G6nlVe?=
 =?us-ascii?Q?ugGxSdWW+M2MfA8LzwyEzZfqAc9xgzdxzQ5g8l+d7vBxl7gv/WNiZFuxmftC?=
 =?us-ascii?Q?Eevvi2LFNvM+Pn/OvRZ6WGzTqhslS+RnP9REh96cJDGpVLDdp/fWDhhl1LoT?=
 =?us-ascii?Q?WYQ3nQV56gmbIqfI9atL4ggWUNx+JbZ2v7S7OzTeB5TAnKdHMTnrDpVZlRk8?=
 =?us-ascii?Q?SJuHq/v1lRwIGjq/BI4Qe5mLzmxpjcRU7jh3ujFXwK3x5ES4eDR3t7kPgbmp?=
 =?us-ascii?Q?/mHC7KiIdh1m47ITqiMXDwad8SOULYxip6DtKmpKYE1u11sBoFHPcWFCVrQ5?=
 =?us-ascii?Q?rm+m4rCED3Q8xTkAcnmNI5gcFoO0vHQp+SlFO6HEQdHqaUs703C390ClV1x/?=
 =?us-ascii?Q?cFQ76efNoME/uaCeDSP8Nn5Gb6/3SRi5jPJiWL/Gih55bPgZqguOF5egv6z3?=
 =?us-ascii?Q?jyQEPVzm9nqfxHGnUpZ/Xr5rZuFGY98bkD+624bCSN8dDkcmCCLAGQiT8l94?=
 =?us-ascii?Q?CIe25g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(30052699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EBpX81eA7ae/EGdYI1yX71UQYK1vqaDea7NAA9Z5TcGw0sMqoOkigvNanDiO1V71Xvnk05LD3IoArLGnbR1BqxTsecIOmdYbi7CVgEI42yuGWjd5/5+1rgtQkQgNRhiNmeBHF/OVH1FZqDZ4HRz6mPpxZNCiRZlz6bv49gz/Ngo9zgIPxSLdGByMmgJ/n19SF/8sJ8Pxez67ua9ntb19lA2uXyeoDLhMRZHdhf7jUkDRNr0k6ZaQPBvbjpkeNZg8P8X1nk1FyQjwX5jSJKgdUE2MqpV8AHdm3/12xa38CVgNj5qksp0DSoG92IJUOASd3wnZINNLV8bXUhatbEduTHGCeoGhyMr24NW9CWSwhEI28urGqVmgokMmyL5/RQ8g5u24cLDjCZYsMjhlzWAikVsqSarcwgbIuisrjzhRPZ++Tli2xWQeqBPT96n/Ir/p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:53.5619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b55cc7-1786-4b59-5502-08de6336d808
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
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

From: Alex Hung <alex.hung@amd.com>

[Why & How]
soc->max_outstanding_reqs is a dml_uint_t, not a dml_float_t.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
index 89890c88fd66..4022f91193ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
@@ -655,7 +655,7 @@ __DML_DLL_EXPORT__ void dml_print_soc_bounding_box(const struct soc_bounding_box
 	dml_print("DML: soc_bbox: refclk_mhz = %f\n", soc->refclk_mhz);
 	dml_print("DML: soc_bbox: amclk_mhz = %f\n", soc->amclk_mhz);
 
-	dml_print("DML: soc_bbox: max_outstanding_reqs = %f\n", soc->max_outstanding_reqs);
+	dml_print("DML: soc_bbox: max_outstanding_reqs = %d\n", soc->max_outstanding_reqs);
 	dml_print("DML: soc_bbox: pct_ideal_sdp_bw_after_urgent = %f\n", soc->pct_ideal_sdp_bw_after_urgent);
 	dml_print("DML: soc_bbox: pct_ideal_fabric_bw_after_urgent = %f\n", soc->pct_ideal_fabric_bw_after_urgent);
 	dml_print("DML: soc_bbox: pct_ideal_dram_bw_after_urgent_pixel_only = %f\n", soc->pct_ideal_dram_bw_after_urgent_pixel_only);
-- 
2.43.0

