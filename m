Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90672D49C76
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36BAB10E96F;
	Fri, 30 Jan 2026 08:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wTDO1V7i";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7AB410E96F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEtqwPY5FA0qQ+r57Mmys3zqg6SIQIoZfza1fZZroSUZUb8oTF74LfyjumSWq/JSKCj2Q6tTgy8YyJss0+4/86sRtUZV8haQQY6xEaBgybM88+oOxL4/w6D2xPPqcBIDkiBA5nkKcunemM0GLcrozhNpwxZ531L5X6xBcaGNM2/Kc+Tk4cWjm2JPJPnY+NHOARPlnjRLDDlwel8jzc8fQQ+GRQcuxewVmsQv1qrr5rYki3yWCq519FfoI1EEYn29JkIDcSriL7pWwR0pfihF2s2kXFRAmka5BrGJjmSIM5u1WnbRYv7zuFxjkhrLZAvqpM+nbSscBAUHtgISPZ9Uzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvsFvoZJJOBArwsYxhnmKwi1yF0nFzF97+Ar6VqjlkU=;
 b=XIk8PJDqo+6vAATGnmvKRL+A6M3aFF0XqiTXtkotGj1ioMiBs6CPrZbu2IdLXip/DjVm9wZ8/Vby/fyg+enIWKr12vsVi5bNnO0mu8s7d6mckX9FezUgcNJRIY5MSVu6yFNqyrn/Pruma0B+xryg2xXnuDScHv57ZOhpFhNhiAbxp1x2B8hQXgsfVZvGsshrOjBnqT9jTmMfDhxXeT/RJXpbkQDsXH0SPoTdtIDNenbNl+QO+KFod8gl7xBBZNb5k1W0zqZ9Ud738/1KVdeV9jWpIOOvGS2BVpPP5OWWv47LMbVcQCklYXMpHspU5XGKjsNLDpDOIVXMXfdKmfPd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvsFvoZJJOBArwsYxhnmKwi1yF0nFzF97+Ar6VqjlkU=;
 b=wTDO1V7iyC9LdRMToQpHOtNxP7KL+itj9jYws1fb3CXMyirT9AcFiAfW6k/zuRUVEeJPGrH3y/8cR38VdSkd4guaQSZzERymkE8cjXxaY66Q8paSs9s7z96PhrPSIF5rhDmp1zWvpUX435Bwxgg6CFRm8TlLEzKhb7e/OrSampw=
Received: from BYAPR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:74::47)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:42:03 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::89) by BYAPR05CA0070.outlook.office365.com
 (2603:10b6:a03:74::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.5 via Frontend Transport; Fri,
 30 Jan 2026 08:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:03 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:00 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH v5 00/11] Add CWSR support to user queues
Date: Fri, 30 Jan 2026 14:07:54 +0530
Message-ID: <20260130084137.2906792-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ede9f85-e6a4-4866-c787-08de5fdb7124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e+B91gp9apkvGDMT9/5Hj2WJNYptgcfghw/Vd3nYAj2a99s3tHoY7RTYixWL?=
 =?us-ascii?Q?0SfYBn2cQ5bmID9bAHcybXemIHUeGCWsMZQOT1hEt41NZbQt3XtooA2iz0ZQ?=
 =?us-ascii?Q?FU9hQDFvKeWzPkIKWd++e1mtfpYWfupzHaYMWC6x/hSa4Lw/WsuuGvycvuUV?=
 =?us-ascii?Q?12v9ySLHW5YP4bmZP4qw18DeWap5cUDGv+2W3zZkWIL4Ka3D4JWkTxX1C6Pg?=
 =?us-ascii?Q?pST5C9xkX2zIC4UvdhOtoNERne6a23+YW26W+JLCL5yCUpdY8GnKhTM2oIWu?=
 =?us-ascii?Q?LCnhkhCfdBdYCi0+skjJhE6eDkXRhm46Pc94RstCSLD0spAr+QJ1Epi9YDZm?=
 =?us-ascii?Q?jzjw9/tEvsjeDlfgAiMazfCwODe9qnlgB3rz7LjJgF685s+hMxd7M644keTe?=
 =?us-ascii?Q?w0Kjdqa6OTtwmL7aD/SnAbZLX49Vleh3GevJgk3cHbu1TZV9LZcaaIbsN7nN?=
 =?us-ascii?Q?iZYGNCIRMGksCiRdw0nIRoi4EiXSPxNN6VBWb5jPuxcp9qIvRbe7b3RKNUv8?=
 =?us-ascii?Q?aSyFE9+7PXHLWPAf+auZMT4HZCWE9Etc8xdN1uvmzesiayjAreAuKwN6tYc4?=
 =?us-ascii?Q?SUPwXVFvz8zIwo41AQQA6bEgaRD+SsdDR8dgyRIrm7MKvFLQ/HDO199FmAD5?=
 =?us-ascii?Q?6AsDyBve/+tuMr2EGA3EEoYjAJgcFOFl+uk0xcqFTGIx+JNx5UUSNMYSuT8V?=
 =?us-ascii?Q?hS6qwB/Qrtx1E90BsvJh2kgHvg68Pc2/3H0XidIIrIGSJ6gXuP7oUfFMSeWN?=
 =?us-ascii?Q?f9g+Znol9Y5i9nNwkp/3aBbC4I2Zv+fxqi5XyGhr8WQmGAjGn1KzvGUpwN+J?=
 =?us-ascii?Q?CzWinecQKyWd0N8rgNIqsobYqNOUXjPSbXNGA/oyiGoMDQ/CuKOJVYwbukS8?=
 =?us-ascii?Q?MhYMhjgvMjBXjvQs1JLB4QGjtANdWu2P0RWr46KyGpoEzhe/rQv1vK34CH0W?=
 =?us-ascii?Q?n9WOslnzPXu2o+nue+R6b3hIngzDmNz3EQkUqtn02onLEIuw4/UMQe5pMzx4?=
 =?us-ascii?Q?Zgtms4Ut2um33ELDxX+KfEe7QBVUvNdVPLDsWMxytVk6rKuWk+ulL1PUx92Y?=
 =?us-ascii?Q?e922oR/BNeZZWy/75KlfZCa1GJ+7kCw6vxa0kE7ky3TrUxr/1A5GUSH5g0Ly?=
 =?us-ascii?Q?l165yUva3YZkCu7vnRyc1lU3/Lmmm21ilfjWTqOTZyBItGzVnarsloGCgxET?=
 =?us-ascii?Q?0ezSscC1wWnp6dnfEtx60W/qgN9Za89E2rRZCEoaVNHBPQJSrMsw7UtGKkpF?=
 =?us-ascii?Q?HwT0K0t/lnSWBvupzbszYJ1dwXkQodDz3iLq9f2pI44yF9yY1iwU+fY/ASSH?=
 =?us-ascii?Q?KPKqTYxdiXBfvEgiL378bTZmRWajfWBmm6QdPAT2R7Tlc2QRF5RKQ9QfevJM?=
 =?us-ascii?Q?ceWb/e0qQBkkHNR0xTWV543fU0d7U+l9bHy5VUmLp3lRgOfE6KMaAYBBbmr3?=
 =?us-ascii?Q?sJwOv7xBp6mxudOeGoOlJ5K7u/jfo1xrsPjcE1NkNP70v75vC5Lts6NFJCx7?=
 =?us-ascii?Q?QqfTNK4+mvuclOj2HR3OJJGIYYzRw0CVHuyUbMSMuqWkBeMAULQT6V5BUTXI?=
 =?us-ascii?Q?chSwr5wx537x9RynNmnDpVn6YG7E5d1bHHYTV74/ba//nk1JKK/lcwldBSka?=
 =?us-ascii?Q?hAvzvux46XzaDv8DzKGBocHsrIzDb3oum9MK/F4HSh7WQTLF20k5Td1/Rilp?=
 =?us-ascii?Q?ZAUtuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IYwL61R4xelAPSen7q/iiJMyOQ7nFpQoxpzkEY63ALlqvHnIAS2aq4Iu34iglfw/z5PP1FC2ZTgdzLDb7rRBtsEWBzSXRS/IiKVDqYex2hJTibCUBXD1E3s42zC8/0CcujLFEdLfoPmZH9Ha8g3rXh+KK+olstVCrFsdDC28ZhMvkOxXrRU1vO3I3+x4pgsSPOiYAjL1doQEtYaKI3VUgpI+2GFtRk3+lKIJzcD+nImVAdvUKsDp+wt/aRVpRzxTNJzFxPNh3N5DcsiDowgCpEQLQNwKH0Ks0Ve813dyNxgxXItPW7QoA24eCsNgPTsRumjn/8MvjxvLpkQwNrfaq3zUJtyHnQ9RuKmzQdGiGU7vIMPgH0EDe2Q3XO0McoZk+wQE2f+P/Y3tr+di4mhVMiX3rKPnSHK0bNKIaY1BFUVWcszM1tTH+1DNyjTUkRTC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:03.2562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ede9f85-e6a4-4866-c787-08de5fdb7124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
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

v5:
  Remove control stack size from input parameter (Alex).
  Add upper bound check for save area size (Alex)
 

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c   | 629 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h   |  99 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  29 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  22 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  14 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  33 ++
 include/uapi/drm/amdgpu_drm.h              |  51 ++
 14 files changed, 936 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h

-- 
2.49.0

