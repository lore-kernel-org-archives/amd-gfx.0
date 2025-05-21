Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4BBC54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC00A10E71D;
	Wed, 21 May 2025 20:24:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z9wXVqZi";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3B810E71C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWJIHj4dAvcVQVJtanhPTSA4zshU3sQ7tAKWDlyV82ZnxwwvtnLv7NRmExVoYuuBY34dZr5bO8mankOGSlHyfY/sVoQ/oKl+02e2ilrs8HFJ/pM7HP9GEGYGClnlV0mocSPVp1pQCF+vvpksLmVKaiUd7n4iXuJ2Kb+QsWSlpsJBcERqd4lDeZpW13SrzGlpeSRi2hezlGGf+VEaEYJypqmqqJPhNPyyoQcvEHhvroHDTLSDxNJJxsTuDI5EbAT8zLv80uVNolNLjyM4ZUeq4W6AQ/eZrU8MR6QIIDeDxjYcgHpM2erod1kz3+9P07WXggfbudpmOPw/AhnakZ/sZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTp46pKVXke1NqpWQ5QuM4tk6DDgRbR2WllT4JpDjWo=;
 b=yaM4x3Qi+CtoWHFTrAVLbK4QhVaSMJUEdY/jBfTXAVlL1WS+wO2NzVP97XmmQ0Sgfae3j1XSNbSpomGX9WiWgpxOJUpZov6aU3qTIWoNF8ketU9l3RXeIg0N2FCZEAcbDOb+VAgpV2YkCw0KFyoP+qwkVGlCfK1cRPng9G7MxHwBHP6DhYTuRi5XeJPDEN9JaFbhJnHVyhUpsH5JXAdNrD6f8PkKgLOjBdk71TWnkmvtELwNLzgMoQb0GmxN13qy9KrlqCo8KWK+WRMwrUU/5W7Jl1ACwAFmwIfFebWlwkmu+ywYSASUC/Sb6KA5+9LUsaj6AoOW2sz63Lr7xB9MbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTp46pKVXke1NqpWQ5QuM4tk6DDgRbR2WllT4JpDjWo=;
 b=z9wXVqZifIGxdSD+O9PE25MN2aZKwcGCdPgybCV8LHXna52f5sJ/92Ke4yvUKP1AMHGdNc7iqqWsb+difTRQSr9WRhU3jqYUXoIEz/IcReBCh4gO5eJir5E9ochon2o2Grsko+w3QU1v5m9bdJ71Ij3I6gbcm06OLHDkUmOMTUQ=
Received: from SA9PR03CA0026.namprd03.prod.outlook.com (2603:10b6:806:20::31)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 20:24:30 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::aa) by SA9PR03CA0026.outlook.office365.com
 (2603:10b6:806:20::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 20:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:24:30 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 May 2025 15:24:28 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v3 4/9] drm/amdgpu: read back register after written
Date: Wed, 21 May 2025 16:24:09 -0400
Message-ID: <20250521202414.18251-4-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521202414.18251-1-David.Wu3@amd.com>
References: <20250521202414.18251-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1b10d9-e85a-41a0-ecda-08dd98a57df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I21W7RVSrVGEMH54a7UOAJ3ioNi1PJNvBXYqB0kpjvjWP3xnxmSSs4C9DgPZ?=
 =?us-ascii?Q?oySRhWNQTYDB9sUEFh5WzDO7pGplz0aeZD4WioeiIf0WTahOo8jT6GhQfGOV?=
 =?us-ascii?Q?MGWtt7tCxh4RAQJH66Tm6cJgx0iGq0Ru4myGf3SkI7IVoUY4pUY95s1/g3Ya?=
 =?us-ascii?Q?Dg/xevH7Jf68bS1kD9j5uFt4myGwIkw7eV9nGMqt+HRtvmOlY4n5ymHV4ajy?=
 =?us-ascii?Q?E57KE6codS79ipzUNwP52Vmx6rq6NlpdOGeQsrtSa8IlYb169VLZt53j75+/?=
 =?us-ascii?Q?RBXvVbfZFLi3dmcOVsnKerHPJst/kDBxwOdbzff5zm+a/B+YKB+wLksTSQvP?=
 =?us-ascii?Q?cg/FdXHwoyHiGvKOCp5VhPdMfFmuojYGST3P34v3OFOMKIuS/RSQgPNEdpaB?=
 =?us-ascii?Q?f0/bTFdN1Z5zFGEGpp1IM5tQNYwB/kHyB9bCK17UyJk1JTXfwnvhjGWHBbXM?=
 =?us-ascii?Q?nCYEMtTKTwYTiiXUd1fl+7I1k1CrgvnPDq0hzcC2zwJhOURXMkSVsbfx4c1i?=
 =?us-ascii?Q?APPeQ50H0MFRq327/idmM4YNr+xvs6zi+4791l1lx5oCJ9o8kC3YMcZfWVgY?=
 =?us-ascii?Q?8tSCTabvdFB+AGehkUQYCUP/QPgbRINnxrOafQ9C5XPoLl+bh8xWLO0SaLuI?=
 =?us-ascii?Q?70y7iTS/uhNkzcz93X9ML5XxlSviEX5X07regMf0+Og3ri+dXhyMQzsdF2PI?=
 =?us-ascii?Q?hG/g/r23MNXcIz8Zf5M7zvpbFBDWmy/4E9Rr1ZZFAO5ghmlfAWzyeKaHAxAw?=
 =?us-ascii?Q?8SASYVdQj/1JKSDbrrLwHOKK6P+Lrjy4pJG65asUlGx3pJe8T+fYr47C5yYM?=
 =?us-ascii?Q?JdPfdn8EVAemXN2KJe686jMkMre3g3OPk549Sw4uE1ZZETOMDeuXqDQsAR3c?=
 =?us-ascii?Q?E8hORSUBcGHQMSP/fuzXwrmC/nIjEChORDTEWaM0LUCElja5YjN7G+Jq2y75?=
 =?us-ascii?Q?cHwKwHrcIRgiE3BU/bEzSOO5KLqSMPfnFfFHaGjO9JhBbaucobzHmCbwuPsV?=
 =?us-ascii?Q?vQkzj4G6ejo2LOAEeYa4BzPE8YidoMj3ec2sbMW/ya7k4YpRTJblz34xsvAY?=
 =?us-ascii?Q?wWDXup3L9eA6HiKCiMX+FcfnhtvozL8Pv0X4jnjMlq+j3tHqV+tpqt+FTDfx?=
 =?us-ascii?Q?m17tiZaL8xIeRUNkit4aYGISvtFFmkCtUuA34nEHBVytegUD76szlv04TLjT?=
 =?us-ascii?Q?BkCyNbF3f8OvnnaJXR1gji6GrPlzrDKS9UNyCkFIDs8Ywg5wbaL5C06M1Lsa?=
 =?us-ascii?Q?KsdJJP3n5gzRHgRg07GJjqKwrisET9ZSYpULzdMRDigpPKREiIJDyQYfOLwA?=
 =?us-ascii?Q?vKnGGx80BVyt/ouPxLTajyLvhvOmh02p40F1wBW4e9cofNs4Gx5p24K1sHP0?=
 =?us-ascii?Q?jDNq8dxtIUHkv12elJkEdCNu6wExBYNkZSB4afMg9bsAOXrv6u9ZNtkZdsW/?=
 =?us-ascii?Q?NXO45jAV3BpLj9Yxibwo0g3dci6Wf8f7lNr3CQVmz5d/AcY8PYnTf6k1zs3F?=
 =?us-ascii?Q?hq7tjblGbmMYrfz7wt6O11JMlWXvNQneeXba?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:24:30.6242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1b10d9-e85a-41a0-ecda-08dd98a57df8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115
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

The addition of register read-back in VCN v3.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0b19f0ab4480d..9fb0d53805892 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1173,6 +1173,11 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1360,6 +1365,11 @@ static int vcn_v3_0_start(struct amdgpu_vcn_inst *vinst)
 		fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 	}
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1602,6 +1612,11 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1674,6 +1689,11 @@ static int vcn_v3_0_stop(struct amdgpu_vcn_inst *vinst)
 	/* enable VCN power gating */
 	vcn_v3_0_enable_static_power_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_STATUS);
+
 done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
-- 
2.34.1

