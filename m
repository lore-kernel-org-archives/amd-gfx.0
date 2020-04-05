Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEF7C2BA19
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E148B20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YvtybuH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E148B20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 930B16E2BC;
	Sun,  5 Apr 2020 20:42:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058326E2BC
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FculP76XbaHE1UBNmqxO1l3dLMT/gEZp7ACURztMl0qYKZN7OJMO0M94YfZWbRwNbPNLGLPxzxYZTBwfbX/0nN555ZzQ+L//0hyRMC9BvywCKMbJgNBF9Ob1U1RnR0quPSQuQwccdPr3sC48LlQwiaUBEbCNGRsi4UYUgmLLswTnPD7YSQ3GFCXsI+QPJEpQLxhh6Yt40utn3jFAf2aGYHp4DcFS0LJLJuHcE89D36rhJReMuwXRx6C6x0vEZ4PbXp+mHxo/nQtUgfaxdkC458dAMbp6/CcikbJKZet5Wd69ohJNHc8It0C1m75M2JoTkFBbpZLQcNbjXosjYqjQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJGaUNNnJ4tgqmPF6eccCsBWttOkeDWedmayaiHGo+I=;
 b=CidliWEQWfIDAt/cTh36O5P8FKqW1robU20RS7HqvW8mY62j6aBbh2QTUrpp8Cy0m71wvSAPkeiO08IYXTPEmIjvdKyR7XvRQoK1JNwQfEaoQeQqqYwdaqh5xh0k3YgN5nde5dtcctDlOEbtwKz3zMx/nUQ0PhTaxqv+Ld2yX6XUOJLT3GAxDcJ9htw1jVU7jJYjQpxflBFOaOz4Y49iTtw7/MdRKKarifc7LUIC4VkOf8vjsqpqPn8pluHv6RGzcBxNe2elmkjYFNcl6USe8lnaPm7hctuGK/IENNLjF2icVNQQqWsrpp8iMFyuvcQCmeZI4cxMRPIRKyrkFEDGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJGaUNNnJ4tgqmPF6eccCsBWttOkeDWedmayaiHGo+I=;
 b=YvtybuH/0QW3gYUlOc4X8vRLsXhtf1QSgDRGMvHQPW52xKK4xIxtwyRT3pznKZsEuSx2ARdrVR82nIHcjICoHYwtR6SDIC9OsqgVXPJNXOoap9stW73YtP+YZxIn+gB6MXEN5NVhJ6PB2jC2rP5ola1948HWCtoeDroIX6E8XeI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:06 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:06 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/36] drm/amd/display: Don't verify DP caps again
Date: Sun,  5 Apr 2020 16:41:07 -0400
Message-Id: <20200405204115.683559-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:42:05 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d553356-e9b8-4834-211a-08d7d9a1cdc0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555A3A0453323885860D2AD98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(15650500001)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GyLYrUgPHILrGVk3O7fHfRQrcdSQkDkVspVc0qpUDjliXwYHO5rqwcmuGdSzM8StK3guj5IHhP+U3ntKUcUyK5cp/o3hhxIKQTD50PJbnjs56G8Ndhq+tB8HDA59xJPxxzHK4nv/hMsGbx7ljds3D2mLFib/BJYiT2X9aqbBRj4tALN/N4HrWN23RdNPXAGMYW7FFX+4tEY2ttRV7lPUH2GZzbGCWLTl64g64f7NwWc9FdNa0EPGqDokVtoJYVXg3AdHp/xnHSe9Tf7Rwi0aVCiAvovxdr50obqNOyUMklZ2p06AhvVFYB61BO2hEKsaiE8dWLp5pK+OOsmyQVFsIczutsXiwc+AlzsfTvzlgtljQeqCQWVTU4skyHBkaV/ASIoazDrlEEXD1UR4PYWBr9JE9HZA0g3ThhBRhvFhC97FPu/7RtbjfwaHVwvI6B3
X-MS-Exchange-AntiSpam-MessageData: k+vIFNXsC95lJQLfICFWzbHULeNqHtVaTwBgSM5NeWDwY4sODPFuxK1eoTL2UWkNWpb++LKEUdOAyPoJuOWPDmZEwQ3LiJyM5ZdR9WcSCYLucharLMpfP8hrhK5toezUSM9i6lQdLAnSwmyiBUrGhzGZc7eX9dK+rdYnu/IxDoU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d553356-e9b8-4834-211a-08d7d9a1cdc0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:06.2756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kMuuPSk5lkGEaITZAUJkHUeGxgJy79odrGPdYBdIDUweq72u008YuCyaKaI2/qnVudpferWbVoUB59EmWWjuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Dale Zhao <dale.zhao@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[Why]:
We will do deffer call back for display detection now. For S4/PM
resuming case, if SST DP monitor has been lighted up, verify DP caps
again and reenable stream during detection will black screen and light
again. Which is a flash problem.

[How]:
Shoudn't do verify SST DP caps if link has been active, and skip
reenable stream.

Change-Id: I5267db502e5fab0102a0db4d520bfa9282aa050e
Signed-off-by: Dale Zhao <dale.zhao@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ecbf165b5775..574612ddd5d2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -987,11 +987,15 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			 *  two link trainings
 			 */
 
-			// verify link cap for SST non-seamless boot
-			if (!perform_dp_seamless_boot)
-				dp_verify_link_cap_with_retries(link,
-						&link->reported_link_cap,
-						LINK_TRAINING_MAX_VERIFY_RETRY);
+			// verify link cap for SST non-seamless boot, skip re-verify if link is active
+			if (!perform_dp_seamless_boot) {
+				if (!link->link_status.link_active ||
+					link->verified_link_cap.link_rate == LINK_RATE_UNKNOWN ||
+					link->verified_link_cap.lane_count == LANE_COUNT_UNKNOWN)
+					dp_verify_link_cap_with_retries(link,
+									&link->reported_link_cap,
+									LINK_TRAINING_MAX_VERIFY_RETRY);
+			}
 		} else {
 			// If edid is the same, then discard new sink and revert back to original sink
 			if (same_edid) {
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
