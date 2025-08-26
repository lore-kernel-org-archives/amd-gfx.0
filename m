Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AD4CA0EE4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 06:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8909B10E5C6;
	Tue, 26 Aug 2025 06:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bp3F+Qh+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7817910E5C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 06:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7XE8WAYMdBz2NKwl9RISTvHiqYf0d/hQ7hIyDA2ckx0C/8SrEz1bVuQldzI9yPyBz7q3zNizJQEkG7ss+3v9Jo6ae2se4pkm6UhzPgdkRS+r5cQddD37y2BPoqx3Kvb1fuh3u0WFx6SeilKCMcl3ra+L72ORDBeBNuZ4d4OMUiPjCEOrjvCsQsUSyDlL6Y/wO2aQPuFWljUyVwVfAGP6zsiGYs39COsMJYA1fiSvDIe86TGkXXk6hqinUrkJ8BP5e3K6sNejmLwWLHsXjYMS2Juspq8gkpe7yYmy4dkPgi/wz0lXo6qMNALTL6uh5GTcchF2bQrdjbV1aGYcr9SiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+WMfAaX4pWl1O/vj72/xEZZTNMNsSflDnEmDJscvYY=;
 b=m7/VCVoZ0JPJZDvT/aZBR/KhBgAVX0KbpQD/wwozBCyYizb8BIKFUOaRHLSRRM9pQEOD/WWBScg11bBAT9C2zNG8fHoJxqQZ2ROo17+pxkvL2RUxOJ7ckWRRkm5DkhxJVAlcfi35asXcTQ9tq9y/roUHGsO/c2ffQ4gTQjiPgj0GO7ffY5clBvTC9zoIYVW5fh8MPYJuRx/MLIPc0n3Ikjl+rP4MxYz5LKx1UvcSXF22caOEeGgkYpUvqukFX8D8vhba9fIqUKbl/hPZR7LhryxJdI/ygkSIzEoqzx/SjOFCDMpWwn8PVkuEL79nglgh+3dGmxNsoFkF/TFPQfOXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+WMfAaX4pWl1O/vj72/xEZZTNMNsSflDnEmDJscvYY=;
 b=bp3F+Qh+dwKrmGuO07KhQc5UUR/Rr++bvT6VyrutkpbtFyO4nHiL/Yf6etKtoc1WYqDfQtC20aLfx0UGNrTUWWpadTp7mfp2GEB6ulXHMNNTl3GcyVSRCjduwNBNXMYJ8o1Wd42aKUhjtA/BwcU8zTysr4Q5UaA817Y9lBaX0Fs=
Received: from CH0PR03CA0433.namprd03.prod.outlook.com (2603:10b6:610:10e::18)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 06:18:24 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::a) by CH0PR03CA0433.outlook.office365.com
 (2603:10b6:610:10e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 06:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 06:18:23 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 01:18:21 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Stanley.Yang@amd.com>,
 <Tao.Zhou1@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Avoid vcn v5.0.1 poison irq call trace on
 sriov guest
Date: Tue, 26 Aug 2025 14:17:51 +0800
Message-ID: <20250826061751.2350653-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: dcaec056-bbf0-4fb4-16d7-08dde4685cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C/4hc9KIgWWR+5H8whba5nFp4ZbGw12nkmIPfaN6rksRArWUjGsYCfPxqdJo?=
 =?us-ascii?Q?ID76HV5A8b83qhfPIgStB/0nOxMt3anhfyyehrDF7mAwteIDk0M5WtYtHMLD?=
 =?us-ascii?Q?UNQ4FuEA9Mlp8oOuJhC7LnUJnztMbXWfwChWC/6C5fcdGAiZ+Ma+W8V1MECV?=
 =?us-ascii?Q?SV2cNiAFIk49t/QhR2cvt+pg1+Ror9OV7DGNhXKHLai2pB1OVwh9Y+mrUA3w?=
 =?us-ascii?Q?lPArUEz6nhc2ha5ngPh1d6CuXQlyba+Nab4aGhU1cSi2dkqu4ZdKZPp/GEoK?=
 =?us-ascii?Q?KtNWAfFnJ6kcPHQ5bXru/Ib0hwFqXd6a+bgPQqvUCRj39oLKlj6PTHKmsB/H?=
 =?us-ascii?Q?13tfGSejNlaMRtPA3OY/II4sV/8r1JnAHS48iCzCfVxaGUVCxTK8lMsslgWN?=
 =?us-ascii?Q?pgE49n13kX+9Hi56PDIhbIXOWi2iR2Ml2MF5ebaNNi8UpaEZayIEyTOQmU7j?=
 =?us-ascii?Q?F7eBrTgiN9JFfbPJYP2RYaVW6w5cub1Rbd1ttjmcr77JgpMi453oSRJKzB/7?=
 =?us-ascii?Q?5BuwDC3YhWNkVxMZ6hv6UzCs1kOIFGt3X3wYiUAwc5tYFfQvcCb565S7j6F3?=
 =?us-ascii?Q?Poa36Y9VWx/a9KVIIVA2HeHQV97V0pnxuGcUDne1pl6sDNkA2njnB1Du3ish?=
 =?us-ascii?Q?rOU7TaXRBEV4wxQlrqY7TkkI4m7fRHbdlUNv0wAMJF7R26KAA2uTldLqNptX?=
 =?us-ascii?Q?5GXZDlmALB0n/t7IhOHQGj+TZxIRYeuMcnUxPF7z2sx+Q9LoNEakO+sQl/JN?=
 =?us-ascii?Q?LEXXCZBgXdi+DeYuSQMfS8lbRFZDWP7Ffx7w3ht86cylh/bwoGN0+6eamck1?=
 =?us-ascii?Q?wxNJxow/RUZ+I3hTAgbMlnvH2viWopBpVdnCYIK9gltWrAAr9dQ+2LOG0FgU?=
 =?us-ascii?Q?0dExaYSMQMjOwEaHdgDoUS+Qd0KEsMBWBgpzjd+Bmn8I8tJ/hRzFGZ3AHSA/?=
 =?us-ascii?Q?+T285MageDguc90fZvlowiMNe6hCVqxFkY0nZlW2y3TX/Vy+csBMGZXkY1x5?=
 =?us-ascii?Q?kkUs7uZOnj0HINwDngzSsECOwwui6CJ8DTc706KgnNwkPzvDAiXq7pziMdRI?=
 =?us-ascii?Q?c/bphZ2tuYtYiGGz3LN0EztWy4jQzOAAGcRJi8ewoHjPal77h9XPnzJuWAgP?=
 =?us-ascii?Q?OoW6L+j/g40wtnXsJa+AOYsbCC/RjkVlr8NDBA6agCTGx+x/Gcr0OJRPITRv?=
 =?us-ascii?Q?IxKdUlmcPhVKTTOWnL3y02fGyLgVzbETAJ2KJSOQ012Ld9BCJAnPfgHatu/Q?=
 =?us-ascii?Q?rAwDtKL2K5kMEgDtnKwN4ONud72VqldlwnccgT4XlOniFhv2nd9+h7MGjM0Q?=
 =?us-ascii?Q?B6ZUbsVQTSg736ohjhC0wHflGlAzVBAdgzh2uJ+CnHC6WV6jWBMy3yspiSoI?=
 =?us-ascii?Q?wdVW0/A8ujpj3V1gxsy/pumfelBFmi1Kqwq9XEpq+vHov/GjbWo9vSwOw7qg?=
 =?us-ascii?Q?S8GtPsqkU8LoQvnzNjVvEeHfdizHFGE4iR6k0axDsEwR70GV/aIVTAS0mAYY?=
 =?us-ascii?Q?3FjbJHeBh/sPvrM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 06:18:23.9500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcaec056-bbf0-4fb4-16d7-08dde4685cbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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

Sriov guest side doesn't init ras feature hence the poison irq shouldn't
be put during hw fini

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 7cb21e2b4eb0..4b01e35ad7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -326,7 +326,7 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
 
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN) && !amdgpu_sriov_vf(adev))
 		amdgpu_irq_put(adev, &adev->vcn.inst->ras_poison_irq, 0);
 
 	return 0;
-- 
2.34.1

