Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54ECE6BF31
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 17:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8335010EA2F;
	Fri, 30 Jan 2026 17:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yb73j17P";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83ABE10EA28
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 17:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUZDmKUR1h4duZ9q+7DXsgJAdjfi5DjaSDCz+735nSJaTqbTCXLyvKNNTM8JBIjfNT5H15WDwjWVjWxicz3IzM93DChrzwwYY21G7gE5QDp+8i9LxZOZ//gqI3UWzp/r8L6sMaNiJiX/UF6vskxT3JzTqsL5XV2gPhCIy9PgE5KtVGDPdjDiMW4fe53nPSIScUF3Jx68TKqb3wk5fHZ7vzh3ty2ghpIn9VdxV9c4EA6wW7uVn2diRvpyVH5TUKPOzKTi8bkGfua649XB0aF708/xVa9vy6awe4mw/FjkQRD7rRwyT/ppdLaZcESguzaV4qUH/QjGJ7N0YHDdGL5g+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4S1Pmh0th3Gut10CHq0JgUPLraJRRt7YdV84A58bVE=;
 b=l/G70TE9DtwhkWsEOtnBUtkqFNnJKgw6jZUIA4oMecfOPM+uObvnxh/KrOdq8vcydK4EvaiAsyH2rGeOBfDOjUjAPR8azUpvgmCUlR8X5m1CIp/cAV7sfWAqiaK3QozX7MHiVSZC0INlFuNoJC1OSsLy3O4/O7T9lO5zJzcC+Iy89O+0oa9VhuKw/XZD0aGHdZ/YoXmvm8k/SFR0w2vDHC4Zq9/IQ4NC+dVPVSEdJU8zrGxrEL+zp/iBefbsamwZS45Wia6koYYvo4UC+MD1mcOFUREqKthmHJ6vZdqgWP6uz8pQ9ibQc/rc8VzHjp6C06n9FXt1R0ukUiOCoRwb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4S1Pmh0th3Gut10CHq0JgUPLraJRRt7YdV84A58bVE=;
 b=Yb73j17Pc5lKbC1m/ks4TFc5tFuUM5Mgxi5h3l4KCPOdPVkCRab8HL9JCUVM2gcG8liVTE+LEUOvv1//3xUxehirugZ794WS3EjBG1uE3hsPAAdJnF/4j/WVpSiRSf054cAVkCC3j059ZvwANixkG79tS20cozVIQzBgJA1TMo8=
Received: from BYAPR08CA0029.namprd08.prod.outlook.com (2603:10b6:a03:100::42)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 17:31:07 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::15) by BYAPR08CA0029.outlook.office365.com
 (2603:10b6:a03:100::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 17:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 17:31:07 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:31:00 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 09:31:00 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 09/12] drm/amdgpu: Call drm_sched_increase_karma() for ring
 resets
Date: Fri, 30 Jan 2026 12:30:39 -0500
Message-ID: <20260130173042.15008-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130173042.15008-1-alexander.deucher@amd.com>
References: <20260130173042.15008-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 66186f36-2064-4ab3-0f84-08de602559f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RRmI/jrbVLGsHctgakmY1AyxLuD30GycKiJ1n9WlC4YNVXoPF4Fo3CMNQRCH?=
 =?us-ascii?Q?5yq9HGjcrgifOt0lVIXl/Gh+elhVoTptaUryJYep5wFV+SY2prENd4OcPjUS?=
 =?us-ascii?Q?ewrnQaOtc7/ytj35Tah7KzAfU4vdvnTBfIuXbfOON3dxhZ9DLpD7L+m0n6jn?=
 =?us-ascii?Q?lNtLiSg//vh5pdQ4fWBRLdRge8vzVISU4YG19wAJvNQ9Vp0FMfdIPoGt9zr1?=
 =?us-ascii?Q?A4A37TW+DndmFzg6GBGU4b7TJgfuUDBePFgnSfBD0jZQdWfiqA4Cwp0uDSZW?=
 =?us-ascii?Q?aFlqZeVdGRZrnmOr7bmAZ0dnREoqttpvF0ik9yWgcYAg/EadgUkxj/FOiFtx?=
 =?us-ascii?Q?iWhM+I1O2i3Z6Rx0PKqzaAp2zh41RU+76alZvSDQts6UQgF7U8zRdmepn8Xv?=
 =?us-ascii?Q?ET86eXU7dlghdhh/StdJFZrf4F8EZkcGLxRXPhpK6ibQK9Sqj3KH/4Ys6tdJ?=
 =?us-ascii?Q?berFELPbjiWD2k6gv8sHeqNX0Hv6AuAeKidVaLnyV+xbyIQT7zw4Fa9tzA4S?=
 =?us-ascii?Q?w+WRgqmjlGf6fP+sOgMQj4oiHTg9D1JLssSMb5IpIJu0erPwz2hkkmnPHWWq?=
 =?us-ascii?Q?PoUhhiEKrhMChDaJOu/DRQlh3RwlaWUakwLePbWbC7Ni2twBURSOMn3UMD0x?=
 =?us-ascii?Q?4rVIZX19VWeV/9595yIguM33yztbhTqLCHjTRh4VQsnnLopFgN+3PCje+Nsv?=
 =?us-ascii?Q?Z2R1bdevgwPcWdIAPRHC83EDhiyikKyylFXXhNpcjaryh2voeWHpplpkpq+0?=
 =?us-ascii?Q?bruoChPdj+JmkatYYtyPuF7cn+6mhCjWre6huyaRURHg8cb75zp3G8n4MuL4?=
 =?us-ascii?Q?h/qzAvsM2rAqaF9fW8jQ4rAiFO2Lb52ZLHVrdj7VQJsBI6THox4W3Msxtu8D?=
 =?us-ascii?Q?HCks8fR+mO7AtuVaS1z7vNWpfLemwIhLqtI5pLlpv/LwbJLETjHlZC1JVHIe?=
 =?us-ascii?Q?necZBAnBfKSYxuznY83QxMgeL72Oh+eWL/Py1C9WhklTSyIbBexADlX865T9?=
 =?us-ascii?Q?zDeZt85mQEUQiPxWQJb+J2H77pu6ou9obqaxlcVo1XxJAYw0LItYuKxkV+GH?=
 =?us-ascii?Q?DSIx76DERXac1LFyfDaYIfyvhtCgzqIh3da5+XUPedKZ87GoX7S5v0A7XExz?=
 =?us-ascii?Q?9D7LOJDzIgLuem5p+HNzJWSN234FEP9xSmJq0o14DgGQrnAFMs419rST3ZPN?=
 =?us-ascii?Q?xnD9IHMSSf1TgYjNmJl/3U+e3E9JV+CpUD7WCCZJ4gc9kKeKn4hOuFuf0S7l?=
 =?us-ascii?Q?XxxTWFq5BJBpp67IicD/Jiy8/y6ZnaLcdWwMhGtis1lqBjpn0AqsoTXwMsdq?=
 =?us-ascii?Q?MRBTkHz2TjNdWy1vchVrdKWI4HxsmXzMUBG1NRh4330OIkznLqSy9agmg5ZI?=
 =?us-ascii?Q?qewbHCQkfAF7PamVuhxsMyPQT1xfzz7bd1FYLSshF35nCXf3hvXtpScLmPKq?=
 =?us-ascii?Q?DQPFibsYlITRpuFfn3vTDBGME+AK2ntP3+K6N78RTis/DAcJfUXVl0pu/FbW?=
 =?us-ascii?Q?fH0LyDiWwmkTtacwg8KOKBcYtqZvrkI3pNCJz+KKUqbQLcWCIrHyf9yNL3mr?=
 =?us-ascii?Q?0beH7tRDWS2uA0lPS7jcVBGEBqlMBDvmFJ17abcJ6eqkbyxpJvC+LkNrQiRp?=
 =?us-ascii?Q?/Q6LrWWqiifUYeQvX6UINkNdS7sNPv68kDrwbX6Uv+1o6ghIQ+EFj5+HBUZ5?=
 =?us-ascii?Q?87KQjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p9nkEI4PlfKtLt/9tChUnGOavOs/3ZVDUXJ8QJtLvQmCfq0ar79PghIUca+VWxll+f6hz7tMvAvuB2nmq+3CRb4lz+lyUg5X98mXQ5VSHoTGPqK0f6RIHWoNNp+/Xg5yvAJcCvVI/Xw/1YZNqfeH1YLSyEVEEagOGvZjTIIuaIxwb4uhHzf4vU+s1QpKp0y8l9PV1QvqDUxuYz9tpZTXKtqGH73acnXAi3EntUd8AYTGEbuXBY3mvkBSZCYN7u24lCtbadXqrUgousgllQMlNLC3OMPr8g9pYX8DjM3uhKX9i0yyvmiIX7cTO49aeHhC78SIydy4ihZiuiGUpEHq+h3ucebM2a0liOUzHRJRvY/pFFARhDKjuBmuzAEsVifY75nqWj+mQiZtkxCWaTsQSxjYA81rh5ho89Fo5ccLjTqH6ao1eC7nLVgI5CpJRDT3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:31:07.1142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66186f36-2064-4ab3-0f84-08de602559f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index cd0707737a29b..dd9b649cf88e4 100644
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
 			/* Start the scheduler again */
-- 
2.52.0

