Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F93D7236A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 10:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0801E10EA91;
	Fri, 23 Jan 2026 10:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yFuLjjV1";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D737710EA94
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 10:11:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xd2J0Fa+sDW4xBD68+s1oNRnL8Vy07fLC5mqbfT60goyTSPf+lNriwlxcAi28RxjytW+pv4xZBuoymLNrYpfDeG9/+H8mQn5Clkc3DqOsQom8fRHSVKdsJ3d9lewbNbfqHuvK6PG3pIqFP6iuOMd5uAcITTllQNu9oRth7jWYL9MekvvJ0XJW79R4oKEVZoJv4YZtuKybQ151Uts3QCyq7eugKtAVM1KmJymc1TpYP7BISzsE6aVXc3LiXXwQ+i39uBI3fPud0PNYrmlR6FnHhqTIUShEkB0VUmml1nRWC8x8OkQwijWVswq7OZLOS2oj5bF54Tg7Rjlg+DD4hRVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PyRbDXoJNzF6+ZFYtvtxgyCSz5KyMoGglrSrmtPf1I=;
 b=b8tYJ1XBIXLwnl+bvgHVpsLNwNq/wnL3LrtiXRcQDkhp63/yXbHct5Uc3i3AIj04+fItKyxGfgA0V3UH4rLEK0XI2RwU59cFwyGvrBpgfMD9SEzW+HJiiP8ahQGmjLoWSZIhWWJkstQefEKKEJo2K5fSiBvX9EBlFh8sOgjV4a6LdCoZiUsHNsMA0/fPnSsPtoV9lWWbhVhJflFzEjj9tL15cakGNA+CSbGgChdsa+trA5iOqmDcM6rKIU4KyxxBN/VbsogDWOV0B9vq9c3t+v6yboc25oteo4f4Byyidktmm8WwR8ihYkRvLeT1gSi3+KUXAkQ3vBdUi8ABKfRfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PyRbDXoJNzF6+ZFYtvtxgyCSz5KyMoGglrSrmtPf1I=;
 b=yFuLjjV1ek3BdxMF/Ds37pVELSnD5kmVxUoB/yYF6owAgCc7tJlpQWdLmkYt+b4drbkspJUjEszCOGhkUb/nAMgSzCCZs/ErmBbkruO98OV7dyV+BbNlQDVvf7LzDtKGBBGJHSsFWsKPdBAm5jdHWLWPVfNvikrnqKA6s1V7r88=
Received: from MN2PR14CA0030.namprd14.prod.outlook.com (2603:10b6:208:23e::35)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:11:07 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::ed) by MN2PR14CA0030.outlook.office365.com
 (2603:10b6:208:23e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Fri,
 23 Jan 2026 10:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:11:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 04:10:57 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 02:02:45 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 23 Jan 2026 02:02:39 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/7] drm/amdgpu/gfx11: add CU mask support for compute MQD
 initialization
Date: Fri, 23 Jan 2026 18:01:21 +0800
Message-ID: <20260123100219.1693990-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
References: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 6769c539-de25-42f1-3a71-08de5a67b93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YddzQ+AA9L1q6WLjPiru75enKt/Y0n0DxRpvN57rkhUc4FEa0x+aLitdV1We?=
 =?us-ascii?Q?PilWkLf6Y/nk/VklCl4McX8XjHZTE26HNtuUIGvMlVUgK2qtKIaf1c6xXmvb?=
 =?us-ascii?Q?GrH6GX52X1adab/nN88vD4fZ2uBsLbYAbm6djHX1YtFjcVrHUxUZpqb342/H?=
 =?us-ascii?Q?yvnq92MCAfhXcciB/q7UKwuejDy/NwR1s0djPL1YiMjR2r8M89L73BIyZwic?=
 =?us-ascii?Q?WCveIHlZMcpAypNSPNZwHAO9TQS/IQu3Ae7fVTyS290lWUHSc5VkVyH9mIGc?=
 =?us-ascii?Q?6j7emRMoQwGfp9SpgpmHwk3npohkVVQZb+Z4CqTIPOCkDTSCV/X/UCBNAV+B?=
 =?us-ascii?Q?PnQcIcyYr7BTLuvvGyzBg7jEOc6drPIqlfVsV2YBJ4/ysxnDIRJTzF4dIV39?=
 =?us-ascii?Q?5Sdglg7y0LdaLc4r37JY6Tg+SKYLyPQuA9JLUPr6wQQUSo2B/H14ClmfPHqy?=
 =?us-ascii?Q?m9D3NXk/8gYCjT8FC6E6OEM2BXdKPcUtwrF48pz6a2l2x/YYhiKJQf7rSFw3?=
 =?us-ascii?Q?amh6hqwNboypwoG5RTe5sTgSLg7xUImvIymJyKcJOjSvXRwtl2fBdNNb1KhJ?=
 =?us-ascii?Q?h+duNRiFKUiv5vsXEKBh6u/HjjQPrOnkxTSzGzOBgNnRM+pJlBpRw/EhyNJB?=
 =?us-ascii?Q?nUDP+EYPnRE2nB2Yag+ym+32A7o8nYh4VZ89f6gFsAnLE/ziRXSgWtvCTH+c?=
 =?us-ascii?Q?kGUSa/yc75Iz53Rt75889ZZfhhGdLOYMdwfhUza9eDeskBQXxh93l8u4ket1?=
 =?us-ascii?Q?eG7j6r/kHDVE0eMKkfMBOZZn2pe+4VrZw8v7KIxjpGuUKgM5SuHHmv7WZBGM?=
 =?us-ascii?Q?52arDHHydFTIQR0o7CffIChPlorqYOKaWPNlhuATVPMoR8PY3yw+2s2Then/?=
 =?us-ascii?Q?tP9pN9j/qcCB65HyqWxEBNvevv2DE3xsgABNNdWqIPalHCORrPvJ6jnYk9jm?=
 =?us-ascii?Q?4kyNDi3dXUopRaVqBQMM8aHr4Nj5jE7ShgPN7XVBhzMEztLxiQLCE8rUfSOT?=
 =?us-ascii?Q?MWZCVVnB2+I70tcW0Dl7Oh4ff1/nv+Up+0SplzRpN5lgI/eHaZXHHEHEgAa2?=
 =?us-ascii?Q?G2v/d+DyEh70NdlnAQ16USxofkTnh6oPfxRuNASlKmLh4nZohLkr+1h/4LvA?=
 =?us-ascii?Q?jw02AKRterOffwwv3K6AZffRuvDi4gxvha8Q0z5VnvAB8MJ8D7ijhgkaWoAY?=
 =?us-ascii?Q?hEuPg6Bx59Putf9x2T55OZ4l7I+7PJiToT3VPI28nBJRjsHEytnfNkWSwvoy?=
 =?us-ascii?Q?NTZn6/uTu5ODvK0tb0r1ukxVvY4WWxEGsCgzSubiTyxNvLcUywtPWy/0l3dM?=
 =?us-ascii?Q?SN5CJc8oib2f5sSZOMdn6szF5zrxlDq9lPb9oBSpIXWOFiEfjEv44MJar/Za?=
 =?us-ascii?Q?/UvKaiFtlzKPqhUOacDxSgU9mjSlQzx2nZLFOdjrHhQ0PZ0H3Z6tLqsSh869?=
 =?us-ascii?Q?Casy+VjpHempLXG7sK7v08XOXQ4UlQPfBUBZkxISF4snkenkU/d6pRkcYOV6?=
 =?us-ascii?Q?+FO0FXdFJ/EXZ0iMoHSwWVSsO9YmVsTF9d2LpWpJ91Wiz3t6JMBm0Nc/oVOQ?=
 =?us-ascii?Q?3x0FdNpWuRZSEngwvpzCmo9xgBzOXGg8kxMfe6hCgSKzaFsEonyeI+IQcrST?=
 =?us-ascii?Q?ATW9+4ecrjbPHJWiAMkNcsZf2AYr6DWbKpA7K7AIunrTWgBZaEfpUaJ6emBk?=
 =?us-ascii?Q?oTahHQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:11:06.8647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6769c539-de25-42f1-3a71-08de5a67b93b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
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

Extend the GFX11 compute MQD initialization to support
Compute Unit (CU) masking for fine-grained resource allocation.
This allows compute queues to be limited to specific CUs for
performance isolation and debugging purposes.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3a4ca104b161..55d98b1a9ac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4238,6 +4238,37 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	return gfx_v11_0_cp_gfx_start(adev);
 }
 
+static void gfx_v11_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev,
+					      struct v11_compute_mqd *mqd,
+					      struct amdgpu_mqd_prop *prop)
+{
+	uint32_t se_mask[8] = {0};
+	uint32_t wa_mask;
+	bool has_wa_flag = prop->cu_flags & (AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE |
+					  AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE);
+
+	if (!has_wa_flag && (!prop->cu_mask || !prop->cu_mask_count))
+		return;
+
+	if (has_wa_flag) {
+		wa_mask = (prop->cu_flags & AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE) ?
+			  0xffff : 0xffffffff;
+		mqd->compute_static_thread_mgmt_se0 = wa_mask;
+		mqd->compute_static_thread_mgmt_se1 = wa_mask;
+		mqd->compute_static_thread_mgmt_se2 = wa_mask;
+		mqd->compute_static_thread_mgmt_se3 = wa_mask;
+		return;
+	}
+
+	amdgpu_gfx_mqd_symmetrically_map_cu_mask(adev, prop->cu_mask,
+						prop->cu_mask_count, se_mask);
+
+	mqd->compute_static_thread_mgmt_se0 = se_mask[0];
+	mqd->compute_static_thread_mgmt_se1 = se_mask[1];
+	mqd->compute_static_thread_mgmt_se2 = se_mask[2];
+	mqd->compute_static_thread_mgmt_se3 = se_mask[3];
+}
+
 static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 				      struct amdgpu_mqd_prop *prop)
 {
@@ -4372,6 +4403,8 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set UQ fenceaddress */
 	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
 	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
+	/* set CU mask */
+	gfx_v11_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 
 	return 0;
 }
-- 
2.49.0

