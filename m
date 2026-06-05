Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A38CD6E5D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 10:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D2E11A70B;
	Fri,  5 Jun 2026 10:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RSfz+/7A";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD48811A70B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 10:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2bm9F5zAocOh2xxbo8X6osJJn0oyyIfK5JlcGWqRqN672NamasRU37z9FbMdk2PMx/VQZZcyvo8H98kDdrCBM44bHSZWn+f8FVZzOBmcmi8G8RVWUi2Jx/h5cBX78uYAmzBViONuyEVxPnZ4WujerI2paCz4s7PbAtmTmLKCl+U//swKIt7AwIU2NgpOnIAr8LVTI9j67MaIiJRTBSfpg2JdxJi94skfyQINOFqdyDtpYmc/wqnhcN9GuJEGeTrrL7U9mdzWB1izAIWOcrO022HalKgofvMtyOnRwKz/XzBvqyH/8D7RBykuX9yBeS3p3UCAQ0ynntqWshCJQgVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dHCXzTKffoK+JiEJunvTnq+TKETcgg5wZyoHS9/sTs=;
 b=uCtayef9GsuZ/J2/5TLNkjeOeZuSwIY9cPMgdErJJGofNrklsLluQyzVWh0GFw/sTwZttEgxmpzCjt5KyI2zJjdl0WEzuI6pskm9ZfwK1ow8NgRlZFwped+Tu9Icc2J5bBww5cXEvyFDX/oKjCBA5Vr2WIB6z3HgDyOGHzHk2YkZimF57H3gY66iA016eGvdRNxBpLBSIh34/sdeLCOBw7U/Yrh6FlxhR30nV3rhDIj6/BtWN4nXOBTz5NKpZq7qK2U1pupnxg7Ck+T+R3xZ6OSquwC7cWgEaMPQjVSHue9DJMYNYVeRG0zXiDODm3sEzTMmJzAVZKzQmYuQgys3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dHCXzTKffoK+JiEJunvTnq+TKETcgg5wZyoHS9/sTs=;
 b=RSfz+/7ATWwq9/fO16f5YcJLHgqIrbwmsH5F3oXV/lBuycIjmRS5QSgcIxfAfzw5fxf4YM2k6z/wPonztySGVc6aZ+ZiPwQLlE1pEfj7u3c5POxBw6iUtA8aQ/3md7t80TmTAGNr0jdQhit6t5ixq9jSfMA60pDceZug5/dxHEw=
Received: from SJ0PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:33f::6)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 10:31:58 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::85) by SJ0PR05CA0031.outlook.office365.com
 (2603:10b6:a03:33f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Fri, 5
 Jun 2026 10:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:31:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:31:58 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 05:31:52 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/gfx11: handle error interrupts for userqs
Date: Fri, 5 Jun 2026 18:30:48 +0800
Message-ID: <20260605103144.2537331-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
References: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6f6ca9-aeba-40bb-440d-08dec2edac54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: hZFou0kc6Atyo32lPgpk2PEOd1ZPZJgH8HJhv4wKDiUYrXvLB46yVGThHDzA4GZ5SXdVq+I1fzErjfxXAozsCtslzHexvNXjpY9Jgpj1B4l/5RjncNDOPbIsRmxrAiZGqNHrrkyyz+CEb2BfNoLLYOhZsSqsOQg52E5w2AUDcLi8TIQLtzXyfI7rcml/EPqTr/LVl28RAtW1O6MHfzSxHZdGonWNDX0zqOwJIIjqxLZXNhyVpLiyFRpC8IkUGPFlIAjmfDVd9D//Sb8fS0hpUz4B2uby/nOBSzeV1ilZHjOpPlQmDHYcZo7CmGGdXmCdWFAIXvWoBoaewSMbBOwr5GB4bOl7fk3xAJPScKDVVSG0Yzvp68kS9SPkVXixfC58OqiKB+fh06SEfbomBIZHAFEHu27I/L+AfP3Zjd4Rq6b62v4aSY51dNY8rPlqHBGor/KtXgO8RK+lq+2JIYmv8MYjuaPl39C0LYsbGTO20aFsIyMhHlXx6rtiFLcCOqTavIUfnCzRFdYz5UzdBufQcn8qP8w4SQoJLx7YHIpv49KAqK3bzB0JwlVotCMh5TGAR5RLtFeKEUQv8K9Wa5b51qCYQCO8htYmi0fs5v/9/BZz9i855n9vFWinB0rNHkMYleyERn0ivUbxuNgz7qNLbwUJrevAgaVC+xffhYpNqTAelLzHbQuU6d+tn5iMqWpoklh7bAtiKN6QJpHV6FoQTw4hz+0tINtmY8E7Krc0iTk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /t1nhGBpqFpKNYY7lp3j26JzqIVrNlbQPJW0NExdT09wPZ8JMoR/rQeh7sug15N+pFkUihDS+sWwB2LrZGDD/3ChmZMGJ1lK50qAtPR3UqszWQ/7Wole37R3IiXun6VZshZmN46UgSzD3WSOnmFTb2j7/+EPEKCE+JDQTWzOKuDF2tXSbyzv5/BaRJ/f+2j7qCUrUX5d/dIIk6I37mWEfBqcb3jfB254Eg0rWQUZzkPhxPdkQ1y/Wdv4EH3hA2ZZwUXQYMXn/iT7Maj93/FbgGj2o3hFRRPCTeLi7Kfcdsaf/A2Ow6hQjsldZY54cjf5X+/LCX94HOJq949X+vQGKAcGKMRkLA9bcp2fPFnIfQnAKbzLiNe8/5o2JfQEsnDgifNi+ghEAHUd1oOCyRuADY0f1dXmMcWNuEA2Wo//shmxoHcn4b5kJ5tjl24PNM9U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:31:58.6667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6f6ca9-aeba-40bb-440d-08dec2edac54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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

From: Alex Deucher <alexander.deucher@amd.com>

Call the new userq reset helper.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0bd9d8a21f5e..ea323d241324 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6681,15 +6681,17 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
+	u32 doorbell_offset = entry->src_data[0];
 
-	me_id = (entry->ring_id & 0x0c) >> 2;
-	pipe_id = (entry->ring_id & 0x03) >> 0;
-	queue_id = (entry->ring_id & 0x70) >> 4;
+	if (adev->enable_mes && doorbell_offset) {
+		amdgpu_userq_process_reset_irq(adev, doorbell_offset);
+	} else if (!adev->gfx.disable_kq) {
+		u8 me_id = (entry->ring_id & 0x0c) >> 2;
+		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
+		u8 queue_id = (entry->ring_id & 0x70) >> 4;
+		struct amdgpu_ring *ring;
+		int i;
 
-	if (!adev->gfx.disable_kq) {
 		switch (me_id) {
 		case 0:
 			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-- 
2.49.0

