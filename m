Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB10FC43465
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 02:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A5620665
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 02:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uoHA5D8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A5620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D9589B62;
	Mon, 21 Sep 2020 02:47:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE6A789B62
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 02:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1ohsPdRk2tb/+9vT/EteqTO/0jA1Yj6SsqcGVTrKxlR0Oe3tJu9zr/5azpkmAVsOlrHQQN8qV9R5Q1UkqpAHcmjwru369bp9gsVd44SdivWT0TTASz8JWjKBdY5pC7WO5TolMXY3ARaHV9EbussG+9327jRpZjeoRRolETwXV66DX61eMl9SdWrrh9SsUkXucO+MxYK+HsL/SiZQrQa5g6kZLVcvdjCck/pFAlKTMtSavdcgpU76gVcVuNLwMKYH/aNfAoqMH3wu+WsdFPpm2gaPwGMKSqfu+Ul6crZXguvD5189TGQ9qqGn9AhSB8mgP5tEp7gPfSegp+lQ3rRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+Lc8TLS23H7D9kCalkYH1XliW4ov4lPWns5idZUQoQ=;
 b=GcH1w6wvSPF+4CaTNIYftTwVU3KNgdYdR7qtulshNPGKB4LsHSg3ClaoglQ7KCnmr0GuEfYju9HWoL6II9PNt3BBB18ENQVFyF6tvpX6++hK+4kz8gvfxL2l5pOYxQpcSZIqaj4oGpKv4UcyfNapRrttAJ7ZjUeYswJ7Eax8OmscWCUMcXHpXDQ00ay7h24i7DUJYdLNM+coQNmJdMJ22WdsnUZQ1e5OQmik+OlFy3zGIfH2CHVJN3sxTL7Bhn4ZXcavo0a+e94M511XTOqlqC+nKEvvLmP/HlQoEIf0NyI0GN6Q/Rts+fyhAksMXH55POROvPw76u/n70HBD8qfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+Lc8TLS23H7D9kCalkYH1XliW4ov4lPWns5idZUQoQ=;
 b=uoHA5D8TTvHFZka6p3ttbtxv8no7MLaY9QgFHrJ5biDKQLt8zG9SRGFwgGjjDvGagOcuZV3oppxGSpA0ij1bquLDDefBCYKH7cVZPt7zdzzMccXHMtcyIx5VJUHmn+e2VHlkG+7IOmrloOxaiJNx7A1r5LTCIg5nCNw33yDY38Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3771.namprd12.prod.outlook.com (2603:10b6:5:1ca::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Mon, 21 Sep 2020 02:47:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:47:32 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: correct the pmfw version check for Navi14
Date: Mon, 21 Sep 2020 10:47:11 +0800
Message-Id: <20200921024711.15026-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HKAPR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:203:c8::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR03CA0017.apcprd03.prod.outlook.com (2603:1096:203:c8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.4 via Frontend Transport; Mon, 21 Sep 2020 02:47:31 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a5cd026-54d4-4129-4188-08d85dd8b01a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3771:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3771A7002FBB1C49B1FFD083E43A0@DM6PR12MB3771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9GfXO6JLdfF5DDCMXlNuz7cVMaeFs7kGSy7Y2mV+kLToRPjIIq5DqTyQ2TM+bus1pJywiOa93xPQphcV3omTvi6adCZgmjCtbT7QtujuGAqLmPk80oIQkyCcJDIbiM0TOZy/jdqHdXs5iRrlaQs4Vc+2RhSZwZbyUOTQnHYc8vS9vwp1tbinL/KlWTRY4a2ty19GWVGoG2C29CDs19XOqDH+FsJIsIs0Nbe0/JTPBcJu0OMrKeAANCCjuigVgWePgxQDQLlFN6WBFLGHySLF40yLZ0sFM3pSyg/TFWfGGS6NwuqnQQ2Gl/VkFr6UUV1MxAOceC5SO+XCGwqb8ip/k4crJlsvOYpeGi+Lb4q9Zs9MHi4oUTiy6ez1ltC9d1a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(1076003)(66946007)(44832011)(2906002)(52116002)(8676002)(36756003)(7696005)(66556008)(83380400001)(5660300002)(66476007)(6916009)(8936002)(186003)(4326008)(478600001)(6666004)(6486002)(16526019)(316002)(26005)(2616005)(86362001)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zuiE80GQFFetT+6VGUZA7e8Er8o6gRyE9FWJhblTcBPTFb5wDwE9c5S6GcbEenwjiGxqyYdPiXYgNXGCDQWwFN/M7hrcyXtDZBAz3Ay1biyU7IrfLzKLq1/cEZtyWAgM+k2XXoU+jWc5xV+RucvA89ICImrIQWhU03fN/6Mq5LcqH191+0tkkGXLUGSdJRKp9QE5qYV00pyPrFKLktN81WkC9j2mUDVYgIBcQhQ4A2xaU5wiO+GzNIsG3Ajyw3XIzNyYn0XeU2M71Pnrz0LHB9HwHRkzJhLSkFy+Jg/3cIY8do4wMkuB/KSq9c7r95WMbSvts0yLTq8DDfpHHgzUg3jwoz0SxX8m8wusFztVRxaalM0QJRiW1yO2/vWJWk2/Yf4n+egiAD2+rXTOECUuJ4RUmQ+AnqbdRZZUVAzZz69B7J7kTCXd934PaTyFJsuuCE+uah5glUCZjhq1WVYWM5z9LibUNRjHQ5I8d3a6LY7btR9GrmXmq6A4vVok++n4MZXKYMRhJIhe7kk7X1fstpQAjbgQ6cw8futaQc7KPywQaAuGVzClETeyUsb76KoJ3SuoHkSayjngZmq2XaYyI1b8Q2G42rW/Ql1UUfF4yMDUJIL66PdcUcRoAqnU8xQ4jMqIQpGHsQtD+pVyWU7LOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5cd026-54d4-4129-4188-08d85dd8b01a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:47:32.7061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGYyoueaDT30U16o8Jpo4vBb6Hyqev1aYeD7If61ILp+8GPa/+8HIfwJXj6yMvA+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise, that will be always true for Navi14.

Change-Id: Ief94150d10e4987e405d97674d9ae4efe89246fb
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index e729337e84d0..b9e522ed499a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2279,13 +2279,14 @@ static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
 	}
 
 	/*
-	 * The messages below are only supported by 42.53.0 and later
-	 * PMFWs.
+	 * The messages below are only supported by Navi10 42.53.0 and later
+	 * PMFWs and Navi14 53.29.0 and later PMFWs.
 	 * - PPSMC_MSG_SetDriverDummyTableDramAddrHigh
 	 * - PPSMC_MSG_SetDriverDummyTableDramAddrLow
 	 * - PPSMC_MSG_GetUMCFWWA
 	 */
-	if (pmfw_version >= 0x2a3500) {
+	if (((adev->asic_type == CHIP_NAVI10) && (pmfw_version >= 0x2a3500)) ||
+	    ((adev->asic_type == CHIP_NAVI14) && (pmfw_version >= 0x351D00))) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_GET_UMC_FW_WA,
 						      0,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
