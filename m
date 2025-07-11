Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AC8C83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD2F310EAF5;
	Fri, 11 Jul 2025 22:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aHI7Dhg5";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20C710EAEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3ELFrATwleFCOvKyQl0jomWQv0YG8k9KfIBtZurS3Tq2hVivI2WM73zWQLq2S0BU7AEIfBcBBXHjJsIHpHD87n7W25if0TFR0610X1w7IKeK40GZfjjJxTKl4iBl2ZqtfcCCRg1dDT17ASNrUIbIFXKmZGIK2trfBfk8xQQ9Of0SzXp3GIMfBn5SV/D5wUegIaShvyArbBfpqvNdBJCnPoK1xxt+TSke9Menveh12eaUPye425SsFrknvzMvpLPplAsQNJYqhxKZSObjyLKAno3jLUTjT7Vb/BW0MK7qqF17Bjip9QtbR1yBvBHUlVMy1Bl1680jiDUw+vP8j91lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oMIVge0wCyf+/+yLB3DWeWl8sSLF+wkhrvWHUlROQw=;
 b=P9zZh1mVI5zMJlTfx1Rz9DufsU3qCVWX6gPuqC9MuNjCt/duo1lP5VbFre0ON3CW3fe9ubnej/GkqMddX/nNHaWchEBPI1KZxN3pruI2xfNoxx7o+I3y3ZeNVj2O1p2ufplTBk8IA4OcKZIVGouGxgkG8bgqwanKGA6dIdNRKs4/k/mJS1pjISMdlh+uJEOnReC7v3uchmQy3fjSuwP46W6BNu4/L/a13ab7f5OJf4H64HwP/thLW41XpJEHzT676CoT+YE9vdLya4Yu5f+B+DIFP7SjpO+XkUOfn77LnAREtxaE9NX0MS4kyLHtuy9vzsRaGI/dM47FtvHmIKwHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oMIVge0wCyf+/+yLB3DWeWl8sSLF+wkhrvWHUlROQw=;
 b=aHI7Dhg5qn45yKYes+Pk2kWkMY8UATUrgeMDTuW01fueWAWroIHMB3AIXB2nBQEmOvTLdNQFyyyEUqWMSnBi4nNicVCejiw9dBT3a7aU8O/Ec2H4Kn5rRb3X4Lgs4yJppXEHT2qvXVI0x590Aly03tAqPYXsgkx2rZ1eqt5OHtk=
Received: from BYAPR01CA0059.prod.exchangelabs.com (2603:10b6:a03:94::36) by
 IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 22:40:54 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::47) by BYAPR01CA0059.outlook.office365.com
 (2603:10b6:a03:94::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 24/33] drm/amdgpu/jpeg5: add queue reset
Date: Fri, 11 Jul 2025 18:40:15 -0400
Message-ID: <20250711224024.410506-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 57496839-e747-4477-8268-08ddc0cbfec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zBx+FFYewmRuxwnunMWz85ixfI7jpHcda9XdzomDD0VGNos2TLOcRbG1VDI1?=
 =?us-ascii?Q?7JAyhF00IAHkbZq77ktaOH231imCQoCk2uHTkyEEZoNi4T+9q2zXi9LG2tvp?=
 =?us-ascii?Q?iMOTBiY7fDzMMXqx2sjOPPYj6ntX1fTgi93+jD/Q3wZwX6N7XAhpSHXjKxFM?=
 =?us-ascii?Q?2SIwr07doEeiXdV1A8fFdYW/bwvuUMfvQbywmtyj56NVhaNEcWeqkQSB6+5/?=
 =?us-ascii?Q?urtoZLCrqrz5ijGFOsvXOwNh0qs0A461t69f5q2GeYNstSUq6F+jlybdi+EZ?=
 =?us-ascii?Q?29bxR6IxKOvu8OcC3EQ8p7FIdUQm79ijAkvEUrCv7UL5YG89WHS9IGCXaceR?=
 =?us-ascii?Q?bXFES/L1D8Z8fLBWICk7vWJtrVIPNL3bgwnQpc2GntRbu82c2aYLuMo3vQsg?=
 =?us-ascii?Q?A7MBA/wns9KYh0a/ub+LeN6/1zK5be6ep6jof6ROyhbYYtcXSFN+IjfsWyoR?=
 =?us-ascii?Q?hWqjeu626WJbeHqKuoxIjW0to/FIlMEkSvFgV8o1Gs/ZjE2PJYFNsWMVi7Tv?=
 =?us-ascii?Q?1R9fS9x5Ktc2fz2JuRUK0AQM/lU3h13YWUFUjxVQlyJogIDlYi/pNYi+4aqU?=
 =?us-ascii?Q?6eHV8tJ0r0xYdVKxhKhNbcR+HQWD7zg774syFpjbrC9vm5TBL8684KmkAhbL?=
 =?us-ascii?Q?l8pp8SMy5WYa1mnvhE4bVGarqD+F0Exq4Vb76x4cA7Iu9nnCPa6F0xBLX5P7?=
 =?us-ascii?Q?Yzsi05/8mfvyNgOB9Tgqh4iuxIeBsQrOpBswi8mRtUEOCDJPZgBwVChqANp/?=
 =?us-ascii?Q?RSHHB+T+EnjSxUulgxWQF5BIZHwTSd65dO5cDo0ZZm3UyAbxW0eFy0a7RzZD?=
 =?us-ascii?Q?k5iRMBcqrQiIxW/bgeKHtgw3NXOruFAKolGVqG9UQxBwKZtMQAVCSr/AXRHc?=
 =?us-ascii?Q?LYNdVcuR5cMSTH1YXyq8e+Is4eEp8VlFHzTCpDPt7aGGbMZZ89kgLU0Q5sRe?=
 =?us-ascii?Q?9im7Op0xKsFUSLj0O//2nqUvQ0v892w2T6/mwmEdyc7IISnH2rZM8v94vZ3r?=
 =?us-ascii?Q?H6Kdro3QIBypTsfqnC2e4SR3CXpUpStUXN/fOFGkjGRjRTwKz8i0YcYCSWxi?=
 =?us-ascii?Q?xDf5GxRP1TmpJSGQfW+5A+8MMKBc/fdM4UWdIzW38Y4/W2Wh72Fn6cqy2oAj?=
 =?us-ascii?Q?NHlvGsaMmCD89GLNC8nSKPINe/oKccntVGIFm924WyJUpBPFCpfZdubSxAcn?=
 =?us-ascii?Q?Vq3sEJwusOUb0dxPJsQAxOJ+i9ZNwoD/mggHEZpQGEOvAMTBMQtCml0lSBOB?=
 =?us-ascii?Q?dLYK/uNoLpdIneZyM78VQnSDk0I2KKso8x/9k4iFM+W6OcV61BDHPi5smVRk?=
 =?us-ascii?Q?qyughy1mJpaYQLSUxQYLvgOeFFAokhCUoMXxgZON5T/I6wKnlwN2sZPyVGOz?=
 =?us-ascii?Q?2RkhTVXapFhf0my2TPyqDYW9gtbuQ65RUi3TDYNgZwgRv3BF2MouGF/b4xEz?=
 =?us-ascii?Q?a1yBR9jXSqQvsVXIPgwznndUqrFK/Yb7a4fxPTH8UtXukaJ8oZEvT70MPOFf?=
 =?us-ascii?Q?4keC26SHCzVkJOE/ueJr5Hmh4MLcirVJ3nGO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:54.0966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57496839-e747-4477-8268-08ddc0cbfec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
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

Add queue reset support for jpeg 5.0.0.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 31d213ccbe0a8..d6b565c29b4b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -120,9 +120,10 @@ static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	if (!amdgpu_sriov_vf(adev))
+		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
@@ -644,6 +645,25 @@ static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	int r;
+
+	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	r = jpeg_v5_0_0_stop(ring->adev);
+	if (r)
+		return r;
+	r = jpeg_v5_0_0_start(ring->adev);
+	if (r)
+		return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.name = "jpeg_v5_0_0",
 	.early_init = jpeg_v5_0_0_early_init,
@@ -689,6 +709,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v5_0_0_ring_reset,
 };
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

