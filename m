Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EF9D29C37
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 15:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB1F10E2C8;
	Mon, 19 Jan 2026 15:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2+pNulq0";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0105310E498
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 15:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsjErtHyr/MGhLZVIOTodlv29ssoHX5C+dcE0kVIXHMnlyaQFbmvptuModvzJWWO5CK5w6/QQQKKTBcCRoETzkOIfR6f9R2JzPpZ/3tkBsffBrDS/cib9dv8eWZOon28C8jDWNZEIr989UN1uro9RrAjHaLW32bffYQmP0iXMhcK/N10qAiYq4ZBe3ls9LsRnIPE5vNu92LqMORuxmanIWp2KP0NBRljhw5obdHLewR41yFGw3kvPOJwk82GqsaeyYD63w/JGGqB5B7wpxREKsLZvSEkNp1RfzKiA5T+8UlAD43LS+LjJmpmjE7Tbn1RmzQYDifPZlVvvUUhKrv2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3Dt2B02JcYaLcJv6n7FVB28FndVBCKV/GrXwMAUq5M=;
 b=Znn+SCvtRk4oyzssKwVQ8dI/K7XrPdv4/bHJMV7jFbRhiecZXO6fhLXmBOgtA3Q4znbMbe2UrMC1ay2siwC7c3+wDB3dBG6ZTXCxPDbS2MbghD1NF8OHsw8/Lmekp33CRJe8sjmobMpTlRYfcQFZ1SsQtObWenyUSC/Qwf3/+ogR5i9KSTa7h/CqsMFKX8O8uvIrE4fAyzzv5MTJcJYXCik9gbZD/lQ8bCW7xUvmX+/vZAOqascbEkyJeyoWyKz/csuPDkwGwQ4/szZP4CPqbOWl1/o4i3DJvadjadXTv9nHDB0rX5bqxlZ6j4DUSutGhlpb1vNvSseI1cGs09pgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3Dt2B02JcYaLcJv6n7FVB28FndVBCKV/GrXwMAUq5M=;
 b=2+pNulq0yU7I+G2TGiYO/6zs3izbRtMNOC0cAnq22P6WTLpgn7G487WoPahcS/Pd1eTcjDN5iVbYLJ0pW3FCSwSCwZN3Dr4ehoBd3PgC09D6bmpetP2dSZC2VPj5cP78owbvbYW85+AV48N1FodPy5a22RVJFkwbTA0rCqEBfiY=
Received: from BL1PR13CA0198.namprd13.prod.outlook.com (2603:10b6:208:2be::23)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 15:33:40 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::a8) by BL1PR13CA0198.outlook.office365.com
 (2603:10b6:208:2be::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Mon,
 19 Jan 2026 15:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 15:33:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:33:38 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 3/7] drm/amd/pm: Remove unused logic in SMUv14.0.2
Date: Mon, 19 Jan 2026 20:58:20 +0530
Message-ID: <20260119153309.1234663-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260119153309.1234663-1-lijo.lazar@amd.com>
References: <20260119153309.1234663-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: e85fbb70-56bc-45ac-4dea-08de57701f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4FW+cOBmDKUW92pikrBHccFU8i5ygM2sXoVROZqUCCy/5NDEMlGLxZBZCJln?=
 =?us-ascii?Q?wOyjP8n7+CgdhDYUeAL3C4jMvyvzQ+17dwd05yS1z6+8mSNp69pZl4U0wWKh?=
 =?us-ascii?Q?a0u2CdVyyp/LyscZd1dY06KBz+3XxqOEWBJyrTzSzV9ThEYGTLRkUi4u7BzM?=
 =?us-ascii?Q?LLVwjUUDdSleVqlbWGdEbi43hO9cCUbzfCZjL933bCeep8g1EbSs2W3N9NJD?=
 =?us-ascii?Q?pxfhM0bRbtadtRJmMOCPvhapjRixCqfopNtRBieqFF/BJkTzjvFYv94fyHdK?=
 =?us-ascii?Q?tjQLb7vw1DrTRuhAtFImSY/4CS/GPULnbAhssfLzkp+5HvKn0bfbnd2rvcZy?=
 =?us-ascii?Q?IG8g2T9bpc140Axy1i5efmjx3cdokWxUmLBiU5TRHyJ1bLqcsap6sU4J0UVZ?=
 =?us-ascii?Q?2fASgT3TL9Wr1ra0rUefIGuJH2cVFClxTKiwSOK48FrKP35fASmpLdkzPpcJ?=
 =?us-ascii?Q?zvCA5JxsS67zaDKhJuVfxsDkCM18geu/xUkydrktAJmaWb971YnzA5aNxY4v?=
 =?us-ascii?Q?gmq1KAr/lqZdvG+wW+DGPvB1dDTUGbPXIn7lyYv5GaAXji0BIlqN+fi3dVo8?=
 =?us-ascii?Q?ayIPhMRXbLXwd0twd2b5fRnisKM36bFkR//Fm5+O0nELFiBfLsPpg9LghHLO?=
 =?us-ascii?Q?61eapUqlm6Oz3UeV9gXpzJmnby43DKhVHFgMcVnQO25f/TOoZ+LEQUOfN6Qq?=
 =?us-ascii?Q?4MdHZ/uvTbV4kmW9bwQePBcxTFuLuylIEqcTAnlQ1Pa0f6f8EgWgLhK0VF5C?=
 =?us-ascii?Q?LS3By0VUqd6ei3X2iJnIVLHRweQyUwSl2o0zLlbxwIcOQPTnXyENVJ27PHvI?=
 =?us-ascii?Q?jtdlYAR9pSatZcNXgZ2mvAn2X9vUuwtp8hRP81nCo/iywDIiZirhHdur4Oq1?=
 =?us-ascii?Q?mBkVj+VuqZuTN7TlYz9DjAntSudUx3TDTSFebhiLmb0MckqT+52e929PW/0c?=
 =?us-ascii?Q?oRdwb8YlFH74Y/IcbaoWqBBAcbsEFlxFRlMMegUxh+5mb92NHi+OSB6AjWGD?=
 =?us-ascii?Q?XO6eEhVEhcflRHMB/ShivuzOgtVb8MN+CykM48npZk8yHrLIVfekcRcb5jiU?=
 =?us-ascii?Q?/CvsVIbuE/A7Ehfik1lToHflaCBnFoYp4iiomglEmtNB0SPu8clLXB+tcNQT?=
 =?us-ascii?Q?FOjMwyPxMJvBeMWOx28ufFC5eVargBKgau+NIAmt1/GjjGeLaXUvD/fkJ2y+?=
 =?us-ascii?Q?0TW1ur+8q4XJSYhydTSp0hyn8C2l+aGqHdxl2jeDjgK3ZSp4GAAg1P9TWuB7?=
 =?us-ascii?Q?/YaSGGKVUWajJACI+uiEu/0IYKHUo7bScNoNCuYEM6IECXAghE76V2XhZfRM?=
 =?us-ascii?Q?bTUpITuoMOoM1TbjGAxYvJWjZ/TLwYFxWWE/QmrW2Ji/TqafGGW71WDL0RR4?=
 =?us-ascii?Q?l/iji91zPcIWWi9ZWtyIy8dCdRllH2VwYaloIbKyA83ynUQrhUkq+FqCeBjU?=
 =?us-ascii?Q?SI9ZqqCNqMZD+SJAQnayZj/FASRHmab0m7wI9Uuh9zrWuqZugfxoMrycKXFO?=
 =?us-ascii?Q?AxuNvRerwUBJONHTHrtSrRqqLU6KEGscSdzRvMXBJS2UCNawlupCzmI0jHgH?=
 =?us-ascii?Q?n1qLH5kNt3pt2zTX92wEUNKIReM+bE0CJwURiAr2dAKGYAaQiuJAG1/U5iVo?=
 =?us-ascii?Q?OU9h2KI+Onq6ddKdS6zdMEBro2BOpriROxaNTA1aq7SOu06k6b8ZbFADISbG?=
 =?us-ascii?Q?XrvSmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:33:40.5087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85fbb70-56bc-45ac-4dea-08de57701f41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
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

Remove commented and redundant logic in get_allowed_feature_mask
implementation.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 39 -------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index faae1da81bd4..d2aa5fabfca4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -268,50 +268,11 @@ static int
 smu_v14_0_2_get_allowed_feature_mask(struct smu_context *smu,
 				  uint32_t *feature_mask, uint32_t num)
 {
-	struct amdgpu_device *adev = smu->adev;
-	/*u32 smu_version;*/
-
 	if (num > 2)
 		return -EINVAL;
 
 	memset(feature_mask, 0xff, sizeof(uint32_t) * num);
 
-	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK) {
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_IMU_BIT);
-	}
-#if 0
-	if (!(adev->pg_flags & AMD_PG_SUPPORT_ATHUB) ||
-	    !(adev->pg_flags & AMD_PG_SUPPORT_MMHUB))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_ATHUB_MMHUB_PG_BIT);
-
-	if (!(adev->pm.pp_feature & PP_SOCCLK_DPM_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
-
-	/* PMFW 78.58 contains a critical fix for gfxoff feature */
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if ((smu_version < 0x004e3a00) ||
-	     !(adev->pm.pp_feature & PP_GFXOFF_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_GFXOFF_BIT);
-
-	if (!(adev->pm.pp_feature & PP_MCLK_DPM_MASK)) {
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_VMEMP_SCALING_BIT);
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_VDDIO_MEM_SCALING_BIT);
-	}
-
-	if (!(adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
-
-	if (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_LINK_BIT);
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DS_LCLK_BIT);
-	}
-
-	if (!(adev->pm.pp_feature & PP_ULV_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_GFX_ULV_BIT);
-#endif
-
 	return 0;
 }
 
-- 
2.49.0

