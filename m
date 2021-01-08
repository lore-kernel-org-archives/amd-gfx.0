Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882BCC433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4586A23A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4586A23A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70346E8F7;
	Fri,  8 Jan 2021 21:51:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D4A6E8D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alKbeOP+t2+wM3Mf1HsA+MRYKhB2fYYkkTIsD2ZvLeTRso4EeYysoCF9A4pCO6b9bFs6qhvlabdxneNmEU/AzfxeGQRqu7L4q8X3SsbvNqZyHr357f5Pdre4aetS5rcAcXtcuFvz2yB6EAnGyLQDb1Iy4ivmvLAgZ8Ud+MZvLNswJGSEg2paKXdGEGxuMgXQTH4NBQyfDdPIySUVga6l4tEOKd7sQirNfeDxKnP9huQwsW+AjGcokebnuwqGfYl1x81l70ZzNaC5LGdEljKaVum+rFeQj03d0m+j0jblLNjKY/q8QQdMo31wAj9ZQpKsfyhMBAYLYm4J9+t4QaTMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EczWL0NLh0pC1t0eaadpSaZTz4qRawfJFyEviMr/BM=;
 b=M7y5CMAvehecd2iQRjy52hiwknx5vvQYS/34Kmcw9d1RG5J6imNLVG2yJ1qkWx0npmjNG2DbGcs2/MI4ye1ZvHuplFJWWjfaUMIl2n9W76hznAFTj28eeWJ7AORLnVn2f+9fpBkC5NrlclSuPjrTuqJp9KQYgNAtu+luAjQxD+7/hcxSj6kiRg1B6JE+roqiiZZR8w7UVuUKo2yyvPeUI8uBk457R0fkS0f3/WcnYNFGQxNJocxcGQ6imOikMp1z96rqoGCj/n7ElHWS4n1hEWEPQWtnvegiFaMpksxcPtyvc27zeYe6mLzmYVr7wlnfZnfybSiH0k8DGke/exFAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EczWL0NLh0pC1t0eaadpSaZTz4qRawfJFyEviMr/BM=;
 b=WwlWk0yYJOeJiSmhCDphSXkbZJHOKQ8JlkhCcij/SJ6kQlZL3fnmAmz6EseWQW+xzLO8Mim3L+lRE5YDrmpGaclh6lL6R4Kk9/0ZW/xH7Tb029tILAolSGUhbXWM7wm3osGQNpOhaJYTYAjcQwnGY59R8Iy1nZivTexlpW47Uy4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:51:22 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:51:22 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/21] drm/amd/display: change SMU repsonse timeout to 2s
Date: Fri,  8 Jan 2021 16:50:07 -0500
Message-Id: <20210108215007.851249-22-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 8 Jan 2021 21:51:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8cc49708-ce48-46ff-7714-08d8b41f8a03
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18827AC05F447E521DF0BCD198AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BgbIhsN5NoesO618A9p0rF1yLs5/3bu7ELWyxyQoDAeQN9BK8e8J7x9NG3M2qr3upVmBDZabqdrlaXJSYpEZy1YBmf5E3uON7yKWgPi1zGXhDGXymeYaBIUlif1082v06YKabX/DoMeYK2nFkwEg6LM3V6JAJzbsBEuwwibQIjLIxh6twB1SmwkZvwpCwoVjwIbU5dtGFbxAnFDezY0XuzCZHAri2MCxyApwFBSm020SWmuUhLOtuPZV1gW26LWvPYpVIsTNeepQFRn+JnlVfw0c68Oe6OJUhBWT3RX+tMZToMwJrCxYBqI0klkIMmVS4bwFHM8Hj0VjDhWtu8JyYymSUEZL/S/Yme63rFtaurCE+MFIVkaHkC83xcb7jzierPXfmA1PGqX8V7UbHGppA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dWBzo3LVO3CfM65Lq5dHNl6L5XI0elirOWH/LZ9QRLJypwOsqXW/IuX9303E?=
 =?us-ascii?Q?rrA468U57o8fPihBofY3XmEbyekM5PQXyfncsr07Rz0tUsZFXvKkPOXMcoSZ?=
 =?us-ascii?Q?uynLoKhhrQSvbgpUTil9FF1KpTx8ueqlBFnbEmV99cjfmUJVaCN2LEOdcp6U?=
 =?us-ascii?Q?bOrCbyRfo9nVFMVMncGqdYUPbf0zTPMsRKlXneHDXmcCUATRIQRnpAjFfkdD?=
 =?us-ascii?Q?B41FoXomXg9gBnj6DxeWfy7f19oL+cOOQIip/UqfUnFsk/NADXbm2ZaLlR3J?=
 =?us-ascii?Q?60TWJKZW6/xES61ADcqGpe7js3J0MPD4hkh4EV1+0HgvKkze3+zxqA4KzIFp?=
 =?us-ascii?Q?yoZB9Y0SSdrquv8krkil1qKxNFtCSunHRt1YWk6Smapj3BXrf0vsq6sCXhTy?=
 =?us-ascii?Q?JH4Ws6X3hvcqzAoNkQ8y9CqDVIRpCruXWqg323dV9MsFHYr1TcWI8Xh6LxIt?=
 =?us-ascii?Q?Ud9v8FDQvdiic+mdnC4VkDRWvAwPjnVFYhIYUBAQIVdwnlG6wm0coxiNnr6g?=
 =?us-ascii?Q?MNLIEFebhqepG696mC0TPsWAxvi5j0+8/eP2jHnDDgVWwcfDvQ5+4kOR7oaw?=
 =?us-ascii?Q?y7HHj0d8Z2Sq+NVGoHAUzobxRtvIBA1257EtnGEpkgHfUNsktmkQGt9Ox3fl?=
 =?us-ascii?Q?b0w3cTPKQxwTNA0f44sj9YLZfrwNXRtC4OTdZ6qvI5koeVeFaaVIAuSgXIGF?=
 =?us-ascii?Q?cZodvrwgPHuM45xYzK+UG92QXXmZrlCnDVFf5/HJR6g5lDl4O3+bCgt/gObG?=
 =?us-ascii?Q?1qPEgkRXmK0o5+yBqYOZDyPyLAVHT6DOnaGFhApMF56ov6yu9WOjVYy8HYnw?=
 =?us-ascii?Q?T5L4nnND/TACtkIBvJWUOkRGM/IsNpPIeaIfAZKy8R6sLKKjr0cGiGDPR36F?=
 =?us-ascii?Q?NBfWI2O8hxu2kUxxtU6mKBzDrtP5LwyqIxLQ7T/a1ZgroEVdhLNHwb5xzzFg?=
 =?us-ascii?Q?5P0iGuta64RxRFN5bzH2hwfLsYrJ3r/thsz8ZCq9koUGw6XWR4hqTQE9itq8?=
 =?us-ascii?Q?/PSBKj4qh8lxEobPftNcjWiAwQ67BD+5dvrH3U2eLc5geDQec0+K46JLKSX+?=
 =?us-ascii?Q?SIEh/vEy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:51:22.3534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc49708-ce48-46ff-7714-08d8b41f8a03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhs31uxPqIOcYWgbb29jC2w8N6WFEYEVa7QMCaHl4comh5I4IQbeAIaRNz92lGtqXuH0yAtKegObzh0YSnd2lQ==
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Chris Park <Chris.Park@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
driver has sent PMFW VBIOSSMC_MSG_SetDisplayIdleOptimizations while SMU
still processing a previous VBIOSSMC_MSG_SetHardMinDcfclkByFreq message.

[how]
same as RN, change the time out to2s.

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
index cfa8e02cf103..68942bbc7472 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
@@ -103,7 +103,7 @@ int dcn301_smu_send_msg_with_param(
 	/* Trigger the message transaction by writing the message ID */
 	REG_WRITE(MP1_SMN_C2PMSG_67, msg_id);
 
-	result = dcn301_smu_wait_for_response(clk_mgr, 10, 1000);
+	result = dcn301_smu_wait_for_response(clk_mgr, 10, 200000);
 
 	ASSERT(result == VBIOSSMC_Result_OK);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
