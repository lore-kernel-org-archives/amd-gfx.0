Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E008BC54EDA
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C907210E705;
	Wed, 21 May 2025 20:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZHjpYGdw";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F3F10E705
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj1ipodxJPyX75U0D3+cK2fCNTHo1QW+ddtqngcYPotQD4cpgax7LDOJlLz+BoyN/ygr2sYaNEVfmHKgEL/RC7/4/ULe0WB+PpYDPVIw+wWZkPBadXobynjOCgEMQWjWtyK40KzFWnXUsrW2GVTFFQ07xBLlboeJtlgrz4CbF8N7dlkofl9XwxlKyV2oPlj/xq3oWeOMruxVbShJQUkOov8+Nkm2abLQuQxc8pqLjxffNxmO9bcxb3iGHv2Hpm2+R+BNCJkUObSqUAo/QXfA0vU1jozeBK68FzSlfYmjfWu5LJYbjIFNQd7k03P7rRIE0gP0Lb4Y1g7bBRDsl7EaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kix89P6z+/wcVVWvAJGAy9pDIB5KG33GxMg7QrsYkU=;
 b=msZsZRKBadqjLFiW7D/pPeKhWL9tsCptObcv0jbdrfyS3zJhVpRHHSf9Mj/jNDGG45wz+MK3XM6WU4t+XWzZRR57VTyc7aVwk9oY3dZee+S5eG8UDiUz+r+vc3vqu8LDn2E0HcbvVeTuD/8O6DeQIi4EfsP6XARxZjqc/947kq4TeaErGQWu6NzxTvFjFcaTk7eykPbJQp4V3j8LrQQwa5kGDHT3kZLLVQZF3+oAVjzGxk+pezAjiffe5268d0k1Z310KoUA5FyRBCi/GqQZRaqIgfzTAlJNwFO5VeAsbv/DejcXM+vHVYf4Aya5FAOnyGHzA8COE2hmWRtnDFwzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kix89P6z+/wcVVWvAJGAy9pDIB5KG33GxMg7QrsYkU=;
 b=ZHjpYGdw4VP+wxtV9Z0Xc1AnWJ4HE6No38GnJ7Fmt4cqXIyrlZg6z8Dxb4pJqKsf5272YnAXZmFj3qtfiIadBDTE25RVWnbk+wOD5Lwokx8iPzjhAX7uU62w+jUhSCjTnZwWHhfGg+B8zo9n2GuD7iXxE5ly5kopwbrF6wNv6yQ=
Received: from SA9PR03CA0009.namprd03.prod.outlook.com (2603:10b6:806:20::14)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 21 May
 2025 20:24:28 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::a0) by SA9PR03CA0009.outlook.office365.com
 (2603:10b6:806:20::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 20:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:24:27 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 May 2025 15:24:26 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v3 1/9] drm/amdgpu: read back register after written
Date: Wed, 21 May 2025 16:24:06 -0400
Message-ID: <20250521202414.18251-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd0c92a-0f1d-4039-5674-08dd98a57c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fk05KPjJNOKnHGtrJlJ3NZar8s6wktjcaOAXyt2Mlqeh4Pt7TItpxQ0R+TEz?=
 =?us-ascii?Q?0UYQTuBJXYKdF3XpkwJMrf+mJ+aP3L0CtwJeRzZUl7NRMRz02BwX2Da7U/Sa?=
 =?us-ascii?Q?AeJWVsI18EPRZVvghDCd2aU/UVDvzZ297/Dpqv6u2N7TfNA4iAryInH9iHEZ?=
 =?us-ascii?Q?tyzbzcB1SnfGVCB+cebod7U10EjEUrnbhUe6quNNQlM6/f2CJMPY10iFCveJ?=
 =?us-ascii?Q?9Kj+osG2qVWrcnGzivDeXu7Vg+6IsOLCeQl8Bkw/begvWzOARmpP8uWrGIHm?=
 =?us-ascii?Q?6enYcI49aH72gyyIoL7ZCg0dwitGjYm7OB1DIVBguEcY0boL3v1ICxOILAAM?=
 =?us-ascii?Q?9sxTSsPxtpNZtRO0ViUWszWo2iiO49ynUGD57Q9/zwWdOwOiLSITcZTf/lZa?=
 =?us-ascii?Q?OxHkeoF4tG1FnwRjydvvRZvUZzG9AV9OEpR28PmMeNnolC7D1/WsgPv611n1?=
 =?us-ascii?Q?U4YrxZOgMgoJWxgl+w2TYcN/sb/Qbp4l5pFAFGuN5TwBNEO2dxr3MU4GqNDc?=
 =?us-ascii?Q?07hmmRlkiteRd4WXOY9Wth5eb8dzOoFpAJBRfM+B01/ttQ+Q1FFYXUaW7RGE?=
 =?us-ascii?Q?i1/P38eBGkgPjUDsjIR3XzmKhwQ73OT+qZklBElU5BJukryAnRYa7FzfFLAb?=
 =?us-ascii?Q?chu/vCRFU3/i6MkRAqiMi2Csl2lXj4li8lETYOxycFTUJ3zc69ZA/94KYKo0?=
 =?us-ascii?Q?YJONRAXT8VMjpHkODCMMMWH5m6nLd36Q5CR42JmX6pnJrHe7MdfMSUaEwfYc?=
 =?us-ascii?Q?1Tup3GggopmouUN8ntdLqm0V14KMgPAtfVDBulIp0RQsKmtqYozyYRv+9MSc?=
 =?us-ascii?Q?sD8FB8wpcADUthFsMgd8Qlxt1hcYq6gKoGvDyMxaerub4Orj60pEmb2Mp1aA?=
 =?us-ascii?Q?p8ggQqy+1ab/KpVl8vM6gKlg31rH1z8peWjyCDyB32fJhEDhgfNIsdO4hYot?=
 =?us-ascii?Q?8vS/AIVJ0rokBUC/h1SQ/dNpk80Nh4xU03Bu3cJQAPDJli3Z43f/Foy8aDld?=
 =?us-ascii?Q?NEJn/aSubgKZ5EcJezfJnZLYm9qfYWORl69Bm4b89lzKvQdBa+lDw9Q55a5y?=
 =?us-ascii?Q?car+9gcXsOVxwvvx2voxrzLgy9RhlrpxovWuRDijuxJrWCpxKJqMR0ubqi5t?=
 =?us-ascii?Q?K+ZXOmfOVfsVGvC+n5niW0Cv3Y9+Iv6irYOOey4J+3E1NUmqjIeWg1qGmLU4?=
 =?us-ascii?Q?+CXpZsil/PPWJnB7LQhuxZyE1kz9a4NixHKDSXS3CBaVCWP+8L0XixKhMeKS?=
 =?us-ascii?Q?j6sj/v9qNFvU0suPRcnu9PU5Z9baujDjsu2Fo/2/430X9L+JG8dw3daTB2lX?=
 =?us-ascii?Q?eSFPPUUm7GVliBAz8kQvrZ13BWPtXSd/SS/5Hko/73/3pbzklpCy8gXzVI2C?=
 =?us-ascii?Q?7+aCPu8TEPvTJ9BbbC7IpPV1HCeHF53hXj+xc6NXqzCmx4/CBqRQ7bUDVaST?=
 =?us-ascii?Q?h0607VzT5M4eXSwZgft/B137rC5Xm+O4XUKpE8HXi+SHxg+2Y0oS6ZzvFV+u?=
 =?us-ascii?Q?23r7xuHIoyuvwYsIcFy5S/OmSq2QxNqBfEP0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:24:27.7231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd0c92a-0f1d-4039-5674-08dd98a57c3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
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

V3: drop changes where readbacks have implemented. This patch set
    is to add readbacks only. 

V2: use common register UVD_STATUS for readback (standard PCI MMIO
    behavior, i.e. readback post all writes to let the writes hit
    the hardware)
    add read-back in ..._stop() for more coverage.

Similar to the changes made for VCN v4.0.5 where readback to post the
writes to avoid race with the doorbell, the addition of register
readback support in other VCN versions is intended to prevent potential
race conditions, even though such issues have not been observed yet.
This change ensures consistency across different VCN variants and helps
avoid similar issues. The overhead introduced is negligible.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 21b57c29bf7d7..c74947705d778 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1009,6 +1009,11 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)
 
 	jpeg_v1_0_start(adev, 0);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1154,6 +1159,11 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst)
 
 	jpeg_v1_0_start(adev, 1);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1216,6 +1226,12 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_vcn_inst *vinst)
 
 	vcn_v1_0_enable_clock_gating(vinst);
 	vcn_1_0_enable_static_power_gating(vinst);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1250,6 +1266,11 @@ static int vcn_v1_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS), 0,
 			~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
+
 	return 0;
 }
 
-- 
2.34.1

