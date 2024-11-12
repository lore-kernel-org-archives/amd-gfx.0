Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BECD41D4E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 03:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F7E10E225;
	Tue, 12 Nov 2024 03:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LQZa5Ur9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B50510E225
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 03:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7GotSmNvanVBJ+4lunjtAsCVb9CFDHMh3e4mWXOOOANTHwBJtAaD4PNUVip+Dn0ZX5OHs1TxITs8JkmmtdXn3eGnW2dmqqDuc8NMUBLSkmhxobKdja6bEi3DrFkkNkYbdbwSN9grlSsbCCB9Jk8u43djOf6SmK2g8P9WVl+uXt9szj4ELFg0UNTsdhnf8VaFDQqughPewqLIQkswZ65AiFdk6CH1tkfJ0PAt58Ft46DZBwBZ8ul6y3qBy5G0ZKkWsLHUSSV5g4S00sl/elWBnIO9SHifeJ2dCb03OScs2Ie1tknKZkpKXZwvSVC7RxaamA2uL02zAmz/cUOKM0+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTVPt+G9dHK/P/z1p0QwYlnM7W2q3ErVBHEO7/PjTIw=;
 b=Jreyx4Kclfhz3bUASRWBd+SHzIpYxDd2t9H1kicKHuz+0+N1GPB10qx1Pw4654JNgRQcM850/Jp8Y1ZurTvxTRg7c5pqy9NsvTXnlEAAWoqwUV6eflJYy+lYQixo1iYuwjxKWB0HDjPimxPBqXFE3hsB1OuGK3tEpy6Ah/Mz/WaJkN6BHdyjNX82ZmRjaAF+JPsLrgTRrMYKDOnUY9GgacPuV9+06YcNq9f00Ic2kNHwcM0Yzj0DSj8+eEotozZQtUXCyQ3ShhQII5bmwR+Axpxk3vmb0XRIuXg6wlzMMr1Av+Dx1KpvGbtAc4hEQvWsyDDFIaHrH4pKXqyjLnJYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTVPt+G9dHK/P/z1p0QwYlnM7W2q3ErVBHEO7/PjTIw=;
 b=LQZa5Ur9NtDJHqLXTj1YtifRMK9YY8RFWaqdm9i42q/Ii5QIAtoiXvzaPphS5ES89TV6rffig3J0QngMGjpVn9WdynkvJe1PGM9kIqig8PVAGxh0krcNmRywAbuswVaAV+qnA21QEkygNKnSNIh61GSt4K4PXAtMzTXOXMSc0oA=
Received: from CH0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:610:119::26)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 03:55:43 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::3) by CH0PR03CA0384.outlook.office365.com
 (2603:10b6:610:119::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 03:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 03:55:43 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 21:55:41 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amdgpu: Add NULL ptr check for non userq fences
Date: Tue, 12 Nov 2024 09:25:24 +0530
Message-ID: <20241112035524.1889-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e1d5b4-97c1-43ad-7dbd-08dd02cde18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8NNsr4oOmtVYmSfukedLIb3o5t7wx5GsTCOkV9p7Om29++LhEhM4+X77itXx?=
 =?us-ascii?Q?S3PLK/jvLcj0LEJpV32gQHh0CpF9LE7q7hUDjDpiyreH0gPB8sCkiFMBOTvd?=
 =?us-ascii?Q?0fd/ZIvq0gUA0N4u3kNdPqtFT9hRngNLHpz4WzDV9lHtRvHIKeX0prECjwVf?=
 =?us-ascii?Q?V2HAYR3DQn8ukXJFyPC6hzygULw3f6cKsFqBk4pmen0n/MGV4nhfgU8yUTkn?=
 =?us-ascii?Q?XKiPIitiTsOf1AwFKko+vUh/5/aYbF3tZ2Cs5XDteZnh2guDwdBQGG1ukAPb?=
 =?us-ascii?Q?jmTt/0xGhSc8Y2UwGIDPFesdkQdPZcVxylNENPB4+bGN1xv+npVmnp8p5c26?=
 =?us-ascii?Q?y8SK5fjxbUDtipE0Ctp0G0yCpRyuWx0dOOSczKFGru/pxMTRIQoL66RruUYv?=
 =?us-ascii?Q?y617nsP3qqL7OFBlnTtz8K6iS4ZSKuBeaPsLeu6JlMeMKU+IvaXDfXhszNPq?=
 =?us-ascii?Q?+Hlti5XAXjHmKyZ4eiVBP/4fOnF6jRtrXpLY9a7n84Z9dRnllNnCeFqKo31z?=
 =?us-ascii?Q?uxUQdr7nRtVLn0miwEak9FKrd+z6Oo7rfxooRT7UY2Oe9zXQhOftfiK4Se9B?=
 =?us-ascii?Q?VymQ6oMYOOb8tPd6UevEP6y1k84xbNHb8/3cGlexT8sHd3V+oepH5YEdxJRd?=
 =?us-ascii?Q?3e+wJj/8TJAV9+1heNsjasRGriAjohcHMd3NpX6KIcnykVOJgiwCYfx5lDzg?=
 =?us-ascii?Q?pMr3XWWaGgNt4fkHTcSDtUB0WGCMvNa7/0OVxzMYjRb5V1Y5LH6KU6VaDt4m?=
 =?us-ascii?Q?dLaGTfFzUrc7YjwmsWtdNRgyNdXB/Tqm0Z/ge5g0rpwVCIWjMFIwK+tufR5a?=
 =?us-ascii?Q?yQNBK1vNmaPpkTEqvdBe1N974hnN2rQYouQVr0SLKwkdghvacPA52aYgfj4r?=
 =?us-ascii?Q?idkU6LuuGMMPxOqjcjoypa4bevwvQDN4K7JKQN4HFJCYte7CR7updhLMYDtd?=
 =?us-ascii?Q?8HbqH0kB7Qe8vsjiIN0GWG6tHirUrXvnlwn1OC4+k7Gzm6sh1RRrqoeT9/66?=
 =?us-ascii?Q?IzRQ1xQfxDJzMWDq1vXQlWZAsfysi+O7gdZhQ+gp+IXIMa92y2o2ec+vzrKm?=
 =?us-ascii?Q?v2BC8ntuS58w4xuCGb6wgZHIzZcPhcOSAKHpe5PoXbIiUyoWQenybCaffwC+?=
 =?us-ascii?Q?RqA4j1uLrOPrvWXa+/T/w11tlEI36m01LX3f6EqRqlW7dIi04+bZdfD9rpBB?=
 =?us-ascii?Q?tm1wXbDttponiUqs8L1Il7ocB7iltQHYloWacHHynHbsP+Sju149/GU/vvpo?=
 =?us-ascii?Q?fjgSEYiIvcMdtV7igQw2b1UaORiEoiYR5/Gyeqg0ix8b29UXVPuXG5ZK9+nA?=
 =?us-ascii?Q?6dPp+tooa3LXWcmBYI0ojRRONAjj6p36yhtBJqTd3UWfVoL1gFFAT7yaeJRQ?=
 =?us-ascii?Q?LXex1/QGodW5QbiMuUirY7OwNE4q2dnAaTyp0SiKQ0fRwPewZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 03:55:43.1198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e1d5b4-97c1-43ad-7dbd-08dd02cde18a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292
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

We are observing a NULL value in the non userq fences,
thus added a NULL pointer check just to avoid the
NULL pointer dereference crash.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 6157a540c929..482346333a89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -821,6 +821,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 				 * Just waiting on other driver fences should
 				 * be good for now
 				 */
+				if (fences[i])
+					continue;
+
 				r = dma_fence_wait(fences[i], true);
 				if (r) {
 					dma_fence_put(fences[i]);
-- 
2.25.1

