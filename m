Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D723DC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8390F112F39;
	Tue, 30 Apr 2024 20:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mfoQvdlA";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C258112F36
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeFpmXCjJ31fjatvnHj/g36BK82oWkLRZ9lSNWYGK6/BSEqpjBkgikqSXuMw9gHfd2rL35XfPyz4mhEt3Xz9aZwyH5lMPJi3/3i7CQIRIjdEoQpyQViKq36tX8UnE4Dsv4O19DdcGCTxvoVhQLNviqKqk6RdlSB2Evqf0DdOTK4An+1ybbVz1omVbJeCZ7aEKprfscXfm+Bfiy+BkgCZ+R/ChAXqB0hkTPCctvUAP3yTJjjSpNizFESedfZJjyQ7+mVUIqOQDpryGRY+nIBm+6jn1PWCo9WDslfiRk2ZGhcjLr5chdubbJjZxGLYCyDj8wpGHgrG4JnDqCBOsNlYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GUQ2/uG0Xg0TAoLePsNNvUP/C4bJ+L+TuOESwkGm2A=;
 b=Lw7Lkbqz8tVxF3Ul9u7faZIhBwa2gua+0RE4nPFkGhrCJlRwud3HOChhGWwjRuc4DXfm5xzJoGres7q3uf0VdgH7LefyuX/2HL6GiPRKuWi0w2iFtUe58KohNVDN5KwzrfmgSiK86qe6PqCAMIR0FUn6FaaJpFUnq6AASkD8MhA27+icMRcCRdLBNKUIN7I05LGbuFdi7dnT5X8i1QgBpeVQM/QYj+2g2nDPJicxk+j7jGat5KOZ5/FktPv3zV90pSUkWzwOD6dwvohEC9fRbvPzOS1IS4cs1qwck3/htZsTz+fOywy8pvQ6nX2KsGzvbrPv/6WySY8EK40+KQKkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GUQ2/uG0Xg0TAoLePsNNvUP/C4bJ+L+TuOESwkGm2A=;
 b=mfoQvdlAY3uYL443DmANoLzlVW6aVQQtG1Z6rW8hr7L2MQbmVIorK3NZ+zqKWn7oWMW83+Pcg6cTzyZNvj/afkriYozdlE+KfY4lfdhjT5ch1K5Tk4OPytH6ZImBtNqp552ViIW0ceXVX6Kh07NRvsWv/pE1650ig1A/RB/M/T0=
Received: from SJ0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:a03:39f::9)
 by CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 20:36:30 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::45) by SJ0PR03CA0214.outlook.office365.com
 (2603:10b6:a03:39f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 20:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:36:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:36:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/mes12: Use a separate fence per transaction
Date: Tue, 30 Apr 2024 16:36:09 -0400
Message-ID: <20240430203609.799792-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430203609.799792-1-alexander.deucher@amd.com>
References: <20240430203609.799792-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8d5989-681d-4087-4df9-08dc69553720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oyaYCU0y+dBzBDZOTy5FFZdvwvM7cZOJ0AlN+oUId/E5A9mpk9rk1UJROIjr?=
 =?us-ascii?Q?xEFZNgwW6jZH0o85jCiZgvjyE4D6Uppy7uWM7zFxCJl8iLDI2Pi7RITSfCwB?=
 =?us-ascii?Q?uZ7z6ibGd+OtO+rWbXk+h/bjoNEkfCLJ0pgY6vcKeCJM54z2QMEWkehO+zIv?=
 =?us-ascii?Q?l0tOH+wHhLgT1gE/75uzpeGczByO56veDU7a6hBH/N33JhYw9Zu1HP7iPWEd?=
 =?us-ascii?Q?yAXWMG8fSCs9Xe1FNwoWdexNL+/qEx9vm3ZGTzz5jylg/Vi3HdWriDHzJuXQ?=
 =?us-ascii?Q?tjgNOLgJ5fNWjWjGL+12O09/BiJG7shczPm38g83tP+x3b/itsIE5ylwvFQh?=
 =?us-ascii?Q?mb03J13QkqUfl9sdJk1Q8DFYZ8x86KPGkuHpdSVZphQOEw1xNDd61dQn4ye7?=
 =?us-ascii?Q?TnfyAIXLfZBkbrj3hJIffr0v0Zf5JCvlXnwObDE8pfdPdbFDglaLAZxwaueJ?=
 =?us-ascii?Q?u/eJnJo7OzLvnoEzdqb4XALZS+48cBZ08jZXRUHUiVlkB24mCF4rM4xrhBTA?=
 =?us-ascii?Q?HNwb7nZcHTRLNQzdPoKIYouEGD++qxOiXfaerpDeSjItXxyA2YAtG4KC4XiN?=
 =?us-ascii?Q?3CF0sZ9WO9wf+6Z89hEJ6tBnKf3JPEbygFXC9zEFLoE/+ptsYCW15EQnXrnv?=
 =?us-ascii?Q?8VRbVB3OI+8LoryIn3fLq+tkdnIVnfWTcXVAgs+F7V0ciprmvqGCkrF5pQ2k?=
 =?us-ascii?Q?5hBQLZ+nZMkmnPDUfgyyNjyKBWqp60XzQoPmhiPnYWwXSEzvazX4gAv5QWPQ?=
 =?us-ascii?Q?NZ0b5mizakZ70BCHY8CTvREQyBjMCjgH+jl2nn3LO0sqTDdyBnrCJ0ybF903?=
 =?us-ascii?Q?iCSxf2bhmMXDm4/m8Lb381QdvDDN33UlaJxqfjrnaLvTAOpfUuM19I5yr9s/?=
 =?us-ascii?Q?97JbET9yK96SZ2OsdsixfFohgiDYGsTPDDBSLZjRu6hJfoxQeo3MMq3upXOA?=
 =?us-ascii?Q?zJylg0V1CTVCpq4ISNyA/yXCxZzWTJXDYeZvMEIhyjVbxo5knglCRv4xeDuK?=
 =?us-ascii?Q?Uaixn9j766z3JJgjRP+RDuQXYvqDRvmaeBRgXOxSTv7bu+6hKVkueXypQef2?=
 =?us-ascii?Q?F6jyg4874YM21M5ShZ46H8LhJnEmN1SdxiXB+buc3M1WX/AE7znsnJgfITFU?=
 =?us-ascii?Q?GzkULUP6N262+nf5OcEFsbOIiltVh7pwGnMO0BApVC/5AvJZ/F6tVBjOpmqR?=
 =?us-ascii?Q?nq3zP/Htwlqt59RuWFWposiB6ljaCqa18YK7OblIgzJnjoTsn6IpfH7U5X64?=
 =?us-ascii?Q?S/otmOKxTpZPCCUbDS6E9ydoHkkD6avgJByczkHsxxs3h/FFauWmFbg7YEv6?=
 =?us-ascii?Q?LEg7Rmmoxpcc+JaepYtWrujPCeECveOvkWK69J2oa3JjCC/5cYNeWMOSz/+C?=
 =?us-ascii?Q?ysQU3mepMz6lklJmjKOc0vPxL1io?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:36:29.6049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8d5989-681d-4087-4df9-08dc69553720
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386
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

We can't use a shared fence location because each transaction
should be considered independently.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 57bc277677ed6..76db85157bf9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -153,6 +153,10 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	unsigned long flags;
 	const char *op_str, *misc_op_str;
 	signed long timeout = 3000000; /* 3000 ms */
+	u32 fence_offset;
+	u64 fence_gpu_addr;
+	u64 *fence_ptr;
+	int ret;
 
 	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
 		return -EINVAL;
@@ -165,15 +169,24 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	}
 	BUG_ON(size % 4 != 0);
 
+	ret = amdgpu_device_wb_get(adev, &fence_offset);
+	if (ret)
+		return ret;
+	fence_gpu_addr =
+		adev->wb.gpu_addr + (fence_offset * 4);
+	fence_ptr = (u64 *)&adev->wb.wb[fence_offset];
+	*fence_ptr = 0;
+
 	spin_lock_irqsave(&mes->ring_lock, flags);
 	if (amdgpu_ring_alloc(ring, ndw)) {
 		spin_unlock_irqrestore(&mes->ring_lock, flags);
+		amdgpu_device_wb_free(adev, fence_offset);
 		return -ENOMEM;
 	}
 
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
-	api_status->api_completion_fence_addr = mes->ring.fence_drv.gpu_addr;
-	api_status->api_completion_fence_value = ++mes->ring.fence_drv.sync_seq;
+	api_status->api_completion_fence_addr = fence_gpu_addr;
+	api_status->api_completion_fence_value = 1;
 
 	amdgpu_ring_write_multiple(ring, pkt, ndw);
 	amdgpu_ring_commit(ring);
@@ -189,8 +202,9 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	else
 		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
 
-	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
-		      timeout);
+	r = amdgpu_mes_fence_wait_polling(fence_ptr, (u64)1, timeout);
+	amdgpu_device_wb_free(adev, fence_offset);
+
 	if (r < 1) {
 		if (misc_op_str)
 			dev_err(adev->dev, "MES failed to respond to msg=%s (%s)\n",
-- 
2.44.0

