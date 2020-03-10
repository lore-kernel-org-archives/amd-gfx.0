Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14438C10F25
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 00:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10D42146E
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 00:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HUKP+Zw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10D42146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 668A66E5C0;
	Tue, 10 Mar 2020 00:36:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B1F6E5C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 00:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Boee6VFoC3OfobyG3938ZJ2r+de3sh7XF7irY2u6PT1lF4m+SMCVzbIXqamrTJJwNSE2wfmPbbqOzh8WPJLQyvmjAQXad6MB7wqjGvM+RXwx+g1gjVAvcz3d+2ILuzv/gEO+MhzDIe3mM5i9DI6z/Lkf2WWce7qAfXUGxSI5ZDZdGoJF4ULfJ7r5ZxoUuPIXjotU8ZeTAxHwjHHN/NR9a4Pf2QnyrtRqM2aqJLFz13KBMu+hWygOi/kDtQW26mhT88TMWzKgA4gtBUpjpUgpkWDrzPho+eqdo6iZ4iFfd++WQX2BvAZbykOo8nLaPTWh7sjkmEs6Ndiedx90mC0TAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3+ltuCGsBrHLfEx1YKHSjPgggDmUwk4Rldj+V3IDlU=;
 b=SwJqnDC9a4yCzisyj0uRewfvdNvQplXTFNrP8uByyCyRrY8GOh6lGwe9ScaDgP6b8U3v1hgT8fp8nKymIMrSB25xW4tCWWH2k06OmnDp9orpYR4ivGRv6Z6PyZekvkgQzKRzMc+RB/9VnZs8vC+AyD0JS3tLjr2gMSSeWksL4wG/isI4VqMzRL6BsLe/nzTrTJWC4YrEf+Vip74XRSTLEF2FG+4pZXa4Hhf95w5V6Fc9Z4OyA/K8p6kDt16mcB1I+fxUfvcAeFFkRYtZ8e5T/DbVYAHtrYwiWE3MMbAbR3RdZ272c/Yjp+nmZneCTA4wm6OIIPfpifp7DzkUSc+toA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3+ltuCGsBrHLfEx1YKHSjPgggDmUwk4Rldj+V3IDlU=;
 b=HUKP+Zw6TChhUFOVOcyjO7/yLuwDJO2Em8kVw33Og3rHRVEXPFu372dkDye10bKOynqh/srWzDlwfnzRBAySQ/sl8A1i8JTXJtlvipCgS2mN3naFepe4T9Nf+LKxjXJj6fNXqo2R/rUtrCUujtfwbIPbhpmoIYzqUPKKMbTsmUY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB3741.namprd12.prod.outlook.com (2603:10b6:208:162::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 00:36:30 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 00:36:30 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org, Evan.Quan@amd.com, Alexander.Deucher@amd.com
Subject: [PATCH] drm/amd/powerplay: fix the coverity warning about negative
 check for an unsigned value
Date: Tue, 10 Mar 2020 08:36:15 +0800
Message-Id: <1583800575-28755-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To MN2PR12MB3536.namprd12.prod.outlook.com
 (2603:10b6:208:104::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR02CA0130.apcprd02.prod.outlook.com (2603:1096:202:16::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2793.16 via Frontend Transport; Tue, 10 Mar 2020 00:36:28 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7853f0a-412e-41c8-e69d-08d7c48b133c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3741:|MN2PR12MB3741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37418B004BB4D0D22F6F7093FBFF0@MN2PR12MB3741.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(8936002)(81156014)(66476007)(81166006)(6666004)(7696005)(8676002)(52116002)(66946007)(66556008)(6486002)(478600001)(5660300002)(956004)(4744005)(26005)(2616005)(316002)(36756003)(2906002)(86362001)(186003)(16526019)(6636002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3741;
 H:MN2PR12MB3536.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzz0TirbMLdmApsDsZ71Q5ghsUDkIDbZwEbpGdCd86kNT/NyBKTrGeo3fb/FM9RK9umKTF4JE6223lon0OZ/yx1+7Zl61AG9BEw4OK2wYxEbP1Pzd0Ll3R2sVQmNEnCWvK3x7h6HF01Tnko6LZ4nr3LMVxLCgjP1+SLxPe8sjiY3aAfvajhk8ASSSoAzohCPSIUhK7uskytSPvYHYGeOFvtux9jyz9gEoTtznutcdpGVXZihzE2EVoHcTxlk82L4yOj4C5wRMkzKjOq1JuN3BdMWJU7B+wojZ5vAMsE+SzjpGcHAJsnGecYeQiACuKtGCtbpXNOIlYko99Am80e7Kum8W01AikxjCKSbZbGFojbruBW5zdM1wLNhbZA/2Z4vyURG+C1XLYsDRbRLHQBF7NoDUUWBV/Diqh09kgLfZS4dukSLPd1N/UHXmFhJU3dK
X-MS-Exchange-AntiSpam-MessageData: TZTAQKrnf9FMc7gPquBfPW4jPQvx3EF6NgsMHxgFLibIJIOGOdaQ9l73dJ+Q+sjCrbxZUymqagdtdqJARl6G4nvGX5figQOZ2oKR89cPiZ/mXmvbU5LHild/lRMD8hLvwDM66i87c4LOHNwJO17ZuA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7853f0a-412e-41c8-e69d-08d7c48b133c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 00:36:30.4117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKLM6Extgbr2o36SQQV8iJRL9RymY3l3Oi8lEWN1o8iRmffpATZwQFJ7iOFc9q9s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3741
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
Cc: Prike Liang <Prike.Liang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There will be a coverity warning because min and max are both unsigned.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index d454493..f18e3fa 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -214,9 +214,6 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 {
 	int ret = 0;
 
-	if (min < 0 && max < 0)
-		return -EINVAL;
-
 	if (!smu_clk_dpm_is_enabled(smu, clk_type))
 		return 0;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
