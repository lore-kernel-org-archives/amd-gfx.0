Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AC2CA6007
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D3F10E64A;
	Wed,  7 Oct 2026 17:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3pLrIEdl";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5934810E659
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+Tj0JCljZ+AwbI7bUhW+APMx51ZsspuMneqDfimEgfLCdhcU5Rg3S+MRIj8Ny78xT8vD85+6RMXDoeXLRt2dc9CxNYNO4tPQjB5zL0YoxWuAqaO98kAZWjAU8o+uK6MxXZxr+kP2PBTLnS2f1sCGf/m2UjOJYcQ6BxoBSFXNa7ckG3r4QazssLspO6b8m6sqdMpBgXyQJfKoVxfb/HsKjRlAXHuUggh6lZOtGDajiwCPehsn/Y0AxaxOG4ZsyMu7RdOeWfGbWhyqlnTgX+BsCw0dJO0Bvl7/gV8JJqHuwt8VCbV8HtmHTnv2Di7FXVt2MfQT6NPD5VoH+FcVNsTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cks4APaP73mOA9cVZEauLPh3j9CWrRqolU1G0AwOc5k=;
 b=xsfhOCcSa5GUyVmKC+aLjvSKc9STyCyZ6KZwR2jbbh4Dd1eT5z3xonLMwEab8ZToFIXRGdqwEjKqPYCVSdCQwDiuN/4wctiD4Ua/ArwCQMhi+TSuHX/TGl8594IkQnBG6VEIcHykWlXGmc42J0eAXHWHAWbrp55ggH+6qszp0YOBg8cpKn/xz1i2qCzliNE5iXSHRf1hJMA2Dbfo4qnJcd7vPCMASPb7X6T0/f54AHf7URhNWxqzMwziMRY4VjOkkGabphOFEPJijUsfISI48OCphY0OcfUz+ajMCHH+irY37LuR1g6rO9lJQ172hSDuJHe0As8zQfJ8rpXFqKiVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cks4APaP73mOA9cVZEauLPh3j9CWrRqolU1G0AwOc5k=;
 b=3pLrIEdlEKo1TEwej0ha/I2ebabbJpeaS/EHlJEuWhqD2reVyGFwmEaifBEDKiUYxHu13UdtNu4d+P2dUYXb4ayQpfHyLOyd9y+Cn02iu7jpG0VFhQAa8kapwgd2j0VvNFLCqShQ1OlY9rfCvMYJSUJzxdKJVvqzu9rCoM+6QlI=
Received: from SJ2P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::8)
 by CHAPR12MB999248.namprd12.prod.outlook.com (2603:10b6:610:2ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:04:31 +0000
Received: from MW1PEPF00018894.namprd03.prod.outlook.com
 (2603:10b6:a03:5db:cafe::98) by SJ2P221CA0013.outlook.office365.com
 (2603:10b6:a03:5db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018894.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:25 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:24 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dominik Kaszewski
 <dominik.kaszewski@amd.com>
Subject: [PATCH 05/19] drm/amd/display: Use aux hw inst if no ddc pin exists
Date: Wed, 7 Oct 2026 12:59:38 -0400
Message-ID: <20261007170412.1898315-6-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018894:EE_|CHAPR12MB999248:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5c3ffc-6b78-49ca-cf44-08df24950d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: q1OBSJxuPDpFcg2ETV7lvrAd4D00HTR09njgEaxErUJTzbGwr5v4jIk8Psz0epfVOySA2u9fSXsPK+TEPtisrh6w6+TLOU6B3GiQt5npDkTISIEW4URRBXx3dHh0tzJ/7z9JWPjtOwmBC5G6wvCtfuusdJ754pPaMH4RjzubBoOIypO7boasjBWC5kv1PrLLSMVVDUQlRe9KfQxrXYo/8SUIF5AbvqV3iqabN7GgC7ehfJb/nVPVMEAn0ae3e+BtavfRZkAXacU1Ge8Pn6NogmzaVGLJySkd7rjcZ/vemt2OJaskXhZyHYGp5Sq5LY6da0no57XJJ2UiiTjxzSl+2N17kNlgyWvFCwLTcdOulZm+66M4hrY2oka7vwe/mFIXKObJrD7Cvlv2omZTbnaiSl9pfRurZKKvSoH0abtRM6Qc3mwuKpF2XR8SQvY2ooTHI9+mq5pdv8AChYNXA/HduHI8+NpGxNwseynIKB57wb6lfEEq0sM6Sc/koT1GQX0rdqzw0KpEtWf3qZa0uBM+pwaNQho9nKIJkMaXkMIk5o6NbJjSJZIraF0JVGC2/Gbnq/mDUHLcYKALesCEOyKxGjwXVOaF2ONK2QfNOzeblEaaE6TQsPl6ztwXowzXeLQSz4iU2qdVk95ET39NTaNsORNQMoN7egVqdfil1uwUy6rJ/7uKriLXpAjUfwZS4mzaKRbOER04RCBOw5yJmoWCWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SLJQtN7uoFlmTzAQGr6HjELlQiKFJSciCUKGts1QQ5jOFmqOqkJX8E8OgOGzkD4QkAaakMCpV2uHzQp+Offm51pVw6yElN3JaJTjvZTMkT+iwn0kQck20hqG1I58Kmkp8RRYs1vDPBojQC7rjmV7k8N1aFJajuu6aGhw8KuD73PjiLDgsYx0SPSxoNWB/gyH58OyWVyS29gF484cE55U/u7ApMjbBRJTfxwsWGgJdiehgd7TQv1LHpIGSdQCF6YBa+g4KZB/apc8Iff4IREGCcotT7v+7zSfl4jC5tzoWJvVJ8szYx/zeWKD8gtixti6T6CzXvq5NTYzKfCfj6zG5WtRwVYW74gLMHxQ1nAXCkHHYMf3WM0FkXgyVAtMmvleCU4llB9dbkRMQt+1pN3SRHhLJK4SQOROh67SsrDrsn1Ycjjj5I0Ip5mFplAF9Ww2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:30.4847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5c3ffc-6b78-49ca-cf44-08df24950d8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018894.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999248
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
On newer products no DDC / I2C pins exist for DP. In this case
instance "ddc line" using aux hw inst, matching the i2c scenario
where we must rely on I2C over aux.

Reviewed-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_fused_io.c b/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
index 923f70724419..1c58223acce1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
@@ -131,7 +131,9 @@ bool dm_atomic_write_poll_read_aux(
 	if (!link)
 		return false;
 
-	const uint32_t ddc_line = link->ddc->ddc_pin->pin_data->en;
+	/* If no DDC pins exist, then use the aux hw inst instead. Same logic as in dm_atomic_write_poll_read_i2c */
+	const uint32_t ddc_line = link->no_ddc_pin ?
+			link->aux_hw_inst : link->ddc->ddc_pin->pin_data->en;
 	union dmub_rb_cmd commands[3] = { 0 };
 	const bool converted = op_aux_convert(&commands[0], write, FUSED_REQUEST_WRITE, ddc_line)
 			&& op_aux_convert(&commands[1], poll, FUSED_REQUEST_POLL, ddc_line)
-- 
2.43.0

