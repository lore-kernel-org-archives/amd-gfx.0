Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0855ACD6E45
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 06:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DDC110ECB5;
	Thu, 28 May 2026 06:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vHJ9WJoU";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012029.outbound.protection.outlook.com
 [40.107.200.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DF810ECB2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+PhD0D0X5I6C+EhdM246CM/9Yc7YAFfhg7L/bYzb1yaTADMSibtPziZ+C+TvW0rDFm7j2dKQff7YPE0jYSazX+bPbO1tMhD4JJPotMZLSbFFzH5iNnnzIPDAaMgojhAGWu7DCMqPP9hXtWz9PRRkgYh4IESftrE2/gJQAnYZn7J1Wq8ZYZ7qGZeFXg5cv9GD3lQFHWdGYEa+mWyahdx9FEN5MUGRiSbsw+mjX/+WM1NpjgWK1/2rmX681DmekCxLijvgKF+Xj3SicUxEY4ESprQWy1gFbUASdBBGlXqHFXFN9nor+CgBbOh5gQ9e73eWiNl7sTc3P3QJDYVtGedYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOZj6pwWHwKWCqyRyVYE9JL7z0OJ3OpDfKv6p3/PPdE=;
 b=SJ+RTVUHCskxO60LHp1BKQ0O/lrrveoBVMqD4rkutIJeFH5BXyy55lJAXFxWiKv58I29f/+pvxceK8BlmCirH8NVCNHqVGuRvxeCaXV7ewmJqAE9zQpni+xHvPO3qLe5bSFwg1dqbDIQDJ3l9XUQA3diEbKNXeplBS4PqhZqNa5pydjJHKfgfzhAZZyJ2D72+woctG/d4QozhhdStDl8Edsq5Qv95Tsrr5YvJikGPTP5s2XQ4s0bi3BeWL0MVdvYtinvu2tZr2YOspq4K3xngidrOu3ho4MmyRDPplwr/m8R9QEwkblDtjDj/vw1YYOBV8JW7x1cmEV+4PqQB9J+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOZj6pwWHwKWCqyRyVYE9JL7z0OJ3OpDfKv6p3/PPdE=;
 b=vHJ9WJoUf2oznrR+WjpNDn0O1fpHG8gsk4Vth/gi3otD79Hv1OxDN/FpoMDKdDuemaBECefWAcWVkhyEaUpTK9pLC5IPA02yMWO8q48UBCcUCQEJa+oj+jRl/4VFW+56O3MH/aonUwDEZwAEtIEzWNiB4TqjPHbyzx864lgFB+k=
Received: from BLAPR03CA0167.namprd03.prod.outlook.com (2603:10b6:208:32f::23)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 06:42:38 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:32f::4) by BLAPR03CA0167.outlook.office365.com
 (2603:10b6:208:32f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 06:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 06:42:38 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 01:42:37 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Subject: [PATCH 8/8] drm/admgpu: Add support for ATHUB 3.4.2
Date: Thu, 28 May 2026 06:42:06 +0000
Message-ID: <20260528064206.12358-8-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7dd1b0-ee52-4844-27d5-08debc844f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0EdIv6fa61z2HuTfZh/j+qP4y/p4G2mBGszLIhd2YZL0RwCQae0dezWh/oc+MGpzcLZKHNoQp33qQM6sLl+NZ85KVGD1wrglXfkDEbhKTogDmQHpmEAZEGzXbNPaoKHWPGL4mUXDSAXS2NYn8GDxW17HH9heHKhQNUjwoOKkTz+N7lC6389HoUbYSm95KHwLdabJyZ9WFa2CeXH00hndk0ObthxkoFEq1qjIiEWFvWgBhlO6zR5MsxdbeMDJqmiylWg8f+ddof7uE5swYANYHyFHDw+fR9XrooStSdNO2/k2rqolwT5vPQSUprOdg3buPQDekvVqa2vJmoh1VbjB9tfDMReN9z3yRDk8bSAbzApzQwbbd/wjx1VT2jeWcWAlMHoADopj+s2j/AiDJWupxAehj8H/VN5MWE0PpKlT7pyDKbji3rfuvrVgzrTx/gNPGiTFtdoxQ0QoGya7BBKCXwMIsbrZY5aguoLA5Z/b4jE4hpNZwCUOba9mTMImhfkAUlP4b4TahwP3LWqzthsKuKMj24AGK+izJKw8Aqr70zLISNAenauKWVQd81JOcFZ6Mcc5oTAt3TGhqsmZ3Gst8zxn2oud+lbwNs16mcYZya/9PYgcUwAy5rzqQGAIXGzu60a0BkD7ILjeK8oghmx3AcWzxz9egSEdIK8zHDWXg1ZMikn/lhtjGlieBO49V2PDDEftpmgplWqOrelXzF3+A1u5T7iErO5waDrBJUz270s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yXWEtb7N96exNzpY2ztTP1xelb6R1ql9b4CPq4oqZjxRKBKpE7QUjvyi9WqBNDQ+6ZSg5ZJR1ejKGF9h1mPswDhtCeANpi3yC2+aD6cPNWZU1G2sdIp/D6jgANQgHl0C3VbLv4HL2ElgfzIka2Lbi45kVmjSf8zMMVQDRFSkKmDfK+VRJtThRjGn58yaSgS61EI1rS1RZmFxmhjZkhr7NdM56Y9HGP/1ZeQG8BMbD6GcyP0tP9+jUV5HVGn0FpvdRzHZh7tmRPLIoi2w+hRSkw3gxb+VauWPAW1yKGow83vCAuuAp0VovQmiGJLcJN+Npx6v9F7oyN/e+U/JboH9Zt9zuR62FXiPWJ/r7FDBURVb97shkNR5LvlkiaPhRf/5ekEGg4drvNF4+s+meoC1+PolWfYBmRV/viPYV8wqdM47vSTQEjjN3+6+ZPjD7S+B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:42:38.8844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7dd1b0-ee52-4844-27d5-08debc844f89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
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

From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>

Add ATHUB 3_4_2

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
index d1bba9c64e16..b42d9876e0a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
@@ -43,6 +43,7 @@ static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_device *adev)
 		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1);
 		break;
 	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 4, 2):
 		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0);
 		break;
 	default:
@@ -59,6 +60,7 @@ static void athub_v3_0_set_cg_cntl(struct amdgpu_device *adev, uint32_t data)
 		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1, data);
 		break;
 	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 4, 2):
 		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0, data);
 		break;
 	default:
@@ -112,6 +114,7 @@ int athub_v3_0_set_clockgating(struct amdgpu_device *adev,
 	case IP_VERSION(3, 0, 1):
 	case IP_VERSION(3, 0, 2):
 	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 4, 2):
 		athub_v3_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		athub_v3_0_update_medium_grain_light_sleep(adev,
-- 
2.43.0

