Return-Path: <SRS0=aySl=3V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7D6C35248
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 03:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA9720663
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 03:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KcMa6PvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA9720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED17F6FC7C;
	Sat,  1 Feb 2020 03:37:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4204B6FC78
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2020 03:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtG9g7HB2Pb1hIlisj81pNwembDZd5S2JXuh3yW/T84dp0hR+4u+Jwuv/Itpv+3ojQrQ8U7nGsiMxV56eDIATEVwjzN4TNk6L+Fcn2y0PI0zPDYHZeEyvfRMjj9F1oGmOCgabi0WOJm0Sqx9vx89O9IP/q8qgpXiO+bY/n5ez6Kesi32w0Scbgexy86KF2ZC0/6NXVxGVq4JEA0K8pDFRv5sqep0k2o0wL5Z2j3WsnIH/4MkHcDzG1JpFhY7s6r+tz0YvufBJbbah7aC5GtaMNsUFKGjNGp3jHc9FeGE7Y15jFahWvQDOd1xs3mAxwS4a3Wlt7nKNG9GMoDqqD0fDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbDoCsfFKAWI17gsUHGGb82f4eGM0KGIjvYE6wFhjwo=;
 b=Bc1jd0VA9AdP/b12WhxoWhslt0cjMLK3js/S+o037DLON0Ha1pVzvT/9be0qCRlIwOvmTV98uHV8Blu6YNS5y7yWR1ae4iN/5c9d3QLN6vsb5UiBOnDqhJlHO9zdZ8X2eGO4/FS8pgO6cStFQ0sLOdk7CeBHapwhZFA43ebcVuM6yjugKCugXVTOX52CDQ22VqkpiCc4uaiUHlWb6hrsWZ3ZTOnz07ZH33FNLQKT1qLs+h2wCw2bva0V0zP5E4IWY4Rwow2cn8B5IqaMFvdyYFYfHmo8uexroD+rVE5muoc3wbn/z0JbjkNyfLxoITCaSV75U/nisn+3XOyM8nB2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbDoCsfFKAWI17gsUHGGb82f4eGM0KGIjvYE6wFhjwo=;
 b=KcMa6PvHd9O6eZtkV06nqkGUjcaj02mcQRxGJGkld0bfPJKgXH6mE4+5rnPc/36VVk/xJ9R/G2W/c+O1Jh6BoVwHL4IttAC7diiIZNYH/PXUw1CtY7ix2tJYR/uygjFYF+guztO1x2jII9TOMHsSOamco3xBBUEoM8FSu0O3oGQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from DM5PR12MB2359.namprd12.prod.outlook.com (52.132.141.12) by
 DM5PR12MB1849.namprd12.prod.outlook.com (10.175.85.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Sat, 1 Feb 2020 03:37:29 +0000
Received: from DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f]) by DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f%6]) with mapi id 15.20.2686.031; Sat, 1 Feb 2020
 03:37:29 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v2 4/4] drm/amdgpu/runpm: enable runpm on baco capable VI+
 asics
Date: Fri, 31 Jan 2020 22:37:07 -0500
Message-Id: <20200201033707.16351-5-rajneesh.bhardwaj@amd.com>
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
 15.20.2686.27 via Frontend Transport; Sat, 1 Feb 2020 03:37:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3f0bfef-9e97-4f5b-3a50-08d7a6c8100d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1849:|DM5PR12MB1849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1849AEE8DBE7E7A4DA9F0B4AFE060@DM5PR12MB1849.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 03008837BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(478600001)(81156014)(8676002)(44832011)(4326008)(54906003)(36756003)(81166006)(52116002)(7696005)(6916009)(8936002)(16526019)(6666004)(186003)(26005)(86362001)(2906002)(6486002)(2616005)(956004)(66946007)(66476007)(66556008)(5660300002)(1076003)(316002)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1849;
 H:DM5PR12MB2359.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lgn8rSw62ZN7MlXtGMBwO6TjqMewbMZcENmXoLbKSvT2HnfAT8N2ISU+HpCmsyxSCuXPHVCVYUflU8OrawybE+8WrWq8UreVI+7IxFOTL/FGgufAvQKozHwWSqbWI27O/dbaxnQ5ry51rXfYvDepr2jLmRj/kbR/NifkSDqs6tyunox2zBykojrZpwrUhmSQTTO0O/ZsZOsnYka6vefcRZ24D6GFs8I/1kAnmdfNvjaqsfLqRe5T4y8auxEmMJOd3oHtwXSfxofqOuMDsY8YSeDqhWHkJOMkHm28fqigJhwVQi7+jd2n+KVPv2yUfokeGdHk+VIVwtg7gb5RX40/NVjmnv/gcJ+ZLh1O8Y+gn1fG80REfu2TmZqSNXkqKP7uwuhTc77H2J2kwFZhRbEzB+Xzo64dEuIfSErO4kAg4oLYBqLmw4Pr1twIsVfAj3UvuCQkRVipKcAWAJJ/97VsdWi3sVaQEyjev+7nHTteIxo5kTt3TUTn/eV+jaQ/fqBq63dyHaiG/qts9DiafKTqMQ==
X-MS-Exchange-AntiSpam-MessageData: KJ1D+mOGfoAkRina9C5dI4sGkCY8sbkn4/23p5Spg8E5QMcK5V0n/bkWp5aLDV51/psD+GaziK6MLx5gJXCmJ7zIMASxdCzsHHsOU/gTTvkygd+4FESWp0iJ5eCKu+lsLJRrgRoEsYeUS+AKXmyu1A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f0bfef-9e97-4f5b-3a50-08d7a6c8100d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2020 03:37:29.1045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wXvMzfi3biFIzM/xxR+v8L00B28I654MNUZRL3LMhGrV+Ew7FwtUWxsdTekXUQ+nMt1Hksbh093IZ/vh6r1Jg==
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexdeucher@gmail.com>

Seems to work reliably on VI+.

[rajneesh] Picked https://patchwork.freedesktop.org/patch/335402/ to
enable runtime pm with baco for kfd. Also fixed a checkpatch warning and
dropped below patch from previous series in favor of Alex's patch.
https://www.spinics.net/lists/amd-gfx/msg44552.html

Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3a0ea9096498..f4c039f8815c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -170,10 +170,14 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	}
 
 	if (amdgpu_device_supports_boco(dev) &&
-	    (amdgpu_runtime_pm != 0)) /* enable runpm by default */
+	    (amdgpu_runtime_pm != 0)) /* enable runpm by default for boco */
 		adev->runpm = true;
 	else if (amdgpu_device_supports_baco(dev) &&
-		 (amdgpu_runtime_pm > 0)) /* enable runpm if runpm=1 */
+		 (amdgpu_runtime_pm != 0) &&
+		 (adev->asic_type >= CHIP_TOPAZ)) /* enable runpm on VI+ */
+		adev->runpm = true;
+	else if (amdgpu_device_supports_baco(dev) &&
+		 (amdgpu_runtime_pm > 0))  /* enable runpm if runpm=1 on CI */
 		adev->runpm = true;
 
 	/* Call ACPI methods: require modeset init
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
