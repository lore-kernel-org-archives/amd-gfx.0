Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC47C43619
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E159561059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E159561059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1BD6EC87;
	Wed, 12 May 2021 17:32:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78526EC89
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxcoRj3z9mu/28rxqr2B2zqSd45dMy/2tCXxLd+P07qpNRvD/qdXj/9ZRLkgnkU525RQ68a62ybCF3brXEWApBvoplrByXyP5oK1MHLYBFBCUMm8RCQKJ46nZHKbv7c5Vo7G3/j9Bepi6J8vlwMP4UQppERk49NqSeHZiUXgVctMDW/qs9yxmmbhro2a+DGYyGa9nnUHiDhnTWZ9b8FJlRQ6/w7ytFEtitjVXVBmbSNGfPTjilR3SyKfqHRgunALDqV3eYnBT1dJTWavEfQ161Tcm58Cs6HDXhnhe9sFJt5+lOQg/wV0OVUGutyLDkpG9aj+y5NErrIZp0/fZSo+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKfY+RIv0nMVPwsVNhYuN43csFxhOFQ2avd0xPb8NFc=;
 b=akYIcZLHlGxD8GGoZXU4fa3u+nRgwi4dleqHDLogGTUlS5UaPu3XzOl6hXOvCQxCDK84WCC4r0gAPbcsL6/U4snV27JKzvlF5IhdKlM4Zl4mw7lsAhhrSy500Zode83jLDrlR9JMhr+BckhcjenBev1n+H3dk48+os6je2Qo6Lb7iUCQw81zCLCco4nKYOyQiwFp/JajgLnXZIrXi6FtvB/xt0Jl6f2yV/gMAltXqdMBdntOftdeunaV48is6/m+kt0S5h2pFmaI2ujxSR0PMCQxulHbSlsT3wnLkVgF+x1IRO0wrbo9yAnj1s3i3mH8EzZA+gBY51s+w7+X58ZmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKfY+RIv0nMVPwsVNhYuN43csFxhOFQ2avd0xPb8NFc=;
 b=RG6SbcsInTwO2uf1UJe6d+a2Uo7PcxNtDwyanH//lCfzykvjeBD7BTJz7B74GiG3yVyCIuR56tNGm8GxFEXicCXn9OjwwHOqo1SCU6REjbAwbN/ttU+h9X3qVoAPRyVlhnRx0RyXwUTXM9cVqY2OFSrHAeaOofuYZfN9JI+99Xg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Wed, 12 May
 2021 17:32:13 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:13 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 49/49] drm/amd/display: enable idle optimizations for beige
 goby
Date: Wed, 12 May 2021 13:30:53 -0400
Message-Id: <20210512173053.2347842-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ac64af9-b5bb-4219-058f-08d9156bcf6d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4567312B61A84EC6AC4BDF7FF7529@MN2PR12MB4567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8Nzehv5ggjETf5Do+R0ounTUD+azRq8mZ1+pIOrya18vllNt1Ax277c5EjJxtENvtFwefSOLRD9GaCcVLRe48COsw436FVvmtlHoxkClRmt7qp3kzovehAJFxUv2XrO4z7Qp20XKUjWn3JQlLhfWPOdb+br9xfkkinIMSdULfR5M7ReKIpCd2ut0PK2B+glqDrmMg8v00koLpvkwpHB5Qpt5LmNyiCd/T7Lz12n/FnWxjjnj2XecJqQjpcsAJyt7qLy9DlArFvbtvqbBpDPB7kuVWLLm/NMkYwGS7qPQs+Jf8i85LbmKsvPNpzvDWu3WNX/OF2ztApzGSVJmi9xCi6oX0QKcbNwdLETzZVXqK7+3nIjFlLyrClUXRlYDdaDOE4mZp83xPk6IEBqkmmayvyPVp72XK1BI/YgR+dYtOUiF9GHVywGTTmv5IZjp6772L1Yk4/cAn+g8SPH/iatgyVbmmvIaICKh2xgC6XRE2IAq8WIhti51pMa89iNWpkD06eybdXxamBjheMkXMUK/mQ9to5NcZg0kod0Ji48P3Jz9WGWzpCbYNuGA/PMHzyySJXeOcUekvASsmpGQlLM0DEz5VC9rFHkeSsKdRRdh7MpnUAA0q1ty8A8npgg1KAolcwxeVCs9AwuQS/YUOHls2pIfj2oJ7JmbqV7zRSUNw8/z3rLBgbHFiA1s/B0bMPy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(316002)(4326008)(66946007)(16526019)(54906003)(36756003)(5660300002)(26005)(6486002)(186003)(38350700002)(66556008)(66476007)(38100700002)(86362001)(6916009)(478600001)(956004)(2616005)(52116002)(6666004)(6506007)(1076003)(6512007)(2906002)(8936002)(4744005)(8676002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DQGb0AYK97Y3NWpS/FByq/7EzLNQptxvtGM4mksnw0EmXNuVxeaseCCaSfPX?=
 =?us-ascii?Q?vCDoIMHTfy0W8GefyjuajR70SMnysHuQhgrBX6Rsbqry7+o0gj9WNddOh2Z+?=
 =?us-ascii?Q?mdwfKUFVfXh4NLn3xDRwXY712srlfWrk4cqYpbc2knSvCQh3ZJdagNUkJBRo?=
 =?us-ascii?Q?8Fna+6etENNnQ7mOFy/Hm7kUTx4JRGnPuiWDpWs74NL8KQSFA4n9HROtl96r?=
 =?us-ascii?Q?vv5WMR6m7ICPnazEi3lW/HqsaLQre6TwojbkSJVG9/cPU89Sv4kZfqRnj2cw?=
 =?us-ascii?Q?5ZGfFJE0A1mUmWBT6JUz69tecPD/xYI2dJXovkVG5OCyRAdLgArfPAZTLhNx?=
 =?us-ascii?Q?O8pZOi6CJ+2QmJK6/MuIPv63k8JeJsYigbmw7GIvQIzqiQ6cXwjDk0LONmMh?=
 =?us-ascii?Q?dzTU1EuqkIYPFrI5JUCnJtBNsdUalxpWXAJ+66hqnWREewKV9B7AlEWFUQ12?=
 =?us-ascii?Q?Xh1lyEjjnyXPfFPD04pX6sap4EZfZt0Jcaxkim76IjLdPSmomxvY5O7mrE3o?=
 =?us-ascii?Q?QqDaogD+KZMhSoPob7Jz+CsuC5t9f0P9NTwDgzzf3LXqe4nwMSCUGM1Zra0M?=
 =?us-ascii?Q?ZQ/JFF5/LGuXfu0pO1ppoQfkc/9cTGIVCK6r/hbOkRhFETWhLKA5zsy16jw4?=
 =?us-ascii?Q?joM5UGokHMyjSV0kPuaMA1Xgl4bu+EuKy9TQvOOaQHURxg2hSmcL7WEopOyI?=
 =?us-ascii?Q?5bG8WIUPQ8KB9c7DLznOCnanuRjXvOHSQIvDvEP6rM+WsxNsQeEBj7p7Csf2?=
 =?us-ascii?Q?+SZx8uuQ+fGgayubt0e4Vltzt/LrgiKqcd8R0yaBw2cYGIA9oeRMRzcXhaBM?=
 =?us-ascii?Q?IHuRQTR7/VJBQRTUrDAxOd+1cyCybP2G6LFtEum9gGSDw1xUwiB7ha819PJ6?=
 =?us-ascii?Q?AxoYiRL0DDZFfD0OnwN/gbjnDxNvtBYS4c4zBtSYTNmbr6wzIHkUGIlW1huy?=
 =?us-ascii?Q?HM0sq+KUiLFg58TNr/LiLPFtFOIVUhOg5uXGlQ+NCIWQRKTDRQWWegv+PTpV?=
 =?us-ascii?Q?9Jio2NQ+CnpeDtauWtci7PX17dXe5ETDEBFwHWOElVvXhFwWFOGy7jCA70WI?=
 =?us-ascii?Q?IE5LfSVjNQ953Wury1Vf9XPzSyJrecArNhHpZHaCExIROnGVL5RW1tyHitDK?=
 =?us-ascii?Q?43f49DJyqzUxezzjPYYafOnSAAgtQme57SqMZmI2XGBNsPscO0awx/imveX8?=
 =?us-ascii?Q?gsisP39xZBqMnYoS91TGV3imW5PTTbUdlQ/K0eb9Sdw8vnbKqBOgqsqF5ok/?=
 =?us-ascii?Q?5Rr5T6ggBineQxCoxwMiV0xRoSqkh+hWvkAGQPvh/CwMhqGQundCw0mYswmw?=
 =?us-ascii?Q?FP5OpKJ4fOpww4juKhVRtgyv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac64af9-b5bb-4219-058f-08d9156bcf6d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:43.6433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWX31SiuxmyKIjI5QLHGwbq4TL1nXG6e3YXqaKP/93hJ/+5wNQqrOnwC68+TtxsDi+0LlXOkLpSc2gGly2tXHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
MALL requires idle optimizations to be enabled. This enables MALL
feature on dcn303

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 5bdb01d2095e..aff0230c9193 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -205,6 +205,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.dwb_fi_phase = -1, // -1 = disable,
 		.dmub_command_table = true,
+		.disable_idle_power_optimizations = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
