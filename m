Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378E3C5CFCF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C172D10EC95;
	Tue, 11 Aug 2026 15:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jqkh8sJ4";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 339AC10EC80
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3tKyUte+uCbwXuD7hfaiV6DBI/bjEdQRlCJ9eyhYy6JJAqGqAcYl3Y1xT7A62k1UOx6Fjjvg6W2Hz4wP6tvOiI+t1cpgWAqv4YyYGIMgNv7taLq1ujiBlO7HFkQgQcVQ5l8mSWr8R7QJgWqqwr9PgZ/sq++FpXphrp7KvTloC0+E3ijBuFiZzedvKvdH1DKM5dmKM0ybftPTlGgX07hukgUu05h2IB5MfZsbGUqc43u1Jpz4NDGFO4sKellYDWoijvCpy923ysLN2mOiHlsfv3XMdBmk8zKHGVUxu2VOz+yEQ0MppLH0L2YxEHNQ0NpEDXLh3OIV+P490Aur2WZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfHUZJoojx9mvYX8rQvwpX2OmHQ7Mi/OPwr35uRYVoo=;
 b=aD0sfRtFfZubSfSooiXOwMH7t65cKLhc4WWfwe9BYZ5LLOpHmXJfPfDRI/yyPoccUt9ZIHHcXQt3nEVXu9ye8pdshZQFK/tLAIDMoLo471fRCx4ai/CitQxueFwedry6zSs/qYQCfm0PmDqAp13bGjaTKbTxRvWkTMk6o7HC1YG62hPan80R6cFrUl0vWcvgu+VW1CqMPaoTwnVf3MygQ1DydzbFTXzxAWy5evjS7LCMrqw3KrfHDwjUfrY2Y7YVNLSiSjL8il6E2ga943saXXuMQjFRqFDksqdkvoFbrApdY93NcgWFeBlwIUWKMbmEmHUiBs8YUk/YIlIdUnyoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfHUZJoojx9mvYX8rQvwpX2OmHQ7Mi/OPwr35uRYVoo=;
 b=Jqkh8sJ4knHjAYjcmChE6AoIJHx72eGKVKqtA0TFpRo6XWlFUdzpoqDI+2cc6uSWtFNuLEYsz3nCa1DIX/CtKuVlGzm7feSKIwZvNnB/Yovn7n5It0WNBbKhs3u87Fo8xBhjBbcDKO73gfG0WOmw1yow4fYpYrNuXlYrv/Op3Fk=
Received: from CH0P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::27)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 15:49:09 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::47) by CH0P221CA0001.outlook.office365.com
 (2603:10b6:610:11c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 15:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:49:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:49:04 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:48:56 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 06/24] drm/amd/display: Guard against empty DCN6 UTM QoS table
Date: Tue, 11 Aug 2026 05:28:40 +0800
Message-ID: <20260810213010.1703162-7-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf42765-5568-4be0-1687-08def7c014e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4NrVNHjFKEj/lI91rvW20DcCGgjpWEUdRQ3FpZK2SU+MFO9UeiFnaA0XqkvAqbb94PkXY8FZ14so4piTwHfh3a0Z7A/p7N/DQsZ2tJ6S/Yt5C8P4QnjepV6N6RRKVE99d1uhkCS3mrf+sRFv56L/eFlQWgz7jGtHb2i2/N1cwBU8XYqWMy/QEZ4MONzf3si47maaPhZZ8BOHRC+CCK4GKgaY4NXk7VoKXajHOsjaDNXTzFMqyDmB4OA7eLHTT4ouEewUdTkOGtU/rY00d7o0yW+1va37uk7zwYopDr/o9v1jN9eF4N2KFklzVgbQBVNha4bFhBJ4ziw67SBIfFw1XMrzkjJCz0j2yLZrXtOKlqpJu0abztJFaqIzkzNdwskBlqkHOBx4FndBjHDouuc9RqaMosAjcvh0uIqiu03oUgUIbEWRDFTKrDtttayft/qatN3EWFsZ2lXEE5gaeJQcSUowSEjJgqv/+kMw23/mNNj+SafxzAUZwwqzSV3vh2ct/V3Qcj+yvUmgwpU1Ltfi+AZPnKKR3cvFYKM1vWwS/vq6ejkFntf9vKntq5AWXsBq683+kUNc+eIqm7455Q49OEg16hyB5jAgOCCBEaXHBo6Zb/g7KE+AF3rNBZoQA4xvCd93GWPmMzb7Khk5tLIh0g+L6/JbeeKqi7+sGjPBdzTW5Vn/T7Xck3jBmj6zuHjSRbAoV6kS6w9mmqTIuuxSKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CEoGlDXPUTmO8oCvh0XIGT2gFt2BN38mO6NaG7IXyQWd1SyzN67JezXcg+UndXkyN3FNIFU+znOV+pPiVVaTZzlxRlATYmoBbMfimITLFafv211uI0/EM9ZEQsaRjBBvwsknZMBs4+0Jiqt2HE3vyQHhcc0n20D5pOEdbSp8arLk+3tUiXVm9XnsMlS57LM34qgoAPW6iJg2WwXY+/RChD8mIP1Mr0OdEnZd+SfLV45H7ExH6PboB6o2K59hMLF4DbsyyEdMxejxtOYhayCuOd9YnNF87aAvhSjb+5DmCKDStKdw3gI3KBajHHppcOwDaBhXzBFr2dOW5+3O+Bk2OX2U0zFm0SJLTHvYb0yLxbFJtK2wxVdLMmuFN/0m/glrS3lW2domZ8/N0kE/udT3aq+DQxKhOSD1XETW8AcmNdub2G9pa6ugLholc9ZpHaxG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:49:08.8927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf42765-5568-4be0-1687-08def7c014e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
The UTM QoS model population indexed into a firmware-provided
table without checking whether it reported any load levels or
SOPs, leaving a malformed table treated as valid instead of absent.

[How]
Bail out early and clear the output model pointer when the load
level count or SOP count is zero.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 40e975e8a550..218856c5fe09 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -625,6 +625,11 @@ static void dcn60_populate_utm_qos_model(
 	const SocUtmTable_t *utm_table = &init_table->UtmTable;
 	unsigned int ll, sop;
 
+	if (utm_table->Header.LoadLevelCount == 0 || utm_table->Header.SopCount == 0) {
+		*qos_model = NULL;
+		return;
+	}
+
 	memset(dchub, 0, sizeof(*dchub));
 	dchub->load_level_count = (uint8_t)utm_table->Header.LoadLevelCount;
 	dchub->sop_count = (uint8_t)utm_table->Header.SopCount;
-- 
2.43.0

