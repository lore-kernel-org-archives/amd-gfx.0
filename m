Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B691CD3430
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 08:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B3A10E9BB;
	Tue,  5 May 2026 08:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="urM6OUSE";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF0C10E9BB
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 08:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mbo76Vw+ya6ZIxEz3rTpiG6lw1FvMgbtckcm7wecjR+x1WHAfYoyU2jzUDnu9bC7rNYLzd+ApGU1xpjEOeM4dOw29zA77s/P2nWLelEuJyIMJF7ceUXq/m89q020jOi8+DME6ffJB3RPsGvUNKrhD7sA0YYM9UDxi3xVCQMAJAdd6/vC4J4dcg3Z8Eon9jiGLlFW0VEVq2yigW67ksS0ipNYpD41dRqFtp9p++GIJPu6PK7LAmTA3PE90uu0ukog/T1KIspXegpIBmloawUPmsP71AP+rUsXajT8xyfULUnfLQXyJkUGImp54HN2w2oA+gR59mBpKzUn/qF4g5HI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56onVBqbG5H6H4j4qKEyT+XOLncC4P7hKRAhzTl15Hw=;
 b=PiXPpAaGPwtn4CIh8vfxlD7ZlI63h6C0OUlgbBuowYmW8rhIT4Bb+2vb2YUn7nBxZEC3Hk9mvdZhv7ZSvfZHaOHuNxbvvxmz7CUUFWbwZQZAPQOQVE200Aj0rsL6PIavNT5qOOhYJt4/XzeUOQzk+UzbkKf6lUbHsI2wr7Dm0RS3py7YVM/msPx8IUzjHZoWIIS7DGb6+uCeRAwXeARR0LsK2nEROgdy2jYXZb8mOkhuY0oAgjJGHU+0y+uNEDYCm7hVU42w6/Z0WrbpEdIC2lwk/3JJz3ftHQUPF6pLGGOr7XK5wPpOK69STSrmyW+KcThf/p+wnx9L0OiTr3uiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56onVBqbG5H6H4j4qKEyT+XOLncC4P7hKRAhzTl15Hw=;
 b=urM6OUSE0r2+DsU2VykyW5cmDtt+YDO4SWnIwv51l74aqFKMK+5GVw7de0MEoPSe9GtEWyf9mwTb0Dwvt4O4BJUvlhYeJIPxTMf67qcR51T3qMaGyw0GA+Gw8XCd0pSkN57D98/kcPBF+uFWsUDpjxfMwcSH18tF8aWfH9DGG2M=
Received: from PH8P221CA0059.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::10)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:16:40 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::bf) by PH8P221CA0059.outlook.office365.com
 (2603:10b6:510:349::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 08:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:16:39 +0000
Received: from caden-test (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 03:16:35 -0500
From: Caden Chien <chih-wei.chien@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <HaoPing.Liu@amd.com>, <Solomon.Chiu@amd.com>, <Peyton.Lee@amd.com>,
 <Yu.Wang4@amd.com>, <Pratik.Vishwakarma@amd.com>, Caden Chien
 <chih-wei.chien@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/nbio: remove doorbell entry5 for vcn on 7.11.4
Date: Tue, 5 May 2026 16:13:09 +0800
Message-ID: <20260505081312.14047-2-chih-wei.chien@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505081312.14047-1-chih-wei.chien@amd.com>
References: <20260505081312.14047-1-chih-wei.chien@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: c96b7701-2cbd-4d77-a5a1-08deaa7ea1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X0edNfDsAYhZea5YX/FUkf9SKqy2ZvudCVDlCeIExHW0osBVRTuOw1bSTBa2UszV9m5a5w+KhGfo4SiW/5adjNhQujP258gmd6OZUEdfHT+SMYbs8zPU+bRBKDnG5toScNwidSsbikHwjNeINNB2VZ9Em+FWxJmrlqMXsYP8KyAVgf1L/I4bHh1MzUavEweCmJ6GpYASmjiwSddoIQOSopobdZYICXAAEAUCC/168MDG9ebDEjOoVTuriPexjLN4r+/XFLk3Rk38S6iBLhpcVZ43C1nTT9cAcr0oIbf4+0v4ouAS/849TAvARPpU6uiwZV/ojiM831Qbwu+HvMhIWqFQ3npeOHu1dLO5EjdaSfmuOVRzCzW8mht+X26nHIIR8TRg2smRbl1GjPINRYqyz6c7v7kuUgHPSWQBW6ozPeFOKFP3mb2+qiahyJRQTkqolA5Hix/yKpIfhSJTGESKwELPj/FKKPnI8TyQGyCs2fxhcnheaR/4eRfTXN/KCcJamICD8sgKmIT+d2s4hI92RzPJDtYiGpcupXFnmA6hhpaZ53biDHe1smEgKavwfL8vqCh+PWerbnVlP5bhTl2x/e6GGK/YLBBwkCjYvocc6ap6GzJnPGItdI9FHKkiRZR28pIJymwAu1qFMs9Q3bb8AH4gbZB8zePphZn84bwwUqrRHorDvymNdP9RNtNNG1YMRglJx3Lfq4bgnAjFVCXmslzicC5ab9g7yk7vWcq+vow=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tJWHa1+3e93wAzvD+tgGw1u6yH7oELvyZ2tCHYpWr6j0QJAy19HY7s38ZP2i/w42fsWIlllf2ouzzmmzLqQH5XyLnSiL5XrnoVusQthYB9o+ZWPH0/Azc4T4nuQlJbtEfkmo3eKvgRrkFklM1ugYkFmR0dfcrhdn0MlSo/pVxW4LP2brvQMjUqi8SHbxEKdBZnARW6jhvEfQPxuNjD1rQh9Ho3Opr8Xk4Lq/DGP9J3lhkwKnVEMu7Ea2MKGCPiF+D3s3XHbL7miTekmN5XJzWaFtxCtWOHaOk0Nz8cyMX+WgF0i0Yo0e2nja0wLx8wd/QQaW4L9B7hGLXxAwlwOA3x8jiBTHm2TQvJwNTfoeG124vkLP6S4sqlIoW0CMyKE3GKMpdVinspzt8Mk45+q/AOH4TMWFF/jggtoCZwfWSNn084r0L9qQVKWEzFWl5Ahv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:16:39.0788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96b7701-2cbd-4d77-a5a1-08deaa7ea1d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
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

S2A doorbell entry 5 on nbio 7.11.4 is used by vpe 2.0

Signed-off-by: Caden Chien <chih-wei.chien@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index b6f832c53860..375d5ff42a63 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -144,10 +144,13 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
 {
 	u32 doorbell_range;
 
-	if (instance)
+	if (instance) {
+		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
+			return;
 		doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL);
-	else
+	} else {
 		doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL);
+	}
 
 	if (use_doorbell) {
 		doorbell_range = REG_SET_FIELD(doorbell_range,
@@ -177,10 +180,7 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
 					       0);
 
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
-		if (instance)
-			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10, doorbell_range);
-		else
-			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10, doorbell_range);
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10, doorbell_range);
 	} else {
 		if (instance)
 			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
-- 
2.53.0

