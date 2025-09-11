Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2627CAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 15:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36BEB10E3A0;
	Thu, 11 Sep 2025 15:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K3UMAxWT";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB12110E3A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 15:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/mWtNvEqGVcnJiu/SLjHP1YzVv5lVAXXF5QxlvODX/BSyYSs2nv/T9gpMJAwaSk7nJnrf0S4rsE7hIWxlWSyBPM1qnIfLNtjGZazfhDIuMkUwoiiZYVTVhrf2cJu8YndETcH/xfJwKP3GBeLDAEVU8yK6CV5+f/vY51OJ8+2QRTuLVN3Pw9ubl1eDpQ0Ltr+mvvu5KBaeKWRT/ryqbRD4y+JG1lZ4N24yaToisJLOaXIvNjLB2+QCuleEoBdRNaJzCZAe/Onxikw20rf99nJ+AB063cRbB1NTBXVpmBGjdpHjAHx9Ww+FThJ/XuBdTo5K1tv9nAPUlQqBjHymW3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2Vy2Kc/TbB191FO2BNgJkkSID/AjU5QV3QVA19Akmg=;
 b=XvYZoMxTlUWE7dwcNJmMumUde86n3SRPuQn81DRt1SB2G1OUrMTw+8ohxlDzHrxcHgaLkN665jnaJ6BPPc2oMbxrASDEsZ7QK3AQLRAjbNslPjhaw/8WY4XVz48JrUupxDMyvnhN+BSDhjkpfaua1t2U1bDjEm6cywTd/QouJrtz32N+sTLZ2EP0NwaFD22gH909AHzMyBZscycRiI3pzP2FTn4Ah4vbLkzMKhl9bfqhBtK2DsIVTWEpj5nTQ1EEZrx6G5JJEvzG/vHnZrFn7Bv/Tqu0gU6zeQDuZUMiK517xiYGThnrzBkPTOTLyHS1lHxbxxvUXGfc2zPhWyCiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2Vy2Kc/TbB191FO2BNgJkkSID/AjU5QV3QVA19Akmg=;
 b=K3UMAxWTseEPjwZx3z1ZDX5o17Zxw9M58pyAa1aAiB1aZU6BWvnH35h1c2rj1CwtQcgj63Wxe6/1zjUCXqAdA41eF/FkO4DdrVZ/AaxhGyAy9LCVuYPA9xTe7wvi2x8tQiRB1dEXgOjjlPqnTgWraqLA8edLHIBFNFIdrbXg5hs=
Received: from SJ0PR13CA0198.namprd13.prod.outlook.com (2603:10b6:a03:2c3::23)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:02:52 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a3) by SJ0PR13CA0198.outlook.office365.com
 (2603:10b6:a03:2c3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.8 via Frontend Transport; Thu,
 11 Sep 2025 15:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 15:02:51 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 08:02:48 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wasee Alam <wasee.alam@amd.com>, "Mario
 Sopena-Novales" <mario.novales@amd.com>
Subject: [PATCH v2] drm/amdgpu/gfx11: Add Cleaner Shader Support for
 GFX11.0.1/11.0.4 GPUs
Date: Thu, 11 Sep 2025 20:32:39 +0530
Message-ID: <20250911150239.825769-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911145934.825708-1-srinivasan.shanmugam@amd.com>
References: <20250911145934.825708-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: d2187366-ae8a-41a7-435b-08ddf144478e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2M1RWdyRTNyajZ1K2M3MXdhNlZHbGhEUSt3Qk5NODEyK0U0cjlYeCtQSU1s?=
 =?utf-8?B?dG5rSGJBWi8wQktFS2hjeDRjR3pGOEVCYlVHMVUrWlAxdG5YNVMrRmppN0ZW?=
 =?utf-8?B?K1d1ZWlEdmNlQXY4R0dYY0xHU0JEL0s2dWVhRjQwZG5FTHk0bktGZjNHTVhK?=
 =?utf-8?B?eGRMczlETnlvSmtkeHg0dHRqdTJGelNlQTdhSVVqY1gvejlDN2NIRkVZcit0?=
 =?utf-8?B?ZFdEQ3ZSbWcvdmVtL0VXdVBKcldBblZGT1BoK21oODVrdzQ2VUx3aXVEcmlh?=
 =?utf-8?B?LzBvQ3V5UUQwVEhqU2dWZVJMd1FtMXU4c0p3RWt3akdBb0xkY0FpbDIwQWUv?=
 =?utf-8?B?dGo3cHp5UDVYMFRrcEdyb3V1M0RRWW9nZ3QyWGNmTDhNTG10Yng1MFYwMHM1?=
 =?utf-8?B?c3JqNDA3aEw3TndTbCt1OVk1V3pOM1FYN3FiYmY3NE1QVEJBSWtIOHduZTFI?=
 =?utf-8?B?cEpxWnZqNkIvUWVJbkwrdnpqTTZraGxPNnM2cTN4Y3hiZDllbHgyVzZOZG9E?=
 =?utf-8?B?d21EanNGSFFweEtqTW9XRTh2ZEkvY1E0c01Ib1A1dnlVZlRBV0I0blVDOVl5?=
 =?utf-8?B?VGJVbENuNU1rZWU1TzBIWVhGOHNDRS93OExubWZ4azFwZkhQaGF6amsyZ1g0?=
 =?utf-8?B?S0tKa2pQei95ak1BcGI1cUhaSm43bWQ2VkhWcVhGNmgzeFVBZy9hTjMrendr?=
 =?utf-8?B?dmV1VndIbnA5cVFBMUhCV1BSWkFDcklmTDk0WUYyNllPNFNLekZkVXE1d2Qz?=
 =?utf-8?B?T2JSRElPSDhNSVFMYmduTGRFVkRoNEVuemUyaXR0dHNvMjlDUklBRlJxN2Rl?=
 =?utf-8?B?UEdhNGtPUUw5cUhuMWJuUE85TGFBdDBwYU9Ua1Y3VFNzVXhpOGxpcHF6Mlhq?=
 =?utf-8?B?NURnYTMzTGtvMy9wMFo4RFdPQ0NnT3ozemZqNVFHSnRjYUlQQUFDK3RNd0lu?=
 =?utf-8?B?cW5wVmVMbXF6VEovTHRvY0pRTFFseERRaUM5cCtEd2ljL1Y5MURkVzVFYXo0?=
 =?utf-8?B?L2FzYitqOXd2TnoyUGRTYUlWMS9iTDFPbFhMNVVLOWpyVkJNeHlCNWl4dTFS?=
 =?utf-8?B?UVFZbGxBTGdVY21rSmlnaWFUL3V1OHdtV0VXbWVjbm5IVDNPYm9UV3BaeUtx?=
 =?utf-8?B?QjlIaCtpZXlrK0F4cXdiWGZsQkxXbE5xRER1VGtMbHhNT3pmcmZKRUdlVWVU?=
 =?utf-8?B?bWxzL1dENk1ZZ2ZHQ0VaZ1QvM2FnNm9TZFVyWjBTSk5oREpvWlJqekQ5akxR?=
 =?utf-8?B?cXdsMkZMclJCRkpKbExYSFR0ZUNlMGFKTGk2c1FpSXRQUk5KUE5DRGF5eFoz?=
 =?utf-8?B?QmZQZGJpTDUvbFg4Wi9ua2M0bVJLYUV3YUVJb3lYOExaWHJKdlFGRS9MMDR6?=
 =?utf-8?B?V0RQaXBaZGxrSE5DUURuVU56NEVBTHJGY1FRdjAxZUJSM28zM0NiS2lFbThv?=
 =?utf-8?B?eHM3UVlFbmNMM2tyQW5qVUdwVndOWUlTLzdwYU1ua2lpajIyMk5VakZFV0lm?=
 =?utf-8?B?Ukc0aGtXVjdjdzlRaHN0cVh5dUpRZnBlajRmQ1QzUmxLQjZSdlFKWkhZdEVP?=
 =?utf-8?B?b1Z0azdBa2p4cXVGTFRiMnBnVGJ4YWFKbHlUVmh6NDU0SnpLQVNWOWdleUlQ?=
 =?utf-8?B?UklkYVMxUU5qYXlUQ1VodWlwTTQxeHh0RTg5RE05WGpseEY2WXJ5ZVBvNXVt?=
 =?utf-8?B?bXUva25jR3BYV1Azb2Yyem9wdzdMeVUyZWNYc21EVHV3d2JsM09IOURxZFQ3?=
 =?utf-8?B?aDdmWWdRdFd1ZTAycWtINzhnZW0xNWNQNExOYmtBYzU4VFMwcC9OdXhJOHVa?=
 =?utf-8?B?clJqc0NVQnZrMnpjZFVzTDdIc29vNG0yeDBCbVQrcmxnWGoxMWRCOWd1bjY2?=
 =?utf-8?B?UHFsRGtUWlRYZDZ2d1lXWE5VOGxXampGd0t0QTJJbDZ1TkFoN2RudlVmMnMx?=
 =?utf-8?B?UVZVa0NkNXN0akJLTmRTeWlUTHloVUZUbHFqaFByaENSMU9WbG9tUWxPaDl2?=
 =?utf-8?B?WDE1T0hma2g1N2lPenNOZ0E0eGE3d2UvY2FyeG5zQ0lkaFpVdzMyV1RTVktK?=
 =?utf-8?Q?PlJvqb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:02:51.5721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2187366-ae8a-41a7-435b-08ddf144478e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279
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
v2: updated MES FW version 

 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 86b3fcab5772..66c47c466532 100644
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
+		    adev->mes.fw_version[0] >= 128) {
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

