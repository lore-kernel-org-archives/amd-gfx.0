Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FB1C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B4A2613C1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4A2613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B451A6E029;
	Tue, 18 May 2021 02:05:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D828D6E029
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 02:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZaWLvPvOONIEkTttrEup3qRChoEGiVggEEsKxShgCvkdKYNXBe5RrWVea49H1f63fMbG18Eg/hILGicoPqWvQXFcLE6rXOs7cd58rKRD5AqdZlITKy75OzdKs5u5tTAjpee01nFS2snCJFuKEjv96ztgMjoWtVZkR5w9FGIz6V+y8/TIu1LuP2Vtc4PhiSCwu7HCKY1y7anuqxAsQuub+6ZHaO3CTlHHCyyIAZodc/4T0qmRrW/Av/12QNC1ydr/7v+jqqCzHXAUo2EKojV61qVgsL7Aoffpvp1/ZEQQThUUbSI7PZg3jjxUXatmBVM7TNTDmMHvWJqXx1lJA4OQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYUw1A3Xs8MbQxGXo4oqo/tayCjTyEJLqMnPjhuiwjQ=;
 b=hZSkSrgoBI5hmGRIX+Jw4aId9lg/3mhv06rAisEYmfyPOHMlXnJSqDu0RwZ2Y/HEyo0d8Ssdc79UbYsWz5IdyPErgPakbIoST/2yHPCBgvE2TmozP0nh4oKJl91hvcEk6E1qgAIAK49/M5uMJetDVq3Hp6CNJBVeD6LqjKGdwZfMyVuB/xLIJ01uoof4NTxyQpu3RDXMFrs/ny86eJqzyFDkcLIY2MceSfi+X3jm2PZkWnc2XpU7ZMber11xbHKhvfv9LCgOOTLxT7t5KHRpvAu8O9iqVFPYmcTTKtxcuLO6iuiEZqFEF0Ymcv1Oi1fyuRO3gSyb5OlY6/lS/9ulyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYUw1A3Xs8MbQxGXo4oqo/tayCjTyEJLqMnPjhuiwjQ=;
 b=G5xqvKdgN2XpfLTfKqmFWYSRfIvHeBh441hlhHN2CXTorFJzoJ8jbjret/UNsZXqexmSoSKLsfxOMmr+z89iatQnuP9ZGqO7+jslCn1ZOQqjowKKrRht3Z+rDqVkuaQtKknLdjD38h0akPsk0Oh8k/cSjHa3eNTqkoCs1m4q3iI=
Received: from MWHPR20CA0015.namprd20.prod.outlook.com (2603:10b6:300:13d::25)
 by DM5PR12MB1804.namprd12.prod.outlook.com (2603:10b6:3:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 02:05:21 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::6d) by MWHPR20CA0015.outlook.office365.com
 (2603:10b6:300:13d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend
 Transport; Tue, 18 May 2021 02:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 02:05:20 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 21:05:18 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
Date: Tue, 18 May 2021 10:05:02 +0800
Message-ID: <20210518020502.351803-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf267ce-6308-4da4-beff-08d919a16413
X-MS-TrafficTypeDiagnostic: DM5PR12MB1804:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18047CE9AA401C7A557A7600E42C9@DM5PR12MB1804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5spZwob0FKq5b6Ym++8gTK+DyWBgWNXdLAf0+DoU4RJjdgkSehdd7PlM+MG/h6aaTzQmfFLvU98f+I+fdhDZR3/n89e5sNHE06Sg0gvVC6VPCJ4tbxXnDKcyPvsrvAe8j4tbbcI30Dcmin+q1Z/k0ekLfqO/cqd5LcnBFJWasiHw1KTVSoDynzM2ew1MPAjsI/paEK+Wpeh4d5zT/YwEdXV4Ylze+F51MME1APEfl6kNZXfTVj0eLwNzORjGUhqRhhhkqLyu0oPUDi22E5scdL3062n8/+A4MOYQLZ0mW541IL+xMTHGKfZ25UtmRVPPQJjzBoIVa/ezv04uW1sQlUygMMhsjJshIfqsaRC7rFlIpGDkKzHOvmF6ggPIvWp2jSvqU7auu9IWm136BhpTxjV2+aOK0aQCdSVftTxis7cXx8aTmJLLhtXwf6WRlJ5VcB7KLLfSAxa7qPQFTCOwW5YKDT/tQxw7/XU+GQIsUFWKxHBVU6J17ZYKqKyWO1UILS6o2us8bFyvSjy5Mm6PytWLaI9gM9dvy9BmLKnYare9t6ih5Y/y7lkJdbVGvkF6SNo5BsfxJmSdJs++z6GAxPMo2NqvOejKl/mH/yXkh3+DSeLaVXTROTBjsCpl9VCptqSxX4m26zRiU2GZOqAvjDj4KmLFazQYvaBJIrsUg8CIj0Mc0aF5rirSGtyo+mOP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(4326008)(36860700001)(86362001)(6666004)(44832011)(8936002)(70206006)(478600001)(70586007)(6916009)(82310400003)(2616005)(8676002)(5660300002)(2906002)(7696005)(26005)(36756003)(356005)(81166007)(316002)(186003)(16526019)(426003)(54906003)(336012)(1076003)(47076005)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 02:05:20.7391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf267ce-6308-4da4-beff-08d919a16413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1804
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Kenneth.Feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No MGpuFanBoost setting for those ASICs which do not support it.
Otherwise, it may breaks their fan control feature.

Change-Id: Ifa9c87ac537a07937a0f0f6a670f21368eb29218
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        |  9 +++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index d2063b1e7936..f16c76038f13 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2936,6 +2936,8 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
 
 static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 {
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *smc_pptable = table_context->driver_pptable;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t param = 0;
 
@@ -2943,6 +2945,13 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 	if (adev->asic_type == CHIP_NAVI12)
 		return 0;
 
+	/*
+	 * Skip the MGpuFanBoost setting for those ASICs
+	 * which do not support it
+	 */
+	if (!smc_pptable->MGpuFanBoostLimitRpm)
+		return 0;
+
 	/* Workaround for WS SKU */
 	if (adev->pdev->device == 0x7312 &&
 	    adev->pdev->revision == 0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3c3a7f9233e0..159cd698323e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3201,6 +3201,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
 {
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *smc_pptable = table_context->driver_pptable;
+
+	/*
+	 * Skip the MGpuFanBoost setting for those ASICs
+	 * which do not support it
+	 */
+	if (!smc_pptable->MGpuFanBoostLimitRpm)
+		return 0;
+
 	return smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetMGpuFanBoostLimitRpm,
 					       0,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
