Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C91C54E90
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC12B10E743;
	Wed, 21 May 2025 20:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BEzYIHRk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB0110E72A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RP9C5biuQYK9+HrxpTLTThY8cSQTSiiNRcbWA5npC18NMAhOj1/pPXBqd61FKvFQ1p5VMzelnl6qly92WO9/mF5i79F7u3vSbg8aSAQ8LaTC2AkZzknhaDJfJUtiWfqWpyARut2lHWubNcnHbxukVZrl6stwYv84EwF9ZtUnrDPmBk1hGLQlEGGZqQkU0/hF6k3hokaj8IQyKkHKCPQywkN5SthMddl4foQDeSilLXBBE0kR3qHAoD+d/U+yxNYwI4xEP8FUOQjruJaIfCwmMR/kyxpW0e3pBzpFRp72bAeU2QdpASqiom9ehDsS6AEFtQGB5ZNKbIvE9jIPtU+qbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyOi2CzkSrR4Pzlk+TXEqigpahnzU3hrliTMOpkCX88=;
 b=q8EjXkziwzl5z9F9d9jnDAD/vIn1RixHrBRu8rNeVtjFOJ5sz/2bO2hMrr/5C7g+CJQ+Gqcs1L2ehWeqtjGQTK5w30pIYbmR3Pw+RSuczv/Cn2MVubfz7YyrQaX7UQenpa4Hqtw6JcN1rutyLWepNEUVuCJblOztJ4JK5jn0g0U7vPxfJVRTDx4zyFcDt4xp5mkJhYsJU4ASKPqpNyj3EYSXaRtX0Y0GtKLoYJZ14IQMWmZYpSWMh41P9G0WTFQdizgRXaivZArexg2bMoGZ3EAGaEHZGoMaKQeoKdIU3QWpGT878HPqUx3CgGAcl2TqxeHqQ0T6AQdv6aSsOFwYxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyOi2CzkSrR4Pzlk+TXEqigpahnzU3hrliTMOpkCX88=;
 b=BEzYIHRkdAtkN3lpXd+4RQ0lqnuLQADHtKCJ2NMQplszSfcT7Ri5Lwm6v2FRV8tBNQeyZ2TIJAkcOjIym+lKNFUW0x1SKzb33P1ohmj5NO6hu0/0inFUHM03PBPgHYZ2WDyFlC6ds3UmTizv0Zg99C4VqnOD+5ZOwi88Ncip3e0=
Received: from SA9PR03CA0011.namprd03.prod.outlook.com (2603:10b6:806:20::16)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 20:24:32 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::8c) by SA9PR03CA0011.outlook.office365.com
 (2603:10b6:806:20::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 20:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:24:31 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 May 2025 15:24:29 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v3 6/9] drm/amdgpu: read back register after written
Date: Wed, 21 May 2025 16:24:11 -0400
Message-ID: <20250521202414.18251-6-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521202414.18251-1-David.Wu3@amd.com>
References: <20250521202414.18251-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: bff6b96a-52a1-47ce-37f6-08dd98a57ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DyDuMURfIM/IhE3+sEggUglln//Ow2KYxIFr3WU6bOWecTtlVA2RY87be1bh?=
 =?us-ascii?Q?HxWq7VcDmqMCFPDJ1pHCITa2H5/ytwlKOQ6Gq9dboUEOInED65Hx0ZI8dY80?=
 =?us-ascii?Q?8oLcfmm5Gh4+FWdtrm7jTIYtdr0J8mNo4F/rsF/02znb3wyMt0pJ8BBjZ0ac?=
 =?us-ascii?Q?UW5PsHM0wYmSedrnRN0tihu8eNk3YXXLm+nqO8s8l+9Z/2bUEihCtiydCGO2?=
 =?us-ascii?Q?28JH9q6iTeWtrMuciINZgh6IdFPqygmy6csmGv7WHMeJbsJM2IYEfC81QdIX?=
 =?us-ascii?Q?6wlVcrwtadfT+Noq+9uOXG0yxk75Nhyd4htZfIyvo4fqo/OIMmcpR6QaPT1K?=
 =?us-ascii?Q?F6AxftDiFtse7e90yRAT90++LTZ9KxhmZV3xkfgeDBc7HPZwlohZO7Byb5G8?=
 =?us-ascii?Q?UwlELjoNettdunw5OEGHhJ4eaRvDTSSmGQXoM3oeyihyly0qKunrojIWnzjH?=
 =?us-ascii?Q?N+GzuL8pP5jN08dj20TM7as4m269IR6b8fwlL1WXuiHeEqy+VXUO+Hs+wDhc?=
 =?us-ascii?Q?xOF+GtmlVyxIketxA3n26xUajVwFt97SZs1nUiKlDefSALHPBWzlw0SC38Uc?=
 =?us-ascii?Q?4Rx2Pim+p1nr7ghFLgKax0Hf9HsLl2iNqC4eJB0nEjI0hgIptFhmSm3AOf00?=
 =?us-ascii?Q?hGW59AE+VcPqoS7VkfRsRoJvkj6PWgUs10cZCFguHwludTbbHd5WwHdAlrWD?=
 =?us-ascii?Q?eb9Swpie9aGb9IfoUnpdAQ/+EsIkufzevMH9pGgJw8s6snVNjLqcoz1lji0r?=
 =?us-ascii?Q?fL4kKcKKbVbdntZ5Evrl7cQUXZOt18+K+frir1zr3CpuSUhcglZ5tsFfi0PE?=
 =?us-ascii?Q?0vzvFFk8CC7C+ZzJwZUVpdvlj1iuIp0xIJdmvwcAQaJ0DDuXnSR6k3jd8K7C?=
 =?us-ascii?Q?FgGeqyxp8su6T43Xe3ujPSOtpSxD4NyXHsUWc3J40iZzsAaRhiTAKOwnq72h?=
 =?us-ascii?Q?E1LP1GhkwYcn5FBSE8wUETqjtaSD6CRU7flW8L9L5zpPBhWteMIbPvFIWct2?=
 =?us-ascii?Q?v2rJ5te5KKDFGQT2DyIAdpWnyY5G+iD16jKnFCNMhz3gbFFXyDWovP6EeLIY?=
 =?us-ascii?Q?nymtq3E1eu2btYOb1opXDXCCW6wf40xc7z6Q+ctOF8/M4loAguy2ZGZuvUA4?=
 =?us-ascii?Q?OqD8NmUvwNU4R/nZf97DUzPV3jF5lteOkA72FXNYisoc/bUGG31OHuG0w0nk?=
 =?us-ascii?Q?wdQZYJ4LzwYp4/66qJ0tACX5zTl1ndqVCO77z3k4s5ryrLkv1HgxcWXrd8H8?=
 =?us-ascii?Q?WBBW27EIQ2caZ9amU3WnN1sXMu8zuDk/tCwulnANcKbV1eVDP+RIdUCIuW+y?=
 =?us-ascii?Q?o1wvBYjcVfL7DUHZ0AJXYg+dLYZncmognaB+A6yyYQfzzZ4VwLmig+/TVOSn?=
 =?us-ascii?Q?XLTXITcGhQR9zedKjis0Xi9bZKYMKABCC9A45R9DGFerYAw9VZqx9sYJlvH3?=
 =?us-ascii?Q?tfZGHbhbwBKWkapw01AkP7Q8JNDdFcBhvPGxtMYK8DlrkYPAjJvGap8bDdNP?=
 =?us-ascii?Q?QSKPFJ6MRFH5GxbdUJCuFEdNGAUjCv3k4PfH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:24:31.9439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff6b96a-52a1-47ce-37f6-08dd98a57ec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
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

The addition of register read-back in VCN v4.0.3 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 764b3ff09f1ee..5a33140f57235 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -977,6 +977,11 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	/*resetting done, fw can check RB ring */
 	fw_shared->sq.queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -1370,6 +1375,12 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
 		 ~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -1453,6 +1464,11 @@ static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
 	/* apply HW clock gating */
 	vcn_v4_0_3_enable_clock_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 Done:
 	return 0;
 }
-- 
2.34.1

