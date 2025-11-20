Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE37CF9C7A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 19:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBE610E072;
	Thu, 20 Nov 2025 19:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dSvaMB5h";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C985310E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 19:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRNnVKZXQSl8bZ4yv8fXinsKeIPcySCiniVXek3wbf8BBGsfTpeOosZJpnW0vYZMqrjWqxzX2N2rNuX5OFYj2Y2X0z1/4pe9+D0gKlkvqboUJLMt1bujQQ4uvEaV0IPwb9q3gDYvciw1BaKBPHRxL8LsGtqkw8zbeeNqZOVrAspBHtfj9u1HgPMHugB5FsH30cgdNuc8RI0tdMSaK+kA4NVYX0HFegeNdfGWuROEhSUtaZbpXDy6nwylKlH4OAEgpsK7CsZJOk09sHQOzuitO0G7LszqNORIlcuEnAug1e0Y/u3KJOXm7rVO0n5AGZKKAck2blm4Wq73e1/Bm/gmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ows399w3f2/iJPSuMgg10FKzFzKOfZxY9tHGySBpY7g=;
 b=Zs+L4uB/5Z0gZndsYMDM8G02raTJ07GtjuH3S+MftDg7QGLSR3IPg5/VHqtai7rRp4BUN0eWUCVKWL1QxvopRTqMrzvwcqLE7+M7ZsSXePdNMoqFUERDX6+7xHu8chrrMHcgKkJipkOoIaE+p8vXPqV8CMYilZZbQsRMWrN/IpDBzZHiSmqxdoHlBUVzrrJtSYVkFQGZjqSHORj0+kaebJKZr6HncC1BvG0yMk2IbTWR4ZHnrbWABLi0234uRK1IoNqRZj7tfUfvMkNprJoTqE6d0T7J3AEpohylL/7ZiLg48WEOBFFzwD1uhl6nGxNsH417cupWA7zmrvVXbc5GDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ows399w3f2/iJPSuMgg10FKzFzKOfZxY9tHGySBpY7g=;
 b=dSvaMB5hM+G1mJXQfnmid7h8DAAeK1liM+bH1fbhyj/NPovJ6336O0HEgkgFBaSZ/1RJiFpwJnP/+Me0EoXXZ/rDJ6srptJUnvWsN8OE3aYT+oLgR6vUjNdT8/OB/SzTHMrr+9LXDsqYhV48YhcaPNx3ehNHG4LSfUsJGR00dEs=
Received: from SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 19:12:58 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::e5) by SJ0PR05CA0103.outlook.office365.com
 (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 19:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 19:12:57 +0000
Received: from BDCBKOCOLOS01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 11:12:56 -0800
From: Brian Kocoloski <bkocolos@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, Brian Kocoloski <bkocolos@amd.com>
Subject: [PATCH] drm/amdkfd: Fix improper NULL termination of queue restore
 SMI event string
Date: Thu, 20 Nov 2025 14:12:40 -0500
Message-ID: <20251120191240.38184-1-bkocolos@amd.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd6c600-74b3-4b50-31c5-08de2868d0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?skslUF4NZ1LvOXgXfM4jb4BVpAkP88lpGXCl/2aOh9qTFR5cM2Bc+khXA2Qj?=
 =?us-ascii?Q?IxfU+2y6bVqGjuQfTYgxaqWsm6Dlk0eGmjB9vnZUFZUsotaZL13hj05X5seB?=
 =?us-ascii?Q?8I9OQZkbs7Wke6ucI6oxTcPU7++1R4xxEvhXn79ywhUMynEuafRbsf30NMPO?=
 =?us-ascii?Q?C9q+gliIqw9kAqXFBB6vYozxjzKX4RCOehAGFePOX0kWtLVKs1zm5Q2lE1tr?=
 =?us-ascii?Q?h+bQXZPIKTvzwoJOk0Uas5cZKIbxAzSii6IXTUjvlSz5uXkU8EOxuWbqy3Ec?=
 =?us-ascii?Q?Np9B1kSYbDoEz6rJWdLfqlUpl9/W0eShwvqNVPhCXQcFeVZZcsJdf+ALvFs7?=
 =?us-ascii?Q?K1tFHORvLmjH8bk5q/FmWIbrtgP89qruOCrqbHVPkW+fKneUktFYrdtculYi?=
 =?us-ascii?Q?eKCmHGfkvl39ceRHdVPP8u3OXIL4y/a0sX59R8uSarbCG8Ab3MrNJWHJogzl?=
 =?us-ascii?Q?wMPQV9iUfU+zXYUrLYgdM4LWQIOmjMdX4N2acShI+8p+15uAJj3kxfMmcaG0?=
 =?us-ascii?Q?thtaFqWHbzmFtq6HV7myOC+ki+n1Bjwi89Z2Osvl1x4FLSoNV9b8LB+3YT5V?=
 =?us-ascii?Q?bcBMpUc1Kgqi/nj3kzSHOgzFfYjew0cebxihP58iy1sMyU4QBKf7b4n4QZ6J?=
 =?us-ascii?Q?O83QPL8zyo8Q6IdrAO/qkzZGv0gJsPWd1jPq8tx3ZxKrRt4BjeYaE6cqBPYX?=
 =?us-ascii?Q?MYWiajD9MWboVWRwkmi+iajAVvvyHMynQX889kioQbO7MzbCZ4Qu+KRTLyqm?=
 =?us-ascii?Q?oF50RmyuZPZ0T7AjNNXN1a2fDFsiE6JDramzMu+fN1wRtNwo/PSxWBcDloSg?=
 =?us-ascii?Q?RbJgMJ/ksyLecxJ3I3DqElRm5nCZrMQz5ySLzxpt4AwxBYYYO9Y4ACsNlwi7?=
 =?us-ascii?Q?29cedgsEztpTtoiGo9exegwd4svryqGVw5XvLgdBW8rsFKgdKUaa4tsTw2KL?=
 =?us-ascii?Q?Juc5fS4vFmSblBhe6go7/EK95uqAZirRTOk+NFY7GzNk0fcbwLry3apv3HWK?=
 =?us-ascii?Q?o7/WfLX5nhLoPkXUBUTYqpm8SeXz2Pa1WFNkLkeffrsiHoH4DY4szJzWMdRs?=
 =?us-ascii?Q?MhJaee7HH5dT8/tbDMF4Mcr4lB1P1+fXs8cAdBHAmBWqWKU/GqtTDM3RI3aO?=
 =?us-ascii?Q?9UkEveEKaWmB/FD4EmmpYW5g5oKFIR/YsVtsV1La2P5VZNwmixOA0NkE9JCe?=
 =?us-ascii?Q?l/6nURvUYsk1iLbjNwm3xNhDAN7lxlUKGrX8bOHWwZVO+LnpYf0k/rxvUz2F?=
 =?us-ascii?Q?oL+EtnPipElYqzF4ppkE6xA/9GC6vKl5glNfJHv4pJMsZrt4+RB7grobQjEG?=
 =?us-ascii?Q?I8FSTLhIabCZyvLn4rbQ/xZ/XPD7kKgt6gMeDv2ArLkRuKlLwLbEaVsLjef0?=
 =?us-ascii?Q?8X7TCL+xIiwRza8sZO2IoyKsTiNA0QweMfrYEiN1Fd9S0e2v/Q4PiGcdQOLd?=
 =?us-ascii?Q?+MoAV0AJ8GsdfE3yhBhioL3Xr83nlfVR7hkQi3QEyH87tkOHa4h7/+FJ0de3?=
 =?us-ascii?Q?YXmIx05VgvyV9785KrvFdcd7DAThF8RBjouaJGwtsLwusThJxK+QDLhWenaW?=
 =?us-ascii?Q?RYPzAkd8Sgr8Dq1Nx10=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 19:12:57.4847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd6c600-74b3-4b50-31c5-08de2868d0b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pass character "0" rather than NULL terminator to properly format
queue restoration SMI events. Currently, the NULL terminator precedes
the newline character that is intended to delineate separate events
in the SMI event buffer, which can break userspace parsers.
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index a499449fcb06..d2bc169e84b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -312,7 +312,7 @@ void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
 			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(), pid,
-			  node->id, 0));
+			  node->id, '0'));
 }
 
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
-- 
2.39.5

