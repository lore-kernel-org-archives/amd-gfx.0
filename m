Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435DBC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7056186A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7056186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620E06EE73;
	Thu, 11 Feb 2021 21:45:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB296EE6E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7D8V3ZGj0+/K04PthcrVumCuafE/DZ9OlVHuIJ1Q/01Vx13/PCWjTd7uOXITEAF3t+5UDGM2SQ8fwIgJiAKbAbSqdPb7kmHY8nVGDUIyR8z5bazqvlWYgJa8Kp5yg9B5GrzVj1Dqks3LHe86nfRHLQWDouiAvT5u2KAnjFNwMdut1nQtlxHmmjuM+5/rMNtzehfKENz2p7s98VVAEbEWxB68zngkpqV5vzFSrNENtreaD4XmpHdaiFSvbEYxcqKuhmW9AMm/+gdnDMWeXzNcFNcT+8bFGkuFs2WVQ9roKM4qEqi8g+vIXTIkK0rx+Hntsn4+Rz7DAg27KiDoGF0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHHGKwSlwGwAxXHM3rIqhMAeX1PCr5VMtouNbh36nw8=;
 b=UjULPqXb9JOijTYwdUwAIVK/InrqJJX6IhRmdmxIeq1jGvdYe6GCF0d1ZHcIuPS3/rDZgCy9pMWe3lVm9j8ATEPJN+16lFKW5ul04Ayxt1r+B7tSAAf7v5quFxEP+j/dwWtMPW0W5LPLmM/gSwjcE1WfFx4ezNdsrWtwc6dQPLbkczsiyQRGolD2CD0zHZVk426f0QBEJEr+KkMCbRqxliE2gneBqGV3F9AqM3aLO2bCy1Tb3m47hQYKmQGdOVVRmT3jo6wYUDxaT4EUzYbdXQPL+Dl6TXfZuqt1VNSdqsnilRsZvXedSOH9P4lAOoXefftzU9/SCwxv86YOWuCI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHHGKwSlwGwAxXHM3rIqhMAeX1PCr5VMtouNbh36nw8=;
 b=lqw7DdEmrM0Zr1Q6spijGRElIfxXLh69QD54zJ0tg1SV4qmtWWy09c7DA/iPsld3wuAM0FpGARaw7XXC9ETafJSV2H2+OYLOiN4oXDAxtn7CHjmWn3jhJiBin4ZgZN5vihSP29ZiF3uCrVU2xb3pDL9HTIVgibpRX0BsYAnPOsE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:45:08 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:08 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/14] drm/amd/display: Copy over soc values before bounding
 box creation
Date: Thu, 11 Feb 2021 16:44:40 -0500
Message-Id: <20210211214444.8348-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:45:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9756e184-e82a-4042-789b-08d8ced64ce6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42355FD1E9D15B976B6DD779FB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRZrAJsCntz6TGuo6Y/9UIc4GeGSjeEJePsHvENv71MfetW28ZJHfdIloq7ts5VMTdNpfgJxF4l4R3yF+wkH7TkXhLNj3Vn0VKA+wJw/zOUv4XDh2TjtGjVZT9t+JK/dou5WBtiUpJ4CCcrxc+nKJLzwTf067PSTuoe8B5YxSVWq5kBTPtpQllS8iD9AawRaGMFc/3tlgM8BrkcB9r9/K9XD4pIjCeAUZ9G311oOlo3bFw8M/Xyy083OUcTQXke1N/3gqi3Z5Gw6VWKlF20+0c+WFc28zq8N2DFDFPbiNAJkQyu1fmq5eZt5nEAEe020d3TuOpeDx8BG94qkZKv8rU07xjfx7q9SvQ2QtsheW83R3pjApWQy8BJAxuL3hNMrD0C/wFePiD/grS7atMT/0l3mP5ELuTuEUIKs4HZM4PEEWxEvIvPilvrHSvmWzUoPUoHRF42QmexelxXOE+Cx1XcwsMHAhapfj269lDAiZi0cW55120LW5yB1uPD4ZbX6zXVa7O+aWO3h6/VqQ5vLLtIy5F/Lgx4JcFjzAlVSoJPlFZc9BEk9+7cOc0GUGcOseK66g5u9EcuQw5RFP3fw9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bYxBvNXMc9PdVaRWKlG2E7RQr+QDU4Iz7AaUUg8y+ZqfKk4XDJJbW1Bkr7fF?=
 =?us-ascii?Q?TRSnaYIwkDEoip1dyCeO/D0OPVmSgT/ovzrkx7ZLhWyBVnlR+Ik1VtlYMsAv?=
 =?us-ascii?Q?R+dumhg2aGDWsFjiNZkMuYwa9jNSY7GbmkhoGMdMNF6noqH/JFPqzJH72fGW?=
 =?us-ascii?Q?CJRWYvI7TUhOzN/zt1JR/5MZL3/WhyUtsNXb4uSifOpTbtWOQXzqDEPIKeAv?=
 =?us-ascii?Q?9KDeVCk8Q0mxM/husXIj5DWWEbSkWLUzgko+joRFZhdWdRIQTjpEKtLb9Y31?=
 =?us-ascii?Q?tVBm+4nF/UEqMhdZvojJ1oXU9wdZnclt323bxLI8cC5dnVVgcSwxDID4aWGM?=
 =?us-ascii?Q?lDX3IK9lSXezYsEwr5BSld2TS7bvUqAEigb4TcSEfxe8/lECb3rQTxMoD6nO?=
 =?us-ascii?Q?YRfVayNBPyuczP7TpmP8gZ5yLuAdXWE3sXAXLS1cAejSeiptHv2QADsyHbFQ?=
 =?us-ascii?Q?KGoHbGn0sjJmgGHSSS9Q8uFItzpuQAcdNV+ovrFtAujkwCMl5nHA3fYSpDnB?=
 =?us-ascii?Q?7dto1w6Cxlne6KUQ2n6QhB7C/mtcvFBm6itUXi5O8RUwElW9afqLvKVS+Jd9?=
 =?us-ascii?Q?d0N4h12Y4F8y9TMBRkP8xbfUVASMcEJVEwUh+7W3IndIjRLecH5Du5VI6G9c?=
 =?us-ascii?Q?m1U2dO1Yy2qdx+8+wL5UUR9JcVvoCsP7IZ8ge84WG5RqUd+Ed1sH7lN8Yb/j?=
 =?us-ascii?Q?PvstRpNP6aj/mkXCp0WWV/FZ3mfltHLr8SggcLHlEyNgICgEqwE1ULWY3JUH?=
 =?us-ascii?Q?z6QQltUKMjkWeUhT8x+qxN6b4Bwqg0sAwPan3AspYNDK08VVnwCZBGxn6tvm?=
 =?us-ascii?Q?VTZCFD3w3r3420str5zJFiIeDYNTwL6SZe6Tef4M9qnq6jR1Y5Y9csOA1Kii?=
 =?us-ascii?Q?BYiq4NJIH+UuenYXqqNZtE/wxeoaMgxyh54JGY5TmYNtH62xxLgNnPtVCF8R?=
 =?us-ascii?Q?e/l/z9fqXQXl4bAVTu2RtAp1xTZi469pAqpcdtvDrkBstMFw6BrcrDa8h5aH?=
 =?us-ascii?Q?SDMOWQN02gX9/GI+lijl5sbuHhNxfztXcCeFA6hv7M92Vt1g8b3SYdczRDGV?=
 =?us-ascii?Q?QLxQvBsciknV45mZFNF+XmMgusUSW+nzbIEuB1rvht0w0umBJTcnZLf7xgOD?=
 =?us-ascii?Q?jdUfQMvX0MIic/7gmZHcnO6w4KnJVX78hOhITLAUfDuBzO58s9Im3d9pAys0?=
 =?us-ascii?Q?tqg7UayzLGdi6lsm3cxquiwKAwRPzRosLUTtYT+iBtMzNKEMhLPJvv5wvYEB?=
 =?us-ascii?Q?KKXgJtIruH8vOSy94qGYRvWc6brrG3645tOTaxIqgvAlIY4YJqjJd2OXp1uK?=
 =?us-ascii?Q?b57B+jRMhy/iNrfHvfkCY3I9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9756e184-e82a-4042-789b-08d8ced64ce6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:08.3769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vypx7DI0cJ8qjoIiS/T9v16eyiecjmfztx56K4Z4bSNBnWzGrdoDKFn6VL+pLRlz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[Why]
With certain fclock overclocks, state 1 may be chosen
as the closest clock level. This may result in this state
being empty if not populated beforehand, resulting in
black screens and screen corruption.

[How]
Copy over all soc states to clock_limits before bounding
box creation to avoid any cases with empty states.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index d6d78438ea08..cc7ba2a052fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1583,6 +1583,11 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	dcn2_1_soc.num_chans = bw_params->num_channels;
 
 	ASSERT(clk_table->num_entries);
+	/* Copy dcn2_1_soc.clock_limits to clock_limits to avoid copying over null states later */
+	for (i = 0; i < dcn2_1_soc.num_states + 1; i++) {
+		clock_limits[i] = dcn2_1_soc.clock_limits[i];
+	}
+
 	for (i = 0; i < clk_table->num_entries; i++) {
 		/* loop backwards*/
 		for (closest_clk_lvl = 0, j = dcn2_1_soc.num_states - 1; j >= 0; j--) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
