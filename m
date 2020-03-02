Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2067FC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 10:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7B321739
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 10:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XKVJENRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7B321739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0056E27A;
	Mon,  2 Mar 2020 10:34:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 162046E27A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 10:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nmw1U2gL953pr2izEefr80Hre1ypm2s8cdpWsqdNEN9tb1oTB/AbZeG7ti8PFsX2CACJhOGE1vSifaptEk5pvVlq8aUjr2jWDzKi+ugg74YCjR+kT4BuOBiBb51EK1cSZ3lizCxTBbNgq+LNbFHyrHRjueszB/bl2x45sucEBsdYihanyZqSfmxRm/t84MqMAzO7egcA6TowKq+r0iw5sLUpgrKvEW/pH5VTKeshVZFpXqCmhgxjFfvkJfpQkQqG5kmjCEJxurk0NWem/PsksfjbbdWhyIYaiP6+32QibFRwEjsq3X89XIWVNK04biIhzpnEZiJgpoWkUHNYrpRADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLfxzsr+7zWFlUZT2HL6KK116jBh3+MFPZCl0Fjgm+Y=;
 b=ZWW9yj1i0omoiApsLviTR5GIjq+CFRDq021ODuKYBePm1AoSHy38HhYYiocqz6FzXCli7vBHGt8F4AWuOchoKlQSU0DHHJ7o+tkoAP+C5zwRfGEMgN9xUnOQJzzbiJFhNhhbzQ4XQK5f5X+iQIupJrIdU0nPDCtET91catHN1L1hV7TqZrb1MAx0PuSEcmEDSfC+rHt799UMe/D/4x4Tg4PHTGf537nCZr50eClaP2ZIHpbXsX9oq/DCkFQTsFLZpraqbjdHgWbBifiipsZDbeevclD6tUOi1gTYsUeqAOdM1vIVqj5HqXHEPQ4+O9pNPAjt5WXLkiAV4Qg6dlROFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLfxzsr+7zWFlUZT2HL6KK116jBh3+MFPZCl0Fjgm+Y=;
 b=XKVJENRoLO+6qFi3oVd3M13RY22StfaAXnOleYjpIF6+gWTJs8jup7yH8DAcxEhUDXzy2WJbqAEmbHaqHfT/GM60YBMb/GF4GNuaEUeRUXOy2YFJr7EDMCBERUTmO8NJvl+ht0MVM1sEadqj95riM7Nnc0oGtWF3m6wAFdqVi3g=
Received: from CO2PR04CA0116.namprd04.prod.outlook.com (2603:10b6:104:7::18)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 10:34:28 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::61) by CO2PR04CA0116.outlook.office365.com
 (2603:10b6:104:7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Mon, 2 Mar 2020 10:34:27 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 10:34:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 04:34:26 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 04:34:24 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 04:34:22 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Guchun Chen <Guchun.Chen@amd.com>, Tao Zhou
 <Tao.Zhou1@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add reset_ras_error_count function for SDMA
Date: Mon, 2 Mar 2020 18:33:36 +0800
Message-ID: <20200302103339.31723-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302103339.31723-1-Hawking.Zhang@amd.com>
References: <20200302103339.31723-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(428003)(189003)(199004)(81166006)(81156014)(8676002)(26005)(6666004)(7696005)(6636002)(356004)(2616005)(426003)(5660300002)(316002)(110136005)(4326008)(70206006)(70586007)(186003)(336012)(2906002)(478600001)(86362001)(36756003)(1076003)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4114; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70bd2801-5de2-46f7-7ab6-08d7be9548d6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4114:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4114574966E422C4AA9EA20FFCE70@BY5PR12MB4114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKvRCfYH6SuAdrUdJ7tC01AQIm03lQP8YC38ezrRyayTGMmVblPgVZPVyTqrFBX4HNSWgxzctwe9D8TgAtKFkAxWPXEvGhoqaJPwVY7JuD9XfnQl5Fp6EqvM5Q27J2rKuX1OxNmYTx0U8gdensX8Ky/nicPcNLTK+aRXIH2CVUy+97vaARWZZGjBbqLGe0ZXakOucQJhCbH3Z4g8LI8YKS6AH1H7SMSr35+oxU8hjj98Fj6lncon+mVhdkwevc1S8FX5HuGTDouOOkhJJ3fwfBrfBOVBRnVnOBUMcqm7W9GOOZNg7re2WjSoiLksoltUPEKF1HcXBGA0dBbei+TecjiGQyLwS+1TK43DepiEsLAAVce8cbc/44a4erZGXARCI601V1wjU7BEY4aLV4ZorTXediqjln7Ic0MmVIFUz+brVsXpIsoUWIB3YIe8sj5e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 10:34:27.6045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bd2801-5de2-46f7-7ab6-08d7be9548d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA ras error counters are dirty ones after cold reboot
Read operation is needed to reset them to 0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index ee0ca996da0d..2f4412e030a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -56,6 +56,7 @@ struct amdgpu_sdma_ras_funcs {
 	void (*ras_fini)(struct amdgpu_device *adev);
 	int (*query_ras_error_count)(struct amdgpu_device *adev,
 			uint32_t instance, void *ras_error_status);
+	void (*reset_ras_error_count)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_sdma {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 5d49253f8449..80734b5cc8b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1802,13 +1802,9 @@ static int sdma_v4_0_late_init(void *handle)
 	struct ras_ih_if ih_info = {
 		.cb = sdma_v4_0_process_ras_data_cb,
 	};
-	int i;
 
-	/* read back edc counter registers to clear the counters */
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
-		for (i = 0; i < adev->sdma.num_instances; i++)
-			RREG32_SDMA(i, mmSDMA0_EDC_COUNTER);
-	}
+	if (adev->sdma.funcs && adev->sdma.funcs->reset_ras_error_count)
+		adev->sdma.funcs->reset_ras_error_count(adev);
 
 	if (adev->sdma.funcs && adev->sdma.funcs->ras_late_init)
 		return adev->sdma.funcs->ras_late_init(adev, &ih_info);
@@ -2575,10 +2571,22 @@ static int sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 };
 
+static void sdma_v4_0_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	int i;
+
+	/* read back edc counter registers to clear the counters */
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++)
+			RREG32_SDMA(i, mmSDMA0_EDC_COUNTER);
+	}
+}
+
 static const struct amdgpu_sdma_ras_funcs sdma_v4_0_ras_funcs = {
 	.ras_late_init = amdgpu_sdma_ras_late_init,
 	.ras_fini = amdgpu_sdma_ras_fini,
 	.query_ras_error_count = sdma_v4_0_query_ras_error_count,
+	.reset_ras_error_count = sdma_v4_0_reset_ras_error_count,
 };
 
 static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
