Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFAFD2ED00
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 01:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369BF10E54E;
	Tue, 20 Jan 2026 01:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h5APK92d";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B37610E54A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 01:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2oNw7dGpRDo/3yx9hZa3wGN4+YKISUmOl+ziUss4SMXrqIHI4wNVh53KCRrr7168VWUskv4+ETHLYYvhxf/F2Vpu3iMh4Vj74COntcqgVjX0GaLrmFLE6mo6LiefkhcGQqjP0tSbIHKTdkoqqNF2NTwIyqO63ayYuOVtUDv4r1Jtb3kxcgpWHH+cTbmbL3hboji41JjuZNH8Hflms/QPOzlsoyAqT78cg9s5UAsGFnftgZd2KL8v4cSCIUDu9LdrGqfFZ0hds2Dfq7FOqbaicAiuqsw5mogQ9+orbeZZoeHsPwj7/ERoW3F7S40Qq/g/+poII3KByRKtUX0ct/iLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffqJlupYO6QWFwXuE5La3Z1P8MI+yJffR1WzVyzgqYI=;
 b=b7GELHGIEHOf4jj2PsOY4tIg5apXSpoejOluTU4Cn+j3p0z+t5QGqECEjFTWysz5CzpRUaDTNlPhGg90YTZmohJHhNM3uNmq/chh8ThplShweHYCA/Cd0vZZIRx6sCxMMG48LQ4wqG8GKKD/+czqXxFIgG5W6xHyBM8FMPchQNXqknv1NTRk3Kz1EEnkuM9lSoegsETBQ+HqU130sKGUOItzEBeLjlbBUyxGCtlMt2qeag23C91B9aQxfV0NRFWhga/kSHhkAwKdpNGNTqLFL0rYGx0CzD/9aJNMk8Sk+pg0t2ltYMF+AHACBRo6xW7lKSteyNEWXdgxHnrBShmmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffqJlupYO6QWFwXuE5La3Z1P8MI+yJffR1WzVyzgqYI=;
 b=h5APK92dZjHMtYyXj82DChRKg6Xok+elzbtpLKtJRaKWrxfHVrLUvLaE9yxEWEEsmrDSRdzqnzSMEgtQx+MU7Sh8d7a480QiClXRZIcjRuO4Azf482OIvwBvCtFTS9CqL50fBZJQwaNmovVf709yEalECg9h3HgCZe6rT8TjW0k=
Received: from BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Tue, 20 Jan 2026 01:34:27 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::94) by BY3PR05CA0028.outlook.office365.com
 (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 01:34:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 01:34:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 19:34:23 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 17:34:22 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/10] drm/amdgpu: Call drm_sched_increase_karma() for ring
 resets
Date: Mon, 19 Jan 2026 20:34:10 -0500
Message-ID: <20260120013411.15659-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120013411.15659-1-alexander.deucher@amd.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: e57eb105-1906-44b1-ea45-08de57c40c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vr77L08nVbUfbVy8hsNuEjRO9+lI+GYIb3dA3SmsORQuNq0qPkXyiDy4macZ?=
 =?us-ascii?Q?6XU3KBfm4J5bdeQGYqPFMXkReb6pKDKZ3rF4w5awX4g/fDb4OiDAeeqlYuST?=
 =?us-ascii?Q?KCm4xeh6VDY2gWyMMNQriVkug/h8FQc3Ad6Ct+LlmBvyD3fGF9gg8PTANOko?=
 =?us-ascii?Q?Nn62pzCfWxJnkcO4HL1aoXPgy/RMdku++wHQYCUtarAeHsMVLlixn9EmjxRW?=
 =?us-ascii?Q?cdSEajBua4/h7pHofAsgAJ7bM6fRNEtlZFwNQRtU21WRnVGF/ESTJzDO0cGG?=
 =?us-ascii?Q?TGkpFf0zF+BtLIZen9+Ma7xv/JKIxxblMb4vafMR7pyhJnOz6RpB/LvTP9vj?=
 =?us-ascii?Q?WQMN1Eh9G1EnfBTzvJlYReQSHIbuI3bwRMSr6ESrvJNQU/vjHqlkKJkD8a2Z?=
 =?us-ascii?Q?0O2Kz5w0WLDsUlCmje390tA7wS/nxG0OxpAEC8jmwkxb2xmwUbViIGAs+xp3?=
 =?us-ascii?Q?XDkavm7TUUVjRBBKiHWXgNtVqeBp76OpSHBiocOajba7Qz/V7uVIsL/X/Gkj?=
 =?us-ascii?Q?JwTliV2I4iwuhOvsd8qNXdi6+njPOnLv7d67+SnPPj4QAAO+kye7NCuzVfj8?=
 =?us-ascii?Q?KfT7y6b3ovo6AH+oAtSIlUOUWT9S8SphA8h7IyhRjGKRP0LyNVAc7at/t2gg?=
 =?us-ascii?Q?Vs1jkcjScGxLiJEY2k3tOv0e505jk3bcy1aN7gP8v42hX1qFDJtM20kWUqdy?=
 =?us-ascii?Q?/t4blBg4N1QtgAVgWtybWlapM49yUuwXybTbOcQCw+4RddtQZd52kTDEOHSL?=
 =?us-ascii?Q?VsQplHHzLnRPHmokBZ7BiW2+oqO4KI+iQYwLfOdJeTGftP3TfiHJrng/WsdT?=
 =?us-ascii?Q?RSW58sYtyX7BWVgqhE9m3GZmD4Ef/9zTJwHii0JhjZOzP4OHo6BSnmWxHw+6?=
 =?us-ascii?Q?OY7bR93PtcM/ZB8N1xn+F8pURXTJ0vX0oW7Q4FU3qHYVUCeE00S9YbWlkPwE?=
 =?us-ascii?Q?t88VlJRIRe2g6ewBxOnhYZno4nZBMLPABBz9vUijHhm7BxO1sNMhJiNS/Bj/?=
 =?us-ascii?Q?kWWbQ+2/Iu7UOX2zUCGaxj5IZXoCzz9cmujGkGgILJM/5HIgCwqka0XJvHqU?=
 =?us-ascii?Q?0pagGHniKJw1VJR5pswhn3uHCLsMRwVUKKIkYo3diMbRzEl+/5JNlHGIE/AN?=
 =?us-ascii?Q?+/V3BslwhLSpHzyFOJ72r7D41sbVxdWeJ47tyC+/BHIYjw36q2T7/C7KVFM5?=
 =?us-ascii?Q?WGnZ9KZQds/vI9gIC5/uR1qBwNCI9bKko3kcl1vWb+q3nO5f7WY/B9mWgJaF?=
 =?us-ascii?Q?GGLWOGXedlv54zWNokvDmMbx6QZtwu1j6rxg0xzdOlzSQlFCWJpsv/0jJj/K?=
 =?us-ascii?Q?Io0j/rghFgEnsTluV36wxAWTePSSCkJNwgsFBYBEPJoPl/m92xlIHLB20Zkq?=
 =?us-ascii?Q?whLA0nFSUuO+eEsQOwMIxFTCIeYkKgQ6C8QNalApQscrbMGUTAcosMxmumRz?=
 =?us-ascii?Q?mwmWAoKOpErlWOBBaR89vsbYs/0yxkWFmGDHBnk738Vp5McGWnsu5YSAC287?=
 =?us-ascii?Q?GvzL047tZ0SwHM7/i0VYbjc0luY+SGdQzkEoOO8tSYfUijcaCu0hZoVz274m?=
 =?us-ascii?Q?/6HGpNwDQbMLr8hpM5wPfHfsmWV7c5HbZ3e1unxhVgD4E8qKPhc3jqfNnCp7?=
 =?us-ascii?Q?T64xZWUZ3eMmx9b0DSyaOaKsVu9UUW9fQv/WnUFv3kgvPNH4dJF9ZrdUrAQU?=
 =?us-ascii?Q?A4L7VQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:34:26.8021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57eb105-1906-44b1-ea45-08de57c40c92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
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

Mark the entity as guilty.  Align with adapter resets.
This only makes sense now that the CS IOCTL returns -ETIME
rather than -ECANCELED.  Without that patch, this would
break userspace.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index a323071762822..3c4b148d4f6ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,6 +137,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			s_job->sched->name);
 		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
 		drm_sched_wqueue_stop(&ring->sched);
+		if (job->vm)
+			drm_sched_increase_karma(&job->base);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
 			/* add the job back to the pending list */
-- 
2.52.0

