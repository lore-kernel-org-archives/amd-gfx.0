Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AA91073CA6
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 12:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C05210E44B;
	Wed,  8 Apr 2026 12:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wf3CQjSu";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6102110E431
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 12:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1rDP1F0UKtz7OUtYyMzRWQsC76rdmL2QxAIbWSuFJTTQJxtownm2p/0IuJ9m4B1Ok2QrZ0qzGb7t6W4TLuWgxOhCI1MVWF4sTk1KSR0HySomypGT/7ygZOa95Ht/bV+KgTcNPUCsDZllzqjhZYRCKb2LKAj5ggngCDXUETyV8Vji/VX3E+Q44NCgYEbH1+jgDejkg8Ukr02122tr4IKwjTy75G9HOrrHG7AkAKcFONp2wjUElFL0IoEOf0N+9LJw43crPfMPXidV/wU4jEMzxOYmI0TpipjGzVHAR30HIrCEG1VFP9tsNkTjQwasSBHBx9tCeWrSOpcXMbD4LeQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOKvtwfTzChrq6LA/RV9OTpwZQ/mO3JjelFtNOHJhMY=;
 b=CzCdKoZaZkODaPHBeUBdU+eJS5v/AAEAui4dl55j6Qv12DLScQdVg4puc8xPkgwiERtWkfeUahwKlrbKzZmQ+s+8S1cfpITzKBMRIFBGVSQW/WuqtBeVUeaMIk/11KNgbw9XPPC41vFkCsLW5p853bx1pc6pAJD+UZke2+I3tVDqtfvT8YaGqgPgo9M6e6+C9ZBORZMc3x0t4Imo7oguC9e/dkAlZD/r3OuHTNxz6gOoDq4jFNdTdsIWytBCrTAZz9/Shtu9Oi0B3222UtH5zz++1a3COLOBnsDgsjoUBObnwmoou1rBOyJlq9coy/mNrO3uP+FqVBb/8rKlDH5Psg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOKvtwfTzChrq6LA/RV9OTpwZQ/mO3JjelFtNOHJhMY=;
 b=Wf3CQjSuCoa9/Ou+HkZGIZVSYUmPd0eTAFNI0xvEQpfpy0MxIGDhKCXvAP+2clq5KDw5Z5BVMbC99J+ROfLymJ7Vr4XA4y5JgktaNHLNKOyg/oFHylmvk2Hs3wzcKWQPozWqreKxwu8/pC2aDtBRBiXhi0rdNu1iRTmfmm4OJDM=
Received: from BL1PR13CA0203.namprd13.prod.outlook.com (2603:10b6:208:2be::28)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 12:25:13 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::63) by BL1PR13CA0203.outlook.office365.com
 (2603:10b6:208:2be::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 12:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 12:25:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 07:25:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 07:25:13 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 07:25:12 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu/vcn4.0.5: Remove unused define
Date: Wed, 8 Apr 2026 08:24:55 -0400
Message-ID: <20260408122456.1787039-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408122456.1787039-1-benjamin.cheng@amd.com>
References: <20260408122456.1787039-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cdd3c7-a709-4d0e-7e38-08de9569e263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: otK91it4YsukZQaHtBwpAPXXVOVW7QTcOsBPyN7btKW3+4YWXQMKyIWaYZ/CKiOZUEMkWb/Ey8uLK1TmCHGciouJ0RD6iJYRbXpiJOAIlppRgz7Nop4Tjkk9McyIppVwU/vih5rAx2UghdLfhUfqkXHl73PqSRPAZAp9x+LqSsiQ6LpxMSJa5DB2osCgJkcKlbXBSxWWILyKobbxUPbPe22RrJaclUUukjq6nge3/tUFrQxSPrRtiMnYtJKW0q7UM50AjYesut3yv5J8KAmGdASVkYaR0XN+0QOZV0Qkk/vZDdkBRsliV9RCmE7eDmiZyWkhGVqJqtoqaCpMIkXjxPrItSZUoXQVbeRjS3z7fJY2D0c0hphxJwMtwl/5VNQ78NBHkgxd/58CdXegl6SsHh9l6HS+ZukpcxwTOmEGVboxx70hfcE90nSzUGOkGQT4uCkO8IEIhGyh62UA+V14rqiendFdMp+W8d5+7JOZYB0YefK0mYnCckTrbhVDPSBI4gwa95cMhwPBuBxBgRCHAlEPSO9gBQOtgXzCSm1afz5pCfNjpZGex7YeEnqK0kHsiOF2AelD6zyHwyWBTjFl6fUsdEG9ZlzTbzjSthxA3HakBd2vuh45hSSToqUvwabNV/3napyYcbXhlEBOkC4kFFbocVzDCd8mrTXNpWVNjg0ObA62VYuw/RPl6xwcIl+WRtzACV3oFXspKIgrxgYi+CnPKKvzEa7WclqUpfgVL7FDipSUmpXvhn7veqnqRTYOn+0pAgsuWgMdXcakcqoZpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tNQd9Ev9o/5OoABBUtEeLxAXl7l5NcgspK9jsd+oJ133HPdQF5FYl1Txze314TnyI6Zv3dMWhSRsrqQMUJSnwIX06uDu9PSZoOFhfsE7SqxItg4J4PbP1jOl7O3Y1hduGwiruCzPIoHmNB04dB1IfwAv/VEPvBoxOenCmzyHT7b+v+R/RKdEGp/iEAp68aQAntsz2Mxf3SmjhD9Xl5VU4QItF3w8UULbKnO7WpVN82OE2Mz16SyY+Czj4l9aCFm7ZlHrM8je9xHGqIu9HGF9QVjGBY86ZkWB7SgFEjWgc90yhO7hOZfJMQnsSMadydkCMw1xI8nLEwDD7N4lSE0HacUGYO9tDq21KdKCmVqTWLk1txGUSgvdBblzzaVDMGBa+OCjJq3guUOhW2GYBFm/vNg7Xcllaj0jdSYadwDhWUHhWUxN7Lmmqi3olLgfX9jj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:25:13.5038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cdd3c7-a709-4d0e-7e38-08de9569e263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423
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

As part of the previous cleanup, this was noticed to never be used.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index cbbc02d68695..a204a0f5c44d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -48,8 +48,6 @@
 #define VCN1_VID_SOC_ADDRESS_3_0					(0x48300 + 0x38000)
 #define VCN1_AON_SOC_ADDRESS_3_0					(0x48000 + 0x38000)
 
-#define VCN_HARVEST_MMSCH							0
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_5[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
-- 
2.53.0

