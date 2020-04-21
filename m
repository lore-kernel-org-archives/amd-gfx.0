Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29711C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98CF2076C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N3UtVGUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98CF2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B26B6E882;
	Tue, 21 Apr 2020 05:24:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743D16E882
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 05:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxtc3JgODxu1y+XSD92K7Q1prRpuFUOEJpJWs3gzzrhv5T5x6ENH1nlaTWXREkh+taEv9arfllxeM9SMg3comiYAd49bAGCztOY7+Kl68mNZfdJ+hHo50ZALeNDVrfw7cB8PhpYw2bM3LAo0pnML8A+Kc93cvQk6ks4O1CBgQtM21N3Fs93lST2E9kgSY3FmKezqNG78I2+2e3ytHJHTtoEop48fzR+5ZSIBaUzkuQyDYd9EDRkf+0OEmm4cNShVaUgeBUFJs5cvpGH2Th9yvcbYfG5fSEZQ3b9wE+hLRy5V0QpkjLHYYbvuAm/5q2PRxA+nTpExEmCjH6bfeENYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ3zf3wlJUcBIRVrRt7rW19UBZjd4hP0rYioUGOeaxc=;
 b=ktQehQF//vBNsu7mOSHeLo/MCmkNSAT/cNL4OhhZg+1x7mQ37LNQBqbqhbIbJNDCk5yr2JTLOHBz079I2HEed0HmfbmvgUpSEbhoBVVKMM6QM/oF8mxYARZoFOecDUyzi+Kc3J308G+UZXCoQiJaXf7ufl/Bbb9Vnun2oaFoGgbGffUjNFHHoGKX3euJc7UAQgB9u/wIPnTdkr9NmdnA6tHHeRn9FVs0DVGggE40tsrC9v5xf3Tl4luKKRPfrJwGT0IdCHHzJTJbaInzuTwd5DVBDBqOz+caJqKWCaYHp6h6jKhEmMpEHqqRY5ryVjJG01fWdiaFN6kqNGEAJ/FyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ3zf3wlJUcBIRVrRt7rW19UBZjd4hP0rYioUGOeaxc=;
 b=N3UtVGUsi/2EFq3lzYmeznVaGbfHlndnJYaJeDGQDAViYNKTuJNkiVgd8NpJU6KrMV+fvIANyteoeMj2/tTMX9DI1rI23vjjGv7QKUZz2aR3G5wSTOoC9bkqfkKAg2BxQ4A/FBH9uYkWhqSnyoKZ90qWs+MTQLVTjxdmK2LqKrQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Tue, 21 Apr 2020 05:24:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 05:24:29 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/4] Some XGMI related gpu reset fixes and cleanups
Date: Tue, 21 Apr 2020 13:23:38 +0800
Message-Id: <20200421052342.23037-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0006.apcprd03.prod.outlook.com (2603:1096:202::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.6 via Frontend Transport; Tue, 21 Apr 2020 05:24:26 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7413638a-219e-4f85-8c51-08d7e5b4439c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3164:|DM6PR12MB3164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3164305C058EF55EE988EF46E4D50@DM6PR12MB3164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(2906002)(2616005)(956004)(6666004)(44832011)(6916009)(36756003)(8936002)(81156014)(8676002)(86362001)(4744005)(7696005)(16526019)(5660300002)(186003)(26005)(316002)(4326008)(478600001)(66476007)(66556008)(52116002)(1076003)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0c3X/zG1AJ9NQoqfV10ZDRVVnKSNp4i4aOSFtC70Xejiv8KZyruHDJQYfQtbmBRIHLwAxAsxdiVy6blMnUDd+faZ7kaptzHmRq3bRTtpuEqCeMaq4Kc+olOXu552+DFMUcaoctx4GC5x0XwyEjAV//cH84/vReqS3xaFQrB+0H0E4epmW08ozC+67kxPgwGY3C9eQkk0nuyr/C93IyO9Xhj1dFGGGy2rK/NS7enWG3sOED/FerY9DuS2IfCpN5dubqBa3YeIicxIBAF3dTvtVBbgdBRowkUigNcRqoAcABakSeJycY9EChQn3/slJZ1aX45yxFH9zun5prUy9eHWJ65ehQcMihssO3TCfAZiT/WgJH+ZLUU49BfduwtehcehQlI/cpCN2UvbLdDsrWY4S928YukEvkOSz048GL+CjOt75bLd6D2okcsTJ9efu+ED
X-MS-Exchange-AntiSpam-MessageData: dVA+Zn0d8IarHO+biFmgbkTawJYGojXS0WOiQaKykiVmyk30vZlb/gZL6714bA+Ve5i0Eq52Uhhc81Yj48rGLuqAqrY4FRz3sv6xf/luyVgTUCWc38NiMkgU35jXUxno5ojPedUQX0uiZN+JjvgR8Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7413638a-219e-4f85-8c51-08d7e5b4439c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 05:24:29.1449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyqSNwzM18U8AWli0iZs7y+NMT536GN+mMwAU9Jf+bTZwxYkgAm3paqhhS6/tAiA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3164
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
Cc: Alexander.Deucher@amd.com, Andrey.Grodzovsky@amd.com, Jonathan.Kim@amd.com,
 Evan Quan <evan.quan@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patch 1 and 2 are the necessary fixes for XGMI setup. Since these
operations are needed for other devices from the same hive. That's
missing now.
Patch 3 are 4 are basically code cosmetic.

Evan Quan (4):
  drm/amdgpu: correct fbdev suspend on gpu reset
  drm/amdgpu: correct cancel_delayed_work_sync on gpu reset
  drm/amdgpu: optimize the gpu reset for XGMI setup V2
  drm/amdgpu: code cleanup around gpu reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 92 ++++++++--------------
 1 file changed, 31 insertions(+), 61 deletions(-)

-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
