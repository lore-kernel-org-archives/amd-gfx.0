Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4025C54754
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 16:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3461A10E916;
	Thu, 15 May 2025 16:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VWLH+o+2";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D8910E910
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 16:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0JcTmgfNivrNa60hCddEiKECiNAnYfVt5l4gOQCzdrKlX6W5pCOxz6vYMyk8OeRkNhfhO81MgnrH6oFHIg5riz2eYQMnlYPAecbFTH5B9wC6NWICSahzTXE+O2wKPDOSEgnzUTYuwzyv7VfY7MOZINsIYjzxr3c5zeHo8nMS9xQY+2gXQAM2qWXoEOHCDYQdw2eKie1g0+BVuhTIlLVmd5KWbF8x4SkfGclLCJ/ait+bp7uYrzXliD5SfeO7lAnYCth9F0B8ISkj84nR6JwNmcHlu34shqEqViuAnF7tFHGkkndRptKcnn92YqGh4BiwSo3ON4H0i1LPN95c9l67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=je8dr+YL0XGP0mMDP0Asi5SaVAL5UuTcQnlFBO1L2aI=;
 b=ahSTBkpfHyoUKoijXTVkce3PL1oWywSDu0ifFH+h/OEcyW/uarVvKRj54HRPdP9Wg+G5ENBt1Gn5C8iE9mJ92sgk8td0jOFqeOqeC7KMoMO5horZqJuPbhXdxZhRYNwEhcuw2YFXAS+xTC1tBLXWvRMrPzqgHOOYhscCHwWpkoJ0NmdZTJVu0mZArQS89WhEkxwtqGPmbpxwU40/UFeiIdtZMAA6iWKQwJjzdgFUok74yFDnLZM3fdlWknmqbLZAt1s7L+keKW19VEFwPnb/1ghyOqCNAOROCL5Gu2SekdtkkD7SaHqOrI+Yy0+7/t65T1dYul2A7MwHDxQbODvaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je8dr+YL0XGP0mMDP0Asi5SaVAL5UuTcQnlFBO1L2aI=;
 b=VWLH+o+2bQLUeOCx5txSGCuzo3PZsDhsq05Eu6LMPtf3S3nhYZLZ8BneFJN6eZHZ5RXib/Ji8VhhlWKVYoEMpX3anJXeG6zWjMJqlmVUOuEWgCyYqhdXo12/eNePCyMdByMVQ4zmk+fknVlQY7ShKsUUXPMTEOoUUQXL0CQUgZ0=
Received: from MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 16:41:21 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::f2) by MN2PR07CA0029.outlook.office365.com
 (2603:10b6:208:1a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.18 via Frontend Transport; Thu,
 15 May 2025 16:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:41:21 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 May 2025 11:41:20 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v2 8/9] drm/amdgpu: read back register after written
Date: Thu, 15 May 2025 12:41:01 -0400
Message-ID: <20250515164102.808954-8-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515164102.808954-1-David.Wu3@amd.com>
References: <20250515164102.808954-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d51848e-f85e-4eb5-55d2-08dd93cf52cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nCPq3oVAL9Vx1qDuFbITBZGLhzSuAimYjoiVNXcORm+ojZw5PKP37pc6kKv3?=
 =?us-ascii?Q?APJvY1uc5lMzIBo8MqLaYj+fiEsxf3waslECOe75a4qdBT/wUEJAy149u5TD?=
 =?us-ascii?Q?8v99lM34WOXwLTi16IyaLCP9tsMGljzCO0JQLy62JPZaxGtSGnBon6uPEUUe?=
 =?us-ascii?Q?/PSSMZ+zZHSCWw7xldUTPCPzBIUz3nODzRMHz54d/0oZ9+cJ7OQc0IrqgJ2k?=
 =?us-ascii?Q?JrMxi0kt+Tls9X7HMnOQITaLJ6fM4AbUG52flalyh1OGeMfBWQV0bMnas6OY?=
 =?us-ascii?Q?FdN432dbFS9gzx2w2Pj3FNZsYEyPvvB8Yk7hkk/Hhu5uTttwEeVxdkBm/Q8g?=
 =?us-ascii?Q?Nza9Wmnes2aJSjM3H7CPlORQ+D6HKs0u0LjmjxuYRP85Te+ZzvIQ8NA8DGqP?=
 =?us-ascii?Q?O+R9j62ZInO1Nmhc+4yId/LIKnjCm/9FCgdKK91JF0j2zK5u+xNwSc/T2vul?=
 =?us-ascii?Q?pCb+5Hfx1ngcKXx8C1EJt7LfgbaAESmR3xKf/9UNZ6kEh/4wQhFFDLUP2a3A?=
 =?us-ascii?Q?HDlqe7QI2lssPceRPZiBM6xsFDJ4iDCDvHbtmzpaXrQH6xqARW8gK5ZZ6D37?=
 =?us-ascii?Q?1AH7Tl6SAAx2tmweKDu7/9gLRK8LqvJZXwqw9STerbrXHPBRuXL58Gu3dHFU?=
 =?us-ascii?Q?SkmYLFOa7d4ahI1bEF/fcpmn3aTwNPMaviM0zsuJQrkKg8uapGCKquaNmbTe?=
 =?us-ascii?Q?ZWtbXuPSzxTn46xy0MKhzyUc38QEXRY8EI1DyhUsz/5J2pCxb706Tj5UsrPv?=
 =?us-ascii?Q?UMgKDQ4QyMGWAYHWQFQP16sq1lFvEhm7ge0WCs/dJ35V2wHk6ywxuStf8KZG?=
 =?us-ascii?Q?xOcTsAovmw/uGLsvvQPl0rfh2KD7ZyGXehcq8YqTOvPMIYLw0nneeXZkAl/v?=
 =?us-ascii?Q?QnNVxTbY72BSF1i76y8RmgpCDF0PL4s/ozaftVpQFH9hYLfRA6UVBiBii1e9?=
 =?us-ascii?Q?uxFndEMu/nYeQZ9dZ6mwK300ufMu6jbhR/LNxzyTjbwjYwG7RyU5Jnp9FlXz?=
 =?us-ascii?Q?lTyDXfQheI1wLmKuIEelL1VWEZ9wrvPkbUSDvRd0XiOVjOmZcqBztf3r2YWN?=
 =?us-ascii?Q?zDj4j34RXMfphe2vRrzqgfoRE+vBqw5Xr4OgCsFbHwjWiMqjFBpg1aQZtFKH?=
 =?us-ascii?Q?s1mUMua8+zKwm4wLJ3iEfHjFni/iN+8x2sDqKAgNEVaPDztZxW8hu+bLoIOC?=
 =?us-ascii?Q?LfhsSB+gYUSgOyj481cm7m/LM+3Hgd0FxkQEJ19fPyCfYKWUSQ/AmXyjbI3x?=
 =?us-ascii?Q?di0LLz+bv5idfue2Ii5aWdgZ1Sxq88CYNHooF/TE+rMO0xtNgxtqNAzJP6RL?=
 =?us-ascii?Q?vHvw4T0tm2sDDbRjgDzoFcq23IcwRA+CAZ2R63+Eb27ax82Kr2aQcLHANBoV?=
 =?us-ascii?Q?KjfhSdZV8Y4RbuGz0YfxiIbdXwJuJEFWo44PqLCkSsWjiBrLCWmGYITL7KJr?=
 =?us-ascii?Q?hyQ6x0oGn+Yl06t3fPx/rtZrLTXvmXICs3cwYm4uPbWti2ZmYJqs+Gh3VKxP?=
 =?us-ascii?Q?Z5qQfQhSUaTfsqHbEvMPHR8ZLAaMiyyXnTl0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:41:21.2690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d51848e-f85e-4eb5-55d2-08dd93cf52cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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

The addition of register read-back in VCN v5.0.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 27dcc6f37a73..f8e3f0b882da 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -794,6 +794,11 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -946,6 +951,11 @@ static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -977,6 +987,11 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
+
 	return;
 }
 
@@ -1058,6 +1073,11 @@ static int vcn_v5_0_0_stop(struct amdgpu_vcn_inst *vinst)
 	/* enable VCN power gating */
 	vcn_v5_0_0_enable_static_power_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_STATUS);
+
 done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
-- 
2.49.0

