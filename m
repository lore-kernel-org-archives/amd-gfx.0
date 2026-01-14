Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E66ED38FEC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B3810E662;
	Wed, 14 Jan 2026 16:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aFJe6aVl";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73C210E662
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZiQQKhM4VGKfZ8R/MWnLaTfP/4aZKwtUPOTAuUuBvNRsGgclAk9kNtBIq5jL2DzL0RL8aIfQbmdqRHxrp0NcrtE9QoDvK8AcBT6W26Ux0rxFV/cU/nt1Rhjzpr/GNNDnvW5lBrguIx1+mkhzJOrY9+MsQFtJAeXmhveSYXZOp9vYi+HAOR0H7UyclR1Fi1s5WbSwCVCL7no+XF01tv+7bYW7JCqKMftmiDP1+aEl2eUyvf0xlzmMHAAFxt9kjedIy+6A6aJFqcDA7mItsXPgEj8xv6E8HlBxedLhIyQyDwghK8LURJJvnMJz5moLP6tIwkBPQSRDlK3Ob4B38vhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpFlmIOi5Dz3K+fQOIzfjEGEgjlkGkTDyHzPOpDFZig=;
 b=l7uxEWZ2s84165CbpJRc4JF5rMvI1+mmem+nDiEu1lu4kZOzQBNxndwhpbZGxh2ngW19DQgKQir6GBxVCRSZ8f71iOA6seqjr+HgMat9ynFyDxTsCHs2NGJ72YBa+qrs0YghLaVRO5eL7uTK1c1/5S2l10tp9Tf1uJluIxYEUzd+IStCrUlSnFgOviVsqz7KY/pjDwBQo9lNuLzU9fIhyh9lWMCZJ1TAgTyEhwIkgX5POpciFoAY4/TZb2eRffpRXoODLLBFvMqweOgw0uFuY+gdZwC8b4dV/LyJb7jGVH5QxMsfTk/qVFAlViB+F41WH3j0MAqL4AWP1hWP260XTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpFlmIOi5Dz3K+fQOIzfjEGEgjlkGkTDyHzPOpDFZig=;
 b=aFJe6aVlPYEKbLo2Rdw0kq4fc1AsG8P0DSdZxxNGXxyeqONpr9vOjMSG8EFc4iLYlQbGu3REyed+YryxVGJJgoFTlE0NSDkjmzBokiGmMBCWc3KJor/DXSjz9VrPnk2aM3+nwcOADeZw26RlJ9SDADB5WJoSZJIG6/infsoPaLA=
Received: from DM6PR01CA0006.prod.exchangelabs.com (2603:10b6:5:296::11) by
 LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Wed, 14 Jan 2026 16:48:22 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::61) by DM6PR01CA0006.outlook.office365.com
 (2603:10b6:5:296::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 16:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:55 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 40/42] drm/amdgpu: add helper to save and restore ring state
Date: Wed, 14 Jan 2026 11:47:25 -0500
Message-ID: <20260114164727.15367-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 5883bee8-3117-45d4-4d98-08de538cba6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l4e4zTwwbuDfx5WMYuoIOyoAf8SEYIXYU2q2Fjy7eOGz2VAv5E+DSPsXh0B7?=
 =?us-ascii?Q?xHPYpVZgCEmjl6OKS0YNiPImznPYZlzzOtf0S3OwuJREoU+G3kFW/VLDuUW7?=
 =?us-ascii?Q?EcK5NqcSAPZJ8eyJXImsgHIsnm6EEi6DN7C1EUx15yd8aSqeyIT5OjcqIR69?=
 =?us-ascii?Q?zI4Wrw/bRoF72NNUZcXEsWlz5TwmrdNf8eY95Y9b3KgLUjVdoaIqCcLyWqQo?=
 =?us-ascii?Q?1D7qNl7En898ErDWF2IA34HBaGMWAFq/xfZRbWaQgt3AbBbT8sqTPAX12ewp?=
 =?us-ascii?Q?4OurcksGucis69Rw9MD+mgssa1pl4Hoih9Sam211iavQYDqv9OvJDaVqTRqC?=
 =?us-ascii?Q?3cYtMNI1ZKwVEREiAF01NYIgLuJ0oAFQ+XGINZ3tw6LLjpfep/mAtaFnEsSA?=
 =?us-ascii?Q?5LPParBPXFwooZrvDi3QNUG4Ig1dMZ2QGBmwlEu7SAFdyWpSOGI6lS/78Iy2?=
 =?us-ascii?Q?MDJlzE05XJxZJzwAGitfJ3gDcBmZSxT0cgi3Rd31Sf7uQLXp27PtXxe1/HbS?=
 =?us-ascii?Q?YO+tZ4kgjM12g9r6wC/6fg3Zbf2g9veLR3F/Qli2mx7l79FT4VPWdCpxYA5b?=
 =?us-ascii?Q?grYkGoA6DDkClXoMJ5D40yCjOPAsrVT4H5rje0UT9eCCWwR9yP0M5ttpH/04?=
 =?us-ascii?Q?i0rm7Bvf9eB4A7HdO7bXjCFB+ZH3i+v6PakwLMyiPgC/MCRXU9g+PCFmV9p0?=
 =?us-ascii?Q?cyzvb2MgZhyRz6kQndGDNEOzbQb+3XP88PPGJ1lsR6YBEV9vS1QCwH1H+4Wj?=
 =?us-ascii?Q?iqZQQaMZ3lWp3YP6fB2lgS/mVi4r9dV8VCDNyhdzfCIx+7uWtpjHUy5dgBYx?=
 =?us-ascii?Q?DjumnM6kyULDiOwCs+GP2qDgwPy6XAbb8vIoaeKw54z2g2sASYHp9gnDCi0K?=
 =?us-ascii?Q?YjeYcazoqbXr1vThIlzCQ7stMWYZzpUHjlN4za786sLXcpEI4czHtYAO7qVV?=
 =?us-ascii?Q?tYJZ6e3qiXCFnjosAT6tBKbdQkP+SdlCSXzpyV/WOk7LBYM76iTm9+7B5FRX?=
 =?us-ascii?Q?WDQ3asNNxoxXHXQBpvN1I21iz3znJxuzt9mFJ8C3XoZI7/l4w3ZZFrTjxClN?=
 =?us-ascii?Q?I5BszeL7FSiIsTlSxavUXtly0tj1heOIVlHbf6eYbR5sChzlG/GeJhRFInBn?=
 =?us-ascii?Q?NXnAc9lqGfhrhWswvsMAE1Og7OyOO6LPTF9tbvdAeZ5YfqdOnZE6wPFpsSfl?=
 =?us-ascii?Q?uu8KpAz8HwkMowy7riUxcQhUNcY3k2zSVXJzn2uNNqZcyhLDoW6i/X1qUDmO?=
 =?us-ascii?Q?2K5BwMvLUaCwFR4DoVO/bTCmrdKe5SYEiI58VXbJWkZsKj7CcbaLzuE4QJyk?=
 =?us-ascii?Q?i3TqkizpGi1opFKCNICukLKo22TUmA78KcFOkA8NisGUwewVl94F1DMhBN/J?=
 =?us-ascii?Q?LinSe3IN+ZuaI2Vj0vLmYRdfsrGPPf6HSq+gIniP4Lmwq+JlME/3LMeLCQj4?=
 =?us-ascii?Q?rQEnHW0sp3jxUBdxTikZaW1LdtQkpNnevWmcNF/zMU+YczcYxE1oxJE8jRVF?=
 =?us-ascii?Q?nOlpO+58D4LjQ8zPaDxwp5Sr5lZMJu+Jq8ozG1h+0SxbLf5bB1gfUU8g/3C9?=
 =?us-ascii?Q?DuYRi6uHjvYBdEvCuZ5cIa8dPDefPbfBimTiCHEqPCqesr6LIkM+MKB3Vc+d?=
 =?us-ascii?Q?7bKucMpHq5ihrqyCewVIUqi+oWXanQsXoYqChOsuSH5HPvOYNusdnVQFcSDx?=
 =?us-ascii?Q?lQ9QXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:22.0707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5883bee8-3117-45d4-4d98-08de538cba6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
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

This is used to store the state of the ring in the job
prior to submission.  On re-emit after a reset, the
state is restored so that the re-emitted jobs from the
state at that point in time.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 72d50602a8e52..c8c9a80bb7c19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -109,6 +109,9 @@ struct amdgpu_job {
 	bool			cleaner_shader_needed;
 	bool			pasid_mapping_needed;
 	bool			emit_vm_fence;
+	unsigned int		set_q_mode_offs;
+	u32			*set_q_mode_ptr;
+	u64			set_q_mode_token;
 
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 2a53991eafd7f..0065ac0fb1e52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -926,3 +926,19 @@ bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
 	}
 	return false;
 }
+
+void amdgpu_ring_save_state(struct amdgpu_ring *ring,
+			    struct amdgpu_job *job)
+{
+	job->set_q_mode_offs = ring->set_q_mode_offs;
+	job->set_q_mode_ptr = ring->set_q_mode_ptr;
+	job->set_q_mode_token = ring->set_q_mode_token;
+}
+
+void amdgpu_ring_restore_state(struct amdgpu_ring *ring,
+			       struct amdgpu_job *job)
+{
+	ring->set_q_mode_offs = job->set_q_mode_offs;
+	ring->set_q_mode_ptr = job->set_q_mode_ptr;
+	ring->set_q_mode_token = job->set_q_mode_token;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 63272425a12f6..340d4f6b87a93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -586,4 +586,8 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence);
 bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
 					 u32 reset_type);
+void amdgpu_ring_save_state(struct amdgpu_ring *ring,
+			    struct amdgpu_job *job);
+void amdgpu_ring_restore_state(struct amdgpu_ring *ring,
+			       struct amdgpu_job *job);
 #endif
-- 
2.52.0

