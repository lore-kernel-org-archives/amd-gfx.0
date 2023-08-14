Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3035C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 10:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB1F10E19A;
	Mon, 14 Aug 2023 10:18:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C77D10E19A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 10:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4u0ntEJ+ClMXsdSIP571HcOw0uao/FAiSh7YTBTuvughf/IG4G+J0IRdY81xXKXBuwSmES6qgSWs45CWmSaxMI7OqWVshzu8Yk4mrn4LJryf0Wgy0/X/70yAZYlqgDJZnR95w0Kubgr7hQoXBfrFBrNGrm/Ufm8Af7le+3G5H7QPxTCemKoECuJA16gDRZ0bugClgYahSlr1kSAjgja8u4WuUF+CrU3Sz1U5eo12KPkNRcYYryt8Pfvr7aU91bnAL+aabTvaNAE41BNFGGPSlUxzxxxixsVnX1r6poTbG9jyPF6S+2W7CEOuG6e9B9uwEgRlrghNrtHjHVgK7JuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o46H2NxO1bQaL0I+lGoXf54wuWS14YQdGi49G1Wbm/I=;
 b=itQAc7o13uu6D7CG/zptiUt0mptTMzmiwL//Huqccu16IripQNO0Znk4w6MJEvvidM1n/R7MFGVHxYhx6fyaqUPec5gofiBSxblB/+8IQnW57XA4ITdHGcUg7MKGhSpUbhN8knTrVuSrCw14T74K9BmE9JRjNv3GXsBwru/jwkxwQ1dLgTPPam/v1aSVxJ9we1yNmZsF4f4ZmdC3fZW955LIe+KtvDSEC0bpJXEz0HrQWF6cNApxtTLErAHRWExsFhB3EVoDmtPcmOLYKR2wpNVUTfdi7P09hsaGL5lDS66aU6ABlJ11Tj53x4H9AUodqPgeXdhpTkbk12MQXy6vMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o46H2NxO1bQaL0I+lGoXf54wuWS14YQdGi49G1Wbm/I=;
 b=vtlWpHJ6KPHqhr515rfCRjPknFxLTL8nF4SOdJipjiuyLdBmmu6NwszcZ+0TSDDYK6rOdDjGewgJVM4+bUzzzslxKMOhhofdzAnVYDQVe/F1SRqtQ/p+yErzvWpQ1igRc9zjO6JtYC7UzqXchgiC6x+peNq/OkEDgKXXFeMCqZ0=
Received: from CH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::27)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Mon, 14 Aug
 2023 10:18:08 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:610:ef:cafe::b6) by CH0P220CA0006.outlook.office365.com
 (2603:10b6:610:ef::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 10:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Mon, 14 Aug 2023 10:18:07 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 05:18:05 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/2] drm/amd/pm: Update pci link width for smu v13.0.6
Date: Mon, 14 Aug 2023 18:17:33 +0800
Message-ID: <20230814101734.1149593-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: b67ae33b-1288-4393-b06e-08db9cafc150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpqSrKKaSmlcmaOD0CEKpmCZIQ3Wa/atBq9E0bGjOhRrUvELSKxnt2PCJ7vHbIyNA8fTUBm8Z98uNm+bh873mobeQTUQz0925nbJVc3oU+WqtUiHubSYLFKhpSgm5ejz8kkgk7MBnlB3X164UmZi7gOJfkzshHwcMdH+o6HtRlyR5c6WQ+C382+JhGKxw9x6jfFoFcRDv2JfbWU3dzI1spzS/clRttGmDny2WBpws7qkMFoCGrfXvmDW/TO9dyQ37YSzvZlolbqYUIIaC4e5XfLfuqIR1RfTVND7rPWNrQfbJbBq0Tkejsa9Y7Zw9w1MAQX24boJA6TnUwXNPWxUcafi9Wj9TwwEzYB9m30LYDQFEvaJP4NwWgZlpqt28q5q7w5YcyX9GbfSYMR8p8fG5fQECMfpTgjT3XYAP2que3Pn6Z6iO0cTdljydW9tyCHJmLbZnyyui+KVUOhrnoV3IXa4Wnbmd8q7lz3ZL7jwwOOKnPFuDI6lfT8ITNZv2FP5uGLKW9J0Iv86yWUmocK/S4TJvKRkLtBPKul618t+VRkGvM2vLWp+hx0IXBGEG6bKJT1dhk3XrP7+05stoRMQgBqzPeruFQ+5W6haLgeQpOXl14ht1OwWiM1lPfG/8vWHHY6LziOVup663uOUF4fJkjQzRWwVNIpBtqbfDRJyHnxKlmJDRjnOwTjMbda7Nql/4qD+oFUn5wWIqjaEoYURFwzNSxox2MdEJMS9IK7Ic0S6I5tLkGlzW7fWY9O7I2PLV7yZL4vO82sbUq/H7ilyNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(1800799006)(451199021)(186006)(82310400008)(40470700004)(36840700001)(46966006)(26005)(1076003)(81166007)(8936002)(41300700001)(40460700003)(8676002)(36860700001)(47076005)(36756003)(426003)(2906002)(15650500001)(83380400001)(2616005)(16526019)(86362001)(82740400003)(336012)(356005)(40480700001)(7696005)(44832011)(70206006)(70586007)(6916009)(4326008)(478600001)(6666004)(5660300002)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:18:07.8151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b67ae33b-1288-4393-b06e-08db9cafc150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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
Cc: Lijo.Lazar@amd.com, asad.kamal@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 maisam.arif@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update addresses of PCIE link width registers,
& link width format used to populate gpu metrics
table for smu v13.0.6

v2:
Removed ESM register update

v3:
Updated patch subject and message

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 362acbb242bb..21275e496852 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -81,9 +81,10 @@
 #define EPSILON 1
 
 #define smnPCIE_ESM_CTRL 0x193D0
-#define smnPCIE_LC_LINK_WIDTH_CNTL 0x1ab40288
+#define smnPCIE_LC_LINK_WIDTH_CNTL 0x1a340288
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
+#define MAX_LINK_WIDTH 6
 
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
@@ -1953,6 +1954,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, inst0, xcc0;
 	MetricsTable_t *metrics;
+	u16 link_width_level;
 
 	inst0 = adev->sdma.instance[0].aid_id;
 	xcc0 = GET_INST(GC, 0);
@@ -2003,8 +2005,12 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->throttle_status = 0;
 
 	if (!(adev->flags & AMD_IS_APU)) {
+		link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
+		if (link_width_level > MAX_LINK_WIDTH)
+			link_width_level = 0;
+
 		gpu_metrics->pcie_link_width =
-			smu_v13_0_6_get_current_pcie_link_width_level(smu);
+			DECODE_LANE_WIDTH(link_width_level);
 		gpu_metrics->pcie_link_speed =
 			smu_v13_0_6_get_current_pcie_link_speed(smu);
 	}
-- 
2.34.1

