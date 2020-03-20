Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AECBC4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D3D2072D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QiYcQyP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D3D2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 622D86E181;
	Fri, 20 Mar 2020 15:11:53 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750042.outbound.protection.outlook.com [40.107.75.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F006E160
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My9/IDmx1HFMFfKL/Q6lySL4r0wDn9R4zvHIOQ1I4c79btSIqypm+kjE5449H5Vtvg+6Pl5TceE824oJDRUfzOd92w44S7xZDjhvrobXHRlsBDieAi0vltFQBZKPKpHzLf1PQvtN5ifJzwPTALJdSmikvYRVFx4VH06YQhXMfk2nBOxnkd/bGIS5f4w2kiwpGe4ojaW5lzbhvLx+xvXbeRZgnPRkPC2X8711T72Y8luVYRLAMc4SO/OHtLhOLvvlKrWxx1V6jklLjz0U3aFke5HYrmY9PsoU2gmfAc9wacbDPM0kzTVWiZQqFHIni8j01lFPRP737ASof9Sx9DFPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwAeO+gNYqiDCewgThf3tG5zkYMCRcfRoqzawLm6gVo=;
 b=k+K1L/STcNvTG1wXDPeomlcBLH1E+xbz57hTNPsG1n+27RQsg6iLwk5OKsOTULuKaMB4op+ZDHaVRnpx+kvl34rsOSGnuop4P2PaMH7ULcSFWMKrFjOnMe7CP2ebotpRqfl1rt1K/LQdSogeUse33KEMpW99QB4W6CrVtbqlLYrH1uCD3wIQUrJ0GkNAtFfzs6W0MgyyxrovlYEhfmdad7YPpNLuxLjqUIYeqt7Rnkoo55GuhZdA1MSD9bhScGjN6HZZBhPqMcMiRbaI0V2izjkSYQIUBYUKQDqCfKhB8xG1D02QJzkWFx5KK0qMaDPucvYsxO4b1oGKwTdYpzY3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwAeO+gNYqiDCewgThf3tG5zkYMCRcfRoqzawLm6gVo=;
 b=QiYcQyP3kD3s9Mdhy4lgkHJ+nGhKEUyGxCyZjvpJMcyRZvKMid133h7LqM1cCATtyYIPxQHTwCw90ILItHjIBKM5/EDhOOU/XO7u0kGviqprI0Ew2M2M1ZhCJ2qDU3TaQg2sCIr25Noxl04EW+5mfMHcr9+4nn5Rjo5FS0m6edc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:48 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:48 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/12] drm/amd/display: Update function to get optimal number
 of taps
Date: Fri, 20 Mar 2020 11:11:18 -0400
Message-Id: <20200320151128.2039940-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:47 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b8fcd3a-9e39-443b-c506-08d7cce1026c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25725157C485E91633FC231B98F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(15650500001)(6486002)(36756003)(5660300002)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/wW/xMs83cjTZ27P+/nM2n+e0JNeAJItiOmTn/5EJ6RtvuJyuqjTgai4MStxyM+jgY68ijNYalaKQEoTzuYIx6u4+z5BnMYOMn1jzMyzrtYidd3KnPrWuC4wNHbvNRjp2R0vpCnOSfE3ldhlrnrhoOhmgOTuZrTu9ezMqXrt9qK+PX1yNwgtmaFkv6un+8CmBlIQaakVmM8OoHp1HFkig34m8RuNWxI92Jq3MQc0lkGzQBMqegde+9dRRm9lP1HRKcPrXXf5HDF+5T4TUwgiyPQ+y349LjLC4N2qEQo56AknFuqmQ0LpacFwj1nq3/DVUO1nlolT1UDNIhde2eDImTxhvg92Ib182SJD05Sj8m0btJ7fSYHlFjiWgG5pODBvkIHSHITjq4A+qyJL6A3PM8ZN0/4mUyMSpgSupo8Td1PwmrfJERwV6WvDlUKm6yw
X-MS-Exchange-AntiSpam-MessageData: L9wDq5/2Gj6K5uYxn60x66qZ3gOZAImQYyiAg8/BFkeYoe7gTooAvwTYbZzK1Z0kQxJPsztqrWwH7vvErHwT+vsDIBO4nr8Efp14kcwyTxeaSfIlp3jcQVVocpue47r10pgTOad+IeZmgfzAb3MqVEYnA3GzpUa09YMsQzUmiEk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8fcd3a-9e39-443b-c506-08d7cce1026c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:47.9123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iheibLf4wvlhRyAFK3Kcf/h1gu+ry72afxSAIlHEJ14BShrP5Q6ukBEc3FShajEvVmLD09SneRPtZ0cmMFg/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <eric.bernstein@amd.com>, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
Diagnostics scaling test failing to set required number of vertical taps
in 4:2:0 surface case

[How]
In dpp3_get_optimal_number_of_taps() need to use LB_MEMORY_CONFIG_3 for
4:2:0 surface case. In resource_build_scaling_params() make sure to also
set plane res alpha enable based on updated surface state

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 75c7ce4c7581..f4bcc71b2920 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1077,6 +1077,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	 * on certain displays, such as the Sharp 4k
 	 */
 	pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
+	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = plane_state->per_pixel_alpha;
 
 	pipe_ctx->plane_res.scl_data.recout.x += timing->h_border_left;
 	pipe_ctx->plane_res.scl_data.recout.y += timing->v_border_top;
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
