Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA85C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 20:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CA5611AE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 20:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1CA5611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7E86E1CE;
	Tue, 19 Oct 2021 20:11:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDA06E8A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 20:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgPD4KxiTOlWcJDO4DQ5BO/6Ch2fZiwTE/zriRrFtxLsa0sH0gwk7zQmeEaaDQitotl6ma6xIv1Mb6znJJ3kGxDqbkV42UxN9qEnGGuAWR263W1M2JpzNQsntSZrNyduCU0FKuMLrSv4c0j8NVaIJrVRx+5nJLUOwMDChAv77Xo+Pdx7nIqIlh5dCIyRP2P6yONJJT9E1lw4uSN6ZbDTCWb4fo6GDNYtgNGXzbyClSRlXAPcMIv7ZrmGe6t0MxuGZdNam80qHKjbsRhQdMy2/kZ/ZwjsEGzLftcxrMpXYgCUcIfCQrdgbcsYj/i81SF7ZRlVJFWRHJkHnuaS/Rw9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heiBy1M+NhfE+i51zGTOTBjIEkjafjNLAVf4jbzSlcU=;
 b=GIuVdiRqlYlpJBKBfBuOnoBihb9R4ZS3A0XfSy7Q9ayKW/UBdkVu4yOT786jA69HFtnZAJOS9d+YsPM/3CgpGf5BZHPi6I0V9EDZCX6NUCYcg+9zZ00FS4Q08USvrHZJIWz5m09JLQsFrCATKRv8QTtUzBBFburp3uzE07WhnOKQCXQWLV2PYWvbLZGfDNc94Fm8vmUSTptLtA3CjDJ1hiFS/K/JGGjyOyfAODYx3yx3rj1ijCnWKN4CkiCLnBqZZaAZq53sxf/25VA4rYPYANSxNe1FhR42GZCZmwdtqUejcgmo3+/vWRucw3XeVCeerKq16hpKVH5zoCCCupedJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heiBy1M+NhfE+i51zGTOTBjIEkjafjNLAVf4jbzSlcU=;
 b=jhe5s+ve6PLPuZkCBzFh+Qpiox0GQ6TsIkqAk/x3krerBIH2zi/WUKavBYWP51IHO2/V8nF1aKuSLB/CrB9xPEjnMGxIcOxh/pyd/+yibDcPVuMujEydHUz+VN51KnkbwdEBo1efoyhqFncQ8t0lk7bGFNHPdZjLo6nlaRWRq40=
Received: from BN9PR03CA0042.namprd03.prod.outlook.com (2603:10b6:408:fb::17)
 by MN2PR12MB3757.namprd12.prod.outlook.com (2603:10b6:208:15a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 20:11:01 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::73) by BN9PR03CA0042.outlook.office365.com
 (2603:10b6:408:fb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Tue, 19 Oct 2021 20:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 20:11:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 15:10:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/vcn3.0: remove intermediate variable
Date: Tue, 19 Oct 2021 16:10:44 -0400
Message-ID: <20211019201044.426871-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019201044.426871-1-alexander.deucher@amd.com>
References: <20211019201044.426871-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be3a3a69-7f0d-4dd9-795b-08d9933c9239
X-MS-TrafficTypeDiagnostic: MN2PR12MB3757:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3757FB280B925A9507680614F7BD9@MN2PR12MB3757.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZztI4Mhmcp5THI2yNc+R/qe6ZZljqGxVJRXS1B+TWAORaNbvYWejA26YinYUxE4ZrkVVKeqClz1lSgvIEyjSB/l3TYx5bnfj9ze9sM5ISBg+O1Pj6Sku5sLQm0MS1IJU/wUd8AJRFDsknkf1pEiJ6vWIYU0FdF8BuUwXaect7hq7G13xpxT/LLbIgkkYy55ZVJyCYP5KJ0z3VyK6lqObFRp+Z1rDUqUD/fkllUMRPdd0Y8WBetVY5xZlQcFdcy9xKeQm+USubEMOdGWO3f/g7kytDTLi0VDR06sxn6ziboG+bqMEm2w0fiqeKac5oO1ht0CZ+BGoWD+Xk0INhmcMCz2FKjNsocuomV9frz3iZyRmlLyDM3YqYV74j8/2fFDHj1FzMr6ifm8UTGHUFB5pYp3wy9I+/6l6mn3P+WB4rC8TtgtR0r+3xr+akeXfahgKgUluHZLDvdBSFOJgyUpzM1letAJltYjZXq3H7a3WujJFVlWANnieZVZ9/gghmxajWsnG5yWrtxLufVoi7agtXIqB+VHlB6BUrgA85GN4cMLq7zfB6+Cp0xLKjZ7w2IityxRNkUNUngb/VCYYZVla2tTWvZ/c1Mu07OWSAk/p0QY9aX9jPUM+Cb9heTqwgDzxXbTZuUoziZ8N7tfbL0cyXKD8cmTsG2gAfLYtkH9wCJGmEjJe/NBvtVDC42NlYW7IIQCGppB4nVzltVylw8XVERveE6t0ilZpx1KyTCdcIk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(508600001)(356005)(82310400003)(70586007)(70206006)(36756003)(1076003)(336012)(81166007)(26005)(426003)(5660300002)(7696005)(86362001)(83380400001)(6666004)(8676002)(2616005)(36860700001)(4326008)(6916009)(316002)(186003)(2906002)(16526019)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 20:11:00.9777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be3a3a69-7f0d-4dd9-795b-08d9933c9239
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3757
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

No need to use the id variable, just use the constant
plus instance offset directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 57b62fb04750..da11ceba0698 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -60,11 +60,6 @@ static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
-static int amdgpu_ucode_id_vcns[] = {
-	AMDGPU_UCODE_ID_VCN,
-	AMDGPU_UCODE_ID_VCN1
-};
-
 static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
@@ -1278,7 +1273,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 	uint32_t param, resp, expected;
 	uint32_t offset, cache_size;
 	uint32_t tmp, timeout;
-	uint32_t id;
 
 	struct amdgpu_mm_table *table = &adev->virt.mm_table;
 	uint32_t *table_loc;
@@ -1322,13 +1316,12 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
 
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-			id = amdgpu_ucode_id_vcns[i];
 			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
 				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
-				adev->firmware.ucode[id].tmr_mc_addr_lo);
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo);
 			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
 				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
-				adev->firmware.ucode[id].tmr_mc_addr_hi);
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi);
 			offset = 0;
 			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
 				mmUVD_VCPU_CACHE_OFFSET0),
-- 
2.31.1

