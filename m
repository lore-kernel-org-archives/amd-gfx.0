Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BB6C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 05:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4952C10ED8E;
	Wed,  1 Jul 2026 05:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SVPLL7v2";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 523C510E31C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 05:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unsJpWSl2CtpfDZ5Ip1yd6DYmu+TF+xioEGAwndO48yS8YCaespxsjhJxoJcP8He+eUVELzi7519U/u8gyIovZbNNBKiqXyIYvYG6ux+KGB0TovwnFd/KgOmTBc44GKgx7ewI/u3CQKX/etWHLfUg3HHcWWmABxQUH6H19tU3c82iEmAMUq6H+9lbbBO5lkP5mQYMesiiJMqqJSEDwvIjGDIK42Vzx6EZvEsuyjZ26aLRYxk+1wRnKwXX/a2bzMcjNEcmrN3fMIQI0RxM6UEACWcQ+2WC2fu8YmfYfwEA+fxWeb5wNUMcO/KPQ0HGa1Dz5AVm+agrfFe6PtZtcqGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz4AtfzGtMWyaeFYfZSwhUOBUvxrFP5c0vaPww6I4X0=;
 b=jbG2rIOhRiXMd+JFdllOESMBFriLHIQgPQb8fl27Zu5AGa+UY0lQgCS+8OLrt+sq2hDvDwgO/B//plWNBtNUfDgS+VgIdOZ+2EQq9gVYOJ/GbARuXlP5LW9qWB12wdxsezhVDjhltiFklfbYP0UVjD7Iqj399Tlpepfh9ENkFlvBGJBSArFwfjGYV+HOxuEVpyTv/e5U7FTvAX9Zp/iYzQ7mdRqSxROUVn0/MV7JojGk0ol5bjz1TZCQ5LX+Tpm0YxI9Ha6h/LHY+dJHKJsdXbLgziv2e1LrmxZK2eS2ExjPvdJJ4RwiGq21s4LFCrxxzBQUPwtSK41NXJOGfYabhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz4AtfzGtMWyaeFYfZSwhUOBUvxrFP5c0vaPww6I4X0=;
 b=SVPLL7v2er9Skz23yV+GnJ9T+BIR7obLe5+FhBdNLrIZWdF+6JGkldGw3WA2hr3tRA+GMRsKaY6JLZNvnlrFtD4syRzoEnuNSKzm8WbaIYPRot6Ik28iMI4zl8cwAnITbKwuBxdF1HTFucoIGG+E5f1mLjDtJ8K+32cONhgCh1g=
Received: from BY1P220CA0049.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::15)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 05:54:14 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::38) by BY1P220CA0049.outlook.office365.com
 (2603:10b6:a03:59e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 05:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 05:54:14 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 00:54:12 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, <Emily.Deng@amd.com>, chong li <chongli2@amd.com>, 
 Cursor <cursoragent@cursor.com>
Subject: [PATCH 2/2] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
Date: Wed, 1 Jul 2026 13:53:55 +0800
Message-ID: <20260701055355.20478-2-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260701055355.20478-1-chongli2@amd.com>
References: <20260701055355.20478-1-chongli2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: a20dc8df-b464-4ee3-d09e-08ded7352e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: bSxmZrnMlDYs+YVjb0zrOUV/EAqQgPh437fqDQQ3ZBdPoCj9n1/xMNnEud4rKDXp/XHoQozeM7xl098mH+fBpN+qiMqIdegvqLK3hFZc3L69zfVRbX6J2ReDCNgLnb9i6Fo7f3YcxSTU9L+jKttsPcVXNRy4P6yCF+kdMODsSKfjsh1gPh2nJa7s9BdZh+/pHeOxjR80uIwRfsQ8MDUms4gXV6so7vtnceF017hxuU6vopevk2p+4AUUKYFo6Vpk7kVbREtZzFUvB3uPBzDfMqbZ4baLXyA00BtiT9fZse2ybETCSg9hsjlblTVWv2/8+h75bSzc+M4Kxj9Mt0/pH4EgcQsLzYUneQzfVAwHsFwfF3IgXi1NVXoXLfYcadpLWfRUF3gG2C7KVr3rEHVeAejFSQZDpcAOuz90t0jUQNg/jVCUk7t1YUQpAJWk9w5SDUaGoXaw/esVgniBb1/qAxc0uxs2bFXFU3rTOp2sXddrqKG443IrVReCd0pQigvBdZw0P+h0lOsJqFheVMA5AKWd9OysHCkb2oRItdlYoJpRUylikVozgYXdlCIhJBEHLVo0602qwHjHz1FJ/z3n1iVNjl7+Pq/9l2V/+IgO5U5IEOgkhO7BSaBZmctNwQR/n6Lynu6Imfl/e/UqBx/77RIgKX0YUbXzkWsHpUzkxCo8Ds//6/EWc/bLog9/zJb02lAFpOlDWg9e8czh1GXcSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IZkgV6KRQcS3H4XITrvjmle4/+kWsAUxkIhyzJX8irQv5i8KokrRULby30XmbXBc+uVNG/b7+MCB3OvABNExsLvBL79bESIHmBdZ0Gd8ldkM+LrnrQNAlFkI7HRe3Fr8AryK308/I5e+KknPrn7rpuuK9M6p6on7ruCs+63R/wyi3bQ/QpkLsWTjFs5WtviMQS/kt6IQH3Her7n5TwAnxmFZUknsEJU2pRSCIzKzd8JjIaZ5H2Dbhf7ZtnoS1WwDRYjAg0mTre3x0CqlYTtqYzfFjQ/6Oq33Fwk8yHgWdlYeEqCq5plMgd6beX7XM5SU1Djf2dpWsWIozqgZSZimkvxy52uKgSGFmuXk0KooKPKE4VM5RUKMJai8D/n2WKiQnetxjTFm43Pps4jemeF5DiM36K/X12yDgk7Q1PD4S+mzceSO3lbxY81ZKzvdqJfm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 05:54:14.3576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20dc8df-b464-4ee3-d09e-08ded7352e66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
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

Move the initialization of non-GPU resources
out of the full GPU access region during AMDGPU device initialization

Signed-off-by: chong li <chongli2@amd.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 610d82b79de3..c2ce4659ddc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1994,10 +1994,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	amdgpu_device_enable_virtual_display(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-		r = amdgpu_virt_request_full_gpu(adev, true);
-		if (r)
-			return r;
-
 		r = amdgpu_virt_init_critical_region(adev);
 		if (r)
 			return r;
@@ -2159,6 +2155,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (!total)
 		return -ENODEV;
 
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_virt_request_full_gpu(adev, true);
+		if (r)
+			return r;
+	}
+
 	if (adev->gmc.xgmi.supported)
 		amdgpu_xgmi_early_init(adev);
 
-- 
2.48.1

