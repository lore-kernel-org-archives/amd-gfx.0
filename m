Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8065C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 11:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6238F10E9EE;
	Fri, 28 Mar 2025 11:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XivkORcw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A600510E9EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 11:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA/UTMV2ww7pgGKAVOtGkrg20I2ur1xxCrJt8GPoykQvdQgLwS3Y3+frz0jH5mdJjuVJGbewbZXGrvhdVK9HiGReoivfTkDkK+EQNJtYz8jOFksWrmJaAm3FdOdABTq6vtXAuMdshAhnprQpv9kgoLZ/irzUIXWL/XNeyruBgLiUDy858ik4gwPRffw5jp8DFDaYgn87lY6/oXmQhHVjQauSV3jiKUpbHmxrV+3OpTi8KfoNFow8uVOUV9EL3BvNRk/DQDu39S1a+TruhfeZtqv1fFf5WVRwSPg+JbhpVVFMLez0hwVYsXJkLkEsM2M2FzRydN7dfjQEST3Y8u9SUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xg8ibBCDZuvn26SnZNet8zCwgqO7ZWVTJrW2LQotJD8=;
 b=AL8OCeHnyYZVT/XG4Ssao3328KGupR4hWvh3QRpU7C8kQtnzch/v1lna/XOW6ckH3bCNuidtFAoS/BNpgQEsCyMRjE83q3FWDRDmd5UuuH3kU+G9oszdZPG/wujt6mjb/yjUaQ7gbm2qRVI27+GC1q5Rs6FpydAN6Ga7xEoiwrk0UXr4Zjh4xIuBJaFKyHdXv1ROP0rozhazVCfW8cOjdTfziXT6d+uwO5HxUGt41j+BQgBXChSrUc77RPr9HNn6ol1Y1rAIc2I+b4RZg+tHYv+DaZuOm57ZtLxDzCapAk7FqIwj2cuMPx2LzYLE+bPgZwsBtVHpzCg4ifbUHnnJJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xg8ibBCDZuvn26SnZNet8zCwgqO7ZWVTJrW2LQotJD8=;
 b=XivkORcwGMVniyVeuj4rPeh+a4v9zmE5WmsZ2+rhFhEFZ/DjB4z68E/SYnWzTuhGP9vBxxqDkvMZxbRAk95QP0Kf/QUTUmVV1duHse3Lvh0I3asFlFKC+MAwXkOa2ocD3VExByURPLfkapxzFkYx9NJ5HaxTBA0sRfYzWqM5z88=
Received: from SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Fri, 28 Mar
 2025 11:45:36 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:f2:cafe::1a) by SN7PR04CA0014.outlook.office365.com
 (2603:10b6:806:f2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.47 via Frontend Transport; Fri,
 28 Mar 2025 11:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 11:45:35 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 06:45:34 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: remove the duplicated mes queue active state
 setting
Date: Fri, 28 Mar 2025 19:45:24 +0800
Message-ID: <20250328114524.1763405-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 687c2f52-ceeb-4ddc-cf31-08dd6dee0dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|34020700016|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RrSnTFOe5c7S1jFzPFF2egFc/DgCnvGgJ2EPzK2X91S7D13MDoYjBenyPgVY?=
 =?us-ascii?Q?GxA4xQ5YCOCkktwC4nRba4uphMLMdNwFZHX5rQe8noCtkXxLAsUxU50RJDYu?=
 =?us-ascii?Q?/V5KltZjSBEeQ0HoNTqQL/EaY35Oc5XqtqTQXGNmd0LNhlKKfdRRhWonNwXe?=
 =?us-ascii?Q?Pkbp28iAMoVTP969OinOKOhJxwiYDaiWfqO4iCb0gO/2m+hNEInLf29UIiv8?=
 =?us-ascii?Q?LRfMpDQGCEna6KrrRuMQ8Mi90DCO9KsFmL4rrXTQnT4xLVCHMkFKPTHvmOIG?=
 =?us-ascii?Q?gDK1t+UJir22HMHD6kcG/1qyfAO8sQ/mAKYqEPEq8t1yf5gHf+y5QRin+7me?=
 =?us-ascii?Q?RXYYa9MNHFoEeXzkLgJxxStu+//Bi/cQJQ9lgJo3l5b2rEGSFoDfyAJ8F12s?=
 =?us-ascii?Q?soEQJmzT0N998XrcnFZjMGcQRxRE09sOZjJrStdaOxHKTlTLsvT78SMJ+JjN?=
 =?us-ascii?Q?DcYFkfddDX16vVIR6bY/ICzWonZYukFlDEFG0LGp81d2Ncyl4nSwrqyazilW?=
 =?us-ascii?Q?iPNBrNT4tZ3xWdwCa6HWMTsr5yK3VpV/O0/VxAf/ZzTHHEVO9nKVjBsfIyI4?=
 =?us-ascii?Q?WEmnbBKTaJvo1rTztFdoByaliV5/QicljIsoJWJpbNjMLh2hh/b5cMusyiWE?=
 =?us-ascii?Q?jsFBIH+4laPvbJxzgHyk5jPmNjM9V3O+mbCb1bcY7zJOSA0oJxc4N1be4f+5?=
 =?us-ascii?Q?j6VSJ+m7UJj/OG8bXQvY4jEIbt1L7EHUivTWs+8muP2/0/kZ0SJ7GCx7selc?=
 =?us-ascii?Q?Av8WELEQW02c7OukcaM0SpwJqHgT3nyTedzvxcqJ+KQWM/0CEyKioPZ7TRs2?=
 =?us-ascii?Q?1ff6dUkgP61i3MjzzF+WVLc4Uyj+TreB+sYrRiFmPhzXu1jxFP18LYW9zgdm?=
 =?us-ascii?Q?yo2b9KEBkoZqsylSzc8xjJ9ZGmP9JdPSOr7/NWt/o1uMjbzo5Til8JWv4n99?=
 =?us-ascii?Q?4aEiQ68ke4zKkIxe7QyT+ra5b0Cs+xCAJGys9UTRszm7Ufw5Hx8haPlBtd+X?=
 =?us-ascii?Q?1WXDNIkAS1RAludgWwM+JG1rJbtSeW1C9XmMAwwPjYm3uIGJm335NLCXIlt7?=
 =?us-ascii?Q?5xqIDyXMZsGsHhtOEAeKN3bjXexYO5tNYcI+a8Dq7MfywfE4rGPcrDvL/ehq?=
 =?us-ascii?Q?xFPwQz/LJQKKU8pO/jLLqg6zlwU7dYw6oEBwj1yHmUWWV4KJEQwy6/zrbHWh?=
 =?us-ascii?Q?zgD7Hh1vh7sTnoMkVQyL4jAgzViVuPpDXe7D+K5H+JtjPT6thc9Y2wwilkpa?=
 =?us-ascii?Q?Ld5jfl/qx8RF3+AatBAXTjLbcCe173BEvVL2lBXeMMhlnKlZvYBR7LB1knPu?=
 =?us-ascii?Q?rwW9pXigv9eU7mvaKN/RANzl0IdtFv4HnjSIhnmhmpnRK1F1X6VvecJtoWES?=
 =?us-ascii?Q?FWVzZyn1VUHGDkSqHJrwNpPepdXxEIrG6hUUN+Mw8kj/gS01DEpeFq1orjc+?=
 =?us-ascii?Q?98v+VYF+uThyHVzHko5/jzLEZDBidSWKEP4CYF+sIjjtAZJ/5/nHr8DlMmrA?=
 =?us-ascii?Q?1yFb5slUgq6WC7I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(34020700016)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 11:45:35.6499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687c2f52-ceeb-4ddc-cf31-08dd6dee0dc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
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

The MES queue deactivation and active status are already set in
mes_userq_unmap|map(), so the caller needn't set the queue_active
bit again.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index b469b800119f..b9705cbec74d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -358,10 +358,8 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
 				   struct amdgpu_usermode_queue *queue)
 {
-	if (queue->queue_active) {
+	if (queue->queue_active)
 		mes_userq_unmap(uq_mgr, queue);
-		queue->queue_active = false;
-	}
 
 	return 0;
 }
@@ -379,8 +377,6 @@ static int mes_userq_resume(struct amdgpu_userq_mgr *uq_mgr,
 		DRM_ERROR("Failed to resume queue\n");
 		return ret;
 	}
-
-	queue->queue_active = true;
 	return 0;
 }
 
-- 
2.34.1

