Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8472EC87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 03:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257DD10E8BD;
	Fri,  8 Aug 2025 03:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L87ZGEoQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561F010E8BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 03:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0UOPzObA+1Ej5BV5P3oYi+ndfH+bhfoNFysApqnhBm9lCJmGUUx+eKV/ilOJg+w/kesz/LrDLvOblf2yqgTIuE/UHBSSxpYjMqJMvNycy/JnCt2ba3QkD1OYYtYmLx+YNB/iI8dHHTBE0elhZ2PEdIoNSi8fHUaKvLTiUQcuR/NpPNRb8jrgYF3hOWcOJ39L8ZsA++2ia9Zj3xazLZszTdUZl//NQVcMy1rozGdZmpIpdEGLEHku0jLdh7oa54oIT2FsYafyj/2/qBP7lbu7y3OQuBId0n5bNvsWQmhsM3OxkR60x5t2MrJWHf2dhcUSrVblTrx0X1xLLKuRlLRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCYHmuzJks6AzYLKrdNYuG2iOhtDDCZ9Jt7mU0m3Uxw=;
 b=L6wBx2+UwFiJmoDAALj8y461Uh8wiFxTvT27LuQQ6dwaLbW76MOW4V46mqRgARH3OxlmhFlcipHYC0CGLibuE9eF/tDqXSvbYwgeIsimhaNTqW6T7E3mSxbMwzDrEpcQr/8eEwGLOHlpPTrLhfIVLjC+A8vUoD+6jh/mjO1F2EiWQVwlAc9rtLFgyvZGN3lgayQE+KUJZbwmRP5QE+ospYSS0rlzfoNJPTectdk6uGvvHP6djqVwBeA6gy/GUPXudsaJ8TTjYJ664BHwAWlCDlemhVPjOe2ntm310AoOzU0p43AyP63wo+4chVS3Ta/4x26Uf4olDaDY+EM6J3GH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCYHmuzJks6AzYLKrdNYuG2iOhtDDCZ9Jt7mU0m3Uxw=;
 b=L87ZGEoQODCuEEvQW0stbCc+b4jTVCoidfxY7NmUQD/4v0PeM/gB4GqqrMASbZ4h0s1Z82Gtkg3mXjmagISOA7y6O9eVEQKbhD7U4n9IpIekK/K98AZbUX7e8KbDsoWYLTwcBNDJoFEe1kdzzQzpKWk+80/HPGePaRIRii8QGKQ=
Received: from MW4PR03CA0213.namprd03.prod.outlook.com (2603:10b6:303:b9::8)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 03:14:59 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::47) by MW4PR03CA0213.outlook.office365.com
 (2603:10b6:303:b9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Fri,
 8 Aug 2025 03:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 03:14:58 +0000
Received: from marui-Super-Server.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Aug 2025 22:14:56 -0500
From: Heng Zhou <Heng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, Heng Zhou <Heng.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved
Date: Fri, 8 Aug 2025 11:14:27 +0800
Message-ID: <20250808031427.3131402-1-Heng.Zhou@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c830ee-29e0-4fb1-ea1a-08ddd629c1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7FjoTJk9jcZoCZ13TZNuIWbewn0FA2JCa3l1+tYqp7PtFlkM7z5ikr/Y8J16?=
 =?us-ascii?Q?cB0tCWVtdBawYsNWe9GFbt3W3YxZuet9SN37OrzAppK0ZPoPLSQRf7RV68A5?=
 =?us-ascii?Q?hSHELGF5n5/F55mB/Z/bzDi65dEjtv4IWbMnHOlCe5qjQ9/Fm8srW+0AWEg7?=
 =?us-ascii?Q?Cl49UFAT6eUFzMXVl6TVhErGA9EKkUj5XLrdfA9eTgnMXKVrdWA0qpvcxe9S?=
 =?us-ascii?Q?A1vaEnxis7ZBavJXqxNJ35/eQfdD3pzGzsndu47SHqG0y3zBNf0vuHkaXz7o?=
 =?us-ascii?Q?VL5E9zLkySC0auL2mzLzOXN0BuHxLAxFt2VGmI5SuL9ML5AH4taLbaXLHL3b?=
 =?us-ascii?Q?bS3YWfjbta/UyTlsdfUijAyQgt/l5v4Va5oq6bBE8HMh52Bmt7kUi+3mqBK0?=
 =?us-ascii?Q?XT6w4pCxOpaABIVpzizSzSn9QWYCyM4UzCMx9Ph/EAdSzLPWmYCtAgTd+eX2?=
 =?us-ascii?Q?FBvhrtw7vUf2FYcqSsN/Tf3k2Qtq6hcyKy6jnjKa6O5yZo3pQAWS7KtCExqQ?=
 =?us-ascii?Q?XZhm6s/kIK877nIHVt7MyA0+iFk80cz7iWE3annbvKef4N77Tr8zu4i64XxA?=
 =?us-ascii?Q?fQYmsn9PFDY5lvpw2mcMJv81iUociFSJry3FTVAIfuQKCycpo8Xiwk4j+hMP?=
 =?us-ascii?Q?9f9tfhmt4uULN/V4prfszKpgz1noAvoB8MHMujKRr4II8ks3kw8YgrXmQU2B?=
 =?us-ascii?Q?pZH/W5qOIUt3kT9k6LUIts36ZJs3VjiuKcprrMIMs/iPTmmaRzsOW3WM/Uhw?=
 =?us-ascii?Q?kYlIltdMzAukHo85b8sgSrJeKVno+qFSR4kr90TNuWCaJR/0brRWKI+G5N7Y?=
 =?us-ascii?Q?eZ5PhkoAQsrpse2ZXmTRmBbs7HHcdNl+fBijvq/knWTnsxP9hfunHtq32PRF?=
 =?us-ascii?Q?1cpPr3Z97lr6qU2gjxdgJckSC7M/j7jWVLQOaP7ZuywLOW6Wlab6t4d6Y30L?=
 =?us-ascii?Q?ug/+saEUMtiD8mp4pQ4rO3QmbNysuX9GrQezFCTzVGt8TY2ioT3uljVI9hcF?=
 =?us-ascii?Q?a0UGZ61mLPdYmAjUNTfbtjFdPKm09kml+ceQS/SGi8XIvkXeVkA6uZ8iOwT6?=
 =?us-ascii?Q?o0SrwcnBEyI4mbJ2p/q33p0xsQ6wmN6PkzLlOzFbt+W4BhKsQmw/2Ie1vhmy?=
 =?us-ascii?Q?UPEKa7T3W+7whhgN5nzdBWM5aqYgBcvFf2fhV5CDlaIrQ0cx17vofwSaUcob?=
 =?us-ascii?Q?isGShqrNGWAnj/seBIVXh/ea5KGvVbifxrN7hIb1Db9u8u/fc2CRtHW7IiY2?=
 =?us-ascii?Q?Yaeu8VNAcaeZia5cFk82KeHTPFp+AnliSGfhqLerIU3AsZObt/jVeC4C3FJj?=
 =?us-ascii?Q?LrOhjr5poxquomBNcovp5u+zWOsJbXZTnJC7p3mYLvjKejue5An3+grZD4JB?=
 =?us-ascii?Q?LR7knf9Kz5xLYViGNRJ7bUs00dElhtTTbOSp8XIz8xvkot9usmUtORVCTblO?=
 =?us-ascii?Q?EW5nQfM+ddh7KQdHwBhaL4B5c/Yn50kSUZ1U6bEKdenSI7RexLN2hZ97Gr0c?=
 =?us-ascii?Q?6QCn6+Xp/+9UCdTlfgUxof2P1eyjOeJTIgDb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 03:14:58.8765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c830ee-29e0-4fb1-ea1a-08ddd629c1cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
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

If a amdgpu_bo_va is fpriv->prt_va, the bo of this one is always NULL.
So, such kind of amdgpu_bo_va should be updated separately before
amdgpu_vm_handle_moved.

Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 37d8a7034a7e..e795b2970620 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2970,6 +2970,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 		struct amdgpu_device *adev = amdgpu_ttm_adev(
 			peer_vm->root.bo->tbo.bdev);
 
+		ret = amdgpu_vm_handle_prt_moved(adev,peer_vm);
+		if (ret) {
+			pr_debug("Memory eviction: handle PRT moved failed. Try again\n");
+			goto validate_map_fail;
+		}
+
 		ret = amdgpu_vm_handle_moved(adev, peer_vm, &exec.ticket);
 		if (ret) {
 			pr_debug("Memory eviction: handle moved failed. Try again\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 283dd44f04b0..2c2a93f22ba0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1569,6 +1569,14 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 
 }
 
+int amdgpu_vm_handle_prt_moved(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	struct amdgpu_fpriv *fpriv;
+
+	fpriv = container_of(vm, struct amdgpu_fpriv, vm);
+	return amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+}
+
 /**
  * amdgpu_vm_handle_moved - handle moved BOs in the PT
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f9549f6b3d1f..853a66f9fd2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -504,6 +504,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm,
 			  struct dma_fence **fence);
+int amdgpu_vm_handle_prt_moved(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm,
 			   struct ww_acquire_ctx *ticket);
-- 
2.43.0

