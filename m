Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E41CF9C72
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 05:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEDDB10E4C8;
	Tue, 24 Sep 2024 05:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbrUnqP5";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6B910E1B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 05:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxPNsr6Ou7wD4nTXf+Ee/UCQ/jx9BzpTxBq3+RKAWSnBvwhSMjhm29v6xCE3CGS9OdYxyRVl1cF0g2u7Cywh+hI3xLJxMZVREkZ/xiyhJLql/9r9iW6XrefMLGoyjkgsLiByl5wtjzBGLaV1mUBhLpEghyd2S3iDyRoU++XZ9RGhpqUHuk9dyM35u5ovnAsBYRv7+IjEkoB5Ou1zO0DE+02VeQcsMg3y+p4quUos938OV7VBGzE9sl8tsBd1WQ4tnbvoPG1q4r6NaGB0pYrQmEf+/uOYG6nGQJzk6DDAUbb966hh6ccKBtwGaxpnY4MzcnRsvfBqdkmgDlpo1QROWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0DeyDXURRRUF+YtusSN/nhPiNi+gbu7Fi7hDBwbxRU=;
 b=FqZrD2G/OwkcjyjvjFl8fN9baH38Ix5/fLipL2odyMF7fnstyVjgvQ/b1VWw+CpOOQE/LYzRqHP3M7Nvrw+E8ypF3JY33eGrbUbnyo4Ll59+yIODxbSS2AT7I7QEs4zJe2nllv/MeyC7y1lDs10IGXkG99sYhT9XFt7+nZ3XT1A6K7fO0Xdd7mHjxEjwrag7KPDVttqpPpsw5ZROy4dO7BpxWn1J9dRGGgN2ALwdLL4OdQQ3Yg6kODYve9q5pU1oj7ZKtjrsrRQlDCU9xh5obJCaVu6gSlLU6S1n9+yhVbF7ecPe6qfPKsJVhPh3QwAu4Rk47fBHq28jpvJh34Fbrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0DeyDXURRRUF+YtusSN/nhPiNi+gbu7Fi7hDBwbxRU=;
 b=bbrUnqP5m1qj6srXF8LCPkGCkipj8AxA1tSoGKJv+BFetrpWoKRL0gRg4Ya914GwcgpFmljn5/kPzlFYNlgd3gAakxTalsqovU8/U6sFgKYkIEo3JyL2PxKpLZ66pbMHS3wuy3hSzcnpChGUrj+nhBOWUFVjAsx5mJoVVShF+ys=
Received: from DM6PR13CA0026.namprd13.prod.outlook.com (2603:10b6:5:bc::39) by
 CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 05:57:13 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::c0) by DM6PR13CA0026.outlook.office365.com
 (2603:10b6:5:bc::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.14 via Frontend
 Transport; Tue, 24 Sep 2024 05:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 05:57:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 00:57:10 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <rajneesh.bhardwaj@amd.com>,
 <Ramesh.Errabolu@amd.com>
Subject: [PATCH 0/7] Add support for dynamic NPS switch 
Date: Tue, 24 Sep 2024 11:26:45 +0530
Message-ID: <20240924055652.2678433-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: d1556167-6d15-496d-0764-08dcdc5dbcd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cz6YG6KncffNFP0bJimAwfKXyY1WwNqVuC2LdhngMSPYtntnLx+LXMvzfhfj?=
 =?us-ascii?Q?OspEKBc9OnwKFLx2uJM+fi/cskxAt7oyd3C5v39PfHAfsyJbpIulfVLvEXMA?=
 =?us-ascii?Q?Ok08AVajaDtTDK/jQ+nQSioPA6zCjq0gMr7QKAkgHOIdWzqwqFjSGqIN9Z7U?=
 =?us-ascii?Q?WSpNYN5axoJMK3/6CASQWxov3Hfnt8TrReJhRWeg5YfLukndaZoIPo5EsN6S?=
 =?us-ascii?Q?TsAES1okmPio6w8iSn9KLfSuD2fFRdD8irM+jvOdU+mvGFItEhcER83v8NhJ?=
 =?us-ascii?Q?Glm0sfPnK1qDAuzFrOZ7kNK5lpLBd8Cwh5YlbXA9a+RCAvrm7jmebEVaYsjJ?=
 =?us-ascii?Q?gEDJZzFW/pSXk/5j9zLXSStDoWt9PYbLI8/jfmhMoyKvWZFD6EFM9Q9aLPCe?=
 =?us-ascii?Q?T42NehMe2w4QH4xYrUPKCEirRhQwYWLDV4h9jQE+oWXcUAOOaflSuGy30t7d?=
 =?us-ascii?Q?djx2ULEg1exFJjt90V+n0A/K3fZp6H8Ow3MmPiQUZrDjD9wHpl9sU53bmgMr?=
 =?us-ascii?Q?hNBWgVI32UXjj20UL+BDGX9TKkWkVmfIMkca2IHShu4PiM+aM88645K2cvDP?=
 =?us-ascii?Q?5Mmnz3LHKtrK69EjNzsOFTd7oFEfOOFYmZ1E4Rgd5TjeTAb2B3WzFQfk2XdY?=
 =?us-ascii?Q?H/1s3IpVAVUsxoYPI2ya99bS1KVBUorfy9UfSJVWyGX2MQIWnn51hdnOFZQE?=
 =?us-ascii?Q?cPGoiQcaJ3xctkTDmg/odX/zjr23JWqgFaA9CjWDgXp0S+/chQmMRWNdsoYt?=
 =?us-ascii?Q?7FwyCcBV04g33HPRchmyeNsbeReZ7746u+AzPo+YPIh12L9DtDqdtilDNcxk?=
 =?us-ascii?Q?/5divVJhbbozfDJ4gBOwOn7CKSuybv/w66xV5SwQyO8mUFZEw0fIzhpfby5c?=
 =?us-ascii?Q?Ft6Ch4rP7mMGsXq139Sm2DxqyT4FN2355AynTNlfspHWFlkuOaZ75FUeMWGd?=
 =?us-ascii?Q?BHB2ufyuJBlVumBtKOvWNqiePwoZf7mw8gu3rAAFgfBLuyLYk0Q4yZIwvP+4?=
 =?us-ascii?Q?qlFIToPVlEh8QDFJQ7seJuwoJ7mll4NOXMWye6MIo8MGBUg5cvTf2wvhjT8i?=
 =?us-ascii?Q?1ecShKayJjHRhLIVXp0AbNqTLlJrNz5RkEJKvW0rh4dH50SLtkp86Yr1mkPb?=
 =?us-ascii?Q?gccOuqMhXU+mUgSu/VF3OmDV2KNu9HMs/H2UnSOiGopNBf7qd7BJaxvl1u6q?=
 =?us-ascii?Q?DKVKvqr+zdpl9UArj1cxPwyJ0ODJV3buZD57sWFpLA9baCDeReSVYmMkaGn0?=
 =?us-ascii?Q?c/NiH7f+hk6HgoXfY4AOHqGr1iAobd5YpDAO8zVLLWtQuXwZFz/Ul820pAo6?=
 =?us-ascii?Q?FI0JIDO3Ek767FrRpUV/9fnc1cX6MNnYU1s7R3qIlinbQBIc7iLGBjDdu9FU?=
 =?us-ascii?Q?GVoSRSi1wt4Fn/Og5op2IHEAJjg5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 05:57:13.6493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1556167-6d15-496d-0764-08dcdc5dbcd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993
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

