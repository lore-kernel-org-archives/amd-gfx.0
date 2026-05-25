Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB1FCD5BAB
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 01:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F67610E013;
	Mon, 25 May 2026 01:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RsnzGNNA";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012060.outbound.protection.outlook.com
 [40.107.200.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB9FD10E013
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 01:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CITltSJ7BzPosgUizrkEJoQmyrTPaHkVkVI005djEkMv06G3UM2RqR387tkMtHTdFgFmhZ6lN/VwaDuAuhCU6EaiJ04JsUoqUYuXVJ6kQVZX5ghNGAo7ZlQLDdvqUYsJWcE9x5Wt1AUUOQ0uIG5I+30qkefw57opnIz8g2YHEXXhQfxwEbWCJPqPXnz400aWXM9QYkOombvUYe4xUInmJUM7khx2xNKBo+ln9FPAVid9m0Mf49LHnzDrijTwOZpBFPZ+GD1oCDtyQNIEW9g4Sqx57vp/5nDSRgagUbgzimCbZBo4IsCF/TaYoiFZWl4a1eqiaRS26xnFs/yPG4uFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAqgoZtWgOWFZm1ArEXrC064RCeEpeuFi9ZZp+shaZ8=;
 b=IJCeAPpudeT8MDt3bpWTApf6WXX3AUqRG6/XJTehRtnVyX7p2vuuQi48KYh1T6f5FVC8wAJ82rMudtJq/xCOwmVgBeV13mj2esmjTLOF2cdSql5YIzgK0y0KNaqeQUn5AjpguT+T3cIz3zRK9Tb+X74rG8nVA77moECt0GJZ333z+SnC2T9mJV214c5cOBu5qPPWidbcsUW8eV+NuCBJs6i8yFTk4y/e2yvezZBWl+4D5UZ0HI7WAwJLV9C6Querk7VjEbR7xxrIADbA0rZFMNkqX6Ze54oyktPXj9yZgh3PQT/LrVzRyhybjyLmZI1D98ky7SctA07ymyGUcvVsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAqgoZtWgOWFZm1ArEXrC064RCeEpeuFi9ZZp+shaZ8=;
 b=RsnzGNNAV9KOp5eWDd22hm+lWEr6qAUC00ySyuBLS4Iayy1H92GjRJj6wq7XV1ybath3BiSXvx9ZNsnykKVmo5pBUzwAXIOgiley3yjeeuy9L9WPScOphdIZr8cDp+6yvMNiRm/ttxO3xpg7I29E5z51bfMih5YtdTFnIcvbUvk=
Received: from IA1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::13)
 by CH1PPFB21296325.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::620) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 01:08:09 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:464:cafe::86) by IA1P220CA0020.outlook.office365.com
 (2603:10b6:208:464::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Mon, 25
 May 2026 01:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 01:08:08 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 24 May
 2026 20:08:03 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: apply SMU 13.0.10 workaround during MP1 unload
Date: Mon, 25 May 2026 09:07:53 +0800
Message-ID: <20260525010753.16210-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CH1PPFB21296325:EE_
X-MS-Office365-Filtering-Correlation-Id: 2160806c-24c4-43d7-d693-08deb9fa153e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: GfI9/VjntOZJ1kbNg0NdQVJ7iU8y+sErEXa0oH9CZZ2ch7p1OyIU1PGwGjBjn/jivmXyyqjOE8w1ltHeOV7lg1eByNPQsWKkadjwavCFfIMPx2pQM7nRKNEMvNyICLz0tUk8RCcJMhvaqFYX7StC/ywWtWtzQrKwBa/yuRaksUgry+q83cpTW2tdQ69clPlH+ZuKmucEuDjiu2Dj82/m9BFA4M3hizld0a3ccZkxqhKxzLCJP0RlQv1HnCR8R9TrqW4YnydrKpWC/nx0CumqVxfZ/AfdNyhVK+bjD0Cdxwu6gpdGOZbZuAZNXs6ugmXxf290ETM6j/TYufL6z5ZVhjn6a1PlNch82kAa1icwgElbhavl+RxB/JsWY9ZuFgQ6+DRv46mI/ienoQfF/YHWAhEU5kFHIUvkcJ81p7muY2c5EhNqOyKgyQuKVFxUn84ZqQnNDH1FQF5BO8fC629cDpZPO96yPl50FIWI6cHAIGLF4A22Je+ZylIH6t0nTperuBRjBDsKLr/7/Shp2zeKmxqLkeoMe1aAZTBHhKNTHHWnFUmnkOrjNFswri4LSXd5U0WDgg3WW1WKg9e29AdZnKzQG10ms7XU6M7FZyln4UZXlbPN5LQ9V3JmkxUhE0XmyHJrmJUlpnF0SKAot+0ffLP7wYVt+C/H65UMMoHyaw4Mg78vLE3Nservo19RtcUC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aarQKX7kW7F39CKBlRxsU2PFaIdP8UXWUSg9btu15wJ+5iwAEK1WRmn/7JPIGCUAwBxSXRu0eZetFCV0a26io41A3hEYRFGKqTB1mtteJxyI4HZi3FP3p9HoVcj7S3cD/gGtwOTD421XVaA1OfFm1BAHrEWSfSYOr4fCp1teLen/DH073qh19nu7kcmoT6U9bsC8w6fi5hm3ZwqO+CYZske/1x2fo9ibozv+DgznZD/aqKuCtTsP5sPqOHgqIqgmInn24h+1Armg93DfzUmT6t/Y7eQ3coEMefZEHc0z56P8SDsRT5Bb/vYC6ajPmS8hHPMzD/22yfaEMTkhMHQdnUWFg7tLJ4jxmmJa2rpnXv2Bz+IJcis82dajN4gl1NEUHpTBliyfsmHGCXdLFRPESvg4oswpBmJxapV0ZLDQYS6OHPQElRIrG34W9WU/tZhV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 01:08:08.2244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2160806c-24c4-43d7-d693-08deb9fa153e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFB21296325
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

On SMU v13.0.10, sending PrepareMp1ForUnload with the default
parameter may leave the device in an inaccessible state. This can
affect runtime power management and partial PnP flows.
Pass the required workaround parameter, 0x55, when preparing MP1 for
unload on SMU v13.0.10. Keep the existing behavior for other SMU
versions.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5133

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 9e74a5c4be43..8781cd9f10e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2806,11 +2806,15 @@ static void smu_v13_0_0_i2c_control_fini(struct smu_context *smu)
 static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 				     enum pp_mp1_state mp1_state)
 {
+	uint32_t param;
 	int ret;
 
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret = smu_cmn_set_mp1_state(smu, mp1_state);
+		param = amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) ?
+			0x55 : 0x00;
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PrepareMp1ForUnload,
+						      param, NULL);
 		break;
 	default:
 		/* Ignore others */
-- 
2.47.3

