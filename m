Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE15C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3313210E196;
	Tue, 21 Jan 2025 19:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qtTwb1kA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F94810E629
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URkonRO4qWAggjEa+FI/Ery//m1G0dWxyIx3T+71u/qVA0hyBVhpb23uT0P+2ueU2ZaIUqwRDbZuMmjOm18iiRwHuK8zS7jI/kMITGlIdCt6mI0V9Q9JGTd/v5Oou049ZNgfAHiHRc80NpFzW16knAVawanjh9TEF/O3UROoQylySV3O09WPaPK4tfbErbiIlWmgdKN0PAPWnxkYdtvv2mY0hxWsYFzFy+/jZASDl8ZBDvASGogq8X9eOcrnQ/o/4C0jQoiwJ6mTDmCEFV65d540GcU/K5BbLdhzEyeKTWeLkA/oatBxYzoVvesyoiBIcuP8SxYrlaipdlkOUp+New==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNf+ASLpXSjYLuSquRup7GNqKNlImRMDLnv4peI2X38=;
 b=n53xwt3a1dniMmEFq9/JbMrYEGlJw+w0qmo9hCGX3vzzh5AhbEykNO9tjc2Z8tjaCV+LbbfWBMT/hScDOR9D2RvEBB4qvJ+DeqFyUkmifF3/8t860Rzb1ofNfLsDh7ylO8WYMNb90Q/tHJU8wfpJFKdPYZsI49WYQpoIEa5iE0Tfi6RoCR+yjJ8d0o03xI3lJYHrkKvNxCLp3YhtysHSQHrCRyjukIy1rbZ29tJ5+FRKLMdMv4IKbY46/7Ki0Xh1n1Vc+iS3NbGRYWPzlMoyZzhaUh2ZNm2GGEYIOTBeVfOrgOcfD9e3lFcdkd8MAAjFb06nuROfjd00A6L7Nr1skA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNf+ASLpXSjYLuSquRup7GNqKNlImRMDLnv4peI2X38=;
 b=qtTwb1kAFnmHSUluau7WJ245Noi2mhILpNQzWPABDGv6Lm/+gNrPJk24WrTaD8a2FpAuv/hsXt43aXvflhAvYmCByjgaZDF3SBYwBa2XBaIIDpzdvUdUm8CfLJmqv3NQJ8pz5T8wZz74HSennJI1dgJdtc8cjRXUvmFRl7KFQ4I=
Received: from MN2PR22CA0014.namprd22.prod.outlook.com (2603:10b6:208:238::19)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 19:39:54 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::98) by MN2PR22CA0014.outlook.office365.com
 (2603:10b6:208:238::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Tue,
 21 Jan 2025 19:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:39:54 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:39:52 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 01/14] drm/amd/display: Initial psr_version with correct
 setting
Date: Tue, 21 Jan 2025 14:39:06 -0500
Message-ID: <20250121193919.3342348-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: b15258bf-fc6a-48a5-aad8-08dd3a536140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zVcIw20sXBLCNSG8Aad8SFdPc87fw8eS35lA+ZblN06bDJkob96n8vqPw+xy?=
 =?us-ascii?Q?TE/qIqWVVnRQLmyHe93MARXRAN1iIPaxVw/Ss3cYFAImSWC92aqWR5X43sbH?=
 =?us-ascii?Q?/eeyQhH/C3NIlcsMJIJBkovPuHFzjQU2ihTp9VSSMQ+zRTq/NFIYetsDV7Fn?=
 =?us-ascii?Q?iKBQJHdfcaAo6DO+gP1qoA21ZuqcXFXnOsqmyEmI8qqGG2SXfovYh8WKF+iR?=
 =?us-ascii?Q?XgIOA13HwzQbEhSfPAkarau8Jp4iAEFLonREe0OPgZpwlff/OMaGtZQSc3Ej?=
 =?us-ascii?Q?0ROBj5FzlCqioXq0HCPR0+0RErpkdDqzZectasHxr0tMLWFTfw1/5Xhvuudo?=
 =?us-ascii?Q?8PiUZXmtmDyXpIwwC5X50cKL7FYc3UAOywmgqLDZBP3buJgZblLFnK+TbgYe?=
 =?us-ascii?Q?v9U+S1iKm+urbNa07az/zBcIKInDIGvQFAuLJUy2U0Bug6pjIk7ViUerrMW7?=
 =?us-ascii?Q?hGfw1Loc0qozJCvQ8mU48o1Unb6c3y5QG01if4wsNxt7qJuCDvQM9ofZBpUW?=
 =?us-ascii?Q?2JBNt91Sl9h+tPUjiRKAXLQjkY4sEy2rnpUnSoZOjuFP8XN8MRQwa/QQW8fn?=
 =?us-ascii?Q?1kUdfGNnK/gmpAkPoQKmQdd61I5grrfy0/zT/4/PaV6EdKZDQTDvwgQtPOD9?=
 =?us-ascii?Q?ZcaTqaVGClAVPwniX7uxGwXLlj49ZVLeVKpgsG28/4Zo18LYQysolYQQbFyD?=
 =?us-ascii?Q?kWI/bLAeZb+tSFTgZA152gpVbuOxj/arlNDY395xArGYzbF5zbvA6BqCWx1I?=
 =?us-ascii?Q?ERhTOTuDnkR2AqTsYzEnJ8NUSZQr1l/0EpUusEOQNSSXJbnIrAQK8ZKZHf5t?=
 =?us-ascii?Q?AaoqPRId8VSW5m02s3aRrvKQUV4vNDVuxwfDuA+lDSo/dATtPirLCDXPOM0I?=
 =?us-ascii?Q?eFHW0SvK7VcImlTUStBKyhiBv0BiJ9Oq0MJwIxu77E6qOLpYfAySMBOTocZ0?=
 =?us-ascii?Q?8pxWvLuzybRcSOp4oSNTavR79VKVMsvH6RDrjxY3F0bm70ETg/aYmwhkiiJE?=
 =?us-ascii?Q?4xueZm8bnJDTepQVf20s4x5wvbbkVQI0I1I2g5nW2rz/fiIVNvWYP+0FGomH?=
 =?us-ascii?Q?yHABoI8Xb5q6keJ/Nn/tRpnGTunILeoEo98wF/qJMkzxPz62sdFB1ceBFc6E?=
 =?us-ascii?Q?8MXcuYTb4Quno4yd/JP2Ti/lnhVM3CuqwrKVa7w73qh3cVay5WAalN4QWowS?=
 =?us-ascii?Q?logQFEDkP/oyhR12vwFCdbP1RbNoNtqDMGPI1sZC9eMElYo5YX1qMCkAE70D?=
 =?us-ascii?Q?t2zUHtR0K+ch9rjGxcPlhujx9YkHxV5S4PNLXOtit2jiwDR/1onNYJcObQLx?=
 =?us-ascii?Q?Esf1T9DSwp3uI0qtA3Mm7OfbrKRbp4864hpXUBcYuljWK26tH+TeDAOsLsWp?=
 =?us-ascii?Q?JdaF+3U2CNTxFZ/Q7+ckcBcy9ZiBt0jX2PbDxYFlJ0fsuRBDDEy/WDS3vMBu?=
 =?us-ascii?Q?IZ0xwWwQVmrmqy55L1EBM5CaRlfTA4fr8IMqwlg80bxNVC9nPB+XttSTi2Il?=
 =?us-ascii?Q?azij0sdnbmcz5NU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:39:54.4178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15258bf-fc6a-48a5-aad8-08dd3a536140
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why & How]
The initial setting for psr_version is not correct while
create a virtual link.

The default psr_version should be DC_PSR_VERSION_UNSUPPORTED.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4c798236d614..a8b0d558b132 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -276,6 +276,7 @@ static bool create_links(
 		link->link_id.type = OBJECT_TYPE_CONNECTOR;
 		link->link_id.id = CONNECTOR_ID_VIRTUAL;
 		link->link_id.enum_id = ENUM_ID_1;
+		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 		link->link_enc = kzalloc(sizeof(*link->link_enc), GFP_KERNEL);
 
 		if (!link->link_enc) {
-- 
2.34.1

