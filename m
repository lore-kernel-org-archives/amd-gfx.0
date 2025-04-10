Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AABC369AA
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A8010E14D;
	Thu, 10 Apr 2025 18:12:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgZk2DB1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B7810E37A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4FUruezGFCDG2fxusMqrZ6xzVp+58hoI3QfqJfFeLu13QbhoK+OB3kA87Han2fmFF80xeT/CbEv6iPzTKXtTVqU5p/qOtg5se7Ib+6v8nkPHbxDVKiFmFEECEgIWx24sUI2pyKqjTMlVLW8Ll2c3oCcMe+fsF9pP+xMvMeDQVhAZjk5jVgc+zEFha9sbp2DILZHHxuvXbe1IMc+6AQJifT+pX0OuJz/3BLq4vyoiys0TabRCz85b7z/VmNYIn12VrVv5mDS33UU6CbiVwPyhlV79CnWXI1krtn4gO7d+igCreX5A6RodDN977zwIPEQKiOFnYyKP6SWDPikCJObtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OF4JYZNOSPv9Jy2s2KtUB9Uk23OQM9BUjrEBkVY7u0A=;
 b=XJSTIsOmPeig+0fDtVnEzfUxSJP8uwvff3YF2ohNoWt/i/4XV465MhiBIEo0zLo8RhbQTJHeX/RGS4Ye7imEKkmzVT/3GBycMNx62azCMWQvJV0GPPn2XFUdXl7L26iWI4PqNrF0QL2dKBRNDjgWL0niee9RqIFUkI7Ta9X72f1syp5rtvkaSk2EBJlNdgx6gL2mcGSLw1zpx1cfcokXvqeQAEl8mUmL1x5uTzffvmYYDKS+sE5IocXHZG/AEz5BIvDVfZqxM94lKMP+67vff0xYlgtQ0eJ2+Ry1jMvB8KVJUf0VHy7uQloWk+OK/oex1xwUHtgQUMaycDosZsvsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF4JYZNOSPv9Jy2s2KtUB9Uk23OQM9BUjrEBkVY7u0A=;
 b=sgZk2DB1Xvk2lAox8wcKx3XrtbmY5rPe/2txsM/edjbdll4/oZrvXwuhVeE7M70sAAujDOXIRlCDAwBrWULZyxRrg7eJ219WVjxpgdGY38MYzHcX3vGFVX3t7J/b/7HVmVLG/yFeRnOc2g4M0ArrxUFGCvpkVlS9FD2LONJk1Yg=
Received: from BN9PR03CA0344.namprd03.prod.outlook.com (2603:10b6:408:f6::19)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Thu, 10 Apr
 2025 18:11:56 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::c1) by BN9PR03CA0344.outlook.office365.com
 (2603:10b6:408:f6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Thu,
 10 Apr 2025 18:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:11:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:11:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/userq: properly clean up userq fence driver on
 failure
Date: Thu, 10 Apr 2025 14:11:33 -0400
Message-ID: <20250410181138.2287932-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410181138.2287932-1-alexander.deucher@amd.com>
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ae38d4-f2fc-48a1-89e3-08dd785b2cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JsDJ2RXm93BGQRnQ9vyL7psLR8+uaY7HZZHeNOCLIBpdQ00f8UtDAYKDh2h9?=
 =?us-ascii?Q?UO88F6rcNESrNGSOQP3oXgsfcOh2f3TJ4MsV8aDfSM2UrCf0QPSyO8YU0V0i?=
 =?us-ascii?Q?t4ddEKP/VKOrjEaRlUlp+n+tWefxNRWt6XtlV+LuHvlB9c0rqycBgfvlTjjP?=
 =?us-ascii?Q?t9ZIT/HopadBz0pTE/E0Fky1N3sSKp5DlsKcej6vq8FDs8xF1Zqb4DAWGy94?=
 =?us-ascii?Q?IPtuX/rkzso4wxCoS1OmbZCOulaNX6MnSa09wnosbacEcjQfByMLUYxCbt26?=
 =?us-ascii?Q?j3qsvp+7MMlyRSUFo7J+3EygEVjMl2cSXVEzB+sjD28X2nFKIk+lLscTA1Co?=
 =?us-ascii?Q?WG49D7Hi9gg8nSPl6MELSsNhpqgVRicVzihzi1ZaDo+ftdfOyNsSqkrpaw1+?=
 =?us-ascii?Q?3m5B/CNsQPv6qaIYGUgLTg1aUb0/hUFyVtRMlHDxduAfcr7H7ok82hmdodzC?=
 =?us-ascii?Q?tMVjomPpgbOTwxugesEkJ1vxOOmn2b1y9aCSwu0VQjNq1oI+zhsvOYOQpBqx?=
 =?us-ascii?Q?Sg9QnnzLeGG2Bombco7R41KlLAdjBDHGEnX4w5VKoY0IaJIiU2LQnlhzJRwk?=
 =?us-ascii?Q?ubWvytkz/sn6AS4rDHO/cGSTyi16sMEZsW8XgSlf6XJ6kHfZeW/0DWsDD+MC?=
 =?us-ascii?Q?4eFbiKRLO9yMpR9vZZi7ZmmhLyNUBwI02LR+bKgYZXXVsRQkRkqlWjofI6pN?=
 =?us-ascii?Q?jMmbDLEsGeGgSlq+703uAxNyuthwFJ9wC3/Cqla5BcWifZylzVeZMv0XGqEU?=
 =?us-ascii?Q?5w6z0TSh3LCx4UWDULJhDZPCqo5UKP70b0Rsa5usYFPNnL5l3NEG42IFVW0r?=
 =?us-ascii?Q?YM5gHtZwsfnFSyzGrrYS8I7F/nrj+z4/v+IeAPV4K2AmMVVnrAhYx2ceaRyd?=
 =?us-ascii?Q?r9GSq05Gz0FnJExylWr8OGzK4wP6xPqGtwzWGIs2qu77tfVha/C16fjaWK+I?=
 =?us-ascii?Q?++FPnC8vt1nV94sJ+AiEqJjbf4puDN9nKCWatGU3/AZ3wI/LfSeXn9q5krMZ?=
 =?us-ascii?Q?3kL9m2/zsdz7VbY3wivJsokJYUXTrcUwHMRAL7zlsBTqLsUW8B07jCKwmksK?=
 =?us-ascii?Q?OFCg1tHqMdFyj41P/RZnStMv6agWmQQooZo8XcwTCgCITW6QZRQO7gOUuMpy?=
 =?us-ascii?Q?RTlGjkEzQzdw1bzkWgha1SlrsU1zqFIdnG21VUEhFG431NLt45RIroVHdsjO?=
 =?us-ascii?Q?xXAuHSEUNOyaT0KDcMjYFcFlV2gfpGjN9083TohkOn7WOkTC+uQZtB3x7xGc?=
 =?us-ascii?Q?PzUf7l/3P4cdLvUCx1ojkuabHOzY6OXrvD/0upjhv853C7j5L0unU2rhuOWf?=
 =?us-ascii?Q?vjkR2T/AcdnF/H+9Ap55/LXXU3y8wVrYVuBBsts0wQU55uBn0G0tnN7QWi4J?=
 =?us-ascii?Q?SZ9hQxglKBlDHWVzXdfevrCp742+CKGQ+5w2JSs2QT3JIwu7CL2aIaVl+ABl?=
 =?us-ascii?Q?mbGJr3wECgUnzCgAIpmqgT5pAq1x8tr7AQh1SsqwtXbCTgCafPJeuUAcYacG?=
 =?us-ascii?Q?dYZioMFw8KuxQ+g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:11:54.3002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ae38d4-f2fc-48a1-89e3-08dd785b2cae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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

If userq creation fails, we need to properly unwind and free the
user queue fence driver.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 79f4df4255c50..6157258092cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -330,6 +330,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
 	if (r) {
 		DRM_ERROR("Failed to create Queue\n");
+		amdgpu_userq_fence_driver_free(queue);
 		kfree(queue);
 		goto unlock;
 	}
@@ -337,6 +338,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		DRM_ERROR("Failed to allocate a queue id\n");
+		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(uq_mgr, queue);
 		kfree(queue);
 		r = -ENOMEM;
@@ -346,6 +348,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = uq_funcs->map(uq_mgr, queue);
 	if (r) {
 		DRM_ERROR("Failed to map Queue\n");
+		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(uq_mgr, queue);
 		kfree(queue);
 		goto unlock;
-- 
2.49.0

