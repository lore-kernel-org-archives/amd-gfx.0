Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3701BFF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E6010E7FC;
	Mon, 27 Apr 2026 16:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p8YA/mpH";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5AFC10E7FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6LMn4O1aVNh0w5j9MFq3Dt70Wlx/9Qao814xvnrAU+0hCp5/i1m0Bokb9Ag6rrAf+0ZyOrmU1ITBqEY1FoYeMtx/bkIEiUTvsH1FdUtDojuzKh7KRnmtEV9QzXnFcRbrO7C6oaSzZIsjh5+MZoIedrVXXQ5579lyQRbyFh1HoTA7+6inZ9asBQwK0qDCwpTU1k7iCTKSBGZM2s/97xmg++1HMXphKDZuvO/WurBLnmvbJa4ZFjZ7eKCsFdHfFhGnv1EnZ9tJkxJ9NO8mnxZEBJs/fYXwzuPPH3HcgQhqX9hbWEQg8EM/gjzI1HsujO0NasU2zN1/yHvEKi2uRJrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DM7ejAjRXIAzac5KqejeO5Z3SRIDabxJEUJSLtLzLM=;
 b=ijWdpn+P7PxGyHkLPv+fnwM7AaBGEbIp34YPCoecog8VXyVyytlQb+kUajJzGEGBKpiWA4NfwI12m4k49OFWIBP34bnMRBQdmP0jZVXj7RBBBnKJwKEZxEl8n5MArF/n3ehg26yZWv/57AeVLUTfZnQjcVbejySoySzIut1t1m3lzflMDp5bs2hNPNrP69j50E58LRnboLm0cETMCE//7FLg1IX4cb2X10mDsBoImQQejslSPBZoWEys6svUIfRJlaJ/OHAX19S9RJ/nGIg9jh6ReuKM+FbXdBrvXSQ3F1jz7HI/JdfFzlWT1Focb20Z45jtxz8P36BwAalZwBk0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DM7ejAjRXIAzac5KqejeO5Z3SRIDabxJEUJSLtLzLM=;
 b=p8YA/mpHzhZcVnZEqC5adDMw2GHVrzGIpA+ceOBOOxqOavMMQITcO/o3w0lqZJ5WzKVDjx3FvGfYCzpTrQNMNMxavuz+KH4AI0ewtEv9aTaGcHYFaRCoqiKrJ6T93vF7MNetJJraHMjMszFwrxZDuHKXwqe5n72cFNeyG6Ub1go=
Received: from BL0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:91::26)
 by IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 16:00:11 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::de) by BL0PR05CA0016.outlook.office365.com
 (2603:10b6:208:91::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 16:00:11 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 11:00:03 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 19/19] drm/amdgpu/jpeg: set no_user_fence for JPEG v5.3.0
 ring
Date: Mon, 27 Apr 2026 11:58:57 -0400
Message-ID: <20260427155857.1370151-19-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 8180bcf1-d4df-4d6f-3767-08dea4760ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BoGjUUHKbnl3ulFDTcwRHwoGZEZPmSCBhmir3xaWSvjzW8niEbIqZRNv3/G1yPwk1t6R1uTSJ+nU29BqJ+FOqqI47xJMbJUfrrvnFhGO/XGweR5dh1LCwmY6PHjBaD0ylgVyOF91du4ld5LjruEHbZ5hEXymZOAPWVfcQq0Rdk+lkMPO8Gpu7IMUs1/LrtTLyRmep90+/CHwnN8g2a/vhBaG8qbQamT3AQd7rhDjnRH3qv7NpR6HIV8kDw21rcJVhdbfdJwM9VJmreoVAe0Sdgr2/eNG7NH1h0ckT1q842BJZlNQoWyVXXCu/11hiKe15qdZXJ9V6lQHo/xXbWOyyQZGa0LOeHQcsA9ffio2jyoaHYAujBd7MVCE6cY8SixjdunVoK4PhdlnwlO9vSmWw2Nnj5zwvhvuah0rtPDRTUMUsFx0YJQ1LEkRwUKR4FAc9dgnBkZK9ngB3Qnb445hzLxCRbhq8Ql+OwvyX0ZtAWYpEMS6bkCCKmBvivKappmmimEhFuMc+q0IM7KxWUGDdk7qYEmy2HNuAKJMMzx0WHFTfpst3r853szgxgUAAcCdqvve8apDcyZpfGiDkgehwbNFlKzw4qbbnTFhJysu/I8DZoa+gP9n25mj6zL1dVrXphT+Iuc3+3ARuBqzktoMd8h5L3MDSdCYROwKx0Z4bLXFrkCRj6iWPJsvcEt9zkonyzoQmxegAOnCyEykQ3BHmwHERS8qOBHRijgHeZnTZB3S+npKYp4oLp/idqlL9bdeCAAqwl7OK9DPMX9aOH/h/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zPYZ4zi47Opa8vCkXR+0Mky+mtCGtJCBEk0dW/D3W67puAVieIMiOxQNfq0YeH+Gq/mPR0bi2KBaXbP8S41wccMjHpG43R6KrB95J7Dd4KFL/wI1MY5kv+G12fUzwALo8WAYtW7gSfneyUppW8BR9GaTJ/N2oj+0N9hahy+pdTgNWNKrJxBJX/VQs36XsubfDK6RbGKprAqUJPdFlhKljPdUWAfesHalJOixap3ygGyd88eodewQAThDF3HuVmg0OZQ3QzDmdwbnnWo8+a3RHsoQX9zgOzljJu6avPc2XNvtvatShvpAf3UU2F/ybHTvJ/R9/8YXn/L4ZJKUah4MdOqhWSZGf2bPzaFVEnBuzy95HEoXbcFka0i3dgX6+enDI2CkbPdT0RiE9zJe6DJDFs7lVM8UiymxApAfMXAGoeLg7E4tGV9Sjv3prgchUTaY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:11.3901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8180bcf1-d4df-4d6f-3767-08dea4760ffa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788
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

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: 4aeaf3cbfa9f ("drm/amdgpu/jpeg: Add jpeg 5.3.0 support")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 1821dced936f..e7546816baba 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -661,6 +661,7 @@ static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v5_3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v5_3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_3_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_3_0_dec_ring_set_wptr,
-- 
2.43.0

