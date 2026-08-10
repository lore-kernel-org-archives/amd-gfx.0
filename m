Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07233C5CFE7
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F4C10EC8D;
	Tue, 11 Aug 2026 15:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ffWL2K9M";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010044.outbound.protection.outlook.com
 [52.101.193.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3CB10ECAC
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJ0bqU82BjCCjFQFgECo8rmxGWBOAdlaVbdkPD0ey+wiM6f+4zx08ufONVIuK/IRPt3ALzPjPnTKnXrO7KheP98O3P5UU21MxKnrN8bzx1AWdYwl+IA8CRX4uWyoVYwJaobwjCuOOYxEv2cQBH+dtXEQWMD4k2QvOeDCIbP/3hXnR0iuVjm8PaDTliQrkCSWMSAci1USCqV8UWYyn3vTGVpLK3BzW+fjJQqy0jLkXVlRksYpcCHyu817A0AdhnaDLdnhZDYVz3jb92oOxMFNds1kkUtvHVTcpEEk5KGMzk/qOMAk1QbFu/WJGHNT/Zk4H84ploQb7AFljMXtdmjokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFpr4QtebRTaQXlOWJxw94S6xRBbl3PvkPFe/s4NluY=;
 b=JiCk0QLq3vftRxq7f5yGXXhjW59ZDP0cqS9tmCBshKSDyNxe/oRP2L8f8i6pW3qUMIJt92ezYgqtjqD5VdXu6nmxnFhkCaJOAtH/jNZEeLOtG29nuectGPah0Wan4gst6noWQCCCuzpN1fZDNmhST6BVqSfdCZ2eh9KsTvbC+M/APjMiX/HSkAvpxqiCFwbbjPCh5aEk7r+qyDfUemk/y5ReuqSoNzGNxSm+7bpND67L6Vzz60LOSZV6YDLxQxXhzWegnegXp8OHwoPw3d4Z3abbjrjy1DFEK7PbP5DSJcsQGK0jK36lzIPXLREe+AFpAZqt1pJ38o6aXMXVA/l3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFpr4QtebRTaQXlOWJxw94S6xRBbl3PvkPFe/s4NluY=;
 b=ffWL2K9MlwItH45ZaR6+w+0fLwPiRAIDy0+Ja9aHuVydLsFoGbvmDhtzKWVjNk3XiyUSgdOgJfrPJorAA1p6lAkRs2nvyfyStjYR3m9EVw7GDGM2sl27+a2KdBcPMEUAMpX1HAqVzx8ARMpvhh+H9/TQGuz2GdfI1cSSDMWlggA=
Received: from CH0P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::24)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 15:48:56 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::a3) by CH0P221CA0023.outlook.office365.com
 (2603:10b6:610:11c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 15:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:48:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:48:55 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:48:47 -0500
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
Subject: [PATCH 05/24] drm/amd/display: Add utm_support capability flag
Date: Tue, 11 Aug 2026 05:28:39 +0800
Message-ID: <20260810213010.1703162-6-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a4ec0c-2187-47a0-cbf0-08def7c00d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sWzoWCsiLlDGo5dA2gVRCO5xXh3Ey2mAdVcVOclpnNz+te1VQE0cPrgoCbSy+TRGSm9MtZtDCFqdajDKEMF/dVfR0XRGzWW4aRmmvtIvu9JhcSbk5LDaM8gk9D47F/TZ4BKhRmmhlaVt3U+x8HKgVanLryTA9h9/86pDsoLfxrXY6bHd3ry5PwMkQE4gaTZh3Unn9IwwinwS86HUwHog7W3EprrIj/9pLZMxKqC0KmxxCrpwQ85w9fPFUKl8qXqzHOsxw+Qja3JTW8MH3oJlZwvLOkSqn9yHe4fTZEekW4Gj+IVUIGqOj+G3FFaJ1feEsHr9mtVPSff2840EVUeJ2sk6fVfj+ygQcI3Ix+C981VmC0x07aTM4apaTfM1aVWcWEYrwwLkDEmv71d+FrQkdFVfJtcuCyRRPvP+HZAEtUnc9ZkrAkVeVvhL4IIBWToi/Xa0gIwC6sANQ+OJ4uoN2Rd8/kQn2V9Kxv0hkgkMhMSI3Ni3bMUZgaBSJELjKQJop/bvdzQ5rzzrQoBigTGipFbagdUXHcV3qff6+IuoAgchYgSkT01dqtmGsVYrPGK/v2UK5QqzV33YylV/stBgkLgWbWMxQG1657OpqelQDQ5ox/4swbVL6yLETHUC0/INnvoEQ0lD8MtKpGHwJiiwLwn7u+1e8EXqUdIJJDumuOUpM/oZIHqKrC49Wizh6S+xzK/GBFIkojPUWTl2Qmx14Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RcolFH/4OjUYHK61osQDKbP1qOQA+D6e5mQCDDftz58KQ7aXNEjd3i6CtbQjiY/iLNjPH4xzj4RQmriBCl6WQpaHOhGKuTBTeLY5OOGLXRGX0mbiegbrxy4RAryOWEodqm14yDIu9L8m7c64NRx9ijtFUOoyj2NwuxLnG0EAwtY8dE/fyiqbw+w92Spm0yD2r3DfA90z8lq4pdYWN8+/MLLoorgAyNMsEcOtYyTkfVrvo8mJhXVwllRZS+OoIzKfAK08v6MoAY8muFOqr6+71dQRWn2TmO+DCarjmWNigUDST+rVX4RrDU8cisLr46h03Qv6GtodOaQF93BS0zNwnUo+vDw9Rb/W+Z4NAthdhFOxiSztwDesrkjod5KvqkujH9h3P34KGKOF9P7W9RyQhVrDmFCFg7ODT9bB1Bztu6RWNoWdtw9w3//cFlQ6kWds
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:48:56.2821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a4ec0c-2187-47a0-cbf0-08def7c00d5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314
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
Expose whether the ASIC supports Universal Traffic Management so
upper layers can query the capability instead of assuming support.

[How]
Add a new bool capability field to dc_caps, defaulting to false,
and set it to true during DCN6 resource construction.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                            | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c23299d3f36a..edd6a113cfee 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -432,6 +432,7 @@ struct dc_caps {
 	uint8_t num_of_dpias_per_host_router;
 	/* limit of the ODM only, could be limited by other factors (like pipe count)*/
 	uint8_t max_odm_combine_factor;
+	bool utm_support;
 };
 
 struct dc_bug_wa {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 2dac5f7486d9..7171b237c427 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -2037,6 +2037,7 @@ static bool dcn60_resource_construct(
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
+	dc->caps.utm_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
 
 	if (ASICREV_IS_GC_12_0_1_A0(dc->ctx->asic_id.hw_internal_rev))
-- 
2.43.0

