Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6176AC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1BD010EFE6;
	Wed,  2 Sep 2026 05:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jzTJuyEe";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F7910EFE6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Epfo11+wJ80hSeQc87LeT9gAo5sIaZR2zlQoTqlu83gnTbQAXQA7Lpdv4oj1piMYaOxAehGV9d0qS8BwWbRG6m4lTWJRvOJjmBCbkz1ecfy0WAjbJV5DLQXlVa6wCg9gv0iO6O8AuRxuTMHYoDM1HS09U5F4VGuU0C8/GP+B3t6IlLnNQqHIaXPi/8CnGYSOEJbPEv3V9DxpkG/tpKjVvn4dMgiOsM8rnBpJOMQo1yLafEen3iAppBWTqgu6OVBKQ58VSE2VqNQby/btA23YNPK925vgAUa8rGGwNNZ8+f5jZ9emetuIb7j4N0CizNybB7CwomU0t7THfFDt6x56ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW5g0JTqPhM9IThajSoemG3eRouW7h9YQdpIzCtoOw0=;
 b=nEppMkcOx96e9oHTcLO57M83l4Br0NMGd4usuJ/tLAe539GFGXoPgym5L23iZITUuV21Ixll7VoJu+a4Zq6Wnsj4V3LX4MnH/MDJhlZRjJo+TDbnUf1OBUskyvE4Hi2WPFiwj/UnM74cHniQva6DvuUusFgAdYxseOI/bG0/6glVpEzpojD+ceQNYh3+MqyTql2y58+lHQ0irmQSzM7Z4SP5JWVWl2LVqcoIPT9MmaNGQuv4ywqLBFF/sZTw2VTm1fn5+0O+3SRyNHIh0WJgIVwtEfwGmmYoMlWouULcH6vzs0BV8rvxVAxdIbbyR20E1WWyMohF+GR6nhZSbXkAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW5g0JTqPhM9IThajSoemG3eRouW7h9YQdpIzCtoOw0=;
 b=jzTJuyEeIfpQr6KJqTaHIczAg9IA7jhIB92NCA1iVUItfJ/TxV6w4/aZwlOzOTMrK7hNNQAK+SGRVI9Lv5uA5C2TuMr44rIXHOZ4Ogr7x6vTfcbAbZdWbu1GE8L/nDjzaJQkJWwnC7Bu6vkO7fTqIk3YXNI9tkEAJeAjmKmu1A8=
Received: from SJ2P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::6)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:10:21 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:5db:cafe::7a) by SJ2P221CA0006.outlook.office365.com
 (2603:10b6:a03:5db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:10:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:10:18 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:10:10 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 39/40] drm/amd/display: [FW Promotion] Release 0.1.74.0
Date: Wed, 2 Sep 2026 12:59:01 +0800
Message-ID: <20260902050411.3473916-40-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d59914a-61fd-4761-a236-08df08b07cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FEXbZi+0gtgE9PlqLwfIiP3FtwUh9nYWmnss9xTUREJF3KCb2BON41m8j6T5LmapM61oHx1k0LYqw4s87L3ngNZYE/d+Gft1aAq04sxZMFRDWXYrgTx1TGDhjfrbKJixPPiPJhRIUlT5A6k3uTGnhTsBkoGMkFL2+lwEKJcw7XDZkL2UGuEkVPgvtzHeBaM7zmKGTrGVqTPoK2/fvSU3WLvtbpcwzFDLi83HkpUVsKPBglLq39pMQUQ/vgRoWgX/aFKqv3OZCcuyslKYT5l147XhlQd6HTl3p51Jy3zcFxQW2YHCKWTnADfo3tW2WJWLXsSRzW3fFNR8TK/wInrnLwNE18JmaM1HeWE2JkikB4aScL5IN0dRjpbHeN+PFd8L97cdBE+J3Xg8/kykNWVDoSEA8da4j+z3ozHf7HVSxnzmWcs7+tniQSH95eW9rVgPPm28eEixsrDG96jT6DQyWzNpwxYZ6j3LCiq89+qHgkd5SIQ2/WEmlsqFXbeRCVHyTGmMi9UBneVRM3YsEn2vuivk/glxXHF9iJJojeKFjatjXTkOTXZBs46ttMQkSYFca3WNCN0i86kFYPkQahVjwq9kLnXb/fVPDTKuhVLEkOnneDbdfzXMfrxYF12tGOwVRuSC0l4lvdaw+RQr4BKaQMuC1XjziKIGNC5DqDDD0l6PFilK04XoUihJNhztnMoH+go4d8DoO+RmTjX9chSikQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A5rrMvzSSLnwN9gQqDtF5yZRacfJwLnLdZ2x5rUkCZWVZqVjVfz04G31NeoX0apgBbd5xWiR8yHG8aUg3eZjgMxh1Y62Cyu+FSE4KaqU1sWstNW48O9E1zis28CIOkZkHRzZWk8+joYDtYFtNcp/9DdtSv/93leDtk0s87sfawWtlt9VDZxCXc8shCvIrAyrASjdk5wNtjPJV4xHXgQ2+sPRtsmS5Bf1ZatY7RvY8MwV53+tTKHW6F4NH2q4r4S8giRQgXvK32hujP8LSE8wU2rGW/BqGtnCXT9jf293tBee1u8InEeGLSqw5m34Kd+zYIojrKlskiB+upbjLwUTdURL6wC9vJ3nl7K/F8psBSPJ51P1f4d2CkSpdr2VO/nKVic1euUxAX+l2N00cxOHzr4KdxZ6+jBgXBEuaDJ+f6hCAsWeozPgOQQzue+5QT2A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:10:21.2501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d59914a-61fd-4761-a236-08df08b07cf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
Update DMUB related command structure.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a4043c5f22ea..ef576640de5b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1759,6 +1759,30 @@ enum dmub_gpint_command {
 	 *       1 - Enable panel polarity
 	 */
 	DMUB_GPINT__PANEL_POLARITY_DEBUG_ENABLE = 140,
+	/**
+	 * DESC: Reset the boot-time cumulative PHY-off residency counter.
+	 * PARAMS: [7:0] panel_inst
+	 * RETURN: 0 (ACK)
+	 */
+	DMUB_GPINT__REPLAY_RESET_CUMULATIVE_RESIDENCY = 141,
+	/**
+	 * DESC: Query boot-time cumulative PHY-off residency, low 32 bits (microseconds).
+	 * PARAMS: [7:0] panel_inst
+	 * RETURN: Lower 32 bits of accumulated PHY-off time in microseconds.
+	 */
+	DMUB_GPINT__REPLAY_GET_CUMULATIVE_RESIDENCY_US_LO = 142,
+	/**
+	 * DESC: Query boot-time cumulative PHY-off residency, high 32 bits (microseconds).
+	 * PARAMS: [7:0] panel_inst
+	 * RETURN: Upper 32 bits of accumulated PHY-off time in microseconds.
+	 */
+	DMUB_GPINT__REPLAY_GET_CUMULATIVE_RESIDENCY_US_HI = 143,
+	/**
+	 * DESC: Compute + log cumulative PHY-off residency snapshot; return milli-percent.
+	 * PARAMS: [7:0] panel_inst
+	 * RETURN: Residency in milli-percent (0-100000). Also emits DMUB trace log.
+	 */
+	DMUB_GPINT__REPLAY_SNAPSHOT_CUMULATIVE_RESIDENCY = 144,
 };
 
 /**
-- 
2.43.0

