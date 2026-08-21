Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C252FC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E9710F4FE;
	Fri, 21 Aug 2026 19:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xLbDde9R";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9225C10F4FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bemUgWL5wu2HUYa75dBpjna1AUdiCBTeDPyoNHSf3JQUZPDcjaeULp2P6U+KzHfUc+zaDw9FbM+MzBSvZuBnnTOp+98on6nk8kuWoynGqIc7fRCEUbAZNEo9ZySgOPQ1sYlyvUld1wp01NtpG6KDq7UbvqaSNvmiI+n1G74A44TC9lHDUO/6zwrbmWpQPZgvHOWEri/NiWO/QLjbbjcR+QVKuh9Nca5S8wpNWnDGpD1xLGfal9T35Hk6dbUnuq46kqBBNW26g6ZYPToCS8rpZ1lxpqEKDWgMxxsDk8qJwR+NpM+LTqYumnm7mPmyS5tUJeA4e56qNKNVhfb0EyiekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtIiEreYZ6AB0xuXnsf+4ICI9TPSMeduBLfl+K03Hfw=;
 b=Tzs63+7fwQtkrLIEzy1UUe65EX7y0cYjjJXVCZHPF0EJn2zb5HV7LYjB+lYmHF2rLwZLJWfa4za6bnUcnRCQHvCGhn7Pa3TaAuA+9ycEKYZJDRtPXEyXG4l8N9lqStj2VvJplmiKwUCZZeneO3tV87M3a6dMSaOx5uq01EpFaVsdK05IAm0zrKVt+x155yYKF7AmpFGQaORkBzTtJaK7f7+4w5usW4H5FrtY006lfNHiuWgGeGUvmHocBfa9RDpMfm//4tj7O/6KiDdwFw80DjMNBrfbyEXEnX3qvxFGSEG6Isa7FKhD5h7Ny2M6wpB7syThENcEdCk3KtSr8a4jiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtIiEreYZ6AB0xuXnsf+4ICI9TPSMeduBLfl+K03Hfw=;
 b=xLbDde9RPCQy6XVOmTxIwNjgaQRrnj6ovm1nybIvVtI7QEN0XPvRI+BNYIc6jFJ3R+BtPFm/WIN40F5dHgoAzhDzPMvgQ9+A05BDYcBxHT0oAzC0Sk6yT7mB1LoBa582eI9K1olqv9AILLf1FGHestal5dHocYKAKD5oimRqQv8=
Received: from SJ0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:a03:39f::29)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:42 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::7d) by SJ0PR03CA0234.outlook.office365.com
 (2603:10b6:a03:39f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 35/95] drm/amdgpu: Add UALink SDMA scheduler entities
Date: Fri, 21 Aug 2026 15:33:58 -0400
Message-ID: <20260821193458.808626-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8cf1ef-560d-47e2-ed6e-08deffbb6300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: C/qE5Nni5NP1+hGQ++8qmqp6RijGZ6AI3syiqvbMM3GedD+VaFL5sC8X1ej5wnimAFhjsPHNw1FHmtc2JnIHbeSVsMOJmLELho86ZBTfWao0GtRJR6HhvD75wIHu6B1DVZrN/P/8DtvQO8O2dd3hBlKbvtSRo8UIdqP7MlWvHG7bMy6NkrGQR0xo9tVO23PTWw/6ffEftEVCIZ2adWY2mhWdED/wo4r6a78CUghV5PfVc4sDaPPquM7e//bmkMYF6th6kNqhRXgAzLcBkwbMUD9AJ6b7X2rqrdwHuuSjOdyHa2SqoYyvkgYCfdSxKPgR1P5v2DkM3syHukFm8L8kaVygNPDDmWpBKTIBEFOZxL0sTJGYkj108XN4hvfkE5rE4OPfRv+RA+mLxzM4P10c0l5iEjXPjt4tYfarx1u/+wk0IMG5iAYM456d95nEfSYEiU7sDZte5MAO4KTKFcpIXCXFw0OlRRdnJ1gDlmJZHlqAdb6conboDWVDQyoC6nxLvXoD/b53GxhLNK3pyWFTvMSq5bD/lE/E3219sG5aGZacJL3C5UFdux9Rg+3DwLNKAOW3zXyMLnUWNRTqY2RfYX6KTz3dxHNyEohsbYYe+EkNrYWqW+qTL9sNlohs2HeEwHdkUc8XhXrJIRsj+7QOZskw69AGXWF2FJx+/F31tMT022NfK/4NZvppdVAUF2cjxMMGHoUDyoT24aeE8t85lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gxy3EQuzR8vQ114Iq/jB0iazyRoy/L/Hy8vV0yM6SiFSIByd0MU2okS/cVlTdlZ47BG8lOHbm2Zh2upLIzx5GvJxxypOL3UaBZm5YeTJU7hqfEc4Lw6oOpC4PY1a8LmyLYcwTPGiS6MeESwXjn0faSpS0D4MtixUV2u1WjKgKZQGfjjU/GF8MTIEHjEdTMkauziW0qrcmHflxLhjQ2ybxGfYJQz8fltixghGs9BMoP2MmAzY5xDHGLMrPUPXBwRAg1ACiVm/P0ePZ8pAnRC4x3pZQ9ThaJb3xMekzXZr7gu1cfduq/dx6efsTS9wl71iubp2V8UEAZi7Ri5SMg53i7WUJDaRECvEdkM9BZ0taSjHsUG1+pBAd3qPOpKpzZYPBhgkpobldw75K+dNpKKUuoSQLiu1EWZ5M/T6gr2g0gwBVY3P+aLGPAOFvM3I8p+T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:41.7148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8cf1ef-560d-47e2-ed6e-08deffbb6300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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

From: Philip Yang <Philip.Yang@amd.com>

Allocate one GPU scheduler entity per SDMA instance for remote command
dispatch. Commands to the same peer are serialized through one entity;
different peers can be targeted concurrently by different SDMA engines.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 191b45a51024a..abbb24330c0af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1962,3 +1962,56 @@ static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 	return r;
 }
 
+/**
+ * amdgpu_ualink_sdma_entities_init - Initialize SDMA job scheduler entities
+ * @adev: amdgpu device pointer
+ *
+ * Sets up SDMA job scheduler entities for remote interrupt and shootdown.
+ * Each entity uses one SDMA scheduler/ring.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amdgpu_ualink_sdma_entities_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct drm_gpu_scheduler *sched;
+	u32 accel_id;
+	int i = 0, r;
+
+	dev_dbg(adev->dev, "enter\n");
+
+	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+		sched = &adev->sdma.instance[accel_id % adev->sdma.num_instances].ring.sched;
+
+		r = drm_sched_entity_init(&remote->peer[accel_id].entity, DRM_SCHED_PRIORITY_HIGH,
+					  &sched, 1, NULL);
+		if (r)
+			goto out_free;
+		i++;
+	}
+
+	dev_dbg(adev->dev, "exit\n");
+	return 0;
+
+out_free:
+	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+		if (i--)
+			drm_sched_entity_destroy(&remote->peer[accel_id].entity);
+		else
+			break;
+	}
+
+	return r;
+}
+
+static void amdgpu_ualink_sdma_entities_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	u32 accel_id;
+
+	dev_dbg(adev->dev, "enter\n");
+	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX)
+		drm_sched_entity_destroy(&remote->peer[accel_id].entity);
+	dev_dbg(adev->dev, "exit\n");
+}
+
-- 
2.55.0

