Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FC0606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lZy/lIao
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A23E51123EA;
	Thu, 22 Oct 2026 08:21:47 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7CDD1123EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:21:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXvpOPLi+c6CJuPrU5/+gdghY2p5wrlCfeW0WPJ+H/y7EV50/3TKilWQoRLdCuW0HFyW73IR/BqIObv0mCTI3UPiECar1Eu7F4zkODkwdw8d9nlomotPl/MbJhq2sIKRRLdp9CV9XDQZW4gMP1kPyebtd1jpNFGbHx5N6dXwvzRO5bd9Y3w70Q1m+HlCtBf58IAvm8OAlRFsyDAYZSYOrXodoABVzt031deCf6IHJcUTNIfA9b8GJWPsuOyVRe+Jxs7XzsOOamFxwUcxUiNZdGq8QnE/T3THRD6y9MGKLiF+5h1flprTe03htF56L1URNTQdfXTX4Uu1zIb0H9Me+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yakfexQHiJyTaErTJhPxYysFyif1krfW7/B9N8H5U5k=;
 b=N1XqzBwrdIY7jezgA1PlHfgnoKV0zQZgmYzY20zF8l0FShpSMk5U2ZxAJHx3TjQqRAhi+Q6BA+bauN/Fl9HiiXARfzNBCiUlSwfwofJ1jdVMSWFM3CFk2X3ZOVbfiKI1wl0MVEiWRMrX2oAnnMan3VCEDOPPqoz5XZEuPAg+4on4zLT4XojtrCnVMAiCdkoT5dn/zXDIzD6dC+6FNIfCqC7Tz73KzNDsN5v3MR5Co1c1Dkr1MGcsJtpFGSuTjG9j8JDfKkcbKRP8thecVReMpicJwdKBbXHnJmfKcwYj20vZJpbwH+GnBBt8ZLpXhAmgITPQN2CT2qJLMb2CBb0vfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yakfexQHiJyTaErTJhPxYysFyif1krfW7/B9N8H5U5k=;
 b=lZy/lIaoaPOJA+UfGIxTV7i2NXKTBsyFyth67AuYUX4s9Ix+2nCvbJ2xCkh5NDsEHte36JgTSd80k41NEqTXW7A2YNaDt67UgG9lw5NwObp1xb4b3dCEw5B7QSqbOpJ3Y9iy1Gr6UV0fpRiTQtgwiaNXcL6GdBQOVH0muovg0K0=
Received: from BN9PR03CA0400.namprd03.prod.outlook.com (2603:10b6:408:111::15)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 08:21:24 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::47) by BN9PR03CA0400.outlook.office365.com
 (2603:10b6:408:111::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 22
 Oct 2026 08:21:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:21:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:48 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:47 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 14/15] drm/amdgpu/gfx12: enable the gfx engine reset
Date: Thu, 22 Oct 2026 16:19:54 +0800
Message-ID: <20261022082011.331462-14-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d50532-e8b2-4417-2964-08df30156cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|261021121427099003|18002099003|22082099003|261009223027099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5tIApEsxN81bUu16jBdxjysYwjAqbeDSZgMySaB+S/ZEKAypiMgxpotsiW4mhbQAvEp2SpQTSc17e9Yn4W2MPPiAEr1UQl+UX/0dRwxW0QOZFf2bHyaBogqtneOqUBAP1MYTD3+YRty4C8E6lQs6xWSiYySRiWtuX4Z3hNM63b6kCF4buZ73bB5zU0V6bmBMwM1ktwdL/AcKRZPnDDO9VBjJbKTZYb8k7x+tmjiDysdSGPHXfEUpDypxfcO2X3CjgHtgtWH7H2WXMWYm6hYO1p3qU4Y/FQk5AeVyJc5x1AqNRTL0M354QPc0HJ4JEn2TqxYNtBplYI/pAZKytX3mfJrsWaeak6O2H600iuIppuUGsFz73XK2UaRPQQh7noBNiOA7Y5WmwVP2GWBkeOMLfMS17XlQILMlPRpPk9nwJPCO/yPgcc88/nWjtxbuqPqu3XQsnOha1zdnSYVMZh9C+cZueEWxQoc6n4VmlyCy+uL9uPnVK42JaFX9TVDc12Mvwc2wEublyOjpMc+5G/LF/ZT/6aQwSuGRCINiSNpaLKoTsJW1CUAG8Pb98yo/cxr59xIOxQLhoDwa4xY23dXoJf8IL0UEUpsgUDLCUYUo55taUjhlE8PhXGCoCD+Gn9bAckqmYRHzAYEf7zJUoW1X+D+8Lld4eTlu0acpqCg66GvhpFrdktbFZm17OGO/yJ8eBns6XZlx2a2rshDrSzeb0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(261021121427099003)(18002099003)(22082099003)(261009223027099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PGTtDJzQL0IVOGKAdS3maSsZf69PmBYFo9YjVKIhQEZMmDJRAXu+xwiX+IeyaIgfRhSa50HwIhXcowEmvJp6JuoZByHUzmZtXGskEJArEkixny+oNRQCQt5RNIGFq7aBp5YCAf+7aYbdYbqyRy1w0a2+0+8Bv3Zobsv2bmUH3JQR4huH3Za4BL2uJr7p537DMZ9lgsvnQ1xItV9SQv6HkqGhCBMm51nfhkYZJNk+yu+7AnfVvzgWoSWuUY8xqCGM3XWl2XPBGdIUO2klJ/3+L/pDwo9J+iTbx7XMhTeuHIk/b2X1QTTawENMfXzMuFjzMINut4Ss6kKWFIXFpgqfMbfvkvvWipP8pRJQYb2NeO5meDLtnQtq2pqVKoyuLxo8QQWGwxArFrV6TQjYzXSG0a1uZEarUDthqjqkLQbGdnsDvgRmSFMXPqRrKxVUs+GR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:21:08.8342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d50532-e8b2-4417-2964-08df30156cdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Report AMDGPU_RESET_TYPE_PER_ENGINE for the graphics engine when the
reset_engine callback can be used: with MES and async gfx rings. The
reset remaps the kernel gfx queue through MES from its MQD, and without
async gfx rings the kernel gfx queue has no MQD. It is programmed
through the CP_RB0 registers, which the reset clears. Not on SR-IOV VFs.

The kernel gfx queue and gfx user queue resets then fall back to a gfx
engine reset before a full reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b5f03f9a4ac3..a3dc05532316 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -274,6 +274,7 @@ static void gfx_v12_0_set_imu_funcs(struct amdgpu_device *adev);
 static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev);
+static bool gfx_v12_0_engine_reset_supported(struct amdgpu_device *adev);
 static int gfx_v12_0_reset_engine(struct amdgpu_device *adev,
 				  enum amdgpu_gfx_engine engine);
 static bool gfx_v12_0_read_gfx_hqd_ptrs(struct amdgpu_device *adev,
@@ -1594,6 +1595,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	if (gfx_v12_0_engine_reset_supported(adev) &&
+	    !adev->debug_disable_engine_reset)
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_ENGINE;
+
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
 		if (r) {
@@ -3855,6 +3860,12 @@ static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+/* The reset remaps the kernel gfx queue from its MQD: needs async rings. */
+static bool gfx_v12_0_engine_reset_supported(struct amdgpu_device *adev)
+{
+	return !amdgpu_sriov_vf(adev) && adev->enable_mes && amdgpu_async_gfx_ring;
+}
+
 /* The CP DMA and the interfaces its memory requests go through */
 #define GFX12_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
 				 CP_STAT__TCIU_BUSY_MASK | \
-- 
2.50.1

