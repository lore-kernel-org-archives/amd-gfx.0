Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117CDC19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01AD210E332;
	Wed,  5 Mar 2025 20:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CoQzDhlO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A87310E002
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPyZKedcwwOMZjWCSDNUHNaEtrac73PzI+cjnYSLZQB7SkYdk6jkGQeasdL0vsbfo78jsRMa1gvf4ghn7n5u5qmQ0FgjszzZW0A3xsgE5cxYnsaLQuIufveXzX2v2LXh8pxtcIYLfD6tC9dBLolOV8OJRaUCCMh9sJEfLKNdipnUwtXdCXgEQyRoI4tGHOMLx/VMtVpdCHhe7JRtN+hIzm0acmf1lEB4IzvBRcSfsxg5T9Qh85YpO5W3D9e2OaEZjcV9nQfs7uzyPMNX5q7x9au1VBt8IZHeX7Mvp2xDG4806wyzcO6l2YBRB5/9tQK9tTtcvLqFNXQmVZbSHjo4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+wEOp7Maj4vvFhPhU7McVk2HEQdEVxhTEGKRa5qQ1g=;
 b=gTVNlp2UtdjhtrU3Z58LyA38hRkPLzxkSHMIineN5xwYgXxq/oGzyzwnfCksE9eMns+GRhfMSYi+1WziAhJrDc++YmDX2C0QQyW/LapojSIkL5orD0/71eM85enQJjPFNpVXbzMfn57npuH0Bsao29yKapBWXTYe1rc13IagsOdpgUjYQKb3FC000cvU6ICIahfK4ljCgGySsbbbP8Ck7JgvzOOmqLZoy42WvUvZEmqBK2k6LEs/tSxoN0RE17OQAFoABDs9unR+qzoltpDVqxU+SPAb1v+XF2o2cvKAZxJVVUWFSwGiEsu/uZb3NbdkhZqMs9AL8jfviSKGGk/TfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+wEOp7Maj4vvFhPhU7McVk2HEQdEVxhTEGKRa5qQ1g=;
 b=CoQzDhlOCievhmWbOhIA6VmOz2AFdeTWMO0qujECpKj5EDho0wLTh6hZB6EDFMV2PIS0NAempDO/1BXFFjt6bBPgkwr6psRAjXjXp+8T/ISQXf4Ef1hpq/rkFAI8R+5sCn9wpGkbzjmcue5k8HWid8XHoGcqcz5OVKl3UqI6ceM=
Received: from BY3PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:217::29)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 20:47:36 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::8) by BY3PR04CA0024.outlook.office365.com
 (2603:10b6:a03:217::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 20:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:33 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/11] Add disable kernel queue support
Date: Wed, 5 Mar 2025 15:47:10 -0500
Message-ID: <20250305204721.1213836-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: c0056e1c-c9ed-4a5d-2e58-08dd5c26f5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uvo2UETbDU6imVkuFplTMbn+PGWX8Z/jYCfTAqje9zC7zBkrT7CqDuqgxQcl?=
 =?us-ascii?Q?C9ZbbheJ3lVh7vlB6gNEKY0/+NTGCZpvlPR5o7Cj5FQWby/A3iHEEI6W3dBm?=
 =?us-ascii?Q?3aAl9p+stXM4aIaesaJXNLPadZPrmtGh0GgToIrHi6ARKcNfuGo1+JjgEaQY?=
 =?us-ascii?Q?comUVEbOb1iljgbNN7lCje44RcBu6U/AfEW/+RqdUs8eBhBmbzEEEeNbvP15?=
 =?us-ascii?Q?f9zegLmnal/XAPt9bnNxY7bLVFKx+vurICo44CR/C8A930RVc6SKCdI4eXXk?=
 =?us-ascii?Q?yih2WIKFEkixXAWr5Gv4/pEdDdyxbcbGaF4DhtECtreS80byNJBA/N5QCqMH?=
 =?us-ascii?Q?/jMctMxwsCKobUtcI9p6Rv1K5Po5f2bjRPZapBLDCqp8bapffBXjxOsfO4+A?=
 =?us-ascii?Q?+ywzY91URvMjSQmUXOXMzhVTv9Vn4edspJw2bG/mcIl8c5yaJwDHcdjXThOp?=
 =?us-ascii?Q?KlnDqTAu9gsnlJea7gleJGsn60r11FJTbnba/X1GTSBW4P7iV8cUEyOJEaVA?=
 =?us-ascii?Q?0Imi2aYA4VHZ35m5gIowW+tWK9E/rZEtOlWsyWA52Z84dv+CfnBH8CtqBaIg?=
 =?us-ascii?Q?P4z06lFHWoPzhJ6Z7CrN8tVWTC2AFbYcJqcaxorT9iogCxnDd/H6oLO32xWz?=
 =?us-ascii?Q?EtbJQE4N+qSjQD6ejgg1IhyI/5FbyZ1PcgOhRPIW98AkE790QHTR2f+gmVrN?=
 =?us-ascii?Q?jfDAlcmi4+RBvFfl3k1XZ5huDkd+AjS4Ul+5yTxSqbEVCX37SBrdy+S/q0S/?=
 =?us-ascii?Q?YdRjyp3MyZeipLiVjEOmsgBNWm/7rBIG5QgEgxi/xzWrn9SP7YceOqRWRi74?=
 =?us-ascii?Q?AguiCaJV17sECCBbT5JyAM8vG9dU+d0gZVfmZLkFbKEuofW+eZDnD0MjOhqm?=
 =?us-ascii?Q?z/5o/pTRe7gR3pZBBhlpfIWWdXTKt6/RRXR5kIxUNLZArQD2rNYyphSYteGG?=
 =?us-ascii?Q?zOA4Ot5Ly0bzSYZggAD1i1GHUKxNmmRTFhrRYHDf5Tk/4LdnKQkaeqHPpjcN?=
 =?us-ascii?Q?8y4g79GLilKwyPl1lFw1P/zcNc4ZGr7SoFXlFbTJU4V46ppLIqx/Kb86/4zU?=
 =?us-ascii?Q?IcV+f7djgra4dAnzIXqvHgQH31IvdJVyg4N3iwWPeXDeYgM69N+M5en49Ldv?=
 =?us-ascii?Q?sHeghJYlj3c15htnvwfhIPcEu2holy69Vl073JZb0shG+wkBy9quiaXyZUcq?=
 =?us-ascii?Q?j7xWTNYvl89yWGPJHf3bWHQMBJ1MCFHPetTtWtTtabYx+j9GDJQNezJ035qY?=
 =?us-ascii?Q?SW/doASaWYvlUY4RSYaRi0+uZiigFrr5j9i9dO98Xv4125N6sBHdYTbMzQWs?=
 =?us-ascii?Q?igApLt/vyPlssiUMR2qJRzdXFrEJqHmREHjdLvbTmy2/iM3vX1tEgdoIpaxO?=
 =?us-ascii?Q?udmQqYF8FDrm/j3Ap12+8fj+CS8cSPj6vKlxyWFGr0fgq6kHsXOpvWGkVple?=
 =?us-ascii?Q?Pp2vSMELcNGZYsamlvOxgoFfUE8S6zEGPasZFg13QMqWI9R7GafnU57TZn2k?=
 =?us-ascii?Q?dPJ+XGY4dhLI4b4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:35.4384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0056e1c-c9ed-4a5d-2e58-08dd5c26f5a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
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

To better evaluate user queues, add a module parameter
to disable kernel queues.  With this set kernel queues
are disabled and only user queues are available.  This
frees up hardware resources for use in user queues which
would otherwise be used by kernel queues and provides
a way to validate user queues without the presence
of kernel queues.

Alex Deucher (11):
  drm/amdgpu: add parameter to disable kernel queues
  drm/amdgpu: add ring flag for no user submissions
  drm/amdgpu/gfx: add generic handling for disable_kq
  drm/amdgpu/mes: centralize gfx_hqd mask management
  drm/amdgpu/mes: update hqd masks when disable_kq is set
  drm/amdgpu/mes: make more vmids available when disable_kq=1
  drm/amdgpu/gfx11: add support for disable_kq
  drm/amdgpu/gfx12: add support for disable_kq
  drm/amdgpu/sdma: add flag for tracking disable_kq
  drm/amdgpu/sdma6: add support for disable_kq
  drm/amdgpu/sdma7: add support for disable_kq

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  92 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  30 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  28 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  77 +++++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 114 +++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  16 +---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |  15 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |   4 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |   4 +
 17 files changed, 261 insertions(+), 142 deletions(-)

-- 
2.48.1

