Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028CBC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9514010EAA9;
	Mon,  6 Jul 2026 20:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mA5Z9RpS";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3484C10EAA9
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ8L/JAqtgfTq6QbjPS8i8ycJrQWz/Y2vDZuSShELrl12fnxuXFTvD7qJbkC55pnqwiOgl0ssrGE5a/tMwccfWcsnrTvBsnv0n7/TPj3p6veJtOYUhTv9E3PAmNj4XhLxvAviL6wnI28/xiyjMEi6MEN8wG8fqiV7MfhrwtL4VvZdECCxctCPyoiA5G90HHJHrqz0A37P7dYqL/sogTgQwXcGn5JSDyAO7SSgTzgiyvJaHbCCrM9p8onplgrIBl7hr6mWu2nZiM4Szgtmh+KnWTn9LoKIwpq8mWL9Dooq9acCgHmbSlU5P+pykp+Yg1P2hikHuq+q5C+9+JiwAT6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGMCXgLGKCJ4ZD0o8dMmnCVAGtDlaYXIsXE7wTbioRU=;
 b=PxHSOEA+VdIKB7NBD1DOfoe9IDyzWnTCWSuOo6d1RdXmnNNpl4EV4vVBpB6hHgHPITtmnm7xjKT4AmW76M7dqP44q1vSgdlJa3h5yo2eBuBsTGY17824AIDXy2/iE4sX+9T0oyPssCzxgBz5MthMsvpIqg/LUgCfXfFgZLmbmZW3acQHnV09rt/yyj+XjFliVx4ybjexeqTh+UUjMf7Dk/c4o5kW0uO7A4PZ1p3sl9bYtn8sxftbosIh2GFzeRf+8/8LQuW0LN7uIHXnTfmp1DWr211pH+Fr7003IXD9RRZSU7fQOYGDlYC45zkPz0rtDHSy3bPVDIbJaDn6ZAaHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGMCXgLGKCJ4ZD0o8dMmnCVAGtDlaYXIsXE7wTbioRU=;
 b=mA5Z9RpSTBqSqqtnLSA6tXG+7OfZCw1KOQnZGZf1VJzgQRgYIpUpCQquq2GKBKJ9ktJVJNQC1R3Dij115Os9y9YpVI1gfAKJNcvnhJFsmca32EyLGRNKQlr7NHWpEsvxQM00EuKh+MiVUTuQWlpVR/kQkCf+kQ4LQwLwoh8Lrfo=
Received: from BY3PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:39a::31)
 by SA5PPFB1A5CE29A.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8dc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 20:06:09 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::45) by BY3PR03CA0026.outlook.office365.com
 (2603:10b6:a03:39a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.12 via Frontend Transport; Mon, 6
 Jul 2026 20:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 20:06:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 15:06:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu/gfx: disallow gfxoff around compute reset
Date: Mon, 6 Jul 2026 16:05:55 -0400
Message-ID: <20260706200600.15071-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706200600.15071-1-alexander.deucher@amd.com>
References: <20260706200600.15071-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|SA5PPFB1A5CE29A:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ae1fab-792b-46fe-db53-08dedb9a055f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|18002099003|22082099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: uYISV0l+J5sQtr6dN0o00Ev1dujfhnfvbdJ3jUH64zBY4BiKfUuetMm5u/cOcUiS3JQOhSFXWO5cO6EY42dRv1pEmiQ1Fa5oj6119C5DcNcbRFiouJDDTekdxULVwAZTAZNWXvTWyzMFPiQrNe0VjrRRIknqt/CL+e/uKwHp+2dhYtKZeoZhd8GRa9iLdG79IaAmxfEBmRU+Yc9cH4/kPpfx83jiBbWKJPuLj9eRH6XQWcoYv8sZAw1bjMcDIE9Xwz7Yk/1F5OzAxrQICE/FXV5KOM1F/23130JLzn8do5IcAMEpI25qRlUekNO41DKKXGcGndMMx82m+yDp4pOleBelLNjBGSwmUDxFL4MGRJT2oUi3ezjnzMGrV6bjs/zfovI8kGYk1ERoDHu/IwcA+KKb7/g38PW2bnrqI+5djRUfjoRarxJ/hH6horGvW/OXHo3mLiAYGDmG0hC1ywKm1qgjflx6PW0BK1dQkBhLgH/ICP16E2hvcYCE/QDgsx9Xt2IKW6hCjhHzs0x2ffL2KY0PCoPOpOyHI9o9uNJrYthBk2cbZdPN2yZebJRRCGSwCRmVF+1sl7YhwP/nhDT6s1jB0He6cY5nsfEff4kp6O+R60wt6KurWTPI5QAjG20v0/2pg+rQ3XLS1vwK4gWUCXTRzZF8y06/DSx8hMIF2JM9EuWa8ZIAKdJnhIHRYSOn9ZNaFnNzKoWQvgCU7IOZ7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oqATofG/YXZxFbl3L9UzyOGmc+9KdzB6UrAXLsJ9xcAcdDLZgmSuCzxeQJCEQvyi/IEdL1N0DlrQaRHHhfnymsNiDi2A4egoyGVY/pSHq5Ts3Ob154EtSdHO1yfbRmBOT3KMdsObxAegZBQ6IdRQ73W0V9U1h0FdJQlIKuUc4NlMPS+4knANAlfjidcAvtRKsgo/7oeRdfqcCARI1XhoK7ojH2RwmP5pKcYyf2Gu71ZPZTPb2eQCxEovE/zFSHkrrpUf/cUE+oVZl0KREH+Z0v62Hfw/z5h877fvcilyXupn7D5OdQkuALlQQBjfwa9mX8sOfjmxS8Zcc7tdFUuL1+SNGTZHX3gj8idOmoowZ/RBlX7RCNjfZq7F6zcS1OIz/DKieI2SVh6WLKXTqvNR2Na5qCjfH3Iw5iHve1vC/F1TDRVEs5o3E8dGwmhVMA1Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 20:06:09.3578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ae1fab-792b-46fe-db53-08dedb9a055f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB1A5CE29A
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

If gfx is hung, we shouldn't need this since gfx won't be
powered down, but we could potentially have a case where
a queue can be preempted, but due logic errors in the commands,
the fence never signals.  GFX could potentially go into
the off state.  Protect against that.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1e275c2e7dd3e..2552561f997a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2285,6 +2285,8 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	int ring_err;
 
 	guard(mutex)(&adev->gfx.mec.reset_mutex);
+	if (use_mmio)
+		amdgpu_gfx_off_ctrl(adev, false);
 	/* stop the drm schedulers for all compute queues */
 	amdgpu_gfx_reset_stop_compute_scheds(adev, ring);
 	/* suspend all will determine which queues are hung.
@@ -2388,6 +2390,9 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	if (!ring_err)
 		amdgpu_gfx_reset_start_compute_scheds(adev, ring);
 
+	if (use_mmio)
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	/* If this reset is triggered by non-KCQ, the KCQ result after resume must
 	 * not override the reset result; otherwise a false reset failure is returned
 	 * to the non-KCQ caller
-- 
2.54.0

