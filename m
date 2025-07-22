Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E93C83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A43D110E60F;
	Tue, 22 Jul 2025 07:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lcb1tp6C";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE87E10E610
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzflXEAh/pp7sBSCFOuUxyqQgjzbwTIslTIawo1/COH92mdW8bgSBABraILcGtyPhzBBU7gpwluEnPwauV7fwab+IFoW4PGHHkpq0TsWAEBMs3Zn5D3A3ZSpn7tiKBaDVKhj/Mz4H+EPbZ0Jc2khslTWK6qM9wsuJQO9JVa5X4nDBJ3ne2swfhIk3lXiR7eT1s5G9eqiOwnrG3XHdTfJeA+e29RL1FycXkOGbV8dpXsrzms6X/ug40UwFLTqCng4lqHwNAZRskJlVDlgZugqV0vYOCODlnG0/Al2LCvl4fjLX8xVL6qDF9ERWVjDDNyiISZLBHd2fNVWhQ5Qe0uAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HKMiyYb3JOsHdDDafMg4Lf7cAZ/qcnO15JNGj67GLY=;
 b=ow8Sxz6PxgvpVDB71tvt3wVtSzH90tSRQN42Q5AP11aqFs49HKf8TDstJCO5dUxrq7gJ2n8lMuLd5uC1krwIeNhYpjR7yl8OWZTcdX9b/YLFfti4h0usFRrhX5IGIhwcscR/M8TNrRZ0jNgjeqqH8JxcujJ3GuCf2S52tJt+Sqo5L6wkdEJ3inANivqnsaReKQPdeSqOsaS0CROjh9MsDG0XbudyxHmY1sCdTael+Yy99vJdWjjiG2bzOKCxWKemCxW0xREsifNu/xJPU3v72qIjznt3hGJ+3JJWhpQFFGBi/XXCnaW36VxUPMr/Pc56OmiilDBHSS5iRtySNDzrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HKMiyYb3JOsHdDDafMg4Lf7cAZ/qcnO15JNGj67GLY=;
 b=lcb1tp6CMP5zhiQ/K8RlwE49wdZ9uUj3DmOgTU5Ibqorw9NwgBR5ATDXVovNo/XAdNpmD/U0Zc17i8A70SwDZQffjnf4SUutWP8X3Sid+iCJAkR7XAOJpxSuc0YF1zErOiDh+fGUfblHeFpn+OJk++F+MWjJvQww3Pw3gbblgS0=
Received: from BN9PR03CA0656.namprd03.prod.outlook.com (2603:10b6:408:13b::31)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:46:47 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:13b:cafe::45) by BN9PR03CA0656.outlook.office365.com
 (2603:10b6:408:13b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 07:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:47 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:44 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v7 06/14] drm/amdgpu/userq: extend userq state
Date: Tue, 22 Jul 2025 15:46:15 +0800
Message-ID: <20250722074623.1464666-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722074623.1464666-1-Prike.Liang@amd.com>
References: <20250722074623.1464666-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: d0987dbe-a3fd-49e2-cbd4-08ddc8f3e92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wy1tGFCDOV9z4wu6RBpXIJeZuDsbgy7zuJvjoprEZ3In3iexrtKdK0SskMcl?=
 =?us-ascii?Q?nxdci8OmYil3SDPmmJmtR1uE1ac4QrYwirIb4ELhMMxiM7+/la31JluU/z4A?=
 =?us-ascii?Q?PdxH8nsMNC9qRDhXyCfFK1GsnPI7vmBIaLUNUEk1WV+PbHQw9db6akusHfHw?=
 =?us-ascii?Q?6BIclkgDQyCWh5az1+PkHL2hhpHTEfJg4NJTfKzmMcXKXiEOMpPg+jfNBGMr?=
 =?us-ascii?Q?ds4YqYLYMFLcy3ciWfWAzHWxY5gvLSyyLneVxDvzafnqosD33VEM3GXcGTDH?=
 =?us-ascii?Q?216N4IABK/KWw8sEOA/du+gtpu+Ue7tL2Z/KiZa3Zem7Lb6XbslASWFeHbVH?=
 =?us-ascii?Q?4KasUN0dYrkJIY1xdjahR+c5csCRBaGjSPkjc+K4H9LJ5r+d5HQ6JPqyvFx1?=
 =?us-ascii?Q?cHYRhKuD0eEG52ZUtWEI0ZEouGqihFkgtxvlWVY4mqkzBdcEIbiYctATCxYb?=
 =?us-ascii?Q?Vj8jmV/XzDiAt9J916hLl0Xf01qvVNRbnL/7ivAhRKgWgkCXia8umkpS6s+7?=
 =?us-ascii?Q?bwn3FdiR6IAMnN10cT6bdcfwLrckUA9Hd6p5b8A4WRa7j6O8P4XBDyvraRM9?=
 =?us-ascii?Q?zoc5iwO4C8wZ7tOZFwK7nHi8zNnJs34DrVsNWMb18o1MdaUT/iBHDUiqSopQ?=
 =?us-ascii?Q?Yc6NsYfrc8jVpKYbzR/fppQwT8wrdAj4ExaCWvQnOm/fvWwqJZNpXfCOcFA1?=
 =?us-ascii?Q?ooArvipWYyuhaPsTXgjnCxIIgv619rBTsNkWNyhhfJdf7s5fJlbRl6UVKVXZ?=
 =?us-ascii?Q?JDkzL1WH8wLlc2SbzZd27YKXIKir9FyN2fX5rvkGInUfzqYEA9tMqt4zTLLX?=
 =?us-ascii?Q?Pvh2V9fpj6bFR2his6nAS4os2oXbTVJziZohujn4Ar+DU8jdRvX31HvFy5ia?=
 =?us-ascii?Q?xpb6cCxA0h75E8X4zsVydt6N//ViEFZhpii+EC26IWVSa/IwoVxkRttoH9dr?=
 =?us-ascii?Q?MLmR91Thcu4hXHLkxDaqPJwkDKnj4qiBF8GyWeiHikhl3oGP3GZqbBv10UKH?=
 =?us-ascii?Q?KICBGli2lWmKgtBMAIBNNZcgjNt4hWjJMxQMGEoaTAYvyenhRNChbi9HCAql?=
 =?us-ascii?Q?YS4T7SyNlLkbaprmmXstQaevV/+7I37uv1dHR1K/a8IOOH0KtN7nm3Anb+2y?=
 =?us-ascii?Q?GJ8WtYoH4sLNtQYqtTCmYi2HLgFxpNXrm4aWdruhB2yEfp8FyLwspFbVQbZP?=
 =?us-ascii?Q?1sPbIR8kzUM8BZND4lkrU0E+97/JDIiECqiP9ptm12um0LmLzPv+/A/7pJS4?=
 =?us-ascii?Q?DwJr0i6WGQyj3ozhv/xZgjv8M+e1eunYYfmhuru4mtiWxhgqFBrWZpWEPdY2?=
 =?us-ascii?Q?nCZOvW4B9wplpzLUqFBK5VQkMjyKk7QFhLlFIa7WpvvHIyZ3bx41oqYgguUt?=
 =?us-ascii?Q?z6AL0sh+FOZFj7TrhPR9Gu/HTpg4w/7YX3CpzDjg+OVDWO/9Z3e1hJXsFi0K?=
 =?us-ascii?Q?N5GcKtYrKlGfjEDII4LMtARXmGaeyDvRbkxdhGAjuhyZufEIe336qv0yd7hx?=
 =?us-ascii?Q?Wc4pnhNvsvfGe/MURL1CaTcvS80KgdBCRllD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:47.0887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0987dbe-a3fd-49e2-cbd4-08ddc8f3e92f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709
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

Extend the userq state for identifying the
userq invalid cases, such as the IOCTL invalid
input parameter, and unmap the VA before destroying
userq.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 75b7e39ee576..b670ca8111f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -496,6 +496,10 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_ARG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_ARG;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 48722936ff70..694f850d102e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -37,6 +37,8 @@ enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_MAPPED,
 	AMDGPU_USERQ_STATE_PREEMPTED,
 	AMDGPU_USERQ_STATE_HUNG,
+	AMDGPU_USERQ_STATE_INVALID_ARG,
+	AMDGPU_USERQ_STATE_INVALID_VA,
 };
 
 struct amdgpu_mqd_prop;
-- 
2.34.1

