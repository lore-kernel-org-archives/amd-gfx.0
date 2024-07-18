Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6657EC52D1D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AEB210E910;
	Thu, 18 Jul 2024 14:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UPrpXyyW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481E910E8E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSOfkNLSQynEWx1FJ7oby8gfbFBcmZ5EQ9KrFy7JlCX0dbp624uPVOu8CmanUf+z7DN/v5J0GkHBafqGFU07uM5L8wlDxzfifkaCD1Gt5iyhMglQ5P4WUAqqEj64/pVX5ZeoxaExhqigWHnV2bJ294t0dg9pnSLqvWqYvVVF0oaNNhzd0cujFwxoDRmGEQY4pIELeQhFv5kVDhy8+SO5FJDPB2rRgzZLF/ue/h69ML1X6ilSRxeBZdRm9oVZZ9o0/eLePtqYF0CUDLbu4VYT6gH4bo+UCH4fmuvS2L/5duXNRZ/DNUqsrzULbEHjVKrVeHoxgKYcF37fCzrsoCyVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/lmhU8Kkbl4BnTcYCcw0n2xqe8qt+hLV9BonipSjbA=;
 b=ZwrLwQ8QHbSmwHX3+uit9JXYmiDFRkgyrguaqWoKbknj1skJ0+s0kJcS7I0cWwulVqD9E90gY1BqU35E3MPzStBmSdPF0a2jss5Gkc4nbxHyUK4dVHyQgcd5n5DCakS0oo/AxfUoF9EgjGlUvdeS8uw0JLhqKrN/pMdp28j+rrSMEtO9npcPZWnvT+Vr7bo4EP3l58NTBvGOHLXKIWqfGNUV2JWg7D4hyY7Fp7B6vpGfTCnuSKha1Nasl460z0dEtKl6s7D/yO960+B+8IpnhnNbqCNaMxoieBCME3hBm0NM9xhhFH2r3pRdtkDfh0km60chdRNM9CV1NVLc8AxwMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/lmhU8Kkbl4BnTcYCcw0n2xqe8qt+hLV9BonipSjbA=;
 b=UPrpXyyWR3tkL8lZM94ov2LJ7CvSaIYZP+AGY/5nJBHWOgZvL7HDAhe/19oIUnyO4cC8lTLtsxHUW0UUMZ1T+I1bNLPWxhF1S1WGBq+U/zLELqVytBSsLsYT54d1o2f8kT2sEnuGBBOY4UK8LjMYhH0uhwhQzJCYYqJoAyB7c14=
Received: from BL1PR13CA0081.namprd13.prod.outlook.com (2603:10b6:208:2b8::26)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 14:08:06 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::e0) by BL1PR13CA0081.outlook.office365.com
 (2603:10b6:208:2b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/34] drm/amdgpu/gfx12: add ring reset callbacks
Date: Thu, 18 Jul 2024 10:07:23 -0400
Message-ID: <20240718140733.1731004-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 63748802-b761-441f-1077-08dca7330c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dJtKEJD6uLpkVJztInbF9rR7BiVZ0ZrY1Pb+itPuN9rbFk9u19Xk6RM4m+gi?=
 =?us-ascii?Q?JYAFN4LFMAnBqdyOvfORudOf7Kl145Ox23DAbmCoM25KjI6nl4GcQRgVtjMD?=
 =?us-ascii?Q?0BLtYfNIxv+JO/mT2nRldiyPJuwrv+u4n0DRaoUeYdZKgefkZvLmukrOKzPx?=
 =?us-ascii?Q?w34VLW+/Aih1DFgPLMXGU1ls06sdyP6TvZ2k/zOjhttcG0vNQc0h8NhP73he?=
 =?us-ascii?Q?OxpmcjgiR0yTvQL7+WhSJG0/xo2lFWi9W+G5bgqCLG3b2j/kqRBuKMqpTsxl?=
 =?us-ascii?Q?P0KM0JRTNFaoQ5Mk8q22mXHVVr4yqexFEIhhD4RLasgIO6zQCVoChk0YK5Xy?=
 =?us-ascii?Q?nqE2USBRBdZ/oju3/BYQ54jsDb27vMOZoBG+Z1JRpkwPyCmOKsZiwF/8g+/e?=
 =?us-ascii?Q?ICrQLr7+2NvJ0+SUz9t654awe/fUFGclaaEBXyX+G9RydhZ/b23gn09T9L99?=
 =?us-ascii?Q?iNmiqwsTF43BzI4oy3r5PKCQa47ngLflmkFktVLb5LWfxqRLgCROiZAKCkPT?=
 =?us-ascii?Q?IYTRyuqbd8SLgNBNz6/rgopHeeu5WxWBvY/rGdGobPTFs1XyDORGYuiWNXOi?=
 =?us-ascii?Q?fPGW+c44cKowNHSvjV2OfcwqofQrjRHUNKu8JGnqvsODC/yznMS3MNcaoINN?=
 =?us-ascii?Q?1Dt/oZSDFWly6Qslfd8AbWSMbm18qLtmuXtthGSj9SgY5a1z0xKLOhjcy/Hp?=
 =?us-ascii?Q?oFBFBp5B5aXPJVn3T7DmbZZSHvD9b6BVryvMpIhi1LREwTBpjGPBefVeK784?=
 =?us-ascii?Q?jxgueKjiqBWH06N4wyzOXLFNxZIqogfzYVd3JWawf1UeGjtIMNH7RC23Yij4?=
 =?us-ascii?Q?AZNqnS7afSSKSZsRARfs3NY+UKMS368ucPv/sOJQTTts/aQ3Lk36QInXBhR/?=
 =?us-ascii?Q?cw6xV/CWq1UrxiEleFvzZTbato+EsQW7qVKA4mkuhAG51dGc+9VoL//13cwL?=
 =?us-ascii?Q?n5cvdG6afH1YORe3hxDYDihX+TDzD8G3//PLmstZYhMVANMISFG74TU15c+J?=
 =?us-ascii?Q?m21P9Uua8dpxkk1h61+9Oar5RpfuiGopZk0qmTeeB4ff0YsIpAeseJUJSKwe?=
 =?us-ascii?Q?IheSgMBr7gF2rU78Xh5mr5R/bA1ZlPsRAE6Bnvrh2CxAEU1FqTAhqjRIpo6J?=
 =?us-ascii?Q?vJLPkhpzefDEHQjUdkaesAJDqAiTPch9rezFQxEK+VweY4sIvQKAazF+7RbZ?=
 =?us-ascii?Q?KfWsuLuqICALOhHDfo8XyqDj2t782H2Ry9pKXKffE1pujPEBgqwJuFxBzqWg?=
 =?us-ascii?Q?q0DyfkO6lHDDlrjXh6zPjva7geoEIBz+JUvZ95NNsxGbgoZ6cWKakcg0dw6O?=
 =?us-ascii?Q?F5BsiTxmtrKNnnZUDuYKoMREI9jCswhZzvy/0fCvbpZinVTimfZLdcZpuEf5?=
 =?us-ascii?Q?mHuZsGqOaDO6JPB84F4NdWuR/nnBui+RqBahP1gfeB1Hsybk+668mSUT1uiw?=
 =?us-ascii?Q?Ep5p/wuFhKQwD20XwwVuAl799iWMLPPJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:06.7191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63748802-b761-441f-1077-08dca7330c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

Add ring reset callbacks for gfx and compute.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 63b073fd4dc7..9ed6c8ba6b33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5135,6 +5135,22 @@ static void gfx_v12_ip_dump(void *handle)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static int gfx_v12_0_reset_ring(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	int r;
+
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid);
+	if (r)
+		return r;
+
+	/* reset the ring */
+	ring->wptr = 0;
+	*ring->wptr_cpu_addr = 0;
+	amdgpu_ring_clear_ring(ring);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 static const struct amd_ip_funcs gfx_v12_0_ip_funcs = {
 	.name = "gfx_v12_0",
 	.early_init = gfx_v12_0_early_init,
@@ -5197,6 +5213,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
+	.reset = gfx_v12_0_reset_ring,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
@@ -5231,6 +5248,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
+	.reset = gfx_v12_0_reset_ring,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
-- 
2.45.2

