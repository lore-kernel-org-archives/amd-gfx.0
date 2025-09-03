Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0333CA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAC510E515;
	Wed,  3 Sep 2025 08:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QcvvZP9T";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48AA010E515
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUhWF3A8MR/W+5qHed7OPKJPhBC5dl4j6Ji8JzHCVMG3tUXZHCb5bNK+2pL+B+o/WCwK78BymwP/r0XdmtQ6aNW+wxSpR2QcshMBg93BJnxaf6XkA6bQrF2JQ4lpcxa9iXl9nETIpxIb6eOCtexO+mJrG5v845QWtd5biMQd99H5SfquADNrNagruy9G33n78lUZrw/4PD1wpApYBSuIWXTfMKaJtvXIQHkQi2LYsF2aHqu/zYKklzCLiMcDvc5Gs7h6c67UiYpGICTPegEevg0WJmaTV/7Ovm+lIELtph+GgSV8QoxFsOM1Xp21WNX1nM4ON9jltALdExsMM8G5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=dndSzieP6lC1AUGqYiyNxRHD0eOAUyUNSgFiilVIkhxyBiik47cKJ24po/w2b3yeCO2CozqYZHuxZjmsbFfnZAHMjzevHZA5QMlQacq6qCH+7Qu9fCZ+CL7j01t8D8crwcShgSiTBiiiU1yIdh0st+v6arAWeJ8VgxyV/A/w0P01zgFaKrFL+lIIgOTZErDQsjDNd5OzKaT5BK+MqglUNXeXaWquaYQXzKFX/BVNi8irSJAyxsKeJ6+sZLRTS1F9r2rD9EgPxpliUQ3z3z62m7pO9+RY+q8r1O/rGgh8BtWPyZUrdDBl+nJdSFOaNVjpIlGChGnM6AMtQCg+8QkYOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=QcvvZP9T6aM2imjGZuXsz0Ppe9IuAxDeQgzbNpiZXE8u/nxkuz/oYe66JQtZxbRZpocG7kMFWWaIE53GylbYXlrN2G2nF6qura8AXcxa2qyM5jH/M8vwtbe7CnvSr8z0dRJBLa1U1GACatVNSkS4GyNnzf4YMcIanEqhOsufsjY=
Received: from SA9PR13CA0110.namprd13.prod.outlook.com (2603:10b6:806:24::25)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Wed, 3 Sep
 2025 08:40:10 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::eb) by SA9PR13CA0110.outlook.office365.com
 (2603:10b6:806:24::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.6 via Frontend Transport; Wed, 3
 Sep 2025 08:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:40:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:40:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:40:01 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 03:39:55 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [v14 07/11] drm/amdgpu: add user queue reset source
Date: Wed, 3 Sep 2025 16:34:25 +0800
Message-ID: <20250903083914.2604482-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ce00ea-3f05-495c-434e-08ddeac57dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ay9aanJLbWo4QjdDNmpHaFc1Si9HUUxMN1h3bDByZ3ViZHhlbFE4ZFZqTnUy?=
 =?utf-8?B?OGNVdHFGbWNBc1owalhTOFVUYWUyUS9KVW5iMG1VSUlzenBtYVBLb0dMejZI?=
 =?utf-8?B?NEpnSWxhNVZsdHliWnpLNDZBQ2xrYjdSWXVJWFFNTlNxM0FGRTJYNFRkTlNp?=
 =?utf-8?B?REpDa2Mxbkw3TVBtazhlUStDT3pxSDBVVjhjVGJ1Y1NBQUZmeUEwdnd2S0Q2?=
 =?utf-8?B?cmt6d2NFNDQzeXpmdjNtc2FnbldyMHcwbXpuV2FZWWN0Y0E0L3BUK3JoUk41?=
 =?utf-8?B?Yi9yUEY1UHRQRy95VldBZUxWZEY1T1g2NnR3NjllQ0xmTkFNcEl3amRxSngr?=
 =?utf-8?B?QmRLN3JoSGZHZzRHWng1L2dURm95N0pLbU9zMHR3MlhUTjY0WXVyaEswbDhZ?=
 =?utf-8?B?NUo3aEcvTHc4WW5ORUJMTUd1Zk5aU1lFWWM2cXd0TjdLaHhQOHREYUhiUXRp?=
 =?utf-8?B?RTdzSnQvRGdKYU13S3EzaVhOb0lXQXNzLzE4akYvU0QvT1gxWHhyRFY0by9o?=
 =?utf-8?B?a2F5cS8zVHMxUXU2U0dPOXdVRzdPb2VOckdsbnN1a1NudmJFbGM5bms2UXVB?=
 =?utf-8?B?WWFSNXZpQndSSFBvSkkzUW5ud3UxU3BPQ0RYd3Qyb2tQUlNLcDd1S0svV1VF?=
 =?utf-8?B?cUlETmNpNmZHbmFkdC9ZOCtadEhhOFVuTytaK2VUY0VHYThpaEl5MnZGVmJW?=
 =?utf-8?B?WVdVRzJtb0pGNnNURSt3R3VwOEJnSmZQaFR6TEZGNDE2bTBqRVY1TjRXNU44?=
 =?utf-8?B?bEp0QUhpWklIYzB5c2krRDNyVmJzQlNRWHNIRjgrT1FHS2FRNHdFYVBrZHlm?=
 =?utf-8?B?MzR6MldTQ0NJRTh5dW9na0d1ZDFDclE0ZVFqb1l2MHRTMGtoTHBNWUVFeStC?=
 =?utf-8?B?ODNxV3BPVjZaanRZQ3hIS1RoRitkRHlaYlRMK1RMMGI2R0tJejFGSGVvZk56?=
 =?utf-8?B?OGNRNEJVT0grOUZtVDc5ZUxwRkNRWHdSNExwcjkzWHpPdmNGUEQwZkxXczF2?=
 =?utf-8?B?SU54ZXUwTjM4VFY5dFlUSXFDM09FM0ZtQXJEZ3lIMXlMd1RwVEdNTkt3OW1J?=
 =?utf-8?B?TXFYOGpXbjVUd1RnUk1YNCt3alNpR3RZdFd3clREQ3VHZ282MzZHS25EcUZ2?=
 =?utf-8?B?dlhGcE5meU0zZHUySUZVaklHK1VGYzdHa0NwMlJ3K2c4N0Nka3RsUmo4NzhU?=
 =?utf-8?B?azFiSEVjL1U5cjZrZUlGTmduSVYyZm5uUjRIYjFsaGxtQnJUcFNhczJCVnU3?=
 =?utf-8?B?MkFxQTJIK2xpUDB0TEtIU1VOeWtoR3ZKaW01Ty9TOWNwMkJFYVNuUE82dlp5?=
 =?utf-8?B?WnBhQ2pJamhPWS9HbHJBbTloNVVTcG52Qnk3TWh5OSszZXI2dUt2YW5nNlVJ?=
 =?utf-8?B?LzYwQ1VEa2N3bmdQU2pxV05QTVc0VG01dWZpWWthL2VVUGVBYVVUOU5ucjBI?=
 =?utf-8?B?V0JtUCtJQWxOcTMrUHVQclp0Um1Zck81cVk0aHBwWWVVUysrc0ZnUkRuQnAr?=
 =?utf-8?B?WEI5Y0ZSZDhHT0lydkwveDNGWXJlYXlXL3czWVMwQ1haWGxHcWNrdzhpNktC?=
 =?utf-8?B?cGFSeUg0N1RtVDIzUk5QL1FIcjhGSlpybjVQSGlnK1hIMjNqQjBnSmZZQzFz?=
 =?utf-8?B?Z2hRMDRLa0orZjQzMjFXeE9GMVE5WWtDOTd2VHlKeFdqeW14NXpGcGtNS1BS?=
 =?utf-8?B?QmNRVzREaFdpSm90VXBHL2IrTlBIc0dha3psblpmTmo0b1M1Yk1zMENBSlJG?=
 =?utf-8?B?RkNTaVpZMXhFbjkwSWQwdWdyWFdXaUE1VWVPSHZtcGhjTHM4UGszd3NkclpS?=
 =?utf-8?B?cHRhNVNpVDZFdExhZWdBQUJ4azUrcnVqK2MzTnZ3cXZYbW9MWnkzUlZDa2gx?=
 =?utf-8?B?Vnd6THBKSXFUUGRoclI3VWRTcXNTN3dZSDZ4K2F2MzhWZ0dZampmWnl0aExW?=
 =?utf-8?B?ZG0wbUtiVlQxdEtoN0drVE5QYUdqTkFPeXIxQjlpK004bVZ4cHRRTFg4b0M4?=
 =?utf-8?B?QTNDbjdXN3hCc2t5NTlVcUtlZFZLS0o1UkI0MTRCR3lZTC9JeHNZc3RGbTZE?=
 =?utf-8?Q?AngyzZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:40:09.5691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ce00ea-3f05-495c-434e-08ddeac57dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1
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

From: Alex Deucher <alexander.deucher@amd.com>

Track resets from user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..28c4ad62f50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..ebcea44dd743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

