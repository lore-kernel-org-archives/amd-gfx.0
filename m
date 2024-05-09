Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41F5C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 22:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F015A10F707;
	Thu,  9 May 2024 22:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UDYqx6XR";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843BE10F707
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 22:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeEOGOSSj46CVH4O8Zt8QGWmn5e6d4htYVcAI8KUxAmoPf4l/Gzn48dqDAj0H0LEcpokZIdmj4iza1rqVvjOxqXqqav9yImL43C41dvJRjNRK9hrHjFNUWdMjoW6Pib/RSIJ9R17XBkUrVV0n2QS11h9QYebsnPsBEpLo4C7zhyo7TkfMufuLAgFqkD8HZERvs0sifSTopbSouRsht9yMX20d4Fwswp6ffdeSV0IOLYwa9/h5yt4DSLk1GmDHtLxvKM1tEuVY7s1hPdBi4aFzXZpPFrjgr+VihAlVIHDPfxzefYGGDTw4oLr+lm1jRsklgPl1rZ1NsbM/tbc088QKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6P2B2V+S2kKVVdpIzvyJEEFnfYHs1HOjzVXeCC2zhA=;
 b=dAqF3kOut3kfkvwBV6uwH3P/3QMc84bG3R2D4Xwbyv7Z3OTOca1DATyIrdI1QJcuF3aZyQhOuzrHobxJnLimFZKhGfRyiKp/vw71hjg0xb0awPu11Mxzks+tJUHKYGI6WJalGWqczJFu8QwzO4X4qA4+M0xGMm7a3uZv7WUyPTvSNoHK4nOyOHz1Hz84zMXSZAkbfzZ6JO0qjIsb92LHe13wsRxAnLhuuY6A8oHbf6hOzZdk9xvtM7XgnieV7TNBAjLmJUMABPGf3ZESyHfXV2Cwx9SFB2LewEe2CR5sIvTX3UOhcvWQ+xvxSh5Vria5bHHV2jNy4zzsSBtm+gO73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6P2B2V+S2kKVVdpIzvyJEEFnfYHs1HOjzVXeCC2zhA=;
 b=UDYqx6XRSq1zdv6KVKEmI2Tr1ttqB5JPfMbv7B0KEmmA+SRn6Acc5/QshWWc3FKE6Z8HxVqkcdxCQMMrvUB92c51djLBNGVOMWY/Tbr/OVgdIULACHtn99FvEe+FcX25Tecl8FozRCZBGFdfvBT8RoAQdSNzKsqwRr2i7X5Uo5c=
Received: from BYAPR07CA0027.namprd07.prod.outlook.com (2603:10b6:a02:bc::40)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 22:05:22 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::8f) by BYAPR07CA0027.outlook.office365.com
 (2603:10b6:a02:bc::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 9 May 2024 22:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 22:05:19 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 17:05:19 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdkfd: Fix CU Masking for GFX 9.4.3
Date: Thu, 9 May 2024 18:05:03 -0400
Message-ID: <20240509220503.2297691-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d996a5-86e8-42f2-332e-08dc70741df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?84WMOAETFouMeWcufahrtKrfbWAqyB7Q6ibwsZoq3oa/h79e2ZATeQwdk3h1?=
 =?us-ascii?Q?bvOYWVLkNtc7igPXS2pmvOMIzrUU5awwHFUn8OICmKS4+QhqxanvfHrO5EyR?=
 =?us-ascii?Q?FQuVSZvXyjT0tCU1xVcSWG2zjMs/zuSm9d5qlQPaPG/q0oX553x5oKZid79M?=
 =?us-ascii?Q?OnMi8BBYnV/uELIfsDQj8mYpcM49fZrHyrZe09ZvZOuUVJfL+34n91cN1qyB?=
 =?us-ascii?Q?1whxAC67an510r98JjGxwoTkgF69cBtPbM6UeYcJPD0wItP50PwTc8muwYdm?=
 =?us-ascii?Q?3fXhi6zI6vrM/GCP1IwokrQXYVO9on8BORcghAxrPCQIVH/XLhQdvmQLT1UI?=
 =?us-ascii?Q?StgpZqHZ0aYQl/60yQHXeX3pvja8QpwPtJd5AJHqAHgfDTXg510JJtmkwMHI?=
 =?us-ascii?Q?qI/5YJFc6dR0bXPrV8pawZQhMxZG1vjAQXniBWfYq3OF9938iId3NtpwEuh6?=
 =?us-ascii?Q?Y/8pb1/kPjoRtgc1WSR0ZvZ6sAHsHdlsZPoy/FR8ltxq/8GlUdgAhGxQh7rW?=
 =?us-ascii?Q?TG8pGnM/OplBTy0m0JhgWYpt1/HHGIDHxkcYCtH0HYl9AuncijJ+Uo4ry+HK?=
 =?us-ascii?Q?nmKXFulNQ5wJx8R3fU/OS21dv+q74TaPnnIKBMxnH1LBMJiskKFYoy2e4XER?=
 =?us-ascii?Q?1b3WaqjreOp1E4iINC3GAONI8TqyLnDGxFM9JRGakzJajYlwDNbdeWzdWZQy?=
 =?us-ascii?Q?dowvRR7oLI8XdlaLU7YTLC80hsbcHhMwUMoq9bZqYxnr96Eq5w7R5I8efSTT?=
 =?us-ascii?Q?4IYHo4NV1MFylQ2qu7p1LvJ7t7XKGpzNAXUqwVtDVB1ztl5MdL607Fg7wrIJ?=
 =?us-ascii?Q?pFKXdXaDOsKu3gvhpiixRwDEBc6f0TghijegpJ1XPPylW4/R2chVIgPD+imp?=
 =?us-ascii?Q?YEHGn6mKR8kjU13TOEawbXMKfJOSO0ntWGut5EVDG6Ok4sutuAh/3jkU92wY?=
 =?us-ascii?Q?JbEraB7wiG6+ZA1HgxOwuP6QrWvg7aM+I5iJlcr0teB8BOlAeaeLjB7S4tz8?=
 =?us-ascii?Q?XGHGkS2wK69kkAV+G2h5oBK1Q8HMVgZR7Jgpaju/e+pj22KkL1lzOFqtpU4d?=
 =?us-ascii?Q?lWrKV11DlQWSu199A+1Fwaj/OPE9ZKUewqajtO8YljcoXobFsVr27e1v9LuQ?=
 =?us-ascii?Q?kw8gYkaRTN2zPu/KXQiCvohCKoNVHXJvTcNuVE0tgrbFtXK97RY0o1JLRcLa?=
 =?us-ascii?Q?xXMs4kIOEOPR5YiGqrg1/+s++O11v79USwqPerH9xwlImRB/x/ckEaMdchce?=
 =?us-ascii?Q?greRzx3ZjP8tkqUKXLUB477VBNOf6oFYXu9QbPH8k63wQL7IpJA5UcIz3woO?=
 =?us-ascii?Q?gqXEybMYtdkz6lxjxefJGTZRS5dY8J/rsq3gP/9j30pULCUkgBxV4UyB2YQY?=
 =?us-ascii?Q?hKmuT5tzIVIwr3gaq7ny/A7Hs06H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 22:05:19.9840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d996a5-86e8-42f2-332e-08dc70741df8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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

We are incorrectly passing the first XCC's MQD when
updating CU masks for other XCCs in the partition. Fix
this by passing the MQD for the XCC currently being
updated with CU mask to update_cu_mask function.

Fixes: fc6efed2c728 ("drm/amdkfd: Update CU masking for GFX 9.4.3")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 542191656aeb..399fa2106631 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -715,7 +715,7 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		m = get_mqd(mqd + size * xcc);
 		update_mqd(mm, m, q, minfo);
 
-		update_cu_mask(mm, mqd, minfo, xcc);
+		update_cu_mask(mm, m, minfo, xcc);
 
 		if (q->format == KFD_QUEUE_FORMAT_AQL) {
 			switch (xcc) {
-- 
2.35.1

