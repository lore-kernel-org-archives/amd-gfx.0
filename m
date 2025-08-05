Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BB6C87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 12:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCFEC10E269;
	Tue,  5 Aug 2025 12:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xLgMPGZZ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42DE10E269
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 12:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKQhVB2/cBwbht786znK258bbxKbgVJi5e2/Ty7NNufDuWue1V5AyQxlRvPSPUE5s+sYZBZe47/UIq5BTxqhIRPEd6aTNDkOr4HDwNHHHDLvq/YaKWAd9VMVKgrNsU34ad9JVyEaqMhjhl1l0d+6uO14oz6dUJfMPzqG8TAnSCyEn/blxP+qlaohqAnwuafk4W+cxFgJaJv0oBI7BAnjtLRqG9S2FdR7bknF03UbWDXsp215eawQU414tEP3RahtmwFx+gLZHeZOiObbbG2ezTMhTRXLceOAYzdm8oef7UTAbSjkmEjXPAsVdt8I8IKHS9rxTG89U4neRwu2co3f4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdPI6xd55mUpM662iAi8YobT7HpSf861Uk+2dKdORQw=;
 b=u8LCTol9EU5ZqI6/wHsXx2X+IwIAmEgdSQXYOBsKuk52gEYGcrc2El+AJgd3vU7xGBjDhXIgIr0gdvVT2QGWo4K/idhEcmioLDVVi7Yasdr6TEn6NMQhB8u2/FSV0WFg0rIhc8j9yHP5debhWZ95YajK0oyfFMykDnjI/Sp/wotxHekii4z4hK8uMChWwWqfftxCICwNRaH+hNhlxlNeRjD1m1Hg+eylSrJUddlEri90r5zsOs4gBS9EDBAzGtgnTyWXPcde/z0UmIvPY9mPLh6x3SBYNgIMNhaehy3gKHyIYWO4eAoGH2tGHiVsvbO//tAO4bCAeTEhFYvjj7QUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdPI6xd55mUpM662iAi8YobT7HpSf861Uk+2dKdORQw=;
 b=xLgMPGZZxBwh5NsDRzAWVPcZIHdUBVHkTqqUgKoGs7AIR4S1I8eISTKxFXyozQbU6S2Qo3zINOr8apkAQ0aFT2ZlrXDe0OxGICYZM3t70JqgjPSXXlRou5DYeSyt9Z88sm2NCB+FRYo4g5oDfdHvsVrjSozOsbBtuzJS8QbfJbU=
Received: from BL1PR13CA0266.namprd13.prod.outlook.com (2603:10b6:208:2ba::31)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 12:25:31 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::46) by BL1PR13CA0266.outlook.office365.com
 (2603:10b6:208:2ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Tue,
 5 Aug 2025 12:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 12:25:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 07:25:28 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: Fix double-free of vcn dump buffer
Date: Tue, 5 Aug 2025 17:55:13 +0530
Message-ID: <20250805122513.1769120-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf29ab5-53ba-464d-063f-08ddd41b2af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/IC8w87b6FLDOrRn+eGsWH3Sggi+1OmpmBzK0iqmqzSbnvvs+BoTqQvNW8RO?=
 =?us-ascii?Q?BgT7tSFjYOtNrJcrkNx/q4X8srPU0iHkb40BBz/jkgPXjTmmhWO1/yRze9Cg?=
 =?us-ascii?Q?bp6j7UedKPIPkrmutDPbwN/aarj1Ry/w2MttkL3WVH9tU67RXVVsa1SM4UCh?=
 =?us-ascii?Q?JRkQu3/vEh+8dLl9Nc2q27pPL1Agxs8fSPJgRQU/OQY74oAlU+nRRvxbOGTl?=
 =?us-ascii?Q?6O9JxJRexUqSUDAGT4ENxOSZ12JBibNN7KEZZH1OdoON3Dm2N5fbnTQ2aMaT?=
 =?us-ascii?Q?vXXNTftwqkceUsP+XiLhegUY3vQasT4OdfC154+XC8k8ekwrtTSRSJ+dV+0D?=
 =?us-ascii?Q?jSLAgD+DUGIbo9sWf3kMTKgb4veRxpi35ue//+GOrUfPm8CUVq0V+F6qIVdh?=
 =?us-ascii?Q?EG1a//IyVqzoIqAWthskcvz6jtb0zWaZ7pRBkU7iAI1ZPmrgOkDpHd2BHWzx?=
 =?us-ascii?Q?aBidi18HP8cbdTtqe+XFkLqtIum83nyuF8ixDN/sCHA0mjOt1WX5FU77aQRY?=
 =?us-ascii?Q?OPPs7aFnKeOgqTKf6+47CsHobUhlDsRdb9GiKT8+qgcIuw3j80l13kDimXTI?=
 =?us-ascii?Q?skkQRB5E9Qb1pW2J9Ix0SX8jwyAZ3DT2pkIfG+Yum+OKI/8bv/nh5+HYwbzY?=
 =?us-ascii?Q?CraAh8l1L/VOE5cIYxjteLE09YMDRjofjloLm2gD0RGYLF76rM/H7A6vKVei?=
 =?us-ascii?Q?G2DuUvrH1iUBDQ2sDeoOfBurbKs4lQoy7QlSsljpQ/mxnWKEc4vM8KsLgw7l?=
 =?us-ascii?Q?JpwuMw2fsr5QMHLRsUieTOBIIao66VVT1PZKtKWeWN94zxwYvvIjrkDhWSFs?=
 =?us-ascii?Q?E+YDXY6y86uttNAucnGu27g9Xv2XVqVQu7zYkBP0yoWlNpq9WHqBjkf82qLv?=
 =?us-ascii?Q?C5/ddIfhyF1jUlRTFgmB7lnux23Cly1xx5zi5Bp2kJ+55yBc9uz+zhdV/IWK?=
 =?us-ascii?Q?vY0B6QabcaykbtT9PKydIttJFCPK64oEz2zBWbBapv0e2BjDecam26l3tJpH?=
 =?us-ascii?Q?Nf9t4sxo/UOKenKDlpZ1ggZCSE2tp3PgEbqGse2+pVrpAPPkhvR3P8Vxnkm4?=
 =?us-ascii?Q?Rbe+1PKiIs2apduenN1+KCdL0BvYPiBtdvGb7RKEubV/DY/A2yzRR4C/s99J?=
 =?us-ascii?Q?CnLAGcyBUqyOIK082Kk0HcaF1TMNyvNjqgWsB7JS6IYHNt9UhC1groGnadlw?=
 =?us-ascii?Q?4u59vvFZ/dt605WywT6Jtu7+2I+sW5WrekhPDFGppbtIwjTk4u9Qrd5N/5YC?=
 =?us-ascii?Q?P/hlCeGBXClJVUHIb8XoQUFvDwmQ3LzdwX8s2P/l5NVlXZcD5c0rzekDqNQ1?=
 =?us-ascii?Q?ghaq3iCeZCdZ7YjGhwaAfoXsljDmb/MkHwQ4XtRw0DTniXsJaqBOD0ysEW7O?=
 =?us-ascii?Q?e80gKw/BDv9TONpVuA1pmnAMNttw1RIChsnN/R+59wTVnikcsIEaVgX1l+Ks?=
 =?us-ascii?Q?H+TFSW9oucz00D9EyRYep3sO4WvkkhdDDqhLvbO+z9sqf8potxPkGMHTSmRV?=
 =?us-ascii?Q?Y79d+fn3xZic2n3H/pFA1PQjY8nE7gS3TCiM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 12:25:30.5893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf29ab5-53ba-464d-063f-08ddd41b2af4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
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

The buffer is already freed as part of amdgpu_vcn_reg_dump_fini(). The
issue is introduced by below patch series.

Fixes: 699853ae00ca ("drm/amdgpu/vcn: Add regdump helper functions")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 --
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 --
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index b497a6714138..050a5411aae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1549,6 +1549,7 @@ int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
 static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev)
 {
 	kfree(adev->vcn.ip_dump);
+	adev->vcn.ip_dump = NULL;
 	adev->vcn.reg_list = NULL;
 	adev->vcn.reg_count = 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index ff2a85619f23..95173156f956 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -354,7 +354,6 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	kfree(adev->vcn.ip_dump);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index c6450ed65c12..019bd362edb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -280,8 +280,6 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	kfree(adev->vcn.ip_dump);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f785467370d9..75c884a8f556 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -275,8 +275,6 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	kfree(adev->vcn.ip_dump);
-
 	return 0;
 }
 
-- 
2.49.0

