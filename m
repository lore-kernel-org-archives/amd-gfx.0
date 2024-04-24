Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B5C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 02:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EACB112CFC;
	Wed, 24 Apr 2024 02:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lIi3KwAD";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209E5112CFC
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 02:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6IBNrHuzwhTyZe6fd1MxLGJKZiXlg2/02zrutvwbTYZHQ87+wYBUAngqtxQGTyq2Qxg6VqelwkxoK4/6fxpLaUlAvha9Msa1+HkMw4GhFYLhJTMucMLGpNGBVjNiSVpZ8Kn4I7MQocgOjXeugi/+W1Ul5NsRjjMFrpAnVdsvRToXaQIDbfNWH6ap6uTtCxaz0ojnWi7AF3bTc+PptBdLqGpAEeu7VdSzRcFySBiHI+7MWfpK/id9BhN/zZvyADHG0GeKT1zaKchkjyD+/yZ8h2yxmqgQWQ2eMqRVCWCpI73sHT35nU/v90eyOeWdFd5pn+/hwtKV+3LrJvPqjaQ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/bmJnN1QeG+pZRBRkwsqlA4axZycW4Dvy64Ap1V5ZQ=;
 b=CjWsu2G0WKXjPbm9sBdgkrZitqBPUzT/imMoXpZHMMiq0BH7+W9ZYXrbfmWlGTYUHJ3Re47PFz+K8CPHPH24WbKGL5OLbkEgHrdpiS8hLEtsO/GWZIvojT6tbjQjffRxeENkT1kKn7UXpHrDOBmatS9H+Re7mrYAy7r7h0v2CJGJdJm4pIub8wtar9b+eDBFN8/6jxCBxUB0m5iwNSkOyC7u4jVrQgSEcYqSrkJwgDahG57WIZi42t8BST59RQcEatuv6QVSU9yilP/EdC5DtzmRGWowofPvAm+/i55YNfAa9jXiW0K8JVKHVfUIUIXwy/HCXRm0PHZrrEQzgz51pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/bmJnN1QeG+pZRBRkwsqlA4axZycW4Dvy64Ap1V5ZQ=;
 b=lIi3KwADb0N9fe4LklqLOtZgcXx2VwNpZRDmCs6SaPlr0rlzulBGGUVYD5AQ2kPUjPLq1LYew/yDpanfKfL+GTaqDpqLn7ZCSMTRUDNjQbhlOyi9Sj3xtqojGtp7ugN0iaYIJjLfxa9sP+WGSbZRZmq9P7IgZx1vHZNlX5bzrvo=
Received: from BN9PR03CA0377.namprd03.prod.outlook.com (2603:10b6:408:f7::22)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 02:50:03 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::fa) by BN9PR03CA0377.outlook.office365.com
 (2603:10b6:408:f7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Wed, 24 Apr 2024 02:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 24 Apr 2024 02:50:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 21:50:02 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 21:49:56 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <tim.huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Using uninitialized value new_state.jpeg when
 calling adev->vcn.pause_dpg_mode
Date: Wed, 24 Apr 2024 10:49:55 +0800
Message-ID: <20240424024955.727542-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: c6418d22-05a8-4da6-8753-08dc64093dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aJtafSciVoKWnkLjPGvSsu7X2ME4yU6w0z6ayEN7qZCJ9KNRRWkjO7L2oNWr?=
 =?us-ascii?Q?b7eKHjFdH4p1PgT6zCUJp2bczRPzT+8QkeZgXrrINOwwQCGmGIM1TmF+4n/Y?=
 =?us-ascii?Q?uFw7I+PRJgF0SgOXVj+3CD5//CtEcXEGGmXolWaGHpgUtACUrdetWx6OAeEE?=
 =?us-ascii?Q?S4YA+VsbxUKZ/4SRtAkUDCkyooYERW1zvgWojb+TkSqw/Sa0+IIKAFZY8Ura?=
 =?us-ascii?Q?LlqHI+tSACOE1DOC0BgPnAmuFOTnZvFTuXb6sAe89HWDRlmzbghSfQ3kIw0o?=
 =?us-ascii?Q?zzGJfi3DAb1SnGS666imr9tKnO43XZ7RysNEOlWZRZAygJEVZfbHrz8W8+EW?=
 =?us-ascii?Q?1pYZeKuKENbKwLVMrklsuYlfb0/U9ihRHQft107rV+/A44IUszy+5h2A3ho5?=
 =?us-ascii?Q?t7T7MEeOA3C6D2C7BjqFo8cTVMMcpGPcgOUzZ12/jpSWbvlmgVyEvfCpmWgX?=
 =?us-ascii?Q?v689/R2sFPQ04/xKgYXfxK+qtGcv0Kx4iS8yhGW7YX4e/t6UjcPQsWAnZSsk?=
 =?us-ascii?Q?qLDNV9oZCrua2SyoXmdOVii63xmFyRr5xQPyRB7JHbxsMXaK+abMd5HaTvcs?=
 =?us-ascii?Q?55gpxkZb3Xa8B9z2fjVdsguBDPOF0Ov4mWMghaN3klX8jcl2jPW+yEvt7QgD?=
 =?us-ascii?Q?U5NqyLMSm5VLzkMgv3dK5vw28yY78YWlQ9QvPwDlzElu84z6FbDE7lITzLOF?=
 =?us-ascii?Q?kOq/okfMJAabc3owz01c/8UVx9ufMiDjcMx/QghqOJ7LIRsJDhI6/Qwr4e4W?=
 =?us-ascii?Q?Td4aLaqPPaXEaYYpursDMlV4DAGiWHrzaCV/TdgnVPXRFQy/57q2R7nM80e9?=
 =?us-ascii?Q?F1ZUstcsAbxSFT1u2llUVElvuNR8my5d72uWqSeAEcKTg0Sh5zSleJtwJGnp?=
 =?us-ascii?Q?s0vVUL5zyjEZLSb36kBd5l2zza3Q9Jhl20t0BqRTkRGaqUhxx2/PgCWy5xPh?=
 =?us-ascii?Q?1qL/kidHrO4O2B0IsPdPRs0WUZNJSIFicuJHPYpLrE8Kk5JfoKMB/v3avrJU?=
 =?us-ascii?Q?hc/dhM0psTdm2Z1RBLuFKG33Dsf1cVO4JUlXx4SsEGnJtpXcEaGBp6xGLWaU?=
 =?us-ascii?Q?40nF5fkHGvD4hO0wiw9J+/dBSLjs8eAPV+X/5F0CzrS31dMdAEgxhYYMbNiv?=
 =?us-ascii?Q?lMypTrtoxSiqOfgbv8mlGu9FLAqoJsp8cUm1aAbnfi4MMgRm+QCGM6/U2CnV?=
 =?us-ascii?Q?PrwjUfNHbuJafXGaePQMvLC0dPmn4xFAR0MvYP36DrmpgFy79ASJDUUCDvqI?=
 =?us-ascii?Q?lh59Yd4lmOymAHfQlJiC0pfx8zaMrx3CJWFZj7i51HZye1SofEx7svhgkMg8?=
 =?us-ascii?Q?pPu2XLF6ZyhTrWvZuMUryndNAfZjBF9Jcc7All9+QahdvT1Ct6OofSGkh/mq?=
 =?us-ascii?Q?WFMrXEIWj1LKfuPbLUeTof9OyVFs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 02:50:03.2875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6418d22-05a8-4da6-8753-08dc64093dc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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

From: Jesse Zhang <jesse.zhang@amd.com>

Initialize the new_state.jpeg before it used

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 677eb141554e..13125ddd5e86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -410,6 +410,11 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
+			if (amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec))
+				new_state.jpeg = VCN_DPG_STATE__PAUSE;
+			else
+				new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
+
 			adev->vcn.pause_dpg_mode(adev, j, &new_state);
 		}
 
-- 
2.25.1

