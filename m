Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A57FD88DF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 02:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A011010E2EE;
	Wed, 11 Mar 2026 02:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tciW2wnI";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012026.outbound.protection.outlook.com
 [40.107.200.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0D810E7BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 02:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmlGfmdwoBPgPPF4SKGvikHqZKEAJ2/OiAXSJf2fQFLFFDdnwTFvrseSMyRNJ5HYPKAEGI2bPawk2LxEGwNR5pEJ4W1HD2ihbBjAumjz3Vepx2zCTaUCauusqk9ATBj0N5CZlr1B5PFqnUfSgGYsw9RPfS1PXv+/JIRJ6vE+uTJdT6QYZOM9d3oLm+wnB5zgKrkgs1+W7RDprSZlRN1z8s0X4aJgE0CaUSL7rAKsfOXa34gxcgCluOCgrJZ1pd3CB90FxGm+mfaG9nMFyx4D9brgvmMH55Xttl6ARzXVZ961l11TWtg3lrKPFlfaTylYIN8LjpUIThHVI6HNQCMNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Cwl9Mq+uW/bko9ovd3ZV1bR+HDhlh2LN1aZ+OnikFY=;
 b=ryIp/zpSdGwIouAzTE71AMOGPmHy2KQLb4VepK8SyAmsPLmOu06/diR9OJkwCc5EQfT6/rltJCz2mWaF1uugyyknwlOxgAua7Za66nR4p2D+DhBY+jNdcwNrzCzkem1wGHcfj76kztfdpkBq5jL5vOfgPzYb4UDTYvkwhs9lN1FkDAVOoNX4qp6T/j+1i/fe22dS9+gi8UVb1yqAuvdG2ZfunnY8t/n1xYZW9Zt4qsZio8kfxHLZBu9lkv5XdPxXieGMchC6+AFiFBt2n55WuE4xq91NOdQVpPqrFUj1EJNdi67qdiN5vbpXnvSURZOPLlxl2rA2YCVvUqpm9sm7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cwl9Mq+uW/bko9ovd3ZV1bR+HDhlh2LN1aZ+OnikFY=;
 b=tciW2wnIe6ydITY0x4M69b1l3qchq8Xapd7aAK3BHNbn4v4rAMN+/hIr3WGUCFCXcYEL4GS6VEQ/AyRYyvj0j9tKTqdhP+g1VuVjPnVqhSmcbQxIMgk5rlZTDc/ltvhKSE+r9gxxH2N5MqfJendla+h92iEklmxknJBPZbgUOaM=
Received: from BY3PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:217::14)
 by CH8PR12MB9791.namprd12.prod.outlook.com (2603:10b6:610:254::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 02:45:45 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::b8) by BY3PR04CA0009.outlook.office365.com
 (2603:10b6:a03:217::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 02:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 02:45:44 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 21:45:40 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 3/9] drm/amd/display: Add dcn_mrq_present Field
Date: Wed, 11 Mar 2026 10:40:35 +0800
Message-ID: <20260311024652.2668570-4-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
References: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|CH8PR12MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: ee624b81-d59e-4d4e-6fc8-08de7f184b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gpXGTrtlHl3+f6VcAKKJoazew6+9hhx/tbJNT91Q+K7qNPdbuADFEtqrzYuswPTNQGj1gUDFAOCyJVJ5JHvevXnz8evGYz1qqsxcj62wJsuB5sYcCl3kubs9bpdDDfQmbliYkjnxwVHPKgxwYIpNNqxPhopffVN04zqeXysNeKEODgpG2NE3YvenJHCFFjXqeIDF/p+zlV9er9ApgoTyzbfMAXJG2ab3xy0+mTK+Un3uLZN6724NwevI2Jx1sEB72ozNb/3Qj0PRJ3CD9ueTJYzQiySifMhPDJoGGtiJWKYH0EhgsTLfFdz72/0ZdqhA78BhBY4HaBI/7GicJWMHLCQFH8eG861sMySifp8MLeB3aer5mrOHabPsRZICdGpnr38HJvr3wxLpkNlWtxscewAOn7UgG2nmWs1Qa7aK8+SOEg+9DRlPHfSlyniPXbcSYUd6lYP98t3GEhaavImOdmWCDKejKCFKqPjoG2Msku9K8pn3sfngRVOmYggj7SukStD3UzAVEDAF++JqCdmTSKRm2ZfPOPJhuCGF/2oen05PRBH7r45bEKzf3hCI5lyhSvMoGTbSyTMsYevv2emQlEPNnLSkNEbtWFJv4uFQJuytbXrIE4u9KXU2MHPllgjTKmMkUAMKXaCtAOGKHRJceOjjp8R+LkAMTmjYzbYn7OkyObRJ80iQ1Zhx7e6Bcez3VHyZDh4PvEJwPd1WxInIP/ZxMfUrbGbdLKGYtIpMlo0N2MghV7qLEX7ydHOU9kh0UFPnwDpKHb+VksI0CT4RLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5wPIUztd18roH5JXCmCzIAFEJCG2Lbj+13Fd5eXM/AniJAFAz/oM6pHRG6UxRrgd3y1QB9Nlj/j+CPwHuETOCU5KZceZdnOCV4x2BUIW/pQjelPItbdMlfUoWtwKZ7staIMORoKNLF3/smF8BhOkHCfYAQkKw9+0I0VcLDMVe2UceaFs8HnL4qbCVhUfXHN8OugP1BTaWHuorKQjIO/8uA6yhKzJ34bXcJpDh5i1+e8S+CSifgHF0PXuEosm+aikoSYagPXjU/v3DeTtCdYzN9ceFK8o3gVDJaXTiqTOM66E8v34Yw0mdMzF5BmetMrmR1E0TYpz1KYzbVedA9w7NufJ/usntAvUc9Cue5A2FTsYBVdGqN4WbuzqqgirRfuY6evC/AbfgctLwvxzb2xjuY2V5JmL54ZxpsFIvdP69A4X0b8mBYxPro6QDOrG9yJR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:45:44.7153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee624b81-d59e-4d4e-6fc8-08de7f184b10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9791
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Add MRQ flag so it can be passed from ip_caps to ip_params

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
index ddbb8dfa9ff8..6152155d6073 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
@@ -192,6 +192,7 @@ struct dml2_ip_capabilities {
 	unsigned int max_flip_time_us;
 	unsigned int max_flip_time_lines;
 	unsigned int hostvm_mode;
+	bool dcn_mrq_present;
 	unsigned int subvp_drr_scheduling_margin_us;
 	unsigned int subvp_prefetch_end_to_mall_start_us;
 	unsigned int subvp_fw_processing_delay;
-- 
2.43.0

