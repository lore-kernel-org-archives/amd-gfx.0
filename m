Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EADDC25B4F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E291810F9A0;
	Mon,  6 May 2024 18:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oTuI/Fct";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77775112306
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijeDK1UmTqeZLlz2TeG7LLdOQgG9V6/gE5QtdRsogUUvwTdr3eTAFMj6E+rSe4L7hoeTwdGSx8ePaeKmMek9ycHz1+v9cFefL5fLaK6Qn1S5avMw/MU83I+rdzV9HHlgkmx1GJ0x7DP0Gd23Xtapu5406GnFmNjdo/nDwMpBURmZFl+6vVx2KXKPhZ+tVNJyZ3379rODmk43J0V0q4+TYWbWEDRxxkvthiYmuM0l941/hUXc70MX/LcNOHbuucOsWFcOiFN9CNJLFMQOJDXO0jR23VFiQFiaNDubnS3EmcMWgWdULFdRBF0D8ikrmn3BH7sDRy8mJT1Y8+ItrgBigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHvRWb8oxKZvtzpk36/BOK7gSfJ6j32bxNSPQgLsSlw=;
 b=aJ57F/7x1BwRnqoDB4N+zQ7GNkeFOI9PX9KuXOavyU8XwS4IOQ/Y8l7DGwYeWgWvynxeAUtzC11YplvdymtD+M066CzYpVWthqlRxv3crzMKkY47SLUoOgcKvBz30dhR3+J1wSRQOyJOOqwS8YU/r5WCkwPiQPITs+MAJgPRnK2+jko86qHPgckG2IxEG2QRlhir821/8/Wb/ovphW74g3RX+7tL0j43pAK3Zi03HuEEGMaFSd/05+yCoy5vBJ/26i03fYCLJtc7bRH5lQfNMASbaxblt77qVH1WeTJ0TFpvh68eSgEhZfFOmhdgSiJYHaH68PWK2FXRfjOt8oWq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHvRWb8oxKZvtzpk36/BOK7gSfJ6j32bxNSPQgLsSlw=;
 b=oTuI/FctnKcDvRD9A+9sy3O+yYrDQSfU1GAkx4F05JiStRt0ggagZxc//AfaZ+7thewWugI8FrV5vU6VHD+Te3mai7MseDspitnLfIIr6MT7BMr4ck7mtYQA3fTemK4aQKJfZPUTLISHzpGb0mABoeSC4NTbU94YVvLYEOaBkO8=
Received: from PH0PR07CA0082.namprd07.prod.outlook.com (2603:10b6:510:f::27)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40; Mon, 6 May
 2024 18:45:57 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::f8) by PH0PR07CA0082.outlook.office365.com
 (2603:10b6:510:f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:45:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 03/14] drm/amdgpu: add set_reg_remap callback for NBIO 7.0
Date: Mon, 6 May 2024 14:45:28 -0400
Message-ID: <20240506184539.1669157-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506184539.1669157-1-alexander.deucher@amd.com>
References: <20240506184539.1669157-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fbc12b-b770-4417-ad58-08dc6dfcc441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IZDYD6WUhDAyF8pkrl3bWoMH8O4RW2t5w/OSKaMTJ5JSPrQ1lCOCuDWmm0Af?=
 =?us-ascii?Q?bffB9pdmcYf6Qtcznxp8ItxGq2PIQAuCs6QE3IE/HzLqu4sUQTwHemFMjaMJ?=
 =?us-ascii?Q?f3PgoRicK1m50RIVw/iOoHoNt6gvKzYFFEC7nhopHHt/4fPFYnDAMJOdyhba?=
 =?us-ascii?Q?b7sDZ6jsUS+REjIAYKUws4lp4b3PSnCAubbRqFZaPMskrEjQkPl/Kz1EZJRI?=
 =?us-ascii?Q?j/qZ7fv5miAO8z2wMAq+f8wp73od/I7XEAaFNALFfGlaApGVa6d+hWybyl+R?=
 =?us-ascii?Q?rZi/0gqMPweOaTFhVnmEvLDvpeg7pwS4jRNbR06N/7qIwTzq31GLt//VSYvw?=
 =?us-ascii?Q?q5ozoWwHNNsqQJ13EdNOKF6EdJr/b+aTIQoYWND3iTHy2EuwaKCPsEyafU17?=
 =?us-ascii?Q?3Tpthd5Rj5BWqIwa51V284kMf4VHzI+Ica84AKEjH1yPGXqzngBqX/CA333U?=
 =?us-ascii?Q?kurwyXSywy/gxUgXBs3CHOfr/NU4j6FBT5C5+2Z7pWZiIVJkWNL4Y1qBw+tK?=
 =?us-ascii?Q?Z997DULC4L+YzNdq035HHdAvmPHy2pzIDSMtghMn6Ti4EeyhOeChH9rX0efe?=
 =?us-ascii?Q?icq1qTulLgr6BlHpncvrwkFzRwZk9MF39yRG3/BwvTcc6wxrbJoCOVrBUlED?=
 =?us-ascii?Q?Pr7bzkN0UXZQmGY0R5AHJcUTeEZazCBwh8oiV1QW1A/bcg/V4VmhvR5V2+ig?=
 =?us-ascii?Q?VOdGHg6pYC+S/nNFdeXzk6XZyENQ3DQ46YJJ+hVQrGDmqAEZpyHIU3nijoa2?=
 =?us-ascii?Q?l5LaoxfX1uyVgtcrZQRdgBm+SD/mhQbxDPCAT3mNiHqLJU5wNbbp4rViAFLC?=
 =?us-ascii?Q?aFLIqbGX0aOraNneXwXO34Or4cRw80f0lmlYrEbrNAVgmHbe9ozGfVBZbNbI?=
 =?us-ascii?Q?HVRTd6IrQ4+UMB2Teu4DHV5zP5FtqbcsRAq4hKv2lIcOdd7SSLcmVX30hkfX?=
 =?us-ascii?Q?JXwaNBV05eWA1pMTq5Uc7lMewS03CeJqhuIwVQYppFSuBuNDRfkjI54eKCWV?=
 =?us-ascii?Q?amZ5ZTFK2H+mzlMReBtNkH5cUqmPSzawsu6Z7jTaBeYkS3v19Wb5oM9HPd+T?=
 =?us-ascii?Q?cCeO939k8MJvFaNo4oQ6MAOgw4vB0wjsAgIt8dE4cfvNIEaIB1FXipsnjJuq?=
 =?us-ascii?Q?hnpv4o0J9EPQlpW/Iek6TVbJUznP3cpKPpZhkfe3mR0WNGyhCjHyA1mIwbUq?=
 =?us-ascii?Q?Nmp10aXINnEcg63n1QCIbmNJM0zdEbxOs/yaekqgcycZ+Rch2j3n0JG16yn2?=
 =?us-ascii?Q?qcaEea37s9rEbfKb0Fd/R2iV4v0LAedDZ1GMy8lRP5+m/X6HzjM2sD4TH9Z/?=
 =?us-ascii?Q?5p3u5yAQEIVrR0Xl0F7EqMzN2mR9loha5MuHMjNW4cxOTgRZwWDDb98WpGNi?=
 =?us-ascii?Q?kkwBhkLt4DlfFAQ3fFf44ufmPkAs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:45:57.0655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fbc12b-b770-4417-ad58-08dc6dfcc441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433
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

This will be used to consolidate the register remap offset
configuration and fix  HDP flushes on systems non-4K pages.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index aa0326d00c724..3dd743ebbc02d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -278,6 +278,20 @@ static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
 			SOC15_REG_OFFSET(NBIO, 0, mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbio_v7_0_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(NBIO, 0, mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_0_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_0_get_hdp_flush_done_offset,
@@ -297,4 +311,5 @@ const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
 	.ih_control = nbio_v7_0_ih_control,
 	.init_registers = nbio_v7_0_init_registers,
 	.remap_hdp_registers = nbio_v7_0_remap_hdp_registers,
+	.set_reg_remap = nbio_v7_0_set_reg_remap,
 };
-- 
2.44.0

