Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB54FB5E8B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 01:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DAFB10E402;
	Tue, 17 Mar 2026 01:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYWzO8oZ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7963410E402
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 01:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meOdOw8WKi2EcY7sxjXlmv1WhO58+DxucLFUksF6zBlojef6wiuptLCLwCeo4+5BQujjo/7vMp7i3tk9fUPqcuyrghQ/TevK8Nhay1oabUQRSK4QAZpXuRNo164MGNgmMTtzQtL/mhV3n72lRlJJnVSh4HgKoxBZdtRVsVGwwTrZZI8e/46VOz0UjAxFeUboH4gYVQqDxyBU4e1mkrEcQc8HmdtKdF+RHfusmZmAfeYDFPbSZsmFNFczlbzbP/bCRXHPL3z7on9Ba5wmlbVygmX1/Tg5MnuKjoq2htKqn4K3iSKnvnlpyedmFI49D1Tl1/fADM03LIB54g3AHghP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgi/pV4gKrsHsqeF0pn+W9jMzXuTIlQfjYsuU8+kcPg=;
 b=AfrUSb+KHOIbWqpG/a8PSUFHKMLEPtoQbmlyoyhhlF2qZiqTVciFJYqkxn2hiveStjoEJF9jslkG1JbO3KnGdX6YZViRlexzya5fkjoXOqsN/vyOIQ/nqaLoVStWzvhavRDupENW33BfOQVhvtNSf70ik9+LAD96ytVzojk+kGVvT8aNKveVxbkS11whCbpQ+iDpAyOk8uYE+gimnLcpfqEUFoCsztXmzZK6j5quOPsO7MTpOX40CvOR4Ku7dFDlDyJ6/oPKCawmjKvErfNnimhLe0P2Yp+QOFJ8JCTdyLU+0leDH8xQLvFwQcGSbXOksKddoty9KuVy3o9YJ57uqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgi/pV4gKrsHsqeF0pn+W9jMzXuTIlQfjYsuU8+kcPg=;
 b=ZYWzO8oZ8AmGT4oh36xMHCrgnRPN6cPrRWcixqExitvzpJF6gGpzkDGCABs5fk1lNlC2L8ZJ3i/5+gIyLfZx8O7zU2OKuK6Zn3twKt5xundnAdmjaHRrf9Sze9MkLmWpGJW6N5TK24ogB8dXONjMysvuayCSUIPq3tXD6TQAYAw=
Received: from SA9PR03CA0013.namprd03.prod.outlook.com (2603:10b6:806:20::18)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 17 Mar
 2026 01:17:38 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::e9) by SA9PR03CA0013.outlook.office365.com
 (2603:10b6:806:20::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 01:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 01:17:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 20:17:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 18:17:35 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 16 Mar 2026 20:17:28 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: harden SIGNAL/WAIT ioctl argument validation
Date: Tue, 17 Mar 2026 09:17:06 +0800
Message-ID: <20260317011713.1812421-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260317011713.1812421-1-Jesse.Zhang@amd.com>
References: <20260317011713.1812421-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: c03ef2a4-1439-443b-bfc9-08de83c2f9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: tmlR3mFnwkkgzHk3x8W43o3ytrhxQLJfy4m6V95axQqbJvNJZ407jbD/7ZWk4j2pOk16BRaVBsQM7mpmLOKUvuU7Lmiyzn+itaHISnqQw8tSww7UnPJdTErZW/9slK+y9wg3dDrjYlK92VxMFBAr3Nx4ZbNKeEwkaz147MtNxSWpHpCDqavTUy6beJwg+zpWTNOSjbUfeGyTA6Q4SiByH9CyywjzFiKJ4dNSnCd5v5KZgDLNQssziF3O/j634iZo3aN0pFyorCSPVwEtNaAQR8FLZ53mdobYxlLiUnO5KuBpMuipLcUH6rrVKX1DhpAVAGgtnZcN7X5h2C6SMYKYa+Q2XTO2yYeEnDqe+vOEXjzh0HTn+XH2Owww3rCF1AitQzPnoM8LlzG4LI8CXGjREnduDGnogcP45DTxTfKd2sSSq6mqyMByb77G5UTGPrnSUFmcPhZzxBXPRNmqgNMV7oNvyjc67z96ATxx1+a22zpoaVWa1ws+tocwLXjXiheq4uQQFV10H+o5vlYOHkHlt3hGM4K6x0+Wuj0hEm5zM2zntJgDoBcrNp/pplOEWnJX/TUEQFUj1rk2yVNQ9Lt6YctORmt5OTEJ1cDDm7yNzU9M+CfR4QkpirueR1qSqtQB41yZrQqyMtQsq0rHpie4xqudtgpG4UsOL+px8KK0Dl3bV7JuD5bEYeaAGvpyqTsea55KY/hyd+TwJeJhuuWiJnbQLlqyiruEG2Kwp2C54A3T7qMURFk9WI2ew2/xKX97SQyuM2Pqrl0jtXZlW+OHjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cYdeeKvNImZDb3K4DfY1uDckHws/liQQP+UB4x6pV7pGWALKgFI0pubC61cB9kXwkap10pv9aSjU8A+AVMSeAPeNVg1Er65av3j7REr27l7qusFORiL66FDl7iCDmxiI3wEfHbOiPYS7Q/RlVBmdmoYQq2QfrvS1qBpH1LYHjvaLsE4B/nmD7Ivpek/GanpFLM9O9Uhc7SO3WpPNmUccoZmrwqLf15+PlpLehM5YJK8y8yFeWpZo0r1XQsRhVwXY7W22nFX3W46VY/zEw8OggLwvsO6xkWvbRWK9SPGWOZYQbczKz7t1Yc4N9i6NQjuL6SqeWrZb6ybnXuvB/Pd2ss9+tddnoLq/JYEDbt411TMem0zBpy9rfCzQh8qPTG/18TsB9bOoHBy0xu3VF52dCTAna97Gzpj1HyR3uRvXq4q5yvKIuxHC9hVl1HuyTTfa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 01:17:36.9922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c03ef2a4-1439-443b-bfc9-08de83c2f9c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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

Tighten the early parameter checks in the USERQ SIGNAL and WAIT ioctls:

1. Validate num_syncobj_handles against AMDGPU_USERQ_MAX_HANDLES in
   addition to the BO handle counts that are already checked. The UAPI
   field is __u64 but the driver stores it in a u32, so the comparison
   must happen before the narrowing assignment to prevent unintended
   truncation (e.g. 0x1_0000_0000 would silently become 0).

2. Reject inconsistent pointer/count pairs where a non-NULL userspace
   pointer is provided with a zero element count. This is clearly
   malformed input and returning -EINVAL early gives userspace a
   deterministic error rather than silently proceeding with empty data.

No functional change for well-formed userspace callers.

v2:
- Reworked commit message to focus on parameter validation correctness
- Updated code comments for clarity: describe the type width mismatch
  and why the early check is needed
- No functional changes to the code itself

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 37 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index fad595401a77..575dd58ed152 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -480,8 +480,25 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	if (!amdgpu_userq_enabled(dev))
 		return -ENOTSUPP;
 
+	/*
+	 * num_syncobj_handles is __u64 in the UAPI but stored in a u32
+	 * in the driver.  Check all three handle counts against the
+	 * maximum *before* the narrowing assignment so that values
+	 * above 2^32 are correctly rejected instead of being silently
+	 * truncated to a smaller (possibly zero) value.
+	 */
 	if (args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
-	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
+	    args->num_bo_read_handles  > AMDGPU_USERQ_MAX_HANDLES ||
+	    args->num_syncobj_handles  > AMDGPU_USERQ_MAX_HANDLES) {
+		return -EINVAL;
+	}
+
+	/* Reject non-NULL pointers paired with a zero count. */
+	if (!args->num_syncobj_handles && args->syncobj_handles)
+		return -EINVAL;
+	if (!args->num_bo_read_handles && args->bo_read_handles)
+		return -EINVAL;
+	if (!args->num_bo_write_handles && args->bo_write_handles)
 		return -EINVAL;
 
 	num_syncobj_handles = args->num_syncobj_handles;
@@ -639,7 +656,23 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		return -ENOTSUPP;
 
 	if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
-	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
+	    wait_info->num_bo_read_handles  > AMDGPU_USERQ_MAX_HANDLES ||
+	    wait_info->num_syncobj_handles  > AMDGPU_USERQ_MAX_HANDLES)
+		return -EINVAL;
+
+	/* Reject non-NULL pointers paired with a zero count: the pointer
+	 * is meaningless and indicates inconsistent input from userspace.
+	 */
+	if (!wait_info->num_syncobj_handles && wait_info->syncobj_handles)
+		return -EINVAL;
+	if (!wait_info->num_syncobj_timeline_handles &&
+	    (wait_info->syncobj_timeline_handles || wait_info->syncobj_timeline_points))
+		return -EINVAL;
+	if (!wait_info->num_bo_read_handles && wait_info->bo_read_handles)
+		return -EINVAL;
+	if (!wait_info->num_bo_write_handles && wait_info->bo_write_handles)
+		return -EINVAL;
+	if (!wait_info->num_fences && wait_info->out_fences)
 		return -EINVAL;
 
 	num_syncobj = wait_info->num_syncobj_handles;
-- 
2.49.0

