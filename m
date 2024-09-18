Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CD3CCD193
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Sep 2024 09:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A57E010E23A;
	Wed, 18 Sep 2024 09:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p1byay1r";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7008F10E23A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Sep 2024 09:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6katLZHsVkuZVN9yswo6qbEbnxtHAzjfmtPXb0/FqqcBbFndvJuuvc7GFWfh9ZT/BjJC5nosnevTGgCKJHEDyHUEHV15e612C40ZF04hSDRX4ijDhDBPeJANjmfdxXEj92UkhQ+rsFc/95POzS8TuwDoLkVV+ZxShoXvDJOoaEzTjnDSy2Ql0G1g+RXjAnZhy9q9zPsMZNlERxsgzPIVhXevEZzAB65WzFV9h1srnNTU32xJBZAWc7lcie1gvJcUcFp+gpTuaCem3nPA6VwtBMk8s6U5AJiZwV3SdOBEZ2x1+bKQoa5aRAGSQSmrw0PivgldocS8Pf4fuB8B2aCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WUr6zD8KKN2APrEVayeJ871YbljqSTKxgHBCIQf32s=;
 b=TmsT/ztqNzO9O/sS7lgOoEqwgdyoidyo6JvkVhTnNYw61pSioYO/YMOuzCl12uL11QpXmU266udDwJQs+h5YIIf3l6+S8UZNCEuZxvhAFnum+vrgF6VM6Pu7c6Vj6SlgiUGFIlanFA7s1kQfzDjAUn/Cf5UbGsECylfF+lnsE6sEcz5flq7KeVTLXbmIqaQJZ4o+4/uv9uOzjn8tw38bAiimIv+wxDx00AAt8IuoouOep6Fpbkz1gOqrMJONdO1qKtp6tf+98kVfOz5f4TMb+cpP0uNdMJqefAE1lLWZUE8/O1vJrPGTeuN8D0aQ5Lf1DnfgIAbMDlVcP06t1PLS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WUr6zD8KKN2APrEVayeJ871YbljqSTKxgHBCIQf32s=;
 b=p1byay1r0Uljpr0Hi5kYKufOlKWbpO5jNRUenazygs8virP/jabwnb7E7wRXv/eOMNk8SpeLsVAedryWv7xelJLuBU1Sseg5EzwTUsyKzaHLO5G3hYo6MhBeWAsykly7saDLwZ71zCjyFmPmcuyth/8Z+ST2bUwlX8nDMhncZYg=
Received: from SJ0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:33a::7)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Wed, 18 Sep
 2024 09:34:23 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::7d) by SJ0PR03CA0002.outlook.office365.com
 (2603:10b6:a03:33a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 09:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 09:34:22 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 04:31:24 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <JinHuiEric.Huang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: set enable_level_process_quantum_check
Date: Wed, 18 Sep 2024 17:31:06 +0800
Message-ID: <20240918093106.825708-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cc9c99-39cd-42a9-8573-08dcd7c51462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8yAjH+oTaQS53IcNEdPUcZvPJI1W+FjtMxJBLYHJ4bYQsSkzSO5oHELAigLJ?=
 =?us-ascii?Q?+z2mqOu9ihWhPX0PY+dPLSgNPeykCvRvQ5wCKc0VrEamlyJEBWTzWqKDmuTt?=
 =?us-ascii?Q?D4jkuqs1rzfvoFNfc1OiJXcnzeaxyzSXCMZv6JsOfFzyhjAQAbxjuG+OxTrg?=
 =?us-ascii?Q?EhXdXA475KAAwSnW61mnYlkC5/R73C9XXjgnonc0GKgWmxKVdO5doHLOYC5x?=
 =?us-ascii?Q?OUVN6huOfa5IWCy0DsxC/P5Gt/uEq5CdTRGjOExpG36PnPlEtQKxtnH/KZRt?=
 =?us-ascii?Q?g8Hqv17diHzQ774UGBjBoi99AZBBbjuk/PaZumlWqv0LeUH6PkZ2f/Ul8VKe?=
 =?us-ascii?Q?rHvMlZsCaW5y7boBKSnIZ+pJIFFjAABIDS/AzHo15623JWLnA2aDkocSgB7f?=
 =?us-ascii?Q?th71EAS0KKiHjtnvnals84yy2+MMtVPqKO2fKysGpMpCLV0Erip18ysMNIgF?=
 =?us-ascii?Q?bYOFeXr+YdAZmcY4rumL4w0aVlf4fDrdUV+qM6K5YYayzFWh6WAA1xPvL8id?=
 =?us-ascii?Q?ADCSsYE9Si6er0eb3+zsYzQMmLRxreYUF0mzMKHPKLIBqYnzB5VS1Efuc5Bf?=
 =?us-ascii?Q?isPL/2kqOKHI6d/A5ax7ZEkOgPUByuCaVyL+QsCGw7hzYtsxs7PV3dT6Hn5t?=
 =?us-ascii?Q?fLnK2wecDF2nBBGxjlXwo6rFEGFGjiByqxmdVwFwNWhu24CFCqAy5WaJQbrz?=
 =?us-ascii?Q?3DaUaIOeXZlKnBvFHGWcN2ES7NcWorM8rFRtGYDto1P6RqHKDbm9HNbv/z+M?=
 =?us-ascii?Q?gM+shzAU2jK7kyF1MTcUsrpeayhnj15qTiQtM0It1g2PjItoX8IZcVL+d6RE?=
 =?us-ascii?Q?Ag+GwjCklLed/SVaY3J0QisceAYtAryV0CkqE+HkC1GCBEF30gAGZQJANE86?=
 =?us-ascii?Q?p57aiXgzGSpGkYBu7q7+EIVkzHeFxLCms1mLSxb1VTfnAynIbESijSrWMI4o?=
 =?us-ascii?Q?DCLvHUCC0RAb3fqcjKmzGs2ZvPjHUWHjvbg+zqejilIKwXw2txKqh4Pg2RFM?=
 =?us-ascii?Q?NamgYANuJ/Rb6NE1vG78AplhcXQ894t1sixAWqPPdI5J/fCUeboiay8DjQ2O?=
 =?us-ascii?Q?XS8tUQ3GuO2WbeLglpZC+ZYD0iMLD10VyQzpJ08GpsrgHR4cGE7PTjGDN4hy?=
 =?us-ascii?Q?3dSlsYHEE0dQX4l+Vo1GLKIuFvNxOjUNWeQif9Fxoa7MMhoVHjiVj7vOB1IQ?=
 =?us-ascii?Q?zmyR3bQ9WUAsTwwQqseqNUb0yL89oURQ6IrsC31wN8UDy5b7nwqNnVU0Qgp0?=
 =?us-ascii?Q?/uIRp7E/VSGI7gOuTiKUpOYCn2BkP6moap1T/Q/Sf46T3RweYCsgPpw+9Lrz?=
 =?us-ascii?Q?DPzNlbhurJ5B8pveZ2+Wysk2hGr/uOo7c1sgKKo6nBRaAvAD3jUAXTe8O/aF?=
 =?us-ascii?Q?qZHfItVp5BiAxCAMmBJzqzYUwnS5Rvu2GxefkYR7wQuMDVD4bM4VowTac0hH?=
 =?us-ascii?Q?zbfncc3CI/g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 09:34:22.8735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cc9c99-39cd-42a9-8573-08dcd7c51462
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939
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

enable_level_process_quantum_check is requried to enable process
quantum based scheduling.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ef05a4116230..ad87621f91b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -609,6 +609,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_pkt.disable_mes_log = 1;
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
+	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 
 	/*
 	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
-- 
2.41.0

