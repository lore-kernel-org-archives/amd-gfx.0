Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B40C83F0A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C89210E50C;
	Mon,  7 Jul 2025 19:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3RJUTGYt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DC010E1C1
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqxMUEZ0vOvGcx9DXttKE4jMckQ7M13pKHMbVKcVbYpVr9C6hwzVEFqIL02IMVdedq6SWdKAg9VMNgpxu+bR1zqXYdQA0Hr5F6IKMbU+ay+TlAFSlASle7afTc2cdJEAl7foAlZ1+KfYUMBO+lHv1FBrORAU5QWlQNeM9qNrFfzj4lDGC5FjqJzksH75oFGJgWNAGgmOrJ42deC+2lUkb4l1O0rtiZpZaQI0BPEuR9y96RFmjauB4Xpo2MSzjQeoCib648bxsGBoGp8dA9CYWW/z07a/1NBNsgA9ieEX2YQcMSwzGBxXSpSlPnnD+QhhCpQWRxte5UwfmwqxaKAqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=735qG+dIzLmd5GfdZCKUcoOLqVkTo53y0NHbnT9Qxbc=;
 b=Y9dcTAnJ93/jM/FaQ/nAA5AR/0+QZ8eLKl46M8p/W3z91hjgiCAZGr8c8zZ5v/jqAO03Lj3renS8vsH21qamJ8CplqnoCmN8dSbp0oih1ZOiAo83eFXYLcJwL5K131JskzxE74vh1eXCso0+OuBkiP+BAPsRR5iu8OTu3rYF0C7GeO3LvdkunmkSwYbVK6nyF/KriCX+5o0NP5pvf2RlejG+D8J7v83RtYtJDU8VJtrFAtshceWaLknyX+DRsBbkovM0U3LshQrHC/fjr5uhECboIEDLVSoomwupPUsjAJU2BmvPgrh8vHMbWYkvCEw/mMr1cKfsecqCwpJGWg9j7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=735qG+dIzLmd5GfdZCKUcoOLqVkTo53y0NHbnT9Qxbc=;
 b=3RJUTGYtQJtRyMyE73hzKbrdesk3SbGfCb/tE2TKl1XICECO/L6vnDk3wDxe3MtvqZnyyd8/JSn2vtCQXaOM6LQXbeD6+B1b2plJ57ARAw42/DZxh//AqVBjNF09/9QVxPpoiklr5eQmdTj4uVu4HNOvjX5N0WxpGOKs1voH6yQ=
Received: from PH7P221CA0085.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::19)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Mon, 7 Jul
 2025 19:04:16 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::b2) by PH7P221CA0085.outlook.office365.com
 (2603:10b6:510:328::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 06/36] drm/amdgpu/jpeg3: add additional ring reset error
 checking
Date: Mon, 7 Jul 2025 15:03:25 -0400
Message-ID: <20250707190355.837891-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 819a8a40-c4ba-4d8b-008d-08ddbd89114d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qEwD4HtuWGAy6tBiwhdYRDviJdE3VPS3pinFy7oB44hSHOTiuoA4cG3MuLIf?=
 =?us-ascii?Q?ZKjgmq8ckGkHcx74fH+s840fXNWeA6dpUADosTrBhxE/zYPEcTjebFinfjtV?=
 =?us-ascii?Q?ST8twlblyL0vLmZ4xoJgq2Ks7G/MZvOR3YlMMnbYPQnbBFsZy4QDjqBAI1g+?=
 =?us-ascii?Q?ovnhUZHWfqj2+ud4BOS9w8OKhzuSgNBn3LgMwKhwaVTbOBJ8AAqfSBX6V+T+?=
 =?us-ascii?Q?7DZTv3wPQ4GoNKoWBVgpJlV/rCbn6HjUwLrrwQSk8aAuPUY/kZKlkC8LHg2/?=
 =?us-ascii?Q?xgGQkESrCixzLbxR5FvxXxt1JfuA0s8KgZSNQZSCjpEU/FCNTAEnYjRY+Frc?=
 =?us-ascii?Q?D3ukc5tRhcMJn9+UWzWWbxwMCN7czSMOUeCG4OV1Wpr0q3cRiK5mH8f7uFMq?=
 =?us-ascii?Q?jhFHw000Cu63MJSn9ABj0Jq76UXAVVkOqao6VJ5OcLTh4k/g9B9EWRj1xwbG?=
 =?us-ascii?Q?ouLqyYwn92d55QHJwl9jVJxm2dsibDT/m7pGY08qTCbRUIoMfStx4woeR/SN?=
 =?us-ascii?Q?eufi2echQtR//BpB2MpkT/6z7lunR6fK6EfxFOc3cu++9nENd8067JFCN2W4?=
 =?us-ascii?Q?P3qmJVL36tCZhtxTVNteFiu4msbv7/BeZnwYGRMN/VDdkqj7Yy3VEk1bv7sH?=
 =?us-ascii?Q?uxvIJo12Gbd+pG5N2uBfD3txCivJqPk/kaTM4BlLxBbeefKKkWkxxPxTiymG?=
 =?us-ascii?Q?q3qlqhthXnkzGsEk1+vUKoyc4KmPTXTZy+5FzSKDlRuHlziNeQ1zxsNNr4SE?=
 =?us-ascii?Q?luqVd2q95GWoETV35kUoqPMLKedcS4w88C6rOJfcPU3TL7rZ2yaoXA4Il9aW?=
 =?us-ascii?Q?y3b3AgJ1vDxNB5N8yNN9wH5wIi6cYKujCYuLoob1uf7iOr6pFwowGIVscvHR?=
 =?us-ascii?Q?KTTWdXOuULgi+x/+sDM/eVkhvjjbVmHW8H65dcfCGTEKGyYkh7ObE7Cxf1hV?=
 =?us-ascii?Q?XNQLYq/CWTv3bcXEJ/2ldS9wRms0oySYR4aYBbDHySLg5/2hiSFJxLvPAsTF?=
 =?us-ascii?Q?fsvM3nxrM8ig5/Kjtlxrg75EStrtA4ugRAyZycvAuIHJsr7OJMG1mruBgUCu?=
 =?us-ascii?Q?RVrIOpP045ho6YnCU6mqLqCCZGURTqcd6bVNP0AINppFuBPPJsEFfpt+lxLY?=
 =?us-ascii?Q?vqq3jkuFDEtF9flyqz1Pr9NQ07ctBwhq+XVjG8UytGbM7bD3PQjcFPEHlB5C?=
 =?us-ascii?Q?EDA8Jb1+11N9tK0CNWk4emOpdtbFFwLklZ0YVCVeUv99mbj99XkC0lJjfc1j?=
 =?us-ascii?Q?LKKY39U/DehJJwNvltCw2Gv/2OnF0TGM/+H+7RyMyRZpfiYzotY91HjFqmG/?=
 =?us-ascii?Q?JXqqCeT2+vw1TN6qhV7cyARG/cbfz7NUfMQrIH7UXuN5mA8L7kqMMYor644j?=
 =?us-ascii?Q?Lb7/mzLcEmNs1xGp6W1lzcf0GwMYypF2VkjDtcquQMTRuX223a742GnEb3Oi?=
 =?us-ascii?Q?uRK2g9fhw1ZIMqZYhwAKAP1ZoN5epT+MA0rMpJEmZlJPKaSU5/fWQ0NgksIk?=
 =?us-ascii?Q?F2LezEaIvn0prCByIC+8yNpAfYUktO1aZBty?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:15.3994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819a8a40-c4ba-4d8b-008d-08ddbd89114d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625
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

Start and stop can fail, so add checks.

Fixes: 03399d0bff25 ("drm/amdgpu: Add ring reset callback for JPEG3_0_0")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a24bd833d6442..5428930eafa3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -562,8 +562,12 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 	int r;
 
 	drm_sched_wqueue_stop(&ring->sched);
-	jpeg_v3_0_stop(ring->adev);
-	jpeg_v3_0_start(ring->adev);
+	r = jpeg_v3_0_stop(ring->adev);
+	if (r)
+		return r;
+	r = jpeg_v3_0_start(ring->adev);
+	if (r)
+		return r;
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
-- 
2.50.0

