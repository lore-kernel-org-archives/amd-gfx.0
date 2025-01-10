Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCD4E7719D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 16:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE6310F123;
	Fri, 10 Jan 2025 16:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BPocKGSt";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A18F10F11A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 16:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mL06REfDglrVuHBe0BRAVtjJ1hcngIwNZs0PRj+toG40WxQOSAHRhiGRVcQYEn5nzy2HFtB3ClmOiyVL+QWmMNB0/gpIThQMTjdT0st2JthM+xu39KAMAs9SVK5CpnjYxApU3jWVC8VC/ZKFQdas1zWEPZRxJ8OVmxzRFoxzUnco05YVkUnCrUkE5MXnoVDd7+Dm4Bsz84jJ5Viw5T8HiFu52moSN1Mh/Ff3tAoiLSAdoDQbbU8HCvL2w+xEvhWh+Kkt0lrfbLiuh/rSrkiVzIdWDZeIDna8gL6W9sra5VPwuQKNfIcVxjCM7oAzenM99xLUHSQWJfi4WRKr0LnYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfOIJaGdF5R3gq/PJwHrIPCWwVLzEovbVU0iJwPMKxg=;
 b=EqKCqPx9iVRSFEflrkXIWfrCriZX42vTshrb9+B9lchUEK/CtRYEN397wJqHw1jkByz6lVyteH3c5F0+J/jRZ0OyHXzgPHWGYxaMo8+z/7XKED1pMMczRDO1BAeNCRtwYQMMPBTbsR+CXH/w0emJqvEkWrtQeoG20/7QbonmT/v2FSy5Xt8kfeTaeimTrUvUHFE7TMROBgjX93Uz2fUZBDdlcEuP/ENh6abUssxbQuMK4gzD11E7W/1RIa+GiZ6Ymu2DhFcJBh7EjBXGewS5K5ZaR3nttULHPKyyM0szbN+yEZmTbjju8uh7VHnY4UvqGI/goUltPtS/0oOrUdwVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfOIJaGdF5R3gq/PJwHrIPCWwVLzEovbVU0iJwPMKxg=;
 b=BPocKGStpgDSjsREFRiA0WLQ3Yowe+imGTct4hY06O5g5lODN1YUBmWNCIstzHkUJsGncixTf66RN20XObaeJbkPxjG7TR6PjyGIgGxfTV4tlMw7fEDPx8Jhx1m101RrIHNJx7tYutC4+v3Nu/AB/8BzwYaRVifga9oa/45sy00=
Received: from BN9PR03CA0435.namprd03.prod.outlook.com (2603:10b6:408:113::20)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 16:18:25 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::40) by BN9PR03CA0435.outlook.office365.com
 (2603:10b6:408:113::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Fri,
 10 Jan 2025 16:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 16:18:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 10:18:23 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <sathishkumar.sundararaju@amd.com>, <sonny.jiang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Check RRMT status for JPEG v4.0.3
Date: Fri, 10 Jan 2025 21:48:00 +0530
Message-ID: <20250110161800.1326934-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110161800.1326934-1-lijo.lazar@amd.com>
References: <20250110161800.1326934-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e2d241-6797-4eb5-ab31-08dd31926919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ur6KJ5QwBrUrptde4SvX8623Tbb7tUabhsfiVPlKlD43Zwb6jGSBnq3Mop51?=
 =?us-ascii?Q?J7dMYey7fHgVYFL4evYxpWF+PfqYqoWMRXNc+7ZmwcElmEqHz+29n70jnq4Z?=
 =?us-ascii?Q?08hfcSh3e4h3ICtlTcyya+4G5UWBYpZa801T5ieMgzUKAN3tPJ2To0a9qqRk?=
 =?us-ascii?Q?COVj8qp8snhxsUG154JUphG7CtMv2wEvuKOZqChf2MVbKEIVAWwdgkcqg5g+?=
 =?us-ascii?Q?XBwg1abPFywI4o824owwW+hX4bivTVu1CDYds2mcplLyr64HmYFMij0iq61l?=
 =?us-ascii?Q?7FRGS2F5rEnlgsCa45shHAikKmCTWqUUJF9SyvM3swYQG/lJe78smul4kFXf?=
 =?us-ascii?Q?a2N39nZ1nt8e6ntH7ed6bgT6cl84EQENhJjxFdBzJpI2zDIwlrFLyWhbtztN?=
 =?us-ascii?Q?sCiBPYDTWYUsA4ofSVUTRjbdotUFKVp6EEiW5rZ6+CyKL+zZC5AVa66wuUew?=
 =?us-ascii?Q?qdKXGOhwTKVXNGJCDdYA1lGivEGqKq6j4bQJK+Ek1L17UMrrfptHDmZgR/r+?=
 =?us-ascii?Q?hg/2IgvD9MZtoRJzCr4tAoXlJCJQGZ194W0A2oY7U1inLvkBKXZwfPWM1DkR?=
 =?us-ascii?Q?IqmpUHaHIlskIV7T21u0TJJOnpY/LwO1VObCKMfJif+5fzHIvN8+zMHZlceC?=
 =?us-ascii?Q?t0zgvVGa5YUBaemLDQ2dyXYhd2PC6pIUgY3QDYD85YVOP3uOfDncrGLkm3rM?=
 =?us-ascii?Q?VnAOIoXYKho04AshbIHrn45rMOUGdhK2qxS/K/5A4W+8dgNxMHUqq5wYYHRb?=
 =?us-ascii?Q?RqhUJQ/nyvnznAJipEZxZ4BuA22kjFU1uFNjcfsGx9C2AgvAIFCLZt5Ak77T?=
 =?us-ascii?Q?uxuQd4sGlTSNISG8lY1/S9N0CHvSWrgNV5k8vvW8pHUcQo8TjzuYJByM4EUR?=
 =?us-ascii?Q?Fc5MtFkzdvoAzWFCzdRkUj06v6Xpzkv5yazPBV56AJF3n3e26dIWjatzqL5G?=
 =?us-ascii?Q?r4YdnhaJ85PVLPKTRzWmd2hi5GkVnhCqW/CHe0IXHAyD99hTF8iUHyOacHH1?=
 =?us-ascii?Q?APS4AnEBMaxE49QwFxm0miIhYP4w5b/8dpwU846fwnsq13P9o/FDRGzQseeD?=
 =?us-ascii?Q?8CNbdjS5bBirP/4bEBWMOVERK4PKUY0nKtA/n1Ly4bBnqemUoRG8VV+sJQDk?=
 =?us-ascii?Q?yeZ1vPfenk92wB9qKYBgqLhI7EgTQX3f4GYmiB80MlIMZsYy0USNQRPQcrks?=
 =?us-ascii?Q?4pev+Xu5ZPVTHDjZqHyzIOBuu/FPAXkUcrQ0fgWgd/IsuRBr+g5uyXjQFY8Q?=
 =?us-ascii?Q?4LNg6Lg83PM6Mf+TL/ZN4DWedA0m+VoG1/N+RHcFpVbi31Sln8OXcSiW47ZB?=
 =?us-ascii?Q?45aus01Y3YcLDWU0BEpTSYRrrqyVr9cxtz0BTwbySW5C1ekHp8i1xJ+T1fqD?=
 =?us-ascii?Q?HoxhteYs9HewFr0RTjLhzWGmIHDCx/RSRbAGLoun/K9qkcexFkv+9cvMX1DS?=
 =?us-ascii?Q?vFf+9ypZUcllyEsmqC4p4rb7MH2Q/A4J4iI1Hic3h+PQB2gN/mSsfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:18:25.4129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e2d241-6797-4eb5-ab31-08dd31926919
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918
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

RRMT could get dynamically enabled/disabled by PSP firmware. Read the
status from register for reading RRMT status. For VFs, this is not
accessible, hence assume that it's always disabled for now.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index d9cb343a8708..eb2096dcf1a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -92,6 +92,12 @@
 		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;	\
 	} while (0)
 
+enum amdgpu_jpeg_caps {
+	AMDGPU_JPEG_RRMT_ENABLED,
+};
+
+#define AMDGPU_JPEG_CAPS(caps) BIT(AMDGPU_JPEG_##caps)
+
 struct amdgpu_jpeg_reg{
 	unsigned jpeg_pitch[AMDGPU_MAX_JPEG_RINGS];
 };
@@ -130,6 +136,7 @@ struct amdgpu_jpeg {
 	uint8_t num_inst_per_aid;
 	bool	indirect_sram;
 	uint32_t supported_reset;
+	uint32_t caps;
 };
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 88f9771c1686..9459e8cc7413 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -61,8 +61,7 @@ static int amdgpu_ih_srcid_jpeg[] = {
 
 static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
 {
-	return amdgpu_sriov_vf(adev) ||
-	       (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4));
+	return (adev->jpeg.caps & AMDGPU_JPEG_CAPS(RRMT_ENABLED)) == 0;
 }
 
 /**
@@ -331,6 +330,11 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 	} else {
+		/* This flag is not set for VF, assumed to be disabled always */
+		if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) &
+		    0x100)
+			adev->jpeg.caps |= AMDGPU_JPEG_CAPS(RRMT_ENABLED);
+
 		for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 			jpeg_inst = GET_INST(JPEG, i);
 
-- 
2.25.1

