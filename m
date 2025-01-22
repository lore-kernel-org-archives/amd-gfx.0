Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2862C02182
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 22:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A74C610E066;
	Wed, 22 Jan 2025 22:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qEC15Eiu";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3AA310E066
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 22:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUc11sJQpfBXYGLHFUv7strye9m133F3yf7RpvmlLL2lGojZjEf0HrQgAUcIaBNKk9R302rqcv+hW/KIGwjq6W+e2XZ3nkweWULeP5/BYZA9zxpQdZK3rYw2X05YLnVGi2vXjvlNGTdEOlJZXJXxeoPuYyk1/kPGRyvfeOTmu61J50AoVJZ3FX3I/jXy87E62BYsVfSYObxIL/PCQnLw+p/EGIrYD9YuzzdpB5hQu0epv3L+rkEKcVtqcUQe1x47W7JdtgA8DsldP6LTsvddZ4zkF1mJIKGXhnqQTjuMTBhBhv/aEwRRmUx1ypRXNuxg43J1f7GaPDVDWKhpPPEYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4c4CHJIPbnpCEFDiJPK+0lAglfxT9NT/lbBvRSn0Zvs=;
 b=Yk1IoOfwahBzaKE09/mSp/gzPQeKqHaxCd27jm8uAFowgRLamOFLrOkBLlKxNuLj3+U+sRsVQTP/P6LbJVMXh3hKOiZV9G1IioKHNn47BHZbBwEHhNa0DBK58J+QaXf4tO0emOjYnrSbWt6COQv/yoi9yyXMQB1E1uOS9tUWQ+3n79CEh+xyDNkuYVcFs7RHU1bR5wwQ5Ov2JTLCYDNijxSDpWyAJcuMNGfWpmon98zFc3IGhbwe01s6QyctBhaXuHCC9hojyyxScwsHdCT9a4QclgYTbQL+FQWgKskDZ4IY6t2AlE83AtcwiiEsrXLBBuhVXpNKyp3PY5nC2UMGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4c4CHJIPbnpCEFDiJPK+0lAglfxT9NT/lbBvRSn0Zvs=;
 b=qEC15EiumrmWq5it5gUQzBlwJFFXYcxjNEINSDmfjmiu118nZ1fuprEYDkUJNwO1VybNOJ7iccfSkrvVJ8T5w/EJJh76Cx9MlJj6HJP52VwoTwurctlMZOQBBufaJkRxU1+E5QgUw8j4mccbzNtZOaOLi/hJ30e8drjvoZm06z8=
Received: from BN8PR15CA0022.namprd15.prod.outlook.com (2603:10b6:408:c0::35)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 22:00:32 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:c0:cafe::5) by BN8PR15CA0022.outlook.office365.com
 (2603:10b6:408:c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 22 Jan 2025 22:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 22:00:25 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Jan
 2025 16:00:25 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Zhigang.Luo@amd.com>, <hawking.zhang@amd.com>, Victor Skvortsov
 <victor.skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Skip err_count sysfs creation on VF unsupported
 RAS blocks
Date: Wed, 22 Jan 2025 16:59:55 -0500
Message-ID: <20250122215956.421185-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: f4477b64-85df-4858-a752-08dd3b302d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TEGv7icZ+xkGtM/DQ4/lGPOH0EaE0TpgsZ9u6MvUE/yeWdFBU6pJTf6+kEyE?=
 =?us-ascii?Q?udcFc0yaYKjek6kdym4P5MfaiOdwP2VOdVmFxFuLx6AMiTNsONjoE82zAUnA?=
 =?us-ascii?Q?Ey1iJ5oBychC8AZEUb0R/THifFO8t2j7anLjH/NFKqfoq5ShShcR05cm7WUB?=
 =?us-ascii?Q?P21/5QkJW7IUZVkhtrh4fJdX7lWav+iTYhYviiS4lKEOm1+l0ZYO8p71GelD?=
 =?us-ascii?Q?NA7733Sz4araM0L0qfrmESDOWOxeR9fJFNQrSabhgS+bseM+AMviPfWr1HaW?=
 =?us-ascii?Q?deCvmBR/B2LXykHxkxQOCnSGNcq58Ptin/yoL1tMObGNcolQfH0xPE3NLBN6?=
 =?us-ascii?Q?bVVQXGOxUW0YmzIlGHk4MOSHYQc30S/wOofttiIOidR2ypbzIJUaq3h6kvoe?=
 =?us-ascii?Q?Hoa1Svue8s7qr1h7PrJxuFoeQWDN3rZifcE97gOHMwVLjOP6dDfUWSoD127d?=
 =?us-ascii?Q?8igtoBIQN+TbVrFzAJRCm91Hr5+X+m/bG1M40GloHVSflvevsO9z+cdtkugx?=
 =?us-ascii?Q?yiw+1pRDjLdSVhxEqvH8ddb9PnKntvyGPDKe5vlG/Wbu8hDZ0qtxMYjmI6UZ?=
 =?us-ascii?Q?vCw28xTIp7Q8NHgdac2X2PFrjzZX607chd1XnTda1kLGFen6Ks4rIs7ZkQYB?=
 =?us-ascii?Q?FnI1l8q8xARk2djqc7O2bANwqSJQsOzYJeI7KbyhC1KMPCuETHcrvxVJu7Ms?=
 =?us-ascii?Q?ZDHbo4yWddoDegqZ+wZcyTuTxEYxaHy/i5BAxBeojGsWLbxd54ILkLxJiill?=
 =?us-ascii?Q?PRx4wxU8rDDXSpPOlNaJE28UUsKEAhBFbHRYgnMVfFmGPMHxQOJcQEagPiUD?=
 =?us-ascii?Q?Btr9B9W1rQIg8RuYW3bWWwSSGEn5li6w1HSppaGblqqxilX+LL6DBHhjEB9U?=
 =?us-ascii?Q?nljXnF0RQFkEwjFOu5WJihe519JZ5WLyRrbP2rVL7Cf1KpTkwrt93Urhk6dI?=
 =?us-ascii?Q?UW3Ijpo0J408jKejO+TcdzjTb0LpwX6i0kZg2PpfM5xim4Qu3yc14/hDw2C2?=
 =?us-ascii?Q?N1563zC2HJy8+9UPy0eOonnzRa1zfzovVtb2QsmGBHbLk68qf/brqKsLBF0c?=
 =?us-ascii?Q?PpVANJQ6gq0Owa32eBje1R8ARHTRPidwxEIwSF4rHmoKVtBS1MEMOZAT4lwi?=
 =?us-ascii?Q?gec3ccDlsiwAQcZvv9sUbFYfoUW+pmAYwdiJN+TQMlijxDf+RioqxLoIAH11?=
 =?us-ascii?Q?lkiJDJjFJdsviQIzakKaSgJZ2dtNuvDL1O0Vls9WnEbwwip+FAkL6YZ1dRaL?=
 =?us-ascii?Q?gcTVtMBTnmyb8Mgn4Bqz0DjGsNaUNCW06Mh1vtBFznRu60tpy3Xwklf5H/1f?=
 =?us-ascii?Q?LHrGgds8Qv66/Ntbg2uZubef6j8zYLTaVmhUr4SOHBG8CYmi3/3pWrCqM7Nl?=
 =?us-ascii?Q?L4I+hXz1l8IINT+j0Rx1irRwzKPXMZgMLmrRh8l/SRo6xMu1W2yr+uWd1Cva?=
 =?us-ascii?Q?2qCQ4LtpGjE36A6bARzcGSzjm2Q1oM/Zsqdv0xtAPTeavsSLZvTHwaKBaqi2?=
 =?us-ascii?Q?mj49qsOGqnMQxgY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 22:00:25.8354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4477b64-85df-4858-a752-08dd3b302d2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
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

VFs are not able to query error counts for all RAS blocks. Rather than
returning error for queries on these blocks, skip sysfs the creation
all together.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f0924aa3f4e4..0c338dcdde48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1864,6 +1864,9 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device *adev,
 	if (!obj || obj->attr_inuse)
 		return -EINVAL;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_virt_ras_telemetry_block_en(adev, head->block))
+		return 0;
+
 	get_obj(obj);
 
 	snprintf(obj->fs_data.sysfs_name, sizeof(obj->fs_data.sysfs_name),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 0af469ec6fcc..51ec98501aea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1246,7 +1246,7 @@ amdgpu_ras_block_to_sriov(struct amdgpu_device *adev, enum amdgpu_ras_block bloc
 	case AMDGPU_RAS_BLOCK__MPIO:
 		return RAS_TELEMETRY_GPU_BLOCK_MPIO;
 	default:
-		dev_err(adev->dev, "Unsupported SRIOV RAS telemetry block 0x%x\n", block);
+		DRM_DEV_DEBUG(adev->dev, "Unsupported SRIOV RAS telemetry block 0x%x\n", block);
 		return RAS_TELEMETRY_GPU_BLOCK_COUNT;
 	}
 }
@@ -1331,3 +1331,17 @@ int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
+					enum amdgpu_ras_block block)
+{
+	enum amd_sriov_ras_telemetry_gpu_block sriov_block;
+
+	sriov_block = amdgpu_ras_block_to_sriov(adev, block);
+
+	if (sriov_block >= RAS_TELEMETRY_GPU_BLOCK_COUNT ||
+	    !amdgpu_sriov_ras_telemetry_block_en(adev, sriov_block))
+		return false;
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 5381b8d596e6..270a032e2d70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -406,4 +406,6 @@ bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev);
 int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu_ras_block block,
 				  struct ras_err_data *err_data);
 int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);
+bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
+					enum amdgpu_ras_block block);
 #endif
-- 
2.34.1

