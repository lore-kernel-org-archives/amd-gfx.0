Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240C6C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA7E10EA83;
	Mon, 31 Aug 2026 18:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ieH13SXo";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3D610EA57
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lErifmsX9Gp3HT9EfRUQti+/H5sCM3/q7COLgBMhsNDYjj5tAeF3c035qxS6Ny0iF4KzQHCKnziMAQk/jTJ1ey8MV4lZk8iyP4p+8oTSncWfZ5flvHfxXDcxMcW0VeRj67O5HnWcNyUYbFaYora6AlDSJl91FWNF92WlYcFIrfKxtvuWuL0aJM7vJm4v0VeTvVbuq+BPQsraZDWCgVdDJgGHWqrfoon7iZrc2yxNEDf+Ppm3KrkO28N7HF8qhRnDWCpyRNqF8+fvX/4gGzwGerhc0bHswop837cXi5d5A4KJbJxCf3iq1WWgvyZXF3PaVcWTD+pNAzSBhL8KFEsgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPwo88Qr0ehptQ1cME0FsezV06wBsWKh9ORnnZjSb8w=;
 b=r9LUxEQH81Pj8Jdg3hc7djkWVVQH1C6FEG6Iiish5CuJQ/8ieROofx+sH8se4x5WmjpLNPE6enMFcgsxUq+FE7qyRkkNLER4l5jOS3lbJQ2zYWShSZ6K94vwOrNsAO6x5EVw6Ge8/3PXBPaImZelBIzgdZieNkT+QiKECapz+WOEtkVk97/SYpYwnTamsZSe9jsMJ4XA+bJyXLFi4KSDAGerIX04OQgRPvW8Wdl47WY8tIloBM/ZoZT5RbRB9TARX4NjCxja8IbBqDFtx0T99bjcF1mqLFoGh3HqTxfYA0qqSxzhpFSl+wge5Jufoj3GXvHhe7nsu4Pa8jMt9t1Ixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPwo88Qr0ehptQ1cME0FsezV06wBsWKh9ORnnZjSb8w=;
 b=ieH13SXozL9ZaLpFe3y1ZM4xOiAGErxA1IajYrntkgwvQehZgwcZTRKPxUclrpuRWCIjLyLjfcNh7pkiN/hqYmFsGaRYKab6PRSQ5T4LBAmTSjpQ3G+FoTkCwx9c6ScSicqwtQMNbKM4XnsVbNIly6/ttaLypzaqEfDXmZw0O6I=
Received: from BN9PR03CA0147.namprd03.prod.outlook.com (2603:10b6:408:fe::32)
 by DSWPR12MB999153.namprd12.prod.outlook.com (2603:10b6:8:36e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:41 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::45) by BN9PR03CA0147.outlook.office365.com
 (2603:10b6:408:fe::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/95] drm/amdgpu: Enable UALink Manager when pod becomes
 active
Date: Mon, 31 Aug 2026 14:26:48 -0400
Message-ID: <20260831182754.1089811-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DSWPR12MB999153:EE_
X-MS-Office365-Filtering-Correlation-Id: 189e7773-f204-42b5-ff45-08df078daeaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: fl3zBejhroP/ucN3yCqNaDnVCXhTpXg9fcEV9u5sSupcmzihGYZjwvxjwdsAnLssHHGjs38fC3lOKVGoTKo5OfW3snoeuukH4mDYdEBqSSbzzNc07cH4yTaQnm+krDI0Ig8yHwnymuE1qUPTXwpVkYyMaEkezzh7HwSt5PA+esZ7ibOsfOZsoLC+TcYOjyorpbIgqknQF127OxmCodvkFBfVpr3RawYBnE+OXMFZ5PBRKADy9MtCAwwEWCm0V8C4BQf/0MklFHizJCJ+0Vd2AI4b7bno6UXcq9JcAT6J9gO3ZeIWPeQZwS3M/snTI3AUTx8etzB6BviuUE4Ohenji40a2bs3GjGsnZAGirqrB7KytcPiiwgy2PlLw8qOqX0DarDZyB0cdqe1ucS9OtY4dwtR+HDqz35ceszht6iQamMGKsNykXtF5WvX0/R3ye+rsrIQ+3Wto159MRKUBT9UFi31kem+3tVxO+TKMQQ0pSVpFgQDl2RfKrDaYp2eBSs+mlsHEXpwyMq9eniGk0dBtodvMe7/C3PRTDf2U1WAWSHJVzKgsBS6QTcXYS8HWkEXZ4hWdWVR6rbFQXpHfA7Jxy9Oy+dE9BqVyoYqc6OhBulNNAe64g/oPaKws6pdwZTBlzyVfT4FtzL/1za2W8nLuSY0pAE5ygOYsRPXTM0qw9vWNkgDmU9qhmn9ogtIh+RSqdxyO6WGHZnSO7CDeQ0xcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l1ZV3MsAzz0ZJJ/tCderzoR4qbJOgGPwZB3u8ul2wtdxXdZBdl8bdsi/Pd7+qZYyhs449PkUKjX+pIyL/9LtLULg4PwgcwouKirkhRcSDejvbfXszk2NYCX5nEt8RrxDF+284fs1ivWbB7pzoM5FiXZwPeIUB9O8TH1VBZ0CoGbcFZK4Ahj0ZQ8+LDrHweA7FJHBHz7evzI6z3trn/lAQM1dX3rJg6zUJGjOdcNMv2PC4jaQoJ1kOrTqQn3L2UFDnqWNwbEZ1cJFKWitO89DV2BCXzPEv+wyYpx0DSxnA0yumeBhxbjo0xEg2kScV01/+ufr26rz/ERY2qZ3FQLcwk1hZomodwAoS/7RjPjGvBP6WNYaU/WHmjhCcVvzRyjANP5s1cm9E5yPIXfREaaGVvSvXkRmhKy37yhuR76PWAJZ9cCOxm9dZVCsYLVpufL4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:41.2032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 189e7773-f204-42b5-ff45-08df078daeaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999153
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

From: Mukul Joshi <mukul.joshi@amd.com>

Enable the UALink manager when the pod state transitions to active.
This would enable exchanging of memory across GPUs in a rack-scale
setup.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 89ba7cef02e81..6329fc8e217e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -680,8 +680,18 @@ static void activate_accelerator(struct amdgpu_device *adev)
 	/* Enable incoming NPA address translation with NPA VMID */
 	r = psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
 				   adev->vm_manager.npa_vmid, true);
-	if (!r)
-		adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
+	if (r) {
+		dev_err(adev->dev, "Failed to set NPA config\n");
+		return;
+	}
+
+	r = amdgpu_ualink_manager_start(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to start UALink manager\n");
+		return;
+	}
+
+	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
 }
 
 static void deactivate_accelerator(struct amdgpu_device *adev)
@@ -694,6 +704,8 @@ static void deactivate_accelerator(struct amdgpu_device *adev)
 			       adev->vm_manager.npa_vmid, false);
 	/* ignore return value */
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
+
+	amdgpu_ualink_manager_stop(adev);
 }
 
 static void activate_local_vpod(struct amdgpu_device *adev)
-- 
2.55.0

