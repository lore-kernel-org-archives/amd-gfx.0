Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93022C25B5F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C39A112CBA;
	Mon, 29 Apr 2024 14:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="at9qOFS9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3015D112CB0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuhFlMx7q3YtG3KUlaBEMEQQl+mVpZ7TtWuh46owHx+mXe8MaldbW1tIH725ApEtuO+GhXyn+Rgzebv5UaTUcp/j/wBluVTB+vAinj2sKB850JCCLfdFSROHMNDKRkmB7aZCfEbAKVFagpXQfCv83oemXnZJz5pPNUaQWKyG+rACUSg3LdN5shNztv0MhXHbWkJZpNh4i3jWUa5rm3Yh9apOcBblmbbKePL0OJ/g+qk9Rf3o0r11g19pNyqsE18pUJrHPeLp58kwfFCWqwo/f71yMq3H7zIikfNuX06j8o5w5ssM8O86VWDGEScKd2HP5g2zw9aCgOfCFT3XWPdV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BVllADd9mciqCOubXTJKmV6c8EDlbpyZrJTgVvj4oY=;
 b=mmhDsG/yIia8SZlWaJ52f8sDn8ViH2oIyz7NMwj2tb4JLQIe27Db7aORhTLA/YtVlL0T2ytU7yJ7BA6sx5xgToqSoqPPzlwT7KEpDqe/mFKA43m64ZAiL992C7SHNEmXPifry+J9MFMoN8Ewy4wiw8w6/vc1mCPjmrxF6npL3r9cWKyAonP9ZtasR1V2wxxbqgTtbInZ5GxV6/OSx9nj8B7ezbhuPwwSFk3rOnTbbNxhDLOV5OIQc9AQ8PgcnbMWLBY8jHwmrnUiQhj0fNBYWJ5WUHgrW9mTc9UaVrz54WUesr2IBtZwlWdYtrxs4wUqfwxT5zZthk5Qc/8NcN0dog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BVllADd9mciqCOubXTJKmV6c8EDlbpyZrJTgVvj4oY=;
 b=at9qOFS9LO7m4kGut/0eY1ygUqdPXLmUHzR8HpP4IXLjh/3fLUrQ2T7NExo0V0FboO4sbOjbBSTaDAkjEws2fnpoo/jaTdOUaUoneAQIOQiGScPmeOBT4rQxR/JyGte6aAy+SDmQnJsW3kk7rW7Z/w3gJOkgHacLlygV6IOkPoo=
Received: from BY5PR20CA0006.namprd20.prod.outlook.com (2603:10b6:a03:1f4::19)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:21 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::1a) by BY5PR20CA0006.outlook.office365.com
 (2603:10b6:a03:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 21/31] drm/amd/amdgpu: workaround for the imu fw loading
Date: Mon, 29 Apr 2024 10:33:29 -0400
Message-ID: <20240429143339.3450256-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 723edbdf-e58d-4a99-55ab-08dc685975a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YsNY1G2lYc1/cRF3lPNmfceKq2TFIqvxcgNFVR7pSKKgv/kkF5Tq+MrpvpHN?=
 =?us-ascii?Q?9ZUjKprUG86ObXVQ4dDpXeuNhEZjlJIWwb/cg28A0ScYyLV7cUG9rHnmwkCP?=
 =?us-ascii?Q?/jYPXMwzW5zLRjh3Lo166j8strNVO4iI8OCywyzFgOQRW3PdbknwgCd4Le4H?=
 =?us-ascii?Q?hAvuQmSHkju7pOOTcc6y70qJgivHrNvgVpN71O9NtRpdiDjyzltAw6gej9Y7?=
 =?us-ascii?Q?U0/hDnbET6IeWVlNoKcTnmYF2zeUNwj6dzD1u1a/B0+ZvbNhvsw31OCufxob?=
 =?us-ascii?Q?dwwV7vPO9dSIjFjxUfGeixBoI2G/dst4sTx7ZPslwh4D4ZamuEJgncJdsWXN?=
 =?us-ascii?Q?2xLe79G5UlEemQ3QGwKmBsrxET0Y/FluEpbHuuiE/G4Naaq/wox9p6/Gr6HA?=
 =?us-ascii?Q?Q0PbqvZmVoiooP1w4KC5SoZeXSSvYQj8HE+TEZqxRf6RuHuY5gl9/0Fkiww9?=
 =?us-ascii?Q?5Oa8np97HVeo1UeNS/0enVzPXFaY5QcTXLNWC6GfcPkHPu9iiaGpmp2LDjp8?=
 =?us-ascii?Q?I0t7nbXkSiOLecntXr0vmqhosTkm3Bo5Q8Yx3fO7zsF+eQ5FmMLBAMf1nDJ4?=
 =?us-ascii?Q?TreFFsNfHbzAf/SAGtnPtv/YOosyE6iRlem2g2t0BCREPNh+xc+b4C1Nvpoq?=
 =?us-ascii?Q?lYgTUFq5GwI6bcMWC7UCWr3Bgr36hyJCExSzIErx/tltRBtkUNtRSk8c/W2u?=
 =?us-ascii?Q?1gu0HRvqJ4CnCeI7jPWDfD+rU9+vBpVoiaKpLQmifUjiKYz+v3p0+Q4+QP+z?=
 =?us-ascii?Q?zK9besm2gxEPVmBnr81UaHWXVSScc4IeNm8nELWZqXnx+oGdkqIDvg//UQmS?=
 =?us-ascii?Q?ZMwMutWPSpyUbxeHeHKvOXywqbKdZwsrpWZLmEarj1ZXaGwoTiyyRtn3wICY?=
 =?us-ascii?Q?IVf1ShfxhH9HKuYqwwdA+5HfYvTl2F1oTndeeXamCyGWa0kJlNyRpsoTtdsy?=
 =?us-ascii?Q?8Ovtr77jk61gIPdwht4Z9y0e10vFX+DYRF2uZxijPieuGlkYn55pL2amwhlB?=
 =?us-ascii?Q?MsMhRKNxtTq5hpxLoI7dCzROfKIj2m4Y76Bnq6CjkElz/eQEHjOXn4HkgkJw?=
 =?us-ascii?Q?t/IRYUcwpRaMaW95wKegnarIwMggxj6IyFUeP/2S/ZX9N89Gh6HLZHz/5Rak?=
 =?us-ascii?Q?62XX5KwpM95/oOcjCT8XT8p7j5PNH7bz1JJfSK/mUI+y+LIoFSF28aCdVG/T?=
 =?us-ascii?Q?3Mhl1hrTsTV/9Dr1VaxrsOajtyIFCJUaZRhTng8yjtdpGdEqd0dnu8tHHueV?=
 =?us-ascii?Q?W8XejpPrlSbhGIl5x03PrG5wFEsQDESyeYUq+zalJaL2ilP+b+FFhCU5wz0r?=
 =?us-ascii?Q?QXI8ZHmbBnn1MxJr6SisE1O7OQ/ZcNpOzvXHKOuuQaYDX6+sornRU3q5sA9B?=
 =?us-ascii?Q?eHGI9tuBDxYkVIypy3b1wvmRaIKK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:21.3337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 723edbdf-e58d-4a99-55ab-08dc685975a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
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

From: Kenneth Feng <kenneth.feng@amd.com>

workaournd for the imu fw loading on gfx 12.0 without psp

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
index be140ee4d9173..7112e4b2d6489 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -143,6 +143,11 @@ static void imu_v12_0_setup(struct amdgpu_device *adev)
 		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16);
 		imu_reg_val |= 0x1;
 		WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16, imu_reg_val);
+
+		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10);
+		imu_reg_val |= 0x20010007;
+		WREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10, imu_reg_val);
+
 	}
 }
 
-- 
2.44.0

