Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682BBC282C6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 19:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D8310ED33;
	Fri, 28 Feb 2025 19:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FJHhwTDF";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1003810ED30
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 19:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHV9tPKI3Z6tZ6cIGHHxqeGfwIV6h8gEVqdZwEHelaeroCdQaTpEEOTrb5us2tNTjyGjxa3b8YfYg7yP6ubEXtA9A9LReoxJpfPgdQqXsOACzkuqdDAQYvoYbB3ZZgCpRXDhKIpn8BDO5GeiuQonrjI1+se3lu5Dl1suC914BG9YdIqAY34y/r3pAzcJniucORV7UzWI6YrWDfwQHLVSu6TRLB6RWBMGBRHke0sqcQFZauM38ift98bswzCi/R7DS5ngmF1C3QPtkgPYBen6jE8puzFbIrgMFLtw/+oR6bVieeZ6wPyWnU8oXaFTxtu9i4RoxRnmHZ+JV6h1VQW1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6urGtyEWnETgSDbkgCLRCXvXyqoeuoCMkav2PQKGsPQ=;
 b=l7cD6/x3aBqjZRd1d8brNmACKoevxpsnGkhwB7KLFnOIF0EqtUqV5zDy4Sq8d7pEcvel6e2YzygQMBYzIJ2NdzHEaayVWfeMoGjIM3LrMEiOEDH3tuCl8g9B6km66O5h9Sd+/0Bih7ZHL4MFMRQx4cRcyOdEHDB5LseabCrccQUz4XvSPWFg/iR3o/T4v2YTfHgiMEmjaOFfRNyU2CrhVYrCmZI+b6vafnH+3SguNGekYKH/VhDgElW9aOcrk7Kpk2Xr1YtqtYoNNBmePGC5sHteDAlkhU7Y5c5Zk01eMx5/b4nFvmek9zr3Buv8hPp13GW1pH4azlguLRuTucH4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6urGtyEWnETgSDbkgCLRCXvXyqoeuoCMkav2PQKGsPQ=;
 b=FJHhwTDFFTKmVO8ldKq80pOZhhpVjBCsOUjLRzaXyrWl29OW4dhILl7n8CQNWpLkXGi3qOU0FhBs3cVbHnzRBWNQuH52ZrJpiX0va1IaetNFioIoe4LxsCzm6otEBE/E+Y1Yk5mYnZa18M9RO25yqntRC5W+N5uUzCRBDdSBIfU=
Received: from DM6PR17CA0028.namprd17.prod.outlook.com (2603:10b6:5:1b3::41)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 19:54:26 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::a8) by DM6PR17CA0028.outlook.office365.com
 (2603:10b6:5:1b3::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 19:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 19:54:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 13:54:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/gfx11: fix config guard
Date: Fri, 28 Feb 2025 14:54:09 -0500
Message-ID: <20250228195411.2530147-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228195411.2530147-1-alexander.deucher@amd.com>
References: <20250228195411.2530147-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: e94fa60c-17a1-4caa-7ce9-08dd5831b468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AA3cL/qFbpuFO/6MEkCz6SIFtVUOg+lbqU8Ly9izVVZk2GNftEZrANYAFfQp?=
 =?us-ascii?Q?bsz4bWxvlwx63uvaq3MCQneLSwJPE6rEDJFN63aQLoLAcdPGCAcRDv4ajydF?=
 =?us-ascii?Q?l6IDJAfy9CIIUQvc64Xn8l7/2ArOXNoZXvqsg54DPW+qHc+n6pooGBjwYlSK?=
 =?us-ascii?Q?Z5Xc+VuSphNfZOZlS2nE5bgOG6KRay4FKrxWDwPus4g0TneMgjMBsCxrB+b9?=
 =?us-ascii?Q?VVdX2SSOEMtm3e1V3lUmbbm2ifYAXTU66Ep21tp52inK8t++owIk1AU+Cbjk?=
 =?us-ascii?Q?Fg45G95BrYfcljf8k5viw+9Gzr4stw27PH1GFXQhv5odM4MzUiSkPxhgV4SX?=
 =?us-ascii?Q?v8xmHOfTamV5DwAUnf085H0frxCIWql+v4lW/UXdH9ml6h8pbYIWOPOe3V0i?=
 =?us-ascii?Q?q40Zok5u1qqvEOAyAcfNP66K60Sw9Ygi9UBsi5KFqb+X8HgBDCJ2mHX4L3bM?=
 =?us-ascii?Q?EseugRcYm4EEQKCq/Djrsc3L+jKCDSOe7SsjLVgOOZI8GQAYdyld+bJiN5+Y?=
 =?us-ascii?Q?Ic+K9UW7+LiP90bOzjfATzNNiDGk8UV6ujC9dAukaAQHyn3TEOk8jkywCSeF?=
 =?us-ascii?Q?Ox9w7lmDfiuwck+ym7sKabHGt3wxFYVK2qQi7nXrTtcGvMgHulyrkEfryo7m?=
 =?us-ascii?Q?Svyc1rfKjbO0AMs3c9Lu0LT6T4nc5sO+lPJGHHNHxTg6asXvr+5YLep+lnme?=
 =?us-ascii?Q?bv3YsXzeSa3ve5U8LUNFpWHiBdjAgCc3XpECMOfc+sSSb661oF8i2RF0zqHE?=
 =?us-ascii?Q?l87krBEF9dKrBn1DRP6cc/s6urcQb+/NQkoPlsz3iG5oGkRZReNw6ni95E/G?=
 =?us-ascii?Q?dE13OajCfeD/Hji9msuy0+fFZxoNJsRIwg2/z4KCqlVaoNhNWnm6QXXOU8o0?=
 =?us-ascii?Q?4IMfbk/fI6VhR+gJZ3O/Il4y331vYlPbTZHOIcuTaH/CTAjEsvxcX8TvZSoW?=
 =?us-ascii?Q?RusDs454gdCCqTXot0mGeJPNv8BKaiBlaTgjy8hGlP2AclsMKRle5T8M2w/q?=
 =?us-ascii?Q?8r8TNLorO/HDS6/dfYiMl1dEO/BzXwkUhA/EhML0uYV+pDQtDbQ2bOLoeidm?=
 =?us-ascii?Q?B0aAq2k39/4v4Kokw1hnQSQa2914mk5qeBKi70pMj55Gb0I7R9a94DT9L8FE?=
 =?us-ascii?Q?bYQC9XxPOXRWVWiLWyAlrk/IIadSKOsBn2O65RR3cUIWmV+uW4zwySuk8iW4?=
 =?us-ascii?Q?1pOrTUft5v1RrwUb4iHzEK4EoQm64UvOfjHAqw7tCDjNnAfiSZeiKXwpsoPQ?=
 =?us-ascii?Q?Fa8yCF5D9K4AMvMb0btCTY/hQArVrQqcujeJLWXOGlZwefprWHFOdjG6cTxT?=
 =?us-ascii?Q?fyPQ1L880WsAHSDdzWC11Pur01lKIQ38Dxg4BSo3zWwUyQPY42l14FrrNz+G?=
 =?us-ascii?Q?heru8gZc7VrrHcQH3j48NdtBeDotMSmWiTMhDpVnspS1y6oiB1V5Q8KQhCzc?=
 =?us-ascii?Q?+QCgMAqL1S8ZzLDvV/vnJMuisrH6z8h7wGP9Ql3iPA1d6gXBfoYUG+KTtQv7?=
 =?us-ascii?Q?TphGwlO+2EMwMlw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 19:54:25.8929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e94fa60c-17a1-4caa-7ce9-08dd5831b468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200
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

s/CONFIG_DRM_AMD_USERQ_GFX/CONFIG_DRM_AMDGPU_NAVI3X_USERQ/

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7970c848583d7..a56fccd21cf6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1610,7 +1610,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
-#ifdef CONFIG_DRM_AMD_USERQ_GFX
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 #endif
-- 
2.48.1

