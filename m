Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC8ECEBF76
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D9510EC0C;
	Fri, 27 Sep 2024 04:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EOcZusuP";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B055410EC09
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAEIUKhZlSfEARmsIp7zNTNnoowZqRNbP0ewpd503QXEvPtlxgZSKZpdlcpgrjW6pL7TwfRxHx8dhhahBnLFOFJKe1klcrzAKQzLpsQ5GdZ3dd7EEKpCFY9iCZqYggaPVCWDdTsRBkG4UdH7nFqeqzR/xgoRGWS8FYRLTlPwGHQZWceVSWKrxlerXybY93bzGpmATznj+YJB8k7U0s4HFkmnEzKMxqkQZToLojcK5I/ITWnTOc6J8pdUUGirM0KX7fpao81ml5YxgpOpHNFW5uwUU6zFgv00kvfS987oDD4OFC/uA6OvIY5NHtdHJLK3BOz+KMuPDlL5gB3fROt8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/gDDOmx3otjr2bp4KueDz2CEk5OT28PYemNFJ4Bgds=;
 b=AVJM0mjkPZfHfs3Q9AlYKyHfJJjyic67to905NEi1llEAEpejCBy4HARUwEmHr3pE5xtC5aC32RJnKJ0EUce2klsPKhIHxiZQba46sJMADf2yAX+b4iEDKgg2wseeahOQYN+KiqVEw11I7cunIW2qO3FffggM9P3u3vLoMip3IH9+ZjKbLXahLuDyHC61NbtnV+bfDpUUl/EJNQjZVwfRfkl9zH5pmW5AHKuNrBSTyJ5dJHUJYO7EQms387f8uKa8jzY0h7jsWpeZrMk+FzG5wIAjiui/IZx+siPx1Drs/EdM0OREJmyBtsX34yZdSw9kEj77TbJMRpSwC7zseE9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/gDDOmx3otjr2bp4KueDz2CEk5OT28PYemNFJ4Bgds=;
 b=EOcZusuPDjRVk3m/KTCoug59eaWPYxKZqUc1RX71RNej/s2ljrXqJ5m/Cy2fBqEsgMAfZocrq80tYJESCX/sp576iOhLRd1LSrX0nZFGJphey/2sckxZ0yl9kvl6zfq5tx6qZZz1o9PqvOmy+r9sj1eDeS/MHdDHMzRML0TtSvw=
Received: from BYAPR08CA0045.namprd08.prod.outlook.com (2603:10b6:a03:117::22)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Fri, 27 Sep
 2024 04:58:06 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::9b) by BYAPR08CA0045.outlook.office365.com
 (2603:10b6:a03:117::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.19 via Frontend
 Transport; Fri, 27 Sep 2024 04:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 04:58:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 23:58:00 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH v2 0/7] Add support for dynamic NPS switch
Date: Fri, 27 Sep 2024 10:27:36 +0530
Message-ID: <20240927045743.2718949-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: dc98e73e-a43e-4373-184b-08dcdeb0f869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yfVRcjJEyvWgSx5qM4R/tzraslztkN0b+DQ5nK/XZsRU6NeAnJUKMJgrM3ld?=
 =?us-ascii?Q?HjBMJ+gl5/96HsGLObsXecrIHYEvX5ICNpiUYino/6/zCuDA3AogEQv3N27u?=
 =?us-ascii?Q?vVxKFlBR7s8xtXe8mDgqQAGjbaufxsVRe47PSowpjDzukRgr49cvw678xdeW?=
 =?us-ascii?Q?THv2Q020SqS1s3L9ADS8g0LpHMeMaLzu7x6etMmlYtRJpO1Sh2hQZE/w4itk?=
 =?us-ascii?Q?BRlSykHM7Sf5YvAKUULUxnljXJJPJTwizByODWn5/oxoyIA09ygzXP97mhlC?=
 =?us-ascii?Q?8bEmh0HZC2JMumhON+KXVjtntAy0mZ/9eRYLpDKkfXY94BWDPXLFOWNC+rs3?=
 =?us-ascii?Q?2y5oDbcuotov0PXCRSizBnzkZCkCBMMFHfybsa3GVjci9zO4nBXUMjsHq1JB?=
 =?us-ascii?Q?5ZqKd6iWtMHUSdbfXTjU9SCxk3uqOHrQm3aI51byvsUnvUF4QxRjIuOFBfsz?=
 =?us-ascii?Q?gkgpfGwPaGwTUWbcv0pk74g4y43YiM13RskPhi3/69BvgBQYSz2J0GMxvsn6?=
 =?us-ascii?Q?kFzaihqCtHXVmZa7TIiYgteyJbvaytBcWxY6eN3DGkDe0eHd9USw70aOp6Ha?=
 =?us-ascii?Q?X/xZb8w9eVm8Lxk9jvxvmDZ7WNnpVhVgdB4+UsW4IJTETO5NyQbpR0IXCTSQ?=
 =?us-ascii?Q?q1eGm57clIkDHMd2NLupp6nvSb/MUOkmrFS5/Rplzp6PetmvzfoOytciSSjs?=
 =?us-ascii?Q?AePTW8YqvOiPX2twq72g1JZ5BnI8tlza8ebjMPINF/w5gUeMWyaRZNVgafPg?=
 =?us-ascii?Q?hKa/0ywnY1FcBdEbXSnzg8ocxN85/msT0PdGFQteqxIu4sm4DjwJycY6at8+?=
 =?us-ascii?Q?dq5WakVIie65W/Es8qxmvs4WYn7cjqMhEroXkm04gkJSquWrQGgKjJdgWDuf?=
 =?us-ascii?Q?A7mWdGK+EAzwnBFDQokmpjdIeNS2UO6YWZ/xcKhjPp2YipzhfSOWFCyf6bbX?=
 =?us-ascii?Q?TA3Hivc++jGQ6kmmPem+Rirxu7Z4mspUmZHgtzwrNidV/xNGp9D9xeszrzHW?=
 =?us-ascii?Q?RadFH+N/9hxGESDSpBEVHUQaFZc1+PDA/DmVt32tK7zctxAHj/hrVyqJ40MA?=
 =?us-ascii?Q?KW2KiH350sjR9+XMjRzwAYBDp1p4dVqAgHe/s6nwhkptbv5mo1SFBQHhzS2j?=
 =?us-ascii?Q?oN4lTd2eyAvymyZYatJGNOyBzsOB60t2HuUub9LJiPC5InH0MuiOxHA2HBym?=
 =?us-ascii?Q?dXrr97hrmSbNYhB1bkIyI3qBz/tOBU8J6Q8Pm96TzpJibGtO1jARG1clmpeq?=
 =?us-ascii?Q?uaYBsYkOY2573U5+w6PKn+MJsXLwOVhgV3Rtb4kuZGE9WM3gFuGrrCvdTW99?=
 =?us-ascii?Q?3+4NpLIpkGw20kbyn22SE5GsZwwqwntATTGVwICkDnJT5Z1hH35aihkBmpuA?=
 =?us-ascii?Q?BJRhRjytFVPfVjWFFvLtDGhGNeyUbfqxQEIqZkcqBhb+u8yHfp99d1339Mkh?=
 =?us-ascii?Q?5Tf04ay2ju4cTkV1SHfYcbZDODm4YDLe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:58:04.1609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc98e73e-a43e-4373-184b-08dcdeb0f869
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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

This series adds supports for dynamic NPS switch on GC v9.4.3/9.4.4 SOC
variants. 

In order to do dynamic NPS switch a sysfs interface is provided to request a new
NPS mode. If the device is part of a hive, all hive devices are required to be
in the same NPS mode. Hence a hive device request is saved in a hive variable.
For individual device, it's saved in a gmc block variable.

In order to do a NPS mode switch, the workflow is -

1) User places a requests through sysfs node.
2) User unloads the driver
3) During unload, driver checks for any pending NPS switch request. If any
request is pending, it places the request to PSP FW. 
4) For a hive, request is placed in one-go for all devices in the hive. If
one of the requests fails, a request is placed again to revert to current NPS
mode on the successful devices.
5) User reloads the driver.
6) On reload, driver checks if NPS switch is pending and initiates a mode-1
reset.
7) During resume after a reset, NPS ranges are read again from discovery table.
8) Driver detects the new NPS mode and makes a compatible compute partition mode
switch if required.

v2:
	Move NPS request check ahead of TOS reload requirement check (Feifei)

Lijo Lazar (7):
  drm/amdgpu: Add option to refresh NPS data
  drm/amdgpu: Add PSP interface for NPS switch
  drm/amdgpu: Add gmc interface to request NPS mode
  drm/amdgpu: Add sysfs interfaces for NPS mode
  drm/amdgpu: Place NPS mode request on unload
  drm/amdgpu: Check gmc requirement for reset on init
  drm/amdgpu: Add NPS switch support for GC 9.4.3

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  68 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 190 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  19 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  25 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  39 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |   5 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  44 ++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |  12 ++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  14 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   2 +
 14 files changed, 387 insertions(+), 36 deletions(-)

-- 
2.25.1

