Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2C7C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 10:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1EF410E273;
	Fri, 14 Feb 2025 10:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3+ofsPob";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB21A10E273
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 10:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7kVahJrbGv1XjlxuhHC9adwUSl8TrextymkZ7xzti0GfPbA1jPZ8E6YC2z+lkyFzLSrgUf9qQwTJvQGTQW+Sv3eeMiUNiOqVIm9psGp5gms/BtKmPmrXd2qY1ErxQ9jmaxS1d4kGPzKNvTUhPrCbZYZVC3WHYr58HVwx4xxo1whgwoc2CAXytbPCdBXNfxOiE5R2++tawK/OmwAW41S3tStqs/GVwNxavfQv8HE//KOQMNqzUCXrfPIIQ14tAKTR3vuIDgsVNRZOesfHlU0O0QXpILWTTOjb5LTgSUTth8T8v9YmPuCR/otyy7T3xBczc4SsAZpnKmA7Ygw9/h6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzlA30s3C5FTJZv1qha2MlMOdJI8MCWmcqDnX31GcI4=;
 b=nG5buxSlqAWpTAsosjzDBC8DPeUPLkyRneDt8XMXmwSnygh0jWx66XhQPi4RzfSjCQ+jVEHr42nAcX4LjUlbhiMYFczazO7jm5LJgFKmuB5WRbIJQb6TLsKOoeIcQxPsjHO+K+rh3WfqSg98fXX3V3NsOY9vRl9/7B4B/A8dn5ZPLSe9QMvWm3B6nxTXi0oSqMGbnfCoOcZUM1SA3qOTzdDRplf7OApVLsMvwHIf1n9pVxplnzSpJ7KW8PT8jILNpX41P8GHRZTxfWMlDr7vbdKZvSbWRMWNh1XcoKhaF7PhXZIz/3qpkXR3TC1+a8Pc1uZoaZsRA9RTTo/NPwzKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzlA30s3C5FTJZv1qha2MlMOdJI8MCWmcqDnX31GcI4=;
 b=3+ofsPobgYEZXlEbB9GyS3P7l3CmQyflYmms089s89wr5PdpKYJuBYNvrWj33SzLjfOqdFsmxTP1e9n+7aJ9TUPXM8qOWvGg9dOoiBWJ8seVZDmp383zSaSrEgMPsVfi0C08UjPYM3bniSj3tw09kETxwFJbw8M6vI5o1OPSIt0=
Received: from BN8PR15CA0033.namprd15.prod.outlook.com (2603:10b6:408:c0::46)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 10:07:34 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:c0:cafe::6d) by BN8PR15CA0033.outlook.office365.com
 (2603:10b6:408:c0::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Fri,
 14 Feb 2025 10:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 10:07:33 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 04:07:31 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, Le Ma <le.ma@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix the memleak caused by fence not released
Date: Fri, 14 Feb 2025 18:07:18 +0800
Message-ID: <20250214100718.2663073-1-le.ma@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4502c5-4ddf-4254-9b17-08dd4cdf6646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SuxIZ04tZFKE3pZi5bsXIBPX8T0TBE7dDarQKXhprOMmpa8/GkEIRAfbDtSh?=
 =?us-ascii?Q?/NHA3I0Rmw1d8tIPffvawd+HU9Nmv2E/zkUzNHe8wbdkjlfhNyxGy6sABG4q?=
 =?us-ascii?Q?y0XvW5Pxum+bDSZ7LU1sOUplW6kaYcFxCHwHqFmJHQn4qqCFWX8yCArzoDcc?=
 =?us-ascii?Q?xunwWcmxgAKMZO8aAFKODHiEuIEqvf++VKq7AY36LE6oPUraBkT/+eu3U4mq?=
 =?us-ascii?Q?m7uDye3HD3mDrPUtSGSM0jD7kWxPJ5shtWIZa0IKugiFGbLgL9BoCkq93TlA?=
 =?us-ascii?Q?BBWgHptH7RiEwooKLXv+ynKK3X+ig3bxF7C9hFbACiNXF8O7IxyB8aAgiyUe?=
 =?us-ascii?Q?aeeiIWB36gq4hwtcLPxBg5+2HQFfPuaJi12Lhkg/rkMXItwBCsf2TMQl1BzU?=
 =?us-ascii?Q?oXEP2kfTNTvciTTvyrKGVXgUDccBYKM5vAJ3Mj1YU86SysLaPYX13K02d1k3?=
 =?us-ascii?Q?cevritlB2zV83xjQDMyD6MYD2SGdRBay/VbHDZp8ghVbq4slasqIEy9vgsGh?=
 =?us-ascii?Q?LfVtjjrDz9LE7JSKTfXUZxbnwuhOeghVxUrOaeud454xfoc4l92YNY56GDiH?=
 =?us-ascii?Q?1LWEBvF6Iop9AZXGNk4yYF7HlOYEhj6Yuwvd6KJJ+3iQh4TO9DF/yey7bw/n?=
 =?us-ascii?Q?avf6BP27fVXHvlpd6Cc5pBISiYQYEFzbUhSGT30ya9GOe23d0T93uRTezgN/?=
 =?us-ascii?Q?oawoo8X1mGnM8SD8FQ3LuWXdUmFbCOFBm2lQWacw3X1Dany5kGrSQjkdXZq/?=
 =?us-ascii?Q?mrvVs/EF4gSinab8298RRYp+a06lpKp92RU572vN5YnB/FJx0FDpJ5hJrRjC?=
 =?us-ascii?Q?Q3qLxhdruDFmmhb21HbKCzUne7UyG3fLfV9nRt/IXjh6n7zf0wPDKAFF1Amv?=
 =?us-ascii?Q?deW8N9d4RRYe8AgD8txeAGtSWMKSkq+EqsDBWvKV4zxAF0LEnKlV3glUAqMN?=
 =?us-ascii?Q?Al8v51FCo7OXMljXs7PYkDIYSPF0k4gr8vgGQtFEynCj7IaVIXaWhyXxMLXb?=
 =?us-ascii?Q?/a8axZGTxcNdL42NoBCRxgSI89tnl6pRFlgI3opclU/pG4uMIn0XmTcAsUkS?=
 =?us-ascii?Q?F19XLvzflngUzIJUfPgp20nmCnuMT+fQitEV+KC1nrF5lt2XyDp+MJHaQU3s?=
 =?us-ascii?Q?podt6qrNt2d2uNdMuZffx+//M4ZLNKje3bv4eK0HlB8bmFf1cqoQT/v/Z5zn?=
 =?us-ascii?Q?K7uSeRFsi/VYaE0KMqbemIBOzoL527hE0zgUnyd11V8B65k/Px+k2qHDNswK?=
 =?us-ascii?Q?ojZK/LYwKUO6KLZ6gNhBzBUJnMjYA5y+jpkaATO3Ku+dJXutSvsmZH+ar7gO?=
 =?us-ascii?Q?jGPeHiDxeebXc+V4hM5ZrEFgzZYVd1PNLo5hML5AlMeqN8C9w13QJAo1QT5a?=
 =?us-ascii?Q?JoInjgTxEq8Umj+wzbsAzyzJCO+qDuuKEbLajQqc9XE7QN8qrNymFFsE4S/a?=
 =?us-ascii?Q?ETUN31zlUKfn8C7upktZkkwl5OuSoR3TV8TrsBpB7/Ap3yUQdgwjHGSNu0aE?=
 =?us-ascii?Q?wj+N0k7bpAVC3Cg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 10:07:33.3174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4502c5-4ddf-4254-9b17-08dd4cdf6646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
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

On systems with CONFIG_SLUB_DEBUG enabled, the memleak like below
will show up explicitly during driver unloading if created bo without
drm_timeline object before.

    BUG drm_sched_fence (Tainted: G           OE     ): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
    -----------------------------------------------------------------------------
    Call Trace:
    <TASK>
    dump_stack_lvl+0x4c/0x70
    dump_stack+0x14/0x20
    slab_err+0xb0/0xf0
    ? srso_alias_return_thunk+0x5/0xfbef5
    ? flush_work+0x12/0x20
    ? srso_alias_return_thunk+0x5/0xfbef5
    __kmem_cache_shutdown+0x163/0x2e0
    kmem_cache_destroy+0x61/0x170
    drm_sched_fence_slab_fini+0x19/0x900

Thus call dma_fence_put properly to avoid the memleak.

v2: call dma_fence_put in amdgpu_gem_va_update_vm

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8b67aae6c2fe..00f1f34705c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -759,7 +759,8 @@ static struct dma_fence *
 amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 			struct amdgpu_vm *vm,
 			struct amdgpu_bo_va *bo_va,
-			uint32_t operation)
+			uint32_t operation,
+			uint32_t syncobj_handle)
 {
 	struct dma_fence *fence = dma_fence_get_stub();
 	int r;
@@ -771,6 +772,9 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
+	if (!syncobj_handle)
+		dma_fence_put(fence);
+
 	if (operation == AMDGPU_VA_OP_MAP ||
 	    operation == AMDGPU_VA_OP_REPLACE) {
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
@@ -965,7 +969,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 						    &timeline_chain);
 
 		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
-						args->operation);
+						args->operation,
+						args->vm_timeline_syncobj_out);
 
 		if (!r)
 			amdgpu_gem_update_bo_mapping(filp, bo_va,
-- 
2.43.2

