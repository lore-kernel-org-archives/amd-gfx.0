Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044B3FCB61A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2818A10ED61;
	Fri,  6 Mar 2026 15:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gK3JGsCN";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48BE210ED63
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luAaPEQNc41Mr4Mvdnspz42yL87eeXtWphTjnDR/0GZbvnE08LRORWxRPCwo9zoLQV0DX1MvCp3HtloDVE8HfYSZ+z6wsBBwNEmiMwMzAF+YQze4Zkm/Z+zfvpD00k6XHKDZDW0co+LSrR2k7+MK6bS8bt286iS4dBlW8Vy2l2jHFNY81la+gM07kx7SCFrtJrgJZHHsdTOUNsW9Y9svHEP3QS52fuujhd/HuBcR5foZ8jddtk2MVQb++ei/gc7l5NcseH0PTIK/Qa0fsa1Yf+PEElfnWJ6VY9LB6i1JV6qmDUJu1GXm8OwIFzFbS0lGIlQECcp+YjlgWb7QJIkKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VvN2UXalIjdqGB6UQxUfsWN92iX42zIxZ1EJ323oNw=;
 b=Pcxo5Rx0eCAfhloYOkLZHq7yoVIPEYxdyzqcDiq5ShsMKJ37YrMF0wFN9nqaGxEdvIBoJV7upL5j6R5+iMktX4ct83+SPp4JzitFxpcVz0iZdVsKtd4BL29qNd3OAV2M5KbM2CLE8DOGeWJqbCnn2nA+n11UqpyGT32A8CouFdjOCMunwlCRLiPCGg5dGn5mqMYYLVnS39eikAyC/P2+v1ZWaN200QEmV1Cvd+2VECYSmEdYEVKbbyaLQMTpBFJZ+hEkdFW4P1VAfNEd03uOwXyWK0i79Lc2CtGsiHUadrGuhJKKYUkKZY6oY63F68RLzwJo6Sjjxflh8TyyUpjMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VvN2UXalIjdqGB6UQxUfsWN92iX42zIxZ1EJ323oNw=;
 b=gK3JGsCNDcZ5ZQlGvCRJgPwVyNWubTqrKx4uOyoRjSrbppFojT+PVXvzpOC5BqWcyt/q6DHdhOr8PaqnpkuFq9Jez9m9oRqM/JKNQIO9gIhW2yolmSF7oz+mCNZGEZbx6cWG4dEiHZJc0mZM4pNqBgDGq9FkSORma44u/gA2dMg=
Received: from CH3P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::15)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:40:24 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::16) by CH3P220CA0022.outlook.office365.com
 (2603:10b6:610:1e8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend
 Transport; Fri, 6 Mar 2026 15:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:23 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Mar
 2026 09:40:23 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: correct SDMA instance number for soc v1_0
Date: Fri, 6 Mar 2026 10:40:08 -0500
Message-ID: <20260306154012.22525-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b78fa6-eb53-4dbc-44bc-08de7b96aedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: wNLzOg1QKYNc0rw75uGPUCbIGVQVnJOOpfkxTYYzEHFC8N/nAM7K9mEpm4DdHGsEDrXyaCsqfDD+ciQkofaA+uwaiEA4rol0KJGEIDR4ZxjdKXC4JslJEEJV2y6b9HZRmZwyN0cgOiQy3arUmEGlJyL5x7ozKeLGU7kHuGN6yekhjU4g9HRjYL3szKVex9s2ZUzDysQTnddleq7bRy67cRi2hwtUUUIWgGRpJzLF58LebtISckOKT3PLehpbEhmmifILBZrkwV1SoM2JrUoPSSh2g+31ZMHZ3Dz3EfXouhcv3OkqA0EIBZA/FknUmCdI3rypjw6I4EjkImY5jeNxDaAkEpg+x7EQfOvjB0kOjC3AeXhkdeMpHdEJd7mlPe/iJAwUkjQmeXkfDvC77+/geo6EW9MKMv1Zzb2FPo26kUpe3H8oLipRzXQ38+Ojv6DEQhbI3Rg+oF9tcd4T1Rn8OEUNoXwcOD8A29N5iallMbtjTeMG7yQ6ZBDrtm0DIlFUZOdhELb7QNSxVs5nAQJL1ywkaz0LpTJW69Osl0FNk98SloEs9Rs9iztGUb+XnfIsB5AM1SkpvDE00PRJ7BMZP+BYpyALwfPBYbBJ2CXwu0LVBjSE3xiR3wC0QO1OGEmVkh0v5sOBgQ2rPeEPQN0JZGX2x9hfN7xWYG2MvOM86syAxuOynC4bU8IG45+Dmvzlh0VKB38LjwsS4adVrAIIYEjKGtOplEtzgIlNXQ+Sdm7OnjTi3OFA4whbKzZZ6IQ1JexSlAMq/k0P0W7dalxamA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gT50yuX58+0u4dSBYSW/2kN1swn9NE9Y5JYkj1Ij9Hp+9+YRDmNcgPT/vtNtJHrIKidJA1QH4EbdDgq5cxEz9s1HaCIwfo4L5n//LpFnT1oBBy9xCEW87hYnJEyhf5LBuOhMqp8q3NzBta+ytNB93mp0rfpGICbfMTs0KK/pABJaErFM2Q1j7kzJMjCDUPJMmT+SqHcv4SnjNBEb18wuZIzcU84JxZSSaVa0IwZh4MRwKUcTRWfXk+raHKX6P9+emWj/NDD6Lv+G5CKul1TD/1BYAs8ia2H4NRk8BOLhVwn34WKZ1vw6Y8FdnJ6LajpI+iPC49beT0O1ev/Ubb/blJEnyAk/207hkvyVKIIVoIkBgipsuifj+pYyaO+3OpG6ORuFpovbmZ2r1dv5ofEdcLsnVBbLREvesuMggA+Eu0/PHR0I1jx2I4+k121CZami
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:24.1872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b78fa6-eb53-4dbc-44bc-08de7b96aedd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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

From: Likun Gao <Likun.Gao@amd.com>

Calculate sdma instance number according to xcc_mask and
num_inst_per_xcc, and correct adev->sdma.sdma_mask according
to totally sdma instance number.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index a0e10dbf07337..90a69ef41c4b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -823,7 +823,7 @@ int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 {
 	int ret, i;
 	int xcc_inst_per_aid = 4;
-	uint16_t xcc_mask;
+	uint16_t xcc_mask, sdma_mask = 0;
 
 	xcc_mask = adev->gfx.xcc_mask;
 	adev->aid_mask = 0;
@@ -833,10 +833,12 @@ int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 	}
 
 	adev->sdma.num_inst_per_xcc = 2;
-	adev->sdma.num_instances =
-		NUM_XCC(adev->gfx.xcc_mask) * adev->sdma.num_inst_per_xcc;
-	adev->sdma.sdma_mask =
-		GENMASK(adev->sdma.num_instances - 1, 0);
+	for_each_inst(i, adev->gfx.xcc_mask)
+		sdma_mask |=
+			GENMASK(adev->sdma.num_inst_per_xcc - 1, 0) <<
+			(i * adev->sdma.num_inst_per_xcc);
+	adev->sdma.sdma_mask = sdma_mask;
+	adev->sdma.num_instances = NUM_XCC(adev->sdma.sdma_mask);
 
 	ret = soc_v1_0_xcp_mgr_init(adev);
 	if (ret)
-- 
2.53.0

