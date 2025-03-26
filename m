Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84619C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 16:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C775710E16F;
	Wed, 26 Mar 2025 16:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zj2S43Nn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D3C910E16F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 16:24:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hrv+DtcojDoK1dzkG9hH0lbR7zDB89EsRlV1e4hG/v5D3tRO1wvMX8W84yddBpGv1LmqDKDKWRZmvWQnVdvIZuert4Y3fBNVL4+/EZLYypjJbCJ7JGDTJa4nsvljiOLXV7iLRD5QKlgg9OGKWFClC5xeCrIxp4qRUgWz40KRn0yNZ7RoyQ9TnmOZo3iYPHIEnXJRWrPSe/PyE6v+RA/nK9kKU87GRcvPZxRe6KA2sxqSuoV6gBQrDRhyMYh3POFDe+jFsnTJNvJf5pHyPN8y/mxURB15liqtebfol+9myFfNIeMrAJ2IW29nkSSeZ6l7MbaUsxsmQlb2uLvH/XP32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMtEjiwef7ADg0uHm3JTskmw4nosnWomm/D6bjyqxdI=;
 b=dtAuueQ+01ovgG/6Pe9pRRzlB7WMirg6CkLDQXUiX8LaGx7a+1Z+89mn/lkfCnEoPfo2BfLzKPTBWAEnLfOar5Ih39LOyjXCFNib0nj4EsN6yd84SZqnYivbspadVif0tlKPdix2h78TZ2IJi1g4BK/XxTDq43CHRmM8TvMSdMTdXJGOBr5ycjg9Ki5ziEYNeXolTpmlriPPhVhSjS+4rkFGJJ+RccrWrqYXzK/IBnyRZmi6l8PNtmrKh4w0c5BkYt+oGXsUbk7UZ3/8WwsgTvPq5Bs3aofXN22vgEX0EMabm7cCIPFCh/whzciBKZUzhYjYDj9+mT1utWPn0SGmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMtEjiwef7ADg0uHm3JTskmw4nosnWomm/D6bjyqxdI=;
 b=zj2S43NnTrNDFJ80CIZMqVIWmnmdFG+6TjaVgOMVjKUdxttilSw4dPfrFIm/oQCIO0eLEMh4RIjG+XORtw2K97K53aZJRBXXQHiqqtWb9Y56Z04ZtqWopW276/RjayjSWcWXTsA7i5cYNnSc7DEJf6VeNc8L44oZnPNRh0eFm+M=
Received: from BL0PR02CA0105.namprd02.prod.outlook.com (2603:10b6:208:51::46)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 16:24:17 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:51:cafe::2b) by BL0PR02CA0105.outlook.office365.com
 (2603:10b6:208:51::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 16:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Wed, 26 Mar 2025 16:24:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 11:24:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx11: clean up and consolidate sw_init
Date: Wed, 26 Mar 2025 12:24:02 -0400
Message-ID: <20250326162403.1139259-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ccc1a9-d378-4239-3f35-08dd6c82a7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yV/ybB3bEg2g02xj4xMYGcMZukxgF+bDJIs8dVOMkEMnC9gdGtqDyw3ssys0?=
 =?us-ascii?Q?cCCUdQq2XrXEZjsvYevf0JgGdAkjrAb1oTla2sBTWseBIWiXht4Ki9Llb8Y/?=
 =?us-ascii?Q?xIRJSkQiVwPjdjxs3zMeVDU+vnr3QN2DwTJIO8CbWtT2804nillLApn7TsRc?=
 =?us-ascii?Q?5BoqEVYpYD/zBhNMgpgSCJNRV8sTqiyXlCbMh+tp5DoStPamHVtiKhPhk+Is?=
 =?us-ascii?Q?vZvaakS9MX6egBwHkUPUIgHCvxR12bO/l756i2DOTbdeWLucwZpARVQycDMH?=
 =?us-ascii?Q?6T5CcX247yyVuv0uHPZF499jYGHIDTF9IShFPFaG66Def1Cwe1xcvOV/s5uU?=
 =?us-ascii?Q?4ORHLEOXQ7wcWITznnuQvYEYh+d8ICaInXNreQbWyqi9LY+f8DJjbErSz+hw?=
 =?us-ascii?Q?FyBSKVSZsbpXgZIaoscVKJuT7sz06LtGfEq+oRJp7N0nIuFoLekw7JGSaynJ?=
 =?us-ascii?Q?/IConTwjyYSBaa3A1JSIJb0LHrzB1acBcDEjMfuqZ5LCrqGLEc6g6gBqv3TG?=
 =?us-ascii?Q?k61nyT/Z6QKjsm+8D+nLI3EDEzPOYNqhSmbCvcXIKnDNH48sMUqTQUmKt81n?=
 =?us-ascii?Q?v1n7CPPBquo6/ibVM2AmSKVp4wgIYMjR8GNCR4gFw3CUWGJb0yR/5wFQBHkh?=
 =?us-ascii?Q?qzm06r5+G7qhRXxkQIqsVvrrORcbE8LjgHhMuEpSsPydKlJSy5n+A910Wzt3?=
 =?us-ascii?Q?6uXnAvf0Lz1fAZBMPRfkicKx0WYN+P99cIYeZR6F9hWgUmQeVtz28XqG3ayI?=
 =?us-ascii?Q?NFr3CFnImBLilRV6k3XQap28rBYDdHn2R+LX2C4KaeFl57sd1ygCHy1KyuGT?=
 =?us-ascii?Q?41QJ3CwSDrxkLDZNUg/L0k1Yp2b1pDUgquh53LCYXAARe/5ZMpsXTsOUqAZs?=
 =?us-ascii?Q?tn+2WxHyEACBqQrxehNnmc/GuLl6PRyYRaGbslQV/ym5vRFXCj4zN//KCBkN?=
 =?us-ascii?Q?+wjrznZQTjfmRDoK7l1XGxrh2mUM0oIPW3SI7hoERKuwLF4viOdTKSX3iOd/?=
 =?us-ascii?Q?RwISu5Q2V8aYMBw7IjQOtcV7Dmrdaqtm0dPKC+rn9ZMe23o8+2FsJkpfRG6/?=
 =?us-ascii?Q?5eysCPYwJ1pm7ig9soLt3NuZ6AVJU0Y0sk8ZUzjtWjTgIVbxoPDHWc8lmE9h?=
 =?us-ascii?Q?hG30cGh084oLnUsgcnjY+dKQX7g7+U27Is2w6YgGfnCRO7fmYcL3K7qtnB7e?=
 =?us-ascii?Q?rVPf/sr+/Uggrj66c89vVeapeEz55F5iuMWnqMeuXba6w11wF09F4As1+ePB?=
 =?us-ascii?Q?Ju9eD3DQsSBOqQkYkI799DCdwywX4kqiaCYIHSiaD4F0z3vKad6pE5xQj2Y2?=
 =?us-ascii?Q?VmDy5NRAurJJNRzow52Tx2t0GVEK4TMVUNVMO/lLkCEFDwwFEJf4G8Zm+nIb?=
 =?us-ascii?Q?LCILLZzeDk9Tfwf1eWfN5+rHGlMSqvChycxsChsYO62/deqDMebtFNR7rwFP?=
 =?us-ascii?Q?PUjJOQZomrcnXkqK733SNchjnz7SOk0DnpsQh/aZD+rtoKAXNXoUKrz0futv?=
 =?us-ascii?Q?Zj+HZbYwVqkFCns=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 16:24:17.3563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ccc1a9-d378-4239-3f35-08dd6c82a7d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
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

With the ME details fixed, we can now consolidate
this state.  Also split out the userq setup into a separate
switch statement so that we can set them per IP version
when the firmwares are ready.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 33 ++++++++++++++++----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1b3cbe3286dc2..b5c9ca680ed7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1597,14 +1597,35 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 2;
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+		break;
+	default:
+		adev->gfx.me.num_me = 1;
+		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_queue_per_pipe = 1;
+		adev->gfx.mec.num_mec = 1;
+		adev->gfx.mec.num_pipe_per_mec = 4;
+		adev->gfx.mec.num_queue_per_pipe = 8;
+		break;
+	}
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
 		if (0) {
@@ -1619,12 +1640,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
-		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
-		adev->gfx.me.num_queue_per_pipe = 2;
-		adev->gfx.mec.num_mec = 1;
-		adev->gfx.mec.num_pipe_per_mec = 4;
-		adev->gfx.mec.num_queue_per_pipe = 4;
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
 		if (0) {
@@ -1634,12 +1649,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 #endif
 		break;
 	default:
-		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
-		adev->gfx.me.num_queue_per_pipe = 1;
-		adev->gfx.mec.num_mec = 1;
-		adev->gfx.mec.num_pipe_per_mec = 4;
-		adev->gfx.mec.num_queue_per_pipe = 8;
 		break;
 	}
 
-- 
2.49.0

