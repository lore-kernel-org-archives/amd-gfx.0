Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C64C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C68D10E27F;
	Sun, 30 Jun 2024 14:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WEl/nbkH";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81A310E25C
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoWNBbqIZhm4Rhu/291dg5p5M2JV1rwyDw0fWAqzvr3Sc3UMpusm5A4TMvp65z1ok1Ln2xKXDFcfJnDCW+myg0WzZQvWW/M2t0ZokRrTmYXywQJrQcRRR8Gy6I6pjd30L2F+PLuttDLaE9h7mj6LdLWcD3FLdJfOBeC0k9AicFQ4bHpFjCtWm00T76hfxOucVqtbz5/i5h1fAjQ7nW/MkJzfyyhbijQ1TtLNAB7r1ICeMTr+a7g07fLHpYZrPuiQPuCaBSM668+37cGxZ/clm1JCxlruuEaRQ1jizJ3m4ofh7UUAMA/NO8lNMFccmLGEcyNcDnpQwAhjI8d8EiyA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCN/crjcquFic0x0bFldvNx2lEhlQwJEm+6CGWnSgX0=;
 b=Pl4H/Z8HB/eFbnrthfF3Na+Z3iBXK1flJ3n72pbKhvaJr7bZgmvCa171LlBCb8lIz+gs0eimAJpqjSPiHw0Vfo+fhGtOvVYJ1mU4Bgv3w3B8u9tCbTjyb2MUFmqguqPU4sahj/gtUarVkoSd3JhHrPFswEiAPRUti+81y3P935VW7qesZeNDz1kzxjRT4kkeRVmMqhusIHQCsSCtJMCYUNjAHAc2n5MtsPDMWxbifgc3DHZ7K56pnp5n1P4CNVRqfp+1nze1MsVmReg+e9ft66SWJJrng5dgF/7e7ijzsFGthKC7g6C9yMSTtRNCZ8zWhL2pClgeyPotkG5nivKyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCN/crjcquFic0x0bFldvNx2lEhlQwJEm+6CGWnSgX0=;
 b=WEl/nbkHI4U8lrcuXIExB+S380MRn/4lmokf5xV6dZ0Bhy4mTzrh4zNvj2BPiPYmHMTzw2DjYgxL/Lu6GlmTiSXBnYzDTL7sUXd9mMSAU/+kNni2CMK4qt0PJiTmExc6CVhfDo+5cGekX2bnFFLD5I36UhiiryyugHFfnLbcqys=
Received: from PH7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::28)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:59:28 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::7c) by PH7P222CA0015.outlook.office365.com
 (2603:10b6:510:33a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:59:28 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:59:25 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Li Ma <li.ma@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 4/7] drm/amd/pm: add SMU IP v14.0.4 support
Date: Sun, 30 Jun 2024 22:58:28 +0800
Message-ID: <20240630145831.2023399-4-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630145831.2023399-1-Tim.Huang@amd.com>
References: <20240630145831.2023399-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac3a239-311e-462f-7469-08dc99153d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5lTkf1g/CsjFFaKmWI8hVYGDb3x8+C3khgcAuu841fHZJKUosPQucCAYPsUZ?=
 =?us-ascii?Q?551rEBsYgPCYXV1QLMs0XYgYIHDYtcMtOZ6vHRQK4T5oHk7V6N57g0G4fVHL?=
 =?us-ascii?Q?ZxW3qQl6hZxqBW71M3oVe90BWjgwMh0pgTQyEdLdQSJaGfHLb4EjquSN5nn1?=
 =?us-ascii?Q?R0yaVeDhKY7qQn95gXBqg5y/0hkUAMTN/ecyBhLKHfD0Zka6aMaCEtOiQ0oY?=
 =?us-ascii?Q?hTa+35JPGBgWf4fxQEHdiT6dd5zF65u/c/8B4HipQHpEO4mL7CSXay3cmpYV?=
 =?us-ascii?Q?/7D1v3pCf4VS5n5GJaUL7ijlsLVF7ij2SFUp6SiTKO3RVU71pWM/DHh5jp22?=
 =?us-ascii?Q?2aF+yHF0YpX+WhxTlhuMgrrbH+EscbWJNgsnhEfnRPxE14taLBOBioUuzsKZ?=
 =?us-ascii?Q?UfsemQVFyZZGblBDEpbU/G/CUWwF9XwLi71MxlZuSiJ1HQ9E8/zk6FWEsQbK?=
 =?us-ascii?Q?cVHNZF0sDuOt/owGQcuoR4onU5hxP+W2Z5DAaCXz3BnG4xkw5+HeZVFe9Sa6?=
 =?us-ascii?Q?3sghX3tEAF6SaUYfqre81D1Y7LPWzDfN1E+xbWl8QH3poJWbVvdyXgk2sMhx?=
 =?us-ascii?Q?emI/K7ay15gcQr2MX7SDI0ufVAY+gNgAUUoPWvL4HMjEw/7o+Ctojn6OUYUk?=
 =?us-ascii?Q?9392pyGDrqEmzvGSAebhhJtAFO6pftVtZsV3rSEiscQlDWL6cLjXCGuqxS3n?=
 =?us-ascii?Q?z/LNg9/dnpRLdwj4gMk5f45IPfYwteYHZBare9TlObq+hEZURBnFmowN3mDB?=
 =?us-ascii?Q?Fhe0vWxEkfNAo01tmtL1KqOIj1iJ2C4ks4THJlf+nsz8lSpLNiBTZURaMX+V?=
 =?us-ascii?Q?reY4JdE1KJQM5Q0g8AbE/C/Rfutgudy7gKLf38hV/P2VDNrccH0LJKOsNehn?=
 =?us-ascii?Q?hEHlytdzY5Z4Y8VVLOMmIPY4Lz4FRjYNTPwC5PRYry9bljX6OwbpDybc+WeI?=
 =?us-ascii?Q?TfgEfcJUqxXvTc0WHx0OQN0ZDP1rprh0aKPFjjcZESgGu68WlPEluaJMGtee?=
 =?us-ascii?Q?0i9DngEq4pAhTgI2rmas4UfxC/9+wT6C+2nqa+8h22WLqmaEhoDl+DxsEs4b?=
 =?us-ascii?Q?JniK8rWZBCYSNvFP5nOytrj9pZz98EqP8fiGEddnxdXDC14niLCS8GLPdQqv?=
 =?us-ascii?Q?ZBRKu8l5F72lpcZaOhqFxGzMkAyseFwrEWVZ8su/bqkS89T0+l1/K1L9iQ6B?=
 =?us-ascii?Q?Spaj2BDPCV+B0pW4Q/zOdH6L6pxsAuUj4ekbO49Pu7T1JLkOqzmbt5YuRue3?=
 =?us-ascii?Q?E/HSL1/jfBpK9xS2l5qc1LjEKiuN56dNeA/e00zbpRIbOVRASQCuAT8OVxWl?=
 =?us-ascii?Q?Wsgl7metDcq+4DD/XV2jju1dnO669Jz7pPUMR80UAHYSFxL41CwnQ+Ivg35o?=
 =?us-ascii?Q?GoNjYCb1AD4u5i09PvQbhjxYJwcREim8y+XbQcIkUu1gtMg70KcnEgr28FJv?=
 =?us-ascii?Q?VbnehlGL4KDE77+OCJP6ScRJ49aM6zXF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:59:28.2192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac3a239-311e-462f-7469-08dc99153d70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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

This patch is to add SMU 14.0.4 support.

Signed-off-by: Li Ma <li.ma@amd.com>
Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 00384b381289..d79bdb1e8cdf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -727,6 +727,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
+	case IP_VERSION(14, 0, 4):
 		smu_v14_0_0_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(14, 0, 2):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 095ee7e2c4bb..09973615f210 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -243,6 +243,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 4):
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
 		break;
 	case IP_VERSION(14, 0, 1):
@@ -757,6 +758,7 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 3):
+	case IP_VERSION(14, 0, 4):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.43.0

