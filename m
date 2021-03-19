Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF06C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 09:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07EA364F18
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 09:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EA364F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92066E9AF;
	Fri, 19 Mar 2021 09:12:34 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690045.outbound.protection.outlook.com [40.107.69.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE87B6E9AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 09:12:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaI28W56GnvF2Sb4N+r44tLKMRf8vcVpVQFxgVvcj6qNbTcYm3KCdvPJybMhcliHDTVT/Y/AEFZTN3DZR6yas3iRK6A3AhXFLCSAFKmJZDJrDIER4VQaRuXDoExtRdyq4qOe0I0wE293s5kvX8GtFQfN6HlVTDGE2te0ELxZVen+DDnPazvT61KusthrzayFyfBdgHJgbdYA2Z64M3ZbJHELa1uNMZpb37sZDQdJ+0jH+hLpqdzypOC2GX6T4Vav5Yx6sJgON5FWD+q7ze91cqKR3l/F+29coct4+IVlL4OfKqfY6XbZVV+fpB0KUdt5WENZEc0KPKURKkh9Gn41WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQgXHEKAsSwGs/f1HDxIMaUI146z+UwLU3Hmzqj4brE=;
 b=PVbLmBUnMjGAb1RjHxPeRXS9yzQTEpqdiSsS/YRXxNWr56cZ4/SKmGX+8q1z5T5PyWgN0ZGGY+8MAiqlMcSuxa2ckOizi0LvAVYLD7YW0IrjkUZg55mjfkIYrV3pPnRpNTNYWjheW3pojI+ct2t45hpkYr8uHYnk2WXAhmbwJ0YepbGDQRX4c/iFeZm/Ypa2OtHPMW6cfXQqSpXXVP9TvWN/zImbwXZx+4vN5PfGDf67X3FZzsi1Qmt6AVMWTl2zdewADugyGSULP3NUqgeIOjc5h6/laWlkbqX7ynwyWFcVDvaO4UvF/uEFjFK9AgiHRCd8LUE7pBPMfYui/NCCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQgXHEKAsSwGs/f1HDxIMaUI146z+UwLU3Hmzqj4brE=;
 b=hy5PRdlLVUaURNFPlmj99mCCu3omBtXmInsqVR8fdLPvQDI1mzDVVrNCpSchwNtU1qhbjybOI6ioKRo8wf/jfWNE/01Pn5X+5nmGEbBYxEwi7CjC0omhww141laNQBDpHe6xKSNMiTJ8qXuQWUtGYFhpa5JWGUBC8T9H1n3SGYs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Fri, 19 Mar 2021 09:12:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3933.032; Fri, 19 Mar 2021
 09:12:32 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not runpm
 capable is chosen
Date: Fri, 19 Mar 2021 17:11:55 +0800
Message-Id: <20210319091155.537787-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210319091155.537787-1-evan.quan@amd.com>
References: <20210319091155.537787-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0401CA0007.apcprd04.prod.outlook.com (2603:1096:202:2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Fri, 19 Mar 2021 09:12:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 150345f2-1115-47d0-429d-08d8eab720b5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB498746439643B46C7B8267ABE4689@DM6PR12MB4987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y45D4tTQD5MzBvb9VIq5f1YUICTWqXX0f1l/bTF0ajwU5gJYQNYhaAIaGAdbW2+o7iz0virgVbyMT73r409wCU7gcOrdLZ2xPiP3npjGRKmTg8hV76AzGy8/u2f19yyAVvI16EeAbGi0qW9cMiKT+A/spszBQXffG8M3NRMpHyy3rrIgUqNR2ulX/CaHGArUEm40NoLN5ek9+ZF9aqBpLjqxMiZAT3QPfdA8mq2Xmy59gBESGdrpoQRuHrOxahNvd3JKx5iLEzxzVZrpo/NO94/Bs07s9MxYFrCyHiDGNHvwH0CAetB6tUVqA9UOwqSwvVek1wkmZiUyZzCz1NbWqrkNbs9h8s7f7T/yN2OdOzpkPZnWtSDuN+lPqA4hGaZUdLTdL62WRSrYrMrrP4gg0Y9DtZAnFh+6IDpHR9Ad0pDrq+4MUpnvenqQf0ueuSpdvHC/E9uTdhi2EA/2O8xSmJtGnrnsv9Qu+zKIMYsLq5JCOfSFNT5AJiG0+dgZJb6gpEcqQQMZAkPhmukL6kL5nw6oz6fFXZAUhNrY/jWkHjNbJOirkpa74UpYrvJRop9SXDuHO/jzh6zrYeRJFJgt3b97dpOII6E3V50+0FTtZnJi2WP1ehelhx/0LqbRQ9EU2GavJKlhBcRFIDvvQti4xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(66946007)(8936002)(66556008)(316002)(44832011)(1076003)(4326008)(26005)(38100700001)(186003)(6666004)(66476007)(16526019)(36756003)(2906002)(6916009)(956004)(8676002)(86362001)(83380400001)(7696005)(52116002)(2616005)(5660300002)(478600001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LimSlh6BP32f7wT4plCsMMKMdof+jfXfkea8NFDN8Wk5gIogRey7oZI0taXN?=
 =?us-ascii?Q?lfGTmtnpRuMN+BniarEhLpT7W8Dhhrmvzcf+wkeQJy98nBSMcSJJySEVI0nV?=
 =?us-ascii?Q?hkEdw02Nk6iBU0HQeKMMBHNdqqbgPqqZ08xpULtG3KeuY4hkj9Yrt6x51S9J?=
 =?us-ascii?Q?DF4eEev0CpfXm9mfy1qAFr0gRkgpc/ghRfIrBISgOglxpvhnZZPX0Dr4MrZG?=
 =?us-ascii?Q?7GOy7ymbZG9Zbe2o986XtDCzu/9zIIL5LL8kwuK8O+1590lNAoyi9PECJ5SQ?=
 =?us-ascii?Q?ePVp/RCaM48DTF8+m0LIMf1C6ZXcfqfUi5Y86gHvHnmGBjmCb9Q0vgeDmZEt?=
 =?us-ascii?Q?LsNP3xtZpPs6VHz3idDeEYfuRz31xJxIa3hcm33KkiUBphMm+KTmvg/OXVGW?=
 =?us-ascii?Q?rsa5dK5I/jhRft/U+6WWPdj2EiBVnAjlI8jvdxNQZMlgiQxrz8CpTaJdO5fb?=
 =?us-ascii?Q?I9lKAEgdhc+rK1WtMPZY6JRkf6hW1hgRJtY3jWr24+tQzarqib1N0fhpDZVu?=
 =?us-ascii?Q?CVmFDDqZyWihjFfAH5npDuR9kOYr3cZZcIe8kn0EGACYIXxqvwm1PmDO3k0U?=
 =?us-ascii?Q?EEp8ZVpvUIIDJhYwvMUeI3cpHzQMIKhUOLWKioW+Zz0R3cea9XwoKcX0pcx3?=
 =?us-ascii?Q?OHOZvIP8TxBU8XVFMabegxRLpMtKgllbW5Iym+7aO8AkBdb97ULXxY6PCAA4?=
 =?us-ascii?Q?yyLDnszUZnvdDdVTOluqIYNE1cBLM5UD/lqzxgQVVgJuuRdWpu7gzBFT5lMs?=
 =?us-ascii?Q?LiOZ6iGSGFyY2aR1hWfIqw+hr4wt/P5+nMjjyZtoNjIQyZp6jfIpjCN28KYj?=
 =?us-ascii?Q?1wiuuAE5FbZOVY9URE7KYiQxr9sdV2KPL9NQeDaEPx/isE2Hck8MW9v9Ndyn?=
 =?us-ascii?Q?NhoN/C1KRQe29ptM8yJbZARWHW0PgAFWWyR51m/oHuVHJvT3iaib5BvhZgvb?=
 =?us-ascii?Q?DH5wERPedLRGmINxI4/y4FequKWjz0LYC/zLQn8YZP8v3dfcf2q5g4euhRoi?=
 =?us-ascii?Q?0m6CX1wIjnvHUr5Su5/CCM3XQy0kwepIgANciDKOikmatCO2CfAXg/QdJrXW?=
 =?us-ascii?Q?+b+/qdoTg56WJi44dKcgBZ36NVE44+/PM6fD4smOpIDMJzc2Pr2Vfg4l6lc7?=
 =?us-ascii?Q?0FGIjDykn5N8z8p7JCYwr9989Bi228qFOqQjVSCn3r+qMjQwCkBWIuuU/Mow?=
 =?us-ascii?Q?OEWMLBQRvxQ6vBvnNctOPBSNDRuIuFteAsWbbIeO3Q/Xi0kItYT2Xx0DfSfX?=
 =?us-ascii?Q?6cl5E4nJwK9xROOZswsRKfzf+O4hNOOgErGmQX3rzS4iSjfnPbL6+Hz1/G87?=
 =?us-ascii?Q?y28ydKLMf90u0KXAnAnooMHV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150345f2-1115-47d0-429d-08d8eab720b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 09:12:32.4048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdJGhkNooUNx1yhX3rTdJ/UA04Fb0PIgBVtoCpj7shIhjteJAYz5o2yGETTVpoIu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise, the runpm will be always enabled on a BACO capable target
even the reset method was forced as like mode1.

Change-Id: If6bf55c533e91470c9c83383788466161608f68d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/cik.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/si.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c         | 2 +-
 8 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 963ecfd84347..be12dd2550b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -589,6 +589,7 @@ struct amdgpu_allowed_register_entry {
 };
 
 enum amd_reset_method {
+	AMD_RESET_METHOD_AUTO = -1,
 	AMD_RESET_METHOD_LEGACY = 0,
 	AMD_RESET_METHOD_MODE0,
 	AMD_RESET_METHOD_MODE1,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6a06234dbcad..78e5445b28b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -168,7 +168,7 @@ int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = -1; /* auto */
 uint amdgpu_freesync_vid_mode;
-int amdgpu_reset_method = -1; /* auto */
+int amdgpu_reset_method = AMD_RESET_METHOD_AUTO; /* auto */
 int amdgpu_num_kcq = -1;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8844f650b17f..49068ad698a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -168,6 +168,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		adev->runpm = true;
 		dev_info(adev->dev, "Using BOCO for runtime pm\n");
 	} else if (amdgpu_device_supports_baco(dev) &&
+		   (amdgpu_reset_method == AMD_RESET_METHOD_AUTO ||
+		    amdgpu_reset_method == AMD_RESET_METHOD_BACO) &&
 		   (amdgpu_runtime_pm != 0)) {
 		switch (adev->asic_type) {
 		case CHIP_VEGA20:
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index c0fcc41ee574..e671871f4d28 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1395,7 +1395,7 @@ cik_asic_reset_method(struct amdgpu_device *adev)
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
 		return amdgpu_reset_method;
 
-	if (amdgpu_reset_method != -1)
+	if (amdgpu_reset_method != AMD_RESET_METHOD_AUTO)
 		dev_warn(adev->dev, "Specified reset:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2670ae00c2e5..1e751d415f15 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -529,7 +529,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	    amdgpu_reset_method == AMD_RESET_METHOD_PCI)
 		return amdgpu_reset_method;
 
-	if (amdgpu_reset_method != -1)
+	if (amdgpu_reset_method != AMD_RESET_METHOD_AUTO)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 7cbc2bb03bc6..b9db761a7cc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1420,7 +1420,7 @@ si_asic_reset_method(struct amdgpu_device *adev)
 	if (amdgpu_reset_method == AMD_RESET_METHOD_PCI)
 		return amdgpu_reset_method;
 	else if (amdgpu_reset_method != AMD_RESET_METHOD_LEGACY &&
-		 amdgpu_reset_method != -1)
+		 amdgpu_reset_method != AMD_RESET_METHOD_AUTO)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 			 amdgpu_reset_method);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c354a11e2fd9..ad11f2e1f4db 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -689,7 +689,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
                 return amdgpu_reset_method;
         }
 
-	if (amdgpu_reset_method != -1)
+	if (amdgpu_reset_method != AMD_RESET_METHOD_AUTO)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index ea338de5818a..6b380a25e22e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -895,7 +895,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
 		return amdgpu_reset_method;
 
-	if (amdgpu_reset_method != -1)
+	if (amdgpu_reset_method != AMD_RESET_METHOD_AUTO)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
