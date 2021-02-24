Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BDC433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A71264E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A71264E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5E96EB4B;
	Wed, 24 Feb 2021 22:20:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE8B56EB43
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ66L/ApZ/UmLnOzaxGp4uwMGCozJ6vZQPE8RnWPPdxX6HePgu8hskaW/yVNUpLZ0FSo2fmSgh2zS7VgMwy2tM08LOGNaVYh262MIdKxqVI/ucP18lxl55MYFBt2tk6HS8Mgtmro7sWhMZpFdbw+Odkedu1zSU/5T0QAlAlL9eQJzOuVbKdiGvzzN9LCmg1y8HIbc3jOyRcj5ccA3TNXA9hTe7XwUBql4p7AfgvYi2t5b6rkxPugOqsvuFwI+2ZoQ0T9Ko8uvRmFoW6fLD6zP7EOjDQgMB0KPuXwocoDUEHc9q9H+MSgzZQwm5987VXX1Le8uHr1X+mH5Kdb9UPBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtbHwld71CSI/OU7IQUUBgxTBOjj6wHJmOvfNEHZX2U=;
 b=JnNaZE1jG5A/Cgtq0X2E62Q2slm1uTOKgyrlCzp5wXHrPtPZo7fuMRo8ukWvk2GlgjoErlfwC0Ff/P3usak3rfxuSofg2xfgTEwCidqT2tet1GKgZk17x3tFEQBy0vcPoXPmnYLUvhKrQOFSiuzvAr4qteeGTcl758/RxgAcLAVTqk9J5q7v6VA4srJP+wVdY5HbOLJhQ+5T7O7ReF0/YSTSKcAUWm7mZt2ANVGDELn4VNhzS341QYQiPZVnuLmozkjyrfOkZLLEvkjQdOa+aoERgGpACvEdEHiEbJJTaeAsZt6x8m193FReaqj5TcryR9b/ZG/lkafRnlOWkQ+VdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtbHwld71CSI/OU7IQUUBgxTBOjj6wHJmOvfNEHZX2U=;
 b=y3SWG//iDSFF8z8dIh1OEPv9l3dXC4lZNPlHaZCKsz2MTu/TMTHM8mgngIWayTEvfyIGATSEt+cwiKoha9cIyHSd/ZFP1XgHnOxIyh2W4tU8TTgS7dClS6BXSj3sG35az3j7XLJmbdGmSash4Av6HJGYlz4JId0qIPoZWjtxHeA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 057/159] drm/amdgpu: initialize ta firmware for aldebaran
Date: Wed, 24 Feb 2021 17:17:17 -0500
Message-Id: <20210224221859.3068810-50-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c7e97f7-92cc-49bb-7d29-08d8d91252c4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175AD31975C921D42DC8B09F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNnpdPHzxDpvCIkx0uhRngFAX1TLUQetECglMVeAReaa/BXdGU0SjZbrQ2OBWfJ4K0QQZ7T9wvy5pOisNotkfsnqm9laEjQ4IsoK9NHeMJrneIaEP7sDYZNLoaRxNx/xpSf56ma/n0rM1jRPIOM1KOMsi/vKE0L2IvmzDQkhWiHab+lfb4blAwDoi6t6itTAioiD/AECWVFhukyltzGz6/7aMwM2aiodq9e3rO1F0Vx9RCHpyzVyPnZ9QmGHPOGKOGs3fTLZdE11dfRpZ4/gdBrmVqorWZ/g32u7XSuzXuSdbYPD4ldxHOKjNHdzduwXTDGjP1s4Qkq2IK576hmmuGW8v9QR9B7L5/j4DP4yV5ZOLGCh/x+UIaHbnkT38Aoa/NUzClBvODX7oO6V94vz6xoSIhCtbVcKWlPRsZo89208EuxbnTZ/ijezf3Zerc37p6LonysF1DU85rWGy85MrOu7HhU/kBUq2dRCYLA2yN3f2990o5UU5/6uL0VbIB6muOKAORgLzxdwKCGWu4rBS/rrbvAtX+r45NtL1ZVkhCFHPVoFxp9CqCIToMiedNLXvKT/2DwmzNcKlFtgiJzgLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(4744005)(6666004)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aIbTNKGor83+FIVTN7ho7XtuJbF4ScELSBhu7EHESf/5sEbYyBC2oYSAA5lc?=
 =?us-ascii?Q?KNCr9LwWdR/ln9pXdo3toqYS2DTIGgnQ3INBEmaxgC7VnAKe7/8uiiTODJgZ?=
 =?us-ascii?Q?Xx1XicMvJGB3c37bpDODpezSbyzslQwexWfaGe0Fp/Ali7pT17co0azBTK1A?=
 =?us-ascii?Q?rh01mtNtrT4qeTX4ZUbFK8QenFartE1nimi8O3vBOevVy9Crj57btc27HqBH?=
 =?us-ascii?Q?QlYil7VnK/CedbXU8v2W0/tuuiKGtI+VS+cErfgIgE4XJEf7b9uWV7yWjrWN?=
 =?us-ascii?Q?VHkoZc+n3gruEM4OLYQeI5RRXZmLjyAnXHuM9qFr/Iz31djXAohAHi/jjfy9?=
 =?us-ascii?Q?7W8/QrI0coZb3O4owfBJC57ROlNTAbJWomyBZgEQbTelHbUxrWNtXzAHrpbP?=
 =?us-ascii?Q?JYFpfS5Ds7VzQ3xB3xlNdF5K3i+5iUUkzdgYC9XhZ/j/5y6AkloMkpOhau40?=
 =?us-ascii?Q?A9dnS9o4LotrFNaEpPneJpTuAUxbii+/Ae9oMWx1Aqi80Us2/tSquygj7Y0B?=
 =?us-ascii?Q?TOxZfnjGFMMKQxBtBilKSMICKoBv08vG4BppmYeplmmhxAxWa/g5L0337YAw?=
 =?us-ascii?Q?tqca6Entnah7MRKUGf7LP8hgOAtrkGLVnCWiDPg2GpOBcqQkTVo7iZbpiK1r?=
 =?us-ascii?Q?qtqEP0tAZvuls2x6x7d7lBUjh+q09D3Rw0XLKZo1e3O7JbiyncbMQpFftJUO?=
 =?us-ascii?Q?tsI4eH+5gNMWpA59a6SYCS9CiJRm7JNCYS+oMqPkctOWn1Vo+XBbmS6h9QlA?=
 =?us-ascii?Q?Dbwvf/XVevG7I4ME5IEghvm0dj87fxFpgxugr3ml0GJjNSrC1KthVoP5p47H?=
 =?us-ascii?Q?WGk2cDgztxKf625yPppletWtx0iugvOH5rMYuuIdkj+f3H9oWOe9wHCatXBp?=
 =?us-ascii?Q?zuPpoCOJu1KXrfO+AP2vvDIO3yroM1SHgzSwnFL6TfY0w4RfNW3ABRcSbHN7?=
 =?us-ascii?Q?/9T6KtxModZSMGyELnpIspLGdCO9ehR/7bTpM91rFjMipvYvB/qcW+D26rsA?=
 =?us-ascii?Q?emLlJ4VOtIi/1k4lwPu0jy9evNGKP+MUUQOADEh6wAmQFVk9ULIi6J9gKxEo?=
 =?us-ascii?Q?YMBFF98RZg9R+1jE6YBa1owBH/jPHyGD9sEP+jfcPk9ejPm7OCTA5UQXDORu?=
 =?us-ascii?Q?5fX6O0n0mmpscnJ9nTfgXPHwwuzOZtFRF+vIj7/Qw6jkhSIrgDTLwnVYn6Cv?=
 =?us-ascii?Q?r9Cn8Gghe68roGge9jV9rmSnp33jeKbm8foQQK4V/VQfUWb18XCQkCsoxgit?=
 =?us-ascii?Q?LJ67SqUUL2XSdjbZgTwN6qpJtfimRVr2I/bnR8dwJQU05kOGAbUwv/RdG6X+?=
 =?us-ascii?Q?YUY6VGjRDogfsqkgc+TI4RNT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7e97f7-92cc-49bb-7d29-08d8d91252c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:59.6004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TY/DY6sgFPqxCYivVs9afSGM8kRGqu8Dobr8ZZCb5zXT/+ui4OYpRkamBzSzp9bEKtmsuH1pAP3LguR1PP4n0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

only xgmi ta is supported at this stage

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 4beee092acf1..fcdce46445d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -30,6 +30,7 @@
 #include "mp/mp_13_0_2_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
 
 static int psp_v13_0_init_microcode(struct psp_context *psp)
 {
@@ -46,6 +47,10 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	}
 
 	err = psp_init_sos_microcode(psp, chip_name);
+	if (err)
+		return err;
+
+	err = psp_init_ta_microcode(&adev->psp, chip_name);
 
 	return err;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
