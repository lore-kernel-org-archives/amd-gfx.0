Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF1CC3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1CE10E85F;
	Thu, 25 Jul 2024 15:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h2X/qe/B";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F07D10E846
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0ydBIp3rBbPEA7SyPdEVz5DIlO05o9hs/XLjincgk8DGdOc7zPqcRQV72afjj9oYnW6rlUO75rWMj3rMMaAU6+kKXuv1lgViWUXEm/t9HZAI7fi68XJ/DVTvCPLq9UFK/D02IWPMr/95YDsU+1vN49aYU2GWyDLsK58SP2CHQs4Pggh7tt/vJF+vgbDI7101NPPQd4qZXdljTzU7DjLPXRR9Y7rkdN45gSt+oJo7LDURi2DmBdHzIZI7qVFPl9dnYhIPZFd1QQy7DihnXqUHPbZfwzAjOVSvkqhtwGa5WyM7fad2FLSAuYk/RrsbqoPtc+a0Kxx/iRdWemPHg+o4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYqfspV6sVHhcjsMRJZALK65JWBHdf+LleLzmygAN38=;
 b=idpSEujCroWk4TcMVuM6Vel14FsvLqQA44YomI/vuJBxpHuFQ7CVRpQD2ePMtjUY0RQsJmsYSimrgXbtvVaz1utB2ZXcbEbTDaYKs0dhWZSP9R77Qb0yhJhdWAqMwFJJrPh/ropewtY4f9cF+4zEs9q3aV7AwLGkj+zZsNOAqpl1nWnfABA0TZmOrQabi/dG/3Ei/gMfMgclGpIh8z16a9tc3gkwbLjTqxY6U7PYZVj71nM5IC+LYXFtMoQowD4qQ7I1VzXhf7QqXfDrBDnOP1+BtpkZV6NXg48w4e8zjvBKO3PFs0dAOubWyeQXhDCpDqNdnDD+egXts/KsMT5VYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYqfspV6sVHhcjsMRJZALK65JWBHdf+LleLzmygAN38=;
 b=h2X/qe/Bt9MSP22EGGAlR3rv8oQmw2M25T2XufbSxLtqScBZuxiYgFI6WjARmAbufIv09kIphqRWMzoJozmMhkMG8IWM231XX5bwerSKtjDZyiGnDsC2Iah9XlKedCGBGJ146+g1fE9gBKvaEPaeJXw20EFuw+KAO7J0rYL8Cm4=
Received: from PH7P220CA0095.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::24)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 25 Jul
 2024 15:01:20 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::d4) by PH7P220CA0095.outlook.office365.com
 (2603:10b6:510:32d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/53] drm/amdgpu/gfx11: add ring reset callbacks
Date: Thu, 25 Jul 2024 11:00:14 -0400
Message-ID: <20240725150055.1991893-13-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c35749-bd2a-4673-1a96-08dcacbaa430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kzxK+thy+LIpfMue5WAtuXzTNoPV7WBiAFVEJZoBubE+++7Vff2a1dZ2oLm4?=
 =?us-ascii?Q?bES6VybS0r/PYaHxJC4QysAP50LK0VSiJpK8fHuQlgIgvJgCP18FXESI1aCa?=
 =?us-ascii?Q?AZOzI/bQ7XLtD9ttKFFHyv7vZFK9/1/DuZfiOeqFjXlbjhQUqPBcdw6q8ieA?=
 =?us-ascii?Q?fcC+ynjX+zVKlsOphez8LhWXIaxKrclIS7XvjT7yreA1zcl9aKEqzFRjvMLi?=
 =?us-ascii?Q?tYXoUeB70wOhVlqY/jOP7c4FUzHr5YiFMhAw516iTy6KqAdXCfMPUvRAXI0f?=
 =?us-ascii?Q?JchvcfpzqBulzkXw+bH8pePpZGpZvGanG2mQBc2ZYFcm5CgKT/okARu1j4PI?=
 =?us-ascii?Q?Hon6wkew/Kz3x6v14GIdJ44Cgl4e8jLQ3VHjMosC5F4b6+ZS3LB2L3dwXnG/?=
 =?us-ascii?Q?dpT/hv2szCEeOXyl6UH7hG8/QICtG5QOgfi/nhbyOxVnqXo+UT9uQo69Gu9j?=
 =?us-ascii?Q?NlU05m1zXL8biPTw0grnpC3P8AfkB1UAzplCFhfCkqKRqIgVcFDu3o6muZEQ?=
 =?us-ascii?Q?NtlID1BgCq3A/vu99Ge9bhlgpTI34pKPMpo+pwUNOBqlhF/4Bfa8NLczFV9j?=
 =?us-ascii?Q?8Y9W7jEcteSrAwc7dw6MmXn850KDgpSy/rDn3ZpaptcPELwxaoAt2gocOBlk?=
 =?us-ascii?Q?LSX57ixtHZWxjHduWBqe6mopWwITZjDkLU0Af9NcUjRP3eX64VSJJr0KgHk/?=
 =?us-ascii?Q?+ad2usKvrXT763IKUYnJkWcfuu5IXYPQASH+c/klO0z/rB8WAHTf6YsbSRio?=
 =?us-ascii?Q?X7QYE2o0k6SXcZ/JYEltXlYtuzRZ46AdKBX7NoB0G8E5P/2pA1AcM1hsWnTh?=
 =?us-ascii?Q?d2F2lFrf1xAOxn5QtBIX3hwrUY9Ao/WfJECFgsFan7qu1O2j5HCnNblBX8tL?=
 =?us-ascii?Q?fiYPCIRnfoVyX7DdzCqjFDptwqPryXi0OmjdwN9XtWdMRLcfIcxOv/XobVx/?=
 =?us-ascii?Q?Rbn38S9tFTbkEzffrjcF0Tx22d8Xay/p2QksmwLVQMRp/KCwzo9mlw/I3vcX?=
 =?us-ascii?Q?77s8gUngAGp43Pt7F3GApFdM4jeW5lKFEQ6HAFLC3SD8O1YWu9mdwwIEIcoz?=
 =?us-ascii?Q?Ajilv5TZqcvXabG5BZsd9WqBj9IzGrkN5NnMJBzMLhae92MUByQ5tYXq69Hf?=
 =?us-ascii?Q?GRpJWFpNaYWQo7bmStcqP0DC4LmC4m4yXWVlMeGr22o0CcGsWWSkva4gxwcl?=
 =?us-ascii?Q?obS06rY7LT504AVa2L1YI3XWtzeJHuaVOje1M0yym0YiFAUn/rdz83ECWyfh?=
 =?us-ascii?Q?FhHWlPHiOml4sGaK31v0SUcoDFOM4ayCK3N4aU2zkjRuJrAPNsoYaXBF8q0T?=
 =?us-ascii?Q?1gt7LxkrOZY5H4dRgMLqpsPqBbJw1NcJyzMDebGVoDafUwkhmdv4aYcqeFqf?=
 =?us-ascii?Q?sBFZf0JkTtNZTKpi6DjFabr8stRXg4UKvPKW/cUoZoUveQXOuCex+JUAOmLG?=
 =?us-ascii?Q?HEipHKl/LdhKUvIAde2c+xJMdTWycP1Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:19.6247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c35749-bd2a-4673-1a96-08dcacbaa430
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4a9766635933..6436f7d680da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6520,6 +6520,22 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+static int gfx_v11_0_reset_ring(struct amdgpu_ring *ring, unsigned int vmid)
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
 static void gfx_v11_ip_print(void *handle, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -6721,6 +6737,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
+	.reset = gfx_v11_0_reset_ring,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
@@ -6758,6 +6775,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
+	.reset = gfx_v11_0_reset_ring,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
-- 
2.45.2

