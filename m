Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E283FC07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4E861029
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4E861029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787346E42A;
	Tue, 20 Jul 2021 15:44:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF4EF89B18
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWHNtcqMtIgvuTwFIIXcTeAth35FkCTdHCFgNoI1dnYgeSlhGE6zBIlhGqo1K6zo1kR6M6i6ejUkuomFc19zcOuclIL1ZpXDEEw7wZ8C6/0Qn7ggtqqz53mu/F2ISg6k9KqpYEKA37Tj0WQ4wz2Yer1nXKzXRLgV6tv2JgWx/loY2wsJ3pgdslF/f6+JZUHMjsthg05Vjjs8AcIeb1tqax2JRKqX7DtPF0nJ4ihyGTy8oKlMgLHP/WBAJdW/KcEn6gpRZZ4wdKBXHqyqjiTZzWNAZr7/TBQEVgH71vWdU1MabsaqrIe6XnPmpwBIzP4o9JOJdfwA6kYJF0t50hdjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9K1jXDDfg7RFKroFCLdQpBRdNokIOtNpu3rvtgTm0Y=;
 b=areet6sIFplyIp1I9dnn2hRI8DHQG+4moIg3eIamxrbFjb0iSvzxDpeRull5fMjQMGRER8MP9e6/RLatZB/RqEIz3iyvOEkFh887+m0ccFWGl2AL077h5FqqfEbBEkvXT+C6arQKoseawIVHKbVgk0hgOVoMtu5zjalV4uP2bNaJK6cZ0AFlJjk6vG1GTdcJMyjkkY3fVHUYvzTsSA9Vk8fPr7+PjQtWakyC715aNt++IYBn5i1C6z5OPcsyouqf3YrynJ7Q2ma3XmeQf3/ZeMCDMEiOyXMnkX/grO34yuZuh2RailP9pGYGxIpubEralhvO5L1900v6VXm9SZeKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9K1jXDDfg7RFKroFCLdQpBRdNokIOtNpu3rvtgTm0Y=;
 b=Kr+pDTdpdPBOAQUubB7vR3Xd0z8dxrQNzjy/QgonB+Af1nc0u4x56RVbuwy0k0qE1bBGQfuEvFvXJpA7qXDgejVrzsg50bx7qwwsN6RsBWN9uEw336Wn1GJ4RPzYBcMZz7+vcf+GTarfz8JDg3eB/730NSphWsMqmiov+8+CXkg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Tue, 20 Jul
 2021 15:44:06 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:06 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/29] drm/amdgpu: add cyan_skillfish asic type
Date: Tue, 20 Jul 2021 11:43:23 -0400
Message-Id: <20210720154349.1599827-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfb6b5b0-7ba0-4b6c-b7e6-08d94b9534df
X-MS-TrafficTypeDiagnostic: BL1PR12MB5046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5046CE68F890ED6DCF456D46F7E29@BL1PR12MB5046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6/q1oTYUjt5ihWGDhqBJRSggdeILZJexYzcEvPgBZIEBHG/jdJmrLGsoWUAtY/lGSihCFkZWFAKE7k1Uk18g0zra6incCxB3Izhq1I+PVrn9uHpw0u/FtuQhHFXoeydwaHscOdGyYmX9ulVmnJQg9BMEJ0kV1tjJXboHYYWLbPMkXliTvLIUBKAPJbID5UioK+LO7y09ABWrMwhd5F8rs520gAaeEJ3o0C/HlWnSZnY6Az05+IfSm/4zOMPasq/lY9ha9R+V3YUh9vuNZpJ8t0+KUGb6Zv01m3i1Hht+M6mZVGGqu5DXfEZgC/hcZJ1aG2Dkn2s9k9F9NebkoxuF6ad+bJSZb1U85uebxFO+Xiec5AOf+sP6e9ze4qV6wqY7AR3EXgMCfC0cvfrdNUQ85Vlmta2wK13EVqd2SOnNVeAD21igBMar0fQ7jvdEm+SBzEP7J2VUEfDI4dfVd3OK0hhYNjfyy4X2XcIsv0YUV0x4shg8rH0QYPuN+uikjFK/Qp/fghwIZsLKTmF+Tz8iQqenjH3T7S+FflKo/F39hL45ionWsX2AbgGJNr4NWTdVfKxMLdZoGfHaZYkfv/AVSrAR2F0rhaROY2tvGW5kul1uKjRfv55qxsOy+RNK8i1lnUcyVECjntqnZKjUDNNPtHkPU7VNg5VJIYHv+XO6DmbYX8K5L61EhlKCUc2DCos66QYFM6YVtZCm8hGNd6mzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(38350700002)(4326008)(478600001)(1076003)(316002)(956004)(86362001)(5660300002)(2616005)(6666004)(6486002)(38100700002)(54906003)(36756003)(26005)(8936002)(6916009)(66946007)(66556008)(186003)(66476007)(52116002)(83380400001)(8676002)(2906002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y+en01zqAkmOVJoiTj7piruOMjVtBl/zGRvhSDTfr4xPaeAmT2w97L76F9pr?=
 =?us-ascii?Q?gv+GvJRcXYJmtdZvxGtxl3upoWqlK9WZy4n4FUMYzSuWwgVqSHqAInCV2SYu?=
 =?us-ascii?Q?CplCcXBAel8wPSCgTcY7iNERkG3nw0J0ne4jCqal9IJqpGhLTI18oHTXAqQD?=
 =?us-ascii?Q?Fp1u3tltAFjzk04SSgMNsqvu8fyTy96NRSUne5Uf4SVzSSm8J83WHRGK+lmt?=
 =?us-ascii?Q?CwAxJ3oaO9mwqXnOHwZqFjXIgx8O9HTR1JqcrsWukK4gLmoAdowMc7idpTPU?=
 =?us-ascii?Q?BNV/j+fdFyG9lCR/k+MaNhHKFXR2kvTcF3vTjKvON3rwW945Nc1ZxrbOW7yN?=
 =?us-ascii?Q?azIGuyLy0lgoe8HZHn6d65xqMSUAoqzleFtFXMcVsJv4PWSO94vobHQwTkED?=
 =?us-ascii?Q?aNZXaQSfzHJT+SACQWR03Lsc8Z590r29moqhX3mdcroPrPgdm2v88aw8nzav?=
 =?us-ascii?Q?NaFtW4TJ93ff4onYaphbQPx9aix7y+sYYUP2pUGdv4yo6Px8Q3DITiGwjSte?=
 =?us-ascii?Q?ayB7+ayK7WQKPBYOqvfhtxbQ9Db/miHP6c8bLitTGMJHHPmaXPlQbvbA/ll6?=
 =?us-ascii?Q?RomD0Hza6krvgI5uNC8OL3BVVgxw5I+dVimwnLmwGxZGNL1K4fTnuXFbIuos?=
 =?us-ascii?Q?l/Ei32W6Lze8Yl/pWCkRhHKvWBCLF2361iWtIjHw/QTWSQLLYbemHwno+rau?=
 =?us-ascii?Q?eBgN6y+NTOG3qc0cvAB1aZjiMAk2B4Yp3vzI0HhQ8WJIAXYRwhfph7dCybtC?=
 =?us-ascii?Q?POxXFtmZ7nw2iRBYS+xeOSi3ZK45KW60XxGGFm/fgdfh8ExrXynzFpmQSPXW?=
 =?us-ascii?Q?VZymcKcI9x/W4dP0viBoXNiQzQA99T3MsLcPa0nYuHszt5MyXN91wMcJSEdc?=
 =?us-ascii?Q?xLdnQUSHPVdAwtVno+RSq1zLU3hzA1ZXhWFQCekmU61ZF+y6xrSwLbFuoeZo?=
 =?us-ascii?Q?pDmRBfPpM9ugYBntLTsU5x1hvGZpBHD+Anq6UHhEWjaPxhYvjA8yofaxH8tL?=
 =?us-ascii?Q?SxwZMppy7Gh9stsWN6zT1XjGzepEgN2Wt2HIbPbL6rH9ycNgrwvGDHRV6K9q?=
 =?us-ascii?Q?s7iK4hd1d8C2IFuLdIt3Z5Lnc2SVIA5BaDjlYxUHf+cF9XUvinI6x7d7dRcA?=
 =?us-ascii?Q?2hDo9Z17YGDNj9BE/FMMU+OACKNz41SvCo6Ehhw+SSWacI5IpCIBqj2ScjQQ?=
 =?us-ascii?Q?vTJsgXCc1+DsWW51Cl9AFRoyPEnpoYeTVgUiyhDjGcp1VfIwWdcFI+XRYvhq?=
 =?us-ascii?Q?zl6K7TvZbvCMQPoFjEuYBe6mTrCiFeE9Olr6tRlCasTt4eM3kaD3AdG6ilPZ?=
 =?us-ascii?Q?p88wo6AEMysWoRAqQeJabGLN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb6b5b0-7ba0-4b6c-b7e6-08d94b9534df
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:06.1292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFsrWhttU1FI35IB7f/Nm+DnXWSkG6q43GDLTbLpdSBBK7TNz5QomJPpjsFDYVlHENIpAX1AcCZ/AQTtLLXakQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add cyan_skillfish asic family.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
 drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
 include/drm/amd_asic_type.h                | 17 +++++++++--------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eb1f3f42e00b..a58da68c33f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -114,6 +114,7 @@ const char *amdgpu_asic_name[] = {
 	"RENOIR",
 	"ALDEBARAN",
 	"NAVI10",
+	"CYAN_SKILLFISH",
 	"NAVI14",
 	"NAVI12",
 	"SIENNA_CICHLID",
@@ -1384,6 +1385,10 @@ static int amdgpu_device_init_apu_flags(struct amdgpu_device *adev)
 		break;
 	case CHIP_YELLOW_CARP:
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		if (adev->pdev->device == 0x13FE)
+			adev->apu_flags |= AMD_APU_IS_CYAN_SKILLFISH2;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index d326339cb3cd..d93686c45813 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -47,6 +47,7 @@ enum amd_apu_flags {
 	AMD_APU_IS_RENOIR = 0x00000008UL,
 	AMD_APU_IS_GREEN_SARDINE = 0x00000010UL,
 	AMD_APU_IS_VANGOGH = 0x00000020UL,
+	AMD_APU_IS_CYAN_SKILLFISH2 = 0x00000040UL,
 };
 
 /**
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
index 0bf0ad869eb9..0f66a0d9f06d 100644
--- a/include/drm/amd_asic_type.h
+++ b/include/drm/amd_asic_type.h
@@ -53,14 +53,15 @@ enum amd_asic_type {
 	CHIP_RENOIR,	/* 24 */
 	CHIP_ALDEBARAN, /* 25 */
 	CHIP_NAVI10,	/* 26 */
-	CHIP_NAVI14,	/* 27 */
-	CHIP_NAVI12,	/* 28 */
-	CHIP_SIENNA_CICHLID,	/* 29 */
-	CHIP_NAVY_FLOUNDER,	/* 30 */
-	CHIP_VANGOGH,	/* 31 */
-	CHIP_DIMGREY_CAVEFISH,	/* 32 */
-	CHIP_BEIGE_GOBY,	/* 33 */
-	CHIP_YELLOW_CARP,	/* 34 */
+	CHIP_CYAN_SKILLFISH,	/* 27 */
+	CHIP_NAVI14,	/* 28 */
+	CHIP_NAVI12,	/* 29 */
+	CHIP_SIENNA_CICHLID,	/* 30 */
+	CHIP_NAVY_FLOUNDER,	/* 31 */
+	CHIP_VANGOGH,	/* 32 */
+	CHIP_DIMGREY_CAVEFISH,	/* 33 */
+	CHIP_BEIGE_GOBY,	/* 34 */
+	CHIP_YELLOW_CARP,	/* 35 */
 	CHIP_LAST,
 };
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
