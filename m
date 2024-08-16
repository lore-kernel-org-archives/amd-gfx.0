Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC8BC531DE
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 07:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCF410E5C6;
	Fri, 16 Aug 2024 07:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GP9bOcJB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F32F10E5C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 07:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzojfGXxCq5w60shXm4A5EQtN4xURs0PgmFiWaaPSVY2rhgngtapas3oJoxwJ1VeL78RY8HXVu5K+X7uvHl6QsP1CA88NBFc8xHYva8ISbGI2Fkt5DRxew/jcL76fGUXPDWCpXAm3SvhzixD4gb9iSFx/sVMBMHxmZOAKi6joO0p9CoKDGpQ2rKrO4luqVDc3417LuLm5VgRtcaQIENQ8bSFqTH1gGS0EUc8yK/iX+twj8RxH6r4ARWM8xojkVGrVJLgi8z2WypvOJtiAwsWAgx6fGvWT4APlmMNGxzhl8nQfLr2gfVb8z3kxvP2cT3eAc+N6O1D9OIzhyiwcgSn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTzvL98q6Ri+/n+s1VztsNIMBovME4G4AGsyVx/VTu0=;
 b=RjNmFDANcbnN0ZWHYBQlx4TyUBM3nw6bloqv7H6ZMVFPIJC0pkkxZ90VpMotcOVQrx/XNAsdtmzzo0rBtoPtycfobEx+oYCDraNMgx+NOAF0sbPXEUt2qNIfari/OulDt7ppC3HI9Z3VydgKi7mMv7e9xgj5L/OsDh26/FSIen/amRB0GA+8O2t+NYB2NHw3svKaDl5fR4adu/Ubht97eF88Hdfjyz9D4B1Am/n77ykw0kYWhOQlYb6cSGT5v6eWYRIm052yqhZiM9cDAn7aVgPXpnxwcpJ24Twu7zNT3NJre3I9V/z30VwILgr2P4e8tGPqw9xQjl5h/Gi01cbOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTzvL98q6Ri+/n+s1VztsNIMBovME4G4AGsyVx/VTu0=;
 b=GP9bOcJBvejV8RjYEbzJD6VQybM+CVR27wcgRSX7nw+XdyKnVttvdLLThvdotVdVcMZm7uOMF1i/7PZJJeBUjCkttTMFC1chSImARq9ZHUMT1BIUohOidtAAJIoLLSw/YBXS+dqAz4V5ap7KH45I5qRq6n/+hEFx+F/MQLdhxj4=
Received: from CY8PR12CA0054.namprd12.prod.outlook.com (2603:10b6:930:4c::17)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 07:55:03 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:4c:cafe::75) by CY8PR12CA0054.outlook.office365.com
 (2603:10b6:930:4c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 07:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 07:55:02 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 02:55:00 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 0/4]  Improve the dev coredump
Date: Fri, 16 Aug 2024 15:54:43 +0800
Message-ID: <20240816075447.442983-1-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 9419c366-1095-4f5c-31f9-08dcbdc8bc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/G0cLwhF/1eLRjG5goXw9hX+WD84Iv0gCdZECS+1nkfi0EPGu2fNLJ/c7iUp?=
 =?us-ascii?Q?tBs+g2SulUAymn2vtger0G85BPnxA9Hho+hVkHT5xAfWjUPEemi8i8ukj0qK?=
 =?us-ascii?Q?vCI8m1yBoOH0tiBtCg7Q3WE9BOgPcb6hjVhQ7IRaBsFlQULwOSFjOkCBGtSC?=
 =?us-ascii?Q?/h3kCXT+WHJx9DeiCi0b9QMLa668BFkqTsqg0qACWhXn0SJJTW4wdE8ZwVbD?=
 =?us-ascii?Q?QYtqr4xZI9sXxhtBAVhRp0NwSsi//LJp5Y1A/qz4JW2xEnS9/1ptimyU69hM?=
 =?us-ascii?Q?vrcch/si5wkzuf+nAXoWn/hxkZDtivlHv9k4/dQW7iUkwM99k9I7osX4oDui?=
 =?us-ascii?Q?ALq7LrLZdHGk725ctceD6989YekpiQbM2tfRux19xSy+KbLE0my2CySbkeJ0?=
 =?us-ascii?Q?RYY1yylLq/gIv4Zg640RYteJRtpNJkNx1BwPSRjXCRaChoL2UibK1z3U1fUz?=
 =?us-ascii?Q?bdD1vN1z7Nhb66WtauvmspjmnNDpWU+LHt5jOn2O6yTPD6XvNQm0QLYjtrNX?=
 =?us-ascii?Q?ctyrGwy8AwKLpvwAVtYySbvY3xTKzZd9TICg7OqCeSrx3MWbhREsQsbBY2vw?=
 =?us-ascii?Q?T3Bh+b2b92Tvnp3zG//zHvKoosLjT+9lFpHYi6cH6MRlsY4uGJ5eJtREFZXd?=
 =?us-ascii?Q?wNcPphdfZu+xZBzOeUrSQGyqNXNXjWvpcSSraMYnYNjMn91VOOmP1dG6GW5x?=
 =?us-ascii?Q?Cu6GkdMHjUJ7958KHVvuVf27Z/E+Epz4h9v8+EbSZu+G3+C/Fk5kfMh/uNmX?=
 =?us-ascii?Q?cR1sEiks4/dOOouyk5Vhb0mOJRao16QPNV9xwLCmIPLFKdQxmANCHi2m4Si6?=
 =?us-ascii?Q?YcBq6UXMJ/YmwniaJwXw2Rf8fPZBeiKa0+DBf722gKQYb2Z2DdnamX2s2vaR?=
 =?us-ascii?Q?kv0yWU+/F32TBdb/y1DoNwtF+s9I/usSKfgOJqe1dgEz0A/qBuSu/89yC1hj?=
 =?us-ascii?Q?7wXr0htLwE/soASebGHUR7LN8qkNW7sXeAkxWDczAOf/c5anhr2eR35hERIH?=
 =?us-ascii?Q?gRIr5eV4sNCs09sTsedkKUbBz6LmdDlxmh0kh+W6FGe42AmeglhlEEepG8HJ?=
 =?us-ascii?Q?34lJbSAVNjaFtc+yAToqoM20LF14BTKGKoFO0bBkphpV6YKfMH0HFp11WR8D?=
 =?us-ascii?Q?3axNZ6NEvqD6Lxnsnj0biWqJQumEqfbWoQZAA/ea9Q7rjB2KaXpcIq1aRmgB?=
 =?us-ascii?Q?DfR6amiIihJ+szc6aiKUW/DS6Ha8hC0Nxd29tDOazT2yXM2W+wOWLN83wC12?=
 =?us-ascii?Q?OGhdyJvvoN1qdGHPVOzD4TT5yq0/LWwnHKw86YHYM5wvroqhBzTdLFqVTfzi?=
 =?us-ascii?Q?Avt6EQ+X4tBsq6/wenBY9RiBaEuRmfiFQ0X7vXEkyRM/N9QYuNRlAksG2qJr?=
 =?us-ascii?Q?Vs5oIYR0vOGe666wBVaAUED4Bz9LSQihYPZQlO51vIJ8t0DIBY24oMAkS2Ba?=
 =?us-ascii?Q?HwJftEecKptz40euJfkdVNX7Uge8Hj22?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 07:55:02.8540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9419c366-1095-4f5c-31f9-08dcbdc8bc49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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

From: Trigger Huang <Trigger.Huang@amd.com>

The current dev coredump implementation sometimes cannot fully satisfy customer's requirements due to:
1, dev coredump is under the control of gpu_recovery, thinking about the following application scenarios:
	1), Customer may need to do the core dump with gpu_recovery disabled. This can be used for GPU hang debug
        1), Customer may need to disable the core dump with gpu_recovery enabled. This can be used for quick GPU recovery, especially for some lightweight hangs that can be processed by soft recovery or per ring reset.
        1), Customer may need to enable the core dump with gpu_recovery enabled. This can be used for GPU recovery but record the core dump for further check in stress test or system health check.
It seems not easy to support all the scenarios by only using amdgpu_gpu_recovery.

2, When job timeout happened, the dump GPU status will be happened after a lot of operations, like soft_reset. The concern here is that the status is not so close to the real GPU's error status.

So we introduced the new solution
1, A new parameter, gpu_coredump, is added to decouple the coredump and gpu reset
2, Do the coredump immediately after a job timeout

Trigger Huang (4):
  drm/amdgpu: Add gpu_coredump parameter
  drm/amdgpu: Use gpu_coredump to control core dump
  drm/amdgpu: skip printing vram_lost if needed
  drm/amdgpu: Do core dump immediately when job tmo

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 19 +++---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  8 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       | 64 +++++++++++++++++++
 6 files changed, 89 insertions(+), 15 deletions(-)

-- 
2.34.1

