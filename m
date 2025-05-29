Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C84AC54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 11:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A4610E1E6;
	Thu, 29 May 2025 11:18:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FKZVjffx";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 036C210E1E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 11:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXAJWYOOjIpioIVWAF9yQYHhwaeQI9lMozMe0uogbJiJ2P4WDvH+RPRUolsxo8q0FEyheFoXXYNnct/G8Pu5CCJ+wQrYrC5wI+vjdy3pB+Y3mQuxypkkKbpphtytD3wU/iGHv9KlzEBrzmnduAg1sECadwqzvoTN6gFPAMVjbZFJUc8grKu+5XDtrAhQr6Rl6dWb6GE1KBHtr2WLxYpReuPBI5DESJpKPTA7HYSSxu/uAs/SDVgenJal14CTyI3pOC/THcE5OzHNtRajhi+S8Tr0knwqqaSosCcXACgotQarjiqaasbDj1svsukNR09fuhqq5BeSp5UIRh6qQnxUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJvfa35lY0Ryl5Gm8/4FUReNv3PQ5MJk0C1qFflYouA=;
 b=ok4sTGaO8N6zdkZMAIRLUzNzESGKCrdMPdD0MVMw2eUL+Ni0k5g3D6h9r7aLAGNwIu7bxjLG2Y8AIm9ganQnKL2TraVIFsrzA/nFpXBx+wsvnv410FxoPoAUNon+UNw5LNcZC6PHWZQnUhVV/LWLCHxTVnB453tcHneKMee5mbRBoTlB4O9/vEE5dZ93jaTLxN7THdfIg6IRljXdcar/lrKCLLNxhmRdhEMUV7SCY015cXLD9EQQJ6f7Ifo+3FFXDrXtM8x6PNUyQIgdJQf+Fk+VgLhxS4tgW7N6K0KLHh2Dzl71Q6toSFQFzYVxcBqTA5Yp5XbGYnxwqrmChiQvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJvfa35lY0Ryl5Gm8/4FUReNv3PQ5MJk0C1qFflYouA=;
 b=FKZVjffxCKAPwLzyJ2Q+02ZHs01HO+krsbqJjQYHAY/h3L3VoHXBOtjE8r/oTU1H1PcMsmqt8uUA7fqqKFstFy4UcJPyxbNZhOnsXkYWov9hZyQOH2ehNzBgedpq8z7IPsl3oFjsErXqFhxrmnMjBD9bRLIVUtamwmW9/uMzQ6c=
Received: from DS7PR05CA0068.namprd05.prod.outlook.com (2603:10b6:8:57::20) by
 CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.31; Thu, 29 May 2025 11:18:09 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::14) by DS7PR05CA0068.outlook.office365.com
 (2603:10b6:8:57::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.10 via Frontend Transport; Thu,
 29 May 2025 11:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 11:18:08 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 May 2025 06:18:06 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx9: Add GFX9 IP versions support for Cleaner
 Shader
Date: Thu, 29 May 2025 16:47:52 +0530
Message-ID: <20250529111752.1196473-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7f747e-3290-40d5-e2a4-08dd9ea27d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUJXTXd3d2JmZ3FsRko1TTZDM2lJa1B5MVUvYS9RdTd2RkZqWE5qbndkVDVX?=
 =?utf-8?B?WEFyRGRlbXhvUTBZZ2FLWFpLZGhRR1JUOXJFQ1NQb2s1V21XRGNkeXpZNGJO?=
 =?utf-8?B?cXZzQ1Y1NkZCSFd0MlltcEpjWkVJcE1EdC96cW9aVnFWUHl3YzdscjV3TUZI?=
 =?utf-8?B?ZkJUcFFhdktWUzdNdU9hWTdkS1l1T2ZjcEVWOVpUTXdYS0xUTzdnSXNsVHJs?=
 =?utf-8?B?M2tqWXRhMUtFQzFzajRUNGpyaFFNVFlGRDB6VzZMUWp1dmFKa0NpSnZRNTZi?=
 =?utf-8?B?cE9rZC9RcStyWUpRTDRYQ2hGc2xYUXAvbC96Q21xemJBcWxQVm92d25DRlVU?=
 =?utf-8?B?UXRjU0c5Qk9ZRUZHWWtFMUl2K2tsWWlneU1raGZKV1dZM1pDOVdtVUJ5OFNH?=
 =?utf-8?B?YS9VNnRHUFpzeDdtcEtBMnNWVVRDQWtacDdidGtkcmFKWjBweTd4dnJKWDhE?=
 =?utf-8?B?ejJkeDFpN29lMHBtRnVuM3lyd1lTRHNiUDhLaU9jM04vTGVOcnJTVmgvNllh?=
 =?utf-8?B?VE5hZHZpN2JZRitVVHFHWVdvRmsreWpmQi9yZFNNSmZ6SmRPUm85bXIzWGJs?=
 =?utf-8?B?Nk9PUXBnVVhxSWwzdUN2cC9Renh3a084T2JlRGd4cERMcFozSFNLbko5WUxX?=
 =?utf-8?B?cXVrcEpjbFdOYzhybGZFbGtxdHRzK2tzU2NUTkpQTTkrSFF4dzBCeXpkR0x5?=
 =?utf-8?B?WFh4bDVXRzRmY2g0MVFDVEFrMzU2R1N0QnFMTXNUNUNubnFPN0hJRENQNWd0?=
 =?utf-8?B?QUs2NlF6R0VQL2pCRURHWmZKbGpkbHpoNGlIcHZYTlJkdmtxcjBVcElnSEpL?=
 =?utf-8?B?UXBjZHh3RnM5ZjJaOGRNaVRVSDY4TWg1aldXTXJIRE1ZdnBXNVNhQVlEcmgw?=
 =?utf-8?B?eXZTeHd2Y2N0dWdHc0o5aGVIalJHd3FVdmJuaWRScEM3d2VVM01Kb2NadGpN?=
 =?utf-8?B?a1dMcDVncnEwZDdFRkl6Ni8vdDVpKzRmaFVweDhYRm5aRnNYTG9rSVlvR0F2?=
 =?utf-8?B?cFJWYmx6WmpnUDRwWTNsdUNLLzFLTkY0Vmd2dFY0SVdiVGJibjJYMHJKMlN1?=
 =?utf-8?B?dFBrcjZjUy9qYVYybGNMTDk0YXhEa1MvWjltTUh2eldheExIakFkYXcyVDFD?=
 =?utf-8?B?d2xkY2NpS1Q1T2dNNk9lRURrME9DRzRiWnZUcVVhakpxSUdmZTlrRTRXWTdy?=
 =?utf-8?B?OE1rcHlkR0hTUHdkMUdtK1dlWisxZmpXZzZYTWlpbFhRRVg2bGdDZUlOTUk0?=
 =?utf-8?B?RnZqVU00cnFYQXJsSmk1anhhV1hlaDF2eTkwL2MxN1dIeDJMYkdhVUdQY2Nj?=
 =?utf-8?B?UVloV0ZsVG5KUFE0NUJUTzhOMVRUUHJnWGRLNDBxZXUvdGxXSXlRYUc0THdq?=
 =?utf-8?B?UDZxdDg0NWRDRTJTUnA4NURiWmczK0VrdzI2dDkwNko1dkhjL3NBaTRFZEc4?=
 =?utf-8?B?elc3SDhGRHVMc3pBT3h5UHRCa3JMUWJWbnA2WFV5aUZVTHRjbGdOS2pWMWZ5?=
 =?utf-8?B?cEl4YnZUcldVR0ZQSG1ndXhEQmZaTEx4NEpRSENQWjJQSjJNNmNRSVBkblIx?=
 =?utf-8?B?Rk1hQlpSWkl6NG16bnNPdWNKRnJzTUx5RmtkVERoMGw3WExsV3NMU21rTUF4?=
 =?utf-8?B?cmY0U1c0UktSWmdBWkdwUHBVUGRJN2Vkb2lUY2RMZU1sQVp6cTVGUzdwZ1Zz?=
 =?utf-8?B?N2xUcWVWNEdJdUh6NXBkdDFnMzFUcy9SSTRZN29YSE84QmJhb3Ztc1lQYVJr?=
 =?utf-8?B?SGhMTnorRUttb3l4d0lqQUpSSFk2UThaNmdOOWNuSXo2T09sdXNYdGV0UENT?=
 =?utf-8?B?YSsxeTZSZWNHRjFjaTRZcTB3M0JrYmlqeXBSSG15Q20xVDZXWUZIdzNra1NV?=
 =?utf-8?B?U0NKK2lnMHA2VVltR0pETDZBRFJidVJSVDFJVDJxZTQwa2ZjQ0g1UmRNTk11?=
 =?utf-8?B?amJaRit0SFZDUWlEcFVGV0h2Q0duRG9CMkR4Ui9sNFQ1U3RlL2IxNEhENVNY?=
 =?utf-8?B?ejlBWWYraEh2TjEvZm8zdVQvL29Lb0ZxYnlxSUxOUG1OSUhzWlNMMUVheGM0?=
 =?utf-8?Q?x9l5ku?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 11:18:08.2830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7f747e-3290-40d5-e2a4-08dd9ea27d7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
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

This commit sets up a framework for integrating the cleaner shader
across GFX9 IP versions, such as 9.0.1, 9.2.1, 9.4.0, 9.1.0, 9.2.2 and
9.3.0.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d377a7c57d5e..90b1e9b241e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2235,6 +2235,13 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 3, 0):
+		break;
 	case IP_VERSION(9, 4, 2):
 		adev->gfx.cleaner_shader_ptr = gfx_9_4_2_cleaner_shader_hex;
 		adev->gfx.cleaner_shader_size = sizeof(gfx_9_4_2_cleaner_shader_hex);
-- 
2.34.1

