Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32375C87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C871610E4F2;
	Mon,  4 Aug 2025 08:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kYxDi2Ry";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A34710E4F2
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVG2mmBv5oBivSwUFYGCj8zv8vE3hc8ImIdjsObFC72JmqZ56/S48MPbsiEmcKAE7bAgfnt6idCAfO2k4vwcfXosXm6Pw8Yl9oE2+NoKG+lVKSPiF0XImmCRUFfWiZ0vpmzpaou/ryFQUiEx4vX7BUBVV0vwBizAqZIMS8DzEU+NnDUDO/OeJkRdBsP6Fe4rpFYB5L5dhpiRUbxr+9kHxr8IihNOHztnbYLWNBm0DSWcki6ne/ovfv1tz3ZrQM8QCOO1eguCaySltCNPIlZE/979vnpQFxbulzgJr3jYF2/pc192r7rsqBKC+FSUL+Lk8JgUZ4roR4RSJc83DI/Qag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWGdxHt/CP3Tyx5wAHMiAawbe18qxt+TBMIIx5UrL6U=;
 b=teX/6lx7t3QWgUS2N++Uqi3jG93F4ojsf4wqPjkfjGUJNspKyxVAxPjriwzPviV7v7yczUKS3ZBibz7dh+Ub/OgglXTXzPQ8C/9gZxJgQKXnH4YoXRCYK9MiXjH9jIJiGAPyZAR3Q8X6hjFd5FANoEmuipDPOXxQadewh13bj6EEx+eSt+aU4Jg+2QMHUCEJBmWiSwoqdLNYj45K7QFux27rbTJo3Cpi5o6x5ESqyCofPPbX5MOv40vRWDUVoUntlTGmE8mERVU8g5h5pB4QlGmiKNS4UyMtKdm8+LhKKNP3Ozc1U9wVZCgeR2YfoIqTRrMcistmh+kGm6AyNqnhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWGdxHt/CP3Tyx5wAHMiAawbe18qxt+TBMIIx5UrL6U=;
 b=kYxDi2Ry9Sdm7IBokXfFoigeNyOjvgGmIqjbSvu9Hy4TRzvsqqGgCyvCpLlCgw/BRrOC0YR0hsUrHSz3UaO/0/37rhjGT2Y2Iq3Hk+ufv6faozOozOso14yYW14pgaDF+GHpEpvfYifmwlrqqwLPIf1lbf47egT49529w2IieMQ=
Received: from BN9PR03CA0866.namprd03.prod.outlook.com (2603:10b6:408:13d::31)
 by SJ5PPF2CD49510F.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 4 Aug
 2025 08:41:23 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::5) by BN9PR03CA0866.outlook.office365.com
 (2603:10b6:408:13d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 08:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:41:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:41:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:41:22 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:41:16 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 10/13] drm/amdgpu: add user queue reset source
Date: Mon, 4 Aug 2025 16:38:28 +0800
Message-ID: <20250804084029.863138-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804084029.863138-1-Jesse.Zhang@amd.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|SJ5PPF2CD49510F:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d71aa4-de61-407d-5624-08ddd332b120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0QjtYZp0ZXm3/cDo8vv5+aHRg0Sxii2kk5kYGrx90zb+CaKkxiq6rdsBoMMA?=
 =?us-ascii?Q?iULTIG/vWHfWVGd+Z8Mm1Yz/ATDTnIjFfSqTPt5MRGpegvuMXWM/F1gUeaBL?=
 =?us-ascii?Q?sZlDlAlRV1MsKByZOvirntkkuJhmXOvAxLsdNDmCgIsRCueQXOX+7trrlmfZ?=
 =?us-ascii?Q?t4Q/d2EUuxV55wHX287Sp8Aa0v25JMzJ2iJN0Hx5yadc9LdGfzU3tEXAthdF?=
 =?us-ascii?Q?e4TeYq1tpCcrtPqjJf+acIsIfL1DkhQO/ysflc4wmjwnmjHbT2kUW0Uw+KDV?=
 =?us-ascii?Q?d8JuToQ7mO4XVFHpMSXHDTOe/qP+gE4DXGk/ISfLJRaMw/p8xuQJpaqjlBUC?=
 =?us-ascii?Q?K8o46SjYJEOoNVePcKgY9Dt9TA5VfK16ilhiFak2S8Ast4V2PIfeCU1GMS27?=
 =?us-ascii?Q?d1ftzaGL3lVav+vIeMcmbvGO3jhvCZ48v3AeZup46UG4Bcd/pUG+/+x6T5R3?=
 =?us-ascii?Q?elnZHW9Ed14DKlddlSWoe6iMcIB5gCECAhR2Gv1Huq2Ew4vW7KkKv0NmVkX0?=
 =?us-ascii?Q?wBIaP7Q3Cg+uXgQbBpQX4yj1STpSxaq8R8TjiyhF8x+y2uH19EQgAVHfo2oh?=
 =?us-ascii?Q?bP8Zs2g6qDA3g0kn3iD8EEnAhnWf59s/D3brHgJIiFl2aBcQrrWTegShgaZw?=
 =?us-ascii?Q?XTZH1XD12/H/OlXcrgTQPAP8MEuoih6nLK52kN6EwlGvkzgff+2W0Udfed7p?=
 =?us-ascii?Q?2UGtgoF4u4rl6sf4PjuKBAcreznmn/5ZcDDLga0bReROgweDxAl1XWc4R6qg?=
 =?us-ascii?Q?APVI1BFV9M9gcDd6ysR/yPWGUCY6WY72uvMWVbF0oRDTL4Q0iIoopjASoJza?=
 =?us-ascii?Q?aS+gKFmDazla0/bhJ8jBgXjqqhLS/ZVpGot8dI2MMSW/O44qqLNJ1gUcteea?=
 =?us-ascii?Q?edha5DP1zZOiOLloYNfbLLL4RpFoqQsBi+lU4MG3aSc8QUOq6ep67INYtcvP?=
 =?us-ascii?Q?O2vQq8UxLw/Uo26PcWNWeY98dzfafH/bzJYSwT0VHklBrC2HLFp21R++q5p5?=
 =?us-ascii?Q?2xPrnQs8AHbfmphDIXzd9uNXycgIPbW1+k5AyLzqlue+ebRUTDjunJuPeK4P?=
 =?us-ascii?Q?iFecXR/jQkAykn+CgiuRmA22EXRionrMng6v9DT+Hj3D/rgxw+c1z4xndGC/?=
 =?us-ascii?Q?yANvccYbf04+F+YLvr8e5OnVK7oQ1fXEa0fleIUr5hYFRbrXTy2iOZTxMNV7?=
 =?us-ascii?Q?0UXD22ttlSR48/OYSk949WFqC7X4d2Z5/PomDkImn8r/DaZNO+rFvkVsaPvh?=
 =?us-ascii?Q?wFArO9NYXHrtGUY/EBa1lvHB1xglXiVVYhpWQXhBgNM4+wgOfTRHSFZ/N+D5?=
 =?us-ascii?Q?+xQx7rDMPB5MJLNI0yxfG7dwC1Eu9w72CNZCBYcIWbp281+PQ0fSZ5KKhSHF?=
 =?us-ascii?Q?wQTYA/ItAapYc4FYqTL5s5ZUmc/vXHq9/K7WlqLvbgDkY2Jsua4giy2S9hn4?=
 =?us-ascii?Q?pd0c3qZLcrOhU4dQj2TI1O/66ClAfcxTCXCAGmFzP2Vx7G6+7SsXmwoXFlNZ?=
 =?us-ascii?Q?HHxy0BNrR6nfPiWn6zMfiJjSlsEMqR42OiFs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:41:22.9525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d71aa4-de61-407d-5624-08ddd332b120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F
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

