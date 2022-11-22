Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CA2C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D007910E382;
	Tue, 22 Nov 2022 05:54:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1859E10E382
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/pPK5DEhjK557T8g690CjmWtzLtAirOSFg5JavCnNqAurBN6MDTFiEs5b7AUQMexyoRROAIu4imHIOkRMFX8au6w0uotM88SVIe7y+RBtBQn8S+zPp4N5vknLKnOx/jCE8tsGK9u9WUZWkaLdfLHbw6RsMnroIwlBMRdBZI3vl+cn0M9yaPbSR4ziNsW5g2RsG+11xCVZQOV8oNMEjAHZxUXUKG04I1EM4hQBOese1SYeddENjy0fsuEDkYpjuAcrNm6SpMQRXT385NnMQw2eVOcD9oWmdJIFLpMDYOX3VK3zg4CmvQ0uG2LCbM4CR58qaE6Ev7vIP/2AwzIUyRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55AyQygXisdXsfo56U9awjqO2AJAC9A7UKPiUujpmwE=;
 b=RkZ6821zhgtIowxvfhQzQhrE10sYOTNqaZzq8FTAviH+kz4C+ghwbi8kl7XlSJ5E9xpC1Zr+umYOFqeM0EBpm9QMyG67Blx211vGasG/a+ovtQ0wrs+CfVRp4H/82LasetZokk+fU4y9E6gIhAwgpkSU9a5koHSDPD60+B2KXVoSASnA2CZF2B35fv0BC5fU0qJGuuoFjyzCd7yCv/hHvFGupmf0WApXsnk2jajHNE/CBQ8taPUbPWb/ckKI/oyBiUDQPn6aqx1oDedmyjyIPOfdu4I5y2zfmXgtsec0dN1yeCh3/spDFSCUmSf0QDvFLwRYUzcpzpScly7N1+OffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55AyQygXisdXsfo56U9awjqO2AJAC9A7UKPiUujpmwE=;
 b=LFldx/+y5iE534v2gVPijRN+PmIWV40v8OpeJyCJOoUyZzU4ohntptrRJFRGjJgI+QxoQkVfAClGJBQU+kkVv0j8vAIg+F24OTGyyWT9HFwG1lDyIWjCXy/07O61X9cb/ONaYOTvNBPUujExhc375RNN3+vch7kMeKcqIyL8QS0=
Received: from CY5PR18CA0015.namprd18.prod.outlook.com (2603:10b6:930:5::18)
 by DM6PR12MB4580.namprd12.prod.outlook.com (2603:10b6:5:2a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:54:07 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::a5) by CY5PR18CA0015.outlook.office365.com
 (2603:10b6:930:5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Tue, 22 Nov 2022 05:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Tue, 22 Nov 2022 05:54:07 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:53:26 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/19] drm/amdgpu/pm: use the specific mailbox registers only
 for SMU IP v13.0.4
Date: Tue, 22 Nov 2022 13:50:22 +0800
Message-ID: <20221122055025.2104075-16-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|DM6PR12MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a35841-edd8-4e4f-5117-08dacc4df80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45JWrvDHKb0xfsyxndKTFuCCZi2+F6Xq9auNPoBVb7oSihJ2I71DhQA6OIfvx9tl5lqbJkeZ6zWAmiPugxHpKksOseJ/DB15JV+qtpS450LthqF65sxcqkAUk4+4CpMM0xdFHfU3XksQvLN85AX9hAEASCJcDBUWvZh3WiZkkx0XjwaZQcERKk8JJvRKvkR/KdSdnhXr3IAhGMZ5KxTpkzzEJpHWz1IQ9ugYnlUmQ6HBNJ38dU/I13mZNOKKHtCLf+9JnI+UApZ1Gvi5B/uFXKwLZKkf/WuwaVt1ONszlTZ5PvzJ/dqZfZhNqfUgGeu9fhOGqg+8bVZNifQbLRGvHx36KbxJ/Uq7ujT4sJpByZgxBUWZsyYslKhRa5s4w1p264xkZ2duD4ePCp5clI7CD/mgwcOoWOEfL/sarURwKTd+rOWcE56opcUDQtFg0Kh/RlmMqXPhclkQXEGQyjAWGXLY2Vs7PMarlQbqm6gmTprDvQ4K5BOEY+oRHEJ5PmGRZ7SYxpYLvUd5jmU/N5ID59Z0Pcalaf7+pEhZXnpVBNnOh7Y5//PJlXlNcKmyj6KVmgmgPW4aH/lo/Vj0wfLD09+pa6uIfbku766KrFrQ2MIouJ363Sg3UwzfBURQ9y+KisAdW/NwKJhuTxrQ0psdR9ZnAmh3M1rqi2vHAOMyRIDZr0nzoase2qAXPJjC7xj1yD5VjM1PTMqTwn/OfguWfqScOztr3O2iv5nk4jBuIMQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(86362001)(36860700001)(26005)(40460700003)(1076003)(40480700001)(15650500001)(2906002)(5660300002)(47076005)(16526019)(186003)(426003)(2616005)(356005)(81166007)(82740400003)(336012)(83380400001)(54906003)(82310400005)(6666004)(70586007)(41300700001)(316002)(70206006)(8676002)(6916009)(478600001)(8936002)(4326008)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:54:07.1513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a35841-edd8-4e4f-5117-08dacc4df80c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4580
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
Cc: Alexander.Deucher@amd.com, Tim Huang <tim.huang@amd.com>,
 Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tim Huang <tim.huang@amd.com>

The SMU IP v13.0.4 ppt interface is shared by IP v13.0.11, they use
the different mailbox register offset. So use the specific mailbox
registers offset for v13.0.4.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c    | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 97e1d55dcaad..8fa9a36c38b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -1026,6 +1026,15 @@ static const struct pptable_funcs smu_v13_0_4_ppt_funcs = {
 	.set_gfx_power_up_by_imu = smu_v13_0_set_gfx_power_up_by_imu,
 };
 
+static void smu_v13_0_4_set_smu_mailbox_registers(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+}
+
 void smu_v13_0_4_set_ppt_funcs(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1035,7 +1044,9 @@ void smu_v13_0_4_set_ppt_funcs(struct smu_context *smu)
 	smu->feature_map = smu_v13_0_4_feature_mask_map;
 	smu->table_map = smu_v13_0_4_table_map;
 	smu->is_apu = true;
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4))
+		smu_v13_0_4_set_smu_mailbox_registers(smu);
+	else
+		smu_v13_0_set_smu_mailbox_registers(smu);
 }
-- 
2.37.3

