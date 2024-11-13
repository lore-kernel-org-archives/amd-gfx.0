Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B58D637CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9270910E2A0;
	Wed, 13 Nov 2024 21:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fMOxSexD";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE23510E298
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOln3mwDlaUvqm/XniW4Z/FHV8tPhSP9kn8p6tsoS0R2fNB51WWhj8QhrzK1r9ehzGZc8lYkuXTeM+mWcIHXAkdpHoufgHf5qi7Xdyr3jE44xbHN8PZI4q9sNE2MjXR1gRJRsWkQ7AiGPQJZTGS78WerPzpNg3Tq7RhLrx8/1g+tohjEiIj+gInlm2Y+Ly96AX5JQ1oazVBULfsCBz3fQx25LcXQWO43z2JiJ/d3KOC2SpgUQrL19WhW+6WVEdGwqmTS42LFDQOUBsoN4EdhAaabNJ1Z3F6/S/nj/xAs9MVO18gmylfHyJbANRQiWCZv8L8H+QJHMMzrB2I8PJOuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/nML+nPB7NC3ZYI84XJt0PKoXW2PlGBYBir8pP4IRc=;
 b=TqIoPfFSShVex/VyUImdhojDobvonxZGLGWvShWCraL+/Li7mfkIrLIGISmLLqufwcGzn1wXAzgLac4yi6kB+Xbt8dl5TIT20boaU75zLwFgHxMDwHrXGbfpjS+7ik60pjTYofebkK5sbFMS7wWUzWwbOelAfXZ3A8ojw0qUgymezjFmS+v0FB+nq5XNFgIqqGNaUPx2rpEZpH1HPF8ODtvXyHR+yyOjGFA1LceHDmHELI9fpSGQYJtuCdqGYJcvIKvGH0p1XaYBgAsXbcLjp1DCQimIEaQKJvnLK8bF86XJeQPZXBYEzTCq2IlWbV1L6OHRTD++SkEoWnHZUKDwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/nML+nPB7NC3ZYI84XJt0PKoXW2PlGBYBir8pP4IRc=;
 b=fMOxSexDBwj0Ng8v5stl2stvGbtdxGeJ/7Wtbl9g1xB77AoRWZFGTHVGET1FpZo7/vI+jfhZ+mo7guniAQYkx3K2lJwZYulL7j/PZjNqiGw94TnO4hEBEYCKkFjnmY4TiAW/4nCThFiYjiBori67N+qmQQnBCrbn5hSNd9WrIOs=
Received: from MW4PR04CA0282.namprd04.prod.outlook.com (2603:10b6:303:89::17)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 21:45:08 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::c5) by MW4PR04CA0282.outlook.office365.com
 (2603:10b6:303:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 21:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:45:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:45:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/15] VCN instance rework
Date: Wed, 13 Nov 2024 16:44:36 -0500
Message-ID: <20241113214453.17081-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 20412329-b90e-4a88-d447-08dd042c7106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ANRwXqGnropIikFNrv4jTHrQhI45St461UA/qQC/hxQJBf+Y3/XIn6qx8+eb?=
 =?us-ascii?Q?0/rFOSQpImvFnIjZubyombtjTUkNs9mb6JXlMqfa0+6eKXI21LhoG7cCM52p?=
 =?us-ascii?Q?9v/P/mRjAASvg8KvEv/TXUouhauedqYwgaoqWKMyXQ9/+0yeKqrnEBVzSxES?=
 =?us-ascii?Q?Nc7UIWcF3NZcwclUO3uDvPajBtb4xm9sLja/bZGFEX+Xw6I8M6ijPAQ7STej?=
 =?us-ascii?Q?nXiPPJFQN/j4ejvP5JjN8DFCGSFMa5R310OOXR8ZTB5PqrRX2he5FI6JYUPK?=
 =?us-ascii?Q?njEtAO4WVBVF81kgtWnUyFadWnza9eTwdibV+q4lLI2Oq4SNvQDkaVqAgc6V?=
 =?us-ascii?Q?25cQYQe7NxaL9Wv2uxm2szAigJ/DsXxRpQarr+WJVZQQmBaegiP8hY10S0hI?=
 =?us-ascii?Q?Y/K2rSC5rwK5THncq9Op4vCYLoopQ1j7VG4CtKZqHkwSM94kmrfFU9aCvoFi?=
 =?us-ascii?Q?P2pDZNsVuLXV9qCSAaeDoEI8n1mmuBV6Tqn6NDME7fBqYeAo0SbvVdAEkbfv?=
 =?us-ascii?Q?9ZZEsDJB7L9iEsLCEShS/sJTzFnfnWgPfmlpkyhyEfGMPnbHNAraFKHMJKNe?=
 =?us-ascii?Q?/zJtM4FbPv8m+zCrZc7QepfBKQ9+X1ykzD3TmduesZToz4FQxvbuL4oaH6yI?=
 =?us-ascii?Q?PNYa/rObT4m5+wrdz9vlLsImWvA3h+34yKzGgKlBy5ko62OWhtvMpSRNdOiJ?=
 =?us-ascii?Q?r6tTVR+/9wiY34I5txbKZWUUTTdVj8ND7x1+qDB25bvi37BOBUZp5SOcSga0?=
 =?us-ascii?Q?lvNZX0wRsyWAOK43pqYstsZ1AFaJpNQoMencmeydS8USYvriEXIL8gcgA/EP?=
 =?us-ascii?Q?nKeYJB+gPOyr0Mtnm9ExBheWTGjRaoSZEGP3op6Hlnbx355EToUxDcuRNUP2?=
 =?us-ascii?Q?dKSRknSCdq2vOsqqipdAmTAFG/diy+CQ/eEaBlpbF/XEzoXyJNQ3HIMQH33e?=
 =?us-ascii?Q?a96WNp/0FV9UYoPIg5OaGzWDD+39ja40pk0WtX6WZR5j69nchLo3V5B1KD24?=
 =?us-ascii?Q?K3FEEe0arBHgKACmV2rkymDJ+PbGV2XiptcQF7k0qt1rgc31LQ22b4VLdbvq?=
 =?us-ascii?Q?zVtWMlxIXIyFvoYUKbnLEHp0eG9o0XfbrhcnHrOeRXHABTVb9vNLRYUlEIno?=
 =?us-ascii?Q?SoJM4LNvhk2JV5MC5Mhg5INGy7WGSefF8IATSEhzpnRrXDWp03swTISYCJK2?=
 =?us-ascii?Q?JjgPNscChEVfdQfyrk4Yy5QXf40BCbaRHjRPqjEpwx8jv1SChRCmhuF7HZTt?=
 =?us-ascii?Q?1HYrEUnRvcafizbuEyddSCSJzrSxkGLSV2rFd+7SPeJEEFEoMC2ObAkS8UZK?=
 =?us-ascii?Q?u36T+0ABtWCPF6O9TohjmCBEg9exAcHQfzGvuz5aSZAOPnpHj8IPt/qBqgph?=
 =?us-ascii?Q?9YRNVP1zwG9lixF+EDaryAJKJtQkPivsbEhcZTEnGzlKZKYS5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:45:07.5011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20412329-b90e-4a88-d447-08dd042c7106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
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

The original design of amdgpu called for separate IP blocks for each
instance of an IP on an SoC.  This never really came to be however for
a variety of reasons.  Boyuan's recent rework was able to get back to
that model, but in doing so it uncovered a lot of corner cases and
regressions.  In fxing them up it became clear that at this point it
was not worth.  This patch set partially reverts that work and reworks
it to align with the current model of having each IP module handle
all instances.  While I was working on this, I noticed a few bugs as
well and they are fixed up.

Patch 1:
Partially revert the previous VCN instance rework.  This retains the
smu interface changes to handle per IP powergating.  It only reverts
the spliting of VCN into per IP instances.  This also reverts some of
Jesse's vcn sysfs changes as it made the revert easier and there were
some cut and paste typos in the patches.

Patches 2-3:
Repply Jesse's sysfs changes with typos fixed.

Patches 4:
JPEG bug fix I noticed while working on the code.

Patches 5-10:
Rework the instance handling within the VCN IP modules.

Patch 11:
Switch the VCN idle work handler to be per instance rather than per IP.

Patch 12:
Store clockgating status per instance rather than per IP

Patch 13-15:
Add new IP level per instance powergating callbacks and enable them
for VCN.

Alex Deucher (13):
  drm/amdgpu: partially revert VCN IP block instancing support
  drm/amdgpu/jpeg: cancel the jpeg worker
  drm/amdgpu/vcn2.5: split code along instances
  drm/amdgpu/vcn3.0: split code along instances
  drm/amdgpu/vcn4.0: split code along instances
  drm/amdgpu/vcn4.0.3: split code along instances
  drm/amdgpu/vcn4.0.5: split code along instances
  drm/amdgpu/vcn5.0.0: split code along instances
  drm/amdgpu/vcn: switch work handler to be per instance
  drm/amdgpu/vcn: make powergating status per instance
  drm/amdgpu: add new IP callback for per instance powergating
  drm/amdgpu/vcn: add new instanced powergating IP callback
  drm/amdgpu/vcn: update work handler for per instance powergating

Jesse Zhang (1):
  drm/amdgpu: fix warning when removing sysfs

Jesse.zhang@amd.com (1):
  drm/amdgpu: Add sysfs interface for vcn reset mask

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   67 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  334 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |    8 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |    2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |    2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  146 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  129 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 1043 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  725 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  625 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  457 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  585 ++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  534 +++++----
 drivers/gpu/drm/amd/include/amd_shared.h      |    3 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |    6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |    8 +-
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |    6 +-
 .../powerplay/hwmgr/smu7_clockpowergating.c   |   12 +-
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   12 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |    6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   14 +-
 41 files changed, 2523 insertions(+), 2313 deletions(-)

-- 
2.47.0

