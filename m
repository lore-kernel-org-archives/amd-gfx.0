Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDA5C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 08:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4B520719
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 08:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qeBv/IgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4B520719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF1289C88;
	Mon, 27 Jul 2020 08:24:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0837899BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 08:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzAAWROkscvX0CzmINzntuEECNezRurQnn3dujWnOlFJfcr1E68ojyL9dzhk0RNldynxdLalfhwNO1wPTYIhwYTLdZOzBqmRjS7tEg7LS5p0JhFkmD0TmbVRNo8swFooVjfwYnfAKYsfGK8Wh3bQPMkWHlzFWB7S16+kt2QONJ1wQMw2OlLR1vYSMgqxt/ZhTTdQQSwACm1npDuVNCl7jmVYwQMjbTmq8ZCjJFycr8TtfnAKCOsVj1sDvSd8GQjW3D1SK3BZlgR1IFXJnlco4CLFm0CDDGwrlDHSSYPxnW3NnyzoaPqWzniFB5VJv4J2Sl7/LCzj0vJ+o1EfWbJ7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/Qdr0iSNxJGCoUnqCIIC0h3ZFmvjfCcQAqZ4qLk4tc=;
 b=DC74T+WzA5SjgElG51xSfeQnhb4aHLbHgCw3pAQ+pXhc/8rvrFP1rfyA7xnuEHDbOmLO3AXsjk3XAFk+jyP7rUEOz1wSs92eCjjc9X5Vg/osvwyHc37E2gcjECqhSKVX0DJDTDZBzpy5cw4zS3wowQ/hky/e3dkeJ82vv5whzLEHLpQUg5W105wBb2u816B2orIR4WHKKJJLTuWRAg/PvB9vjtgDInDF0fGk0EDTolc0Kx677r0EIg/tz1twT7jtB2GNDxoOUzBXVfkFhQZruRh5H6dMAM8U8LvtY4/1nms3zofQhCJgvuOzbldyIa6SuxdWC7yimM4gOqg6wxTRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/Qdr0iSNxJGCoUnqCIIC0h3ZFmvjfCcQAqZ4qLk4tc=;
 b=qeBv/IgG/3wknAjqpN6zZ1Wl3X8GFcJFQbyF1ojiIXnKH/scpEShyY4TgAhvSJsgxpbsujg6gWpcGiwNzx+FG8zGNpVI+SvL2WsLBaguedjc+RQ2EFB9TxZzjYuF7Zg/t1NPdA+GYcwuD3Dtt9OCDjJusmfQ26tHDB8LCoc4opg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 08:24:27 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 08:24:27 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: skip crit temperature values on APU
Date: Mon, 27 Jul 2020 16:23:58 +0800
Message-Id: <20200727082358.1242582-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK0PR01CA0062.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Mon, 27 Jul 2020 08:24:25 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6341c21f-7d64-4b6a-b281-08d8320679a9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB404827159A5EFF6D68A843E8EC720@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogJ6RzKFbxEBFbQdmHsp8GFmykwEGUXExcvJLeFCLLjubT7k/5ZbmLwhM6TZlYaVbGEzzc8r9APdVzTgzkeypxXaOpg9ftgqGMjTQjZVSOqCH4tUDPIRNFkHIhxU/vQXQAHCaECrImnhCy4uJcsL5zvTXheO8/Loa7GWEib3KV7V32l0mH5qmGkiRv2cWddX601XhPP6qy9MvzW/yGo3ubfCmQCFhQcfL/KgVN41/v1bkK5KCLaR1ztQ9S2DMWJCXZEjGRhU3pfnYlJ/wNLjfamIDj8khqK3PM9GFwO3v0ZKaMSy9ULh3an7a9m+GX7Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(83380400001)(478600001)(186003)(6486002)(16526019)(86362001)(8676002)(36756003)(316002)(26005)(1076003)(52116002)(66476007)(66556008)(6666004)(7696005)(66946007)(4326008)(2616005)(6916009)(956004)(8936002)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qJvHuHLbGep5bG1N/47bOfsj/ApojbzY3zPQ9HtIj2eExYolejHsLqll8e55DLD+mmsvITI8zIJhmKKYtdrREx2yURXlrtV5yUxUrxRCjNXlUiSHWxuV0KRyY7ueNOAK5Uu2OE10EfR3KmOlAzdmjK5YbUOkOZvQ1sg/6CltDkMGPKrfp4htUAnA/VJBitKEVrFPmeQSXRGV+gAyqnhCrr6GCRwwduLwROWq3SYQpCA5O0U2d+nirvYC6BZk9KCpOFwSxzAJFozZHOLKhKj3ws9dMiyTkcLwI33PARenKMxegCBoIy8V1NlPKwsLkligO51QFkHxfDIbueoFqQe018pVPYmYx3O+tVpk45UOjMweOQgfIQtIlWrtmOZ64cFdWVhV70wMJFbSSCvjVKnAnLQErXYCGtOsJ7iAOxlZ+P9JVZOPJivkNR8E6KPFF6EmOFBC+Xb1OPZrx9m7D8j9MyQ3MrG7I0PGAjz+BjF+DZw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6341c21f-7d64-4b6a-b281-08d8320679a9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 08:24:26.9140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gb1oUjxPo+6odquT75bA1B+AF3i3FZ4rzuluOFKKcUB4tD2c6CGcXWVGfIUT1B/du1pnI2Kb08AD6jS+VJyD3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It doesn't expose PPTable descriptor on APU platform. So max/min
temperature values cannot be got from APU platform.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---

This patch needs to backport to stable tree.

Thanks,
Ray

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 5f20cadee343..65ddf575ccbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3212,6 +3212,12 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	     attr == &sensor_dev_attr_fan1_enable.dev_attr.attr))
 		return 0;
 
+	/* Skip crit temp on APU */
+	if ((adev->flags & AMD_IS_APU) && (adev->family >= AMDGPU_FAMILY_RV) &&
+	    (attr == &sensor_dev_attr_temp1_crit.dev_attr.attr ||
+	     attr == &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr))
+		return 0;
+
 	/* Skip limit attributes if DPM is not enabled */
 	if (!adev->pm.dpm_enabled &&
 	    (attr == &sensor_dev_attr_temp1_crit.dev_attr.attr ||
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
