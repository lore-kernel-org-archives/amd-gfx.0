Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCD8C3ABC9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 16:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9D710E90B;
	Thu, 15 May 2025 16:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CA4pg5yx";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E52210E90B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 16:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqW8QX8bpTy0XU4D72SQlFuGN3fY2hm3qKSdr0VDas9swih112+OrDTWKiJdc8MQYqRyoYSaFxhf6UuHEURN8asmy/1YGJzMEMW9yIMkCsWWXOupK6klzuj15H0FOCRJGChb7TCsskCRS5XYwgsvGAjzI4/oeDV4EzvzvrQcBzBli83NSMGpkLdzeTtoMbPEDSVyPBmsDC+l3PlBom7vwifmTiGnmk9IWymDMGVUwyVgjamZS2EGu5zMMESbt7DjcC+jHRKnyq4cYw4S3b2Wzpw94/2dkFK8MdxtuaHApMvpUOg/Fjo4w2jSEmF6GN58f3PotizY88EOE/4YTE0CCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59Xd6UURiVs0oN9x6ODPDMcXMYCRDzkrpnUsKYpKVO0=;
 b=RPZnk16FfdNEFAGT8w8oqRzEYGLLCNnIF32jCeBmFFcw2NM7mLEeCnKHt72HHZ0dSkL6HD2bWZP2dAwsRr5ODcQDPsTRHNkVetNVnpBWGTQHE/Kx1CibLsDiXic8zGHOrnEuO3B11Hu5Juv1zjxb8xRCtCIM8uQchtEjzIAF7KlebpT79zeN5XhDzFBcMuZx4kyRuJKlpeHsmex727L0V2sSD2EAZtb4/4V7oK5I1ni74Xc8RfjOUWOHWNCl0Jggaha66j2sK0Zw7EhPzjggbx6Aeh9BDEzeKg8uKNCU+HBmMKXbf/MEatZfh/lh5QvjpI0KUOCgqFoRr9X1yoFvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59Xd6UURiVs0oN9x6ODPDMcXMYCRDzkrpnUsKYpKVO0=;
 b=CA4pg5yxIvuScRKRj2XFHwphlJVMP4NywMLYvhuWCVDuioSL2D0xPmYFlaRV5cSrnjrqsR15tNitJc9nJlK491W4ciAZNTrl/Wofm+Ui0gKO1DwSuUy+NH/7tufgRPv2GFXgLZnHY44HKepgHEafvT9AWHMsWjPK0Bs0Z08+nLc=
Received: from MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 16:41:17 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::f8) by MN2PR07CA0029.outlook.office365.com
 (2603:10b6:208:1a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.18 via Frontend Transport; Thu,
 15 May 2025 16:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:41:17 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 May 2025 11:41:16 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v2 1/9] drm/amdgpu: read back register after written
Date: Thu, 15 May 2025 12:40:54 -0400
Message-ID: <20250515164102.808954-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bd27f9-874c-4e26-0b24-08dd93cf504c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?55ec7mqU/3Bi0aDInVMp4FvDSeousAPxJAOHSPrZuvklxbzC+xscDzJOfVC8?=
 =?us-ascii?Q?OsVBgKlPuzPW43UjdQrhqcyD/zwXPYYNQUnXBB9taSj+nlhmoVhwdJMLrTXX?=
 =?us-ascii?Q?ghxTnI5/6GQLaknVJwXkpjUxOatYjNxd97KXcsFWuhREw0WNBX0BizMTjI58?=
 =?us-ascii?Q?7IpitDIZm5MMx9zRGKcbsFFRs5dL5s/i4pqzWmYIrpwhDivU4Ttzd1eOablU?=
 =?us-ascii?Q?lFtJ1U1leZTSJIEjou6ZjhQMzhnxxkyZhIsADPSG4xDKHDgVsaANVmCEGlXI?=
 =?us-ascii?Q?/DAOe+bWcSO6Rd/1iUowA9LVIzPWLvRvcOOQNE6ENR4jbNnw19zBiwfiVdcm?=
 =?us-ascii?Q?UgUPRuC+zIjmhyaz3+C+1alIJpaj5+7Mf3wUdqDxHxqQ3Z3QoUlGlYlTz4oE?=
 =?us-ascii?Q?UByxgjnPGqaelTC0QdH7oEtgbqPziBE/opNMTdCyI+++BIDuQv29Uix+nv9g?=
 =?us-ascii?Q?hwtUJNLdanAZ9FkZ3GTuSGP6cSX8Tqt5iEVdC5y0UBA1SLrRLyLQlay9809b?=
 =?us-ascii?Q?1huAI3uDF4QWzMRrSHVBUyW1QMEQlw9V9ephKSr4KKMnn9pXkrVOph8FKw/g?=
 =?us-ascii?Q?SVgi26cE0dvPioelUMoYyncXZu6TWxapy1k63c+C3REj+3kxc+qIDQRezONv?=
 =?us-ascii?Q?7zErQtnJLbhBhZ/DbHCBgGdD7j5mPgb544dnAofQLi6ziKB3QH+Y8hS9C20V?=
 =?us-ascii?Q?9tLZb2iOp/duf+RvsRVxL9nyiP02OdWHbf2h/JWGs6ik4VW592/nJOPf3aGK?=
 =?us-ascii?Q?8oy+ErkpQ5S0riIJGYPhVQnH5sdN8URybknHeIqgBUGmcuDUv1i1nW4tX0xa?=
 =?us-ascii?Q?cgZs4ov98kUICedg8RkPRDWXvQjMFQwrbwqXSCWYy1aYsHRZR/KJT/0whoLK?=
 =?us-ascii?Q?svX3ZQaIUKqaRd2qA1iRAfIduXKuOmMamA/RgIJIrDK/oaPVG14r2Sasr2yj?=
 =?us-ascii?Q?yR6PU9jU49i4DKeGR72P1223wjJUwpMpeWgK8L2TUdvb3PSmexHlkCySTjJI?=
 =?us-ascii?Q?wQeFuwedok2wAsDNRwSCmvbVhZ6uSBdpVoghAK9tL4+sdDSsyyeuhhjAALOP?=
 =?us-ascii?Q?UeiiwsL08M4dAceHqZsuCJxoHuZ6yvpBqUVeZN7+huumOhE9TsEDdr+9nz5x?=
 =?us-ascii?Q?z7gUX5x2G3IVt2DxKOEBRnzTh9tSJl0LvlDPdwWdMkJoIG6frDlauF/+NSY9?=
 =?us-ascii?Q?eRcbh1OdWAvHCIUaQm0+KCr4R69FmFLRHOwvBw1TxgnQBTg799uPDpJTxlVx?=
 =?us-ascii?Q?OO2UzrY64YeBmeJIQ+xik31N3yAk6yqd3INYnJcdDOAR/KZpoPZyOZgLs+01?=
 =?us-ascii?Q?fIUs4920+DG/bZNISMnVtk4N8BMmqkt1Y3xjwIHrSS7gaJUeEQs+RmJQ8iBr?=
 =?us-ascii?Q?eMTPHWk0i+RCuZ8rN4YIL9d0YCqz8Mn+dkk5GNk7h5P1vV8dcu15qDDnw/5V?=
 =?us-ascii?Q?XtXNzb8oJnfNXZlMoK2+p+AwMpu7rH2eMT2x9EvHrSDkCh9cxqjg9cRu0Rej?=
 =?us-ascii?Q?2K+C3eqUSGTL2MS+ADEQD5rbM0T3GU3/h88T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:41:17.0730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bd27f9-874c-4e26-0b24-08dd93cf504c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
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
index 21b57c29bf7d..c74947705d77 100644
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
2.49.0

