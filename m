Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE4BD4415D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 13:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD81510E636;
	Tue, 19 Nov 2024 13:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l1LZmJAn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B6210E636
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 13:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqkYq7LG9T6k31d3jVQblR0Aofvmhs1mmU1qQJpq1/bXPQPsExv7J8pwEDCNbwKpPbLVhzMXKYn0ZpSR5GLecJL79xLhQyFW050kj2L178CxscqnzeZqlfuT1WGjYFcpDo/HI4kGFd2x27AhgDX9IklDpsw3gjBSo3PoZsLv5rxeTQrFUI6aB7aBHgxAytgVKUxvWR9ERozePYI60WL1scD7OvQFPs5T9sktgOAQCbtAlDXqVVDjarF0WGLUgZRt2VRis637K5FUBW97e1na7p4v0tG39xR5HsFy25erOOGNo0aRfFkUMflxRsMKI1L9cpfw2osGI2RWCUQCDmPyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYVfP+9TuOPgDl+HnxOspMnTF2exHbMQ+L9VvhVnPcw=;
 b=zO7EGnNkmC/C9+wRMz7dOQnoB+4a6to5aQAl8t/B68cuK1oFYpN54UGN4OfS1Kca9F/WRX1LDFeEKwVoaUwdObYkSbZuyGOD4/lJdyA9FUBoRCnoicZC4PxR8AempfVqsemaalW5uaEBGHA4GuX8MAQKBNzCl7H/4NbQg84YQET0ghwa73ZszqfVaOSkLbLAQL7J0Y+wRHrTLTniaPYsuQkPJLN+xGFpuPD08BvVX9WhU0PegVb9RVNTprbZdU9srval0QkpJ/05BeSQQw4xSQJ6qQJQd0FrKN1mALJ12pIXoDSJakWGniod2XDZ5mlmwS0BPUictgF0wxXNIK7iGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYVfP+9TuOPgDl+HnxOspMnTF2exHbMQ+L9VvhVnPcw=;
 b=l1LZmJAnDLhlbhqJfOtCPb0vjbjd4LMZwHu80BWRlJVOF4vgtIhTHMu9U0qxoeK3hAgz0/VVVKY1fdnZdJKG9M8ZoCCk2SN8w5ybIeObiXlMwDqd5fqq89yzXVVWLn3JkOEwWI3SBsjax5zaKMJ9N/qDmbMgrthO7MBIKueJRqY=
Received: from SJ0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:33a::33)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 13:23:27 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:33a:cafe::a) by SJ0PR03CA0028.outlook.office365.com
 (2603:10b6:a03:33a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend Transport; Tue,
 19 Nov 2024 13:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Tue, 19 Nov 2024 13:23:27 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 07:23:24 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add NULL ptr check for non userq fences
Date: Tue, 19 Nov 2024 18:51:12 +0530
Message-ID: <20241119132114.163314-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 428b04e4-e218-4cce-efb3-08dd089d5a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?urMl6Cfo37pE3LBTQAUQe96XbCbNgsHpqfAX0t0JOdHoiNPT+hbFXnO4BSkO?=
 =?us-ascii?Q?GRxyEVG3T671rDzfiHvfS2jUk5ZP+Tg8xLLmJa03+kddz/UZxKyVyB6opbLO?=
 =?us-ascii?Q?ah1m/p7sLslGndNwlw4sknq5OqzQUgR2ON4mrNGmPflcjHQJVNw6cBQ21Ach?=
 =?us-ascii?Q?lwGhSzmanQgtBiFUEUQZf2zs9APDryT4Iy/g/K16Zn0Xd8GHnuxQURx0EbRr?=
 =?us-ascii?Q?boCEfMBqKC19K13Z1wPLYZVK3GtWMlq8btVe1bL28R9zsgiybudzvkVnAQLG?=
 =?us-ascii?Q?hcX64Nq1jBC73XnQcehi4MFtIz7NTffvUKVpCkzN5mUWjxbFlg3uIaGQ48Mx?=
 =?us-ascii?Q?B93cjVFa0zrLF1kTHXAIcBfT/ojU3XPdNjoBh5tLLnjNX05pX+uVqTgebVmG?=
 =?us-ascii?Q?Ab46Tfva2+7lAi41IWTzI1PdGKIchN73qrHH3DjrvgtGaJfrXlMfhDWQJDIY?=
 =?us-ascii?Q?JkcdvLqnCu8HJtuFj4ydTQzTxrgCsZwefJv/A/FxINcUUYwV3Z4uvnmvLRHn?=
 =?us-ascii?Q?cXPyLevl3TyiGvbvoRnTnWKE/XytZif/BMpFc/er+8GwbY26vxMtvPNXK7Fs?=
 =?us-ascii?Q?fWuAYeUef3TKjV64OXam4x+vP0MONp8UYRnopaDhaISKtzhlmzUhEPicYrV+?=
 =?us-ascii?Q?ZusdDHVz3yMqQJx1YheaTiVuveEpTK+PAJO1LVJzMy3uQ/7S8YVH6AosMkwx?=
 =?us-ascii?Q?BsEU6pefLKVHb0c2eMksS4JT7kz7L2QtgmzC4GQ9FhpAq4+9CppYDMw7M9ZV?=
 =?us-ascii?Q?jqKkH4JnHDMlkw2g0r1cIiq2+Ct6J4HKh4S8Tg3K2WYOB5GuTxoP6Qfq0wL+?=
 =?us-ascii?Q?8hYiU6TW5/QRrucqGyJk5KZvWuEP3f51/b/m6FFVdkvXfArCaUY6kXCl3z99?=
 =?us-ascii?Q?SgUhFI+so+gy5f5MBmnxO47iwDZJh84Nu6dVY3Bt5eLYYkIxPUINGiHWz7hP?=
 =?us-ascii?Q?83Y0nhanLC8Y24LGceSIrVGEOUtVFZW3gY+IuHwutge5YKfyqQmYdwapSG7i?=
 =?us-ascii?Q?CNCN+EllHn9H8c4Ibesb2L1H9jKLiGWXq8OsQsF41d+ULh2BfwDnFiV1LlV2?=
 =?us-ascii?Q?pLM5ebFbVi3DI83veEy/0zX3vZsfeqCKviP1viyRAvtbhFftITkNunbRN/6b?=
 =?us-ascii?Q?cP5TEN9ZaaA2honzfDNw6/RAtRByoL9jJBU0aEgn7xfhZSkmTUgUl/Ffe/WF?=
 =?us-ascii?Q?cPxRqZiPtdEwQQBHWdLNfPnPI3I1a2JJ9kZR0LtUaEaIE6l9fnSNvYs3Emw7?=
 =?us-ascii?Q?X0+tkBPMLKROwjhfIbj2pm51uk92vLcuac9VZDX+UrTLvUFuKnQKtzdRNo8X?=
 =?us-ascii?Q?qB4kGyWN4OqBdn3/cGvzfylIXD2rQzH+dGuXiyt4OvqdnOK2EAlvbrUdlNUx?=
 =?us-ascii?Q?CfuDA8b1iHYVEOPtGORqyYO3a4VPJkcIKk6mk3P4sB10nxx78A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:23:27.0829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 428b04e4-e218-4cce-efb3-08dd089d5a2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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

We are observing a NULL value in the non userq fences,
thus added a NULL pointer check just to avoid the
NULL pointer dereference crash.

v2: Moved the NULL check above the non userq check.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 6157a540c929..76f7babd7a54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -815,6 +815,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			struct amdgpu_userq_fence *userq_fence;
 			u32 index;
 
+			if (!fences[i])
+				continue;
+
 			userq_fence = to_amdgpu_userq_fence(fences[i]);
 			if (!userq_fence) {
 				/*
-- 
2.25.1

