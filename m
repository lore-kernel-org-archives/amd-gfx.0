Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84EEC433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9547E20773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jt7Gfbsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9547E20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50216E14E;
	Wed,  2 Sep 2020 08:32:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6BDD6E13B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 08:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMw/9r5zzzLJtKpfGP6t5Gb9b4WMec5v9ZeeDNSyGPOQvV1GvGwE8M3eOg58REXhU5cMrBjC2A6mdY8X2myQkWZnIMMQ6sXDAX05vWZw7/YmSeuDYrZMf5OyNbS5PAssJ3kw6kyZLt22CNRF80S5dHZR2OlRFod5iLeHkWfaT7p8J7Vs6woW4njcoKwS0jE3ux5Hi3kxREn5gDbtpowiYP4WZ85pp2JvU+ophaA1FGYcj1QyxNnNT9LKW4z+LXQ3lCBrSqW0HqABXDVNs23243RBMZ70/fMSYNyeRfAk6CJO+B/dVsLL0iWpHLgXysr/BdopUMAbF1Xo388/dyuFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+JcYe90B+RfcRTgtP7ZFYL8cRXcH1VCil3/pZ3t/CA=;
 b=LfEDoQ/VC/yH5vrjWSuYo8kv6ZzIAEDQUF66rDdR1IL4LytZdV1hgPyenudxkSc5tBELScMlK7qJDQXPKreu2Abh2wPPYoftzuuRexQz0uQ0yIRQa17i+iP+ER7dzIAjdTzn2ftmWbTPB3qFW90tEdgIqauHl/oZFmSQxEw0uH0wx+rUoTzOJvQArUR6rwJdycGKCqT++J2cqxtQ9+0W5LB2RK0VlxkNq/c1d8b1f+s6FIMNRWCwCTwG8SK+C6nkh42rSk/dPhgS1E25Yg8IaZcJkjxUdXG1jKwCQCA2VIw4VAWthYsYfZ0GilNt7j2gilXuBmJ5rdrHeNiDl7dngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+JcYe90B+RfcRTgtP7ZFYL8cRXcH1VCil3/pZ3t/CA=;
 b=Jt7Gfbsp4zPqIGdWqzVeKni9IvjHi/nj2XH42fZ8hWH9F3DKfiFr3Hc+Yi6NHOCAAbJrr0kvbrUvn6Kf1j/6f3kPzMkIhF9yhD9XhyIWRAA/KoHsWDCRnHNIZF+uj7WUJ1mhVFrmpyd/uqWGuIG2rEAmR6eO+NNAMa/Y/BgFzKg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Wed, 2 Sep 2020 08:32:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 08:32:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/9] drm/amd/pm: wrapper for postponing some setup job after
 DAL initializatioa(V2)
Date: Wed,  2 Sep 2020 16:31:26 +0800
Message-Id: <20200902083134.25569-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 08:32:02 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85a56af9-787e-4aed-a108-08d84f1aab7b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3868FFB0683BDA20DDC74293E42F0@DM6PR12MB3868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOgFIaUimJ7Tfcrdlzgo88xfC8/5PGeQR2xFcYaNiKWC1AuVBrvlBwyEhseIhb/vsNHDMTgAE/OeumkLFntuj6ShmxsvsOkHq7lNhXl16YK+QzjGYbKUYxyOn/S6lLWiBHprWAYUymndguk0sKHvA5R1LozSloBebpPum2N5uIZOzH9f7+9jedmfQ19BeuKunWDKVbZkRjgxLysmwAeSyNb1WgwwNX4apdGHGj68u0MXQ9iB4KPW14R/vhsf95Q+PKM2d3GdJoIZfJaLdJWd3L2qswSV58cHkrDHUBAF6GyButsrSQ8fRvm1PILrSFv9kf4NkxKVEDOT/HEpLp5G8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(66946007)(2906002)(36756003)(16576012)(66556008)(4326008)(44832011)(316002)(186003)(66476007)(5660300002)(6486002)(8676002)(86362001)(6666004)(26005)(2616005)(956004)(6916009)(478600001)(52116002)(8936002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qnrw+hLpcQBowckya7I4lmRhQS8ft+Dkh+S8GLA8B35H8O20p4QmPLgaw8yf1EZHwN52VM/l+aUaMPh2bYw/tM697KcnUChIdP9J9S/vvpLEci05pwBXkD8vN7PPGYLIEyWyuRv9PGydxu0DfWE4QNGovJnugG2kb2Qx60aAm3LO1ShCrzRk1mY9dR4IZAEJtcfxyNfE22Nynv67Maou/4FXJS/iXbts+3OVwHJohqewn91mAbjUWCELMmeiHTlLb1odYPTZaKDmixAgC71HFQwJ0gOO2btvDOhBGbC1fsgzUz8xk59WOwtJLCJ7qD9Sw1Rxy0VsoFcxl2hZrGeI4/X1yc9elik9m+JkXOJjpiczm/LM2BzjK8KtdeusKZR8dpBWF0UEdiO9O/KbQLdFNTW6SPN/YuWL9W3JJuq2ijgaD9TnOSm66etCt5ZJ0DoF+wECrp4GnWY9LSboXADMDiH7PcoBeLtOqGbuUzKL96OUMyF260aC+0P8kfM/bZnsW+FqOgUZ5j/vgPikPAPeGJWetJ6Cj+Zv52cJJWXqHbz8cEivgNzISBXyodWoFGIn0Zbelp17tf8wHTek/RWaBEwhlurIeRXfjjAD8I+E4hHBCqgWvjkShgJUw1M/dwe07ByDKfrSAQnS20Nz3quspg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a56af9-787e-4aed-a108-08d84f1aab7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 08:32:04.0293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fz8amLmxeWQoQkC6HvbiYmsJJQMtucd4qmm5awKu84gdObQOdY0txRrL0sjgSsec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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

So that ASIC specific actions can be added.

V2: better namings

Change-Id: Iabc9241d3e10ece9cd54d8cdb3ae8c8b831c7bce
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index d22a759b6b43..4acc3c4c4737 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -600,6 +600,7 @@ struct pptable_funcs {
 	int (*gfx_ulv_control)(struct smu_context *smu, bool enablement);
 	int (*deep_sleep_control)(struct smu_context *smu, bool enablement);
 	int (*get_fan_parameters)(struct smu_context *smu);
+	int (*post_init)(struct smu_context *smu);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7a55ece1f124..8d7c75c51fe5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -473,6 +473,12 @@ static int smu_late_init(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
+	ret = smu_post_init(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to post smu init!\n");
+		return ret;
+	}
+
 	ret = smu_set_default_od_settings(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to setup default OD settings!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 38c10177ed21..db903889f6a7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -95,6 +95,7 @@
 #define smu_gfx_ulv_control(smu, enablement)				smu_ppt_funcs(gfx_ulv_control, 0, smu, enablement)
 #define smu_deep_sleep_control(smu, enablement)				smu_ppt_funcs(deep_sleep_control, 0, smu, enablement)
 #define smu_get_fan_parameters(smu)					smu_ppt_funcs(get_fan_parameters, 0, smu)
+#define smu_post_init(smu)						smu_ppt_funcs(post_init, 0, smu)
 
 #endif
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
