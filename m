Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD03C3065A
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2821A10E0F0;
	Sun, 30 Jun 2024 14:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WGWv3ztI";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3A410E092
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1A2KB2dtbXdqfBds87a2okJsoANy6bB3CATisQ6T3KO5hbuNAKAGrDnnwyKCLnpjkI1Gwu3Ex4Utd4RX70YdtMwbyNf4o2oxG7rvSSn652fEu8exIG2vftXC568qJCP6O2fMcFteO4731BJ+ySg8kYmCFT9iPLySRZjqmYcbTWjQKsN7Dr8ZofThFHwB7buXuBwqSXOcQyZ/CCgrWvTf7sBPFhtcd83pzMCtkbKjXZlPAnI4GjTh24jWkvc++sPy8mkY5tekg0zer1P02Hf3A0xmIGcCUtD7kI0ke0/j7tPs71XngQYZYIakJDmu4iZf1SrHlmOYPLMUz5RaCigzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImIptvh9AIBI4QzSL29Hm5uNNBrzj6hzQUbxXKXExAo=;
 b=M9qB26owrArC0pXlgIqZcCKazmkOLQN+SUXJ/3vtzLAky4hy41FJ+F6h+uvf4OLPiIwOFA8VSYro0M7zrPBcVU9+tr0Z0KAuBJHu5gD32jULKEts0nqtWGu2uJzNySn9o68DDabP+cRwajQK8xk5UB9sVjx+gDrPWYJWJXNHw3CoMBEwD5lTq02ftH5V4QtXy/JbqnFVA/n9ObczBK8URKJtsytQprB5hxlrja2pK8XV8Pb6HGdlZcrbO6gEHr+TESerq5Aw9SM3QdO/2Qa/Conl0oxg9HIDgSO+wxuSQw7SLPe/HVWH8azdrDlY32hxGVAxPHBxJZU7qr0ylJgkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImIptvh9AIBI4QzSL29Hm5uNNBrzj6hzQUbxXKXExAo=;
 b=WGWv3ztI1rC1s+FnaeqiA1tNxXb7PYe8gaBrTrZcu3mP3HZma8BtkGZ8vC1b/7G2o7laBgnFIR5aGNWWOfsXPEtR9HmR5fbx9nKjDz6N/7qYpUxTmuZ4/0Jkbx7X9nHqcjLTWOZVZVtrf8/oC/3+PZhg40rju6PQZCRAQkWtnNs=
Received: from SJ0PR13CA0148.namprd13.prod.outlook.com (2603:10b6:a03:2c6::33)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:45:56 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::c4) by SJ0PR13CA0148.outlook.office365.com
 (2603:10b6:a03:2c6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.8 via Frontend
 Transport; Sun, 30 Jun 2024 14:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:45:56 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:45:54 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: add KFD support for SDMA IP v6.1.2
Date: Sun, 30 Jun 2024 22:45:20 +0800
Message-ID: <20240630144521.2016551-2-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630144521.2016551-1-Tim.Huang@amd.com>
References: <20240630144521.2016551-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 55493387-480a-4146-a00b-08dc99135978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GPDzcLaRVAq+vFdXP/Fv6rl81P9Fs2Dg3Dp4C1aXVs7DTq+JBzIeV92y1RU+?=
 =?us-ascii?Q?19BXEa3YjiKEqmPbzRs8ouMRMPvUP5Sp51YMmiPWmuNTV+bu2sbQg8DFzLRZ?=
 =?us-ascii?Q?lCbJsCZC3oouQafpqs+TEyiGOYhjIWEODG2FEZSj0fuJRbG7khNmyTB6g0FA?=
 =?us-ascii?Q?ERXk1uuZqDOi0tW2cYrUI/KNUQqo1KeY2tj5gdGnUEK8mcPb3SUiKXmyoZs6?=
 =?us-ascii?Q?d3WNVOuputaiRZHDG4isK7DXHHzDGyzu88pKGzGvNJ7QUDQBTSAK9ylRXDLy?=
 =?us-ascii?Q?dZCpM+pqzu0gsnKHLge7JWF+r+a5U2mPY0ntcla+mni/KjoPEWL7ZqUtreKo?=
 =?us-ascii?Q?PAoMOODs1+8unm5APhXhtb0YAvdZeLTabDyzXz8dl7CCDnFOwzw3THP0dGwp?=
 =?us-ascii?Q?fHRnIWABgtaTPwkYWzvbf0JsxuMzei82VjJtoqt4Y1bWRXER8BkpnyfoEnF5?=
 =?us-ascii?Q?JqcjKg2l65D5VPrerGIpQltZM8f/46uqMkTAgC+sdrviM7GvNvrX+mQ2DS2Z?=
 =?us-ascii?Q?z0HudUYWgLKD1BFWuY/cOhYa1LjaGp2hjsJaojDKnlf6omfJvlCF8AEnz3dA?=
 =?us-ascii?Q?f7qI24J1odptll1dEf/a1VmaxooVJ9+kVBQ1nNdOX+6rS0i+YJxJU+h3vz+c?=
 =?us-ascii?Q?qMNs02KZAyAijmzoL1OVuYgGd+sfO7Ldk/CgEc15DkqoSKxu/TyyAd5tVJxR?=
 =?us-ascii?Q?TE2He1HmCyo8TJeJ7Q/0VslO4j+1ZX0Ij1YCpW6mzcqbUa+R++AO5RleuswM?=
 =?us-ascii?Q?YQZ+e65BE56n+VuiPDYfgAQI1lxaOICdBqBTDk6MkTjQfpGKd4fYlroFcEei?=
 =?us-ascii?Q?q+B0oO8bIzERfzBj2ME1GMHkyXNhdrmen0fkSLovHKV2FJI+ew3dT+hZ79xD?=
 =?us-ascii?Q?EJOM3LRT5zZz8qC4EkDcRICVKc2kJk/wtD6r3kEYT8y7ATnlH73oKkWP9PpG?=
 =?us-ascii?Q?wo97Rycf4DjpddKjvrGsMFbKgD18lokp1UhyYpu+xWs6DtaLouWAehbqZJSj?=
 =?us-ascii?Q?Fr9VI7GLacvJbzWBNYyFVJrVh73C19IfApPDAeRzm9/UhdxZufoTgpW2aXuO?=
 =?us-ascii?Q?ZsK7IxJairWKNGIw0C+Pt8S8FM8yiZbCSzznOLGGtg4esh53CLAPAPMtC9l9?=
 =?us-ascii?Q?TyjMNxENTta9QvPZsHPH/LZjj0XnhQOkVyl681TTJsW7SwRWi/Wxm4vCFBn5?=
 =?us-ascii?Q?xK7N7W/8co2CfUSmvOfbsus52YUIpC2HwV79CGHNnMuYXBzjqw51omRE5N26?=
 =?us-ascii?Q?yT1B3rl0Bxmb0HnJRIDLn7e53SMir3T6DlztXyXrPXYsoAZWTpnGl6KVSNUu?=
 =?us-ascii?Q?FYNm//G0oeeJ0OTkcNROzvGicSHQyjE/30LiGHcX0Dl3cbOXR+yeaO8vwvRO?=
 =?us-ascii?Q?y3Kj8CD4Uq7MbB3FI2pew8tWwYuy4HEYmLvzQrh3RPe7LRUf2jMKWYISmnhC?=
 =?us-ascii?Q?O4JVDjAz85ut8Kr7lXaRplOyyxwWlkjE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:45:56.2398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55493387-480a-4146-a00b-08dc99135978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
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

Enable KFD setting SDMA info for SDMA 6.1.2.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e6debd63a116..f4d20adaa068 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -99,6 +99,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 0, 3):
 	case IP_VERSION(6, 1, 0):
 	case IP_VERSION(6, 1, 1):
+	case IP_VERSION(6, 1, 2):
 	case IP_VERSION(7, 0, 0):
 	case IP_VERSION(7, 0, 1):
 		kfd->device_info.num_sdma_queues_per_engine = 8;
@@ -119,6 +120,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 0, 3):
 	case IP_VERSION(6, 1, 0):
 	case IP_VERSION(6, 1, 1):
+	case IP_VERSION(6, 1, 2):
 	case IP_VERSION(7, 0, 0):
 	case IP_VERSION(7, 0, 1):
 		/* Reserve 1 for paging and 1 for gfx */
-- 
2.43.0

