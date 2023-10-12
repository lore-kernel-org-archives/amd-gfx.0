Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12C7CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 13:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E28410E4D8;
	Thu, 12 Oct 2023 13:14:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B251B10E4C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 13:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwLnDYdKG6iitfiK8HfZeVNmgdjcx85fbmJ7Fjp9h13q615NSru7L2tMrWr4oUodQYykKnISFAWjtvPyXFHZBYiu2EBPTXKbQFFE3/5TzWaMP15A9BJv0QZn34WNYuYkGrmHkKtkAS8mw9zuliVNCa2AhrlplSJgNtxxkhhbNGmZFQaVUj2+KJp+p/uz5Da61h52fzp4O9tKEi6fSKeb/EHdbIEjBYyodVngxYsZDLJW+Yd0/rLVPlrQLmz7EMcAK9+R0nX9/Ced3UolMDkF/mgfiXzI8dJZs7NZJ8LksenzHocCvTNdj52auZb2tmW0vRL6g5oljDO1v6xO2S3TGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXs5HobLEvQEE0K2Cop8y81MwXcJhbgp+quwvNxyiKw=;
 b=WKa20OPa7O7LTnkbfBTXW6gQLJYSP2p3MPtLjq466gE2emmw1Q+00ysH/a43pVadeJZ6LKIFlVwbnRmM/lg3Zw47FjuYJ6oYXNvJOguzVFM3yj1Urrm2c4f1gZWO5Qao4+pIncfS4OZTM9cRrRra1wmbVX/IZeX63QAZ1I59ZFDNLjH2Hk+Smi91WRgljNiQM3x6nTvWcaZP3TNlbVD5MTaVhYWwJL0rxcygmhXpoCUV6THp4rN9doCXdyoqplm/JN8KQELTJCzIBLkNvDlt+WlZLF96fjS1hEpn4KFWbrImmqUWLkdvbRsGWPx7QsRdfHh0fpU0eHIkfa/4FUqjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXs5HobLEvQEE0K2Cop8y81MwXcJhbgp+quwvNxyiKw=;
 b=endXWdU7dlBwM6VB29b5LBctIpbm0m2aMeCQT+9JvsOb9n8iqA2QH2TzhRede0gpcHEFAX9J4Ye73Ql0qL3dDFsJy3a3zjFPocRP3QgfXuAW9f8e5u5GpssfHcQ4eaBJUJuvDcbsudNo7eEZj22yNB2yBuquz4xrNyr5+9UyCtc=
Received: from PH8PR07CA0024.namprd07.prod.outlook.com (2603:10b6:510:2cd::8)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:14:25 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::e8) by PH8PR07CA0024.outlook.office365.com
 (2603:10b6:510:2cd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Thu, 12 Oct 2023 13:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:14:25 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:14:23 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdgpu: add RAS error info support for sdma_v4_4_2.
Date: Thu, 12 Oct 2023 21:14:04 +0800
Message-ID: <20231012131406.61101-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012131406.61101-1-kevinyang.wang@amd.com>
References: <20231012131406.61101-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SA0PR12MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c707646-e1fa-4ec7-156b-08dbcb252871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Us/G1qnvw2HCr0cz0ku+c8d0xAsrE72HU9juOn+JywMDhUlx0CFLR4GjULYQ1xovsVDX8Ms2nE76iT1bGO9FfMAYjQRhnqZj4IVaIT7OUy9t2HQ1tzCSc/Kf8tujPiOtHmbLaKPQgZTNNJbZeM1JqliZl2abJjKwaw3jLAfp/9SlbohiYySxjXLvgeKyXsxrcE40dE1yE9Hy6mVZyQoG5U1twKy3DB7tH09qYXXTuKqhWepFiubSV96IwmBSDLt3j4NCuhnd6KAdrvGqIg2KLcLL0JZXxtF8bOm1qmC1DnMygTWHF9ay9skkjLDFdHewGv6zwPhu4V8pJTpzxdxEcq4cdzQY/VCDgRuAS4llDD5MKWVs5OwWL8oDXwuxAexH4y8qby4LCp0JS6vQKQSQ4Kcr/3xQdHqwKsTfLg1TVH2qopdHlRuWxMP5qtLwG5OH9x/ZIXqwQ3TX4DybPlB4vlSri87cyRRZR840imfxYFh+dQW0UmNvjhmDqWvE0yo/bpdmgeiYLdqmytCcmmbDQfwiOyBgzafrf+zUXi5itIs+dNON9M2BRRFrWmdYOlQoz+whaigocvmn046kBDaCK9MJMsisikqn6gD5qIq4mqnZAMuM2P68jsKmcfpBaAIsJMBIdOOqLaysfIm+BSr5n85dY00WHgV0fuss3rLA1/wCyWrZqxGliEjll1vn69jSWbVz369CZz8ZefYD1XiWpQ0NIS7/GqAeW27behl/tzNq0VG4euk/o7L6GoYbVjMJPM4EnviwDDXEl4hNKuGKSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(1076003)(40480700001)(40460700003)(478600001)(70586007)(70206006)(6916009)(6666004)(356005)(47076005)(83380400001)(36860700001)(82740400003)(81166007)(7696005)(26005)(2616005)(16526019)(54906003)(316002)(426003)(336012)(36756003)(2906002)(5660300002)(86362001)(4326008)(8676002)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:14:25.5160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c707646-e1fa-4ec7-156b-08dbcb252871
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add RAS error info support for sdma_v4_4_2.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 3b6990ef403a..31aa245552d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2130,6 +2130,11 @@ static void sdma_v4_4_2_inst_query_ras_error_count(struct amdgpu_device *adev,
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
 	uint32_t sdma_dev_inst = GET_INST(SDMA0, sdma_inst);
+	unsigned long ue_count = 0;
+	struct amdgpu_smuio_mcm_config_info mcm_info = {
+		.socket_id = adev->smuio.funcs->get_socket_id(adev),
+		.die_id = adev->sdma.instance[sdma_inst].aid_id,
+	};
 
 	/* sdma v4_4_2 doesn't support query ce counts */
 	amdgpu_ras_inst_query_ras_error_count(adev,
@@ -2139,7 +2144,9 @@ static void sdma_v4_4_2_inst_query_ras_error_count(struct amdgpu_device *adev,
 					ARRAY_SIZE(sdma_v4_4_2_ras_memory_list),
 					sdma_dev_inst,
 					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-					&err_data->ue_count);
+					&ue_count);
+
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
 }
 
 static void sdma_v4_4_2_query_ras_error_count(struct amdgpu_device *adev,
-- 
2.34.1

