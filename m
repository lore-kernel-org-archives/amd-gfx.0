Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1349C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83CB310ED17;
	Wed,  5 Aug 2026 06:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SD3mHCXk";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62EC710ED16
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZEjScFAhKQVU+EEq2doDaN/emq71ISZzOR8OlitfDIW+MudAIbYW8+4i54JSPzb/OlyOyiWuoSOHJh4/jusCGMYVmvSVOyl0IAPAZunT3hr4ODereHkJFdg/V72umh9IH0nkx9ATB7UNhNufso1vb01ENfc48HF/tv/eTrHlzt4FaGA1CHUqv5zGc6c+dd2AgpsPwpnfqdw7gIUyrqQmEvsk7HSUrb3tsQwgpqzVkg4F5N8N6VcdfRoWsjJLiZu4gJrrWoG+FQezIlXbfGpgnD0wubXBdSWCZ4t+T0q3DI5BSJsiNhZ5cclztIC1jaHwS99JzgwhaPv5nqEXJ2T8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8TGvB+wsPdOKI1/BNtCwylBxYhjH5SGw3057sswfKs=;
 b=eUUuL4pt4ZfYYCeuJk3QWnJYqRfG3ZeiPdV4caryNkkb19v7lwuoxTf7qJ/foyC4BmW7aMzbweAejye+CJgaCloKPhXX0WZH8p0D/pLvBDhqfADN+rojja9A1GCldd20vsKonmp33xvQTZk75u6Iivz+H52Nx+KnLPj9fNmO4VX+EfJtFiOFuutRDdLftF6q9jrDt2Th2zjIlHmSEKfUSn4XkddTK5eh3/WkrYB6reHrzZfwZOKX8OSKiRJlBXiY9UYfew5vRxD1SByLauD/79hzpItkf5Bce/o8Ownyekpykz82diptezbZFY6EiFFcZJ8dh2kgNIevHTUBd8AJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8TGvB+wsPdOKI1/BNtCwylBxYhjH5SGw3057sswfKs=;
 b=SD3mHCXk9ZLFbvLCgManso8bVu4l8kMPVP6YuMMtAcnvWPtwq3m9TupEmN3cCVsc0Gh8n3MqEFcj+Ewc217bdcQPXBWDR99Xp/oT0o5PkrIGbrviU02Snibu/i5HWBXrHoHdOPEzPAw8DkYs6iflUS+iFxLyQycJ2VfQvrXfGhk=
Received: from SJ0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:a03:39f::34)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:41:54 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::98) by SJ0PR03CA0239.outlook.office365.com
 (2603:10b6:a03:39f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 06:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:52 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:49 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 29/34] drm/amd/display: Apply workaround to limit SopCount for
 now
Date: Wed, 5 Aug 2026 14:36:41 +0800
Message-ID: <20260805063937.2145774-30-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 1369c207-9f0e-416b-a5cc-08def2bca304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: x2s36OlndF9Y+whfw0gV9lqZCenaMDe+y8KwyAnKjxGMdNc7pEg7I/iLVnwyCQLotIG4mIzCPPX5yhJUnDJ60icYATQaPk2ZaDZjj5bbSZm/n3/yHOAjoOhABz51CRt8cXz9ksxfQ9zu0BUx/bW3Li/iQozjh/Qme8flV69FiDQek/hHnWXTFYmmzUNWuOsp678cAfeQSqxuxgIYFCjRfzRezAXodb80+7srJlJUfme5MuvaeQT/HHh2pEPNy0sPe2A5rauFf2wbFDDf8P/iJN5RXU/60CqJDXgQcGwqSFkJNfGeP/F+Y5R0mQ0AA+6AKDzDIjB7KCjhyFIizqv7Uvjfs1t7qsWFTo4O6FHFX0bfFX6UK+gy/JWbbYDl74eCjYkRjOxl0alY0EGEA0WQHmx031/Hgk7qYImP+TgV7hzXyQi5oR3nUsk2nyAgBw3jf7oJlY6e4QLdTba/BpEPAQMJgyy0ph9ekXBi1pAvhyX1FR0wix89zsC5lUbgQQzCKl99S9XD0YxLuJqS27yPJXPqh+UAnHLXuAfLWHFIjqjPQjOwkd9GWdS1yTLDo2l5gsHx1rJtbHu8f5RWDHlHOJoy4G1PWTkj1butnmE3k4QmMj87hLOsk9BX+VyNXcDqCTa/HGbJ+0VP/JoyRl2A+W/eWguY1FrYyRxCANPvQAUKt3gVoEKFAhFQdqKMZpKBWWz0v6sAgQS9eRlOG9ppAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GDHUZ3Sp0X05tsDfJfPnrHWPMRIxGDNLZtPRkMG7pVLjbqe1yPsFtrHmrKD8yo1TTS89ZM/xWF2UfolLV8eQ4OhXCEZgN5lIuc6hI+MWTRLvn20GKx8SsX2atqLjqrM2pzjkcqXssV1ADk+VdzCZV+JR/bBJ8EMq5XGUc2LrqUMagllEH2hj3b6BEgzzJTSugczjocT6zdxSWbcChOYNrm8kHN0B0N8xHhfDC5svEpICJGT8u0qtBPW/94dW3fcXGSgjNi9dhMpoeCf1U+nPeH6n6azm2IquuIsD7pzOpsmKkv/kUJBGC30Dw3e3wroOOQMJvZgnj7ew9XK8iu8O26u2QeIZjSn80vdAYeDAYfszJLSP9fw54MhsEfBPV+F7UNbVMdQersQYt5LsJbwwseQDSewuaoiHrywAOPQb55H5oIkqmRrfSB5aIsvoGQo7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:53.4610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1369c207-9f0e-416b-a5cc-08def2bca304
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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
- PMFW does not populate the SopCount correctly today. For now limit
  to 5 since that's the default number of populated array entries for
  the Sop array in PMFW.
- Also remove some commented out code

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index ead4ae9e51eb..267e5060c6b1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -628,6 +628,11 @@ static void dcn60_populate_utm_qos_model(
 	memset(dchub, 0, sizeof(*dchub));
 	dchub->load_level_count = (uint8_t)utm_table->Header.LoadLevelCount;
 	dchub->sop_count = (uint8_t)utm_table->Header.SopCount;
+	/* WORKAROUND: limit sop_count to 5 for now instead of using
+	 * utm_table->Header.SopCount.
+	 */
+	if (utm_table->Header.SopCount > 5)
+		dchub->sop_count = 5;
 
 	for (ll = 0; ll < dchub->load_level_count
 			&& ll < UTM_QOS_MODEL_V3_MAX_LOAD_LEVEL_COUNT; ll++) {
@@ -688,7 +693,6 @@ void dcn60_init_clocks(struct clk_mgr *clk_mgr_base)
 	memset(&(clk_mgr_base->clks), 0, sizeof(struct dc_clocks));
 	clk_mgr_base->clks.p_state_change_support = true;
 	clk_mgr_base->clks.fclk_p_state_change_support = false;
-	//clk_mgr_base->force_smu_not_present = true; // temporary until SMU ready
 	clk_mgr->smu_present = !clk_mgr_base->force_smu_not_present /* not force-disabled */
 			&& dcn60_smu_get_msg_header_version(clk_mgr, &smu_header_ver)
 			&& smu_header_ver != 0;
-- 
2.43.0

