Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9934D49C7D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8FC10E97F;
	Fri, 30 Jan 2026 08:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B/4BgLkc";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF75010E97B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTsZsr/WnbMLZPrKvwgh99j65eB4X1vSThqmpE0uu7ddpu+gKuq4BHME4ywvmyVNvMrx+1AufF/qkIJes/WO7f3RHiUSdGKfyCs0phunzRA47FBpA9vW2hd5a/C+h72JtSLs92oVG2AVsO24I6fUrRYSfpaLQMbiz0Rs7NpCVlTL4oocTGl0homcGae2rYbWfKgdX9P7KxEilX7x/LaAlNAkzT+tw7dNP+67UgMlJng/brirpwQIAFeMzo2cltn6T9U9uex9t7YTbpID1prsalyNzomt5fwIPleHDFoZEAzF7E6vQV16EWOMzTRnJIE00XSAhmnDlwb9dDo2zUYRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxkO6CT2Ul3NryvcMZW392jsAtvQgfFVsTXe9XfhAmY=;
 b=Auf1NtjzNFeAEm4vYMT4OqFDZHZOQlNYZoAhWuh/IoaLK7Zlrj0uZ5xjORgmeX0xMPOgJA5rmgJlL/oN7aTsGwwGj487u/6xn6Krpr6cXyGcz8W+jogemm/OkJRrQrSgk7hnYTxWfXHiZCXEnvso/vbvfOvgeb/T6O25VmgTgWokdTDI4yoJ0a/hEHuMKDMP9FfeYHUyVz1GW7IYb+N7zPjv+8OtD/pmJ5F847Ngeui+M3WzFxlvJtGllV4Ub7rbdu/k106DHVogBmK93yuHTCG2Y/dWBAwrI+PLyEbXfndfhnIE8MJmUJ0Tg4hplsnEE61fz9nWEVimXSYYNSRkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxkO6CT2Ul3NryvcMZW392jsAtvQgfFVsTXe9XfhAmY=;
 b=B/4BgLkcr4gn07lOAv5L8DXWaTK/oL9CjB4095IxI0D/ExE+OBGkcbmjBVLGf/mCFy/f9az0WrenL1Hojnru5iu8POfYfBSuXsM/kuKArr0mSt1b3bmoRsxzgKW17B40JYoriNPU2JcGDgBLHxISwV9VhweilP23nwS8NSov9qo=
Received: from SJ0PR03CA0365.namprd03.prod.outlook.com (2603:10b6:a03:3a1::10)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 08:42:31 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::d) by SJ0PR03CA0365.outlook.office365.com
 (2603:10b6:a03:3a1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 08:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:27 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v5 10/11] drm/amdgpu: Add ioctl to set level2 handler
Date: Fri, 30 Jan 2026 14:08:04 +0530
Message-ID: <20260130084137.2906792-11-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260130084137.2906792-1-lijo.lazar@amd.com>
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b842e3-7bca-43c0-f35e-08de5fdb81a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4m9LJ2wlR8CIUKEwaE9iixn4a4mdszWCBXn/PmZQk9kwejbzGWhmwcdaB9XJ?=
 =?us-ascii?Q?KeITwmngjPK1xUfUpdIhsr0bR4x8fKGCflWZH5Eegp6pFk0IWs0mWZZFTDd1?=
 =?us-ascii?Q?QcOKAhCD0H5vdBuGw3yr7QGrtzaHT9nx0mgMyiOvy1Wusn1b3QP7WEujYskJ?=
 =?us-ascii?Q?A9A3XA3yJBEtNGfK2RZT7mfLxndAhbpadSOmBBbR021O2QgwrM6MoNcQdVrJ?=
 =?us-ascii?Q?Ox1cJQ/D4g30gARKWffxGeaVg9ftLFffnNu3EIzaMnePfuZacULUGqXoyBAN?=
 =?us-ascii?Q?c93U9BL0NGlrmgpedeXALGsryifOTZJnGhRqd00wj7JH/LxQVRVbVhs5V7Yr?=
 =?us-ascii?Q?MUTEKYKG5kh8FjoZlrVNmf5Xujjvyl97xwQYGE/KPlnUP7h9Lr7Ufl4W7FEJ?=
 =?us-ascii?Q?6RzNgQdxcqd9zikn1Qq9vWSX9Sz4D+lf0YFNrKCyITX9hotV7pumaJQHqrWo?=
 =?us-ascii?Q?botoJ0aMhN+Lhpbyb8i5gYi+uz66T+dQT4Z/5xTefl9spqoe4/zrha6Z1AmI?=
 =?us-ascii?Q?YHg9gIY1e65/D6KXvjUCgpnGWFumLoz9XV8aqN/HKDGJX/0uSZqkpPnq4bH+?=
 =?us-ascii?Q?Fz3/1TvMUDTFV/aDHhe6P/kAvHOkvsDuCQscyxIkxmGdQkRi2q2hTsFJzJqo?=
 =?us-ascii?Q?Zp3YpfDW9K1wtrgCQpjXT/tvVr+psjAsHaS0gFnLeexPijZ0CKfjJBsATCe/?=
 =?us-ascii?Q?BU4b+eR9wNESP7haeYRVKniF1eXTevSWVmiVBstUGGiJovw3FIMTMiRxUxCI?=
 =?us-ascii?Q?AhNqvsFuwS7Pq3xU1l0OgnXJVkQ0uxxQkBNK6r9pZ/woLcdiG7kvqTPwc4Bq?=
 =?us-ascii?Q?R8u2oA0cFVQjXploObTM4hcOCJ1RvzdDy1nh/JazZGhuHFTIXIkRHGnoXhMR?=
 =?us-ascii?Q?ulkqxsHF7HygWhc4MEbskkeu9BYvUl3PgFk9Z27l1piHsMsWqxFUeAEjw3MP?=
 =?us-ascii?Q?N4Eu0sNynAbavKv632fxM1nFjWVnZMKioQDLwaOUXYiBxBAPtSIf0HUtqcJj?=
 =?us-ascii?Q?I44eKlxxfzu1rjDaHs4NDiAaIEeBkf+j2OR4ikO8clvC9gPUOh5Ixab/JewD?=
 =?us-ascii?Q?CfIBOjlHvhXk3+r20r659a+q0BnzLKxJq7F82TtMwoPqMtYJt3nhUZwom6C7?=
 =?us-ascii?Q?zkUXQpVi0eFz3j5nDY7sSXV7+b6VQurSEQJc0ajuTPhPPWtwD4GsnD48ORpv?=
 =?us-ascii?Q?6kX406c546BBbwscYHOpLMuq8BkntKvn1MTux/gwCad155lK6IkV1Nb0cIun?=
 =?us-ascii?Q?JqxYNB5/TS0xXIbwkwsgGKWMV2OJS0FSb3/qXRLTva00e64CH+HMVOIXDoaW?=
 =?us-ascii?Q?Le2+/QohKQRVUmd3n8ZNmJBYH4Sfnz4yKW2AEQBvxq8xJWO3I40eNxMUVZzv?=
 =?us-ascii?Q?fzrXQZaSsnIfoQWDiljzn/Wsq2AhFWemAInHVxZJ75SRXHHMW2sFqXuF7dhZ?=
 =?us-ascii?Q?QUYMQel+ZdvJ/yo1rNo2tNLr0n/3beLNA/Ba05xayUdvuj3QbU/kBs4FINGT?=
 =?us-ascii?Q?ZBetX9VmJf+GlzNVR2KghUfNW8YHusZ0J+S2DjJRL5g+Kd2Mn/LkSKJ64iE4?=
 =?us-ascii?Q?CflByIAap3QoWT+OnptYSjlGcmuzohZHqmk5OtAL4cFAKvMmvWl3+ZkzoeXO?=
 =?us-ascii?Q?eTtFN+ZppMWnsAfmeBKqPprZlYQx+sHKD3zJhPQZtsvw2AEG6i9PZn1b/Kq+?=
 =?us-ascii?Q?WSZ2Tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JCbCFH+DFUa0BjtB6hYu+pFtOef3DzPSsqzSVQdf0tIRAcVes/fCdM2Y6VhRKng1BN/AJMGjsp3YZcDRHThd9YsBQ75HNBBy0aiFhEKH9TBlEn8w+c0lE+fpLyiI+z/VYS8E/5Ymsj71mDHcGXd7RIjIPxMA16GYH1X18I4eJcKHIGZ+ftpZVwxG6u4YWZ453uIq4vJg45pu9hUnAxHwjqwUikBZIWtcmI2Q2RGd+Lqh7J/lXX3EoNxEz1RFBrE+QpJsiPtIrUufWmFWsf6Nv0x8ndkkBDuI57vHLgNW4NKgc+oSP5fY8nBowswpFBg2lKdlvPf5JQ4vXRAK5lbj/8XUd3E22b+S3vCjsWqq2r0/ietnvgcR086G7uw7tAsRYWqkCjXH4H2VFqn7urFh7WOxhCKF2W+us9m1Rpp4yYmUZcWC1x7qkKZubFIUjIa+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:30.9220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b842e3-7bca-43c0-f35e-08de5fdb81a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754
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

Add ioctl to set tba/tma of level2 trap handler

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 105 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   2 +
 include/uapi/drm/amdgpu_drm.h            |  24 ++++++
 5 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 26b757c95579..c3dfd84c2962 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1575,7 +1575,6 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
 void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
 int amdgpu_info_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
-
 /*
  * functions used by amdgpu_encoder.c
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index f4907172ebeb..50bafb84a912 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -505,3 +505,108 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	kfree(*trap_obj);
 	*trap_obj = NULL;
 }
+
+static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
+					  struct amdgpu_vm *vm,
+					  struct amdgpu_cwsr_usr_addr *usr_addr)
+{
+	struct amdgpu_bo_va_mapping *va_map;
+	uint64_t addr;
+	uint32_t size;
+	int r;
+
+	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+	size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
+	if (!va_map) {
+		r = -EINVAL;
+		goto err;
+	}
+	/* validate whether resident in the VM mapping range */
+	if (addr >= va_map->start && va_map->last - addr + 1 >= size) {
+		amdgpu_bo_unreserve(vm->root.bo);
+		return 0;
+	}
+
+	r = -EINVAL;
+err:
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
+
+static int amdgpu_cwsr_set_l2_trap_handler(
+	struct amdgpu_device *adev, struct amdgpu_vm *vm,
+	struct amdgpu_cwsr_trap_obj *cwsr_obj, struct amdgpu_cwsr_usr_addr *tma,
+	struct amdgpu_cwsr_usr_addr *tba)
+{
+	uint64_t *l1tma;
+	int r;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
+		return -EINVAL;
+	r = amdgpu_cwsr_validate_user_addr(adev, vm, tma);
+	if (r)
+		return r;
+	r = amdgpu_cwsr_validate_user_addr(adev, vm, tba);
+	if (r)
+		return r;
+
+	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
+	l1tma[0] = tma->addr;
+	l1tma[1] = tba->addr;
+
+	return 0;
+}
+
+/*
+ * Userspace cwsr related ioctl
+ */
+/**
+ * amdgpu_cwsr_ioctl - Handle cwsr specific requests.
+ *
+ * @dev: drm device pointer
+ * @data: request object
+ * @filp: drm filp
+ *
+ * This function is used to perform cwsr and trap handler related operations
+ * Returns 0 on success, error code on failure.
+ */
+int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	union drm_amdgpu_cwsr *cwsr = data;
+	struct amdgpu_fpriv *fpriv;
+	int r;
+
+	fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
+
+	if (!fpriv->cwsr_trap)
+		return -EOPNOTSUPP;
+
+	switch (cwsr->in.op) {
+	case AMDGPU_CWSR_OP_SET_L2_TRAP: {
+		struct amdgpu_cwsr_usr_addr tba;
+		struct amdgpu_cwsr_usr_addr tma;
+
+		tba.addr = cwsr->in.l2trap.tba_va;
+		tba.size = cwsr->in.l2trap.tba_sz;
+		tma.addr = cwsr->in.l2trap.tma_va;
+		tma.size = cwsr->in.l2trap.tma_sz;
+		r = amdgpu_cwsr_set_l2_trap_handler(
+			adev, &fpriv->vm, fpriv->cwsr_trap, &tma, &tba);
+	} break;
+	default:
+		return -EINVAL;
+	}
+
+	return r;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 5717e1d662fc..2cf485111e8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -31,7 +31,7 @@ struct amdgpu_device;
 struct amdgpu_vm;
 
 /**
- * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer tracking
+ * struct amdgpu_cwsr_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
  * @bo: Buffer object for CWSR area
  * @bo_va: Buffer object virtual address mapping
  */
@@ -62,6 +62,11 @@ struct amdgpu_cwsr_params {
 	uint32_t cwsr_sz;
 };
 
+struct amdgpu_cwsr_usr_addr {
+	uint64_t addr;
+	uint32_t size;
+};
+
 int amdgpu_cwsr_init(struct amdgpu_device *adev);
 void amdgpu_cwsr_fini(struct amdgpu_device *adev);
 
@@ -84,4 +89,8 @@ static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
 
 	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
 }
+
+int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
+		      struct drm_file *filp);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 771c89c84608..7fbd106fff8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -53,6 +53,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_cwsr.h"
 #include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
@@ -3074,6 +3075,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
 	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_CWSR, amdgpu_cwsr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	/* KMS */
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 41a155fe2c01..fe4474fbdc17 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
+#define DRM_AMDGPU_CWSR 0x20
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,8 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_CWSR \
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
 
 /**
  * DOC: memory domains
@@ -1675,6 +1678,27 @@ struct drm_amdgpu_info_cwsr {
 	__u32 min_save_area_size;
 };
 
+/* cwsr ioctl */
+#define AMDGPU_CWSR_OP_SET_L2_TRAP 1
+
+struct drm_amdgpu_cwsr_in {
+	/* AMDGPU_CWSR_OP_* */
+	__u32 op;
+	struct {
+		/* Level 2 trap handler base address */
+		__u64 tba_va;
+		/* Level 2 trap handler buffer size (in bytes) */
+		__u32 tba_sz;
+		/* Level 2 trap memory buffer address */
+		__u64 tma_va;
+		/* Level 2 trap memory buffer size (in bytes) */
+		__u32 tma_sz;
+	} l2trap;
+};
+
+union drm_amdgpu_cwsr {
+	struct drm_amdgpu_cwsr_in in;
+};
 /*
  * Supported GPU families
  */
-- 
2.49.0

