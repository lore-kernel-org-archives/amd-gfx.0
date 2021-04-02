Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FA8C43460
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E776E610CB
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E776E610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6186EE0B;
	Fri,  2 Apr 2021 06:44:08 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700075.outbound.protection.outlook.com [40.107.70.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60AF56EE0B
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMsxZjj3wZZpG3H99rnEHWxBTa45ysDp+30LkVzUt/1k9GQbRkKWsgT9e1BtDC6DpI+/zSNwoNAQnIitKmmELz22MSOmQuk1OdfQfRU4tSjGYg2rWNo6G4KuQ1eYNlLtiiTypOtubzYXJdAB0Tj2ALvMCEGrVlWQ4/8JUaAVm3XrWdfqGQOmC0uMK+nDz40LkpgVKsOqcrvnH9LgAhCuLUydQTq1PqGZ4eCllhkkwu6hgpJyujpHv3KUqo8uUxdVJUx24+0p+IN3vyjJ8FrBDgQm4MWyfZaA2kBi8M1X10Ciltxw0xZSouWHeWblq260h8GoqeMTXSI/hT9bAhMKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaOFZxT+KAURJI1U9/sVbP/gVFdxSa4AwQfwg+nBfB8=;
 b=g+WGscT18Zd/MFw2OUX1dzDQxwdlng1zs4EV7rbPs1SunmBHSJjLZALPvuxfN2J2RYOhTe05ZqUnQof2I8lmW64SOroI6am9JKdtGpMZF/nxpQ0lonx04795TTa95l5st/4tHVtQ84Z0aE3OvxYYeS8eMupUYDqtw8OG9eiWLgYnOtF7e9Miw5Y/nj08xwbNfTnadY8fm11DcM690VGi3H+ZvgeZ3SEjKlRAYVwenLeobB4t/DUR40Y4083TWaoemM58CsyoqXEC6u+MVrZ5VMJAnIwH0IosVkZFBBVegT6/5cdlzEBcToR5pWv5csovqhvwpllqakGGsN/bd3QN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaOFZxT+KAURJI1U9/sVbP/gVFdxSa4AwQfwg+nBfB8=;
 b=hndjA1pjTMy+Mo1DNBnpM/JUpEpzjR/nuufnrhVWTDIBcIYo6FvBq60VYSRet6ut5zlkZq9e2Keo2XsmwV3YX7T9Pa1nORMJGZKCaLYVxAM5jEpUolpmt3V2r9jj9rKkm1HNVjvT/ecEOWaOP9MdrZNHMzFQin6n2WqGWsA4wmQ=
Received: from DM5PR04CA0040.namprd04.prod.outlook.com (2603:10b6:3:12b::26)
 by CY4PR12MB1814.namprd12.prod.outlook.com (2603:10b6:903:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 06:44:03 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::f6) by DM5PR04CA0040.outlook.office365.com
 (2603:10b6:3:12b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Fri, 2 Apr 2021 06:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 06:44:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:44:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:44:02 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:44:01 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/11] drm/amdgpu: implement query_ras_error_address callback
Date: Fri, 2 Apr 2021 14:43:39 +0800
Message-ID: <20210402064345.14093-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064345.14093-1-Hawking.Zhang@amd.com>
References: <20210402064345.14093-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 775eb283-65d1-441d-d87b-08d8f5a2b45c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1814:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18141BD6206976EF07A3BC55FC7A9@CY4PR12MB1814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h36g8iEqBvlUCmIyVEfHwYI6l90Q64MH31H4i38Gw+0h7D2IJhUerT48fgstyDZG/UBD2kufWJUUh+UOJwSbcgcF6yondACkKp5o3ULSHWXpcQhgEe93ofvnS+10YEt0WiyllAEryr6FhzX8LWJdwBhMg6DCR/vRrBp1QD0TSEIS4bBS3J/I0ROdVANkIMJw9GqsmLjnBEy0ExPWd9J5wKMpv50m8ubcOzR7mtBDgQbUVdVY5idpwTeI+MKYHRzlxg4/n0OBMQPUjWH9Qf9SqWeDEkkOBUgrjZ8eP68+aqoiVF4NNoDgoYAKo75IQ6XMdE5aWtwz3m7aOpo2eZZ6bnAo65dQWOwM6PqpwymX+xQ1oOxhGAJWxAqxkjsO5aJ8X16VJgfXPz/MzKzY7L76TE1XB5jmk4v1pHJDIdk2vvobgNeCe4gdYUO3toMk5MOaWxZgPJaMIH6w0LLGQhDeycO6QBoBa5a98jzkwn1xVVz2Wr30w5QCTiOXui28QrOpRlEorb9AbNfoTSGzWGNWRTuuyZgmT6JInYR4u3j8/GB5f23CILGl8FVR0oN9k3JTv3o+qe1Bhn5ARI+Z8OZae1DoaA6nnUI8Jvba5oNWTI8PA3vuHg+aX802G8Fy4mLQIC+NC2YkgpJJjCZtH1Ksybn6gdBa6BQZvBzkiT1LqPkuv4K/DxNWEi4cv/luHnRc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(82310400003)(356005)(5660300002)(26005)(83380400001)(81166007)(36756003)(110136005)(186003)(4326008)(86362001)(70206006)(8936002)(70586007)(478600001)(2616005)(8676002)(2906002)(316002)(1076003)(6636002)(36860700001)(426003)(7696005)(6666004)(82740400003)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 06:44:03.1496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775eb283-65d1-441d-d87b-08d8f5a2b45c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1814
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

query_ras_error_address will be invoked to query bad
page address when there is poison data in HBM consumed
by GPU engines.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: John Clements <John.Clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 90 +++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index fe666ac93b54..3c3fb01b7c20 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -183,7 +183,97 @@ static void umc_v6_7_query_ras_error_count(struct amdgpu_device *adev,
 	umc_v6_7_reset_error_count(adev);
 }
 
+static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
+					 struct ras_err_data *err_data,
+					 uint32_t umc_reg_offset,
+					 uint32_t ch_inst,
+					 uint32_t umc_inst)
+{
+	uint32_t mc_umc_status_addr;
+	uint64_t mc_umc_status, err_addr, retired_page, mc_umc_addrt0;
+	struct eeprom_table_record *err_rec;
+	uint32_t channel_index;
+
+	mc_umc_status_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
+	mc_umc_addrt0 =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
+
+	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
+
+	if (mc_umc_status == 0)
+		return;
+
+	if (!err_data->err_addr) {
+		/* clear umc status */
+		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+		return;
+	}
+
+	err_rec = &err_data->err_addr[err_data->err_addr_cnt];
+
+	channel_index =
+		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
+
+	/* calculate error address if ue/ce error is detected */
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
+
+		err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
+		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+
+		/* translate umc channel address to soc pa, 3 parts are included */
+		retired_page = ADDR_OF_8KB_BLOCK(err_addr) |
+				ADDR_OF_256B_BLOCK(channel_index) |
+				OFFSET_IN_256B_BLOCK(err_addr);
+
+		/* we only save ue error information currently, ce is skipped */
+		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
+				== 1) {
+			err_rec->address = err_addr;
+			/* page frame address is saved */
+			err_rec->retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+			err_rec->ts = (uint64_t)ktime_get_real_seconds();
+			err_rec->err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
+			err_rec->cu = 0;
+			err_rec->mem_channel = channel_index;
+			err_rec->mcumc_id = umc_inst;
+
+			err_data->err_addr_cnt++;
+		}
+	}
+
+	/* clear umc status */
+	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+}
+
+static void umc_v6_7_query_ras_error_address(struct amdgpu_device *adev,
+					     void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	/*TODO: driver needs to toggle DF Cstate to ensure
+	 * safe access of UMC resgisters. Will add the protection
+	 * when firmware interface is ready */
+	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
+							 umc_inst,
+							 ch_inst);
+		umc_v6_7_query_error_address(adev,
+					     err_data,
+					     umc_reg_offset,
+					     ch_inst,
+					     umc_inst);
+	}
+}
+
 const struct amdgpu_umc_funcs umc_v6_7_funcs = {
 	.ras_late_init = amdgpu_umc_ras_late_init,
 	.query_ras_error_count = umc_v6_7_query_ras_error_count,
+	.query_ras_error_address = umc_v6_7_query_ras_error_address,
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
