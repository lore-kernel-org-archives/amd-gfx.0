Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC45C7EE39
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3359F10E424;
	Mon, 23 Jun 2025 16:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vCY4EQtx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B59610E416
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpfrOjVOi3PdJZYNhNT4u/GfBj/iIVSPyt1MLsq1td8LuG66g126O2bZkd37k0zReBoRObp2cXqO7oWHDqmXAoXj14bzgnMZ+dKTc87cGFcOZXSyybv3+LL40pIOEj3w+UTEGlP9mQSTSyyWwKwlqAFAHy1zeVShtFsQIuflxDFt64txxkdy9CMk/BOqIbYT6ZXWaycPt5dAehKk5zuzwuxX1cAztd3BOMvrYKCjHvmG+/Mlm4Xv+W6hJ3Irv4DhClCsaYVQKE+4R47k8bLh388wWWC8cLZggHFtuFhEs+Fgxz+gd9XlbAonnaJRu6a3zwkMk0g+cV/QKg51WDEx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGFupS98QYmlFYjpZKYpTCYpVwfHYhT64G7FY9E60uc=;
 b=TnaGGeBvPed0d/k6D5swhUMhuEL5TeAumh6V3thIlk5nQjicMpeZL6xJyk7umW/PkWUS3BNSJ7ncybFxvk9QMZHQk0Pzl6ML7gH7puziKlkI4s65E3t9+quWMphAAcCLVPwtoDLeSzgpiXeTxrRj5fkiGUqCFOBaRrRdW4vSzkmz+fpr2AKdWSJsnMewHGIuXvJ4dGAAHh4DzuBmy8Wg34NFNyYsAMq1QIQOjmIzUHQlt5OMeK0iTMTp73On18EmlVhA1Mrz/czsAPlwDou3cq+MxzN+9swlS+a1BXbRBDPOWzmoK+YWNBb9zXOLrHMkcPQuJDtwLap2k7ZlYwLN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGFupS98QYmlFYjpZKYpTCYpVwfHYhT64G7FY9E60uc=;
 b=vCY4EQtxoa/dlthZuS2jsa6v1ZtLS2h8Ilvs39peoOOyolSwufpbXMTIdupl8R5ZVuGhWXXmxsPK9mIrhZszvxh46LDf01THc+wlMQ1FPTOhhHcy2HRz2NEBsfC6R3bJfNFLe7HkQ6RARGYh3DrKa9bnWOdHe8tVTfDlRIIoxDc=
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 23 Jun
 2025 16:15:11 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::f8) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Mon,
 23 Jun 2025 16:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 21/31] drm/amdgpu/jpeg4.0.5: add queue reset
Date: Mon, 23 Jun 2025 12:14:27 -0400
Message-ID: <20250623161438.124020-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b291d7-f56b-4fe6-4430-08ddb2712098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uYEoYku4blwuLljouTDbJIQhmkj8O3Lo0eOvCkvpbCDr7nKE3o+21Lua1dxb?=
 =?us-ascii?Q?ZBshBMdWwFV1h4N8pbZf5JRqhor+GA3uO6c7R+/QhRxuil16P+HuOV55ViiZ?=
 =?us-ascii?Q?K9WJXNA60uOVHXQYfTHTkOA7gnUfAu1pmrLeghgma2J2V0rg/98Mqh3M2yLs?=
 =?us-ascii?Q?0oiR78Mpb4ApfrBe8bj8iT5WxbAjlT+jzLC6wWDhGmSBeNnuVDLzl7A38T46?=
 =?us-ascii?Q?YlRTX/Yurc4R/OoytgRWApfyGunfWb2OvOcnxFGdJiC/VadI4HevzHt3A3Ng?=
 =?us-ascii?Q?tIiYsw+Il3H+3o8LCjh7h7NN3G34d85pjd6mMFnust1f46PoqDOW4sUasSl7?=
 =?us-ascii?Q?/C8ZF0zJRb0ErcDymYHYxb0myGbODfvBi2J3XkgMlMFNOY9KSRlxZA2sxx8z?=
 =?us-ascii?Q?Zp+yaHVPkdCYNxHkH0JpyK3N1+uEQq9UhipoQS9+t28XxTQKZPxPaCeUq/tB?=
 =?us-ascii?Q?Q/9SqLrXfPNIoJVhzP4eqDCWoNXkmw653/p5cdbuCyK8aMWXNodmBWdQBrgN?=
 =?us-ascii?Q?jRSQHHX1v9Ze7u50ETluWGdYDhlyWUFQgJf8n5EY87ILq37ls/i/qrL5IYOO?=
 =?us-ascii?Q?tauRawTQKSl5K/nBnLwJ495mHGet+KGuuaClD0bZRHG/NMlnh6mD/r5fuW6r?=
 =?us-ascii?Q?nxLY97avp41rOpr9vSclYDC7ojALfGZP1maum1tVzyhrXI8BPQ27Wu1cBqnB?=
 =?us-ascii?Q?QvGQUJ6/Q3aIWz7mixyNoM+r0qK8PE/PjHMoWv6e4zJbCaWnSmtv0dqvfJla?=
 =?us-ascii?Q?fSSQZc8Z6Pw4YpqeU5cYCqthjoLmyx2mDslArmtFqyUeHx5Sw2ThWy/hI5/y?=
 =?us-ascii?Q?yCBR2rIYP4VcL/fqhS23VNDyx/1w/jQtiQKjyhFkfO2FG49KZCjVBjfdsDph?=
 =?us-ascii?Q?3FZxqSzh3Qo7dWekoDVzoEUHsXEb0JXr2HjFIsGhX5KMgPORw77vCN89TQiP?=
 =?us-ascii?Q?EmrFFKmrEv6N3ay1URU7uJsAkDN/qbaMJZ4vKECK93qPaW7OZq8YquiYilY8?=
 =?us-ascii?Q?6yMZiROdSOa3AuON4fPufyeD/Qz+VE+woHuznW90gPdcgRp0LAhn7+JG4Yo4?=
 =?us-ascii?Q?/Og550+deW5CNRoXjgTlqKZhudAB0VRE3NR8ViX7AV9G4Awng7Y4qTa6FESF?=
 =?us-ascii?Q?E83tE2Lidhe4LR4gbbJPeberjXg8/yjrYe871Rzmr6r+HcKE8EdTVJebmk1Z?=
 =?us-ascii?Q?ORbPgpZHtqpgXd03mUusQylzF2kLkP2IoXodUdCMcX+eBHvRXB7snTgYYlFr?=
 =?us-ascii?Q?GGuFfTHYmBsBBEsyDpBvO5QuzE+Tc/0V+ey4axHdfRCXGcU4E2xoY+9VtBis?=
 =?us-ascii?Q?k2pv+IiDPxaX9r6DOqv0JSNCN+QVS7hvD228/jKj0UA/uW5mEsMTrs5DsD7+?=
 =?us-ascii?Q?Bf1fUJ7PSJtRbXVZIL19SNgaWJj+hfT/PrgZHkY9eIbExOGjTEWnoJhQHd10?=
 =?us-ascii?Q?gF41W17fKRSVesO+UDFynWBv3EVQDsnFweSCBd5Qz0Eu0ts3E69L4ZtrJHhk?=
 =?us-ascii?Q?v2RagtsbY+htHu72dkWt07bsJustsEbyPzXQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:10.3960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b291d7-f56b-4fe6-4430-08ddb2712098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805
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

Add queue reset support for jpeg 4.0.5.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 974030a5c03c9..e6e90496135b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -767,6 +767,16 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	jpeg_v4_0_5_stop(ring->adev);
+	jpeg_v4_0_5_start(ring->adev);
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.name = "jpeg_v4_0_5",
 	.early_init = jpeg_v4_0_5_early_init,
@@ -812,6 +822,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_5_ring_reset,
 };
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

