Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E6CD25926
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 10:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D9910E652;
	Wed, 28 Jan 2026 10:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mBwbhb2g";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B04810E652
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 10:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1VcwwC8sqt3Jv/9OtFGmVsK6JmF/x6SHKhPBPaRp4YvVtvb4N+M3dTLXSL4apEEsxs7WdPh9C+YPU/PIgALWU1WWNit8N6yoYnrsPE3czimatsyZzFLGsf1I/NDlUPK/JzpE5grcx96SvrjmkvXtTD4NXTdc8qAWZLrj5MRyTGhNbz3KIxEm9upvIvxDX5Kq75xX+r3glVgjAueu37uZDzn2Y3QWsITIQD9VoAwOfqFjZG+dSpqD/Vzzx6zVLL5oqsE6W5o4d6N+agswHjBwCFBOovORDvb3zBGKZkj0Aa6pyVP3qUCLz5A8uh6c3TwxO4tdvOedv8JaGAdvkSfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxjtWHMYLsbLy72vGz6tCpWgVwupDqcGAYcBUeB0tQ4=;
 b=FU81RYE0vgMy0YItHt63Z9sSd6eB8LThnXx4DikQlVoWvacQ0BBCkgC0Bubp8niEu+19eSrM1hbeymCuUEGgtXioTrLEu2delF/PhetJPfz+KhgpwaCm86OKmXCUuCGVH75umTipnBdRc89ObarQo9DWb8lJys1Xl65bfLDGylpqep06MNUJFg/KwvuJXd2FP1Wa5sTH5sYYtTB9UNyg3YJc6HKC8h8KevmWnnYpFl7P7YwPWmcg0R+RIYb5RyKMbmWkvgrITR0KpdwOKvQ2sz4SUrariznYATzdfrEe03XLBPv++YFgtE3Pv9LwF7X8nUeAGMRRf0i3JQjvcj7Y4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxjtWHMYLsbLy72vGz6tCpWgVwupDqcGAYcBUeB0tQ4=;
 b=mBwbhb2gFF44bYxWS1rKBGn+3yQT2xd9QaCZw72Ae/feqe+ZBL/M9uPuAB4jENuj8ncj5nold87fO58nepNR+1SdifYZ7orsYR06qU9uQCcZRBnYtmwxxO6XAAfFH4lyP+S+w1YRJkeqSv5nnVyBN/r3oigE1uLv5ncuIvhUfAY=
Received: from BN1PR14CA0020.namprd14.prod.outlook.com (2603:10b6:408:e3::25)
 by PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 10:59:25 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:e3:cafe::d4) by BN1PR14CA0020.outlook.office365.com
 (2603:10b6:408:e3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 10:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 10:59:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 28 Jan
 2026 04:59:24 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Jan
 2026 04:59:23 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 28 Jan 2026 02:59:12 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v4 3/6] drm/amdgpu/gfx11: add CU mask support for compute MQD
 initialization
Date: Wed, 28 Jan 2026 18:58:26 +0800
Message-ID: <20260128105847.2898288-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
References: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff3fa18-be6d-49af-54e7-08de5e5c4c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YyvZYa0Fgzq5rgJHhXVH8favJ3RhN+dcuYAVwYMvkmkIp+JqbmI7CKoItlOQ?=
 =?us-ascii?Q?fi+CWwu9EIYMZdxNp4zNtkJ/+nYip66MY9aIDEFmGsTmVLSFkjNSVJPZd4aM?=
 =?us-ascii?Q?DlfmoTcasamM0HoPktYabfxtZsN3VyI9GAwg7yZ5T8CWKUDCilGFRyX/9AKG?=
 =?us-ascii?Q?gmXFQOPxPywhuqqn984S+eZexmzK8bTtJjdBMQ8yeGYqD8gbdFwaQx8X+fP9?=
 =?us-ascii?Q?LUckpQY1o8AImcoQ5UY2tf1uGfkbfL00ecTXHmTgYoJaMDyFf8VXkxMOcIi/?=
 =?us-ascii?Q?Ke7/rWBdHnw7kvueuvFnwZ0LvagyRXTL5fCYU68yHpSOq1tu1iXogbBEo0XU?=
 =?us-ascii?Q?zEoig97KVmVirrSYz75/2Lv0qJCQqNIPn9WKY6L6E43JPaoMOaajG6xX7aB7?=
 =?us-ascii?Q?kRNDxN6csHnms2Qq08BRlFXBMpncFcD0w1u2Fx///fUfysrrgle/8v7S16Og?=
 =?us-ascii?Q?Cx1rL82zMJeCFMJ+Z9aRInQrrvph/ug/fANQBGet/WoyZMV3+H5VBT7oLuom?=
 =?us-ascii?Q?CjNOyxv7aUt99Bb7QiQWRRye+0uD/nfAWZkbkWobXRSojqyIxEwQ/UlxCH9A?=
 =?us-ascii?Q?V7mw0O0+eh8G8lJovq9mW7kQsmaTwV4yRAD0d7t95abt7QpiZE9cEYqtj+fx?=
 =?us-ascii?Q?pOxIWPN+OyZkF/pOzZsCeWHUVjcE8Pv6MgkLBodlEW+vK7bQkS9ZL0kaJuLB?=
 =?us-ascii?Q?EVqe3rnswFcDX0wgRLQRCRANdev0D2VkQ1jFccNSyv6Rt1z+lVToh5yL9mIY?=
 =?us-ascii?Q?PrtnNhqqtaoxoXqnrqr2kuq07z7nN6u5kIi3aBd/5dYiEKTj7AzdSr2d0gxN?=
 =?us-ascii?Q?8LIXvEnDJZ6bsBew0BJ0KtUf1M0/+kQFKZElORTRKmiK1MWsGXaBaHPI1OLw?=
 =?us-ascii?Q?7jwBS4S7ZWHrfhW36HhRL0+FTrZT1VNmtClcRTvkKoPWRcfgpd0LffJivM1c?=
 =?us-ascii?Q?WTsGNL1D7jxM3FIC0BpOokIQFTuygK0USGcoCS9sxHrZKpqhXvTp0Y6psac6?=
 =?us-ascii?Q?mXourwHAqd6jh9ZV/3tP58tyG6BCnQcdrh4sRZP/2pjZz/G4Zv/dwfU4z6EC?=
 =?us-ascii?Q?dZWqbMPMLSD1la4Ie8Mq1V/e9oeQUQ31venzfOyOPOphXF+B7Uj4nOoSPaFe?=
 =?us-ascii?Q?N0vpJmh2lVsK6LqTvRi8D6v7NaRT8ZTb1Ycht9kHBItNUnjaM1YdGVOR2pev?=
 =?us-ascii?Q?dhonmirhFJ7usKKJbxTSV9gdAj6OPEHUb6Czf6c+jq8nvW5Q0TymkQWMzhUy?=
 =?us-ascii?Q?E/65h8Bc2j0q2+CA/n4zzPgNLyxhULqCcM9OGklZpvlJJys5S/WfAcrcZPOg?=
 =?us-ascii?Q?dlGfaGkemXiP4UZsQwQGJuCwjzGQFfrKCuBC7oGb8CPt2hNIpBcaZWwXQfVy?=
 =?us-ascii?Q?sJZZ4wEEWqDJi+v/7rT6UDQP8rSBwpBMEjpojS58MIrAWSGPnsU8A7HoGJf+?=
 =?us-ascii?Q?rLWF+Sly6nAWFXfGR0kGLd/IzidTNN0rcddZ0jwdFuANPd2dS5Z8JdO+zZs/?=
 =?us-ascii?Q?zEryT8S0HCUVeSXBsiSYbzzqD2iLQCwreW5jgk5LMosSzmfu9fGfQKzMshLa?=
 =?us-ascii?Q?wnDHlVaq+z9bKz3ovqAVAVRb1ZolKHBJZog/Bx3MCNmVDUedfFE00h0luxdt?=
 =?us-ascii?Q?gPH5ylhaln96q0yMqELtbdHJSDAj7MIa74DYLBpy7cbrlfFseIacMZD0ALqA?=
 =?us-ascii?Q?fmmpSw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:59:24.5916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff3fa18-be6d-49af-54e7-08de5e5c4c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

