Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF8C47092
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2BF8610A1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BF8610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F2BA6EAA1;
	Tue,  1 Jun 2021 18:14:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348296E1D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 18:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO776HHYqNRJqmL35+Jpbp8IDz6lRGTaYPj7Mf1Sue4U/r/WYF9IpTJLrFhoUNFQRPZgRaRNaHjxcrET0wP42DNQ6Iv4rj+3vbUdeBB3WEvwb7Qq5P6B++Y1fxKGGv+fslI/xIfTBo4Gnz0qJXsZqeYbTpKDQAT7fBpvz07BpJCAgr6qybDIeLF94jyBywwCY8ouRWGXTWFmC7pDxYEAuw/DK3ZJk/5ePKHD1dDnRcj4nLpDeDbSOq2RW9oLtcUjXljyENmS+e/hgZWQRN2p8bvOVHYy/s+2VdwyeVNVzMiIPyQ/DF/Bs+ANM6pYybnBbN506L2Sn5TKc851UFY4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTVU4B+vgWd8BwpF7lxDOhUELBnle+aFEKw4kpiUwn4=;
 b=igRlyF1dUzLHdAMsEom3Fj/KkrshYSTAlNbWoGb0CsDwT49hZguGuCcEpNOw4eKNp5ZjQH0J7CWzv+IUz/hxAr1xx86CODQY3PtXLLQDTkPJi2QHZ0haiFDujlKJF9TpJq4F+BKuq+sthytynA9qiIXbhIbzt2hToUdqj4ih8SzBolfxE1uYQ7KaG/JD0OOr82k8uDIhu+3QytwsnraAH4Vvki/UwM/nqvWHPw1Fh84fY5c8c+VAnBC+Ob/HEcoS/t3lgCGX0X+yQiGDLAlQJcOYYZsS5fcmXIQ29KCD6qP9yk1fOB2J+P2cEVoemaToxY3bHaEjUJ6vDrRjse5cCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTVU4B+vgWd8BwpF7lxDOhUELBnle+aFEKw4kpiUwn4=;
 b=Mfa61hG6vDvjGboBB2VhZE3vd8K8XnWwKHv8qkAeW2Mo7YjHuJ8BeYtNS8TY8e2/uafA5w+AKj/vklSB8vWgv7VtjzRxz+qhUpeM7X24t51tht9HimBr1+VClitklGsfNGVJUgkxh5j13DObkV27PJHbKeagePzqaigQFl6+kmE=
Received: from DM3PR08CA0002.namprd08.prod.outlook.com (2603:10b6:0:52::12) by
 BL0PR12MB2530.namprd12.prod.outlook.com (2603:10b6:207:43::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Tue, 1 Jun 2021 18:14:01 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::78) by DM3PR08CA0002.outlook.office365.com
 (2603:10b6:0:52::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 18:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 18:14:01 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 13:13:58 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Date: Tue, 1 Jun 2021 14:12:27 -0400
Message-ID: <20210601181231.24773-4-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210601181231.24773-1-Graham.Sider@amd.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3b90044-b7e6-44e8-e2f4-08d925290877
X-MS-TrafficTypeDiagnostic: BL0PR12MB2530:
X-Microsoft-Antispam-PRVS: <BL0PR12MB25306E08DB4E69A91BE8F6F88A3E9@BL0PR12MB2530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7Oh8RdOs8fuaphu9XKWvqgiQpEA1YlBdnyh0ck5EmOJnLXCce+TcuraSHZDitJvmQwhT3T3bcJeIaNDCcF+KpfjVPYp66LjGv/olnIA+IBU01NoO30Xo8DEJOji0WV9O1urPNFDMlNKZqNvR3YwWjJd1BI4LAHemla3V7oE3MLke5/eFPcRfcFT2nbRaFHAdqp/Y9k33PenK9gtX9c0pSplniZZguGcXKFJQznNNzbZjvssYykSnVc0eBH/r5Agm+keE01oZrAMGnLDLGWZuk2TOG7S8huygLgFgQZIIkhUaZeROVrQAypxsqWDsdG8cZiV6vCWI8Afom18nIUJrpcVVgyI8PhbjaBgdbzkivtOwPoVT/r423MmycNLQz4rGKo5adZuT9wIYJeHnVu3Fsit1YNrFmwx5NzXkOcIBX+Ks8EAbe97NWFY4GUGbQA24UkFyKVMNl3RWYvD/jboxtIJ5dFawCnAAyiwM7O/zlaTpDDGD+aQRAoOrUCnzxNTScSSFKhU/Xtx+IiWlCZiswp5e9mXCsNa+f5hHATPHoIrONE9cJDMimTmSC04XZZSYfdOE2GH/WZVAUc6HLE3UxnN0hUW7LgsX/0f7YrP6qRq6WFqM6Sp7rVLxlpo5vZzzvKX5HkVYnr2s3RQR00BqQPDlGTwremxA0c2+IBGGdUqK53XdZTKcOtrfOQZWNYQPQ/5vnOEHr35DED1ucX1ykU3NxMLIvIEenlgOBmjTtE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(478600001)(2906002)(6666004)(4326008)(54906003)(16526019)(36756003)(36860700001)(6916009)(47076005)(186003)(316002)(356005)(8936002)(336012)(83380400001)(26005)(82740400003)(82310400003)(5660300002)(426003)(70206006)(70586007)(81166007)(1076003)(8676002)(86362001)(2616005)(32563001)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 18:14:01.4618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b90044-b7e6-44e8-e2f4-08d925290877
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2530
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
Cc: Lijo.Lazar@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Perform dependent to independent throttle status translation
for navi1x. Makes use of lookup table navi1x_throttler_map.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..bf376b1be08d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -238,6 +238,28 @@ static struct cmn2asic_mapping navi10_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
+static const uint8_t navi1x_throttler_map[] = {
+	[THROTTLER_TEMP_EDGE_BIT]	= (SMU_THROTTLER_TEMP_EDGE_BIT),
+	[THROTTLER_TEMP_HOTSPOT_BIT]	= (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
+	[THROTTLER_TEMP_MEM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
+	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_TEMP_VR_MEM0_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM_BIT),
+	[THROTTLER_TEMP_VR_MEM1_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM_BIT),
+	[THROTTLER_TEMP_VR_SOC_BIT]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_TEMP_LIQUID0_BIT]	= (SMU_THROTTLER_TEMP_LIQUID_BIT),
+	[THROTTLER_TEMP_LIQUID1_BIT]	= (SMU_THROTTLER_TEMP_LIQUID_BIT),
+	[THROTTLER_TDC_GFX_BIT]		= (SMU_THROTTLER_TDC_GFX_BIT),
+	[THROTTLER_TDC_SOC_BIT]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
+	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
+	[THROTTLER_PPT2_BIT]		= (SMU_THROTTLER_PPT2_BIT),
+	[THROTTLER_PPT3_BIT]		= (SMU_THROTTLER_PPT3_BIT),
+	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
+	[THROTTLER_PPM_BIT]		= (SMU_THROTTLER_PPM_BIT),
+	[THROTTLER_APCC_BIT]		= (SMU_THROTTLER_APCC_BIT),
+};
+
+
 static bool is_asic_secure(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -524,6 +546,19 @@ static int navi10_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint64_t navi1x_get_indep_throttler_status(
+					const unsigned long dep_status)
+{
+	uint64_t indep_status = 0;
+	uint8_t dep_bit = 0;
+
+	for_each_set_bit(dep_bit, &dep_status, 32)
+		indep_status |= smu_u64_throttler_bit(dep_status,
+			navi1x_throttler_map[dep_bit], dep_bit);
+
+	return indep_status;
+}
+
 static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
 					      MetricsMember_t member,
 					      uint32_t *value)
@@ -2673,6 +2708,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2750,6 +2787,8 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2826,6 +2865,8 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2908,6 +2949,8 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
