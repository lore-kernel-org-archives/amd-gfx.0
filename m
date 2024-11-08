Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD4BD5E145
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 07:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385E110E0A0;
	Fri,  8 Nov 2024 07:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C51zDIXr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF7710E0A0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 07:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IV10GwRMxfQ5lEBrH+8IlWuiaIjJWFPnliWstAQdqVC2cV847ywIMn3P0BXqhKkgg2h/l9X54GwGjBPAYcz4Eqpa8fqV/0Imhd7jkFieEC4Gp01HcAUMOs7baqMt5KfaX0PBOlV02rneWTzQkf0xSbJ5v93cN09FP32rXXfzmU37W3PyGq/zv6bSVV1T2hoaWIplsPz1GAajvprnZMat/a2EcQAhzW8lQNeehmUUUFlKi5ToDyf//Rn/rSJsecvb34vu2As0oIHgeOqlMkE9tGxvJL1CXnjGAuQt6/t9WlVGRDtE03AfkSefwmZ/QeyRhq8vApFJ6WU24t1I/rouBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvhsveYBBAIG5Fpel064BZjp3V/3iIElTD/bTDGo9B0=;
 b=V6Fd3oJN8sxURITcYcS8SacmEaa0aJoJlDTo4z0UbjXw3+/FdF523OTZ0VPnh0LyKMnTzSQex9Zgp/EKP+MwXck1hqb8Dz4MZ5BcnCMjQtgbFNYiFBzL2InQroET0fFq7lRGCG+6TFC/IbM2uqxJCwHle9ibztp5f0TLqfwfnLkdMj8cLRjwjU90uAlwxQXr5Or8uQV5wyVEuOHT3g1noSBV4QSGQmJyhFkLlvzQMSFb3OPRZJSSfdrh1lorNswD+6SUUkOKH1sUsz9NqNFM2zdwaSsntG5ABcpcRZJBxOVku70EW2nC/q3ckLiTUyPzLjhuQpqFmG7unscB6Hio1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvhsveYBBAIG5Fpel064BZjp3V/3iIElTD/bTDGo9B0=;
 b=C51zDIXrqF6hmPRBsdMpNz2+t0yYIH3Bed7AAdWcyStXanOlwFRlZBjL8Js91h1jBq6EEkQSqXcIY6YV+iecN4OP9uYjAc+VoRA43c1OXcyw8VGpkt+gCeSST1tqvYjXpYzKL5hPZRRjTt+olWnTrg/pn8gYr6GIJZdru08tOiE=
Received: from CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::29)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 07:44:48 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:11c:cafe::f1) by CH0P221CA0006.outlook.office365.com
 (2603:10b6:610:11c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 07:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Fri, 8 Nov 2024 07:44:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 01:44:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 01:44:47 -0600
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Nov 2024 01:44:45 -0600
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shikang Fan <shikang.fan@amd.com>, Tong Liu01 <Tong.Liu01@amd.com>, "Emily
 Deng" <Emily.Deng@amd.com>
Subject: [PATCH] [PATCH] drm/amdgpu/sriov: Check pending job finished or not
 to identify has bad job
Date: Fri, 8 Nov 2024 15:44:35 +0800
Message-ID: <20241108074435.641831-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8bd61f-9bae-4131-558a-08dcffc93867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kapFh/H4qkflGwwXA+u85jYbHMIj7eSo2N9ofmKbPEW5DB4hiaQvPFw9KPx8?=
 =?us-ascii?Q?tycwvLApGKwdmT7/ZPNCURvHL0H2/jqhrEdTryV/TEgw65ATurn6hUoMbpr8?=
 =?us-ascii?Q?tpxuB+sEjACgvnoXw6+0q20Tb7VRpLWEMFz5cSPU+PX/VKTpmic/h2rhGxEP?=
 =?us-ascii?Q?WYBl8rYIN+o94IL6HQTqEKFCCPEgVD/ZYq3KMHpYuO5pmrnahyXXArFMCvK6?=
 =?us-ascii?Q?bvKcfNk7E5jO6tXrqVvAP43CHC0nfOTRQmBGouB8LPQH+j2MUOzjK+7B42U6?=
 =?us-ascii?Q?u4KvwwV/JViu4ItAqzNe4anx8YSolG41JRvsHX2MLDyy/mTOvnD2iS68ITcF?=
 =?us-ascii?Q?k0pBfAsDDshHLP3N68uMDiGBm/u2ddH9HoIn0Bcxky5bEq0az77Ysbz+Z/xJ?=
 =?us-ascii?Q?XyP/zzNqcDENseM23IO7wevxvgFRpijvOKeSYRzeYD1rmp8z2UVeFF5x/fe1?=
 =?us-ascii?Q?7+eVzxBUDiPizm3zEE1M7LxpKvcTT9fLtFv6YiVY90MQwmXhvGQBlbkE8vjo?=
 =?us-ascii?Q?vl1W27sdQr6SPKomF+d2FhCS4w/U5QHtYcjrVi7qI+84G+mmL7rSjkv1WH2d?=
 =?us-ascii?Q?Wzlb52XKsqdxE9Jk0zkHMBE1qyaHKnkubg7ConlfTGxiqv4t1Gci+fwjyevU?=
 =?us-ascii?Q?VBGFY1XnWf6DcH8DRHo1l2mVL84LTsL38vUqjzpZ92eRJ/71DH4RBIMbpNbx?=
 =?us-ascii?Q?PHwmY8zYm5A2+iwYropSCZOcISRXpzBaTRWY2D1KNqv62kkru26W+dYpJF0b?=
 =?us-ascii?Q?pmEj1sprCfeXfn0RHPLIIHpgsqDvEdt2Qh1vpBDBBD9VoIipX02wlhqtPpBn?=
 =?us-ascii?Q?lz9CLnlJUL0UsK121l9Psu6YqC6i+88NW8j5+uUSa1pI7I/DwxOlge67AS46?=
 =?us-ascii?Q?6CMkPDBIBwkC0wypF4Q132cnWD4hyFTq61MLxNjeHBPwaD63nq5cnc45A9Pt?=
 =?us-ascii?Q?4Gg2w9WPfDHsnGLCE/39QEi+Digjg+BnsJ4HsvbyHpvZTwT5TbU/3AXy1hTd?=
 =?us-ascii?Q?FJNwm5j4NhYSxHpWkb8/MdmIopXpP0WwEceIV0nMvJiah94Gb0cjmFFCMTgg?=
 =?us-ascii?Q?PsEPs0GZUArRrmHiKS9GNo2oPN6xJxWy7dgJ7GqyIfuMiJ85D2T9/8EKdU8V?=
 =?us-ascii?Q?QL+HAxlPtbR8QsE3mNsV7MVxV3v57x5MsCJ64jEGFCboiVAcVZqkEbYBFjAz?=
 =?us-ascii?Q?6MiqHd8cGFxs6ojS/TcDkvdLpjRLxG6Xa/9HDUtCpWEsk/5GVY47elEgBdB2?=
 =?us-ascii?Q?23zcV8RI32V3m+UKYgbbJNduSZbKqnVGnFiiR9oQjVU+b2VhXyFaJr16fpxu?=
 =?us-ascii?Q?FmXGCAQrnnq5jX8gZNJtgZ4KgWZZSeMTsxSFYw6NHlIW+0N6AglTE6SXBXG0?=
 =?us-ascii?Q?VFMuhnCTbQ/Wkl8EE/XqZHa0J4BTpC4NK/UYcJ2v6xNSK/Ux3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 07:44:47.8792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8bd61f-9bae-4131-558a-08dcffc93867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
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

drm_sched_free_job_work is a queue work function,
so even job is finished in hw, it still needs some time to
be deleted from the pending queue by drm_sched_free_job_work.
here iterates over the pending job list and wait for each job to finish
within specified timeout (1s by default) to avoid jobs that are not
cleaned up in time or are about to finished.
if wait timeout, return true

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6c0ff1c2ae4c..83ce1c85e680 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -100,6 +100,7 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2)
 #define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
 #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
+#define AMDGPU_PENDING_JOB_TIMEOUT	msecs_to_jiffies(1000)
 
 static const struct drm_driver amdgpu_kms_driver;
 
@@ -5198,7 +5199,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
 	int i;
-	struct drm_sched_job *job;
+	struct drm_sched_job *job, *tmp;
+	long r;
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
@@ -5207,11 +5209,20 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 			continue;
 
 		spin_lock(&ring->sched.job_list_lock);
-		job = list_first_entry_or_null(&ring->sched.pending_list,
-					       struct drm_sched_job, list);
+
+		/* iterates over the pending job list
+		 * wait for each job to finish within timeout (1s by default)
+		 * if wait timeout, return true
+		 */
+		list_for_each_entry_safe(job, tmp, &ring->sched.pending_list, list) {
+			r = dma_fence_wait_timeout(&job->s_fence->finished,
+								false, AMDGPU_PENDING_JOB_TIMEOUT);
+			if (r <= 0) {
+				spin_unlock(&ring->sched.job_list_lock);
+				return true;
+			}
+		}
 		spin_unlock(&ring->sched.job_list_lock);
-		if (job)
-			return true;
 	}
 	return false;
 }
-- 
2.34.1

