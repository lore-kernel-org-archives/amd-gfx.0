Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2538CA1010
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 20:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5F110E92E;
	Wed,  3 Sep 2025 20:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HzxPrFjV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0310810E92E
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 20:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGq4QO2JzazpNClgqE6GITBBm5FfTqSO7doZEK1VoXI7wJtNgVwe8ZpH4PzKWhbFydiaySzqig6jYiJcvFoCMXH8DgzsdoNO/G+VNubrxqsUv/tJn7DbUeghqImDwKqtPqgfMXC4uU3TZkyzkI1+SLE9OE2vr8zqxJ7FwNT7YK1t09UUWv/cI6HMsG0JTwtcyfQ6v0nvwnEKpuiME9Ki3wDZ4w/EF73yCR3SIqiGpvzvIIDmSqH1gKwsjmf3X5vojBKnTaPczC6Q89ZnnpAGpGNyjz2HNdi/Wt+0S63EAnBe3oNJi1uFzkKeYVSGIeeA8aK4yUqtJyAXn5iHdA4hZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXcZk0xYe9S49agRK2j4Qwu8QSnEdhDs1/4sSxQ5CXU=;
 b=c/64P+ykpyTcT36F1I8eAPNsZcaL+sCsApGbi2u2O+EXtVeutzoZEb52VWikQzoQjj7UlwgRfcvUcfsfVaH/7JL+d3GgX2I3BZmMoVbWhcWRArFiiXv6cE9JmOafFU5vPhLG4LKwm1G9JM5rLZNtA0FT9YYpG0hgWjOH4KyZH9gMebC0/pZBmnY1hQK3oTmP/vp5fW6mM0hszTbBVHi0nU/h/OViylCA50bgHivqar87tSa3k1NjQMSTT3Ug1GvlsiL1SkFGZMmnJYJD1eGosX+0W0soETKj+FDOyS3QQbPQ5nd8bYrWZsKW9qZfY5x21pAUtEE93RTt8eqhNPyFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXcZk0xYe9S49agRK2j4Qwu8QSnEdhDs1/4sSxQ5CXU=;
 b=HzxPrFjV4T34QgWPoL15nTTLu9c+fDjcu8kFzrqbfJGV+ExxiWpG33ZGccr+STNIIqpNbNyrVKdPowZnWwcqFI7amA8c8UTcx6T08ik8WqAeXoxhIjA6SXpLaKEDI5MHXQ3f6zXU7upEUp8/2rkgHJawNhHnW0yQIkWm+n8NruA=
Received: from SJ0PR13CA0086.namprd13.prod.outlook.com (2603:10b6:a03:2c4::31)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 20:36:23 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::9f) by SJ0PR13CA0086.outlook.office365.com
 (2603:10b6:a03:2c4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 20:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 20:36:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 15:36:22 -0500
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 3 Sep 2025 13:36:22 -0700
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <phil.jawich@amd.com>,
 <xglooom@gmail.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v2 0/2] Declare isp firmware binary file
Date: Wed, 3 Sep 2025 16:35:42 -0400
Message-ID: <20250903203601.839525-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: dacb6d49-ecc3-41f1-01cd-08ddeb298c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VkQSmUVOtTg6XG4odpYBeTfsKwr3aCeW3X6UzRuZRsxE0bthc/a4GOKQXOc3?=
 =?us-ascii?Q?uX2uM3ykVpzODs5AO14qeLkkQ7QdDd/g6SWqiMOVoOvIyDpiProRaEjtoS1R?=
 =?us-ascii?Q?u/XfPCKvXVp9xAinKNYA7s6gv4BCaY4EQtzPv93w1iHXYQ/UGHGsaU1ZwOxA?=
 =?us-ascii?Q?9livsk+y1+EmxniPV9MmUhOT0yT2vr6OJER987Mix+Mhe1Bv7iGFHj9LysNP?=
 =?us-ascii?Q?dy6WkSh+8EBuVXvVkfEto9gfGZRZp+wOuKLUffReb8UQFGzlAHAIFEH3yh9v?=
 =?us-ascii?Q?PcioyTcD7SlrQNBar+Jd7Kje0avj1lszTmW0b8FlxBsLHYT5KQPI8817xW/H?=
 =?us-ascii?Q?SAbgJguKy61srkLBpBoRgj1AeNsLRAXztBQsHzUMYBBOeN1wD/zKxIsAp9wb?=
 =?us-ascii?Q?yiukktO2lQUKUAu1Nl1Co7uQ+XIhqlh0VK5Hf70ZOfxAukN5t1plJTW9dhzj?=
 =?us-ascii?Q?/yv0O58QCWot6lZb4h89iy3DXlynWVZKOtmirDeaxQ6zhe8CG4PgThQaOYtp?=
 =?us-ascii?Q?1c65+hh5P5+frtxbyp8enpa4UZXazIuAoMvo7OVTs4irOiVEild42GEx7RZR?=
 =?us-ascii?Q?dqim2N9ESWMett+RgyUdp5yp4VF5fLDhj2Q1xHb5uUzZQxBTqfjTQ5WN7xfl?=
 =?us-ascii?Q?ET+Fxx6I/ePlt4kjsJQhVTvAsnGqQpt8z3KQStcsAC/mhgyaYFRUFX0d9Cxr?=
 =?us-ascii?Q?AS07g73Q2/awpuijy1091GX9zTyrkVB176Ygj7VoizIRbANp29KQuTkBN2IO?=
 =?us-ascii?Q?CvFcqN8e6pFA3dr/mu9Zp352BxBOQZDZOkvsYYL/l8rOUCNFtU7wPTVx9VBy?=
 =?us-ascii?Q?7qCQTO9J4cvgW89d8AU1BHPG7DVPYzfGwD7oAoZRL7Rt5Y9ThLbFIaUkdnzS?=
 =?us-ascii?Q?LRoXjOjIORwsN+FKL4ysQzeH4wS7RUeitRIU7/wgSueLgt6WG6VkjuDlCJXk?=
 =?us-ascii?Q?GVeahUollTn+fpqUyLSxAX2jnvf+GieWBOP+7lCOEIRtFI/u54PRmVoeXnPW?=
 =?us-ascii?Q?Y7su8WlQP0nU8ObrOcJiE8qTSwOtrl/Nd/JJakOujw6NUClaCsbg+q8YEtxj?=
 =?us-ascii?Q?jC+6JnSDGAKJ/dX9rhOJousjBEHXvFawVNdQM/hEbZtibk2OE2lqF3QDoB95?=
 =?us-ascii?Q?2NJZ6vHzFIviI3RXxvyazsTUOsM3Jeh0v6z1ZAQPJIljNW4bw4xPA5rJit+K?=
 =?us-ascii?Q?+tHAj2a3wocsBU/2EpEH4Ih+us00vuOP49d7ogKYrt49VALsuWjKXgT8b8TJ?=
 =?us-ascii?Q?Qs9oPrZ/090Oa8UxIYBeBGc+ViliFkp6gnP3q4BsvxhCcLrha8qi+UCTVnfR?=
 =?us-ascii?Q?3XqpY7aRGw/ync+5EOHapv03hmGkEzS0kzIglqXYHlUqIW2KDEwy1OdSMNuz?=
 =?us-ascii?Q?27pIg4HUa8TP5Prp8xGvWCmQ3VhPNnhgfkpcGO0eKZXj0UIvq9nJt4AuOlwX?=
 =?us-ascii?Q?hWI9vlsJXRpRRtGljPD2fgIFUUpGcTZjXuIykDf+1sPGQDfpWtqFIE3BVQkl?=
 =?us-ascii?Q?XNCTtLCEd60ovYIa//gCLj4taQGlDslnLnK3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:36:23.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dacb6d49-ecc3-41f1-01cd-08ddeb298c5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749
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

Hello,

As suggested, patch v1 is split into multiple patches. Please take a look
at the latest patch series and let us know your thoughts.

Thanks,
Pratap

----

Changes v1 -> v2:

* Split into multiple patches as per the review feedback.
* First-patch: Moves isp firmware load from generic amdgpu_isp driver into isp version specific isp_v4_1_x driver modules.
* Second-patch: Declares isp firmware file isp_4_1_1.bin required by isp4.1.1 device present on HP ZBook Ultra G1.

---

Pratap Nirujogi (2):
  drm/amd/amdgpu: Move isp firmware load into isp_v4_1_x modules
  drm/amd/amdgpu: Declare isp firmware binary file

 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 22 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h |  2 +-
 6 files changed, 37 insertions(+), 17 deletions(-)

-- 
2.43.0

