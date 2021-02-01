Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D121C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 12:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB8164E9B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 12:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB8164E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612B96E55E;
	Mon,  1 Feb 2021 12:07:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE4E6E523
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 12:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9cRa4uMZ/CZOwjDn8phA85VvvBetKg2yWM5a6jbcXxXexbHUxXTnmk1gaFkKP/N6siON+g1nx3mrIWLQdKGry3BeWh1rdZ1iJZjIUPqWtzB42xtPbVtew0eMD2l5etVoCdKkCD6h3THJpfEFF2cMjt87yHqzfTNgOWnpD4R76jB2ZTVK/9w5Dufy+OdU3p9tWp0I86swEikkULfLo/kQjJSritRZ6caXcrfqAwggJwk1/HDTDM9ZI/zYYonWBzgOEeuuNwqaYaIjorYx0+B1LvoQHKJ1mUp2X7wRAI1skEflSuOUeD5FX33/IIutOVJTmYqOeGXu/loI8X4e0AzMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ro1JqyJ+dZz00hh7XW/1EAbfRfXIQXE7FvoIkV6rQ=;
 b=GA0Oo4F65E+gEb+wzrjASjqWLq1BxBuDHn2pp2dCmnL9FFJKyDtto/1uuqziV66ChnfOIHWgrRo0sSZFu3xMjBm+OwQa+y4x2imEeH3hRobH6oV1VlmkdlmpRLJxukuxo+1/7kcqInPsQFN1iv35jX6iNRvLqRs/1jJBEvWB2WsiZdpdb2W3gr6aRVcTstaCBZWSD/NI7qmRyQiXUQDdM15Qi1QJa+YDfb0+jvp5oWo0i3/JUrv+vjD/9ADlPk/duyHdhahTntY2I6Xm4PNWrexa6uVHTX4ITIizurckOMS2ffjgY+JK9GS16HnyqokgN0GW5Vyy0hln1pUn8lCQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ro1JqyJ+dZz00hh7XW/1EAbfRfXIQXE7FvoIkV6rQ=;
 b=4NZ36+PerM/hGJ2WSn6AFA1ZOmqopEplfIg9NuZ1P7hLlPo13MojQjCXBqGd58loPTvRrGT4moBOW2JGtmgQuE5GJb5NGp56U8HzrUMK0pfNseW02B4cks6ABbdJRMlHvZSRadrm8lNA/7seqckj4FUxXbJbEY4EuABwzPerl6M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2454.namprd12.prod.outlook.com (2603:10b6:4:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Mon, 1 Feb
 2021 12:07:54 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 12:07:54 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: enable gfx wave limiting for high priority
 compute jobs
Date: Mon,  1 Feb 2021 13:07:35 +0100
Message-Id: <20210201120735.2970-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201120735.2970-1-nirmoy.das@amd.com>
References: <20210201120735.2970-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR05CA0087.eurprd05.prod.outlook.com (2603:10a6:208:136::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Mon, 1 Feb 2021 12:07:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b49a9be-e8b0-428b-612f-08d8c6aa00fe
X-MS-TrafficTypeDiagnostic: DM5PR12MB2454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2454642A6E874EBD6631524E8BB69@DM5PR12MB2454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+9BYu6lYZH2TCcG9u5rU1eBhbwF8HZxiOuKM2aP9/ZQWIpQCvk9dmzqXWFKLhakBhR+StpBbm+qV4UJZCp4ad0z/O74CZRN4U3zacTfxfuK7zOv/S5STnmRAniIR4Ls506CucQze4UbpCbJkc8lQUPoyUSOdkGMhelM36VfCh++4kxrL5X3Sdk47jWn342APMtDSdYgCoveFTDr0aIQGXYwS6i7lHqa3rGexOMctTxmFqTgRKpXjI/C1L/i6Ks3UBIiIaVuXSgw/tbi11Z5JCSd3hdQT3FAWlbS1hRB7m+sD/mZzI/BcRRNmFzwMRdsf15AHHIu6/Z4FrqcXF9VZekcPtXEEhEs5KVQnl5bcPaHEsaV46g6uyM+0RbKvDovFJT7CaNevJTdm0rjvj4be50EyScDUXE/ZQEMMwzqPIbdmXpTsWk9QWnjz6/B+AkZWXaWb2Dqm7oWkzm4xbvZu0ft42xNhei01LXItAjcArYv42K5QBmBIOf2JUzx/KgBuQjF7vF6F9E2vjYTtVuU+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(52116002)(5660300002)(1076003)(6486002)(316002)(66556008)(6666004)(66946007)(6512007)(66476007)(6916009)(16526019)(2616005)(956004)(26005)(6506007)(86362001)(36756003)(478600001)(44832011)(4326008)(2906002)(83380400001)(186003)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Qv8/noxAIePJwQ321sECtLIEeQ20JMlzkhu8UskzG6qY6vWb2dA7+xOnbbIw?=
 =?us-ascii?Q?k/pmxFwRA3JC8rdXOjGjg/CdBFn8/rO0w4BbNl13YfqfoJmV/Pw5ru47MKKp?=
 =?us-ascii?Q?OiCcM/rtSnq8vM1MertMCZZSshxe0FVObaKDN/dviJLZk6t9rRZoDpaUXM4d?=
 =?us-ascii?Q?0Ewyx+8w/pjzSpD1f87Zx/amFz/NyzDXbbOd4tAk2xA0gVcgM6OXL6sIA8rr?=
 =?us-ascii?Q?zy8SA6x5XBf+Y7AqKAIz9CAU+QZON6SjIVz9W3ESzvrNhY7eIty0c4QWZ7Mj?=
 =?us-ascii?Q?ORuI/9NhSQq6PUu2IIJv6dceGPMANsso5Y6ZyDXf21ZkfRYurxn8DB0iHN4x?=
 =?us-ascii?Q?1k7/sQepBS51fUgu7QeTzLcQKMHknzwSwMEhPlKJ6Fkkvq1H0fAcPO3GpnjR?=
 =?us-ascii?Q?M3s4TL/pM9AY/5VY80drTo+bPYwC9n6XpufFCmP5XRFJC7J41GYWIcdAw25b?=
 =?us-ascii?Q?Tv74Nv9HSfTb8pdUpdqBWI05z74VCSMHI7feHkiOwA/gYkipIsoe3ZpEdlr+?=
 =?us-ascii?Q?7VKulN3XLgJ5hcgqapldkguM3SscDCE+iC+R7YrZQ0yOGLn2eire0LIDo6Q3?=
 =?us-ascii?Q?d3WAYiWkjTLM1x8mH5SETovP3inb+LTbd80qjBX/Y310BZXxb7Rk6vr0NnoN?=
 =?us-ascii?Q?OsIEgguBFtAdt5Piu9tcmWT5pPW7oFH2vZ8LXKwuWlZlMjo29+WuWCVkANe+?=
 =?us-ascii?Q?QhrS4KEpjlCBRkrnDagLbmZw6LfAkpA0fB70azYcImp2IYDlc7LEvQVw1Y6I?=
 =?us-ascii?Q?B1Te4qOq6BiCzCwNdDrL76bm9fgTJBLfj2u5gb3hDRAWweIgm5SUyxwPKMRY?=
 =?us-ascii?Q?aWjgvsdp1S2Zr/lVvODPEEWoC42pNm2wb9EVz5N/G9m75qfQYCU38rohBJDg?=
 =?us-ascii?Q?1PYU57D5/qCpEs/km2TwFDON1LsTOtZbhAYbJ8n6vs6QW5Rt3hdh7ohMyhWN?=
 =?us-ascii?Q?s5GKLYIPHZwilyAm97AiI/e8SO3phYn5tSvG15Psn04ItuCDzx1Q+V0S9qow?=
 =?us-ascii?Q?tQ/5gZUe//xsqCW212KOuub9PmPBJwTnTDQjCX3ep71eWp+3lUUAUsXubhzq?=
 =?us-ascii?Q?dYF7d6tv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b49a9be-e8b0-428b-612f-08d8c6aa00fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 12:07:54.6050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHWEow+xwxe/cuGcAxbbOY60ZzSU39O1R4z+4MHQjVxehVLnhPm/kEMEJ0ITcMum4uEOdab+4og54ZebmFhuPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
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
index 024d0a563a65..ee48989dfb4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -195,6 +195,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
 		ring->funcs->emit_mem_sync(ring);
 
+	if (ring->funcs->emit_wave_limit && job &&
+	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
+		ring->funcs->emit_wave_limit(ring, true);
+
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
@@ -295,6 +299,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	ring->current_ctx = fence_ctx;
 	if (vm && ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
+
+	if (ring->funcs->emit_wave_limit && job &&
+	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
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
