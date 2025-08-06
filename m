Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3626C87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 02:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C73D10E702;
	Wed,  6 Aug 2025 02:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b1Wf5nvz";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0938310E702
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 02:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/p5tLvRzYpQjspGYZF9bRSC8e6uE7zP2RT0w8CrN8mSE/BKkojFmHnQDtkJs11EkFJVrWhU2m4csL5GUsHBoMUEM8SRiR92i7NQdGwkmD1CBv2+f1MSjniV+6gTWziZt2pLxxUxxs1YoiL+3ixL+6UslIAcNC1efQGBJnWoXY1VcrXlKSLr2z8b2h4EtignFPFrVYrNtW7FQqEXiT9dcza2JpBRz5lZ3h/HJ3GYBX0vQfjkMdLwy3R27Me7zZBmR4PcjeJGpi2GwThc3c3OH+R/nPQLS/150Z5nQjr5YeA9UfPNzJwaUG9rGpws1x/UK6rcXV4Jz0niQ1ljlt2VGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5FLi8A77PBsj8ol+23BTNtA6neKJYSZRuSdbFzdGWk=;
 b=yMTopTHk2Glj/swQg0G9GWyY4994WUJGFrWBdUdvD9EfAXITTlYYXo0QIX7ucfmfOEIup6NucqaXuS8ntup8wA0H4g8Ip/N5eL1SJYRlU6Rm7KH+gN+bHD33Vy/wMZYq4SiATbKCyR7fNmgydp8xPKGu9iKsBLkTeyscWA6DTbuajAwr2Rx4VU2C2r12oeRV88P/lDGQ0AOsGDTMLOknvd4dqQcsBemhFtzKDf9o0HIyCNu5tx2+u9bjDcdUzBmtKYez10GQGjzhkGX0kM2RTsEcNE6nn8J59eGB5wCX7TQw9QyHZVuCUB34OgzTOehnZppC9rx8q1Sae/uVqqHf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5FLi8A77PBsj8ol+23BTNtA6neKJYSZRuSdbFzdGWk=;
 b=b1Wf5nvza2ikCTtn8+F1MYctOCgRJgblq5uNdM0XYENQbdP6p4KB5JmefXs5czEahuP6U2CuuiLn/grDF2Z+TqFoEn8KTWiJCzsJJhvjOYXH/K43aKmpSfodm58MJwda/PGfDJf5VxnsnUhZiXGeGY/h3s7WCc6GYW7D0s9nZjY=
Received: from MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 02:28:45 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::9a) by MN2PR03CA0024.outlook.office365.com
 (2603:10b6:208:23a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 02:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 02:28:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:28:43 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 21:28:37 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v7 04/11] drm/amdgpu: Add helper functions for user queue preemption
 and restoration
Date: Wed, 6 Aug 2025 10:24:49 +0800
Message-ID: <20250806022816.1050823-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 070be6f5-1819-4477-0064-08ddd490f747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bhZyfrWE9XJMkItYpda2b8NHK3TjXydcPeZd6LVSFepkrVwkrsDUFxfkrIl6?=
 =?us-ascii?Q?G5ADU5+7n8Y5k2RqSCkC8UGSXPwxDc0heJF0HuhPw2gVpmMSwkrFlHQXk5Mn?=
 =?us-ascii?Q?EUNfjnwI+7uM6nmGW768ov+VIQfPqj/CdEMgoxn7gctRIXIw9IA1KcHNrCjD?=
 =?us-ascii?Q?XyvayrvO6iYVBXo54nq7eVj29B1V3wN8vMHaG4d1cnPab8iPKmhxS6gQ4aQo?=
 =?us-ascii?Q?yDeLmCmsmBMJ8Gdm7ujNNB2BSXj9vuP/e+l6FlGxjrEIwinqtjq4DXJqpleC?=
 =?us-ascii?Q?HIbyTgmW10wuXk6awfz7UrbNceqOslD7ZomBVOzmocnA1fQXRnexr2uopJbW?=
 =?us-ascii?Q?TGv0S+O3Xnu5hCHEjfjgat6X/s7jM1qJtzGOxmcWF2c+DfQ8xLR/OtdYgNA6?=
 =?us-ascii?Q?kQMvIJZoHrA+7U4pogldtXKybj9XrIJpKc7/fKuCgWmJ3pisM/YzdQh5TCQ0?=
 =?us-ascii?Q?OpsAMIc0cmQ1/KIucj1Xyv4ttj2/ZLcP+G2PpQL8YHWrs6sJZI1R/T0xpey1?=
 =?us-ascii?Q?KsyBexX5g00hTdtnrYHpjDW1fW9EYtvcdOR/QtCuXpblJa/hz/WPKYK167bB?=
 =?us-ascii?Q?ZzEgEbDIYBrI26D/xOfDo9Xcnjc5FxG8IgIStLgzDEc3naPJ/3fhZMFhY3w+?=
 =?us-ascii?Q?o8kP0RMX/N7XbH77F/D9JIzQFZDfPXRxLjArUEnC6OHWn5U4SQz12CkM6m+9?=
 =?us-ascii?Q?OtqoOQZeHKZO2NxpWODIwGCKjsCx3gDkvqO2+cmYmOTbu6BXBS0+M3qcTLU0?=
 =?us-ascii?Q?v2XUQ4exG/++JpuuE+ZUXAAGqCBC2XZRhTOPdv9BfQrFdwVOBqbGbxb5MVdQ?=
 =?us-ascii?Q?T30G8E8bxLakxW9Jw/Yr8jCt9YB4h8zpuZ9jcJpTss6phZFJ15XEPYFiQC6Z?=
 =?us-ascii?Q?4cZXalzHhofJocybfbxnR8XogsRC+kA5rfl3/JUfyTNpE3K3MVAZ00dFy0v1?=
 =?us-ascii?Q?4BSu1V+I05T0/VBSbF0ZmAgrS6weEFFYrtvbzqFM/X24IuLwSklLwInV9WO4?=
 =?us-ascii?Q?s9/UiJK73j9YnZDA9SKe/Uot47QttjfSIpTsnzvWrnWloOBy2VazhEZrVxXr?=
 =?us-ascii?Q?NUbPrUfVkVMm1DR0ldFmFHWziBr+xv2odUK5Oe6rsgCaeDR+bvAjFZ7ubSTQ?=
 =?us-ascii?Q?63BYwGZ0SFisFLqATMrBelUG/V0WtH3tp9IDbK1uzlE/mTauAraOd5zzbve7?=
 =?us-ascii?Q?g4nulZI1NCfWS+csobUdpl9jJl6yNAN1yAYn7YzGpbkk1U2hlwSF9BUJkBv+?=
 =?us-ascii?Q?XxDWeoSTwsTT4k+t5SREK5Yiwggd0a9oeoLb9CzmUVp+cwTY89lXAbBD4kpe?=
 =?us-ascii?Q?Bfn6FmgzJUcT6r2zuOAkyU8pbO4P3STgEJ5JHLCjhDmxSrHQxzeswIak085z?=
 =?us-ascii?Q?mFO3km5EjWq3khpLAaOJTOn+YjDD6Q4miMwFygv6KrXyF1BQOoQWVa4atlOs?=
 =?us-ascii?Q?M3wc1AfjuPnr0UaMA8R7yk2a9PbCVRChyMjZGpg0z5Iea1PizqmvWme8baOl?=
 =?us-ascii?Q?4eDq/GLyZ/kfEcF29ge/O1EgWmZd1vBzaP3y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:28:44.5059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070be6f5-1819-4477-0064-08ddd490f747
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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

This patch introduces two new helper functions to manage user queue
preemption and restoration:

1. amdgpu_userqueue_preempt_helper() - Handles preempting a user queue
   by calling the appropriate IP-specific preempt function and updating
   the queue state. If preemption fails, it marks the queue as hung and
   triggers queue detection/reset.

2. amdgpu_userqueue_restore_helper() - Handles restoring a preempted
   user queue by calling the IP-specific restore function. On failure,
   it marks the queue as hung and triggers a GPU reset.

The helpers properly manage queue state transitions between MAPPED,
PREEMPTED, and HUNG states, and handle error cases by initiating
appropriate recovery actions.

These functions will be used by subsequent patches to implement
user queue preemption support in the driver.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aac0de86f3e8..1496544cd1c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,6 +44,54 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+static int
+amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
+			  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = userq_funcs->preempt(uq_mgr, queue);
+		if (r) {
+			amdgpu_userq_detect_and_reset_queues(uq_mgr);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		r = userq_funcs->restore(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			gpu_reset = true;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
+	return r;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
-- 
2.49.0

