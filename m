Return-Path: <SRS0=aySl=3V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4ACC3F68F
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 03:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B338920663
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 03:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eoLSFcWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B338920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE83D6FC78;
	Sat,  1 Feb 2020 03:37:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DE06FC77
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2020 03:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL5AT79o47ZFjgSbfAv1KoG82tDXIK2Zd5iBcATYJ2WhIKqFyUsrByrEnBl3uxXZ8e/Hea8G/96pZB+BnYJGRKbl9X5TahN037Iw3VprPfxRCcN/syPDtcll92zyTR9lHTIVGkoDLqTIjYu53rtitXy7R1ygjES2na35D2GM/cryDTPwRob0GQIh/gRxt5BazZM/yP6+D2JaUfANBPvDyjsu4/1dsI/aqAp812XJIaJK6lIw3i5NI0h7eg4ItxDXdUWS8khSvaY5b/Y/IZEeABsoqQOZADUZtM51bayS3W/bMe+ZubJkOreZzHmyIKcnEFrygYysaFM2oylKf6aKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yamYMjEyC14jqyfsLCVm3fseKIXJvt70iMyHiEfFnmk=;
 b=DeZ3IeiLTSSJchBvdf8fgU6+zzP4g3X/vhTHq9Emnr2ftO5Ef+3zJ0TiJdN04mv6IwYaSC6jLq6sOaLaMsCpHmAMkG0fNYDaMKmRT7M3jO8TFkbYD8KwnQobJJUhA66097Y+9PyPsbXZtuwBqJLAXbM7R3y2Fa8dojBsX4JXpO923t7nxDg9tWzQutt4ShKJm5C2zzaVMA76buIdLe4vtfHodInQ0NNjMPDxWP44PqhZRv6mIG3wXZcaVuRxMHjSYa2SMXIBkDEyoG1oyTwiokmxCWcQyGZSQUh2HNl3zePdy0K1W8NXsbc7kGv1sUo7RWzcC+Rd07Xy/GIeNULsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yamYMjEyC14jqyfsLCVm3fseKIXJvt70iMyHiEfFnmk=;
 b=eoLSFcWP75AmCH0eGWQH5LJlq1JoyXbCbRAkByCHu7VD9VlVqQaanyTz+ZUqOE43uV41cn2iqNflBAcr9DWI5vaRz7zC6swpIzDjfT7bIRsNm7/jEYv15UCz/w8g2GNu42sWvi80ObZ0XuoTR2m+pesiuIesCCd/D4/dLf5eGE0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from DM5PR12MB2359.namprd12.prod.outlook.com (52.132.141.12) by
 DM5PR12MB1849.namprd12.prod.outlook.com (10.175.85.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Sat, 1 Feb 2020 03:37:28 +0000
Received: from DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f]) by DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f%6]) with mapi id 15.20.2686.031; Sat, 1 Feb 2020
 03:37:27 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v2 1/4] drm/amdgpu: Fix missing error check in suspend
Date: Fri, 31 Jan 2020 22:37:04 -0500
Message-Id: <20200201033707.16351-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200201033707.16351-1-rajneesh.bhardwaj@amd.com>
References: <20200201033707.16351-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Sat, 1 Feb 2020 03:37:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94fbf84f-6009-4168-720b-08d7a6c80ef8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1849:|DM5PR12MB1849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB184918DF4E0E7A767485C0E6FE060@DM5PR12MB1849.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03008837BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(478600001)(81156014)(8676002)(44832011)(4326008)(36756003)(81166006)(15650500001)(52116002)(7696005)(6916009)(8936002)(16526019)(6666004)(186003)(26005)(86362001)(2906002)(6486002)(2616005)(956004)(66946007)(66476007)(66556008)(5660300002)(4744005)(1076003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1849;
 H:DM5PR12MB2359.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4uB978FTs8NVC+gqSm4zVkuaBABgHjYkhA8KhnHhEFinGRRFvU2J2B3l1koAMC5paRaH2fh1Swcf3i7cyF2Y3rb44uGh0YGM6vilinYoz0xBHv4lvmSBfYe4UIndayrupTihwKtxL3vK26jWg7kjXtVk0mhOuURyE+Cvie4l/hRsJEX2MECuEaQ89yCxTfZCDmZzBIsjDBpGci8zkOS16JqjVarcYfyZ50R7OpWzovkQBUNpRJDxItALhD0m24Kbgl331FkAnJS3WOlrz0uf5ELU1p9akgGVYPa2ItwloAiWCya6YlfQLVaJdP20dTAwDc3u48AwM9G16Afg0d09utMbVZcBtTE483M7v7m7KylfYWrMFxBnag0O7jRCxxKCauwYy+81UyNtETR/ZZ4DhvMuG6JkosmbzTy8yAwzCHzbIkhmHOZj0J/DE71o61x
X-MS-Exchange-AntiSpam-MessageData: nJDmO5AXwBQAkvJOI4TgTd87UeDShWWPAu+45AqDzV2ArPxjXhSalCWG42zEf4rTf1gsG8ur4K4uJ/0xUI4yx3LCx3z9oEKbHBBD2FdjpPmf5NjBSTSeLimhIcKqvGFisRScaBqqyywfdg3AMo+88A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fbf84f-6009-4168-720b-08d7a6c80ef8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2020 03:37:27.3846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYF5y+R+HYUa5Ph3n+ZGX8pP/noyo/xVWHieKouVGTAU7gmkmNhg4AhrKv4ovMjNmGVhcNqqvAovzlDDxeVM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1849
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_device_suspend might return an error code since it can be called
from both runtime and system suspend flows. Add the missing return code
in case of a failure.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f28d040de3ce..0026ff56542c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1235,6 +1235,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	drm_kms_helper_poll_disable(drm_dev);
 
 	ret = amdgpu_device_suspend(drm_dev, false);
+	if (ret)
+		return ret;
+
 	if (amdgpu_device_supports_boco(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
