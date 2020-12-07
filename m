Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160CDC4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 06:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F752229C4
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 06:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F752229C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9536E566;
	Mon,  7 Dec 2020 06:57:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0176E6E566
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 06:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9vTKZkm4WM/O7sl4Qedlc14TtF02hjAZAL9nG7cTKgKZKCdobL7E1jsLRzJIr/YlIwOXVm4hgzMIIctJBXoMKUcqwWZ5dcKc/F51qchAKOYnQSpO0hkpptQX0meiFeN7936804qgZICKM+4E9TPea8gYLMkn/vlQtWF6iV9WOXOalX/RHx+3xQZgaeA1CgYEi95/9wkn6VbBxD0F8Lj7Xt3A9RC3f2eZ6Gb0KCvH+Pwqg8eFsd/1VZLruW2FnheivYVZ8YYoyCQY0PPhR/2eDzSwJXCKH5q6C+GkBZqO4qnrY1+UEs1GMIs9Nav6wc7VWu1YUAZH5ib3Bgg3U5HhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NaFndJwhCRjrtepIDCshk9g6h/MC6gh8MV8K3I+EOE=;
 b=UO9hVCAHqmLaxxbLV+MDmL2ckEdeTEos8dTlxO+NqvS73nzx/OygcBNRMIrUtJM9cHkU7frI5mpkS8CZJpSo/izefbWZfyMYAyOltDqB4Hc1ibsFZachbQn/87jOjZ91ALi/7772PAA1uS8xsoj5Mzt/L8RV2m+LCCR/HWYtS7T09BqJQJG/VxD1AroaLqX5nvWHmJhQuQjTwNpOuC7K5ImxFHfUH5B1CwjFJvMrzBx1qwEaHZP3Nc+AyOvhznHSH1iiF6Z9oH7ctUTx05OE4Fd8ObgLD2RGWq27ctfGDKQp9yUfrHiL8wq1NYzweZR2gegqT8fmzb5oh4WgkNlSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NaFndJwhCRjrtepIDCshk9g6h/MC6gh8MV8K3I+EOE=;
 b=4c0aAzwfpFit/F46Ywjmpx2A6dzvks2mpvsgppIoQXBva+IYjhfmZpdqGk3k58pO9ueqrs/QfIvheMI3WACCuRhKd3HLxZplKXPTqg7nqt/UKCpG0QzdEJw462/G3PZ4DTV3az+1AATWXokJP76Fv+7b5/7HlM8Y9EFxD1f/f3I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3006.namprd12.prod.outlook.com (2603:10b6:208:cd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Mon, 7 Dec
 2020 06:57:03 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 06:57:03 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: change trace event parameter name from 'driect'
 to 'immediate'
Date: Mon,  7 Dec 2020 14:56:43 +0800
Message-Id: <20201207065643.29208-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR06CA0013.apcprd06.prod.outlook.com (2603:1096:202:2e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 06:57:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 350718a8-ad18-4138-25d6-08d89a7d4d8a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3006:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3006399FE98E51A6FF6B1862A2CE0@MN2PR12MB3006.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blF/YYUTy3AFjllRs//sLJxGjgPx8IMmywXdiY3wk99EYOWlkSxWjO3anQPobgLLDP7dp6IoGCXvFf+mRvDrnHATHRrC+yPZD2AlVD3kpUaqprpxgZcH9KC1RqZoJc3XfEGWOKAL8IRYCsFrGeEvQR/wx+1QrkLzkKEPA0Y3kAd96TEQl779LcYyK533lrXSqY0MKDTVhrakn2zi4mR0vtsBeW3CrGw3lm1zsOqHN3mvbxU9ME84Nmz0WBTdG2abT9PSvlDLz97zYZa6aWcfRqo2LA8Qs3kRZiqrpyPwLrb07k6o+MU/D7b47TslLN5WRR3wFjzfF72qwNVtLtZX/flJx8EdQspVmgwbxFd8q8iLlwOxRrl2AQet2urNKEMn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(1076003)(186003)(16526019)(316002)(956004)(52116002)(83380400001)(6666004)(36756003)(7696005)(6486002)(2906002)(4326008)(66946007)(478600001)(66556008)(6916009)(66476007)(5660300002)(8676002)(26005)(8936002)(2616005)(86362001)(14773001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/W56o4B0O+tFekiBFSGMSSk2Qi+/wytWpihOvZ0dzxTp0tqtwpnLqxjTQFv2?=
 =?us-ascii?Q?FVFrTIXUyjG15eL6vr8Zb7fJFqphcDxswyYCO8EptNFKQqZPv8ccLHw36UPF?=
 =?us-ascii?Q?MX7Zfj0wEW3vur0onLDPIR1n3nQVlQHcbRNNl9utrDfhPDa09Pjo4gGK59j/?=
 =?us-ascii?Q?Lwk9fKYClf9mzB2ZMSRbAkzMawO30qBkue4czkfLe6rU72D1WY+uXMg7RY04?=
 =?us-ascii?Q?SmhYjb2PFGNYQ4EUodqeADMRvU3WQdrbCsrBLQ7tgKI/tOzwoDP7mU95/acj?=
 =?us-ascii?Q?ykQKF22m4RY7heYRbGsAgfzBRiM4kqpvSu6XI7ZZWyPdX0WUGZw4ov8TlhJt?=
 =?us-ascii?Q?b8fNS4Dp5I12SaKHXn2wHbwujq9eyi686eruMxaOwRT7asPxBKmKOj6q8NDC?=
 =?us-ascii?Q?o7+fOkeI5NOszIrdjItADGgBUSs5IlACt1N+gqFFvLrE9zW1SMtLr6CTgHN7?=
 =?us-ascii?Q?1DumqKb3WiXPjvq0ncftYTTkj7K1C1NA29pPta0nK12wJGoDyoFikTcVXuNm?=
 =?us-ascii?Q?gc/dspyHkpMcs+XQYcyG2jD/VjYtFjOX09Ax44jKvnVC+GpsFAkFgBuKugFJ?=
 =?us-ascii?Q?20OUoQNvGacA9o3lrxpzpn7jX/4LzDqG1aIFUWdxLfD7pYY3aqNCVeYC1CfF?=
 =?us-ascii?Q?iS732o53fv+QCvdEjYR9mW2ijTCyoMEQPVtx2VkOgtLGgz20R3VJtMWh4rjP?=
 =?us-ascii?Q?Kn8U0MulxWNYh6SHIdNZ7r1FLvauRIxkdCpIa+l52I/lYKJI17j1cf0YTj/c?=
 =?us-ascii?Q?G7lefFz816XbajmTzXUFtsh+7fAW+sET9FwL81V08exBiNJlwCFcuxlNVBOq?=
 =?us-ascii?Q?LFj4QYWmXUtc7CiGK/y+3bQlV6OXJKXsPndQqqqGZdtiRUelsYrGJJ3re9Ih?=
 =?us-ascii?Q?Q0/LwUZ1YQXs7yYCXXxVTbcYJUhCikNVOTE7TVs6N5WkCZlZKrDXBS1jbvVI?=
 =?us-ascii?Q?/B05hNYEkWEKBYzH/00B0BWC66kbyj55/JnFGFFo7VyI1i77OxIxGYbrXGmf?=
 =?us-ascii?Q?WHBi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 06:57:03.4464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 350718a8-ad18-4138-25d6-08d89a7d4d8a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4Mu8Dh4+diOXF+/+Lq0OwpDhNUvFMHqUaELjC3e74nIw/oJg7TswSEoO4mWLxEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3006
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
Cc: Kevin Wang <kevin1.wang@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

s/direct/immediate/g

amdgpu vm has renamed parameter name from 'direct' to 'immedate'.
however, the trace event is not updated yet.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index ee9480d14cbc..324d5e3f3579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -366,15 +366,15 @@ TRACE_EVENT(amdgpu_vm_update_ptes,
 
 TRACE_EVENT(amdgpu_vm_set_ptes,
 	    TP_PROTO(uint64_t pe, uint64_t addr, unsigned count,
-		     uint32_t incr, uint64_t flags, bool direct),
-	    TP_ARGS(pe, addr, count, incr, flags, direct),
+		     uint32_t incr, uint64_t flags, bool immediate),
+	    TP_ARGS(pe, addr, count, incr, flags, immediate),
 	    TP_STRUCT__entry(
 			     __field(u64, pe)
 			     __field(u64, addr)
 			     __field(u32, count)
 			     __field(u32, incr)
 			     __field(u64, flags)
-			     __field(bool, direct)
+			     __field(bool, immediate)
 			     ),
 
 	    TP_fast_assign(
@@ -383,32 +383,32 @@ TRACE_EVENT(amdgpu_vm_set_ptes,
 			   __entry->count = count;
 			   __entry->incr = incr;
 			   __entry->flags = flags;
-			   __entry->direct = direct;
+			   __entry->immediate = immediate;
 			   ),
 	    TP_printk("pe=%010Lx, addr=%010Lx, incr=%u, flags=%llx, count=%u, "
-		      "direct=%d", __entry->pe, __entry->addr, __entry->incr,
-		      __entry->flags, __entry->count, __entry->direct)
+		      "immediate=%d", __entry->pe, __entry->addr, __entry->incr,
+		      __entry->flags, __entry->count, __entry->immediate)
 );
 
 TRACE_EVENT(amdgpu_vm_copy_ptes,
-	    TP_PROTO(uint64_t pe, uint64_t src, unsigned count, bool direct),
-	    TP_ARGS(pe, src, count, direct),
+	    TP_PROTO(uint64_t pe, uint64_t src, unsigned count, bool immediate),
+	    TP_ARGS(pe, src, count, immediate),
 	    TP_STRUCT__entry(
 			     __field(u64, pe)
 			     __field(u64, src)
 			     __field(u32, count)
-			     __field(bool, direct)
+			     __field(bool, immediate)
 			     ),
 
 	    TP_fast_assign(
 			   __entry->pe = pe;
 			   __entry->src = src;
 			   __entry->count = count;
-			   __entry->direct = direct;
+			   __entry->immediate = immediate;
 			   ),
-	    TP_printk("pe=%010Lx, src=%010Lx, count=%u, direct=%d",
+	    TP_printk("pe=%010Lx, src=%010Lx, count=%u, immediate=%d",
 		      __entry->pe, __entry->src, __entry->count,
-		      __entry->direct)
+		      __entry->immediate)
 );
 
 TRACE_EVENT(amdgpu_vm_flush,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
