Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC58C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42F910E07B;
	Wed, 21 Jan 2026 22:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IrJG8CJL";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E4C10E07B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUS/7rcZpImf8SpSOnmvK6K12U5/UejlkZQJ+6pQGzHdlU5tZjYGCGjgDa7bWc1gJ7V/IKg47IzWHoyuuZ1+emJ/ALtsoOCjN58MAVLkE82DBpI5BQEAfRBMqfjU3mftLFm/LQWKrGVeVaNY7l+1T/GehDAPdZT3u1BYqBhz9I+SrbShgJsew0Z0zt1GoYCOJcCMVISQ5BjjPKIvQChWQh3at1Kj0NfIcnpKLsegbbf8lT8oUn7/tDk/BpwYmxAm5YvYCqjwc5BMxq2rns+mFvuPo/+Upif/7XDU55GjJsqqL+Ra459M0/c3/EOkQXmphCIscfxiCQvkAwNLKcWU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIQERNUiLWP6uOPd7FGeDwqEWqaNpSkeACiTi4d77Y4=;
 b=hTCBEZJvIbyBaXLrCECqH2zhMh8e9TWHgWP2/I97TivMl5ZyORfBwpEOmehxBBJumrEkAWbWBHYipV+n8fm5z9mhonQlhV4SxYlORZOJPi+rFO7vT2mgj0X/lEIzhfc2S22KIRCL3ZYfcX1S1BqlDkrfpmFcjssCfpbNlRHGZK166nHrar3866pblgAF1BFshG9PUrSN+wXKEsTIGQSxIwko9PtncGFy2ywPSWEGUc6tlmDX08fSorSoULPpdaTQGL3Rg6tXpq+3EkPbp/A/NJZc+qzFE1e0Quz9BHJz/DrJF/cxIEAXY6VRt8gUUA+5LIN6mSYlGBgacP6JWQGpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIQERNUiLWP6uOPd7FGeDwqEWqaNpSkeACiTi4d77Y4=;
 b=IrJG8CJLr9EXrgwOQovP6NQGAgMuSrlj2QVezQ12Fv5sQ08LHZBK1/gWX002S+Nx/8Ck+TY7lWY1/BBFyy0NVOeglXXzaRA01NHoqRWNBNRq6icwCB5ejTAQt7wTmeyjpbN3NlFg4y4pKv/22WEDn2rSLSEBtvh5cd7ZWPMFWtI=
Received: from SA9PR03CA0007.namprd03.prod.outlook.com (2603:10b6:806:20::12)
 by SJ5PPFD5E8DE351.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:32:54 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::b) by SA9PR03CA0007.outlook.office365.com
 (2603:10b6:806:20::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 22:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:32:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 21 Jan
 2026 16:32:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Jan
 2026 16:32:53 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:32:53 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/13] DC Patches for 26 Jan 2026
Date: Wed, 21 Jan 2026 17:31:36 -0500
Message-ID: <20260121223247.186241-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SJ5PPFD5E8DE351:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa54e9f-25bf-4182-fc89-08de593d04c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n3kjAyjH6KqZ+u3FCR61/wq2AoUMAVa4mxWEeO+V4AVUuY4KWf9NASX2yCHt?=
 =?us-ascii?Q?cyRYFo1dBWDToahMVvypEBAVH1sGPzCCh8ARugeiA46maLIJRjUP3ORbZKtE?=
 =?us-ascii?Q?/gUUKqeUDz4HLN1uR1BXiWe2IrQXbvFtqmNnV6gEqjcTrR4rcuVBpJdFoOk2?=
 =?us-ascii?Q?2LdhY0qhlVWwxPU00bn9cNuNoPCqt+hohmUGvCGnYtQNmjdloebDntgimGMT?=
 =?us-ascii?Q?3bdC8xN/e7Yz94wQs4wufEISPY80L0W/IrXpMHd7xgCiFftiB12MTKApvybF?=
 =?us-ascii?Q?yok1i/FTCkQ1pmi60gXtkn3jljuhTM+0DdMGE4W/5V53u+C0TTe3SfWIvyh4?=
 =?us-ascii?Q?GXtlHGWW6Lx6D2Pb7TeX1jWU/GVHYMmrJeTLYgDRd7XM+kiYNsaCYqir9Boq?=
 =?us-ascii?Q?HYWD7wEifLjR/Q35QSysOvdtkhzYlu8OwqpuKu49OmzdCozN9G734GCjtJ2J?=
 =?us-ascii?Q?Gl0EnMdm0sZeDK2jItuj84priKpJhVieB9NZKn5rTcjtFx5ggL5BVpg9pHb4?=
 =?us-ascii?Q?R9cSoAViV5WaKpYoiz52dz93xUT7GGPT1V4I2pkL9sFOqsI0bKhzN+MWhVfK?=
 =?us-ascii?Q?/YcJXQwthuIXKLPq8e+NLmDPEAS9Z6FuK4oMc4tKLw0fBYuQF/Kk8fbxAxXO?=
 =?us-ascii?Q?5MOFV9esjBqzXyH1iYRnQCbRF8If/K/+YpIm/dIxq8yn6DZWfyEiX1v6vP4r?=
 =?us-ascii?Q?2OsdagfN1wH/6FzFd8nTS7i4nvRbgH/6UZPj6gcTI7fB5f9e78WWCg6uSGr5?=
 =?us-ascii?Q?zTOq+tGvVjqZCxhDC7BDiz08vA86jD3aWThJbj6MooYLvQTKpAfmmwSiitfm?=
 =?us-ascii?Q?Z4DnwQfpTv8UpfncxxtxJ3ReS0bD5VffKnEa4GIxnAHQeM7DUYx6REBnijJ6?=
 =?us-ascii?Q?PdVZ6HhHOtRkGc34yCcpLaGzbqT63kzHYkR5DxvTCeU5HPMDJLPL/cVCbkQA?=
 =?us-ascii?Q?mQf66YuxYmUY+9Gh+pNEYdyBvYgkBPMPoLdM9dx42D5EKNHDCUUonN/kMOie?=
 =?us-ascii?Q?LfSJRg3DwZ7Lec57vX7Shr2BnjgtdKXjOF2O6joRfdA2siBkMJIAfH9F0NrK?=
 =?us-ascii?Q?kj7h9sD9OCuBfTmT9QjlmUrLZDJ2fdg6h1B/XncGfVXyyAKeuh+ISd4Q7/ZA?=
 =?us-ascii?Q?k0WSooVQdj2+nXHHFMuS1F0g3XxSuSfpVU4Y4SQkdDmx7iW/fYoU6eVeK5tG?=
 =?us-ascii?Q?duPoktFGCVg1ylCnmYkaS+fhnqXXcyIdW/SNFlBP5ZkHTUcrq7RGd008DIXZ?=
 =?us-ascii?Q?P0byFaBZMyb49s1nhK1IDp94hKP9CS0amaBlYQI7CYYOdpxukW009Z8UhTLv?=
 =?us-ascii?Q?BoWV4qoofJa5qxKbjV3BWMDnUzZBzzVXfglhpoAmgWMOPGHZN5ALX/LzzAdQ?=
 =?us-ascii?Q?XfnokrJNviWW5LjAUT2dFYiZq6u6uANtmtBhPJvn1PlKVQ+fS56a5LfbAmRi?=
 =?us-ascii?Q?IAfPKop3K0/MPytVcWp0C7JkRwrnIPGquaDoKtN4ygTD/RXjGkVpAMdDnvWl?=
 =?us-ascii?Q?AXHzZUw9PJBaGTJyhRKOp8cpG7I+yjYwXXXtyNJUIc7Zr0/FGhBd3JNjwGn3?=
 =?us-ascii?Q?YXq7SKIQMyGhsCqs1r2hFWDuVrpkMQZxJisvez3B6yLbkyvdBFMDdHfFG0iO?=
 =?us-ascii?Q?4RKi6eWL+stKrGKfj0flwitHdRAunam4xbQXSC5zUh0hztNDHExs+l6t1wj8?=
 =?us-ascii?Q?fpSszA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:32:54.0435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa54e9f-25bf-4182-fc89-08de593d04c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD5E8DE351
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

DC v3.2.367

* Fw release 0.1.44.0
* Fixes for corruption on platforms older than DCN4x.
* Bug fixes related to USB4 link training
* Fixes related to FP guard
* Debug helpers and other stability fixes.
* Some refactors to improve code quality

---

Aurabindo Pillai (1):
  drm/amd/display: perform clear update flags for all DCN asics

Bhuvanachandra Pinninti (1):
  drm/amd/display: Migrate HUBBUB register access from hwseq to hubbub
    component.

Charlene Liu (2):
  drm/amd/display: Enable vstateup hook for DCN401 to be reused
  drm/amd/display: add setup_stereo for dcn4x or later

Jack Chang (1):
  drm/amd/display: Add FR skipping CTS functions

Matthew Stewart (1):
  drm/amd/display: Fix GFX12 family constant checks

Michael Strauss (1):
  drm/amd/display: Add debug flag to override min dispclk

Muaaz Nisar (1):
  drm/amd/display: mouse event trigger to boost RR when idle

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.44.0
  drm/amd/display: Promote DC to 3.2.367

Wayne Lin (2):
  drm/amd/display: Enable bootcrc on FW side
  drm/amd/display: Remove unnecessary DC FP guard

Zhongwei (1):
  drm/amd/display: avoid dig reg access timeout on usb4 link training
    fail

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 13 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    | 18 ++++++
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  4 ++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 16 ++++--
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |  1 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  1 +
 .../dc/resource/dcn20/dcn20_resource.c        |  2 -
 .../dc/resource/dcn21/dcn21_resource.c        |  2 -
 .../dc/resource/dcn401/dcn401_resource.c      |  2 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 55 +++++++++++++++++--
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  3 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |  1 +
 21 files changed, 117 insertions(+), 23 deletions(-)

-- 
2.52.0

