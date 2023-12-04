Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9F9C4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 03:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CAE010E182;
	Mon,  4 Dec 2023 03:01:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A96D10E182
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 03:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyU15OJPc59FfWz6GuNYsdYQq29BpJ0pCy/R8ayWnLu3X/GbHKR6QkKMOVD5vLVwoUDI6c7jMi2dc3FkWvC/S4Nzt+LLLzGXDZbWmKj0DA0IrTrfxeLiEyBWcDmfB5FXhXQ8In4GmZZdO3AVrxnSjisUCBn7h/ONBNtjn21qEPdUqP4nPIYJDOiOirrndTFnWzB49t4L3q2tO1Mdf0yKAowwsb6POsP9jQaqrFUvk5PkpVxMIhoTxSu/8YPDDSwAYx++D9bRsjqXXwUh+cXe6ly6RoECP/NemF0M1U3NlHG7HVde8wWOBJZP89gjiYgmV920wgHv99fXPQ+0E90iyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C9s1DVaNZ306T2W+uSqFuWJ9qh3iaekmApZxbcNWUw=;
 b=LMDVPlxHTk9WReosLmDs0Sjlj2CBADNWi0oeopP0hdJ15KPqtHJUfrWQFHAFeuQthNgmneCk6WNGQDDLwtSCaNwTlvjdNUAbh0EpZeKQ0Fy6LvTGDR/+AMwugHLQ7tu/qJ2M5EG3V3HZdAnqYSfAmP29yrFxMnoRI2xvMJzpuKfoxi2lhSs3dgg/1PABngMczgwOxsJB4xk6ML4vODQs6WOZ+10oNzaTmVHCalBRvQw75KgaT2UJw7wTlHqA0miLY4K1Og3v/jF5jbKbiOT8UnVmzytSGc5687M1hCLH6UGAPkWaltTFCG1a7HrhbfZkPJGL+lWuDNONoafMnPIKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C9s1DVaNZ306T2W+uSqFuWJ9qh3iaekmApZxbcNWUw=;
 b=C87VbYIQl0KaeeOlhjnfSnCrlQya9nmMdeH6beNTAQdWpvqLOLPTBRuK2TVj/n0gFDvNAYgSeqPGR1NzDn1P4Pb2mrXKbQpKwYmklBDg2r1/Dot/G0tS0NXUd5jNvqi69FZgQCB4NQhLqAZYos6kSJ2sckH8VpyENmmAymp0n/w=
Received: from MW4PR04CA0137.namprd04.prod.outlook.com (2603:10b6:303:84::22)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 03:01:36 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::dc) by MW4PR04CA0137.outlook.office365.com
 (2603:10b6:303:84::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32 via Frontend
 Transport; Mon, 4 Dec 2023 03:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 03:01:36 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 3 Dec
 2023 21:01:34 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: support new mca smu error code decoding
Date: Mon, 4 Dec 2023 11:01:20 +0800
Message-ID: <20231204030121.2862186-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: aef5df8a-fbe8-4217-d32d-08dbf4755429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFgy5Wl0bfswjYBO5Hn65mGKzuZfh6X8/ve3I3XRq8g9wI6cQVg/+oluDzYOvX1Cn8ZrYMG0+GmRzn7dEiwRTQnL85I6wTi4Igeeo7dWRYazTA8WHlxn+km3Ox7dHhNlivhRwiD0MKZck9pZGcNbH2th+83xikmiW4LCFfocca1XG6fx4AtTm5d0vqW0Nqzx07VHaZY42twAcbhpsrJ4voricwL40ZEDJ8dxWidi12FyUpFfiSnrdU5vYBiU6fls1NMJl/J5Wdj/PL/x13zj0i8ZmMyWuZ5lrRvyZFn/hjv/bYufNEOInL19C6pXi5vZ92I/cNmq38VZ+ZCR7OGcQnA2kzf2RTlBT+mo+ecks7fW3Eu5E568ZKTiVUt5lTFPZcQ2mf0KTsP3K3mPY1OWsPVixsaH66HdJoZG32Zsr1AVaaBKOvejn9BEPGE8oIbZNJeXQjPRfiAlSlHob9NSOUkDIugbRVOJpDKTtKH47MShQmUUkzZYFjVlCZOEpAZpWAszitcrJSDKbK2GZrwuVlDZhRNJwvYJZTCfKdgzJDlhC1IszUbgyiFpAuqkG41KLCuOZEiZMasq+FRs2wpE/8PZ04DbrpkS/UT3NjLR0AJysUVB/sWGIU2NXfRlctmxJIIteb2xJQ7D/Q/z22A9HvnoqtMv22xrvJ2VMy1HalvtHcBly5eu2FDr/Pczw+aa87pgU/VJ8rYTuv8j0QOd0hXajxzoLPNgcxT+TCq0AvS+ytEO4J/gVmz9k6GBMu0w0cyhgj38G/V0tx4RJkxXDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(41300700001)(36756003)(40460700003)(5660300002)(2906002)(86362001)(40480700001)(2616005)(1076003)(7696005)(83380400001)(26005)(16526019)(336012)(426003)(6666004)(478600001)(82740400003)(356005)(81166007)(47076005)(36860700001)(8936002)(316002)(4326008)(54906003)(6916009)(70206006)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 03:01:36.1872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef5df8a-fbe8-4217-d32d-08dbf4755429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

support new mca smu error code decoding from smu 85.86.0 for smu v13.0.6

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h              | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index 2b488fcf2f95..e51e8918e667 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -46,6 +46,8 @@
 #define MCA_REG__STATUS__ERRORCODEEXT(x)	MCA_REG_FIELD(x, 21, 16)
 #define MCA_REG__STATUS__ERRORCODE(x)		MCA_REG_FIELD(x, 15, 0)
 
+#define MCA_REG__SYND__ERRORINFORMATION(x)	MCA_REG_FIELD(x, 17, 0)
+
 enum amdgpu_mca_ip {
 	AMDGPU_MCA_IP_UNKNOW = -1,
 	AMDGPU_MCA_IP_PSP = 0,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index dda2249c4994..ddd782fbee7a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2635,6 +2635,7 @@ static bool mca_gfx_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct
 static bool mca_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
 				  enum amdgpu_mca_error_type type, struct mca_bank_entry *entry)
 {
+	struct smu_context *smu = adev->powerplay.pp_handle;
 	uint32_t errcode, instlo;
 
 	instlo = REG_GET_FIELD(entry->regs[MCA_REG_IDX_IPID], MCMP1_IPIDT0, InstanceIdLo);
@@ -2642,7 +2643,13 @@ static bool mca_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct amd
 	if (instlo != 0x03b30400)
 		return false;
 
-	errcode = REG_GET_FIELD(entry->regs[MCA_REG_IDX_STATUS], MCMP1_STATUST0, ErrorCode);
+	if (!(adev->flags & AMD_IS_APU) && smu->smc_fw_version >= 0x00555600) {
+		errcode = MCA_REG__SYND__ERRORINFORMATION(entry->regs[MCA_REG_IDX_SYND]);
+		errcode &= 0xff;
+	} else {
+		errcode = REG_GET_FIELD(entry->regs[MCA_REG_IDX_STATUS], MCMP1_STATUST0, ErrorCode);
+	}
+
 	return mca_smu_check_error_code(adev, mca_ras, errcode);
 }
 
-- 
2.34.1

