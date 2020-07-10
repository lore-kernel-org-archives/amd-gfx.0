Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824F2C433E8
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5326420748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0SUo5d/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5326420748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2226ED10;
	Fri, 10 Jul 2020 20:34:08 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750078.outbound.protection.outlook.com [40.107.75.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11DB6E18E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 20:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBXdFeDi9ThQp+ZUVlcdRDaXOQ8PW6SpYRvNc4zoQuetHz++5xyllAHw6ktag1iJXUKkK3rScErqk8wU2rGUGeLyAqYkO/y35X1EljuITSJYgaYkpMFtdIclU04T6pwZNfBplfdMO23Sa9mRWRjapVGNcro2OEyGIelYR0qW6YFqDBraszD9g18dic1KcXpD90AKQsBgAED9p7k2ZsaS04UbZSyCZT/PPe/TuejPxYdXOohBGIrRzqPosDR/KN8gmbedwUXhmR9FxSFheOp4ghvEAlZURXMWXTB0A4LTMeKKeF3/ztOqsPuhJ6BZqseIKzhBDc/opfem667sxZViGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hyP8bw3FwARrz84rcklU8Qx7DX232VioCE9dZBDEbM=;
 b=NL2GPxhf8J/0U9quLwkycTC3GkL2PS6S9FIc58shcMR3Qo+pYPR1o2Vbq/oozB7CTZ+4DvdeC5ygU9Oe2//u/GZAQmGDmutLMxIfKsU5/E88gGzLhn1cMzzgNqFUsmGCzBmYL27sNZ61DRapU9oHbTY/BNnQmeDpfDnIQ8D5eobj8iUJjeC0jyxkGzoVmj3kCIgM3egZXnA1psNpKGedKSxqXXyCeFR3iR8oFKqDLLfG0khyLEx0qMhQWG5S1NV0cP/7dGT4rk5g/RA1r+lH7IKBC1eu/bEiKcMfQ2Jeqo4ABaF8bx8Owc2aUfdIXeW9jada0yGJTCYW6UJz3G+vyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hyP8bw3FwARrz84rcklU8Qx7DX232VioCE9dZBDEbM=;
 b=0SUo5d/Q2eX7O9wTwH0zL7SFmu4d8m+Q6A7krNyw27H/8NDK7bRDfPKQC13ckVOmaj8mEaGp+KtXpHNInKxh6IiKcRpLY988U3+05eVtY+2a8dBnsdNMeyu7g+pW6iu7YAfubN+yNro4Lxl4JFM2Yds0kl4pGKUiEebdDmHpxEM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 20:34:04 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 20:34:04 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/10] drm/amd/display: 3.2.94
Date: Fri, 10 Jul 2020 16:33:23 -0400
Message-Id: <20200710203325.1097188-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
References: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:8440::b10e) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 20:34:03 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 275f206f-62d7-4883-b680-08d825109610
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB423148468BAB5EE5419C0C0198650@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbuFjkfAQnDz4nXWGGaIZIKMtx7zcetMzYX6w9XhAMiBJvPfFSl7N9iepbECON6mglBh0gy6xUf8usxfEWiYUaBNDMFGt8RmXWItMK8D9HJ9SJA8qNFGeIjmkFAMq65Ib/ZDTpcCjL2fFOXhDJ11oUjSsuvYAu1nXkJiLjCVSIkooEAca22/KWkYidapTg3YMvQPsJ3Gqg/6rC2PQ2rC+AUnYHyPU9Mb5KND47ppg51kZ5C6bCFh0blDEVTSYKj4PYAcqKHpcLntGdIsHh0Eb4LeUA2qdsgWCTRiVkMgr63n8Hka7Jv8+urBJthBZAV+T3kNCUkE0Rwzn1JYwAf2Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(54906003)(4744005)(2616005)(8936002)(8676002)(6512007)(478600001)(316002)(16526019)(5660300002)(186003)(4326008)(86362001)(6916009)(52116002)(6506007)(6486002)(1076003)(6666004)(36756003)(66476007)(66556008)(66946007)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: O59WOKaaTMYPbtQe40w80VvnmvmAOujD64v9+09HXO4McI01x+3vRE8CcN47ljGZaug5S1oEhS/6s10n6BFSLIvuaIWk2GilrzYNR9fR3uIgBEqN16UfTvfsfitM0ZCu/QBoLVPQAfOS9igNKmSvM/uSOHkwuvqo2VARePPkm1u9AnVyx17U3/6YptyadgsNn89IZt+yCkH7aM/VqK7KUrzCBYrCbmiop3Kq3eUFkMRro1dJMqibnmf567TmWq4qBSdzulXOsPxSWvA6qp7DLwAfpALImXjoWKo/He7DlhZ5bSd3oWh8UTbsK5K9gYJAWBfJdfvPOesHXNjTzPyPc450o/4Lr/+vfm724N8s08KR02nxqZyDjtGC4qqbSQ+8OpN8SEbkUFVXCCq8KuYJ61+9wBFa/DZ7n8KOSni/GDrG2ssJakPlgW/K1mT6fETQ73ixDxhMIkpDtsjA0mn3RttlFpgayIFm93PNNgUKdjHOT22dW+lUIncnWo73+haW6kaAaNh7HXqWMT4YFDb4ZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275f206f-62d7-4883-b680-08d825109610
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 20:34:04.1989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cW0gYo9bsuCDlmPH2ZqhuIv4BpwN5pZvJ54soOKQCpLD8ic9TMZw3se3HksNuX4sT3Do6oRrIbT4Sok32Rb+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c2336ca3a9e0..e5a1a9eb6217 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.93"
+#define DC_VER "3.2.94"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
