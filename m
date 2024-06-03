Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D767C25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 05:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 940BC10E289;
	Mon,  3 Jun 2024 05:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UaK3uhpH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F1E10E2A4
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 05:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eai9vZvbj1m1Bz7sBpZhRkfk16mQ42wn7/0jHU0dTlMICY3zAC3JJAIDsqjaW0Mhts6dFRil43V33i177v7KScaoQyhIBjH28MgqbanniTFtV4a37cmGMlNkZdAQpfxGrp30xwVnaA9Z8QfUXgsUJCpLaCpfU/MFbyoKsbhuzzcjn+P8ptMgBKlfqOa9ulmh/dspwFr6WwarQLtRz2Txf2+7mchoorVY3u8LOibiHCQpXbC6Jd4PEcm/0L/TJupa44EzVjFuZ++KlPVzi2+qEA3lDnRSSDP1tSLsQIG1rqcX8NIoqD0jsLmKY8nP0a6YwtV7eMMgnUBo/hsaLG0Y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLwsXJ7VmZxcExAdysPLyNPogKihJ98yDIX4v5Fi0Ac=;
 b=ZHN3tVcInAKPf9zTirwe2lKs6PJXHbOhiHUTyMvg614J+fkBGdgzoBU53HNhwtOA/+sARn/jT2WCpoGrsuN49FiX3N925uG8hyqYXF9oGMkHRF0hJDQL5SS3ANzQvZ0MsftmT63IsI0B+utimBEcV869bYABrZsXo1AKOdkftOkCp+Z9bFdNzqV7myZKzDM/Cr0e6avlfSWZ+u5bQuAIaSjzLOpm2r/3yNG7ueCDhBEoxHBnLwo/lIdPVQhcFMRYafmwf6J46IDVOd4glj4pXnyUnfO7f6YDVctSok9qhDZPnedlAoKmfwmYHnEFALubKLJ6zsN03jAJf//RL7Nj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLwsXJ7VmZxcExAdysPLyNPogKihJ98yDIX4v5Fi0Ac=;
 b=UaK3uhpH2qEJGfNtPtsCUZ3i7T3kbmXgbB9aLyMwbJAZVIteErC6FPGePwR8RKO+3vdmj1J38nrFNGla90e6w+F7kAjR0y0V4+syAi1SbDclcF0fy8Mw6QnXH6tja3aoduk1rOWjEKI6O9xrQ2a4jmbYKUK93NZySv97DF77v5o=
Received: from BYAPR11CA0060.namprd11.prod.outlook.com (2603:10b6:a03:80::37)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 05:59:29 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::1e) by BYAPR11CA0060.outlook.office365.com
 (2603:10b6:a03:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Mon, 3 Jun 2024 05:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 05:59:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 00:59:28 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 00:59:26 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>, <jesse.zhang@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH] drm/amdgpu: replace int with unsigned int for imu_v12_0.c
Date: Mon, 3 Jun 2024 13:59:25 +0800
Message-ID: <20240603055925.353172-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d7659d-f4af-4d92-bcba-08dc839254dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d6bJpnev4GO9GSP5mQtFHC7xj0sLcQGCLpetDG++FICelz3rt5ktSzsprylO?=
 =?us-ascii?Q?bYxQ0c53duSJnQ+Umr74eiJ/gV55QsogGH2WqiJihangtr5MBgOalkbfquiJ?=
 =?us-ascii?Q?c6LjyuUYihN7YY2Bf2zquku2Ors3XfroOIfKy+YN2M3IPHzr8Hepxsz4oKeF?=
 =?us-ascii?Q?B6g3E+21sspOc6dNzhJwus1qQXENJR72TKrU47CV5v3MOyzXq/4Q01hakbue?=
 =?us-ascii?Q?d3abwlcUsruBf3MK22/zyNLceJ1cRJoZsrjuVn172nb0OFuYOrUi6HnAo9K4?=
 =?us-ascii?Q?7yN5yVgPtRDRCP2a7UVtl0OSZqG7DWZUee1pH9mrz9OutMJp76MDy9sztalk?=
 =?us-ascii?Q?6jF6TUXtIEx5r95APiY69w2rMWlbQ2b8IiCWJECtwunuDc+TqicITiqYH3Wj?=
 =?us-ascii?Q?xz3YIXBGupkCxWlxlSeNS+1MkX4dReDIYFpeHUSKNfwy7ZS7dehu1Ufa2xPO?=
 =?us-ascii?Q?W+00XH8GruT0k+Z8V84Dc5QqsSd6kaeeSFHrwAKK+cMCa2X/dgyyZO0BB75X?=
 =?us-ascii?Q?uFXCxWtdpsnYioWxuul9rJpmreI/gaGmuKxqGsUh7kvsASsr/WwvtcLW//k3?=
 =?us-ascii?Q?3+Dhc8Z0BZZZ/lXnxntzKQsK11H4nJ2WmR7W0+zUslOqM7QAURJJddVaevGV?=
 =?us-ascii?Q?V46tEUWT2EqKu8tBzexOawGOgr5DRdTmKIDDqtR5RRPKPZhJ6jM26bdZ8Pst?=
 =?us-ascii?Q?HpAnwaJqEUxKb1xmVde9a0cBJTijFuPHazat/Apyv6iXvRlQVlipeJj48t0p?=
 =?us-ascii?Q?O2/DJO7Q7+foi24mpfavynEj8IG1VdH3SeMpusSCXtoWGRRiDt8VfOz02Nnt?=
 =?us-ascii?Q?8AqSuS/8bWMG4/sUTOoRcjAKnY1eQZamLznuVTgV5ByFPlOEuSDDlOL7jG/a?=
 =?us-ascii?Q?yCjMPi+3b8GjY9Qfq5i8LT8BtKQYUWSHKHPvt6QsVFFR0Ufw7v0KPM++6mk9?=
 =?us-ascii?Q?inqZ6WuOoE8Llo88FbhQWWsiZgSbKds2s7ogj+VE2Gx0u32FEpXtijbjal/c?=
 =?us-ascii?Q?EDqU76/4d2lPu28QxCVHrW18lnKhHQSVgVJDiTlwFUnx2CBjGun5xZ9fYwfl?=
 =?us-ascii?Q?Sgw1XtdJjHL13NjAQySWOhTIdq4UBYO9cHYjfKKwavT3eChH9OpAI8HmX0N4?=
 =?us-ascii?Q?+HcJknrGEw4A2UctCLBkOWyfs8rk89bHaBC3tVc6cWTo5ZxBJVyvhWGWnaAN?=
 =?us-ascii?Q?nCY1SZ2TdXRocZcbt4p2apActrAE4BEQY6tM2QpwLRc7FbzE2JwGuntuwW1x?=
 =?us-ascii?Q?qERFf4h3gSv4Nzeer54bAlZ/OnZ2iXbYVm00mL1ydtz58q4tyRh8hjtKCxs2?=
 =?us-ascii?Q?j/1DFJHqpp8Srr62L2dIC8PFcv7ng2aOZfpVCm9j/x3iAjkd5kIN+1GMeXCy?=
 =?us-ascii?Q?4ECx2DeAvNsGtJgWAVODwZll08Cd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 05:59:29.0799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d7659d-f4af-4d92-bcba-08dc839254dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
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

The return value of RREG32_SOC15 is unsigned int, so modify variable to unsigned.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
index 0c8ef908d112..2d6f7549c2af 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -119,7 +119,7 @@ static int imu_v12_0_load_microcode(struct amdgpu_device *adev)
 
 static int imu_v12_0_wait_for_reset_status(struct amdgpu_device *adev)
 {
-	int i, imu_reg_val = 0;
+	unsigned int i, imu_reg_val = 0;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
@@ -138,7 +138,7 @@ static int imu_v12_0_wait_for_reset_status(struct amdgpu_device *adev)
 
 static void imu_v12_0_setup(struct amdgpu_device *adev)
 {
-	int imu_reg_val;
+	unsigned int imu_reg_val;
 
 	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL0, 0xffffff);
 	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL1, 0xffff);
@@ -157,7 +157,7 @@ static void imu_v12_0_setup(struct amdgpu_device *adev)
 
 static int imu_v12_0_start(struct amdgpu_device *adev)
 {
-	int imu_reg_val;
+	unsigned int imu_reg_val;
 
 	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL);
 	imu_reg_val &= 0xfffffffe;
-- 
2.34.1

