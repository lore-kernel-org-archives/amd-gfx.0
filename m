Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B717ED111A0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 04:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51DDE10E047;
	Mon,  4 Nov 2024 04:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eKfAMXTQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE9610E047
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 04:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VllzQrZ96A1NNdue8brp3i6mJ9aFjx9O9GC/qOoZvuyfF+H3J1XxEzsQ5vBK5ZiGEXO2e5jYtPTLmf5KqT7iHvkEBVgg1dZQQCBn+KPZ64yVackL8OIQ/BKfcdQeqm8Ba6dxUxG4eJ6cxnVt2Vla770JB5SC9h15ziGe0n3WUETIBdokHaSSL7TJW090i1+TLv8PO22ZpS1OQNFWU2M/E2ZZ3dLPZ0mP4r+4y9/h3yKGbjpO7XWiguj+YX/Nh+rS2jOwzPpn8nLdZIHewC7qzojv0EiyzJaxS63PURyEkA/QE7JTRW6o50b24mcMkWdIxDTpe5s5Jt2IYhDL9FkqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Cqyo8qmVY4SINiXBzQDGPBh8liW7nIXBOBSPUy433k=;
 b=rQE1o+RMb3/V5shPWDK4d56gWisZs9RqSRBlV2j6MYNe301s9KaOiTvTr2IZs94SAsDknRC4KVynzg6NYA5jL6/6wujdw/fkDviWbY/yYiAtenF/VzRZ9r/cC90Gj59RjPnDoxYZQAG9sG+9vzvjZaSnNM6/6eHRICh9ILVbirbgMq5K80o0d0PfWmox3a/ejfSuzVkzLtFXGHYBWOzmne5jcFtyPMVaUMrhB2Hbj7we4KePwvn8Y6O9MwrvSTBuanfpUy6qpTw6VRcB48FoxI807DGLrJYTUrI4vGnJw4nrWszrPpnIRY81n7MoKBihYf+8RinHRkHxC60JlR2iZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cqyo8qmVY4SINiXBzQDGPBh8liW7nIXBOBSPUy433k=;
 b=eKfAMXTQCtRv7DCprtWz7TOTkwOopBFkPHBuFFAZ4JTygRaYDXbfs3vDjkjAceQ9tnQQApBx/KG/nrDdmuqlrlaLsJS8A2furQBjljaVlzLwMqu5Zo8mf5EXA4awEtouSk+rF1ACZTA+2ZpNaY6wZnVZE88gbv7Ynj4mM9V/OX4=
Received: from CH3P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::10)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 04:44:53 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:1e7:cafe::50) by CH3P221CA0021.outlook.office365.com
 (2603:10b6:610:1e7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 04:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Mon, 4 Nov 2024 04:44:53 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 3 Nov
 2024 22:44:50 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Tao.Zhou1@amd.com>, 
 <sukhatri@amd.com>
Subject: [PATCH] drm/amdgpu: Skip IP coredump for RAS errors
Date: Mon, 4 Nov 2024 10:14:14 +0530
Message-ID: <20241104044414.3204284-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 6277573e-e6ab-407e-f049-08dcfc8b6ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zggfe2xfbHNndX9UJHxSUmGZfG5v/LVYTZZD9YN5lGejGTJ7vAn6l0N7tjwl?=
 =?us-ascii?Q?qBkC5yLDN5Zx8GXjn3dJugtBcLNEvpVJMzwG5B9kRyeOcQc90u9dfshuJ1OS?=
 =?us-ascii?Q?P0DNjWyq4soNHW4aFdgcw1D3y6XPcSyQ2SiMlN+1oaskS1ZQeqQevD/UH7Th?=
 =?us-ascii?Q?sKEBuhPnxfZQGsi4U3cj62m6EFFgpVklkY0SJrHe+DXHCDRrrReXkg3wFwr8?=
 =?us-ascii?Q?yH6QhrkPlxQQfBHsl3JUpkvit5xlhFO+SUwJQIahrxeA3rO71Oh0toTKlJM5?=
 =?us-ascii?Q?+jOQHOIV72jrWMjEhXkGnzg/+61Bt0nYh8cGqzqkLhnTRF0eODWS5zYXvz3T?=
 =?us-ascii?Q?zjGdcp0JVRWtULZDS0Rwh61nn+75yrZbYRo+Wgou5LCBCaZSa37BEN4O+m8R?=
 =?us-ascii?Q?hBFnBM9wpaKayvbuYDkCmyfIVIHDXvvX1OV1j1RcaVmWrziNjjaLSPupSQbp?=
 =?us-ascii?Q?pp88bRMZrJlYXwAMykqpJgBUFKAmjR8HlEAZIK3OJL75Q/jZGnLI6roPDMLp?=
 =?us-ascii?Q?a93ChZjsXcXXxrQs0Ue1WPQHb7sefxSP892wbtoOaxwA7ouqXZBzp5PqHXj0?=
 =?us-ascii?Q?99oC0UT3qsxQkg1EAYqDW64qD2fl8/BPqtBBw+vBUDSkcmtA8vj+CoPHOiS9?=
 =?us-ascii?Q?MgK+/KpOsSAEkS5TdjlbnWPMumuUrw2F6tpX7dCwlZILbQ/9Ldo9zvoIPxdb?=
 =?us-ascii?Q?tLiH6Fe1vP9u33sK6ShpJy4NXfMjanCOK7sPvC3ZF0Iq7r7Y72Ub+3L8awLv?=
 =?us-ascii?Q?I7VZfG2hH0ph0PYM9F48oma0as3iW6M6tgQAhIqxdTYVHTksXy5+XmYsjyv4?=
 =?us-ascii?Q?SCjcRpMgEbaLPEQw5pZMMJX6miaK1gI5fLGCOJRmWdAWH9z+OSAsZIhc7Cem?=
 =?us-ascii?Q?HtyrqYqfTchahqxWlmPYNbvVrkrk3KMPXFkIGjf1hMQKeMTM4NX4KxycpANh?=
 =?us-ascii?Q?c7tn9cQUCtoO6DcwwAwCfAECgWv2anhWZbHwA7DGVMrKehmHnJ7mLzLdY2Lh?=
 =?us-ascii?Q?fhS6Kk8gNU4hw5zMtDON2my/14np/aHwHEvFoMTfvvrSGvA6y7haCOQXWgkX?=
 =?us-ascii?Q?eGCiC9HOGUyFT/jkXA+vQQnu3cyCkklmBGwtEQKgcBzO9jfEWAN+Oolkp6Li?=
 =?us-ascii?Q?E4sm7Lfdq3H1rRjxfTNtGPAAqp7NPiHXHYkcpQWAmIacsWh2RVDPWh5lF3/t?=
 =?us-ascii?Q?wX/JjUeKu0IQUMMCikP1VVh9qbe0/oWZDuMkQlkmkrAjzncjADKU3WMSK9Yj?=
 =?us-ascii?Q?4CVb6fZRjyUbn7usmK0M5MlrMdfGVjHAHi1JRmtzikjlsEJOzXejkfvPainF?=
 =?us-ascii?Q?fjQ7TP23AeJQ7I2Yn3jxr3156qHIAJbEvG6FKgZSDKt/gmmPlIlRzUgh/YlX?=
 =?us-ascii?Q?SkEe37NqEpwE+TMWeG6Ub5OGPN1p4r6cgvRsE4aVZF+f25wpeA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 04:44:53.2520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6277573e-e6ab-407e-f049-08dcfc8b6ca6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
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

For RAS errors, source of error is known. Skip the core dump of IP
states.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 17af8c58e676..bcfda997bfe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2606,6 +2606,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		reset_context.src = AMDGPU_RESET_SRC_RAS;
+		set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
 
 		/* Perform full reset in fatal error mode */
 		if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
-- 
2.25.1

