Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534D3C52CDC
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD51C10E869;
	Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bEmq2vHK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2A910E84A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv/PgWxbB2yjNIJ8HccqltBsvBthpBQA+wLyLFqAROoY0kFSwd7W4NWnumC1O64q09UgHf6zN7QPtitPZFYoiEtOaqsqptNFjO1EQLyRB0k0F4ip9nYFdW4Nvpv9fgfShm3i2HokxV8Iq/PxG3HHZ+aWz4CIonnEqtc8qABLkz1SnbqeXQBLuxG3ZPdOWnGDPRzIyhgF0sJD17fS2c10GCOe/MeUdRBW4q4RQoozebXeHcXofyVQuesnVjYV0sPsPIiq3T1BWPEFLCFFhcjwXBXPP96FT1Bgtqvs+SpP7S0hVUeBt9ImWDGaHef+74wgmjhXkgiU5FdlUoAzylpC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHEevypStuDLwImguUii8pXEMrSfGK16rWxFJF8TFps=;
 b=XH4I4Q15TX4hNKUn+AXwaRb4n2uq7YKuEcTZWKRxax4aIXDRCKMFbRCN4p/AR+wVtAF0NmjpMXQHsNMCbwpHtro6YdFh7I1hLPAgltNN+SWB5TcAdnK5QKgYi1cYBHdBJUx8ALyus3CgDxU+Jnwv5e0KmOJkNxlDP55lk07HCoN2wF+hgYCwurJ7Fz1eE85xlTEs8WUuDvrTiS/A7jEythgU+LeMoK0zpWsXCqH+7aYjzoHhz3uDteVVRxTACZmWejfGjMN6q7GCvVlmQW2Js6dEwy7ua5ZA9j31huNxM2MnL77sJHhcknCZopC0z4Jjsg+hWCUuBTTYF/5wYHYLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHEevypStuDLwImguUii8pXEMrSfGK16rWxFJF8TFps=;
 b=bEmq2vHKrBihIVY6z4TrTb4ylno7BwSWSejj/nBv6ZmN/PXBammE/Kfx2PLr2gJGTrc+8ElYh31gChcsrNbFYsR8hoIh9tqX3M3SW7gPaxgez5/3ZX4DYYmglTSTV8bCW8ZJ+8C6UWHrku1ifSfrWD+vVCiTu9lRg2wpbY1QY7k=
Received: from PH7P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::24)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 25 Jul
 2024 15:01:37 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::3) by PH7P220CA0040.outlook.office365.com
 (2603:10b6:510:32b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 50/53] drm/amdgpu/gfx11: use rlc safe mode for soft recovery
Date: Thu, 25 Jul 2024 11:00:52 -0400
Message-ID: <20240725150055.1991893-51-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba68c5e-706c-4283-22a2-08dcacbaaec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oo3UIi9VEfFabiGddQIkekIKGGn8O5JsR6lZU6CB5DFeRd+MnYOXU5Srewre?=
 =?us-ascii?Q?E+HGEwpSHgZZRK/YjxG+tpaOkXK3VLlT+B7KPTyylKIwvI/O05gzfHhWN6aU?=
 =?us-ascii?Q?MquSa2qhsidyYNLoGLbt5LQXFTsdIlE5yTxv57Sk9BoOwGFrMa9lrQc25eay?=
 =?us-ascii?Q?/7msM3pT57JbowA1nXc2aAle4RI/sklcsm4lEj1TXfkLE7meEKozqCCH3uhZ?=
 =?us-ascii?Q?hxFw4fQtKgrj5Ha4oA1/ddI0qgm+1dYEaC4w1exkxiWNNjW2UsvZZguG4NIT?=
 =?us-ascii?Q?fNtX30Sakk6mvsX1Aq48KjfIHiIv0mUi3Z/ZqUBILSNQqMi1WG3j8jqJ6aWb?=
 =?us-ascii?Q?hotZIhO9rCPpaz4eFhNvwexci0CUPb+NKTRwxwVMk8DLRWUhPHjGttwe7RBq?=
 =?us-ascii?Q?gs6/ZDOAglNwu22+poH0vLQ/4V34urindTeDSm60zrEa5TS+My0ZyzFZHCIB?=
 =?us-ascii?Q?4xp61/JP3ed5OcVPrRmYDU3EPEqfhl0YIuQz+IbeRVrLFD1K9nGS7us5PEKQ?=
 =?us-ascii?Q?BdD8BiGda2ZFs2JhgAbROzUkOSHgHQ+BuX5HAYaFHqTAnrd0umOFj/9JV6cU?=
 =?us-ascii?Q?oEjkKtnsOJPE9BA4pFrtwCkfQiVpDeN88Ix7F71bGXIAqLeEaq5NyuW7/l+0?=
 =?us-ascii?Q?lDhFXCVuOrq6G2geU0Uy3rz4MLzJTuwUq8lKsZ3m8FTa0xMuBi+EwyrkcNYb?=
 =?us-ascii?Q?om9OR6heQ5hMxIIS31VCrADcC2z5Ge0IvVo6j5PmH5wZ9BPmbcaLyuhG0xlV?=
 =?us-ascii?Q?fDBGe1/V6Y17OxTSJHRCKHAfGrF7M4CMi5S9A+UGmLZYLYONe7huMNrh+Nsy?=
 =?us-ascii?Q?jUMdqkNThhUJgng7sJPYfuB1nvJ2P02uqWousppBxKtn0A114oJUA7EPCuj8?=
 =?us-ascii?Q?KIsfKhwjLWfnX467pdT/gTsBe+W3XgECaRQ+26FrJn8g5UW2q6UjkmCak50J?=
 =?us-ascii?Q?YVYuFItoG3AnizLl1q1CRI4PeC8NZMNIH0+uUx2VFN/4hQTyWdio9PPbzdN+?=
 =?us-ascii?Q?7IquuuhfriyKnhB56UIvBsi1Bsn6w6EheMa+el7hL6/HzLfJXcMjE5DXAHId?=
 =?us-ascii?Q?Por6qU1mk6d8u4ViuTBqPZpRFv+aGx7NVV/gpbPMf1PRKqJHSNM98xbfhZDJ?=
 =?us-ascii?Q?PYFhGZ0t6djYl78s9TXSz9R7lX4iXJxZdIFKtMlfvPNLSu0l+Lp2QBz0nVgR?=
 =?us-ascii?Q?1KP/e5VKZkjvmPWoaPx3FWKIyoO1lbLFramqgXQ64fARg2OKrIuFSK/voxCX?=
 =?us-ascii?Q?dJ6MmbaxXHh1+LtJyK6M3hgpT1tyKDlsQHk1qdv70ZvtciuAI+pQb9QaowMH?=
 =?us-ascii?Q?BrpHqDM/F5ITV5htqYlfBJnvoUlpkN1RNAU1mx4B5lmAzXj9tEzND3d/Y876?=
 =?us-ascii?Q?TpZOAUL/i+98QJWOZnizheXWuoCZq+D8Mu2jAI6dw/ORpX4149JU9k6FgRtu?=
 =?us-ascii?Q?rjZaCiKJ5bgVcdy1TlDVbcR+6BR8Bqyq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:37.4632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba68c5e-706c-4283-22a2-08dcacbaaec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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

Protect the MMIO access with safe mode.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4198656f9a0d..0b36c4039b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6071,7 +6071,9 @@ static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, regSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void
-- 
2.45.2

