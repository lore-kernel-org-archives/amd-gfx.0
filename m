Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C44AC83F29
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 06:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F62910E050;
	Thu, 31 Aug 2023 06:15:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2AE10E050
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 06:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDv99zeWnloAJXsuWlGbLxKxEQa6IrxGDVmC15lUXt9P8RbwsrM49ii2Sqq2rzH+P86hX9QsY4NPjEKCJ65akZFHnJEdUqDXf0xpFh/3w21dXiQ7IpWA+wR6V3QmrgDzjga9NNowYz4mX1OL4YrAh9FiI8ypBCSd1ASeuEkAHe7uH3kUi8F+UOdnvmOWPihh3qCQMMj05bqFSpAIVgVkKHtu15l4AUaXWJSt4RVgpnBAlcAmvGgpBCfChBtYImuUh6xI+vsYbWVmwd0SYNMzt3MNrivOMehf4DqUH+p0I040i17OR57r+WRBr5+xD37F/b7g7mUrVK6BTJfyRNgxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnBW4oHwWkC9ZNOiQzjw8RKzmp4JwQ3Ld9X8ccgx0Xs=;
 b=GLsCksdHE8GxDDC8gbLgz512oPfevdj3BQ1jC48xeXMDi21G7q31Pwc7BqNG+mQOx9RSWscRwvLCSCYt+50tHmBEPFBSg8AyA5HeilmrAIgUwP+fSeQ/JTtJSPPp5DeWDkXl/quTjkZfD+T4O5jAJApXT9lPobxESfm2p+nD7y5MzOHbdctuXhjH98RHhG4OyOIqWRrp1Gwo7yICFVxf4B8SLvu9/s0guOOdlN93RTH/CF/+yWzagJQBjPwuNtZvw/QWxrrIim1N4nzKsioL+lskKWozzIFf5k0vj0GSqX1hA1u2/o5l0ZzLHsuYiX96kUkKsvojkU4QFaF1PElcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnBW4oHwWkC9ZNOiQzjw8RKzmp4JwQ3Ld9X8ccgx0Xs=;
 b=DyhwsLEldFVam7B6fsitx5RcC5rFto/LiT/EVyNMJPOT21oZ2BY05rFGn+NLRi2SR6t3bO6xGzVUReZOZ6w3+BaJaX1XRKK4Erfxhp2XoJkN/awhxUp1fHC/eabtt0CQYcA7wRNApCuEwbOP7a6lAqL4Q3R0GykS8hPxw2gFMv0=
Received: from CY5PR15CA0131.namprd15.prod.outlook.com (2603:10b6:930:68::22)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 06:15:08 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:68:cafe::fb) by CY5PR15CA0131.outlook.office365.com
 (2603:10b6:930:68::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 06:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 06:15:07 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 01:15:05 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: only poweron/off vcn/jpeg when they are valid.
Date: Thu, 31 Aug 2023 14:14:49 +0800
Message-ID: <20230831061449.4121417-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 3933568c-af46-4710-b518-08dba9e99fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8863BZVmLRH2bOD3Na9MA+oOMfW5D9V2lgCiWlZQJr1RTR4MqLr0FD9SyIApwy7LGLBLwtNzZMAqOd9gBhZCAuNPTvpbK6p3r3GxfNJawRW2IkRB0wdWDi/qhxte8m3Ugns87lTxK9vulIAvaDkCTCGcAB1IEELiJL1yF0G1BYj9OMCW/6OfnQFXCagK7Jqwzpraw0AF8VvFj/MYvFcYBhiK60HrmP+vQQyjWtgzEBQVyFJzm9yPRVpE9u6+HrCpSNG1bZbGkXCqVn2dTkOqzFDOxnh/gPb+7Mfc+P78OjXOH28WAAgB58RQRK0VXJODHLZTxw+RV2+j5eIC2C23AmIbE9YFm8E3M0ywXDDcrw+z+lykWj9n1bv4CzauJWG7LViNtTsijemo98Cui0fbcFry7Z73YBetPr4PCxUx7KKE3W/C7FclGWyEKe+FkasWRIn5o9zezw3La5dgqIIqpFKkyvrjETzgFrnQe4ofBOhtsPzUs5NFvJ9uRHoPVUQI1yL89pioqmXN/ZDXAdLVAWibSigqJAfn4Xhq5k6FgTFxcZtqWE5iH90T9JaCJ2FaXYOE7A3g2HH3EE8SpiheQG1ThURmAGi0+YYN3w542OcLtqQokbWthfIzpS2M6i9AymF+Z3jrlLJw/KEwyFBk/B7l7R1EOCVeCj2dY09Swda8Nmozc4Zng8ClHP24E4Ej9xavxjPK9o4h/RTp7rZ1uHgp3Zu0rlEbwI3Ou+4oF3SZH19PEFH2q0waziNn5bEDuCr6Jk7wQ68RLIaq5u6eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(7696005)(6666004)(478600001)(83380400001)(2616005)(1076003)(2906002)(336012)(426003)(26005)(16526019)(6916009)(316002)(54906003)(41300700001)(70206006)(70586007)(5660300002)(8936002)(4326008)(8676002)(40460700003)(36756003)(40480700001)(47076005)(36860700001)(86362001)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 06:15:07.4447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3933568c-af46-4710-b518-08dba9e99fbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Evan.Quan@amd.com, li.ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If vcn is disabled in kernel parameters, don't touch vcn,
otherwise it may cause vcn hang.

v2: delete unnecessary logs

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 30 ++++++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f005a90c35af..b5fe4defd12c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1454,6 +1454,21 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	return ret;
 }
 
+static bool is_vcn_enabled(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN ||
+			adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_JPEG) &&
+			!adev->ip_blocks[i].status.valid)
+
+			return false;
+	}
+
+	return true;
+}
+
 static int smu_hw_init(void *handle)
 {
 	int ret;
@@ -1475,8 +1490,13 @@ static int smu_hw_init(void *handle)
 		ret = smu_set_gfx_imu_enable(smu);
 		if (ret)
 			return ret;
-		smu_dpm_set_vcn_enable(smu, true);
-		smu_dpm_set_jpeg_enable(smu, true);
+		/*
+		 * don't poweron vcn/jpeg when they are skipped.
+		 */
+		if (is_vcn_enabled(adev)) {
+			smu_dpm_set_vcn_enable(smu, true);
+			smu_dpm_set_jpeg_enable(smu, true);
+		}
 		smu_set_gfx_cgpg(smu, true);
 	}
 
@@ -1651,8 +1671,10 @@ static int smu_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	smu_dpm_set_vcn_enable(smu, false);
-	smu_dpm_set_jpeg_enable(smu, false);
+	if (is_vcn_enabled(adev)) {
+		smu_dpm_set_vcn_enable(smu, false);
+		smu_dpm_set_jpeg_enable(smu, false);
+	}
 
 	adev->vcn.cur_state = AMD_PG_STATE_GATE;
 	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
-- 
2.37.3

