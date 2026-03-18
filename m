Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B2810706E8
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 10:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67FED10E7B3;
	Wed, 18 Mar 2026 10:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FaITzuyN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6DB10E7B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/JXiBes387SLuBRaZaFDkkFiyeg7bzzYKudYIlcbdzjcnA6QhNp98Yc0SLaUoGqwYEKsjQuQfEJ8FNxINYjDfuXdSoLtT8Hs7DV793xHyeGOoMeaWdrqmJQOc9oM0V9mmS/eYz7t20J+8HzmL4+oVftoqzgzmqeJG4IMstpyyH0uya8OoHj+XzgkWqbvgKlAryMinrdsE5R9+Un8Bj+5KXeLtM6Dqj5lfTyCwcaS3348uwsgChH0pmzYMhLSS6uYgFM1/5WX0EyBb1tNrFfOOH2QBv5GyolBy8elmc92uWwwBxnwJfpjHJj639ky9wdq19dXE8X3zmQ1inH30elaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9r/hex22YrSS6R3fDGHcXtJ8fcqykLqniJaPs4sbe0=;
 b=YpFDqxLkzYUyEq708Gas/H9tS7T8XEZ1d+NyzCKtMqaWIXqEWaS0IVWTQ8m/HCADx5QEyYVq8ij68SLbZXDfspgNR8KEdfKwu2l57fIg5x74YmpjSUtV7h5ARnWHpohuHKeU2Q/VBymaAniJiu1UaB4jcABbTahliFl0QL/5fmgLvLAVu4pTXGVvPEkZxL2a5NHAIgQlchOmV7+Tq0nvpU1kuGYX49d0lr9J/sn3NP3fd0GnmqlWd+AWsTTX/JCcm3zZGRGzkYsgvF4xeEEzeWmmEOU7CdNDJpqe6poTWwIGvuwyvzu7GzVVVkCwBbRCK3hufMjmF1FlTVietsnrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9r/hex22YrSS6R3fDGHcXtJ8fcqykLqniJaPs4sbe0=;
 b=FaITzuyNjc4O/B3KejvG5EbNvbyvGWazqH6kOXW5+uafEEYLmVT61jOZcE8lbvqa/4WZoaGydFi2egXCdVspBfkMUVxKAnCoXxd9V9EneTWQV4iHWzE/4OPRHht5wORyzjwsg0ZnNQxBu5VsfT5/h7RLIbf5PuG7EyVErqFxFyM=
Received: from BN9PR03CA0157.namprd03.prod.outlook.com (2603:10b6:408:f4::12)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 10:39:31 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::55) by BN9PR03CA0157.outlook.office365.com
 (2603:10b6:408:f4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 10:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 10:39:29 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 05:39:27 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v3 2/4] drm/amd/pm: Return -EOPNOTSUPP for unsupported OD_MCLK
 on smu_v13_0_6
Date: Wed, 18 Mar 2026 18:39:04 +0800
Message-ID: <20260318103906.3107670-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260318103906.3107670-1-asad.kamal@amd.com>
References: <20260318103906.3107670-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7fde0e-9436-498a-7258-08de84daa29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: VlEBmtJL/hpquFSE2WSaDMWgxWdKJfMSxPlKTuoiQHdW9pdYAVyDLvJxymBZDcSFNs3MDkUm2Yvueh28i7Bm+i4wtuUKUqrPhrnlzNrzAH1Aklx2ltWMmGzOrfuVsZZC/6WBCXTFXlR4zN7ZCE73uTQI8a7kUdBnMwYCuw6ID8/H2gsXEYyiLg3O/cvd/ldR6DFGyjiP/cNbsgFC9ByTL+R7s1nw/JKXUg+F2HQ/cZ/MFTybKfQR5g+triqM4Il+nHxB5+w7SPN56vgfTq2FZmUPslvc7HT4zVMxvCvNybzYjJ/gEoZOGte82H9ymhEor1eitQgqhGniYeaT5jw36it6Xn4fEUe1WLpO8rxXvEfC0+Hly8JZxnk9NRlkimJycdf5+yvSRl1zoEMMHEWO3gvgx6mBwoYXsXEXfhZf2gQ1ndTCMe5m14PtpVIta+ndGD6IgNeqkB7TYfudJzIoHGYIerVSEBPvpiyP8IhXvNEqGKZI6sDsAM/f/8CfchCfTRmxGficptsmVpcgBCMg/OMw77qLgqgNuFV9QqIotDYeq+eLGYZgG6F+FFnImjHbPYh5tpe88nHSQYp7p/4S/HzBB1S3QS6wI6T4k2c+qN2sXkz6cKlzPq/tQrem7oFww6AknSQTebTAHL+fO0CKuohRHkvOp3hn5pSmal2et9JGThqF9dyGFAE5EHolBBBWT1KzQ1xKE4xFzfVl4YV44e9X0wMpSNZOfarqCJtSCmoj6TJRhnWvN/MwErXZ+oEbzrp8jD/a/6IBxSvdXA6QWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2RNKqfkoBKIxrvqf3dL+3qfagB1qXeR5o1Hm7vY65wBLydQyliSJ1My/MlwTmdkpG2tzSWlBGfIpTynd15REJOxsrUFnbagqCfxry1peq0jRU7eqAoVTV5J01f39CDynz64RMEqUc3nD1WjtSDnTQaZKv8lXWJTki0K8Wx6P5ck4lnV7n0nKHHPjWTIxPWQairFGpnToDrcaAsb5dPR54D5cJMWGkRf2FRovapv7+VZCLcFup1bHyaQmk9gKt/qkf0H+9TLA5QIBP2mXot9BXKialg4qVNVD9aTdYCOhokT4B8eTOxtFmLNVw5eKONmujkK+WfzLdJZ1b6onthoGzHDpLr4r1D2bGTEK2vb2YQVppH/lPEW+yJKyfM43S/w9emJ7OVQIttCX/EA9zE+tSXDOp9GI8KNQtxsTXopLsZKLlWgxaRZGOKLcB9WsvLBp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:39:29.8773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7fde0e-9436-498a-7258-08de84daa29e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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

When SET_UCLK_MAX capability is absent, return -EOPNOTSUPP from
smu_v13_0_6_emit_clk_levels() for OD_MCLK instead of 0. This makes
unsupported OD_MCLK reporting consistent with other clock types
and allows callers to skip the entry cleanly.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index dcc447e5044f..bcf8921bf1c7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1394,7 +1394,7 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_MCLK:
 		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SET_UCLK_MAX)))
-			return 0;
+			return -EOPNOTSUPP;
 
 		size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
 		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
-- 
2.46.0

