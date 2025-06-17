Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA595C7115B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660B110E562;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BRj6OiIx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC91A10E562
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTdQIa4JWeW+18Nt2WzFc4RY11HmYh4ZB1PDyRjoTKFULr/JZjPmT/ApXa1AQSCjnBXO6TygquMkzLlLzmWSKOfHId/kticZu8zWLvVud1eVVSMt6T/LWHxQY6ANxSmACUtouORDkcXk6v/RBAEDcp5VgalvjHh7fBh6LmAzR6uNuRFBzCJ1aAlH/YioG8mDMxzJPmr1tmMygcTC9zo9L25oWB9eaJKXDB2gj8cVa6CTymHDdELoXFc5TrlvYZvP/dz0ngrd/PvEyyKO19E2tHIvvKHiVTMrF1jVfZQdogumN1732/CC954o/Aobd+BqjyCJfrAcCmOP3uC85dRa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkTEIgN47MxgTLRkuzo9/XccMTOQDYykGWdM+YnA7m8=;
 b=uhLhrGzpSe3FhE4HvpFf9XmASaNaKXjTtL30iysHwna+etZQX7FDdbdDwZr+uIkKMx9GIBDPINZuWrTCW7GCtV+9aNSOfviytcKyROQDq3xjIjTJ9zQ9BzeXXR5p/jtwWoomTJwgvehBwYE5m0lJOeOSh3xSncY6amKVCqlkgoz7kgVQzCcRJXVgApE3nfTu0EC2fhSgbIXT0eTL+MF9xdXO+X71NPRekTCo45lAh+MMW5Nn3AWzLx3+cWjzIJ8W8x95K7ecMyrEcDPujraxJ54Cf0ezG3rytOg3S0QOdbxVdFfqqNVWUsJstVcZubcUB121KNa1+aulC2e5rUIzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkTEIgN47MxgTLRkuzo9/XccMTOQDYykGWdM+YnA7m8=;
 b=BRj6OiIxX9N16Rx7I/OhAzDnaHVMX00INKRQPOgr0TDy1dyCTzo1AP2lU6FSgdkWMTRNtAQMUYOD1rT4V4qR5dCfWaIIPHfbeHHa+NRzjmWafOpleRyX08M0tNxmMqJUAvbEnVmeuU5vtsuurALjbIBMRH5pwoQYgTjSOr6ifjk=
Received: from BYAPR11CA0052.namprd11.prod.outlook.com (2603:10b6:a03:80::29)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 08:02:28 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::cc) by BYAPR11CA0052.outlook.office365.com
 (2603:10b6:a03:80::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 17 Jun 2025 08:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 08:02:27 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 03:02:25 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 10/11] drm/amdgpu: only bound the eviction fence to userq bo
Date: Tue, 17 Jun 2025 16:01:50 +0800
Message-ID: <20250617080151.1093481-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617080151.1093481-1-Prike.Liang@amd.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7e000d-f72c-45c4-46af-08ddad754d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TFk0cwSGLlgfvmWyaMpkSbegTITze2D0doATKw0C4/UdGHBVdsdLhPLs8LBm?=
 =?us-ascii?Q?iMPHDGF+tJD8PxCnqyLZqNo8fYvXKEDfzEa6H8x0xHHzszLIzd3O3HhC2xbl?=
 =?us-ascii?Q?7LjXLtyEaXgUmJyq+sRCRbr1KBnDo++PHcaS+YwohpRR73TNwGsT8PRQuWQo?=
 =?us-ascii?Q?Hy2l/fL7A1em+nYgsnnDskbt65ulrTOBi3T/EtZYyimBVzzOm5X/KJ2tJ0rb?=
 =?us-ascii?Q?Cvgxw7ALiNdsbZsVoxI2tS2QDwcF/X3U2R3gqqRwuFBmGddrBVJnQhSzP9f0?=
 =?us-ascii?Q?yrqgDNDoU+krtZdqTkQfKiC6MH7vmNsHjyOHsoA7NgiCSDSkpIne4rExbdOg?=
 =?us-ascii?Q?UdmlvuQBzrx+NE9olPm0q+3lXOAG7f1V4ZQO3n89LQKfeL/wRgSmkwuDNfs4?=
 =?us-ascii?Q?D8oezyPqERAoV/Y8/XgL+k0GU+fu/QL/0YwcIcdDcMKIHKZUkVaQwgID/aUE?=
 =?us-ascii?Q?3YPaXA93xMdxe1GK5Hy7TdwUvbTHrMpndFICegJBp6WGoYKhydqd9cHVXg7x?=
 =?us-ascii?Q?o4YvT4csKO6HQBBXSXfuMtTAJcP47iHOEsED8EmfyAxkqPUB2KDkKdaI7UXH?=
 =?us-ascii?Q?MTfeY79UuEufLUPztEbWnlJ4EIC81QyIMMpbaBZCg8w53Y7szrQLPGlqfYoU?=
 =?us-ascii?Q?7u3Udy2uBYeXoDPv/EZnmniQUIfZ+AixWvQG4m8yANusJd95jYmw5XsenmCx?=
 =?us-ascii?Q?7d/osUIqunurbXDMfs8VwYL1tYCMPODEouKDiNFokuIHiByGMvfENDrkAt57?=
 =?us-ascii?Q?ij+zDlwWV8BT3pGlOmUi/yWtLnCDY6zsg+i8oNN89xuFk/xJtFbWa7lh2IMl?=
 =?us-ascii?Q?D9nsdRuKa0GyxhZJ8964PL6/q270+NCrsBfiPq+tsiW8yZFjOKt5y7+gXK6F?=
 =?us-ascii?Q?mzPPHGdV+EHX8CnQ4fG7d/oqy9lQpt+1oxE2J+bTWoMyURx4Q2piKR0azA8m?=
 =?us-ascii?Q?hDOTNzCTTsadzwvihWDSEkEQLxz6uJKdtkIQPE93R5C3H4eM2r53Sj93ei56?=
 =?us-ascii?Q?rj2Uxfj5+TGFoolHAU8uGkxgwCI9Ikdra2SNZSODtnoEdqYOSyqDJhNkG22u?=
 =?us-ascii?Q?zwtDt0f0LAu0H3V5Xj2jT/PGKsYEygt5bhtd/rWObpAcGtqYYX3yZfXh9dgY?=
 =?us-ascii?Q?ypzD2OG329IrBgQ/q/yxTi1MqlZ2PEmKKQ3t0+A7n8exMAU/AxGGZKpOUiqx?=
 =?us-ascii?Q?lpVzfPRyDA96aNcMpW3dzMpF2C/liREd3XKFkONS0EmMNvD7x9nx7bYIfiIp?=
 =?us-ascii?Q?oM/+ASNbrFZDnob8QuaRlRqijRdslljTtvjH/b0jaE/8w1Nxa715KY1Bsket?=
 =?us-ascii?Q?1jZjP/rhYkXi//iAElY7FihgD+HmjcwtolQKxMso+Gjx227wz89iFa0ijayJ?=
 =?us-ascii?Q?ejH3UsdPPWfFlbY5mqseC5jIlyMHv67FKTuBNdynLIhMwfXszBHn+WkODNzU?=
 =?us-ascii?Q?9mqxuNLrXRZMs2+QX/Y1VecyqZYMMUFarMiHubOgonry0+iPE7v4qIHfqc0H?=
 =?us-ascii?Q?oyIjcFws1naYwcatVxG4wNxeYfmXg479FPDs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:02:27.4243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7e000d-f72c-45c4-46af-08ddad754d44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
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

It doesn't need to attach the invalid eviction fence
to non-userq's BOs.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2c68118fe9fd..50356aa23a99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -294,12 +294,14 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	else
 		++bo_va->ref_count;
 
-	/* attach gfx eviction fence */
-	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
-	if (r) {
-		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
-		amdgpu_bo_unreserve(abo);
-		return r;
+	/* attach gfx eviction fence when userq created*/
+	if (vm->is_userq_context) {
+		r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
+		if (r) {
+			DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
+			amdgpu_bo_unreserve(abo);
+			return r;
+		}
 	}
 
 	amdgpu_bo_unreserve(abo);
@@ -365,7 +367,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 			goto out_unlock;
 	}
 
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
+	if (!amdgpu_vm_is_bo_always_valid(vm, bo) && vm->is_compute_context)
 		amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
 
 	bo_va = amdgpu_vm_bo_find(vm, bo);
-- 
2.34.1

