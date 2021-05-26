Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E7AC2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247BA6128D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247BA6128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01876EB76;
	Wed, 26 May 2021 03:22:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695C16EB72
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 03:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdYxxS3n1ya0tUtU6QSGnotIA+CH2lYAM4wneQUCmRvKm9iwMivniI2vRF46Fh6jwVKyO4iVhpRxgkXUYHzozqlRe2LOyXEGulFWlO1HclhQN/Xm8wyCrUtNlJazuhtoCcdjQ+gHX8tJCL7/7IVEBhh9z5vwi4OeaQl9n1F7ndA8IRw2Zj5t+RCGoSEyu5lSVjWtNbDJ7+yBvU4YlkV1s6ZmlzTYRSGZgbZMD9f/G6984Zwprl9jXkI9wYZTDsq9ayH/AffaGN1Ms2q4XNAeu+/z0JqGj3n4ulvpRtHrXKywb5kL5NXdrTrBPdfVPWRkZnKx8bVNikHHDfh72iOJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+JigfmFxfBaZ5n781/XDL5VxRw+RpqW2pvAbfpHshE=;
 b=BsSI+61p0zUUyqKKHQh8GMpQjyevm7ZDTHh+Y4yeQF8g2zo1FfNDlP5FAGIYrMBFFbr65N4c9bjjOje3DZxAoqBLRS4p7eOyKWjq11hJmwRywLsNUTTM+6aDk4htc4VPNdW7AiHYQuQrCmaOp0ZxSjgeOOrVxBcoUDh5AV7OhT0gLLSw//SSbkTzrqAEKI9lpbPToCpQcbSfHyje9AIxCmGidtqZBMFy+owLo8slpcnb+RwUFupWNetipqYUwjj06H7Mdq9ePXQSsv6JZgn7kSEMVrJvXEtPZE53wECC2FAIQy756nmWT9JK3HGd3cHQoH9694OAe1zF6J95UYbdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+JigfmFxfBaZ5n781/XDL5VxRw+RpqW2pvAbfpHshE=;
 b=vM5Vo500Qv272VBDlYVkovRpS791WaVkX721Os38xFdyYTui1saMN5iU0VjN74wbD474DScJlmenEd9/sdkW9iTv/NI62kYJqksD1ZP6IZxdZsbS29qh2qonaz3aN2268qette0IIOkzIRFfMTAy8LzHYAVbnRMlalPRdxXTdqg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 03:22:53 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5%4]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 03:22:53 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/acpi: fix typo in ATCS handling
Date: Tue, 25 May 2021 23:22:32 -0400
Message-Id: <20210526032233.1260674-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:207:3c::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:207:3c::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 03:22:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca8bb356-1469-4c6a-d680-08d91ff58c74
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB404673E9D0A4ED20C3A9BF9BF7249@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOhCWzZbWo8VZ1rQHU+UK0DkZkEfTGAgrAnQ/s45WKbYSP+V9jylm9wXkD36ALxhmcDKYeGeDt3r1ntIOBBVH+P7ZUpfEsTD0rUeyB1/SJYFpBoB2IP7A0uwYux+5Vh+pBfPxfERdwkhS78bhuNo33OBoyxjr1AdphRqRIkZSZp18lD2knpaeLhxMwgyai/b69eMcICOk1O0zxBpwy69mClxBGhz+vHtn2Ib1yrA2Il8mWIg9BqCDwiKwTUmcYdMqRYsQixNtm97KvQNhiZFgwRro6UeFuA2tdS3c58A5gkfmFaRLBw3uAiNiDUHDwBMWWpFzZivGJlCoDRXm1PuKs+jFuYjej3SUelTIDHhze5wIOBH828UC2Ds0GDDu/8nNdSlhJVKHMM+xjBUN8zgB38tRryd/439cY7Go+iMpgJ1ZtPufhRZl2oQjYUHb3szQwucukMA3hAGsQDeDgT5aL+DvbEUBGdyoFmKfnReRQW4oER95frXiNngjV2yd8NqIpMaTPrSj1U/JDdhChrD6kR0QuJTOTt6Y3uhhR+13lmGO0JnoGsXic4igBT2qZYlsBpCNCGUSZ4Jz4Wew7oxcbOB0KRK4shTHayK12eM9CFf+4xIagfpiT4CZClVQRCu8NcLkvSKfhodX4bmrJHn4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(16526019)(186003)(38100700002)(38350700002)(956004)(2616005)(7696005)(52116002)(26005)(6666004)(6486002)(36756003)(6916009)(86362001)(8936002)(4326008)(8676002)(2906002)(1076003)(4744005)(66556008)(66476007)(66946007)(5660300002)(83380400001)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Gfx9pP+nOtntBz9dAWb0uoyRZyZuUOpmXVVXjvgkdgzooLTmxaSIdkfnO3OC?=
 =?us-ascii?Q?W4uj4KtmP5fsZI3APuR939YUiQxTiAkLE0GBgBbOfUTS+lFN3dzRXDk8VpUc?=
 =?us-ascii?Q?Sn3Tz8dp/rbrLHziHXgskfiajw6Jb0homlmlFj7/L9p6l+K0UNiAxntwSPt1?=
 =?us-ascii?Q?cAJJZqRhH9qJezIHTqprYhwA4UjxUOeMIThsitR6sRSdxN+Ae1jurP6VPKzW?=
 =?us-ascii?Q?xf+mtG13PAVFexv/ZtDGPdcm4ArCSXHCgesK1arKW9xmJbX2o9pMLIV78ZdO?=
 =?us-ascii?Q?PRSDFNljVCzf+A3Ttgef1PdefHeh8jzyIIlahdBBnwB+y839gNED4wgOQfTi?=
 =?us-ascii?Q?NilA1VEJyPCmUWQ7uZ958hbm/gdVXQvig7GGre2VtGcsLLALRe6MfhC3UBzd?=
 =?us-ascii?Q?HJaJSW3JzMUhsEQsNgU9dGbQB+8s5Vj/JGm8ZbqHep0/7QPXtL3/UQ3U5fnh?=
 =?us-ascii?Q?to2uX1NuRmfynpmEyNXN/4VxEii1y8Y/RTHDMA7SgncMZLQYPGs68A0y8cHJ?=
 =?us-ascii?Q?NSchlKD1qO175X+mNpBXMJvv5ah+txby5N5HP1ydJJofgSTUyKvAvgQMwUqH?=
 =?us-ascii?Q?dRrNgQY5sae/2Aoe5SwETpv1DjbYlxluRAQbUVmT/eiwLBT3LPVFppWUABzk?=
 =?us-ascii?Q?bYdNCWxz/IhcrZPl4u27gBAc9s6AU+T02boJuDLI54ELGz3VUr4SKTOad+A4?=
 =?us-ascii?Q?UhYyEbcYMvA1xGKEh53TGCnUp63NFC8xxwYzSSl7Cio48weZ9DmcMPZ6aBtN?=
 =?us-ascii?Q?ALMjfYxXJcjo1Jq7egF9CStAXY7m7dFrTDh9ZkCcRHJ6GpSS848Z8fIm2RqL?=
 =?us-ascii?Q?wY+k5fDVjly9tdqApGSeX/zuieZsEAbACHBnRCZebYVJoy1HUUSMm0bNhcb9?=
 =?us-ascii?Q?NHhfx8WzOJGKzLV8XkvdKoB2IM851T+Fy0WhXnjDPMSKgE9wCsXAUB35gBm4?=
 =?us-ascii?Q?ebC39vzjlQQO9AyJAvYZ8thGmXf1QxTdM77EUhb8e9qYoU4ZlKkbOASon1Jt?=
 =?us-ascii?Q?wyzpRYF0iXpjKo+Sd8bdyv3IQ75wWXuYZj3jz72q/wPVvYeATipRosuU7o5w?=
 =?us-ascii?Q?pilCI/TCmOLeY60UnsuqaYnkTbdwAehBHEdlqWh8gEdL/dDLr783c8TRPIFv?=
 =?us-ascii?Q?g3jFEOQp4J8iXNUpjxmKndlGfThsK4T1EprmK88CrnSigMTGjvddpg+BwxCq?=
 =?us-ascii?Q?gMUOlPIiNwtPSwQxpkt+vKSKxzTJt+twEcou+tLhJyTiuc7DpY1eSPKFrQeV?=
 =?us-ascii?Q?KzvPu4jUw8/AtTas4eCybp4uzhd9UcMHDOJzztlAiokLZsZKAMyPwpQ+2kxu?=
 =?us-ascii?Q?t5Omfk+7U1viUBMUtaymkyYh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8bb356-1469-4c6a-d680-08d91ff58c74
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 03:22:53.6558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jgNAzj72aFlN+SQTVJp/pqtTcZkIL3JLOmLLAlYk+5GWXDqPyTwkEruihTRrPThOBC/nVYCczk35/m0wh+L5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Path should be NULL when we already have the handle
to the object.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index dcde3f658a7a..2195e24acb69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -557,7 +557,7 @@ static union acpi_object *amdgpu_atcs_call(struct amdgpu_atcs *atcs,
 		atcs_arg_elements[1].integer.value = 0;
 	}
 
-	status = acpi_evaluate_object(atcs->handle, "ATCS", &atcs_arg, &buffer);
+	status = acpi_evaluate_object(atcs->handle, NULL, &atcs_arg, &buffer);
 
 	/* Fail only if calling the method fails and ATIF is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
