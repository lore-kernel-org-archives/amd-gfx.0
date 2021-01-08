Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC262C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623D623A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623D623A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0197E6E8D2;
	Fri,  8 Jan 2021 21:50:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DC96E8D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev384eD3J0e8ZVIzO55DAtbENi2NTTRAFOcwAZsRVPzjvz37hRYdQms5Tmul3Ku62qLNe5h1BCiAvI+qZw4ZB4v0lSomEnc9F4Ziw956tBFjiTGbMXwAiqP+n/JYsWIjSsYyxmYuw4v46FOPJz2fhu/JrgfVG7AYgtoOBxY5i76+qalSA47XpiHpzPqjih6bDJDfsKj02SmvFSBSDRjpHPZkRSPMzu8yQnll2qJWVzundtokjFl54S2b7zrIPObl/I0JFQYuSV6MjhUmXKeC1JBHF09RYnKs42Ui4dt9TBtYaqhdNu5sGEBrosQGpDBDcvQdVJdPb1R9akRs1h2SEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te9s3dFsu0rMVop65cF7977SKnvyi/Q27coXDxVtrfo=;
 b=XrtWOGbONquERuCM5DXy5V3/gHqekSV4dy9zLtiYi1IC+D6q5zP8T5KokrRI4M/ZyAtoqyyAWfM8YsXvMr62/LajfszRkbJ62IULxZsc8Wz0pQNGF07kvtVsuP1oFUA0Xihe83F1vZiFztmilTZSfw+3wsxaF/g15EkqJpCoSGF/2+uBpnGqEK6t1E/PUk2eSCZ9THgCWinvb9HmIro60/C2t3aMciIZqsAVkUER85LoR68/bnXiq9LIvlEMmk0PGoZiFfu0sRS3AbkYj24JxkxJwiOrrSVIjWtJTSonmJtjCnnTvRT0VNQvOg0nJF54pbO1DWE+pdBFehIXnl6KXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te9s3dFsu0rMVop65cF7977SKnvyi/Q27coXDxVtrfo=;
 b=zn2T1iUVLjcUUqQfEcbBq42qOsbut7sSuGT2U4rkwlRI8XAAJBIJ9lNd0uwhjdCGDTr/CG+Y+SdyZuobWKOFOrUzXqNDM9ucuxm9F6s65U90Dzxl1d5/szmAtEv2MVds9Yhrbyq9RrExXwl0W3S2/BDGeXTSbgTXeLKFrXDBHoM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:34 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:34 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/21] drm/amd/display: Initialize stack variable
Date: Fri,  8 Jan 2021 16:49:49 -0500
Message-Id: <20210108215007.851249-4-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 8 Jan 2021 21:50:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16ebc377-0d27-4f87-aaa9-08d8b41f6d1c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882566FFA0E01CABA338B2498AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vM8nRNGcjccXo9SCR0EgYa6FU77zXBHmrvYkMHX0bD9n9K/1bI4C/C/LnQcqxUtsJFAszw2vdIsrgmvNphc+A88ta2EoqEHSPH+pCV2nU2XbzmRGeZv3asqW/7ftRGHbwi5YlwPL0z21gBTsLbxwpzC9oAVE8WkiGAtcKoO6fBGKCZ7LWfWf/UiAryu4qs2uxPkGKK5bszHI2CSVky4MEpJIAkMapeU7McsqapJT+OD4mOzZUWOXHe2bGzJQL6rdgYVh1uLQZ/nRBljlJQwBTalOIsnLJscbEtG503oDaZIq7S8irSoasXCkjq0WrV4vH8ka/o1uyPOVecQNYPgvV/zM9fdbMZ96GXtBIpZwmmi9+RC7GUJFp298H8VqMIPkHZz6nPDK6x+hi6i4Kmh4lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1UMHENeYc+iQ96J9n7oY6cJPXYQy2N+tQyV3+vG16a1dZx/pO2xMs9ifEdUF?=
 =?us-ascii?Q?vzRsz48NHK//LJB0m3dqbIAhrY3kFpN3wiz0ljeq93X+CFE5/CMX6+v7MTOq?=
 =?us-ascii?Q?m/zHQPTIZOc9ucjIwpA3qRLQ/maoiPqKcYIx3WVlSflI1KM+lOFpTwcKC8Nb?=
 =?us-ascii?Q?NBKVONVzvWMN27z1cNsmds2Bi82vxxJBlX4ESbHfcZIwbP8pz0sqxJZLh3j0?=
 =?us-ascii?Q?2L370nPKTxGR6gwd+fXibIJ2RX51Y5aFojBmbnGDrs43O2ZSJoLwsTnTm0z9?=
 =?us-ascii?Q?Be1O2WLrMU9BHqdgX6ywSKcfm0BqlBNj+JDto41UKheH2jViNQE7zm0N9O8n?=
 =?us-ascii?Q?cH+s/R+tS91URcfumEBaEvbn6vGzTrfw5XOdvAfXKeL33k/K4z7EHEPss7xg?=
 =?us-ascii?Q?Bnwm/LWme/xlU5q8rIjCSF57A8UUvSxu/0bGcDlgPJXkIK69FF0LU/OHdY7k?=
 =?us-ascii?Q?HFAL/2VjoV68N2BLIj5Y+XEDawN/mgkZsZdgl1zP/l68q7IjUxUf26ZlJjIf?=
 =?us-ascii?Q?SB0V70PxQ4n7BI9Y0v5Br04ppQWaSF66KsN6LBfpY+1oRjoRBXLCaNgOMXxy?=
 =?us-ascii?Q?rTTTXtdmLckmoOWbJZKhLCLxcPd7fG+xpF5ulJVapTtxWA1vJo0xh/8lxbWX?=
 =?us-ascii?Q?h6s5Z1HorO526pvTT3a1l8z0MUCRdjNt2hhcSVfh48KCM0esI+7Cx2q81lsU?=
 =?us-ascii?Q?aaLE0b1TvjH1lfPoJR+jX8S+Kwhli1/I6EhGyyC6/kXJD8nZOozpT7FJTF7B?=
 =?us-ascii?Q?J5Z/mbnTSopwqEvzQ+PBezN7zT9/f+yag5s3CLxEalM6JbXwcxqvMRGXLNTO?=
 =?us-ascii?Q?OBQ3fCLUMJga/bj1h/DHAPH8rFPOBVF5HZgVHJgsU8guUWD/5ZkPulbR65Aw?=
 =?us-ascii?Q?omj36+jPATc6P26glkMwab0Clis8qvxQuPIK5CEybVlCq7iCjoZ8Q1iXJYng?=
 =?us-ascii?Q?YLybu8Hobx0EVrel4hUIxjs+YXwRIsoHMoWdf/BJQykgmAiP1CSORUsuUuqb?=
 =?us-ascii?Q?9rN0A/svKs/QVuGCA82l71eOaXrEWJJTn0Yqgbdl3Smn0LRg1dNRXZ1WCZ4d?=
 =?us-ascii?Q?0boIYtrG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:33.8447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ebc377-0d27-4f87-aaa9-08d8b41f6d1c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmlSDBSwgfd4ZA1lQmQVUCKHaZZrsBs7or/8gX0gfP20WTSFbO6ob1ZqL10pljLCAoFd5qwQBmf9pUpak/HohA==
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
The stack variable "val" is potentially unpopulate it, so initialize it
with the value 0xf (indicating an invalid mux)

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index a46cb20596fe..b096011acb49 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -470,7 +470,7 @@ void mpc1_cursor_lock(struct mpc *mpc, int opp_id, bool lock)
 unsigned int mpc1_get_mpc_out_mux(struct mpc *mpc, int opp_id)
 {
 	struct dcn10_mpc *mpc10 = TO_DCN10_MPC(mpc);
-	uint32_t val;
+	uint32_t val = 0xf;
 
 	if (opp_id < MAX_OPP && REG(MUX[opp_id]))
 		REG_GET(MUX[opp_id], MPC_OUT_MUX, &val);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
