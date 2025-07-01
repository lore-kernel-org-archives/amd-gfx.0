Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB48DC83F04
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A595210E62F;
	Tue,  1 Jul 2025 18:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gCYVEYrs";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A30710E5F6
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azLnP/bo/yfnuJTEZLZuLmEgOFm85B0rOuoX/oBiDXcXak3eBst2m7mo556F6WIQe3b7VinptReP40mqZ3SGzB2PNE21bJPtqFpjPigGXwHoqfz7pdwCSZ+YAzGTWSqXwXZGpSbz2nzO8mKs7fCPywuWRHtGDarFoKPYu4WZ/lE+H6XG6PzO00Hjb5LaK64qfB98UKKJdiH05FRBjneEENZeHU0D0hS2Qt/ymnBu+1y2ZvjIu6hx2NHZkxRQJs8gDbtKSYNnV757QO3xKtbxmTb4IYda3comaToDHTKvcXusLiP5BlmZwkVm8YRrtw3gZIeJzjd0A8Qhr9CIeTqR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3/pbIgpPGchOnymbkcc99Ow5ITUhhWBa5uaVPNniCM=;
 b=BntKPVAx3mK1Folqgt5+c4frS8WEehUi+I1ukhDqaqrNK55SATMY98m7iGsi+6Z7dGw/EE1EOJG0MSJq09n0U3KjiXdLyUOtBstpusVgp5HpMuJEvuWONqc+S+6Igdqb7FiuhnEAbVYzAeQYpw7lwU/mHU0yJwup5Tpmg/6BZu6IBsrGossFb9OATuX6DMgOk0ouLQpFoBQMJPotRcS6dWj/DDlO/TKFzy+A/V0VP3USzJPHdkZlzJBQn96xakeZYkA0U8OS3Q6RlDYz5EiW5ttj6gUSVgN9FrTjd810KcaPAQc8OUC+3N4KRymYoh1QyRQ5/DuwJToGCjiK08Oitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3/pbIgpPGchOnymbkcc99Ow5ITUhhWBa5uaVPNniCM=;
 b=gCYVEYrsXbNL6MVaslW/fD3N4klj/Z/AXKB2pCHmmdX3505Uk1rmBt8HmOfwbyK9cAFRt5KTvhkiiiInZSU+lol09nvUVO3othQazg9PrBdD7jZBN1k8FBATUlr74vIyBoRAj5sV8yi1N4mJHpg9qR8c/11VwkO+3uff+T71kpY=
Received: from SA0PR11CA0018.namprd11.prod.outlook.com (2603:10b6:806:d3::23)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 18:45:18 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::9a) by SA0PR11CA0018.outlook.office365.com
 (2603:10b6:806:d3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 20/28] drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:43 -0400
Message-ID: <20250701184451.11868-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2f2efc-2a2a-49d0-7180-08ddb8cf6cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TCzviA9ikTjl6DwT5g6L1rWvLdP6ujliJyHn678igUPsz4PkwheyAwiUJUHV?=
 =?us-ascii?Q?T8smnLkq2mH9oEtIzxWbjDH75F8ercgMD5kReXAOhHrfBpxmrk0Vu/ulB4qw?=
 =?us-ascii?Q?cFANI6G2uNw0Sd5kwAkay+4K1NNc83+i2bNkoYIXp1UNl0DyapOgqiYnEAmq?=
 =?us-ascii?Q?aTrkOUVm8uEcO904OtG7fCoZA6t7f/nhZWLwdXikHDGkSeckcYMT1nKOZESr?=
 =?us-ascii?Q?PNYTxRpGvOIptmdAhIQMUQzcq6ZQuykJIuKpIPZL1Mx5pgJ0lfDPcyCoaIb3?=
 =?us-ascii?Q?jVoZ4NHnnTCaLviY3RQl8qbEDuZ8iTB6XwFGIx18+RXvYdPcd57m6V53tn8L?=
 =?us-ascii?Q?AemZTBIbq7Kf/wME1IrSLd3ipPZ0wyUkWeKdkcukNmENUXg1RjETokLiSQt8?=
 =?us-ascii?Q?Pu8QttXqceW5V4i/aLV7lTEW5N8ubv8XX84fCEuI0yd8gYGfoX6qXO9SvAxP?=
 =?us-ascii?Q?547MDYuYPTWAzNhTXUSZTE04shFmnQOfkIIvyoo0Gs/hUuMkzxFwFpeXRyaS?=
 =?us-ascii?Q?+nvSiKF+nue+B7Mu0bCw4W/rP8X9SFTsUj2qXFqWB9UTLVikUlh+Mzd7g2Ys?=
 =?us-ascii?Q?bztsT1LxNZO96KT3/7MPe1ChRNPZn4WCGTNqWMsO/Ugs+8DNazWl5fwc35Zb?=
 =?us-ascii?Q?kKXDSJazdJzYnOm08C/eDEPHlEjnZKfvKGjMnEoD6EQ5n5kFg+To/ldu7pAn?=
 =?us-ascii?Q?s418q+bQPI0Sd9HYMtpZvnpu/tqqwwfKJ6k2WWbnt0C07QU16Kx3imo3Qz9Z?=
 =?us-ascii?Q?K7+R94vejUJ5DOkRZgMrYZDEQEZsZZwbRT59zTC93CkES6U8hEjop3l3Pt0g?=
 =?us-ascii?Q?g4YSxfS6BxLvUrT+M00qGVbyx1ecUv/GLhqlLfBa35Hi0dBvxi0qWOjDVYl3?=
 =?us-ascii?Q?66Lp6nQWop/u+XMQhMdv/oYUQ9Z4RQl/I0KibMcpdExKZFj77rNyHCgTfgrW?=
 =?us-ascii?Q?Tcznz7tqjcEksD5vYCtHiviyncKra2xE/JTRwHgWnbw0GJyWmtmAFDpvkpSF?=
 =?us-ascii?Q?imfd8GQhA++hpNr+6FFjRLQGl8JKgq675JkdvqCqJ8Xi0I0YpDmvWy6fZs0I?=
 =?us-ascii?Q?626TxWuj/KwsWaz1t+CU+CXbKwJdRTL/VPci1CjZbKH+iQ+O4bQQhk0To6Wn?=
 =?us-ascii?Q?gJYzdTd3nR8mQMYlSxpGtJLR3ExH2mx8ss5yvyqWQAGHO+k/mfEPZ7SHJWIJ?=
 =?us-ascii?Q?DZa1CSIk1n9JQFMMstBdoh4zbFEErvpSa3+0hUKWPukYOKorVXsymY816RJX?=
 =?us-ascii?Q?Tw/ieaJF4VraVdKrSiH2fvWGK2KahGrQM0il6sJ+OHwXgzlVeUMuoCGrg+wV?=
 =?us-ascii?Q?SXPhUSTKzYvzQX6MQ2/KCFrBvJnlTDyHyXc8gGW56Gt8/NX+rBHxOwbt9Q8S?=
 =?us-ascii?Q?zklED48OYNL9ts9d5DumDUXe3OEv51WlCWVKduFHsOoycYdmrFes71pzUhW2?=
 =?us-ascii?Q?fnPQ1ffzOG7S9Krc4BnXwv6T8LMVm42bN2gqDq2qU/5CiZ8mtOhh/ieMNrb0?=
 =?us-ascii?Q?AcvuG6KG02hQwLAoTt6DrNENJdyFY3CSPqVp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:17.9552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2f2efc-2a2a-49d0-7180-08ddb8cf6cd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 6f8a16da9d608..5473cbaa5c0e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -838,20 +838,13 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
-- 
2.50.0

