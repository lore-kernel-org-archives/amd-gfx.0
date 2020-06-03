Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDE4C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 05:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8149206E6
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 05:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rvJ35mXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8149206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C63C6E4B5;
	Wed,  3 Jun 2020 05:03:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C5F6E4B5
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 05:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgFjhQY8VoqKBBibj2SklVzw9tJrMTqNfDULfdMkI9G6yTaTqT902xwHiDHb3jpeUfYodq1cBIe2p2KF4j9iWf70247odp4HHDmPRZvk2e9Tbd5Bkk819Q4Ca7hsdvUScIu5YM9wj32MyMwuUPruFcz83OXKBLimzCjr09gqQhrhb3452Bm9+TNPcteiUyKFkG6Khiio5ZSm3mhMponiGIwnReFrQWwI4e3lN9zcv/U4Zl9cd0mNhhUWACB2cH6KSOUzC360X64KjDHzU0y0ZrPUTbgRhTemK8ulI+hw2z8xlMlVRdqPxbhoTD52rVpqfkbUc488VN/DkMqgqQ6BQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INQukTXtjnPg9rXyKbESX5wfxKot1/bZ+GBPeVdCLJ4=;
 b=Gm7SuRRO9zwJPQVL+FViSAcx96QuAH72kFiumgt1JPzh+IueuHUFCCs/8+/thSg9Rgmd8yiCGxzyTw3CZAqEKC/0fgQbc+gwZXMzTbtAg5DwTZtxXC1G9lTteznqlFLaIjOpX3BNyxHKYAXsky7/q6Fz0EOZdw2xk2ktKiikLS2JyysEWPAzlPMsWHLhmjkiePznFif0CMGmauqwgLWAH/BHBY0GtRW+NbqHBK8Kj7bjaX4KR3nxXa9RAvSMpjaT/LhplOtnNG2mssqlPHjb6zjhhtdmBBLoP0+sTgJdzOi8mOMeuFNILMMGpSc5+/jcruUG4j8YuXDItZILacDJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INQukTXtjnPg9rXyKbESX5wfxKot1/bZ+GBPeVdCLJ4=;
 b=rvJ35mXBPCNr+NE4l890tBSGmQn3Vmc5ofAd0iWexWuvRhS/4IdTJrH/noSzXhicM7+2Zjb6WI/R6WgAF/hV0zLt7PmgnLoj/yvhj4vDSrRHrlFaU2M8RQhY22YPvgWzO0MU6gl2W0AqNN5kMAz2FXi/3qQlaEPidiIdBQZK+FI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3354.namprd12.prod.outlook.com (2603:10b6:5:11f::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Wed, 3 Jun 2020 05:03:49 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Wed, 3 Jun 2020
 05:03:48 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: use work queue to perform throttling
 logging
Date: Wed,  3 Jun 2020 13:03:27 +0800
Message-Id: <20200603050327.16680-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR06CA0018.apcprd06.prod.outlook.com (2603:1096:202:2e::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 05:03:47 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7946bd12-e12e-4d4d-e526-08d8077b8032
X-MS-TrafficTypeDiagnostic: DM6PR12MB3354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3354882CB0CB1E67A98ADFDDE4880@DM6PR12MB3354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:39;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5CmDyNUnnZWZiR44o7zYkd8V8OH6+xYvJ8TuhkupCtlUsCaoofnQv4BlVH37Vk8nLIwdTbZWIKIXvI/NiZQNVdhEa8KwX3Upx8DpEOnfxmgHvBOTJbp4Qzp1prPTcliBNah2C/5A+B9T/OvqBQt6bJKsLCYYAdGVhowYx92ORRcVfl/IT79iFbQVwVxeISSfvMkdYrRkHOV4Wwug0B7HqTvifHECco1WAksgl1d6H3Y2KphC6bi71KyENplzSxBrF+sKcWJ7NvDWIwuhjvBktwyAHSO/Fjg4yXttjvRsTWyPnwrDPg8K4wC2RFOAEYRS5+bXATj93DONf1gxodq4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(4326008)(8676002)(26005)(66946007)(52116002)(7696005)(36756003)(5660300002)(1076003)(316002)(66556008)(6486002)(6666004)(8936002)(66476007)(2616005)(86362001)(478600001)(44832011)(186003)(6916009)(83380400001)(16526019)(956004)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0RpVbm/jUSZkL7udGWER7LQEnVAaLAflzXA8iqQRZGt9rRY+ZluSzVZyZlpzJb59tTzfkfO8QkzPHzzitwWY5D4P15TICSh8M5L2gR75v6STm6575Sb5caCWadgrfXBs0mlK4EjmeKkO43hGyxtPD00xznZzvg8ivpwS5qaznHa8EJjoSPPptUJfGmrJbMoreTYitgn4hSgTAIERy6fbk/nPuNNMjJ31aIm2dE9f5Fk0Fgf0oL0i3/KAK5VL+kh+Yv01fXKj0JArRQtpDVqvniKjTL8zMQ1dFay4mfMJIDnIG3G0kkEpcYUwgUFq9pseozi8RX6Yrlxp7XWvFg/P0x38NVump8aLjbLNRnB3uxeHCH+8QiJKsY4p2ZIkO9g9eyliRkFczR9BXuPIcYOPNhzC1etbpyQHODGFSR7eKIS8/N+Ge6ukDnHNrjDXI69pHTK47E6IXQp7Md7ca8aKBJEO5e1wWWcfCjr+NSAS76aJTH0ESt6XfQPsmbOdaGMd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7946bd12-e12e-4d4d-e526-08d8077b8032
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 05:03:48.8744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IX6BOTVQyChruUaLJiiKZiAyrMVGi6OoJ1dBuNt7Iy8iJlu/zFBwjUH8JZS84Pp5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3354
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

As IO operations(access to SMU internals) and possible sleep are
involved in throttling logging. Workqueue can handle them well.
Otherwise we may hit "scheduling while atomic" error.

Change-Id: I454d593e965e54b13fdf04c112abb0a022204278
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 10 ++++++++++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 ++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      |  2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 342fd75b0806..e25a3b1ce7ac 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1053,6 +1053,14 @@ static int smu_smc_table_sw_fini(struct smu_context *smu)
 	return 0;
 }
 
+static void smu_throttling_logging_work_fn(struct work_struct *work)
+{
+	struct smu_context *smu = container_of(work, struct smu_context,
+					       throttling_logging_work);
+
+	smu_log_thermal_throttling(smu);
+}
+
 static int smu_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1074,6 +1082,7 @@ static int smu_sw_init(void *handle)
 	spin_lock_init(&smu->metrics_lock);
 	spin_lock_init(&smu->message_lock);
 
+	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
@@ -1295,6 +1304,7 @@ static int smu_internal_hw_cleanup(struct smu_context *smu)
 
 	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
+	cancel_work_sync(&smu->throttling_logging_work);
 	ret = smu_disable_thermal_alert(smu);
 	if (ret) {
 		pr_warn("Fail to stop thermal control!\n");
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 6f44ffb6eb51..b970b4d663b0 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -411,6 +411,8 @@ struct smu_context
 
 	bool uploading_custom_pp_table;
 	bool dc_controlled_by_gpio;
+
+	struct work_struct throttling_logging_work;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index adde9eb7b283..69b1160d8ba2 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1597,7 +1597,7 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 					return 0;
 
 				if (__ratelimit(&adev->throttling_logging_rs))
-					smu_log_thermal_throttling(smu);
+					schedule_work(&smu->throttling_logging_work);
 
 				break;
 			}
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
