Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57DACA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 01:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4613C10E2B2;
	Tue, 26 Aug 2025 01:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hFVUsiZh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE40E10E2B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 01:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3gFkg3ghyDamQ6B3d48SkyC0Amzul6mK8ST4XQwCg/lFqrvQcY7Z9z9b3WjKxV43pQCw62hZdO/Kctta4S4UROo/r18An/z+T1Y5km7/M2wuSFNVR5v7RLUqRXTEUjK2t842h+AfJoHIYbvgoTQ0KrsxGJdw7g+i7VTiEOzalSAG7hBN/TIlLZG7uCcr1LLaDtDu97Nd0BKIOuI+XS0h8TVr0Xqz4Wu9tIXqv4+cu6V64zGfJqXjvVDFMLEAF+XzXTdeT5JausaAk99ReJdNesU0rrBlHMdQjEKtcgb1ddPVW2rTIY9f0gznGFoAeq2KdBXryz1Mj0jilFIjaTVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbQMHr0CGdXCDyUtpyJD9uCzZPpJ2ZW0V9dvQzkftb0=;
 b=RzABPVpHBdONfxG7ox1QosP38/Wenoz7Lh5c6Akbns4ZX0B62Dj5AHHwWp8nvBKALR4+kWwWXHUX9NX8/TvbJpSERxqhRskPrSSK1cVBfPY23pTT3sE4NYEr3sMKx/+uqexfnrAFjlDOG0UB820KHDnIOJz+dx3NE7QFVO240iUa3HmEDNzQEjJ66KfPVag2/Lakz14hOjkdC/vuAbJjjEhGig7qeR8/HzEsaoIUagDujzAyfuTtqf/cSWCAiQs5cbuzkAWFl8vuMfoPsDo2COfU8oWY9rYFITAka1ph6P7HLta0TGMYVoQyxBTlbeT7DiSdtKSOg7Kd79GqWhhlIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbQMHr0CGdXCDyUtpyJD9uCzZPpJ2ZW0V9dvQzkftb0=;
 b=hFVUsiZh91XHkvrweexlsjaB2NwGg/mZXq4m/TnZgiLWlYYqgU6c7Tt3IhxrDoUXv5fxFDatN/YOCPLktIfDsYtuITMre6yp5iiLv1/6k9tb8xF5HXj3/EgnA70MTrj6wRv5eyqm6mbnnxbJTwuHqxLQST4Y5LoUcTibF5H3Hbk=
Received: from CH0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:610:32::18)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 01:47:08 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::f8) by CH0PR07CA0013.outlook.office365.com
 (2603:10b6:610:32::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 01:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 01:47:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 25 Aug
 2025 18:47:07 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 25 Aug 2025 20:47:00 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 02/11] drm/amdgpu: adjust MES API used for suspend and resume
Date: Tue, 26 Aug 2025 09:42:12 +0800
Message-ID: <20250826014648.1711926-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
References: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 62959d1a-0edc-4bb0-0399-08dde4427774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SjUTbJgqEtm3mkb0KF+ZGW9daCFmEeiOXLf7BU+bLKmI7v8uywzmKj6qRLkl?=
 =?us-ascii?Q?WSO7sUkQS7W4qmG62xzIQBiNMFVeIZbEG3nT17kvnr2SIanqz9LFvlieLH21?=
 =?us-ascii?Q?hp4UDpfpnYTJr9VNtu3r2KdwyvClsYvaP3j0THItOj4YNsspOVwpRH5HIVFY?=
 =?us-ascii?Q?FH5EdbsgYDy/K4G3WHfJSwsmXyIQVjkHMY6LEvTkpD0ZTUBbn3/O9SSejjEt?=
 =?us-ascii?Q?S5GuoP/LaVa0yV1RPbZ0P76e4C59gr0TXbfxapq7pGyTXKViaCdbbrnoYuY8?=
 =?us-ascii?Q?++3PV1Zm2trKM2GrpwZFU5KBu6XsXk+vJ8Q2aCylJaRGjQnTk+9brPtH6uKr?=
 =?us-ascii?Q?GBZ2Io+ukm2u0HALnehcMuU8YagGLFhoyQZaWLYmpWx0bXmbeOUFgV90szHb?=
 =?us-ascii?Q?hBQkgsbJv6D+mt6UeZloSNgQI2mOvYNnuN39SlZSeagjHv25RUP9QA+PWATp?=
 =?us-ascii?Q?s6kvtsNDeX8k2bit9bZfK4/i44/kaxiLNh6cAqAlG1xYXiAD/tYFTriDdA/g?=
 =?us-ascii?Q?ZylgYxLbRN/4hmr9gF3wpHuRzELKF5JcuGMZHzwk2p2o9r8u8lksAIxgoQQd?=
 =?us-ascii?Q?833yq5YLMUGMtHGLpn3WvnfhNtnU7nadAihS9MF1JaV7pj561qIdhaeA5RiV?=
 =?us-ascii?Q?8SYUv2GGpCgNOeA02MnwBhP9Q+SPb4PoI/vO/X+qOznNm+3J7wRIvVMV0Gra?=
 =?us-ascii?Q?u+hf6QrGP3+5aUpvW7z8KLacQujtNUHNlEAKeIYnQfSj46s5GJA5UICxdgeQ?=
 =?us-ascii?Q?wW4fIETvwpKBZNm27TF9lFAaAPjoaei6nY1TebUKwEN/VmTj51FrH+2QKYvA?=
 =?us-ascii?Q?EJoDP789LdglJ5+o4A2SmQpg219pWNht63+KMzqBeubRo5x7ls8G4HgQGmcE?=
 =?us-ascii?Q?ZFH97J7IrE5/riXkX7PFsq5lpJ/oRytIDhv2xPNeK22CeoPTpreMIK3cdYFo?=
 =?us-ascii?Q?lyypOsB9jj8MLomxcNWCmlCR7WLKGtOAKoGt99TtUY8yR2sNEh94vgcR3CcF?=
 =?us-ascii?Q?xthlMe5AMyREeumfBhYVx+Lvn+dptmoIcJMtaKCQ/Wa39ncTVrFNKyVICNBM?=
 =?us-ascii?Q?RYmrBIdfcf3/rhixbzw6s7Uv3Pwl4uNCBjn6Jx9vsG1TqNa2FPDQpJtsAK4H?=
 =?us-ascii?Q?mf7T/O0HlSAcEtep64wIb16XOrWqj56S1bDnhI9+qlBGwcIVvJgpZYJ0STc8?=
 =?us-ascii?Q?CHtYF0cdACXd4TCkPxx+flDVmf4Lt7V5BWmwzHEJ8eNONFREOnuraLOuAirt?=
 =?us-ascii?Q?NTccPcPi51fSesUFReyACp4oF0mL/5SzXUtwJyWEBcGIvqK8JjJHlJdMhu9W?=
 =?us-ascii?Q?Wza60VhGyYIqLedDVUYcc0RHi8UkI6qxIbdB4Felx1PYnMBOsJ+z4fX7eGYD?=
 =?us-ascii?Q?jWn4sdTFGK+44XmloiW0l/yP2WtWdBOpq+onQA3AxQ+X6skmDTLX5LNbegxH?=
 =?us-ascii?Q?MQWm4NogGzKcV643ZH5jfCNtx3z65b1bzktdoMUxjRDNCO1nEAF5+31Rwn8A?=
 =?us-ascii?Q?SPE5V+qwII1eRc6N6T4m71AVG7IylTdAbEmO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:47:07.8973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62959d1a-0edc-4bb0-0399-08dde4427774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
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

Use the suspend and resume API rather than remove queue
and add queue API.  The former just preempts the queue
while the latter remove it from the scheduler completely.
There is no need to do that, we only need preemption
in this case.

V2: replace queue_active with queue state
v3: set the suspend_fence_addr
v4: allocate another per queue buffer for the suspend fence, and  set the sequence number.
    also wait for the suspend fence. (Alex)
v5: use a wb slot (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..502fa0a40107 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -347,9 +347,80 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
+                            struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_suspend_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	u64 fence_gpu_addr;
+	u32 fence_offset;
+	u64 *fence_ptr;
+	int i, r;
+
+	if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
+		return 0;
+	r = amdgpu_device_wb_get(adev, &fence_offset);
+	if (r)
+		return r;
+
+	fence_gpu_addr = adev->wb.gpu_addr + (fence_offset * 4);
+	fence_ptr = (u64 *)&adev->wb.wb[fence_offset];
+	*fence_ptr = 0;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.suspend_fence_addr = fence_gpu_addr;
+	queue_input.suspend_fence_value = 1;
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		DRM_ERROR("Failed to suspend gang: %d\n", r);
+		goto out;
+	}
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (*fence_ptr == 1)
+			goto out;
+		udelay(1);
+	}
+	r = -ETIMEDOUT;
+
+out:
+	amdgpu_device_wb_free(adev, fence_offset);
+	return r;
+}
+
+static int mes_userq_restore(struct amdgpu_userq_mgr *uq_mgr,
+                           struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_resume_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		return -EINVAL;
+	if (queue->state != AMDGPU_USERQ_STATE_PREEMPTED)
+		return 0;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to resume queue, err (%d)\n", r);
+	return r;
+ }
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
+	.preempt = mes_userq_preempt,
+	.restore = mes_userq_restore,
 };
-- 
2.49.0

