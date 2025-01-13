Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622B4C02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 17:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F0910E74B;
	Mon, 13 Jan 2025 17:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5QW08EhN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E0C10E741
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 17:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKUO1SNaoxGREqDtUi1t0EuJNbFjL7ti61IVMyUGz/EqY7tju66MEobptVmlQcrlKXqBuQQHClHShYHULagzo5c6OVDhoxrLgRkqxCjk7jZvtKsewgHcvBhCHmUVf1grxjZidDN06hkLrJjb9cw3VNzQmF/0dxBLMU1RCgPxpPI/QmlmE5jrHL+xXZYmYKd3l2hBZFW4FdBvFeKCfKlmPCokcGd/1CNFINeXevpyo25xEvXygMl5tTFGNm8XyprkXX9u0BYSUFfQQZfLnhqh9pvbKVSdODbbMgleOQZSqyrTYH9vrDW8MjmhMdeInMXvwQpT2Om2Pa94/jUhA9k0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AARE9wd4w+Lu8t8oW171J8BPkStYPPzb/UbLHYuINcc=;
 b=RnEOIERYoY1PtmpAwTxFrfAeoXwqNTd0lDknNzqDfwlbU9U4kNuH/kPq4yDN/bjAMRCIhbPgaVlka/95Y7Lyej6YPvk+EQ4m7XBBMgtHtVfxi+IM9rWneafmCHFzTANTXMzz0Es7H44ck7Dj6c8sJOYWJzC1D2yQmr9MdZU+noWlTlWlQ101Mq7eL0ouElbUV58vBNo+aprlMagccvouoYYLSh5kkHFhv02y8prUdW9mwkZDEw4UBmdY6VDD0o6TpDMqPSIo0dU1K34uM68SwK/ETi2zQuyrixRBlhyAFmM3pq/6H318NQkVIWeF9T9L+oN0mjZth25I83T4jWs3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AARE9wd4w+Lu8t8oW171J8BPkStYPPzb/UbLHYuINcc=;
 b=5QW08EhNLAgKYPCNsmS0c/C60cXg8TX8PzWd9XWYd8PWb8jcXR0xF81VwIntuJvR48H1zCG4guZtDU2jzxI9zT8nabaaTNj3lg+GYwj5jz6YP5LPjHYtL0NI0vZOifJyEjduF62VcPMkaFJNs9rmQ3RuLjM8O/rlwwlU3s8LyDs=
Received: from SJ0PR13CA0239.namprd13.prod.outlook.com (2603:10b6:a03:2c1::34)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Mon, 13 Jan
 2025 17:08:21 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::85) by SJ0PR13CA0239.outlook.office365.com
 (2603:10b6:a03:2c1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.10 via Frontend Transport; Mon,
 13 Jan 2025 17:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 17:08:21 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 11:08:18 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <saleemkhan.jamadar@amd.com>,
 <shashank.sharma@amd.com>, <arvind.yadav@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix the compilation error in userq fence
Date: Mon, 13 Jan 2025 22:38:03 +0530
Message-ID: <20250113170803.1043933-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: a7609812-1dfb-4157-026b-08dd33f4e224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kjoUKz1jZqCJN4XPDhLVUwJpc7a/JL5d1kpmRwpWE+BDX1zr+NhQYFvDHxn2?=
 =?us-ascii?Q?XtWIrsNFCs85jTYDKjMRJz7Z9SzV2PGV9zIWA24Mt1bsUb3e9Aacch0AnA/I?=
 =?us-ascii?Q?/EfQVYB9puu06tRUv8tMI7nuiF7MQVi53VDfZ42l2tgBbiQhz9DtxKPiOOdl?=
 =?us-ascii?Q?GEIFKvZPuuE0oNisc/kF26l3JPjGm3gdferxonax2KpJdtou0vXOuDaSv7xX?=
 =?us-ascii?Q?S5RtY6CjmIIlGioK8d6dJucK5Ilac19TjMiojbztuU2QjrFHQUSEYy2Maor1?=
 =?us-ascii?Q?czbNsq0rtd+asM6LO3517b1OQlvzQV3U7YKFC/+HR/tmB2au2Ar4P5mBOSyS?=
 =?us-ascii?Q?R1wjHPuqWi8A5GZcLta1s9l65Wc6m28JKnkhoCrGeERu0yHxbg0OOyFoVzXI?=
 =?us-ascii?Q?41o7nnspI45bdasM9rRcuH62aKrIl+DGlPrZwf4inPzq8fJCqoIwX51DrDle?=
 =?us-ascii?Q?UIbMjMTsQGbt9JEo21D4tYjiXVlUogkE9UnuHoiLsU8/8Exq6W/qPXT6ApEL?=
 =?us-ascii?Q?Y7ckEiLM/hu0gtWPwInPeSfAEBXaQHRVMlYuivouKy0Yly2SfcvzqM8MgI8h?=
 =?us-ascii?Q?HeNXvnlMitNhhbOgzjkZ7h29iau1hz+o3r61ypN5hfYDw/RjSI81I5YR40KX?=
 =?us-ascii?Q?vrax4kYwDY2h+AnBxcbZs6BAzjcVF4u7u6T5RDdPC7zJhGOv0DhoTPdSfT0Q?=
 =?us-ascii?Q?FRz87tS4viXKrfvFvIxeUIkMfgQy2xM8fkcQ/ssZdh0eMKb6MFNH+VUIF/dN?=
 =?us-ascii?Q?QwXWz0LfHACRGdjCcGntAYE/mPVq+yFodWvsIM3t++kDoIP/ZwT2UpWBBfls?=
 =?us-ascii?Q?VqFyPEbKV7PqV8BJRX85QDvPNGt8bD6EEw/+A1rydU8jNu2jkatUw2fEEcn5?=
 =?us-ascii?Q?NI9WJL1cS+fKNIJABIjDSXmGfySAMDzFhcXRTXPwoomXW5vUB7sGjBkp8LMe?=
 =?us-ascii?Q?LSlfhHEzAeItfm0M4f8TjdDmKbnL6rv/ibbyRFRntdYUp0TCMXH2tga+bMXr?=
 =?us-ascii?Q?g4I61BT/Utv1qpjclGq95YtadMLuE3LG/du+rCOdoEw/jYBGD4mypfYKRKCH?=
 =?us-ascii?Q?z0pqyzV06uoQ1L+L4+sOOEKbNMIrrtHp+ySNDfdPVtobY2mb5xMlqWxRvNEN?=
 =?us-ascii?Q?1rqDfLtjqyRRKJ27eauL6R7btZbXbLHfRHFHH349+cFw4gzKgPh3zz+clZ1i?=
 =?us-ascii?Q?4T3jDlIyk4TwtEdrLtd2L+B2l/Xt35V9WupsOy1KM00FAVQQGGEsXCc69Wkl?=
 =?us-ascii?Q?enUOCj+TH0RxaMl+yCDAmiom/VXfSCVQ33Tk1zdL9FC1z5QHCfXqwg46LV7V?=
 =?us-ascii?Q?4KbPi1+Zp5ovEPr2EqlPOQ4pbJl1lgfjBuFS2jWi59ov93gJYKfQCrVnKJ9M?=
 =?us-ascii?Q?lQ43yIBQ/fIjnMk1xMVyh7wV++0jDIANaKFg68+DxuEX12oHEEXz2sbFaiJR?=
 =?us-ascii?Q?R5r35nKqsq6NiCDDVq+L3owlL/H4+oMJ7XFe1yUpbiFJvd9As+E4QIae5WAN?=
 =?us-ascii?Q?AeZZFAuWxIesgjw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 17:08:21.3963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7609812-1dfb-4157-026b-08dd33f4e224
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
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

There is a comilation error after merging:
 commit id : 7de7cafeb474d1454b1744c9a51eac4c8a6ed29a

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 2e7271362ace..8a4d9495f9d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -503,7 +503,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	dma_fence_put(queue->last_fence);
 	queue->last_fence = dma_fence_get(fence);
-	mutex_unlock(&uq_mgr->userq_mutex);
+	mutex_unlock(&userq_mgr->userq_mutex);
 
 	for (i = 0; i < num_read_bo_handles; i++) {
 		if (!gobj_read || !gobj_read[i]->resv)
-- 
2.34.1

