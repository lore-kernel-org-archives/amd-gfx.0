Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A266CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 08:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B7410E9F4;
	Tue, 23 Jun 2026 08:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wpAML/uj";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7E410E9F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 08:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdNsBbtpcRBQ8x0PnSTA6C6U61rAKnvi4/Okf7mtUpuCTWii0dIFpX+6Hmts1pMHiWjAvH2G8xFqZGs1W21PsbUblU1HEbxJIcAmo1sJICEGOxjPY/pcmFwUdcVnQe8Ptr/BP0x69FfyI1KmFXhWdFHB3WtW100IsheVEQhPk+AH5ZVdYuQsXf2nau7hiMxlZDllclLOQkeYyeSQtWFIZIbiiGgC5EyqXLDifLPUiRsHEQ1UQrN3/uloCQp9dquOvgU++js3OTdcLPPpgqUfJ32Ukl+GqX8izlABXvAtc2Jqjl9t9LXcldikO6+eg7Kq3pknDDTgbeKvXLXy7XLaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Vt1dFl3K4qYUIBnXDlp1DpsB2YtA5yILNSkkuZMijc=;
 b=S6VxeIpNqkrNHX2PZdOEuUMc0Y2J3HNrhlfG1qD81M/ymmBMwIcmM0T1humqCKh2Lp6qd7C9E3MfAu7Cw+1C3yLfu06Q6N3MMSNsyHk89TXbySg8hwCo1V4GSO8larnjCXWgF12zaXF+DkFv3TpQKLzpXF6Yz0JKUFYSyNVdAoCv6seQEAsxgwIfimh8Zdo97Hl9O/IJzT8NGL7EnIbworwbDNKpv53vnIvtrO+m67ifYsLUmdf+FSMygGQMIAUfcil7+mb8/eOJIyK+aYEqnZpdasMHjcnEfsPzrNnbSxIt/rl9rRuRq6db7ZHBEsYrZyb7JgSHzRkAm/dWxfb1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vt1dFl3K4qYUIBnXDlp1DpsB2YtA5yILNSkkuZMijc=;
 b=wpAML/ujayisRJKXw7OPvPq4hNl3LLYxhkSBZJGCo9KdK4ri40ZnbFrCLvyQFGKkUgcLZkHDqhP1PgRcNU8Vk/UN9UENaWs+mo13CVNEXfElngOEvfTnPsIwq9gBklw/ucGDUqZAet2AAeRrg6K/Ipia6CgVi+J+HoEoQOxBHK0=
Received: from BN0PR04CA0110.namprd04.prod.outlook.com (2603:10b6:408:ec::25)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 08:13:24 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::2c) by BN0PR04CA0110.outlook.office365.com
 (2603:10b6:408:ec::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 08:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 08:13:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 23 Jun 2026 03:13:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 3/3] drm/amdgpu: Add PASID to fpriv lookup helper
Date: Tue, 23 Jun 2026 13:43:01 +0530
Message-ID: <20260623081301.3046023-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623081301.3046023-1-srinivasan.shanmugam@amd.com>
References: <20260623081301.3046023-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: c923b8a5-2505-4067-cdba-08ded0ff4bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9T3UKqmLxTalWQZrIpc9ZgUV51HxBx+MTot9lHp0HtV8hHWzQrurdBoKq3e217nntwer+J9gQ4Kdo5/66AgwnNsry2wBwAoRkbENZGdwDpjosW8c9hf7ioANm26hbYPr7aGP6fpufVRDm4hGvcpI1qSavw17Da9afLePkjEu+VWdS4NZzIRvttYnVimP/X96yJb+0ElfJW49QBzg7ER4asTCG6eUqkZTvog4Lta48bO5I4x9nffx51cfuMPW+cntqJDVGeiNsaeJUdEcvITLUCPILEZpKha/aq3SRU1d6qJWoMn+jX7P9UP94uFbwo7/0j4pjphoVoSZ7gRJO/hXsV7c75BQGwhqBiyzWgKvD2vFDs/DbtKbX7zczHp98RQocOn7/4eEi012DT6xmKFNiCyn2GbyeIMXmxEY/iNOEmDGL4GPxY1OqNJklPC7Jv4u4bpgYD+IbhNQljWiXeH3vbaMc96wfr7cgKR6H640JsW5Y0/svgc+MxnVj9GNpGjIK5SHR/1CPpvo5Yy9Bk4vw+0+Ss6LkiSJ3FKrfG+YdYFYompbAH7iSyTcaZkjlfqt8dtIHRHZ2Kb6ss5vdGRKiP3b5AxzdcetPWCp9YSksG3fB9msbBdD8lkI1CQof456BUMvuIgZimq9Zi3Lok9rzrEfOOmM6MTJpPr+KKGksGNmgL9Mm+VM98jb7gxgY32E3X71Gex0ymcIwM6N0Muu2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4/OAx3I6KMNbU8O+4TQElP3XTZrWFRlZYPz1g/RErgQ4dBJ7J3qdTq1TG0rgsNa/1HL2hI+GP8kftCz7WvwpSSxL8QyHUC18WCiKAFoBg8coOc8dRCvP3Nxtp1jqmQa2+I2QG+EzgXJ1eqcNm5y+LbbA4Cn+QPp448NGAt8uIpSWHjfKbeWrWOZee978rtxrSsdwmNVx/3sV5osgaOPHi4sBvZoxmAakR7NciuF/o7Q+u8QSyAgt6mtm6ibnENGsBPnjK/wbK1aPW1ncbO3yBPf2085tMHKA7VRzm/MmWCw3TajObmDBCBR7PsGWcKn0dBM8dTfe5W8ldx5glhjPOCmLRO+7d99x4H0r0wiXL/kkxKecTGS1T6kVTvOlcwNVUVwZ/oh+qqx+i4MvSwRJ6qsxxbMZtKxpjNolXEvj+cOXvuef65Tt4Vd/w/wF6Q6+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:13:23.9321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c923b8a5-2505-4067-cdba-08ded0ff4bc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189
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

Add a prototype helper to resolve a PASID to the owning DRM file-private
structure.

The helper provides:

	PASID -> amdgpu_fpriv

This is intended for process-scoped event routing such as EVENTFD,
debugger events, SQ messages and future WAIT_EVENT support.

The helper intentionally returns a raw amdgpu_fpriv pointer

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5f1b285b8445..eb6eabbd800c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2933,6 +2933,20 @@ void amdgpu_pasid_fpriv_unregister(struct amdgpu_device *adev,
 	xa_erase(&adev->vm_manager.pasid_fprivs, pasid);
 }
 
+/**
+ * amdgpu_pasid_fpriv_lookup - RFC PASID to fpriv lookup
+ * @adev: amdgpu device
+ * @pasid: PASID to resolve
+ *
+ * Returns the DRM file-private currently registered for @pasid,
+ * or NULL.
+ */
+struct amdgpu_fpriv *
+amdgpu_pasid_fpriv_lookup(struct amdgpu_device *adev, u32 pasid)
+{
+	return xa_load(&adev->vm_manager.pasid_fprivs, pasid);
+}
+
 /**
  * amdgpu_vm_ioctl - Manages VMID reservation for vm hubs.
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 333bf14cce6e..e14ded69e31c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -519,6 +519,9 @@ int amdgpu_pasid_fpriv_register(struct amdgpu_device *adev,
 void amdgpu_pasid_fpriv_unregister(struct amdgpu_device *adev,
 				   u32 pasid);
 
+struct amdgpu_fpriv *
+amdgpu_pasid_fpriv_lookup(struct amdgpu_device *adev, u32 pasid);
+
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id, uint32_t pasid);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
-- 
2.34.1

