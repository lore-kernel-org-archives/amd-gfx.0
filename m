Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB88D6ED28
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE45710E935;
	Thu, 21 Nov 2024 13:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kRpajfym";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0813510E933
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRQyDTPeOcAh6sE2Ds88TFRMV0ptl3bx7ndaWmBjDpDJa6MdStnDuZ2ksknpRMPhmnRtODXxz5IOlNUJhqms8eUhrXezX08GfFtlRZn2jU4XfDtCAgTR0KjLWTrFTBVN0ADXrsnFAKO9Ualjfzl9AF451x7oiDCWR/Vu8d+Ikk1k/0zK+ocgVZ3jzBu1/UFGZHnCH7TmY/Xp9vXpbMk1wG+XrL6HdQjbU6TQhqhAVc0HpeW+aZA50mnYq2w8C5+idNnFBoZXyKEaBz+zA0POBHLBw0fJffQPkdy9B41A1LX7PlSlKE+gKwUE/Q1QB0kbE00WR1ooQWaOpZ8RVaQB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDqKqgvxdnXKsEE2qjB9SjMyOpV+lV1fpi5gSezy5R8=;
 b=QvvcfnmMccPOnWp/r1ccYwOaT03kaYhtbIxepb0gchcT9RiRFWDQ4yDOFHgsLIAkYEjC+rR7HWrVCafBY/LpXEPoucIvPfW0o42Vk6C3KWjwrwLC2nfiVXg7MzYg2pfK1ykm1xsogDk3eKefyfSlZXuEnMckSjMJZbgs31qmh0whpbh7zzocgDaEpGrS3STwNdGhQprxUslwcr4yRa0QTBvyQts663rC3x0BplYqFM4bL5MwZ5+RMXv+mgx+8YFZUR9VwdLfrtEh4aeNdIp5rzaYS+/foDBrqw132q6YH4II4tuv83ssJNukW+5hapjGEoxCx2R9fWrmmBDxOXOKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDqKqgvxdnXKsEE2qjB9SjMyOpV+lV1fpi5gSezy5R8=;
 b=kRpajfymYaL700VvVO6LkwoHpj1UwTOwhw81Et+i4PH2AzgZf5MAczOVjWobQxYl97atpVqnZX+Q1j3oDtuFGJyTiOSlZ2EM31U51u26kq3dlMFnG8DnchTk/PzuWph3x/O0TT45cR/oD9cPtM+B95NR1tGHV40aEPGy2tYZ2ZM=
Received: from SJ0PR13CA0214.namprd13.prod.outlook.com (2603:10b6:a03:2c1::9)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.34; Thu, 21 Nov
 2024 13:11:27 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::b5) by SJ0PR13CA0214.outlook.office365.com
 (2603:10b6:a03:2c1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Thu, 21 Nov 2024 13:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:11:27 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:11:24 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu/gfx12: update mqd init for UQ
Date: Thu, 21 Nov 2024 14:10:49 +0100
Message-ID: <20241121131055.535-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121131055.535-1-shashank.sharma@amd.com>
References: <20241121131055.535-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: c9dd5709-acc0-4df8-3f6e-08dd0a2e01f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GDfjaJJEzpwRrADQtkuFIBWvJg0nh0Kxx0VZ+AXeD3W0AwFJy6Rb/2aIwEZf?=
 =?us-ascii?Q?GajXxMga+Cx5//nhk4Vohz/dH6lloGFgrcWe3C+ow+dl/1m2YJ5+/xZqnbXz?=
 =?us-ascii?Q?bO4L69BqWUXjszCPkmfJJQ0gvbmSb6iQU9axSs/UKorLTgQ6JAdLHaow+oUV?=
 =?us-ascii?Q?1v7SMxInO9f/q14Q9donDLQpnjvchez1TYgRbKiQMLt7wBqoIkCqvmfGVK3b?=
 =?us-ascii?Q?nBTnv889T5+WjCzXruR31CtMv1G33Bc/rbW1FbnjKF7nilKpV6p56kHUKgJ1?=
 =?us-ascii?Q?YWQ/L8e6fIIj5IxZA686qkbpfCbvbI7pgO22bVpM+A9Efw/KS5Wts7B2Y1mr?=
 =?us-ascii?Q?2cshKLHORbbQ24/Bq4EX54yXt2U6ud7m0N/2CvFnSBQmCC6gZxeNzIcwmCl8?=
 =?us-ascii?Q?Swr5yvrV9stbtnEYypOXSQKynUuipWhpEEWca5+Xt5esZTTPaQYCdFAyqT2d?=
 =?us-ascii?Q?T57sGDGEbXpliT61QlRhfO6opsSic0dN5lRBacTeGfvA7yapB4bARG2v3UGg?=
 =?us-ascii?Q?eBySWE9uyho196RIkvnf7p+YGUTA31kayBl0YMLZ1kJBqKOOYR92OAUm7nYV?=
 =?us-ascii?Q?uR9DMXzjYLB2Em7HWrX5FxY/0RN47M1rsoTjcdNj1sWQWDrVdTM5NWHllAVz?=
 =?us-ascii?Q?54g0t10Jd4HCvkAzu8eV22NG/wIFgNrdX4tnJ11uNNtTL0h9Pnh6ShDY/bub?=
 =?us-ascii?Q?qbwlR1E9JTsh3fSq6azd2g+SnPu3g/Zwmt/F2X9w1RxrRHcLfV4tFqtZq2fK?=
 =?us-ascii?Q?i4u40f2QjVk61wHgB5ehuEwIl8BehNOMLTPj5C7Vp8yWvZmA4HF6pi/2gQ6t?=
 =?us-ascii?Q?7hfaL8y6bRb7Tgq4zZyBk6WfiRmlR2TmugFGnLBNWzaPf7mVVCNuvepd0FFa?=
 =?us-ascii?Q?RRDvFpUAqFLVjSVWF/k3P6PrE0XUicw0hb/ntDJSfc1+azWF6DUTdguW2W4B?=
 =?us-ascii?Q?Oa9I5cIsuBqrvQHj/l8pptSZvypHAihf9yLa6bdir0UPanBAt6k8vewtiXE9?=
 =?us-ascii?Q?ccLqBduqpVLQalTSaoKUiZqhCC2nbwH6o+QRxMd4dfML7OpIMmxwZLTmrAIi?=
 =?us-ascii?Q?g538bBgV1xu1/3nLihvi3ZtpJ3uPBUjY0t8IiyPvrGkYJkuvGdv79eJRXZ+U?=
 =?us-ascii?Q?hl++LPqIb/l/WdZip/zEhhLTHvurkv7gM2jxaMyFB2mP/+mGY05wYSlAGdw4?=
 =?us-ascii?Q?gx0MFwUgcszcvZFIq53AZd7hd053UWr0URASCiYYVs8QNiafxzY1BTMVSGEt?=
 =?us-ascii?Q?O56AYj5dwNpFx66hxrAbHcL30LqHyn61SedoXCr+yMHnrGmTVeXfxzYfrusT?=
 =?us-ascii?Q?ZTecsTy+Z3dmouxZb3uBZAD8V1dvR3f2nnkbIT0BSjtkrxkMlCmMDxWa/JZN?=
 =?us-ascii?Q?OQ78Bmcx2jl8IoSaSWBh+P6L/LSjqY9oiZj5MtRq1b8mOP8sMQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:11:27.2161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dd5709-acc0-4df8-3f6e-08dd0a2e01f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989
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
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 546ea709d43e..3a7532db9b8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2962,6 +2962,12 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
 
+	/* set gfx UQ items */
+	mqd->shadow_base_lo = prop->shadow_addr & 0xFFFFFFFC;
+	mqd->shadow_base_hi = upper_32_bits(prop->shadow_addr);
+	mqd->fw_work_area_base_lo = prop->csa_addr & 0xFFFFFFFC;
+	mqd->fw_work_area_base_hi = upper_32_bits(prop->csa_addr);
+
 	return 0;
 }
 
-- 
2.46.2

