Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04B2C7EE3A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5203A10E413;
	Mon, 23 Jun 2025 16:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CywW9xWl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A81F10E40B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN8oGrVB9yR51BUjBe4VCFH6NpSt8lWA1gy9TmlB6oWrFR7XL0fYj6Sger74lxn/JvDw2pw6FHDKWV7Op7F5B/NhKqAHakbWIHLBO4rT+MVJ6lvoHJPUW27wvJcMv10q6xFVnqzbDeFAFvjO88B+KIsYzPtfaIAKrvkZ8BIne5fLf6Vd+UwNgRh9zy8cY5fqKUP8BtA3n5oZN2M1pyXypMI541TsmmGhty9FbGaIsFb0PUyl0pxu9gKSPgwhsYV7i/rOkgaOufBwFc1/1eAH+bDPr+ySudtpnp8aOcfi6Rvp9WXzVpltr754Q3tzR0aJP/CLD4ABO1nkwZLtmYfc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBFs0X+Y/w90XBVNdGuqiGlUx5Jv9gjidP9b4FdpAS8=;
 b=wNiNCQZiGdzUYhOg5Sesdel5oUCnYWXyC32RvMvqpG/jV+NaVJYoVER49H/D4ASKgTYtzNj9i5i5Dp5GIqGvTm1HBpuxxsFi+QQMtFqxHfzefi0GeOVjHhn9vaYVVY0aiNhIoK/90bTRWxcfAxeK9iylJEfOddVm4YKMaefvtd0qDR+0ZejOyBUQ3mEZTB5vyeEcV74BEq6ytj/sxiPpHo6IlNTnNQPPyC/u8yqiNiRxWKeJflxTryTdwxhx4UQ0OJQPs3juY+HC52DnQXZ0uVmQVAzJyhlmroDYzXcfEGiNDT3wfDBK06YsMuLLKlOVga5LFDmMFPJtUDcu8JpW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBFs0X+Y/w90XBVNdGuqiGlUx5Jv9gjidP9b4FdpAS8=;
 b=CywW9xWlnNnSPcpCWyEVjPx19BOoNFlhqhV3xDsT4HzZckOUTBPZzCOuJ38YYYFI3WFct8n/1RQA9tj8Io8pVUuBls0fNt1EsyPcP1vH4PeKTgq+3uY0j+kqX/Rik1ug7F/tC/ksqmNWEvhRljNyPk89bQmS/70SIsxAKN7OfrI=
Received: from BL1PR13CA0232.namprd13.prod.outlook.com (2603:10b6:208:2bf::27)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 16:15:02 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::a0) by BL1PR13CA0232.outlook.office365.com
 (2603:10b6:208:2bf::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Mon,
 23 Jun 2025 16:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:14:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/31] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Mon, 23 Jun 2025 12:14:16 -0400
Message-ID: <20250623161438.124020-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: a64ac4c0-d6d4-41f5-3115-08ddb2711bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1539+afG8wT9KSY7Y8y/ZlPIV143IMhzWhpMJgyVZfMDJ/YAeoVD+mXznhiI?=
 =?us-ascii?Q?E4Q2YB+usjwY3iH90FyRLePFNFKtY4IJRkYZErH/bSlClsiOo+S9t7GDrQ8I?=
 =?us-ascii?Q?Sj5Ri5//ow0AMv9zQIAvf9RADzNH7WF8tNSMGFuohb+JNijeB7PlbN8wGksL?=
 =?us-ascii?Q?Srpc7XNUJ3cxunrZwtjsKlnszPXmcnEaC3/6YltX5BuUIGAwfLoPXzPzBkjF?=
 =?us-ascii?Q?U01QvG9ydcQ+MxLVwhsQHOWYKmigvtKx+1lp8ZOmCXjRI9KrEzEgAFG64bbv?=
 =?us-ascii?Q?XR2zQW1ctcnJS+F7isOoI6bCmZFxjNid+aMqNlV5t0d96Y1LqokzCeWdE7Be?=
 =?us-ascii?Q?oNkhpnGnSteuDR0rHv1GPvvqb346+t2GqcbNgNkFwED/AR2Xegn89Nbyzkvh?=
 =?us-ascii?Q?ydAo1pz+ZQlU1MwVivIvVbTfXI/pen7S40OsjiYjuQuGFJpV+c0gVEbkT4CN?=
 =?us-ascii?Q?i7Fhjsm6GXlyvWKcuETIOcCO/oQ01Dxatxg0XT6N0sEeb2iatSOa7e9xCU+5?=
 =?us-ascii?Q?8yah4gIWf2RjlFz+3Eq7uDJIfqVUMf1nA9xmsB4wqJweJfA3giMxD9Vgx9Bd?=
 =?us-ascii?Q?x5kYt7YXjU+dwspCdde/z+KOyyYbdnWvS8ocSeHzhkADQvbvbiacdxeIn2wV?=
 =?us-ascii?Q?Dv4uTBOpUxMgn+97t8+QOWZRf9OyDVrE7Mtru9KXijRnPMi0Xw87UfBLJl+s?=
 =?us-ascii?Q?XjbXIYYPjy/YbImdf2yyxTU4kfLyVjJxWKRIo6HCeln0uKoii+xdeZ8aKgZl?=
 =?us-ascii?Q?PZzb2YTVQdaT+UYa1rgZcccOgzyWrpAdyvagJn6c/napH/jvR56lF1A4iOgn?=
 =?us-ascii?Q?+CmY4MTBwYSvAzHGVdcWb4seyEn8vsVepnQt3liGA6FpSmCQhICiXdtzMSrs?=
 =?us-ascii?Q?/K5Iuui9tLWeLExEwVC+/rmavDq59+4PQWJGi2cRcVQExZ3yMA7bQsn3JMea?=
 =?us-ascii?Q?Tnufocbd1bZ4YcHa4FvMkjyXQl99cRAuLMqh0Chu1Qm7q35sCxyMc3teVTgN?=
 =?us-ascii?Q?Mj3K18TZU8yjvdl+P65quQRs4m5062jxvnfURsUnGoLe2fi4PuydMGy0jc05?=
 =?us-ascii?Q?BYhY+74Ko7i72FVV+H5Tjvb5lZWyIysvjLHqqn1FtlP86kDSX38bUhwUSG0d?=
 =?us-ascii?Q?Q+UpaqY5mO/Ai3iaetMwBJe5Zikv/Thfy12YmFdZBMY+6WJxSyMS0vML/i7X?=
 =?us-ascii?Q?Z3jbswdesT4zH1A3ylMXVX9jUbWo6BQhz7MIVNUuM1PyuC7OwZmy1GL6DsyH?=
 =?us-ascii?Q?syPbrXsucsi1yiINWRqsjLfTdK/yDXH+hB9PRUEUgitr9xs4au4yAaHnq5ks?=
 =?us-ascii?Q?c9l6Tsw9YCyKxdCNJtsgooEGkDTB0wynQR/nMZxdfzBQF6BWEkFAydNbiG2u?=
 =?us-ascii?Q?Ham8WbZzJF7EzV8kGvKAf/GSGXWJVlaW1jqFXFUpZBTsKfnVYHY1G/HSBUGp?=
 =?us-ascii?Q?DCrNP2AVV8YeeUbPyai+LcrQ6oLtdQuoKUAHhA3D2tQO/8TKDTSdo2TRKXG1?=
 =?us-ascii?Q?TD/69umPKohsIsX1fNHgO/YZxERGmRRZTDAp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:02.2271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64ac4c0-d6d4-41f5-3115-08ddb2711bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index daed0f187bda5..21bdf9746db7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3567,7 +3567,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -3615,20 +3615,14 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
-- 
2.49.0

