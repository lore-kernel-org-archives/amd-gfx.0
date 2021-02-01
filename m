Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2817C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 14:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5AB64DFA
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 14:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5AB64DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC7F6E7D2;
	Mon,  1 Feb 2021 14:38:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53E76E7D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 14:38:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgzcqVf2D1IG0XsON3tu1kmY9ijd2pD8TIHGUhoFBmv901/UKBv20T63Su4MyEThWlc0hJxVlN7sMPB9soH7SyCUtKtG2JBKvf+RureeV6Ivaa/dV+/pwsjrbBbHj9GkSO7U3sk7qB4P9DlyWnRlUUDjFl58kQ4HmIJsdYevijhivpLLpT4z8MlkCjLOoHH+5Xz1ZEXRsGWTF8qxW6zctIj18fDLVTxbQ++0o8TwhPfXBPFH14wd/uf5OIXqWKZ64+hzRrMNIqgFKeIM/Zbc6X/rXr/7EXhukZ/OD4+BP3lUQM7yjOJ0yjq9FpHiLebCqxj87QJGjxmz1wAm3TL6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFAN2a5t6msIFIISrskmiuC7vEfnPEt7UQskqL4ebL0=;
 b=h1OU+lVH8WC1IBAyDi48AUn2R9COOSL+4qJeLG5jaQoLCNaoLo0G/5qtrCZEyzGWPLnAr2GwFRbd0vwVTc20K821FHAUrISIVCE6r5CvghCwfC/5yQIqK6sovUJtererxnxfajkqLCWndXAk/dXEhmnxDJis3xvMYVEN8a8YrUuN1Qt3Aulye09ORklO/p9vjevLKXEt2rjSlwCSKGM9HGAYEnQvs/dlCb17djwaWFW69fVSpv9Y+3m2V+lziE6h+9H1Yz1Eom7hVr5rmfOzTzqUgnweLFAKINuxgUmEZdAy/gPgksq8L2/HTwlZAOK0697W3gS8+By7AnswEPh0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFAN2a5t6msIFIISrskmiuC7vEfnPEt7UQskqL4ebL0=;
 b=gZSHM30D++lG0yHFtTzx2sTtYhNQfxcgIaEGQkNE+a1GyglmCBZgFSjLVIpZhL2wuQwzrQdSuqU3ax8E9EG/FXeu5bRrsv91w5qSLFok7JtyYeIExx7kPaeik+ShiNnt3I+8oDDdt/UsRgHfeZXrGo7IzjWYu+1GzcQAO30mdIU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2373.namprd12.prod.outlook.com (2603:10b6:4:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.20; Mon, 1 Feb
 2021 14:38:18 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 14:38:18 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: enable gfx wave limiting for high priority
 compute jobs
Date: Mon,  1 Feb 2021 15:38:00 +0100
Message-Id: <20210201143800.26908-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201143800.26908-1-nirmoy.das@amd.com>
References: <20210201143800.26908-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR04CA0144.eurprd04.prod.outlook.com
 (2603:10a6:208:55::49) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR04CA0144.eurprd04.prod.outlook.com (2603:10a6:208:55::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 14:38:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32d2fc18-93a9-480d-cfb8-08d8c6bf0420
X-MS-TrafficTypeDiagnostic: DM5PR12MB2373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB237388BC66A687AE4FBB81728BB69@DM5PR12MB2373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:208;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9roFG8ugqmlxj/XaPOphaA8F3eRpiRsQ4VdPH6mOovw9BJcrRDFkwWGWisREhaFvHV2OrjB2E945mOQRIPygorq3Xau0bRF9XRZLdVUIbl/WK2H1wPTvOYHOHrOaVR/nv5McnqlZ5Anef+vSQfiJOdKw697ky+madYyAJgU38QZibXUf8G4EIvr0C+0sbvmBuBLHvUMOU8m/LEQic+/VBMsWECDfPd/4mp7LfdE3WerSRf4j9fw71QWMTGdunzGAvB+2YLWljuNRXdg9r6jp9pbqRUIw3mazMGWlhnf41HiTQn2yE3AmY6FupfsXnFgiJC+vLr/L90AvWT6rlxxhh0cb7PUiwiau59jlmbPhgCP7oT4TvLoustApObBgo74sb5zX0IAFgDQKDJW94JWvvQCr3i3sJgGDEuukvA9EXPZM9h2yQQyx3xi12zl/+iQrIPVGrfBDdXgCt/jUKy0lq5y0T3L4SqExV2kKFK9DA2QRXMY/ImX0rZvfNmIittBe5aUZi1MDPoxcjI5oARGJcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(2616005)(6916009)(44832011)(6506007)(26005)(186003)(36756003)(316002)(52116002)(6486002)(956004)(6512007)(86362001)(6666004)(8936002)(2906002)(8676002)(66946007)(16526019)(66556008)(83380400001)(478600001)(4326008)(66476007)(5660300002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?omTXp8MyzvuQsJQ1NCbFF0naod0tx/1hIfqO9hZJcR5XwBw0RoEv/aHKtvhQ?=
 =?us-ascii?Q?e27HwWGsbTQEHFvgiNFHs52lmYVF37Ux335HUCZsLsmJNVIs0sDDJaQVGcSy?=
 =?us-ascii?Q?gembWPCMf9I/bIhe7toKF2mgAxZhdomC5yAz/b+KQVLb/VmjCzw5L7ULOCSK?=
 =?us-ascii?Q?UkzRiN+5/3+tiwdmH+iRqbQg1zDIaZ5y4RxUqVFBIGEeoZpkuaGV6BLiWbBu?=
 =?us-ascii?Q?SormQbNsslbMR6p5O6sVEzptwe2xGyq4Dur5rR2Dib8AJfGFK9DovEebFVSW?=
 =?us-ascii?Q?lXuBxB0xoXX3208Z1EidqZMVGXmLNPU2vagK6vScMXp9HDxYiKQOp++LExgT?=
 =?us-ascii?Q?TtSxH0LbIpDICmEUQZ29FgTohASQzJVDmQPayiXQKiXgUwYVNoD4UenDZKkJ?=
 =?us-ascii?Q?U4PsH2mZgTsR2Y9u2kaoc9hCV4wAvS5VENhsA4nUJxfv3fDYPA2XDkrgV0bW?=
 =?us-ascii?Q?Jb+lC7brTWf3PGHwO1z4XOZtuS7mCK7qyKV/ulBuMdAfpUVuuAHWH1mHcGKg?=
 =?us-ascii?Q?nMRZOoKrtJ6dCzU7HM7qJLbwJWTxT9OTLNSK3luN2iCPmohQNzUTky7aDGdx?=
 =?us-ascii?Q?uSbdxy2W3rPR177bOyRVH2IK5S2AFXR4lEK96yeIS/NcAJL4joKPidgYnoS4?=
 =?us-ascii?Q?X5nMLSFKYdO9q30EB1AM5DZhzf5ciKPu1sUkP51hsPIlYuAwXywvLdTUby+w?=
 =?us-ascii?Q?aDlzcdL2ipWerdTytBg48AguQWW2PfC3ZoX2zCnLTULvNEkUyeJdC9i6451t?=
 =?us-ascii?Q?zVJV2IRnV1lQSGprhMjNnavt2W6wK5IgUFrb4K2EqK9CN1lsS3RNbMjhnHdh?=
 =?us-ascii?Q?jXSeTpO8pmnmdxl3LAiqiyFj2UdM5AzGcMXdlYQkKpKmfIrOd4Pvv8tj404j?=
 =?us-ascii?Q?bL7uf/ICBFJIx3meBEZZeb8V3Xa5PgVMVwUiaqA7Yf70O0BKngCoqKd5Br+n?=
 =?us-ascii?Q?8yfd0jqgTpG5J76OlRBDm/vHJX3t1dqzNUZPEP3UNQqdtTGZGyAlgIE++iAc?=
 =?us-ascii?Q?F9uchsv2tyO0M07O2GsA7rnEE5VAqHoZqN6TIavcWu7qKylv/uFd489AUwk5?=
 =?us-ascii?Q?LWMP66oa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d2fc18-93a9-480d-cfb8-08d8c6bf0420
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 14:38:18.6435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJe0E4s/9mCYHZgT+j7tcywwGXxiHhZ+nwnlUVc4kSTX6lNwK3GUedybtidtCr7A7QHYtI9PF20OkXxynLAV1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2373
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gfx wave limiting for gfx jobs before pushing high priority
compute jobs so that high priority compute jobs gets more resources
to finish early.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 024d0a563a65..5360c759d9aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -195,6 +195,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
 		ring->funcs->emit_mem_sync(ring);
 
+	if (ring->funcs->emit_wave_limit &&
+	    ring->priority == DRM_SCHED_PRIORITY_HIGH)
+		ring->funcs->emit_wave_limit(ring, true);
+
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
@@ -295,6 +299,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	ring->current_ctx = fence_ctx;
 	if (vm && ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
+
+	if (ring->funcs->emit_wave_limit &&
+	    ring->priority == DRM_SCHED_PRIORITY_HIGH)
+		ring->funcs->emit_wave_limit(ring, false);
+
 	amdgpu_ring_commit(ring);
 	return 0;
 }
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
