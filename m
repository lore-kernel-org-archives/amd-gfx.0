Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E5EEE0213
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 06:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2A210E183;
	Wed, 11 Sep 2024 06:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BZLHBcst";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B1910E183
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 06:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL3Rlrq8GwAYyJoF2PQTD8bkT7Y1WIgX5uOp9mUEZDA3xDaMxLKIog4G5WE5KN0vRJ8zdopDRhZ4SuWyYU5OzLGYW7kByM6qtBj0QV836EeeJG1cTzH+ZsU8IcLNr1/VVUQ4oRGZYAn765+6wE3KeecMkKVUJteo7DHeCZBFxImVbOGGr7MkyfehDL5iQMxmIaCuLeZP0z5PQwGpaS5amEXi6mJ/mq2vD0sbisgHq7/ObM1vZL2kcRfYkDBk8uzSZTRv7ejlDOARlfsQdSlMELqvGi3C48Bc29D6oAWrwA5o4SGUFkKyuCzWPD9YzqO/xp3hU55GvSc0azYcx76nqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPDudZ5fqam+6q3V45mveSApgp/dQ5oHQB91TcDHSGY=;
 b=EaBut2B/WlCdeQmWgQ0rvJGsHp8ntBAohrWHOKjby2DmDjHo1LNICvAZuksRtU8BnOolnyp9DpDxBUM4r56szjr7iBwqbTS3BkQkIHOJ2Lg25BoAzW1Oib6U3C4EdlNyjBaRknl2ejruW7pIMMA0Igb9bgl9wnWAhlUVPkLY5aD7/WT1IQYOD2xIxaQ6qX9kqJoBO93JXz3wpxqvHTTD19NYBHS8muEiXF5T1c5DKHZT8pfzb6mtVorG+DufMClHZDMP0lQEvfRKFeStvoD1CXj2wvYYZw+YsD9VQVptxB7wcO7EqEU00U3A1KKki88HSEkGI4K1g1ZS5u39oEV2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPDudZ5fqam+6q3V45mveSApgp/dQ5oHQB91TcDHSGY=;
 b=BZLHBcstbEdbJTba7x2OX7zGtdwtq+tLwYdiESFy+kIvVRLq3YQNUTQpMiUi1VVna/8zmb3h6aTTmY6bOHDWWZuxMSO6IDDXPrtyYjLQNDvZuluhg8v4Max8LAsoF1oDb30nSjmF3xN6UJuinGeUGW+nLmdhBiXzLAMfC8OhJ2A=
Received: from SA1PR05CA0004.namprd05.prod.outlook.com (2603:10b6:806:2d2::29)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 11 Sep
 2024 06:59:52 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:2d2:cafe::8f) by SA1PR05CA0004.outlook.office365.com
 (2603:10b6:806:2d2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 06:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 06:59:51 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 01:59:17 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <feifxu@amd.com>, <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v2 00/10] Support XGMI reset on init
Date: Wed, 11 Sep 2024 12:28:48 +0530
Message-ID: <20240911065858.2224424-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 2842b046-0a9c-4883-bc4c-08dcd22f5575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wr36GRsDlerlI1T3wjG3EXDH6UD6HDSDBjbjFstAFZUR1tDSXkwfzg87sw6A?=
 =?us-ascii?Q?2I0pMn6GSVarrNAYUSyDPGAut6VL4YZ9wpMdxFutc8/1IT0OKfrJki2eeqOY?=
 =?us-ascii?Q?uwUBJu+aqSiuZiq+twuxANNyxNq6todhWPc/sVug+QL4it2B8/LA+kaJbWvo?=
 =?us-ascii?Q?LwpTvwO4s82OxLyXlEQKinXKFfCXkGB64T/7MxXXk8Uk/ypfU/p5Vh745Jqa?=
 =?us-ascii?Q?AyrDsWNnhMrXbZZRs3EbFB/VelTq4+NATjahbP9I48sjeArPV6oo3AD6YiSE?=
 =?us-ascii?Q?AWQrXp1tNk/shAE9aL7KXoQHvjNyj86Nt+xVTYkAmk2iNgNlqz4XN15r8XUq?=
 =?us-ascii?Q?AUQGR6PoHsbZsBHoT5TBOvfFLkKHhr0p2NNK85h6an2alvk87q1SB/iOpyIh?=
 =?us-ascii?Q?2o0L13NnzqumzJOHFbTG/BhpIyW6D+z4wsXfX71eDTen1ndpQi9cVreD0uRW?=
 =?us-ascii?Q?fMPs9Tapt5zjGhGObBL/lc738VHDga0F784W5AKZqMZ+aQwZRaG82VCBKI4c?=
 =?us-ascii?Q?rJGJrRbeM/9KGp0xFkKPQLgR2V/qXcxH6urpivuz63BjwTX1UDvYv+CprBgz?=
 =?us-ascii?Q?Wq6dpX3hqoRXuApmhpOilFpsMzTsxA5w5spYEghvJE6WoMtropQfA1dkFa+S?=
 =?us-ascii?Q?ItA0vjV8nIHkZ/ZIG7Jv/9iAOH6U7RP4c0NjVndFSEOO/XD/eC0LHPPFxs7P?=
 =?us-ascii?Q?Bmq4xjiEMBAO50jQ0jLCqYmW5Mrvs9uvBjcipuzXzWgvfAQKvFyt5/eNFXLy?=
 =?us-ascii?Q?2Epzr4MxkOc7dxHPP2DxErUFQgNqycV5lSC5svtIyhG55H1CKnDj4Z+cERpR?=
 =?us-ascii?Q?+PliA3uEGUIzNq6lkEtROSjdUhpVzsWS8eZBQJARUROUztYM4NpvLP4V5Jnx?=
 =?us-ascii?Q?hCyyOfrNPsaZ3AXGgp9/117TbuRVOyOxrDIZ3SlHsSUBpJYeR7fR+XmUBiWJ?=
 =?us-ascii?Q?B3cZ67ClMvLfI/V+0a7REwW8iFmJG4nQsmV/jGUZ+63GsFnOblDi4coEdruA?=
 =?us-ascii?Q?zqQHfsJvMzkn6slBGXgazAzMlo9Yj5BFhwJYqTgP/dp1wMUEuNfcePfeou6R?=
 =?us-ascii?Q?APgJ7NQF3hog3sJwtnXsp0KGWzU8hSu1g3wBxDF2TxIcireZfaa5QqK9od7Q?=
 =?us-ascii?Q?cu6xf6xwx8roYmJAXlrfObQyd8zrLcZWh5UhQdjgcVdH+kc59okSdPBZR5gW?=
 =?us-ascii?Q?eitt70s7rp7FBRRc76AH0RMVxBwBDzzOZb+51vAM/BXou8/yFq4Tg5hCv8Hx?=
 =?us-ascii?Q?2XPwaeVVC0H00a7Gw9sDjg8e5wNJZ9LEIHty8mbnuINi6y8caF9JNrruhipT?=
 =?us-ascii?Q?kAuhFTOxXr3J4Cy1lEKxtnNZUCfAkIbdNmcUaxbQtRCThKTScXMgJMNQc9ug?=
 =?us-ascii?Q?Y5MBixE9yhDWxLi0uJFVR6AKMNh6EVzDN0BZ4Rpn5NDO7T1MpuBO8oP27n7z?=
 =?us-ascii?Q?S6esPv8hJZKtQ6R+8W5n7N9v74Nj71mh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 06:59:51.8217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2842b046-0a9c-4883-bc4c-08dcd22f5575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
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

There are case where a device needs to be reset first before it is fully
initialized. An example case is a driver reinstallation with a different version
of PSP TOS. In such a case, if a device supports reset in which PSP TOS is
unloaded, then driver needs to reset device first and then load the new firmware
components.

For devices in an XGMI hive, a reset needs to be sent on all devices in the
hive. Thus driver should discover first devices that belong to a hive with
PSP support.

There is an existing delayed reset handler, however it has the below
limitations- 
1) It doesn't discover devices in the hive, instead it tries to do XGMI reset
for all devices registered to mgpu struct. mgpu struct may have other devices
than the one which belong to a hive. Also, if there is more than one hive, it
doesn't work.
2) It doesn't take a reset lock and since this is a delayed reset, that could
result in unwanted hardware accesses during a reset.
3) It doesn't initialize RAS properly (left as TODO)

This series overcomes the above limitations. Instead of marking a pending reset,
init levels are defined where the level of initialization may be defined. In
case of a pending reset, only specific hardware blocks may be initialized. 

Further work (not done in this series) may be done to have fine grain controls
for init levels - say skip enabling features like DPM enablement, or skip
loading specific set of fimwares as they won't be required during a minimal init
scenario where device is going to be reset.

The series adds an API interface to check if a PSP TOS reload is required.

v2:
	Fix logical issue while replacing pending_reset flag with init level
	Use consistent naming for functions/variables

Lijo Lazar (10):
  drm/amdgpu: Add init levels
  drm/amdgpu: Use init level for pending_reset flag
  drm/amdgpu: Separate reinitialization after reset
  drm/amdgpu: Add reset on init handler for XGMI
  drm/amdgpu: Add helper to initialize badpage info
  drm/amdgpu: Refactor XGMI reset on init handling
  drm/amdgpu: Drop delayed reset work handler
  drm/amdgpu: Support reset-on-init on select SOCs
  drm/amdgpu: Add interface for TOS reload cases
  drm/amdgpu: Add PSP reload case to reset-on-init

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 258 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  81 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  62 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     | 149 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  73 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  14 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  25 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   7 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   3 +-
 17 files changed, 516 insertions(+), 214 deletions(-)

-- 
2.25.1

