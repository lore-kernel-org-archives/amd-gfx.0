Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931CEC369AE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240C610EBD9;
	Fri, 11 Apr 2025 14:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OWbvwBhc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B243010EBD4
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYZADcQMoKHoP6nA7FhPu7K+tqmLlijCdv8lnMzJ4Sv5tnVRL2GPSsjW5o6IzA5BCAO40zBatqgJTu89MEEkoyb4IBZZ8RUwhOOF2M2otfAU4+Om2bfx1VVIHXmnFuxpLDYVqjUVLXKB2POgosZ6HxoMqUkoZHFjsiYvZltDuJFWhjfxhy4trt2rt+Pekxt6nrzsrCc5/i8Ap9hiSfWLpzFF8O4db4kKe3V0+3bkb6x2HLZAYazioBivpC8Oz88fACtcqbwT7xN42LN/ik637MN8JqifwrBYq0oJVxkhxOvWmemmVau1N4gi3ID8b6pwxPu+rkHoBo2JuLlcz41NSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQcOOuJCS9MjMWQlSFxkdXIeMPx3jd7Oes6QFCDU6PA=;
 b=EFsvIHnBvbk5krR2VQhFCGl927Ri0gTC69CBPp/nKVOSPGl5aINKwxK4qDt7aRFs8e45HYP/qd7yrLvNCqy9nZPpJ1/UYKDqlZFNa9tBqh5u5kr4BEADMSDle7ZWMPjJ7qyi8ilA2t9/qio3TpxHgiSobTOtlw1s7uvnKs8noSJnz1VJ5NxfNu9Hcv1+UmgxM0PO2wA+1vjDKqbJPSxUL+IxdC4h7PUKTa/Eb+RxuToc1e8tLr+uKEB+wCV7foZbnK0Eh+PbavtYxolTR49TF7y8IpbamMV72+97ULymSAM+h0y7xp3nIs+LSskdZUpe1x2NW9HYImCefmlsUNQN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQcOOuJCS9MjMWQlSFxkdXIeMPx3jd7Oes6QFCDU6PA=;
 b=OWbvwBhcHdNKhISGf9hcofmvB03K/Ep2KNhn3WUI8t2Vj7WxTqmYlf2TySLaYm2wJGPapQWize6gKygfF+UKNh8kn4uKpnWhMQtNjylxBAHVex1UsyCSHGK+5jC24QgIJuTss31NpZ02/F1uPULnfUEyz5l65lJqOIzqoVL6aCQ=
Received: from BN9PR03CA0643.namprd03.prod.outlook.com (2603:10b6:408:13b::18)
 by SA5PPFF3CB57EDE.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8eb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.24; Fri, 11 Apr
 2025 14:12:45 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::f8) by BN9PR03CA0643.outlook.office365.com
 (2603:10b6:408:13b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 14:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 14:12:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 09:12:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/9] drm/amdgpu: don't swallow errors in
 amdgpu_userqueue_resume_all()
Date: Fri, 11 Apr 2025 10:12:26 -0400
Message-ID: <20250411141228.2722962-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411141228.2722962-1-alexander.deucher@amd.com>
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA5PPFF3CB57EDE:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cb2d36-5bad-4034-0f5d-08dd7902ee9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e4nOvrex8R3GXpk8MX+QY6DuBpzTTDOAGznZ0JuD4Ug/FchepI87Go4wQLeM?=
 =?us-ascii?Q?8cBmOfZconaF/XW+9DXGIatOjq7Nk7uyqJOzUJ6mpeP1OH/BRHu62hSNna6V?=
 =?us-ascii?Q?SDlBPFkgdzt3+CUCRKzOBfysWCmlZucIDHQ8KHW+yeeraabOGv1EimSKjugt?=
 =?us-ascii?Q?yaZ1rimcVKYHNvwNQQYa7bKdzQ8nlqBfiLcs5iCfEXHGb8s2W7l+FYDj5bgd?=
 =?us-ascii?Q?7QkczreZARd3cSKTCghUDVjEc7ZVUgZOd7YhBpmCgJFZHQ98C+blpjUvXrVL?=
 =?us-ascii?Q?mDMPXZ+K5yiOsOdNjyMHjaktrktuRn1gVCDAKGXj842Volt/LeoK7VntaKz2?=
 =?us-ascii?Q?i8dHMoVmEXtG9RomqA/nMI1y3H6hr0Bpc9Z/IJdnb5/nIo2wXc9Qiwr7Vgj0?=
 =?us-ascii?Q?d7s4VsiigMPSmafT7sEQuRQgVANtJCY6AplerJhrgsX6Iodcvq21ra3jN2Z3?=
 =?us-ascii?Q?JAN698W7IARdz74y8S/6PTG3T+l6MSxEGpqRJpXOqBTxSDliS394f+7Knk6t?=
 =?us-ascii?Q?5ZMoYeHUYspMLXSZO5/OxDEaSg+ZLHejYZtWSzPTPfew+9oScUPt7mZrsyBC?=
 =?us-ascii?Q?9dy9ZZM7GuyBLa3O3jMsEYlLrRSfaWxdHjKQ6L/AJWhOixFCt5qoQRLQhl02?=
 =?us-ascii?Q?317arMXtVe+fYp9qsYJPfZ5zHkeCfTX86Tcdq0MQWlH3rDg2o0WhMneEAHjn?=
 =?us-ascii?Q?KOt02XDV2JAK8lACPHxsXXg0K5eYqUlN9QtKAUcK06gM0VSEV8HRniFz5tAN?=
 =?us-ascii?Q?pKUQGe/RIlw4yHd/rKc75cfREUQM7GNNDfwTGaGuGlpxu4nmCMEeHMV5/UPM?=
 =?us-ascii?Q?0xB7pwyfn8EaD1AslSv9E86cxZ+ph+5IyFZGRL9ZI41Ax1nhIdP3dvoOyAv3?=
 =?us-ascii?Q?3CLb4wc3l0T26hrOsN18QO6tevrBYnORi3Q4Dgi6ag0ahjEgF7ncgCIjwjOT?=
 =?us-ascii?Q?kQwRzpkNejS9c/WtEGCgwZ9dfN9Wf4K441mNtYmOFyMIMWlplBO9CN8pHy8n?=
 =?us-ascii?Q?oTFn2C/IKR27JBma4fdugrsMTf2dhSHohb2Ym5GqKtVXBDZ83Rl0vrJ/xGFD?=
 =?us-ascii?Q?AjiS1lEduiFra6hbrLvuVBcIHX2CGd2Fp+JGsx7NFtjo4mPch87u8ZSGmCXw?=
 =?us-ascii?Q?TiE19B1LPT/XiEHxVuAB5PgVell8JVBir9eFTajOIXKFtmsoO3bD1BEvyMFk?=
 =?us-ascii?Q?KZsmnk9425ZlvIQ95oNad+Y2odQ7TsJPGfMdVcL2F1a9OXMO0YkMiVazGsJm?=
 =?us-ascii?Q?GS5lqPn+6wEYoTo/2jgtFNgUVY7s38SDiTKErzLjki9511ZdI09HTgYS3UZ5?=
 =?us-ascii?Q?+kZCAuTlsYWkfWKnWf/GdUSjPRGhnv94EbxjVYkUh0O88g5ztAQDP6khg4KF?=
 =?us-ascii?Q?jBUuIh6bSqif5AQL1g5CKJvB3e4DQpjco5ifXOMol/56GMuNJTpNjUOcD1H5?=
 =?us-ascii?Q?OvEzXDi6jt0Y8oXW6/F+5Sccd4+VpfOZvWIlSZ62de+x/QYwNruAIQovQMFf?=
 =?us-ascii?Q?iSTMGfmMqyiR2Tp2OVZc2F1Q0UoL9gR6R7k2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:12:45.6135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cb2d36-5bad-4034-0f5d-08dd7902ee9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF3CB57EDE
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

since we loop through the queues |= the errors.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index f5c2489baae43..aa7222137c31d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -423,7 +423,7 @@ amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
 		userq_funcs = adev->userq_funcs[queue->queue_type];
-		ret = userq_funcs->map(uq_mgr, queue);
+		ret |= userq_funcs->map(uq_mgr, queue);
 	}
 
 	if (ret)
-- 
2.49.0

