Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711A2C7114A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A9810EA72;
	Fri, 13 Jun 2025 21:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C5GmhNYJ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2993810EA6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhYEHotvYjLWW5m+n31GPoqAnLNng32HtfZ5EB5S0IOtOmL6j5n6c5jQ2zsbCbq/BhUvgBP2nh+GzKapFlNmvOSHTrLAFIFxERVq2OoUiOSR7MVyvd+I4laFs/XB+eN1QYwTaBxKjQ9tZ0d+lEiY6MqyZ1BplbFn0wD/5cPlL1hvaBPePJGiY3JBj8fg+geE+yRag5cODGmqkkIROMfrkb3Gv5dkFyx+X9FOz0Ukcae4iIPZidRZD0CHXuLNBP38SNYuvSURtzZ7W2WHQV3g22f2qoFu5m65NVwdzfU+NNj56Zs97F5BhL8JtsDVwFa38TZTjDIfsW4FMeWbl9Toew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE6qZ+OpgNsramDZeZTiUgXM3eSmMRSG7dHeeC6vkKc=;
 b=NFJLTPS0Q6ZJVDQ0miesPKdK8v8+V6Tfje8OBBShuLpHf3d5qkzJMxPS/dM141OZqcHN10NBgKs9F6Zqd6zMLvs84y5bZNmNASE5+2ZFGlqqgR9BAyH5z2SBKi3bYs7rd2aZcA64i2vUp3q7RYfFzd1nKfFn+DlvkEHa5NmR+/ToLscqKdhFh6XVpTCyBOwo0jrAV70jxUjbmzFQVi1KCcenahMs6oN7MoljGWJBBZv3H2DuGeqd+bhBbCBElmw/hqF5JAGd9V3+u3yDqXO/6NmR+blUYonXbxf33+Egtx9Z+OozhyzFRi1YCdFs6BwGFMYFwdj38MgOC1572DFJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE6qZ+OpgNsramDZeZTiUgXM3eSmMRSG7dHeeC6vkKc=;
 b=C5GmhNYJd0xz6pHQEZ+9ERppSkYeuRJ2g4PAjXV7Wy8y9EYlmNJU1ZWFcY/pcUIhckZLQpfJ4y1DFdWXWQSKeaUwE1arY9DweLedTf0iOX7f9CFF2b8xy/9DkeQeM/2MWaZrjQUB3WAkIoz8bjA9+dEjPYgWamG9cyNJJm573z0=
Received: from CH5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:1f4::19)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 13 Jun
 2025 21:48:15 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::fd) by CH5PR04CA0022.outlook.office365.com
 (2603:10b6:610:1f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/27] drm/amdgpu/jpeg4.0.5: add queue reset
Date: Fri, 13 Jun 2025 17:47:42 -0400
Message-ID: <20250613214748.5889-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 133e8143-4d77-4bbd-c47c-08ddaac40094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rxlR8pfTcOyDMUpFE8x0diWo6GyEzT0eX+vDY7cOnkWpt9G/bZVjVItCxxJM?=
 =?us-ascii?Q?UCxEmOx21YbOB7RpRyUD0NWqQw+5kjYADnlFTGVgdAOSyH4mqRPzENhFHpyx?=
 =?us-ascii?Q?XY6Bm4ayd/v3ddsDDrgKGXkOGKp4a0mZJ81/c4169Fco9OtUFT4zMImUdaHr?=
 =?us-ascii?Q?K6K75Y1ZZtMJIPj1D93seDp1xKBVFP5IoGUzSsc1T23BqS6X66pYeCa0QaX3?=
 =?us-ascii?Q?FZPODDV52yA/RKb5B0jpNva0WU/mLzrAdHJA0SVLE4gdc1cNs0koz0THqmgU?=
 =?us-ascii?Q?r40Zp5cZIo0RWvaRXm0Q7IbLmUEW5K1CHHw8r/efd15yYQ+alrej0A93v6Pr?=
 =?us-ascii?Q?MCLJiS6WeFv7F5iqCPkzTFzC1G6I9X02DfMm2JCunUE9qqky7/nVT/EHeqjz?=
 =?us-ascii?Q?ihpa3rF+tGzjA7xTsoHlFr9MIiaOz1D0u5KZfSxoW4pvNVvxGc+FMMmTnkfH?=
 =?us-ascii?Q?Y0JzpfKg3dPKDYEsS4vzqs13AM7gyd0RtrJ/MMA/afLfJsRtSQR+U/5ujxix?=
 =?us-ascii?Q?xlYp5TlDQu/QMW18Hc/kgtvTcifKGZKUc8xDuC/+xVOzi8QX3E/9ttXqkRdb?=
 =?us-ascii?Q?LQXdgW1quc3wNf0p5iXIiSjCTNGUMmOZN+SNrLpNUyEcpNa8fa9ED0oy5Geb?=
 =?us-ascii?Q?sAQ7ocH6t1cKBSUEy+bfhgyAnqHlyiimHvLJk1UNIsyzrETlxNsnF6SoA9v9?=
 =?us-ascii?Q?Ji6fDZMpOKzbDg78dnbQFVj60vc129pgkqqZbJ6ADD6+VfSC/SA6/fi9U18V?=
 =?us-ascii?Q?0/f0/NsHheT45qYT7EujtcqJ6O7xqt35c/fne+X/mFa5kMnRerWU8Jy6QTQi?=
 =?us-ascii?Q?Jy9xJocZlz+M5R/P7GsxFNksoLIXJG7pEOa72qTZR1RxdtsK3VfCxXZYF4dw?=
 =?us-ascii?Q?N8R4V8GzlyjwLPf63V+8ieK+zGhvVOHHgHnpmezYeid9G8MhyYz844k1Razp?=
 =?us-ascii?Q?A7PzKMLKDm+4ua643d+KphxRxsaNa1f39zxUu1MlD0E2W4moE/UPZ6KGPt2j?=
 =?us-ascii?Q?vILMR3oFiIYIUyKAifcXfRhry0yCHj3qcym5/enmOuj2tl0L1KAPs2YS74hF?=
 =?us-ascii?Q?M5+A+OTDjJRzIrw41o+f3DWxOoTAlxkyoz5ppcLIlbCtt0OCup0uFoOgwzNq?=
 =?us-ascii?Q?QdUgQN9Yo2SUSROAwJS7MbV45aBZR/Coc4aGweSWV0xLwi1+XmRTzw4BxXo2?=
 =?us-ascii?Q?bBjLt7Ae+QtEo7Upwj2dsm/lDyyVUFoiacO/Z50NqpqbxX5fuvofqr6edqlz?=
 =?us-ascii?Q?1+3OEYLTkYBe9YiWDfDkXqfj2mRIk7pnVKGILyeHjIOnYib6viKqWVL/9GQJ?=
 =?us-ascii?Q?0pKKgPzWly82WF1cuweEHyMgtIifQrcmC69m2zAhhAqOJBu9eF0vzSO3tXsC?=
 =?us-ascii?Q?n4P2uMxMEZc4BCcVb0VMR+ZwdFzepGnac9D2ZEOHKJAXnytnM7SIMCl2yqip?=
 =?us-ascii?Q?wwD6amYI3HmwSWOMSOul326kK4IkuzR2yfF8BB4/dRKrlMMOqGhD56dfsgAt?=
 =?us-ascii?Q?37dRBiDI21MBAQ19++VUF0iJG3Peku0mdj8L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:15.5987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 133e8143-4d77-4bbd-c47c-08ddaac40094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

Add queue reset support for jpeg 4.0.5.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Untested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 974030a5c03c9..c6e89aa9217df 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -767,6 +767,30 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *guilty_fence)
+{
+	int r;
+
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+	jpeg_v4_0_5_stop(ring->adev);
+	jpeg_v4_0_5_start(ring->adev);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
+	return 0;
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.name = "jpeg_v4_0_5",
 	.early_init = jpeg_v4_0_5_early_init,
@@ -812,6 +836,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_5_ring_reset,
 };
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

