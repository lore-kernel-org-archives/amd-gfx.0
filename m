Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C474C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 09:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 125A360200
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 09:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125A360200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C5689F6D;
	Mon, 10 May 2021 09:56:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E522C89F6D
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 09:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gk6xO3KQlZ9nxIBYTWx3SxfWRmu7BSs3f3eaxGb/7PeXA4QVikBiFnPkcevPvSFXLWag+afhGSk/4ZL+6TYwBzA8qkarYTEQw7Dbiso0WkelkD0DGLEW2PiwnKWiNTT+/dPa8bDNvsF0YBO+yXiNKnLxKwgezcfkvI6gLEYpbsJKCq9iGcgnAIf1grf7G4TmG2NlvVp+o58ThR0xVE9gykNwBDOF83khRCUV3T8iITautCiQjyA34P+jLZE/8+XryopuM2uNvO8eiZ52lPW1courKBQKz3MTVTbtfhDLtEPpZmk6FqekCpMIEtnuxSa930Z/hHu6eCGBtvSEsQUjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxJl3FF7ZlF5J4b5HGUIP5M6uPl0Mp5WFA2auMrX6SM=;
 b=ljIijZowDvjHQKA8L7xzTyA1uR1wb8Rir8LsXukvVE8pezA+p5/YF0JygEHNXW7PkPhu6tMub2rfqNjcXT2vCGbj06bbrQAM3crWrl16aZdp0D+QuHYpagch6WeZoQdrs06xDr9V813PVKykmyAf4c/NLZUkTEa9Xbfl12XIv2NEBBJMx5vXQZ8c2F114hN5UyEa01DQvegmJxP/aMuAyghzLUjxZItTTtSptHNqHkelqm0CoTNeX6JHykYwdBicybG0eIm3OfVuxpUAFHQYueXn752QJ2G1csaUASMgilqygEDWpQ4u0Yjf3MdYTUNNKBWLXLIWErKM0pT9ZtheKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxJl3FF7ZlF5J4b5HGUIP5M6uPl0Mp5WFA2auMrX6SM=;
 b=G0XvubHyQeWfCYUyq5Neu8QtXxosYLYdoKwBgLRNg/f7MnZUEOVW99BW3UD0CgSlGCCBIyLLR7er3/2NW/1Rb3et64z0xSxVT2LgEWq/ntivms0lWBceIuju+ViPxT002ljCe+5cEvIYXyFBDx2Mdz/BRBDxvPqk8h+yYPfP7SE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1247.namprd12.prod.outlook.com (2603:10b6:300:10::7)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 09:56:14 +0000
Received: from MWHPR12MB1247.namprd12.prod.outlook.com
 ([fe80::6c4c:39f3:3898:27fc]) by MWHPR12MB1247.namprd12.prod.outlook.com
 ([fe80::6c4c:39f3:3898:27fc%12]) with mapi id 15.20.4108.031; Mon, 10 May
 2021 09:56:13 +0000
From: Leslie Shi <Yuliang.Shi@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 guchun.chen@amd.com
Subject: [PATCH] drm/amdgpu: avoid undefined return value
Date: Mon, 10 May 2021 17:56:01 +0800
Message-Id: <20210510095601.2091-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:203:b0::36) To MWHPR12MB1247.namprd12.prod.outlook.com
 (2603:10b6:300:10::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from syl-dev-machine.amd.com (180.167.199.189) by
 HK0PR03CA0120.apcprd03.prod.outlook.com (2603:1096:203:b0::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 09:56:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f302fa0-959e-416e-bc5c-08d91399d85b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB45072F393FF60C2878A41482E0549@MW3PR12MB4507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSpyEMxwbvxxYmRLgyEgqg2cCuIE7qjR4YBQAmtD4H/rGvmyRrF2vKQ3HhcfQsIdtaurl2bsiqyBrXjftA0NS7IQ77Z2pWoG7C2OsqBWyFbNLKNIdoonXQca+gxHl8ATYXLUn0aJrzRuVkore0rtvveXTyJlLXHsMmvOc2bZnVZqkIwMJWQx1rXiPkaOFGW8SK2TcGObLxKj7llPQjdcwqMcRcF9jzmD4i+NqkS60f5Ijddw0UpJjckAnD0W2JWnL3NM03fuxpkr3PpXLyNQ4quCZuNubL2ucSM3BtgtreqW0OB7e/8eUZ7NdyRrzBvKENHKyUxaysTSr48wJza5zmDXyzgIGzd/X0TMFqLnI7UKQ+eofMUeJ7binr6B4hXH1rXnD6L5KjuMkPTJFvzAMymGBYl8ObY9CMhYn9Knc9kimZGlFxQxc0zvzGXjq/FY/fWAJG4l3fcb1Ho9U5/ImaAFQ0FlhtDHzdjdH6Yzj+bSunMSqtmPpd43ZbDXghwPXaTgH7iZXL1Hwzkg1QQSpqYi8ID6oayz32PPaPsG2EQ/GnGmvUifyU/siMf3MqQvhH6tm/jbn1rgCab3FMtO9+1O7lB/3X4+tRjFe54G7sxiDx2tMTpf8AlKUC2EYk88N+gpc7Z72KtiAAZRbVrgVLyhZrKLO8s+g9W7gVoja4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(66946007)(66476007)(316002)(8936002)(83380400001)(36756003)(8676002)(16526019)(2906002)(186003)(66556008)(86362001)(26005)(38100700002)(38350700002)(7696005)(52116002)(956004)(2616005)(5660300002)(6486002)(4744005)(6666004)(6636002)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CQ4dZCo2uLa/iHqBHef1C1fgjnX1Zvr5xFQw0FfEx761/jRvCZZAqvI0NkMH?=
 =?us-ascii?Q?WkCyCxloX2Eo2jmlsQ3mEjlWUz9DVef78bw7hNEeIA/bwNH2KjhYpahtIKpm?=
 =?us-ascii?Q?WcCatvPc+bh/QueOMsIQMtENtP6Ih+3/STihFhwxgNPCEhHDuBZVgyfo00c9?=
 =?us-ascii?Q?Osj5pUQnC3buufz5G0w1KQo87Rk2LIyDbH82Ey3H3QFuD56AAgL52RcmwAqD?=
 =?us-ascii?Q?czUGd7zC/gQN5VaIQBmJSWL3PNdePJAkRgnUgHg8geDjho4a6Cx5gsvxV0KT?=
 =?us-ascii?Q?hYwXe9D9B+Tcou4KmmKbpw8/toZ/AtzEitLrwfl24WuYNNZkO1s6+f1oEfUl?=
 =?us-ascii?Q?w77eougSZENtVfx7GLyY6Ydle0zKeqWgZYi52yn/iKlkaDERPw8bku7gD6on?=
 =?us-ascii?Q?GsEF3TYKJ1vNCQgpan8y+pWJPU/vz3Io2xBrrBvcqwuG2vXLuOjZvRNUTh5h?=
 =?us-ascii?Q?CYgClERwP43jwdYfbG+C+JlaXMgVywVfMGk1rgN6qEAfXMu+S2caO8MinIEb?=
 =?us-ascii?Q?qFNR/a9nfgAPJha41+UYMt+a5W7UFarNYMn0weoIo7cCZMTqsmxANLpxMaoa?=
 =?us-ascii?Q?zsM31phBCrsT6O8xoKfgs/PL6f/+2OrqiMgGJb0FhJNtZFqjdZmitX9dtk3a?=
 =?us-ascii?Q?6Wfl84I6QvTV2QgyEN8FXhokhRlQaqWwsjqgGg8R+siufES6P5xKMv30w5NI?=
 =?us-ascii?Q?N+7sdtk3J3GWTzm075FTPpwW6xdYoCnvJR6ki2L7O+BxHt89xet4YvI/5kJA?=
 =?us-ascii?Q?JKkc/Xzzc4GDSVvzYbIQF+SQ1QxJoCZ/Y/Jsc+lxzjXhZtMKTRX8kTiHFgvL?=
 =?us-ascii?Q?78qtQTzFPoskAaliOWWucy0UaIRlmr2EEmEL/Xpc8Cxb0pfLfwIidss0KQEy?=
 =?us-ascii?Q?Sc7Z1ZnV1DlUJ/GaeJ8I9knIVYf1TJZOwrPr0E8JRshUu8CcgCbAQ4sJ/yvO?=
 =?us-ascii?Q?Uhgy0VluipWMmUCrPUzTQNKBNF3Qwdp2U9iI6V6xLcelZAtoYTPAzCMe4Gcb?=
 =?us-ascii?Q?LthO7/BH9P/tY5mEXaYVT0OOp7SNP1FqA0ace4qFk/K3p4gmwl5jGD+wm4gY?=
 =?us-ascii?Q?mtkCyjRtcE4zqXbeFD0PJm5QTIuPiIUnKTwEZNNgHTKC+DLeTG+BIAFfQNiD?=
 =?us-ascii?Q?zBoT+yl76vdIe6tZv8KrM0MT2b8iS/NNqYVfA22JwAMkL+a/Xi3OGRsFXbTK?=
 =?us-ascii?Q?Yxgn2T1kW3F1OM6NZg2ObKRcZzdJ3QcyY13L/xan7z7i3L8MedMepYSr/hbV?=
 =?us-ascii?Q?xryWfFPM/ENr+YbFfmDQuNI0DZTja+H62mSSXdXMjsV1OLLcwKlOqqmYcj64?=
 =?us-ascii?Q?tF51uSiJaJcQduJzZQCs2/Ah?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f302fa0-959e-416e-bc5c-08d91399d85b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 09:56:13.4188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMPyv9lyloj3hkNwp3GqungqChWxiU7J5XwivqH5X8vfh7FowcN5aYX9PLljQVrlZiQeIqGBZYBmd78TM7h9Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: a7c22df2fd07 ("drm/amdgpu: clean up non-DC suspend/resume handling")

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 7d4af8fc7e97..f3b2762f6f53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1554,7 +1554,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 	struct drm_crtc *crtc;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	int r;
+	int r = 0;
 
 	/* turn off display hw */
 	drm_modeset_lock_all(dev);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
