Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EEBE7719D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 05:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25F310EF9B;
	Fri, 10 Jan 2025 05:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3oN6cVco";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3758A10E0C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 05:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kY2oHZuPFhMKhXbyKvEv8Bpo6rfeEQzVaDdjApucRGLmZH80gp+aXWVNhFd5wZbd0FPGm6wjq0fKVlOAvSDG0kCA2W6mFmosuS3nH5OJqwbo6GubZ+vozMXdWuYCJ3DlCUaehtbAzqFjgJAUFg9W3xwGCLkNIbzU+Jms392G/vfyn4a0r/+lO96SkZEPjG6zK5U/4XXQkQDp45ALpp99Emkg0UmbAb4X7PGEFKWFss6kWKEvr8cL/HaWVXbYbYHo0ImPTssY+AZa/CCj5iN4fTx3pF6CdYqNctv/FuETiH7JGIjw3Ef6bRbnsSDmUy0EdqLt/kKZqZuz3i3ySGr8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIyIWIFijU51Pa16l52N55SXPGcCfh6SgulMPgcZ128=;
 b=I0lPaqfcg3Bb0kOb0hPidwH8rumRVXhHrqdaaKNcWsHia2BikybXMNA/SXmxueTJ5ycZuhtZxsPDq7ZA+ilqNETVr9BzrhxitEPOy6epemOI6uedYkYeeCwg54ksaz7BjVhTrnM8S6BIj1nyTqm05MO74+I5r/cWlqmnapL+AZqUBV5BfeyfEGfvMpx+JSrKWKs1C7LYeB5C9NpcwBM0vjaYt2YOKNJzkrQkF3IawD/Skuba32Ey92GgrjyTpJ/s1e/ipiyHXbeHmIKdThgGCckjwmWZetZ12X0clpHG+cQLui3waqzJMW0RVYaStSG0BPqZDzhQw9u1nQMH6LOgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIyIWIFijU51Pa16l52N55SXPGcCfh6SgulMPgcZ128=;
 b=3oN6cVcoRDhVHON7epqirN/86xr4OipRJIlzNRpyF1JFMjMP2Ecn8UoAVwZXOVYsHZF0NGSzlgvIVH9NdvK/cdf71HBdNKMeMhgKnE8jQ/J7Hp6tH2MeWiN3Wa5GlYyMaoXtx2v8h9rZgOQ9ThIyKBmNVpoYvyv/8IGrdVZxCeI=
Received: from BYAPR07CA0081.namprd07.prod.outlook.com (2603:10b6:a03:12b::22)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 05:22:09 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::3b) by BYAPR07CA0081.outlook.office365.com
 (2603:10b6:a03:12b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Fri,
 10 Jan 2025 05:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 05:22:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 23:22:05 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 23:22:00 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 9 Jan 2025 23:21:58 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>
Subject: [PATCH 2/2 V2] drm/amdgpu/gfx10: implement gfx queue reset via MMIO
Date: Fri, 10 Jan 2025 13:21:50 +0800
Message-ID: <20250110052150.3295085-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110052150.3295085-1-jesse.zhang@amd.com>
References: <20250110052150.3295085-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a36cb02-9d7b-4a87-1611-08dd3136bada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fyRSUWS3DBoTU1lvmxIibxcio8pkz9seu0nOKpEoE4dBPA2ZThhpiQOHXZPE?=
 =?us-ascii?Q?4EQcOUU9OoUQR/Sy+7erQHe9GtZBSTjMjxV57QobiczmbQYZY7gXkkGCaMI5?=
 =?us-ascii?Q?pJ91ncd9K5gmpza0ufmzeNagLDnHmN6NSjti6inwMZ2gjon5G6RYIq3wwpUL?=
 =?us-ascii?Q?vGswH0PpfITgeEK2qi0+1leJsUd1UYuaVXPztIrnWpJ4T65iygXrGuFOaCzg?=
 =?us-ascii?Q?E52nBRhLfI+ZNfEUgzhQMfE7e2GaQHIGgvI+nEr88k3JlYaJ1MoluotqjzS5?=
 =?us-ascii?Q?s4EH+y/neW2WSZu5mzTJvZuowtDQPMDThE3Fz/K5Y2QnI8JGM0cId05ZZ8C2?=
 =?us-ascii?Q?AVl3ZL4bhGgY8lR/MMVCL769krfXFMkQ90wT7iwnwXtbCqQEBTAz6cfDEROH?=
 =?us-ascii?Q?7sWLwdnkNHPMV5xit2Vgq7/GbiVdzY5qKfYR+lKoXhE/kpjtSekw1rHXPUZ0?=
 =?us-ascii?Q?9B6FvwaOCVjmKIJNeEGQUJELD9AkL8F1fKZk2OxwkMh7BNsHJzpUBgzoxh1a?=
 =?us-ascii?Q?ZKFePS8wtEmblFr93Zo2w3UPQ6eCBTxGa1nC9e0Ge3uZVFbAn8BzN5jSTKYG?=
 =?us-ascii?Q?QHqvOf1RV3MkAOB/YPUL3cTTsPoWIVgyhJW9HS5QyIuuU/Prc4SWYQ0qV6Ys?=
 =?us-ascii?Q?kbEPLhttqXnYuvLOUGFyftoChAYFTqNLCxfojNrg2BqW66JFabS08O/S4x17?=
 =?us-ascii?Q?waTRL/w2GITkCw0BXd55QfEwIV1zZcqCalev2VY7xTITjfzpBxSOTWKxMQr0?=
 =?us-ascii?Q?2FXqPgmmycELtYzb2PIOop4ZwPuEQffnFV/OyFqIFIpBqqY5QPnqtb63+W39?=
 =?us-ascii?Q?IHfszhYuJ3sUAzytX9gd6cBBOh3J5NA5hjpEhSWT6c08Mw9OQ85j5k0Flq9k?=
 =?us-ascii?Q?ablmMOsSynnM9kk4rHMd5V31oA6Je+j0Oef0+sWZqZYlztkMwgc6g6fkO/QJ?=
 =?us-ascii?Q?gMTSfN1R44keuxWt7FZnoW2q391ZMhF1zNr17jSdDARdN+Nv7XN6teCz4rG3?=
 =?us-ascii?Q?w3CVLHMYbqIUP4JIauQ9jImLdVMvqJaNdIIH4w4Ta7GfNPP/UNR7kKr3l0mh?=
 =?us-ascii?Q?TEfdB7aTkrdqGRqfUYnat8n6xx4rlBy8oBm0bbkoLNJsUSK/xBW8PZsqyraI?=
 =?us-ascii?Q?2ovF/Uw1wlPj67c0dYrfmphcBADvz37vCn9T2c1PacHPNmW7LDOartPjACp4?=
 =?us-ascii?Q?rFEVCaQawZVjYKta7qOcWdihYvh2TSho83Gcz5ZSMJDsO4aIdS238Xxg32wt?=
 =?us-ascii?Q?5TBG9A65aojBH2gbCVWa01cKpsMvS2yNgW+tesnsMkb2C/dTgHbaIMaMtZAx?=
 =?us-ascii?Q?f4gjdds2JaWaZJobjFGfU7jKiSQMJcDbyiaEjTaLkNsAGsso3nsEwCHd5jqz?=
 =?us-ascii?Q?2ET2v8O3aVegbfXeDTMXJnrpOI1IPGop2Pk30EDF3IMo7fe9XDPmWEz+AU30?=
 =?us-ascii?Q?TfxBKzsoSqndsaB2MohXNU6Md4hpsLQsvuythZTd9vUG/dHPWt07Kf/ppsFj?=
 =?us-ascii?Q?OJBbsIntnDrFGSM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 05:22:08.6984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a36cb02-9d7b-4a87-1611-08dd3136bada
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Using mmio to do queue reset

v2: Alignment the function with gfx9/gfx9.4.3.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6157e1126030..a3d726dd6fe5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3796,6 +3796,7 @@ static void gfx_v10_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t
 {
 	struct amdgpu_device *adev = kiq_ring->adev;
 	unsigned i;
+	uint32_t tmp;
 
 	/* enter save mode */
 	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
@@ -3813,7 +3814,25 @@ static void gfx_v10_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t
 		}
 		if (i >= adev->usec_timeout)
 			dev_err(adev->dev, "fail to wait on hqd deactive\n");
-	} else {
+	} else if (queue_type == AMDGPU_RING_TYPE_GFX) {
+		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX,
+			     (uint32_t)(0x1 << GRBM_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT));
+		tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+		if (pipe_id == 0)
+			tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << queue_id);
+		else
+			tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE1_QUEUES, 1 << queue_id);
+		WREG32_SOC15(GC, 0, mmCP_VMID_RESET, tmp);
+
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, mmCP_GFX_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout)
+			dev_err(adev->dev, "failed to wait on gfx hqd deactivate\n");
+	}else {
 		dev_err(adev->dev, "reset queue_type(%d) not supported\n", queue_type);
 	}
 
-- 
2.25.1

