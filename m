Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DA9D2F7E9
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 03:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA4010E793;
	Thu, 17 Oct 2024 03:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VmXBqgT8";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60DE610E793
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 03:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyZxuy3QISf9R20G1aaCalSyUI2SrsQ057jsiTvZRc2p3l+e8OjGcqbURLXIyj3qy74G/3MbafCtg/uiBp44Pf+Ye9P1vgVX+JV7nebEuF8cUAgIBnDnQJIrtzb6In1ojJ4QlbNzRIYchicVlJ4i5wNvQg1u7MtmOAWe03zQLzCzKmsoV1vletk0dJmHk5+DREGlPcCwpgoXnvO0tQq1wNx4zY1F0cd6DZgoS8sn1q2p5G07Z2oRHp+GdyeXbYOQZTu8n/fwmdea+Kkkk+c89p1IlT6LlLmHvBENHNAQHiWDO42qxD+xYY2DTfxbIIjuIq9lQRWODdODGeLvF0xwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z68M8rS+ifxpMmYcCwNt5U5zS3z950sUdPmWdiA+Jj0=;
 b=UHwxc72VLFJSeUx/exHeU+rSVN7gW2H1+M8LREi89C8Fvk+5zRw6TPNOoN6DQLOjoG8oxz6OPooBlWk/yJ5JArgH61/H7aBQmCrpxPN3wDFx9mtChFTERQqYlUC1gvaRHXW9Z9nBXtufMGzYVUnA661zeiMrkuFHoo5Wojk8MPVQHo5FgMzVwETfCzrofTYkBXrk1Xdvy3hFoXdoHJNxkZuds5uKx3zqGDvxiSlFaN6AFO1iZyMnN2k7wMfDS2Ek515nPtcnfQdnWiKApB58uQ7N3tShJn2JHOc6yjUaB4Hg4k0z34PHiE7QXs/IFYVdK0ZZpOuePmdMBI2wGG5/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z68M8rS+ifxpMmYcCwNt5U5zS3z950sUdPmWdiA+Jj0=;
 b=VmXBqgT86mDc5p5vEG5sRlmMA0iGYeVOIkXQLEaxN07PaumGWQIBJErRft+YKXXwjJFMaSYso4VD+I9sYXp/TSh1/6WnOpM9N0kl1G4xd7vnZFg4LV2m4un3NxDsL+lajOVpyjIUbb3GFOZLO00vRl13IavAnQ3rqbJo5VOdDIc=
Received: from SA9PR11CA0001.namprd11.prod.outlook.com (2603:10b6:806:6e::6)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 03:43:45 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::95) by SA9PR11CA0001.outlook.office365.com
 (2603:10b6:806:6e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 03:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 03:43:44 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 22:43:43 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 0/2] Expand Display code documentation
Date: Wed, 16 Oct 2024 21:34:25 -0600
Message-ID: <20241017034244.223993-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 672a948c-f945-4518-3400-08dcee5de6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kCJrV0hIFhXePOpyz+1eQ/gj6unoHrWLmv66bjYOip7PfrEzBeeb7WBD34GJ?=
 =?us-ascii?Q?qROYjBekLWACO9E4Aeooz+voD1lOeeB3M+6Ay0r0PAgrFdKLfgdaE0sGgDf2?=
 =?us-ascii?Q?RR6b1AnsdAznAckxqMPqSIbnjaKxxexF7yatTpjD58ZZQkgu6CIG8NMsuEai?=
 =?us-ascii?Q?BO5yuuB4c1e0TEN0lqL5bWebUbdChi4u1LiDdiTjinVh8EnmYTe5smIq+s7p?=
 =?us-ascii?Q?QtdxYNOgbF+kyTWiVby0T1UWeT36Oh+4eE7WPvx74oVmdlm8CkRVptD7vHOW?=
 =?us-ascii?Q?xYG3MOrJj3bmSH2iwedoJmLby+4PQw2KVLLyFH6fY68FoiFClvLB3Ex3x++C?=
 =?us-ascii?Q?NruEYLV0SA4c0ciO/noHHyY5UM52ECH+5H6TJu4VWUgA4lz5UWfnWCV5lARE?=
 =?us-ascii?Q?ew5RJRprKvwXoAgXKwfWnVDOYOp0LOHQNNrBfL7Qsv4dO8d1xbhKuEneZh4L?=
 =?us-ascii?Q?mosJcZdsTEJ0qKY+qzO5/W+wwAyZg+qIvHm/7pveAgri/fniab+KrhgLUz84?=
 =?us-ascii?Q?JLNEJYPKbXEE8GS1csHVdl8zA6SK4NpFQuP3N4Cd9gTM10nU4H5iYTl3QnMp?=
 =?us-ascii?Q?5IJgxsD2cHqEExF3xhkq7avdch1y1qob+Xn9/QKLi6VGpdSLIj/ciNN2ffBE?=
 =?us-ascii?Q?URDVFqFMSRuwKEoNqs0KpYR1JzdYA0jMj8enG5cruTJ5qppygUbdS7VpOuZX?=
 =?us-ascii?Q?BTlAmYv2jyPuz13r2uSx/6ZVVrIzgElAcPwK37VcTm5ZuhEAf5UnOZ4nnm9h?=
 =?us-ascii?Q?YKYqQgZkrojsfoDdk+EBhtrmt+bZfoIbomDI6RRpsJT4Wb8vj+1KbGqyimIT?=
 =?us-ascii?Q?aGn3+BUFVZwBvvoU+NWfHwhZHlEvrJryPNWJpGh8emICH/gCNirC2aMUwpTt?=
 =?us-ascii?Q?z4iYIft+6tqXXGraKcfn6if2JRxaJPn7RfGIvLQcxRaeXEvTdWNWkk/AHrLi?=
 =?us-ascii?Q?UfWwqNI0YLYKp5z5vds7BW0sNJVZ4DsesfRDUrPqWFIL3qlxv4tM/0c3viiF?=
 =?us-ascii?Q?Gt2JcCtzxEGb4Hyxb0ydvnz7V+UXEQxvWjIGUjCl+VpHSoBUYE7XfBztdr8j?=
 =?us-ascii?Q?yVC4popeHpOTxAnSwSzpWRUtw/nX+gdHYIbJf3n6NbqeuYxGXe2gnXCwFuZe?=
 =?us-ascii?Q?hULIe3UZW690x3uuovhi3IUs6TOHRlRJ+f2k9Knswng21CVITVv71eh/hOVc?=
 =?us-ascii?Q?LlJrajESQNe5mPgGHCnVzfAHAlg80ripUkHrzpMI4AqCPWSoqwyuDLEWupVl?=
 =?us-ascii?Q?LGYqfdleP6NjIkMvFwtJ85hvdN8RHyvNzxlBnBH/NMnB+4nVLi6OpP7DrZhv?=
 =?us-ascii?Q?7N99ip/vPSvBT18ziDhZGlcJsZ8lJDPfO6i97tNsNVE2fGNb9c7vGJcNDm+c?=
 =?us-ascii?Q?C7mcfFMeT2cDYTC9wMWark7tyJU2IfVei5/7kO0KPTfJV+ECOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 03:43:44.7907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672a948c-f945-4518-3400-08dcee5de6ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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

This patchset expands two areas of the display documentation:

1. Add more techniques for debugging the display code.
2. Introduce an explanation of the programming model used by DC.

Thanks

Rodrigo Siqueira (2):
  Documentation/gpu: Document how to narrow down display issues
  Documentation/gpu/amdgpu: Add programming model for DCN

 .../gpu/amdgpu/display/dc-arch-overview.svg   | 731 +++++++++++++++++
 .../gpu/amdgpu/display/dc-components.svg      | 732 ++++++++++++++++++
 Documentation/gpu/amdgpu/display/dc-debug.rst | 187 +++++
 .../gpu/amdgpu/display/dcn-blocks.rst         |   2 +
 .../gpu/amdgpu/display/dcn-overview.rst       |   2 +
 Documentation/gpu/amdgpu/display/index.rst    |   1 +
 .../amdgpu/display/programming-model-dcn.rst  | 162 ++++
 7 files changed, 1817 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/display/dc-arch-overview.svg
 create mode 100644 Documentation/gpu/amdgpu/display/dc-components.svg
 create mode 100644 Documentation/gpu/amdgpu/display/programming-model-dcn.rst

-- 
2.45.2

