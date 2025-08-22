Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E3FCA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 08:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8750B10EA97;
	Fri, 22 Aug 2025 08:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gl+kiHxI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E5A10EA9C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 08:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kkv9JpAsM9+NuUXW9WIF3wusFqu2iwPFxEsQ9hpgFv6Fg5huTMAuw7vPaQysJ0V66b5SbQY9O3b0DSSacBkTbWk7ZDXbbZXnp3epI744aRLE07BR16Qm9ZsvT+ZsH6OUdn5bWPSBGL2nnHpyMyWVAnbAL5OcqgNyWehhsxrFoDTaM5DC4o2EMfEHVELf4VC2O+hcdclQ+K1p+ptEhNvD9Brh7s89u+enrYj7awhI/C7JB6+TxfbgLN0ia2pHV62hcOwOU5F/a/4YDxXaH99DDtaDRPd8nWMK3/V+3MIqoOhbC8GGYHTRZn6Re3LunCV5wrxxMuLj3dF7jx9k15SqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=CXE2KY/JGPdDsavBYHcjyTXPOCy6Kg77S/db2Ob0F6+m3GrZ6dSaRF+5ImsyPlgdXdiex/v7wZPC+h4KB5hk77SktiDUAhpYLmqax/qO/gK2DCRZmedtPwGw430CNK2qjAWks2lqG0x5dT67hbJS7MAtsa6NKV+YJVmr2dxG0AdilbjoTlv7ZLos0KhnCIA+OQFsev9Wv0HhPQfJBPBD/zyFoVF8sQcJl+J7lumwRsHeepycS06mMuhrYZEjFXa/hE9Uky/3jhDuruUJceuYTpPb8Sw39N+FfmQLNW5BbaG0/traU7/SMbTFO3/LJyptg7ftUqvEaCeoeIdMAL+s8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=Gl+kiHxISBXEl+iLqkocw5w4lI+kdZj1HEpMW6FP4MqoF+SSO1MzOVwYe9lKVctson4XOryigaCxb0YCMoIiXIBIgAg4m6h/gWRa5RHOh2Ds3UMTVeNXISSZMxZP2RUnmmmoWzGI7YVvGTQWjtBGxTqWg/7Q4PqFMgrGuh9RWuU=
Received: from SJ0PR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:332::17)
 by DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 08:54:56 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::29) by SJ0PR05CA0072.outlook.office365.com
 (2603:10b6:a03:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Fri,
 22 Aug 2025 08:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 08:54:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:54:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 01:54:55 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 03:54:48 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v10 03/11] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
Date: Fri, 22 Aug 2025 16:51:06 +0800
Message-ID: <20250822085434.970798-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822085434.970798-1-Jesse.Zhang@amd.com>
References: <20250822085434.970798-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: efe9d347-b4a2-475a-62ec-08dde159911a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dm9UO60ZJ4BFckmD0acH1RIaygEpcpkx+Em7gjvFLVeR3i9FgWM91mx9Q4O6?=
 =?us-ascii?Q?V/caUQfKuxqqhz5H4O+I9aMFmEsb57oiFpn7ZE/V9zZshIhqaVM4gFURd7Xe?=
 =?us-ascii?Q?r4W4hetKPFd82VTdtG6dtguQZlkNHlZcjvVVtDJm87j/aLsbM1lwVwrCFfOO?=
 =?us-ascii?Q?OD7A4BSafLZQJZzE01gph3YZwP4rFsEqtBeK1eE5K5r0TCN1CZlQ0xNvSS6T?=
 =?us-ascii?Q?s+pYloC5esYX3zCVLRukBdnrZZnSY6ktMc3xoaKUu2h0IXoFWXXWsXMFRVlm?=
 =?us-ascii?Q?lbsPVZxE+lEjO6ybIdOQSFjIxQB6FwiY+lsXGdGlIco5yvwpVfXrMBE2LA7h?=
 =?us-ascii?Q?tKs05uNMs6zfgPPQKSsaXVdKwFQHz4X8npZeSCTKiKWYqd83sN/XuKTsYA4h?=
 =?us-ascii?Q?iMbm9uiH3U+0e/UsPKG93M6I0yjUjUQWalwY4h4nPTcioThY74YF+bUb3NzE?=
 =?us-ascii?Q?szivhhRPGGYVA8/080PB1Io7Jnd7zyJ6ixpNOghqBNobxaVcOgz4xoFYpxIq?=
 =?us-ascii?Q?IJjrkxBbYvET30z2r0mxBJN8iw8pQTEkUa1EJAEiqQC0/hlZYgL5+JWq8B2w?=
 =?us-ascii?Q?CSdRYohcEEUw+7tMeFi4ApjFTZOaoP2yB+KGEZxI1kSAYbFFwZpBEXNSnGAU?=
 =?us-ascii?Q?vVPUFtH2gQ8DNkcyj4gqQMLj/RlN+7FMN/MmZhmd98EytOITjSLQ0JBVzy7u?=
 =?us-ascii?Q?VnO7ZnJmRuh+F/DHptmnOJrirTe901P0tSkq4lfkzZjpR2PID8uwdLgpWy11?=
 =?us-ascii?Q?A9DJ3QFaxvrN8wDH3ynAJWDgIbfZC57Ao29FC7qS0VB0yBwyHxvdGngaP301?=
 =?us-ascii?Q?1NPphQSB7CjOfrER8ZzpB/HIgnk/i6LS1CWo2heWgZEfA+F+S2XNYOOF+NJr?=
 =?us-ascii?Q?M/TuLh9An+jgqkYRs2JObvkaXdZH8qH2QuxY8CWzD00+yEdGyKA0NCERocZX?=
 =?us-ascii?Q?Wdc46d4/yTbzIR2ebz+AUAh/6+mcrToSR0riRArdz2GpnHCxlxEJX1b6bbXH?=
 =?us-ascii?Q?F8LnLZfRYAXBS3sv+OIyTnTmuTPNGSQQN9eQDqkoplesDMLR0dphN0efQ8Cs?=
 =?us-ascii?Q?AD44lM5sOp1o2WT/RIFFid56IXzAnEB6nJftHsFnzdws/Y7K6mSMj5AIQEA0?=
 =?us-ascii?Q?/5mvl6NQ08XdiUWq/kbfJMGlis7C5LuFkjIBxo9tzDjenupe+2bQbmJtdMSu?=
 =?us-ascii?Q?drn1JBbaBmALaA+Ek6EzcowBKsyu8pCCt3v2OynGynJi2g7JvWe54ib4dDqQ?=
 =?us-ascii?Q?dqHoQGzLIe63ZTt7tNxWa8aRu97EkS+YsTWdmWmE7n66WzOWc+dzrNtkN4D9?=
 =?us-ascii?Q?Pl2Ng4ZOZyw0o5d3H7Hbv12/1KLnekGm8lcfiQRUMn2Nb3EeDjrZ147HCoiT?=
 =?us-ascii?Q?fSh5ergg9jhmir90JWegb67avG3BHFD2BdP12bd9FBIPCHvSRo1dCywAFV1M?=
 =?us-ascii?Q?I6Bn5QFPSljuNZkBxnJnG+b/BqGFF9rXV5EhZP3E1qbYo8IzSam42XzPnY85?=
 =?us-ascii?Q?kdDbaEQZI39GDqOq/Pz98VzkKEbKEd7RpaY6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:54:55.7902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efe9d347-b4a2-475a-62ec-08dde159911a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799
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

This commit implements the actual MES (Micro Engine Scheduler) suspend
and resume gang operations for version 12 hardware. Previously these
functions were just stubs returning success.

v2: Always use AMDGPU_MES_SCHED_PIPE

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..24c61239b25d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -567,13 +567,41 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 static int mes_v12_0_suspend_gang(struct amdgpu_mes *mes,
 				  struct mes_suspend_gang_input *input)
 {
-	return 0;
+	union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+	memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+	mes_suspend_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_suspend_gang_pkt.header.opcode = MES_SCH_API_SUSPEND;
+	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
+	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
+			offsetof(union MESAPI__SUSPEND, api_status));
 }
 
 static int mes_v12_0_resume_gang(struct amdgpu_mes *mes,
 				 struct mes_resume_gang_input *input)
 {
-	return 0;
+	union MESAPI__RESUME mes_resume_gang_pkt;
+
+	memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+	mes_resume_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_resume_gang_pkt.header.opcode = MES_SCH_API_RESUME;
+	mes_resume_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
+	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+			offsetof(union MESAPI__RESUME, api_status));
 }
 
 static int mes_v12_0_query_sched_status(struct amdgpu_mes *mes, int pipe)
-- 
2.49.0

