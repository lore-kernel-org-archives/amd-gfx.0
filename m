Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40599C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032E0610E8
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032E0610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959CB6EE0D;
	Fri,  2 Apr 2021 06:44:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D196EE0C
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7Zrn27Or5622uUqtpRM3WuQu9KpIoz+sb1L7AaxvtWnMEvdzaaiwFwuzJKYVHU0fMwAk/9CuDT/3EW8OXiI2+rwyYmql7zk6twUxeztmubkJpsKhgPpJ018AdLCV2n4C9tf5Do11LJsSn/yZc/sTvrxk1aoBaOSZicVYVLS0cWDwUmpyYdmmu2CglFbWrgfVxbSKygng4/d9fQdwi6EzNdZFVoclEX/1ihlJU8cOPgZduXN/gBHBxlbwj8fnTKo1UoCcPAE0OkEp/Hn6m/mIGoACBrq8Pov31CsG2L2FMVugR1qg6PvrKkp2EW1sOFypNUVoPQ6EPkMFNq87tIFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1140nqdxdmn6SN2GwSrCp3+iqCk0xNsHC/XoOkx6pAc=;
 b=aZ9OSNXN7ZmF3zZRvpFhHqVOVzR8WgVt5WxvEgHQWmehL3RdeHuPz/TjnE1ehnwq2M2Lw2g9j58anMbcroCKOKEIie/+5ht4j68RC7u1RgmGjoRSmEk0uWDXpSG4MvR9pdfANrQAfY6SSCEqH0cFQHCRcfHeIYifzYIbM6PUXiflfQLTZRRO2NLJzxugcLQtVbcR6zgyJ2vrJBnYPSo6Aujefh/Z1hq4wffmvdG0cwsZnolQ0L5T7uF/k+KYV0o4B00qbp2YB5V8hpqOH8nu9XYb6MPuyEIEe7bGtMeOUT+Zh4afi3xnhPFMC/YEyN0T70vupKLQlhnc0qiX51ursA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1140nqdxdmn6SN2GwSrCp3+iqCk0xNsHC/XoOkx6pAc=;
 b=XTmt9cfkLE8ziWN2fpgWaXphMe6ggvseD5UkTHyH0HilYU+ew7HGnAfuXkhFBuHtgT92pM8FqHlYCOyn1XhLQi3S1rYAKqN7kJC5mptAp277E+OFjlF05FCao/XsvRGTrH2Ji+j7BfDGGkhALkTyqRSIi6hsQOA0HHLERPuPuRA=
Received: from DS7PR03CA0127.namprd03.prod.outlook.com (2603:10b6:5:3b4::12)
 by CY4PR12MB1239.namprd12.prod.outlook.com (2603:10b6:903:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 06:44:11 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::ea) by DS7PR03CA0127.outlook.office365.com
 (2603:10b6:5:3b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Fri, 2 Apr 2021 06:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 06:44:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:44:10 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:44:08 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/11] drm/amdgpu: split umc callbacks to ras and non-ras ones
Date: Fri, 2 Apr 2021 14:43:42 +0800
Message-ID: <20210402064345.14093-8-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064345.14093-1-Hawking.Zhang@amd.com>
References: <20210402064345.14093-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e4ae862-2e44-485e-feca-08d8f5a2b8ec
X-MS-TrafficTypeDiagnostic: CY4PR12MB1239:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1239FE4F6B61F9BAA1DBB661FC7A9@CY4PR12MB1239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lT/DUc6umDKVWoVxKnflO8NsTq1N5jAVVGTB/KgIDnjfesmVjYF9L+s6tMlg5mGjCtdmGomQ/+lrDxcHOFLZTUASBvbz8DaC2QvBkNqQvHYj3LHN5RdWM8GyBG6S1gvxiHocdpXHOF3HJYt8QYw0yC1O1RgYDEYi5/ndkqeuvfeOX7EMXS0T3PXft2SMLsXO+CJPAHfrWAPGMiCWy8nG7VdBw9zu9S4I5GDqDzGhAc0RG3+LOJVXm6YLknJnI0nk1LR25kxByEtGOIGo07rNHgeEn8TDEdfpUij8A5mER40aPyawuwmbY3gBMYYsFTqs35cIP/jmFmu6IeI9tuvK9UHVa2yqGKRUJy4PIwDBpxW7nSQZV17iT21GKQ9LbAYC8pmbCSJn6R6oWNPnheLrTks6TvtVIkwDDl0q21Wt9hkMHvskLiq2lrNxl5It0ItiedkaFQ2DkPqSd+0DLMakHc/wLeWKjqmnHbYVZAjcXc3IRE6EAF4k1xIcYTUm4L6oBKjg9Pjh+/8l8Gq372+hKthffajBt6hd31ObTy4Yh4B0RrppHF93Q9hFWBQHfA1uLp2U7xHme60IwSSc6RSGIAiOBfR3/UZczBFlespmmLn0MZp3h1MuC0W5cGo1elaxwZNLkpsOOFZN4PiGVyqIKVKLXPvvoSn/PPv6NecRzUqQNg3zHV6i2EOEmX9wxfTY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(336012)(478600001)(186003)(30864003)(8936002)(4326008)(82310400003)(2906002)(356005)(2616005)(6666004)(47076005)(82740400003)(8676002)(81166007)(26005)(36860700001)(5660300002)(83380400001)(426003)(6636002)(70206006)(70586007)(7696005)(110136005)(86362001)(36756003)(1076003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 06:44:10.8022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4ae862-2e44-485e-feca-08d8f5a2b8ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1239
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

umc ras is not managed by gpu driver when gpu is
connected to cpu through xgmi. split umc callbacks
into ras and non-ras ones so gpu driver only
initializes umc ras callbacks when it manages
umc ras.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reivewed-by: Dennis Li <Dennis.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 11 ++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 17 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.h   |  2 +-
 12 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 082f9d03a94a..3411c6577a18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -391,8 +391,9 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->umc.funcs && adev->umc.funcs->ras_late_init) {
-		r = adev->umc.funcs->ras_late_init(adev);
+	if (adev->umc.ras_funcs &&
+	    adev->umc.ras_funcs->ras_late_init) {
+		r = adev->umc.ras_funcs->ras_late_init(adev);
 		if (r)
 			return r;
 	}
@@ -418,8 +419,12 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 {
-	amdgpu_umc_ras_fini(adev);
+	if (adev->umc.ras_funcs &&
+	    adev->umc.ras_funcs->ras_fini)
+		adev->umc.ras_funcs->ras_fini(adev);
+
 	amdgpu_mmhub_ras_fini(adev);
+
 	if (adev->gmc.xgmi.ras_funcs &&
 	    adev->gmc.xgmi.ras_funcs->ras_fini)
 		adev->gmc.xgmi.ras_funcs->ras_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 172738cc99db..459a470744f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -774,13 +774,15 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__UMC:
-		if (adev->umc.funcs->query_ras_error_count)
-			adev->umc.funcs->query_ras_error_count(adev, &err_data);
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->query_ras_error_count)
+			adev->umc.ras_funcs->query_ras_error_count(adev, &err_data);
 		/* umc query_ras_error_address is also responsible for clearing
 		 * error status
 		 */
-		if (adev->umc.funcs->query_ras_error_address)
-			adev->umc.funcs->query_ras_error_address(adev, &err_data);
+		if (adev->umc.ras_funcs &&
+		    adev->umc.ras_funcs->query_ras_error_address)
+			adev->umc.ras_funcs->query_ras_error_address(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->query_ras_error_count) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index a2975c8092a9..ea6f99be070b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -60,8 +60,9 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	/* ras init of specific umc version */
-	if (adev->umc.funcs && adev->umc.funcs->err_cnt_init)
-		adev->umc.funcs->err_cnt_init(adev);
+	if (adev->umc.ras_funcs &&
+	    adev->umc.ras_funcs->err_cnt_init)
+		adev->umc.ras_funcs->err_cnt_init(adev);
 
 	return 0;
 
@@ -95,12 +96,12 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-	if (adev->umc.funcs &&
-	    adev->umc.funcs->query_ras_error_count)
-	    adev->umc.funcs->query_ras_error_count(adev, ras_error_status);
+	if (adev->umc.ras_funcs &&
+	    adev->umc.ras_funcs->query_ras_error_count)
+	    adev->umc.ras_funcs->query_ras_error_count(adev, ras_error_status);
 
-	if (adev->umc.funcs &&
-	    adev->umc.funcs->query_ras_error_address &&
+	if (adev->umc.ras_funcs &&
+	    adev->umc.ras_funcs->query_ras_error_address &&
 	    adev->umc.max_ras_err_cnt_per_query) {
 		err_data->err_addr =
 			kcalloc(adev->umc.max_ras_err_cnt_per_query,
@@ -116,7 +117,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		/* umc query_ras_error_address is also responsible for clearing
 		 * error status
 		 */
-		adev->umc.funcs->query_ras_error_address(adev, ras_error_status);
+		adev->umc.ras_funcs->query_ras_error_address(adev, ras_error_status);
 	}
 
 	/* only uncorrectable error needs gpu reset */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 183814493658..bbcccf53080d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -35,13 +35,17 @@
 #define LOOP_UMC_CH_INST(ch_inst) for ((ch_inst) = 0; (ch_inst) < adev->umc.channel_inst_num; (ch_inst)++)
 #define LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) LOOP_UMC_INST((umc_inst)) LOOP_UMC_CH_INST((ch_inst))
 
-struct amdgpu_umc_funcs {
+struct amdgpu_umc_ras_funcs {
 	void (*err_cnt_init)(struct amdgpu_device *adev);
 	int (*ras_late_init)(struct amdgpu_device *adev);
+	void (*ras_fini)(struct amdgpu_device *adev);
 	void (*query_ras_error_count)(struct amdgpu_device *adev,
-					void *ras_error_status);
+				      void *ras_error_status);
 	void (*query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
+};
+
+struct amdgpu_umc_funcs {
 	void (*init_registers)(struct amdgpu_device *adev);
 };
 
@@ -59,6 +63,7 @@ struct amdgpu_umc {
 	struct ras_common_if *ras_if;
 
 	const struct amdgpu_umc_funcs *funcs;
+	const struct amdgpu_umc_ras_funcs *ras_funcs;
 };
 
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 33e54eed2eec..2bfd620576f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -655,7 +655,7 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V8_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V8_7_PER_CHANNEL_OFFSET_SIENNA;
 		adev->umc.channel_idx_tbl = &umc_v8_7_channel_idx_tbl[0][0];
-		adev->umc.funcs = &umc_v8_7_funcs;
+		adev->umc.ras_funcs = &umc_v8_7_ras_funcs;
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ce2b1a9125ea..c353254ea5dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1155,7 +1155,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V6_1_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_1_PER_CHANNEL_OFFSET_VG20;
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
-		adev->umc.funcs = &umc_v6_1_funcs;
+		adev->umc.ras_funcs = &umc_v6_1_ras_funcs;
 		break;
 	case CHIP_ARCTURUS:
 		adev->umc.max_ras_err_cnt_per_query = UMC_V6_1_TOTAL_CHANNEL_NUM;
@@ -1163,7 +1163,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V6_1_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_1_PER_CHANNEL_OFFSET_ARCT;
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
-		adev->umc.funcs = &umc_v6_1_funcs;
+		adev->umc.ras_funcs = &umc_v6_1_ras_funcs;
 		break;
 	default:
 		break;
@@ -1194,12 +1194,6 @@ static int gmc_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	gmc_v9_0_set_gmc_funcs(adev);
-	gmc_v9_0_set_irq_funcs(adev);
-	gmc_v9_0_set_umc_funcs(adev);
-	gmc_v9_0_set_mmhub_funcs(adev);
-	gmc_v9_0_set_gfxhub_funcs(adev);
-
 	if (adev->asic_type == CHIP_VEGA20 ||
 	    adev->asic_type == CHIP_ARCTURUS)
 		adev->gmc.xgmi.supported = true;
@@ -1210,6 +1204,12 @@ static int gmc_v9_0_early_init(void *handle)
 			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
 	}
 
+	gmc_v9_0_set_gmc_funcs(adev);
+	gmc_v9_0_set_irq_funcs(adev);
+	gmc_v9_0_set_umc_funcs(adev);
+	gmc_v9_0_set_mmhub_funcs(adev);
+	gmc_v9_0_set_gfxhub_funcs(adev);
+
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =
 		adev->gmc.shared_aperture_start + (4ULL << 30) - 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 96d7769609f4..20b44983ac94 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -22,6 +22,7 @@
  */
 #include "umc_v6_1.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_umc.h"
 #include "amdgpu.h"
 
 #include "rsmu/rsmu_0_0_2_offset.h"
@@ -464,9 +465,10 @@ static void umc_v6_1_err_cnt_init(struct amdgpu_device *adev)
 		umc_v6_1_enable_umc_index_mode(adev);
 }
 
-const struct amdgpu_umc_funcs umc_v6_1_funcs = {
+const struct amdgpu_umc_ras_funcs umc_v6_1_ras_funcs = {
 	.err_cnt_init = umc_v6_1_err_cnt_init,
 	.ras_late_init = amdgpu_umc_ras_late_init,
+	.ras_fini = amdgpu_umc_ras_fini,
 	.query_ras_error_count = umc_v6_1_query_ras_error_count,
 	.query_ras_error_address = umc_v6_1_query_ras_error_address,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
index 0ce1d323cfdd..5dc36c730bb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
@@ -45,7 +45,7 @@
 /* umc ce count initial value */
 #define UMC_V6_1_CE_CNT_INIT	(UMC_V6_1_CE_CNT_MAX - UMC_V6_1_CE_INT_THRESHOLD)
 
-extern const struct amdgpu_umc_funcs umc_v6_1_funcs;
+extern const struct amdgpu_umc_ras_funcs umc_v6_1_ras_funcs;
 extern const uint32_t
 	umc_v6_1_channel_idx_tbl[UMC_V6_1_UMC_INSTANCE_NUM][UMC_V6_1_CHANNEL_INSTANCE_NUM];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 3c3fb01b7c20..3a8f787374c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -22,6 +22,7 @@
  */
 #include "umc_v6_7.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_umc.h"
 #include "amdgpu.h"
 
 #include "umc/umc_6_7_0_offset.h"
@@ -272,8 +273,9 @@ static void umc_v6_7_query_ras_error_address(struct amdgpu_device *adev,
 	}
 }
 
-const struct amdgpu_umc_funcs umc_v6_7_funcs = {
+const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs = {
 	.ras_late_init = amdgpu_umc_ras_late_init,
+	.ras_fini = amdgpu_umc_ras_fini,
 	.query_ras_error_count = umc_v6_7_query_ras_error_count,
 	.query_ras_error_address = umc_v6_7_query_ras_error_address,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index e59dbdb6ef9b..4eb85f247e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -32,6 +32,6 @@
 
 #define UMC_V6_7_INST_DIST	0x40000
 
-extern const struct amdgpu_umc_funcs umc_v6_7_funcs;
+extern const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index a064c097690c..89d20adfa001 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -22,6 +22,7 @@
  */
 #include "umc_v8_7.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_umc.h"
 #include "amdgpu.h"
 
 #include "rsmu/rsmu_0_0_2_offset.h"
@@ -323,9 +324,10 @@ static void umc_v8_7_err_cnt_init(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_umc_funcs umc_v8_7_funcs = {
+const struct amdgpu_umc_ras_funcs umc_v8_7_ras_funcs = {
 	.err_cnt_init = umc_v8_7_err_cnt_init,
 	.ras_late_init = amdgpu_umc_ras_late_init,
+	.ras_fini = amdgpu_umc_ras_fini,
 	.query_ras_error_count = umc_v8_7_query_ras_error_count,
 	.query_ras_error_address = umc_v8_7_query_ras_error_address,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h
index d4d0468e3df5..37e6dc7c28e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h
@@ -44,7 +44,7 @@
 /* umc ce count initial value */
 #define UMC_V8_7_CE_CNT_INIT	(UMC_V8_7_CE_CNT_MAX - UMC_V8_7_CE_INT_THRESHOLD)
 
-extern const struct amdgpu_umc_funcs umc_v8_7_funcs;
+extern const struct amdgpu_umc_ras_funcs umc_v8_7_ras_funcs;
 extern const uint32_t
 	umc_v8_7_channel_idx_tbl[UMC_V8_7_UMC_INSTANCE_NUM][UMC_V8_7_CHANNEL_INSTANCE_NUM];
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
