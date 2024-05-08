Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98196C25B5F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 20:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139C811296C;
	Wed,  8 May 2024 20:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uoUD2Rhu";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF13811296B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 20:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiSgS66dEqcNkjG5ljO//np2xKO1VKcrcuj6bbNAT1HXB+9IIXNBAGptUWz3voW9JQ9MMJdjha3zrnf7JBV+Hj4Qxmb9xp+ZUdselOGpy3f28JsH5j9EfVqgjDbnLSf/6hx/ld9VpTwyFfPGUNajvkw8fsTsKmkCjPLGqy5T+znIUhy9S4+mcso4MKQbK5oMofDtagA98PrVW/xSMXW9xsJtnq8rwAEknqoWQOGQ0Poo/Y2/mGyv3ZP1Z/56t7RU3lqCF8vbPO8aS7o4uE+S0sEW7dRKwRSyB591dkDDTt4QKPVWKKfVgeUHWjlmTyR5FtpNEjHBl5bZHb0mA6YtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ir9Fqc6X0VBcue3OxkBjjDH6ZcLTeKUSyKZjP6gH1xA=;
 b=NrTW+ILZQuO942kDjd3NX/eXmRqJ62y0nFDMlXS++gFsb2FhL2EjLuJguHbOMQE03DzO79jIukAB40yATj6MxlWuRO00nhVT5IoaufJXUJvscG6kDIoojm9D/AoLQdI3Bq5mRv05PbGWNgcxz2V2vkCFNhXM37GOpbwP+yxIrg2SZVwDLqR6OCu6Rxko01ZL7Di8ftDCuvNe7h3sstdaj+W0YvnjxicPqZLMH66Fau7TT03jrVKOZ/ZsrfmK0Rd/wuAA1V13qZt0DrqdjkW9XmSk0nP7z1WqgyKU8dtXEfRjCC62tfbWAqsqTBhd9CyCtTC8cMpc1Eg45gA1/ZcSCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir9Fqc6X0VBcue3OxkBjjDH6ZcLTeKUSyKZjP6gH1xA=;
 b=uoUD2RhuPTI5sqQ3slHhmgv6KQGWZ6h8gK5IQFbimOpOc0xhooJ9iY8/zxNaXnLDFkzPp9oSLw9F3vNrzzWImbS8d/IrG8Q51MtrPUWc03dcK6HnnY8kGSpiwH7X/P78KSEDBp4c4mOP+slob+EdtybqbEZmw/NTK4EI6+PnfNc=
Received: from DM6PR07CA0068.namprd07.prod.outlook.com (2603:10b6:5:74::45) by
 PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.43; Wed, 8 May 2024 20:29:07 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::6b) by DM6PR07CA0068.outlook.office365.com
 (2603:10b6:5:74::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 20:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 20:29:07 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 15:29:06 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH 0/4] AMDGPU userqueue suspend/resume
Date: Wed, 8 May 2024 22:28:33 +0200
Message-ID: <20240508202837.1411-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: de4ba29f-cf9c-467d-61bb-08dc6f9d82d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W8OxF0KhWjrFcxJ+hdSAlSBjQDBBaW8AhaBHB9COVqOS0cZwWagYccFP0PKe?=
 =?us-ascii?Q?oSlOhtD7CMVwH8aiJblsCvFVz+7Y44y9/L7bwuR3ERNeRuxcAZoBEDjFedip?=
 =?us-ascii?Q?QLa6QAlio7DeqoxuQUr49cjQigo8Q1uvq6QpzaX1DvVuEtPAIhGg5u1H+f0f?=
 =?us-ascii?Q?bDV74GnWloHBltt/glsF9igA7MAhEyAF7BlndPrG3Uk/xvMjL2tYJB1oO3qK?=
 =?us-ascii?Q?wU8KgIdLT1ZFFyT01Baxp1McNI+ZbsTNGYVbMB5JsCrLYOKgGxqQ1IBGC/4u?=
 =?us-ascii?Q?uHR81N8jjjJUm8Z3oTiZiZgFeFgehjxmhub4H6se8i86NMy9wZOxr/tr9QqW?=
 =?us-ascii?Q?E+pJH7NgV7iValPMVwbIZeaKkbUT1fnwN9NrTx1rMbuV9jm/26zCl2768Pfk?=
 =?us-ascii?Q?4hMMs+UYS2Ih/bc2hcKabnvHakUI2uE6dk8umHifKh9b5hwcxgc/TOjN+svs?=
 =?us-ascii?Q?wBkCCZkbr8TPwC8fcHPioQ5v/R0/HV5secEGTXYtUrxiJ3nA8pxU7YvDbQyt?=
 =?us-ascii?Q?ePW6mgyz7d0dEot9kPmslGxYjmxu5m/O2gzZxjCYtC0iBeePISqqLAdat3uv?=
 =?us-ascii?Q?ZubFsT1Dk369WCjvXcvxoFe9R8Ir7Uo+p0eMYZ2b/HtJJKCqJrLT1hkb4Oy9?=
 =?us-ascii?Q?1iG8SM52cWvjLQpbV6rmiGdmYKSaTRCzOQLjsX1GlYXGaT5ilKxM7r3pRXjs?=
 =?us-ascii?Q?ltJsNv2MQuqYrtNZ3preJdE+zvQ4v++GwXnELPzLbmmVs+c76wlUZfjmGNiT?=
 =?us-ascii?Q?sLwfYdApeB+V2c7Y1xxVyOcFfr8JH/rA8D7KcAw4l+iUUdsrnIyZxJJZDDWm?=
 =?us-ascii?Q?UNOL/svOqwF0J/KuNUqmH8i5/PbaHK7LI5RV+HwjS+IymtejlBUUcoFQkixx?=
 =?us-ascii?Q?SPuQCvxc0cnjDeR332QziLgn1pNC9mPNtSG+4y8mtuaswtn8wQV8LDfhEx+/?=
 =?us-ascii?Q?50MMFk60BZBau/3ojtyTyg+KnbsVQCAp5UiOMaeSrI7LhsOMGHBswxxoR3jC?=
 =?us-ascii?Q?HoUsBSunvuIKMpE6ykwIdVO2l4jW2XkBgrRM3oDThGDGztdicIzogX5VXh8J?=
 =?us-ascii?Q?z1Ud9qK+Lvdq3QOp4dUtLzaewChU3uN8EuzQ01MKJtKuT00LUNgfcxvT2LVW?=
 =?us-ascii?Q?oUkVLOzMxH01TzUKIYnE/Sut9I5VL058mUqKtB35GRsAUiwT3tixY0ApGei+?=
 =?us-ascii?Q?E2EaNv/lWYCYKso+LkkLXzjLMWZphQhVdkc+UFHG6weS6cxvkEkhEcLsZ7Ko?=
 =?us-ascii?Q?daSMTtfN0cX33H0JYmLw4VaQ8EXxVyvmqp2K9ppFmU4KOvDOCvCKyZAnocjE?=
 =?us-ascii?Q?rgcuEJjO+HOEFlVU9VDyCblA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:29:07.4819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de4ba29f-cf9c-467d-61bb-08dc6f9d82d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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

This patch series adds support for suspending and resuming the gfx
usermode queues. It also adds eviction fences which are primarily used
by usermode queues.

This patch series is dependent on basic AMDGPU usermode queue series
which is being reviewed here:
https://patchwork.freedesktop.org/series/113675/

Shashank Sharma (4):
  drm/amdgpu: add gfx eviction fence helpers
  drm/amdgpu: add core userqueue suspend/resume functions
  drm/amdgpu: suspend gfx userqueues
  drm/amdgpu: add userqueue resume

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  21 ++
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 112 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 243 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  |  31 +++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  12 +
 9 files changed, 437 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c

-- 
2.43.2

