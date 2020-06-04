Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33721C433E3
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0930F2072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1XmShTxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0930F2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB5006E197;
	Thu,  4 Jun 2020 04:47:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6A16E197
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMU9YDtvM3xIy1Rxr0UTNhczPhQVvzQr5mjhHTt99dNDDIvh/ZaMe5kK7JHLovPWrYE54dj+AcLO8mkmNDks8Z1ViT0lykktiJ1JPiz4S1+tIYuMJfaylAoOIXZanq5BsueFYS1kKrV8kQxnXZzHTyTTy9+SLZaWeGXxn9+BwBh1uyYfFNxGZ9tcGMkw+vIUh8h09lez2CHumSUGiK+OlDJFseOsMyufIBzT0Mm7iQ+q+mi+9+i8914ZQUHShGU1M7Hn24xUDfLXJ20IAEPITr3y1llrnFovjYYlSZO+tvKWcBDYEYsrt2MaS/9Ng6Ru8O3du3g2uFYrwBfqch/03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feBjp1KdJ5U8yzlLXiF857Yd8dYAKixhiDsvURx8LE0=;
 b=fN91ONXWSt2k8Q1W2kPQYkqdFJMdYpdTiOgxwgVf+ECLP5h9HGAziCp7zMMwAMeymeFbtByTAdpIjVvSOZk8+C4z9uZUWqu1Qr7RggrKlmoM5gRqaCgkTEjeUdVgm2QvfXhjtNe+zMht0Ara1fMrNr1Q96r0c8ZfET6gvKuy0WMhmHqMMhV1BMVwODYd1/SsC9tPIOFcl7KECQLP878GuVRBpKTJEbdQMDXaYCtl1XGhlop52NRxJcMCpBcLPgwFLgi0IR52Rc0M8kqEk307VpaycLYvr4nEMFUz5FpEM6nWtoq5uVZPus6OQBQq12DXnu/U0E3pS/Cb3FVihdmlYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feBjp1KdJ5U8yzlLXiF857Yd8dYAKixhiDsvURx8LE0=;
 b=1XmShTxMEPRnUQic7Qwm1lhyQSfNfHchAr4fOkCpld8C+vDVscSj9Z/CzF6cSpIjaAo8gcjurZCzvHguP/b7cz5nN1iuwU4QKxEDMVYP7Xc+yCIVjaRjahehpsyqymx24pvelpuFx5NoAd+g1dezfSa2gsVtbNPqUqzl6Lgh2Sc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 04:47:12 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/16] drm/amd/powerplay: resort those operations performed in
 hw setup
Date: Thu,  4 Jun 2020 12:46:14 +0800
Message-Id: <20200604044619.18658-11-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:47:10 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 215e6671-cdd5-4659-bac4-08d808425870
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32129C54F76ED323633B5056E4890@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vR3BI7IhPCbSxB7vnWi/HK+sETFR8pfkK+RytTCx1xXRopWYpSPFjthgNFrvGAUFVrivpzIHfmxUlbDNkJF9Cjl8bcBvwos5BKZVQYUC4YFrjzPtXI7RmP/QNTjQ+1CWu1yCaqTOiyHihhSOhwAlriMHIlDh9EDb2s3QT4keRIk9Z6Y+lLWOtHh7U40IxzCGIg+uT2Gm2PyGN6J1WDTbajHXmnkydZaP5DVygY6DWxtHgNYa1rRFsq4/wssAREFI5QYrAPNeD16HaM1R/+9ts4HXqRx8FA/A7OlCAGPpFF1zeJBTDH2ERi/XJfzNoLcKqBJlPb+uKBDbo8i29y56Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(8936002)(8676002)(316002)(2906002)(6916009)(956004)(186003)(66556008)(66574014)(1076003)(6486002)(16526019)(478600001)(52116002)(7696005)(4326008)(83380400001)(36756003)(2616005)(66476007)(66946007)(5660300002)(86362001)(26005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YwZvhd4lQIDUPkIMbEW/qRX7MQQ55NXh8XO/fC+z0EvsO8mI/NmakYDXWfFncVRmf6fnu1TDHGVFnS+aHIb2SbgQz+pTJvzoJKpq+ZzmlXkvT8mIg6eNgfO9f258QXLS/j+bQOWvRRNaU061a5s93pDj0K1Jqdl6mao2YUUmJwCkxtSAiYQzF4b5RfVqAjQ/xB2q5DhKMtquGJ8gBVw1hblI4uayeVQuzkUR7aiY5B2YSZYIS0Sj66roLkOdN8JhgKoKCMYjEtuzJVrIgcNomNnWZqf5WQ6bw/YelBSNi/Ge613vbfcsyEBVf7dFWMyxDWcz0rxhY+fDZyDxIeDSfjpQ8XdfalY27pnJo5zG1Or4KhdGwXWZ0TGEs4OGZcfQuCU8B0mhP/UHztrMBsHn+RcT+E7+BKWjsQhvdCyM4Uf07i0Q2PV7KFP8zDvVTc7/GBLJ+3CvJF4C+EJoZotdIVRrNonI1khOXX1Z1rcC+EqMUSn+SVXu5uDhcZBy1ndb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215e6671-cdd5-4659-bac4-08d808425870
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:11.8851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uZ0HhE3ndOE6bsq1MsC9m6YjJtDe5gPn1I0azr9EQAAiWmtMbcL75iukDcQ6LG3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those common operations(for all ASICs) are placed first and followed
by ASIC specific ones. While the display related are placed at the last.

Change-Id: Id45caee98273c8c0b9c1c9f2713fcf8106e02000
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 61 +++++++++++-----------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 4c1f7c36b74b..b3410d111316 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1134,6 +1134,21 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	if (ret)
 		return ret;
 
+	/*
+	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
+	 */
+	ret = smu_set_tool_table_location(smu);
+	if (ret)
+		return ret;
+
+	/*
+	 * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
+	 * pool location.
+	 */
+	ret = smu_notify_memory_pool_location(smu);
+	if (ret)
+		return ret;
+
 	/* smu_dump_pptable(smu); */
 	/*
 	 * Copy pptable bo in the vram to smc with SMU MSGs such as
@@ -1147,6 +1162,7 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	ret = smu_run_btc(smu);
 	if (ret)
 		return ret;
+
 	ret = smu_feature_set_allowed_mask(smu);
 	if (ret)
 		return ret;
@@ -1155,6 +1171,21 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	if (ret)
 		return ret;
 
+	if (!smu_is_dpm_running(smu))
+		pr_info("dpm has been disabled\n");
+
+	ret = smu_override_pcie_parameters(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_enable_thermal_alert(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+	if (ret)
+		return ret;
+
 	ret = smu_disable_umc_cdr_12gbps_workaround(smu);
 	if (ret) {
 		pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
@@ -1185,36 +1216,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	ret = smu_override_pcie_parameters(smu);
-	if (ret)
-		return ret;
-
-	/*
-	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
-	 */
-	ret = smu_set_tool_table_location(smu);
-	if (ret)
-		return ret;
-
-	if (!smu_is_dpm_running(smu))
-		pr_info("dpm has been disabled\n");
-
-	/*
-	 * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
-	 * pool location.
-	 */
-	ret = smu_notify_memory_pool_location(smu);
-	if (ret)
-		return ret;
-
-	ret = smu_enable_thermal_alert(smu);
-	if (ret)
-		return ret;
-
-	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-	if (ret)
-		return ret;
-
 	return ret;
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
