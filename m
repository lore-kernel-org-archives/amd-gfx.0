Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133B0C83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1AFD10E60D;
	Tue, 22 Jul 2025 07:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sqgwD9GZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC7810E60A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOfbgkOwymJWVJxD6eYvozKRzZJETUx3f7MkqkeRyPp5DZ9lWJE1dXlAho1p9Rm7CSqUzcqxTkFt5itv4woh/i3j2NtYLNEpm+5p3jwBUkDjWHr5JGYaicvWsszVB+huVoy3bEsOOkZtsBCm0tntlEEi6d+I+KWZ57iDb2LTHqlI5g/aNJNUTsOli92hCCrYeKNkjrCCdYRHY0nPYT46Cn+Yx5nYWn5D/snzGrYj589RkmaKSwOpA5CsP3bpUI6Wc0UeVsd3q9nhhNLE4CNUwGjJtCDriISdeSO2kirvd/fUBptJLs1ERau0ZtAb61PsqoWjXmhsLuqcGQiJRUgeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEZkaZFzssbYJaP5hj8FPmoYiU63lgqoq/smH0UeTkE=;
 b=rXklQD/AzQfQF0RkOHSFkV8gCNqMeWcDdr4uMliAGWj2Fur+lXPcyboeT/Ibn4JCsgqcYEHsI2xaad8ky7Xc9c3PhimCPCBNxZffnFb4C+6lGO68aR6nHuBdmmqgpUxJyzTVBlYZuMekW5oAfC6b+gal5Zd6GluQyfSDbtTE9bD20RATB4tPuehELEnN2z/76GtqNjWT8G9h5lXJP5tDHFJ5dbf7tdh0xHq4EQHURJt9CuZ0j2tRMtOVsyL5nRYfVDpvJXuXXMhF6eVknMoMsN5tgiXI3wVAwP2WywuINGiujeirQSLyI3ykpT7SgWipCKUqW8Qj0KkVJvm+4YqaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEZkaZFzssbYJaP5hj8FPmoYiU63lgqoq/smH0UeTkE=;
 b=sqgwD9GZQiBiBLe5RFEzpSuFffI5s/nCTg2jWsCgPBlrOcaDHyONwGDpo/snQv0Gl8h6v3xGswZvsG06718BjZUmmQ7ak6lD5lSGpBBA8rPX93fkWYSDmFzh6dKSnkbDQ0i+OjcHarA3Bc0g1xwR2ZoOOl1m9woIxhN/0kdJuyM=
Received: from BN9PR03CA0655.namprd03.prod.outlook.com (2603:10b6:408:13b::30)
 by DS4PR12MB9633.namprd12.prod.outlook.com (2603:10b6:8:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 22 Jul
 2025 07:46:45 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:13b:cafe::28) by BN9PR03CA0655.outlook.office365.com
 (2603:10b6:408:13b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 07:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:43 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v7 05/14] drm/amdgpu/: extend queue flags for user queue query
 status
Date: Tue, 22 Jul 2025 15:46:14 +0800
Message-ID: <20250722074623.1464666-5-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS4PR12MB9633:EE_
X-MS-Office365-Filtering-Correlation-Id: 21841622-569c-473a-b059-08ddc8f3e7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+86e6F56Ewv25M+K0o/ITU/aExzQWNjihHGFDuF1H5pZbrudDygaZGH405Df?=
 =?us-ascii?Q?D5xGCLn1zEDlim+lTd1tupemWsQndGnKqIOkvwLAfyBBJtqC18adwVlMgt2R?=
 =?us-ascii?Q?4yfut728weRK7fCR1PjYvomeCdtubx2+l0d40Eaupa8xX4OIiCIt+u0adiRX?=
 =?us-ascii?Q?/4AVpvYpw0ASZIa0/m+zqIMo6rp/YEH7i/bd/dhhz6BYCQd3IcGiAFQ7Hpjp?=
 =?us-ascii?Q?NwMU7ggMT7twCWhCzOsDIkVXQ67/Zd7YRSmuqWC/lRKxfdeQGu5SoaEyn+i5?=
 =?us-ascii?Q?At/PLd5ZJjXqA8vZDT7xFVOR+86L7KupQjoETf79bcl1QcKzkKgBqOsojjDK?=
 =?us-ascii?Q?9/7FIr2iqRLgc0ZAO1pLqLZYAZQColv+NHnMYRMC8+BMo5w+cg4gdtLCTEWT?=
 =?us-ascii?Q?TMMgMdsIXyDjsp0egXTaS8wI+LKAeNq7vrcs7sFCSYs6iHLQKftvPodf329Y?=
 =?us-ascii?Q?XFeGHOShQgYS1HKg9DJaK7mury5Xnu+5eDsmib7X44ukno8eFZqIjVxsNxLo?=
 =?us-ascii?Q?Bv/cpPQSiK1F1uuw5i6ZOnrD36Q/Q9rvWJThpSHs7albeMouLBa9LTQftfsB?=
 =?us-ascii?Q?ptLtEsJibOvwLSFYnL/aj0vzV7w134M04Nib6oftnIW4FeCjtSJqQhsv4qGK?=
 =?us-ascii?Q?E0BiyIcJwjYE94VXT9x5MWq8kBYD8mSE/ISQOdhNFNX6wfCAAdXVzlobnOcj?=
 =?us-ascii?Q?aK1Dd23iBcUhddr96BybPuW8BoGy1PGwtm0AWGcvj6kFa5+A8QaidJla3/Sl?=
 =?us-ascii?Q?u83fk81HEpfG3bbctnz0UAOqLd+Sr98WmWPf3AkQiDfxlzGXIyfbrV9DgFKs?=
 =?us-ascii?Q?4yl/TZ1xr15t0vGD811OjOzwp3skXTgUDG8/Be+5ORnGo92orzjk2iE7aLFx?=
 =?us-ascii?Q?Wh4cjnK9S0oDpB0Lq8QUulrpf9lLyJqBIiQPcUl8p+63HKCMQ97IUFqS1IQZ?=
 =?us-ascii?Q?9/dAT9ZJEfK0mOiYr6xowxVWT83ELURD5o8W3ux0iwFg0ifFrUj3Mri3kOc+?=
 =?us-ascii?Q?WGXCnvwCIUvNA10cq3Kwo0kpC5Ronp+Zgn0Xn6zt1aOeOyGT5JbCWZW8yTAn?=
 =?us-ascii?Q?YyFon8NwmHMKrKKn4FnLksnHojPUF/Wk3rhLJY2voyOl6sEYJs5zkC+FyVu+?=
 =?us-ascii?Q?pyBO8z64F/HJKsKNepD2YREQamKpq0Pgdi3VMWA1xtF2pUFX6tpHfyZ0WPeC?=
 =?us-ascii?Q?2u8jzSUwmCM7dFs4ddEnvyLcJSdJ7W4+WLtXQfDWvGiv0TTqaawrPkAywthG?=
 =?us-ascii?Q?P7UhX/GKxUxX4i0wSz0qZWLZ/bkfmYUT07Sc+yvEyTi/U/G94g3doXT4hrVS?=
 =?us-ascii?Q?1b+MUzuBDnWSSe1teZ2MVQTDfY4VD6qiwEKSrJVVVbkr/fNRLS0lvsVO4AZZ?=
 =?us-ascii?Q?hbNGMvfzhr4tYIktINtWHxS5vYvwUqnNMTEBogl90fyvkM0Q6H5K2XWSZtJf?=
 =?us-ascii?Q?9CuVeZM9zPTjrZeXFXfDSsQJTMVA9pQKeUCL4H9s5HMN+yEgWgvJE+4pXjKe?=
 =?us-ascii?Q?MuAaHogp18ujqDaa468TMtqnu5XQFDQc+6d2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:44.8727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21841622-569c-473a-b059-08ddc8f3e7dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9633
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

Add the userq flag to identify the invalid userq cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index efd0d2356077..3c536c8517cd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -346,6 +346,10 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+/* the invalid userq input argument */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_ARG (1 << 2)
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 3)
 
 /*
  * This structure is a container to pass input configuration
-- 
2.34.1

