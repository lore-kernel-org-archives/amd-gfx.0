Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E705EC369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 03:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0033510E346;
	Tue, 15 Apr 2025 03:49:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SkV0FKc2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703B210E346
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 03:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWMQhtzJiaZ9ACmvyJ/HXQxGrILiBWWZeeTMwAUCUfMBgZRphmF8JCwUT+w/qNvu6seRoah6YhEhy8scwtupYYwoLxsz+2UlQ8zkzdEzxTYr+FefL4mPcdnXr3E7U+8onVo8xttVTbRAF1i3/vtWhQ7Yoy2vrMB7sOxX1KIOfF3PRe8Lpxj6kZTJGfpK+G5kSac38smzwPpCvDw1JTsscOpfkS4cDZ3uEdJjGSGI33DM64htlxc7x9RkCHvw46wI/UA71jSsdloZTqmCwPke3dXhqmDp6ZVn15zt4czwV5IMD55xKkodwTOmQY5QRKY/rOTqJ01N6PoGH+XulVzdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS4uC+Tr4MTSTetw7q32MA0fWncWRaA/UKpzG6Wq06M=;
 b=twQETMyOLdggkIMLrSavjLh9sa84sjxQf5FzOoFYS+vgNs0G+Iat8xqpi6r+d6IucGjLo5qwXRVtV+uBqK/z9smHf1uBbYR9YqtVdK+bvTPYvrO8fWFHoP2JhMVH7gPzeYCAN5c+VxfUyazqshLpYFHrDonBNX3kCeyi/JbiaUaOdttX0ecAXnekUq87BzaFPqwKQ3CHe58VzJ8DrlfU85j4liLaXR89sb6u0Shr54DMrlkNLk6UjqmqknEHIimvpLsXuHmW3ZE6zHyr35nzIhBvBY1JNOxh5FigF9AyXiOpblLCIxv12npscw4+fdk0+s9o6fm7lbp4I81nRjzoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS4uC+Tr4MTSTetw7q32MA0fWncWRaA/UKpzG6Wq06M=;
 b=SkV0FKc2WAIwMgStfIPk+IgkB5Zjg0QrzFUV6dijHjnq4W2SebIwBsaWpf3d2VkvB4cvKSnd8g5ur/7KKFg6xSdlrxTukZSbr5sPJeHtD9pp9r451mumrKjd9+diLQdDYhC+wpkqvdMVivQx7Mxi9IEnLZAWPI6FdYg5BrNNwSQ=
Received: from BN0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:408:e4::21)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 03:49:25 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::8b) by BN0PR02CA0016.outlook.office365.com
 (2603:10b6:408:e4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 03:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.4 via Frontend Transport; Tue, 15 Apr 2025 03:49:25 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 22:49:22 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Enable host limit metrics support
Date: Tue, 15 Apr 2025 11:49:07 +0800
Message-ID: <20250415034907.106855-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250415034907.106855-1-asad.kamal@amd.com>
References: <20250415034907.106855-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: b36be4d1-8eb0-48ab-0353-08dd7bd083f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7/vxUJgqLWo9RCzw7nPdHtdQ0K8mi3JLJi0nazn588t0gPR8C5+A0HSXy2RV?=
 =?us-ascii?Q?0qViXwPEAlDGrf8EBq5MK4HXjVAeZE49uKvVdlMiwCoPPJCTWVID+e2f7tpZ?=
 =?us-ascii?Q?Iecm1a9eKlxUC3bUSYdlyIun3BKhz6V18O6LmRulo9mICEn7m6yG8dd+FyXU?=
 =?us-ascii?Q?e6q9q/0XCRefEO52fiEnauEfK1/uI8CqVKYL/V64UNaoe1GsTrZ5kAVeSYl4?=
 =?us-ascii?Q?6NLpw+MUTdrhPJ9cNacXKyDYcJ1I3p935h8Ge5l31B7rWK+6+D8ZuWn9La/3?=
 =?us-ascii?Q?TK0uaYRvHBl9ZLhsodTbXoMImcr7HjGOHYRSM2UlstqHboj4ubLLoAkr+SXc?=
 =?us-ascii?Q?hjLhclRYcGlOg0R9CuflWUYz7IMk9B6at8bwodrI4nEPw7n8hy8lJ8S6MUP9?=
 =?us-ascii?Q?BuqvctJbXdDPn6ZC0S+ysOeW0e11RlLaSusGoSsBTaAu1qaBIv01ysAHrbTJ?=
 =?us-ascii?Q?bRTi2UeP3NbouNPDONJicKxoZNgC7GQ4I27AtEbXPbzjlWwr6eATbp7MOTqH?=
 =?us-ascii?Q?2sD67oPuO3LCdTtv4sMhdNVB4XyqIQHHebhYdxdFFG8VVyOsM67VhJaBAANw?=
 =?us-ascii?Q?takV2EsI9cLfvVMleJOgs0SwPv89AMDLVodCgrswlzuMP+adsTA0JF3vVh1r?=
 =?us-ascii?Q?iurPFRxwLJeOUIp+0MJMnLRtpZpqAMuS2NTmhKq7zfzIJWPA8Ay3XVVoCYvR?=
 =?us-ascii?Q?N8oyuWMb0dlJYJjLWq6wyFV5dHawD02y2zJRYGOLLi/y7a3UQA1YfdIk/iC6?=
 =?us-ascii?Q?kMGsCswZQIhJBQXr2cTzInnTcKrXSQhNQQOsKHB5NJnotOTovUnsX6PO3x5s?=
 =?us-ascii?Q?SBeU074haEyhgqtF714Bg4Wj2Lrk5XiSpU2420LODHahZ2fo664SJ/8zPJ9q?=
 =?us-ascii?Q?vBaJMrf8cnpTJigssolxjhcikNiqa5nu0+gAM2NmaHORVf1kAttRASkICBpK?=
 =?us-ascii?Q?TTaUnyn57y5l1MkqhQVCfk4qGrQXXhb+MUI4lDE1koPVRt29mSa/VCfwfwwt?=
 =?us-ascii?Q?FXTTLY/OWJPD5e/rugFlVzfyXKZ6L6bMaGdGQ7qAgh4eKEYCqbwi/cnoFLNZ?=
 =?us-ascii?Q?eUPdbePblsU0MMQeem40os1Xk9OP4/UJJIV+lyZ/xZdGl9HPH1oIxsP9j5qG?=
 =?us-ascii?Q?i/wZobcejKusLXE7N0Bhm19etqV/GurgL2aq+fH7VIZ/6KC4awBfWm1tbKSz?=
 =?us-ascii?Q?uarer5eK5ngB9VEtL3OOzsHoL5FAqtN222RSvupqnwSi4eN65jI+SpagCLUa?=
 =?us-ascii?Q?ZymE989HKbdiL3Y230f5ozT8mMbXD6FvyyJnGWfUNMRNJYIZpIZpvSSZETFz?=
 =?us-ascii?Q?WAyeAm570YHn3/I8C0o01tuRFuoEdi9+ffWvzN0+Rg9GeyGAYVx5NHqJMGRY?=
 =?us-ascii?Q?KgmqczDbx4ntCl48iWd4saZn7w9nKLogyVkhJdqpWR0eDvXkbAmxDss1E6SF?=
 =?us-ascii?Q?kfjnstXN/EH9eP5xZjgCFznxG+TyEnVnNYcJKC+ZC1mGnJOOGdnZWIFtIVlC?=
 =?us-ascii?Q?q86vuteN5s2ghH6NCXupS8DVBA1G81/tAtoL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 03:49:25.3219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b36be4d1-8eb0-48ab-0353-08dd7bd083f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
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

Enable host limit metrics support for smuv_13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3f61c94ea2f8..6d84257b5301 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -337,6 +337,8 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 	if (fw_ver >= 0x00561E00)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
 
+	if (fw_ver >= 0x00562500)
+		smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
 }
 
 static void smu_v13_0_6_init_caps(struct smu_context *smu)
-- 
2.46.0

