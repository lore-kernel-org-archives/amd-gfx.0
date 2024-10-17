Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503ABD3C523
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 16:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF28110E884;
	Thu, 17 Oct 2024 16:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ki09sQhd";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF4C10E884
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 16:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gu0z1nANLRRL/4nu0lFuCxLC9LFULd775jh0Yu2X4KVpZAW1FIfUg0s5ZJf8vMH7iqmiZfAf8kImkM2pbw5HPF9Yx5Csm8wiWuIZVEghTmUSGmPeZG61dDulg2bVT/WxxjSLzjSkd64vAWBCVy6VZ8iyecPitoNqpk0c7rh3C28uNx1HuBAOzeKLRQcGYfG3F+y0DkT6Uz5e5dGtKFlpmduFicTlk+rN5AerT0ezexJF6gNKuUEpvQylubucSzac0QvnH/c4FC/KpFOxbkyJTIFtUiEtQRfWScHdEdIxSqCZSDjaQcN1L2Wq1QgP0JGQFopw2Onch4uBslGA5dJuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYKRprLuktdth+UwJKko7jGzHLk7EGo//ms5dkFmnA0=;
 b=lvDh4R/o98qbi2bBXufOVSXlXe7jB0v6pirhWRM0pbctsS/IDfG1zKsDEGycqgVIBFMjy6TL5RgeB7ZgfdKFUXEEhOTFUG3dtTDUjrFBBOzfcHxv7BVUTp5j29dsOnca0fg6OOT6RME9D1HjZFsaLaZQ9Ae8Bw5ClY57M+/o/pwf9KU0yxFnvdL5jGT4N/a2pKu0yLJ/T2HB1+n8HvSqJjmrAMMElmSDMFWDolUI5/0cGwXLU31Ac68cDCX3ROD4KdgKkMydalTLxkZ1ndyShby0j2hIyBR+wmdiHkQ+kLDtXBwynRJEy8HItQ3E+IGcKSSM1Yl4H+Q7uNGh7abQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYKRprLuktdth+UwJKko7jGzHLk7EGo//ms5dkFmnA0=;
 b=Ki09sQhdroWPnNOb9MQp46tus0zt74M1V9KnK+6wTWI7dGVj8iB7AVqp0/tNxeEfNJgbqp4hhLXpKRAnKvLeUPEZ8u0Kg2nGAeGAVf4r2lOKAqnQsO1hDexenYWODSTNfPgFKsQsHNlFhncP3aGT4YtL7aJxyKp4pQEsVtq1hzo=
Received: from CH0PR03CA0251.namprd03.prod.outlook.com (2603:10b6:610:e5::16)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:44:50 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::e3) by CH0PR03CA0251.outlook.office365.com
 (2603:10b6:610:e5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 16:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:44:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 11:44:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu/gfx9: Enable Cleaner Shader for GFX9.4.2
 Hardware
Date: Thu, 17 Oct 2024 22:14:30 +0530
Message-ID: <20241017164430.3674916-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017164430.3674916-1-srinivasan.shanmugam@amd.com>
References: <20241017164430.3674916-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: db493cb2-ad7b-4602-bc97-08dceecb04c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDJqbmFCRXVWTGNWajhsQ2hLQTIvQXdtam9IMjY3QWpRNVY2M2JEYkJSRndi?=
 =?utf-8?B?a3hRRXo1azFFZmF2NFpGdWtJSkNuVEF2d2U2ZnlHbjZJajBhN2wxSUt0MEZI?=
 =?utf-8?B?YkZUWG81SllWTWJ3eFJEWEc0Qm96T1hHbHdpOXhYZDRwakdGUmZ1WnpXdUVJ?=
 =?utf-8?B?bXpDamFkeDJ6RDlKbGY1UnVCY2pBUVB0dThobVlpZVJYSC9KZTFZMDlsVDdK?=
 =?utf-8?B?bktlZzdibENWMlhUemR6U3pFT1Y4V0szQmVnOUFwNVNqQmMzejNYVkc2eTdX?=
 =?utf-8?B?R0FlNDA5a2VFaUxBdXBsN3diQWhNN0VxbXVMNTduVE9ZL2tJVFB4WFpJa0Nw?=
 =?utf-8?B?OWEzQm9LaC9hdjZXOTFMdkRYdkJQbWpnbGJNcWN4YThYOUd3NHN4OE1LVjJs?=
 =?utf-8?B?ZHY4RXZud2VRQXBmYkMzZEJtZDV4QXR0NE55Q21hSzlLVkozRm9MVXkzeWYz?=
 =?utf-8?B?Y2YxQWVwRmhoY3hBalRnampTSlk0TyttZmhNVmtpekxhKy9YeHNQR1FJWjFX?=
 =?utf-8?B?eHFWWEp1MHFGaDQvaE5uVjhCdGwvZEt4WDc2K0YvZVAwRHZ4T2dNZ1JwanY5?=
 =?utf-8?B?NUJGclN1b0Q0b2s1aHd4MFY2T3c3ZDFQMkZ5czNYVWduNkhhQmxEZXBqM3h1?=
 =?utf-8?B?MzViSjhyOGJFYWJvQnFBKzBqczQwa0JiVmhhNFN2VlR5N3ladStBNXBIekxp?=
 =?utf-8?B?SDZDemlOQlBydjU4cjNKeUY3Q09UVEo2bmR1QlFGSTRUNnBYTWVhYkVkNmRF?=
 =?utf-8?B?eUI5RWU5dnBZWWgvZkoxaFRXenJneFgvQWZrcjlCM1kvRjVvZzRFVGZNcWp2?=
 =?utf-8?B?U0Rmb1BwcVBIbXlaZ29oRDVaY2xkK092ZWd2dllTVytzUHJvWjlXbk4xRG0r?=
 =?utf-8?B?a05VRUZLNy8wTnFXOWtLcWFOZTVjNUNZQXlCUUlISnBOWVZUTlF0R2Y4ZkZE?=
 =?utf-8?B?TGVWbDB2aXlZc3IzVU4wZm9OT1c4RnJkcVhvaDZ5cEcwZ2R2ZTdYMEVrSE9J?=
 =?utf-8?B?SkxNQ0ltM3I2cnpvWXA0Y3hhdEJuaURCZmpCYXJSWDQzZjJuZ1ZFQm9DMVNv?=
 =?utf-8?B?MGQvbFFOcFordFlsS1lFbkl1eG5pY0ViQkkxQ0h0bHNBbmZTMGttanF4NEtP?=
 =?utf-8?B?UGowMFJkYXdQWnR6WG1Gelo3RmpXZGJ2bmpEeTF5NjgwUlF1V25WSmh0cUY4?=
 =?utf-8?B?TnJVSlVUdmtYQm5jSU0xWWNYa0dpZnZ3RkFJMUFUTXhuU1NIblc0L3dJKzFB?=
 =?utf-8?B?cDZ1SXBWTFEyc1RvNHlDdzhUZUdGVWpNTXhMSjBrdDJZcGhJVmtHZVdmUlZv?=
 =?utf-8?B?WmR6T3lZRWZpdDFFWlo2ajcxY0YyRXE3NEQ5OUNRZXA0cStEWGUwSEkreEt2?=
 =?utf-8?B?NDdVSnNsZGdjNXNPdTlVMXNOU1luZ3VUcUh1VFNZMmEwVGhCTkV0TDlkd0pr?=
 =?utf-8?B?b1A0ZWpDeTZuK3QwbityVFRrMzJMTjJBUjdERVhodWhnaDNWU0tCVmhYSnBK?=
 =?utf-8?B?WnZ6bHVQZTNCOFdTTDlZcTRQbXplSXRIeWdEaUZROUZkay9GTVVDMVUxajd2?=
 =?utf-8?B?dFA4MjdFbGovcVFuZVNPSFpZa3dXbVpaOXJ0ampnVm9kYy8vYXhuUGwrdzZ6?=
 =?utf-8?B?T3gzZm9sRHh2ODE3WHZFQW5SeEd1cEhLTDBaTW11THN2Y3Q3QmF5Ukg5aG5Q?=
 =?utf-8?B?SVVkMmZoWi9OczZvbE43ejREZHNqOFNFUXVQa3JRdGhOL0hsM3p0bnR6U1NE?=
 =?utf-8?B?Nkh3M3gwamkwWUNjY3VZOHNaQ3lRWGJRK0NHdENET2hDM0M1RWtmSTBMVzhZ?=
 =?utf-8?B?WnIyZXlTMWZ1eUw4LzNLaS9iNEdkYVlpbTV4ak1zSGhHU2xRMEgvQ2QwTkNP?=
 =?utf-8?B?bGZHM1lsOTZmWFI0b1pxaGdXS1VxbzdKcE84RGZsTVdMMmc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:44:50.4498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db493cb2-ad7b-4602-bc97-08dceecb04c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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

This patch adds support for the cleaner shader feature onto GFX9.4.2
hardware, as part of the leftover locals feature. The cleaner shader is
important for ensuring process isolation and maintaining KGD/KFD
serialization by clearing GPU memory before it is reused.

The patch updates the `gfx_v9_0_sw_init` function to initialize the
cleaner shader if the MEC firmware version is 88 or higher. It sets the
`cleaner_shader_ptr` and `cleaner_shader_size` to the appropriate values
and attempts to initialize the cleaner shader.

This change ensures that the GPU memory is properly cleared between
different processes, preventing data leakage and enhancing security. It
also aligns with the serialization mechanism between KGD and KFD,
ensuring that the GPU state is consistent across different workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b4c4b9916289..66947850d7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2223,6 +2223,18 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 2):
+		adev->gfx.cleaner_shader_ptr = gfx_9_4_2_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_9_4_2_cleaner_shader_hex);
+		if (adev->gfx.mec_fw_version >= 88) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	default:
 		adev->gfx.enable_cleaner_shader = false;
 		break;
-- 
2.34.1

