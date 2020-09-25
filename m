Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51233C4727D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F11206CA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fmnY9Vd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F11206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B856ED0D;
	Fri, 25 Sep 2020 14:55:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9656ED0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPpC4EledelBiZ2me0lkr0CCcMHp6601KHcYuVcfMGQJrwAL7bw8/2x7VGx8f2jxtVrs8BW8cSIuWZzUfcRFNCat9ltQmbw7W0QVEV9sCmJb2m1pv0QHsCVofMvn19DAsAiRoSrfvr+Ny692NXKB6asyQ+HyHqcfI8x4s6TphQSwQCqEVj+shKGbg5WdyMH9QmclpOM0S7U+Oz2mmz6O1KZavANFbKfuskeQicyp4hmBe07tLzVIqeg0YPPS9For3rl4nezZJ6vw1KfhlGwhRjWsOulctsiG1FxNilre3iKWPi1Ts2Nxg4xCvDEOMLLCK6ExPNfnxrIhXbtOwQAoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxzgwzwpbLEqpbx/d928wyWEBSTnG2B5aYgNDoztQfc=;
 b=NzSiQTllGfcMC7BAs4LEmBA2h8qbt0L/dc1L4c6F4/5QD9Vng2ad5zrVly7d2A/fjr7SCMKr17tFTG9aA0LDwF3yr8jOciYIywT1hjvAI4ymrIgbi1e3JmlqKlcAivGxSMUB4yJbEJTArCsQX3p3L/ik/cWICmK09VTT19zW7SPYXv8C9bG/uCIRX3iEHw84MrmqXqqMu808Qzst5qFm9KHV4w+1ZGAYDD4o+BOam/EIjE5lOAMkv3WRRxu47l9dmsMtHYBtQGKj9nbW+MN52K+ww8DT/Om+oZfxylyfqkyB7Pv0EYuq9kieI9bQF5NrULNlyJeS1tgyYA1mfTfwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxzgwzwpbLEqpbx/d928wyWEBSTnG2B5aYgNDoztQfc=;
 b=fmnY9Vd71E2bODddbxhY8Xp0YnpZmPyqvleoj0udrO0dGMrTJU9acFwoWcCyGvVer/uDU2bm9BSzYvCBxMeYq957/jSIVTbfwZafiwRnYcysWgkl0mlpR7WHDQzGbzC8dQCj/qjvSUxCgqPH5BEsQV+rLQhBnhCiCiu9bM9npRk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 14:55:11 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:55:11 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/9] drm/amd/display: Ensure all debug bits are passed to fw
Date: Fri, 25 Sep 2020 10:54:49 -0400
Message-Id: <20200925145455.2398170-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
References: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::980e) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 14:55:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb2374dc-de3f-4f9c-60d9-08d8616300af
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4219A5AC335EF988C4A3978198360@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WoI6XeOrdyyACRHIbQR9avD2ENKbnH9QFITTX7a9PWO0NCHJlcOA1xeujzLNKr3/NANO5LQtnSYCiPq0tj76mY+dMfiWUpt/hZfncTIHrZnzb1vyBW5Bxy7xRCQbqiDJJEbzha5oH0JMSLSwNDvE6XcnUTrN7nySXV14XYzUrPsMgyCl+A56SoiTQd1dkJqS8e5nRBZRoJDG8OdZdlLq2y1UiuY0Y1JK4Y9+7dEyEkA1nob+NDc6DL/Y2UdP1wmHhLPG6/cSGVHMONl6khLB6/5wqoSxpXesAgPz0gI8m0h3dYLUSePV4hGwNHgGHLCc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(6666004)(36756003)(16526019)(4326008)(6506007)(52116002)(2906002)(86362001)(2616005)(478600001)(6512007)(66556008)(186003)(66476007)(6916009)(1076003)(5660300002)(54906003)(316002)(8936002)(83380400001)(6486002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: W79PeTvE8H4htVjP27/nhzUawidYQHTx2tIRbVIC8ukEKunEOl9ItiIYoyjcOOYc4IhZjWaF94LvKYEpx5N2xVc4HBGtSazwAN/bZ7hpfDeZML2DEdrxEicbUwAvw8ERinzM5knGI+HkKx3Lxd0pGC3V+3CoCTZavZD48NQuAlUAT6Sv9Frhng3SA97MDOsP/xTev9n5ZtrX055gdXGB0t2f7yJ2uBIraTesCRGOA9QnEw/H/VZ8hX+atQtO2aaGXm2Wf9aSrVrZMc7K3B1hjmoa2kdY76U1lEqF6QBIeHEVG/t5bIgEcECLORu0NgA7/8UZ7lbudsmhvN5Pje7x9AG/rtv16D8tyJ7f5d5UTydJ1s0p5q5EsVrWkZ+trW5/HioAY8Pft3vkLfJsCiLNCSgq0nDtaygridS0cpAuJu/yzic2QUOQ5puTbKzmipYW7kG06Z7/8N2quJnkbIEclwASyc0s4SpG8iFquGCAofn+98spn6ssPg3dBxmn/OlyxDJ9F9hCyn3hbS/V97F6Q6ww1OZLpGB28WzbWVszrY1dLtj9G9LrN5jOO6JfbQi6NSUsYht8bpv9fFFCkATqGeRO7DCQ63zsCwnC1GQ74qtK04WprWeHuZqd27G/ev1+NriXOvPwXtxeZuhNU8BpyC5lRmsly1qKC4G3771Zr2c8s5ZnL6vekvSnpET6PvRR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2374dc-de3f-4f9c-60d9-08d8616300af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:55:11.5449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ovTuWyuNhh/Pf/13w5fWdID7FIj0QyRmAlX4a9cH0uQ30bCwy/TuqkzmDlTSJrYATpaszKi6A2pgQbCFs2dlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Some debug bits are not being copied from driver to fw.

[How]
Copy debug bits properly.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index bf24f1029547..67af67ef2865 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -256,10 +256,11 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->smu_optimizations_en		= psr_context->allow_smu_optimizations;
 	copy_settings_data->frame_delay				= psr_context->frame_delay;
 	copy_settings_data->frame_cap_ind			= psr_context->psrFrameCaptureIndicationReq;
+	copy_settings_data->init_sdp_deadline			= psr_context->sdpTransmitLineNumDeadline;
+	copy_settings_data->debug.u32All = 0;
 	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR ?
 									true : false;
-	copy_settings_data->debug.bitfields.use_hw_lock_mgr	= 1;
-	copy_settings_data->init_sdp_deadline			= psr_context->sdpTransmitLineNumDeadline;
+	copy_settings_data->debug.bitfields.use_hw_lock_mgr		= 1;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
