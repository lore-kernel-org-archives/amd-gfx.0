Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C372C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 16:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D67510E3E7;
	Wed, 19 Jan 2022 16:29:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E8B310E3E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 16:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2H4S4fzidMcdI57k+oLae9PQAOPnObjme0T9oebPd4TVs28FnxK9eiXCzUBHbLMnyM0EbT8LS0rlTLXOV0PhEXv/X1qwT0mCXrJKjep1NBQ+vl6WpctPlgiopg5cNeR+t/VIH2BkgSZuC2YPvKY45n7qVpJa0olEGfARWhOEB/zGTuIMuYb5F97iZswbes6vQCuByomcyibO67n3jL/gZzh91m7pL59jHCdnrTjgfRri9ucnkrsONvt0WXqi9HEOkDl20SCQhwQEfwCdRVxRHtEIl27DtgHH/fk+hUsLe/CaqTa2DZiAOHLp5V+P/KXEyhwXSblANWyoWuBzyvRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME6PQnUYh5YRENxUUTCBdpt8x4Qv8WdGJ/9GKGsl8/U=;
 b=nl7Txn5We4ea/wt+IIL3oEXR4LM+W7Z0764UQ4Me8CFj7ik3KkOfJPSLfi62LgNCo1Svig6XuU7dLAfGFhqlwJ+mRfeN91Utt9lkNp2BJvS1qRPEWD0jcQEOLZCzqduZxOiqAbsM2zkUX8ELtQIgIpZEYG10QgzTVENwgH3oVC8Y9tMMIIHgeatuqflbFmknS+YTkDl58Qo+aCrb3i+cYHRkEZMdeaWmbKxAracSkNe8XZWoPQ64sG71fX/yPR6I0lH9CsgIPhTyoINRPoz2uON8Rc8cRCxf4t4PCK9+mJ6V+HsqSdWqOYH/Mhwh+GUIJvbxh+Bfl4bY9EEnLShfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME6PQnUYh5YRENxUUTCBdpt8x4Qv8WdGJ/9GKGsl8/U=;
 b=joaHXKlRh/E7twsCDuFizbkqRnAVuyykLSTQgsxcwPnJELAQ260Z1DpgvxAICePcNFDDvPqWDzj+5DraxIXh4W5UDb9+7Qmg1KWCYru0usw6Ats+ksov/CzQ9GYmV6EqU1gQwGus/78QmF/suP4DyXjdcfTm+N9ZqIeNc8xgeb8=
Received: from BN9PR03CA0043.namprd03.prod.outlook.com (2603:10b6:408:fb::18)
 by BN6PR1201MB2529.namprd12.prod.outlook.com (2603:10b6:404:b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 16:29:00 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::18) by BN9PR03CA0043.outlook.office365.com
 (2603:10b6:408:fb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 16:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 16:29:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 10:28:59 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 19 Jan 2022 10:28:58 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: fix convert bad page retiremt
Date: Thu, 20 Jan 2022 00:28:56 +0800
Message-ID: <20220119162856.30286-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d95e0ba0-110c-4bc1-c13e-08d9db68cc88
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2529:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2529EB7F500A9828CC502AF49A599@BN6PR1201MB2529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zs2i4zww3wsuvOAO+wdQ0T3X6SJvDZ5FB4mFzb+v5fFZYf2rnoy0zG3dPiEAgUgIC82m3MzqtyBFu1IpzHefglSiJQlMGhfShyrvid7bIfv3OTfVIfKBXFE2/cxrbsE2GoN41CdEiFGsa2JY3dvmFSuHdPh9MvreT3jn4vR2oVMIUe6XCatfuJtqGL192OSD2m4SNWmStGN/WyXRILBlF6QobbEqYz7HZVeTZ4mjedG0+ovdK52VJH9UsQw+FVS6q3TzJrXthjFqO6VeSsgnUh0YHVPRx/ASyMPB8/CcQlG46k7BkP6qcP7zloESNsqwz8FdKW63MJ7ZS69C19NaNq0n/L6uYh6JyA0pS4CH5H4Liug1qhe/S6MizikKQT2nNWO/sRfMw6uvGCOigXNNDTyAv7AsBNgcs8g4s+08NR7ExIeYs+eKYOBaLzu8n8aOcUYuYF6u2s1PXJwRRPPmXBe+bXhT/X2y5GNboUv00fOHZ1QmfwLoFtFqFqRTwXvSt55A7kjOw5uZK3cicUORY9N38MgPiUP9OFluIbRKmGyt4Kc6cg5T/MwZC8qRScwHH5XUnz8+Np3NjEUqq01JwoHs/ctQq+r3UZ9kfaDTWCYonqY5JDwSLISEyhucEwxt4RX1oK+0mhTquCd4f6/My9Oespw97xfI6x+Ejyt/I02DtVY6008JsnzQ9PDcETsIdgO0dqNB3NDxJEZAn8OcrPRjlxidhQi/gtIadOsdXvYNROHxxC76JiyjSRuuH8vJwSgfe5OIcdFvZexCe3JDM4OV1O4wp8wXUsb4etGNW2c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(83380400001)(336012)(508600001)(81166007)(4326008)(426003)(2906002)(356005)(8936002)(186003)(70206006)(40460700001)(5660300002)(26005)(1076003)(86362001)(36756003)(70586007)(54906003)(2616005)(6916009)(47076005)(82310400004)(8676002)(36860700001)(316002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 16:29:00.3763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d95e0ba0-110c-4bc1-c13e-08d9db68cc88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2529
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
Cc: Mohammadzafar.Ziya@amd.com, "Stanley.Yang" <Stanley.Yang@amd.com>,
 Tao.Zhou1@amd.com, John.Clements@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pmfw read ecc info registers and store values in
eccinfo_table in the following order

umc0 ch_inst 0, 1, 2 ... 7
umc1 ch_inst 0, 1, 2 ... 7
...
umc3 ch_inst 0, 1, 2 ... 7

Driver should convert eccinfo_table_idx into channel_index according
to channel_idx_tbe.

Change-Id: Icafe93e458912b729d2e30d655fd68be0e12124d
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 526de1ca9b8d..f5a1ba7db75a 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -58,29 +58,33 @@ static inline uint32_t get_umc_v6_7_channel_index(struct amdgpu_device *adev,
 }
 
 static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
-						   uint32_t channel_index,
+						   uint32_t umc_inst, uint32_t ch_inst,
 						   unsigned long *error_count)
 {
 	uint64_t mc_umc_status;
+	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
 	/* check for SRAM correctable error
 	  MCUMC_STATUS is a 64 bit register */
-	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
+	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
 		*error_count += 1;
 }
 
 static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_device *adev,
-						      uint32_t channel_index,
+							  uint32_t umc_inst, uint32_t ch_inst,
 						      unsigned long *error_count)
 {
 	uint64_t mc_umc_status;
+	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
 	/* check the MCUMC_STATUS */
-	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
+	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
@@ -97,19 +101,15 @@ static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
-	uint32_t channel_index	 = 0;
 
 	/*TODO: driver needs to toggle DF Cstate to ensure
 	 * safe access of UMC registers. Will add the protection */
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		channel_index = get_umc_v6_7_channel_index(adev,
-							 umc_inst,
-							 ch_inst);
 		umc_v6_7_ecc_info_query_correctable_error_count(adev,
-						      channel_index,
+						      umc_inst, ch_inst,
 						      &(err_data->ce_count));
 		umc_v6_7_ecc_info_querry_uncorrectable_error_count(adev,
-							  channel_index,
+						      umc_inst, ch_inst,
 							  &(err_data->ue_count));
 	}
 }
@@ -122,12 +122,14 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 	uint64_t mc_umc_status, err_addr, retired_page;
 	struct eeprom_table_record *err_rec;
 	uint32_t channel_index;
+	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
 	channel_index =
 		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
 
-	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
+	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 
 	if (mc_umc_status == 0)
 		return;
@@ -142,7 +144,7 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
 
-		err_addr = ras->umc_ecc.ecc[channel_index].mca_umc_addr;
+		err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 
 		/* translate umc channel address to soc pa, 3 parts are included */
-- 
2.17.1

