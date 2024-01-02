Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08025C47074
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A56CB10E111;
	Tue,  2 Jan 2024 03:45:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 356BB10E111
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COq0o8CwKqNSnWMtICaw5Z4sK3lhqyXubapv8h4VDwDRQ61FynloyiTpw43JNft5udgm1+gc7yVeekP7EkzHUMk9O7/gCn9os2C9IQmWVR6cEjTRKf4Db7gsezgApm/QjslQeyOthwl7Xc75NIkUDwk0JYwdrkQyIOnG+WP/uXNjsgmohWX5mXMh37VoHBGnXg7YfkuHcpHTVLyBd/a3rEWouBaL8iyGgj2lMMK9sZGL+SXVNG4zbgx5SviE3nVKdhnhzLdJWFkpFXKqXyTWyBi5Euz12xJsWIyFU4+b+AEsmC87G9FaE+UArgGDeK+sR6Yndels0Yk2EDDNjzJDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHqz5dKCvDF6ROd4xDVdjTfftYGo3xV5vpbyD0Boj+A=;
 b=FQLCsR+mAwxhdwFjUv5eWbFBwbXEwV7RZAl+twzHIheU2XNWiqkA+TyuzLJc1aE7J0LO9Wz4Tlc86gnMX/rSsGW9ycFI9iwzXPFkSrQ9K+cDKHGYutoCgpExSlA2VH9Tu6Bpf4baa7JhIXp+DE6L3kEgkPOyYnAKaQtsZahVBZdd+A7WRWv0dKn5pRbleRAIctSM+vq8mVcgI6XIRk5rXvcoPjAersVimTE4KkteAFzUaMnn5Dt8Rjitb1RGlpOIdNEQCkADs8J/9Af823Gq30eOzLNa3zGcFO/FhxFR/jFxDuKK1i/4POrT26zbD3SeSzJzafJUK13ZZu+U1IVRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHqz5dKCvDF6ROd4xDVdjTfftYGo3xV5vpbyD0Boj+A=;
 b=ZOufOEZPKQV6Dyq17kIOVT8WnjggsgXmclhAuQD1tCW3xlRQvhvxQ7NiefBzvkyc8lEtd2pBqics45X13Fm/E7HTVQLSGUOnK7xacWxf5cgdtS+nYYfb248ajMgSzzN5/U2hIxaDd4QwK30BwiLrhVVu8vl4v0aRHmEWzRtb/Hk=
Received: from SJ0PR03CA0157.namprd03.prod.outlook.com (2603:10b6:a03:338::12)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4cc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 03:44:57 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::1a) by SJ0PR03CA0157.outlook.office365.com
 (2603:10b6:a03:338::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 03:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:44:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:44:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:44:55 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:44:53 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
Date: Tue, 2 Jan 2024 11:44:39 +0800
Message-ID: <20240102034440.16376-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102034440.16376-1-Hawking.Zhang@amd.com>
References: <20240102034440.16376-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe8c078-b7ba-46a9-8435-08dc0b45302f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2YaW8XVbvEc0UO9nL3B92GhZaNrt8Ke/K0kZ/b006s1rddDc34DNKydpKeyGSr1d/SFmY+KdSD+WGq11SanYY/wUzSk/R9TdTw2IVHXT03TN50W35apu4JLVERy3IjU4XOJ2+BOh9nywjMTBJxDf4xqrplbHHg7W7cWW5H8ZZhoS1bMJclaKeoO6V/y22PV14ffV0gnXJACKGEdK51etZPzSAWdvHq4qpXiy18oGDj65+J0VuPzuG7cjaO1SFWKbCacHAMeRXWY4VMp5yGQZZpyiciy0cwMGPE0vPHT9uq+Vp0Dp0JDGJ4YM3wafxxOPUTEkStUFgMtGtRDaYbEmCDQiDptolLKcSv3S68ezoQiKxkT5XVlsizLcqJ8Fs6S8a/9UcRDnERkXtjRglgs9rNNnXghKWvcQk6kZWqstSUZfrfb5puRW14EReVYekHR6Y+mlcBsOCMfw5EuHoXIfGt9OMwTAh6kOBhmPf5dgPem2DSmpWzHcSDhA/36wynYedPFK5liVxQLhyQICDieTjgmv1cM5vdI/WA+wfAzvw7NPrVDzQ/UjDyc56vpd40fP6wEn1RmELT/w+lzpE/NqbncuRc0dJgb9QWcnlNklzMJnRDQ30QWYPUpN3KTZzDoiujfzZWI3eYA6HfjocIMPHk2dIcKm2NZ+6GudCYiRXEgInolSTU29ti2u6iAumEl8F0b+Mgxl8T1c3uPQ3QQomh8kW4wsTT28CWAd1xndasm4eR2yKpuPDkrwKM6Bp2y76GH2ww6ZZgX2sre/vJPPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(36756003)(40480700001)(40460700003)(7696005)(70586007)(70206006)(86362001)(426003)(336012)(83380400001)(41300700001)(82740400003)(81166007)(356005)(1076003)(26005)(2616005)(47076005)(2906002)(5660300002)(4326008)(6666004)(478600001)(6636002)(36860700001)(316002)(110136005)(54906003)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:44:56.7586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe8c078-b7ba-46a9-8435-08dc0b45302f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of traditional atomfirmware interfaces for RAS
capability, host driver can query ras capability from
psp starting from psp v13_0_6.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 26 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 94b536e3cada..8a3847d3041f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2125,6 +2125,19 @@ int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev)
 	return ret;
 }
 
+bool amdgpu_psp_get_ras_capability(struct psp_context *psp)
+{
+	bool ret;
+
+	if (psp->funcs &&
+	    psp->funcs->get_ras_capability) {
+		ret = psp->funcs->get_ras_capability(psp);
+		return ret;
+	} else {
+		return false;
+	}
+}
+
 static int psp_hw_start(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 09d1f8f72a9c..652b0a01854a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -134,6 +134,7 @@ struct psp_funcs {
 	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*vbflash_stat)(struct psp_context *psp);
 	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
+	bool (*get_ras_capability)(struct psp_context *psp);
 };
 
 struct ta_funcs {
@@ -537,4 +538,5 @@ int psp_spatial_partition(struct psp_context *psp, int mode);
 int is_psp_fw_valid(struct psp_bin_desc bin);
 
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
+bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 676bec2cc157..722b6066ce07 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -27,6 +27,7 @@
 #include "amdgpu_ucode.h"
 #include "soc15_common.h"
 #include "psp_v13_0.h"
+#include "amdgpu_ras.h"
 
 #include "mp/mp_13_0_2_offset.h"
 #include "mp/mp_13_0_2_sh_mask.h"
@@ -770,6 +771,30 @@ static int psp_v13_0_fatal_error_recovery_quirk(struct psp_context *psp)
 	return 0;
 }
 
+static bool psp_v13_0_get_ras_capability(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	u32 reg_data;
+
+	/* query ras cap should be done from host side */
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
+	if (!con)
+		return false;
+
+	if ((amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) &&
+	    (!(adev->flags & AMD_IS_APU))) {
+		reg_data = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_127);
+		adev->ras_hw_enabled = (reg_data & GENMASK_ULL(23, 0));
+		con->poison_supported = ((reg_data & GENMASK_ULL(24, 24)) >> 24) ? true : false;
+		return true;
+	} else {
+		return false;
+	}
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.wait_for_bootloader = psp_v13_0_wait_for_bootloader_steady_state,
@@ -792,6 +817,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.update_spirom = psp_v13_0_update_spirom,
 	.vbflash_stat = psp_v13_0_vbflash_status,
 	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
+	.get_ras_capability = psp_v13_0_get_ras_capability,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.17.1

