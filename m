Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D05C25B4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 20:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4EFE11296E;
	Wed,  8 May 2024 20:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3CBCfOlz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D313711296B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 20:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqmJXCITGrqj08dGH640a1J8wzGbOTf5/NN5m1mJwM9Q7qY9EBADfJiBlaHEDlKQiNanyuC6HA7lp/utRMbcG5vmThB3D+KAwZbyJ//qLeZMZxSn1XdxPkXhlufkezlMDYkKd0yRFKU4Y5jY0xrMoke9YCFdzpTRLTjpUe9cn3gjQ8wa9z+bUV45kaLHn2lA0LW0bOqKvhvwAvRXqtZnOUQ/dF+pVYyxoaFYtUGk2DLbGz8QSRBQZJrXlv1OArlt0csS1rwHnxrFrfRZaoUDg4sYrlqgiv0tVWJpm11xvcNtKlxOt3RqZ3TmkXHhCi8ZiXJmsork7r9qFjqjWydChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2UGLhYGr3kHJaolmm8hUdvNd/DKNP/rlbrA46fAhoc=;
 b=Wa8biNptH3l88dO3PWyhPDdicv8lF1kSzP61xMF9n3uSsKSlAfHXCY4u6N5AQPqPq8YMPHmfUQxOocxvwUcTScD7ZjOHTLQWkrRCwbPZlsalxGUE1yskhR3VeuTdlJzoSfRwKsUamOkN+W2AgPAvQf4qacNMJnOqHeUQTvIY8OmghEqPa+hobaehdShlTg2UBlGnC8Xi2b6VnoqaYu4MaABERga3G5cwOyEZ4oco1blG1KHXhONNDJ4SWPf7o9xAZROwYsJ65aHyQ0aLdRw1fCaixaApRZVYVenS6cYJdOVSVtnqQ4zu3A/V/3EVEEH4yquPD3Pzsowm9M/GpC/x+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2UGLhYGr3kHJaolmm8hUdvNd/DKNP/rlbrA46fAhoc=;
 b=3CBCfOlz83kP6P6dzfaT0xFY35Tsx9UiLva+Jizwvbn67ZDO34lA3CnvR0HsQa2g+sZ5aeLyWD0u5a4iTgOhGEAPIfS8f96EEbvssjdYj5++TrJA3haYG++mX0HmkwObPioAtAd8c0c+0J5ZKTvPqQ1uRapsy0Gz87XG0qsR3TQ=
Received: from DM6PR14CA0043.namprd14.prod.outlook.com (2603:10b6:5:18f::20)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 20:29:11 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::35) by DM6PR14CA0043.outlook.office365.com
 (2603:10b6:5:18f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 20:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 20:29:11 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 15:29:08 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add core userqueue suspend/resume functions
Date: Wed, 8 May 2024 22:28:35 +0200
Message-ID: <20240508202837.1411-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240508202837.1411-1-shashank.sharma@amd.com>
References: <20240508202837.1411-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa0bfc9-ddb5-4de1-cd18-08dc6f9d851d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UHQa++XtwzgttVHc9CbNvIM4J0n6h4kIiN2SGeILADuLcJc+F6R9KVbzedOz?=
 =?us-ascii?Q?L1WQqRS5JFA3IvqoakhK3G4I1WXAc9grNcM/Aa2/8W9QDOo+BOubL1oLlYxO?=
 =?us-ascii?Q?uo/PICnRy06J26E0jfxHYNRvWAssGzekb3AHCt5pyTzJ2n/K1G0F0E+WsDQW?=
 =?us-ascii?Q?MgzyNEVyDi1dCelRLg1nVGstna1LFUFTnQUM+OMC0h9NpRL/8lel5cd/gZq2?=
 =?us-ascii?Q?quBg4PZvWmCmdB8hLa/5irkE1/lbpYhm2HylsR+fss1tm8eILsZFJWjBbjV8?=
 =?us-ascii?Q?TtEjKDZhbVw4FOtGvZO+Fl66x4DXbrLdVdPjREEdamzECAWOEd+8hhOCSub1?=
 =?us-ascii?Q?B5D8sCnOteZmeMHoQkyXvfe1xAbAdrJUnj/iCnz/YkTgZqYiPT295s/KGxYp?=
 =?us-ascii?Q?mTtUBA1rJeZRwGSiKhoZt8anLv24ipTJzNIIhdBiyEdtn3odhxtLdM4miAq4?=
 =?us-ascii?Q?BnNH7vb01NpJYJrFTj5UchwAKQ2U4TA/uvUWrOsrBLt3m4d4ZcEGOmE+EKqd?=
 =?us-ascii?Q?/S6lRR1zk2Ge1p8tTb3QAiSOT866Shh2mshtGVr/8jfLF0zF8xLicfFxFxUT?=
 =?us-ascii?Q?S5Mn+Udb+ALfMg4wWnkl/wr1ptmoizEJYMC3msqZRg13lYvbhROotq0xIIPy?=
 =?us-ascii?Q?kw3FHRrTsBzImSVUNDzSkO3/Xv1kYIL4hNeN1dbv16TPkt5mnGTY3fzRgpSE?=
 =?us-ascii?Q?sG4Fh6+MxWPh+h3t0kmz9SkVrhyeTEvOoT5Q0FmPGOGcJNiHt/sHPYjwisV/?=
 =?us-ascii?Q?M9xfjIs4e9pwj7BPFtJTDtn8/sBgjZMm/6+yEEpAF3N+G7XgyLf3nkKQveKe?=
 =?us-ascii?Q?srJhtK1IO6hEeQhYI2CrlFzLEj1V279p4w58m6VOKCnmEUUkMNKrNOaqYxQi?=
 =?us-ascii?Q?p7u4EMsMTheUHZwxqoR8nzNs2xP/6L7IeVEBWa5GSpx8DA0wJvHvT2x9lz3w?=
 =?us-ascii?Q?wm1GnL5Z+3/Fa3M5leWKrWY8cdiahktDtIR+dzhTGxottUPmmp3YCXWo7BJL?=
 =?us-ascii?Q?mDOjNcoDpao9JS/aU6G0pgTOcZGz9suaaICWFR4ACX1MLM1anOMjRNff8UTW?=
 =?us-ascii?Q?XBllxCEHRY97n7+DiAJoTDaQZJFLEa40ImhVk487ah0c4Xyt46fzwhjXK4Ex?=
 =?us-ascii?Q?HvrHYrLMXekoYnGXCVEeNPJHUDfeCnPnj3gniLdEDaulibuQNu19PpYQXGXi?=
 =?us-ascii?Q?ZFQ6AFLEX1tKet0/4rGTJDIfAdaZHfTr7TMMx2zskw2pOYoAfJHQMFSBgEjH?=
 =?us-ascii?Q?B0gWis0Fof23kGwzOj7+jvLGiiFGDpp3huIybW1raYhuIjiX+GNK/tcgAbkA?=
 =?us-ascii?Q?TFPKghC1e1zoYfqRgI2ARbnTx+3TjB6GB4ajkfFyAMGKF0M33WJVFnFGKKR2?=
 =?us-ascii?Q?E+LxaWY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:29:11.2701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa0bfc9-ddb5-4de1-cd18-08dc6f9d851d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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

This patch adds userqueue suspend/resume functions at
core MES V11 IP level.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 31 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  5 +++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index 412970376b49..4e05da3c8f53 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -321,7 +321,38 @@ mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_v11_0_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
+				   struct amdgpu_usermode_queue *queue)
+{
+	if (queue->queue_active) {
+		mes_v11_0_userq_unmap(uq_mgr, queue);
+		queue->queue_active = 0;
+	}
+
+	return 0;
+}
+
+static int mes_v11_0_userq_resume(struct amdgpu_userq_mgr *uq_mgr,
+				  struct amdgpu_usermode_queue *queue)
+{
+	int ret;
+
+	if (queue->queue_active)
+		return 0;
+
+	ret = mes_v11_0_userq_map(uq_mgr, queue, queue->userq_prop);
+	if (ret) {
+		DRM_ERROR("Failed to resume queue\n");
+		return ret;
+	}
+
+	queue->queue_active = 1;
+	return 0;
+}
+
 const struct amdgpu_userq_funcs userq_mes_v11_0_funcs = {
 	.mqd_create = mes_v11_0_userq_mqd_create,
 	.mqd_destroy = mes_v11_0_userq_mqd_destroy,
+	.suspend = mes_v11_0_userq_suspend,
+	.resume = mes_v11_0_userq_resume,
 };
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 5416de0bdf25..afaf93faa824 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -37,6 +37,7 @@ struct amdgpu_userq_obj {
 
 struct amdgpu_usermode_queue {
 	int			queue_type;
+	uint8_t			queue_active;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
 	uint64_t		flags;
@@ -57,6 +58,10 @@ struct amdgpu_userq_funcs {
 			  struct amdgpu_usermode_queue *queue);
 	void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr,
 			    struct amdgpu_usermode_queue *uq);
+	int (*suspend)(struct amdgpu_userq_mgr *uq_mgr,
+		       struct amdgpu_usermode_queue *queue);
+	int (*resume)(struct amdgpu_userq_mgr *uq_mgr,
+		      struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.43.2

