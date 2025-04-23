Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3F6C369D1
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 13:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F190B10E69A;
	Wed, 23 Apr 2025 13:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ac2jqzJU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 373CF10E69A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 13:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9MXc9p89B67jnEhRO/AUbDKnDt63SPqioMeXtlg0L3Fy7tmh0CMndda8n9RPpvU/6nBa4XkaUpdmZPbp1lusbUGhPholBiEc7A//Di7csSdJd8tht+PX1sX/ZVeqH9EqTr4JKotyDzIgt450O5EJN8xN2b6+a+G5S+9qgVS7WiLnZBQq8P2a68GOBzmT3F1dzu6QUVkyXABasmVK/xy0sDlzJccMnmo5vj6crnHsPJsAfxT++IaLfkBrDCutofB1rI37W+X343wzn9IOxJBEHouh9CxVvn02UsNflhgjQegSuwi5NF6JSJw0KuG4ojymf4Xkh/Wmi5CZUekE6twMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8jf38V0gJZGA4MSOXRRE+Fw4kT2yQJMLAPh5Bx9mqg=;
 b=bFFbniV8NvzS/58PkczEKHRYVruLh6IyVkeznhSowOB3+2ch2c1mVZ+QspZjcg2uycpIWpN0JFugIrMUsrz4crZdlUnPsSgEFZ0UAFqLYbbSXutZFat6wnLnodrEfVNekP1MHId8/FvX8f3XEOHq9X1zvW6PjFUYmxLBV3iDwKMI9JIOWAKSp9cDjiyCg/E5KReiQ2YChialp1wUukuNuijIiHOkcOlOA9/3E4vJ3fuHL8d1CHZBkolMfphyUgkyDXIybIxMC+tFnq6A9wyCzK3H7We4iHPTMm21VOnjqzwGOGCFDRv35/obNlicOgj/uLmU5TeDFcsWKlGDkPflCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8jf38V0gJZGA4MSOXRRE+Fw4kT2yQJMLAPh5Bx9mqg=;
 b=ac2jqzJUnS/ewpIoWCewOe6ioYmxvhgat9cYiO6+BAVSsnSSxYe3US+FBiEGKch50UxTkDqdgycnnlk/HsMy1QE1fOZ69TW2HlC5PmeYHi8X32AcRY6E371qldyNIFGE1ldwHevcMfEt1SJJrWk5B206RsmFQBdkYz0xiSdbqbU=
Received: from BN9PR03CA0253.namprd03.prod.outlook.com (2603:10b6:408:ff::18)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.38; Wed, 23 Apr
 2025 13:26:16 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::5a) by BN9PR03CA0253.outlook.office365.com
 (2603:10b6:408:ff::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 13:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 13:26:15 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 08:26:13 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: implicitly sync the dependent read fences
Date: Wed, 23 Apr 2025 21:26:03 +0800
Message-ID: <20250423132604.4002242-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d32b8d5-f4dd-443a-89a7-08dd826a6c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M3Su/7M4K9OqnxC+fMVbyYPYWV+FPateNLdx7zRbSaYkJCFJ9TUACFL2gZZU?=
 =?us-ascii?Q?xaR/aNUWW677RPKye4yvYV2I4C8Cbm/PkY0IGgPwc6s8e4fTluKrJQq4g4Ho?=
 =?us-ascii?Q?Vf6Kf7VRRUhmK+FeuGzZ03Eidgz2WtoIs+vaJCrrHiTUDb+BCk1+nK8ZhBue?=
 =?us-ascii?Q?ob7yWgHuAeT8t3W3phKP74OovB+xrhyZp7itBq15INyXELzGurm5x3MzLria?=
 =?us-ascii?Q?cHbEIIKWXIlG7Qxmq910zvjbjMqmtzao/xaZ64YM8Lj2Su+vaiXXuXhJqKRa?=
 =?us-ascii?Q?8c290bUyywz8CMVWSZzuJ2fBqC8XYYF48CkDIhGjvvJipr+rHPqmE+78e/Wn?=
 =?us-ascii?Q?AGUIgHq2FJRSUnSQsA++EurOWzN7Eh0XnkAuu0c+Fp1nslAzsgV7NyA0dUX1?=
 =?us-ascii?Q?RXeFEP4cDpUY7vVS0GFt/2OcWDpixW3Rnfre4dvC8j0yDJ6wWFkgHZuLNrFp?=
 =?us-ascii?Q?0TZmyNfezf3YXRKb+e1Am4h/O34/OQ7Z3FQ+rJh4eHDFHVvJDLoJGImpiSvG?=
 =?us-ascii?Q?T/FdrAjP9NJDm3opIqy0Y5ZCFgwHio+QiFibXsDfj4oAbN/l/3QLcOkXosfB?=
 =?us-ascii?Q?GY8Pjcv+1jDqhq80zjf7pbXYKOYR+FbaJeboEU6/zM6imQifqqPPDV4i4Ee+?=
 =?us-ascii?Q?KPLZSBt0WtehQ9ilhgwdcNfOa7KUucVSgFdkBcmNKhdCO8aXLXlPzLLy53ey?=
 =?us-ascii?Q?1a55Mck3E0lW3LN/5OiPg6RC6RgzanzOMSyNB+d5BNnt3tCqTeopmaqyfXQR?=
 =?us-ascii?Q?GIVl5nF93cKaC7ifQS9dK1hmSVvwKbheT3GUAFLWpntDZ7HviS9ctu9060ER?=
 =?us-ascii?Q?vRBAyiAqN89g5Lu4PNj5tkirZSP+OM0kH2hWI9Y6Din6ACRYmYvTSXDBCO20?=
 =?us-ascii?Q?APklnYbhLT0YD6eUytsowo3AKr7fQt18ufLRdWDen2MlXPtmjWbA+Gp9KiSo?=
 =?us-ascii?Q?tlRtw0tN6sFG3M6TjloGa1oVyH4Yx+9Sc3qRbQyWxCmOtmxRPkJu1Mrw/pGj?=
 =?us-ascii?Q?mMoLYNMob3PQNStDIkbo/mxtZhiV7uUt+R/QBj/+fRt4tXz3zI72/X5bIXRg?=
 =?us-ascii?Q?GYU+Iy0fbGFHlnHdZmjvC/ptPUTDowDp0TA1frRJeyeF+EJUkdkWshvZEXqx?=
 =?us-ascii?Q?Cia74nv0SubkWxVAN4G1uiwIvO5sUilWKGCePAOL/f9cMnGUiydL6zOiXCpS?=
 =?us-ascii?Q?3XkVy8lqG+9nH1A9zdnpU+7snioaXIC/MmfEAz40Lw03W4vRjZXMHmpfnADL?=
 =?us-ascii?Q?PHISTH03DHVXVdXZmrBiOQKd4dIPiO32BQDq7Y1AqGhuh0Poe6gR0TATF4JU?=
 =?us-ascii?Q?fBVsjShf647odIJxq7xWxHj15BoWSXkUkNa6x3icxJscMEeW84wN+yx1rEVo?=
 =?us-ascii?Q?DRfwXoLqMAa01ayRzx+qvRCpuXAV/sJUVZdUSOjjVHVccazlH+ymCbpARoQ3?=
 =?us-ascii?Q?Yj0GWM3uvZkErxMxnIVuMd8NOMOepohPYAE7iGE54mNkNI3XFlNnL5Sux/an?=
 =?us-ascii?Q?xsh2uOIG6y/I5JpQV9clWiCQYVn2toSbcVtY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:26:15.3468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d32b8d5-f4dd-443a-89a7-08dd826a6c70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209
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

The driver doesn't want to sync on the DMA_RESV_USAGE_BOOKKEEP
usage fences, so here only return and sync the dependent read
fences.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 5576ed0b508f..4e1d30ecb6cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -249,9 +249,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 
 	if (resv == NULL)
 		return -EINVAL;
-
-	/* TODO: Use DMA_RESV_USAGE_READ here */
-	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, f) {
+	/*Only return and sync the fences of usage <= DMA_RESV_USAGE_READ.*/
+	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
 		dma_fence_chain_for_each(f, f) {
 			struct dma_fence *tmp = dma_fence_chain_contained(f);
 
-- 
2.34.1

