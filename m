Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604E5D13588
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 04:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0916810E327;
	Mon, 28 Oct 2024 04:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FQHX6QkR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1EB310E327
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 04:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYZAnyV8p63N7iowCYW4/NfjCf6hJI2nqlNoDKr+PwgrH8Fb7b5eTZ+F38rpP8t+LnLzoOxi9aublc0QQFhIY6L9efKhy+eYrtK/sr5SEYl04lmpl7ZCrG4Clj5wUpJ/kBBuHM11kjrABjshJ4Pov67KCezfNHScE4wtlpvExERzwIk1Q30c+0pV3Sfm2USWmSZLSt6prdPro/sLfygiGBdsisQG1bcREr4glC1HVu+/zt0qb38+NdrPG1WCOmduxYJIcPGF1G61RaM/+6DrsX9tp0/lBcd0l6UhlYLQLnzg7iQ9zP2hnM2r725bxQRp3KWiQ0rho3dF6lI/g9wTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIK2kpDVGPdCIZCjrZnD9Uf6eiMcBPhYui9QXe+oAs4=;
 b=UWUHcIYgwJHOGM3On19xMNtPX6ZPUjGymKK4wiUbpxNjZ3FondSU7jnrwcAMiyBlqjlbXM3QJirEIUcSXDCIIig2WWiFzk1u2ZHuVy7KYaMB8rr5q2puojB1UYL85yrB6AS/gtdTy4WIcy9g/ZqgwBsmT7WF8SLKMzDPSib+BE9jzjr0HXRNHZ+Ay+lCYWCpZxbClnRGYXt0RtA2vxgr6b06oPWiB00kz66zF4jlWJyrUt6oFoqDJvKANm8+WXvQG+r1uOYzGbBAyJ6iiiSqorb0MAbuZI77vHW6Qic50AW3RD6/LoPfHhBYykuuHbl8FihcfTdzwPq4LFlnPV02vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIK2kpDVGPdCIZCjrZnD9Uf6eiMcBPhYui9QXe+oAs4=;
 b=FQHX6QkRcjfujDA2XZUNVXCbBUQ/av0+plyAiQ7qrFkkYl40xjodWG3TR1tMBlyjHMLvYgsHsK5LsWJJnQ7gumhEETWu4fEwcknQ5iBtKSjPpQvucQ9LEde2dQ+ekZV8ujKklYhUM/ZGF9CgjB+dM6NjS70Ox4O37HeuLWBwPew=
Received: from BYAPR08CA0050.namprd08.prod.outlook.com (2603:10b6:a03:117::27)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 04:04:37 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::3e) by BYAPR08CA0050.outlook.office365.com
 (2603:10b6:a03:117::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 04:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 04:04:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 23:04:36 -0500
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 27 Oct 2024 23:04:35 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: skip amdgpu_device_cache_pci_state under sriov
Date: Mon, 28 Oct 2024 12:04:17 +0800
Message-ID: <20241028040417.3204840-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f86e2a-4ad0-4ea1-8327-08dcf705a3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UGhlx8LKKbO7HwIxbglWAshSmP/MZbPtf7Fi7SZVsDhHJr5duJZkdT1QiJdw?=
 =?us-ascii?Q?SlCQ2kNBKre3TmNnx1Qpk6CgW5wFbq9BJ63vm+nym/rXrIWwsWUtXzfSWqun?=
 =?us-ascii?Q?R/aJ/jJe/AH/DJkhZAMWt0QgoIm/fBWO3rQgkB3/JXo04UFyl48RDm+9Lf0C?=
 =?us-ascii?Q?TfZ02U3ofsF6pzKmbeQeYGsp39gHnU9H1PB9HnQJTXb+5M7/mzhGkLSeG+DR?=
 =?us-ascii?Q?3afEEHVFT7hMPO8mnsgbzlDag/MXk7ghnmq0cHS5KV4QdeUoF9JVsadakaJg?=
 =?us-ascii?Q?qv4NqhaSYtLVN0tKMHhdKhOKz/ufEFSCPSEyjaRdNh3nhy3CkXzTcPJHw0vR?=
 =?us-ascii?Q?buNKhJphjxte7heZFwBcHZospGy3CahdbhMSuM/YslEyhk+wznsHgG/jXXnX?=
 =?us-ascii?Q?wCqN53vM4hMZd/E5VMQp7xei/Sra/6FDADvC+eIwls+hE8iWARclpSXEntut?=
 =?us-ascii?Q?wy2/EXuUBF0kQi8rkcNtVO6hOiBxNry2RiLqkbf/Nr+nw4/9Q4Aew7yzsPXP?=
 =?us-ascii?Q?DGBBXuYMbniiy8PcCb3RcdFrJB23XzknpC91roZjGw64ytBxxbOeNUEAoCgq?=
 =?us-ascii?Q?kHRILNW5Huoi9ZaNduVaoI6r0r44Sy3sP5Nzf4wZ6SzuVcxSPvV/bnqW6aUk?=
 =?us-ascii?Q?kXWVYsF9jK/waNiarfvyNIdV9mhHYvSYbdlk8ey37b9xoAvXQwdU03SYiGX5?=
 =?us-ascii?Q?xcw3qiPlOnUzMOZtnXeI+Ia+beQENtQBbQW2BR1ZAKl+g5IO3KaCiZJi2ieV?=
 =?us-ascii?Q?GRVUjL4lt57r42guzMFYdoTd8uygSU88xjv6u458FL/qMQlLBgK8epEufUs0?=
 =?us-ascii?Q?Sdr1nRROfmn4RR6VbG7b9PdPUmoWNd+hsXAuAhtXlrIeNsqPVDsdoQcvff9d?=
 =?us-ascii?Q?UjrAsp11GDULNTxvbOJElO8XZEzwlHZCR5xCi9+3DdEu3nwYo+1pcMyV7pC6?=
 =?us-ascii?Q?q8B5sFhf8fnh64I+xNA2fpvQZAqA9aDGtuU1eg/b30hoEQJgBkaDKgNeRZbh?=
 =?us-ascii?Q?WAb8uKn4q3apGHJ+EqosKZU//jW0lOzIUNKVGMij2ZJ8VAk3Kbfm8Fq3R9HF?=
 =?us-ascii?Q?iRc1NF0m65C+Ry+46bIabx97jHhewMwzbIB2J8hUGUt9eza71idxiIR/HIYl?=
 =?us-ascii?Q?c24vsatLGbO98FJeABZ5De/w9KXqg0JyT7yvf8ScMQ6tQkaZqvzutQITEjd9?=
 =?us-ascii?Q?goCb2yhDmut/UadAjk8ybs0cxTq9VtwUA2q+hX2KZvbQSr9R6jI7eNjtXwV6?=
 =?us-ascii?Q?PJZF887gTnNptEpsxqlqOxHvMizvRtgxQAqBF7Jyhbn2lY6Zc1ZkQlEqq3zc?=
 =?us-ascii?Q?vJgfdMYp5RhLWnZkX0aV0V+32Ye7aG9Rr6YUJ8EmZnjch52w1hj8OlrjAT6Q?=
 =?us-ascii?Q?r/TNgq+rGkHWBU8BDHeup1bkU1CIw10EZHdiwtFqt+n2Pm+c6A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 04:04:37.0479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f86e2a-4ad0-4ea1-8327-08dcf705a3a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
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

Under sriov, host driver will save and restore vf pci cfg space during
reset. And during device init, under sriov, pci_restore_state happens after
fullaccess released, and it can have race condition with mmio protection
enable from host side leading to missing interrupts.

So skip amdgpu_device_cache_pci_state for sriov.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 383bbee87df5..64622dc57a6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6451,6 +6451,9 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
 	r = pci_save_state(pdev);
 	if (!r) {
 		kfree(adev->pci_state);
-- 
2.34.1

