Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A070CCF9E5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 18:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16C8610E17B;
	Mon, 27 Oct 2025 18:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yEtetx6b";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733D710E17B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 18:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3WecpwlNvceKQG93oXcLvtpWPEjghTi+FMnrc5MfEL2/GrmvoDXHgR6WeXUWg3PWJ1iy1gaLXv/o8L/sdZPMO0zb1I5M0uZ7GeHVjjAulQH3PhHLQr3jhEsxuFwF0KWLZpwiik3/61Cj7/ey5LFbfLh431KYRcBeLREArDUh0xB2npWShxK42/Wsmuvds+StC4rTMGQKmnVffWMlxSIo7JUuk4r5755EPkkGlPKlLXDv7TmVBl/8YzzvY6EtgDUqq8VDAlCvvNQItBMgJTh+OGgEpdwjLxQM045xcWgOEibQQOnzHpYqj2LaSMyiSTDhnpG0XanoY/ro2aFtwjNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+NZNVu5TLOM9j4NwUdNFJOEXDAkthtBW+WJxR++1Wg=;
 b=ynJm2rBaE/oNvF7ZFRL0faFy99ZDR7nh53FMgcv1moQcOIc5HT4nubDzst8Y6RN950zX9nRjheurziocf4Ko5S44s40tmPERM11+68/9GT+dK8LUWaucBLq9cyylBLmGw2zXkb1pVJlxreEKQ9mivGFozSlraevBDQM+U3xEW7A/3JD7nTVswPBBu407AwZqjxmtOqh4byfZSDItOKFGtRh8hSgNXnVFcdZHjin2NmUcp3VQeqvXjIy6yWyj+KxnWlLYK5OSpk5h0xL4Gmj8A6vLE13esJPEhtYeiToukEsUPYjq9n2G8ygAvNfHkpqHNLCuxGtcOlUq8/whxS26cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+NZNVu5TLOM9j4NwUdNFJOEXDAkthtBW+WJxR++1Wg=;
 b=yEtetx6bYzR1w7qO/WwqSyjTm04FQLIKBxjGu6PcgBbpiADshZ6069AvYwdJpSyLLVZqcKrtTF7YWgVhxLYS95kq2vDK2eT6FZOI+NUtBQduQ/ePW+yW2ZdODcrry+0cGa0f76e8qOLNdMMOE331ebSMBeBwQybAtO5fSVwMCEw=
Received: from PH7P221CA0076.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::32)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:08:50 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::78) by PH7P221CA0076.outlook.office365.com
 (2603:10b6:510:328::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.15 via Frontend Transport; Mon,
 27 Oct 2025 18:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 18:08:49 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 27 Oct 2025 11:08:48 -0700
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <Jonathan.Kim@amd.com>,
 <Felix.Kuehling@amd.com>, Sunday Clement <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Fix Unchecked Return Values
Date: Mon, 27 Oct 2025 14:08:08 -0400
Message-ID: <20251027180808.3022439-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 359dd41e-e105-454f-f93b-08de1583e105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H+hHNmVLAXsq/2FYMNGEfd29ruzDlfsJsXXQkOCMM7lf8L1mxKMWo3oqOfoO?=
 =?us-ascii?Q?qptlCAqSmRdrEdYhwIW/h0ty4Uk7n0oPb1uLSnnbbTqIcSXrTuzY6MJQWNRw?=
 =?us-ascii?Q?b1w57PGpS9yBdnMsZ4DnuYzlpwBlFwcRxYzna+LA6twQ1VRxJWKoNK7vhPP0?=
 =?us-ascii?Q?HXcaI9lDkya4Y2aqpnbXv2HkZHmeWyvH2D9QsMLl5wthBTDQx6xhufz/j1Z2?=
 =?us-ascii?Q?19yOsb3Q3wF6qbg7U2/33gctLgqjDVdxXp0tEW3H8vJEZI7hZkoiAkOvIJZK?=
 =?us-ascii?Q?U9sg4mW8jgHKF/RtIotRZp+tGa/m1SFo5wr+U73H1isL4/2fOK+mCbKyEW1a?=
 =?us-ascii?Q?Nqi6+frx88F7fZGchVPuFPZ/Xi6xILOB8tzbexEi4nM9pO2U8Oqu5ItnseJB?=
 =?us-ascii?Q?yh5Tnk9NhDG/KQkIvfnyKJ39F0hyaPpJTBR6VCDgtz7LYIUJBltDDNCR+zyQ?=
 =?us-ascii?Q?SLpeThq1S6Z+d5x0CW97QpI+aorxsTqgk1cWIl9NkSyedKG1AAvFlj5iSxJV?=
 =?us-ascii?Q?TT0DpWrdR3E6hNYEgl7KdQjFPilItbny5PZxxkNwj3q3c+trC6xSsk55zn1Z?=
 =?us-ascii?Q?vGmE78+qI0jMOj02mshQFlEhxhN/0GXevbw5TxrornFAK8zuO8AhU3t40By3?=
 =?us-ascii?Q?PkVMMbLImEczrA2lXtqPfFKxJWCxrAD+c7FAn+E+B2NmWIXtult3JHzwD+jX?=
 =?us-ascii?Q?lEMeceiMe1xokq+dAj9MVuPjvxfaXCaNzLHHhJqV9koVaZUmx/3+ZaUCh7g5?=
 =?us-ascii?Q?hN6RZy3hncIvzCHvIVlVaPohzl3QWOCg/ugvU61CfI+JOZpcwRWkjrD7k5J9?=
 =?us-ascii?Q?dObk3/atOmYFF4udG4ZFhcRGL7BqnaDHUWQHGHcHyfhcXZfpTlP6eWoPQfV4?=
 =?us-ascii?Q?b45pfE0aV+EHYDIjf2QyJ5tiZHkVTvHeCLgXTQsaLNByhkAWYNr8mk+DKlo/?=
 =?us-ascii?Q?0uiwV9JkrwzElD7MBEWb5oBx6N0STkdXjE6u/cvqWj4beNpLPMnn7NKnp7CK?=
 =?us-ascii?Q?BfgwgREd5dx7SQlF35oW+jfQImRRSTPc/2z55RveQ3ZrODBojmPfBYdpNunS?=
 =?us-ascii?Q?dVtY7b0bIE2r7kSSIgBQJ0tjtu3xuuy8dj8UqwFGU5e5GOBMxA+1zU/tFpwK?=
 =?us-ascii?Q?XduLq/kX4dtctKeRU1vaSYyXsguifdivEnotq3R66zE91FtCBVGX8/74vSgX?=
 =?us-ascii?Q?Itmyw+a1MhG5gqBgMlp3C0VilPK2ER3n9SPhI41WMQ9wJZKaiglHEfzU3mll?=
 =?us-ascii?Q?CBII0P9I3HGihJU0T2Bxu7MrARyrhJP9uYJ7cCmyJnUBwomO1zei4+q93LKn?=
 =?us-ascii?Q?38Fg2tiD1xj0zWsTY95J5CPDoqMIspK/5gYVTqQCJ5zK9IoyYplqs9wgVkzE?=
 =?us-ascii?Q?46jsqcHWia56a6/Do7hdjV/GuYYvao4UVtDciY/n+JBjgs7FuBvM4KpwTYJ8?=
 =?us-ascii?Q?Fu1BkSM8PSGs2ZO6NZyxAJNM3iCD9PhfLC8nf+QKEDbeY54BrbhSF0BfeBfm?=
 =?us-ascii?Q?alwQUHf69DBw8fiCZpNcIMyjncE+HybBCJJI1WuuyTeOv3IGpV0YNDCFwkVG?=
 =?us-ascii?Q?lLTN2Xc/PuYn5iiZK0Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:08:49.2490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359dd41e-e105-454f-f93b-08de1583e105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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

Properly Check for return values from calls to debug functions in
runtime_disable().

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 0f0719528bcc..8d096f52127c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2826,7 +2826,7 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 
 static int runtime_disable(struct kfd_process *p)
 {
-	int i = 0, ret;
+	int i = 0, ret = 0;
 	bool was_enabled = p->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED;
 
 	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_DISABLED;
@@ -2872,14 +2872,14 @@ static int runtime_disable(struct kfd_process *p)
 					pdd->dev->vm_info.last_vmid_kfd);
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
-				debug_refresh_runlist(pdd->dev->dqm);
+				ret = debug_refresh_runlist(pdd->dev->dqm);
 			else
-				kfd_dbg_set_mes_debug_mode(pdd,
+				ret = kfd_dbg_set_mes_debug_mode(pdd,
 							   !kfd_dbg_has_cwsr_workaround(pdd->dev));
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process *p, void *data)
-- 
2.43.0

