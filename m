Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BD9D6E2A3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 03:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC9610E109;
	Wed, 20 Nov 2024 03:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="10SXMCHu";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D0F10E109
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 03:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJCIuDgHL9N2fmMmfppw4mUKsFST8+GjtMuwFvUKZQtGXLNBXwMIQl1OiLwo7zxCQIxAetowmBOvdInTXqBWQSEnDMJ8+Ls9FtncDQffvNYO5CTiniQd0zuwskCRlClwPiVVRJZzdtBxZC79DnJGVjyWr09FwiLAeVfn/o35pN8mXmA1zk6tqpA9JoMoPNeMiSnfQPdNyDWbv6YDdlcCwvfE3AK25KVYFa8IwCan1VkKJJ0hPYx0szuDAV+7T+2OrcCCcRjt39Ul564p1vu5UuaZvnwLIVk18LGUt+O9fP2oVTkYudyFxxi01r10E9TRMGdB2tFc6xlKPHDK3wE0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hnqp3julajVaLn3wxrgX1z+IPP/vgcKnYYq1kkO2E0=;
 b=zFXMEGZeR5u0aTWJn+cielKmwEwcLt++SIG59ggtNsl2tXv4dGRQEM53sdf7Fmw9xkadmDfK+cisYQ4gg7a9fVua2DU1qfLu+oyPIC9b+2qz1e1ZoxT3wfm2dk2fWmvc7uxpQgO2SSHJJ7ppxkeyd/PMOJi35K0iAkoLADjckrVg9HrqjiiSlPC7oWB5cOiyHpSXacvWTOfVrjNXUU+DUy8LsI8Xe33stXBVqS+QndeVutD1Tj/uJB0TB59Z0yg8xIsuCvdBa4h4b799qvpeqYPpnU+zoIstCQnLGfm6vbywvN0dCzPPqTJu2iqAzrxs/+LlQx+NwA6Op8cL5Dz42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hnqp3julajVaLn3wxrgX1z+IPP/vgcKnYYq1kkO2E0=;
 b=10SXMCHuvZOflRIBGxmV3MjcPehIHGK/hQYhHuZ4zKvH96VDPo4T6V5M5JZ9pAnvSiuWeFYmqVMHVRPBj68R0uVRwOPpgW1z3xy5G4YmiA1DAso19W5RcnlL0r7Lng/DMMAA+BpS4pkUzPjqEfp0ODg1XiKWxAfLsEoD0xs4AKE=
Received: from CH2PR02CA0029.namprd02.prod.outlook.com (2603:10b6:610:4e::39)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 03:19:05 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::9e) by CH2PR02CA0029.outlook.office365.com
 (2603:10b6:610:4e::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Wed, 20 Nov 2024 03:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 03:19:05 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 21:14:51 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: Remove arcturus min power limit
Date: Wed, 20 Nov 2024 08:44:07 +0530
Message-ID: <20241120031407.3398856-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b4984c-1694-4207-a6a9-08dd091216c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7ZkhVsQ47pAWvvXcMOeyTKG0WOSLRjvJFWArTSYFUO9onvk4O4JHrOKq7cL8?=
 =?us-ascii?Q?dqKExVgxaNryBuyPf+jurlqkDNS9ut1qf+7jiiyA5Wwlleq4dTOef/FJTDrY?=
 =?us-ascii?Q?4tXhIbYgE0pldY3NZRCCaR7sG7D0SZ5Rlo0BuYC+W5df3Yxp0DRSw5vilPeV?=
 =?us-ascii?Q?3xTF5PXK5JnKv6qPuxgVh+T+ycVLhdUZERLerb+5oF4Zs8FEdhUL196AtwUP?=
 =?us-ascii?Q?o/pQ3tAcL06pl0S2o4XTuGa5huxdBj6Lssgs6CYNESnCWEoF5ybFJb2kySmX?=
 =?us-ascii?Q?cSSrcnKpXNAD7qF1fuNiExV+hvCjeXjYImX80diMGVP6wWpMHX2mK22EHcXQ?=
 =?us-ascii?Q?wcbZsqElvIWmtH56qgGj8bLFKupui64EKercWh2W0DN7vuDkZYFEJ1OVEpzu?=
 =?us-ascii?Q?b8IsYwvonZ7xa4MF98AiRj9ZpwGcV2Qnxr014dJOAc1lKejkPkr+D8Z2z2gz?=
 =?us-ascii?Q?b9llaKF4edgJOuRkRSaR2RvG7uP7gSfnnuzRDvWDwiKoMJ3QfoaqypcV2IXr?=
 =?us-ascii?Q?AC4us5q+/5mqy2OOR7kHrM8lz1T/+hUfv4o8PqHWk+cptTK9dYQa0EzGNNGA?=
 =?us-ascii?Q?8ZA/3aM2+EbnhgYm301Ye9LhYKGrk10sd72E/vxnNtq1QeLffSoa5Q4pJXYr?=
 =?us-ascii?Q?XhhiJ9Mq4gdrOS64b/b2ktWfUcec9SUryThgj8aSkdLZ5J8faZN6Sy9JXqk9?=
 =?us-ascii?Q?P5J9KSsCCOdUMN5HCrAGkT9keCEuQaASyJEcTomqZtTHb5rqSo4f9fkybwGv?=
 =?us-ascii?Q?NdOadvTyaHRhliqMTb2tSlqBJH+JkqV+O1xbV/Sf7ICRFq1hf/vb0b/GdwAr?=
 =?us-ascii?Q?s94nIFb6DlnYk+i+jSrYSYtW3l6IzvvxfCOwEmSczbR4XkumB/3jn5cFRWyR?=
 =?us-ascii?Q?rGQ1zKj1SXx9a8wRbP1yeAqJOorF2u0ZbVJi9pLLw5iHpi/tOt3c7++uctRF?=
 =?us-ascii?Q?Vh0yyTS2ZTxGQzrwEXmiOQCEFlxk3GojTsFArRsr1uZF0Y/lDaLPElhYBnIb?=
 =?us-ascii?Q?vAFqiGo9KPpS89BsTSuP/9IveqrbfgBRyOsbc35h1yDjcmbdWQ8RDkSf3RhR?=
 =?us-ascii?Q?user5OX3xAtWTI95TDW9cFuEXEVX3NFxyGdbLpqt/XF/B4vrq0rt9qrLbF5U?=
 =?us-ascii?Q?C7/wlRZNKDTxobtubJig05XOIZKk5U2EIsqkY0lFZePI+9hqRkENSbu9ZNmR?=
 =?us-ascii?Q?ALV3WhPZtwLSpw5Bk93kry/vTk2NtSxQ49p9IBoz/Pd/x06PVDNEKinFVdYJ?=
 =?us-ascii?Q?L5dnplbM3Ct3BlXls/KC3glECbtRQCV8NDP9U3NCQwKAjsYRwMqi6b/8wdrB?=
 =?us-ascii?Q?05immHGJdiMe+8MRZ9xx4BDMWeayuYCzqG/JyBM3ea4evRRkJ9qnauo5TMqa?=
 =?us-ascii?Q?4f+xdE/1Ld2KcxxELZsGMioapneyCKA/hBCj+Xn24IZHKWRl2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 03:19:05.1941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b4984c-1694-4207-a6a9-08dd091216c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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

As per power team, there is no need to impose a lower bound on arcturus
power limit. Any unreasonable limit set will result in frequent
throttling.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4b36c230e43a..12125303bb79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1344,8 +1344,12 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 		*default_power_limit = power_limit;
 	if (max_power_limit)
 		*max_power_limit = power_limit;
+	/**
+	 * No lower bound is imposed on the limit. Any unreasonable limit set
+	 * will result in frequent throttling.
+	 */
 	if (min_power_limit)
-		*min_power_limit = power_limit;
+		*min_power_limit = 0;
 
 	return 0;
 }
-- 
2.25.1

