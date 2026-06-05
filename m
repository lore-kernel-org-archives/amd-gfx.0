Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D41CD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 10:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD47E11A70D;
	Fri,  5 Jun 2026 10:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TPFX04Vp";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 165C911A70D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 10:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DebhaLaR/C1rPrcabKEXaIO67fYupP4AdD0Miwv57QK+Zo6jmHXW0sB3PzPWRyZTZHnUAL6HgE5APzcN61+78cM2/NwNOyO2kz/81THfe6r2+mTqElg0A6HzqLPCgutbfyJwbq6t4aMOsW3hh0ea3uo4AGH7jNu0EvsEUJ88DeXOppcZhvakJiYaKBP/uU0C8MLBS+a0XJaJJ3YnGkpoxVHtTKf5xdNSz/zgGtitq+ho8t075R6jQLtjUBqv1FThXEFZ+yngLExXbFC8trpOQYGkwwaFIgRNtdTe1qPpayZDpshr+PjlAhaZybp6B+l/26w5agM6ZwT1YZQCM7sJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVxQ1bkFBKKvmnazL2XfZA+Ur7BAaN9AkfxZYEjf6PE=;
 b=PNt6SMtuY5k2rMFAuEaRUNqRnXIBmbKkMcQ+YZkk9jecPf2iX1J0EaDUMXELrd9xCOtVipDOi8LQfd1ydTznjMZm7AkIpBpZKfuWPDYbXjo0VmD1ymVsN8K/MVtrxQ+WCNH42TToyCnNdHgTt35ElP06cfH7FT+Ah3KT+RB7iMjYnGeMHMfM8dpOhsakPLUh/u7gCupzLF/jIBgtzt/hGuZoWr4FjDq/EP7R4r+6BWeWvjH1/eGp6Vllzgm7Gh0ahBzgskLgTJOeX0EdIss0OscRGQGcHbG4fUyvwd8LEw6ObL16aeWRwS1ZayNNpIN7Sm8WVqsAf1glw0zIm3Lx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVxQ1bkFBKKvmnazL2XfZA+Ur7BAaN9AkfxZYEjf6PE=;
 b=TPFX04Vp56FzjajfGc3zE8A0057ivT+6OE2ExEmd+aOOWcR+onzBYdHlxIYynjlwIGieMUiybXXddQJlBgnPHnxx/5sO6rMwS9tC2qRSp1TpVrIeOJPzTOD11cK25H2Aa+9u4VsvxHGEw4SWHkI7i9NJiEiTJp3imXg8EzS4F5g=
Received: from SJ0PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:33f::32)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 10:32:06 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::6b) by SJ0PR05CA0057.outlook.office365.com
 (2603:10b6:a03:33f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 5
 Jun 2026 10:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:32:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:32:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 03:32:04 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 05:31:58 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/gfx12: handle error interrupts for userqs
Date: Fri, 5 Jun 2026 18:30:49 +0800
Message-ID: <20260605103144.2537331-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
References: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 28af6e7c-fe54-4ac1-7e24-08dec2edb06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Je+e2lIVDj4DRQk5m9hJPwCjqaFzQ43JZ+1bO33vgKNnCgUUktfUGT9Ee20JUfxSRz6GCekH9NyGMfeS7cntgwY8DKBksIKP8NMUBGFTSk/PfSexUqHWUO88thN1FvwCXOnL0KYeSFIePIMge8oUrFlQuxHYAjDr9ofXqfAY1nTDJsJHdsGUf3b96dXTTF0Y6ViJ17Jy9etuc3K1BxJZq6Tj+qA9nfs1j8UPfeE8ZkrUZAa8Ww0QrRYGKLnM0iuLFUyU0SlfyIXq9GhJF7HROYRccoHxIwbYrvH8j8iwgJhgUboVs4g6SebyzVun5uZKiYo2jbD0YvvF/Ji6GamOtIDwfd53gYEVKGMRs7TM8Uq6P9OjOAIvQmNfcBAxX5GjsVf8gYCeU0Kym/Js9WxpdEDpnXAKGP6RJG38dwXLHiGjLse+tew3DYwlFeIP3epsCQuylhKn05T+BqWBpk2wXsV/CjovN6eqpNsciJL0mIF/YvV8/uuOIx1krJdpqNA0JYDl/Z1I0NKZj/WdU2s51J2HIHZY5OG61Cx2olRgnCXJ7WOnb3bC5KmpQRimfDmflWQLnA9RjaD+SZXEP4XMz1fxzLnRM3oumgHvdWGQJF2XJS3k2j4bsD/iSy6Ho/3WRcVcVU7qt97ENZss5hfWihMpN2bCtTQk6ZByIYXKhndA86HfoDTx7isxHuKKEqxtGJ2RiEJam/iOy5b4DIORQvX2oxOfID98ruMIuSwx/bI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5KxiO6t3QBUUaXmSjFwbd6WOJf0g1zXJM/mJ7rau3r1YoDotZLsgRyXsbAoADsvTQOZxspXPacNTquDzdU8FnnY0eFHrXxlS8GWT9uerp5UQ6XaHtd9usEhLRZqAtPopwhTdzywMjRmjG1bwyrt9mor5RAbTAklkIpOX7PGEBHep7XZ2MGhOIgpkfgavlNAK4U/Sck1LIzA+WMnsuzmeT/7nUkowK3oZ2Ob7MX/+LcRvLxekLHG2oKdCb9NiXFJh65Vp0JQpbHV/OK9UHJ7skAOL+aSLfDq7f+2Dvhg74x8GCs2cv+cuycHRjYenGgU52e8VGRWMHEWiuJKiNB/7DpJreWRCfxDExlu1ddcFlNsAXhYZ7NOP5QDSunb5bFTV+rM5q5uMjY8ssnY78BvRqEcFhRjqVPATriUPZnQ2uTAASZYQ2aZzhMpP4hEOHts9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:32:05.5223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28af6e7c-fe54-4ac1-7e24-08dec2edb06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 380ba062134e..b3f1bbf3fc13 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5009,15 +5009,19 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
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
+		u8 me_id, pipe_id, queue_id;
+		struct amdgpu_ring *ring;
+		int i;
+
+		me_id = (entry->ring_id & 0x0c) >> 2;
+		pipe_id = (entry->ring_id & 0x03) >> 0;
+		queue_id = (entry->ring_id & 0x70) >> 4;
 
-	if (!adev->gfx.disable_kq) {
 		switch (me_id) {
 		case 0:
 			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-- 
2.49.0

