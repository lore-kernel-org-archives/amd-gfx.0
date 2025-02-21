Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499D8C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E818A10EA8F;
	Fri, 21 Feb 2025 15:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5LCCPBVd";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7449810EA8E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/rQuQ6tGE9i+v7ccjjfCEeNxfdW63aCFb2sYPJPqKnzsod65xjXiS6l4OxD57Nr7s67Au0xmnPMFdJaOJqWQNsglmIzGLRhrkPxYEk9+MD9kBfjn/TGkKKfu4u3+s1ffEKE35WhwCv7XhUwygE551v2vpXHJw43Bmh3dvopKIVbdUap7BlmOowGaebiaf5AaOtW0HTKSHLx+io06QyzuPOFtF8uGALQrG8xQy10GZ+FvmT8l6rkfmWlPvVPNnBNY66190xUArcs28n55uu2vdhUaPyHg2xwmY4u99m2h0ro0ATbnod0L2Vizb9DSqMCiOq9cbp2+hlKVJS9PGaY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU41rJ149CwZKavzCEvhSZZJG7HV81gYpB4iJYAl5ok=;
 b=cOPeP5zhm0qx6i1b+ericmtu55mFUChxLwMDRAYKHVS1L3/qVNn4KGcZng5pDaj/yArPgZCkmU/eFkBYQURboOHXkUqiJ68iQy3WAobMaotP5JFmpWCYX+HIPL3IP955dC6WIjnwWM4Gujj3xmy5nAVDhrXbLsuTYR/nDNKzGxb3TEuKW0vdbRBB1hwbuSKafkL0r2cT1BdSLc/UawX84PmlQsw237Owl9itwKqNPYZohuMcw5/KF5wRkJQXFJF3PHZyeDHE+jqcZJCoXnkbn/SaTsWPmhAx6i7pykiSWZF/qjpSbHMEg+CC1+JFlrpWdNJPWXhdsfFmp2n/Y96DMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU41rJ149CwZKavzCEvhSZZJG7HV81gYpB4iJYAl5ok=;
 b=5LCCPBVdB198ON1wKjmeVHkga8aAiAtN/iw4J9ZUtlh3ZVD/YIH2txKGUpAlxn/33mvlg2L06WDHbwA6VdSVFtB5jDXLZPCwos69z2S19EfMdXqA/Jn/ob5uU33q7BCS/jLKfWclG1FaMXFFrvl/klzG69vG+ICkzOjuLJUc90w=
Received: from CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::29)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:22:54 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::97) by CH0P221CA0006.outlook.office365.com
 (2603:10b6:610:11c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:22:53 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:22:50 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Avoid HDP flush on JPEG v5.0.1
Date: Fri, 21 Feb 2025 20:52:34 +0530
Message-ID: <20250221152234.67294-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221152234.67294-1-lijo.lazar@amd.com>
References: <20250221152234.67294-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 7830472d-d51b-4dc0-c3ea-08dd528b9c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EiUT2o0Hzc3eHLBsM4Ime7KUJjBiHymneJhMKZICSPeP1yZwLFDMqPaBxxE7?=
 =?us-ascii?Q?gnfpM4G2yP6p5pdEGnoFXvNQFaYqfi363cLH3gpi8LsR0DWShstMKAhYVics?=
 =?us-ascii?Q?YHxBpUEmy95Ifq4FMtLa/fJT97U5EEEhoKqsjyzHz82lGEyiLyDiuZkj4Cyy?=
 =?us-ascii?Q?fgpvZy4awq79IV/GOP9u/fS1PPHyVm+eZ0KTjw5mP8Pqwzxc/eOKqEAReaBR?=
 =?us-ascii?Q?b2t+Gdgv2mIS+cLPCCH/l4hsDcctZhOgw7A7t9Ku9jIDeOGOpQaqeWJeAWs5?=
 =?us-ascii?Q?RbHTZMPyop17V3hmoyJPo2rLlv/qYOStWPjg8kGosM4YMWljY7yBKkc+LV5K?=
 =?us-ascii?Q?zC+9ZMo16C31SxXakL5lDXqdm5E5gLxDi96K3Zm77gQF2XqjaS2Gr0EFLX1P?=
 =?us-ascii?Q?R4Qp08kkoNPQOwO+8wMoU5WY/rQ5/SE8pahODVsx20u6ZKtuVuYlq+nsqcaX?=
 =?us-ascii?Q?H75TCY7iO+ArLDtcWdy8T5ZC1gqkMi+fsuEATEkj9Sx/lALtReseb8xK2T/D?=
 =?us-ascii?Q?/3vsTgd11MqcoPEtFlVML6l5F7FMbf8FUyIbsiWA4xGs23Q2VYKyFnYrArGC?=
 =?us-ascii?Q?jullSHMGC0dyVitR5/JNzu9wSpVWsDGI1B9Qg/BWz0H1YX3pSH8D4rglg4xI?=
 =?us-ascii?Q?MqTi02WVOANqHFfQMwbaqTFl73ROTNyVca9/WC62D1DuILLWDtQPgN9bWCrv?=
 =?us-ascii?Q?13D4bjEswnnaBR1nw/KdYBH4u3Xv3vxy7yqsQrAz+Vdr2HFfFkZkJmG7YFZw?=
 =?us-ascii?Q?0A7d4fzDBME0SkATyUrKma9gfh2UTysyIth7uo/B6D475QmhnHb57Ww3eXtw?=
 =?us-ascii?Q?qtHHRSm2et/xnR2Prxy4FArZJi//uEA9kh/ipeacIWNqqj8rHEx8psVZESRT?=
 =?us-ascii?Q?HEi6kJ/0AGyEwOgkjfj3m2JhOMMXRsHCkYLfBSH9nxUFq2amCECxAfK02wJU?=
 =?us-ascii?Q?GqYSdrYwpKh6t8/t4CCcb7aCbTtJM9/0JQB1nnTZFkTp2zXkB5DDXJ0dG1hq?=
 =?us-ascii?Q?qXXwCSdMbeJ9uzyTgHYxitjhUqfXLUJm4DpQ2faTkMSHhOiGlExljMEFOUIk?=
 =?us-ascii?Q?tgRq9pkFp6pIwtiPGovI08quszab4Fq9ValZObOOCLHNQ2TDQVoF40BK4/SV?=
 =?us-ascii?Q?C/AirvVxM3KkhRgGmQ0KbrS+N9c4mzVFdI3X0TyHFkY83vBNTSlRYfSfon0S?=
 =?us-ascii?Q?nPp2Qhy83BeXDhDMj0uF3tekikhI4laNX+ULEYqxflqr+AnxJL8UGoDL3Gte?=
 =?us-ascii?Q?c3toTsbEKhatCA8LR7xyqcTe+62pi9CLlGmFZNSX9A+KYwCiL3GNhQhJxYz2?=
 =?us-ascii?Q?Bosf7UsYQQgIxeQytqWTwuJ56evqH0BpzLLKTdASjJ4h25PafDFIWEd/CM8u?=
 =?us-ascii?Q?HNak496oMZ3nJ+/tG51VctdHmXuCeVSr/cL7N1JwHPwK2VmmLCBdrLLremJr?=
 =?us-ascii?Q?B7YACpa4BqNWrhpxiHMhjLVCrVgEuqPz7BQKH4KDZgSA16UcJSK+b7/2EcYy?=
 =?us-ascii?Q?6DJltWSkej1EhFg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:22:53.2823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7830472d-d51b-4dc0-c3ea-08dd528b9c5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
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

Similar to JPEG v4.0.3, HDP flush shouldn't be performed by JPEG engine.
Keep it empty.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index b8f06e9c9e62..9f5f49bed5bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -686,7 +686,7 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
 				   jpeg_v4_0_3_core_reg_offset(ring->pipe));
 }
 
-static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	/* JPEG engine access for HDP flush doesn't work when RRMT is enabled.
 	 * This is a workaround to avoid any HDP flush through JPEG ring.
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
index 747a3e5f6856..a90bf370a002 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -56,6 +56,7 @@ void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq
 				unsigned int flags);
 void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					unsigned int vmid, uint64_t pd_addr);
+void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring);
 void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
 void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring);
 void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 0d63af6ac68e..13d869641fe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -703,6 +703,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
 	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
 	.emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
 	.emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
+	.emit_hdp_flush = jpeg_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
 	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
 	.insert_nop = jpeg_v4_0_3_dec_ring_nop,
-- 
2.25.1

