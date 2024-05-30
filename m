Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D58CC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 03:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3427410E773;
	Thu, 30 May 2024 03:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IfsziRHN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94E710E541
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 03:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQs12e/A/8v98AI5Vh6IMWplm7SZMSdo18ZbhdsFzIJpRgGiXx55EgKFUvINZ13Mdp2SUQz9I5GfixquNdUE9CmuOv47jrLXw52OUxCqozDBUtUp5p9GpNGEZkomhrmgFPCEqvAcAsuXF5EXlgxP3YCPznHaFVSGahg0BN2VN7YJnAJC3i8cNWtFifQkNS9CvUeypGp9fFFyKWW4lQcnuRBdf7kIaiZQTZliAD8ANlOuHqSAxH1fJTFaUIYys1zQqQ/IO6ONItu64bY36P8bRZHNYzLPDPKTE1ay6WJU5vTzqr2ugraoI+thOFkqTCrx/OU4CGuiL6bm+3W497LiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml1etgJDQq0u5VVGjq4KgAKl2NtVF3/+KmFJ8TcR0/s=;
 b=HQKx9/04wKGqQ+5sa2lTVwQCVsCgYRXxAv3BxKd6yzo0bISS+79YIROFRDKVjrf05b5rwa+Kfw/QFoDZzUnm7ehujGFpsM1IHk0NK3sG27I/gCV4a8bV4uNOjysAOLgL3XlIZhqEXHqJMJPyTQQHGEjy44QXVy6jowKSabheGgo3SFJHNCAPhKkdgltIbci7aiaKnli5LjaTFpaWgiPm1fVWHyAbd7K8Vou4aL5IpgTeHrdDhgwrEID4AdsbTdfsuqk0RhKs/TRC6Ai718zTMhwZ/GQxn8blM+viGJhRweYZU7ztDPLEImJVBZZ0cy/5YoUTGsxGFm1otdUQmgMqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml1etgJDQq0u5VVGjq4KgAKl2NtVF3/+KmFJ8TcR0/s=;
 b=IfsziRHNG+Uei9HAs2bxBtCB7VmQHX7HWnwRpd6jhwDMRKNlW24VH7/WvRt9Fc/SifacauR9PPeY+6Drbo9PfuuPbNB7Tckyjq2klmrOFa3MvvHDusdklyiHTliABrENDEFChkzmZ3v/g8cuMGm0l6EblUo2IHyi9ExKMcY+z8c=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 03:47:38 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::17) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 03:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 03:47:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:47:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:47:28 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 22:47:21 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/8] drm/amdkfd: fix the kdf debugger issue
Date: Thu, 30 May 2024 11:47:20 +0800
Message-ID: <20240530034720.2341171-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fa33b3-c29d-4af5-7001-08dc805b3fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lwqo7mGXi6ZIgpGn9BnlwSheS9VVJpkdQsgOvxJ2HjNaDuwXCtn1rGJzheQD?=
 =?us-ascii?Q?5Qm3tMoVZWV+XzRmVwynVIqaxnmRwm6L3Pt8D4AR/n06IGX1EBq2fvsINXOZ?=
 =?us-ascii?Q?1NecB0Zt/6t7Tn57VOGktZLe6VhNRL2Oea/RUpl+L3HYopu5hgeK4zVuKbMu?=
 =?us-ascii?Q?76ACr8zU2AlnQ9oMXAD0NF3IWr89QUxSa3rYx6nuKmPzRwD75sweNc0HERnV?=
 =?us-ascii?Q?6GUOqNDQLUuST84tIvgSMz+mF43y15X4ZCKUT+CXw8HoKew90Zy6K/SN90yD?=
 =?us-ascii?Q?KgDpdWHnWRxtK6FRgCKRdUwV0d1x9rzrTzsXJJ17T6tSs2Z5ZM+My4ifmsIX?=
 =?us-ascii?Q?NXzbUHqxeKDc12/F/zsJXptjxvgzvXtQVaE+0HxRFY2+Ts7cU7P6xFTDJAMV?=
 =?us-ascii?Q?zh9MM65t5qmUAyGT7/3vxlEop17EO11RHo6MKN1JWSDtV6rYIawAApMD5py3?=
 =?us-ascii?Q?VecJY73eA965xopxAd1gKfEINq+ySsHuc/JxzNe+9+CS9C7dFvtGmTQPd6Wc?=
 =?us-ascii?Q?6UvluKMGiCJ3KyltTPOZEuL2l3zxah91z8lKQORFHb18+8Dx4GUkZeZMVbGI?=
 =?us-ascii?Q?AgGx2jixcJjWhFzyBVo3tNctbeOzAlA4B93O2eM6JpUQ9Ja3F9ZgM//PzGkY?=
 =?us-ascii?Q?QeUW6VHI2NEi6v4cDJLDeEpSJ6Qm1RfPP2os2pDXxaS8wIn0D8WhxaRYx/p+?=
 =?us-ascii?Q?0CoRZfBkoJfRo0Ktu6WD84L3o6HWxOMyPDqEIXx1Lnd6gnv1hMfbEu6qYDnA?=
 =?us-ascii?Q?vPZYaVFBucTU12Tp/qlcKxq1Z6YaunGBYQWTEIVYisThmcXx+MwbEMrMkGj4?=
 =?us-ascii?Q?zzKJunnyYTicp8KnAvlfmq/h6VGhY+3MGrFPFEiLbIYhQGjk3OcqCleANxns?=
 =?us-ascii?Q?pzr9d736F2+Tzu5vAtTaCTfR3sy2eHcOww2KWBC+bLz5t4VPLNCtr0UjXcZa?=
 =?us-ascii?Q?BCxsiJCI/WGroM1TSfJ1MgT9MYYdYeCh7ESdYHQY1mbco+DYai+PXcuJGo25?=
 =?us-ascii?Q?a2m5ERfHOYVzK+1NbIQarmVIMs8qvHIh5IO5/qDa8qFGZ2g4q0ezXFRx/rZy?=
 =?us-ascii?Q?fuE6LtBA4d+yVP4FYbDD20gCkBhuNTR0O5dEN//vMSPsLaNzUg1iwouBXA+5?=
 =?us-ascii?Q?rHFCfg1+a6nKG5/a4q2iqmkXQ2ihD5mA2HbJBIuoHO7IregPVgE0UmpVE3w4?=
 =?us-ascii?Q?Je/VG7/XHNdM1xdn3oTACXiePIK1Vi1wuwLyVF7P4dISHXOhwq5fEqTDkfW7?=
 =?us-ascii?Q?drhdE2a/oXLz8JXELJ6j42CiUrN803AuK2cjUh69bcIegFz9Vn/yH5Lzxg2K?=
 =?us-ascii?Q?YFUQtoBKVErIcAYk4c6Zb18dMYur/nSsz25tk6NEB467V71OwlkdB+NP7u5O?=
 =?us-ascii?Q?r8M++BuIBXOr2NSMBvo8MKIXfVrX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:47:38.0953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fa33b3-c29d-4af5-7001-08dc805b3fed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273
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

the expression caps | HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED
is always 1/true regardless of the values of its operand.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 3f27bab7a502..4abd275056d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -503,7 +503,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 				kfd_topology_device_by_id(target->pdds[i]->dev->id);
 		uint32_t caps = topo_dev->node_props.capability;
 
-		if (!(caps | HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
+		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
 			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
 			*flags = prev_flags;
 			return -EACCES;
-- 
2.25.1

