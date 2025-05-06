Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275A6C3ABBC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 20:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC6110E72C;
	Tue,  6 May 2025 20:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cyIwcMrp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D4010E719
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 20:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5KO6b+K01rp753LMfNPX0qrBXvvN4NEmtWGe6xm9w49jrXSYVLl0R9BHeOyMrXrjLgJTl6f4DumM0VIdKRRTnG/VBWHuQtkHKep3pALeWLYdUVYpA8rs+pj+P0/SoXoK2RJbo9COOeJTvNJUrJtlSIQDNHmAhvLxDd2SagH+3mxSwfyVO4E2EMLVojChI5iNABJRSamx6IQYBpUOnNfPcsTnumQxYAj7DdrzbIxXJlbu9gozdcmc2i4WGr8aUbRV8M2L/ENEqyQ938Cs2mfOmqC/NiLFTWbpAhovxoFtGfsdwYCZIY6j9aVS4oUnmKR1uaUuelTj+st+QKtzK1uAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2DuHVX2+cIdwJakTaumtZHa9AvQMHOF3i6TqXrSrjY=;
 b=LJ9AYzqtCT3XE3A0rBWw3YZdsOqreD99QxWCpCrEvt3yWZUbrrtSG6dM++9ROG2kgL8kTVbCJ3ZDob7Fyekex2zTSpxSBBlxzkGGxeevTEhoLbgKyTJIHjEdqLbZ0vEub/zXIdOZ7PLr2nE6UTQsJM/LQt9LGpHgpWV36mjuqFtPj1Vy9S1gMg/VrxjQFbLwmeh1wGFkOFpDSOHq2J4U7/7MatHNQj13XrBaEr+y62ZZjSm+ptNEkPzb6foNJy8i2QZrcEWq9MUnPI04Y4p7AoEE3sqgHk6flms5vL34KGckHIRUsIz+KSib8zmkvnRcWSy7AC7djxjkrMdocmTmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2DuHVX2+cIdwJakTaumtZHa9AvQMHOF3i6TqXrSrjY=;
 b=cyIwcMrpg4Z4tuhOkvAojWmKXY7pPeVkKTGb9prtsUZReeEB6/tfgOp5eVj4bMt7tiEVV9mU+HFZwophtduMSv4wbJMFXPKcv1F7YKl4iHooGYJ+ThDPGFi9/uQaXbokPcpRmm9xXvxJmakQvtomv+5WpRbjANlMf4rf137x2gE=
Received: from DS7PR03CA0326.namprd03.prod.outlook.com (2603:10b6:8:2b::28) by
 CY8PR12MB7339.namprd12.prod.outlook.com (2603:10b6:930:51::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.34; Tue, 6 May 2025 20:53:28 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::48) by DS7PR03CA0326.outlook.office365.com
 (2603:10b6:8:2b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Tue,
 6 May 2025 20:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 20:53:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 15:53:25 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 15:53:24 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Manu Rastogi
 <manu.rastogi@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: Update cleaner shader for GFX10.1.10
Date: Tue, 6 May 2025 16:53:13 -0400
Message-ID: <20250506205313.88835-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CY8PR12MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: f2eb7824-6928-4919-5354-08dd8ce00c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkFjZmpBWDVaQnZnVWwyRG1rRUw1T29YZEFTd3BmcU9Kc2FVL2FqTFpSRUx1?=
 =?utf-8?B?WnlGWUd2ekxBNUNPRjVDM3F0NXdBdmJWL2pUMmprMUdYUWtlMUxsaGhTV0lr?=
 =?utf-8?B?MnRHZGN1RHBNR3hpK2xOUlNCMEZId2JXSWFaL2RsaDlPS0RlMFd2dDFJSk9J?=
 =?utf-8?B?ZXMrQjJBUkxDL2hiVkhWYmJ3dk04Mk9WTjU3eEdTS3NRMG03Tkh3NWtRbHhr?=
 =?utf-8?B?aHhIT2ZRY3RJOTRmbENOSVVHejhSSmEydXlWcG05ZTFjQlRNeWpKdmVTRFFG?=
 =?utf-8?B?dnJac2s4MjI3YStXYUtEVGtBcVFWcUcyby92dXVkVjg2VlkycEtrSDlYLytR?=
 =?utf-8?B?MFV5ZDUxNDBDOEdObEdVRG9hY3lmK0ZXaSs3cVpERldrSUVHUTc5N00zckhR?=
 =?utf-8?B?S3NTaGhrV09IdFFzSitoUWdvK3pUYmFObm5WSVZ6ckVqbnlTUlh1TkN3OGl2?=
 =?utf-8?B?akZ4TDdmYmZKWnFKZXNhbm8zb1gvakhINWQyQXlJTnZSNWgwREhzL25KblpV?=
 =?utf-8?B?WUhYcTkwK0MrTklZejFTS1BCeTJWS1pnYlUyWlEvNjAxR0tMbjEvci9RYk44?=
 =?utf-8?B?RkFkWmd0c0xsUVpMbUZ6bEdMRThGcmlydWsxUFlESmM4bTQ5c0VaakhWNFNz?=
 =?utf-8?B?RklnK3hCSldRc3VHQUJrV3BDMkx0bnVqeEhKZ2pGOHA0dU5JdjlOejFDS0dV?=
 =?utf-8?B?T3pqbmNYY2U3QWVoOURibDRGVWNiT1dCVjhCVjZnTjFVU09iRTNQVExYMkJG?=
 =?utf-8?B?Z0RmMThVVHFTTXZ4M1dyemF5S0NNRnY3Y2RSZy8vaGVRMGJxU0RiV3VEUFhL?=
 =?utf-8?B?eUdReUtKcStsTUpaOE54dUdLYnlpVXJuaStlVGtEcHo1U00xelBjM1hZc2hQ?=
 =?utf-8?B?cHlEQkkxSFhjckhoR01PZHRFTXRudVBod1NaczdnblJNZlZJQVZuMThWUXVw?=
 =?utf-8?B?RmlvWWh2K1hHZnBMdFAwSm9UMmltL1ZqZnpYN1pIZXVPdkJ2V0NHQ3dKblox?=
 =?utf-8?B?Q0QrNG9CNUlxVFFKM1IvaHpacVo2NmZNdGFqWWl4VlBZZnkwdDNPSWVvd042?=
 =?utf-8?B?d29JMHJsOHdDbWhEVXgzaGRSQVB1d1RPSVRUWStUb0o0YTlLZU51d2EvdTZp?=
 =?utf-8?B?VkJaYmpWdU5TQ2wwUkhVMFJpMWREVHMvaEtGUUViUkVTQWNKY0pFWG5uL3lO?=
 =?utf-8?B?V3VDNmNtM2JVUVZRT2k1Q2FRYlhCWmFQL25sQlBLc3lNUDZ6SHBLYXZsUndO?=
 =?utf-8?B?OGx3eDIveURIdkhVM1V3Y0dhMStCdDB3RlNEbHArcnRyL2VyZFlBbW9iWHlv?=
 =?utf-8?B?cHQ1dzJBN3R5ckN5MmNzcU5GYUhleXIrZDVVd2dEZFd4ak8xby9iRFVaUFBm?=
 =?utf-8?B?UDVSdEw3Tzk0V043M1V1WU93ZnZNY21hLzdSSHlXTDU0TXV5c3VUYnRSNnNw?=
 =?utf-8?B?SGVzcGk1SkNIT3pvSEhzaVVKNlo1QXladElTZTRWaW9mcWpKZ1BqMnpSVm90?=
 =?utf-8?B?a201RGtsend3d0dqVmo1VHRDbE5Ia1ZCd3N1aytTUWZXM0RRSGUzYUFsNGJV?=
 =?utf-8?B?NjlBTk9EdDM4WjVyNnR0Z01Qa29VR0QrcGN4L3BuQzZEMmtrY2t3T0VVZ0Ny?=
 =?utf-8?B?MHdqb0lkaHhyZ0lUbXZSZEZXTU1Vck5NeVNOVlpyaERwRWxMUWdTZkxhRGZi?=
 =?utf-8?B?L01RVjhxVFB4RDJwUHBrbk5hZXExbG44dko2YUtSQ3JZWWxNdkFEMkFnUDBp?=
 =?utf-8?B?YVFSSXY0NnJ0VjZNQlJ5R3dlSGNiVWliVWg2VUk2TGFHYUxDYVVxY2xRbmtF?=
 =?utf-8?B?VjhjMGJoTmJqMjBlL0JuaUtvMS9Xam40YW5ZTjJheHZkMHV5QTBNM1EzM0lj?=
 =?utf-8?B?bktDdWtyOU0wMFZoT2dZM1dNSDlIMEt3SlFRMXIydVVsa25CbW9EWjJLNHdq?=
 =?utf-8?B?Z1M5R2V1MG5nNk1vZ01ydDh1M09GSDdjNXYwcTk4eXQwSDQ0L2dRTWptZ0Nw?=
 =?utf-8?B?T29GRnlqbi9idkR4dG5zQSs2OFE1MFFGNW1qL2JrYXZWK0tSdWlOcitsNGVJ?=
 =?utf-8?Q?K8NhW8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 20:53:26.3208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2eb7824-6928-4919-5354-08dd8ce00c61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

The cleaner shader is a piece of GPU code that is used to clear or
initialize certain GPU resources, such as Local Data Share (LDS), Vector
General Purpose Registers (VGPRs), and Scalar General Purpose Registers
(SGPRs).

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Manu Rastogi <manu.rastogi@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
index 5255378af53c..f67569ccf9f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
@@ -43,9 +43,9 @@ static const u32 gfx_10_1_10_cleaner_shader_hex[] = {
 	0xd70f6a01, 0x000202ff,
 	0x00000400, 0x80828102,
 	0xbf84fff7, 0xbefc03ff,
-	0x00000068, 0xbe803080,
-	0xbe813080, 0xbe823080,
-	0xbe833080, 0x80fc847c,
+	0x00000068, 0xbe803000,
+	0xbe813000, 0xbe823000,
+	0xbe833000, 0x80fc847c,
 	0xbf84fffa, 0xbeea0480,
 	0xbeec0480, 0xbeee0480,
 	0xbef00480, 0xbef20480,
-- 
2.34.1

