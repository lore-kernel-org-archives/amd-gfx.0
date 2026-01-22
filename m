Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2A1C44536
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 479BE10E061;
	Thu, 22 Jan 2026 10:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Uuya5OM";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197C310E035
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyXJItzfnXyOfmCcuwWssSVGE00fZJte+NVzzfjQ/KuNS15ouHHzTvVbS5fdipDp5SSQH03Lbxe3ScNy4XwhhaLIejRRqkwtQZbBpFEuZbfpLHNHQNfE03L627AiOzmRN1PEeFha4oddOlJiUjo1p7506ktbfjG3S21QJYVi9jrNP84Zot3jeLjYwyqEIvmzkXGi2rxpH3EfaGDS6ZhVzTYXU6dLUMW1/uxnP7gDH4Gv/eqTAG1Xynp/pJhNhwhbXBblRx8hjSA1S+hn5czYqJ2tWzsl6WDT4azdVaOdWiYPxemJU2bbuA28Qm5E9SHwbfr5Qby4C/irCdK52eSaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwxNrnr7VNu+WaX9mxHJKCH+x7mm9IiUqvQm3nRJBa8=;
 b=WQUmzI08whQ+NWBO1WBMFlvecGlbFk5u2Etrg9HcKZFt4+kxWp+YiEgaQovd/Fl9I5A0dzBjtK3q/lfuop48EwZeY2POQ+6FaIsZpmd4dZRE4r3JoFy/vDSS2kaQjcjc5xX20go9AhcLuFDl50re6JERKqdiS2lAQCF6M9K2zSXpmwKqKiaxL42+YKfSpy1BwmhB7oxy88WF3lFAP0PxChW7Mc2ZWfMJZz+3JVTRltFOaZbfAsW2IcegRJp4XFaLmwlXWP077bx1u87BAjjq4+H7QvA0P3FFxYv4MEywyDu7W6wLbYafxWVBIPP18+XzI9St3Clpg4jhnruGy8DZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwxNrnr7VNu+WaX9mxHJKCH+x7mm9IiUqvQm3nRJBa8=;
 b=4Uuya5OMKNsN1E/pgXx4YstWhEElGeBPRxs6ozcQKciYFpg+jY/V7V7pvyWzNSBEeXv0nlZGrWSnQtwaWExagilwpzOjWcclSho2flHkHd+AlSD/zXpRg6nM1+KNpcc0H3MPALkdJFp5G4jyFbt1SrRqAr+qNbj14++/a1P/Zq4=
Received: from PH7P220CA0115.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::32)
 by SA5PPFA403A61D8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8da) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:41:42 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::64) by PH7P220CA0115.outlook.office365.com
 (2603:10b6:510:32d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 10:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:41:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:41:39 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH v4 00/11] Add CWSR support to user queues
Date: Thu, 22 Jan 2026 16:09:49 +0530
Message-ID: <20260122104118.1682154-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SA5PPFA403A61D8:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e3ea44-06a0-4abb-d270-08de59a2d4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?34bYmLO/e9IQ+xd4mSXUE1iCR0VpblnbhxjSfoYFlPdSaZQM7cBEJyCSRRLp?=
 =?us-ascii?Q?NwLbncrc7l4Teiv3Vc09/aCoKbEUHlBMLbXM1czJDUoGUrFfGmQBPlFrlKoZ?=
 =?us-ascii?Q?AST7kx/MDEcvC5LwyclN3jRtjCQ47WSuUg1WAvCuvoL1XjtB8evKs2W/vPZk?=
 =?us-ascii?Q?v/clIfaYTWI0V5WIlZqYFIXVBVJkggdpbQ/mgu/gYTR9Eg+uKz3F8U/phcSw?=
 =?us-ascii?Q?v06xXvNhpnvyXih8kTTCvX0UAgpkhtnJRckoHUgKu99UlDORiQsOACMwIlqW?=
 =?us-ascii?Q?ymTcGcL3yvAkH53fEVQpd0v3t6j0J+qH2JbvDXSU3E2s0NWezDpYC9E6nv7u?=
 =?us-ascii?Q?FA/WTxunUasrMfqw+aJXsU33MPdxmHasriiUZQ6ZwZK8+hWwoxFLsS3vCZFq?=
 =?us-ascii?Q?7rBNBBe0mWEQ+IOaJONk9BdRC7PG6aV1NiGUrl1ERrW7otuBBlr8QeuOUYsN?=
 =?us-ascii?Q?NR1hXNPjUFjsGdGbvYGiEw+52Tl56i2FtZdwwdX5vxc1TxDM9WsV/FK/LjXB?=
 =?us-ascii?Q?lSCpmMU9vkCzj6TD5InLSfqbG6T2fOJ7SfXE5YtQutd3whQGiLodn44qnHpa?=
 =?us-ascii?Q?wlb5bOtXRsDFnijtS9C0+aTjbiEOsvISGK1MebRyi0b/J/TBlYtPkJuQs/jb?=
 =?us-ascii?Q?joqc082IRvdE2wLRV6Cdnj53LlvMkADpOD6rKyIlpAS9TTsT5GPt8pflbyQM?=
 =?us-ascii?Q?uMsDSgZgM3M8YWPDaGnSQO3Nk+dK1v2Jp2BYXzVNNi1vZBxawGIinBZTFsie?=
 =?us-ascii?Q?4/0+lqIiJffY4yWbC211pH0I/9c92v+pW5n1iv2qrECAxZ8Fqh5w6Iop3Gmn?=
 =?us-ascii?Q?0M7D1NBl/OFbU/HIuBF97GnuBN7GwTNfuIooYsPLKBCB0FiJq4sPFdfZG9Dg?=
 =?us-ascii?Q?tvKG6Zn7R/gFIzII5hsbUI3U5yZfCzJpOlGg4yHfaZ24UknlbV88lzhU59PP?=
 =?us-ascii?Q?ITZAfnXl0k/GWshf4VNW35SZy8DpQ9PhXxiYwzw6sSvuU3xwU6unACGDG9Wn?=
 =?us-ascii?Q?w1sAr2kwNsgdYKC5/Ut0LJzXhv0Ot+mF7m/B6HPkGyflk6mNYJsJfpBKo6m6?=
 =?us-ascii?Q?BsyVuflJl0TZxmvZKnzm4zYNFVn6Odpugf5PZ98Go0WuPj9/2llZfvQA8wEi?=
 =?us-ascii?Q?0ezj1AYTRaOLOflMRyOpaGoluDrtj9uKpYqAc6CgaWw8YFUHjYSX9coD0I6o?=
 =?us-ascii?Q?YMK/+AWXlVgZcYpW8UFYNXOHQt64jkKJu7/qzGG1y+z8vOOi2Q4BBIamyBJB?=
 =?us-ascii?Q?bYPI9bdGGpKiq15zulHNd+8poXJ1qn/imm7MHscGJEyqoyuVuI2zZfXbbkn3?=
 =?us-ascii?Q?9QI9bcA1GZ4XYIlfe/om99t2t2VljI+PiclFVvSFDwgdpSsuhkTieXNxqd/r?=
 =?us-ascii?Q?yBzeHrQIeQLA5146qrbn4HkIPRdfTm+J7XCuawvArQAbccRBkSubq6GI+8g7?=
 =?us-ascii?Q?BoMkwDOnkDPUIPWhVhHNnNo4T2Yi1npEE6prdg2OXrrZGTEfP07Sxpupypn7?=
 =?us-ascii?Q?sTQYqEpKAcf+cqlOWI7PSPq3nKNTb9OVbVmGj/203mqS6JV2iSbAfpgrtCUQ?=
 =?us-ascii?Q?dFRUkOSkUHARuEpHSy+Hi7S/F1uBtXuY/PQSdmQK6OTKHXu/LtFzOODSXfPX?=
 =?us-ascii?Q?bFeHpM2xIJ+pPRmi/1NSiLLBbDahDrsZiYGHYiZleX0LHjcVVuhko1af79rj?=
 =?us-ascii?Q?1vMF3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:41:42.0245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e3ea44-06a0-4abb-d270-08de59a2d4b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFA403A61D8
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

This series ports some of CWSR functions from KFD to KGD side for userqueues.

Things which are part of this series -

v1:
  Allocation of TBA/TMA regions for first level handler. First level handler is always from driver.
  Presently, this takes care of only dGPU allocations and is TBD for APUs. Backend to add second
  level handler is added, but there is no IOCTL provided yet. TBA is allocated only once and TMA is
  allocated per VM. It's tracked by a cwsr object which is maintained in userqueue manager.

  Adds save area and control stack calculations to KGD side. Also, support to specify save/restore
  area params while creating user queues. TBD:IOCTL parameters need to be modified to specify save
  area params. Also, need to confirm size calculations with multi-xcc and obtain the number of XCCs
  used by a userqueue manager.
 
v2:
  Remove association of cwsr with user queue manager (Christian)
  Add ioctl support to query cwsr size, set cwsr parameters for user queues and set second level
  handler.
  TBD: Handle level1 trap handler allocation for APUs.

v3:
  Removed 'TBD: Handle level1 trap handler allocation for APUs' (confirmed that APUs also use
  the same path).
  Rebase against amd-staging-drm-next.
  Fixes for issues reported by Jesse Zhang:
    Keep 2 pages for cwsr handler (TBA) and 1 page for TMA.
    Add cwsr_enabled in addition to cwsr_supported and use it for NULL pointer issues.
v4:
  Add disable userqueue check (Alex)
  Fix usage of __free (Krzysztof)
  Relocate userqueue trap VA to avoid conflict (Jesse)
  Keep the user save area size check to be minimum size required.(Alex). Control stack size is still
  matched.
  Set trap enable flag (Jesse)
  Rename input parameter for consistency (Alex)
  Add new function to set debug trap flag.

Lijo Lazar (11):
  drm/amdgpu: Add helper function to get xcc count
  drm/amdgpu: Add cwsr functions
  drm/amdgpu: Fill cwsr save area details
  drm/amdgpu: Add user save area params validation
  drm/amdgpu: Add cwsr to device init/fini sequence
  drm/amdgpu: Add first level cwsr handler to userq
  drm/amdgpu: Add user save area params to mqd input
  drm/amdgpu: Add ioctl to get cwsr details
  drm/amdgpu: Add ioctl support for cwsr params
  drm/amdgpu: Add ioctl to set level2 handler
  drm/amdgpu: Add interface to set debug trap flag

 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c   | 634 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h   | 100 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  29 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  22 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  14 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  28 +
 include/uapi/drm/amdgpu_drm.h              |  56 ++
 14 files changed, 942 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h

-- 
2.49.0

