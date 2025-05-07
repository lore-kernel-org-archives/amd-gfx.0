Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5974C3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 15:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5881A10E839;
	Wed,  7 May 2025 15:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BSUfpB1d";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5F310E840
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 15:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9FJS8drSIt3TxlCGxHz4t2sk0InLmvTcpgrhPysdOLTvfvJfDfgY1IXkgQJavHnNaEqPJ2ez6mte04tq710h7mvpsw3fw64uKcogL3aDHCfdp3sXcMa4R6nmu+0eCh3lXqr9XDQi+UhjVIxc+i0gg0FUbL6MTrAkhk2PHpgm5Pjllbbh/uWy2b0gnWBzPmoK8Zt+vNuqIgt2Pk9QFbc/CTpoWNugv6SiwiFZMBYMm4eF4Wti7fZoQNCe1omFbpISSK6QcCd3fQOP4faH64yihn2yY8eJDGzLHgp1eaWBnr31odbyPYNsFu1y2H+Swlx3/Gsx24yBKPH6tB+kZCGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU2/TGpg8RIQs+Vq4a1K+IaAtjKXryWDUwW8UqU1lpY=;
 b=JIhkawp2VdY0YOxMoANC7eaylxdCeouidfBh9cRDRdmbXexbhLO+mRaRd2cEGcpYdhYTXDcX1/9/mMmEQWybOMsb/ZVqMPdnXEoYG4KzHfpNFO/nDBQvQmM2OhxAHm5WS1aBOBfsUoKkJlPQ+sVV8619lPHDeaJvstNi2MG/WIUkjq/CGYIsnfC/HxHnAQeiMLf0ZUeS25+pu9iQ01rTa0ruVygJrLJ2U/umJwHsM6hU1Wz3fzinWa3GdLt5xmG03ZHOwgWt+Tiy31aslwyQcyDMA9uCTIMYwN8vqs/eBXXih4iHPr0Xx4tSuqbkL5KnzbimlRsEa+VVRsx/ubX0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU2/TGpg8RIQs+Vq4a1K+IaAtjKXryWDUwW8UqU1lpY=;
 b=BSUfpB1dqzxJk5IZxsfmHOxJM+eASSUULOqvdNkdj1tKYe0mt4VsIyM1J0se3RFHYv3GNYI0nmipj4667qR4Ml7avO2nuuvcUgKC3FC1NPrWUwqN9+Dq/I7h4ya3WV69pV2mwYON5/GP+uFhUL6+2kUj8VKZ4Ld75vJB8l+qIGY=
Received: from PH7PR17CA0040.namprd17.prod.outlook.com (2603:10b6:510:323::26)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 7 May
 2025 15:27:30 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::d5) by PH7PR17CA0040.outlook.office365.com
 (2603:10b6:510:323::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 7 May 2025 15:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 15:27:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 10:27:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
Subject: [PATCH 4/7] drm/amdgpu/hdp5.2: use memcfg register to post the write
 for HDP flush
Date: Wed, 7 May 2025 11:27:07 -0400
Message-ID: <20250507152710.234881-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507152710.234881-1-alexander.deucher@amd.com>
References: <20250507152710.234881-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 7035d689-e21a-436f-23de-08dd8d7bae53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?00M0G1MqeUWBgjxS/h1EFRNwhFb6Y0xzYdOGsXfJjOHLHheawPiPUezQmPU5?=
 =?us-ascii?Q?oAUM9fJD4k8PFu1xr1V0FBE8wMD/laJhdF8oL+kZtzWNp3TvPTK2vBmcnsfy?=
 =?us-ascii?Q?hmEdlbSRK4zanvBUBkqvE9lFDBCwUazyhxw9IUFdt3RPMDvcd9kJnlAr2XMm?=
 =?us-ascii?Q?/ZKWT43W+OKM2W8aR7SvmkhchnZDbcNO7/5gTLNOZQ8UxBpnLYMk3XTNSEcL?=
 =?us-ascii?Q?i2ErMRN7+xqOfZ6OSYKnASNAjk02VjxkO9L2DgENwHUfAbRppI2LJA6qqKeZ?=
 =?us-ascii?Q?Pew9umXKWHSQD9YBH+UCBlhMz+i70OhJhDnSZSdSZ3mmw7bjzMGIsceryuel?=
 =?us-ascii?Q?havKN7ojTH/LcnJ5IBISlxe8Y/uaxWtbMZ0gSWL8PIRoKn9w4KkfN1BZx+Np?=
 =?us-ascii?Q?5PeO/8H56eGq2zZClCgKw19C+PDlzu8CtMvYZ5sLXJex6nW4mdGRW8KxwcJJ?=
 =?us-ascii?Q?/hqZGy3+kAVWmbmpZmSY3T0nwkG4ffbF8uwF7ofsxUZ1/JypONMR4AAYWdtO?=
 =?us-ascii?Q?GOLp3/Fm8LkgAb0uLx9ufd6wIdxW0oa3UzBqzMK9+26rVQH814WWdvDLZYwK?=
 =?us-ascii?Q?xKmRTZoKN0dqel2iTzWxXMX0REMMsYgXbHSi80PJTQH8DJULo9XVtXAsOH95?=
 =?us-ascii?Q?R/lzw5M/7DUfMpU9Hz3HkpoRlzqum47vcd3Bhd4iFsV4jb+Qi3RlXCNygeDi?=
 =?us-ascii?Q?v8DQlADp2nUo1z7qC5wq6YEXfdUiaAJOly4aMRe3g1D48xpTTI1de01Juvrn?=
 =?us-ascii?Q?j7cA7oK+nBvgVuY0Svan1qmhM2fIOf9400oZ9kqYPARvBINJpxuQeKLBARzT?=
 =?us-ascii?Q?KmsfD5O/t9kCpSro5P/pE29D3j4Bjpx4iqXLw5nqjm2M4zHzERagt76j/glD?=
 =?us-ascii?Q?5E4lIQslOrPe5W3JsfabEu3aF4WcCbHgImh2OS4ZxFYyzrIisJ00LcfRoHCW?=
 =?us-ascii?Q?zgAUynzJvG9CBrYnGYNUycfa1Qbifv/7h6q6B04+1mcQkdECUy8yE5fCD9dS?=
 =?us-ascii?Q?NDpqOJUZh7BYhN1Df2vzq1oDxKUk+WKCMXcm69bdndvDufZMHeONxe5tpE6L?=
 =?us-ascii?Q?zODZc21nzqn13aHeNPSfnBUi4sZwUEbb/5jirpa9qXRvC/ZIFyhHO76EjULA?=
 =?us-ascii?Q?jBlAh+KDbHIT2RXjAhbNa+07orx+uLvdlEJwaZ6V4DvaJeIAP+BfI/VM9b9M?=
 =?us-ascii?Q?kEhZKGJYP9RHlaa0K9wBMfhxxu4SA6ZLgDJ1RtABU3CH8ZOoAilfrjEoSGtl?=
 =?us-ascii?Q?3FmWGG90G/XRUA6YtAY1TDef68EHZtDTT7RXqOwDOs269mRD5wOTnERQKTyG?=
 =?us-ascii?Q?GU9NRbwqzyQnb7tY2vZumhyp4Z47R4mqoiPE1kiCU6W4P8G8Q6aQhnAWu5F6?=
 =?us-ascii?Q?6jEvH9HYp4lJyg/h8bziVTk8WzvFcNz3HjOBvDNcFiJkYAZc3sY6zJlIZ0/L?=
 =?us-ascii?Q?zoQU9tPoFddiyp2pim3J49jLtdUnWKWN63qcOz8WoN4wO3G2izalsw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:27:30.1022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7035d689-e21a-436f-23de-08dd8d7bae53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
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

Reading back the remapped HDP flush register seems to cause
problems on some platforms. All we need is a read, so read back
the memcfg register.

Fixes: f756dbac1ce1 ("drm/amdgpu/hdp5.2: do a posting read when flushing HDP")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.html
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3908
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
index fcb8dd2876bcc..40940b4ab4007 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
@@ -33,7 +33,17 @@ static void hdp_v5_2_flush_hdp(struct amdgpu_device *adev,
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2,
 			0);
-		RREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		if (amdgpu_sriov_vf(adev)) {
+			/* this is fine because SR_IOV doesn't remap the register */
+			RREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		} else {
+			/* We just need to read back a register to post the write.
+			 * Reading back the remapped register causes problems on
+			 * some platforms so just read back the memory size register.
+			 */
+			if (adev->nbio.funcs->get_memsize)
+				adev->nbio.funcs->get_memsize(adev);
+		}
 	} else {
 		amdgpu_ring_emit_wreg(ring,
 			(adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2,
-- 
2.49.0

