Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EA8CA101F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 06:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEFD410E2B3;
	Mon, 15 Sep 2025 06:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MeTNpD5s";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DF410E2B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 06:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCRiIp72+bDBF9z2+1BoDRW1WmQY/T5GxeUo4SgKye87rc0bksS9xlA7uS0JeZy/xV7ikQ36+oc6NZ829eEn2h9taxCOsAUjbr+ZYmg5vdzp+3AG997Rhrr8UpS6X2nLua/3gFeDORkhuAyNCeWiyE2Jj4jGzVXakMFWxsxQR0dC2AljrD+djIFULHoX8M+VAXPreH/hcCGogQbc/FQhQWPDsJAKu7pUBV5EGIXk2QhYBOU8ufLSx2/VyUhZVZD6pnLDJ75l1N7M5MLZgZE9d+vjlFyDoVA5NkDGFhaCdjw/RFkBG2p52blfKTI3TKsZM0mKA0uG5IG/pqt7Gi8rAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDY+e1D0CiDc4TbprU/ImuvMHhZ2aBH7PD85ZCkrZk4=;
 b=QeIND+7tCA2wwCBg76+5/XZgLpzGdUobiZ04XTuIjZwhBxQxvJidiqUfApehCKz6jEvuLnNQyPvvkeqZYYg8kLA+cKd8PqKT0MXeWyW8l4j8OqqmMK1Sds1Kq4+p6V9K4nqSIFuOtwIEjKCzxg/o0u24Bg6yd7420gwotk3tK5af0U1/MqY3Y3SHVJe0GZinYGPB0pz3CsG8qAKWyejA9EqRYM/Yyh7xcsOwd6xaDpn5C7kemWUuHmle2+CvqVwyC6GooKCLzp8dgUwwU3irJZXO8uFWbsqPGCC7gV6W1I8nLYLPPwbIV36r5tg7GpWfuJSYB64xSY1MZAnEhEBgcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDY+e1D0CiDc4TbprU/ImuvMHhZ2aBH7PD85ZCkrZk4=;
 b=MeTNpD5si4sPj96UVZQzLqPH47UO6KkcG2jnWemMtvyXvukkQ+NMDquELPMu+PUUJGG5eQHPhdJGxWe2Fsl3Ww/RG1iDnnSpvE/pK+IIulizZTFmQX0sEglLVzLd/MStxRQWy0JLF8Xf35S6e/HKUGTughR/cMwx1CDQd4CnzNU=
Received: from CH5PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:1f1::27)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 06:21:19 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::1) by CH5PR03CA0019.outlook.office365.com
 (2603:10b6:610:1f1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 06:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 06:21:17 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 14 Sep
 2025 23:21:16 -0700
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu/userq: Fix reading timeline points in wait ioctl
Date: Mon, 15 Sep 2025 08:20:58 +0200
Message-ID: <20250915062056.6436-3-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 9daead8c-06b5-4cb1-5e6e-08ddf42014a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?En8BAtN2cQ/Zp61WAVlV3F+TmiApBASK+3Ld8nBOhFHSNV/+sY+p9F5TkenY?=
 =?us-ascii?Q?veQTU8vocQDhZEBst7f06Rk3JMLSCNJBF4JY0NjKQi4x8e0Y2U2BHY/9Cfn0?=
 =?us-ascii?Q?O9JhP3sdm7m85ojiCQ4kxey0UAuMlojJRmbDZOO9L++BLb6c5r9l3Brt0XbI?=
 =?us-ascii?Q?MSdWjiJByiu/0ShrN4rk03bLrGrarv1uX+PX0kz5xPjuDODf1iighDyhpt5g?=
 =?us-ascii?Q?onDTA1rmGqXHGWw3bp7wHHOMKgexmk7lxgj8SZEnsKOxWvkIzgulGvKxfxBM?=
 =?us-ascii?Q?O5fFmCHDgB23hDvvKXCcbXjSVIkgHz5dwUH9UvLqSpZB3HiUocXiuRM6TdyU?=
 =?us-ascii?Q?KcNjR6X2JsFgcHL7wJU4mzP+Xa4x2eTUM8LJQO/9pOtkFkkATnnsJzmsu+kY?=
 =?us-ascii?Q?ZdRm6khpAt07ZlGD3WlcJ5PCSSg2yRINXGifihc9XEz/SnJJEzqGYTiEiaoV?=
 =?us-ascii?Q?pQOrJaq2xA8mD8PuqaPnPHE4TxaiS2eT9UrSjl3ujKn4XhWhj39+23LJA/JH?=
 =?us-ascii?Q?5LtUKUNnW2QD3t/VsG2n3hMlO5vhyxnlG4atYbV/bp3/hH4Y8ScdLJ4sMPyQ?=
 =?us-ascii?Q?/HmN31cmdscA5sJ6NH2HG6fdp3PaYvxIcKqet6J5hy0Hi6axy0Q/x5jlbhOP?=
 =?us-ascii?Q?E7CY7L5Ux9U7eTIubbeoeg18euiH1BPqna/ggRN1Mx+T6yipoCnYWneGUL3I?=
 =?us-ascii?Q?khKK4lEqRi/MyVgZS+V4nY8J8EGdjYaIsLn58uIj+Ux02BMnVmU6Xm7i/txv?=
 =?us-ascii?Q?FxEz/r+qOfWe2ZoxsKg1AKbrtfVyecUxOONchblrcQfGdloWl8pTy7D68El9?=
 =?us-ascii?Q?MciR+AsBB/YJSHG8+rYUd1lo7Rbajo/WA6/shV2JEqPZL3B8kh0CwDfvAbF8?=
 =?us-ascii?Q?+dedpXajjRR8JG+2vPtKwI3Fvvl9L9+zwvLAAYhxCnn0AOGBNjrFPIIzu3Ph?=
 =?us-ascii?Q?0SXgJuRCA1E7heR9EddGnFKnjmXlSASdXZcN/sh8AUCWBt8Iz/rY2o6iwft0?=
 =?us-ascii?Q?KN46gGKVhD35QyHrGstmVlSW7lFS8aXrxY+89lDD5/EdX6izVrumIsenBkIy?=
 =?us-ascii?Q?DyiHdUhuleSWpazF5KJ3lXU6bYA6CVekq40Dd+wpdBaYPo4MKJp/JDXiBOhV?=
 =?us-ascii?Q?ybaFE599mFwBbmtExRH7PkxK3heSqLn3lqlqP97UxmvlQhJQYgrjtB4XHcq6?=
 =?us-ascii?Q?4/FXOJ1FJp12sgeA0VwUp4qeZq+uiI98sblrdWh6j62Z0AlJv2RfW64DWn58?=
 =?us-ascii?Q?rsmR8YFdd8uUZJa+4DOPN66yBl4qjVMOLTyH9r+V91joNaMOM5MfOOOW8q+U?=
 =?us-ascii?Q?cR2/a/jDsKH1blGMCZfMSpgCgkczplcQ589jt/5LaMDyEpwfKENxHEjf2IiP?=
 =?us-ascii?Q?AydZNdtx9W6FZdALychPLauyfz18EoRuOWBYl3oRY4Vzgc5551wIWGxpNtDN?=
 =?us-ascii?Q?JTk8la42t93VLdyV9B7L9OwQDrdWsXMIKK1cF1WLBplWZDM9r/ajPUGFMt+t?=
 =?us-ascii?Q?BBWAD+QhFKOIWZfdSxhwOoEYe8eYMvdgB0zB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 06:21:17.8650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daead8c-06b5-4cb1-5e6e-08ddf42014a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
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

Use correct u64 type.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 95e91d1dc58a..729f0f358398 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -637,7 +637,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
-	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
+	u32 *syncobj_handles, *timeline_handles, *bo_handles_read, *bo_handles_write;
+	u64 *timeline_points;
 	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
 	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
 	struct drm_amdgpu_userq_wait *wait_info = data;
@@ -682,7 +683,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	}
 
 	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
-				      sizeof(u32) * num_points);
+				      sizeof(u64) * num_points);
 	if (IS_ERR(timeline_points)) {
 		r = PTR_ERR(timeline_points);
 		goto free_timeline_handles;
-- 
2.43.0

