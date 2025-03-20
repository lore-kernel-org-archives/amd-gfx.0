Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42E3C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 04:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D39C310E0CF;
	Thu, 20 Mar 2025 04:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PNMbrsaH";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5EA10E0CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 04:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9GvTUpJJ6a7bQZHm2uz7V76iyzTBB0/4Rt85Zcn5i3HxSpZ8EO8SlBT7XuaUDGhCNrfeE6rTPMXwN+aE5jvs93B9cCP9i1skJ2TCVB5OndEIctfZDY2t2eOm0iJ0+NytdYOL5R0tGod+yxcfTSNboS6HBJxuThztoKsfjvSGwgnGFmvtYYqxI2EFq1Tf6eCCBHC33YqEOeg2AuPJOcH2leIyG/l7erlMsa4buUq4JkROtVtMUeryuiw2ldtQCXMRLbG60V1QHQQ08tGHbiH1eM7x5bcR6NXmM7/u5M8vk9UdNcr8hPuaDg9X4b7Ao+RgknFvs1PiCoD7jdYWi4RXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edSPah3oudknFHTW7ime121wHfxjAPeGh27vQPSiofA=;
 b=Xr+J1RFGG7NOv+snbESq6jp1FGBqcVLnytvRTHX8DKHeyGYe3Wwe0jKru6EnIXV9qwKryCUrp7zZZTBYx8UvRDHaXdXUhrocqhboO9EXulLeDUVxaVsgldQ7XglNuWyM4paRj+L1DZztRt6qLm6FRnUukBo5YnNvhQszNUz1ILeRvGF25y54+NOTGVWwb5b9NuzPkGaoJVfZ+8MEtPHEWaRppRnLGO/oE5zYtuC6svNArxXrt4VraAznqR/rtIRpReb82tZm4MgD18kwOYjOWBta8Ah2SgfsMEGFTLFT1cqvx0izRE6MPkRDdO9ZUxzh9Bt14Z/iPyqS/BrLeYAZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edSPah3oudknFHTW7ime121wHfxjAPeGh27vQPSiofA=;
 b=PNMbrsaHs+3vhx+S0q0EFXgGRw8LXS0fjSzEjHGYT41IOJ1uhKWXVIvE7ekdleB7l+ZQctMgwesrcCZJ4BBc/8GQK3Rs+Yn2uld4PiwXHTLIPa5V0j5X++COb9bEswdNgwKgBdhwsVHpDgrFVMwd3vcCl0pE3Kx5g7SZVlu34jE=
Received: from BYAPR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:c0::40)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 04:12:55 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::52) by BYAPR05CA0027.outlook.office365.com
 (2603:10b6:a03:c0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 04:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 04:12:55 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Mar 2025 23:12:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Mario Sopena-Novales <mario.novales@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: Add Cleaner Shader Support for GFX11.5 GPUs
Date: Thu, 20 Mar 2025 09:39:36 +0530
Message-ID: <20250320040936.2361475-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c60902-68dc-4fae-51a4-08dd67657d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2xGV0dWbk9ZODZaRFRZNDRtam5SdDkzUVhtYW9FeTdNMnh5Mm5XV0ZQUWkv?=
 =?utf-8?B?VFl0aCtJci91WHF5OUptM2J6Wlo0NTk3cFhheVIrNVphTC8wenB5bnoyTTJM?=
 =?utf-8?B?UG5UZUFPLzZsR0dUWGd3SDJlOEtONkhGWGdES292czBVbXczc1lQYzdqT3BF?=
 =?utf-8?B?NlRLdVc3TmswSmpqQUZMRlJLQ3ZQK0hXL2tVMUQxcmJWbzRtL2FkcHdNQjFN?=
 =?utf-8?B?K0VVMmhRaDg0YjJVVGFrVnF0UUdzdjlqNVY1V1dlWW5xMVVhczlKR2FRWUdl?=
 =?utf-8?B?S1ozQzMzMG1pS3hUSzYzUWFnQzJSNkwrcFZpZHVZWFNWZHFmUzFLY0FxdWIx?=
 =?utf-8?B?emxyWXFKMHV6ZlRHa2xod3RNRWZPU1ZxSWx3d1RWMWNIdzRzZW1sWHRlb1FS?=
 =?utf-8?B?ZmpsYTErbXhDdkoxcDNQSUZVRVRPQzhwa1RUcUJ1dWZJT2kwNm9RVTNJcTRX?=
 =?utf-8?B?eE0vL0FCaC9kQzV4MTN4Zy9QZ2NwTnFKemJpRWU3U1RUS1I2QUNxazR1Njhy?=
 =?utf-8?B?YzByc3dqWkdSVmJGTHhaUGk0dSt1amFmRnJUR25ZMnF1MnM3Zk9qMHhlYzdK?=
 =?utf-8?B?T2xuZ1J4MDZmd2dGWWd5SWhCRnlVVkg1ZTYvY1hVOHNBVkROYzd5ZnBQZGhq?=
 =?utf-8?B?NWZYSVpwUGhNT0t2S1hXdFlMS1R1Z0YreHNCR3FhdzZKYUltdDVxL3lhT043?=
 =?utf-8?B?QU5DbmR0UkxJb2ZYT0pkZGVob1FhVUJITUlBU3dCK0QvSU15N1VRVnJDNG8w?=
 =?utf-8?B?N0xVQ2RSS1hSZnFNL1JSZXlla3NzOU9TWDQ3SkhaSGRFVlRVR0FieWN0R2dQ?=
 =?utf-8?B?UUpTUGxoeUF2M0g2U3luV3F0alBkMDl2eWIxNEg1V3pIa2szcTREUnhnMDdt?=
 =?utf-8?B?aUV5YkI3VzJoV0dpY1p1VmdpSHRYZ2xoNWxGblFCdEExRVhxZjlrL2dVeExk?=
 =?utf-8?B?NGpSY2wxa2Ezb1NOWTlPVEJzT0hVUmp6NElEMERJL0JpemdQRHMrUk5aS0tR?=
 =?utf-8?B?M080Sk9mYnFTbE1SYXZ0emVPSlZJaDhET1R1TE5JNklkZ1dkbEFkUUR4ajcx?=
 =?utf-8?B?SW1VN3A1eTFYSUNGT0c5ZEIwL1pwUnJ1OEwyR3YrdllsU2M2UDVDbUpGM3dl?=
 =?utf-8?B?ZUk0UWpkT3U0RWdlZ0p4ZCtISi8wVmV0ek5ZRS9RSkxGY1gvMFJmcnZLTnpi?=
 =?utf-8?B?Z3RsYjFUTEVCMjMzcTh2ODBPSE9XVTgzMXhFTC9iMEJZV0loR1RTU3FMcmJq?=
 =?utf-8?B?bUl0Sko4TGdndVVoQThsc3ZWTWFVNlRDZmhsQ1QxWUhxbXBrLzVRdlhGNWhi?=
 =?utf-8?B?ellNQTBBRW8vWFBsQ1lYK2NLeURxdVdVeEJKNnpPRGMwcFZDWFdMemdTN0NO?=
 =?utf-8?B?QWJzYTZnWmlRZUhmU0lsSEhhK2ZodGl2akk1cTQzUFR4b0RSRUswOVREbnpm?=
 =?utf-8?B?ek81aFI0YmhlOGwvN2IweENPK1N5cVIvTFViNTBHZ3lnTy9mWGRlT3ZrTGF5?=
 =?utf-8?B?U3I5MDkzOEE4OXphcXgwVUt3VDArSWhqQjY1clFvdTRiUFFxRlRaV0RVeTVt?=
 =?utf-8?B?SVVacGVra3FWM2lueTNQSXZPSE05eHVSMXFxUjRVMzNrOUYwdWxSanNmUVpG?=
 =?utf-8?B?b1dlb0ZJeGpocEUzRTdKMGdwOWxSTUo1UDl1WWtWWWJEQ3F2S3hnUnkrOTdh?=
 =?utf-8?B?RGxZdG1laTFlUWR3elAxVDd5WFpHNTFscjJKclFpTExNQmZORjNOOW9XOTJU?=
 =?utf-8?B?WDhabjZLV0FWQ2lFZXZoR2FVcDljM251NERsSVN2bTY5bXh6dTdLTitaTjdP?=
 =?utf-8?B?R1laamRRdldQNzBKbE42Z2Q1dTV0ZURQSGlncVlMQlNKK1ZrVFZ4eTIxOXdY?=
 =?utf-8?B?UlpsV0pEVlpWQ2lVcnJ5OVZTYURjZG1CL1llTWlUOWo5Z2JjVmdIMzBjaE1S?=
 =?utf-8?B?Zlh4SmsxRm04N0VPQlNhVktZZzZMSHJKVTB0c0pwdWEyUXdkRlFkeGN2L01H?=
 =?utf-8?Q?ecaJ9e9jU99ssyap0cvfj8G1BDwl0Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 04:12:55.1629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c60902-68dc-4fae-51a4-08dd67657d99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
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

Enable the cleaner shader for GFX11.5.0/11.5.1 GPUs to provide data
isolation between GPU workloads. The cleaner shader is responsible for
clearing the Local Data Store (LDS), Vector General Purpose Registers
(VGPRs), and Scalar General Purpose Registers (SGPRs), which helps
prevent data leakage and ensures accurate computation results.

This update extends cleaner shader support to GFX11.5.0/11.5.1 GPUs,
previously available for GFX11.0.3. It enhances security by clearing GPU
memory between processes and maintains a consistent GPU state across KGD
and KFD workloads.

Cc: Mario Sopena-Novales <mario.novales@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8261308fc1f2..e0a9b10d645c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1632,6 +1632,20 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 		break;
+	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
+		adev->gfx.cleaner_shader_ptr = gfx_11_0_3_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_11_0_3_cleaner_shader_hex);
+		if (adev->gfx.mec_fw_version >= 26 &&
+		    adev->mes.fw_version[0] >= 114) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	default:
 		adev->gfx.enable_cleaner_shader = false;
 		break;
-- 
2.34.1

