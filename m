Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C45BCA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5D910E8F5;
	Wed, 10 Sep 2025 11:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v3AgoKXc";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D84C10E8F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhQnto+f0UPEXnlYsKWbjea3+SJHYEUT8ihn/vLQTLvXbmdwEOnvyxnOZRtCyyCcFTyCliSsz6X83+2UG+lZxdU6fBEN+GdEVLLmNUpqs11QHQI321EdCi16+p4j+nHsvWvQu76iQfvdHeEnTWTYHQV4I/S+ebMx76HEZwEwtJEoUhpaL2YOo5CLQMTQrnyr0Pks8MXgUkq4uGQaVAJXfE61JlEKDsVozQzKkhs06putkJ3M8t21jtrMdgFLqxnRMbPc0w/wk5c+HylnqxG0vRY0nSJLx2EgVYj+1iXzIDoe65x3FOV07NyCCn9rNlCOwbZL8NGlCCLcTCXJd39giQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHQiVQXJqZSJ2/2wbZ80MAjpAW4KSUIp7snD1yhpNF0=;
 b=x6ObmVqMvSZAkXTpcEf/x2c0Izyeoc5I5lz8CRhyYg1ivVo16TYzwHZbMg/f8y7RMds7VAGa6aP+Sxk/clHan5qTDa8pnSnnTDe+B7F+6mJOpvSgAL2kLZ1V6yuj5TY/2FlnG3W3nrmMFb16zY1w4YfxMQQ6YnjdD4BzlYdR769OWOki3pA/6Xd61SaimZVze2rgo4UZSVPJz13KgeH0Z3fCcyTh3fzPORs0twmLv1j4+w4VPYia2iKO1acIYWbhKAIRjzu/gkTuKgRFWiYkr28NJMIx/ccxgNMJSNzhp2gia5AfwcrAiyRMobpcdair2si2dB2tgg+maJOt4MCogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHQiVQXJqZSJ2/2wbZ80MAjpAW4KSUIp7snD1yhpNF0=;
 b=v3AgoKXceG7ErEcdzGg1esTVFMqovFiO4dA7/UsWGUrClQfm1T3Qf+7WM71+MfEcA11rUaT8eH3gIvzesbLWLXRyTeDJkClC3Nw0IucZXcG7vXabwQCAtbgbTVScPLO/9Rdywa13MSph79wLNAVXO6QV51V1rb5mNbJH6tVEgNU=
Received: from CH0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:610:b3::20)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:37:53 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::44) by CH0PR03CA0045.outlook.office365.com
 (2603:10b6:610:b3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 11:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:37:52 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:37:51 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 7/9] drm/amdgpu: keeping waiting userq fence infinitely
Date: Wed, 10 Sep 2025 19:37:29 +0800
Message-ID: <20250910113731.2688320-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910113731.2688320-1-Prike.Liang@amd.com>
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b9e565-4390-4d91-e499-08ddf05e7a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EOE+ooSUSLBVB8QvwJmfmmd+1usqJvwFRg0I0GGbkoA+aWM8e1jlkH9NMMpu?=
 =?us-ascii?Q?VW6cR0KMh/YiT8Ojv+fGjo5Wdq4GXxJY3ln/iQuNQJgcNJSnJ0PE/qKIaaav?=
 =?us-ascii?Q?hsFUP6xrJbsiPZWdQcNlcnn6I5Dkl8cnQsjVi6+vI0z4BjnPCdxexlTUUaPg?=
 =?us-ascii?Q?jtQJZWTidRi9aURnLyynNy/jgae0TUdUM+PgIs5IN8iK+4HfDu0yipWgLweX?=
 =?us-ascii?Q?tEJ6EPkxaoShlIchRaYvQ307jGBHJVFWxZsLBU5ZJ1HHUsdoCfpc7EkXzvJl?=
 =?us-ascii?Q?OD4hzJvC7uHVNvMrcCKU6Z39hSt/C+KLUC9wq65NHsrlfsB1LlXtZs2pL4Pp?=
 =?us-ascii?Q?kwOr2rNLaCcM9GJklRx5cRzER77qexSerKnhKlIk3tHWYYrNFwOztZt6KbiZ?=
 =?us-ascii?Q?/k3syy4w/kXmQm5ukz/j0wSqj9BrEJPZW/4jptNikJsD904T1y5VfzWnDHZy?=
 =?us-ascii?Q?Fnl2gAlyP33fov3nOe0wQoftmoQ3DQQLPrKOEn5S5LRzPbSOJEyjSNzgtQLx?=
 =?us-ascii?Q?cug56muQ2C/od9anc41nlc5TbOdKdZcr8LKOGAgrDG297RRDgfQMqfYiw6LK?=
 =?us-ascii?Q?qTx5UPkHYzIkj2pBiD1knJue3bn+92wQEgSip10+T53TP7VeRQ6Yw/eWz9Kg?=
 =?us-ascii?Q?++AhoqUe5HmjrIpwHIaXGiDXfcIq5tU/BWxZAflRvXKFKC1O5L89ikGwxyAq?=
 =?us-ascii?Q?SqzWKHo7Lh1wsUecok5BzMqOw08HSQ7cgApvoG+ywdJhlz1y6KhwksiQH88M?=
 =?us-ascii?Q?T/nXQrn6QBXhMEYmjE1O7AHlKoswmGdORyd9wshh4DUnMc5MN0LXHfYokzDM?=
 =?us-ascii?Q?dg/v/la/sNn7sG6rnDMuVQDdHnSvSPA+1JAzkd2DON4s70AH4P5dapDlmk3m?=
 =?us-ascii?Q?94LlNtK/psaOoHRUT6Nm8xEmGbz5f+mKpbj1t08SStuJQWXOX2iZzG4MEIIe?=
 =?us-ascii?Q?xlJNmg1tXavwIXfoRLIwDbmrnPmUAWFwRMxNyiBr0MvVQs48rK3qC6Vd9tdR?=
 =?us-ascii?Q?ibUu3Lx/Tt4W6np/5MPL2LiplD7zIK18sL+/4ZgibxVfSrk/+q/ey9Gz/CEd?=
 =?us-ascii?Q?c96f3zGCqU6jUNaFo9eGFaThsu2qLRYyuwipLQX6Ed3I1RJmNJ6PecI45BSB?=
 =?us-ascii?Q?JO2+XgxtO7JoSV1wXoA2fIL8nZ3t43cFZMWWIg56rroIv2BU4L5cjtM8DSVY?=
 =?us-ascii?Q?GHdIadQHq3xBoNeZuk0LH5DBSTe2SDX7Nbhreu6nviQ6W+aXYElNzHvkYgH3?=
 =?us-ascii?Q?y6LHFuUmSoW+BQTOeHSwmx8uR74gtyHbPHRIKQdKxh+ohnmaG9QKzXMhxQUJ?=
 =?us-ascii?Q?88KEJqP6rOBgoUVNeWg++0O2sLMOfdICWtdM5Cez/1cU5RQw9FLsLIoRzT7W?=
 =?us-ascii?Q?EvpAmuGiAZZwyX9HsxdHW24Ii9l88bp59yH/wDDOxgAyAubVW0xY4yAHAL4k?=
 =?us-ascii?Q?makphiXZwgADINxHYwN99fRCbDjBSv93AYrUmHpmyJo3OucP1pyI2vOAZlPx?=
 =?us-ascii?Q?ljgObVFjDBG6JvomHn4q0tK8ZXAzOj9iErje?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:37:52.7612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b9e565-4390-4d91-e499-08ddf05e7a6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698
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

Keeping waiting the userq fence infinitely untill
hang detection, and then suspend the hang queue and
set the fence error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7b7dae436e5e..2626a41a8418 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -199,7 +199,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -207,11 +207,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 	int ret;
 
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return -ETIME;
+		}
 	}
+
+	return ret;
 }
 
 static void
-- 
2.34.1

