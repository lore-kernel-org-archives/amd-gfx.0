Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810BFC38A2F
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 20:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5561220656
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 20:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WE7eHDaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5561220656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A47706EB0B;
	Fri, 17 Apr 2020 20:45:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5C36EACB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 20:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIB/THhMyLYSCINc/PCW2Tvy/3xaDQU7HvsIWspvgs2TcEF07Kv6RBal2jj3+XW6E1Be6upyMERSLxxnbOblTUHxhh5naxylqPfDvfPxbfsOUsrTWMe5bCuQWdLiCi8TEiiibmhzQmlB802w0N+GV+3VMR/Za3ktgfvXvrf0f8m89vQvhFb9uCb2auj2/KKH17F1dGhh8YkV2BnSbSKhSj0EbK/+EEhGZLPyeIMNDi/CFZhozXIFZt6dewr42lVN8hEa9B1Hbvc/HhTbQ719GCvb3TUshfU2xz8BCH6cbgpK4V+fd4gGod58IEqrMSE+8CeFKPIhPPlt4qXVa867mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj4g0+zVD6DQ+ATTBooOPMKaOWSF5uCPBq70Yj5zHsY=;
 b=m4lOAAdJiaLdeKrX6XF/bdKmPdU4VVLiXsgVe6gwzfArm65XJlk24IHMxmNNCtqZOCa/I5PuShgEcXUHWdxH7i/jGh5Ice9nW+I2YTCf6FzfXuYB3yedqdvM7YsY9xf/VOfllUKpGcAYg4fLTOrh8BExWHm1aTaKVN3oj6ptMVBh+MXJw84WImnK4kD2eGgtDe3EBxu0/q+ZYwhnKRxJPA8dbt9og6QxKQnkWxIvWQsZEm/b0ojM4/sydu7zHgoVZki1u3ea8jGoi9vGky4LDh861PbM22K2UCa+7GCFmm4quWEwwBhKLsByg5PU4bJH5EeD73Ns/GMLHZAhEDLMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj4g0+zVD6DQ+ATTBooOPMKaOWSF5uCPBq70Yj5zHsY=;
 b=WE7eHDaSvq16UbWlnpL7TAT6g313Q4xf5w6jcWlsIDfkY8Dd6HEOAW5mKVO+N/zYaMuOUHFCcqLqtjzEzxLNww+ZdDrOXh9DXZzaUbCj19TjP07ZWEAwN2bkxnoCYyoi12zxGU/Y1dIvRHTXacH195EQRGpA2jvsFvooQqZ6bt0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 20:45:03 +0000
Received: from DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a]) by DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a%3]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 20:45:03 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Print CU information by default during
 initialization
Date: Fri, 17 Apr 2020 16:44:46 -0400
Message-Id: <20200417204446.13999-3-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417204446.13999-1-Yong.Zhao@amd.com>
References: <20200417204446.13999-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::17) To DM6PR12MB4482.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 20:45:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cef487d5-2c60-4617-007d-08d7e3103428
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:|DM6PR12MB3594:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3594E1348B962922D937E17CF0D90@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4482.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(186003)(4326008)(2616005)(26005)(956004)(36756003)(316002)(52116002)(6666004)(478600001)(7696005)(16526019)(66946007)(6486002)(66476007)(8936002)(66556008)(1076003)(8676002)(4744005)(6916009)(81156014)(86362001)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfwtdlehPEqWIjHYihTryJmQuLI1alrQlP9QgN8UK9oJMx6QPRv2bM2qze94H5kmGVDAMmQwJnucLHV/xtRlAuFsZxhkJjf4ktgDFPp7dznh6V/NpCreX7kjko5gwur7P0zdPh+LFjKfRRTie1yHxqXrbrovSFZt/ixxRH/SkQAdXfp+uv4thlpyaAA6LqIeI7bmIWUGSQrYRCdOZRhlbZS2KJKjlEptXorQENQLsHVw/HZIuYHe4vaFk8KA4fheax1CqGBWtcNmZoC6uW7cd29j0ajLlVetihl0b6/IaFxWwtRzGjBWVsyLm+WQxcjur30Bk1cNvX2y+vDXz+60YcSZ4RGEf8A2rl0F8tlqb5jdurfc74KgQNzbESxwm+8JcRLxeCP/AB0aUQpFBhR1gV/0m+BiPE7s1mXriWEEyA7CbD9lY4snhlw5smmg7vBh
X-MS-Exchange-AntiSpam-MessageData: t/PLHl8QKj8OZiRCKkgL1WaN9/X1GNEGV8dbS6mfO+TAmQEfAB8Xr02/G6eccprdTtOPokKGb8+bJGGggtxWBnWCbjLDWqib27byKlmw7HVPqoBeTQWyCkHdu73m4ggCBUtxBMiIf13E2EXwIAm60A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef487d5-2c60-4617-007d-08d7e3103428
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 20:45:03.2851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M33Kqxg8Km4AAtOWhwUw0j9qVDxp1SbMuWx/phu+INk80YmayqXJI1s5e6TSNHYv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is convenient for multiple teams to obtain the information.

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71ea56e220ae..92b7a1ff1dc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3170,7 +3170,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		goto failed;
 	}
 
-	DRM_DEBUG("SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
+	DRM_INFO("SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
 			adev->gfx.config.max_shader_engines,
 			adev->gfx.config.max_sh_per_se,
 			adev->gfx.config.max_cu_per_sh,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
