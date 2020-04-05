Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0869FC2BA1B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09FF20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m/xmOrnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09FF20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31F189EA6;
	Sun,  5 Apr 2020 20:41:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919C589EA6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeAQcEAH6UchJMpfCpB5/vNPz5BwyDgfr6wDSCk0tnrMKemQYbFvFylhdLnLLkOpganYOxh/QF+jcQZogS5LoF8GfaNES8gtoCdmGX+b1zpsflY6bSiAchlocblxeoTQIQyELPIq7Wa/NyLaEtsQvctO2CKeET4g7c7jiUAp/Us3Ace6kg2dPMfGBb5SqbufEVbg+hfIaU3cZx/ZB15QtuHR+bYWtJbIjX4eRwoucf+6lH8Nv5EEpd630pmX/dQtDOn9cFtfB8Nn0LNbWKN0dadLeNPi9MVuSUw1w3lpGnd3ioRP4i1rW0QPJt9BsL1vOINzRGlK0dUWhBTkahnMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWz0To4oL6jIIz5uYyVCCZnZZSORwb4F+nxiGn/3Gp4=;
 b=hrcT2x1R2W/583KldpwDr7uRZnSKWYgns9c+9QHIkfMvdNN9lT4zfOTeDBH6MB9eQOiJ8ipqfEx1lc/gn6W1bH6NqRbB6Av/VKdkp5vpizO5BGb3z5iTBEEsHtBCbQMvIgkLsyJQw9brNVioKGza4u4xjBWDsFNYNCymWVjP28VRIsC8QEZSbRHG1ECcusiPXggnM6+XgTbwaJO2jneEdpbzJPcKPztBEqNeUmunFpiHAzly9aEOPMeC5mVnrQf1Xg8ZqrypC25kBsQOKgbHkcTi8nOi3beKUFzIt0uI88euN3m/75ToVZZmW+zG9Vsvzyo6Ti0qpn/aB2DwboISSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWz0To4oL6jIIz5uYyVCCZnZZSORwb4F+nxiGn/3Gp4=;
 b=m/xmOrnnOD5UYrCrMC4U+sATAa1toxHD0XmgJE+Ejl+/5+eZShbVtSjuV5RweFjEgvVS2aJa1Y9AMUlRh3+Dc7Ngmp85O4YQz7K3VmGVD8bdBX91Rn9aABzGpHp6jn5qhSI1IfQW8yOfFFkn/wHLKfoEidCvhvbODIi0Ls5qBm0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:40 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:40 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/36] drm/amd/display: prevent loop from occuring in pipe list
Date: Sun,  5 Apr 2020 16:40:41 -0400
Message-Id: <20200405204115.683559-3-Rodrigo.Siqueira@amd.com>
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
 Transport; Sun, 5 Apr 2020 20:41:39 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 831db765-d6c0-4249-15a8-08d7d9a1be74
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555F55F24DC25DFA8949A3098C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(6666004)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZthwqZ4A+i0jQybh6FYngm3h1qrHWW9Qthax06kCfB6bhZb9wx5FPKJespFr5983qJNf4fTTTCYL/kcZPXY8slTmkb33CZ1O8LA1ZVJvW04RrJo2Yp7eCU8CcgfenWDFugpbDCxvWXoNMUvB7CgWgvvgO1pEK+7nEoqA/3nPEwkpLbNFEFGllqn6czEyjjPRznyjPDd8wE9ZBDkwu6w7qiVAkayHD+O9oaerhHpYdvA8oIEX+RlzbmdkRl6BTTlavzIF/5W4Z3B/Kyrw4nO/bsxOVzLAgqdS/Q6nP5kxynrbIM1Oun4sPWWOEpmRz7TUYjJ88OaWkwzIyvmZLxbWa+qdhlbJXv6/NwBcHTOMoMntPvzhwLWmgtax++Ec6rJumr5hnjq0xOOPxzN9FSD31RYYr0D+Y6YST+wNW+y7zcDw+oWl29Jp7FwDKOsyGOi1
X-MS-Exchange-AntiSpam-MessageData: okp3rD4M8R4H/SP+oIKBh++nRxWSp9b/lk2Q/+In6UajqJvV5coFs71p0Zj717sP214FNWrp7No0DLx2VC0CtDzDVzr4kvKngapDPWHTr0EJki9x8dzCVP82cHEdbwQDcuYEWEruGUp0lJDi9cyPa5UBtWh5vX8c1nkD3vPRNIM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831db765-d6c0-4249-15a8-08d7d9a1be74
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:40.6204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZ4Ys1owaHsfvdIDupXndd8T1urbYEvWGA/PxZFfJaiGCulJmAYe8PfJNsV2Nh6XzjUxLSs7M5hBorLIbB8/5w==
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
 Josip Pavic <Josip.Pavic@amd.com>, Harry.Wentland@amd.com,
 Aric Cyr <Aric.Cyr@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
If no free pipes are available, acquire_first_split_pipe is called to
get a pipe to use. This call may alter the ordering of the pipes in the
list so that, for example, the tail pipe changes.

If acquire_first_split_pipe returns the tail pipe, we'll have free_pipe
== tail_pipe. What tail_pipe refers to is not the current tail_pipe, but
what was previously the tail pipe - i.e. prior to the call to
acquire_first_split_pipe

The logic that follows will link free_pipe to the tail pipe, referring to
the current tail pipe. However, since tail_pipe is cached from before the
call to acquire_first_split_pipe, the wrong tail pipe will be used, and
it will end up being linked to itself, creating a loop that, if traversed,
will result in a soft hang.

[How]
Do not cache the tail pipe. Instead, check the tail pipe after the call to
acquire_first_split_pipe is made.

Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f4bcc71b2920..7b32a34908c8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1358,9 +1358,6 @@ bool dc_add_plane_to_context(
 	dc_plane_state_retain(plane_state);
 
 	while (head_pipe) {
-		tail_pipe = resource_get_tail_pipe(&context->res_ctx, head_pipe);
-		ASSERT(tail_pipe);
-
 		free_pipe = acquire_free_pipe_for_head(context, pool, head_pipe);
 
 	#if defined(CONFIG_DRM_AMD_DC_DCN)
@@ -1378,6 +1375,8 @@ bool dc_add_plane_to_context(
 		free_pipe->plane_state = plane_state;
 
 		if (head_pipe != free_pipe) {
+			tail_pipe = resource_get_tail_pipe(&context->res_ctx, head_pipe);
+			ASSERT(tail_pipe);
 			free_pipe->stream_res.tg = tail_pipe->stream_res.tg;
 			free_pipe->stream_res.abm = tail_pipe->stream_res.abm;
 			free_pipe->stream_res.opp = tail_pipe->stream_res.opp;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
