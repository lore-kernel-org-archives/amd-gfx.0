Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61B606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fNHp2Mfy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F256110E03B;
	Wed, 21 Oct 2026 13:16:14 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9AE110F9B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 13:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spJjAFOOQ8W+Qby5D2QmK3mwbOugB6Zn0EAXfkX1VIGymRLejwc7yzjNzE8g/sVCQ/uJfpGPFv6Gw6uDfmjSyY1a7gGYq49H5KLGua9799JhqFmq40FgsP6Mt5F9eUle6c6yDA8b59bcUaIu8VfHgNR+nIIKfmWCTNM+fDndiqTQUg5RHR7fyFiG1aM1zhVAuoSCSQfeT8hfjTgbCtXPoN1Gm7SnwSneisT8RqQ3NwO+krvOOvSDyZ9VEKLhMwOwLRdSwl/XFXt/OgG5Q8/aT9/koJDDTS05Pm8aCmik/xvsMpbrCCx6bS76dLltPygZ2kHAwF8L56gEBtozc9YzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKeseuMz2Fy8Z4OYgD9CzH7/7yc7Hmtd+BfFPNdlAPA=;
 b=pZh9HVXz3qdEJ5/3+TU3gjRdfkTCt6Ub5Dv8wQad59+z7x/CtW5tKu7yMphRc1yWrHh51DZ4hAtmDz3S9mllBj0loDDptYnQBGCMWdQeFcs8aKTCcmdpNWVqHvJKPuSKrS+6isOX//9bPHeKUVgsGK3Q4oce8mEBf+3FGxzcScMsMbkpNtS4brUOYmWDzres6FzBdpw4rJaWT6TUgpYcBdi+kji+xppVubJeTXCxBK1uKEP1ZcY1pcH+d1T7fsn0LnOI1W8N8F5VNlls6QTiYk3gNY4hVdJJpsqGyzzXx58C5PEmPxBv8Yf2VyjLwAwYttlDDlHZ2M8gUCQwz26WVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKeseuMz2Fy8Z4OYgD9CzH7/7yc7Hmtd+BfFPNdlAPA=;
 b=fNHp2Mfy/HmBcViUZ6k1pmJ3flxTX4xW0T84lFA1YcUpq8c48CCpGLv073aBKx8CtHbyxvSqZgMPkcvirjHK2TfiqPkOyLrtLc7mpFILVeq2LHBebj8Wu6iBiz42ImhbI8E2oNJZ5GZWHD79PZRYqxCi4X6o7YUyrT+QnNaFlbI=
Received: from BN9PR03CA0482.namprd03.prod.outlook.com (2603:10b6:408:130::7)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 13:15:59 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::49) by BN9PR03CA0482.outlook.office365.com
 (2603:10b6:408:130::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 13:15:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:15:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:15:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:15:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 08:15:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/8] drm/amdgpu/gfx10: rework kernel queue priority handling
Date: Wed, 21 Oct 2026 09:15:41 -0400
Message-ID: <20261021131545.1962601-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021131545.1962601-1-alexander.deucher@amd.com>
References: <20261021131545.1962601-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eaae76a-294d-4fc9-ab9e-08df2f7572b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|261009223027099003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: LWQRMCw/ZviKCLrUBieZ3VXPllHeJWkV32vYmshV8Ze3oGF0YjeEcDnI9KqFd2W3ij6MZYwIhw2dGbmGxMdKWXD6fW6+CmsqQr2YY/DiLLIxjtDhBpE5rnZ9+n19PJQrIAWKf6mUpHUr4FEp0xtobx2zhtCNiDiOiweP7yhy8Rp5CQ1PnvK3F+oUldsq5hjzkF/B4MZFDwcpY5yzZLbUfhMgeAI6aBgVDkCRnNSVn9OgGLZCCNtah76lUUUpo7uSTMfMc8/3NFwDvM6QuDvQRza72yZZ0SCGMqowbqOgMW7OKpI8/fHBYe1hDm3/OIY8jNeb/aEjjt8xpZ01ogRRqWkQHeI4evhXub/o2WmtVh87yTbAzIJh/lSuE8XDkQTZPYgnCCa72v5mOGG0QBCn4SC83zgmaIsmCnihDqWqshVTYufBWg1JBMQ7kVh0GqyM2kFDuymqkMOIea+dG25toux0NBdktwD1Zh7RbCQCW57wXfR5H4/M25IBmSigGNN9tKMatHz/T6bLwskdLkyLUD0fbAJlLDgoFVxHweP+TDn9M5eY4oM5ERseMBy1u1mFOlGAGUhiA+mZqu8vk0IY2tLiVRfyM48W4Qb0D3222R45upSJk6NQbjult8CA6LRYlhNSmwAcGkywujjssjJ9U5qNDsC+R+0INkf9TH840FMuSQWHN0Wiz4kxZhRWCzJ9BMjNVg1RThuibJS8pI47Ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nH/fEfDmtK9NNN8CxjjDJs6eZr9XHXk60GUoi28Bz15oqg7/+y2UKiVM9v8Xcku4w1bOWtCcG/kwogGltHUyZLwm9I9z88L8nj5Vho1v7NQChyiMgttsRKXmtr5dcjyEbgyZ+OCtw8oXG67hwTdSfYRBZFGsV9m6dfq2r6LEW4555ryvuYoIEB/QKMZtOmkrcbr+Qdfk8tKKPSMUFffdhHQXRG8loLA9qGCjsVS/BhBG7X/4sVI6DgecIsTwasL6lt5ux93TXJApZaybVNSR059XvF5n1vBWATkJ4xkkNwEmAHvfdei+XtWuxt91GLKoX6L7JmZO9RXvpnpm3WPZvWYeNRFgK1A2Cwf8PBeT7V8kmfKT3o/goYt3auTzmQsSZaqtjGW+W5duspIL5lQLltEvxJROaruH7cBhgFNvBTA4cAa64QEkR281a384WGCa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:15:59.1553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eaae76a-294d-4fc9-ab9e-08df2f7572b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
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

Rather than setting a higher queue priority which could
starve a lower priority queue, enable longer quantums
for high priority kernel queues. This will avoid
starvation, but provide longer runtime for high priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b6f61f4a08e5a..74b68b6048c89 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6800,6 +6800,12 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set up time quantum */
 	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUANTUM);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
+	/* increase the duration of a high priority kernel queue */
+	if (prop->kernel_queue &&
+	    (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH))
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_DURATION, 20);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_DURATION, 10);
 	mqd->cp_gfx_hqd_quantum = tmp;
 
 	/* set up gfx hqd base. this is similar as CP_RB_BASE */
@@ -7019,7 +7025,12 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	/* increase the duration of a high priority kernel queue */
+	if (prop->kernel_queue &&
+	    (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH))
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 2);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
 	mqd->cp_hqd_quantum = tmp;
 
 	/* set static priority for a compute queue/ring */
-- 
2.56.0

