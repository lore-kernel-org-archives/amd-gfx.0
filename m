Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C39DC0219B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3560410E387;
	Wed,  5 Feb 2025 18:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HK9pEROh";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DCC10E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+jjxlrIlyEV02XI3RrjM9I/cLWeXdGQhHmDnANL1nwAYGrPcqY6ROPMK3ZJRDfhFQu8FXIhs5I4ziOVlnsD3jQz5rdCutDP1PVtbDaA5zNOkz8wpsgj+cLuMFcv7rhmUVQM3hDY3j7Vp6M02SNAEtHzI125tlvaVGjt4E60pcPihz5fQRLQ03zcv0AuLDsC76MdkI+bHsWH0KeyJjJYOb/nNPB6IvB5jDW5W/I4vELQGFNqAJRC0msOuBj0z6Aie4QpQwv/TaFBe0AhBGgVoYfKaHqBiENpZuymp7MbvetRcs5nNWPb7SLfG/IMp7OXTQHrWP1m6PduaBMfC7sfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=othY+AQxPWcIhtOjM/4aPeqpvZ0b7Kd0eHpPn2FvdlQ=;
 b=q6sBVwuc8CL+WrzXC/bvmyAcLdsCkqQfYMzDwXAm3s/D3KGJIQY09omCklLD02YtGratuYFNPJFq9f1I6pb5ln77HnQxOqvMpnOD313wUpj7ml3Hx5TAHM4KYFhv3GE6cvadhfGowOhAweoeoTKPg8dcdAwV1qaA1BJCAroj1SOei+50dZ6NVLL6uSK8TkSs948mnx7rd9L/tmEQvewH035Y+zPZaI2TBm1cwtopE6I0AHB+du09o/nqCfmSQUV38CAr2pQCpd7neZJc/CvQZccDYc06E/iz92pAN0HPQhJAgDvQ+ybVDhBxj5783+IEuhGltoKN6Mg1LGYxWEF4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=othY+AQxPWcIhtOjM/4aPeqpvZ0b7Kd0eHpPn2FvdlQ=;
 b=HK9pEROhIJJNW8X/yIgRh3ZJem6e1/eHg7fiO4wqLr2k1Pj0Xak+GabFK1cDsWPeyjkY2nm63wz4bv2lqfRSxCSuzpdgzcyKbawVrqqFuUaBNBlxWNwrFOVmFPZOCTXEmDMLOHr9dYRTaemdhqZ5yfY2yKdEkE5xgwjOIMRzIUg=
Received: from MW2PR16CA0052.namprd16.prod.outlook.com (2603:10b6:907:1::29)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 18:41:14 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::3b) by MW2PR16CA0052.outlook.office365.com
 (2603:10b6:907:1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend Transport; Wed,
 5 Feb 2025 18:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:41:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:00 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:41:00 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Leo Zeng
 <Leo.Zeng@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Martin Leung
 <martin.leung@amd.com>
Subject: [PATCH 07/14] drm/amd/display: add new IRQ enum for underflows
Date: Wed, 5 Feb 2025 13:39:22 -0500
Message-ID: <20250205184036.2371098-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 68207cec-50b1-41a8-a2e8-08dd4614aaed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gtc1o7who9d9EDAejQPRPvrN1vnRgfvvPBIiAPcgKzL8otCG/m3tnYcWhprK?=
 =?us-ascii?Q?zCOAHMRriMR4LHef/tVAiC4vXoP2KFhpGhyC0t5A6v7mWdZGDhLcXNoBOItp?=
 =?us-ascii?Q?BZhe9gLQPL2jVHxbW1aFRhxHLs55A//6K1d1bqlKQvYpk0anidz0h3wqOVoa?=
 =?us-ascii?Q?C2vkwv4Sl6zWt8Mg5cXdfy+UdNiVOgoI7T0K34zMF7drWluykDEggjirkP5C?=
 =?us-ascii?Q?9aMgc5vRHB9HbBQjY9OKBf74SngrI/vFMTOP3XFwUFL39mUJGtUwFFszjID/?=
 =?us-ascii?Q?kHr3TAvZO9oKoump/1pFFr/Ie/gPN1VOFHF4psu8BvYF2x6DQH1B1feuS/VV?=
 =?us-ascii?Q?XkxdUbVWwaZwX13wAihSyYwGXDe8EMHIK6gKVCT3km83qUyOfiF/hUImWkZ3?=
 =?us-ascii?Q?NPqgFTUxnUxZyM2WVWTU+G4d4A7tL+tfEP7d4HrOzBvnW+SKK68Ui+8M3HED?=
 =?us-ascii?Q?DUjFyRXFJ4Zkk3LO5bA59TV6W+wIVOJDUqjJB10H1GnKJ8PNEg82pQjWUrbi?=
 =?us-ascii?Q?A3luBwe29Ed3BoQKY07tzqOCIOGQxktn4xbCLZMCoeb97oGRNkfemJA9J93G?=
 =?us-ascii?Q?AGw2irskqBJzPwEpsjXVmFPi2+c688+gC/y5/O8VprSHLi0QfrVAncQWSj6D?=
 =?us-ascii?Q?Q7meXRMfDxNeLWjVFPn7shkF6jHvwfDDyJieGFDUyDVtrXb+6wwbStGa/GTd?=
 =?us-ascii?Q?yzpOWow0BCrEIbzVL3P1Z9kTZvxza+F79H+G+InNXBBa1qMCk36LC0cwDF/+?=
 =?us-ascii?Q?Nifp70G/0d7AngKP04p74nmvriw3WyEUhwfSy6nhKgAxydUlM3DYoE6J7eiQ?=
 =?us-ascii?Q?sxe/bGmYJGhcnar2NLM855cnJ/3SZv5Ma5+AhL7GLtSvz5Emt8sYzJCIUA71?=
 =?us-ascii?Q?ytNB9lMj0o4VkohZHRpBq62fSRMzC5QdmvxzGnAmdjyLQI3oXEei7b8gYpUO?=
 =?us-ascii?Q?tFL5US48lGZKK4YVWrhPpVOWm93XiXMmMaZtrIU0y5rq4CJmHsv1RmtT+aA+?=
 =?us-ascii?Q?PQAURYtkbAGeU6uSXHnDRYNYoBhNGfldvgMdaZ0yXXHlnAXgTfH2bxvY8trW?=
 =?us-ascii?Q?dY9OuGRwE57bXFMNsfSKicnnxvelbtZpTgPbn3Y3MJ1rbDUhrFTU9Vo8oAHc?=
 =?us-ascii?Q?LVd3xBiLLo7+ehSfhAz7cWZ1kesOoF5uUEHYmYXjDR+doGZ32j+VsQNhNzde?=
 =?us-ascii?Q?KK760J7ECHPMxOBc3xJEAd5Z91XVcfqE4xKmFHHbGvdKkMbcfGZKMqv1RvcB?=
 =?us-ascii?Q?Exwp85b4kGYIno6Fh9JjJlojviLJV82+PeSoHFPhZkSw6Zm+kBJXHCNz3zfL?=
 =?us-ascii?Q?5FAYosaKkK3WUunjbqISPEjer7RjPZZPLIUWra04mSk0f4pEY4kUYXBJym5f?=
 =?us-ascii?Q?zdT1TBnQPdvWiZseq6NNiw4vJ6s1FzHwfdTgbzqgEzhVeCzouZnS8Pap1Ky0?=
 =?us-ascii?Q?ndX3KuumjcJT0e3Gwgu0XptZnfp/ZpLPFJNRsMYKWslHEoZvpQl4F08xN5y0?=
 =?us-ascii?Q?wb7V/BlQnA/Upsc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:41:13.5906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68207cec-50b1-41a8-a2e8-08dd4614aaed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
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

From: Leo Zeng <Leo.Zeng@amd.com>

[WHY & HOW]
needed in certain scenarios for debugging and logging

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Leo Zeng <Leo.Zeng@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index e962c426beda..110f656d43ae 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -170,6 +170,7 @@ enum irq_type
 	IRQ_TYPE_VUPDATE = DC_IRQ_SOURCE_VUPDATE1,
 	IRQ_TYPE_VBLANK = DC_IRQ_SOURCE_VBLANK1,
 	IRQ_TYPE_VLINE0 = DC_IRQ_SOURCE_DC1_VLINE0,
+	IRQ_TYPE_DCUNDERFLOW = DC_IRQ_SOURCE_DC1UNDERFLOW,
 };
 
 #define DAL_VALID_IRQ_SRC_NUM(src) \
-- 
2.48.1

