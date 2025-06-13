Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC64C7115E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C83910EA70;
	Fri, 13 Jun 2025 21:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kL6MlUET";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9CD10EA68
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOX/3pcp+BgbFRQepY5+MsrQCQgcnRSFCdWZzpPvzxuLA+6BwNYlS8F8O8IKTLnoKIpNxnoRQtJM0/XiOe4MJ6wyqQZGKLqa4Z4N8atEZDjxAQTSWZTSujXtSOmEdG96k1UgRb6VRErdfm5TCWQNnbTw7EYhGtCG2Efzayw/KrCkoelsScS6/T7v4wVTFy7yiBf+Jqx1SxlV7QgGloEBuO+wKetGbIIldo6hs+YE3pepDKKilOJZxMmGf6G9XSqkZ0tzOjIsyK0ZsMQKpFo/m/SFSyZ3SG15sw0KpS9SyzZY7BtB9x7WvXHm3Qja9GdMalntL+NpBFM84zDl2d1Ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfzNffkXrYnPE/FdS6zSD0yCgfgB+qjbj1B/0BTUkt8=;
 b=FbPswwvVABi3vbVkbukmbTZixpUW6wkx0V5n2gqRb+9nN1QahVQDtD+jqikINV4X+//+nWTR0d4cmPzyTB+NTti0xkzjHhY9tMDrnwjvbYWixkHjHUHdQLQXG6Lt97tSp4y8yxyrmN7RjVOvOMmrstV8I6aO8siLXR7dTFie36pQh05KVxk4wWBbX5bivo8lh2GIg54Ql8y5X9RRyD8igYQdeKDLRsn1nigvzki6glkMTuQlY6Axj8f4Phh4relME45G7HLIrSahnlDj+EBEvuT7It/lV45HY3fyJGLwnCWHT36W+n4rHYpHifmISpx4EsMtVZTvAymozk3TI9BOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfzNffkXrYnPE/FdS6zSD0yCgfgB+qjbj1B/0BTUkt8=;
 b=kL6MlUET6khnkp5YRrgo7WFM7Yx19u14p3XDEGamW2o6kA21Kx1MmaRRR07a4OYYjKc+iaAz0leT3517dhRtoJ2ZpkRc25vfNcM0/qZRntAlR8PHrHXNV3vSEj7Vkn2W7cE3q9twk1Bw9U+7yXTkKXgxi4g0zKPtGbDLAbZ2Udo=
Received: from CH3P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::31)
 by DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 21:48:16 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::73) by CH3P221CA0030.outlook.office365.com
 (2603:10b6:610:1e7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Fri,
 13 Jun 2025 21:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/27] drm/amdgpu/jpeg5: add queue reset
Date: Fri, 13 Jun 2025 17:47:43 -0400
Message-ID: <20250613214748.5889-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS4PR12MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea27131-4bf9-475e-4f88-08ddaac400ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gkAlpW2n12oj8jPTbP89+gaLeZWmKewqfUd53uqSAv72K926fBm8vxrYzun6?=
 =?us-ascii?Q?2niASxj4MdOgtzgzrtwa5dK3lcQa26PPBgol1gb/CHxM9ylCHcKEzclMear1?=
 =?us-ascii?Q?cP3Wu2z6YXqsj4Uamkt/37ioRbQbEJ3GOxALSCSRq5bi/7e5lLkfDhwtSpqS?=
 =?us-ascii?Q?PnUA/nZhE2rIyg8dp8KTu/Snw4n1FcSzg7kmgVkOCXb+mqhw8bvxNVN0q23t?=
 =?us-ascii?Q?QWdm2eNsVRAioahPA8bla/7xKKCKLu6olP5PglHmHYeLwmhDLHDsviZvbvtK?=
 =?us-ascii?Q?V6i53AaGZBfiFOvA+7SNdlApQWGaeoxnQyMh4xOcj52N6IDKp+dg7dEkn48H?=
 =?us-ascii?Q?cvyJvcAbPUijDuku1IZD9bA3ZE2jgbPkgo6I8qy6wIoxgKC8QI+n9jOYi9Mt?=
 =?us-ascii?Q?rctTR+aFcJS9Es2Mj/r81pgBxlVIb4+6kNrc068s0hi96VmNSRRirGRNq0LF?=
 =?us-ascii?Q?qnXE/9290yS+b47CnLlAdpfy8TLUaVhl3FUFmvHJb+pCx3DGIxX9KSmVAJ0b?=
 =?us-ascii?Q?pn0JEVk5uXnyza4Xx2GeSRoRdk8VZyVuW4kJkhBoz/DnDQbLSGnISE4IosLy?=
 =?us-ascii?Q?lGyxoKLyqu1G4LJDCsnJIuAyn6iHq3b0t5hJckiVCwq91WpiGfDgkCaiBxUk?=
 =?us-ascii?Q?3GfZJtmRW9qvDX0UiG5JAdwBk9eR1jjJ56D69iwpjNgQ1WqgwZf855T58Qoy?=
 =?us-ascii?Q?RKgribqxm8yAItYkBRb7Vv2g5kOixm3ih6KE4qK2JB13kO1DKaKRh1grxY8I?=
 =?us-ascii?Q?2sjeBOm1994uGcFuJOK5F3dwl/3kKgrw6s4HjJupH1AggjLJKKX+hatr7cTI?=
 =?us-ascii?Q?W5C9Ge9mHrpRr2HrBWDeCIHnszMksL2KGB6dDDEzGTMK1hbbHzNxowkHUxT3?=
 =?us-ascii?Q?zyx2fdJe30Jzz0wuDq1xVwB3ETie2k09mQLhYe1ocFubJbhOzk5lm0kwzun5?=
 =?us-ascii?Q?oh+crgHyEgTkT+7Jdrf7nZiy54Gp0kVtjs355gaJslLp6YZJxYfYfGYC2BHW?=
 =?us-ascii?Q?En2WLarWFuU5DTHcqguvgtXLwC7kzgNUrEY0jF8YgIlkEDkTfBndDQiWKEH/?=
 =?us-ascii?Q?2EFm3Nl5rf+Us6a2SqeKYOMvl1Wnr8wUuQvYsx878KleZRnrUE+e0F4U1pWS?=
 =?us-ascii?Q?1uPa/1/UVOidUnSVk7uJhALMo8MXiNAA19TmAEbVeQQVbUh5Wx/g/NnI4PbK?=
 =?us-ascii?Q?H62J1y2Qf4FGReqUKlNOired+Hj2CXYKgHZp32u4dCA4D5Gag3GwugO71tna?=
 =?us-ascii?Q?z814ybUDDVi2yUqsI+hjwmtCRVJSbmZCwHwyk5crrzbZs5Z3Eg5AlDdi5HBA?=
 =?us-ascii?Q?U1HVseoNB3vlcX0deZ0WknRTyshOhejo/89kPCGCuk+r+0J3nzAkwp7bnIL3?=
 =?us-ascii?Q?8UfK/VYbQuv2CiuAmdF3x/UoT6tEayRIbOL4SZutHzPGSuKncNvKclb0egfZ?=
 =?us-ascii?Q?89inIaPMadty6oeDqP0roSAdfkSAWgmOEiVfBTwhOAStPnuK7sVHa/I+2DMp?=
 =?us-ascii?Q?/X00DsjxgY3RZUUeEDXUPkqt/yvq54eeslp3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:15.9449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea27131-4bf9-475e-4f88-08ddaac400ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9684
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
index 31d213ccbe0a8..df47693a30d77 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -644,6 +644,33 @@ static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *guilty_fence)
+{
+	int r;
+
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EINVAL;
+
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+	jpeg_v5_0_0_stop(ring->adev);
+	jpeg_v5_0_0_start(ring->adev);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
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

