Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2155CC71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 03:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC24B10E26F;
	Mon, 16 Jun 2025 03:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EtF/JqIz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4203410E273
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 03:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiE+UiyiHhlCtMMuIPqCnrFOZLYTkSKc5gmEVdndpI/CDchqtPcEKhqx3NbDChU+gtImBVBccMd2gUXYRV7Vdm88z5etDbLl8Yew11ePZPQN5Yj72DigXyIFatXbP5W5l0BfQOIa7kBMfRIQHlGva3jHps7Mi4Sn0kEHgN4qwxLHmOQBtm+27jom1jggEBO39GHXCnyLSL+FYpcibpSDDTGCs62gniVuGKWAKijvxS2Sq9zTxZiKVpqFQHZo11Bp6727YFhbVAC4W+xeXNxmvP2p6hxg4kJhJBdUk4n1m6kve+kLXNiYFH9s7IThv2AHHBHaJILkRFWtbC7yy74i3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdsTfCHUNqZvyGaRYC+QBT9ccuJqZaVDZj/SQZksYVY=;
 b=Zy3kTnmdnu4KiSeliHn0+Eyx+YO/PMga1+SgSEJTvtnnxKvdX4x6hCMTDSLpKcU8WYJCxcZEDxAxUELJmQpxdjUZOPeXFVetZMLZ/V871BAcVeFf/N7FEr9S0zVIRmgkLNuV4/21KNXOfACErDQ6Z7qvP2EixjysKLu21BmR4qWtLymqxt2p/aIBEdOl/hwWf+oaOhf42PSEIIwk+rABnglXx9QnIBJxYTnOuygm2Zq9O7hiyX0TydGwDlgyVhpfKuA9FVXuhutRitQnrAWQ8yb80ixJxRLDarGi454DUSYHTk4MRtdtw8+/AgkmfozxsUoNWBX8Uac2IyyCWpEqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdsTfCHUNqZvyGaRYC+QBT9ccuJqZaVDZj/SQZksYVY=;
 b=EtF/JqIzRv1aogdxetJu5k7E2MrtP6BV/MkdrnB3/HJhvz+p7GSXfS09gujIMaNxsmaPq4rrruSeXwV/2+49NpHxEoqitKfPMEYxhssnc03HeXkK+RXJygy/tR79oLuUjOTUfSHRqoKAUcotQTHFmQBNaw2U5TQhF818LqEU5Nc=
Received: from PH7PR17CA0065.namprd17.prod.outlook.com (2603:10b6:510:325::9)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Mon, 16 Jun
 2025 03:46:45 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::b9) by PH7PR17CA0065.outlook.office365.com
 (2603:10b6:510:325::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Mon,
 16 Jun 2025 03:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 03:46:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Jun
 2025 22:46:43 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 15 Jun 2025 22:46:36 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v2 7/9] drm/amdgpu/userq: add force completion helpers
Date: Mon, 16 Jun 2025 11:43:40 +0800
Message-ID: <20250616034605.2683434-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
References: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cbed97-3cb6-46af-e39b-08ddac88695e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WcneSKBTmyvqf8PuykrmrvTrki5iXgygOINorjfoaK5SlUJIsqadErQy+2aV?=
 =?us-ascii?Q?9uQLb3SUyjKjcE0sa3QR8PfdVKk1wOkkS4Cqvc6GzVwDhcpGM5Ra35L5okSX?=
 =?us-ascii?Q?IIpZVGSTyh5RO7Z1VETCxcYDm12U+Wsi09HCBstN+AVcCjk/KLEdUPEYBpHq?=
 =?us-ascii?Q?yBw9FRC4HZc5dr6IWn2kLv9NbhvKJO6tJHQNMX/a9CfxDAQT8wJ729NU+m/m?=
 =?us-ascii?Q?b0yhD7QSQoEyf5H5/Lw3uK0RpWu2VsS6Fh3CbCJMLk/unwYFiRazy2/uS5L2?=
 =?us-ascii?Q?67uQmkmAIditrPmXNoOHbtCEQ+qvSqgmFhI1iFMqYAPc34B3on/d0nyTYKLm?=
 =?us-ascii?Q?jFb1POu8U8oX6N9lIw/6OMa1OqeUBsJ7z2Y1yKfWxTu2e3ebsNkBqPvuS1ls?=
 =?us-ascii?Q?GtibkLaQnU0NXORoZ6WugAisXznjqdtYSmNWuZeGFvijmx0H+Rg7mJ0vO9Ly?=
 =?us-ascii?Q?C0Sm4qu+c9yY8tpLHKEJcS1XkPr3P45DIh/ONHKljsavKzKFJeVPjnPxTLm4?=
 =?us-ascii?Q?PghqW0wTckmwe6JES7NfLNL8Uslv3Xabf3kRHy2A8jfCIKNntTi3vpbdLpBa?=
 =?us-ascii?Q?Rj0R8S977USs8o0RkURq9Eqlwe378M282kdFpB+oOx0Y68BD0KGkYo6mi5l0?=
 =?us-ascii?Q?8YHHj+pqhNjaYqcWbIh9EXVK/npiZd3i6vvuWksoiHlsevde1vzDnCM7wjHo?=
 =?us-ascii?Q?mmIfCV//b+kBqp5TDDVqptgWBkVGMRN7jtmLxrnx46kKKyZmXGKubLCiswiL?=
 =?us-ascii?Q?9vC4C3Jr+oKPn0zE2QEz4Eul6mMqP0fHZKUfE6HFe37u7Cl46UZAMcLoi446?=
 =?us-ascii?Q?PYTPVbKhceHDABi7xVRbDACKtSj0GsmJkdhCAscF+T28jPuSzvmgjv1vit1p?=
 =?us-ascii?Q?6KhOfML1VhGLN84Lv6Gehe1GOoQxtcVDb0DrWwyh9IpoHLZbHHeVCLnYQE2S?=
 =?us-ascii?Q?q8dY4G65/Vb5cZMRYZ/ODYAvcZ/dIbtR4V6VTor6VoLC/TVDw5YPw4+HL7CW?=
 =?us-ascii?Q?TtT0Yuy8bK8kbVVQ2n8tDaHPspNo3HPwGsKv42r46M+M+iTGKbxtNYQMCKvm?=
 =?us-ascii?Q?bFxYAYYy2qCprRAMB6UmPNm6xdFTnToV/6CbYqgbUrbclzcCRwLFt4JCgGod?=
 =?us-ascii?Q?P99dUuoQil82B8BGx7TO+m4JHZYgMa2DgyMw8eYq1fEyqw9Z0RiAqHkZ1MsH?=
 =?us-ascii?Q?0p8zbt+xuctejYjhzRl8yXzyBwyeliWh5HbcrjTkdeOET8gwyfljtulGmoaa?=
 =?us-ascii?Q?aESqLL5cSrCP6RVVBP7+xULKB+c2LNWA4ZgzzYvolENKZvV5KvHSTleYHKof?=
 =?us-ascii?Q?ZyUIO7PdqUWXJGTI0wC0K+FgM2F7GepxeybMP1jR49LkWv1eoJufTcpm7EuQ?=
 =?us-ascii?Q?6SpfJuNkhqeWK/qrKDMIAl3OEdU9oChQOVaS0L7InAD+IQym9KvevD+hL7R3?=
 =?us-ascii?Q?IN2iOFxSPXOBoNMWEuLZeeP+IBnvEY0qBd+zpzE58XsxDX42nUMhGS/fPOQ2?=
 =?us-ascii?Q?3aalCdmL9pZij1+kYfLVymsokyoCd2X+1yOE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 03:46:43.8757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cbed97-3cb6-46af-e39b-08ddac88695e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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

From: Alex Deucher <alexander.deucher@amd.com>

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we
can set the error on the fence and force completion.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a86616c6deef..01688bbf3f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
 	return le64_to_cpu(*fence_drv->cpu_addr);
 }
 
+static void
+amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
+			 u64 seq)
+{
+	if (fence_drv->cpu_addr)
+		*fence_drv->cpu_addr = cpu_to_le64(seq);
+}
+
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
@@ -409,6 +417,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
 	dma_fence_put(fence);
 }
 
+static void
+amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
+				    int error)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	unsigned long flags;
+	struct dma_fence *f;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+
+	f = rcu_dereference_protected(&fence->base,
+				      lockdep_is_held(&fence_drv->fence_list_lock));
+	if (f && !dma_fence_is_signaled_locked(f))
+		dma_fence_set_error(f, error);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+}
+
+void
+amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
+{
+	struct dma_fence *f = userq->last_fence;
+
+	if (f) {
+		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+		u64 wptr = fence->base.seqno;
+
+		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
+		amdgpu_userq_fence_write(fence_drv, wptr);
+		amdgpu_userq_fence_driver_process(fence_drv);
+
+	}
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 97a125ab8a78..d76add2afc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.49.0

