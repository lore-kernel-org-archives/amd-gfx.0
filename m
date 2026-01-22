Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1B4C44536
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EF910E035;
	Thu, 22 Jan 2026 10:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2jgHjEAx";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE4010E973
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=It29aeIQwS3rk/gl9ZN33f3OH+HvFx3W2FFFTtXWXT63YC8RyQx5Qe3zVV7mfY/npaRdzdQx5S+0zHZQ4XAsmpJjXBegy4Bgnzvm23rr66EgeNX4Td+hfYUgHGkpw6Blm/oldJ8jUCl2WsWPrhCpt3MRJ/FKLk/fLCukX9jcBV4L1ebk0batHBnf5nPOqbQOxUK50jhG0Za8gGPuQ3wkCMyy130AQMLb0fOMTuNj+dwoXNov+ag+xMEhIf9WHxK+fdfK0VEB1thIOEfwRRPlUrYN7w9dSvUGrwXr3RAxOAle4OhI0ebdPLCLMeFXBd8MUcU2haFZqGURbiBWOtKWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSTLBH5pkatOOc7gO0Y0xtvaDfofy7GCmn9k0QDBJAo=;
 b=izF0IWJ7mmfUYE4KxElPeGhcpMhtlgs/4j5ZT8gfR2aQ+QKIVJITNNLjXdJPffwmDP6r24fW2u31qn4SahwHqxWI0JritvBstZvB5cWZDNn259UArf5Sxl0UdkexMIW3ug6ceTt+b4Dl869Yiz9EmwkMGynX+5AvC15muf8H7Y25CF3cCkhYHHNoWqBpQqQEfiuLaVkdaDzdgJX4t5/z0YpTpzWcSVwAFNh3ZOPoWRmPef6OCj8Tbp27WM/hZOCMIAGEwqSpbsQ/rd97AMq8oEBQn4XxRPYKoxZAefbGH7yQqkmDDn9TIA+8BF5DnrytlGzB497sdWulJw9FL2V4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSTLBH5pkatOOc7gO0Y0xtvaDfofy7GCmn9k0QDBJAo=;
 b=2jgHjEAxrudDjgn0XPcG4GB8tcL0ymsQ1nTikGTbPqrMhW71iDPuNB5PLGQuFwV2B77xDCyLKGtqV34EE+UCihhYHUlLl2mr1XGbCel1MlkMLOMeAzUlpqtYQVxBa78ywDChtfyQY47pLd8rnOl8JKEXKtVjdqNYMsfuXcdLSN0=
Received: from DM6PR02CA0110.namprd02.prod.outlook.com (2603:10b6:5:1b4::12)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:41:50 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::5) by DM6PR02CA0110.outlook.office365.com
 (2603:10b6:5:1b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 10:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:41:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:41:48 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH v4 04/11] drm/amdgpu: Add user save area params validation
Date: Thu, 22 Jan 2026 16:09:53 +0530
Message-ID: <20260122104118.1682154-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122104118.1682154-1-lijo.lazar@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: 295dbeb3-8c69-400c-4f84-08de59a2d9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NpZwYQOFhe6ExahPO9RA6Cw9pOksib64qOssc/LdcY0HrNAJaFoiUvwJAHEc?=
 =?us-ascii?Q?jWHRaupqNedQHTJfZf9fE3wGp/IjLEayUwfQxWliTH/KbqyvdUmDPsBcsUmm?=
 =?us-ascii?Q?uCfzlCNYamiOPZRD/imZQ6AZda1YfmSVU+gaEvBDELfmue5O1EZlByg3kaMC?=
 =?us-ascii?Q?STCwB0jbNEgmTWSPAXNN+F/dh0F3kvhnROJwtkdV71OkKsjRm/B2OQSCq98X?=
 =?us-ascii?Q?P/OXnpTdK2kepar31OZ/ytK3vVSmDnr1VznxY1gyaKPVrraMfsDeno7Jn63p?=
 =?us-ascii?Q?YQAzAuWjDtwjV2JLQyqJGamSFpeOi1iVMCKDBlAPDyT4uBWG5nWkHxxXX63P?=
 =?us-ascii?Q?gYPNdzFWHCy0g2BBd/Srh3I2LJZRF+FKRk9wmFCkLxnr84UZKAOWMXgtCfna?=
 =?us-ascii?Q?CdxSbHJNbsrN8x3LzCh9cfmzY9GBJ3hSMNw8zhqVTKl9YFPYXQwi7vYwLYMm?=
 =?us-ascii?Q?zUZtBvOuZiHOxnIjldyCsiWLp6FKQyilYNwxOvdvJE5WB9nu8e43TH9Gh0vi?=
 =?us-ascii?Q?X36r1TRplXVB17A4w3N5ttV5KmCeC8gOzqlK8QKC4IdG8MglB4BrRkGnsMf2?=
 =?us-ascii?Q?nzGTQ5LQ0VARLSjLzkG4jbO6M5bH5ghxgz3fKPqL00RAuOfnogeo7iSI3NBb?=
 =?us-ascii?Q?VdsoKQ+hSva9IZXpYnUyCKH0pMbYjc+wLoZKyjOLbk+7RpB9SOKT8B7dMoX6?=
 =?us-ascii?Q?hd+i/65Uzrno+5iSsHSCYQewbKGay44oGYvopzLm9cnY5nwkRa3n8F576NM1?=
 =?us-ascii?Q?nmq9aw//trR+w5DKyxnwbxygGO/GQF+mwVkDKaStjKQX01xejdmAZ8v/Fikv?=
 =?us-ascii?Q?nMb2oeBDD5CK+pe/SmF3f0WooqZNRW1KevX3PA3zshNkY9S0s36lLE/HoDWb?=
 =?us-ascii?Q?+WMwUYb+xS9iqbuKdHTNRBhBMBvVqnjboXrJ5s2Z/kJ1I4km7xxdFDBLPPod?=
 =?us-ascii?Q?Y5RhSKDTeGQpmR8h6UXgZgTmdc68W6v31etHUIYv3zbrfXj5/JIe4rutVycD?=
 =?us-ascii?Q?uaLIrw3fnDYBYta9S5fr5kQjq7S9XsnlhgC/Ha6c46uxQUJC7MnzM4O9tNsS?=
 =?us-ascii?Q?RlMHyx5Q0/rqpV1I7cg1izGbooxd3I6l4plM1YyiJYIMOLdTKzAB7j0oSm57?=
 =?us-ascii?Q?tQf7PgccqpX33ldzOnnyzhpBBkZHNEel9kXzriF2L0kEeb7TwT5bYQysLheq?=
 =?us-ascii?Q?IVS6zq8boch4vLP68W8iURpoytFzl13FewrnY+C7EyqyBfKVkENt2KPC/NHd?=
 =?us-ascii?Q?cz3W81KMQ9vnFnu629S72TJwYFsKZj3gP8DgfcdTKB7nFZ15LU6MvubBJJ9D?=
 =?us-ascii?Q?hgvjYyjRWysQ1kcPitai4jHMBXt8mKJNRp3NyZmKH0CcOpKUgGSXOyBuRbxL?=
 =?us-ascii?Q?CUH4VrSvv4rBCkM1RS0Z0PoJ47l/j7DOSLsO/z5aufEkANUDyw5QAh763FOD?=
 =?us-ascii?Q?cjerAoh7Pyy2/DnDHMDCTk/e9iKPtIvHHn9VWGQtR+5dbyetP4Jg4o07Ydk/?=
 =?us-ascii?Q?pkkfvymiA/mWQSdY4+p52nqwkgvzmaIkJ7g0t/vnasWp+yd8BtgK7AURiRTF?=
 =?us-ascii?Q?tvHpnfAWRRDqLzYqVhvx0pa/EE7E+6C0pqxwdQy6sU0+JC2kcxenlR/o45KG?=
 =?us-ascii?Q?dULoUoZEA1DoZqiciBqPtvhLfg5FKPozLIOUFx1iTEzDnVBs98grkl9URXPo?=
 =?us-ascii?Q?gvOBAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:41:50.3977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 295dbeb3-8c69-400c-4f84-08de59a2d9ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
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

Add an interface to validate user provided save area parameters. Address
validation is not done and expected to be done outside.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 44 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h | 11 ++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index 80020fd33ce6..32d9398cd1d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -64,6 +64,15 @@ static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
 	return true;
 }
 
+uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc)
+{
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return 0;
+
+	return num_xcc *
+	       (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);
+}
+
 static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
 					 struct amdgpu_cwsr_info *cwsr_info)
 {
@@ -425,6 +434,41 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
+int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_cwsr_params *cwsr_params,
+				int num_xcc)
+{
+	struct amdgpu_cwsr_info *cwsr_info = adev->cwsr_info;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!cwsr_params)
+		return -EINVAL;
+
+	/*
+	 * Only control stack and save area size details checked. Address validation needs to be
+	 * carried out separately.
+	 */
+	if (cwsr_params->ctl_stack_sz !=
+	    (cwsr_info->xcc_ctl_stack_sz * num_xcc)) {
+		dev_dbg(adev->dev,
+			"queue ctl stack size 0x%x not equal to node ctl stack size 0x%x\n",
+			cwsr_params->ctl_stack_sz,
+			num_xcc * cwsr_info->xcc_ctl_stack_sz);
+		return -EINVAL;
+	}
+
+	if (cwsr_params->cwsr_sz < (cwsr_info->xcc_cwsr_sz * num_xcc)) {
+		dev_dbg(adev->dev,
+			"queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
+			cwsr_params->cwsr_sz, num_xcc * cwsr_info->xcc_cwsr_sz);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_cwsr_trap_obj **trap_obj)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 3c80d057bbed..96b03a8ed99b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -56,6 +56,13 @@ struct amdgpu_cwsr_info {
 	uint32_t xcc_cwsr_sz;
 };
 
+struct amdgpu_cwsr_params {
+	uint64_t ctx_save_area_address;
+	/* cwsr size info */
+	uint32_t ctl_stack_sz;
+	uint32_t cwsr_sz;
+};
+
 int amdgpu_cwsr_init(struct amdgpu_device *adev);
 void amdgpu_cwsr_fini(struct amdgpu_device *adev);
 
@@ -68,4 +75,8 @@ static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
 	return adev->cwsr_info != NULL;
 }
 
+uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
+int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_cwsr_params *cwsr_params,
+				int num_xcc);
 #endif
-- 
2.49.0

