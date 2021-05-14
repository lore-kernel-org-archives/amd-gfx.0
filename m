Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0037EC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5E2611CA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5E2611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B55D6EE06;
	Fri, 14 May 2021 04:51:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643686EE06
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYxjFKUD+4yqaN9jtRb7upQ1+biBD1/NdLvQnQJxdAayG5xOwr5SYjmLAhCC/cw1HcxOOCFzfCV4IelY5UhrzbaDdkZn5lKKUWz3ns7bNUIIwS8NYISEwg+XqOR589RxYiJa5C1pW5OT5ZKvdp76FQ8mBhwwBFUpfI13AKgwdJRR+TtKr1XVnnnku5zTdmgKffVISAD1fJjF5hpVm9UOX4GScvi0nCHcYHhe0S2rMthn69VCsoJJMpFfdfxUcj4ExMdbIKYcnBlfz86lT6I0tznEY9YHTtkOnRWQ09YDxoFOZqIeEj14WtCza2GkcNqFK9GjOsenOxFvWU/C+Upaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPZe28Nc5suySwLyCrF5JqJbF3LqPnUO1Pf96Qady5s=;
 b=d0fD8ANWoI66LoDlomOODJs3gHnI4Fpf8TBXXY0OHHXi/cyYfIowhzkmZaQacxvWXzsKUn/SR4DdNZVZDXl02f/Q/raFMxAFZF9Y2dF6OEXvGFbovELadTjZH2yEYKDOZPDqzE1Nnme5YKgv8fPyY38OSRbU+wMKbihWOjgaGpcR7QNtNvgAzdxV0ejwmSNxmvIbKsAq7fkMWBLSt0vqkpxiddvIEfgqmAzN8WZiiCiBWP1o2S07uSc1kP61x3IZWfB2MTABIr+mTPaejma2JlLgT2KPeXEghnSe2ieprZbevj2XcfWNlub8uLzy4qJppaRn7tuADMfEnJfO6RAwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPZe28Nc5suySwLyCrF5JqJbF3LqPnUO1Pf96Qady5s=;
 b=wIn10RgN5MdMH3BNXGxnkM4QmQMGQpYSewpmrLgIACVSWoodjxSQhdXWlx6IxcWhRQY0uI2NbJAG5kMwLiY3RToxFsYhVYCJJP+S4wj5LHK2/dPlCUuZhr513TB1eajZw6rng2bVBBRKHQpkCmsD9SEMyZGa6Il0g+np/7ctO9k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3609.namprd12.prod.outlook.com (2603:10b6:5:118::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Fri, 14 May 2021 04:51:38 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:51:38 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/20] drm/amd/display: 3.2.136
Date: Fri, 14 May 2021 12:50:03 +0800
Message-Id: <20210514045003.3069681-21-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:51:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f79c551a-e2c1-4617-4f7b-08d91693f519
X-MS-TrafficTypeDiagnostic: DM6PR12MB3609:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3609D69448A7474B867CB338FF509@DM6PR12MB3609.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xj9/Pv1cAyXyieME3L0hKxJwSpzGhz0Rpn2xBkt9+2S/NZuR/pFWQ1JXI/l455Rvefv5fgiEMlMaqotvqn4KiAtr8UYm73nbk8AoqKObB6NvmLa2mppELYYTOJvBFHcYi1PfPzzpHSjGJpQC/4w+i9ndYEHRW2biCvgLCEn87XkGwbyUN+Ro/75JO6Uhw7Gy1dhzmzJ4mVC7JYeMplr6Wg581vsv2GCrP8NlCk+IUkMMvD7jko8IQE6C3xQJkHewTfyXN85j502qTE/4WvM6hKPmj5q653N9dUa+G+3vyrS/avfdpmfDaeBd5VhcPL/l/68WILx8LtXmn+ZGvs1bL8z6RgO/B2i4Qq5w39vAAE8MQCNhJQnkxou3lODQQLpItqSDzX9vzOT6wXk/FfVEIvroiR5YocwRUc1dqTDN6W0I0AZZG4yCtMP/J2gfcBRZ3bm61d6bfyRaHx6t7uTS4sk99ZjpH1MTadVO90ME73giRsHDdbK8eNi7lFTFnY75tw49IV6tWb0pXRHS/xum3WrvemrBD38SXrTLm80tOT0ggLc317Qft15bh97ngbjs/CeEnJ/GVin6EWogJq4ViHeSZT9WcHGl392xWQk96WOiOpmPZFCChQXk3nLw/yi3Q0oUcSlOOXmj72hbWF10ftpvKYS/B1aWPYO9mYBdnGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(6916009)(38100700002)(4744005)(4326008)(26005)(186003)(86362001)(36756003)(16526019)(38350700002)(2906002)(1076003)(2616005)(956004)(66946007)(44832011)(316002)(83380400001)(54906003)(5660300002)(66556008)(6486002)(66476007)(7696005)(52116002)(8936002)(478600001)(8676002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lBGKkPbcdXwiw3jDIjav8Oudw+OrftPEkFxHvvDelFpNxwbxr7IQA0XshEvP?=
 =?us-ascii?Q?U+7KXbtRRwO2400dU27VM228PNpxfAubbKVfNy8iHL1l1BvrAq9Ug/Ckhu7E?=
 =?us-ascii?Q?AMiTXUiu+v/EwOI33Ip4Cy0B8VYrhwozy+QfqbVoovOpxYGnA579oDGTT7t8?=
 =?us-ascii?Q?GQwhazrhiDkPos/J6mYVxkrpwsdkhFGnO3piszIEy9Sw/2FpmqoyNn2jUUNk?=
 =?us-ascii?Q?xxIB9NT7HEx3L1+RaMzUvjl5Ijm7RaXXVkd+ozCtMpw3NbNMAIxnBe8zH/P9?=
 =?us-ascii?Q?F7IhEt0CziQTjAKCxkCWhX6l8/JDwv7xlvFV+zEgLVuGSeMN6bbcpXLCBGbk?=
 =?us-ascii?Q?5G8KfltN8REk/dJqjY8ZV65YnwGoVY57feblPMBXI540T+KLW2mlTQaCXezE?=
 =?us-ascii?Q?UX8UOjifCmCJ3A4tWiYvsBiyYUrwsl6xOXEVeFBEz2rahz+QKJ/8se1tdFwN?=
 =?us-ascii?Q?kpYm4KEDoW2kTH1CeRoZ0rnyRL+HLQiu2LIhPoYH+a/N8JGzxczix+1VWZ7Q?=
 =?us-ascii?Q?eKWcN/dUrN07sJT2CqdWl6b3RbxOa5ps5hOD1mLbmEz/bqeZ9SswfNFMPdBZ?=
 =?us-ascii?Q?CV971OyskP+6Do2MeKpX6r1F3SBJCsl6LYfap+H3q61tI8YX/fqpk0+LT9/g?=
 =?us-ascii?Q?Mp8MNRpHFm2ulwn62dWvYIJVo8K4XR8i1lzKwp1TQCRjr4y/Yf0xBe8Spe5I?=
 =?us-ascii?Q?yKyuSd+oly246O02XxTtxGULPsmxMCkI8SwAIkyJY5u3KsZg8j7n5dG2S+Eu?=
 =?us-ascii?Q?b8rZRDy42Vzs1gIfz+6QaKgcQtkxhD6pC3T+Z3gHZrKRd/r8Vjl/6x/sUt1r?=
 =?us-ascii?Q?fuM7u12Adh+dLuxKmpxCezO1iFvg4lnLXY28AHMvI5FQz995i5Hh3mSOOvpf?=
 =?us-ascii?Q?I8lS0HLMcStl9GHryekZQB77mn8imwNZEdZWFN4XZZ77Ebn5jV8vpQR7v/Pn?=
 =?us-ascii?Q?OShXld464ZYBpSSyFRP1YfRiq2iaQjSQ99/5pIjL5n+qWyjS3vv+3JIcA85D?=
 =?us-ascii?Q?YrobieR5cm//OAZAHCUGEaUMo4nbh0IclHP96ARO16FP+gBlDlAYhVOm5qA0?=
 =?us-ascii?Q?8zGs2AyROMYU4KT+1OClQ9x6gVUq0HF6MpB0mAyVcSIrDy7MTzBmV1Kwea8X?=
 =?us-ascii?Q?AHGTBSZTQFM1hWqvcbusSpm6wun2a1l/zKoyolQaYTYpm/1IvdK+CYqc4ozR?=
 =?us-ascii?Q?QEshZLK/j2r0y678NkECoX5S6nFQmfYlf5A+KoRDsEqwfGc9d5Gc9t7V57HZ?=
 =?us-ascii?Q?vla9aCEoFuYWAuc8zJWy0hgDKr9YzOk/+P5cDG97/kDGfjmI8/9PEC37mozD?=
 =?us-ascii?Q?cJQt+IgjgImQUp9yKQDyUvrIyCGR2tYCtJausYwFbpZtDg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79c551a-e2c1-4617-4f7b-08d91693f519
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:51:38.1304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4Whp/jpmuEjYb1gi9zxVsFP6PjwJlT28/qIYJiGszqvuur5BBD86V1pl0FyjTK3T07eM7RabjgdjDD7PzPA0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3609
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 63b61468898f..7da5e7a2e88d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.135.1"
+#define DC_VER "3.2.136"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
