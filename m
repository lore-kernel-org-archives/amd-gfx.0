Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8A6C10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFFC510E2B3;
	Fri, 10 May 2024 02:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GTUajOhl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B832610E2B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvRxyV/1lRDwnuCbgOwPCQER+zX27qn4WKziymrTFLJgw6gJGhqgNUR79lxQTQBJITf8cGQliRXpTmO70ylBEiLHEHgTA5VkyhysYAJxh3Hu8Jz9VuhnlNmUZgXTckMO8mLi3PoNqDr7VVRzzuN/7Pt+xlyftw2mFhLkW4RINYur5H6kibbOHfaICfcck2VsrVboPoarPp3h0MTAB/IaG1L8nyR4hW/duvfq+ChznjsZP3ekD3QSXOEyPtbrO3Z2LnQds9YRCYUzLppWpn0WbtKPiCcPj2PZaHNq6lnwnG3qD9ONuZZT3PaX+uIh9FLU5TiUDDCOC0uZI4blAV4CuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxpv+7akmFiB66u2L8Aysu+jI8AlPeNfKGIqWpFln8U=;
 b=hK+Lq887EXIwZFLL/4xEv1RqIM4IyY/RFwfzq2IlDYcl//1VCnRgxHt2Hjgt6YIdk6sUJ9HX2s6xQTBPUtYThP0rw1sPmBgyhriOVmD/rVUM7SxcsegTgyEX6pYRAdVEd2SO8FVWcZca6gf3i/xdOHZxfUHYAN4aqAt2YQh2EAMXlVbBjTE3WTVPamnQF0x3WL+9WsPByg3iqKJldV7nN+RLTZK1MEmaXxhK7eE9vXziLWzXHLMkyw0XDPTFvLWMZLXQprMUU046dixgT0+onZK4BlkD56FT1DvvFQq8lmqFZVW5EjLmI5AyQHErb5notoH1kZcPaetvNSRyxzvFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxpv+7akmFiB66u2L8Aysu+jI8AlPeNfKGIqWpFln8U=;
 b=GTUajOhlvZWF6AhzqC48rOmG2KVcp2IXcCEh1XQGkbMFUmrrgQY7e+bZ9FCHF4N88zfFiUpugLsJLDkd19ZDuo9E0DRH3ML/Hd7yrAAwagl3iQEVymi4V+rS1ghdnv4tAuogZTtVb9OXjr3zUrMdKI/WCj0TBtw66V4/Yu77eQ8=
Received: from CH2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:610:20::23)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40; Fri, 10 May
 2024 02:54:26 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::57) by CH2PR07CA0010.outlook.office365.com
 (2603:10b6:610:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Fri, 10 May 2024 02:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:54:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:54:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:54:24 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:54:18 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 19/22] drm/amdgpu: Fix the warning division or modulo by zero
 for the variable num_xcc_per_xcp
Date: Fri, 10 May 2024 10:50:35 +0800
Message-ID: <20240510025038.3488381-19-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: be3aedee-3671-41f0-b3ac-08dc709c80d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DIjTkBm+rH37Yu7Ml7bkDN16SWllPRolVmNGcSEbmFdnRfAK3bxD326Jh7o2?=
 =?us-ascii?Q?o/IMi1GsvQJpt03zm8aFmdyRqhUXm92OlgtBEdkxXwuEYyDbEdSKHWq366yO?=
 =?us-ascii?Q?AkKr7u5vSUxqdZUmvQ7bLeENTKr8XT3Ii0eTrFCIGka5vWavgc9IzKjOi3sP?=
 =?us-ascii?Q?esZoxX13aEFCQyFLeyPMZyAb3HAuSMHWVMs1xQ8sFyYEKPm+Z9XUngMox2qW?=
 =?us-ascii?Q?EwiChNZbpj9HJgZOz3r8+yZMiTMQYq3dsl21kJwr7alOWuwFgXaokOvUTgRt?=
 =?us-ascii?Q?ZCWunMy1HP/LvPIB2UxqqHM44rUclVWdXV/SNFSfv7bf8TIjyLJg2DRFB5C/?=
 =?us-ascii?Q?ujuwNWnIy7o/kh3byHpN6PVhrp7Pf1ESkj6Wto+4RhaTRCHtUaZ9vkwKZ6/Z?=
 =?us-ascii?Q?8C3/0j0rsCsT6QfK4GC2+IM2+Uz6CNPQZeYp8PKnMw8IQAmRYTcRJBUkBreZ?=
 =?us-ascii?Q?8t8djGSKgbiGu4JO8O+Iy7KuL6QqYJ+MpAH96v5asyIXhTZH4Hq729L3Vug7?=
 =?us-ascii?Q?vScpXSaACUbYMzZb4JqR3kQuIdd1nX1CMpSpYYRX8Gna3OqxRV/3KGQ8jWD1?=
 =?us-ascii?Q?XkuBTDE4ZLO9QEC8BV7E359dpPX+4rMfLXtxjGW7KHBsi5pKnc//lAO+NB6A?=
 =?us-ascii?Q?sC0MRhU31FXgQkqrnrNN8HXR0Biu0gAXDIyxzsOr5G4v7qTy9wSot2RD4GUm?=
 =?us-ascii?Q?6lQRe1J+iHBa+g0jlkvYi24ZVsg+D3hixddRgO6LeJG0M8x4VDItBeZ7g7mn?=
 =?us-ascii?Q?Kwn3MFODlGfPY2xRuUPGR0fUvDZMdEO0tM+J2aDK0OCDNrj/viy9/ZzevlE+?=
 =?us-ascii?Q?Psmpk5vxVdSaa0JzYZpXkl3Q2kAdWBSegwCfy7HTuBps8aH+aQymhEOUj+GV?=
 =?us-ascii?Q?QtWtkIL5Kb6ZIDMrW1wWpoqAdzJ8mdUnfSo67VKam7XsaTvHnHRydXvo+j7h?=
 =?us-ascii?Q?3r8uXTudACCqcIYIxF5/LYeK96O5s+JZmR5D3dneMXkMc/bwp08sYjWZIcDR?=
 =?us-ascii?Q?Kj/zpWNFmA3EYybYVmuVZfbPr1bc4ehr9loFBF2JqZ+ZAYECltm4JxNiP5eX?=
 =?us-ascii?Q?RmmBqaaq4bEDUK10QMh30iXY4+Yvt2Q+t/5j5O+SXxvnLU8+3ptdETJU7wAW?=
 =?us-ascii?Q?4qzvldqqSeghi38iYmWa6RG6gOfo+cjmHDRppNtpzVyKr/Eo+vDCZUfhu/qQ?=
 =?us-ascii?Q?54FOtL5uoceFbm79liAqrVQBUyIDCYhVHjEGITc80XZNLhSnleGOTGUvcYXb?=
 =?us-ascii?Q?dgf/+ywyNoaMzGd0yQGj5yZgNZIZZVTKEFciXjo3AoKeiVtDUBnDxA6gAtJT?=
 =?us-ascii?Q?ZOQsZTxh0basFiMqv02sh9Urca/7ZMeCQbS4FsX2xTeiL5KjLBETf06oqEDj?=
 =?us-ascii?Q?QK0xGXiEouvJIQ8xRj+Sc94A0fPC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:54:25.7881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be3aedee-3671-41f0-b3ac-08dc709c80d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

Dividing expression num_xcc_per_xcp which may be zero has undefined behavior.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 414ea3f560a7..5752c6760992 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -522,6 +522,9 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		goto unlock;
 
 	num_xcc_per_xcp = __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr, mode);
+	if (!num_xcc_per_xcp)
+		goto unlock;
+
 	if (adev->gfx.funcs->switch_partition_mode)
 		adev->gfx.funcs->switch_partition_mode(xcp_mgr->adev,
 						       num_xcc_per_xcp);
-- 
2.25.1

