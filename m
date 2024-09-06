Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5199ACE7AE8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 08:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF3E10E9C3;
	Fri,  6 Sep 2024 08:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JaN7Co2Y";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D03510E9C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 08:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7AjC5oRzhYcdRjmzdmKP/7sONmgJH4rh8kjiydtrpwvxPJcCYr7B19gQdGjhBs0osWNM3r3iZu1b9o6nFmdzzSMLfEcW9gLmruKPwKSr/CPCMi/GiXel3CDQBqVqRVHMtYMmZUqHIzkzcFEcpFb57SI0Hz2aHS6E0hyrUfaYvBvWkH5goH/uePOcCYzptqSBcNHrBAnnmTJAFyT7HOn+HOpA/230oAI2cecnPA6XhxAehOBMdhyDZjf/eja7GbQiY+vGiDWi0zbhSh9/kJJHc7gihgLWpPQMfr/1Zn4XFl0xCgI+1kXkQC4z8ma5s3H8k0ltF5oKIHsdoAdeoqXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZcqmNSxrWoI9cOq9keNyJcB6HfBZEwdXIi55YyYQ/8=;
 b=kbaGIQhcwapSqduYa4syOF9n2YYKhY7wcHrAhEmDArCV/kWBN8EpIM/wqCouTh1h7gqVwr+GBybZF7c8wfNEZVgHj+DoNs1s4dmKw+L1Ux1Di6zRUmDfjPD5aMlrE+cRYKYHpFTtYhshN4j6T5ahfUcFXfPM9Najz9fQlWGhag6E5EAql3epMFua8r7moGkAvXsWDDH1CsYIG1yHQSwsXm7R3Hi6b0Oq6a4sx5f+VW0196ZQQzqOiyAP0MCYHqt1VHATWYcR14+zEi54h0WkBs3rgVyLJd4r/JJaJ4DO7ENMHZ/8LniAj0Bn8291W1RIEo0BoAMMEuJm+y2ahGBo2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZcqmNSxrWoI9cOq9keNyJcB6HfBZEwdXIi55YyYQ/8=;
 b=JaN7Co2YuH9j+Ny4nGs053Gam7byFFrTaUa6+Xesd8cxzVjYGaDEtk3NPi5NQD1ItOSTcm+seomuBiPSBA+f2wncWE4TyRDJxZwCxu/OeBiPlooPGPhcsHmaoPDEdcvExpYh9LSyCmHw/nR5o1TVzvSiuX9S2X7jhwj7u7cnrzY=
Received: from PH7P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::9)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 08:46:37 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::83) by PH7P221CA0037.outlook.office365.com
 (2603:10b6:510:33c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 08:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 08:46:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 03:46:33 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <jane.jian@amd.com>, <victorchengchi.lu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix JPEG v4.0.3 register write
Date: Fri, 6 Sep 2024 14:16:18 +0530
Message-ID: <20240906084618.2068168-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba58d61-e9c8-4dff-13fc-08dcce506b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nImNxXB2XgU+q1eyGVsO47g/YTHHpBiA4utKeiOwU+HzGE16k6qNqkgFX/8x?=
 =?us-ascii?Q?vPGXB7qt+juc5m3g07GJQetXKrjMwtkgcRiNjfI7YkEvtwqQT7htDJzserCd?=
 =?us-ascii?Q?bJd5gGaTNtoAfXC7cUT8Tr7EO668XC+DF3GGloohJil5/2muC2/CcXeUJzsc?=
 =?us-ascii?Q?G3P3HcoPP6oEovE5BKrI5m0C+2mHNpljRQSxjJ4xGKVD8oRouHPnfjsmM/Ey?=
 =?us-ascii?Q?LXq0eNj+3j9LXRwydQED9y15tANMjkhiPZMfRGb5OOKsa0qXAr2YDrs+flXl?=
 =?us-ascii?Q?sSlIC/3hnMOfCus16VUBlg9Ti5Z5XDanLcwRfcompiYisVGSLr5qYLfLTFy+?=
 =?us-ascii?Q?YgnPQiNyZMEWg8qQN/a5Kv39Xz7R7M1NRj4yEjzOjOwUKscJy3TaxRzMPFX5?=
 =?us-ascii?Q?vTLHheKcwzsLbt5lR6r/4XHpkh94tkd1YoHrhnrCoqX/N5YoZjw/XlIIL5xy?=
 =?us-ascii?Q?7IU1pkVqPAV2YJDMXZa/g2ljI8E5zInjQZnAh7kgORmtFmjA8IVSQjDPLtNb?=
 =?us-ascii?Q?XGZIi3SjslnZrkkNVO7mh9CSII4HYP+WEp6HmxCUWy2UJQ94EUUB5UK5xP4W?=
 =?us-ascii?Q?eeacPAecXsKBidFqnAzkpbAZj8n8UL/dGRq0/BfGkPqi934xYqzCkMzchMOJ?=
 =?us-ascii?Q?CZ+2L0R3VJsHgxMX9cvNjzD+bv5zbWhnrnW9sdLskelFE8rKgrqDpO9mfQF2?=
 =?us-ascii?Q?SMbwjhvrOAKNdEYt6gsxQ0GObFsjNO+8FxmF+/Kl78QFQivHPKo7236gy+QX?=
 =?us-ascii?Q?qDWxVckhn9BNZIy8VqLJIOFiGRqiCMVl8mUkY7FXkjIfCXsYA9ZIXbFBfYZf?=
 =?us-ascii?Q?7h3SCVt838gecwmlztIwDrH7IR7S4qtylGgZJjkUckiXa0ifdMt9J4BgOeOI?=
 =?us-ascii?Q?8K4u97rKdodbMYTwbBjRbDKFFRfT4UVRAuA7q146F3do3e+vn+3/zrtOVc4g?=
 =?us-ascii?Q?x1Z1nN6ffdiQjKcL1S8mTZcwGyQ9rxNb03yH/p9zHOjNrnE0tYNLZIIICHjK?=
 =?us-ascii?Q?eE8czyX7c4ppOdbUC3woDTwAMk2g8kt886jem4z52hNuddJb5MskGbeycqk3?=
 =?us-ascii?Q?p5TGPlY816GTsrbIt9+b1JGgwwUWBQiIMN45LcRrOp/Y3H2WPrNDVR93gnHq?=
 =?us-ascii?Q?s/ZaDkPvx+gnHy2dD5xHHWN9xKaoAHeoDL2U85tlDsVBVA2uAtW3FpUnGqYD?=
 =?us-ascii?Q?JAXo6ccyHp+pzmXKJI8OWtUSXHL3zSFgQbGn3lh3S3qC39K+gFyZZ91pHyBf?=
 =?us-ascii?Q?qesygtnmTITUJOuQCbJY2CJOJDFfxF/dEj+xJMmHhcFTlwJjwBlxWkm+IUC7?=
 =?us-ascii?Q?TFqpBZsrNF4+jw2gnrTMCyZ4XTYdR72W6nr2qpSMHX2JNrYbKlVqbtUVlG+A?=
 =?us-ascii?Q?hgjDuv2OK93vbTdM/yKB5NibgVZse7kZCwHX3EysmmaWetd2+OxzcFvuCIzW?=
 =?us-ascii?Q?3xDlqGby+5NA3F2t5Jaigz21Mv7bqkIO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 08:46:36.6239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba58d61-e9c8-4dff-13fc-08dcce506b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795
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

EXTERNAL_REG_INTERNAL_OFFSET/EXTERNAL_REG_WRITE_ADDR should be used in
pairs. If an external register shoudln't be written, both packets
shouldn't be sent.

Fixes: a78b48146972 ("drm/amdgpu: Skip PCTL0_MMHUB_DEEPSLEEP_IB write in
jpegv4.0.3 under SRIOV")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index a4ebceaaa09c..8d6a8c66da18 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -674,11 +674,12 @@ void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)
 		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
 			0, 0, PACKETJ_TYPE0));
 		amdgpu_ring_write(ring, 0x62a04); /* PCTL0_MMHUB_DEEPSLEEP_IB */
-	}
 
-	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
-		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, 0x80004000);
+		amdgpu_ring_write(ring,
+				  PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR, 0,
+					  0, PACKETJ_TYPE0));
+		amdgpu_ring_write(ring, 0x80004000);
+	}
 }
 
 /**
@@ -694,11 +695,12 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring)
 		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
 			0, 0, PACKETJ_TYPE0));
 		amdgpu_ring_write(ring, 0x62a04);
-	}
 
-	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
-		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, 0x00004000);
+		amdgpu_ring_write(ring,
+				  PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR, 0,
+					  0, PACKETJ_TYPE0));
+		amdgpu_ring_write(ring, 0x00004000);
+	}
 }
 
 /**
-- 
2.25.1

