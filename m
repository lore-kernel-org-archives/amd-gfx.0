Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62796C021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00FF010EAF0;
	Fri, 21 Feb 2025 16:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0mjNPhBt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C762E10EAE8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oELfxnTwmtr4VVtjnYjdbxIjgtckzP8mL6PPzHSKKtvruPKBPQx/b04Ik8X13Iwd7n3wSkcUa/+AwbEWFPluJGTP+Z5XWbpt5dT3dK/n96zdCv0A3PunW1tXfZ4DpLZ1xFqQQHYAytgbs9Do+hoTbo/fKzBCcfWoTMH46uX4CFyo1RqU2XeYGsaJY386cY7aqSg5TQLRGM0xhzR86T/jw+MRkQW7EmBX4vNASjXYvPh8DdubfH2mz0pPF/A3A5wJYIFlW+/Vw7pU3FBaCFAe0NlOR5nHn3GVZ88EaoR5DwY5KoX+NkKBOPK32tRC11jLx09cwKfX2C6nFSkNUzjN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eht7EQxm1ovJhSKyQZnGFANPfStWiRSenM+LXBCcRPI=;
 b=Dxsvr1ycgniDVdAnEbCT0fWzHfhAHeGMcmYCNaLCMfKa7aLP3W5ebQ+IFZ9/kSju9cHv43ebRYLXROQnHFvK6AGW5BXIgPfn2pM5JX1wl4qT+ywB6sP0yPCP2KmCFt2PE/jFURAg9B47ezg7AI8txDDcIsVNTPk9wKpX1D1BFzaMXMpDTuaGMVsTF22+4fpJJiq5SA5yRxZqfo6WWirSH7hP6k+yWCRYwBFxyjvzSkJYFVzQ4GBwc0RBPPugVbF9lfLUD8tvvTOsF4n+V2P2v+809Hh3ZBbFWXvuAdALYGjFhmQ9PgVwf2W6SkJQcWBHj1zpoPrtJqeIw2HMor+1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eht7EQxm1ovJhSKyQZnGFANPfStWiRSenM+LXBCcRPI=;
 b=0mjNPhBtAcyI4JwEWDZ2AY0jJRrhdAMRQwLIG1yqHPmLUO0WNKMsBvnuwyGYfRm7K/aAGmD91Pkr+pkJsAp3kfg9nuTd21icJ1W6r5WhSFVjD2KttuLXkxLdKumHtB9H5X499/K/iq2Rmz5MPwcDI/7ePYE6apYILsKsmuo1ijQ=
Received: from PH7PR17CA0056.namprd17.prod.outlook.com (2603:10b6:510:325::17)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:02:42 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::a0) by PH7PR17CA0056.outlook.office365.com
 (2603:10b6:510:325::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 16:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:40 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:29 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 22/24] drm/amd/display: Fix HPD after gpu reset
Date: Fri, 21 Feb 2025 11:01:43 -0500
Message-ID: <20250221160145.1730752-23-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f34ec1-8bd7-4f47-4dc9-08dd52912b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?veAL3RdqAwxt5pjK0XrwKvOg08kHNf6mpStVfnkwwGEJxg/U8cdbYleAyEYK?=
 =?us-ascii?Q?JB+pWuBJNw4fCIcdCMV9S93iGL2AOpCQ4lpFflw0U90jZYxzrUCTZ1OnDb8W?=
 =?us-ascii?Q?hFCjI+njEbGprIq0p83bu530EIgPZmygkCgb80CwmoSEjEyP6qsL9Vhe0rjR?=
 =?us-ascii?Q?3WYJI0fknYCppFd9l0LUOY0vzkz984qqLUoFXi/qWTYJiwqzabQ3R74429o4?=
 =?us-ascii?Q?OXAl/bORrmmr/Pr8gPtyDh9ZKIxWuYKrrCI9PgWd0WfzwvBBuQNx6CoY5hxx?=
 =?us-ascii?Q?av+e3gWds4mxp8u1eQliKrSdK3K5q2KbHsi1/C4vvgR1QCtYaon4j992X+cm?=
 =?us-ascii?Q?55rua/L1JM7XhlWfc3gjQq9C4b0wTkEgoEK+xm6fP//d6s8Yzc/5h1aaSIim?=
 =?us-ascii?Q?Pf6QQFq+2qyy9pbPo0POWgA7Sq8ZLOFSa/0r27MK7r5y5kjCG0oWLKkJ5Ki3?=
 =?us-ascii?Q?T6Y6Qpd3Q3ulAzaLXZYHkG+tLTZZaqv2aaRfqMmRNOHFVtsusgB512raMzyl?=
 =?us-ascii?Q?HfZQlMreETDEpk6Z6iIQ6C9GNoTrBFUNCHSnhQDeVJ3w01zoO1P9oG2EB1mZ?=
 =?us-ascii?Q?odr2PfbzCcwVjZcnytbJq1/tklgfEZ1uhCwCr/djY4IKI8cKNur9ZaTAsAsj?=
 =?us-ascii?Q?Mjk2EG9bspkkemas6RpLAuOX8ADvbRnh4n3pmWxxZy6krx6UWBXDXfHonGFl?=
 =?us-ascii?Q?FZW7Vk5MaPaHKZez9LstQJoUOvr6A9y7fT6shK6Ljo9nFB1Rq1cEjI1MBRG4?=
 =?us-ascii?Q?SXMwT+W7AMcHUO0EUHYDWQ8XMS5L71575GlO7Q6gFSFJRbbstMSGv6i3cuYR?=
 =?us-ascii?Q?pThrfSMP3F47rO6rxbF8cP5uPT0idCa+fjwIq8LRR3vv7/FfySnJ3VOzQTg9?=
 =?us-ascii?Q?xdm9I/CYBI3pvdwVmyEcjU8eo9/A1dNnaAAykTxigXBh/l/7AxF8xFVBQ0At?=
 =?us-ascii?Q?Wkgf+3avBMz0TxhF7WkbzhabCw2jKbVTSMHnrJLI6cJkMmjW69XQ84HFvU+R?=
 =?us-ascii?Q?JNjio2St9PN87JtVnsdSXE75jqH27ZlusZOFFeUfcbA3XGTB3V1z7Ynx17IC?=
 =?us-ascii?Q?CffziWh41dlx4FHGJv4yJED+5aAkM9j5l2A0ASuvF0OmUt8WXlriyUUNl1pt?=
 =?us-ascii?Q?ucy+HmY2sRmdvfp55Ge4cAuViAJwCIOnyO1hLpdOk2g3t3JYk+pH7NjgRFWH?=
 =?us-ascii?Q?4HRBezUKHYP/XBPFrFkyxGPlnZd9M3GlsIiSKapTN8kLQoZqRAWfAcCLCT6i?=
 =?us-ascii?Q?kqmSRxTpvgluvEj8ODLr1aza9E2r+vi/92KWpZcR83rrfjxBdpdpue4Jzmw5?=
 =?us-ascii?Q?oX7MZKFf0abIFpgmjAL7eJX5wQLotdVnaNguiCCg7Heg5efWorHxdyOBu9Dd?=
 =?us-ascii?Q?rDGNekDO6+BlfMOSov38R+SqcbomRnBM946Y/Rb4E/7txkILGwbXTi950740?=
 =?us-ascii?Q?cCs1LS9v5nLq7wHVNzgwv1ZXQJQxuq5VdwtugB5/uJfRSPu5bl1lUfA5CNhE?=
 =?us-ascii?Q?h6tePzw5JJT/pE0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:40.1473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f34ec1-8bd7-4f47-4dc9-08dd52912b21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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

From: Roman Li <Roman.Li@amd.com>

[Why]
DC is not using amdgpu_irq_get/put to manage the HPD interrupt refcounts.
So when amdgpu_irq_gpu_reset_resume_helper() reprograms all of the IRQs,
HPD gets disabled.

[How]
Use amdgpu_irq_get/put() for HPD init/fini in DM in order to sync refcounts

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 3390f0d8420a..c4a7fd453e5f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -894,6 +894,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	int i;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -920,6 +921,12 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	/* Update reference counts for HPDs */
+	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
+		if (amdgpu_irq_get(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
+			drm_err(dev, "DM_IRQ: Failed get HPD for source=%d)!\n", i);
+	}
 }
 
 /**
@@ -935,6 +942,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	int i;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -960,4 +968,10 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	/* Update reference counts for HPDs */
+	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
+		if (amdgpu_irq_put(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
+			drm_err(dev, "DM_IRQ: Failed put HPD for source=%d!\n", i);
+	}
 }
-- 
2.34.1

