Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A38DC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469B264E2B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469B264E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1E889FC0;
	Mon,  1 Feb 2021 15:52:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2231F89FC0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E80EIxHKwsAupQmADizMr591BZu49T/LUWuezWRNIOLDNmefrgqyleu5A9ZEcbdlW3FXShg4WOf51DtSL/CiBKMXavqXAq3VVQYvVYVCtTJdgxzSgZrTZi0bXQ0CfvE3AQgs4+owrVTPcjGZe/uiPOq6YCmzNDzdvWZWyhaQWfQsK2/QUDr5guDAI0RnezWQ7TsVUq6B17yLiuN3eCkpIv3XztqRLes+yMcm3e4wA4FeDIBBZ8NN8KZAnjp1imr9dRumf7083+aNLSTPoFr6xg779T6TZJY83uxeWKeDCjL9OuxJIVSSObHkrlBpUzw2Fi1DHkyFDtArOrb2WkA3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuqY+j6LXXDiUKwN1f2G3WrO2T8pZVCEgtTKdb/LT/k=;
 b=Rxhh/I9YLkMhhgeYonysXWizPpZx3s648+euBnpJsJaak2ZXkfX7yBwfEYWXXcyqovTl3macTslxPvwCPHD3CCllLCwyMZsM9Oi5dl8zrTlXaSZCa2ZFuJ16vNSH36eKI5YUA5yRuVDtKaFcAX6tsXYRD2NkYXxb79RyAsDS+ug6UlIHcrETycOVMhgG1U7ZUCeuxcp/c0+lGrK3Ec0n1aZIKO38zUb/GKrNoDdyb/d/ND6CK0J2B0Pb6/nx6f9kb9ydzic2aoASLWWBr79nVc3JZKfDpjOZoYnLNU3/w6hgNjXXXAYUdMkcc1pG5VJ5Rdqrw60rrrvit2qD1GmwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuqY+j6LXXDiUKwN1f2G3WrO2T8pZVCEgtTKdb/LT/k=;
 b=wGzpX8m45lfylE35tshxlt2KFUMNVD15LoMXpmZzpTDJpb0ybe3/3EJ7MboSHeqERwQcT9Lpdsag/LBPV1h5QcDfZA9gIqOvBi6oNzaMnY2JJw78UAqW3n+QqF5nxlBbx+1YJ22M8eVPTg9iISkEhfI/g/N+aLhIqlMJQKFNM0w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3066.namprd12.prod.outlook.com (2603:10b6:5:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Mon, 1 Feb
 2021 15:52:13 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 15:52:13 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: enable gfx wave limiting for high priority
 compute jobs
Date: Mon,  1 Feb 2021 16:51:55 +0100
Message-Id: <20210201155155.103360-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201155155.103360-1-nirmoy.das@amd.com>
References: <20210201155155.103360-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:208:55::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR04CA0129.eurprd04.prod.outlook.com (2603:10a6:208:55::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Mon, 1 Feb 2021 15:52:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebeecc19-f0fe-4082-49e7-08d8c6c957b6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3066516BD5695D991834A5288BB69@DM6PR12MB3066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKlOupN4fO/nZDronyrnZTfYIWkZUiCMXYyBbEGZLaWjzNeCSeK69DirVPvAkipZTx54LFeIVA8HE+R4PqYfoyTom3/TVFH6H09BZOxl0AYz+ApXZ0fxQSopcawg9o+ldI4ZuNkWTCBX/MTgH1DkODJT4aFcxitWquwGJ2aroGxw2fCr6L3b+VN8PU769DnGSskjlg4rPmYjAyhwxs0vtg5bw1cOBRLhtOfEK9FVOeT9x9bx5SQ9gzgLGNAvOYuSeYCH2aclzm7A46ratv+2i2vrEPf7Gm9WdBS1wr243+WRI3kcBjS8ZcRaeR1CTtEv6klWelW+n9mH0e7Rc1CVYlSaDoQkZgADkM3bgCLQY23tg9LnJ7dQE02y8WwmJCBJXTa7nCQ2ICDLsN1K3DaaaMkq18sJjDaZCPBz8Z6prUZsLajlqJW1RnjeFprgYpLm0SOGfz7W2zPIux/j/pvZFXiaHCwT9Nw+eH2kzZlbhRocFwdADL3mQM8V/H0yawy+pkuZY6RbZN+yowHyQT9JrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(52116002)(6666004)(5660300002)(1076003)(6486002)(316002)(66476007)(66946007)(66556008)(6512007)(6916009)(2616005)(26005)(956004)(16526019)(6506007)(36756003)(86362001)(478600001)(4326008)(44832011)(2906002)(83380400001)(186003)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?26O1Wk/23cMfbRI8S+RlvdMEeoK2UQU16IR9oZ2F9W48kGkjzqrUooiap+o8?=
 =?us-ascii?Q?3YO5Z4fKbdOpFaG5dlfV3m7ODABWXr5LmN7nK2BVniDFoz4MpW0wr7LCQB/r?=
 =?us-ascii?Q?RmpxzTn12Fjmrde84u28rTtf2mOJUuDzbSu7fFXNYW+5V8BDQejpq8uVz4U6?=
 =?us-ascii?Q?jIT/qtOk2dSGerNmMuZu8QlDfzQX3CASXFFzrKhttNIewqa5LUY3VDdP2qZx?=
 =?us-ascii?Q?Tcg4r0/6WH5dmR9HWKBsr129UGfw4W2RxspH5aJYTeEjAJBYaKJ2ldZC5jxs?=
 =?us-ascii?Q?9dAgcUWtziDLD16OB0ZFVPoPF78dr3UniWO6dcb+Bh5WzzZIIPDP8sN1jq0+?=
 =?us-ascii?Q?zfYlkwizdZC74Sjpcegt66FBWzEpC6Rxk4CjIBjv+3JlwBdTDlcP9m3DkkuK?=
 =?us-ascii?Q?e3YW1TyJoQ9u60ZpzgS95VtQr1Wn8hE3eI11zfDiz94o6M8QrBhQwmUR/4YX?=
 =?us-ascii?Q?BwvLOe1LQBwhTQgsW/ZyHeA5Wzz9IWAGIPBC78BldrkYA7GyiebtWABlMWrW?=
 =?us-ascii?Q?1MZwJZSIJAjWuUGnYWIsq9ZjZU3tmG6aZzVAry57FugfYl0iQ8dg90mxlqpK?=
 =?us-ascii?Q?ZIfxGHxWbDTvORqz+Dj0ud/jzKU0/MM20snjRubUoPcrQmob3BIM5+xxfxdR?=
 =?us-ascii?Q?emhSqWahvbaznvEj61qEE6L61ZrtI9NEd6r+a9EZNUjBI4ZWeQXW1dclBdfC?=
 =?us-ascii?Q?iJ81wLT8+oxSFvq/mXFB9dpdrvv2bzkGOShtOFw7XhtWIeA3ypod6GeJInm4?=
 =?us-ascii?Q?hoIckZ3kS+6MJOYM/JJUg6NdvrC4LkUy5NzMSjRj6zBQ8kIg5IAtVL3+Hwzw?=
 =?us-ascii?Q?YeKdIxxjEqJ+POZa4mNpAA0tl0GUAYmhHq9/1ZbGXGrP9oWvMHCcTp92uFqb?=
 =?us-ascii?Q?lVVa8Emj+NZ2cXNnIKGFOkk5t+4Tzk2nXZuBqZakCtD51h2kB1kTnaPlCXud?=
 =?us-ascii?Q?Z8RrMBcEJWKXaYd0BQW1rkSPNxXAW/ZqG7vLMBxHof1aHrxcK9vbUmz41i+O?=
 =?us-ascii?Q?zslmS/LvALd6r8IDAg/ErYTeVxhLRzT3z3aVD25/KPSz6/ccE5L8BnQ1fKgy?=
 =?us-ascii?Q?z+aaoB9l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebeecc19-f0fe-4082-49e7-08d8c6c957b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:52:13.7334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MywsSWCRAktSMXatYTwHVUZG7MDeJhj968ZdPKBAFsz//4t1u4/FbeOBDEaOd4/P0Z0Xl6n1lE2URcvHW1XAbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3066
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

v2: use ring priority instead of job priority.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 024d0a563a65..7645223ea0ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -195,6 +195,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
 		ring->funcs->emit_mem_sync(ring);
 
+	if (ring->funcs->emit_wave_limit &&
+	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
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
+	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
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
