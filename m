Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA252C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8319061059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8319061059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA316EC76;
	Wed, 12 May 2021 17:31:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A166EC78
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBfYxXr6Z5yYacPt2Qe2lX1ttAGlYSfNowUuFn/maY0ggnCdfKQirshoipWgzfb0AOMZa1wQpmRWvZJIRZyNfJtYo9T6HjpOuseZRFjvrg9JKgM7CKzvYQcpFt6mLY8mO2qKT4as6LrHsoFbKGCssv9Ik+ydP5ifNZ00M7hauTktgNbM0Z9cG1nPJSjeBUBjfh0MDPFUfOjk4sTCkHQJoyhkC2W6sKkxVumblv2v66hkpHFoTpqsQtziJbo8rECBLEyN6RV8dtTyurY84ZzaP8c2zHk/ueZ21C+yLNCsI+5aA6YTXQ+93hYAWhF1fKLeG40ZERSAw5/lZOi4fX0Zzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni2hcB7NxHiNsSPZWiAnTv79bx3V9a6QNT3A3QYt6yY=;
 b=VZSpX73QjeHeuR61xFykCp02rDpt+DppfELwUx1tIsCwENpK+v3/Yzoa4gujaLEcqLkny5nH/6XG1OWDyln9s0mzdrp5wNyz3wCn+8Fa7bZHRQx29kBuJNqL3tk9QD70jbfoL4j4/ucfqBskCRj9Ivkr+UBXvFgXu9NAN26lxD0HyncTQCf8ZurvKy1SY/SUKoIanfm4Tn5O1kjNVnRDdMpZrnxKOHyfTa52R+dxUSn2et6GvvoodDsYfEbPVaHF8vIScZWpaLo2ovMtPllpaUtA9MT2jv/6dalbFvJwtoVr3gSf8bbXYO9f90HCkh69PbvE+L6s/RvDNQ9aidgQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni2hcB7NxHiNsSPZWiAnTv79bx3V9a6QNT3A3QYt6yY=;
 b=fnyaSNihYjZqlMmr3IX8FDCLBEhMI6lP9PAmMHAyAKjTaH70/MbsGhan21juD+u7BHmfe4QHUAhP6kFr5zOumiFwkJg0a1wjsDSl5L+04nkDqci6qhytBtAxc48+n0XWfon2dfsCf8YCf9OL+PAvr+tWzqQbEw4h4NFLrZ/8txE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/49] drm/amd/pm: add mode1 support for beige_goby
Date: Wed, 12 May 2021 13:30:31 -0400
Message-Id: <20210512173053.2347842-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6608869-e23b-4f00-3b63-08d9156bc746
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340E9673F6EBA2D43A87CDBF7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfsVsjeDjZ/TyN74j8CPfNo33hdYqTXRrqNOCba5F8SZDQElyqrI+pFXO/9qYHU1yiuamngZPJJSGeZXIdwd1XtlqwpJLjp1SW+JKfEZtvjU835sNNKxilna4owYlv2E23mZnaWVfIoh5cAsheACHjLWZxcmj06jUDGDNrTSIGiHtq+4shYfJwhT1IeHgwGkqkZXeOmFjC/x3bKKs67QXXPvTNJcnxirG4FlIJTd291DXczvOT2kLcxxE1Jw724U6cQsUGXCfLJ3vmCgMkHIzRSRF6pkTQwgaSsHkdsvsJCDgSE/hQA6J1uvy0ifJuyzec6EFBS4qHQL/El/gIMX0icAmueGD6jOFWe6ajCBOkAgsxzvvHAj0priymHWr6W4AyQXjQZte4xUrEqt3aipACVx/MpBy4AxoCjMMgaBUh//u5HsCPeJoqxn+nBoSVVHIqQssszdEkolqtoOFtUwY+xzt2a5U3C6GZVzaQbZpuHT149DutoLEkU2cYiE4SXgPNS8rNyyxr3Wl5XunOsheTTqvpprY4JL53yKZET5XJa6xxwWb8MeozKT6Eq8cxK11ajuwKM2oMVH7orsoUCWhLgbNszO8/vzNDXL/eraPJfek4PWb0CRd7GhKiZS9f2WxJtYly220f+R8+/ZH24snsMhEvPFzneYsXao/W/5ECrzKIlLdBj3pxtBdHVMKL1V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6666004)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(4744005)(956004)(6486002)(8936002)(16526019)(1076003)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IDGjBpehBCacBTNPi551Z9arB/wRXJ7kBoTPXim1r7t0vIPnNWcV/KcZRIeL?=
 =?us-ascii?Q?FPAh065q42kL8xQY9poN31NVuNKg5XC2HIVlNU7Icq64hjfbCmLr8bRuUdEI?=
 =?us-ascii?Q?lt0EfIC0tPyn2AaROTKEAyiMwvnV14y/bLjFAsbSZ2riUUfqYshVj/V/mptV?=
 =?us-ascii?Q?f+KDyYSBexkIvjCGzljwASBeHNL5Cj0K7Q6yQ6FJ/ZeUIS34PsVZIxL6CciK?=
 =?us-ascii?Q?5AtpBdoB2tFWdHLvZoiIidz0LcRikJGqJvZlkZe3qBhHdsivAWiFg5dY3V9a?=
 =?us-ascii?Q?p+t+J8D898JKD7xxUOgi2hm0CSLKF47YEFKFzoxyFP2qTXN+7hvCzq26vx8R?=
 =?us-ascii?Q?e1ymv3ZTONFi79LGH1aVBJMwXwDaQgBpMIjYwd/lruOfm+conM52wbLbbQIs?=
 =?us-ascii?Q?HxKWjeLmS5gR/YPII0C+E8GAgmpJXIFxPdC6G8dTIi1XenZIhfWwspAF0PJB?=
 =?us-ascii?Q?ljygT03RpZvlANt8pBZ0h/d9HtdyIU4Ifj8ptE0AHa063frj+k3tul71vzDb?=
 =?us-ascii?Q?rFekbK12urkS/tEP5liK9bhgq2rI/5Oh8/wQ/aLNnhSI6In4W900apkSK/ok?=
 =?us-ascii?Q?IS5GtmKx9lMPGioe8HZKfO4Xju0X/gLvSgYuK50jhRbJ2HmTef61bd61dS6V?=
 =?us-ascii?Q?lRGNiurlQBymcpKGaawcGGbVdAcJflHvQQ5AE+RNK4VZRSj15/JPXkHpqSdy?=
 =?us-ascii?Q?qI8xqzf1TbWpqcc/V0U6X7hr6wpdmWtbZiTEtyOTnawYfNeP6aiPm1V6ByAp?=
 =?us-ascii?Q?PJF41YVCGsNgQQzDr0q3CIrKw9WoTppD/DP13DiXX7KCajwxVNVIi4wvxZgt?=
 =?us-ascii?Q?g+k0kCl4lRRO36wXRaFa69OCn3gv9Z9YwCjSkEQx07/3lm9ly6KO4gmcJCzG?=
 =?us-ascii?Q?tgTyrPrHRiF39RyryRBq75HyiZbVdL/C5ZhL3jnmU6kQdmYCpO3MtzDC9VyI?=
 =?us-ascii?Q?qZxvMI4mnJscvWrriLJA/WjfrjEwmnd5sdR6ghGBGV/m65NhZhirboC5Aar5?=
 =?us-ascii?Q?+OMTQUVwBiVnW3bqek8oDwOvY7914t0PQzAj9oeR9RehSu8Kh8GRudhfhG70?=
 =?us-ascii?Q?4AYByh5JCWQQLkRB/oDsonjucExcG+qCD2/QXXG7EgTJH/41WIyF9N3UZbA7?=
 =?us-ascii?Q?ks50b6HtpvAWfu1bT0Scr9BXg9rv60JZY+ohMjv8sJgIMORWoHqF/eAC9lkL?=
 =?us-ascii?Q?DzqA2S2d14/zBDClXeuTXyH2lJpuZhBnJWVgBewdkANrCyOjk8d+ulmMEJ2d?=
 =?us-ascii?Q?p7rpidirAUYl7wlOjNbg3TkUJogUZjXOZ1fSmEPHe7sl9mHlzLIadhm01has?=
 =?us-ascii?Q?5SNCOe1MHt5jYGorzzGMNUjR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6608869-e23b-4f00-3b63-08d9156bc746
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:30.0400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiAnCDBvSihYms7k7AZb4ZAlkglnHR1rub9Jtry8IkQqv7FmcfFSBwxbJfkDW/uwr9GWDy4ieYmTVk14dbx9Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Add mode1 reset as the default reset method for beige_goby

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index c56f8e7e20f8..58c58067c3b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -534,6 +534,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		return AMD_RESET_METHOD_MODE1;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
