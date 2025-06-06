Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9288DC5B549
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC2810E9BE;
	Fri,  6 Jun 2025 06:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VsPDmOIM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0097010E96B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLk/EqJLQSrGciC1pI+i45filKGWSU2qbdlXtvDeXN6m1bMljXYkW+Kxb/ZU6l7EGdNcKvenWGIyhDEo5fZRN6SdYB5la2hi0AYh6JY0qZ49LocSwg4T/C0GMNtGzeLKAfGYMFhYGlNVP4nopK32G8hBrHYQbRfBmrSgQOqFbwt0usBVdLoV8X/SD2vBN3KnEMs6s/IRBY2geHQbGGZuvfqMW8fJrdCHIFs0Uj6/zuLzWpIWmyKknbmUfClS7purwiqNpfOhMxv48QXhMQSiHutUVQXv5vNaAFYZKAgz8awywl6YEo+J7c4wOoEIPaBBoLxk7L7eStn7F73WTf2Siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPHSSNlVSZ4Nl+6mF3Iig6H6xfEXrguzGk0d1n4ebqE=;
 b=LGhKCgIw/AmNOEm23bYy7VPMGIRItHNfOVrnSuKHlS2eQzsUh1OceCY6W+IuaElGzwOM9giSFc+LkxLAWZ27c04+xI/xee/AXzqQoGyuzLdoPHRiayNK+6F4QWhPaZdIBFMoKb+jE0FuBAlhvi08fGcLWBikOjfgsjDi24FFGkm72Te4r/dVfvfhS9bn/x+FLBq+hC0gW2IiCpfHmTmHGEj0HpOWYDHUcLjJR1cfQxvKwSjz+aCku4SlpI0KHI/kY43gGbqN+8TRIl1JoWnYXJPiy6aUWXCo5b4owmsAzQan29Y91LSnhkb98UluvSg2L3X0Pv+yrfViewBnJzN/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPHSSNlVSZ4Nl+6mF3Iig6H6xfEXrguzGk0d1n4ebqE=;
 b=VsPDmOIM0dZVjaghj6CCFcz/FkaX4M7pV99FLJEH2R1aTnTtsuiHPPl6Juot8C4UEIoYQanE6wdb7woBsFqEM+WqEzwnX/Q4Kht62CpOlwpWeBUOj/l+TeeRrHyr0fGIOk2lJN8/YLVNcTybmS2VbPdeF8Ny203iDupjWbYGpnM=
Received: from SJ0PR05CA0079.namprd05.prod.outlook.com (2603:10b6:a03:332::24)
 by CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:26 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::b8) by SJ0PR05CA0079.outlook.office365.com
 (2603:10b6:a03:332::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.8 via Frontend Transport; Fri, 6
 Jun 2025 06:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/29] drm/amdgpu/jpeg5: add queue reset
Date: Fri, 6 Jun 2025 02:43:49 -0400
Message-ID: <20250606064354.5858-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: b8623091-b119-43a8-a39e-08dda4c59426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IQ6IlcPdjTjsMRXlucYVobI7cGd686w/IckhuqbcfDljy9Ay/7uAsKnxp16c?=
 =?us-ascii?Q?0RUbgPzryvjti3RuYjoe5mSWuuw0xpg0ob4NDW1/a3LoDaPf3EfwSQ6teu16?=
 =?us-ascii?Q?FVkpiO2/z++kkOIg73wAlkrs/bqqB6qx2fPZXKhbtdOLvjEs/zc49Td6jsQ+?=
 =?us-ascii?Q?dr+CJXdYeoN2F5rT9WgIwcYpm0lv2QkJurn/e/vWvo32e/tJG6j7Srm6Lq0a?=
 =?us-ascii?Q?WWRNA1q+i1WHQmuNDtrWNVO5bkKGIJORT4VlVnPP8pya+7Jw8m2ux2cFPo8f?=
 =?us-ascii?Q?ZsjyQNbvj4y184dhZDzWn2eat5QJLGnkyVKIUg3NHh8rAVHEQBgKvVhdEicL?=
 =?us-ascii?Q?WFxXjoHOy6RxMqbc+mwOJjHyYqxi9ZO6CTs835imyRtUhARUql3OpOKuvZd+?=
 =?us-ascii?Q?ppCZyHPxpKVs6cGFnjc803JnZGWu/mIge1MdWxm4JTKVwYsZZDQeqDKViC3H?=
 =?us-ascii?Q?F92ag6aaK1f6DLI3j+AYV/Y871Q19U0eEPfwCcKP8yHkcSrn4AsMwI0xiSoZ?=
 =?us-ascii?Q?TYiH1GMc2XmDupRNa8Ckz02wazq2Vfdl4NQglisFoVQybJgHxbsNjJhpqap6?=
 =?us-ascii?Q?4gUze1gIssoF1qYBCcaaOYCbahLEx4hkMLBhDIzerk9/y7uxYj0k0zQAlixY?=
 =?us-ascii?Q?h00yh2KizzQG7hExr7qVttEVdiTsvE5uIbyJaR4xCP4SmWWj2v5OjYlpT+Iw?=
 =?us-ascii?Q?sEaXlW73tCHGGUlgHwUU6k3wMj1254fJh+ImZUFuoLeIFIFQmrCL0/WB7nlF?=
 =?us-ascii?Q?Zb9Bp1IhQR27CnPFXjDIfl0/PYGPSOdKL6APXcxpEUriArPep0Um0fInssT0?=
 =?us-ascii?Q?fDuqY1RNOq3XOrkSisUi3bNFhiBYm9AnylzMAzCnbDPOt48+HYDYN1kot5Qi?=
 =?us-ascii?Q?YM99cargpZHsloS4Ye2bbI+uMNOOREiAlIaOd5VzRnr+FULU4sxmujDoyiGJ?=
 =?us-ascii?Q?lMoHwts+PZ2jTGzxkIRcDc5IcZBN2gVjQnkGKILU8tpVYTmlKeADgulwTlP+?=
 =?us-ascii?Q?n6LhOHsNl27Gapeq+9pEMlX0S51LhM206iUqyqtfSaWANeJT7IPQNHCabaSs?=
 =?us-ascii?Q?2ri/AaLr2kutFttlLVVuZ2/9jgeRzhGor+LVqnSWH2k0p6K2fXPQ8KU0ADXN?=
 =?us-ascii?Q?zlZ5d2EDmPRvZp/scpqb1KNVens64C+Sb5pUEpq1EmuuiZq8xb8CW2fPix44?=
 =?us-ascii?Q?Jf2WEfiCSreI3dTK/UbYG2EY/orTgsJjv4yvB85UtpMO4lThn6bgH2KY2p8u?=
 =?us-ascii?Q?JiPHcxw7op98Q6AeGUJPZJXlpgOOtLlWCi43iW+JrM4HRt7aSlqHKHgMaamE?=
 =?us-ascii?Q?uwScAfLIU5lSXG9p4OzK9nVW6YLy7cFeOOCqwQhUKpLtuQrVSeKDZmRrbOWK?=
 =?us-ascii?Q?zAWuzbyhkdbz0vO9w5h6rTBz5zNDCGEBuQWgFQnwxgQVV/gwrJwagyF0EBAG?=
 =?us-ascii?Q?UZu06l6JcPP2fYknDRTZZN55WkZ0vL6ZbKE2Mup9g2PjTdEMDibXCZUMl7nO?=
 =?us-ascii?Q?xKyo7dACY3lyYzHAuscgcA+gK4/R2pWfVO9/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:25.6283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8623091-b119-43a8-a39e-08dda4c59426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
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

Untested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 31d213ccbe0a8..975e2f58b8444 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -644,6 +644,33 @@ static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				  struct amdgpu_job *job)
+{
+	int r;
+
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EINVAL;
+
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+	jpeg_v5_0_0_stop(ring->adev);
+	jpeg_v5_0_0_start(ring->adev);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
+	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
+	return 0;
+}
+
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.name = "jpeg_v5_0_0",
 	.early_init = jpeg_v5_0_0_early_init,
@@ -689,6 +716,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v5_0_0_ring_reset,
 };
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

