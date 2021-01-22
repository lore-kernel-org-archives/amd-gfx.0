Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF326C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735AC23AFC
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735AC23AFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E28E6EA54;
	Fri, 22 Jan 2021 20:07:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925066EA54
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1zBgf3dDKcU3WT8fdtrTSWTzrsUJd0M4wm5GTn2rLpYjhkbY3zVSfcXVzTsz23YZyaqxjNNfBszXnoJ1ogzfBuP4zo3bmZyrpLSZ8Q4182xfbLSZVbOixEClbTgGLCWHa8YzefXoD3ZJ16B2mKoY3QECwCS/+m9y/a9nB7Mh7EPqX6r17Wfvl5OcrHrTiJ2ojlk9JL8DMUXvYJ9w71Jy1X0CvkH/x5zh5Jk3LYFSnm0vA8+he6CbR9fz+EkMXAU1eDTAS2a/TQT4GlAI/aPy598UKfoJFSdkPal1qtNNz0/YFpsmholaH6qlj6Es//ry5OdRSJrkXx1O2/4C7Pcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYo+invXK+D+HuJbIjvjpnvjK2f90J2QXjS5OqsUlKI=;
 b=Cv+7YieTWuYC7IB//80J+pLtGuCVXZ/hNejNbh4nFDc+h5q3+Jba63J9fD6pD+WwR/MclKR9EAWrlalbaXHKXCOYOU7cpFBTXSwE6lnllcicTmBktyS51gmUD+91L6fZx5SJB20JlqwGdzyyHcDLiSSogFXw2eSUljUCuWjlGwUwmusBLXiFpat3/OQSz9mArXEVWjZTHFXOnME7vxav72650xyKcoECuWz7AOewSUQdq+nrHcGy5im6f1dnxmWvk+iADzxPGl9akllvoAyz44tF88Ck+9nAsmrdRvcWaeXUMeyKREYjhbEYbB+hj/MnwLJTXaCiz+zyu434kYvN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYo+invXK+D+HuJbIjvjpnvjK2f90J2QXjS5OqsUlKI=;
 b=vEe6gKdok24oJAs3Iiy8gIBJgZzfeJtydbIjy4tOjekEf0Vas+KinbNZ5ORGdsg93CUAkfGirBH4XQPqMSCmn29YwnAswjvLlDuKHbQYsjdEBRt+r0M64lGXk3y51dEDB+B/Q53R2YNNziAF8yhaivwP4ojVtXkoPZtm6JGVKLo=
Received: from MW4PR04CA0174.namprd04.prod.outlook.com (2603:10b6:303:85::29)
 by MWHPR1201MB0112.namprd12.prod.outlook.com (2603:10b6:301:5a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 20:07:18 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::60) by MW4PR04CA0174.outlook.office365.com
 (2603:10b6:303:85::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:07:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:15 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:14 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:07:13 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/display: fix calculation for the pwl backlight
 curve
Date: Fri, 22 Jan 2021 15:06:51 -0500
Message-ID: <20210122200652.197934-12-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd45cb2-0e61-4e83-d4aa-08d8bf1150a9
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0112:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB011293324E86F074511C9805EBA09@MWHPR1201MB0112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eCIfbwCXLuUccNsy0iWdAP0OyWMJsHwrGUN9qmCEjr8XhMYKLwxgScUogpsik5DmPa7U2zV9scP+N0aXc2L+tVcgY09ZX+InIV/x0yuTRO8TYi2DbXh9zq0LBvyrHNpSYajMXj7JT9P4iLisueTtbhuJ532eYOAapwxbQXk5bROS+MRTvHljf6tyD+a4LQ+B0qhLi3gMpNwtJbwnUjE/lpZBFyi1GTZVIeqBDxouKE3ssDo/vBFKEUxdrnRh36juqIZHGHSDk/VmHywRAmNr3FZA9iu0ih0zcs5RFjlgng8AG3w4AHlomqNwbJQ72S6dlFexacdgmrxMC+nJp8xqHgeDKETnKIJ3SwKbOBy+BTsiCypu0ASifXxNMBO1iUOptlfGlXIIUgWOXETWKCoriez8Xb+N4s95OCOMrNUWEe6EXTWPU0Pj+fdiQzBn0uvk15bB6DQAG2hmyNDIk1NUbKNFT+CLqLb7lbw7LXa2Wpov7I02fcgBsmX5pKOsg6P
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(46966006)(86362001)(8676002)(2616005)(426003)(8936002)(336012)(82310400003)(47076005)(26005)(1076003)(356005)(36756003)(6666004)(83380400001)(81166007)(498600001)(186003)(4326008)(5660300002)(6916009)(54906003)(70206006)(70586007)(7696005)(2906002)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:07:15.9832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd45cb2-0e61-4e83-d4aa-08d8bf1150a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0112
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
