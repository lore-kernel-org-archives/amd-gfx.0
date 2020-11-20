Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D56C63777
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8249222D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qnkbowll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8249222D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDAB6E918;
	Fri, 20 Nov 2020 20:20:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E33DA6E921
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA0TIEkkbu4GQcRdff8j71lvz0OPODkdjOdOuiyEWimv4Odj4tr2o9385y1r9CfVvBfTdWjF5yb5hf5t1hf5NxK8VV4J8VhlZ8nzpQsxI1GaPEGkTs7lWKa8KvY/SRzh5q5eB+RTpfAD2Kiy7Eo+Jfdwomg7zxtsQu5l+hRi3aLaoPNsKRBKwqB93AaPR2ze4Lj6s/VdMx33UXqN4AzAEVayWZfTbWbsVEQH3ydzDd6Gn9bSbbf+aAz9bqA4uKBCo8bypiF4HKEo/RCde45RmYzq1i6TXHWyYosqk8XJsxzW32D4udM6ZlLK3Do+cpjEv4l5pDGr1PxFCwsp7heVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN0d/m4UOX91qcyWBvShlDmDV8dhlxW01laXLCDycZk=;
 b=SbwII0Mqy2/+vAVZLa5QjGnhtQVsdAiIAsv0DZYrjKr8MmwudDXkG6CGaxeXZIIF/S3qh3l7PnkraIP9+UOGTTJPjjWSWKDjymCBiAp0A35VCppi/JqXqquiHHhXcDg6fpTlseNSH7OLJNiGwX2E7Uyqy6jqCGjZ8FAyzY1ZDHiJSdsDVwiVzrAFbBdhVv76f3nXds2tM7W7uPss4dB9GwwXiMhkE9kV/BXXULPcerP/QDbLJoMhXX+qG0MaH7h4lM9FDC3X/b/1ZYrC3abmjdV0CcaFAewWQINCF+bmUcTF2uhWbufYucxWvV6b95qxbU4ie9pAdAKxeONDHd8sUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN0d/m4UOX91qcyWBvShlDmDV8dhlxW01laXLCDycZk=;
 b=Qnkbowllg5X+383jAAS3BjAG2wr/bdk8mYOP+sziacl5i/Ksh2n4+Nqv8yWuMp/hWcuOzM+GebBh0aqH5JFZT1CAWukWa1DMTYohRhyoX203BWnKFeSJCb3BZcXa8F3HBnm90o/3rnQoZZy/mo4iha4d+GuOkrW9rFxyG+owiKU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Fri, 20 Nov
 2020 20:20:27 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:27 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/18] drm/amd/display: change hw sequence
Date: Fri, 20 Nov 2020 15:19:48 -0500
Message-Id: <20201120201958.2455002-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a442fba8-1eba-4f1b-0e1b-08d88d91b842
X-MS-TrafficTypeDiagnostic: CH2PR12MB4261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4261612C3275155ECB7D60BC98FF0@CH2PR12MB4261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkClhRAPI+BoLAC56N9d3hFWBs/ID903xfZ/HAPpD5BB9MjIA8aMpBRDKG/dLJEawHx3EEbupIrXxJcpNNZXdCF+wXqvbWNlftR0e6ETuf2VZXUqD3lzvVEM4AHN+NAKYvBGILHibutWXlTFBPCf+78ufTpSN4m36oebYKKZEV/HWg6bhyux57ZzRHuutkMUz1TQLYV0Zz8ORGIb/C9mN+qDaWbUDTMgS72nWdwFcd4x2QXbJhM0WIJ+xgvaeV7ngT/6OrkqQlXGap9+l+sXECfrvfUmgMw9dT/RczDvtcl3I2jD/Vkv0V0WCzpeHPiF5I5kizgoDTwwv4q27mj1UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(5660300002)(83380400001)(1076003)(6512007)(66476007)(66556008)(186003)(6486002)(66946007)(4326008)(2906002)(16526019)(86362001)(6916009)(316002)(8936002)(36756003)(6506007)(8676002)(54906003)(52116002)(6666004)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: U31HyAtk2P+1u+o8c4dhSXJMrBOq67JtrqC11S7FostWScFSswQUQb9Go2YBQM07HQ7EqYhMydRvQOD0Lh+9yP7MUtNAC1eEl7sT+Jy6TyDGxQ1P2ndmPbI8uiCWJktvUX0KbyYBV0QfWWyoDKk1RY91M45eqnbtrpAzKO4GnaW1RJkW5MKiWxOOABFo48bfx4OAtq3VfySkyXqsZhdi4Vq5HuMCf5QjjKyUsaky4hn2/my5rLWot8UwAvik2Yt87Hprt+W1Xg1HOpJAEwEUBF2XTZ2X2Ijs8GOPJlgSV2ZVbO7hxrod1zruL4fyRvDHe+rMBaFpyxTJTCRFCgNpAkmg/cVXFFncvx/5TMmMv/D6qnB8Ami8jeAXB/SIUyhNtjri4vkaR+QjqzQxOTZU2QPs63AbMIPNAOUfkvgFffHqEG+eRsLfAGT0MBxXaSWl9S3rUtruFBj71/YkCUGzpTMqe60jC9fbMwO+Gsz7oc1LA+ulpMjhCUnjnrZfe52Bl/GJhsADD9NqH7CEUKtbX4joIK5PgJ0c6OMAHNyl4a9JWVOZvPNZl6WsdslgaUqDwkNAFe4usuvDJebTYaVz+nEtixhgj+M/hJ95H+aOmNn48pI1JfdkgQf8pVanhH5O4WDrQNyRI1iCwuD8tbZGh94B7WGc/69y5iPe814ZKPll0pXBrHYQB9RVm9j+Tf3/SyYujFLEXey+jIuna1tCLMKVV6P/bprHkzj8QuCBi4SnA+1hsAZMUq6gpdQ9uvHcI3Ixn4oAkBKLh6U+aut+4HJsFrdyZ1ABzYIBlart9CDRuk9S8HTlR3Hb3iIoJLDg4kIhq7a38vZLp8xQL63jXJaWOBvAsQiE2vOSY23Vb2eC7obzK7GZn+4VXxyM2tdeEkA1FKD1KICZ+iRb3s5pKJx6slZIRQyfes9jEQ7eej2w2vxSiD5Y8sgs3AFk62Ee
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a442fba8-1eba-4f1b-0e1b-08d88d91b842
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:27.5815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWaJ7Di3oxJqZ1Wb1fL3rKjg/IbPLeaNZUEJLIkKwI8AGgvdrsB0VUs3nrPUXUUfll+5aLGQK2QwFoUlBHOyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com, Sherry <Yao.Wang1@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sherry <Yao.Wang1@amd.com>

[Why]
t9 delay func is called twice after setting power off, the unexpected
action results in a doubling of the added 140ms t9 delay

[How]
If the backlight has been turned off, does not turn it off again

Signed-off-by: Sherry <Yao.Wang1@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 9f56887029ca..90c85b3e859b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -939,12 +939,15 @@ void dce110_edp_backlight_control(
 		return;
 	}
 
-	if (enable && link->panel_cntl &&
-		link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl)) {
-		DC_LOG_HW_RESUME_S3(
-				"%s: panel already powered up. Do nothing.\n",
+	if (link->panel_cntl) {
+		bool is_backlight_on = link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl);
+
+		if ((enable && is_backlight_on) || (!enable && !is_backlight_on)) {
+			DC_LOG_HW_RESUME_S3(
+				"%s: panel already powered up/off. Do nothing.\n",
 				__func__);
-		return;
+			return;
+		}
 	}
 
 	/* Send VBIOS command to control eDP panel backlight */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
