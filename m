Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AADD58CCC
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 03:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C678D10E09D;
	Mon, 23 Mar 2026 03:30:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MEzb3eKA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC6710E09D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 03:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nf+sqvlGVHuhm6sNe0fOIY7CeYQs7PELJryZgX5OBO4Ew1hHspsd03EuoCDMxVANE4+rdOQvwFxBW2xphpbYkcIWDTYWkh7MG4wshrU+Gy//H0P1WWGyb4ovUhAnALTxQx345hqQPb6ZG0PBpFjsnrCU0ZAc9RCuJrf+TX++dE+bgRSnuXsiFsQH7OW7x9mc2rQF0ywFYFRxgSa5iZV5JkyBoNii1K2YQjot2k5DNqZD2I+HDhqHkAPce5WLzGkWJFTZfzr3okXd699u4+wKHfkQpcRvgcdXqRqtJ65GMpMI8iT4p1OZoV0pis7rdSo6De7lB2HCXDO8t4swFoAotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zD4/vLOuMR30ZPSv19tu2an3qALHiL4PC2excR5+o8=;
 b=ofRn6AZ6iuxoXQe5bfiygjw7090sODU1PXEdjK3Ig+tFcwmg8tBB/TECZbIJmI2lrVN62cL0v075wLA5SoRMzccIY1pMiNJdAIRwqtdd5VvQNsMuombn/2SWjveXP9yw3UdEIzKW+Af/AA0yzNEJQZKrJSRu/NjYjp9LOWUcO75zNjcjWKfPwMTHraHbEzm/wn+JGOk0VRrBCykaLvJUuRNg4ADh7iel8uwW9xele26seyw4iZpo31CebSv4Eo0gYjnO5PWpJdTeJwtoIKa6IpTuId35OLC+6+8nnP8BdhafRgDUQOD1IjGHwTxpRimdVT/p/gGIHB/Exx4Zq3O6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zD4/vLOuMR30ZPSv19tu2an3qALHiL4PC2excR5+o8=;
 b=MEzb3eKA7fALqG+ptATQJyPbjSJ32mJCLfm/ZpuGtc2f7leKQJFDX2ykzBBtnxtHhsvkCRXxlWYY7sMj120/AnU2uCjo/xC3VC/DRN4RGe5zReju7pJQqO+ChUfJxTIDpAnJ4cWEZzm0N6EX3u/hedk5lpEGlkRVHZqbL9VoDRU=
Received: from MW4PR03CA0300.namprd03.prod.outlook.com (2603:10b6:303:b5::35)
 by SA1PR12MB999083.namprd12.prod.outlook.com (2603:10b6:806:49e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 03:30:36 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::19) by MW4PR03CA0300.outlook.office365.com
 (2603:10b6:303:b5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 03:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 03:30:35 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 22 Mar
 2026 22:30:33 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: validate SIGNAL/WAIT ioctl input argument
Date: Mon, 23 Mar 2026 11:30:23 +0800
Message-ID: <20260323033023.3338683-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|SA1PR12MB999083:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bd8bc1-d080-40a8-353c-08de888c8bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ssLTtCsG0+FoYX/IspdTci6a+3cRhNrp6TZMZNi7RIx2sGcSuVLMcz0jUMLqsTU8LJhhNIxlcYfzGBVbcPsnqqxhvTnhzdj6Q2UctToQSt/VSiVOA1ELvP6JI3QHxoEsnlwnom1lwWGeFmuQCAFvBKk6fJ7Hn0Gu/BVsUSNmsnd+bN2bzgacUV8eOR4Q1kx4N8IU6f75hwgLMKToBv3AJ1fekHX/A+b9P9XHLa123cVj2zUvqe+nGXatERykE/QrmNv0BpZtbxembI/7r87+/gOLIW6WxkaGQOqhZX8+jyuT/Mv9CyzyWy6nEfnOAqm1gSu3RGPdmJhbXcWWANRxQ+BVHbPcL6j+K/qzmBUUTP+05gntgMHxSyqnHyUeuQ7sOJZiLv7RfR3Cj8CJ90qhbndv3OjD7rmy1DsXIPKvJVlrXjN+a5zyHdAbUs20t4HE/Ji7GqLzKo30i+Kgsrm7lgzT5RHcXJJh4ruad478X1KCa4lyJqVGpEIs6ZRr8KtUz5ZqSHAxKbol128cdZqUWwp/4N3yA79b1eWYMWZgHyFFSjBWPxlkWe8MDRqe6yMJxtRl9tQ7/ODDv0DKm2/P+qr3kBYn/F1bzEq+U6wqgXBKX7iJqZBvXFeRyXiMloyXNNbtJDDAdRWTkFoFclmXTv85ETw29MDe79WrzVlqoriyxWPWVT6PYsR/vf5oJbHEsy/6WNkwgIKzONHM8pt8btXZw1v8nwtIRGBHhMkx3JhhrKZLiDJ42G1tEVh3BQlDFbTzaU0o0ARz3+kwVYBasQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: chKJHhmYozeGVmOW3oan+F6Ucn68s4RFKG94WD4DjA3MKQcgQtwMVZwfRRHulcJjCeml5LCxJ85yVH73RVKZ3ZvEwBSLbO4aY+eOiDGo5TLJGo3nXVJrt0mgs601p4BxPVoD1RYyAZgVUD7YkY2puh36KaQEmJwB9PteBiZAcpKaKjjmlV1hav+siUW3AX/iysO0v5Ns6+KjuJLw1A4BZ/Ku7qdaOo8eH8tEykKP1NgpjeWZ/6u4Q8PNu5F0/eZouZkSLUFL3Xk2wKuLA3SHkjzwP0mx1T1thH/GyA59mSRFs9pTAIVz/jF+F70UIF1Dv5clvDRkgxmyTFkSocIJFtd1m2XiGi5b8l5OlfiHcX9CV7Mbci0BqAnDBgpF8hFRqB6Xl2DHzt1rCwciNQRH+Vc9Ai80EZ3QQAdOSphDkOmgpSasGBW5vLfPb/a2B6Xi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:30:35.4556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bd8bc1-d080-40a8-353c-08de888c8bd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999083
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

Filter out the invalid userq emit and wait ioctl input
arguments.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index f93da45cfa7e..7b2700a0c0ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -483,6 +483,17 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	if (args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
 	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
 		return -EINVAL;
+	/* After the mesa allocates the input obj properly, then there
+	 * also requires filtering out the invalid obj number.
+	 */
+	if (args->num_syncobj_handles && !args->syncobj_handles)
+		return -EINVAL;
+
+	if (args->num_bo_read_handles && !args->bo_read_handles)
+		return -EINVAL;
+
+	if (args->num_bo_write_handles && !args->bo_write_handles)
+		return -EINVAL;
 
 	num_syncobj_handles = args->num_syncobj_handles;
 	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
@@ -946,6 +957,22 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
 		return -EINVAL;
 
+	if (wait_info->num_syncobj_handles && !wait_info->syncobj_handles)
+		return -EINVAL;
+
+	if (wait_info->num_syncobj_timeline_handles &&
+	    !(wait_info->syncobj_timeline_handles || wait_info->syncobj_timeline_points))
+		return -EINVAL;
+
+	if (wait_info->num_bo_read_handles && !wait_info->bo_read_handles)
+		return -EINVAL;
+
+	if (wait_info->num_bo_write_handles && !wait_info->bo_write_handles)
+		return -EINVAL;
+
+	if (!wait_info->num_fences && wait_info->out_fences)
+		return -EINVAL;
+
 	num_syncobj = wait_info->num_syncobj_handles;
 	ptr = u64_to_user_ptr(wait_info->syncobj_handles);
 	syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
-- 
2.34.1

