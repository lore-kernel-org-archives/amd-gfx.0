Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ACAC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 19:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE3BB11A85F;
	Thu, 25 Apr 2024 19:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YmPxPSYi";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D6611A85F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 19:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVLZ9Mh6oUZgx9nHM/FRbCzpmW/Tq+8xoD/czNpVtrr3HLMJ308FJOBrcFTny0N3YBIA5BevysEsA3gk5g6weqT0kuQhCxCfSPdx8x/Zcv7yeVTFO6iVJEWGFgnloBz01I4ma6LscIfvqarC7PmePqsiOwo3Yn8tZZ4zE/R6Nf722zYn3r/ispO/qwBzqqhy6qTygJ3OmaqUcQFI8PDHLS9LWGgMBNgR5QVgutxRr0HwlygLHUEpX/nMUfkHLJ9MimyksYxZTnaNS/xt7x9+CWT65Ed91n7xWw+9M0KoML5vjsYxCWM0hN1mBOk/dpNdW4odQULFIkBXRK2TTHRcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyMm9e19kqdsqARRKOH7EEUrC4C0d+aMzetmdn9e60E=;
 b=EF7CZK/NuVYtZDZGdjSjQrQnMqbvn0495mUJsTIZv5QClxSNQCZr7ipAy1UT+FynrnOJTVeSSgIKQlDLRRmoAHp6B/ABY90tBUP2h+9J3DcvjVBvS3GtnI2MLjmpyzyRZWh3zzm6aLFYScrKZWuGa04WWFhyLJOdjPBYWg92Y51im98MoSO+aXMYZMbyUVvBMxNay+qFr83gNgrlYkoerkF5D4aZ8TYrt0hik5TtJ4JDyZgLXlLTuI0aUmiWA/ESC/qqPatte8m1KXnyODmI3jzM48mfNWFimlZ7SxkkVmvJ07rm2mdu2f8Qs5SL/zfWcV01kwK6yPtRFXNezFnW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyMm9e19kqdsqARRKOH7EEUrC4C0d+aMzetmdn9e60E=;
 b=YmPxPSYidxwwE3cX66UTnPagvqTi0x1qfuMs3+CyToH3iyb6pjPDMi0Sa3vzofwvQlxxQvbAvx3ODpSTfy7AmyeMF8XPx6sPUzO2hW89afShPvx3hJeMT14RnLy8/9T6WfARLJGeIZ/fU+c1rHriOwIa3R9+j4PmquJXDVoAvMg=
Received: from CH2PR14CA0042.namprd14.prod.outlook.com (2603:10b6:610:56::22)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Thu, 25 Apr 2024 19:59:09 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::ca) by CH2PR14CA0042.outlook.office365.com
 (2603:10b6:610:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Thu, 25 Apr 2024 19:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 19:59:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 14:59:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Set pte_is_pte flag in gmc v12 gart
Date: Thu, 25 Apr 2024 15:58:47 -0400
Message-ID: <20240425195849.2787543-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425195849.2787543-1-alexander.deucher@amd.com>
References: <20240425195849.2787543-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8ff9bb-54ad-44b5-a70e-08dc65622b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R7lqf0uBcZGJQFeXqHpEcSxSbezfshNLT4SE8P++xFpnA3kt1Op/S43mnYwg?=
 =?us-ascii?Q?GC4onicUVUafpluUETLS1K/5UeI63ye04vApPr/ydbXiF1sVdzLkHpwvdwrj?=
 =?us-ascii?Q?+roJCn0BD6FSujx5kwcHDlkL7wGabmR0H5nbQK/+4zP4uQnkUf2RT+jdN7eV?=
 =?us-ascii?Q?H51/501/QkX0USnU6eLv23z8snXMBu9MWTPsEuuMwk2rnkIEZjX3+SBFnSpe?=
 =?us-ascii?Q?hAUk9RwEJzZ7lhCpity9VUo4n0rKk1dPzVnLuxjGSMGkCxO9C8Gcwi1S+2iB?=
 =?us-ascii?Q?znBmB4+98irRb5YdRmOZmjj0H7xx8RGlziQDJ/XOgOOskPwdXsq6pKW8icgz?=
 =?us-ascii?Q?48qUMMtSlimz19H9xfJG4/StY7MDTJJ2VSXxJQVJq+JKplDOaLh04O2xeLGc?=
 =?us-ascii?Q?PiC04zfDVXCtLfF12W8rVCGCgQOH/IsldSupxsqa86uRSbdlcsAq+X/6tDDb?=
 =?us-ascii?Q?L7W8gSMEPGwsE4uzCACrVYcGYckaKBxd5/5y4hnnlyPpN1CUElepKl2vORiJ?=
 =?us-ascii?Q?QfKxnt2yv4TwesSaC+AgfZLDcNVl022eSu6QZIkLYsfrb1/i1gokcBsGwwRZ?=
 =?us-ascii?Q?RlMfQY9pYEBrGLcidDLo2j/hgVXh29oL5HQdqqtraxXnckXtu1yy1fQXArXS?=
 =?us-ascii?Q?53Ky9x9KK/1Y75jFyv5XgPu80+Fdx0VO5JYSRVTSbB5X9pjHcMlazpmH8e/4?=
 =?us-ascii?Q?Jkq/87p+V5Gh3OvJiQ7Ht3EsQ6QzZTyY/1rbjB61dleBh9hf4Tg4jPvOhqvw?=
 =?us-ascii?Q?01IPKegZIBZLN75yedMBORA3seotikFC3BS36Mof3bujfEsCX6rrPkL7iUSl?=
 =?us-ascii?Q?vMje98TZ5ExGCXlqIG8SdTQhVoJybfyMZSXqirboV1sXs+ovQX+Ao42YzQ/E?=
 =?us-ascii?Q?k/14ti1juQeXzPnhplvk/w1zLAZfraZjqmLqb6Hr4bK0x5JQyxKYjtCoClzk?=
 =?us-ascii?Q?DWCDxlEJDaKRUkhy5K1ML3rhkLUq6YIgbzxuBhG8LcnFakKdDlGfi2okmIBZ?=
 =?us-ascii?Q?Uh6Spzj/L6QlYTZwbNxGa7hOGoH/hcnw9XP9BYCiaPlOYoEOy7MI3q2ldNCz?=
 =?us-ascii?Q?/DZSS5ZJ+lZl/yZATS4iq6ZCYUpiBRE1wnjLx3IMEczP70Y26scRgLnrAT2z?=
 =?us-ascii?Q?nwVpbEGyXu2iCyZMjySZQg9JHaY8eK4Rep6OOI5fcuux1/ECjw3vLNMMsAz5?=
 =?us-ascii?Q?11w0gX8rofl+iJLuNaxW7s3MzExtE8/fEA/P6tL5rcRDNtQYlQK+VtKBsPNX?=
 =?us-ascii?Q?cCo8BiSXLtta4sW82Q9mFbToXHFM/uTBruZctYWaHKQd+Fj/avY7j1XUD4XE?=
 =?us-ascii?Q?IB0dUwQ64myS9hg31hrHWnxwNRB4pndSXnofXZmyQgc8qxRp3YvLeVAmkYZ+?=
 =?us-ascii?Q?91ALcUZnoD9NMoN2tx+H+6slo1J9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 19:59:09.0430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8ff9bb-54ad-44b5-a70e-08dc65622b86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

pte_is_pte is new flag introduced in gmc v12 that
needs to be set by default for pte.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index c85ebc8360e1..c24f5bd3e09c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -686,7 +686,8 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
 
 	adev->gart.table_size = adev->gart.num_gpu_pages * 8;
 	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC) |
-				 AMDGPU_PTE_EXECUTABLE;
+				    AMDGPU_PTE_EXECUTABLE |
+				    AMDGPU_PTE_IS_PTE;
 
 	return amdgpu_gart_table_vram_alloc(adev);
 }
-- 
2.44.0

