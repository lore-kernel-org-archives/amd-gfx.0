Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B88AC352A2
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 00:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32A920838
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 00:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2872orpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32A920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 002116E4D4;
	Fri,  7 Feb 2020 00:09:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BB36E4AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 00:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJ0P2QyAAbEK6Eu4btf/GFqwqUkrCL0NOUAethWOwJXLdKdH+Aq2Q9OCAI18L8+y9vCwCbGghbYgxbvY8z5BcZQtk2BbKDq+8yPCXZpT4hfEy59v4Bnqrb/BK6AAljVZQtpEZzl7cimyEx3HB0X8++Qlo4O34n20szTGrQ6N4/S3e70N1d7EJiO/lCrk/Y5hUfiSpaLxF/jcIwal0wYnNWGH658Uqktbkbm2NQyP5sgcC282veuQ/rTBiWDsyubFZIU8q/tUxdbyXgN4BQev50+j9T31sFqHmn1GDTUasqJD8PIEoZrKjgwA3DeuU9rQEHBmDX5uaD6aUGEhSLOBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYy4/GedHAmsJsTnFsDSAECp9kvO95kqQuplMmUSpbQ=;
 b=SD67iSd9VCuNB1GIrLhGP6S9peakwLBne7WzuIKjxezT7IQ2jvIO6AshQSM5WVT8oIHyE+bAnCCGVVq+ONDsUmrORJVSwO50IFVn0WSU7X9qjm0ow0CAaFLGh9RKlMZHM23V0MtH06UzIy7s7XkLlRYBd0hHU9SY0Hcp+CSb8g0dHV6KZJwej8K8TY7gONzpo2eiJO1McE0A044C37wKnjgJ+AFRZ2mWPr12BqElRvWFF1zxowP5/yIO7li1s6n1xTjh0gp+BiTZQaFFw+xMJseNICXFbrpf/WGUhks7KjG5iN5SyjosfMOKOegMn/rq/pUoK2oJiULMGE6a80LsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYy4/GedHAmsJsTnFsDSAECp9kvO95kqQuplMmUSpbQ=;
 b=2872orpqmJAbuZXdqD1eQbGAQpugP7EgX7l+IYAduxzdPyKnXi7rQxN20iQrAquD1G9hEk/j3CZFqOD03xhfKMuovWx+Rwv1N5V4quzdWqraeg+7CDIyNMTE4ZZf3XxE3+6ZB5kd6ggLgTGZjoFbCf/MLx/JYqHSbxfj5iNymR0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from DM5PR12MB2359.namprd12.prod.outlook.com (52.132.141.12) by
 DM5PR12MB1530.namprd12.prod.outlook.com (10.172.34.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Fri, 7 Feb 2020 00:09:29 +0000
Received: from DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f]) by DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 00:09:29 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v3 4/4] drm/amdgpu/runpm: enable runpm on baco capable VI+
 asics
Date: Thu,  6 Feb 2020 19:09:11 -0500
Message-Id: <20200207000911.19166-5-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207000911.19166-1-rajneesh.bhardwaj@amd.com>
References: <20200207000911.19166-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 00:09:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfab9770-ff45-4a27-6526-08d7ab61ffd9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1530:|DM5PR12MB1530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB153042C2AF88C26FF592C9FEFE1C0@DM5PR12MB1530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(26005)(66946007)(44832011)(66476007)(5660300002)(956004)(66556008)(478600001)(6486002)(7696005)(6666004)(186003)(16526019)(2906002)(52116002)(36756003)(316002)(86362001)(8676002)(2616005)(6916009)(81166006)(1076003)(4326008)(966005)(8936002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1530;
 H:DM5PR12MB2359.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /w5nx37McS1k7Obk6Rf71WHnpjRY7zb3TiYSuSSk2zvy+dnziccS4w7iVSnhED8OXntbsVsb2FLHNCzdtMns6/9zzCilYpojhfqsskCXOr8Ky2r8+V1YjY9uBaZtwbeMjLJuGpoAbO7sIW1IXYUQ5X2zakBRx2Z5It6MfjgQWVaat+ovD8sbLRH5GWnTStM2GkR71OYm9Fp3WAviAFk2zu2CeDR9GuXLrT0OSMNRiz+U4qkd4cU8uu6aADzzM7JiWNC4EjummieC8TteOllXKjcAglgPIoT1c2ykRmX0q+TPM5FGAJFEfZRdp4huGCsSAE0huneQmSqIMPqzxi20JoOo6ABxjS13PqcDEub14DxUeK7RJC2dV5BH+Q+gUCGvuN5KM2uA5I6ONqklSRs9VsY+ruLC7YTRhFYKcN6CfajJ1WGYgWlEempE5DGLT0kKmm9c/FE3Q3HnZFtTVuCcTYw7XpgpEZJyAh4DQMDrxfggtzuHhcnHPjbeZ/imyXTcASIo3cKNat4gXh2CfZ/Pbg==
X-MS-Exchange-AntiSpam-MessageData: rgb8MgZBgiOS3XdTs/ezHQcQXQPEmJL7Da2ehOQD5fyl5rEkFhx0dds7iNL86BcGdBQwBqlkhWXplkRcyu6Cdxu5heCOHEvcd4q1dozR5tEVOToG+V25zSXWYt6O3TPtb/7HMiP1Q2Fb879VFGQ4UQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfab9770-ff45-4a27-6526-08d7ab61ffd9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 00:09:29.0448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wL6WZxJxVE2KF/a7edgtXJwjS/96NXQO/+tWsAH0ajX8cTYqCZYxjJ7xdDtwX748u3KbZteSFQYOetipPVj4uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1530
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Seems to work reliably on VI+ except for a few so enable runpm barring
those where baco for runtime power management is not supported.

[rajneesh] Picked https://patchwork.freedesktop.org/patch/335402/ to
enable runtime pm with baco for kfd. Also fixed a checkpatch warning and
added extra checks for VEGA20 and ARCTURUS.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3a0ea9096498..0f3563926ad1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -170,10 +170,16 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	}
 
 	if (amdgpu_device_supports_boco(dev) &&
-	    (amdgpu_runtime_pm != 0)) /* enable runpm by default */
+	    (amdgpu_runtime_pm != 0)) /* enable runpm by default for boco */
 		adev->runpm = true;
 	else if (amdgpu_device_supports_baco(dev) &&
-		 (amdgpu_runtime_pm > 0)) /* enable runpm if runpm=1 */
+		 (amdgpu_runtime_pm != 0) &&
+		 (adev->asic_type >= CHIP_TOPAZ) &&
+		 (adev->asic_type != CHIP_VEGA20) &&
+		 (adev->asic_type != CHIP_ARCTURUS)) /* enable runpm on VI+ */
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
