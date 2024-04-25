Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E51C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 07:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E96110FC47;
	Thu, 25 Apr 2024 07:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PUybyDg3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6866F10FC47
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 07:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKErp+MzaXnGtirdS44oT5f27dwd/BQkgqJD6sW3rSngs17R4Rqg8VccFVZh4O1sfNjP7IS0EoaDlCcqa4PR7fLPMdGVPLqhXZY3hsZnzRwmCQyyRNWB4XySPRILoOMqGC9v2rWGh6S7/vL7yk3cnLxh64ai1UbMWP3ycQSnBxNu4KUPuc5dOD/hSenFzKtRjt4P+FfHvcjEfoUnywwuU6rf4aoFnsbch9UEtPUF9g1HFnL8rAzzPb6F3SLrFJQeoLq9cB8N5t9kISS0CrMb4giamLwT773DmsBR1jXm5FkPQ5aQ/A5olltYz0Q337KVNG86Ks2uu7VEXxkQL6NCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfJLAHp+ltUP174+SuBQCUwt+6TsQvA2aEaZg4/GGEY=;
 b=mSbhLDuHjbZ4TrMXlGEdAGaQii3e1t5qY+Zlso+rvviZFmtHS6QBE6o/E0TVDBsHmoBzinF28sPQ/NQjVoagyc9yNBwsUBx7JRumzpplSPWRUSiX2y2Y2qknAvTilXmgsN1mMEOVkRhpfGqYUYgeDGaFPaaHPLiSTKuQnF+XdeMftfK5XTF+8+eHntzwdGedUceVy6oBhU6Jb+wgWh1sHye9qVbTFFZsYsVQtrBoKJl5dffbcBuvYClqRfYz9GSjGek1eY92FO0E2PD7gOcOq2N+GjApeuOXoUcvT5uKPuUw4EOO+ddWfQwz3zP/meNs0emOq1i5LUeLBmYo+zOxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfJLAHp+ltUP174+SuBQCUwt+6TsQvA2aEaZg4/GGEY=;
 b=PUybyDg31AWe6078G5Db+UNcwr5fjEizOdqBbh1IybWYQ8dvELdwTwA7b4OMFsI60iNWw/Hyc5BYUyz/a/njA6RQ23sT1gIAz6NLtTAHIt1u6THkOXJhCkUlIem0jZxlvqNCGv4oHPjNizGjbEUYp7gF7NGEYtDTD1JSSVYNVuY=
Received: from SA1P222CA0170.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::26)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 07:03:21 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::c2) by SA1P222CA0170.outlook.office365.com
 (2603:10b6:806:3c3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 07:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 07:03:20 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 02:03:18 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix overflowed array index read warning
Date: Thu, 25 Apr 2024 15:02:26 +0800
Message-ID: <20240425070226.1315866-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d3042f-416c-4d74-f039-08dc64f5ca99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZqJsZIiA67TseQ0krtLiB8HbbiApxYiTEWAfbI1gn9/XWTeM5EoEQ1HeTYHl?=
 =?us-ascii?Q?/zKlZRjwc0GZvsYoIVv5yll1p8HxiDyYY8jy+AGzH65Lvp5KGIsdA5lU0JOy?=
 =?us-ascii?Q?fz30IC1M1UQjoisT29jah3toEVwOPRyr8yWBJzn2WNsVFToupVFVXU7SURMc?=
 =?us-ascii?Q?pBVQMqjW1Vmm6BQ+17V+kLVQ3LfEx6my3C16kcoQUjar2THaojW+VaDvVYFW?=
 =?us-ascii?Q?JeK4oLfnzsw+uXlzewdt3qSsszPOKNmXreo3LXjsYGK+MdgW428JZdeM3iRp?=
 =?us-ascii?Q?kNpdm0YFWpbH05R/7XwTbn1iu9CbgY434JZ+Ym8qRqRQNybum9SzvGXLc8zv?=
 =?us-ascii?Q?NltY7uAN4gymNC0dloPijf95biJHTa6dBuTnVoz4wfjn4XWw5ZncVT/S5NgG?=
 =?us-ascii?Q?TkbBgvGnXneYdhbVB6t7Ps3mGZQuSa+apfeGHAD9oX0ZWsw7p1cQEl39AJXF?=
 =?us-ascii?Q?Jzg3NkFt+w2iihuZPFnS5stI8gRreEzOAfFcbmqRvLV1kfpy8SZYQFqp4LYQ?=
 =?us-ascii?Q?yi1HVGbIFs0oug64kXXajPloNmqaO9NUp0uAzBTDF5Ire+lB+MaoNy5L4q7u?=
 =?us-ascii?Q?k3aY2Ucrafh7Rga4vkBOJOmompQfSYH/BussVk55ObRq6QhQnwe5UVo5KyjW?=
 =?us-ascii?Q?BHkLX8+Nfmed/lnCy3w1eCA15xCwpwXN1o0/a8qIu353nRncY3FeePucWj84?=
 =?us-ascii?Q?bkJ78TX1qC+UHRURWg2D2CGKt0ws8ptodnb3EXtUxLdiwg8U41PJKBln9h9B?=
 =?us-ascii?Q?fyog5Cfgn/n5/gDfYdp86FX3fnVrAFvbqfkj4kLwVHv6JsHJw6K3/jCe+UOi?=
 =?us-ascii?Q?0emIgz/ag7WO0kDbg8F1ZNrPpUDIFirZ5M9r4BvEPEediO486+A/kqtCavVK?=
 =?us-ascii?Q?+7XjklzjNOX6lyXhviyMGKraMdzl+fmlGx6TU9OYt8BudqFdxMfChBC8aFcS?=
 =?us-ascii?Q?ye9dLigxu77P1RXA4EQI+w9ithSW7GRse1LnFuFFI4E4g19kU/IdEPsEllhf?=
 =?us-ascii?Q?Ovf6dR6V4LY29bHUnCDlG75Q7lk9tB6y7V2zq6lCVnt4yjVerW3LEsUOwFWU?=
 =?us-ascii?Q?MFP+t1sqvQ3c+/QjlQBl/csMk7s9XfCv8fdbHjafv6xjzA40vusI8dqiWyUf?=
 =?us-ascii?Q?LBtdKVnzXMAKaEy7/vj12HtECr/wMnPhAPb1Xxbn4dFA4OyqK+bsG+pQBkD9?=
 =?us-ascii?Q?p0J6XPqkPkZBR5kecc4PpFYoiQtY3TI5wd7a3hv3UsgTkP96j4vAMxpA1TGZ?=
 =?us-ascii?Q?35wc5BtH0WwYDZmnn0A4jyRypx/rTSp0AARXzFaw+aUAQzKV1tL12N6vpZVo?=
 =?us-ascii?Q?de80hhfQlMJoTtiC/BzVfRIRBCFbvnD9iBWy4l/xGmn6bqNzww1oZiMLm7es?=
 =?us-ascii?Q?QH+DH9bftL0aM27vixN2VhtSt4l3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 07:03:20.7994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d3042f-416c-4d74-f039-08dc64f5ca99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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

From: Tim Huang <Tim.Huang@amd.com>

Clear warning that cast operation might have overflowed.

v2: keep reverse xmas tree order to declare "int r;" (Christian)

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 06f0a6534a94..8cf60acb2970 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -473,8 +473,8 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 					size_t size, loff_t *pos)
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
-	int r, i;
 	uint32_t value, result, early[3];
+	int r;
 
 	if (*pos & 3 || size & 3)
 		return -EINVAL;
@@ -485,7 +485,7 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 		early[0] = amdgpu_ring_get_rptr(ring) & ring->buf_mask;
 		early[1] = amdgpu_ring_get_wptr(ring) & ring->buf_mask;
 		early[2] = ring->wptr & ring->buf_mask;
-		for (i = *pos / 4; i < 3 && size; i++) {
+		for (loff_t i = *pos / 4; i < 3 && size; i++) {
 			r = put_user(early[i], (uint32_t *)buf);
 			if (r)
 				return r;
-- 
2.39.2

