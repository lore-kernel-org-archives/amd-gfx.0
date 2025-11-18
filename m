Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E390CED24D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 09:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C0C010E458;
	Tue, 18 Nov 2025 09:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dBEiVO+U";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4A510E458
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 09:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXu4Jq7C/ibczJhXyunBGdsmvWngXO+MVlsYaCnl/oEgreApdILMAWOfRgEx5tQ5VvXGb0mIZnHsCVPf7BoU0JDSfgxwDk7ordxF2rJdYFdlZmZMN4ajc+fWHlDEhoydhFY8Kem2yOcs02qW7Ihy2u707b4cw1uyBol+jpllvUzJxc6G4sFB/qsj3jXeOKWv8kdNFxuxZNzh0x8cdWfsdVVOrWjIu7jDbH1M84WoG7L04nB4Vq1fCdUIs1CXjlBhSb6T5E0urZCd/sNEk4kvewFWUs/vrw2nI9rFAta8z6rf7wlA6gn8kqIB3vpI15a+ZDivH2hWQgHjhRsuNORDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7aVzUOUyjMu3DpQWw21VPPme9Os8P0aG3uvhID7q9I=;
 b=j6/hlXSh+7kISVbWIuprKA15fEpgpSRzPI2T1pXko5ZxGD/pNJjlr6YwJ67mTdKTSSfqD0x4Eb7r6sG+cquQtB+R7q5DyIlrY99X15T8KbSMMaGbUlB73Paw/fkfguXEZX5iQMGf9/VO663RrloAoZXG0IPOiSRqjgv6SGUfG/FMT1aQmtLj4/5+QOsVdik6RpVWTsG3Sab6Hzln0g91+Hl117YT7FQIvREC1AfC4oGK3vT1zJvYTG0+izdaq/9MMOcPRi9nO/lhe0sQ+LuJy5Q2AFFVN8xg8Tiha7z2vnZUbgourFyKzrsJrznwsvllk9F6j+xFiy7ALjARGb1tlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7aVzUOUyjMu3DpQWw21VPPme9Os8P0aG3uvhID7q9I=;
 b=dBEiVO+UUpkD625+AZ7q4zml81mXtN6aJzgVo+oSwSH+Pqr0ZUJV4gfeoR2pnZ5e9L9AVMjWAWweNnn9jwphdsoUPw6Vj5VSkD2WFywkoz14GhTDOjwEQHDoVWbDSeGfD3uSoe3rsjEXwBxIN6JFEXF6eomQuw11dXkFhiJHPn4=
Received: from BL1PR13CA0383.namprd13.prod.outlook.com (2603:10b6:208:2c0::28)
 by SA5PPFE494AA682.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 09:17:11 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::6d) by BL1PR13CA0383.outlook.office365.com
 (2603:10b6:208:2c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 09:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 09:17:10 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 01:17:08 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 7/7] drm/amd/ras: Support sriov uniras to obtain cper data
Date: Tue, 18 Nov 2025 17:15:59 +0800
Message-ID: <20251118091559.959683-7-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118091559.959683-1-YiPeng.Chai@amd.com>
References: <20251118091559.959683-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SA5PPFE494AA682:EE_
X-MS-Office365-Filtering-Correlation-Id: b12fa825-3667-4015-d7f9-08de268340f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bosM29thSQ/H8/7w1S/7Jux+BXDakDjpS9qDDGBO/nz1Hq28VK2Dg47nceIS?=
 =?us-ascii?Q?LXZaPghcSYT/MdgXqi7DRZUd51mq6qc52iOvGh6Pc2AvSv+vSVTZ3m7E+yba?=
 =?us-ascii?Q?iVg6TZOSW1iVbh5ySlW+iuKB4i1xYkYZAHPz3qkTu12GfomZUkkHdI9zGsfZ?=
 =?us-ascii?Q?YsthchZmSYs5IKNEIc5Eub3P3KdVLSUqecfYN48rpt4m/S4WKDl+DCg+G3ga?=
 =?us-ascii?Q?DWGdLOg2dVfHtStWvebc1+xB20NJlcotgEE5DfsPr7mBQtVHZf7ev7u9eZZX?=
 =?us-ascii?Q?+moip16Ythguxubgzivd9VoRZJKsLZyp13Tb0nEd42QpAuvP5L+W6Dc5rtQe?=
 =?us-ascii?Q?ylfOG0HsiaQgRoc8QUzYa0Lz01EjTYReWrCcl1mf6anngpoDPvRFwRqgHm5i?=
 =?us-ascii?Q?tpbmRR292i9XRk/nuv7lWy/nbrKsHomLKbPAD+XFyptxUzblBogYT9FNG2yT?=
 =?us-ascii?Q?NFjFCB3VUCSQdeLZLpmYFPglsRIPjbYjNNAL1/t9nfn+MrccZ89M4pHjR4gz?=
 =?us-ascii?Q?wz30nuunzJ5amEwZGDXvXgDJbWgIrT+rgt/yJudbqAB61YRgh0FquYvS5n5K?=
 =?us-ascii?Q?/YNUJN1OmvqlHbzRSMOd/BrN9ZCzEPXSaX+ht33XlY50cXWdV1eb07CYEXON?=
 =?us-ascii?Q?5mfJNpbMXi7w0zUsA+ZUQsp5Yx8oQyt9r/vSblBGfs5Wtu2j8NYq58PMTZg9?=
 =?us-ascii?Q?OmzqC+SgYr003fovChCoYyGqFc6kPa0iEHT4EwQFYZ6IF4m96cgTuoO7jnRq?=
 =?us-ascii?Q?dj43e52Fhj2naTHV5O87EJMHOnWnyaBLRRG8fRzbvxSUlpeat8cez0cfxrR4?=
 =?us-ascii?Q?K33aBoR/MHXGAD5FxZMQnjqz3mOJmfeaJiU0KLYPeqXHD0L1gl2d53kj5B+t?=
 =?us-ascii?Q?Gr9qMSXwD/kRQXrQIe3HXIgShdApKocX1jraztFBgecepKATumr/7IHDM51M?=
 =?us-ascii?Q?a3GPwLDGF3DhNntPiZSDoh5Wmi/2GqiNsrMyHiMRdnkZmn3DgLN962h2XAWM?=
 =?us-ascii?Q?yPhsV5S0jfRo07ZjOO2Kn1zopAwvGe6uAykdmTKRxA4WtDZ67vzJ1J19SObk?=
 =?us-ascii?Q?r63CEPin9DecdY0bxrRD/KIyFA44ufxa/SiQurs9FbnAS8NNp65igccgo5VO?=
 =?us-ascii?Q?9qrhaRpkHoJhpc78Eub1D6QHhBaPLu4YJ8dKQuiRmq1mVMe5AyVZInPnJWw4?=
 =?us-ascii?Q?rhyXIY9hhHFAXbmSyEW85XYqH+Do+Y42kSNdMygD1RVtVF6xLC9fc0r5eOAQ?=
 =?us-ascii?Q?76TNMunaFSG8r4oqo29XImu9zBI5dFyuXL6B1nAp16LxE2uGKJWldleqq3dw?=
 =?us-ascii?Q?Fna7np0buGZLS+TuD0xy5EzzF47m1WCv5H3/GFIRb3FwzVlDKcz3bfA1LpLA?=
 =?us-ascii?Q?oSeMzPwVFZkOcTwFMKAO6fU63hGSCkKUawiHR0qtGEq6annT7cpQ6zVKM0d1?=
 =?us-ascii?Q?JAKHylkDV6nSL8BA9UG/zu4ExF6IBVx3oA+uSwjTzBUYeVvxPskh8je1W1PN?=
 =?us-ascii?Q?n/15XA74zk8Bx8Zjkt6eD2b7fj+kuELJ3nhmfeOPUQir1tba4lY1u12a6qQ0?=
 =?us-ascii?Q?pNkatWGVJw3Db904rqI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:17:10.4973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12fa825-3667-4015-d7f9-08de268340f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE494AA682
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

Support sriov uniras to obtain cper data.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 425a3e564360..90e6e89b1fe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -23,6 +23,7 @@
  */
 #include <linux/list.h>
 #include "amdgpu.h"
+#include "amdgpu_ras_mgr.h"
 
 static const guid_t MCE			= CPER_NOTIFY_MCE;
 static const guid_t CMC			= CPER_NOTIFY_CMC;
@@ -559,7 +560,9 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (!amdgpu_aca_is_enabled(adev) && !amdgpu_sriov_ras_cper_en(adev))
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_cper_en(adev))
+		return 0;
+	else if (!amdgpu_uniras_enabled(adev) && !amdgpu_aca_is_enabled(adev))
 		return 0;
 
 	r = amdgpu_cper_ring_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 860ac1f9e35d..deead462a72f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3320,8 +3320,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	amdgpu_fru_get_product_info(adev);
 
-	if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_ras_cper_en(adev))
-		r = amdgpu_cper_init(adev);
+	r = amdgpu_cper_init(adev);
 
 init_failed:
 
-- 
2.34.1

