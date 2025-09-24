Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEDCCAC5A7
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 09:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D341C10E6BD;
	Wed, 24 Sep 2025 09:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eOAJaEO2";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3047D10E6BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 09:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5tEafb+DQQlhs3sPyCGZ3STAr78Hv6kUs8UY/NOjgBlzWd2MRWC+S5jOyPFs5ftb36TIZkiMjOi1DG9boyuXP/ksCHVk0glFKrlON7VVX8fvgRVwK29mPlhTcB9upMfsLaFUKgvcWTRx6V74WlxUF11TQbG2vzLmqwA5/0xLGhx+pHjZIahv6H3w9r0VPsMT4iy9vcxBMxrHYnU0xadoeqKT5FFKReFOa3lSa92TmFu0hePQ6Cn1t6nOPmOcmJ9kshWWw1B8IlFYSX0MofHNwqdXFHt8GVD6YIPKDXYh9j/NnNfQM5IJWHh04s5myt21O3NTuq2SSuSFU2G0yygcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0YOsEqSlhk823/sGYdbOLCng1QNFZ90KqkdqayaVZc=;
 b=GsixG12+Aib8Bo6IO39uASHQaWtWZVlUFc9GS7EnwWQ0HAGJOvC/0WmoDk2ViRgydQbAhPGj9CjpABpzc1y3bKEv8cSCslfXwUuciU2VlJTOtL3BVt4AszmQ68aE6hh+GQNWdCI9/jqki1h2XX3hOqSoyYFuaRUOqJd1gHqcPbhkcb87NKUscsu49hnPscI5QuRzNOpg4nhYyIJ11PxrSCjKIuXduMP2YMRDDYVbj1Q/NVZCcJcArEWp4pqnSv3O3LIrQyiw6ohi3zdbey3HZxdn8FUdfybxxY83EfG+P/TgiaXVKWXgT5IFE3vE0k3i5f555lNhw8s+EqApQQj3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0YOsEqSlhk823/sGYdbOLCng1QNFZ90KqkdqayaVZc=;
 b=eOAJaEO27AESI8P7FC6Z3butPq2kmcg/VaFL0w3jWsU105ogGMeWgRTBQDVDtiRDFH4Gns2R538hER+I8qyCsiePx1l09xRdRpTJlpy7+LX3HAVxOvpjhpAyegWVhalEFLGsI3c1h321oRxWRm0KT9sKJ142m17c463fXR4Yv2s=
Received: from SA9PR13CA0061.namprd13.prod.outlook.com (2603:10b6:806:23::6)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 09:02:29 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::e5) by SA9PR13CA0061.outlook.office365.com
 (2603:10b6:806:23::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 09:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 09:02:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 24 Sep
 2025 02:02:28 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Sep
 2025 04:02:28 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 24 Sep 2025 02:02:27 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [v2] drm/amdgpu: Fix fence signaling race condition in userqueue
Date: Wed, 24 Sep 2025 17:02:22 +0800
Message-ID: <20250924090226.2343264-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: 4182af7e-ce26-4b74-f74d-08ddfb4916ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QzPrk6WvVc21Hg8vudUGqtduxP3oehOrIAP7VMiiajoZjV7RbqpiwXedt3c4?=
 =?us-ascii?Q?EEdeXyFXbdyaxzPk7CJ+Vd1NDxcGtBwBET41PAt0T9QCKimbFkJnxhbvH1Yb?=
 =?us-ascii?Q?9IIKbhFT54syorOINCyFoptBKwxRbMc/STslHFj34OwXivO2A2sZQmvKUB+f?=
 =?us-ascii?Q?mfbHUqsgXWHDlmI+wAdsGRctgJZkWjbuSClahuiUE2vbSS+4JQy1gK+eRKUW?=
 =?us-ascii?Q?DbjUKzckY6SR1h3Y87MaXnu+S7rZplCT4oVx54mCAeOka870H+uSUbyOi57t?=
 =?us-ascii?Q?7gfjKSlguYgFSXkOArKy5lkXMvwUxE1udUXroz6Pc0oW868eCQAQdNtGLG9Z?=
 =?us-ascii?Q?8n470yC/nJQ4Ey5RoiADECAMHfFOQ9JlbqPWRLAQ94YuqRbA44AiP8p00YaB?=
 =?us-ascii?Q?qty6wRIxauKNnM6OcCpiHPscA98RJNXttIOOVmvzOmO3oz+Ng7QWJRSRPIKF?=
 =?us-ascii?Q?wwGvCOWkInxAetYk+JL+/pZFF0vMTMFBVQTU+XGML3Z6G9d2pUk7SxHxovHX?=
 =?us-ascii?Q?Vhcog2irQycuv6TS6qLCQMM29TIQVGtgxRnl3DNZjno9GGgm2DB5jVQyObjH?=
 =?us-ascii?Q?QdPRztRGLx3DkHgcaVhmUPR7KdAwkmwsg0IYjHqqV4daxVDywhzdZqL9v9Bq?=
 =?us-ascii?Q?2QLuAxY8V2kDhx82b3d9E6iE8KR03Tj0n1Qlns57UcACF7JrD94PXBwNV6WG?=
 =?us-ascii?Q?SrpKLZ5HvLcLz86Pwv+aH8Woz+KrGH0BjgZIs9dJxY7X24xfyEH5dui3MoCi?=
 =?us-ascii?Q?8lFx4CH/pUUen4ctRsW1W3WZXJonJQQUuBCOIWk27caRDUmQwDjGWblfpwHM?=
 =?us-ascii?Q?qkj/N5YDZhpCSUUZ+WDTOecCn8lPFQY13X9KXND4ZVIAFr+jk+Ak6+AbMMul?=
 =?us-ascii?Q?eQmRY7ttcdWOodff6kL6F8dL66/V2+WSrq4Sd7zT8IOl8c5wODRqY6a4Y8oL?=
 =?us-ascii?Q?KG6h81UgRBqezL68VapPUzC1Rw27967xV/pdoIZ32elEfID8qEx1hyshd/WC?=
 =?us-ascii?Q?3mQC0PdGNkKFGZjzRcMDjJNcDbUpAQHcv5V4BjFfsseM4/QH6n2OjAe6I2hH?=
 =?us-ascii?Q?WsPnniPHoQlIjv1VsSVLBDuilpL9H6rFIltpUrq0319TkQYrdkGFHJFbrJMR?=
 =?us-ascii?Q?6Wmtp7f2MnvJ26hnYLrG82SHTvT9LzLS+/TR2xdjkN8DNyqcWE4nz48J/d+w?=
 =?us-ascii?Q?6kcjcEi4TCJOabKIiFT1MMNccHbuhaum5QY2CBoYibFnUzAA4CaSf/vUO4Vr?=
 =?us-ascii?Q?byjr2o39ukGTct4BSkVRSpQ98/SEqeV6iOA375YwDqpE1mquQ68IQ7VtOTjl?=
 =?us-ascii?Q?Ihcy0+QNvz88SMNbBfEmEO92SWtTk7Js06LMLQoOim/qrTFVtfpuU/X40MRG?=
 =?us-ascii?Q?LsEXlFtIHdFPkNlCqzqVSwMJna3BkXgvGFvzvUs3C92MeHZljisWsHtZWxH7?=
 =?us-ascii?Q?BSp1U3salhkNKJg4gFv45PLqjGHPw4T+ySGjcRMvhOAkt/HoOpYpbgqanQmh?=
 =?us-ascii?Q?BwJw237wYr9Tldnow3ViHpboLo+M6XwCKWt4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:02:28.9346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4182af7e-ce26-4b74-f74d-08ddfb4916ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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

This commit fixes a potential race condition in the userqueue fence
signaling mechanism by replacing dma_fence_is_signaled_locked() with
dma_fence_is_signaled().

The issue occurred because:
1. dma_fence_is_signaled_locked() should only be used when holding
   the fence's individual lock, not just the fence list lock
2. Using the locked variant without the proper fence lock could lead
   to double-signaling scenarios:
   - Hardware completion signals the fence
   - Software path also tries to signal the same fence

By using dma_fence_is_signaled() instead, we properly handle the
locking hierarchy and avoid the race condition while still maintaining
the necessary synchronization through the fence_list_lock.

v2: drop the comment (Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 59d0abbdfc2f..aab55f38d81f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -289,7 +289,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 
 	/* Check if hardware has already processed the job */
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
-	if (!dma_fence_is_signaled_locked(fence))
+	if (!dma_fence_is_signaled(fence))
 		list_add_tail(&userq_fence->link, &fence_drv->fences);
 	else
 		dma_fence_put(fence);
-- 
2.49.0

