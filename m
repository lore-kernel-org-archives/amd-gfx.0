Return-Path: <SRS0=iabP=AP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D65C433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3631B2075D
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XJFh/6JU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3631B2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4726B6E3D2;
	Sat,  4 Jul 2020 01:15:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862F26E3D6
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jul 2020 01:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kppUmGKlaSK80eHg1/jK+wo2eJ2TOeCnlqBFX8H0yKDtOSbz/aSCf9cZF5BPXnReDmOehxYaR2TB8bEB1V1ag0zGnbAEBEcJ8wpyP34O3mrzw4HCTXFsL/atasiiN0LgFvGprZnjAzYrjT+s+Q0CzIEvxE5CMggeXpiylS+QFNr3dH8ZYOAFJ5MJzgOExUev2JxFNN2ewwcnZULirDFaa/8PL/b4kjwsSYUFiOYX3obyMW3Rt/oXxFkDbyiEgpb4rdSRaWYStJ4Hjbw9zmX9BZfwe+oJbiIcCyQXqdJtYYiprZu5RCQt7XeNwHnDQRAdyOigPz0vTKxM+ocsUudNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7rXGvBR19M7eiUi/+qv3b1huGz1api5vmPY5q9B184=;
 b=J2TIwackSSR3t7Nry/0wEaaXQFjjAvdbR3e2qnhlU3SLsJCBiQcNlE81D+InMFPKKDeVLJnCgkhcrH+V6KekoeYYWn31m0U1wQYX3mF4FQN19A76McYRHqU5S8QwJ0HWCdffik09D1lrFt6np7efy7vd3Mz3m6EGQAfVbZRoYtPAew4GJ2xk/iLid6ZTvK90YUdHDvVRb6xm4AO6vLGWSDIN5YrRW1TJ1Bfv55fxxHyguoxEip/VoIwL3z7AwzK+cMl6NU+wlLnUsvfKVDd/SMyxJ+YMR6DqLvEsk4HCGoPuNKY5TH2bktvktKEgu370WZZQklTfjObRD/mFbCJzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7rXGvBR19M7eiUi/+qv3b1huGz1api5vmPY5q9B184=;
 b=XJFh/6JUIJ4zj2fVabcWht47WpshjR/ebh3k/7XS5NXu1bM5kMhHfyo2yv0lGUPbVU8Jbpg1dW05HMbtr/HxVqI6uU67CH3NJu2uLh0HEc5lSJDfk+trcS79YDxO2n0vnhu/Ochxg5aGfWJkQEuDxP9SH1HMAdYkkJvBJI8RUYU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Sat, 4 Jul
 2020 01:15:25 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%8]) with mapi id 15.20.3153.028; Sat, 4 Jul 2020
 01:15:25 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amd/display: Send VSIF on unsupported modes on DAL
Date: Fri,  3 Jul 2020 21:14:52 -0400
Message-Id: <20200704011457.2368241-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
References: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Sat, 4 Jul 2020 01:15:25 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86ec225f-3db9-40fe-3521-08d81fb7bb57
X-MS-TrafficTypeDiagnostic: CH2PR12MB3768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB37684BF6BD314AE812303890986B0@CH2PR12MB3768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mkzHTSkiNZFxhnNF5NmFO82A/t7tSXLsTVuKJV2u8Wq1NJAgOJ2GDSJ8nhq1GampKxa74PdJuS0HTR/ItvxlBXcuTcyIpl2YfaCiiwGACrqLkJeMAPDSPyHs9yrDMk2/6Ervrf/tGF1PLbos80L0x2irPbpXTuoDWi9yyeMBwUR5QJVKutMN+lbNpnHDEtxm892Sl8gmu2feyHo6eDcg5IsLsQDF8mB4Fg+UcS0sNvmkBt7w4oVKa1V/3tZlBMQrPXBdu/s7snC97LuUAy7uqOD4OydCMHS8FUQcwCELusV+f395btBLS3E8iRYr9vuGWqi3lZwzDRQFL8ZTxcGHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(478600001)(8936002)(8676002)(6916009)(52116002)(6506007)(6486002)(316002)(66946007)(66476007)(66556008)(6512007)(2906002)(1076003)(36756003)(4326008)(54906003)(86362001)(16526019)(5660300002)(83380400001)(186003)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: d3nUOdyOnQ6euP7IgZMOHOaiPe1lVRrOX/MvzsN+OxySc2CPTbSEUZ9rQ6vfBcEHKH9I/XQJnuW9ZU0pu0A0XIwbemCcWRPwy0e72VpVKK84CrgQejoHWcf5p/LlgbiLL3FFBYE6QX90T9G0c/MzdINHJsXREZKn5822BJMROgPBvJWVzcFGhu3S0lp4Z9wiZO4NGnHr2DmP+0ADo4Mm+WpNm7tCx1orGsh8dTXKxX12pkXE72RZg3y4OZSP5gBtAM3i+ZozBmCq5ibYCA1isht+ob7ah7U2og0Uj+RpYU6yNUGEFqjhUZ/af2ZFN9PahjS64ntq/jfJicb9n1yA67KcFEs0jgbRC/t5J6dU83bdNKOy7qk3DFGSDj1l4q4lmwVu1zNAz9dCXu1ce9VkCViVu53UQvl2JxJ2m3P6Aty8LszqzRcSz7cvw+AMth3plU6XjMdY4hlmrI6Bzcn186eHFJXDFwcZv7DLyS96KQ0Pcz0Z+KjMDNpXVnz4WhWTngHTN0V3xSN4Q1qiN+m9JQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ec225f-3db9-40fe-3521-08d81fb7bb57
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 01:15:25.7238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4U5E2/MPbAAAdf4SYAKUfHzUT0gKg8ChMSkwMV8rV87k6D3LARX6MT+xgwTIsclrNdOfDL9spgh7gP6rvsU/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
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
Cc: eryk.brol@amd.com, Jaehyun Chung <jaehyun.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 aurabindo.pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
Current DAL behaviour is to not send VSIF if mode does not support VRR
(ie. FS range is < 10Hz). However, we should still set FS Native Color
Active bit in some unsupported mode cases.

[How]
Remove check for if VRR is supported before building infopacket.

Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 5ddfd6476ff9..d3a5ba9ee782 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -790,7 +790,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 	 * Check if Freesync is supported. Return if false. If true,
 	 * set the corresponding bit in the info packet
 	 */
-	if (!vrr->supported || (!vrr->send_info_frame))
+	if (!vrr->send_info_frame)
 		return;
 
 	switch (packet_type) {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
