Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A292C3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF7D10E92C;
	Thu, 18 Jul 2024 14:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u4VsSn0Z";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C2C010E92C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkyfVEBNktEIT+R/ysljW3nE1FZqGFdF0HfcYUZWwT+/7QSE+M/ThXRgZrMMCs+r3oVF1jgK1McKIZ3ky0XCQnF784w356HPWeyMfEtkX/VY3ix4XeEN/gWWd+t2djTXJDPRp50dLtBDYLh8z98LhGf/vIVT3dWitRKKkVozowl0I2E03WnCj+eYEhvqkGB8yFPWbBCO/sJ67loHkmJEIDwOWtEfb2EGwsz+gwsLEfzTb15S7+EtZRFg2YmCbtszYJZA3i4vv9PtknV76hpUNxekysYsVKyaqzmDVuAWjKo61Gi2rNMzQ4+X1Ln+XS+TpKbFZ/uUzoBPazzIu7J9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkV8EyWbz34oGQBJtiIi5oqQOFk4YNqzY8Lsi6upf58=;
 b=AIa0i6ZVfUot9CepIb320pH2pR7S2QP7/ax8cJkruEsBNd7A14ei3boXDgmBxsZGR7ZVc+ywJo6pJgzxsOVFDwh7pTq+VNIOf/V7ewcT607QZMUELCv9TxRldaJLpSjLKKo1LNJ2sn2an2wZeb0V4k2pcVgg6KQdV3VSMBWoK9RUg3b9OPKSul8VdTaEVhO4wuDWinVJsC8HGVOdagMYq/ZL0CDISfi+9xgp4r+4qcwIl+0w4nF7l/3prHpEDO1mq6+dTb5mqMFfooI6ec4FaRK/Wf8YAVY954t55Ur2ONLdz8XLSWGDInFtVk6KIOyMTRG/2gks+IRGe46jHWnSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkV8EyWbz34oGQBJtiIi5oqQOFk4YNqzY8Lsi6upf58=;
 b=u4VsSn0Z67ZZsVuc7D1Cj9hWdzicSKG4l2oYDfw7lrWrA3HepD4mi2Bg3f1EH/k92mc8Ov9JFma0l2XwKWu3GjbQZN9t6Iikh724DbN3n5y/LLARkoCIqHemiiXttZSWRg5Mf+mA9Sv22ztTkIPHZmrGkFqDjduZvoBc5yZiw/g=
Received: from BY3PR10CA0026.namprd10.prod.outlook.com (2603:10b6:a03:255::31)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 14:24:05 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::46) by BY3PR10CA0026.outlook.office365.com
 (2603:10b6:a03:255::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Thu, 18 Jul 2024 14:24:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:24:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/gfx12: per queue reset only on bare metal
Date: Thu, 18 Jul 2024 10:23:44 -0400
Message-ID: <20240718142344.1738604-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718142344.1738604-1-alexander.deucher@amd.com>
References: <20240718142344.1738604-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba718a4-1174-422b-285a-08dca735476e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/T4bQAbClBJJil8/F/bpPU3/+HpRsZk8ct37DXO1vy7fyOFq91/QPkra4j0C?=
 =?us-ascii?Q?fQDFr8Tc2FZsQsMsG6JeQKnya7sbY3wn8hXIE5V9Y7eOSBJdBHjLAEp0U152?=
 =?us-ascii?Q?cxPFaGDo8269/AYsN63cLycQmROHBAKU5/Yi0PDcrsTdF5XRbjkcuFk61jhN?=
 =?us-ascii?Q?AmS+8GzuQNvwLDBzYuOQMVySgXel2QEiDLz2ZIxJAlTqY1dmpSQRb08WHJFk?=
 =?us-ascii?Q?FNONq8t3V5/QbEqtNwl8g/Y9PMVZhIC0cH52DnUsu08SJE8YZoe3vdV3xKHD?=
 =?us-ascii?Q?9kIjn4+8xOruV66GldcJlMEXupRcl9Aqp4kGH/5GswM9qIkpjTa6muF4Fq+r?=
 =?us-ascii?Q?Vvl7a2y8Ck95sAsDuSUmTnf/Tkuv48/5co8u8skVwNn0HFflzB40fLrjisNP?=
 =?us-ascii?Q?oirawojDjGLvZznagu389xJYZfdkls5sHQY65u3ulvCwLI/6GYGSul+hGNQK?=
 =?us-ascii?Q?DmULDbc+xDFtTEtitma1huTna6ib+fyPUlxL01MqoarA9EBDuHMXSxl8yU3a?=
 =?us-ascii?Q?m3ORT01FyoAqnik1KfdjYYAfvZ10RSUbX+9PqgoaXgjiAtj5peb7Zu+RUoZj?=
 =?us-ascii?Q?Iu//oAPFAw7j3xhvEJRLFrQOpaIhfx152KUHk7CRucnEEDBdtY7czOyrOzXe?=
 =?us-ascii?Q?4q09lpJ9dJJA0Da8OGhKIcQSsuXsOPm+fUR/J4mvwkx++fO0yPuVJ9T3rt9h?=
 =?us-ascii?Q?gP+pfayAbJDEp//0e1jADzpuirPtft1LDN51PBCLMCMRPASgOJMsRYuRSEAk?=
 =?us-ascii?Q?UoPAXIcrsUxQXbTT402YAnO4TOFVQ/HUAghbFPtQvPR4DfSo9Qieb7tntbDW?=
 =?us-ascii?Q?4hnQvQ5PuWpV9IDr4j7ErddLxzd0ZrnqcbW7R2koXXbPAlk5HQ0zr/w7b2We?=
 =?us-ascii?Q?mRMFOOu6ecaTxL3JHdpY98vfCvJTNLvvYUjjHa04BySrFLgArHkqGPyFCTt+?=
 =?us-ascii?Q?+aZ73QhDunc0/J0d83vfnTgPlhAJWyY3YB3R3cLe3D9wg//izZj7yo+/b1LD?=
 =?us-ascii?Q?UT6uMIZxdkVpd7X+HfUXYbFuKOCYHSg2M7sILZ6Ui7kHEqdTNCMPqAB0s44m?=
 =?us-ascii?Q?pDCtRG8NWzOMAD2izI3uEP7R8CN6Xmtzsr5AA69jqGyoXWTnQ/Z1FQ3wiOWV?=
 =?us-ascii?Q?fT7Q/Mz3qEdmcGuabuaTW6+KLay0YQWn2DWa1s7kqOBzJ4+JBrah+uriDY7t?=
 =?us-ascii?Q?Ox03UOei8LvZBCuWVsjLseeGdWB65k25ubZkivU/2NYjgn/2JzI6NshYPtp5?=
 =?us-ascii?Q?irl2flQVqKiMKfxbmAZbPqUxJchEYZXRpwtfNjJNihXNEKUsSYTlWV74h4oV?=
 =?us-ascii?Q?f+Lm5omBzCdlgox3KqxDj9KhIXvz0uG/WR2fPG+AWzxwGqTak/N5+hkwI7jz?=
 =?us-ascii?Q?D+W8DxNJNYWJSXCZcGv+pteRY+ppD1eUcgV8Ul288v6tFA2hhbAEpC69JmRY?=
 =?us-ascii?Q?6SZWdyt6p91jFm5KNVbceE4UCaDt/UT+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:24:05.1712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba718a4-1174-422b-285a-08dca735476e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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

It's not supported under SR-IOV at the moment.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ba121491f5a7..4ee36a172471 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5140,6 +5140,9 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
 		dev_err(adev->dev, "reset via MES failed %d\n", r);
@@ -5177,6 +5180,9 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_device *adev = ring->adev;
 	int r, i;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	gfx_v12_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-- 
2.45.2

