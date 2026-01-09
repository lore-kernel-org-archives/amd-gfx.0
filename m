Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4696CD1A62D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 13:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12C410E8D4;
	Fri,  9 Jan 2026 13:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LwqVpuvD";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5649A10E8D4
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 13:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMc+0F+7JGlxGDdSuqrszJo8N1Ro6IqWDQxgGggCH4CsITgoLtDfz57C5sbBiduS8dFaqosB/Ya6JXTvJdns3qZGzUkxl/ohE04dmaQeaewR3KmsU/meswQSZyjNvRw4X7lF4zU8mc9/TjRSdRBY4tsv+YYQNeSPv+b756vFYjCDpikJITEHpeABlpuL8/p/VCVsluovGU8gJBSnj1HXTu2ig09PBoHfwFZZizUoa9i0UjFPztfv+zbLsCbl8T6PRJ5QeX6umeqlnXuTYw5CCBut7syYGqPAP1UhoWJjOsEL6PpM2nLUzl9m8BVoqaP8YAm0CJuC+qL+VWzDI8eK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WksdhiQ7U85i/zn5P7yxsuqhUSaj0CDFx3siy/2VC9Q=;
 b=UU2mi1qB+cU3XQ2EPxq4i/2HMg7LE1VNLXpbVT5DkYYppvhM5zguMwkiR5TTE9i5h+lz/H46YiSPuzoHvek/NzQcOdo6qr/H/SmlC/p4vcDXA6FaaS/YXnGUy/kdneOFPQl10oyPJUb2lhBLl6wK1ptZWOWEYPqML4UPvmDC9CWrv5BUa0XkrPCA1fFVlukLuiT340esTcbEVvLXEXNA2j5GDd8acLWaoyumzz8mUK36/krQ26O46dCu1vG/t5CIrz9yY9g6DnAvXg3pF27yTDoGeTTU/SlUX9/d4cLLc9zkQ/oXhfiRAcKAjw9iJepqVSV8jpHjXQTnyJZyNIhYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WksdhiQ7U85i/zn5P7yxsuqhUSaj0CDFx3siy/2VC9Q=;
 b=LwqVpuvDlPj1Ic/t820qaItqHNzmD0y7FqIS0Zm/WmejuPManZRm0DRCvwpK+dmBYjIdTqzcfahs6W8wIJr8wRvjD7EHho/nwc2WYJhogoqI0HTt5x7CkRfSiXxUC4Zv+f/ChiFkazisr4BOPte+IugN9g/2+YlbTCmIbse3UYY=
Received: from MN0P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::15)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 13:57:50 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::39) by MN0P222CA0007.outlook.office365.com
 (2603:10b6:208:531::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.5 via Frontend Transport; Fri, 9
 Jan 2026 13:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 13:57:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 07:57:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 05:57:49 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 9 Jan 2026 05:57:49 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <Prike.Liang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: make sure userqs are enabled in userq IOCTLs
Date: Fri, 9 Jan 2026 08:57:43 -0500
Message-ID: <20260109135743.3241773-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcf2ac8-616b-4128-83be-08de4f8713ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yFcrNmgR5AObRFqLmsQ0Kxb8F+uKWtTnUvWSqb4V3DYMe+Xkh+rkkXn/IIXV?=
 =?us-ascii?Q?bJ5v7AEziet+pMNlXRM1YpRmGV6uSkfAiNVo2q0OpEpyfuOPIYetSasC7dg3?=
 =?us-ascii?Q?qu/f2cYcQ9+wYQPukbvKI9xrUX5lJUrMWmfhR51SXUEGOJtCHImdUqIq/uJe?=
 =?us-ascii?Q?c0hW6VpJhdevrUBNXrgvIjK2uhVJXECZfA4fQsMA2jBkQkkP7FpaIfu1xpJF?=
 =?us-ascii?Q?ZSPBVPo8yEr8lAUxbayOdx9kZFCZ8zeulccAxx3YD5dRVT1t1e3Z6U8YOLoI?=
 =?us-ascii?Q?0O3dW+rvD4y3mPzLSSIBsWrKAEgmmzl0HNfi8+cef+akK3u9aM53GZjaHWJQ?=
 =?us-ascii?Q?lXQG9C/0D3uSdwxyA1dZt5vYweX3uBIj1vxLk6/OGCmH8MgicQx3ORKcCHmr?=
 =?us-ascii?Q?cJvFNDxc4zuVX6CaZqHdsQ9hUnjYAqbdEGnXx3a7f0LkHdPOMjhAg/kbsw+1?=
 =?us-ascii?Q?/aUHrLeIXC2wFyhSYWeWXgAHXR8WXgdcR/rwbP+QuupFFrYp9UjVEil6+twL?=
 =?us-ascii?Q?g/vqC4XMvsfQKTDcnaLroG0W43lOn4g8SD12UI50H7fFvwblrlEKB36s3QXv?=
 =?us-ascii?Q?kbtPl4TyAb+XFfkJzwx0aVHfwvyn12U55jTUHs3FaQJAOZGuSicD4Mgr1VmD?=
 =?us-ascii?Q?mOkMLgBrdSXz0Xlgoc9IOJJKRnnqKsIeUhl7SAeu4K7L/zdJDRNN2Nrb6Qtu?=
 =?us-ascii?Q?kG78BnuwMmXiaqN1bYRA7KdfBdKy/mXscFy+88r45LD0SOKbMyyNNMzJrVHt?=
 =?us-ascii?Q?hANOOaNqrHoO7qQ9VDnU9sWNxsv7E3xrrSM/73LypSwgby7j0+12W6MXsktJ?=
 =?us-ascii?Q?K8vaMPAS3X9m1sqhbYIlnQXfQtVGXU5AqQW64pnx7byXbREC/LbqcxvEthW2?=
 =?us-ascii?Q?QcL3qvIgrHe50KCQBdQeaDxJjuyUa0zQOZEar458ikM5zkedloeLjj9q+HRE?=
 =?us-ascii?Q?16SGCa+k84d9POJjpOZuCb7I+uNXmcbFLoeoLjJRNebHJujYdIThp0ynytIF?=
 =?us-ascii?Q?nsbePDaOK0EyaS23B2ESpvR4AYAs2/ANgbJzWhrJ/xzgE5Het/O+bjmIQjm3?=
 =?us-ascii?Q?tIVQ4lIdM19j0Ls73/V1QU0W2bpf1UDHyPP+7Fcw8MLy0Xc2QojZSvPEdr/v?=
 =?us-ascii?Q?QMq7J/eXpro9IYvCSQpjVR4wiyji0czeuVlLir7R4e0g/78PeX/ICivQcFoB?=
 =?us-ascii?Q?Rq4CX898JDFh7wsEzN3EjpgEywA/jlLo1FRe4EOLnHwsxN4UZoMUvZ+450D/?=
 =?us-ascii?Q?aXUBxngU+aFI3okNRtNtNtn4qWYeZGrDkV/efxz24tyqnSkvDob16gCg3qUg?=
 =?us-ascii?Q?tNXsqIclgbTlkrLFk+esaPb/Pkxjg+JJbwKeuj5+8M43lnFpSOd6RVMYW8AI?=
 =?us-ascii?Q?6ON8nvTCewPBkyeqTYHDS/E+ufnzzQKJTtXe+lw0aAjtUM0O0+Wcy0uQ0XGX?=
 =?us-ascii?Q?qZvmNiT7Phgx0FD0IxAljV0uFQZdGp5NrhkXflQRmxyG+sA2Fueac8AByt8d?=
 =?us-ascii?Q?/qNa1hBnIQjEco88Br+tzYpaMO0lMu6T3VWSA3SU5TmnbK9k2pOPihlAbWwt?=
 =?us-ascii?Q?wnI/jiiqzTL3yEB+n58=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 13:57:50.6077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcf2ac8-616b-4128-83be-08de4f8713ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
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

These IOCTLs shouldn't be called when userqs are not
enabled.  Make sure they are enabled before executing
the IOCTLs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c |  6 ++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 98110f543307d..256ceca6d429b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -888,12 +888,28 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 	return 0;
 }
 
+bool amdgpu_userq_enabled(struct drm_device *dev)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int i;
+
+	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
+		if (adev->userq_funcs[i])
+			return true;
+	}
+
+	return false;
+}
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
 	union drm_amdgpu_userq *args = data;
 	int r;
 
+	if (!amdgpu_userq_enabled(dev))
+		return -ENOTSUPP;
+
 	if (amdgpu_userq_input_args_validate(dev, args, filp) < 0)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 7a5ec17704567..468b65d953b0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -136,6 +136,7 @@ uint64_t amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 					     struct drm_file *filp);
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev);
+bool amdgpu_userq_enabled(struct drm_device *dev);
 
 int amdgpu_userq_suspend(struct amdgpu_device *adev);
 int amdgpu_userq_resume(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 1a23e7709dea9..d6fc65803a309 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -493,6 +493,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	struct drm_exec exec;
 	u64 wptr;
 
+	if (!amdgpu_userq_enabled(dev))
+		return -ENOTSUPP;
+
 	num_syncobj_handles = args->num_syncobj_handles;
 	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles),
 				      size_mul(sizeof(u32), num_syncobj_handles));
@@ -680,6 +683,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	int r, i, rentry, wentry, cnt;
 	struct drm_exec exec;
 
+	if (!amdgpu_userq_enabled(dev))
+		return -ENOTSUPP;
+
 	num_read_bo_handles = wait_info->num_bo_read_handles;
 	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
 				      size_mul(sizeof(u32), num_read_bo_handles));
-- 
2.52.0

