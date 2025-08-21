Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA71CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 01:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC1B10E2BC;
	Thu, 21 Aug 2025 01:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mAB/UyII";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928F010E2BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 01:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPsezD6g2G0ZREghzfVBkItNh+gZbQlQV6k8ckWXo/nkud4upxADLssIp1pTLX/9BqqbDQtoH/gezHOiZcrB2peHLVRqXszXk928RTvwt6WJKuBgQ06FeIcXoWYqbKR9uKIHs9F/BmWZfcJ1eTgt+kahJC+EsM4v5RGsOXcrurxT2yz5Fj/iNymSQUrpqMhaqIxK+mXVdK6HGDCbea0gTE5wLc86jOOjmPYqumCtv6GEGzsXBzMvIkRiVxiAx26LPzMO96mGMvU+b2RAlTznRLCYoMQ7E3MkUZhFq+WV+SM0+1Pv3b92dOG1mjET1E9jvw6RRz3aoHROswwYIyl0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=I1h8HqbP/3GHzlQW4yGBE2qF7pSSwLgYtGxnUOmJHogr+oEODRQ9LiB/bAA0xib4ZeXsT+wBi92t6Bu4zSTd6oX+vrlxBFs0IG3oQQfgx1SaXwjhVlvjwy4S1OG/U0E2Zfy6m9aJEcVirK4zkzscQk1KSO2vz8OnC1iDjijgZoMI6tRfGxgin4UA8ZRgE3otH1CeBPdKUN5S8AYDWbEAp5Gl1scVYAm16Vb5V196oqDZW8Xg0JgMg+w7bZ9oR4ZO30fZyKqLcjsy3RlB8dx8r7zGZ6G5A6NK6qciibjqRmAn1KUxxiWYPLdLg2eYg2DNIbxBS3shMyJlekKCJlaHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=mAB/UyIIXC9vqZtiHZboErSsSJ46ll8GfLrCijOud0ZxTko9lOUaT5gNHByQOZc3u5YUfEz1sHf5dqzkhPLhARa4Jg6sr4likk28K5fgwQA/GTWatplZjh0Q6jKqAiDyDuSKfsgtKSUgYu0mNT59Ph7d+hrFj+t5jaX3oa5QMro=
Received: from BL0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:91::35)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 01:41:42 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::b0) by BL0PR05CA0025.outlook.office365.com
 (2603:10b6:208:91::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 01:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 01:41:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 20:41:40 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 20:41:34 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v9 03/11] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
Date: Thu, 21 Aug 2025 09:36:05 +0800
Message-ID: <20250821014115.566598-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250821014115.566598-1-Jesse.Zhang@amd.com>
References: <20250821014115.566598-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 605123fc-ccd3-4dca-17c6-08dde053e154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G++x6jcMsnvd8TwVswvgDslWh1MPhcZjwBy2i/lvosAYaHffYJw6feDdosxb?=
 =?us-ascii?Q?5CMsxaAIl+Fj8VfA9jReMuHnDnNJY32IVfch5k9FxX/BN+wMbgU09474Pjh6?=
 =?us-ascii?Q?p0OTDvp0Nj9IAatfsj7LhYh43x3A5FfOVVjZSsjMaehIVnASttk57aYC3i8A?=
 =?us-ascii?Q?BV8Ja0Ii5ztyUFejaGIVmpH4gSNCzGiZX6xj/ImjKd2gLeCb12cGklbqTzqT?=
 =?us-ascii?Q?FrdqY52+HYd1I+5XpBMXj96HFL8G4eDTHRi+iZMHCesPj9HS7jFdLuMPob0F?=
 =?us-ascii?Q?KmD+HLuYQEXH2cbkcrifg2q2PfxxD4V1ci5z/+F4lDTV34N3D+ZcKUQ9WTVq?=
 =?us-ascii?Q?V0qXpMfTH2KkhudbT6VfdAhTE5deZD+Z80unsSoUU8Kho7RYWIphkxdm6I5g?=
 =?us-ascii?Q?z91J7/Cn8oB7GBO2PMLDmw8AV+AE7TLI/4Z/Y/i4oDKZg2sOGtj6BTmxiuNc?=
 =?us-ascii?Q?9WvT0QH3UEXSKh+C7oodSFPeQfj0eWCVPojfutYUyaaqaPI5v93hXn0Qk2DR?=
 =?us-ascii?Q?zEefvfUd7SIqPYzYI6DdrHg7OmjCE/NvrSXR0twhXSv2gqKTmRS2/ERuCJJD?=
 =?us-ascii?Q?vn0+oABycdNodbA8hwNh7plTmGmdPIcJHLMBhFAqb6TQLscZdCCFNlYzA7Dn?=
 =?us-ascii?Q?N2T6SqwYKmn8P8uUEBJ+9BoPsRzxT5ojchEmL3aliyCjKf0uzKrBaH6v6KSb?=
 =?us-ascii?Q?vKPiJus76hq9Vgwx/2gPZWO8yR5HDm79R0rBhrt+yU8tgh85bhhBtZlqOM7L?=
 =?us-ascii?Q?AIxlsIrrqn2ZVs8Ty1c5nSJF0qfLXnNpWWdOJ0UMiScVuYfgGyyonw74m4w+?=
 =?us-ascii?Q?KVrCU9WPBEcfU+QqAdOfsto2ujEpgaU6VfdsWRE9nEjVRRGufEBLlNaHYwEY?=
 =?us-ascii?Q?jbUDl/8OcsdTl/2JrbWLIbKzdjZjeCAnMT5HTPDENa+Ap2RJgXKovFiXVRMd?=
 =?us-ascii?Q?HchgDCytfbYC9W3jn4baqxTtuFYyOOpVPDw8sPS1aO8fQRBMAvzjFXD1HEAN?=
 =?us-ascii?Q?FjLCQ/7AvRQnTedsfZuQdk9GP29+E17ezEoQV2JpvWZXO5S/eFggSBv3TUPy?=
 =?us-ascii?Q?JbK6OnzXAO1XbMWaWjMDMQkNK+D+ECOGjZO04IkhItEq+A/C155pGFEqJCLS?=
 =?us-ascii?Q?lwSGSCCasPJ2ygVBxmGMMD7Gk4ZUaGG30m6BVqQVRkGtBe/nVp34jBfAnrY8?=
 =?us-ascii?Q?ZZpZmf+8xBBYVRah+BNrUTPUKdx0wD8Q3La2CT+jDRxyhURiFeNmqxxBwwPA?=
 =?us-ascii?Q?HLDnCkZ3EzC9s3OFk9e2U1erY/ymjD3Wj9kCqAChjlsV1T7NgoBFU56X1dAn?=
 =?us-ascii?Q?8Qmbu5+Qjx1m2EdGKAmYNru8xYQTqi6k9IM9ywdsrQ4RmIXHcMk3OEq9X+4h?=
 =?us-ascii?Q?oGR9EagBEiHNH6jMiIS9yjH/U3B9pWQIEy9I4tevT42DFaSn7reAhOIToUOE?=
 =?us-ascii?Q?I3bkCd2poBMztd4uL0zubAlcZuX5YMBDZ249VUwKN+c/YCQ3A9AdyRbOMCOH?=
 =?us-ascii?Q?rLRKE51c0pPhwE9+yd33fRKQxwC7s2LxV/eC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:41:42.3339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 605123fc-ccd3-4dca-17c6-08dde053e154
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
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

