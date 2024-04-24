Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E62C10F1A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 02:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6955113792;
	Wed, 24 Apr 2024 02:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xt54IQtM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561F911378E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 02:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+qitzVH8fxVKILrwlTKhN3D09h6NWwb2OsAzc2F0T4MQbHVmRQxx6iv3Q1JD2NLdwaPBilNOkChyW+4LOW6SfyNaHpIQwvBZCduOwZ6gy+njcGgcmG1IBXTyhl1u/0WK2t9b5/zN0cX1QBvbmb7KBxwCMcnye4CKhBUFGvAQX695/5q+h5Nhflma4MDF0CUlq0OWm4wmEw/BTgrNFGEPhC3qJj72yjNz4lr88tsdEoJ4Yba+lGWDA/DmSHa8aEiamunmuvymIK5nKPNZiwDKGsILbXLmgnA9sFw8rQp9GWhyCnUTm3hf8lNKBBov3txHGkvwv/3hJYvPIYLipwWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Si+ZsP/Sig062h1pYETn0VT/5TofTBdxCa9ooswB0tY=;
 b=Lamchotz+khNh2qi/MSID5MW8OZd1Yo2sdtzzqIHgP51a+76nPYfT3oSPNV/Xoc2E/Oo6GTEjiUDIL1ww7c82RGmCD+yM2zZxqClCTRcqexlQCEzttMjkleHCgRU/a12Jw46NEkWwetaik4wmu5Ct3qoHgb1Zh3tpLRsXwVxVh1mWNbj6Epdz5mQnVyrIWfXThslMzI9+dzMTuqbpn4Kx9d8qwybojS0WbkhkBShVsDRFWIExUb4lF+GnbwqZ2wTPGTUP84MlDHUQNcNBqcBH7OODXURXce3EA+m/DArXLqQVfA4DYTtZt4UJF+iPAtZFj11mU2srb89cUBOY1D2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si+ZsP/Sig062h1pYETn0VT/5TofTBdxCa9ooswB0tY=;
 b=Xt54IQtMUIcGzkGM2hOEzazpIaNdi9LegMoCIARIBYaGa0tZKHuQZAGNm0n2+Pj6lTFrKMxwvstfuaSvKXD1G1Bhu/TYZZgwc86k8OCl+xmksrIicTba086S7BllCcmTezJj3NoUzmdsFJ7fMRk/igmfwFKHJxmFr/EdvcH8dJQ=
Received: from BL0PR01CA0008.prod.exchangelabs.com (2603:10b6:208:71::21) by
 DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 24 Apr 2024 02:50:25 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:71:cafe::28) by BL0PR01CA0008.outlook.office365.com
 (2603:10b6:208:71::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 02:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 24 Apr 2024 02:50:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 21:50:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 21:50:23 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 21:50:16 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <tim.huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Using uninitialized value *size when calling
 amdgpu_vce_cs_reloc
Date: Wed, 24 Apr 2024 10:50:16 +0800
Message-ID: <20240424025016.727595-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: fe58cdbc-656e-4ca9-a481-08dc64094ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sATuAs2wePHP+/RJf/diXh9ZtsmxTrmHA4zpdm+4DKJ9lTQFnUtMyCtyfi3q?=
 =?us-ascii?Q?SoCZDYeHxLkuC90HhydbQ+clM/hYX5xq0oaFVEy2aEVEJ7ayJRs/pTi+q8sy?=
 =?us-ascii?Q?3Lo/L5Y0JtbxZJRHOZqjVHGBS0GSIExzoNvsftey68ni7+scBvMbjGlMg0mD?=
 =?us-ascii?Q?Jglf/fXntICoG6i+78BYgZ8o76JjNFsQ5PrzVA8QF8Eh/mXMV6ii1bIIHR1K?=
 =?us-ascii?Q?6g45GMqUQpRCjnzBLlVn0r0i23bd0IMsXEoeTtOj51biB9baTJ/hY15myCPF?=
 =?us-ascii?Q?+eQY+6SVirgVu6Tzm8/uqhrNNbyBdfl4kuAvqmtOgpJVPI0/T1dLvPs9EFQ/?=
 =?us-ascii?Q?xns5RQ+Gnyh0ZnShrVxZ2RfrKMN+vi3gjWl0YDLt6vah5vejJmwmLwQAXnYP?=
 =?us-ascii?Q?4+gPmR2thju6rAI4Q7y3GFO82KnrtNm69r/IBPI2mgpRKGjbsIziJKsxls7i?=
 =?us-ascii?Q?z2o9jjePhPRZ1lLDZ3+hSdu03CY0rLJFe4ypmhkTo1g09EGaaVfHepyBI51P?=
 =?us-ascii?Q?uOdNMKqevk83IKCPJqDjYyoYiDMLt+FFKoVW9ERUMzIit6aLemrG+2keygiC?=
 =?us-ascii?Q?k8MCTeWDJvBWX9Hctip98QxFTyLY10WggjBifC7gFM5L1Hd4ipUgkGOPG53n?=
 =?us-ascii?Q?0jXWcq7zDvv+U0QmfhIVBonz/6W/kMrBJwRxFpdFxpJblgYRK4EpKaOe30wG?=
 =?us-ascii?Q?0iB7FDg3uPb/4VQeI2Cg7yreEYjcX+cWB1EBd+xyaTogUr8L38ywcqlF4pze?=
 =?us-ascii?Q?Qyl3bznh59Cb3dmubP0LRWU3jVxPzsIM/0wBsVBO0lhs5teFSpcG14PVCvCJ?=
 =?us-ascii?Q?91DVB+n4b0/LneS8awrrup5snvmBndWEHVsbOF47xWntjTk3O+bqTwRx5cdK?=
 =?us-ascii?Q?EYRJ1VAgCzXR8/bm4/0yaMmncppEHDMMz8l2ycBjNUg/KAbrPRULGSLqx0AA?=
 =?us-ascii?Q?4G+CkgMGbpRKB3XVDmNQbsmAZZvek4qfo/2XgoZV8gJ6bgOOiG1iZg2P/roB?=
 =?us-ascii?Q?MQbhQtT9+nlsdTo4jUKn7IuGuiBbPezhOa5/pVRrtih+vn/AcUYR3ccil7v4?=
 =?us-ascii?Q?23PI715Xep36UcJlITpSd20A9RRAF6nQAh6mvfHzDIr1Piar+pLcc9YI7QHW?=
 =?us-ascii?Q?qxW5+jt4/KVmrSkpo9vwa0QR8OorF440Jg6aHkQoaNq2aST895ZqBjcdLWPX?=
 =?us-ascii?Q?yp76rpKZYhI23ORZkiiysN6gu7F22xPeGEOag6T4xVcA279JJXavAQGr6oEX?=
 =?us-ascii?Q?Zy/hrcn5IS4jZST4qeu93O1QCbrW0KCFdE77HgbNR6mCr30/pl4M5DjZr6ZX?=
 =?us-ascii?Q?RZRo4emf/2N17goHwkvlx0Iy2gUgkdAkNd96mConQ4L3BR3WYyJvrp/OGB+M?=
 =?us-ascii?Q?phRuTlo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 02:50:25.1838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe58cdbc-656e-4ca9-a481-08dc64094ace
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

From: Jesse Zhang <jesse.zhang@amd.com>

Initialize the size before calling amdgpu_vce_cs_reloc, such as case 0x03000001.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 59acf424a078..60d97cd14855 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -742,7 +742,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 	uint32_t destroyed = 0;
 	uint32_t created = 0;
 	uint32_t allocated = 0;
-	uint32_t tmp, handle = 0;
+	uint32_t tmp = 0, handle = 0;
 	uint32_t *size = &tmp;
 	unsigned int idx;
 	int i, r = 0;
-- 
2.25.1

