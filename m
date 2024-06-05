Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10551C25B78
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 01:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF4B810E679;
	Wed,  5 Jun 2024 01:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P4/9eeW7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE91610E670
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 01:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW/SjCxDXBkHc9gEkXEv7ZBkEaU3Nhk1Y3BININynBtBvcnqrOgqvGWM95tEEo4J4fZDCmAC+hwto0e2UaB0lwqG3flf1bBMwQ9qjvXaD8UtVDOqk7GgB5iQwxFT7SnpahSncqTzlkGFJ3fF1Z2SepgNriCuu42SJgjHCXR4nWXAbEgTvmxQzUWfCfFQgst9hn0a6AnNKEppBsrRtjTAE2c4xgadHgKfc8RRPd7ZdgXIpuUbsR3m3Ca7iEFtZq/0wYTd1Lv5swx30jqYfekAfrpjCwWo69LBZHfID778rplKb0zOasxXoJbE7B/Gx1GomY30EWCC0aFsQay76lewKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CndK9v+os7qe3SqSGthKSK4v5OkFcqXdL6aNGIsaFbM=;
 b=AhGdLeOTosvt1E9Qx8rPaDu+XD+5iqo2dBmb7KbeGTyTGe/2WnxwW9nzn6nPcmqjWW0/Frl0/c2G8FFA2l9pN5NpESvuSEGos6IvrKhoMl74WhLo48OvezbxPs8WaPDlj0ZKAUVNuYgS9UxgfgKS3tNQ7JtY5j3I2SKNh2RTeCgGNJpiUBkTyoQHMzO05OuQ+NzRxKVY97MhDWdgre/+sOXW7FaoQ+Ax2GfJ0ermZnq+wv6f0dWk/Ez7mOvAR/QWbDjifB1yr5kFzsv7hg8UjJtNgoRb+SN3fNwu+TpTEqMkICmanO9rTDMwTshqL2zZMLXQGQtwwl6cpUyWfaSDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CndK9v+os7qe3SqSGthKSK4v5OkFcqXdL6aNGIsaFbM=;
 b=P4/9eeW7M5eAIaXv5pk2nnH+xQO6Hwz/4kgmUGzBHQ94MVJ6hwK2qrMKaYU3IlPO+5kEyOx4e1qMmMI/VuQ+xP3S5EpFZm9LSK2mPPVTavjwqZ0LKzwliCV7lEk3OXOEgxlfnc5VgfbSi1LYDsNC9dB5ecRF9Rr3h5vy4W1wBso=
Received: from BN9PR03CA0142.namprd03.prod.outlook.com (2603:10b6:408:fe::27)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 01:33:54 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::4e) by BN9PR03CA0142.outlook.office365.com
 (2603:10b6:408:fe::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 01:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 01:33:53 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 20:33:51 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH v4 9/9] drm/amdgpu: add lock in kfd_process_dequeue_from_device
Date: Tue, 4 Jun 2024 21:33:18 -0400
Message-ID: <20240605013318.11260-10-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605013318.11260-1-Yunxiang.Li@amd.com>
References: <20240605013318.11260-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4d4676-efa4-45b2-65c6-08dc84ff8f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dfivmn0ibfpNo6SS9dyK3GHe9zpn/ocbZzwR8mrZcHYB6iRJV7v3z4hdbtg6?=
 =?us-ascii?Q?vrm5H2uTIPth9nVF6DqwtHyjB2sDHaph2r5kB2VM0JE9ACDXxMBGlhlQliTG?=
 =?us-ascii?Q?vM7oKf74ovpE34FwSgR4t7+vxKrHb79uvBSnJlBjothTd/pgscWRM0+Zq6iC?=
 =?us-ascii?Q?AcVzjF6tEzwlDCwqYqHiZ8DDxlLS4c/DgOTxJjBNOg/qrLjlS0mrhUUau8F0?=
 =?us-ascii?Q?W3ypnA9EkIXOEsD8vzt6ZzS0cCAs3B8lJIvB7IwxcjF06Wp3bl9NpYLw+RJa?=
 =?us-ascii?Q?Qbez2VQfM9cjqIlknpdPOR2Dqs0d1W/SD+sG9+PIFpZEqDcGYoE9bFExK9KM?=
 =?us-ascii?Q?pKaoQlN7yKtpU58rQeSXjBmutSwGQZSp3OIiae/n2MT+n/R2Rtxg4I2QVEHz?=
 =?us-ascii?Q?AXl8rGk5q8TN40ySWeM6G9B1JzgcRyM6pMy4P0zIrb4xaLyKb5YPxKgdUnUC?=
 =?us-ascii?Q?nOP6NauofYXTRBvH4hJJbzjLOJeGSpH9Lyqi+eQt4W2jJel6j0vFQ1Yd8/eQ?=
 =?us-ascii?Q?WYsg7IKA+kWVrQbq+Kg9NS3gH8wwuYHi2vvGmK4kW+4+L2imJrsGUx5MAdHT?=
 =?us-ascii?Q?5tveg7meWUiFZ+1OEUYLy99AzDhGxXpZkdVGWq9/CQiJDSsEXxC6HYMbxIBO?=
 =?us-ascii?Q?4sj3mNYNJT4VzaJ7nWXBFu+KrAYk3OH8wYCkMOvgOebs4mjEjN0SyJ8SdzRC?=
 =?us-ascii?Q?58d9Q7HdVIsPx8C4wKGHss8H43pY3pl6+0IYjJdM2PYCGLSL9eMQQZpBzi6V?=
 =?us-ascii?Q?/P159RvjjDnEUS+parFV0m7R5DI//SZpCeLdl0iZmTvQC+OgGw/RuiteZ8xJ?=
 =?us-ascii?Q?OVYPybjk3jdDvJwt2SeFY4wpGzPLybkXrFsNGBfKEeaXeVnzY5evOVVor7Yb?=
 =?us-ascii?Q?IGgrCx9RGgnmIh0e19NA+JBAMHRKM+xCpDJw7jSgg2ifgCx+eeOpH9tPJ2Q3?=
 =?us-ascii?Q?8T5ozgxc/+k7DvsYCwRXwapcWoHBowWe6FTgwTUU2LoPp9lrTZj+rhcis1/H?=
 =?us-ascii?Q?Af9mOEadAX/aYV5FoHBqkBRSjeRwwVqNmjIK5CCJ4rPqvK7BhI+Nm3qA+7SU?=
 =?us-ascii?Q?jQ4hgFrjuSLoH42i8cZSxpG1mwJoaF7AdANTdLVX8rVpQuGSiNauGxvB32xy?=
 =?us-ascii?Q?ZMAG9359W4aeZrMooh5DTefe8i9yEnnmfgE6jJ1MlEsaAq8QKLskoCJNeXrt?=
 =?us-ascii?Q?+MA5TW/MyzrHzJWZguUKOBGK4P8QCMfk1qS7DuvqcJHiiIGCNTG++fs5/hOy?=
 =?us-ascii?Q?IVVMVl1sgs+UqAHxD/IRPkwj0jXuaPg3RqFfjAlh25ZjyBc+ONebF5pXppo8?=
 =?us-ascii?Q?5qXHPbbk91filbRJU8NaNKYfh5zZmi70RF5rrVh9p4v/cselTiLLecbpaOgz?=
 =?us-ascii?Q?BYyTzlb4Qsy/LR1XbJcDtGG4mwbY0ab+YMxtDgt7oroj6UTwFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:33:53.9078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4d4676-efa4-45b2-65c6-08dc84ff8f8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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

We need to take the reset domain lock before talking to MES. While in
this case we can take the lock inside the mes helper. We can't do so for
most other mes helpers since they are used during reset. So for
consistency sake we add the lock here.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 86ea610b16f3..21f5a1fb3bf8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -28,6 +28,7 @@
 #include "kfd_priv.h"
 #include "kfd_kernel_queue.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_reset.h"
 
 static inline struct process_queue_node *get_queue_by_qid(
 			struct process_queue_manager *pqm, unsigned int qid)
@@ -87,8 +88,12 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 		return;
 
 	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
-	if (dev->kfd->shared_resources.enable_mes)
-		amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
+	if (dev->kfd->shared_resources.enable_mes &&
+	    down_read_trylock(&dev->adev->reset_domain->sem)) {
+		amdgpu_mes_flush_shader_debugger(dev->adev,
+						 pdd->proc_ctx_gpu_addr);
+		up_read(&dev->adev->reset_domain->sem);
+	}
 	pdd->already_dequeued = true;
 }
 
-- 
2.34.1

