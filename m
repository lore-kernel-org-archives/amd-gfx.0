Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250A9CF9C71
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 03:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7CC810E76A;
	Wed, 25 Sep 2024 03:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hCtGHpws";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31EAC10E76A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 03:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0oeCGFyPCpFfz02GNXQuiNLqysysH0tVgqcL3EeX8WQg6GMS2d8lorKi6CkHrHzTkpM5Q65hhMyKnHUSsWPndkqhQGadYBh3Tz4iqSjbqQtKHaXTW3JQ9O8duBy78ybha6/ysc2SiDWYdbkbaJWmRPecPkPbh7Iml/lbPxzous5acZDFwFHJciuqKV+rtVisR83MOQQFZxF6QGCVyETt1VYMwH1kHAJ0e5kMPSJsOi5PBuG6bsQt4JEVWbNsdOFiBSHL7fHVMJOlQDhwfTJVkxeFWNbYJ8BBKnfQNgmF5jSGR+N7FRCpTZv8Vf+WQYRhj8LqfpG7BkhQkkFFI62GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDd47qoeO5+RF2ZmBUVKJcRMkjMqkpD3QQe0Kmb26r8=;
 b=sdoyoPxsWPzFrXu4QVa5E7VV2GdWPl2/FDusEmdq26viWhXVEGG8m1iwx54+az5ia2CXPoPYJNrCgptBz/nYiC8/7c/NusAUpJBpfnbmnqK0kL9999Q2i/fZoqHSuB76V3o88xj1apOE3Whefqspt3Mll8ew8mqRSyQy6xzOmvwuuepz1EUaDLLXovPdZhNx14xmvW8CB1tLIFQ5aVUrC/kTDTFqJdH+VHmGoVfMByEcAt79MLyOfa/pSEIDvHnis7BDtC8Ic5FPVBmBiCynBpCNkmUFQE1kwiIA743w4aiH1fOs4MUXLA8H1xedHps94MmcMYrNpjNEXu4ss+Aixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDd47qoeO5+RF2ZmBUVKJcRMkjMqkpD3QQe0Kmb26r8=;
 b=hCtGHpwspzVYa1UVGCEPptAUiKS6rES5R+CGEXosHwKa30r8pVne5buKS709ZrxGJaAESAHXao5A+Byi4VbomhmS2o7qv0iRsqLMXA41Ullj2X3UYZ9e2mTWVuq4zTw+jSS7MqgeyujOILVFGHtev4M5msCfUc5YuYeMBzcgzTg=
Received: from CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::16)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 03:11:45 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:610:116:cafe::25) by CH0P223CA0005.outlook.office365.com
 (2603:10b6:610:116::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 03:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 03:11:44 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 22:10:22 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 0/2] Init SAW for mmhub 1.0
Date: Wed, 25 Sep 2024 11:09:49 +0800
Message-ID: <20240925030951.603486-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 69279bfa-045c-49ef-e0aa-08dcdd0fc95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lS2KvNi1CrTk8w0ReAoB0+AJj4nvg963BKR4nk6XmkdSvo2G1qfPO5DWSHES?=
 =?us-ascii?Q?2RfEwctRoasi6ok+HaaoaNFDHbVmeZ+svi451IObWbpk8UvXYdhbC5YKXi6P?=
 =?us-ascii?Q?FDRepe34MNsNVPv6vJ5JoT7Jc2QcSq3TF5hMezhBWH9wF+uM/47S1TbFrff0?=
 =?us-ascii?Q?HzYAMCAzr4aNV4jJ8juYB+0eqqUDae7MVPzDc5xCFBIYxitHN81lM9Tt1Vuf?=
 =?us-ascii?Q?PeRLpmZ80WwCp1bc27JcyhVM5nUG3dtMl6FdqE1woqdUiFiQdCTZTE+5HEmZ?=
 =?us-ascii?Q?rgMWSsOX6lPzvPpq/C5o50HEAgq/uSNxzjL2MYMKeIl7t3BfX8iXuptSooGc?=
 =?us-ascii?Q?fs4Nr90g6KvjGRuUIKT0ARMcMbrCugZcluXTDh0JR9ngRqk1Yc4Ep8zAPueF?=
 =?us-ascii?Q?KHoJq47tHLI8BgeQb1XdNgQvJTPdcnZGliu6RaOw+nuv2SG3TZGju5RKZ36c?=
 =?us-ascii?Q?6h7n9P3Sydx80ud3DGaHtv4w1Y58pPpKNTfi2wcizW1dv8/De9NexIQeu0ZG?=
 =?us-ascii?Q?bgn9wUH3UnPezerJgGccuIktIugWSuqdaxtfUU1xd/n0/wdBZmL7gcGE7wak?=
 =?us-ascii?Q?ymdQF+Jy3r7IepcwdQaG81C2VK+z0CnInHiS8Hzrgry8kYBJ9hk4dfXDJ4ew?=
 =?us-ascii?Q?iqkPyQvp4zv2VB5NefN+mZa3IJl+dTxOODfshWmBbpb+vZSTqpHY+TXn+A9r?=
 =?us-ascii?Q?ETBXfKBKsif+VSkbRxp96zfNfIxDukv7LNItnSfo1cLWAdwsWK5ZCeAyhnC3?=
 =?us-ascii?Q?Lz5jauTDeZPG4aNmpl641lKmilCKRcTkb6+f0mNXk6jGGkIWRLEGdebz/YGn?=
 =?us-ascii?Q?xYqxjsdKSjf8bnM1szJmVsJwGQB3czJSjvIYWpoTLDNLY09OukVITvyCICSi?=
 =?us-ascii?Q?e/N5X3zsD5DRaaHE0vUYpMXOb33ZuCoFbCPMmL83SHOeclt0mxAHA/fbxLun?=
 =?us-ascii?Q?UfMHGUz9D/X2AtWBQrYuM7X+DRYnuonNGmDihFJfLSve9YPLqMieSdCqViXf?=
 =?us-ascii?Q?xEVFa0/WufV5rzp+q1HRrSmiPwu7296cYaKtuS+KniZ1IWi+BeL5G0Bh4dSp?=
 =?us-ascii?Q?dwrXhu0LTxoQtfteZ/0bygyDQ3zd8TDU3m/dPRYTbdugKBMoj3jp6ERcXokC?=
 =?us-ascii?Q?npsvKuYV1m8chvP7kxogRVDxuUCjzMpS5Y75DnyzCp6PzeR6QfnJDoS0BJ5w?=
 =?us-ascii?Q?ClDA+JL+SH/6pIEPxc6WgWq0eBY9H8L0phNGx2xZ8ou3HADqW33b4R99QuXA?=
 =?us-ascii?Q?FjuINFTbASdGqfMIKLxmolDXP+9d1Wh4BT2fLlWHgfmsnYhgRM8hu+CQ2/yK?=
 =?us-ascii?Q?1EXwKnuWvIpK8ZfkEwnI2IpU57SAF63VG09c+ToWIMGXjobXBl2/0ONZrU4v?=
 =?us-ascii?Q?CxhtArdccbIKwWEtfMTMIaa9gQ9UdXe7db1zeFWn8YWEPILbRs+ItNu0M2sz?=
 =?us-ascii?Q?lsGjK0bgyDoiGjWHFSa8rOOv/0Ae19VP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 03:11:44.9172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69279bfa-045c-49ef-e0aa-08dcdd0fc95e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971
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

This series intends to initialize the Stand Along Walker
for mmhub 1.0, to support the Image Signal Processor

Plese help review.

Thanks
Zhu Lingshan

Alex Deucher (1):
  drm/amdgpu/discovery: add ISP discovery entries for old APUs

Zhu Lingshan (1):
  drm/amdgpu: init saw registers for mmhub v1.0

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  2 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       | 49 +++++++++++++++++++
 .../include/asic_reg/mmhub/mmhub_1_0_offset.h | 23 +++++++++
 3 files changed, 74 insertions(+)

-- 
2.43.5

