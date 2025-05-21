Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EA7C54EDA
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CFD10E75F;
	Wed, 21 May 2025 20:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s8NX1H3H";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A72010E72A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozKszeX97FRRUyrrpsCFB9msMRoNSY82FyEbjz5C5gV3ivR10ixNqSMoR17Qj4SbBAQ4ufPuIcuwCcRQVC6sZw3a0ymeSjfskkOW9r7TuClnihlp7jdFEZbp1QJOYrVoz8XjOB/OEIvl6JD9xvOmDoSuKlTe6NWU+nTT9aLnfv4HPTNejGGnoSwjdmnLWyemTcQlYL8zkw9+X9y37NQft8s8j2td0RsTKrjrk5hzhKvNwYdgNK+YUtaaB07HAYFYLd9NnPYvlF8lGmNbZKlvLESeU3c2DfAy84PSXAwUcpoLQt75z16SShjTZzOsitmi2Lc5YDFmb+40S06tfWVWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPYKnwsVomcMoWMwOYpiRLGaUP+CmAotqaNUYQa78P8=;
 b=nYW2HHkeQiXUHFfmqerd47WQFf8k9/5/rrKcBNldGQ/nRlZY+RfG0EN47sFiYg7WlCAEKfhC8CEWp62FBo4dNZmK7eCJiAKsx90kH0QDQ/o84W94ZybUu9u8d8c5bqyz6pZdPGX9KNM7syZXWCwDiIItcCUwtkAanG98zKTbWLaBW+qW1hB/6nNCno5K3kpNUbHWwOgCGmr+88+ASIKz+m2gNV8MXBT9/hyT9cRm2CMOrb3sx6nbHO/Tyg77tpyl6OjKkln3Ar5DSKTOyma8lnzGkUdbzg3zo7xt225IV7bLgUKOmH6qjJU4iMi2ZLxInP7AIDG8U5QM3ElIXy8J6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPYKnwsVomcMoWMwOYpiRLGaUP+CmAotqaNUYQa78P8=;
 b=s8NX1H3HMA5wEX1oDuhNVVDK4eKSyCoMPEJ2wneXO77FMcvPpwd2bnhj4b1ZB++M7kgAuc+s9aXQK9RQX8crwvUVc95Q5pemw4P0vO2KP1IHy7RslCHugR5K+R4QSMNf1isus1tvxSo1bdgRlqJDdFED8ywbZPY7suB6dGbYN7M=
Received: from SA9PR03CA0007.namprd03.prod.outlook.com (2603:10b6:806:20::12)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 20:24:33 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::4e) by SA9PR03CA0007.outlook.office365.com
 (2603:10b6:806:20::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 20:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:24:33 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 May 2025 15:24:30 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v3 9/9] drm/amdgpu: read back register after written
Date: Wed, 21 May 2025 16:24:14 -0400
Message-ID: <20250521202414.18251-9-David.Wu3@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd5f2fd-9cda-4cc4-51b4-08dd98a57f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HpXeUUG0Tky62AFU4oOxKwufqGDRxSJswSQWoQddYyG5KhG7UtemaD3lLX/+?=
 =?us-ascii?Q?lEEz9/EJp45cFQmUwuU3mbqFzBXassMkJk4A3N3J0dHVwfK4vIomVOtjXSb/?=
 =?us-ascii?Q?mjZxZFWQc3C7bkhYFRin/leqiHVrFoz5DPvx5W6+AL9Bi/i4nW3w7UziW9RI?=
 =?us-ascii?Q?33WcGPrNSPeReoNy/q5OfgEBB9/s4G7TY2J8r9/OqSCUume827voKFxJDoA1?=
 =?us-ascii?Q?D577u3xPqDYzCnmer8XfvG1UnLXTZ4JKxx5VtgOai+PR6IYRtloFY2KqYDDd?=
 =?us-ascii?Q?VIdLqdt3sNgfcGZLode8jHcZFcdeuDRuJzakeZZM6C+DRVC8fUAoGiIf7d1f?=
 =?us-ascii?Q?E+jmsoN4mGisJxT55+bzWa+9ar3UxDnpFYWLNaDdTZRB5K6JarroxOksscbq?=
 =?us-ascii?Q?K7hPPxpkmHFhOB8sEUurQX3FSAgneSTnt//JbqluRSyAWeV+pSL7pR0Qak1j?=
 =?us-ascii?Q?j8DQQ/8bBigZvZARMHbLKWf292KMJcD0RTw6+dhpvd5C/N9PoBroAzLoog2Y?=
 =?us-ascii?Q?qEbdvglgGlhDBTL5oxAZRlh+OFFzjuG2eY+4oXBKihaP3hs7YOyseAMGTTee?=
 =?us-ascii?Q?hq8KtVmRGq3H58b3sOJA1KnYjlBo+fcX9u953OKVWaK0H7HPO1/McjloWRsd?=
 =?us-ascii?Q?4n5uiPdTU29cGE8No8r/HwO58ACpBWBcucLcQndIODmpqMHGQmaJHAOYc5Mt?=
 =?us-ascii?Q?/VH9g0vU+Yt9FEn1z99ikiqeD9AdzAoMWdY0h4eb70zzbZjsXNqWqgMsKmGV?=
 =?us-ascii?Q?npHc2UTyeA0N1iBsPoyqWE9ICWQWTPrMVp4aj55zY1KlCAjmreoQ3wPeAcLW?=
 =?us-ascii?Q?9ydqZCjRrPLQuXRxygzTN5/knbdbyAlmM6tBdebnvvKQhtmMNVo3Vkh5LWZD?=
 =?us-ascii?Q?v4PZr7WkmcjG23wz7BSl6VywsDh4WU8eWaaAcWAoh17mD6X4IC0oJYspzXP+?=
 =?us-ascii?Q?uoIMUlE/cbVYeVe9Q2ByhOY+MS9X54YMC+vIfc0Ta7pxQUBPAUMz6Scp1Rkd?=
 =?us-ascii?Q?iWkW56aD+IaS9JEeUSsGFwqcEfcHgZ0+OiZQDO3f1G+zFEMJekP3OrpVZY0U?=
 =?us-ascii?Q?B9lcuQHGERODCyf4X62YAxcHZL6NhpaJAhbBynEUyG0A+p5pXCHKy94OudBe?=
 =?us-ascii?Q?XxFoTsysQNvuggsXQicyRRK4RwHzcW+HkP6+NKGDXwD0vItpMFUCWFdttnRM?=
 =?us-ascii?Q?79XdCj9tfL82JPUbtnL0c2akxrW5QYD8jT11XPqjDcOgyHVpJGIVSKejNuoI?=
 =?us-ascii?Q?A0EiPrjtck7S1wICRLq3h9xqVQu9Yc9EhogoGTP95SyYFuNN1kxRIHEB7VPc?=
 =?us-ascii?Q?z2c6hsSnh/QkRaQJJwGec3Oscj2s2bZB1eFfv6IGmrcVSNX1/s9pLntbOmf8?=
 =?us-ascii?Q?jujZXjOa+iKokEOjChTbN/Hb9ErTUY0CIN9T+zX3iHlnFSTbb/SOKgsAhN6m?=
 =?us-ascii?Q?FGR5JSk5uagLjI4y2szC//qJ7Esmi37EvLOtRo0LVqdPm4/7AdNT3sJRqDU9?=
 =?us-ascii?Q?3OcP+5eEEYMjsQ2OexWZn6JKZswDpIe3suoH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:24:33.3589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd5f2fd-9cda-4cc4-51b4-08dd98a57f9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
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

The addition of register read-back in VCN v5.0.1 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 1e9d2aedf2799..338cf43c45fe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1038,6 +1038,11 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -1072,6 +1077,11 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
 }
 
 /**
@@ -1147,6 +1157,11 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
 	/* clear status */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
-- 
2.34.1

