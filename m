Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662D0C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A64F10E4C6;
	Fri,  8 Aug 2025 06:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7nCjgae";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3844B10E4C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueTvrMQMZk/HRq16YMKBcPtFtuNMlvrbVAeyOGiK3QYOXSmx2MgSaUn9XdGkh7coASmpB+Ds+kuusv12j3AZ0l6hbqCqTHrCYX4EvKKaD+Na+hJMlcFDPlFgM0f0Cw3d84Dk/cAOMejKdHckUFtVFPuNDx7r2O7sJg4kikmYK/q/Qk252iley9OryDzGtXF7THi3SkEJhz9slYLLBSZyXDbiFf4cwstZHjzvOgbO2ZM7QRif+2sBCUVx+6L2D8t+8Dj1rF7lF09pDow+6MvyOBbCQRc5mmQoVdbNPYEmAbdtegm+DHlGASBFun3f8hzwUwh41xz81yGKHMqtZXZ+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yXxqOg7MHaxzunP4jfCGGLVFOvo533ROdtAo3/lP9I=;
 b=EBaY9KA5J5jt/VZXDQng1f7CTRhaZMP7ODZBuVnBcvuKGrKWsHrjZDLqm0f0OVaOSxOCu9f8l+C1QHAF+DKpmvdKWPQHQVuAXIUrkbubKKoL/4IbWKntNRw63ulQBHrAqCAv/8QeP1tOQIfGhUrMJ3CYn1FwvxxP1UpSFStt43wDa2jz5zaQ90Th027o8vrd8MHynTkse/kFIk8npJEFQqcz7Yxqw1hTFLivkdPKTWmrtPSr1VsQOoGbeGR+SBAs1CLrmJnlnvqhusfi1PsNZoYS3xiK/lGd57wyhS3oDVtAGN6VHlEwvVesU7kllekHKXg7z9EYaUXOkB/tJkhajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yXxqOg7MHaxzunP4jfCGGLVFOvo533ROdtAo3/lP9I=;
 b=k7nCjgae8wJY/t3cZ3avORqMqHg4VVaeHgmu4W4zMxSTRCSjHDgalFf9+HKE48UzleByAeK0QPvDs5jbL7LElTpTyIErC6znuFx92YkJNyFFbnq/Xh5OfPFoBGkBUhqWrRTJVTBBjXNn4pSTmWcJ40ATv3nXk1mxScO5vtOaZE0=
Received: from SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 06:29:48 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::b5) by SJ0PR03CA0357.outlook.office365.com
 (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 06:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:47 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:45 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v8 12/14] drm/amdgpu: clean up the amdgpu_userq_active()
Date: Fri, 8 Aug 2025 14:29:08 +0800
Message-ID: <20250808062910.1613453-12-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a213cb-c1a5-4e56-e7c9-08ddd644f909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Vo/SkuFM3KKBD3fCsV8P/gcqk/IkXmFHDUF3K7J0tCxR3fCdiT26w32tVpK?=
 =?us-ascii?Q?oMyinienJMBtCKdHSe7eI40IghPIS9r4pV2ZXOBR6TWUz725X8it3RXNQQgB?=
 =?us-ascii?Q?+HC/wB3VQsAdOwE1hPWS1GUh/FT1OAJE9AMboUxb+VqCdOx9f5+oFMAg2PXe?=
 =?us-ascii?Q?CNCAvEYJ3DUlkat/qE+LDMvZ2Y4Yv/8vy6VIS5+tPGAzIdRzmBtmW6UsHgZE?=
 =?us-ascii?Q?yp9SQpZgM7Jm48Npow+e2JyJqBdL07YwdvLW8cPqbr/QGhXtIinfyGsivkmw?=
 =?us-ascii?Q?s7z/MWE7CknhL+XszZctN4zOVIft3EuaQt417KaiXO3CF1zR36gghly260FM?=
 =?us-ascii?Q?ae53l/fW+pRL7x0TOhzlf2tErKnLA4408vqi/ji7nXX10BSGIRsjh9zKygkT?=
 =?us-ascii?Q?3KM5lLKJ6EZwBE9JdpL0IA1bInedD0jm9+37heETZjgIE1wctWQp+7qzitpR?=
 =?us-ascii?Q?gqYPSnyv0pD5UV5k2M4yGft+FWsRW63yf7Zy8OkuncSHKjMGYMY6HLMQcdBu?=
 =?us-ascii?Q?xk6JfpO+HKVJxxKC4FWt5owswu/KQXEWiZxGx32QMGLS/GVzhtI2lMfXypyT?=
 =?us-ascii?Q?wIcR9Lg47KaWmAb1+ilUzCpNetb579Ut4ocYNXFDFhG/Ln8+8x6ABkSFfNkC?=
 =?us-ascii?Q?k4MxcqV1N56/GLgp8Sn8yJT9xXbFJZQl1QAfqqegw5KWJKps47k8JHzpWxQ0?=
 =?us-ascii?Q?o/W5SPauWCu8Fg6yVzngaXi0MAF/SDzHZ4RWgUbbtsEDOFKFgB74/ko3DIcq?=
 =?us-ascii?Q?GTsFu3feqaOoeELejmS3Jj35KFfFApuV0uRfyaJOydy1jdUxGEaMru3I9wuY?=
 =?us-ascii?Q?UVxosSz1ODI04T2Fqw5GRpzXkwkHer6YVuL5u4EgyXL7/WyviJc0yFkTdknR?=
 =?us-ascii?Q?hN0fXDlDI2kRxgCwgZHepTSThd13cYY+rpNnbGegSm/+XX6D9IbktOrquEJv?=
 =?us-ascii?Q?OgXhGc0BDaYh4zRA5vRjmIOal3sNyQ9cEnfSN8koIrINvHREvTLrUGYvBj5u?=
 =?us-ascii?Q?RUw7jk+B5Bb9ovH6fenStVaNX2czzDNTU/nCjASAxY8gpP1j1NS7aRhjksOe?=
 =?us-ascii?Q?WBmO2HlvLW+14ajleX9rKO7AQgnSsAbVHZha5SMmWF5bD2NMxzNQXLJkApT/?=
 =?us-ascii?Q?9B97xajRDgyJinP/0CqRU/w6UXDK96GSg22Nj6hiywIZPjZQYKoCmtkeoWsd?=
 =?us-ascii?Q?ylftx7yy878mTz0wjPKEfxNjD0X+pEnaMNWcNX8wdYJTR1l2wf/nowFMxlUT?=
 =?us-ascii?Q?QxWmUUuhIlzJxdTjXvL1I0p2hjQxkqCZG3Cot+gXIpKdF1WVWxdv9uAGXB2F?=
 =?us-ascii?Q?w4VMnrpeBOizyXe3ScLQGQamn+Gtg7JkNM79CPdHXUdJAWum0k+2TUE09N8P?=
 =?us-ascii?Q?FV9fqkBnC+1hNGeQz01LU0H/1tLEkga54AQQKR+eaZh997jYq/QEVlFJxOrC?=
 =?us-ascii?Q?DFxDyvBEtLSqYJo6awkt6qs2arlru/l3SKGedJ4ku7s7A/g3Z6yFYF3SGLQz?=
 =?us-ascii?Q?fkYSqR420dmneFW2RY0jg4wavCopC47vxtHB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:47.9400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a213cb-c1a5-4e56-e7c9-08ddd644f909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
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

This is no invocation for amdgpu_userq_active().

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a78c2caeef41..3f8343599deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,22 +319,6 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	kfree(queue);
 }
 
-int
-amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
-{
-	struct amdgpu_usermode_queue *queue;
-	int queue_id;
-	int ret = 0;
-
-	mutex_lock(&uq_mgr->userq_mutex);
-	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
-		ret += queue->state == AMDGPU_USERQ_STATE_MAPPED;
-
-	mutex_unlock(&uq_mgr->userq_mutex);
-	return ret;
-}
-
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 30067f80eadf..cf35b6140a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -123,8 +123,6 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 			struct amdgpu_eviction_fence *ev_fence);
 
-int amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr);
-
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-- 
2.34.1

