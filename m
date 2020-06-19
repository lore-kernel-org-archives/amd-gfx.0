Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A7BC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C21208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W9W2YBrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C21208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF7B6EA51;
	Fri, 19 Jun 2020 20:12:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE136EA0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDEH1SQ5JCvfS5c826reClrePLcGSORRbkgoe3OVP2lj6rfWVyGlFpAWbcu/WaJ7RSjN+qALTfcNiEQLMHcl3XZfsy6eCOx5gAyIhnFrK+ltcQWFpbz2C1LP02IEcexQErIuCD+iJmbnIzo4vX1Rxpi9I2aJVoO0yAIR9qDE/RgEGzrlD4siPtKdGn6S6GpPUUpyuSFGWvv1ihdRPmWlHMikZiWEWUutqPADe7l4l25v1RDVAAgc6NhdBjcmpv6/FaacePV6CJ7uXFf0CCNqPufiUXqWyo42c+fihen/FWJtpIZiPVYY5Jg29Yg28l1dca69tx+U1WJPpGqjDcHxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hDnmG0fjbjafSzT7ei99qKO37PC9hndhnY7AoVaB9w=;
 b=gZ8L+kFOtIgJ+B9aR7B+qv9iMvu0xf6U3/I5kJjKmK5T/WZZWzFbPvkCGDqg3kkU18qxCnGYymSp0ZvkwTePzoki39Cqm8tuTwCFvbpGJgLb+s53NqokYTV9Vd1BNcuBgJBDLodg1tt4rkPJ+4MedRkdPsTBzUlI1Pd55DUC5MYOy1PfjDjsPZFiKfsqRLK7QAuLt9TI2TWAVgLaYWCMsk/rucftsrxfRsmVZq2htK6J9zAXM0mX64IUrURrkRvggLXgyajdzXso77A8qCT9YcErhSGVDrUv3MSbo53Orby2NPJFTFDfsGXexCDl3PbLF4znx34OKpcT2eJFwz7Xnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hDnmG0fjbjafSzT7ei99qKO37PC9hndhnY7AoVaB9w=;
 b=W9W2YBrpIHn60hcAQTPBRmgXhE/8ENXUtR74317RS1odk/u1fQTqniMs4UPGpOHnk916sgJSIRiHaRPEgWzyXpz061fEzcQG9zaL/aI4xURZEdB9qT3mwsC3RQsCzXrRtm8wbVqUOgUwhd0iFzDzA+cH8U2Viq2s8vBwn6vlY/o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:49 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/30] drm/amd/display: [FW Promotion] Release 1.0.16
Date: Fri, 19 Jun 2020 16:11:54 -0400
Message-Id: <20200619201222.2916504-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:49 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d226dc5-6196-4424-257a-08d8148d239f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3717CA3EE99B232ED2ADD6F198980@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjsTtuAVs8hJzu7RNQS9Q9feXVNVfUiuoxM5e4L1EwYvoxdD0ZxQWA8cDPVmu6WaUbCvNMp4O6E7/WYvxg0zwzikXYKKD1018SuOzF8O6G5X2HWI0nlKNDceF+9ftR/uMWc8jTogZ7FkMw2NfGEPwDobeZD4zWiDQqFeBA/7N0v+Bx58BCvBP9uILxxNt1D4s4kPKj3avtSZFkK1g9Zd+i2JkrzUPxbMljZkQok7XFzJRIQ5iKzW/rTMc0H0aL5zyOkmlypz5l9sPJEkV9HSPTUutW9LjQAynobOACQXWQfpURHuEcYWFsc8hgEXuFS1HMUMllBvmIiZmdbzKMIl0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(5660300002)(66476007)(16526019)(86362001)(6916009)(83380400001)(478600001)(66556008)(66946007)(8676002)(6512007)(1076003)(6666004)(6506007)(4326008)(52116002)(8936002)(2906002)(316002)(6486002)(36756003)(186003)(2616005)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3OYCn7BU0UAA8EiSmlharGvf+R8dH0jsB42p8XHoHXi45sgfbkmlsGRicIoffdkszIq6d2KvNsZAeIEJWM8i8NzpBLxCCzBd4KdKjWOZLKIXLXGNBEsQqtt8i44VCR15QSGWwXrm5Gr8ehns9r9ErpnRZwvGr/P98Q0T4ysskbHSZ0RVBmPRHRU+1vdt9G6aNNYnH9iMDJHbn4l1aKXaXAFCl8ERgH4vnryAwvzq9GFaE/QVXpJfI9h6LUEqFJEbFDodbSBZCS+lzKmF2zMgL8oxf0YxQ6lN8rZYKjcjueEIYe98uxx9bKcnuMrC3BIISKx1oFlDxMRAmW3LCkgpbfBP1oE+kQ+N8aamk4SUg+XJpIU5xgynr/cKBKFWiZ0fXU9k9L8TXMX9w39FYKmP6BuGbgx3DPmJo5Vsy3lm4Y5b58rrLZlV+PEdvno7QMjvVH0vB/71Yp156tRhXB7XjY7KQQ/KcNuq8zxRXUstWLDyzOwVSsU4quRX3U98XRbo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d226dc5-6196-4424-257a-08d8148d239f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:49.5642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9uULg53ga0WvgjeMwCDCkT7kFBqECG93W4jfqRKom2m6N2pm9xwvNbY+cwExhX+wfLz0HEp0w+GlFmR5JXcuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 44f74047050a..ef9c116b790f 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xee850bb2f
+#define DMUB_FW_VERSION_GIT_HASH 0x703682cd7
 #define DMUB_FW_VERSION_MAJOR 1
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 15
+#define DMUB_FW_VERSION_REVISION 16
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
