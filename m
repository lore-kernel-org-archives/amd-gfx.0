Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC4BC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 08:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCBC64E2E
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 08:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCBC64E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DFD56E479;
	Mon,  1 Feb 2021 08:34:15 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750075.outbound.protection.outlook.com [40.107.75.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1DA16E479
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 08:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyv4dFFbTJPI6rvaqVG95esqMo8b/1nerXKCszKVbcmIfLmr49cJ5LnyRUDoTNlaEHawB1Mv79Aalg/ZHDW81GRyCWwhdYKMBQpTPOdr54GnxOiCcIF8JJWVYJY3YQ2dENe1WRuAp7OMdZdIuNJpxRpq9R8RTYJIUcVmtGoJXs/opaWE292sy8JxsRn3EBZCecShT35fcf3YLu+z/kCfU541uubeqwkL6a5bBo0F5ri5mSC7F0F6nbyIQHVpE7/j10BH39U6aAezWtW0mJsRTiRUfnPFFOPNOfK4kNPPKTH2Xv2pevEoMtLP1LKvmZxxMvCl6SoV/dglMJMUnofYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10RTXZ5gfu7gwwpGMCgB8Plyu43ucFWXznQtR+wBYr8=;
 b=FlDl1fSgwe/vgD+1t+k6GyjqZDNzZv59H9wxKO0RG8b+nonzq1f5FCt2Y1ocpgpAWvb4YTTymVAMbafpBxHIAHBrf8fMrcUNOLJJzO3otCr/+/zOQesSfIz3LF3ONucg4oMDt1S7L2GS9PI3GRSG93bjBtrvOmkpwP9raPoEmb1SVYLIOp4ZMVTyKRryMv07ONmfKBX/iIYFqPDXf57cO3Rhk8Bn1C61EnG4iIJlT6Y4rf6MYiptYh/Zo+MDdRf1s6/JkJXhOOgTN+wPO7+RerFXAQ17TVUTbnC5dpMDCtAsYIbJ6ekPXi4PK0r2fozS9me4+TxqBZ3JxSBs4f/gaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10RTXZ5gfu7gwwpGMCgB8Plyu43ucFWXznQtR+wBYr8=;
 b=J71FaauYfuQ7sdaEDbDdo0qnkG98gO721dOfQv1WiSlCF/Vi1jjnpszt5xYPO4aTu+ha4S1FUgtoBuAjQo4x9ogSekz6nC9Ut8vdJi9t7gWs3u/cGAp5Y8u8f8rVgaaLwsECCX2NsnrvaHL4aGqJCib7MgdnZkwn/a0gTcXAM/s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN6PR1201MB0148.namprd12.prod.outlook.com (2603:10b6:405:55::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.20; Mon, 1 Feb
 2021 08:34:12 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::46e:9cf4:65c7:8913]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::46e:9cf4:65c7:8913%6]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 08:34:12 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: fill in the data member of v2 gpu metrics table
 for vangogh
Date: Mon,  1 Feb 2021 16:33:40 +0800
Message-Id: <20210201083340.28680-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0219.apcprd02.prod.outlook.com
 (2603:1096:201:20::31) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0219.apcprd02.prod.outlook.com (2603:1096:201:20::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Mon, 1 Feb 2021 08:34:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68954af6-7a60-4869-9e7e-08d8c68c2667
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB014803470859A3BFFB0676D8F1B69@BN6PR1201MB0148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMaxnczH+AaJ/g5Vgr8TnQiKa+GcnSo8K5o1Z9cC5KzoeH9NZ6uarW51VW4UPvX/XrpuNdgesoPU/T+fdouvkuJWqoGX9f4Vmv0TVmoxDCAKJZq2F6oltl8L5JVwFtSLaDFGZg1NkKuQ3mneml1rkDY9vymW67YwKvOK3DREqP2fRNOsM121Dh4/K4bhQn/mc7cZrZXGYTZVjbDmH+MHwh7QIxBW0gMbC5DeJZm0TMVcs+2+LPNj2FMbw/TxZxrjvINWiznrEIQZUVrPxVQ4zpzByl/vqkWyvZ8ZXDQF7Cs02k8XYrdHVrbofNG4f4v/dvNWvgt7dsbThIvpLOJkivqP/6EK7Iq8bWAZ/ivRIG3rm0S1yMAiC1gCZVSyCalxJGZpN/XQwqRVJKIKnHzAhFYUlpUb5jJJQQ1iGRnEH1N0tyQXkouRuTkooI6UhK1nhPd0/mmjE0dO8A0rB8V5X7+qtUV21yU+l2Z+8fG1/psbuzFLUxtWUGzjP9Mak7uXM1OsdemIQ4fpfeaCYd6EMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(2906002)(1076003)(8676002)(186003)(52116002)(7696005)(6916009)(16526019)(26005)(478600001)(6486002)(2616005)(5660300002)(8936002)(36756003)(86362001)(316002)(66476007)(66556008)(4326008)(956004)(66946007)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y3veALOmhT+wgpJhH1/O4BsKZgjdhuvWh+PhXJAue50ehNX3dHr6WOlEZJSV?=
 =?us-ascii?Q?ret7B1cZxvvXIFNjajyu7rl1GjSebT/b+Wo81rDGbJ45r7mg98Ue6ZgvThzA?=
 =?us-ascii?Q?S002reGEaF+dcQzklQSvW4cUd4WVUjpID9DZyOQ7zAT1z+X//0xw7BHVn4yd?=
 =?us-ascii?Q?nqSYe0QFSnu9LRBL6L145CsMKMhR0cTdZj5WlFEy6dNsQVu+CQUD/bCz+H0c?=
 =?us-ascii?Q?iYeEvE4tJ3fWNGzgf5vk1GQlOHeeLf2JVWqrUjKspDuHf3a9qPIMEszY6TF8?=
 =?us-ascii?Q?Sig/llqJyZ9irhK3ZoIlo7xuHgqwMRSaHk7i1fuA2em47fhkOtVsokQdOBIt?=
 =?us-ascii?Q?lAjyOLyMdwf7GL9GllSa+iKsX4YFFAqj6Y4oaNOIAjGzk0xWGvcbolFljyAI?=
 =?us-ascii?Q?s78cpJB626ri/47PrrLpbYVovNaBCsKzHiTpVb1g2BIiTQiOicaQoB5kpqJF?=
 =?us-ascii?Q?0PY7dEEC4sz+ssu5CBUHfLy1WZwSXL5MuN0zkmLiKD3Vcz5LFDAnT487mX9W?=
 =?us-ascii?Q?aMqmaOSwDn28bhiAly6+y13tuWSDzDS3SBq8avhZpSG+saN6uQPNSoJh9xQV?=
 =?us-ascii?Q?W9NhZ/8R8tPW8n749E2qFu/6hO+twcMOZDSwfQXqsKbCvsu44QETIF/e4Nw4?=
 =?us-ascii?Q?SkDPdm4keXWlQFiXlzmIFA74dqyem85lLSp087tesaJJ9yyAP3JNC6k+kVep?=
 =?us-ascii?Q?qEvmuy521sVupKUYfhN9LFofDVfFzg96O+QFEDatjG1YzokU0LDBO4qnC+E2?=
 =?us-ascii?Q?YAnPQ1nTaL3r2QW8GVN+KwIFm8+HLhAGIZ6QC37OGZliLVAy8a4U/xlY5dZL?=
 =?us-ascii?Q?LnP7H1GbDptbwqo48Hy8vyLOsqDnVUskeHQ45f542I8+2NrAJftUZ7wPTf8G?=
 =?us-ascii?Q?XxETEpnyVHGAcOJQX2IunzuKOFDru7wSAdUYf+7f7swSl13OcvD8L/sYUZcy?=
 =?us-ascii?Q?Fy8+/CVXnJbPdbkGZmv8j+T8VBgZ7QotLWlx9WT+sRpDkzlEXlhPRDmPuZzA?=
 =?us-ascii?Q?xG4gJ5uxTu3hiJRGrJdtwSVgG7j7iRweJgB8MZPrl7p4eVPF/RXir/GMxukO?=
 =?us-ascii?Q?U9aSkWE29b6Jw/oDJAweeEcRnu8Hwg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68954af6-7a60-4869-9e7e-08d8c68c2667
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 08:34:11.7760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpUqMiwqjLlRdWf/pvQftpYMvW4RiTZQpRby36uw5qB7DzeavNvvMX04lOxRztnXVm3vX9FsC98nS6X6Sko8Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0148
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
Cc: kevin1.wang@amd.com, ray.huang@amd.com, Xiaojian Du <Xiaojian.Du@amd.com>,
 evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to fill in the data member of v2 gpu metrics
table for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 6d3c556dbe6b..4726cac8d824 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1422,14 +1422,17 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
 	gpu_metrics->average_cpu_power = metrics.Power[0];
 	gpu_metrics->average_soc_power = metrics.Power[1];
+	gpu_metrics->average_gfx_power = metrics.Power[2];
 	memcpy(&gpu_metrics->average_core_power[0],
 		&metrics.CorePower[0],
 		sizeof(uint16_t) * 8);
 
 	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
 	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
 	gpu_metrics->average_fclk_frequency = metrics.MemclkFrequency;
 	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
+	gpu_metrics->average_dclk_frequency = metrics.DclkFrequency;
 
 	memcpy(&gpu_metrics->current_coreclk[0],
 		&metrics.CoreFrequency[0],
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
