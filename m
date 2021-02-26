Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A491C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 07:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89DC64ED3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 07:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89DC64ED3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 335CB6ED82;
	Fri, 26 Feb 2021 07:42:20 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B7B6ED82
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 07:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIQAwDn9ynjf42Hm0dn8i758I6HSfOszNyhQ++07/BrrNfTPfidBDJXszdUo8/Wes84vanDV7NjQAbkh0/OcEDevnrVHpkkoX2rXgYVdqR+j9eyUp1f2SBBn+DSlidsk3HG2URlhr2EDO4TJ9rqdrSPxeibgbhj+NC4rz/n46XPZNdBq/lt2hFJrmJfNe8jSpPzZ094wO2mgBRZt25bxzaxGsRdC2VyGBQjhJwvgG8CurLdKkwWXnVUCvAp+6rlzY/yGOCNimkHmGbaW5XAUezRlUYNUN+yAeNxaU1eT36mYkzTnxzgK01tYP0XhsEhdzUnfBJtp7yZEnSa/JvAeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkkwzQtQzJwiO5QcvgP4FDraheyK4WrwjHOm5db2weQ=;
 b=oUkYvpcbj27WBygED3H4mAqFErTiXUrYw48TgYntIeB7kb8wiY22qbZKgpdzn6Mr0scJFPvf95Z/9njwF+RdCGzHeZUleuuJi3uafaiHaDl1HtzIyct88uL0MIyjCtSX+PRa4guZCorTZ8BoEgyfXRdW6gEaQJbFbgb39+lIaIAzWpVjuMMq9Uczc/1F8f2mUQt/OK1K0qfbjbAoV0m0tEmYaWwbyZ17bJhmZJX4HWkAQkpoomGjTYUO4y6boXUDfCHe8xFno29tEFrkKEl3TmMJ7ssh/F7Fx7X7rvSDJaoDvomvctIjdN01Am7mR5Hr0oy7HrxeyKTnErOvCYzkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkkwzQtQzJwiO5QcvgP4FDraheyK4WrwjHOm5db2weQ=;
 b=FlkYLIFLlPx2SNUOyyySoX2x35YRGCPPpc0RUg0/sKM9Ql05g6it3HU7ROdZ8iRmdU9RfKPoY4ryHEj5+9cVh4CJmiU1HL3OgL1gODZeNxz86GStQauFzN1aIrU4BZ91cLHWsgIB8NrYTaPdZCH0cXrQSh/RXWmpXEo6rIdAlOU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.29; Fri, 26 Feb 2021 07:42:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Fri, 26 Feb 2021
 07:42:16 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: correct gpu metrics related data structures V2
Date: Fri, 26 Feb 2021 15:41:55 +0800
Message-Id: <20210226074155.89805-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0058.apcprd04.prod.outlook.com
 (2603:1096:202:14::26) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR04CA0058.apcprd04.prod.outlook.com (2603:1096:202:14::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 07:42:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb4626bf-7d83-496e-d9fa-08d8da2a09c5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1451D1F8E2893E0C3F78688BE49D9@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/sKNY/ooKkGMHDH5VL+nZonSheBu9bbd8f0eR+Rnh8jFNsbhBgOPCSuPhLSLWzmvbZaBnmdXkK2kgZG/wPWT4+MPpdvWGyWI5B1HhXDiuoI9WG/RrMVIcEZoIpVD39R+2mqQSf00fLll05A2RnoLCDhwtUmMwuIPBiper/CDDR2KHo3gmn5xdawvuj2CrOr0LFAhzhYDSCo3dlQGv8oUEjCQVdcViXKKOaXbr9463rlPboimnkyWVTuGSZuFmtSxfyw1p2lKcjxyj17CdRfxErb1xyf/XhM93jW6RCyf7WT8kBbfwRpBaGXWl7/mhvrw5hCHlGq3ZMfYSbgp+SBRr3jU7nNVX3YHamatzSE+BfhaCq28iJfibYWRpiwngfYibzaVtzOibTjcZjgNuzY6Ty+dNDwtFte3RiLBgbMt1pUc6joraTegCe6vBeoV0jsa3dZKPQlUDzWpmgfRn1e3i39P788elRKc1B6iC5ID7LreeVCxMgKzTLLh6k/MXwvEEaHea5Qy6J7+dadoGEFhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(8936002)(4326008)(44832011)(1076003)(7696005)(6486002)(956004)(2906002)(52116002)(36756003)(66476007)(6666004)(186003)(4744005)(8676002)(316002)(66556008)(66946007)(86362001)(2616005)(26005)(6916009)(5660300002)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GcIeah+A6yeAQp8KQAUxl4EHCnJeF8eNRLah3f6XX4DStueV6mCl1klUBrQy?=
 =?us-ascii?Q?YWwwJcHOy/u79o532U9vAw1Zrq00tW4Tdeb7xHGfYbj+5XN1jWW/GZsqW/We?=
 =?us-ascii?Q?X7IKXgxb8z1ZRqDgUoK3HztWtbOaZ5gLNh4qaakj305BJA1NAEl9w4JIBZa6?=
 =?us-ascii?Q?eZRaPGwci6hvVfu7ezRfmaiA3DBDWLuHljNmzhNmbsmPold+cHwqWL45tGFy?=
 =?us-ascii?Q?7ZfxN+m0Yk++g4A3Hslr5Ihn3nuMV3PyZyhXaBCI0nJna17LBOrYvHs8vsg0?=
 =?us-ascii?Q?Qd4VaseOHY/kUeA9xjJ2PuMW9OCtLkH8Ph465B1MhMD2t/mbQHreiPW5vjRW?=
 =?us-ascii?Q?VpVRtI/TGInvOE212Tm135vSO+SBuuem1s3ds22kegiiDbdhFfIHZbbc7Nqb?=
 =?us-ascii?Q?DgP+6TD8BG21++jE1hP7dkhWBh9pkofmRPQs8GPzD7lFp9KYNxzFgBHs128E?=
 =?us-ascii?Q?JSgkgV2mGfKvFcgVugCf7zwTBu5ZGKr/XqH7KwQctGS/Z6YdELPlf5nfGAhD?=
 =?us-ascii?Q?MKBhq7G49csns4E92Pw+M7iFIPyZ9rnySvWxkXCN1ZzNzuwF5/+YF1rI3zvj?=
 =?us-ascii?Q?o1SfjVUAzHt3GtuVavPnTBFIyFHb9m/0qRs0Rxwh8zkfR1WFcVFR5odjLs3T?=
 =?us-ascii?Q?McmwAg+UDTOmIsin7OmqxknxnruzZX2wMYvlOx+RhfmDO6tw9FWBsyYIcPyk?=
 =?us-ascii?Q?iCb0pQju8QscJUorRvGykv2sOv7dyOKxRiW+ihGmnZFxs94CH20WCXndoq6x?=
 =?us-ascii?Q?jPcS+U7eQMbP2Ag1rnaZ8KyzHgb62UxwKaJMiAsUTHPt16jpCLxLM16MLpik?=
 =?us-ascii?Q?xiddVmwb7EPsza0PwbPuL9VztMFQqvJMUyYd6BG+BlQMwR4VPLs7g2TmYRm2?=
 =?us-ascii?Q?a5h3YVrwsSpzLcfFx8C1NboV7hcBmZA/TliVCY1Dgpc3/oDamy50Cfk0ty8m?=
 =?us-ascii?Q?JWyX5SLcJDUIclIpXU+IlJ0QlI2YEprU9rzZb3qKD+tgk/6Xmf1SaD/N7W1G?=
 =?us-ascii?Q?WoxRQC1xPxfrKNMUvyfP83lIR10FLLsHxeK9DmkyC2oYba4A2yMiRmYqVb7H?=
 =?us-ascii?Q?6hekS/pnXDuYBFHpNUAxArdEK0aUJqQwGvoz4r9DxxxbyWU/04sgSEZOonQS?=
 =?us-ascii?Q?P3Hd3PHwHYVrnOzanO92Mx6kE0iWKCmpvKcf4GCA+A2dRxMsDXR+ZDKCX3Rl?=
 =?us-ascii?Q?P//yxvC/YC+mnvlRZ0HL/IZ9XMAssH7utVysd5496z6Hm7JoOvTJk2Qq+C47?=
 =?us-ascii?Q?uAKBj8vpOmkdqP8MD4toXJD++aO0BSVJgIYGEK5zXucgwoeJ28riWSoRKrwD?=
 =?us-ascii?Q?cXbU3WJBZNUvpph4pF1XvilU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4626bf-7d83-496e-d9fa-08d8da2a09c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 07:42:16.3966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pg1tEe8Kff6yjra8P2CIosGQUZ+rqNBgFqpfABGUtg7ad/NaIPhhjbs6jVj3Lrlb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To make sure they are naturally aligned.

V2: minimum the possible influence to existing applications which
    were developed based on those data structures. With this change,
    only 32bit OS are affected while 64bit OS not.

Change-Id: I0a139e1e1f09fe27deffdce1cec6ea4594947625
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 41c89f7d6412..ca38a204beb0 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -339,6 +339,8 @@ struct metrics_table_header {
 	uint16_t			structure_size;
 	uint8_t				format_revision;
 	uint8_t				content_revision;
+	/* make the data structure naturely aligned for 64bit OS */
+	uint16_t			padding[2];
 };
 
 struct gpu_metrics_v1_0 {
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
