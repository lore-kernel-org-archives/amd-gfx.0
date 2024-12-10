Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E17E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 07:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8D610E382;
	Tue, 10 Dec 2024 07:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FCnoaI70";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4091510E382
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 07:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGZHMuVJ42s6+BGct6GvHskP6iw4qeLzOZ0reEycgend01n0gTh5upramNdkN7ouPDdlRLFSppqT46QzC5+o00UUxz6a3BU+tgfPk2FTwQAfpm/hH6CsOE8qDRozbmW9YhwfhKEeksMM6VEL/qN0I6O+atCJycDtrSjcsm3EahNPOhyirYXJe2FE5PjyxM0mxYZ/lmaaxU9yk21zXzFvSxJpac9F5MRNRlkg8qxIN5+u4u+wZJSqh5yvnKGlhsVGVeMgwyr7AjorigZ7W9DCVWFYxUM7vUJ/maxxE7vRa/TKymGd6Z3iH7yTAnEcbLptq2FcAuhD0eerEImJKxiYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpXHp2UXV9w3he2gptxgeQsyfRg/sehMrvjucRzsAqE=;
 b=WbCq3OepEbH1gx+11mrxsZn2Jw9ye6WkPuNVujpJaahNFG2E6ldhxXJyVyMcT6kl6MmKKVouODP4NtYFZsjf6ZcGpTlHJmEjVAhjgMndohfy251fnIvQ/zjelLkV4FwC7taHFViefoPwdFLzCYaqmZ31qC7toeco7S4qkM6MlfbvROqeUhyBnsDzcsHsZVzxcUMh0gi1UcyqWFr4niaTZ8VQCjqgo0rzs2Ki8ioz0FYDdE3ugHBDuOkYOI+bHCGc/phzHLrMOTv7iB1LQV2AiwQRTYBxPvgoSrYNN6A+nVOqgxsq8II2vcCxQaGIRVUo3SLTX7TYQFGBfTQTr2WmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpXHp2UXV9w3he2gptxgeQsyfRg/sehMrvjucRzsAqE=;
 b=FCnoaI70bgTr3iUCBAhm6UO10gIEptyyndk1/8AWRjsF3QhutUrXplqQ1JwMV9BacxZC7W7rVdPcOV3k6ec8jN+iwgZZUrUQPkDnOZCyHl+VmTUhkQra+gGRqLZNBY2p9fWXWRFgi3aQEpCBdYp7IcEBpfH7iYGuUEoRl0HXmV0=
Received: from MN2PR17CA0008.namprd17.prod.outlook.com (2603:10b6:208:15e::21)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 10 Dec
 2024 07:53:47 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::b) by MN2PR17CA0008.outlook.office365.com
 (2603:10b6:208:15e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend Transport; Tue,
 10 Dec 2024 07:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 07:53:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 01:53:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 01:53:46 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 10 Dec 2024 01:53:44 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 3/7 v2] drm/amdgpu/mes12: Implement reset sdmav7 queue
 function by mmio
Date: Tue, 10 Dec 2024 15:53:43 +0800
Message-ID: <20241210075343.2183239-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1baed2-56d6-4707-78ce-08dd18efc6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k/MkwHU4cTrJA4HKcdVsIheX677nfsbDYZ2yf+ZEA5Czux68pWxIBuQx9QZT?=
 =?us-ascii?Q?Bb5n0LbrIghmlCMWKvtvIU+Hk59zFlITZb4BG26PVMUFqu6qK6yRs8p42w45?=
 =?us-ascii?Q?ni6yrGFW9Dx+mb1kP7MCs6Ea78W8K7igghI//hbQ/cDXCUkyON07XIlfg1cv?=
 =?us-ascii?Q?MZnyw073OCMKu62PFtPUzdBl5+7dxjkA6JyPAguHKpM9bV/ZYSxSX6YSXoyR?=
 =?us-ascii?Q?yGGhY5Tv698xsLWolortUcvpDeWEkFkz+KnznD9N3h1YbmGq8IfCjfuE9JQC?=
 =?us-ascii?Q?T4lzHOnfA+smwSklWSE31JN2v7Uor0PpzG2oaFtqDI8dG4DFGKXa4n3guCu9?=
 =?us-ascii?Q?jnNNM1LYPaxdYRz6221cFYNLnl5tbpc+qA6TfHbgSHUnsImojH5SopizRM+i?=
 =?us-ascii?Q?/gWNwPxoZqU8/wysLts3TNbSKPHgG/EZnkV6v9nJUuBW0LYDVlPj6X4M7L3U?=
 =?us-ascii?Q?anvtXByvoDwDLAuYWR4RZIEwxKNMzf1iLRptBs+earxzoyqKaHzf3SdQvPLU?=
 =?us-ascii?Q?pFPyj6qaKQ4KJ/cugrldpvjMUJ0hmZ6y1DQ3gmjDMvP0uQYkfJp07GqLeAZS?=
 =?us-ascii?Q?zG+KPVYRzWaDr9h3gvxsvBPrY8lV0UQzvd37yyfsXw6WqDT6WNsrZVmd3Hj5?=
 =?us-ascii?Q?weZnyzAVBAlzqTWcy2fLAWKeD0DOXriribmEjClitnBpvPCqs0v1691W3Uwq?=
 =?us-ascii?Q?DqzPdPHCL3DN2i6Bt03xljGI53hhbjHra0m7io0pDVV7LJZumVvh+FdvCct8?=
 =?us-ascii?Q?gwN1CRxdqH5RJAOLCjqjDbS1ULg5Gx1E/3JIV7iLtwnepXtxr+9xJYxgYLDZ?=
 =?us-ascii?Q?bhMm3r/bT+XM2ePUa4eyTkUIYn5sQOgy63fx9oKkdHYdAipKsnDkhCwoh6Fx?=
 =?us-ascii?Q?Gg193UZoechGVP3c2dA2YExgNPol9HTBYqsFLcFbZUuM4ozEucvk7JaE/UWH?=
 =?us-ascii?Q?VTQAuN3l7UxC3H/m/753rhi48Y7QTnGuE7C/Rbgkx4Bur/r9i3TjA+tEQp1V?=
 =?us-ascii?Q?Fh1piQyIhxdWVotCDm3oehiDLdZCMwsGGLfi/FfoxrIjo4kaQh2+6uUvx7oZ?=
 =?us-ascii?Q?LGAE2Z5/q3WkekS3qoPKo6MUa0ygnKPk2z2QvzPicb+LY7N9RQnP0aY/DKCx?=
 =?us-ascii?Q?eMVh/cscdk2f/hN+ujBVu5JO4O0E3ru0/fVGDt/RqqWFMPHoJrrWH3iz+UnB?=
 =?us-ascii?Q?b91dINKOG8Kz8bZN7AuVes4Ri7jCjdTmZ4DC5QCQuxvLWgvX6G4+Srx7Vp7Z?=
 =?us-ascii?Q?hxPamZ539g5nrUpusr0WICx/er2yKaclzXrIVMfvVsJSh6eBelhW2Veerv2Y?=
 =?us-ascii?Q?NXSGidGjeU3sJraL8e/d7T9L1p3Q+ZBCkhyKGQeXmoznUkO2GLrh9Z57KFa9?=
 =?us-ascii?Q?dGAzOhUU8OxeJSkIEgqXZp54B7IuSaDG8nTPQgtyTEtw+i+uPGl7LtCKVW2x?=
 =?us-ascii?Q?69n2sMnp7XaiPFn8pVFU9P+f6CygzGA3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:53:46.8612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1baed2-56d6-4707-78ce-08dd18efc6e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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

Reset sdma queue through mmio based on me_id and queue_id.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index c63b3053eb7d..0f6635ee84a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -350,6 +350,47 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
+				      uint32_t me_id, uint32_t pipe_id,
+				      uint32_t queue_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t value, reg;
+	int i, r = 0;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_SDMA) {
+		dev_info(adev->dev, "reset sdma queue (%d:%d:%d)\n",
+			 me_id, pipe_id, queue_id);
+		switch (me_id) {
+		case 1:
+			reg = SOC15_REG_OFFSET(GC, 0, regSDMA1_QUEUE_RESET_REQ);
+			break;
+		case 0:
+		default:
+			reg = SOC15_REG_OFFSET(GC, 0, regSDMA0_QUEUE_RESET_REQ);
+			break;
+		}
+
+		value = 1 << queue_id;
+		WREG32(reg, value);
+		/* wait for queue reset done */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32(reg) & value))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "failed to wait on sdma queue reset done\n");
+			r = -ETIMEDOUT;
+		}
+	}
+
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
+
 static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 				    struct mes_reset_queue_input *input)
 {
@@ -730,6 +771,11 @@ static int mes_v12_0_reset_legacy_queue(struct amdgpu_mes *mes,
 	union MESAPI__RESET mes_reset_queue_pkt;
 	int pipe;
 
+	if (input->use_mmio)
+		return mes_v12_0_reset_queue_mmio(mes, input->queue_type,
+						  input->me_id, input->pipe_id,
+						  input->queue_id, input->vmid);
+
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
 
 	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
-- 
2.25.1

