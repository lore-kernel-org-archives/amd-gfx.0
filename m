Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE42C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116152072D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mitgZ/3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116152072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE7756E480;
	Mon, 17 Aug 2020 07:49:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7276E480
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 07:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbotIgO5awb/fj3NTTJLy/ENf9ziL9qZAbwCtucybkxL2tQBqlx/WTWydzZ1a9mcC7OeMTTdpAiiH/bsr54LWHAR/wBR0AiV5k8kVQ8f13twPr4tHYTK7MmvTcywOO7hEgbbm+1YKPeFsMYpAnq+bAjKZbilTGDn3ekUSHY2dMG5pKQx+DQIJlU+QhM7JyftofuND7+MzyFmZK2tLKHAWtbnByJzp0EOIybTR2RYtmQJA7Gh5uMowjem7PVBsOy5a938TwJHoFRktGw6Iye1dSjBOAy5bJ8thosvx1ikLj66o6J6UV5QycJz/pDvomb2D86d0K0pdNtXKLFxAWH/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RYheCCxyN5CQu/DZTAvjN1235Sfnlv8mfJDWxUAIKs=;
 b=blrKAEo/OXScKxKMdCZNzz3prqJobF1pGBOUbVwL3Q5P7Pjcmnao5UzCDbmYQgyL1WjG4qbMZirqzNBX/wC9MdbLVmoEmGEsxHOf4md7I7onEIq4W5jjqU/YHFEOB+HMgzTFTXpYFna0/tU6hyaAjF4aak1maUfVQaIxylFdXclUL3Zivy6wIBJN/7aZt62E0siMI6bQMR1JuRjKpHA0NrXGUOXNcJQrVuxNBXsGUPOdFRVsi+dIDCCPB5tvI1TwmrUYs9ZcL1qfJs1kWdUZ2h6FY/Hj5mwVApU7f2eUYpv60KnDTjko9lI8i8L7QLKq6gC5SMPPDbOW5aPXkyGCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RYheCCxyN5CQu/DZTAvjN1235Sfnlv8mfJDWxUAIKs=;
 b=mitgZ/3ab/XsAjkUXBdx1mcEZ9SEi3C6RKWXaqNqmOoDZMkb8NyovTPwWyysSusvX7g08xqwc7g8u0kLvt8CdVc4UVEXBXL4ImX8o5YXlooxBCEZknGZMQ6AqpM5TSlTKK/3TviRI5cElrF/9R+1UMCqzLzS6lrAo7MaksdxS2k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Mon, 17 Aug 2020 07:49:44 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Mon, 17 Aug 2020
 07:49:44 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amd/pm: add Navi1x gfx ulv control interface
Date: Mon, 17 Aug 2020 15:49:14 +0800
Message-Id: <20200817074917.9607-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817074917.9607-1-evan.quan@amd.com>
References: <20200817074917.9607-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0401CA0015.apcprd04.prod.outlook.com
 (2603:1096:202:2::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0401CA0015.apcprd04.prod.outlook.com (2603:1096:202:2::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 07:49:42 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbc1b2cd-73df-40ca-8866-08d842821af0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1452A5E35834492178770E2CE45F0@DM5PR12MB1452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANopbKArNXAN0aMf3VG337IOHy0Fz2yKXzcRgidZiC1DwgevRBqFeAjTt9DQ9FCDJvsys5wVMK7WIeV2UdrrDt4EZN2oVxnPX4+hTt8oXxdMsI//Pl9qCVee+9GrvrjqFtO39hYqUYff3IqbkTlrp2gMe7j1X1OEpt4eu2PvMrCiCtuUlrZAYda8MERgwFxNpwbLQJAGEWUwWqSU6b1SMNK9yRUJpFakEg3PZ/d0FCltOvQYttffeW4l1XqjP0uq9duhTRZHXs0/BHgp/fWFYUwhlZrRRMa6KinguPPCPf/O86s4Crhd/HUgFqxOsjChmamwXkQefskqK5OYVCBBHVuTa5BbWIRwd/Zw9Vw27C3rwudZ2ZiNwi17Wc79GpfO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(4326008)(86362001)(16526019)(6666004)(186003)(2906002)(2616005)(478600001)(956004)(8676002)(6486002)(5660300002)(66946007)(66556008)(7696005)(316002)(66476007)(8936002)(52116002)(1076003)(36756003)(26005)(6916009)(44832011)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zv1kabWcK1lSD8OU4Q7ifApgRP5CEPH280KWew5Uk2BHHFccBf0SFf6/g/8so7I8c/7oHUNzoI5Zyhg2478/dTPAaPBEM3vpnj7J6NG3wD9bvV1/cU6pm0ocxfbvM1y2y5NklwpRGQbYW1b8t4op4SReSzdIqCUMLGqnrAphV/gVMLmxaXqr+pkSMz4daJcr0bjsAgxA5WVrrSmd0A4Rv9ICknITtToInPdHJqVqNGms3y+ixpAz3xaLwrvPcqDvbKltZTnHMpshjSyAIDX9/cn22My9tlQejprVUOVYJfbFYqGxpsuW7gBa5H0zlcB2d/qJ2FA2AEa+4/Ab3GpSWm+gEcwOAKX1QSmEpPKmYbtBmKBc1eMYBZ+FBMROm2HyRQZY4qzT70pQ7bmmGDkJ+HilAmdlRJRuztXWcQ4fcfWaR3VicA47lJwb+BVmFFDusON1jgR1Cu4C5UjHiuCxzQWCluITXf342anAIXBKwhFMzOf/h1lDTWrEL2yf8inhuBnpBbwwBQ4PJu6PKN3qIUfv6m1e7mweJCqYPVOkzlLzL6fbG2pDSlQ9HT/grqwIw/0FSK0zCsDWilh+Vqbe+0+jJDDyUOln7qrm0u5GEBvt+BWq9L4DLku1v/QLmgACly5DSaJLHIJ9MRmVc2EyqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc1b2cd-73df-40ca-8866-08d842821af0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 07:49:44.0946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83Z39/lEEySqR69JskTC+DuriS/UdZnSLehzDsLzaC8ltgZbGTkfmHX+/wPIaxNa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
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

This is needed for UMD pstate switch.

Change-Id: Id14399d3a5e4b24bb8a72a298ec4e96717444741
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 4b4d461899df..c10119f29904 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2578,6 +2578,17 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+static int navi10_gfx_ulv_control(struct smu_context *smu,
+				  bool enablement)
+{
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_GFX_ULV_BIT))
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_ULV_BIT, enablement);
+
+	return ret;
+}
+
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
 	.set_default_dpm_table = navi10_set_default_dpm_table,
@@ -2660,6 +2671,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = navi10_get_gpu_metrics,
 	.enable_mgpu_fan_boost = navi10_enable_mgpu_fan_boost,
+	.gfx_ulv_control = navi10_gfx_ulv_control,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
