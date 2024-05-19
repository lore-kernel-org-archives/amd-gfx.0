Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6111C25B75
	for <amd-gfx@archiver.kernel.org>; Sun, 19 May 2024 13:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0869510E039;
	Sun, 19 May 2024 13:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g3u9DXIC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04C3810E20C
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 May 2024 13:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCuzoay1Lq2Ua8kM2EVurInNDV4KQRsjsGCEipWuZfFIP9ba/f/VG3p1rz4AuldTAv2NLFeTRWPR8VTDdjpqShDahtqNqSvxrRDZvcRDItODqr/+io4BM5omnGBg/v/NDpbkT/QhezTw/GWd2911zXZNLqKygCMiXfjTh/oWSTAHGWqpV/9IUzll1eut1YZgvwZykeXJfkvSgm/pKsMFpti+7urBcmqY5atXHCgQAW8EE4ouNhnGBLq3ZKnxcNqcobN0aiKc+Us6R2aRqe0fuGuvUACZwjPFj9RuLZlRDhLop3r9DZH0Kldr5uoKctLHgdWeSC4cpm/RpqJvn8waHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdL9EORLDSWqifQ4XlqQyg1ovpcvACbmolgiK8axNts=;
 b=OWEYz7vB5sGat0iK6pLWAHniPEM7DrSutQ4G6cR/j2huDRuvYyhey5NSdtJKgAU7OkbxxKDRN3gGlWNJQYQjWrZQX8Y3mXWjJFYSHbi3Jzn1oWJty17W8yi28Ox/lLo63NRv99FcuWSMbH3LUt96S00vkL/LeK9DLgk3EckXK8/an4hWlscSHjatPEdIMJ09P5dPvxzhxgEnoTgyf2BBYHUzooDh+AAaxbvA3bXI8d3d9KWPDuUL7TytqZe5Zr+kNveEw2RCEmKl/cnhJ466WkSeYolVEo+Z+cMZDO8T0b5Nnlhsj51ZkI9w4iADwTR3ZXjihZsa60QBU6eUUvvA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdL9EORLDSWqifQ4XlqQyg1ovpcvACbmolgiK8axNts=;
 b=g3u9DXICOGcUNMCL2BSaZHAfNtK1peRZ1+PfzR2iYa8ebiw6MkMQeeQFRtj+NyEEDiwOH1Tl3iUaFhQMkVpZoJsk6ICzr0A8c8xZdguFINn0SRoimGByHIZdo3FqWPBLb0MWuXRTCHKAmj4Df5imf2o6HOOtr13JjMYAyVXcCwQ=
Received: from PH8PR15CA0002.namprd15.prod.outlook.com (2603:10b6:510:2d2::29)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 19 May
 2024 13:02:41 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::b8) by PH8PR15CA0002.outlook.office365.com
 (2603:10b6:510:2d2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Sun, 19 May 2024 13:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Sun, 19 May 2024 13:02:40 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 19 May
 2024 08:02:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/display: Pass errors from amdgpu_dm_init() up
Date: Sun, 19 May 2024 08:02:23 -0500
Message-ID: <20240519130223.6802-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 9845ae39-f70d-4520-e706-08dc7803f74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kR/FbOUUNDgP3DdG21WbuzeqnYMuUFLd+UnIZDxREGIfor7SnDQWhVkurroJ?=
 =?us-ascii?Q?ytEPLADByDwyp0/zpPR7OUtsdNzmY6lHESiC5N2k4fUS8bVIlFbBHSJ2j+hF?=
 =?us-ascii?Q?D4uLM2EmsoR0jSeQIERv/uZLRMXPc1xPJGWxvioTs9WBgTnp+pTlwoEIbYvt?=
 =?us-ascii?Q?F+WwfCgoMOD8BV+erdXdl5sfIbVh6DjCoOzcmvUg98EN7YSFdD7RWlQjLnoy?=
 =?us-ascii?Q?TkfuafhQDLhenRHVh9JrIBD85SMfLNvDzpIknlBo5X7oet4UIp/XQlxED/YR?=
 =?us-ascii?Q?wwFHJRMJ8SyOG86cDbNVJ2Pry5gHEgRXRt4RshOyy7fToAeNsAOGUwtZHpzk?=
 =?us-ascii?Q?MSwSw/KZRs/5ZPjdEboAud8Nwuab+XCL+4DMAE/Nk02LjSERMRrqE1quYQE1?=
 =?us-ascii?Q?vMt1k/FmE31iJ+bmdSeGFVDL0goXkL2cZeFW9KdoUzRVsqB+IRs500SF5UqH?=
 =?us-ascii?Q?0X0RUzmqohyVO/0jxAgQsvlg0ecG3Lh+tYlKHldCP1hSSNfUmVbefU55x7Ie?=
 =?us-ascii?Q?WzqUZKfvbzYCHoX8qYwsrBndqS3mA+nR/SUf8fysRktsvVDW2iRYVoO7puTN?=
 =?us-ascii?Q?fCgdoocB70D+CIpQZnd+rLcDWLKTysWMR+uON0JRE3Hh93gcKisGuMXmxnK1?=
 =?us-ascii?Q?e4R/1Tvbk0P5uepTNTc+5prlaTSazNyhJJnL/ztRtn+djJRmtq80KL+Mz2IR?=
 =?us-ascii?Q?kEHDhq1GriuxPyi9mTctfaWXD2LsoRobvGuq1K7oI9q6QPk5yE8NCWuYRxyB?=
 =?us-ascii?Q?DHs6JteH81j8kjvXNLcnfzEmhJVeSCvHlEe2GCwgPdQQ9e8T0VaI2xf6giYg?=
 =?us-ascii?Q?Jbm1B5DQhsEHUkUN/He9et+OhohmrwgkQK/bmrG61LuJJZyBwc0Tq3tOmnwB?=
 =?us-ascii?Q?lSx+mE+J1IJ3Dx56PKUZfMFGXao8+NptgHmmjXn7b/mbhRGC5oO0e3IU+aPm?=
 =?us-ascii?Q?Af9lqSuLxwinkzsP7J8NdAIY8bmjY1rGshTmCpWynZ6zXiGEtMoHst5fiyn8?=
 =?us-ascii?Q?tgX4F2SO3hGViKAaDqsbBUgMcTkKCNmdbhtX0qkx1WDYZLW6i2g02UgvZQ20?=
 =?us-ascii?Q?+Ii5tutuBVsp8YI+GCrriLZmMEIKNu8sQKIUqvDZBf4/OfquKuOxmaQeh9ap?=
 =?us-ascii?Q?cRHpzzgzhcS8wm6b0bfLlpl+fWzuoQXKZ5CEQeaO/1kWYRx83hEeqQlgV0GB?=
 =?us-ascii?Q?G4cUnCraFTZxc0jkTDaIeoZQyRkaJaC+ZI/xIYWUcPuKhHJrF4KQ3OcKyz9N?=
 =?us-ascii?Q?b8RTPil0+Fu54bMqsnHeZl+cNH56OnInMbJ6ll8On9xHiz0mtmoqHoS0Wy4K?=
 =?us-ascii?Q?3kX000CnRXpzlHmeK8C4Enlpjc9ryc0H1DQ4g6C6VbPkaIuROh4zPNp5i61G?=
 =?us-ascii?Q?ZICBsCDAYlRdU/+V3oACsrlwgSHn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 13:02:40.8521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9845ae39-f70d-4520-e706-08dc7803f74e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
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

Errors in amdgpu_dm_init() are silently ignored and dm_hw_init()
will succeed. However often these are fatal errors and it would
be better to pass them up.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d6e71aa808d8..01b0a331e4a6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2556,8 +2556,12 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 static int dm_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
 	/* Create DAL display manager */
-	amdgpu_dm_init(adev);
+	r = amdgpu_dm_init(adev);
+	if (r)
+		return r;
 	amdgpu_dm_hpd_init(adev);
 
 	return 0;
-- 
2.43.0

