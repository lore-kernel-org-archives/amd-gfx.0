Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5931CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 03:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48EF610E221;
	Fri,  9 Dec 2022 03:49:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2227010E03C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 03:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdjX1odsXYCAcQV1a5Y3rPbjHnpDaBtPSioOtARMNKLzVAVkURpzccye3dMEISmjxeA+wecwmAyo65/pZc6Uq2J/kkEmDpuoply5zcxKfu+E2oOvYSXyuBiOHK/Rptuc6WQpVdqEIkZ0NYsowUcGHNpx66u+JTAoqf0282XxQTNhY2NYvixPe1w793QEKy3TuDPIXCQ+xI0lbcga+R/ul0is7CiGH8p6bCG+6hloT1EvDtB7LfLW+ArpSKJitzU3ra1aotaHavrPFznCWEYzFrtiGoWSAbTyly5eVEchypfoSd5wA6+us1fu9jlGMzn5lO8WDRd1mgJI6sw4nhgcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXWQIamqOmE/xYEC6NrtTnKe4aXLW0iZyyjeuBl6naY=;
 b=nVNFO2yKWSCqeKQTdMr0yXrucJ0kXRtY4+bCbwsYEz/E59ppqHtvxRRkVGPx9WGzkd6hS7VSQtvx8oBiyBO4S47FdFFjuQLbMoN2H2noL3WysblyLtgyn7M8dzhrH4JiQrdoAdb7TpKqmpcnG/7UqrB+zrtciOwtf9QxtzZF4g0OzimOuWleaQiCYZ5VcDJfYH5xoNOCx/1/bDaiWz1/eJn3yTlH7LDVgCPJghmCJaPw78iO3vlL9ZXlU3uHli/8TgnJP+zbxGKO1P4/YCWVuMWDgAwTeHmkRRAWUu5oIsayoreSu9KVHxXsCjO1Xssy9vnbifU/eCwRnP8mqgVxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXWQIamqOmE/xYEC6NrtTnKe4aXLW0iZyyjeuBl6naY=;
 b=EgqneWwWTyjJYRrib+qGvy/cS3CuLAkSPqdATlfrjHbc3ADk18fKb006Y6ZocbSaIORZsXDwWIw+F81mzhYJkNbzzTV7r7WdOkQRUcccZB+jlRrnEWWRrzCv/AuMsIhNXdEBkM9fmh9HbpNFjnLacMudc8zn2WM+3IVQrcBKL38=
Received: from BN8PR16CA0006.namprd16.prod.outlook.com (2603:10b6:408:4c::19)
 by DM8PR12MB5463.namprd12.prod.outlook.com (2603:10b6:8:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 03:49:08 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::b8) by BN8PR16CA0006.outlook.office365.com
 (2603:10b6:408:4c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 9 Dec 2022 03:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 03:49:08 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 21:48:47 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/10] drm/amd/pm: drop unused SMU v13 API
Date: Fri, 9 Dec 2022 11:48:07 +0800
Message-ID: <20221209034813.2373727-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209034813.2373727-1-evan.quan@amd.com>
References: <20221209034813.2373727-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|DM8PR12MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: dd84262c-8aee-4b25-ff55-08dad9985342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyJtWw23hX7GkgBb8mf3PoVpWUhGz04QpEUgYqs7wfxV6wvrE9cmm+sFISUJY9jiQwsixAsYn5t1+K3mfGCW+rnYHejcRP+5NjI/qOfq7qCFu11JQiCDIiKgWJ6x5kHDnsDie9lgw9w+3xTc/RGz/WgdmRUX1PazHQkCCPtOgQh89xz3crFVs32nMFu6eiwA8vWR1EzTbq2rdDrtiQViiQCaY+afNMON5Pz15MRu+tHOeBN6XEOME4QSXGFzWrUMVDc6m17El/xZlXX/11Fi/jwR2Iu+CnrgCVZR9L3VEgGkyFr7eEQg7T+Jhohf2hyJa/tXuc4dtTz6+uJhiSU72letyqg9tQIRGn4h9YRIE48hMQl4eL4fpF01Z6zmH//UuVq8p7/IzNhc3xH1JOXKufUQ7QiHzBNpzA4002+FzKq8cchsk+eCeHddh7RHuYVyhsbedL6B+YnbegEMa1QJhd7wzUd18K+RvUl7E8411wltMoKtp1HxAL8SaUr5+I46cKfqQAsXWlco7/PuEdlXN/LjyB4P//hQZZOUHBinpDKBx1OxhALvZcZhMHf9N/sY2+yCOPreKs4gyu1nj0AfI93/I3505z1fyQTEbGkf2iY5FMJKUQtCKF9FlIS4xyO4Rqy55xadyT6VXf8bpRiJUBaWJechipeb9xEkiX4baa2NMO54lyvLs12wCr8JKye/J4YAEQx8u2T0lQT4ueVTCLfkCXcqAwNx93GzuVVKa70=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(478600001)(8936002)(86362001)(356005)(2906002)(70586007)(81166007)(44832011)(5660300002)(4326008)(82310400005)(70206006)(8676002)(16526019)(1076003)(41300700001)(426003)(7696005)(6666004)(26005)(336012)(186003)(47076005)(2616005)(82740400003)(40480700001)(6916009)(316002)(40460700003)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:49:08.0877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd84262c-8aee-4b25-ff55-08dad9985342
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5463
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The API is not in use. And it's unlikely to be used in
the future either.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I7ace04dda5752d940fdd630e6b86879f748a3ac8
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  5 ---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 39 -------------------
 2 files changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 46d472310b7e..1c9c5dfc8b51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -244,11 +244,6 @@ int smu_v13_0_set_single_dpm_table(struct smu_context *smu,
 				   enum smu_clk_type clk_type,
 				   struct smu_13_0_dpm_table *single_dpm_table);
 
-int smu_v13_0_get_dpm_level_range(struct smu_context *smu,
-				  enum smu_clk_type clk_type,
-				  uint32_t *min_value,
-				  uint32_t *max_value);
-
 int smu_v13_0_get_current_pcie_link_width_level(struct smu_context *smu);
 
 int smu_v13_0_get_current_pcie_link_width(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 38517fe3317d..fbc138203fd2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2062,45 +2062,6 @@ int smu_v13_0_set_single_dpm_table(struct smu_context *smu,
 	return 0;
 }
 
-int smu_v13_0_get_dpm_level_range(struct smu_context *smu,
-				  enum smu_clk_type clk_type,
-				  uint32_t *min_value,
-				  uint32_t *max_value)
-{
-	uint32_t level_count = 0;
-	int ret = 0;
-
-	if (!min_value && !max_value)
-		return -EINVAL;
-
-	if (min_value) {
-		/* by default, level 0 clock value as min value */
-		ret = smu_v13_0_get_dpm_freq_by_index(smu,
-						      clk_type,
-						      0,
-						      min_value);
-		if (ret)
-			return ret;
-	}
-
-	if (max_value) {
-		ret = smu_v13_0_get_dpm_level_count(smu,
-						    clk_type,
-						    &level_count);
-		if (ret)
-			return ret;
-
-		ret = smu_v13_0_get_dpm_freq_by_index(smu,
-						      clk_type,
-						      level_count - 1,
-						      max_value);
-		if (ret)
-			return ret;
-	}
-
-	return ret;
-}
-
 int smu_v13_0_get_current_pcie_link_width_level(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-- 
2.34.1

