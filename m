Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E58BC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 11:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4060A6113B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 11:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4060A6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC356E0DD;
	Wed,  7 Apr 2021 11:36:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4151D6E0B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 11:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZenshrpT50S9LIXzU2lmCZk8hkxcai4ZLWdLWCJWoHnErgassDQfGJtpe306dNGAa4kD2a3grRFOB7ZowibbG63/8L5r2AHpEjZ3bJ5hWJ6N+gQg1pleMAP2usghSZ97QttlADR3S5pqZLM4COEfpTe75X27Wm2ziiVOm/WMP8b8Zjok5lSviGD+WqGqcmEGIybZRiNmdJMTHHyqGRb4sBM6McmCScuKQPiAE6AuywQR/0CbiHj8hhnssFA3iCdQJlX09ugCjKrpWWkXSyadNkrFo42k1wX0k4g7fVWe1mcd4UcoRwUSVr5I16g1GAgjqxEifI99901praqLVcoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s9ZPv5rbx1Gva41zexErCHEVD2kjbv0LePlOmuoZBQ=;
 b=iYD92ifV+NjAhQx2O3JJUomzuBt4f5/of0xK9+YaSCiPdaghOpLMt9alWBJSMFomtyNyHcQGLuprM52+SOjw6UJUyb/7Yy/Mp25rz5Ug/+7UlC55VU0dtRBkWfOLX9XUoXoHwszQHX4/VyLU6hndJMNTn9oYOGAk80QtQugxSfQ1US1zZ7+LSbyh17DcxQrOHjD/PmWeAqkVIwCEkwlfoRIKa9qNwzBbpl/5UT+28DJG7ufo9KXKU6kLVZyIyFFflafZV1TUBem00cbHlyiCHwLwvPe8METqHhZhkowQew2bgu6RlxQZcSDKXOF8zF/aMm7AGGGq//bgFz9ZjcX8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s9ZPv5rbx1Gva41zexErCHEVD2kjbv0LePlOmuoZBQ=;
 b=AeQjM0SxiDO57CHbAL0N98/s5oQnaYaLKBSSTXRpGvriF5f+Aon6KOVzR6Os55/cKEJ0ypeyvfYZaHzC1jHoPg/VKnjl1ZZNMUrEQkQBWn1FasxV4u5CVJbKkojUWAzyR1Hn1ApnMasqWWK7ykpuBe7DH3bRo1gi9hJCWyXl7mM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23)
 by DM6PR12MB2683.namprd12.prod.outlook.com (2603:10b6:5:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 11:36:12 +0000
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd]) by DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd%11]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 11:36:12 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix size overflow
Date: Wed,  7 Apr 2021 19:35:47 +0800
Message-Id: <20210407113547.1746-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To DM5PR1201MB0057.namprd12.prod.outlook.com
 (2603:10b6:4:5b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR03CA0050.apcprd03.prod.outlook.com (2603:1096:202:17::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.8 via Frontend Transport; Wed, 7 Apr 2021 11:36:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37d57cc1-1d68-4b7c-9c3c-08d8f9b9581c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB268347475D4AA72021DB031087759@DM6PR12MB2683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hFdKDpF5SB2qXTdwDWywTLREr3SvlPQXcVEeHCmBcc+8DTUTj1GiBJ48itRuTmE7mT1/ITYoX2KiqWfe6y0H0MWB0ziPu9XvIwN0v6UaE+7yYst9hQ7dYxZYejBTlXDvH+nvu3gf0zYqIxUxOsJrSJzgb5RDvjjCmTat+1O/3fNnNjGZ4BVCyLtatd5tLVPiSfp/lxlF7hAMXc6x2ivrhWxGO4j4xkVv8/BfrBX0+KgG2RvTCrK0v2mbtzlFMENp9lq8yjC8CQQ+FVqrdHvRxY/oxHfNjXn5da/s1pbDM2lAiXLNMwCKP2BYgpAU0qKRvb9qMLC0GKqlk5XPTUzOfN1Uw1bj68jmtYvk0GRa6iOAVirnw4peul2Zv5DxfF0CfA2KZ0mLee+LuKRufHJG9gpa+SMrXNneMi4fLcF3UccMW5Y2VjEKhWGqsFgvQe/iRyGsFYirob6sGzQ5T+bPw2MpC/05X0i0J56xcPm42p6Fl3J0CnfsJ5tDMR8QdsIIfxAdrR6TMdUC/ymsDVFz/hKKseAw5laZS5MKPk87HmX6fU3dWXUZyXDry1SiXuY9T16agqu4nnMGA8m0sX0/tDuQymROgQF56qOhCvPJ+XZKvwVIRhVmfZ5ZrfQY7u+eYD3yDUS5npOM9HrEGVXTMKruzn2TCiBS/Vizpcf3jIjFVrxpj4SALQmMsJUEJKK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0057.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(8936002)(6916009)(38350700001)(38100700001)(66556008)(4744005)(5660300002)(86362001)(83380400001)(316002)(4326008)(2616005)(8676002)(1076003)(6486002)(2906002)(36756003)(52116002)(16526019)(956004)(26005)(66946007)(6666004)(186003)(478600001)(7696005)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uL2ljtKdT8kj9e9IIKto9ayiMK7nPy035f6BUsW5NHovHaVJphrzhy1Qt+vz?=
 =?us-ascii?Q?7jjZgENnPIeB0R56ng6/6hRt04b5fQ4hgW80gQXfnZF6BpmC/UGmrGVImQZy?=
 =?us-ascii?Q?iYjNwUNHhcBfajeNFTg/u9pbtOOoAzkBecRCgUcd2A7bT6MYkoouVRPCuHvG?=
 =?us-ascii?Q?ESe1f+wx8x8eQ3j3rn5HXfZ+odNibMuRTtZgQLW6reY8d859WfvYfunKbFQ8?=
 =?us-ascii?Q?OJiHQM8OCbKAMn19ix72jTIc4NaDYwA0bDjcHdek2KSS7FHfFlk4j8A7M60a?=
 =?us-ascii?Q?+F8WORHVJW5Xi+0PpcU3BDlO11liLo51r1VJgghKBmh4EOZofDJjGo0nLxOq?=
 =?us-ascii?Q?oTTE8XpHT8aHyc1lx8WgfoG3Rt/zKVY+iSBIJk66wH2uI2nXtPO6UZdSut4n?=
 =?us-ascii?Q?UlUrgiQ5dlQAQPdFT+u34KyOmaEaV4DXGJBqbETeUMyqCsYuqDcz8E1nUq8b?=
 =?us-ascii?Q?ELrMbkwgErbv29IIO+/ISorgLf4aFC9tr+wn11ZPs6vdzle5Skc3DRrSlsLd?=
 =?us-ascii?Q?wpl9apEsCRJlhINsXiwNefeREL5QYlkQWNKmJ32sKiclha/+m82vE+tn3fN2?=
 =?us-ascii?Q?zfBv00JfILp5XxTm+J7U25s6SwKOvBprbjYrJHzPfX+uTedQkvtQ3wNP687k?=
 =?us-ascii?Q?h3FkUmVvSOWBfw3p+JddA6y8dCDbq6sKnK+OYTy4cR2KowwOF4w5mfWW8ggw?=
 =?us-ascii?Q?DhTcVQHS3EJA4+TMLmi/1H9xeQlIGvUkorx07hsp+cUp58omtJDzYSnHkoZt?=
 =?us-ascii?Q?8+ziwrCsNus9d47+vuXfxclbEeTpV05cQEEWAMHpCzrfFkAHvFFHSnTTt6RR?=
 =?us-ascii?Q?Z42Otrj17/WkCzveyl0WefY3I/M/aA1nSbBzhcPz7qTlETEx01XqN/aj3ZlS?=
 =?us-ascii?Q?G2tiu1prLO0tLJOO4tHrXmGjUXg+ya1pn8L2yTQSmVzHw5WzzoxYnPVFNJ7F?=
 =?us-ascii?Q?meTh1O7KIAzas4iMC5W2yrkhf88B6qUnhagLsb16S0mKOGUf5Vab+JFdy5k5?=
 =?us-ascii?Q?+cP+izbdw+3y91IAhTKGB7L0DpH0VLZEd7j+KgzsTN71q76j7+pINbgJ+NRJ?=
 =?us-ascii?Q?0oATBEUNrcLiJ+haMcwjArYX4M6IUb0iVi+LKG6xcGOGOqqEH3dYOQp/uOQC?=
 =?us-ascii?Q?soxL48C4mNd+13tcETwKNp3V59kt+LD2vwx4ne943p+rqpjqvtnchrY/q3m6?=
 =?us-ascii?Q?Zw0HpzJ5nCmLiRS9jiGu2n3Go6d7722uO9XZTdfCtPC+6WS6tAaKYGs8RyGQ?=
 =?us-ascii?Q?9uJ46EiuXpS02u80+3dEGV1cqPbkRC78AE3xCah9rP5vH9Bdc4tEtU5Pl5sI?=
 =?us-ascii?Q?TuU1ndi/h9l8vYV6f96+K29s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d57cc1-1d68-4b7c-9c3c-08d8f9b9581c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0057.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 11:36:11.9169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81W7XLME7zSIoHbaMvMCoayfR26rV0aXD2DZ2eYosLLhjiDblyKF/rbTieqbM4WN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2683
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ttm->num_pages is uint32. Hit overflow when << PAGE_SHIFT directly

Fix: 230c079fd (drm/ttm: make num_pages uint32_t)

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index fbaa4c148cca..01a5c487505c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -830,7 +830,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 
 	/* Allocate an SG array and squash pages into it */
 	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
-				      ttm->num_pages << PAGE_SHIFT,
+				      ttm->num_pages * (1ULL << PAGE_SHIFT),
 				      GFP_KERNEL);
 	if (r)
 		goto release_sg;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
