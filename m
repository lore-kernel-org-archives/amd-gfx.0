Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8CEE7717D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 03:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AAA10E5B3;
	Tue, 10 Dec 2024 03:18:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ionz/wHn";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B9610E5B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 03:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVua1CMRt9hPW1QDYKSHB+PVqekLf4ttZMez0uIVXx66B0+fE7FoIwFwILBrLK8/+ZSGCab/mRnOWK1vm3Dk7tC7KMdcej9TG6tNcb9p+WNATZFadY5yYLswx0FBz2d03Q9iH+0qKlphXKZ4vl1Mm86exCKRGHdPlve4JeIicwXCNXqTs4d1trC0ZVH8ef4BzbpIUHz9pJJXGDJPy9NfE3XFAqI4ua5hVGOAgcc4YC4a0DopgQ+rlj5MO1oeLlX8kIdArtzhm7U8911sxsQAdjAChYwtIRi7GYRAJK9R909KA1okXKfr7UnLSKlGSoCJe7YPKcpFYyH94AhRP5NVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/dzIJjPNS7lY+LHlgefyuQQuo+vtA2z/BILNvKXQeU=;
 b=v7YXJ5caAZ+uEaFCGqkvq/U/Uoqtk1RKi5J2JZJm4mM59belMWT+LDVEmOxdiEIBknl6VndJx+ReL6T/SuPTB4wXyJq8CtmcKJ6JU20MWVqUkNs3CnttbS+jSUyXXkHTAaFzDMAX0ZZnK9DE7h+adgUx2hlZSeeuTSnyhuAOxTReD1ECqbninymzwXbs0/aUKAQ+7iMr+G2Bdsyj21nyVRUGz3zaslyTQAIPD33awpTOAJOds19+TyRVpG5NZ8X38WUmAzzH49Q2FOvB2zpC+8XR+bfr7k9EdDlZl7YmyC8bHzSkHfG3v4XZLH5hHsN71pkYtSotQDEg0lxBSXDy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/dzIJjPNS7lY+LHlgefyuQQuo+vtA2z/BILNvKXQeU=;
 b=ionz/wHnmNL4hZPbLhAn7zkDmvSDUMXhSEyF2E7Htdf9a0kjD23dJKxab8K1kAS/V+ryA8EKwHEDDO5jWq1ayAo9tCDuxS0hJvVLepkc9SWm5/3RFvSU4ZCePdpJaMFVrk5iSrvH9BmTqMzTic7jIV4Sg5gTQ8KNOYyB5T3jd1o=
Received: from BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::35)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 03:18:15 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::c) by BL1P222CA0030.outlook.office365.com
 (2603:10b6:208:2c7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 03:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 03:18:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 21:17:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 21:16:29 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 9 Dec 2024 21:16:06 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/sdma7: implement queue reset callback for sdma7
Date: Tue, 10 Dec 2024 11:15:59 +0800
Message-ID: <20241210031602.2154914-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210031602.2154914-1-jesse.zhang@amd.com>
References: <20241210031602.2154914-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 51251547-b47f-44b0-c7ea-08dd18c9492c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zri4APYb4GI5EBy4Cmm8ZyUoAyF53vLeM073ktXZNmi7lKU0ORqHFjkv16xJ?=
 =?us-ascii?Q?+mhcsqyzJKMzM5Volb3qPkWobwT3X/CBl/L3eDzCn8ezPBkvB6AtWdyrzSl0?=
 =?us-ascii?Q?XjMy1FmITDUqaqpy6f+4tU5BMqb7OjWP4jVbNPiPbI5Di2uP7spj5QLV2vNo?=
 =?us-ascii?Q?16BdsXobWyRahveeW6liMxL7uuTJb0xSD5FhOPXrEuuhFSCzG2iXy6VPlxAL?=
 =?us-ascii?Q?MXJj9kPAE9sqC6d5x0BNV8luNi3n6/Et1jWbv0FNgSDjUzeh+5mc2xnga9Kv?=
 =?us-ascii?Q?zTajYOMHhaPcdzgfCHlGCPpC792fAxIE3j4QEm9GHZROIURiSFIo/tLPe0mO?=
 =?us-ascii?Q?IqgWiqHuyjRFhFNX8pRq7r1JKUz9Gv3nddkjSl2kFwblNxvfu0cxMcwIUfcm?=
 =?us-ascii?Q?DqllHzmMmKVqhiQfWXzn7XMYlAZUJL1nvMaK8So8zqf1BCT10/5DqJfPKcK0?=
 =?us-ascii?Q?2WpYuG6GnccPSg/yagqaXfenauL91Eg2+3HC++XGh34K0g27vl7E1QL9m3gu?=
 =?us-ascii?Q?ynwiwLMEIwZOrLSh7i+H1khbI7pniPURxjDaCyYEbufGn9CAp7qpBZgnaROW?=
 =?us-ascii?Q?dL1Ae4qxkQZ250aUAV7mc5Er3lzrBKONiPQxiTDwkeS/AkAdSgA53qX1owqU?=
 =?us-ascii?Q?kV83Qd8syS7KUTsHJaRhKRlK3FES82WDUdlnebqZIX3EgVAwvtU4aMWMCdko?=
 =?us-ascii?Q?53xNWL7YAZ4pjEY7Cszuj3rShfl6Mb3N6Izkp8uxWdpx+D1RmXwWri6z1amK?=
 =?us-ascii?Q?/OQOKGM/SM4vaepQqX7xcPEdn5JI1D8VtUWzQP22VmPtWBigelqLonmtv+1m?=
 =?us-ascii?Q?KFm64akQT8qJCYDDtP7g5YrTgC/EsaXO95nZqEnp/pe7EdGjs6yRsr6wBWa6?=
 =?us-ascii?Q?pbzLzkuPmBYwz+Jvkzrxfc4TeEZ1tYBt1ip3QOb6CbOnyB2Xfu/tRQ+Sd10t?=
 =?us-ascii?Q?cXe6v25GxVIxmzWbeo40/G5wRu3lx3BiypJmD5QvF4xudoWVFKEoDQV/EPGI?=
 =?us-ascii?Q?KAvhl3WzV/ek/yvKqcB4dWRqNZM652TcqPT0F+2P9iGKXOkE5hHsEJsZWEB1?=
 =?us-ascii?Q?8I6LT2cCcpBilUMB3ym5L3D/I6dxjxKcTVcTg/G/XRdIm58cbfm6gDY28/jp?=
 =?us-ascii?Q?u0TUH3UoLPkb5iGy+nzByLm59TZsAMBGVPkXXPInoM0mC8KxSUt/yqAc2Ko5?=
 =?us-ascii?Q?vMRiWjPWbLdrMZd7Jb+Cu/8pFK2bQgDrSB/+2usj4BGgoZXdUKZ6a8/bETRQ?=
 =?us-ascii?Q?rKv99HLutp9TFjn5Xo4ACpzGCKhUoTsXHuXS59m1Cb1X9qiPI3n8Gvsp5fYd?=
 =?us-ascii?Q?P6RiJ2LWOHx1GuqZE2XSbz++/1Agbg8h/hZlHxx+KqkhEzhipQxyeY5KyPkr?=
 =?us-ascii?Q?Z2HkLbAfxCE9vln7cqZduzo3ugUe+tHw2rY6+e7LrLhTJbF8L079/NzZYlrB?=
 =?us-ascii?Q?3QneBDBHKzsqEuRwfdXdg/Mm+KztE5Rg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 03:18:15.0236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51251547-b47f-44b0-c7ea-08dd18c9492c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

Implement sdma queue reset callback by mes_reset_queue_mmio.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 8cc8eaff0680..627e0173b64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -830,6 +830,31 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
+static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, r;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (ring == &adev->sdma.instance[i].ring)
+			break;
+	}
+
+	if (i == adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
+	if (r)
+		return r;
+
+	return sdma_v7_0_gfx_resume_instance(adev, i, true);
+}
+
 /**
  * sdma_v7_0_start - setup and start the async dma engines
  *
@@ -1668,6 +1693,7 @@ static const struct amdgpu_ring_funcs sdma_v7_0_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v7_0_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v7_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v7_0_ring_preempt_ib,
+	.reset = sdma_v7_0_reset_queue,
 };
 
 static void sdma_v7_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

