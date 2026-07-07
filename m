Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98109C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 18:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8CA10EEB4;
	Tue,  7 Jul 2026 18:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QmtpKoN4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD2B10EEAE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 18:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN5ky+AfthnkRkrQ1k3sKZypYrbrZj9Me/bWnoWWtB++jt8PRH5io+QHYScWka/T1yGkxVgyw+h4pOtLLBpMUdYdzNrmgIbSV6qOJDXXRW78V7KNQVFJOGiLZetNm87CL5AsWTgQy5bPPdFMGUjaGk1jkxIlCUu8DIQCJWhff1EgWdGtVA1CkWoATeHNVqgH3Fpe26PRW7EFC3p8ScNDgqXFV8phVA29cQKuNu2F0gBYmr8Ws3QtTxNQ3Aea9YW1ABtLLDyyrarJJmUqSsGhyPKwfSxpNoFQtxbACrJ7cybrUvl2X9/M6eyjvDUSOzpV6bctLvH4DSA25dvgeGayNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmIagbvjaQqduF9SSzwsYjcvPJgAlAUr0RWx1JhBA4U=;
 b=GEsWIzktg8SO+1HqwzWtAdo5MqHsrWAZy2rrFYIefrXOan0Nz/XbtHa2MtDwbIeMJI819r9HP0agOoUFv74vv09ZYA3/uAkazC7ZrVmM1uBk7LA8yeKtIZMjDaikEOLY5GTbymHXHbp0YYoS2t7NCbQgUsJdVkrCTDaEgQt5sK2+9S/7hIg3DwCMv0Axq1tPz5Jzi+MXGLZ6fs9VgjWf1IOoWe9EJ18JeNGhIErgSXw89l7qNimOG8us7oDeKIyph0maP/RXx03Vu4i1kYiYw4/nTqNfDuaERqVpJXGX/aFlRaMMf6jiZaDeQ1FsRQH7TZFzH2BhOPiu6POgYW/m9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmIagbvjaQqduF9SSzwsYjcvPJgAlAUr0RWx1JhBA4U=;
 b=QmtpKoN4HQOKXL21rFvL3oa3KK1KWkhTJAm2Txs0FHT5s99ZbH+Ajha86kg8cKv+GsWI7ml36KB3dRvWxk8KVII510IG1n56h2ErkLXmtRcd3gDeBeIr770L+jo1XkgxPsPvZcn7G1U8j9VmL+jV/fPYvTEBwXnbJiICHLsGIuk=
Received: from MW4PR04CA0382.namprd04.prod.outlook.com (2603:10b6:303:81::27)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 18:00:30 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::7f) by MW4PR04CA0382.outlook.office365.com
 (2603:10b6:303:81::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 18:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 18:00:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 13:00:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 11:00:28 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 13:00:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/gfx10: fix IP dump alloc ordering
Date: Tue, 7 Jul 2026 14:00:18 -0400
Message-ID: <20260707180021.2642432-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707180021.2642432-1-alexander.deucher@amd.com>
References: <20260707180021.2642432-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cceb0d2-9404-4c31-dc26-08dedc51a18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|6133799003|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: i0SC1oWuYCvTAu8EB/Bz8V2tuDmS3mjPH1yHYoGncppXy0Y2124DoO1YZGm0AvlgmIPrx4BR8Beh9fx8GbggJI7Xc//b6wgGDL02rJ9SrQXuNEfm/IAynIJBjCPv+teadk8oHOFohCqYyPhiHRgK0r0xO38tHLzrNTGBfQGGPNIsmGMDaqZTeb3UVrDaz3BVuBOmx5TMno2OG5bYXwAPzJnbU9Y3ejFPbb0vUg0N3tvVRMhOJNxbYpAA/TyXbuocVU7Hv9yrceKGlR8PU5yFtPWL/R47L6C7gZEOaTXmcTBZrOzP76YqJvBf0Cc0zDoDTapHbVCSvVU6L65Urwb8bu66LpQMK0MEGqz9RKmln9S1dIN6mv/XyPZ2uBDrHUBcJEfQCCfB93HvEs0C974sdDf0AzJW4V3Dhst0oQF506Iijf9sl/CNJ1pyQZEk38FB1NcjTMR+KdhdqoIj3bFivMZF4iCZf3/oZjOV6omDbrbGw9/+IscSPxiihoLnppi/B/3sk1zZ3e7xuukzKetyj9msHhjnMpdEBNqChdmWVQoZRmFrlPtokVz3wCBz/7cW5CvNXdiJ8vJ7kVFveokqtTZvsSj03pN+Auu45q2OC22oif6OL0XBTKD9NDHr+jRdomzLr3187fDsDcji8LJZG3n9AXqbQrkcbSnwlJz+wrihnugtoStr82JYiE7zo3fMXzEH41FoGLGkJSLXPWwpcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(6133799003)(11063799006)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lmA4iJX+j2Rt6HlAqjjc2nQyXKOsDjQO8dSXDgOEIdUlQOclULxfa4uDvspe1FHjdUMSbxiG+EF3bUXbB3QVuV9z14ozEZCs53pYtbcVO4bEE7fl56SWtgGKjOfWtW9mnzuyRjj3+n/+VL1SGUwnuOK+j7CBwg123X7RKaVVv6I3X600g/7GusEtGWOYjHPwR72v18baUF0gtVnjZg9bTPoDYX9gpuoQ0+Alt1vB475dq/kWhXrnRZp36UTB8sMF+SyCUfkohEAClIa0+hkJdkZW8j2my+rupThY4AqDZK21ZSOx8t7f/yd03OmPqtbjNvLt4lzZGU1dAtpNInRMO12PgGVa+KUnc7EzWnKK4YRZB3nhuiLyygtwAc4qp4INkjz0exj/LVNFuqIqCS8RdyqcqfCCNCiVMfOkBU+b2iaS61VLdCdkEdpkJQ2uhCUJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:00:29.3256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cceb0d2-9404-4c31-dc26-08dedc51a18b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
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

If gfx sysfs init fails, we may leak the ip dump
allocations.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 202ff7a5b0ae6..34c333e5c74b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4990,12 +4990,12 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v10_0_gpu_early_init(adev);
 
-	gfx_v10_0_alloc_ip_dump(adev);
-
 	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
+	gfx_v10_0_alloc_ip_dump(adev);
+
 	return 0;
 }
 
-- 
2.55.0

