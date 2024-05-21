Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27264C25B77
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 03:25:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE0410E8B8;
	Tue, 21 May 2024 03:25:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZCn/T24F";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 387C810E8B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 03:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAlueYT4XfkZq9kWxCmko+E78kD654Nn0yJInsGcCHE5+6aZvAOvpr9/lQbyApFmc3Y3LhKWkxMeSS9oSvbX/qBq7smfe/NPulqcGR6veO9msbgx1mwdTtaSuQmAMslld6B9JMMxDvbMAmmBuZ4UET0eySfVTRtyccluIOFsDbuU6oifaY657I94UHQrSQDO2D4n1HnJrrXCE4uIJnPfm0rbvmq4M1Trdi1N9Xbi9MrnVB8wjSEEfFgCD0osv2p5TKrrBMtYaCgW17nWnH1AqbxhQp7RKwnFM66Q+fm5C7jKugOxU0jIZY03yhfsIof0Z7Hw50B69RI4Z9c3GZkA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63rXWWcxZBN6wN8g2IZIKBu3HH1XKPg2YxuyrFvQKRA=;
 b=eB1BaK/QH10XNwOPHi/fHI7PbAOwHI/TcRN58WUqu5NpJh4SpfAOS2LgWAw6fMOOp8x+qIVflAnzNsXM5yJLG5v8ZUk7JMAsYb+nVMJVe89H6MFhdauKt3n/77V3Ty4OinolTwEsS2MwHD+3I8pl6fQdLcPN2fbGbjAdSePhCwek9ZwLib3PFaQ1q2X1lM/SQPdM8bqZ8f7pKV2YfCD5kExcqdUX2YBV2Nehce3hMcKccXDo/ZM1+YpiByfba38pRTe5oWVaRaSfmc5GKbFOlZzsaeH1TF/HIgTgMHq7kuAnSd8a/rOvRq5EskSyacFDDe0MZ4PA7F52ZjR14iDm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63rXWWcxZBN6wN8g2IZIKBu3HH1XKPg2YxuyrFvQKRA=;
 b=ZCn/T24Frg26sqUWORQdjoppycx99vkcIxztAolg7jY2FDxIUxxo/zAQGbafHk7v8O6un09A5zRANNaRrSq9iyU7ArMmo2MEeoWA8cNo7CVsmrjm8CWN+DjJNilwTYGEkDQB80AqzJ+AJDgf6XIEsssrNV02pMRz+4z59o/VAG4=
Received: from SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 03:25:42 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::1c) by SJ0PR03CA0245.outlook.office365.com
 (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Tue, 21 May 2024 03:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 03:25:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 22:25:40 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 20 May 2024 22:25:33 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: fix invadate operation for pg_flags
Date: Tue, 21 May 2024 11:25:28 +0800
Message-ID: <20240521032528.288631-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f3bc47-e179-4164-1939-08dc7945b148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wf9JzIPOxCbRdBaFTmyU9hjD4XRINe/gIPwscgBU2WvoOtsTYHvHrrk1Nw6i?=
 =?us-ascii?Q?5bStbdb4U3bWXHlvlkzdwpTZZhNkU5FwPtvG/oM1IrtYWwr9i7b4GFUWwP0v?=
 =?us-ascii?Q?I+sGAxebAX1C4PFQs67xISajEggoRG7wZHM4DKyTXZjwHw7Cl5D86+y6Pi2r?=
 =?us-ascii?Q?zKE1qpCkhDfHPKRskREH5v2O5aCX9hjchtInvUHd6yD4cVBZhCQ+HhfRwFxJ?=
 =?us-ascii?Q?D1xEYj8Lie3nN5ILIHG53qzSI1Ii4trUVfpGRt/O9TOApOCxfFulqKsU4CZN?=
 =?us-ascii?Q?jYUoF4vNrpm0Rbp/cQCnY59Bk5pn8WiVyrtbOxEx+LQ/fH8o68HgVTCfia2C?=
 =?us-ascii?Q?YSeV5PpyL9kZMxK33EL1CyEuFsF4q6YloJldcQXWYIaAywI4J7AbDpihD8Bq?=
 =?us-ascii?Q?pfGUvqRHy9xCc5nihDIak+6LRyKzIzWS2nGbAnnLcj7xcWgAepcC1rAktl4K?=
 =?us-ascii?Q?EiLbTNr/RuBmAbF6li++PJ4Akk1Uuk84RO1i7l7BGIu+y/SAGXiNvbLyW83I?=
 =?us-ascii?Q?mcRNB/YOz1rJKmdbh4C6uUkiIROZhkNqauySFv6bX5Zvdi3OSaZZQFeKpgwa?=
 =?us-ascii?Q?rzJLwN6ljFI9GwOV5ojLa4gqebtH5vG9K01TnpwNWqOCHlGOxkPXaaA1ZH6A?=
 =?us-ascii?Q?d75lISVPlPI/IO41R9odq5fapmhInHooUs6UN9t2ZpH/KRNIBJZ+MDekvp8/?=
 =?us-ascii?Q?LbkVZWVgqbeLmxwSSzcOtV71gCVkeNRaet1g1SctUlaanrgETYf4tvI/MF+0?=
 =?us-ascii?Q?TaLUq6rsE3DmWVhmoNRl8gzEjQvs5wldhTvaJj3ZCHt4YRWDrYwTlVu3xqVH?=
 =?us-ascii?Q?LvGnK8Socv6NJGDMGJ4gHjMfoIewbfIdKO/E0zyipy7mffQGXQWWY1/Az50E?=
 =?us-ascii?Q?g3Q+dckSaeFncPYI9vW5/kSLQGzaQF5au/ublj1mX3Na8LVOQKhRpQmCDfpH?=
 =?us-ascii?Q?pXDn6pqKcuWJ19VcloY22S6iRMQntqPXhfeoSH9z0/KVBd71hd6WuyM7JRta?=
 =?us-ascii?Q?L+ZSz+TAiUloJfYgxBoe2WRNRwicJu9By6Hl6QPrinAFCwiXx5ouqfyjhQRQ?=
 =?us-ascii?Q?nyMA/zDAMLxiNWdriXPgU0YQx5OxPsW4IeefHVNrzXbFmnP7CAoKKL+skUC9?=
 =?us-ascii?Q?hCrkKom+rc0iT6c7BiHZVCZB+0l2I7pte0i0BG+C2Dg7FlsMpN5TgtMMaz/5?=
 =?us-ascii?Q?GzJ6LKmOBldzgQz2KZ7hiSjGzO2+gZ3MaDne6EV8+7EFrz+uyzSn/EgfV8ed?=
 =?us-ascii?Q?grndRHJVORwOzV3d2jIEIPZMLoMBV5rnf/QdnUUzI0QbH64TRGeDq4lFPfMz?=
 =?us-ascii?Q?+SvQYHd0RXXwIBD7LUdimqDtA6XTnT+KqzsBGvB3PBJDkwrv/khcyy6alFOy?=
 =?us-ascii?Q?IeNeTpvy3alq9ZUu9JEzTzAl3ZcA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 03:25:41.2045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f3bc47-e179-4164-1939-08dc7945b148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572
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

adev->pg_flags >> 16 >> 16 is 0 regardless of the values of its operands.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index ac0ba8b8c1aa..da5bbf46eb27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -935,7 +935,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 	config[no_regs++] = adev->flags & AMD_IS_APU ? 1 : 0;
 
 	/* rev==5 PG/CG flag upper 32bit */
-	config[no_regs++] = upper_32_bits(adev->pg_flags);
+	config[no_regs++] = 0;
 	config[no_regs++] = upper_32_bits(adev->cg_flags);
 
 	while (size && (*pos < no_regs * 4)) {
-- 
2.25.1

