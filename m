Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D25C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364A423A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364A423A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC65C6E8F5;
	Fri,  8 Jan 2021 21:50:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86BFB6E8F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csngwYM1EL+sv+kGwaNZumRXMq42sqhwKLYs8NtSiNNXf8cLR7gMB/fa1jr9KFZM9ZbAa9aCug6VhfZHIwfAcsj3pgPcNd6o57Ek7GOAWnbs6a27JROh5GCBJJxbcmX6nRAc/BrV/rj+Jxm50odiOTspohHdf6e8lZOCcxyH5zR9SmF87kSQiPRVbLc5nJhWQmvZYYSoIWhmgP/pp0XqarAHv0HQ4ZNGukxUGdDcD3rK5eAVkkF4EShODJIhInGKwckhnfdQWOTdkabhF59hrC/NiT7mtKKkzD8Rk5GFmFH4WiyOHGrlA5RLaksUy8F/SRc193rbSU04hK9TYE3X7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYVq7VcBJh3F7Uvt7fKpiBrwPt2ABGnzrMsmv3PNSdc=;
 b=hI2q7cq5CirXUDtbkiFeY58Qz9/dXSfQs3i1fLG2QepKx92sHG2rvL3TX4POIwNUYndoArnv9evgoNtCA0i2CeGsiRXU89kGc8iVZKxXM763KhQ9RhBEXWYsyXz94ltqDeXz0pZYjSgCGzxhJ7UfSvhNeKul2IVTj2Pg/gVmKZipjxkw1Mcb8dZP04o+B3wbS0cQJTN37aqD3UTes02fgjb0BHmRksq6X9ZokoruhWJbnE6Sy+4GjFX7bhtkKAPCR6MIderNxfLiBXFCypMbF/W+7ZO0BFf2aW1UoafnM/lJFKsXzmRdEpkqtjFuFTAp5EffRj58uo6NHUIcN/Ipbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYVq7VcBJh3F7Uvt7fKpiBrwPt2ABGnzrMsmv3PNSdc=;
 b=Cqd5eA14m/coRp9L1M5oI2a2AKrJa4e9WHLhI9cXMleZCauoRDm0I90QBDtxAOyW3XuPh7NKUfA0bCuhrf8GWE5sqaM4RM/zCVqjqoOwUjox+9lXcHfmR6HF4TS77IOwsq5dRfp2rTTcOM8r/a5iiErTmwCXg+ViAf/0Fo/amqg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:55 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/21] drm/amd/display: 3.2.118
Date: Fri,  8 Jan 2021 16:50:04 -0500
Message-Id: <20210108215007.851249-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f6f04d07-cb3c-4fa8-d99e-08d8b41f7a00
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882AFB6B9155F8AA8B7FD9898AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Z68bxcXwvlw01rGtS2wyg3Kp8y0MYvmen7hV6x5iqtcjnt2D7/5fgx57ChgYENoKxlO+8y3rwf+heGs1hQn5KV+Rd68VmitwxZ6126N1He3eC6m+PVb+pkXmOFQwIBiEQp6+c7Ylq/IGh6QoCqKUt4Kp3PgMldTbeLmFsWFzBFFmeZR9pREgV5//wGuhLIp9Eec0y14egIXsdbLowPRorZ6xViPFcUpoZMn62XiFwnX5U8soq38kYkkbNQGN/DX8ydwDJZVBzJY4kFOW/MywaMO7eUjyM5TKM8cy5+THRRsRaMKZL3LNuhcLXNN2wbJjLm5+fmzjoJkn0iFfz1d3jG2I+0nN9iIJnk6DbXQVJBwzVoxOoPuya46O8n8zl/vs1sgcgF0AIhYnp9Fj6nVxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(4744005)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9HaZhrtjVADqZSAGMGWppfM7Ij9ffGqvWoxgWdF57L/SVvo1C0RQq4I9FGEZ?=
 =?us-ascii?Q?8RswbHGNFFs4lbXvChZyAezHV+Hn7DQSaynD7PE3kT5SHH1WvhRvTaupDs13?=
 =?us-ascii?Q?TlQyg+9NPhVa9HzXKuNPgMQi+AOj4ibAWkOuq3V0DPHjNSv/7rw+Xb8NmYst?=
 =?us-ascii?Q?PDIvUTcuVB8/CPY7gcP0OkiwsIte+ee78j4rEMWv5OQMGslZXlzojCj+Dz64?=
 =?us-ascii?Q?WDRB/KEBrjH9RS7DYZ6mauisBqPr9XYa8lNjgmwpEmy2m23H+/fFl0QJ24bw?=
 =?us-ascii?Q?dKOYs4+/72Mv5AP+NPJRZg8ta53YkG/GsaoHuvXwggkqC5oKLySEQnzSyzyX?=
 =?us-ascii?Q?gagijZsuHKTgxPqKmJVZ2PMZF6YmP93oC4dK9fbRL9ZEeOAX1AJQGNs9wAhc?=
 =?us-ascii?Q?lvcOtQtxLVohCvrioVvLp0iW+ZML9MV99bIquu/P8ygtiDeEZPl+yI4tE7wa?=
 =?us-ascii?Q?w/2v/SH8CkjQOQUovwEPyQaxV7nt1h5gur8yibRmOfeCWLPyzbj6e5SFRSUy?=
 =?us-ascii?Q?4GDGXcGxwg4sQsDGAhea17s3NsjQvg/kB71g5OgkvS/UVFgjXPt1FnExTTAp?=
 =?us-ascii?Q?M9OMGmjK5nN8PkRcsBcS3tLboUNpukl2FoJaCdg2PIrAurofpiRvjPdjbAaI?=
 =?us-ascii?Q?Vct/S/9fEo4Z8xMFVxpucTlwne4rK1R+sZ/WyapYsmR2ZjQNSt3NkxlhhqLO?=
 =?us-ascii?Q?XAvZiZT0VXR9JlwwZKEUS3K1A77gYRm0m+KOhhWvwtRdjFEX+SIBJwCvHOuE?=
 =?us-ascii?Q?TwjJSZt0WIioQZAGBSLWGb4az4C+Nk6icMt9DndGinYLLmGvHG8LIZSyEnrA?=
 =?us-ascii?Q?kAex5B/aY7WiBpE9OKz/uilWtw7Z1jSTxE605xAppRs3avgrsefKUHzkoCsY?=
 =?us-ascii?Q?BoB284w4pMa2vcWeiNX5U+a291WitKMWJ7FNe2Bwc4zxvvG0QWrSapz4BYeS?=
 =?us-ascii?Q?HkVSF+iTsdROOX3cDoqVX3srad+SJgjP/fOaRhBx38ZhuPpIkrUXvrVjeJbT?=
 =?us-ascii?Q?SoKNQJg58ixxIIzQ/8yQTfc8Gtr7YjbUHJcpvJrSFe6k2/MWns9vwrsDVX8n?=
 =?us-ascii?Q?iMwON4D9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:55.5277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f04d07-cb3c-4fa8-d99e-08d8b41f7a00
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdWU/ZtVWmNSwHBXmlimdp87JxvtMqcfdvBGNhX+ZYHZ661b0vwhn9f0q2xaBK2IsS+7FXyK1zUvZI9Vd8DQNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
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
index 3737fb9802a4..f3ba02cc85d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.117"
+#define DC_VER "3.2.118"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
