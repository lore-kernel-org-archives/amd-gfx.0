Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E09EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A66A112B10;
	Mon, 22 Apr 2024 13:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i+B4c5Ik";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2BD5112B10
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtjyzL4bmG4bamvEM6mPcxOx7+vq3pLZDUFDjWre1PgFIbaCOO3AB1MJiN9i3qKEQrAjUg4JJIbopbx7nbkbyWVLs5WHmIyE6Hh6D1KjABSK4xBHrVhlgZkv0a34JTisjmaldbE5z8cghFGBpGmgP52sPoOS5Xns6jYaBDvV1QwLsrHe/UjceNgw4bJOEIFI3S94OdLkU4+w8noSZE91O63h9vBazTW/kLVJw/x12OmissQvcEfIYIT+BSsg83GOock6mGwAwyWNLZeuQqhvhoRYlWb2urg38G/TIjd9b/4JX8ovqnE2w4HQN8A8s4aS2iYGn5WcmWvYZ8NqZp17fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNyivYZjs+d0o4kKHOMxxaDoAsYg4wV6QpeEhW+6eXM=;
 b=R4MA8SuPwonLqYjVx1QQae+3zx9tEyzFujOwy2CHT32IKvbF7/mWOPAPcEL3qPW3AItmbi4wP0gu0AkpgXNKrQnXXofYZyQZND96khyC0WHrAzL/Scsy+vvIgGVKc173/sWYcJtj7blUfjl2wd8Hv/UNjxeH1estB1BoaKI2gVSWB2Z4lznptkRJeu5Yg9wiNdzzjC7Iqz0hrAld1Xk+9ex2OwQfAgALS8qGM7+O7+llTLBMIfqENmsLOIru4jzb21pBdUb8Ni8UR7sPBtCt6Phz2onoiImVpM07LLfivyR62LQVW+SeiZb8jlMLm3ktVbxgKC4YTmWeLLzBgZ54Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNyivYZjs+d0o4kKHOMxxaDoAsYg4wV6QpeEhW+6eXM=;
 b=i+B4c5Ik5TojCfo/alvATg9NRlwXc9AowBoENIbIGfbmT38hjeYT2WbEHN/x0YlQyb+ZZK/fEHDChbFk5xKw7RYtkoN20veSiLHJMSERyo6slVG55nG83s4pduAJ80hY+XSdE4Q+jyXToJCTjlk1PNN5J22Neh+rea+Xz9JkMy4=
Received: from DM6PR05CA0039.namprd05.prod.outlook.com (2603:10b6:5:335::8) by
 SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:57:56 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::76) by DM6PR05CA0039.outlook.office365.com
 (2603:10b6:5:335::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21 via Frontend
 Transport; Mon, 22 Apr 2024 13:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 13:57:56 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:57:54 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 4/7] drm/amdkfd: Evict BO itself for contiguous allocation
Date: Mon, 22 Apr 2024 09:57:22 -0400
Message-ID: <20240422135725.11898-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422135725.11898-1-Philip.Yang@amd.com>
References: <20240422135725.11898-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 87932c66-1a86-4551-4777-08dc62d43698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HVDZGYHXdhWr9qx5RvXHStzIsBFrg85VhBykcN+L/+n9V1bxFNStnDuELO3d?=
 =?us-ascii?Q?B6DIjXQx0XyKWwLFTB9OgNBTjTDqYEl1O0eRJYxIzjUGustukIBfwxCbm9q0?=
 =?us-ascii?Q?TqBo8lLmuRcwIdiT4D5klG63uKTpL/YBF5xsL6ovA5E+KeD1Rbi9a7x7bAch?=
 =?us-ascii?Q?Ri/eakENZSzABqN6HVyKfI0MeetCW0VUn3C9R1HQFEyFY4n5SNeRAZW0N48v?=
 =?us-ascii?Q?Ak0GuAtY/XqAHSIPvhT/DOqR5P6j//f+USGNd2V3Y+QqOj6Azmc79Ll/3gBd?=
 =?us-ascii?Q?Czex1F2m3m4p6MNmxb/CAW/pTZ7Bvyd9Bb71Yj4iGMSUhKbUNVChcLaoZZXs?=
 =?us-ascii?Q?bO5PxirvVABdGFrZHna58h5erETmYUhzbNKXSLtvCSorR/upRaz5zF5LdJCA?=
 =?us-ascii?Q?Pdg/odKeFDPWFjoLSk+/cQcNqqQnZE0PysKgut7cm+mJgKj+GVvZfGjOHIck?=
 =?us-ascii?Q?vuL81SxgLqtzt1yN3EHTu7FUwtKdAZYjrdonp/3tocFwTnWLinenJpVCk7t9?=
 =?us-ascii?Q?55KV2oF9mqNGz4WFsX3rqnSV3PHODOm+q/wNpO/sdctK02Vq6mwzr43FuVOZ?=
 =?us-ascii?Q?KDYDpf5fRpKIWhX9LMINZyTwyr8Ush2QC5VHjkXmElm1K/mMfqqd9fkn3JXq?=
 =?us-ascii?Q?muD/IEyQhNkNJmXng1cdzFsZQjy1lTIVOkSoxG8nBLG+C/JfBgaI9wByNKUY?=
 =?us-ascii?Q?aDAFgM9DBbOhW5bu9jNE80KD5T8+WMrScSfpw/SUwG1bj2mU6+tHfqms1J85?=
 =?us-ascii?Q?/KCwab8QBoEqjmLDxE+naXOW1/aY1vHCtWJAz8qgMmntwUu2Xj6jzqG5b+PJ?=
 =?us-ascii?Q?jNzsF/xv9QQ8YBnRV8nvwFuDieHT/sWrDe9uSTjc4EGgFHy5wOwFfdNeFFsp?=
 =?us-ascii?Q?55bMqfKEKHQp7zTNj9+dyXzdWWQ9FRU1SFAUs9q6Okio/3cIGz2C0B8/ROng?=
 =?us-ascii?Q?jpjmdsXdVQmMzkbClKEZj563hDNAcL02lRPKs/R3CB8zz3FAg4zEwNgV6S4G?=
 =?us-ascii?Q?gCNki/vT3Jh2p7Ip6Ro8F3TcDPABO7pbrd7RtB14Sg5sGZoSG718KG0VtCO1?=
 =?us-ascii?Q?tghb8Hdwx9946STNBfZBe7dRCJ0f/20vV4U2uTFmEGTWoCMISfLnjK7yir+S?=
 =?us-ascii?Q?LfLdzDw1s9pvnDNe921NVIZmdB/efvy7FPH6M0NLwg7kkYT83ls0Qw/1Gkdm?=
 =?us-ascii?Q?Th31wGNCzr6FLgcOhKM71X4NpPlF58EVcf34EpNgyAJfOzJ+FIpj+7zRS1x7?=
 =?us-ascii?Q?JZMVY13mAwKUs5rEsfeWr7JOoip/3mEbsi4jGE0pvkW3oevJsFOsCG3JAVvr?=
 =?us-ascii?Q?U8LoxGolJLOoD14yzq8YV+uOWOsxvPfqKZxaESZwuOwbAW/RqJn/j+kC8BXe?=
 =?us-ascii?Q?hdDkuzI+LZf+MTc7c/ju9itJXG/D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:57:56.7212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87932c66-1a86-4551-4777-08dc62d43698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035
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

If the BO pages pinned for RDMA is not contiguous on VRAM, evict it to
system memory first to free the VRAM space, then allocate contiguous
VRAM space, and then move it from system memory back to VRAM.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ef9154043757..5d118e5580ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1470,13 +1470,27 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 	if (unlikely(ret))
 		return ret;
 
+	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
+		/*
+		 * If bo is not contiguous on VRAM, move to system memory first to ensure
+		 * we can get contiguous VRAM space after evicting other BOs.
+		 */
+		if (!(bo->tbo.resource->placement & TTM_PL_FLAG_CONTIGUOUS)) {
+			ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
+			if (unlikely(ret)) {
+				pr_debug("validate bo 0x%p to GTT failed %d\n", &bo->tbo, ret);
+				goto out;
+			}
+		}
+	}
+
 	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
 	if (ret)
 		pr_err("Error in Pinning BO to domain: %d\n", domain);
 
 	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
+out:
 	amdgpu_bo_unreserve(bo);
-
 	return ret;
 }
 
-- 
2.43.2

