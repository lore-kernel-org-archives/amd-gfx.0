Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C780C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D53A23B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D53A23B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F2C6E05D;
	Tue,  8 Dec 2020 19:28:59 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8091F6E05D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aoo/UmKfmQTHo2Lue5eibkk0ZMHt78jldQ2Yi5WJwHpcnF9itjUEzeWT9ccDKJDBPsquuD7zrTSa+5zm9pELeLblXgqdYGIr85JTzdEk7+nZfvPV4BgHdaiKVQ3GQtO4tQ9MHjg0qRLeFR9OTsKFot2Q/ZUMGfYB05djZfW+Ma67ubikpUszB/5FG2ulVl2OUH52MK9Vl9cVfWHW2P5AeSCfoIRvYigVCqF89peSxe2jaoGl4wbpp1G5GN5CV6QKa13FHR+k+dzZlOuSNhuxDmwsQd3XzQrvMDU4WSTt1zgSozuRUaqv6asxRtS9PXxH1oqjsYHwp9vTYYkbeak2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAlyVYVosAMt/9jTzsDf1ae0kMalQEdZC9ckm+3CE88=;
 b=XHXeb1Evn/lxmVQ/i7etSnCUT5+sU2PXbgVWoCXBf1zWg+HamzP4J3taOKi33kU0Dk9FS1qG1DIU4UwE+KEb1MDCQowSYOmDLvWqRVDjSe1ODMqajcZ0MdXVrhEnvSTQwP9y4/hbroyWw3rEtrETONsqKAyqsUwvOPVE+g1Oik0mnIsJUz///WTnxJOX1PfpXuWf4LfNcDe7sVJ5fkXvS4c4dTtEmluQvQIug5RcvHfiRvKi/Mm3+FbSe2Z9moNztVQUh/C2vlWpcQauoWcKVyLNn8UxKhyhuUI11SSvPwK7eGnSeCl0bowgFdLcsIxP4oepzk16HnXE0Vj0rxoaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAlyVYVosAMt/9jTzsDf1ae0kMalQEdZC9ckm+3CE88=;
 b=WYjri0ox8a1TpbFoGVEdRLPn4uncKorSTy9LFLdVmyiCWkNKYZPX9RIrGIuo+A9QfXj2JBWNskR4i9CzVno8NvwKdEyqzxBPckTpO5JpjcSNDPb2b+EZLM9j4SP+vo5BaukuUkm7u0/xzFqY3vCisGWXq3I9dkquBd/CnyECF04=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 19:28:56 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:28:56 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/13] drm/amd/display: Change pstate expected timeout warning
 to 180us on linux
Date: Tue,  8 Dec 2020 14:28:32 -0500
Message-Id: <20201208192844.23580-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208192844.23580-1-qingqing.zhuo@amd.com>
References: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:28:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74e96da4-da7e-45c4-3ec1-08d89baf8167
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4388C7298586067C2272F739FBCD0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXD7kQnUiZXbDUoAPf+ux+BtZDED7i5bQwIkcG4vli77gwESLsV4v4RKweYmH3Oytx4hc8GIJijkvbKRaSLNApNhj0BcmuOj0HqicMUw0bdf4SW439Eu9JAPdKlPE7CizfCHuH8nc78f9h1MJsdqOkPybxDHyXpVKP/7y/Zdwm3A3dWzD9pCJ/KkixY5116s20IDx2iWgAI9MHI3EVb8bl5ioi+moJK49mm5VjOBfR1K6mQ7oXNaejuRlUqnggVp06hZHyRpC97jIAIQJgccjH4pnMlixS1iuIXFhirZQWyfSA+HnBEwdCf1S8RKcw0KnIsOZVmDqh9p3GMmGcIV5AfBo17oBlTBzKNJwdUvgoo8lpeWOVMg/fMTuQ5vss2bGdSlEgJ/QsdP+pC8KmUifB8Tr7cKnAgGNz/frWiXns8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(6666004)(86362001)(83380400001)(34490700003)(6916009)(44832011)(8936002)(956004)(2616005)(186003)(6506007)(36756003)(52116002)(66556008)(26005)(6486002)(5660300002)(16526019)(66946007)(4326008)(2906002)(66476007)(8676002)(1076003)(6512007)(508600001)(69590400008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OVBJ4UFjHQO5mVfUrw2SKGzFt+jd6BoTTvW1zxesbaqjggBKY6RMFfn0bviA?=
 =?us-ascii?Q?d96s99vsEjcT6wt7NnyRjx6/TIW0PoMjXRjIa/73Ved+mXY6dkfZAkn+y8l2?=
 =?us-ascii?Q?hZNyWin4JMqz7faOyUxzTWb5MZ0t7YXUsZ+/A19SQGCmbnzR4JMS/mPO6D4Q?=
 =?us-ascii?Q?PwnFMa3mE9mY60vxVMULSFwcXvEvKppvbPs86r5XDZtF9s6+3Q3//3/wtjFs?=
 =?us-ascii?Q?Y/yUyZPc58gPcXb34WOKqzRHKDDDbzwKiP76lnssJhNqKlp4QOm1cSh2TX5x?=
 =?us-ascii?Q?+QtG+XeyxHebMOXyPDaLZgji+UYwFhsY/DTgACGf//g7u068XDT90NpagYhc?=
 =?us-ascii?Q?4tgvFKayoCW041BYR9aWWQWbkz/VPbafWXSdAwU9hJUtJvfeKIA8aG92GhXN?=
 =?us-ascii?Q?+ym/EVnmLtboABTC+YxJzwOyhuMxI6UCayLO+JZ0n6VXJ+P4OqhSy4HMYAhD?=
 =?us-ascii?Q?6F9BYRFcWrDi98WIWwMwjNtIu28H/fQ+3WY9CUGeaGOKNnYVyIKoeVuRhN7r?=
 =?us-ascii?Q?XfHZhePv+jGVTpW9t2B9UTeX+PDKPoz0NC2zg+e0frgKWiZuL3SRTwt77zWR?=
 =?us-ascii?Q?69X/GtOGucTYgvpso0X3FwP+h2RfkyZbDmb0l0fdzVCLy48+qDOA90MezhyX?=
 =?us-ascii?Q?ZvaO+0aMA5TetQQhedO2JRaxGJ5Spr9kCoDiDiroNH3xyK/Fuszin0wZlAmP?=
 =?us-ascii?Q?Ekuf8IPGx3ut1aLzZ0L0a2XPizLG8V3bJRYrnCS/Ayhxnc0Ljf+zFcJ1AAmY?=
 =?us-ascii?Q?vaeXcvF3Ac21AncoiO/jzpHaKOKypt63Hmlob2psJOlzcJhvWQIJ+1owxKpL?=
 =?us-ascii?Q?GRVjCJ7fkbcuqcJhUQKHtPjhkaLmA9fISgnuzP/N1lKI7zcUeGDENjNo1zvx?=
 =?us-ascii?Q?vt2DQOQhzroF706w11ZTBQPJVS3miyFdOrqcHwBxM2ah4OD0kc4aSGKke55J?=
 =?us-ascii?Q?7xMJX+y+w9sw2w6yQVtJt+LCHEIoQm4gNDtSYMaGJvD9ZL2il7GIoCS92mc/?=
 =?us-ascii?Q?msfa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:28:56.4644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e96da4-da7e-45c4-3ec1-08d89baf8167
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0PfPaBYfWPYhi3sX8Yqm+CgQspv40fgEYL8bIOY7MwHi2VK4q6h/9n0JeN6NN6K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[Why]
There is a warning that triggers when pstate takes too long.
Pstate can take up to ~200us on Linux without hanging but
it is currently set to 40us.

[How]
Change the timeout for the warning to be 180us on Linux.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index 75637c291e75..6f42d10dd772 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -124,11 +124,11 @@ bool hubbub1_verify_allow_pstate_change_high(
 	 * still not asserted, we are probably stuck and going to hang
 	 *
 	 * TODO: Figure out why it takes ~100us on linux
-	 * pstate takes around ~100us on linux. Unknown currently as to
-	 * why it takes that long on linux
+	 * pstate takes around ~100us (up to 200us) on linux. Unknown currently
+	 * as to why it takes that long on linux
 	 */
 	const unsigned int pstate_wait_timeout_us = 200;
-	const unsigned int pstate_wait_expected_timeout_us = 40;
+	const unsigned int pstate_wait_expected_timeout_us = 180;
 	static unsigned int max_sampled_pstate_wait_us; /* data collection */
 	static bool forced_pstate_allow; /* help with revert wa */
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
