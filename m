Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB9BC3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 14:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B6210E3F7;
	Mon, 15 Jul 2024 14:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XLOylK2D";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657A110E3F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 14:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFHJsT7hiJAAjEEmgvrhuiS4Iu9t7ufJdSLYPSKoXrbfVZurVvDM9oilhBQs8KWSTM6wECvRk4YDR/Y+M8TNOGAEmsyVgWkOychmxrLwwMBtaRZJoz1k2eEwzeSiVMky37Ar/fGEv+tSwAfxZMSGGu6gFDqTV/MBy9zQtpQLiaZa1jb83chdb07LR59cYZuJN1GMwLxDjv/dvkNN/vLd3y4xHINpN5oWXzQ8UTJQlASnJKrK+EsoGNw7z+6MnROmCeBKfapiqbh/ySqPRfSJSdl7bx0m633gR47RQTMFp+O4bpj3Yz953Izdr+5Mz4JInYhV2vZvrNLcdje9kmFeOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0t2TJQpoQ2dD3NanAoKYbBST/dNTkGtFO+O67JKNRg=;
 b=lJQnjtVfZzCER9R7L0djLA+CrJXNI2c91sw/g5lcBI6cPHR95nuG0Ump8ega8AO/VIt27ka86IS6fP0s5PZj01s2cC6YaAWZ1/YOhSnWOwJ2HhKCLvbNDzFv6kcNh86007VGYpk9LrY0PjUuboXTksuax+VOM3mxXmRtAFYRjzNYe94pxJB9LXLin4l2NtTCB96moLxq98OH1UR3Ip1XB0SoA5xNyApNcRZ3PsOzKxtZSinrntgmovDLv78OEKFTACRdqfMfkH6U42ZSNnLV271Ax2uX1+zyvL8ePRvccdLc6+e5SLy2P3L2jqfzRwX9cPmXSb+yasGg4FyH+tkShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0t2TJQpoQ2dD3NanAoKYbBST/dNTkGtFO+O67JKNRg=;
 b=XLOylK2Df/WfZyg71m/zW6P3++A5xpZk6lUerS4CCFjoEpdWOSWzeS9+Z0kvN2ZG0uI/R0YqgXm+eSjhQ2PYelij6PighbTV3S6wLMr0h408LBdoxYMqsZADiA95a9xKJ242a9O2a5ehk2Ab1okwH0pLefG48BbtAZuSSM0+khE=
Received: from BN8PR16CA0011.namprd16.prod.outlook.com (2603:10b6:408:4c::24)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:48:22 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:4c:cafe::1e) by BN8PR16CA0011.outlook.office365.com
 (2603:10b6:408:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 14:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 14:48:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 09:48:21 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 15 Jul 2024 09:48:15 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>, "Jane
 Jian" <Jane.Jian@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add empty HDP flush function to VCN v4.0.3
Date: Mon, 15 Jul 2024 22:48:14 +0800
Message-ID: <20240715144814.168577-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba00939-2483-42d7-0574-08dca4dd2cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7eiLa0jjS7ar+rwgkJtUFrtEcYIDonINYeTFy1tLOkT4HlM+8R6E8dSaU0p3?=
 =?us-ascii?Q?9H0Bbcr/yaQ7WHWwE71zMiVNybyNvtFFHtpmz8NC81hp6/A0YoJWSGmfkduq?=
 =?us-ascii?Q?s4cJzYWhFZe3ew38SS2ciT+oIp+kKaxjdzJjzHm20j99F+Qp2fI+Yterrowi?=
 =?us-ascii?Q?CR/1Qrf8/NyALOaE1VqZ/QpXgffWP0nFxDLgfGbsDksnlMwGEnuRM9CTv/X7?=
 =?us-ascii?Q?dUy+VUBfKPDPsV++aH4W0aEczjMYKLSSQpwVa6JeFBKB6r/DANK5wSKN/gFE?=
 =?us-ascii?Q?8kCMues8v4KRwShcgcVD5ElnOK0r4eME9ZjC5aeyBTzwdNeuGK+lXidCSQO6?=
 =?us-ascii?Q?QelCa02vUcU1xDtZ8o5OID7GR+uzJE4BNECvwL4HcSWk8mtDOESOrbXv53PB?=
 =?us-ascii?Q?xbwlSfRl3zaY81Z2GcrMdjmhab+J6b9bD8gOwaDS7jLa/AeHBFQxdp0Hw54f?=
 =?us-ascii?Q?iEYpE3/cJ6TtHZ6wlKs6lOnPe4VoUfvBTZGP8MtGsVOabNPjerf9U2x2WOCi?=
 =?us-ascii?Q?q8KAxgmA9y6D4cYsmsWoJ1vVCXWzfOG60jbWpIovLOvFWlEapjHmeUBj7n94?=
 =?us-ascii?Q?JfPZWXfC44EWemcLqsH9xk/VYOHYNQA22vHtoAm0oUAJfEyA9LPpbJWNb7xq?=
 =?us-ascii?Q?3fLXdQvF2Vj8ay0AdN5fEez6rTdgeu6UADALSuMAhQyId/WZbNKeQTzIzRcI?=
 =?us-ascii?Q?DDRKGilQsK9AMy7NxwugLLQVqxYnSknFjHZBpA1PKe3bMV1nvzDVHN/7N9jo?=
 =?us-ascii?Q?TANkc0vRH5utDhdLXJoW26yE2lr+/+yVlibmiWlCmljqxWjSOiTGzB6vrZN3?=
 =?us-ascii?Q?BuK6mb/X1MqX2G3BoubN+laY5sqkusTeHsRittN6NSjhcEBZtYIqFZYclHdy?=
 =?us-ascii?Q?LCmSbUNj/zwfcS9nO0C/pIHAV45D4cnIzHNIIV2NqA696sY2FJwhVJnNkKTA?=
 =?us-ascii?Q?BMQ32FRgLwrbC3K7MbAd21mUz6BHtPFEW+HH9s2KBtHxKa5oFO14iqteoTYQ?=
 =?us-ascii?Q?0HTy6dEtuc4//qtVYy70NYyGy3Igxg1vWtMN93YlIhnIPB8NKxigQCFN22MQ?=
 =?us-ascii?Q?rxoUxZRKyI8G9nDM0N07BiEjHk1LUhUIFgFcZHG1dedAo70KpYW6tiNPTe88?=
 =?us-ascii?Q?d0JePWd8rSxCKpQNwhdC2UWR51gxBMhKd/A6PC9OAwLkQ4lWw+C5s3yJyoe9?=
 =?us-ascii?Q?N/F8iaWzEa/x0Vus+QlNytfk2+CUkR3iIzDl2ChbwSWV700UYMe8ZQGgmjuB?=
 =?us-ascii?Q?bCSjfEWzlzDWWyYJ9eiw/19GYOwpHUk/0omTwKrBdQA2Zp/aCx3CQeKsytjF?=
 =?us-ascii?Q?FHOO1uWMBvYnng8FRupWS/9Lws2cTeG4/syoCda2Cyek/znz9KHspQvIBngl?=
 =?us-ascii?Q?KqPs9TKdUEdnBXkQHJyr2W2S1JXt3+gC/Ch5V0ygxUOAsyYVCLSHNE4wSG/A?=
 =?us-ascii?Q?++iYEdExlefyGCKlp1aDVN+qriTB3VUr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:48:22.4561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba00939-2483-42d7-0574-08dca4dd2cc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971
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

From: Lijo Lazar <lijo.lazar@amd.com>

VCN 4.0.3 cannot trigger HDP flush with RRMT enabled. Instead, mmsch
will do the HDP flush.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index f53054e39ebb..85d849680993 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1375,6 +1375,14 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 				    regUVD_RB_WPTR);
 }
 
+static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+{
+	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
+	 * This is a workaround to avoid any HDP flush through VCN ring. Instead
+	 * HDP flush will be done by mmsch.
+	 */
+}
+
 /**
  * vcn_v4_0_3_unified_ring_set_wptr - set enc write pointer
  *
@@ -1415,6 +1423,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
 	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
 	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_vcn_enc_ring_test_ring,
 	.test_ib = amdgpu_vcn_unified_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
-- 
2.34.1

