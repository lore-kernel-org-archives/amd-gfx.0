Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933B9C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 06:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19354113222;
	Tue, 26 Jul 2022 06:29:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC2E11324A
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 06:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHMTEUU22k6OhyLAIqy6+exbOb3Rkq+5quLpJCD6YfrFMIdhQl9vwy+9nrf5yq5OXQSOf8mVejuIQLQl+Ho9PjfFqKy2p8ZRLooYRjMrgXjG46fPuKG/SjDFuhNOA6etPvjI0uumuATHqXbr1MyppR2TKXykSLdDRJtcWmVMpAVjuWBlcGdxojDDWQTWMEg+6oih/AckjpPV5Mf/ImfcgrSyVdYdzFukrq1djeXOpvov0VM5TVH0FDGllBdi/52ziIee0ZHIonpKXkVmESHR9CyhZ042NLwHjLEGSeFCbMKFMRclSxCHJZh0A7IqMmxXGPxCTyUkdRYzse2fkdcs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Z6GB3NBCtCZh41ge9tJ5XMmAfvZDEOafSLAz8Mxwg=;
 b=k2O4/8udGFlLsoCxgoSqphsEh0aPuFu5u+OOP7dZlJSslU16OdwJfBQ0KkNjgP6RmeTHUg4Oi6eyDSEH4n9YQGHFdjw8cchlM3F1cw/By20Kf0q+zuJgrPIUTW86GE/a7L820ET8GFuxtTf4YWTYrk+92O4v920TCg1cCkE+j8gfqHQssPcoSTe/qMP4sM2KC5EHuYkczHFy1+bGrjeQyKVeyXFqAOmR9/UNsvC2hVpG6mz8EZcmwmTNvF9p8Nnmnbl+2htS+J8qpuvwmbKva8Z16zSTMZSWpdVP/gbReJObdVYciw/xJKpZgxzr2QmN+GPRI6CUjCIn56BvC/f8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Z6GB3NBCtCZh41ge9tJ5XMmAfvZDEOafSLAz8Mxwg=;
 b=G1FG9Rj55QY7ehRnG9rllaIBrRgfTftBTAfWfPUZNPhUPBTYvDmMAkwUZduXguPx9dtU6tdcWiBKLjP0BeTD9nI24KCqXHusy6nuPwh3cZIYZ8JH0+zpd7/lrcP6N3988GW0kH9FeZW0xIMrsYbxhygw5TdPe2fuS+46Uo5++7M=
Received: from DS7PR03CA0268.namprd03.prod.outlook.com (2603:10b6:5:3b3::33)
 by DM6PR12MB4826.namprd12.prod.outlook.com (2603:10b6:5:1fd::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Tue, 26 Jul
 2022 06:29:31 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::31) by DS7PR03CA0268.outlook.office365.com
 (2603:10b6:5:3b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23 via Frontend
 Transport; Tue, 26 Jul 2022 06:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Tue, 26 Jul 2022 06:29:31 +0000
Received: from master-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 26 Jul
 2022 01:29:28 -0500
From: <shikai.guo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: Add get_gfx_off_status interface for yellow
 carp
Date: Tue, 26 Jul 2022 14:29:05 +0800
Message-ID: <20220726062905.3323207-1-shikai.guo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47f3971f-d122-4467-9be3-08da6ed032e6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4826:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2Lt1U7cuo58QkYk5e9kaclhoqeJu2QA1j5kfP3vEbLlgxDrw0z9zpB4MSdxq7NhV4MxrvuG5ix3pJfIvA6t8iDDeHH6kmqE8npuSY8f6iniZc2bV+MkiUlHqX2uipDjskPoy394nrc3MgHiXobY8BNKTfG8dIENKZvlpkZ6XbELaCKMFzOc7YER+jT4durmQYS8B/rowPEWQdw5070GwX7nmvt3jhog4s68ES+MzpsxLUGq9sFjEDyvgKzn9Ae5VbVr+PSYhyUIhOWZxmPHkUb9Uloiwws5iVmjPcpztqjFRwXZOBlDuscoj+oYNC8E04cMH6nE3XYdgP/xnsxCXZ1GfYZSxcql3VryNDA2QOS08Br1RzGa0WuYt1IkAMacAuzL+Cq6IxCMiJGjG75qEWtBhdUJOmS4a332UbXyH92rjWXjGLJPVAT+LylmNLpqhXLpDGZTo3tjx4A7/2jFMzmaPNlsL+9j26rxZEiMopWTTYOBd+GTWlM7odxcWsrIZzWOokG/2hoP4SyIS227dbZaQHry97Zqwi1/Y3gUTaI6JqF6iQfzPJtbC29deVWx0c7XsfZOoJoQc3yXiK5vUbZhFMoj/+HjHCVYJO+kXKGxaVSWT7RfOyELeX7XWMzAPSJpa+PityBBetBa3xxqebrmtkTOMpOAVHfz1ynTPO4WM6iu4NxXBpv3qAiNHPJpmjPfpHxcEDYUVEbISbKvSPqj6xyUYn+09qIEoCsnfbeX1D/krC01ZvXWyLbdNdIgntwiWhTxlTafsO30ow0OvQRLA9gkgfc8t9q2Ve05pB02/ivg8AM0/TKMa9Rs6xpfZaYudXyWoxdBhAdAaRI4p6EjoVQFSw1vuVAmiGdCRigLNUBEaEnQbrNm5je/VTaP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(40470700004)(46966006)(16526019)(336012)(47076005)(86362001)(426003)(186003)(82740400003)(1076003)(36860700001)(81166007)(40460700003)(8676002)(4326008)(5660300002)(70206006)(7696005)(6916009)(36756003)(8936002)(2876002)(82310400005)(316002)(6666004)(478600001)(40480700001)(26005)(2906002)(356005)(54906003)(2616005)(70586007)(41300700001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 06:29:31.1011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f3971f-d122-4467-9be3-08da6ed032e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4826
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
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, evan.quan@amd.com,
 aaron.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shikai Guo <Shikai.Guo@amd.com>

add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.

Signed-off-by: Shikai Guo <shikai.guo@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 70cbc46341a3..04e56b0b3033 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -42,6 +42,11 @@
 #undef pr_info
 #undef pr_debug
 
+#define regSMUIO_GFX_MISC_CNTL  						0x00c5
+#define regSMUIO_GFX_MISC_CNTL_BASE_IDX					0
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK		0x00000006L
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT          0x1L
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -587,6 +592,31 @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v2_1);
 }
 
+/**
+ * yellow_carp_get_gfxoff_status - get gfxoff status
+ *
+ * @smu: smu_context pointer
+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=GFXOFF(default).
+ * Returns 1=Transition out of GFX State.
+ * Returns 2=Not in GFXOFF.
+ * Returns 3=Transition into GFXOFF.
+ */
+static uint32_t yellow_carp_get_gfxoff_status(struct smu_context *smu)
+{
+	uint32_t reg;
+	uint32_t gfxoff_status = 0;
+	struct amdgpu_device *adev = smu->adev;
+
+	reg = RREG32_SOC15(SMUIO, 0, regSMUIO_GFX_MISC_CNTL);
+	gfxoff_status = (reg & SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK)
+		>> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT;
+
+	return gfxoff_status;
+}
+
 static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -1186,6 +1216,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.gfx_off_control = smu_v13_0_gfx_off_control,
+	.get_gfx_off_status = yellow_carp_get_gfxoff_status,
 	.post_init = yellow_carp_post_smu_init,
 	.mode2_reset = yellow_carp_mode2_reset,
 	.get_dpm_ultimate_freq = yellow_carp_get_dpm_ultimate_freq,
-- 
2.25.1

