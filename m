Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABE8C19F4F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321D5112828;
	Tue, 30 Apr 2024 20:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y9wTPgKO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88FBB10ED52
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIRqj8euouxZV1ckGpod+M+VA3++lzPSoEB76p5OAeFX24jBPQIgmV0i8bCWzvIPH0LiBJUQUj5Nmw78CkCQ7rRiTL/IwcTh5S3NYswcUizC7XoCCSI62A/NL5K8jJqOkEjQ3Xv9Yr3bItQW70LXS2LSmOkRPwdGtpWxtpJ8Bk59rjotdDiKq/ymCXiovSOWNm9EM40STQ/F5kAu9qSlhBjVH+BDbfsomdVDRpJH4DXaucw4SbmDWUeTXIOgTMMNe1UvVgurMJY1l5sOxOJAMGNZ058rm+GtZB1Zn3OSgdQZQjTWQQT9PMtvZKfHlXoqczm3p1bMZ85CPMT/Ua7o5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtU1SUX5hyFW3oj78Ysx/36E2i+FyxFbPc2UtVMozBA=;
 b=Q/+4C5a5b8bCvCD1P0dkPcrE8j0H/GMm/O+Rrs/ebtyw1M4ToweFB6TJoezsVPOVL+pKRIWGYzlIrnLH6uUF6O7jhdj4STCMxCgrEwEUEVcnJ2KV9huYQGl4KCgsnTuKyIccRTlyuoegPF1v0WrOMVeQjaqytsW9MTpPIVUDQ8+JQuIhQIhV1EFTbnnsiNxMLeDnJLjbz38jwsH7e0JZ+wb4fsD6iZK/KzFd+PZdBg6cc+fjzdR3CZPnGDne5jXGZ52b+PrvUJj8/UxVk1K3+O+Myqu5x1EEsZ0hC3W0Fqf8BRDgF5Bopwhi43VHi7c2zfW44+sey/JPEFImaGQ+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtU1SUX5hyFW3oj78Ysx/36E2i+FyxFbPc2UtVMozBA=;
 b=y9wTPgKOU0FJ68NvxL0UtuL1OcuLaVk08ULJcME+xiybn9DQ2mnVh0xL8JiFNUglEheCmX7lafh4tb3r8j19CK0elbyncUtp3xSOGak6UbWvWo6QYqa6IhdnCDf0/SH2657Hpyk4j/0TOsgx+zH3PuPCcsfxk8LzH0gFXZTOiWU=
Received: from BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 20:37:33 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::28) by BY5PR03CA0002.outlook.office365.com
 (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 20:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:37:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:37:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: support mode1 reset on smu_v14_0_3
Date: Tue, 30 Apr 2024 16:37:09 -0400
Message-ID: <20240430203712.800427-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bd133e-dc1d-40ff-afe3-08dc69555cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YkUFKY6KD/6AyNqtLC/jmSGxvnB2aJ+uONTsBVJeHyLFjGWVXKNaLLM6+i64?=
 =?us-ascii?Q?wulIXDnHKCj7XpYk4igvMsn0Jg6Db24BbdCpO3HIXR3hWz/YiRCf0gj/oPTw?=
 =?us-ascii?Q?jMmNae9M//WJNYg5ZG9ZTOTl6ck0bRhiafOtY/n3rYTCy8oNTBCWKGTbcN7k?=
 =?us-ascii?Q?afd8Or0NZA05PgMK6lNpyglSxOpBrGQ0l5pRwW+MNkkyX+g50yNe/sid/6VY?=
 =?us-ascii?Q?i7KhLG/IxCechXm7OaLE+vDfRDrGrUYnqpaQYR+1c9ZUM+DVD7uylcJAJPkS?=
 =?us-ascii?Q?4lkbyYIVVOfsfRsgld3e/kA1IOc/LIQer3b0eRTmavs5WhsnCylKW89efLEm?=
 =?us-ascii?Q?37CM6PJ3DQxpmY5yz9MHqoMtBDhhfo/xzji1vDfvPVgIyZ2r8vMda+HnLfOW?=
 =?us-ascii?Q?NuVNjNSxe0dP3/jPTfPZl9Si/vxKuCe5jRsA38nKQ2J3WQsr2JSs9PhgF2eF?=
 =?us-ascii?Q?1RZMzam7OyirNTYRWhIFYXQZh9DvUMALZYXQq9zpuY05QeSTCXtw6MpnljsF?=
 =?us-ascii?Q?44iAtHDsrsayNwcC+XfXX7QidmMuhxtSfePzEzq6x5Be+Q2rOerbDnhsfyVs?=
 =?us-ascii?Q?qQeYz1ttfwJZFBvkF/yGMx8/NPCvUW5YQBPPvlaVPfTKdggWMu3Sxvt87F07?=
 =?us-ascii?Q?QM4UgGP60fxgpOPJo9GcpRQky9/qZxVITsEb+IcmXTK27q0o1nWo4Ux2u4xy?=
 =?us-ascii?Q?7v4wKVlyD09cgyEk14KC8iqkF27SMpxXC3NPDzyjylVz6mueWz40staThPDf?=
 =?us-ascii?Q?PCie0yHdBg5REMCLe3LPPwUCa2AG1NeEwTcygiBgPyjOTlQfYYhEkRfZiqJV?=
 =?us-ascii?Q?GOwRlWJ0N1IkOYpiynMfIya6l/Rm4J9bnVwJbunBF1oMFQVm1hQ9z7JRMgtY?=
 =?us-ascii?Q?qR/OvjecqCT9+qeY5jz6TJdaNDjWHdn/z1CexLxZ3BYlIPFIoRGWtDYyidKd?=
 =?us-ascii?Q?jb3J4h62FUlf9Lb9QyUse+DkXA5Jg28VffufYqDTwy9EoMvFsJDgC5NH9DYS?=
 =?us-ascii?Q?exFOBJOeNce7bZP1A7C1VVYKqVkdTsytkHD6pX/C2QQCViZrvJJeOUSDQH/s?=
 =?us-ascii?Q?/+wkMmEoazu2cyJp9QiaOO1EfWVz0rCGLz9F9ra+fP6DipRaKlI1S4L11QvR?=
 =?us-ascii?Q?lB3A5rXg/4Vvq/VHniES393dIK0QeeNEHIfsqRIGJlSSS9bRKm/5fL91jFOX?=
 =?us-ascii?Q?B3HgubvPM8rZX0acT9c3jfiVnx1Vqm/OaLPfUKOg3rCjmFA7Rok4U28ft4Aq?=
 =?us-ascii?Q?Pxtb7GwTxUfv+44IQWKA87Rj/mc0qHGKkJ+IJtrhhyCLpoyQi5EAZhmwPhi4?=
 =?us-ascii?Q?jndLaxOdwR8r3PfbIQG+JaT4MH5reC8cBKZjJUv+XegbzEdg/8yVax6bkW+p?=
 =?us-ascii?Q?rNgPyxLcLS2Lep7+hqbha/DcR/uu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:37:32.7015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bd133e-dc1d-40ff-afe3-08dc69555cb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
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

support mode1 reset on smu_v14_0_3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c        | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 1bbcd23e703ba..12900488dd618 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -204,6 +204,7 @@ soc24_asic_reset_method(struct amdgpu_device *adev)
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(14, 0, 2):
+	case IP_VERSION(14, 0, 3):
 		return AMD_RESET_METHOD_MODE1;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7789b313285c4..9bcc2ffd1b63a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1844,6 +1844,8 @@ static int smu_disable_dpms(struct smu_context *smu)
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(14, 0, 2):
+	case IP_VERSION(14, 0, 3):
 		return 0;
 	default:
 		break;
-- 
2.44.0

