Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B8FC19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B781810FF24;
	Mon, 29 Apr 2024 14:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rY53Q9LA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E806A10FEEF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCKX6Nz4ahrcN+4UPtyfD9br3B+L1DS1RQINdGsqcQzBNdqxYe++V7Y2wMvGGBzTT63hZm/P/WSPvhN+exK/lReqGVTXhQWtOC5OZtX03ebRuzbMUnJD5e3F5lrmM9ECIcED/dk0kWw9SgDbUUdiOCOTwXogs4j2dqPgh0WXJo/HwDyRhA/TPv4vU0HRo+aCQCQiMydaL6OZgQk4VTB7lv5TkEjaatL+uKcQbIUL13AHJClFRrcxPu5PWojNO3t69jYAqmTcCg6+NpQPvIyqDw+XcfoInzXD9MB1/69HxAi8pUeFrb8S2qOzyKx+XE5N9a3SI7Xu8pAhJC0TcckDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xOaPcYPDrdZtrsbWcmaFnXjiB/lt2JlEW6TwMPwiLs=;
 b=kBfscayeGwghDG52Pvyvp9icGhmeiekT/JH2Ze+f4vlDJebfQbOoNE+AUyFZiC+fjqh3LIaASlFKhs3lFkbhUqIHN6y+uu+tpOaJgoSwloDTAv8Bsls9zVyP0w8FmkkFam9CWMB407TuR2PH3TGrj/BXcyaXnnxD/Z6+J/oOLkH/7hc3iDX1DUIsjZwm+2aGnqd2/+nSLICWlro5+CZ06fVe64YvHevd113jFyyX/SehjGdmzSFXNYtyacQDsnBNfH4WiOojChlYjjdhgz5Dfcqcg1k6GWiicBqOQlYa7Enr19FipQItEOyUm03IfzL/wxDYSzGZwxM34FbUhjhAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xOaPcYPDrdZtrsbWcmaFnXjiB/lt2JlEW6TwMPwiLs=;
 b=rY53Q9LAD5IP5L3TfjhnMpU1Rq3D0EleSg3NFB9qhMXjqwexTpHp4iBlPX5C2s8edwrAL8mwSdtyGTSCi0A35nMcy7HGWynNMAA0sHFr3Vw0bksCh/5Js4yIzkBZVQt7QcjQ4MJq08tU7ha501ZY4M7ukLgzdB/kgk/paWU77QA=
Received: from BY5PR13CA0011.namprd13.prod.outlook.com (2603:10b6:a03:180::24)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:57:58 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::4a) by BY5PR13CA0011.outlook.office365.com
 (2603:10b6:a03:180::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.23 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sreekant Somasekharan <sreekant.somasekharan@amd.com>, Joe Greathouse
 <joseph.greathouse@amd.com>, David Belanger <david.belanger@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/14] drm/amdkfd: mark GFX12 system and peer GPU memory
 mappings as MTYPE_NC
Date: Mon, 29 Apr 2024 10:57:26 -0400
Message-ID: <20240429145726.3459450-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: d114b2c0-499b-4152-ab65-08dc685cc230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m+u96lNnq9T6xM3AezjZEkHrPYhy96AF7hjtoesOS4J+oW5vE9BRSLYxSVO5?=
 =?us-ascii?Q?MlRuHmzaJwWXsA84CSKWLkh3CVbYamX6FCjYQXGdWXUU/GS1tyhPFveEz0bR?=
 =?us-ascii?Q?5TVWyLYIYQiPEYJAbA/0aaE98wDJiH0p+ldcYm1r6rihbCpzm4kzR+fVLgSH?=
 =?us-ascii?Q?5Gy2jfwrCm5W6PVnaJzzDP84YAAR9c8+Wl1LvtNF4QXIIaBT+SDgxmRKoOEq?=
 =?us-ascii?Q?OewuvjKh9kowdYRnIjGDREcnh7odjL29Im/F32W7hzo5Xbi5T1A6uTgkt+F1?=
 =?us-ascii?Q?wvJePvWR1wCI3gauQ9dJJP/5jHreM82OC8j+3Is/ekIlYauyTLjpZ+oyFDwI?=
 =?us-ascii?Q?FzMLk9taoDwKz6/MzgI623LPW+o7V5MCAkJqLQYNcsRfS56/hjF/REMOwb2t?=
 =?us-ascii?Q?QzzamVoy0NAbMtyOnLSBLsY1Lhv6vK9SbeqbTJ6GDx7MprqxLHbo5vOroSPu?=
 =?us-ascii?Q?nO5l38jQiW6QKog+c3T2tYBrz4+mS1f6ccY0JsQl25sSeK3gwUOJb38Fjk1L?=
 =?us-ascii?Q?hQPAHyWX0Y8wcF1ckYRe+Svwb6+/oqhBBKF/XbSkWSXFKgCd62g9A9qq0L6I?=
 =?us-ascii?Q?rH4ZQ6Ztu1JrYkUJ416RacYw7UOCycOz2hdoEF2bD+/etD6ke+r+6nn9ib+9?=
 =?us-ascii?Q?BrnBSFOC1fZN1Q2NuEiltej53L1EYVy9x2Ngz9y4Luj9dt/awqv/1ItDhr7c?=
 =?us-ascii?Q?5H/pVlwcGsdDNp/7l0M9HJ/jd5qelObp4EyBHtmYpHmcLoV7ZthA1AQgIh3j?=
 =?us-ascii?Q?irmmElCidWCv9nPdbD/rN9k8uDSwpfgS3z0CH085xUD/vPolLwhwpYQNnJYz?=
 =?us-ascii?Q?SQoPS0dSIeYCd3D4lp9FFfHKvayKjkRcGTZemQJYbLSeUZu4qNniTXP03RZo?=
 =?us-ascii?Q?dEGbQg9BMrAKveV+3fELITJWLJFIqEyCq7XNfsYpiBcW5eRzXUwFDjtNNgun?=
 =?us-ascii?Q?KsCTpnddwoTBcLx/r4odUYawRly+JtfY/KQVhEhDA5CCV26UlgdAFw8JVRMi?=
 =?us-ascii?Q?4Y+ud4vf5PI42I2+zSPbu54+YYxmhrFRAE92a2glZy3Ox8wzPknyyWIfcrZ7?=
 =?us-ascii?Q?RnICerSeElvm8E7yQK+juDo2eVngqiDSQxmw0Fl7iRh9w2x1JZIJSkybQLcQ?=
 =?us-ascii?Q?Ech55vWjzIL2c2+5Ov2PHxGLhwcxRXnShuCc29iO0HaO6fkLVVSqsrwSfLqX?=
 =?us-ascii?Q?hL3Zl1+LrqjI64OPwgJJzUv7ymBAnu3E30fmgbD36qBh2+nvL7WSOYApnaCn?=
 =?us-ascii?Q?s81w1T5Ci2P7PtWA6Zm59rLjIKm0tmlf5/Sd4n9xj2ucSfeOHBNfxwDuTnhW?=
 =?us-ascii?Q?IAkPJqinp2XPljrd4VF1nD3L6Z8+xOe561OuhQNHi7hhYiKt+yMAsFscIkVU?=
 =?us-ascii?Q?fOUFNcq49czerZJBZZtSr20//VKX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:58.1829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d114b2c0-499b-4152-ab65-08dc685cc230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
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

From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>

Due to a HW bug, the system memory mappings and peer GPU mappings
on GFX12 need to be marked as MTYPE_NC.

Cc: Joe Greathouse <joseph.greathouse@amd.com>
Cc: David Belanger <david.belanger@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 9 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index c24f5bd3e09ce..3e6676fdc1875 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -497,6 +497,10 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 				 uint64_t *flags)
 {
 	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
+	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
+	bool is_system = bo->tbo.resource->mem_type == TTM_PL_SYSTEM;
+
 
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
@@ -515,6 +519,11 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
 			 AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
+
+	/* WA for HW bug */
+	if ((bo && is_system) || ((bo_adev != adev) && coherent))
+		*flags |= AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
+
 }
 
 static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fc5ede17f7c22..db90795e6245a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1248,6 +1248,15 @@ svm_range_get_pte_flags(struct kfd_node *node,
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		}
 		break;
+	case IP_VERSION(12, 0, 0):
+		if (domain == SVM_RANGE_VRAM_DOMAIN) {
+			if (bo_node != node)
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+		} else {
+			mapping_flags |= coherent ?
+				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		}
+		break;
 	default:
 		mapping_flags |= coherent ?
 			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
-- 
2.44.0

