Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235ACC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 16:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C4210E5FD;
	Tue, 24 Jun 2025 16:16:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BposUux3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96F910E5F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 16:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsqjJE6m5mGMdzLer4D3glTdcelxsGqSukQirVtLRo5v+/KGfb33/w0C8QIe0VogIQhOizLaEPDxVM+mtFqMToY/kEPrIN7QosswPInlsVFLcx8kry9SumPBIS2+G4eh/yF6SN2jG+KqOr9bVCt+i+Dya73I1iIonzNMCOOM0Dar3avl9Hjb85sUBgrMngsxIZRFDna6y4XvK0idJtBDAZZfXp2/0dEuKTmRi4J0T/ZJq3VFUEgqCRXe2lKyXbj/mfsaotxzZ2TzvvRSPzeOzGbiQ7TuTjwclarI9/juYFlqtCWZAheOneiFgkFA2qpHr8OzFmtkS3hb2/0m2am1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxH/J3I1NaYnThk/ZDmL4idtusKP8sJrFhnCCDT+vkg=;
 b=qQxkd7hfBbY2TGxVlNxVYmunKvAXZCb02iBiBnrLvwWG7ZZDqqs908u2mkm99JXdo4Iv/+7g6/upisdqfR62/lSlGObezwKGrBOBhyiKTXH1NQ++nMXcPyG3JVERJcVAHdJ56NU27zsqAtfjqSbGw390Agk/hQVCut+rhVMRyo9c1Jnz11+3AKJwHpP7rLjoLwTbcHjzrQWuUZcrka/X5r24NI2JSXsFvaaQzmu6Yz4AHS/MPBTum2uCjWFUDdgQNkCa0cVndJsum6EAcAsp69HOKbAoaKfE8/ExN6rckXy+6cC7OfOMXiTdhQ5iIwhDLom2PvzpugMH+UCJ1TN3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxH/J3I1NaYnThk/ZDmL4idtusKP8sJrFhnCCDT+vkg=;
 b=BposUux3o2T3o8H+8bjWgdZPZKyj7b6j6srcL4TFeDCreveYSvUXEF9pKHsBAYU2jXX92gj5s5zE16lgtQP238qQrm2NFpinMxisnANRZK+C8N1I0WYV6/SssHPEzmSdO+8j3rw3yW5OWijtMUiiuYEgWvOAwQ5w2vFeDyps2qU=
Received: from BN1PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:e1::30)
 by DS4PR12MB9563.namprd12.prod.outlook.com (2603:10b6:8:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Tue, 24 Jun
 2025 16:16:49 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::a0) by BN1PR12CA0025.outlook.office365.com
 (2603:10b6:408:e1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 16:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 16:16:48 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 11:16:47 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Include sdma_4_4_4.bin
Date: Tue, 24 Jun 2025 12:16:37 -0400
Message-ID: <20250624161637.6375-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DS4PR12MB9563:EE_
X-MS-Office365-Filtering-Correlation-Id: 2924a54b-1a6c-4bea-172f-08ddb33a85b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gcfPWn4VvAl8uwFoE6//4IwXqIZwI8L4x5LIlaUrm6Cm8Wh20JN1ShOUjxrE?=
 =?us-ascii?Q?BjrDJ7TofELMZSaF0JvEHSktzHoI2hNOUYeWyZ/ThvZGVn1FAhKS0m3wdWCo?=
 =?us-ascii?Q?Jnmxdn7M+kp62Kg1RmqDsU8CUZ94F6ISMLEiw0lb0aQURmeOI5FZfNVCI9Jf?=
 =?us-ascii?Q?+ZmYEzG9daL10A7PJP08VAtpPIHfSTnzkeKOOkNmc/CiKp7LiTLTta3hwV/g?=
 =?us-ascii?Q?LNeZkZWB3QJkxKf3eRO+QNGaD0MYs7Ititoaa/4Xuy3VrKmOKQbW0VsCVyN+?=
 =?us-ascii?Q?lqKopINNsV1oJDMJ4sfM4Jra6pOJwMSFW2JDAypJS1r2LCt2+PGDberoucEI?=
 =?us-ascii?Q?4yaPt5aqWdcVqP/D4MxWkgZKPO0YFiqj1RK7uFrkpMzlL+fOr3nOzYyjeKV4?=
 =?us-ascii?Q?XwwD5Ig4S6wt8L9WrFYjFXvUT8S1H4TR6m3tq24tOR9XEC/MggroBjq1WQvy?=
 =?us-ascii?Q?OQc1V2Hg/jZO5hQmThP76ryjfRQRFjPnX2dl7LFLfs97/d39sUQD8OXeI0Z9?=
 =?us-ascii?Q?hvHF5JU7Rpaa6yJ3Busn7XlV+lV2Yg3j/OKVvn+kEK1WS66rhIBQCGCVH/lq?=
 =?us-ascii?Q?Pys9NHijJ1OBMDNTaJaXWXN5GynGPQZzM61mKOeTAG/gtgSnyBOZUgnGlVvX?=
 =?us-ascii?Q?74i9BP4SManjmhaIHU7TT+Z+/MZGq1TYdo6ynkFbc6xDxcDvIFOdy0gTW1M1?=
 =?us-ascii?Q?cQ2CImt/HaGuyv0dZFxnyWQlwfQVS+kH0y006zT1FX44xjh7vQaL6jthEXoh?=
 =?us-ascii?Q?3q8xoQ3HBkPLanDLaT9KaAKWvYbZly0/7I/nvTg8CK8NjM+SS5Y2Lw3/FSh8?=
 =?us-ascii?Q?X1m7kxSh7tB/WjPBAP9CuAlwkym1RxqqH+dkHAV3cxv9Vu/8SR7oQ5BMsAyW?=
 =?us-ascii?Q?goyNSRP0njWCWLddFM5TVRvph8WR8Gv1LY7Xw2runo20jdbQy68LIJ82eq/n?=
 =?us-ascii?Q?SKsGzCOWMSNZTCtSuOdt8NM5f7gxAnx4u7gxLGLYXaTaXlFliCHzTQiOcM7m?=
 =?us-ascii?Q?efUAjhZez9KjX2X3leiM6c+4I8DlnP7qc7QPyyyCqFw1/z5/fuRhIBQnclqm?=
 =?us-ascii?Q?fqCMNLAjRcaY8yuIW+txc8Q2qBHG8oWhZAHiPDzdisS5avjOh1KC7VRHAI9N?=
 =?us-ascii?Q?p9qn6bJcPAKXqvI0TaSghgR4y/lS+XXhyd8rK56FIZfF4ALI0w87+5IAXEfg?=
 =?us-ascii?Q?rEfvJnf85xhVHi9ZMMj3oKuvqa6GSWioTKNI100Bv7kQSMA1XzPrvrZoX8M+?=
 =?us-ascii?Q?bbvPrzGud32k4IOfMt4cTucFksx9Ca5+00OQX2dGQLRZPwe5d3gR9MUmKvgO?=
 =?us-ascii?Q?T2WFCWAFsDgXSuPCdAcrfbS9ksttzV9zsGd6PcPcv8GSBu39Y706kAvnsYaK?=
 =?us-ascii?Q?LoAWS9s6xkLljctmzS7npjLQimSOv4DG1s3t8l1+P46j/+b5WoogZTjgwjcx?=
 =?us-ascii?Q?NCN28cAK9JWea0yivx4FAzn6nAnC8M4+mx/ma5oLY2GdupjLaKU2RwWfblUq?=
 =?us-ascii?Q?+XRcC5UZRAui+ow32m+LB4Xp1v8Bh86mPRcF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 16:16:48.8908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2924a54b-1a6c-4bea-172f-08ddb33a85b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9563
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

This got missed during SDMA 4.4.4 support.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 5b7009612190..08ddef027f21 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -45,6 +45,7 @@
 #include "amdgpu_ras.h"
 
 MODULE_FIRMWARE("amdgpu/sdma_4_4_2.bin");
+MODULE_FIRMWARE("amdgpu/sdma_4_4_4.bin");
 MODULE_FIRMWARE("amdgpu/sdma_4_4_5.bin");
 
 static const struct amdgpu_hwip_reg_entry sdma_reg_list_4_4_2[] = {
-- 
2.43.0

