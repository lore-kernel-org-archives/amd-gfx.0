Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA4606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C5eMT3J6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9753710F944;
	Wed, 21 Oct 2026 06:26:20 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010008.outbound.protection.outlook.com
 [40.93.198.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 577B510F941
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvySo+D7xEH0dt6fRLDViywAxFgZkLkcPUj25NhXxm5wu7k7XxPJWDROZvqTGuXj993Qrjv2v4ixn1tJQc4ZosIV5mq/sdKF/8qYJc7qW5qRsQLzxa8ulI+ZxRM+/FfBDdFc+J8GpJtU++hhHZT4xhVukg9LPPx/mhxUbg8Kg1ZVUz2Ssx9/FmVZLJ4hZQPXHYvQAiv6VE+Rv30EHVQncFqmWFPLg3WAnJX90aavP90gJRlNLeihNk6t8EuoiR8qlBOYWhcSvKb3q6QJlcjQD1/XQgC/eoFRts+5zhHJ0AV/Y4+Ft+n+JINbhgJw4ev7QjZ6erSSK/fXhYyAJiFm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZeP/zn5eBS/vHVt+if6fyh46uCUvQs+8clzhZ55HSs=;
 b=isCI/hNW7Bi284slt/BCzxG75Sp+PTvgiV1xS3MW+z2uK3TYiGpXvdQtL1+RXkV0XYdMw5G3+SbAW5loHMWDDj6BaaubBGrsxZotjHFnOnW2s26Hr3+OpSn68PtXXgtxfYiX/i4GJRAOvygsU6ihU5DDUP3/CRA0pFLmYd3jWdm8PH2FPTrevfN6xFEoBsjl96OsMnDYU8AuF3qqzBYY9bf1/ngDrYBcZsc3hmj3n8ylDiclzkdn4uk8xVUPxnu6I9IHMnyzZNCPFuNXuTU68fB6AeCdkbLVzQOxBQwPXngw+bIF6QINHXTLFnigDRynLIW7IN2vyC+ZHd4JB4ufrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZeP/zn5eBS/vHVt+if6fyh46uCUvQs+8clzhZ55HSs=;
 b=C5eMT3J6zo5A2J2k7OKYWKIkLOGv57P1bXOqrSqNZzVvIDI9iIbBDhCSeRLgkaEqP/SYIBFc658s54JyqxRwrYkAh7kRvOYnXtoHIIWwR58BQCjAPiPa2KRJrw2J8qrFnQz/9SJRwzcv/ZcY5FfdXU/OzBt//QvteHG4pq/ZYwc=
Received: from SJ2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:a03:505::25)
 by DS4PR12MB9819.namprd12.prod.outlook.com (2603:10b6:8:2a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:26:11 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::6d) by SJ2PR07CA0002.outlook.office365.com
 (2603:10b6:a03:505::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:26:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:10 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:06 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 13/49] drm/amd/display: Remove deprecated bandwidth Kbps fields
Date: Wed, 21 Oct 2026 14:22:19 +0800
Message-ID: <20261021062519.674697-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|DS4PR12MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: 563e6acf-8b22-4466-4494-08df2f3c3320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|30052699003|23010399003|1800799024|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: S2RIgmv/BSr/WHfezD3ijz6zhQn5o8RAJSLK+k/E2qxRYvNNsPPzZX3yPBim8PJGPPA6z46ohpf+m0dH1gLspTU/eNmzU2GpgjSwICMaXtdwpoRS5fh7L9E8f/bWJBoXpGhSkMjvFjSWqqhwFu2dQ6kwKjkbJHtn+g8Y6CXQXd1/P8Dfhxpb6Plp8jAS2tT20/XkHAF7FcbSEwmeD/DrPoQp+DsPE3Osf/4E+YUsZ4Mkb6nAkRv3ywH2UeK+CgcZ5jGFNS0RAkR5PssDet9pEcf2Yn0NdHFM131hjTzi7B8emRIAYbWikglDVCwOaYLvVvdOaIKU3S9NjFq8YVpN4SOpfg5pbaD8jcvYFKeIPLdMKix1oKRHctE8x22sIcpuJSpWr0DAwG4Nnp/bTc2TaXZd6DNKf6jplzBGyUDjqpacCdIiAG7CCBKfEnkG6Ac5Gc/WMxVmw9SVvQZxCcibe0yrcYyO97pogAwpV8MYF/8ABUKj+4eSr0qM4k4L/DEpsiUaF5Kpt6MMXZ7Da70MPFs5lwwIqxIwnSTYMBdfU/w/HfSn2lYHpLgdckwBdxgLhozjaRP4GAPTK1FrSZWV4gFcatBIsvIaer32P8gJQ06cbmNJQuIwg57egTtH3x2mmofIUEDsP490ekVtVan/caz1kaqkr/RxAZkbKJayCDGS4Xfe+nEOHERpkYqmpwIv+LN0mgAgMkRM5gb8YpvmBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(30052699003)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zyIeJNWDTZMcQRIv5tGzaoUoKNDORMCFepIHlFkYYMametSuBIjQhrvxCkGmLurtCOiMY48TRjOJJJujDunwGfj1+GMLmdrtgRhvsuzDYm+GDO87dRC757XupRfWTiLZcIKALomwZLLPby63RGdRjVIHv2WxzLTiu5PybkzE2JnbEcZTA6GkRowj3vLQOk8Qn7+KtoYicvFKvLVqWwnZ6XsoVV2YyELIOy/GYiSoVKoo8s/eiqoUzC119vR04LYb+EIbw0KZsCXSOLY4BmQstpeWdJn/Utq1hLflBn/+VsH9Wj+OcRje+0s+tQ1nVHcqqkJe5dTyZRIXt9z2u0+9ISxW6+J9gzg2aBTVJ8xJVY2Hf86poKGMR3FkIrdYTSQ7yj+bv9sXLiUBwh6SuGtG0UAS2wRjsvU2jboSCm+86+XdwvaOmB7//CZTsm7CRgzT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:11.1464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 563e6acf-8b22-4466-4494-08df2f3c3320
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9819
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
The bandwidth Kbps fields were deprecated in favor of the KBps
variants and no longer have any users.

[How]
Remove the deprecated fields from dc_clocks.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f4fefa7c9ab8..1d95ae50f341 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -811,9 +811,6 @@ struct dc_clocks {
 	int idle_fclk_khz;
 	int subvp_prefetch_dramclk_khz;
 	int subvp_prefetch_fclk_khz;
-	/* deprecated: use _KBps variants — will be removed after DML update */
-	unsigned int utm_urgent_bandwidth_lb_Kbps;
-	unsigned int utm_nominal_bandwidth_lb_Kbps;
 	unsigned int utm_urgent_bandwidth_lb_KBps;
 	unsigned int utm_nominal_bandwidth_lb_KBps;
 	unsigned int utm_latency_ub_index;
-- 
2.43.0

