Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C276C52D1F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2506B10E86C;
	Thu, 25 Jul 2024 15:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gIROkri3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294B410E84D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IobSMdSuKvsrBTJ3TUzkhc7xgnKtXzA+9zR9oVvZAG7L+z5eRboKJkmE5+GIBkven1p9Shie8BbjIz/4kM2pFJfX8Y2GbJuhbG/am/p+JcRJ+BB3kFFVRDfnygUPmM0IgvJzjhJDDnguNTeIuJD3X7+Tqw+PjwFTS+0c4cjAV287Lz3ovGWxtrqJcTos9zQ50+H10lHbZ/5ByAnSacBsSXhxIhdkPR9pKxIbHTYbHmXTZR3bbCTBBP+JsBmo4azPsrENE/TB2xntR95ZXZSpZMyE1bKYsedP5V/6QgezBStSOaGX7uw5F8CTJK7RRELAjIlTtqQVaNmSdUb4mThWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsFTANUQuu3mpK03qzehtdtSN5aOY5MfY2PwiMwb2Wg=;
 b=RK7V2CTfQvAl84MTvFn5WCfvwBtVIQ52L6c6glTI3RC1EXFqNo8k0kvq/Y5Aht7KDg1Ney2cfJ0J6H0xJ4YKXXMaXn8XDTGNZ9LQoFxOJTAvDFW5xC2mnSl9Zf9DEdg0QVJ/VzS4zJ0mx3yH3DS2LR6J0Iak9MKUCL4yy++sxQIWr20yvDM/SVXKH2O2E5wZEYkQEzyDIGkHU8z4NahpvHCNpp3SQZeRdbAQ+iBXuSRaLdAt7CGE/I4n29Y4JsSRq88nurACOxq1x65Ca7ZzaF3QMN3U/lkzmRZsV9dk99q6NeRmKnJK46HhHV0Hd0Ek4kzLZqqaqKan148HBi47Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsFTANUQuu3mpK03qzehtdtSN5aOY5MfY2PwiMwb2Wg=;
 b=gIROkri3qHdt+zXWytFkjdEqubXZnuH6kQYE3hEAAoSD43Z7LjJ4ra7ac9CJ6xBBa6xG54qaWi3d3kYKYHSnDLm05yyCzFQ8U4pcC+RzDvStRod8zbfJzrEakUTu+nt4EKxxX9yH+wicPNS68oO4IVvZTDKrYx7VDb+pjnLcDY4=
Received: from CYZPR10CA0004.namprd10.prod.outlook.com (2603:10b6:930:8a::9)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 15:01:39 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::a) by CYZPR10CA0004.outlook.office365.com
 (2603:10b6:930:8a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 53/53] drm/amdgpu/gfx9: use rlc safe mode for soft recovery
Date: Thu, 25 Jul 2024 11:00:55 -0400
Message-ID: <20240725150055.1991893-54-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4f2154-bcd0-41e1-2f79-08dcacbaafa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80OUXxHAE55nU9cFFErWvlKZRevVRMUUFrCdy1TvbIkLOqfeEPeFVbCE0ip8?=
 =?us-ascii?Q?szihlwgOD9BVx2MA996ruH3OO01hKcJN53//4T1+RMJ5+ejrriVovPCkskFj?=
 =?us-ascii?Q?Pg+VmO01998/hhvvrMLQjsZ+dREkoM+pFOynY1SSsjEc1wSWzOM+eaxm2cf1?=
 =?us-ascii?Q?EqL6R0+tloqWE7AsxC0RT+aLp7nDQb2waT7S1mwy3O+RNbUqb8TpSTEv1kGK?=
 =?us-ascii?Q?JI/Az/8OC1QZyKJiM98nHeE1HKD7yI97vrWLHCQIm4/WnQPHc6dif+TztkzJ?=
 =?us-ascii?Q?+6b59NFadaEazH45RG98qUZIVuY/lixKUdKLk1sySkKgba3Pi2dM803dwID3?=
 =?us-ascii?Q?eS0KsIJ0mv8QC86wKGrtNi79nv5ahDSQ2n+/5L7vjDQlO1cSOhXKKlP0Q7Ug?=
 =?us-ascii?Q?LVDn3vAIuqP0ZuTcwe174zgIIBel7PnOm/eB7g2ufXCt5+KznSS3P9emskpK?=
 =?us-ascii?Q?JDUt3ZbQgAgSsqQ6bO1dpLMZjTjKakea11eGPqbbke8JmluWVqVZ1JsCeO3X?=
 =?us-ascii?Q?cbU/d7s4QgM3Dm1cdTqAHv+tfnIOm4HBFTSVozX1g00VVU2MLFgWWhXbM5Ia?=
 =?us-ascii?Q?zphp7badSW1qwkyHxANLq3/FEfp4q/wVh4YXzA8v8pF3WebnFXcnFraQHflC?=
 =?us-ascii?Q?AQVcBRiKwa4o9iCyrQjAzeUdJ2MDx75iDDJuXpO497ieMlv4VtG8bTLVK7EH?=
 =?us-ascii?Q?Lx2N4STLwgvJWhrGoKENbd5Y+Ifc+kQ/qrwB2rfPCwkUf9UUNfe46DaN3dwB?=
 =?us-ascii?Q?HHhlFoBKGdazHf+b2s8ekilPi3oDcX25DmtSmL0EsUJjv+K/Lzehxo34tMxC?=
 =?us-ascii?Q?a15KdwM2RiqxJvYyW2rqpDcpU0J/CTpjZDTYHdORq9KcqOMZiAvXzvTJ+MMk?=
 =?us-ascii?Q?vrFfQFs5Z/HWXtYtQdfwBXSJPpRMzyWYJVYbL8/o/WViVs5NIFxrLbQXQJQA?=
 =?us-ascii?Q?DzOYkSxVNFH4qqcoM4pCy890HDn6H/2SrmYxO/vNFhxLgRZe+9lPQeUnmJov?=
 =?us-ascii?Q?+pfME06seMASqPDNzlUgdGq1RSE1+f1XWtfZzDl7c8i3AOiJfj/ZjLNuHtXv?=
 =?us-ascii?Q?sRr7Rq2CDCaZuki7rd435yvGNdkO0ooRAs/sizYvUp/w43c6BMaLBQpbMmXT?=
 =?us-ascii?Q?14ueLLhKZWKMWELI85GJPCttX598i24Nf6QQ4ZZ/HGWHdHlte6iKwBLy/8J5?=
 =?us-ascii?Q?FYLtOzSo8zkuE+FyLCrYFOKVlrWq4qikLys/CRXbE1axHJe9lxdYYq3zmsqg?=
 =?us-ascii?Q?+ifZt2im8z013KEI4lNTC3H75UNZ3LfX70tQBh7Mhg/wPaFp8IJNpbmWbdEX?=
 =?us-ascii?Q?MyPfUbMNO1OyvFj5mUhTlrVMG9UnDIdJRIYnTTCxMp9l4NhGdXHT747JffBr?=
 =?us-ascii?Q?idpc1qnM15nwzgjJlt3QiqAfHOHFcnHW567txCwrMrVJYwwrXpw67QZ4IZc+?=
 =?us-ascii?Q?FfzVJ+VO+xOT+DPsszWIn3zupOE0pIVf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:38.9185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4f2154-bcd0-41e1-2f79-08dcacbaafa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 77e64987bb03..11a565d7b5d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5907,7 +5907,9 @@ static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
-- 
2.45.2

