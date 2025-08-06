Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C73C87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 02:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E2B10E2D1;
	Wed,  6 Aug 2025 02:28:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mCfyW/Rf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E4C10E2D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 02:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adKaoEyk3nzWm9Hn8M1o0lPy8mMPJ+wR8bRQ5USZl0UFN9ekwbrGFBVosyoXym+6vyDnvGzsVrQK5f8OySMMRdC7fd8GYUL0ltb4KjRtwOVooXQsGx+Ikipd+9/upSnhL7I7koREuxjjXroZOyqcaZwNFQ5j0rDFSS899t828gkxp2zOQ09W0EjA8ts1/HgU9YO3NSCP5mpKIsMINqpEa87uJgQmuLynU4OU/bhuhwIfaMQAABj38wjOnbfGs8X/BOXJc8q7EYqUAhNm3kqtwdLyzaB4ZugM+QXVVONq1WlW8B104uJrae1Cq7hY1VFvkooTDA8Yk77bSVRja+zBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=suZ8XmXKTkt+G0TKSA9xUKO6jEzjMEXfITUb9BFwzv99EjxIkHb4GaDT+c7rihm9s1ygEN1YQ/83oxsTL/Auf6RJkmYeqQUAgThWIO1P3A91urcGfqXl0HPC+A2R3nAHDR/kbXYuQccNlplRgTGonLAjETnTeN8pXpXTwlBw4NurcHBkvvvY6c5Av47WtjFkFP/Gu8zcng1zu/8FBebRV9EcXQW4/+Q5tuGo4CPKkIm01TKpMBlHeiNOlkExdEF0hhuLK/5/5gzlBlpLlvi3cCAAVKC5x3CKjyI3nQNXEbaVeztMpC+VVTvle+TxCBY+gxuPGcWDl2vvxq4ZM5IpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=mCfyW/Rfyc/r7XxG/GhNQJEa0YxvS9jvEv8+s5WM6uiZ78UO/ViTBCiLf1rL3U4dhtdJ0npN5xhtfuyAZ8fA+GRayc+lDlnLCbNBU9gn07HCVVGaSbGD7DN8HNaIsKzeDAeFAROkzJyjjH5S5R58VgZX0RWSbcU1amG+ImU9uHE=
Received: from MW4PR03CA0288.namprd03.prod.outlook.com (2603:10b6:303:b5::23)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 02:28:25 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::3) by MW4PR03CA0288.outlook.office365.com
 (2603:10b6:303:b5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 02:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 02:28:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:28:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:28:23 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 21:28:17 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v7 01/11] drm/amdgpu: Add preempt and restore callbacks to userq
 funcs
Date: Wed, 6 Aug 2025 10:24:46 +0800
Message-ID: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a5dde4-5188-4b34-df2f-08ddd490eb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FQWwFmfkqg7d1r7JFZBiRGlM9BEXPUIHWdOGXUR5vlDe9VaZO9nJJU9jzZQS?=
 =?us-ascii?Q?ZIkiOBNfM1a7wIq/3fHohptb+KN0ha9X1221XnzfiQsqnhYWc8Pn2Pgxgu/w?=
 =?us-ascii?Q?Fu609+5GK+PZ7EHzoAHmCYdEo2eEaADoYt6HHI2foP3gDPUnocJDDtqsgAzU?=
 =?us-ascii?Q?ozId/W1MjMMTufUEyW7aGPGLFp34TFOOQD0iYkVXdaLhYUE4f01WxNKukHx7?=
 =?us-ascii?Q?I8AazhVj2Qa/Abbua+m2vmZFuAM62zlV6CrAVG6njksNVQqwYYlV8GxguXHG?=
 =?us-ascii?Q?hORUpylqdJdZHIJlPpbIZhIJssfnLMOtTsurDuQcu2RS+UMX9rVybudHXhlw?=
 =?us-ascii?Q?JRCgItZ6zLxXP+8lEgcqKjQfKGlxmMVDBgJZx+SM9l8tDYlUmX5a9/mHK2v+?=
 =?us-ascii?Q?I/osFzcA90/vvuZng5Iav/BnuEEm5y98o8gRtnpeCIlwJ1WoB00UJaj+/X9t?=
 =?us-ascii?Q?6j0SXa2rl3xB6D5T9NTW4HdJ2j/+y46g/gJRq6A2yCKXbkpYGPmKHB9bd04L?=
 =?us-ascii?Q?lxBOvuTZyVHOTtIEKFh+I9c8izwO3CRnFoJw+BYGNqfg9R9ZJtCs3+Fcbsj8?=
 =?us-ascii?Q?D2mVX4Kz9Ui3Ig/h+/2Q1j8ha1nZHzjmF97osTXCFKPcBVjBmxLGEPpieMir?=
 =?us-ascii?Q?pZup93WoGUH+w0fiLdx/ft85QhtZnNhkC1e9XhCTFAuXEm3YO7UM8JseTXU6?=
 =?us-ascii?Q?SROFdw7tDwTZ9Ke78GJlo2bRytOsDXvs8Iwqs5rCfGGTTk7I2HFAGQDv5s+L?=
 =?us-ascii?Q?BMTsIU7dCTJdIMpiD4q3h7m0GSTFTDbhuVF9U1NDp20Yg39etVNA8/oBDzuJ?=
 =?us-ascii?Q?AlwaWZarop5h9RlyuRuXs1BMoXHAWzmYCdHv808UUNmymNqck4JUHwPBL9wI?=
 =?us-ascii?Q?E0X3xuEbMKlzwPeOuwhz28E2faZzd4HPw2KeT5WwFjV22ikTc3HTZF+DCy+2?=
 =?us-ascii?Q?rUx1D/WTpNmGFGlld7yhmeBXFOKSSkQD+vwjOs7zUL5cJEeKlrFJJDB0I4nG?=
 =?us-ascii?Q?+xCBMz4NbDgL9iNUG6tFJm7I3Gdd2upqWdbflVYRoCEQmGSKra4LRfhcP5i7?=
 =?us-ascii?Q?w3/CgCAdIeHmkZbVMjIO1L80XuqxZmytFrlUBBs43Jozecc6yrKIf2I+GROm?=
 =?us-ascii?Q?byRBdneM4E0DrecXaakUfRUByi7sjaVkXCl5q/o7Ej0UuE3TgjKW/nPPo7sj?=
 =?us-ascii?Q?6JQplqFudIGH6ODrSx1ufkOgGFmhblCpTaPPt1BLlaEakHzCXxml01S9o78m?=
 =?us-ascii?Q?DavpAPxcN7lL6UN2uU13drF5RUOfkwCIP3WI9vmhda7ERWdV3eOmi5dpXh/Q?=
 =?us-ascii?Q?yIGGWT1nkDvpw4I2w/Uhsn1E7G2cZ3lQhkUgpP7xi2wZ5JJiaPEIcdLIAmox?=
 =?us-ascii?Q?y6+b50397yNOJb3KmEyUqeYfsSiC1IlWd3g1Ereh8KOiS2Q2qxKYIB5He7Nu?=
 =?us-ascii?Q?OcHthWgxsKH5fiIP8oa21DI3Y87MfGZYus8r262VbPrMzjiVbDmUJZLJS0EQ?=
 =?us-ascii?Q?2F+zglL0UyYzFwpFkwCxmmGRiKEkqPMlFtCf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:28:24.6008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a5dde4-5188-4b34-df2f-08ddd490eb77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
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

From: Alex Deucher <alexander.deucher@amd.com>

Add two new function pointers to struct amdgpu_userq_funcs:
- preempt: To handle preemption of user mode queues
- restore: To restore preempted user mode queues

These callbacks will allow the driver to properly manage queue
preemption and restoration when needed, such as during context
switching or priority changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..5111d7dce86f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,10 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
+	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

