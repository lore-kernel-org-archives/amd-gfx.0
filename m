Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6D2C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 03:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87BA2076E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 03:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2boABqKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87BA2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3206E02D;
	Fri, 21 Aug 2020 03:51:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDBFE6E02D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 03:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcxDUP8Ndl+qcAHgK69noDV/Irz0WgznnW7Ti8owslMmKg9yAfW2AeiXlxVhNpBEY2XHkAuhUCN9uRAYnRnPFnaf/wuvQIUFstnxODPpy1nSUfZ7bLUCGwk0NH0NfQ6AMwqV6dQcJjGbtkaXEGNYr0eAQeunNR7XTdAx5OWsKD3WtJT1ZhTY3Xqm8B05ttfgtBpyVvbW05qgKDfYj4q5cQgHnyQuMR3XZRzWAgg+LSz46BSOZX36yTNz/Mf536mQdrC3qf44q3zvqnhEooe1H2uDaIKIfjEVjvf+M8oVVjtHjpgFM+c6lpHwZicoNEmhIK8QLolZHhHLYqR9wF8dnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJxETx4FOqznztPGebZSxGgxx5jKkIMwL/EOcGt+aVA=;
 b=gQ4297HOVyKvdIfuOEoN3GMr/Juizh8ST4K9cjQ9x9/Vgtwwz2Q3Lr9Kch5L51CpN0t037UeINqixZgm1Esy1h4Hl+8VOdHK3lVMXGZVBYHgt/Q9lOIBSlYc64fClv2IIt2dE1cN938h3S4t+OrgsgRWWaWDnOZScZXge7bC+5eCMjNIRJdNU1F4WZ3+yxhaLnnUlXVOmHmDiGWo1D6DdJhgqjhS8tmbBZqjSoXMlPsMlh1ffAZyBxHgFbkV2OEujB9pAyErR6VPJIEFi01zLZIwgFXJnia4v94GoWlZngzogEhFomhDkZDQDDEYHm8ltg51xlW6ntmkCCFfFjUiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJxETx4FOqznztPGebZSxGgxx5jKkIMwL/EOcGt+aVA=;
 b=2boABqKQI7WICJbNfq3MxPoMy56WRyKYhehwn7ywjAd9p9UyYRoAaCkRVSMx3dkyJs9FJeqRw6HnirwTESnHjt9zFu7+4HYr5cNrvTg+t8a68QUV3YVBD/rsKJBhgf/Fg5YAmiNeQMm+zNOsqa+RDvy9rN5sSO+z9Ztmd+bmge4=
Received: from BN8PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:ac::36)
 by CY4PR12MB1477.namprd12.prod.outlook.com (2603:10b6:910:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 21 Aug
 2020 03:51:49 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::b3) by BN8PR07CA0023.outlook.office365.com
 (2603:10b6:408:ac::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Fri, 21 Aug 2020 03:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 03:51:48 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 22:51:47 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 20 Aug 2020 22:51:46 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable run_btc callback for sienna_cichlid
Date: Fri, 21 Aug 2020 11:51:22 +0800
Message-ID: <20200821035122.7711-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08c08d97-8577-4b31-d1df-08d8458587c3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1477:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1477A4B9B23B3A9EAA57620FEA5B0@CY4PR12MB1477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n94MxDa48fYf49rhrM1SfH8ffaFEQlTCqsggTBN1lk4i3JEXIZSobQfBIpCwbRnCV6LRhmDBNihQIeYIpQ07bgeDgyp5u5Lw89di/cCQtPeejJSEJva40VLxV6cFChO2ouMhHbbP7q29VeH1P5JruMm59as7jwcJSTehDWklZx7BKmLx46K2dpw32xcbxZ5lUC6jGtT+DT9f9ozbBllYYXISS0km+HKoBAiSd7mPIMcXSyUBoFQG+VM+MN2ARh4+d/psp8ao54NAQ9A3ZYO1aG00Ho/Z0HLUD5CJypeQZ2sx7TkwLJ0j52k3+n00kq4NSHHmG5268wjMizSRe+k675Tu2hreyb5K7Rsf46CeAMDJjfB4uJ78G1kpYA+MI//CBJte6yS33m5ZuOQTQGfh+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966005)(36756003)(6666004)(2616005)(426003)(86362001)(2906002)(1076003)(7696005)(54906003)(6916009)(8936002)(8676002)(316002)(5660300002)(186003)(4326008)(82740400003)(478600001)(70586007)(26005)(82310400002)(83380400001)(66574015)(70206006)(356005)(336012)(81166007)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 03:51:48.3219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c08d97-8577-4b31-d1df-08d8458587c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1477
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
Cc: likun.gao@amd.com, tao.zhou1@amd.com, kenneth.feng@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DC BTC support for sienna_cichlid is added, it provides
the DC tolerance and aging measurements.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I93b439b99c1bf365194d61385eb0fe0251f27041
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 8ffa8b71b75f..d2320ce7ef0d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -95,6 +95,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,       0),
 	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu,       0),
 	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           0),
+	MSG_MAP(RunDcBtc,			PPSMC_MSG_RunDcBtc,                    0),
 	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   0),
 	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            0),
 	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            0),
@@ -1735,6 +1736,11 @@ static int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
 	return ret;
 }
 
+static int sienna_cichlid_run_btc(struct smu_context *smu)
+{
+	return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+}
+
 static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2792,6 +2798,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.mode1_reset = smu_v11_0_mode1_reset,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
+	.run_btc = sienna_cichlid_run_btc,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = sienna_cichlid_get_gpu_metrics,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
