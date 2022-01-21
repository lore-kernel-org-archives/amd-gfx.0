Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C656C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 09:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EACF10E9AC;
	Fri, 21 Jan 2022 09:34:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2892610E9AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 09:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0ZH8E/Uo2Tmh3E97hdlQUyf7htVFwTw/uPWPdUTcT1cHiby3Sw9lvjT/HoarxEpS6KazDuHLgL10++g5I3rt/miH+nguw5wF0zpaXXna7FaTefE7QixNsPXo5dMOfn6ofO0+4ceFrD1bvwuTbETgnww7z6wAeYjyvUAXezbRqvjPB1GOuXtHn8n1dZO7j7agKuG5lAKQpbUvMjBccR/b1azLMpOav2kXa6cT4gk4UqXu555xSGwe7K/1/tHOTlIAbZKBFcFeZNSffYe+b4gCdv7J+av20wDrnWKcGEt6/AKZj39qsU+jDEx1lMSkiepswVvQzp3FkbYAKqJpW6nWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upHSBJz3UsTyWTINhSne23Uv+iBgziucmAMtCZnm5jA=;
 b=gWenpUt8kfcNmi7VpQchrKm5fSAgMy35w8dqBD/3NRO+quPTJvUSBxW6b6lEs4W38twIehJQNSuH9WjDBR1X7P410hXQ76faATsLtOi5cMVI2xHlDSaRXYTVPkWfuQXgy6HhOIbeBCb0r7nCVxx4tnFRmuPV1FJtx6bB3TzXgJ4eAZPjTFXZ4zYwQncXGX0Kv5OxjX3V7ytnFIQhVQ9jNlD9k55MU/bE+tK+ZpL43fWOK9snFC2TZjzuME9YxLAmcuisJr+ONtdLEhMYLyiHCuQ0nyslwjZjchHKpbBPRyYd21Ps99QFNMlNVcTuKbyuRQVRAhF5yT9pNQhAY6FCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upHSBJz3UsTyWTINhSne23Uv+iBgziucmAMtCZnm5jA=;
 b=FpvByfbCHQwZQzIURlkD+qgXEp7YsQEHkuquyII12MKd2bV8DsQLHr5WNbqa6YAKRdnFw5wiPYHYFUierj87xxjQpx9f82o+887hlCFC6UQrQ7vi8BRBr4gQBnLs0dFxjF11NP2wl3VHnkNyaRToAkn6pX2S+s6EZI1waDwgS+4=
Received: from MW4PR03CA0132.namprd03.prod.outlook.com (2603:10b6:303:8c::17)
 by MWHPR1201MB0237.namprd12.prod.outlook.com (2603:10b6:301:56::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 09:34:45 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::aa) by MW4PR03CA0132.outlook.office365.com
 (2603:10b6:303:8c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Fri, 21 Jan 2022 09:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 09:34:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 03:34:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 03:34:42 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 03:34:41 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Mohammadzafar.Ziya@amd.com>, <John.Clements@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix channel index mapping for
 SIENNA_CICHLID
Date: Fri, 21 Jan 2022 17:34:39 +0800
Message-ID: <20220121093439.29089-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e61444d-28b8-4b99-c400-08d9dcc14265
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0237:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB023799BF477621290DA766459A5B9@MWHPR1201MB0237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXV53usLsYu04W/G3Z760Sg/AlpHqCu3tqVojTm4lzjfgwDiC6+d6ycAR3mnwuLVNqxhHiL0dYP/VqbwO9cZQzIksn+ROEfBXkAs113uRXoTvQC/xZw4rCg1iIrz/8uOwKcBvtN4keXFJ9pAyaDS7nmzQw2XuXsXmgUY7OW9hIMScVX6QPux5KIfhSxTT9KaAoA19I8eDLJKTlmlV91Q9xMvOKY2YRIh/j1mO8+N3A+bTwfviNojsh+2wPiRtZ+b/9h1hcgKbIgw0nVhsbSDYua+JEOURZjMHcFD4FTd7hodvYVTdnoTMHTyTYnPTeIY/u2Lqp1SV1w7DOvenFIH4/bq3kDNXgfz3eNd4uwDgr4oXIqYnCVYZHOKtqtXRTvgFvsRtbnU14p0xKEPbYnbgUlY6S1yGKR+tQOd9wvN3Pbt160Je/QMtWdCxy9kG86C36e6fcKak+GUVIgoyLN4LKouky8Zu0zSkPYPj7AJq/8g/RYmByPQQnc9/eEAd3oRxYcRr7w/01lRhIXCuepMRKSQvTNaBirpqZlvPvj/iEnCG3OUVpNJSv8/PR0weHJqp6J1lnKT4krTZIY98BtVI6DThuGWyVLzGv8xUZIt0PS5SID7NTl0oRqT4cfA5NSUFinrItcEgErSTmHF4Mezvzw5utTlyXFOV+G6pyXZTcrgJHjHILVWhWufqiamdGAUygV8PJPhVezFmfKb6BwRcG4w1MVQt/EkW12sDZoDohaH7JN+CgmGeZBx9SwAPk40vw5/Ok8G3sPMZ17UhXYaiwdjV5gJz3B4bE0lKbEEj1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(82310400004)(1076003)(2616005)(70206006)(36756003)(70586007)(508600001)(8676002)(6636002)(8936002)(336012)(4326008)(40460700001)(426003)(36860700001)(86362001)(356005)(186003)(2906002)(26005)(5660300002)(47076005)(316002)(83380400001)(7696005)(110136005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 09:34:44.8837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e61444d-28b8-4b99-c400-08d9dcc14265
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0237
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pmfw read ecc info registers in the following order,
     umc0: ch_inst 0, 1, 2 ... 7
     umc1: ch_inst 0, 1, 2 ... 7
The position of the register value stored in eccinfo
table is calculated according to the below formula,
     channel_index = umc_inst * channel_in_umc + ch_inst
Driver directly use the index of eccinfo table array
as channel index, it's not correct, driver need convert
eccinfo table array index to channel index according to
channel_idx_tbl.

Change-Id: I26c3a99d161a00a69f7d00bd177942b6cd65a0de
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 29 ++++++++++++++++-----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index cd57f39df7d1..d70417196662 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -55,29 +55,36 @@ static inline uint32_t get_umc_v8_7_channel_index(struct amdgpu_device *adev,
 }
 
 static void umc_v8_7_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
-						uint32_t channel_index,
+						uint32_t umc_inst, uint32_t ch_inst,
 						unsigned long *error_count)
 {
 	uint64_t mc_umc_status;
+	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
+
 	/* check for SRAM correctable error
 	 * MCUMC_STATUS is a 64 bit register
 	 */
-	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
+	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
 		*error_count += 1;
 }
 
 static void umc_v8_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_device *adev,
-							uint32_t channel_index,
+							uint32_t umc_inst, uint32_t ch_inst,
 							unsigned long *error_count)
 {
 	uint64_t mc_umc_status;
+	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
+
 	/* check the MCUMC_STATUS */
-	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
+	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
@@ -94,20 +101,16 @@ static void umc_v8_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
-	uint32_t channel_index   = 0;
 
 	/* TODO: driver needs to toggle DF Cstate to ensure
 	 * safe access of UMC registers. Will add the protection
 	 */
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		channel_index = get_umc_v8_7_channel_index(adev,
-							umc_inst,
-							ch_inst);
 		umc_v8_7_ecc_info_query_correctable_error_count(adev,
-							channel_index,
+							umc_inst, ch_inst,
 							&(err_data->ce_count));
 		umc_v8_7_ecc_info_querry_uncorrectable_error_count(adev,
-							channel_index,
+							umc_inst, ch_inst,
 							&(err_data->ue_count));
 	}
 }
@@ -120,12 +123,14 @@ static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
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
@@ -140,7 +145,7 @@ static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
 
-		err_addr = ras->umc_ecc.ecc[channel_index].mca_umc_addr;
+		err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 
 		/* translate umc channel address to soc pa, 3 parts are included */
-- 
2.17.1

