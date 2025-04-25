Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9438C369D1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 07:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65BC210E09E;
	Fri, 25 Apr 2025 07:20:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xGtyLK2H";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3E310E09E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 07:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5AX6O5slMd4K49Gy7KssDYVqxGV8dJ5wFnmPad/YJaKKDsPcmk4olrE597m3+K4LXmux6TqwQY/Xic2KC7I0ivLAOiIws8/8btzFXvIUM352yLAmt2H7wcM1DY4n/vyHMqXbEV3tC+ePBp5qNwbk++QY0WG3omv3Yzfu6j6PdedEexciEc/6JZvorOXxxPVzsI4sr2jvWip/WDCLe2NMAPLfzrEmlsBLXRPGajRGOT3vgHGo7zUJOCAmVssFCwo1BGWzko5C8EDpswwF6yKposfmoQe3iTOhY7I0WYU5MGxYRPQYN5QKhXdLzujAsYsNNH8fKQWApqJiXSdRYxr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8jf38V0gJZGA4MSOXRRE+Fw4kT2yQJMLAPh5Bx9mqg=;
 b=rkh9QOM88tI4HaS1koSxjh9aybAOfuRPuchiloBYjLKJS5q+F1s8NabOqaWp2rRBg4vJ801XHRBwgCZF21ShdzJcDjQqnsfkmsfKItc5YUeNKYhOJNJQsQxWeX8txY7KNUMxxAxUVa0cWt41CChRVBJiRwUKMPpK4WIKPJ6G7IGKCV0y4IPZoKpIoV4S9AJY7wtcaBgSB1HmXYPulChGXDI0cHsVPfIMmBs8upQM0yO6eLTT6apEyeysaRSAJ12/WpOBPcN7sksZx4k7gCfxkqBKDM7uWjsPQFjlFvjra4Thn1ZKYL8tRIHormHUQQ7/WfUrXack1Gcw/iAcdL+wiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8jf38V0gJZGA4MSOXRRE+Fw4kT2yQJMLAPh5Bx9mqg=;
 b=xGtyLK2H34Ghi7DyuGL061Ds/apvZIioTZc/loGFnjqlANrEiDwyJyvHvbaT4+GhOfKW8aYy9R0XaORUD4EooXhmjBkNBQ/UVoUVMDCvgP0VrifMOeGx4J6I5OOnGfo+Tp/RbgWeHp9NPUTRH27qC+mZfvxa4isw1HPFo4SQ3iw=
Received: from DM6PR07CA0132.namprd07.prod.outlook.com (2603:10b6:5:330::25)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 07:20:53 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::60) by DM6PR07CA0132.outlook.office365.com
 (2603:10b6:5:330::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Fri,
 25 Apr 2025 07:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 07:20:52 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 02:20:50 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: only sync on the dependent read fences for
 user submission
Date: Fri, 25 Apr 2025 15:20:39 +0800
Message-ID: <20250425072039.4034161-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 000ecc83-a3ba-4a18-dcee-08dd83c9b691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TEjqwLyD5NabeeTAxXiTyAVA79LtEs4Zk3ZIX7ut01VlT+igvoERTNdJc4DW?=
 =?us-ascii?Q?LlZzd/3Oc0BuEtysR9dYLFlsP1yeRNmzCPUJfEOLTLDral57iYth2c4raA2O?=
 =?us-ascii?Q?14M+EumxteBcdD9aZi1PoK62lAG9eSLW+M93fUvcIlU1h/XAWMYSdh3HBIDm?=
 =?us-ascii?Q?anMhp4jgMrStVNdlY+zDDoYoZYsn0AV0LBosA8Aw6I7SiIM/iGMn2vGlXNO5?=
 =?us-ascii?Q?SPjRdzoP3H6GH6jOTo/T0SJHTMXyUuwfRuDiviZOMwmlz/E1H/4i6AoeK63y?=
 =?us-ascii?Q?zwtwBXiKUewYkr/8eW7TH6nemWDqmOHjgFYgQvugESrIvrIkv5bhxPfV/v0r?=
 =?us-ascii?Q?Gju649D41kQ5e08g/zRNh3RJqCfQw+Gqu/39Imo9CAFJ+BL332f+AO7ZuYFd?=
 =?us-ascii?Q?hk6OP3Qab4LV0/l1w7RKbH+nk08LDo1ZBxPZ+L7TFmz8BwygQQ5klr2zrk2V?=
 =?us-ascii?Q?yogAjagi0jT2i/ScJzX1bzvJdX7QlqhUhpMzqbmosk6DFlsyHZ5gv1lQxHa5?=
 =?us-ascii?Q?yezskvgJNoS5mO2z8T6MIedMOugLiO7MpdQ4JVmU85DBgVgJdjAngFXst8w2?=
 =?us-ascii?Q?eR+dXBggyvpH2xwkC3DAupJH+Fh3i5TDhL3Cc0yVazZQJDgzndPY4fEsJ4wD?=
 =?us-ascii?Q?RZZF9b441kpNBJs9DH7vKAFJY0ARL8ZlLM4KgOC+NkGW/h+bv6CKM0WJImgA?=
 =?us-ascii?Q?pjVbkro3MurECdYrufaLDzvH10F/80ltiXY3xtFr4SOwCDpa8S+Qc2w4vTX3?=
 =?us-ascii?Q?Swaw97A4oBxmv7zfHBZJrKlyxxY2Q8plMjRHo9zZ2SiE97At7RuNbZqShxXd?=
 =?us-ascii?Q?wzk2THbw/2Yw3X8arVi1i5rl6JI/wYFobVwjRHh+jrg4lLRPxbnmFOr1UPBd?=
 =?us-ascii?Q?rvQmJfuKCaPbEogtxvOEkg2Lves71oOTeMu/rxV8viXxC0H2u0izMsfsmFJr?=
 =?us-ascii?Q?FDVkJUdvZrB/oWIxbttCcMVgPWc6N6wsSL1Q6DZAXhYTo+Hw7QYuPqcHxKhf?=
 =?us-ascii?Q?MneeV6KXessLW7xE3PJGSmVmg5vZu017ojHT+0UUZphbykFGwUWdlUen7IUK?=
 =?us-ascii?Q?NAPUD8AlhTzOb8ynkJy850SNyPbiiKluoBeKgwH0rcqirireE+AfQBSjpGNi?=
 =?us-ascii?Q?sArQJaRZboIok9oVP5qKkH5BkdiqLEy/QwOVhRtLz/la5srz6+s/GYOKwTW8?=
 =?us-ascii?Q?iWk18oSZv8usmot2nK+lfGJ3+7511XQwG6Eqql8VmWFSeY3nOTr5jOcwgEtT?=
 =?us-ascii?Q?TkPbs8cJnpkEj6lp4pRY2UIh/JcTuU1ijGmSOk82XIhThrNuigQGmwyHIzWN?=
 =?us-ascii?Q?XBndn5KPiVWVcKm6rY+UCRQmJMhDR0bhU30B+tnhHSfwhCZKrG4Fu6UnKZYH?=
 =?us-ascii?Q?nvoJba/AATrYZ0PWM//MbvHQZCZtrSVcBHChhTTDE+gKxpZoj7v6D1c1vXil?=
 =?us-ascii?Q?XV0u5kgoDdPouxnUpXdOlRrYhnLMb8/H1oXpJXi7qrBef7gMHHOcC5ugRdgC?=
 =?us-ascii?Q?PqJKalmF9ROrA+vTLdA+kRtRL8rDGXwENZ5l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 07:20:52.9437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 000ecc83-a3ba-4a18-dcee-08dd83c9b691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355
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

The driver doesn't want to sync on the DMA_RESV_USAGE_BOOKKEEP
usage fences, so here only return and sync the dependent read
fences.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 5576ed0b508f..4e1d30ecb6cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -249,9 +249,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 
 	if (resv == NULL)
 		return -EINVAL;
-
-	/* TODO: Use DMA_RESV_USAGE_READ here */
-	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, f) {
+	/*Only return and sync the fences of usage <= DMA_RESV_USAGE_READ.*/
+	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
 		dma_fence_chain_for_each(f, f) {
 			struct dma_fence *tmp = dma_fence_chain_contained(f);
 
-- 
2.34.1

