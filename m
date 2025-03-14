Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB71C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 09:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8AE210E97C;
	Fri, 14 Mar 2025 09:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Os1iyys";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C28910E97C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 09:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNPx9LJk18kuuPuqc8rgy0tiwW5J3AyYiuG/+WgcW7ocw2DTts4cBHWWcg+ziEH9bZPLd+KYEU0CT1wOaZogsMiz04Jhzt1rB+TEdidMGXnVbS9h7hDUqmWzRjG3EwrL5gdsWO/Vj4P5XFeV1MjkYvcIOUEfU7bc5tmtChH5hG/GqIlJtqXpK7yP9At7oFXVy0YdoIKcRsEOLnOha5yHw0za35DnqtpTEQJNCvbsv7HpKZyviTz3wruBiSg9r4MoturhjuXA6Zxq7Oavru6KVqEWbmh+laMZGckEkZaNZyu2dJpoa9xyefzN8I298HVtGZBxiLIkNP2RdLUkEvva9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6Vz2R0Cuoh/ALBkCT7v7hu99MOXDKqFAH8lbYCQ+vE=;
 b=hG85EK2qIsB32Zz0/A/cTIusBA/G7dEy6PpKrQHhIKqJPTwKd0sol6TYFgkVlzQtmOdAfByL7xeh+Y290OfqexCBJ8CykpcedNjdYBkfdxPoD+p/fHJliJUkaiUngnSMESWQLvM/DDIFS3ICerejaGiEVzcVsjDiP+f3u2et6iXuGbZu8y/xaikz82F3Cvkupf4CwDKsGF+Wx4D9u3rYT60aA70YVIyuNrRAaQxFgdJKymk4eFaTiMnNyWHWcE2J4Qx0PTBijSAZRFov/OYVeKSieB8IOS4aGoLvtwOVS5RUutdG24GX8JRysILHduybRGjsOqMDE4wKoEiUBlzpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6Vz2R0Cuoh/ALBkCT7v7hu99MOXDKqFAH8lbYCQ+vE=;
 b=2Os1iyys7qP9t8Vni7Hlan2giJt4938R1HkW22DrykdxXsLx8dNA1zbcVyhSpZu2MTcfrwYk/o2syFHjx7DYk3DHZxQUySmjtOYNcsYUdO83zBczJBbLgyWVcBuuDCjxZrnpZtmCvXxy6XSpzmxQLpEZ/87fXFv/Z1VIULPW9VI=
Received: from BN9PR03CA0661.namprd03.prod.outlook.com (2603:10b6:408:10e::6)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 09:54:49 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::aa) by BN9PR03CA0661.outlook.office365.com
 (2603:10b6:408:10e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Fri,
 14 Mar 2025 09:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 09:54:49 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 04:54:47 -0500
From: Flora Cui <flora.cui@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Li.Meng@amd.com>
CC: Flora Cui <flora.cui@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: use specific ip_discovery.bin for legacy asics
Date: Fri, 14 Mar 2025 17:54:27 +0800
Message-ID: <20250314095428.2914973-2-flora.cui@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314095428.2914973-1-flora.cui@amd.com>
References: <20250314095428.2914973-1-flora.cui@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f89dfe-1202-4f0e-c35a-08dd62de427e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U9y8gQizzPUl8x5yRlSLtEzEgffLlFEUVxJOxj4iceGdbszVsW44VpSEehl/?=
 =?us-ascii?Q?4uWT+ZERsePr5bC3vaslJkHUnWYsz9jkK1nhHrnwPYqLtcNmeduS+QQJYPly?=
 =?us-ascii?Q?HBenmBjPWYjYw6jVceHdi6+FIHC39qYQYM4wKJhSDf/2bMi0MJ+xvBrOa+4b?=
 =?us-ascii?Q?FprIethMfRvQV19MhwEfMKi8bRR6F6w0h+0OthxLl2ZF3rk6WgTDpZakDJ84?=
 =?us-ascii?Q?RqcnBOlYvrbDP1GhxkU1WhyrKLDL+irmzuAs8KSSH5DFVzWApjfRuIHdGFbD?=
 =?us-ascii?Q?qvfgFQXBFQiXtQncI7Wkn9Q8O3lxhyeAbLKeZ5/5eDVkdj15gISOOb+RCcoE?=
 =?us-ascii?Q?OR5wjXdHbMS27GPW4ReXl+IlrVH3sXLkpFxqXy5RizReM6BxgXkr4bAfppOW?=
 =?us-ascii?Q?ogPqkV5viBAqQKbrxRvtdUW8RjMsDsTAh/NKdx+meORRSGD2dtQXZIPFPqS+?=
 =?us-ascii?Q?gVfQnq/nLGlJv8F/Ttm02SvBmGHN/257UPkJSUV1IOkTT1p54a6E3wLUWi1a?=
 =?us-ascii?Q?K+MygohhXncyQVdKFy4fwIgNHtUuR7bm4LOPMxTuYJXcLhbxZA3yOHybv00g?=
 =?us-ascii?Q?/RtXuMhInNo6GLE4BgbZuWn/IyHVQan8sb6hJkWXza+zgp9vaXfllgNcPtLc?=
 =?us-ascii?Q?sP4sJ+jbb0lx3EDA+G9GxgUtxSYpDQ67Fygyaec/3mf7XwwrWomSJtOqomUA?=
 =?us-ascii?Q?+TsCgGXxthGDxiUN+bS4rsidcglcaJeQL7gZa3f0XAikt6ZxrOtVweuQc+jU?=
 =?us-ascii?Q?ms3INvSgYhOmz9cGim1XM3akBmMKI41SySUd/43Jax2YRSpy1G1uB9tTknXU?=
 =?us-ascii?Q?p5hqLZq9snpN1pqq4XNrkQMcsGpwqz9GaPQBeddpLmPc1ixbAoTq4UHz5su5?=
 =?us-ascii?Q?rpY/E7keG7dWfTxnRvrn6gbEBjrBB/Yh1AZvWqnUFugBi+e28iH6Ik/6Bbqo?=
 =?us-ascii?Q?uentdvg95zacEwQutbWEH7UiWHnuxdDO3L0zi8C75lQFHCjZzXgx0thNo+4S?=
 =?us-ascii?Q?JiprxxZpVuisAbxGAeq07ORCZgKSr0I+zpfpBBcHtEGCoiab//7/j5mesppq?=
 =?us-ascii?Q?MJ2oa9NpWuOIfG0iow2SlIP9ZuIm3uQ7oQ6p8WBWqVESoTKmTlMYFFKRqIhx?=
 =?us-ascii?Q?4E3kosEj77I+twOEIbFrKNd3dAsyM0sxI9SlyVQz+lsYgYN3TKtaGSgbmfix?=
 =?us-ascii?Q?5e1ICl0BhQLTrcIMjDfp4QAb+/dipeB+dpDfAS5pRAYcPzUSl1PhW45wA6PR?=
 =?us-ascii?Q?PccuRuqV2YhOhmve/dcJZC2zsrpIu915R4P2chuXUQ5vOs8I5MDj7hEJD4gK?=
 =?us-ascii?Q?BPJnircr+pncTo7nNjSvpllC7HvqMg7PYEZaqYihY8fzUZqPfguwW0Y6bDJl?=
 =?us-ascii?Q?BgR6TGknqxQY0RZequIgLkF/CfGkoT5lEdJZ4JC7siYSaU2wyLz7cSx2wtNI?=
 =?us-ascii?Q?u/lJ8bHWev7JnkC2aSkQhuqQkPF13YSiuZsonnSWMeJzUh6TvCUdlEkQ7v98?=
 =?us-ascii?Q?1lFr2iEtkTWb6uM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:54:49.3875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f89dfe-1202-4f0e-c35a-08dd62de427e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

vega10/vega12/vega20/raven/raven2/picasso/arcturus/aldebaran

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2b4854e03821..fff438baf64b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -114,6 +114,12 @@
 #endif
 
 MODULE_FIRMWARE("amdgpu/ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/vega10_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/vega12_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/vega20_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/raven_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/raven2_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/picasso_ip_discovery.bin");
 
 #define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE	0xde3
@@ -400,7 +406,27 @@ static const char *amdgpu_discovery_get_fw_name(struct amdgpu_device *adev)
 	if (amdgpu_discovery == 2)
 		return "amdgpu/ip_discovery.bin";
 
-	return NULL;
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+		return "amdgpu/vega10_ip_discovery.bin";
+	case CHIP_VEGA12:
+		return "amdgpu/vega12_ip_discovery.bin";
+	case CHIP_RAVEN:
+		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+			return "amdgpu/raven2_ip_discovery.bin";
+		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
+			return "amdgpu/picasso_ip_discovery.bin";
+		else
+			return "amdgpu/raven_ip_discovery.bin";
+	case CHIP_VEGA20:
+		return "amdgpu/vega20_ip_discovery.bin";
+	case CHIP_ARCTURUS:
+		return "amdgpu/arcturus_ip_discovery.bin";
+	case CHIP_ALDEBARAN:
+		return "amdgpu/aldebaran_ip_discovery.bin";
+	default:
+		return NULL;
+	}
 }
 
 static int amdgpu_discovery_init(struct amdgpu_device *adev)
-- 
2.43.0

