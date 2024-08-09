Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBD8C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 07:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C8910E869;
	Fri,  9 Aug 2024 07:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IJkEljhy";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0AB10E869
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 07:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfXeLzSh45azv7NMnn/wDyLpW+GvpR9cenQUZbRLH05d4+xdzJ9C5k2pNHLnxkg9Zor63q0oCXzWe0isF8dxcPLnUucyz3zpCbvW8XImfkIzvGybGuhdUXFx2nTY5Wrqy2sBuszZv2c8UlZ1VzgIdtR0Rt6OLK3FS6jivJww9hu2TQ3aEJGwcwLBd55etBFa+OzM8Xtme+JGrFxj373qO8kgUR2HGkmEORuyfyKkazNB19HQ8vZnRr5RW62A4mvHk6zXzlNxGyd0swbGA3Q8VuU//8ur39HO5M7On+hvx1A+09csKywmgVXK6DOFIHFeTyabuFB7mao3LLwxdSB+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVOqphb6yd14ZesipUErWnTOhn0MLAlX9f6xS+OpnK4=;
 b=IiOwF5Td/dQ/qFOGP7Rv1iaP67NtUhL/G7r1bSFjwrKKZAIrYaWKrETMJ7GTr1P95/2wVwD2J0DuvIuH7FMWqN0rTRsguRi9ZxU02WYuCZ26gIzhMEwVh9LCslo3XepNs0CJs792V1vcf41mrdJv0kyGFtovUeRm8eSan7DLvcptm4f98apum/DJERwQLicqAPsSf0KmRb/HjGbvj4I/tj83VnqnIKWUY2uzx8nOlPGtYYnlGdfPnTzXb5ON2AoBNG940+3aeZrWVPqFmBAZrEj4MrTKSJBOBlnaxy5AzcWMcjeUS5WHnUm8h90ggKNkfixwEHQ0t6Id4unILTnFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVOqphb6yd14ZesipUErWnTOhn0MLAlX9f6xS+OpnK4=;
 b=IJkEljhyI0SJgsYbNy0gYpEi08BiGcrCnk1yF8hw3RAZtoIiWTuk4nEp4DTOFnsrwMmvGJsHG2mJtO5rHckgt3ni3zDZlIasAXBglkWJ7oT0u4MZ/LyT7Ar8XafnC3+DBjgnHsGDBqwz8znE2tHhGuVCwUADCBDZVeU2n2Mx4+A=
Received: from BL1PR13CA0293.namprd13.prod.outlook.com (2603:10b6:208:2bc::28)
 by CH3PR12MB8849.namprd12.prod.outlook.com (2603:10b6:610:178::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 07:37:17 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::7) by BL1PR13CA0293.outlook.office365.com
 (2603:10b6:208:2bc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Fri, 9 Aug 2024 07:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 07:37:16 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 02:37:14 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <jesse.zhang@amd.com>, <bob.zhou@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: ensure the fw_info is not null before using it
Date: Fri, 9 Aug 2024 15:34:25 +0800
Message-ID: <20240809073425.54632-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809073425.54632-1-tim.huang@amd.com>
References: <20240809073425.54632-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH3PR12MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: 3deea931-104a-4c6e-42b8-08dcb84617f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?15S51gJSXeifzpnGtEkJ7kRsrems84dQTubWrmotDclMttv12P1blYxyFFcA?=
 =?us-ascii?Q?SnHwfXRe6G2WJjP9KRZM4SCyHCeCUtH37zvyCIih8VGcjjCYzskSTbVir5Ap?=
 =?us-ascii?Q?bmzPOudw5Y11q0lCi9MPpcMDkyy+DFQF/tYQB3pJ6u96Kw9lOQC1el9xtABB?=
 =?us-ascii?Q?4RzS09UNR3KuuEzcxECSpxFUL1bZQBlnpfujsLVqjSAImFZBIhsmhuVV6M/z?=
 =?us-ascii?Q?EXGjkYXYalXX9RMwNDQIm0s/HPI2hbM0aYCxgxDq8xJGnuVOVlXhzokVnWRb?=
 =?us-ascii?Q?MYQXJMp3c815CChuJ8T8J0Hl9x2vFuiFfZXBtkmE4OjUgenJcaNbJnzK2NKj?=
 =?us-ascii?Q?AWoHycZ/1PN2kk4TM1QouF1vlz4MRaueqLk5q9zEhgAfc5G+LzTPz3vgcwhv?=
 =?us-ascii?Q?0qjp7wEzGkp7UYaLcPGS08/DjvXAEKg6YkxcCToYaQ9pn6Od4tEiS5cq4v+t?=
 =?us-ascii?Q?iLQSmRh0poeoMXsRgbd2eN5k7Nt8ld0vEcFAXjcUUp8/yRormZUBc8ZANXst?=
 =?us-ascii?Q?TX2nzgLGyGP1Hnp5yI4NnbrcPzvcAtJabU63nK9nT9fN05wdfgkQiafmrrsm?=
 =?us-ascii?Q?OjFnT+rXLlkpcrZKvmoJ6aVg6dG+l/RyEabg9J3wVcwAJVsGZwQcpQFgpl4f?=
 =?us-ascii?Q?3czkG5fcyO5X9xC52I++cWebCbYmOuOP0q0QUoZ0tCUy4dJryFmGuYkCNZ1s?=
 =?us-ascii?Q?dYtg9n1HUxi4PyuOn3vQeSSmirAYk4DCz/mY35PehEbrjCUWrX57Q6RaJBtH?=
 =?us-ascii?Q?XG9aL1J3M30pb6KMfr8yJZ5o3/gpw8HNRn/oBNQTBozdb98hI8IOvrLsJWyp?=
 =?us-ascii?Q?Qrg4d/1xaRVeTMKk+sNJRQKrKEFa/pROztgbcZjGo9SYyC5/LVRBLXWvhhV6?=
 =?us-ascii?Q?w31K36d9viMYPmis19wxHAQrH4X6wSy+vVOGUi8TnqNN92b/86BYCU4iK+V+?=
 =?us-ascii?Q?DFCessTs+Twd1iKqjQpeW4t1LD4AKLh5l6/wxPaOazYJKvssOkvDckE0+Dv/?=
 =?us-ascii?Q?VC/SC2n0egbYVeXgn+6pmYQjXPagJr9bVMZ9iPwFO7snAZ9GvBR10/qbvkHY?=
 =?us-ascii?Q?k3BH/S7bWW4EqMeBGL8h48HjCWrexRiefuESXCBx/pD4gzA0xJHLMB/gxTZ7?=
 =?us-ascii?Q?h00XZZsZIqluTKi+eBcMoiCuenGWBVwrUDgfByrg3TbSo5185xGToImf78zc?=
 =?us-ascii?Q?W+P0g9S5isHQDyJm8zCYdppqlM4GpHXcqLaZOGTTKC6gzFOawBAl6sWrjqVF?=
 =?us-ascii?Q?TlSaNfc9zeNUXRMTqNKqdgU3D67ubGsUrPQpmu6yYdg/Gjk4SgTOxLXkA+Pb?=
 =?us-ascii?Q?IxwmlvB4AvKkg9hkvtAwBscm3y913yuwCwma6IVrrO8XsSieg/RFAulW220w?=
 =?us-ascii?Q?1NBEXf3dzBTELxU+NOo2vNrX9Eqrl66k7f1ARufV3Ecl1Gh/5q1GJ1XoUx1K?=
 =?us-ascii?Q?Z8Yo/AJQQCplqaXe1Bk+srtv/VNr34sE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 07:37:16.8026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3deea931-104a-4c6e-42b8-08dcb84617f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8849
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

This resolves the dereference null return value warning
reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index ca1c7ae8d146..f06b29e33ba4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1183,6 +1183,8 @@ static int init_overdrive_limits(struct pp_hwmgr *hwmgr,
 	fw_info = smu_atom_get_data_table(hwmgr->adev,
 			 GetIndexIntoMasterTable(DATA, FirmwareInfo),
 			 &size, &frev, &crev);
+	PP_ASSERT_WITH_CODE(fw_info != NULL,
+			    "Missing firmware info!", return -EINVAL);
 
 	if ((fw_info->ucTableFormatRevision == 1)
 	    && (le16_to_cpu(fw_info->usStructureSize) >= sizeof(ATOM_FIRMWARE_INFO_V1_4)))
-- 
2.43.0

