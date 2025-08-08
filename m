Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2ABC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 387A210E4C0;
	Fri,  8 Aug 2025 06:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fLA9u3iE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA9610E4BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tw1oEdL9z3WhU217JoJVl3YbSP+CRtPOEtrIAbGZfXoifJ6JOkkR90OpruuNWbI5kWqlf4rX4IjpUoqTwUdH4F3UhNQAY1FzIP1tn3lGzrpha40UVBt8H9YQGj196ycyMSAKGjbQFu1R2gPwk2yDhAL/Qe4AEkZEkLNLOnBMPDN+b+jKs9zLyYCjZKM2xUeqxYLuyqUqdxtjHumv3E/5d9E79efYOGNYI/IYzOrhVcrRwvOWrsLtCp5DGApK1K96Ih9pCIskL0xMAjo/W2hFvX+MZ3wzVgqBIFvoo9z3/9+gndR/4gvHtoTdvtO64EuKFa81SdFYmAQgDZSWbLrhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEZkaZFzssbYJaP5hj8FPmoYiU63lgqoq/smH0UeTkE=;
 b=bFBJiiZSoCpiXadtlroSdTiw4DBtKCzccxBfQ7cX0mlp2lAJ/OmH1n+OxGzrppYm/HnJveKHPnwmkMuRoEIJWrIxTUoxn98uRlpi6qIdLlmJeHHVULHknmI0i+B0a6m4GamE1OuPZyMpauBfKVAqZm/SABMDIqY5h9LGL/gEKWOTEjOQ9JB2eHV8CyiHHbkoQUQQ3YLO7KM/7+pwAMncBCyQRA6h9vHChZVqy03Bvh9LL85cCVQ8O0Zx0y0UT9ybH+zIS28Z6iqvUVryiZ+Aq7oLcnDVntmiVopq57CVizNeOPbsqdhMafZcSRNNuhT0YE/6nL31yIDBeBRhQocslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEZkaZFzssbYJaP5hj8FPmoYiU63lgqoq/smH0UeTkE=;
 b=fLA9u3iEjkAKnt9QpoaMdqouf03206YIlRnJjCiEtkgMGvy9dX9v6flEoSTGsUkPgJRqyzmMW0J67qmApIk0OUqeyN6dQaDOrViVcelhPUcAJEolTyZTiD1TmdoC/P30zo5bd9+HGjXyFoGkXim1tPChavywTRJvbLDrW2eNZs8=
Received: from SJ0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:a03:39c::19)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 06:29:38 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4) by SJ0PR03CA0344.outlook.office365.com
 (2603:10b6:a03:39c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 06:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:38 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:33 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v8 05/14] drm/amdgpu/userq: extend queue flags for user queue
 query status
Date: Fri, 8 Aug 2025 14:29:01 +0800
Message-ID: <20250808062910.1613453-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: e5972dbc-b9b5-4a17-b729-08ddd644f36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1qjzysWTYcDK7NWo5OiQu6rSOE5ugnL8Ml+B2d9sow2X5CyLXoS10aBELaku?=
 =?us-ascii?Q?lz/bonrO5YIETtb7gZrNqjDLHsRiNATP6Gz142FDvXkAde1YDe9Y5f03bB2w?=
 =?us-ascii?Q?YN4ycu3O7vsyokhp6vhSK6JYUTQU6mSL08ISSHxzkb1r9kxvEniFqghPIGsP?=
 =?us-ascii?Q?asjSzWgLn+VQFly29pXSBZ4/rE699TC9zbchqreqTtg9ywS1EYM3EXD4G+o+?=
 =?us-ascii?Q?eh0LAYm+H37Ny6keOENw5/yJi/6UbQGACAhNOJZzjpeCn3unVteSEk1vImNV?=
 =?us-ascii?Q?R8B8/yKQDxxa87MyraeNl28/9GtU/qSMNrDbSS4JIcjgprMDkU5bGXWzY6KP?=
 =?us-ascii?Q?7cBToFTbd72FQ14KqpuLvhJedhKcDK4u+VdjE6jzGHTVrTKnqZus6hAzSEyR?=
 =?us-ascii?Q?tSVtQhPTC+DZWPvXP3YA2iq8obAWnXLYbhILMmEAbGEw5dy5PvdYC100Fw2y?=
 =?us-ascii?Q?UeJ8tJwNSy+RusZbfINWwoZatbIuAZZmIaTTKupoQYk3bpM1mt/6nad0vvEi?=
 =?us-ascii?Q?igxUswA/X1qEPH2aDtq0mcOscndPkdBarjv1uk7LDvXgCymQv4m8hpTr6rLA?=
 =?us-ascii?Q?dLJqbLUn4ywNPplMrqTqxjEDnpBP/bynh/kQAntKqx3A9e7XFy+OJiiosXkW?=
 =?us-ascii?Q?HB1j+Nz967h6k7K7danwlN2CZwvB7RY5aCiiRI1mqxplfx/hYLjuNH/spkhM?=
 =?us-ascii?Q?ciHHvlrRIapNMwjUTUfSc1gRPfeiJ3jDbM6uK4JZ72eQHw49/TWxjb+7XWMS?=
 =?us-ascii?Q?dfiwLXS4wrILo/7JUmKUdSbUNyBDyz2IBIWf3add5NBoswkwwZwJINjgnOJv?=
 =?us-ascii?Q?7exE6U1EKUUGkGS3NgXO9YOXxjB7I4p/dPE2mPonmhyToPIJ6U9yDBQm6wg3?=
 =?us-ascii?Q?aQrAXoKqSxzg1ITHvKMK5fI3692B8nUnGw85rpyvhe5gi/uH5bfL7m0e12T9?=
 =?us-ascii?Q?gGK1p/qXmPeVkjzDW6+DF+QkSRMqZeRldSas2dePuAu+xkcJ/DadCz0sMxCa?=
 =?us-ascii?Q?IRlq20CxjvoYjfH+Uf85azqm6gp4ZmjnNLKQ/7ivpgNu4i0qyWZfq7pmZVCS?=
 =?us-ascii?Q?B0luQhbGYPmgCsBwPGq7VtjyJR953+CuhsjefoQwQksjFLniPeXMOy2l3Els?=
 =?us-ascii?Q?kDyPjoTUS5ArCDf+ZhRb6FoOesXdBbu+WsPm2B4vXQ/RG45S9Sa5VlCKpfeK?=
 =?us-ascii?Q?3KlA9rFVTcjMtHAof6YcV3bP3J/s7RLBvHsLgvQAjJRQTucBvDObtHfzraXt?=
 =?us-ascii?Q?U6Bg0GjlMFRl9pxGzpSiPJGVyR7N8B4K/qoUTLKczOdolB+iEPqWVXAY9ml9?=
 =?us-ascii?Q?o/pOe9bv5tfLag5K+MMyi7ztkRVWGjQUQMzXhoooQ/GpUjVGi/ravFdy78Lf?=
 =?us-ascii?Q?2nm96+0oa5/GlBF0U5qUXoxMGFWWmC8du7zqcSyKFFH7Cos3Ncj5dUnVMW4p?=
 =?us-ascii?Q?8r69jPk2UfrizpmneYyGCqvew0v8sSAXwGDkgPOZealVhwQvsuHzQrjVrqVI?=
 =?us-ascii?Q?CYaQcbe3FbhS3GNF/SKrhx8CQFg/KJ4BYfln?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:38.5440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5972dbc-b9b5-4a17-b729-08ddd644f36f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
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

Add the userq flag to identify the invalid userq cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index efd0d2356077..3c536c8517cd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -346,6 +346,10 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+/* the invalid userq input argument */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_ARG (1 << 2)
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 3)
 
 /*
  * This structure is a container to pass input configuration
-- 
2.34.1

