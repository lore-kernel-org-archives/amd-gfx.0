Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A666ECAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 15:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2A010E395;
	Thu, 11 Sep 2025 15:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BA9bCLdo";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4985810E395
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 15:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4JWxYCgCLrWhkf1f168SP/N9EJeVLi//L3M7+xoalFOjXOWXUKaqfeUFbeA+U7ry4YvYu10TPZ3V3/5pO8Bl5y4HHU7ZaboV066mtkNoS/VzTtMB6ggGfOKNd4lh/84vjqlWZcpeSRKXYUtbhhDBsQxz7srFCkAghoweaU+ii08WQnzw2gi3jE4jrXLgiUYhOsLcjdVNAW/MHxMBtuuQeV84HmbmoX+FSqt0iPjvz0Er0fChy1EldaFbsT+9d/5C8dVJm5R3cuT4g5OAYYpBcCPLlubuV0wW0RDVoBpfIWsm2pbNop7Ogg6IX+QalLH/tFeUI7lsfodhaQ3Yzek4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+av9+Twso/sDxkDWCsdTG5pD1Jyp9SjQTpa/aWkrmY=;
 b=EplC85quOjD1KES1Iaf2aGsz9SHopjSLHB7jdS3FrcmaO9s9b0dPZtvv3ICBcRvmgWpFaCodmFQbsvoNjDJKK9Yshm57yAqo/GEjWjeqCkToYMrFNDxBfLcquxI/KtC/0zqY+6hyZaouuZX5jPBu3noMEQDd9rtAiuPE/DY/94youhRj/KQFhxU90v06WEAhcoW/0UOF/tK99TDLF6UQTPuI15Mly/N5xgh+4geecFPYscpXeNBoMHiRNarcmRfnr0Q2QzBnof2QLtZCmqsLlxWDWf9JkL4H1YQeod2c9nBal5BsaDUfHWtSTFBpEk9FaqqFT9CRgA1QubTsOhEZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+av9+Twso/sDxkDWCsdTG5pD1Jyp9SjQTpa/aWkrmY=;
 b=BA9bCLdoCIa5P/9q4CD3QiKVGLW5oUu7KCL3ggGnQ2ITjeuG+wTRhYdspb0aTkZZ3mDFC1eLTBwFsPURlzSucy9bIefNEiVAmRW8XCgYLUXJTmV8VunZ6h4UejGNtu1zla/NCQp7H7m4gtvg06HkP5Q/xZqb+hgmzSkMx4CkIHM=
Received: from SJ0PR13CA0157.namprd13.prod.outlook.com (2603:10b6:a03:2c7::12)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:00:16 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::c) by SJ0PR13CA0157.outlook.office365.com
 (2603:10b6:a03:2c7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Thu,
 11 Sep 2025 15:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 15:00:15 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 08:00:00 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wasee Alam <wasee.alam@amd.com>, "Mario
 Sopena-Novales" <mario.novales@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: Add Cleaner Shader Support for
 GFX11.0.1/11.0.4 GPUs
Date: Thu, 11 Sep 2025 20:29:34 +0530
Message-ID: <20250911145934.825708-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 5999c0e4-01e8-459a-9061-08ddf143eac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHlSRXA5eHdjU3hMcXQ5WnZINk9hSHk2alljVWFkZnh5WjV3elF3azZEVzNi?=
 =?utf-8?B?M3hvRGxKbmVPa2RYeW5EaG0vbmZMRFRPd2pGMG5zV3d0MFFoMjBRU1B0UzZl?=
 =?utf-8?B?aTVWOENXdDlCN1pIVlZGdlRpRlYrYWFGbTFyTGdCNzB0NkxYODFkWUhyMVpW?=
 =?utf-8?B?VDQ5ZmUwVEFpekNpdUljL3B4UlNta2dHSm9hS3MxUkNYeGNFa0Y0RlQvL21L?=
 =?utf-8?B?MXJ2RnplVGZETndUaWl3elB5RVVENmJrRUJWalpIS09zVXI5bkZXV3dJRjZO?=
 =?utf-8?B?STNkREU3bGZwWThzRmFEcEV6TWd4REM4K2dXQ0gwOVIxMnBJZ3Npb1VxZ3du?=
 =?utf-8?B?aEoyUjFSbkxuR2pvWUM4MmRJKzlUODY4WmVZSVdGZzMzdTlPN1lKNlJYb3pk?=
 =?utf-8?B?QjVhS1FzWllmNE9RYmIyYUc4WmR1UFR6WFNreGNERURHK1ArZXpLRTdtVDkz?=
 =?utf-8?B?N2FNWmhkMlF1bTEvTm1rdzNVbHduUXdMT081Q0Jmdm11Tmk2K0lqa1RiRXJP?=
 =?utf-8?B?Zk01WU9RQzc4S0NkLzg4WWZ4K0xadHE0TUNkRWNoendlaGxaYW54UFR1dWhi?=
 =?utf-8?B?QStyQzloaDVwUlliYW1BVFRPV0pHYzM4bTRmQjJUZXpxa2ZTVXovLzZQbHIw?=
 =?utf-8?B?REh1U3pFMmxSa3NUQWFwUkpwWDYrRnZFWitqZVNwQlRLQWNmYnNXcXIxM0hV?=
 =?utf-8?B?ZzJFVkRMR21NQUdmbHhzTnpvZWQvdUVFa3VBRWxOQVhBTnpNR1IyRjFnd2wr?=
 =?utf-8?B?RlFnbkV0V0M0L1JqU09tTTVCL2ZCL240MDM0Y2FkeWQ1TDNlNjdIWVRldDVZ?=
 =?utf-8?B?TFJMMDYvOW5penNXVHc0RWxCY3NHQ2E4WHVqSlkzeUZHcnpFbHBkdjlMUmpw?=
 =?utf-8?B?NXF6Ris4WXRFRzFUdXBYbG0wYVNhTm1Nc1Nmd2ZERUFNNkNMRGVEZjR6SWl5?=
 =?utf-8?B?czlvS2lCYVhHV3V0WXY5VFB3T0wyQkNrZlNNNURwY1loY1lqTDBBTTF5NXZR?=
 =?utf-8?B?Unk5a2h2dUtMRzg0cWtheDRqdU5tS3I1cHpyWXN0b01ZYU9qUDExdW9rT1d5?=
 =?utf-8?B?WFlVY1lmckttTWJ4VmpCVWM2S0d0amM5RHJqVTNhMnY2WXlhRitvdksvc0tO?=
 =?utf-8?B?Z2puUXJxVXFpU0l0WTBuYWZCWXJNVHAwK2UvMXlOdG1nMHd3NTFzWitZaElh?=
 =?utf-8?B?V2J4c0RoVE93eitFcmthNHIrK1JXRTRUUW5Fdmh4TytrUEp4MS9wRWI1ako2?=
 =?utf-8?B?QlI1K0lJZ1VYZHN4a0VLdDFqUnNUdHY1NEJxcnJlVFFmSTc1dFZGcUlBdUdN?=
 =?utf-8?B?WmI2d005eEUzUE1RU2ZpQ2szeG5OeXNLZ3gxVElVQTZLVXpEUGc2VUc5SHI3?=
 =?utf-8?B?T1BkOFNpQU1GNnczNkZFRWhGUDYvL2lsaHJsN0owazIrNngyVWwyODl5S3Ns?=
 =?utf-8?B?VHV1ZVJDRlZ1STNmWjU0VTYrNnFTbjlBb3F4R1hSbjdaeTREcUMrenBPa21n?=
 =?utf-8?B?V2F3N21GcGVaMmNsblpqTmlNMlk4T1hNeDNuM0dsUnd1L2tkVnNBYXZ6dk9I?=
 =?utf-8?B?VjZjQk1TRkppSW9WN3dPN2Ira1hTZUQzQkxFU0prSTVuVEVYMHNjU0xyM1RF?=
 =?utf-8?B?RUtEUlY5MVpZUmRYeFlxRXp4eWhuSFBWVTV5NkpjZ1U4cVoyYjBkdGZJdE85?=
 =?utf-8?B?OHpMN20yandia2hhamIwV3Y2UitRTzBDbWk3cVZXSC80MUJnTGN2dkFZckg4?=
 =?utf-8?B?dXRWTDMzSzhQNGxMZ2Njc203Y2wrRzhoV0ROZFBiM1FqSWtwdS9VbHZWakZl?=
 =?utf-8?B?eGx4TklQaHkwNVZlWWdzOWJKS1lTNzdUMzgwTEdtaWlKcjJPN1p5WkxEdWhW?=
 =?utf-8?B?N0V4cVljNUhlM3BqaDltaDlCcTd1Tm5CaGdmSnNqbUVIaVVpc1UvN3BpdGo3?=
 =?utf-8?B?SmpKMkFXV2lZeVFtajlsSEtWd2J0VzNocGNkNUlqRlZMa3RMWGtCb0QrUXhS?=
 =?utf-8?B?aWYyVHRuSllVY0VheW5teEZQbVhMbGFpNnVTVVZqK1ladXJHNlNlaGZ2Mkhy?=
 =?utf-8?Q?8EUxGA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:00:15.8870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5999c0e4-01e8-459a-9061-08ddf143eac2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
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

Enable the cleaner shader for additional GFX11.5.2/11.5.3 series GPUs to
ensure data isolation among GPU tasks. The cleaner shader is tasked with
clearing the Local Data Store (LDS), Vector General Purpose Registers
(VGPRs), and Scalar General Purpose Registers (SGPRs), which helps avoid
data leakage and guarantees the accuracy of computational results.

This update extends cleaner shader support to GFX11.0.1/11.0.4 GPUs,
previously available for GFX11.0.3. It enhances security by clearing GPU
memory between processes and maintains a consistent GPU state across KGD
and KFD workloads.

Cc: Wasee Alam <wasee.alam@amd.com>
Cc: Mario Sopena-Novales <mario.novales@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 86b3fcab5772..a101c5134089 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1653,6 +1653,21 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 		break;
+	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 4):
+		adev->gfx.cleaner_shader_ptr = gfx_11_0_3_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_11_0_3_cleaner_shader_hex);
+		if (adev->gfx.pfp_fw_version >= 102 &&
+		    adev->gfx.mec_fw_version >= 66 &&
+		    adev->mes.fw_version[0] >= 255) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 		adev->gfx.cleaner_shader_ptr = gfx_11_0_3_cleaner_shader_hex;
-- 
2.34.1

