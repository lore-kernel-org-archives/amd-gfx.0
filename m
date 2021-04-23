Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25697C43461
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C549361175
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C549361175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068336EB7A;
	Fri, 23 Apr 2021 11:18:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B2106EB78
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 11:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI12tPZmRcDk+jSg1DyQnRDtIb91s/yjV255qq0jTRGloWDBnKwrca2x9z/97MV2MS2l0ACYA7k5pl3vA81dbcIp2wAbMT6HQGtD78DdZZFsGU+IleTOcD1lnNUQ375UHxkVsUZk1TViN/8dQZPahnZy25J5Bf62bf5aZni+mq2Dlxsd8k7TcS9Ro25OfTyavY02Y07XPgCKvtRtUPn7AR9/NRFB1CiAF89LT9jRlmaTa7qtfcYlSDNLhxarrmkWSfklyN1jju0xUtgGjjm7h8aJUh62K54zFhQJrv8jeS1vUVIPdDubGIAmz7qjlqSCYJiy2Y7ioDMZNVD0wDxHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWehqFeLHa7gp2qgQ7uLSmgjxLi6SvMDDMdnBANmqD0=;
 b=liX85PPpFXSUfMICH0j2cufh6hj5ZeV+Gks+wjCKHSH6Qpmu98QyqACvVba12WNbwBB+Yxmwcurfww3BXc3V791/qJulnNsu59+FKyizqki1i0WjjY8wBkcGKMDTrom38spXGkMBI/uJT0yNqDm9hSyjrU8PgMY2AuyrCv7MP2qJuOw6Iv7zvn5EIyRdoXwW7ql+kDq4EGyYwu3VBlGq2DYFNnOl/VJhNHEWKGmkkl7l+lt50lUbdv+tzouziQ5lBTgxs/Ln8us21C8LE8ZqJftzyyzL5KQ81Tetq2Ol8w/zK+a2dVJrSgQHYzkS4xwAK91q8eIO8NPTgOvG1B5vHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWehqFeLHa7gp2qgQ7uLSmgjxLi6SvMDDMdnBANmqD0=;
 b=UePrGuDEoKo3+91MCql1UREgT2QV3ZIYW31AcSprgpoRqGXzADgq8jEWnWboc2uKFw/vOZcVurtggx031uoTWmvGWJjhrWS4zQ6PgNNbrzppuAG5+bYAo8rZyAa+LGExH3UTwmYrIx2Y04f1/BstnbMnZKdZs8x7ybpM/VaQj9I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1462.namprd12.prod.outlook.com (2603:10b6:910:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 11:18:07 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Fri, 23 Apr 2021
 11:18:07 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 6/6] drm/amdgpu: remove AMDGPU_GEM_CREATE_SHADOW flag
Date: Fri, 23 Apr 2021 13:17:30 +0200
Message-Id: <20210423111730.2345-6-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423111730.2345-1-nirmoy.das@amd.com>
References: <20210423111730.2345-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.34.71]
X-ClientProxiedBy: PR3P189CA0049.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::24) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (93.229.34.71) by
 PR3P189CA0049.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Fri, 23 Apr 2021 11:18:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86465ba4-c672-40af-b120-08d906497849
X-MS-TrafficTypeDiagnostic: CY4PR12MB1462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1462789B530F2052A19ADE118B459@CY4PR12MB1462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VO9hM37apnJVopL/bEzYEiT1LkVtU1Iwmc9+HG6HUxufnSKoHuDLpZJuOTq8JpL431Cxht2Wonn34dKH4tVyKbjr/jnGY5Rj69gAZvEPGgdau93BxLM2W/hUguTXKMPnOz9hzcASCxdaH8bCC2kwc8n6U8ThKDbhiTeuJX46/uYxRsGogIbivMOiphNF5S9rR80MmaZsUf5XTVT8xlVmYBUYjljK7XIutW9Wa4wAWqohHDjMiN4XXTSUVHVufkmkYeteURKbR6gBf0SgHC9cli8X+BAf23mc/aRHtv/wHbzQb/SaFS44tCGNCsZJOfILXGy/hUpLVs9kdkAywdbBireBx0E+NXS1bo02n+McoModPUlxlkd2Q71yuMYBwrDiIUU3b7nxokDLeWRyzTYJP4QSo5Zxy5CEBODRQ9i9wySjU0We+lRFwt218warTWlRCiJfOhhYTUC4wVf/oA1eoA7+4xgr6WDexK5zqnaC2U6dgWSVb9Xb5D2a4YvY9gkV6x+kIGHk9X46//j25Qh5hEusrGlM6cx71nkuGsk0O6aTZanB2A9+tIlntQvHwMXv9lMxq5WneymyLE7nZdYi88yOjulaVh0veQZjSYNUzR/M/1frWcxhNcPYzDXMXROlNZwChNkxbTX/i2ud/GdCCFJ/9Ujf4lcJqhHNxuj3kw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(478600001)(52116002)(38100700002)(16526019)(316002)(37006003)(38350700002)(186003)(6512007)(26005)(6486002)(86362001)(8936002)(6506007)(6666004)(1076003)(8676002)(4326008)(2906002)(6636002)(5660300002)(956004)(66946007)(2616005)(36756003)(83380400001)(44832011)(34206002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I0Cq4SUnT7gHkxbkXN8N/Ctnm5QJ1L2BGxXX5M1ouD8rimE8GllDgpY9P5uq?=
 =?us-ascii?Q?OuGsWSj6uovIJ0aYW5daw5XwcT9rzIizTyawr9LBnJdEvhRQcLBdp9m3Tv+V?=
 =?us-ascii?Q?ToJ440zZiqr9hI0DZJu6SR+gqV2wHMmt+FqiGP9wMgos8JPkLg7tu6gdQKfR?=
 =?us-ascii?Q?I5ld+lrC7X05IEUiTaU+ax6eT6oRrXbLet5vHPxELhBWBIqYIMjaWDLdRdO9?=
 =?us-ascii?Q?UR58hsME8gz47pcc7Yxl5xnhrUHEMUfXRUIXUF0DeG8h6o4E1jMqsc/CfYWX?=
 =?us-ascii?Q?1WDc3iDxJCQQzWuw6+1TOgEd4RYcXjqnhYe84RK4PSfYYZVMgh2gbDPjoxZL?=
 =?us-ascii?Q?3oV+XfmzRb8cYmrL5vhEjoJs3kE5Ed1tYze3Pe3o+xybBXh+DFARskB9LqKF?=
 =?us-ascii?Q?2MqhGnuIVicvD7RXTdp3YFeAxJg+7R/g8+tiNnn1354ZPNeqROp1LGyXH5g2?=
 =?us-ascii?Q?RgtFqovbeTAbhMcXgwQh/QWFzRGTb4N4Maw51Q424+JR9MGdSRV6qtpSKbkj?=
 =?us-ascii?Q?pdWbugTtThrRvnMAhdRVPJvWxOaC5yf70W81mamy3XJeVtMOSt0NR9wmHT/K?=
 =?us-ascii?Q?0oJN6GM2LlWXm3Z3+jd+TrcueE1ZGzo2X+u9wOocm+AeR05ZAUkYyg81RkrU?=
 =?us-ascii?Q?RxvGrN7vmSQcl5eFY+6U2lDjM6z51Z5qVHY1EFhRqTVaIC+ScYaR0BmBJcSi?=
 =?us-ascii?Q?oH4FcnhDLpqp5gJNZID4Vi2gp9Iu0m8lWpWn/uQAawvKNnme6SzaZEg/uw4H?=
 =?us-ascii?Q?NptLzBt2mlEOOKq8MDU7KcxcUbqhzOtIkohn6QAVno0+zObI8wdcqqlkQ6DW?=
 =?us-ascii?Q?UuMIE5zlanLBixOxyqVlsRxgEqLXpVd+Zg60CE0ZHM5TitRLEI6IZdDvfEoV?=
 =?us-ascii?Q?2atOK0YsboVDwXPN8HlSyCsq8EMmdZ4ad1hAkagPF+Lp5+piGeMKTNKXJOrR?=
 =?us-ascii?Q?a11vmbmjJ/8+n9kfZwz1sL7CEE8C46898R/HC2+L22ZiJaACFZ7vpl/BzClS?=
 =?us-ascii?Q?K/Bdj2jZqzE/D/Z0l8MWqeKKLjrcQSjNX+kXzNLAdz/jNo+80DW/fEyi0dTD?=
 =?us-ascii?Q?ccRFrwuQTbzMqSnav7MCuRNelO7zn11wQn9bf6pMn7oamGZGZEd8trDa5eOV?=
 =?us-ascii?Q?O9GWYZmoCpLnqcop6KRxGhIOqdgKx2LxThBNjrlrglVXF/MdAHb7YBRUKb6j?=
 =?us-ascii?Q?PG7I2CAxUx4UVKdnU4FKS+Fsbd3CBzHDDNe6UR5aGbE6y5KByfcoKaS3Uyse?=
 =?us-ascii?Q?70q62eiMC0oHvp6TxIrqbL8AyQta+5fh9Z1o9y9MvvSJn0I1fVLCs+7EpMjH?=
 =?us-ascii?Q?cTyW2JysqVPlgNQRKmBMPg+u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86465ba4-c672-40af-b120-08d906497849
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 11:18:07.1459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k22tpDdPYD/pS0AnLwmhYk5bOAPOrAph5JlaWmt1mXVy5r5J3e/JC8+kwj/p3HNVMtsw0LknWlHbTfXuxnssrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1462
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused AMDGPU_GEM_CREATE_SHADOW flag.
Userspace is never allowed to use this.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +----
 include/uapi/drm/amdgpu_drm.h              | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 39f88e4a8eb5..da6d4ee0a132 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -649,8 +649,7 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
 	memset(&bp, 0, sizeof(bp));
 	bp.size = size;
 	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
-		AMDGPU_GEM_CREATE_SHADOW;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = bo->tbo.base.resv;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
@@ -685,7 +684,6 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo_ptr;
 	int r;
 
-	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
 	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
 	r = amdgpu_bo_create(adev, bp, &bo_ptr);
 	if (r)
@@ -1559,7 +1557,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);
 	amdgpu_bo_print_flag(m, bo, CPU_GTT_USWC);
 	amdgpu_bo_print_flag(m, bo, VRAM_CLEARED);
-	amdgpu_bo_print_flag(m, bo, SHADOW);
 	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
 	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
 	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8b832f7458f2..9169df7fadee 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -119,8 +119,6 @@ extern "C" {
 #define AMDGPU_GEM_CREATE_CPU_GTT_USWC		(1 << 2)
 /* Flag that the memory should be in VRAM and cleared */
 #define AMDGPU_GEM_CREATE_VRAM_CLEARED		(1 << 3)
-/* Flag that create shadow bo(GTT) while allocating vram bo */
-#define AMDGPU_GEM_CREATE_SHADOW		(1 << 4)
 /* Flag that allocating the BO should use linear VRAM */
 #define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS	(1 << 5)
 /* Flag that BO is always valid in this VM */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
