Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B3AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9F464E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9F464E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7316EC27;
	Fri, 29 Jan 2021 21:28:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997306EC27
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhqxUpLpaG0mTInQrVptfck2Pth27w+EcJeBcGJUvKv9jI4qn6RKYiIrHMvY9zDRlQOxrt7DwbmBQLDV2aJKXBNKdHLaSjFlIsqht4tYDKlQC0qG6WhUWUquqGfnc4DEWa586IsPlciyZ51RpCrV2vOlhAviqx53J9hjEdRZ8Sf+cwwzppK48Yhg1MPRYU7AEjvxzSOy6nYcMAJON8LncsRo7iO7zbQb9VKL7GAT4cm7dXCLu8Ru+JwwhEkPSGQAcMClQ0vG3U3LARgijIlqTsT/0oB36c7JvDQocQ4F/IQpXSsNi4/dvMt20qmJ+wK7gDbgFbb1jKG+M/QuCb7iVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYo+invXK+D+HuJbIjvjpnvjK2f90J2QXjS5OqsUlKI=;
 b=dTKd5ZqJ5yuWd8QLMiY7S7S3o1tgTvQm8MTl98oRjR3e9mKcCB/INbbnkHLknbKEAZxNODGDvOvQg2Cmw0QBV3VjAFyJvGzbFo9krlsiuAU0R20jKwcwJaNfN3f/CxzX0J00nMn1xsidjgvUI9UvJSWmWxIKCxUKwN65ollsC9QrFiEvFMmzqxY5W023DEijWAIUFPlZ+1Izq+XExE8n3k8Xy9RTwsiaTbfEcXR3HB+ZHg7cKMZnjB5zaxqv9xUgwDGgJJqlOUPKVcmbPQVCpaMw0GbVxngROPFcuXel/jKKLziJZ5TY4BXC/nD+VlsCYgpKJtAdQi+m/YbgLBYoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYo+invXK+D+HuJbIjvjpnvjK2f90J2QXjS5OqsUlKI=;
 b=NW8Ch91cw8WWh7c7qZKbgnrZGZjExvStGvOIqO7vZLW9V0YEb0DKp+i6uQEfSRwkd4dRk0MtbXapaa6Op6TeKkUzb2YEFHZ+72MvkSzOZLOg7FfQebGuWCguTdhTIKfc5gHJdUEUrUPcEhzD4XN1oqHTcTGvPvLiZAxi4ILrM/Q=
Received: from CO2PR06CA0074.namprd06.prod.outlook.com (2603:10b6:104:3::32)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 21:28:17 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::3c) by CO2PR06CA0074.outlook.office365.com
 (2603:10b6:104:3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:15 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:14 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:14 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/27] drm/amd/display: fix calculation for the pwl backlight
 curve
Date: Fri, 29 Jan 2021 16:27:36 -0500
Message-ID: <20210129212752.38865-12-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1af33c0-9495-4193-af78-08d8c49cca5e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4153:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4153B913568C3B6ADF12B7DDEBB99@DM6PR12MB4153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LaJmQ9nXeYn8FZ1GI6d0P5wdtsQj2otjprtmVqt13n4dhc03RMxQxxh/vlpsaOSvblwTw3Rrn1ITQZJVC7Pxkp7AoJeSZuOeb/rHY973rxXNuhiKetY2nD+oN0wx08PaLcwIM5jY8eeDRFQRgsNmq0SZxSAbfo9XWY0FXMWBUWIWgHKONIl1FmgIPghlh9dFp1ZzQ6+Ac5yQZlfmZg9Ik7QKqyC5m9LFIZN2L5XQ3w2cISwwa2CuFDd15eRta7/VHdDveecUUxj51r0e79cGvXFYJ9vscdmF5786nSX33n0jnby3FjnfjzkDn/VxpqSa2RfbzYOXCj7+oSoryMscxebpHNdn+pMo8F5WQCxcOr9M1S0CoCdteJI08n/G311GuT3grIFJUnVknWV8d3dURaiuEmlbS5lGJW0Zcists6OA54FJLdEKC/LS3uj2Tg2qssKP1gIpcCcuv6kusvVeQ4l8lXdmVCu4gNpYtFsHYPNcAXKBd0+3N97sdvczGZHWN568hnss3XWzKCCNgV//IEIKvJGD6RNbOp8Zy+bt346WMx8neeCfwBM65djwEuGKcpM8qOREoU75GYg9O69WIcFWhffoEJYUz2t7ds/qA8c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(26005)(54906003)(478600001)(2906002)(8936002)(7696005)(186003)(8676002)(1076003)(6666004)(4326008)(426003)(5660300002)(316002)(82740400003)(70206006)(70586007)(86362001)(36756003)(47076005)(83380400001)(356005)(81166007)(2616005)(6916009)(336012)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:16.0361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1af33c0-9495-4193-af78-08d8c49cca5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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
Cc: Josip Pavic <Josip.Pavic@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
The PWL backlight curve is used by the firmware to convert between
brightness and linear PWM value.
Driver has a backlight LUT, but the firmware holds a PWL curve and
interpolates between points.

The calculations are incorrect leading to slightly off backlight values
being programmed.

[How]
Fix the PWL backlight curve threshold/offset calculations

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 3d4c66933f51..6270ecbd2438 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -266,7 +266,7 @@ static void fill_backlight_transform_table_v_2_2(struct dmcu_iram_parameters par
 	 * format U4.10.
 	 */
 	for (i = 1; i+1 < num_entries; i++) {
-		lut_index = (params.backlight_lut_array_size - 1) * i / (num_entries - 1);
+		lut_index = DIV_ROUNDUP((i * params.backlight_lut_array_size), num_entries);
 		ASSERT(lut_index < params.backlight_lut_array_size);
 
 		table->backlight_thresholds[i] = (big_endian) ?
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
