Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19B8D6ED30
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E3010E941;
	Thu, 21 Nov 2024 13:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TftUxPOa";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E4710E940
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdPHBVas4ewKu/2YBiS+RExKxyHtvNQHfLBH2A1+YIx5WycdcXMO4MOiSYDj/KlSBMzpi1V9237RFaLihL1MFCzq6s1c3SFcmEadrxTgRO9mBLDoP0H5iu7KuZW65GCE2SWRORdapI9wiQWw9QTAwLJozoeJAAyQA+PFO3VTAflDUCeCgokkEs8cQAJafKcC3v80uIwrmDv5GrLLftM9G9Pvz2qAs9itSa4po84RrfStjxubDETSeXbMzsZsNRCu79D+gx3oZ0xQn6QytAqr6LxWXKzY7WAgnP0svyDNHF/eCArMlqSEl15bvAUlqQQeIziF/qm1FlFA0maWpIM5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLG7ijkreT8a3hevhG9P61qlDuNEYO6pkgZgCOBoNsY=;
 b=x2ns1Gj/ekKRr2zZopSA5DycMlAiNECT7u4G/T3gram6P+b3C2rzmfXglyYJT69MI3gOPcJcudnI82lKhpmcq0Y+kDdGp4Tyhg5DQXTy97RdqfcR+U8+JZrf0UKxK0yFBwLcGzSfyqcR+U1f9hrE/3ZnfMEDTv5sm63yDBvhvMxF5trxXDdgKZbYcvmbabaIRurBi5efrdHmL0Co6NsPkRICZL/6yZDhOEr5eqjnsFPYRsnnF4+b914plerBFNuZwEwyBq1dpvPDSArbIBgGbazEwPUYT0VwpBDOcdufTIBE7oCKUlyWLjwuNPFgBgCjOVRC/3BQ+fGW8egWfDSCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLG7ijkreT8a3hevhG9P61qlDuNEYO6pkgZgCOBoNsY=;
 b=TftUxPOa4JXFYOwFRmkO3e1LPc+z8bNr2J2icD7vLQS4dbcS0dETnWDgtPxBhTRmQbxDlqMQuTDTM1qZekwR4GFDqIKenHDgx4qjCJOchN/RQwclm2eVma/mu7NeJcy8KufYwJ5E7P8WPvtiIp8JTD0sBeggIFpqSQRRnmjmtJY=
Received: from BN0PR04CA0127.namprd04.prod.outlook.com (2603:10b6:408:ed::12)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 21 Nov
 2024 13:33:37 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::67) by BN0PR04CA0127.outlook.office365.com
 (2603:10b6:408:ed::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Thu, 21 Nov 2024 13:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:33:37 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:33:35 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/sdma6: update mqd init for UQ
Date: Thu, 21 Nov 2024 14:33:02 +0100
Message-ID: <20241121133307.594-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121133307.594-1-shashank.sharma@amd.com>
References: <20241121133307.594-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf384a2-3e26-4cc0-25f5-08dd0a311a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1kH0xDlR7OMf87jFj4I8M1a3lVkVVYbkHFrPa0FHhFy54Wu9RejBX0WoxNcI?=
 =?us-ascii?Q?LO9X6bcJK8KHcsy+kA4Z2xh5vuSpFitvkvgFZlzEZTaTujAM4lB9HAOgQhsW?=
 =?us-ascii?Q?79D9P6/4id5jemwghF1qnZ+18eSrLbzC1wXdr5pxYsGv7sGH/1qhNI7Ej+2D?=
 =?us-ascii?Q?/TYg5fWch9J3XDzBS4LPi9PQkEdlvhxH3j43ZSLUfe5oTkVFW+syXCfFOnU9?=
 =?us-ascii?Q?n43fEOxRPfneK5RXSWc3xMg0tLxiaB7p6vcp8J3+2Vs9NYIh82ME02SQoe7s?=
 =?us-ascii?Q?i4aeOYAIlwrTfFqzgQcx3qoiIrsjdlyIGL6+Mv/Kjr3vGlqKPWIVZyWgCZFZ?=
 =?us-ascii?Q?jZqfwKyL3dhKeGkft/cq1Mxq/c9VG6tQqJYJ+ULFDIA+rqofvxU6Zt7RmbVy?=
 =?us-ascii?Q?eR/j35CfzhcGJ5kA0dqZijJzIo3YgsEzOuLH0XQIn1XcPdfW3xFOToGaPwTc?=
 =?us-ascii?Q?eOOGQ3UNtrRR3LNPtjZRlHBY1NeGmumgHt4YwrCiFLxEDlhkMItbxOy04qXJ?=
 =?us-ascii?Q?V3AmNKl1I2hKVZ5ZP1n7cugfbzS1mgq860EMHWeIp4LHYBzAfVDxiZ3psmr5?=
 =?us-ascii?Q?CUNOCF4YUfauqUMSlQ5+2/Z9CYZ/Xc5oQzXTYkHGMalzk3bh++xsebySMHJW?=
 =?us-ascii?Q?Ol+Sl2NkyVf+UADuAU5+almr8bfn/Jyp4LW2mbiq33EhhGYAHDsa8bai4b+U?=
 =?us-ascii?Q?mZgoXCgVImfozhOBZSbwavSzNQkBKDHfQV4DXCfKsvYJ+y/nLq+UqlSSUNVC?=
 =?us-ascii?Q?LN8TfgDKDpb05ocxGdNAnd3DfMDNZr4byYOrXBfrjZ7PnLGEiSLV1jNGAECq?=
 =?us-ascii?Q?tKUWuW53tGh0QVrn524V/2MAJU945PSPUgiHe9UXoOTACu8HTMCcChU/7oDe?=
 =?us-ascii?Q?+gROn2CJiErB8eZJw2e2zOOh1pbRG6QftSWyVQ3eoYRvmVnJlbUNFmNqZFZK?=
 =?us-ascii?Q?M4AsFFl639Q8MQebUP+hNXKiEo0Vfrce4m/gdmlZtelLN4EG7diFEZh20Qpu?=
 =?us-ascii?Q?rCw1P+2NI1qJ2ThxTuqQ/NHORha+QjLwVanRv8d1SAF7bqxb8dPlhZiTdcY0?=
 =?us-ascii?Q?Tk83yc0yk736KX9a3rzfxUn2+enJcZXHO0SBZGT3L3Grq/6x3/pKqut8Gn26?=
 =?us-ascii?Q?SLe+1hHyD28OCPJcnkcE/TYuJ1yz7zXNGXIidKDdEFyp0FE+6RNIB4xD6oqP?=
 =?us-ascii?Q?Ue5y4A/cqkr+wg+vhiBKJIl72/EjJfWxiPmyX2mWDfRGcV+TlTOUObgqmMML?=
 =?us-ascii?Q?tC/IDWtp7XG9qCcQhtnadbrXVbLBApw1lzQRw7NnTlNd6VA9hmXbao5hjvIt?=
 =?us-ascii?Q?6rDb61aoIbn57TiDUDzSY3Vfpcap4CKSgmxV50ktrByT01SOR06ESGHHB+2H?=
 =?us-ascii?Q?Orj/9/Kot2qos2CD4CEUie4M39FSMfDo3tLNcnYUVHBaFBvCPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:33:37.0895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf384a2-3e26-4cc0-25f5-08dd0a311a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
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

From: Alex Deucher <alexander.deucher@amd.com>

Set the addresses for the UQ metadata.

V2: Fix lower address mask (Shashank)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 6e9fa0bc89cd..9af6aeeca063 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -891,6 +891,9 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_aql_cntl = regSDMA0_QUEUE0_RB_AQL_CNTL_DEFAULT;
 	m->sdmax_rlcx_dummy_reg = regSDMA0_QUEUE0_DUMMY_REG_DEFAULT;
 
+	m->sdmax_rlcx_csa_addr_lo = prop->csa_addr & 0xFFFFFFFC;
+	m->sdmax_rlcx_csa_addr_hi = upper_32_bits(prop->csa_addr);
+
 	return 0;
 }
 
-- 
2.46.2

