Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBFBE77199
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 16:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4F010E210;
	Mon,  6 Jan 2025 16:47:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zWlyz4xm";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3C310E210
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 16:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u899wJxdsscB/oM0cHeZRIJOxIx1k79QV8p/UXDTbi64v3hErYMApwMgg4ZVC89LSjj3yyOH5LStecEKTKzkuJ4On0pvvCfO+V6L1sD7lJrY8izi09h5LlgqJsfcFzjwKQd450g630D8zPthr92dtBTtzD6wprUzt6zlO6eqLeY9BN0zzhC5Gf3feA5k3ymDeOr5tqineZO1bMpqd5brFYBZHiVAEhOqxU50Tj2ekj6Q5V2AIPgia4uvgrqplc3J3tFQmz8nY1mZkX/GWmqwV0dlD39QtSXk9zhpnkNrXLSL07aD1Mktq7JMweyzFZ8pDZd3jpNuhxGkzK5phcXO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61VMEogmgmUqe7GzGdlrWN8rIaRQGY6ezzENNVnbLAs=;
 b=SqYriluBqx7xmm8wFnmiW0qbErZZY75RooITZrnlnauqx8Fzakjqd8x2HRahpaTUttxycrZTsRFo7uWZaCUvw0Gbx2L4MJJbyxljVHpTgJMprLLSZv6MWq5NP3TaRjepC1rDLTHGV+bYGAq+wwIcLymRzvKK/8K1hf71a+k1PwwJNTOjyn+Kqm7JReXRQZeQi1zG1iUxgX76K9msKeY6hZhKr4AUOJvxIdnpbamnYewuj2/0eTdtOingk2IpQb6H3KUIQGvYar3s+W9DWBM/0MRfT1ZgN8xWaTidGMFRboIWBDXi9cFuiLKKWgh8EuoLM64pR8GIBxcF+hGD/UIEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61VMEogmgmUqe7GzGdlrWN8rIaRQGY6ezzENNVnbLAs=;
 b=zWlyz4xmLf9pjqQysSJiWY3OK1P2SVLVYBsQSo1M5hS0QfBSQjbplBJ6sMavoroqUVTLVV6dV1Xok6Dzr+ldRuVC1wRS+m0MWz6izupDVnhJcnEU6lzEhphQ7SGiDmlr6UJqsnSbX4kGeRHDmCsp90ZPNE9OZfbgoNngy3gaTFk=
Received: from CH3P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::9)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 16:46:51 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::68) by CH3P220CA0020.outlook.office365.com
 (2603:10b6:610:1e8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 16:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 16:46:50 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 10:46:47 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <saleemkhan.jamadar@amd.com>,
 <shashank.sharma@amd.com>, <veerabadhran.gopalakrishnan@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add stucture to populate doorbell info
Date: Mon, 6 Jan 2025 22:15:28 +0530
Message-ID: <20250106164530.763188-2-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106164530.763188-1-saleemkhan.jamadar@amd.com>
References: <20250106164530.763188-1-saleemkhan.jamadar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 172dc7c3-b69d-4d6a-1b80-08dd2e71b7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B7GCeGem2aFP6gOu0QwShyP5DKgx2tbO3UdLeTc4KRtFtKCgqRT5YbWMor+g?=
 =?us-ascii?Q?q2vtEMB5taHXYDS2Be22ekNs5RxVP1HVhJ2AL1Hg8N7yuT9EJLE6k+MWzTpf?=
 =?us-ascii?Q?J42p0Whs+Ehr4gGeLUJVU6td8CNKgVgeOufV7PXeaAvfP6UMikdNDD10IN5v?=
 =?us-ascii?Q?faL9BToLqCbM9gOI7bUTeiZCB95rry3MvTNnN2nFGnETfTcadNl1TmSk1hkT?=
 =?us-ascii?Q?bekiLcRXVJ/SAg5aNQ8tdyqkOkyEoB7uBbFm83enTIAhx3jKq+Q0/XmWz5eq?=
 =?us-ascii?Q?TPT3gsI92+kAzwhVUacReSflLPirat9+Lvx7DxYuPQeUD1yHWoaqA1xvx4fL?=
 =?us-ascii?Q?Y/DZdHqO7K1e9DM1rXeTO/fMiZ8MzFmz9KzsHrVhvyTvFrWNcBB66uT8o1M3?=
 =?us-ascii?Q?T9xoqXCppL5NIZCLswIc4PKNtud23v5Tw7dHaxrTb+1JQdVJ1hzaPLkTeNkg?=
 =?us-ascii?Q?Ddu7kvsLeicCboyWQOxFDfE2+arIFGURtjNVR7O6q+OALAAM1oVZGYoCQVPj?=
 =?us-ascii?Q?zMoUGfHxCN+fPZHRqWL9EkhF0tEQNyqrALG99XZxSToNr0afk8WSr+kI5Pjt?=
 =?us-ascii?Q?VcKQolfMjGtu7aX2hZ3mz2yaSUPR/ayRtjABFDM5ZYZJJqGHElVOyLkdwuRO?=
 =?us-ascii?Q?GFgzqVAc3hgQ7r4narHMYk4gvtUVlTigWmZF1xxSzFaVoApW/4wMWZ2hsZMa?=
 =?us-ascii?Q?BE3gJwC7PIcRey/QUID18KijAkDBzx25V6dwkiUzeeleLqg+1un+sPpJ+WfC?=
 =?us-ascii?Q?xPDbKl9bjfHzFJsnET1cRul9qJ2zK9J5Uyeg7XE8Rvp0X/wkS+e+4iLqZF/5?=
 =?us-ascii?Q?E6HZWVm6WA2qiNN8SOmfKNoClq6YK4s65rZzhc4ry6Z0/QHRyAnL/na4eh7f?=
 =?us-ascii?Q?uHpLM0N/P4a7GPilqb0qbkriaZTVFCZIJ1LFUcwxjkI9W24PE4zcnBIZbdMz?=
 =?us-ascii?Q?sGGoJr+MVpy3CiGe/M2HIw9MHAGj1MDAZLXVLfVt5VMKLnPOOU09Q5VLHNQf?=
 =?us-ascii?Q?HUOm5GHTnIuSMxfrMcC3ImWs2k6Qi9jkQqlj+U7DUCiPAU3Sc1kMN79fHijs?=
 =?us-ascii?Q?8AWeFONjZ0a86v+RUZrk4fJ4lgOQyQqS/M7JADEExwxWEqqnuemGM6T9d6wN?=
 =?us-ascii?Q?/db5IbdF4qkjOey6E2DXmdmVBrkh8HcJxJl074FboYDujX2Oe6ganQEuSyVG?=
 =?us-ascii?Q?7JHyCCNAAbr2LPNXAS05Nq0P2io9QASQYnrHhHcr1e5pNcZtFKizCJglQ61c?=
 =?us-ascii?Q?ty5LZYRTRMwtHEhorvDDHZh5j13OK2Uz12BeyCFmgLm6facS4bruO2BrV1SY?=
 =?us-ascii?Q?f27LCZUFUWqzXqBbd4d9Mf3cK8CTujsVmfWZe6tTfB++7ZJiwEQAq5Fw5CQV?=
 =?us-ascii?Q?WK/Mw3HZQ/Peh9Dw+RGIy7Aew1hryOkHPkTC4qjMaqE8TKfABh0FL0T+EYNy?=
 =?us-ascii?Q?hl2vJMF6pg/di+vqPG8WjUNzlfTIFJ1RheuXHU782/SDfII/Q8+LtXmxI4Gq?=
 =?us-ascii?Q?7s7RQSCvGANzIhU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 16:46:50.5133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 172dc7c3-b69d-4d6a-1b80-08dd2e71b7c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780
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

This structure basically used to the populate the doorbell
information that is required to be mapped.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/include/amdgpu_userqueue.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index e7e8d79b689d..1109144ed7e0 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -78,6 +78,13 @@ struct amdgpu_userq_mgr {
 	struct delayed_work		resume_work;
 };
 
+struct amdgpu_db_info {
+	uint64_t doorbell_handle;
+	uint32_t queue_type;
+	uint32_t doorbell_offset;
+	struct amdgpu_userq_obj	*db_obj;
+};
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
-- 
2.34.1

