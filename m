Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F78EC021A0
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 00:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B0510E198;
	Fri, 14 Feb 2025 00:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dBeunU3C";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E5310E198
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 00:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBc01uznn/fhcWn381Enl7bjBgoC9GDvd1CXjFZH60TkoPp1tYTrseBpsKHyAdw40HAhMrjVahjdEcpm/RVhF6d9iWO2ENOCwjdbcBVHSJtF/pKjwuP2HnTof30AOcyEDUazXDlXD6E/sOY3ycfcZP+lsFA8w4fFYjumyS3KPhxH2O4GW4b8+WktHxNMLhaA5z2K0xTlKw/uJNsFH1IYTFgIZm6SByaXTh5n+XhXVIHsRhe611L+zRhL1eEFaaO9LRPlWvAgNEli97Bv8JF7JLRiWLw+wfWJmhfTzy5hRF/voF+z7iZ9CLXarD1kMIaqbKOplDPqPKJHqONYnCp7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0fqApPv6QL7xRk2p7UebJXAvRRQzfkHI8zdV70nPRA=;
 b=g15u82ntrEz9yXCZwd3ewuqOFdVog58ydgXOFg5xv6cZfnG+yST6VxE6hwGALUM6FzffconE72Aki2v2CL7L8JCHmEI3uSZK0MMgP5wGrAn02+nNdSIjhPL0AlYUGdXZsFxGxPmegwtxTPWYJRt+55+zbaXo3/OgJY4Cl9U0NZ9xEEPfT57fI7nXX1jvwGhZ7G0nrMMIwUA+Y9dpRVoSF2lDSIKTMxUeHX1/p84qNykrdmTA6DcPSFrVgGdK8ARajl5wgZFLNN4gNXZZduT+LdaEckZdu1CreS6WAQDMY3vcbdQ1A/iedoKpU+9Pqg1jnJ0j36R8Bs0FiW3arQswxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0fqApPv6QL7xRk2p7UebJXAvRRQzfkHI8zdV70nPRA=;
 b=dBeunU3CXqeeYX/BqMZteBE2j0x4H+cYFO0LtnKSSAqafr0v2E7P1MWs4+gPILsG1v1sXQ9lMa2mSNnYzBeM+HE4lc1xXB5e03t/gkxRRNLkRl0mi0pJHN2AwNFShVJSK5fGNCntAInW2K5mVvB31IG4NHmlBr9ioRopKB05NOY=
Received: from MN2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:208:1b4::37)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 00:14:04 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:1b4:cafe::e3) by MN2PR15CA0024.outlook.office365.com
 (2603:10b6:208:1b4::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Fri,
 14 Feb 2025 00:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 00:14:04 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 18:14:00 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victorchengchi.lu@amd.com>, <hoarce.chen@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Do not program AGP BAR regs under SRIOV
Date: Thu, 13 Feb 2025 19:13:46 -0500
Message-ID: <20250214001348.4767-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b56398d-2298-4d4f-0653-08dd4c8c7d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LahD7c7iegRIzTs3k+T0CbW59lmyB+MEMuXDVd9Oa4wOGTIJHsV1hype+HWh?=
 =?us-ascii?Q?lkvo3uvqVfaEWx6GGo2bZwNVgGsIIZqf8pBnp0ZBBqmWV4+NAuDa0T6XlM8g?=
 =?us-ascii?Q?HJhC3B3oMB5q8kXvEYT4AAkBEtgT8o1UOyPqwcrzDhXoeQ7AxrY2+eYmUh3n?=
 =?us-ascii?Q?Apw8P0FgpcHfOc3YDf/Pk2JYZu5amw2VSVjX3nNy1ASB/3+yme2tLLgWjyqZ?=
 =?us-ascii?Q?CilQIzTftOrW2MOPAdNCGInmnjHMclYOgEj8Q71U7Ypy69MnbGvGSX++R06i?=
 =?us-ascii?Q?mVtHnuUzQTUchQ1U8S8rzYAJiO8VJMg2Gerefchllocmz9TaXctJot3alhRu?=
 =?us-ascii?Q?nhjUnlRGsgZ4jQ91DXr/mRbW8eq4iSh4dV2DPLDeOl5K4dgNsoPNzlBDwCYa?=
 =?us-ascii?Q?xQPNvI0V8A3JjEj19hB7JNZKCSXGCbpoO11u6kZoxHk6xsnRm0nAzUIJMAuN?=
 =?us-ascii?Q?yjEgRyEf40v4OImW/7TdKFFKmrZaLYvDeZg1UmI4oj4Gtvigs2FJw6gseR9C?=
 =?us-ascii?Q?nOInkPKDFMkp/ZfKSjUv+ZZ54bSlezmdf+HiMv6rq8+KQfsmHgP4gWzvoxQn?=
 =?us-ascii?Q?caB9i3aLAe+z4a6fGv/nsEGj9TGiyFDkbcHzZj09yCuJ87ZM825BGVxE3K7S?=
 =?us-ascii?Q?NAd54A2VA4Byc/IaacYnQk9Z6STP9VrLbMD7LuwOLPXTSznOfs/y+RX40jms?=
 =?us-ascii?Q?mRcWoOPXGNhGXabHYndFsS6iw9PfrZqZxPBn+aYHZ7hAk3+laApIGqWjYBpx?=
 =?us-ascii?Q?MDS2OblGTYdZ6XrA5LRqXKzyWyYCBql/haYH3Qb5EduDBWryqPQDo3txcZ/A?=
 =?us-ascii?Q?0m5HMSRb0kLAofXlPz3evycY7sJ/x10n/+p4zq3ZzLF1xLkS/j0RTr2fY/YW?=
 =?us-ascii?Q?LWLnGMHtWbHTEeYvUbtgYU33A8WktM2wP9r6bX4Hh9fbJnKLjle/mOPnBKfq?=
 =?us-ascii?Q?opZ4UlX50NyqljZo7qd0p4Qsj3dvWbZ7GrBMol6hBT6176CQ9yhl4b+hBd50?=
 =?us-ascii?Q?ZsUCg5EkfiByJzMFZ13pmGHongaXD1sEKkk93Hm/GS2f4LZs1dIhHYHztho4?=
 =?us-ascii?Q?BZ1/WIeQek/oCRbdNqzoeEBiyKCQpI92lrDljyo10+/5a5m24DCuyXvqmKOg?=
 =?us-ascii?Q?rtn98WEH2Smd5Sf42fy2/ewtekmw453edmE+IEYWnT2U77hAlg6fqhaYhywh?=
 =?us-ascii?Q?xTbRbOKIQa89z+MW3+5X6+jMbH1LQYtoAdeQlJD5xRd28bzbRYRhvTb3+1pw?=
 =?us-ascii?Q?JirmFr3N5UVkRh62qux7rDk702X4oH6Z3XgFQ2Tr1Ov7wf3rWuVtOMTJ8Gft?=
 =?us-ascii?Q?vO6uFQuu/tXm5Jp4GshwpDc52FZi3jr5jCCoIFixOz35FtnnTIjYh4ZmmQwH?=
 =?us-ascii?Q?0uO5bC4n00OicYK7W7vJzYYrQDPsQEE00n8PPD36htNIXlknPK73grM9fVOs?=
 =?us-ascii?Q?sdoWx8p5x9yF/hd0/ku5nM+EQ3+dtKBcS7C+SGmPoLERbEC5awaVF6wSUiwG?=
 =?us-ascii?Q?TF4opKu92N6Ms+o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:14:04.2494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b56398d-2298-4d4f-0653-08dd4c8c7d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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

SRIOV VF does not have write access to AGP BAR regs.
Skip the writes to avoid a dmesg warning.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 0e3ddea7b8e0..a7bfc9f41d0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -92,12 +92,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
-	/* Program the AGP BAR */
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
 	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
+		/* Program the AGP BAR */
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-- 
2.34.1

