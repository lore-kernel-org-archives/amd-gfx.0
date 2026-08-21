Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FBDC5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC16E10F3FC;
	Fri, 21 Aug 2026 19:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="16BKFALp";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B707E10F3FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuWlTQTc3whmCbU3L4WUqy6+m5dEENWKadpkwlzQYBh7f/k0RgA4kegqtXpfl8kI0BnHI0BYkW7/0ZntWvrMWmiq6YWzuKm8UU8r3qW9lkJh3IoH5MjTpCqUbQqQfZU9jhf/CXnSmJfBxUIKLyFLv1P+oF7m4kwXIRI9zGPhkbRdmdXKrjn5/rhoIow3eUXT+XDtMUWW5aOjNuBm+pcn2pJ2jaXo9HfmcZ6AlHibxkHIPGiYZssUIaTCjUkEAjAOHPdPcNlwhXRONj13US4y8eZBWQJy/SFVIFwmiyuYDUxoYwoVvfbrGTDN9Qw63c71Ck8zHMTfDivUHIS3x6xpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGNijF5wM3H+whnsHeuPLkRFj1dCh7+Zp9T8gf4RncQ=;
 b=DGj4t7INH8ri4Zs9vQm5DTNtv//4YG/hppFt1f9GDqoFMEm3XSFfir7ruZvJ8eLUovbQYcOBBA/PSkhxOqThgT0GC9GATjuUOyPybgBe2jGaOy2S18rB86uoswGhkO5iIqt7AJwxdJZBVj3HbiPAIRZ36xS1zMtO4uJ3CPVNgXGpU+AU93/Ul/OZNhxEs8QTr4S4bEvPHSHl9CMmJw/y/csVVZZNWQumTgJtyKBXXWigpcID8/mi0k3xiABiwyp+BF+XHF7kouDTF0RV4CUnL8c087qLyVRfeGhwIOBWA5YEEBpCbvjaehY7jCr/OHugs1fitf76jBTDxjt6ze/ifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGNijF5wM3H+whnsHeuPLkRFj1dCh7+Zp9T8gf4RncQ=;
 b=16BKFALpZsV2V+F48vmezAXIUCq6w5QMTKXj3bUiVLkL6vV87OoWoi9rI1Ll/EXG7to8a2jgBm5Ud/y28+LZOJB5U7VzVeB6/GaplPcbi13qZqid9tXPaNWzVPXBvgZauH+a4ORM8Uh0+Uu6hGErSq3fmMGVcELaeCxnsaz9B0U=
Received: from SJ0PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:33f::12)
 by SJ0PR12MB8613.namprd12.prod.outlook.com (2603:10b6:a03:44d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 21 Aug
 2026 19:35:36 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::aa) by SJ0PR05CA0037.outlook.office365.com
 (2603:10b6:a03:33f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 19:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/95] drm/amdgpu: Enable/disable NPA address translation
 using PSP
Date: Fri, 21 Aug 2026 15:33:40 -0400
Message-ID: <20260821193458.808626-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SJ0PR12MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ffb8fc-bd31-40fe-841f-08deffbb5d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|18002099003|56012099006|22082099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: GMAvPMkmKOkq+bM6pN0QIFPuMewVY0TX6drvbu0w923+UbvYl4PvSboj0JOs+je7zVBB1yDIctBjaV9bbvNd0a6i+WnXQD6TKhGwuQEB7oPyM4+U/kalNw+HjP0duQEhlIy+9Wogxt0tkcFRHN4Bl0mHlAqUMvQ31CBmV1LgILGsVY6FPVZ6sW48ZF5JfozavVjX3M5tr90OFi6PqWIAWBJ8uRu5LUJsBliZOtX6jy86e616W6pbFRpcrHC8I2BFlIx3LKdaqLgH3ujY2vHadRspzCVQTcnH3B6scx5/ricOXox0wg/JrWz7A/FyTgigc01ObjhX0WSdYHqRZkhkdebO5w8I/miXaEMgRKhn74QBUAUx5HVPxGGvm/LynjyiZpkT4Xdw/aVllI5byY/BxBGEs4KCFPaLs23R9LbvqfpnzxGSXotjL11bDZ4Gf3ZgMl7nPNdB08zc9iyb8oCldkw6r4kV2J9iRQqCkOseT5dswkA4Kpq0dCWb7vGt1/Cs3ikcxLnN98k20iBGe8tin3/txxbVhL0d93aHRoZBJYNSUiwCJRxipWbJUXhIPVe9SHK60X7bEarY+UUKkIOsH9Fq7NbDGfS2r7jDbMqFE3/b6F+lEM/wAzJl00ZfJuaYVsqEwcowuVS5RU9CP2Cu5AthZ6v0u4qMcpZR4DfSNvIy2dgdAa68Sg+StchRHamyAXLQsSwEMaM+yl6tLda2YA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(18002099003)(56012099006)(22082099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h1Kzgr4Va8Yu0XSZmJE3icTC3bNM5ANqKgYSur1rGWdvzccmUpaM3leg46S+uNwBT2NfMaVGs+WiCoV9JICpzqCA7th0EGnXUgsVFw1uS7lwuTUuVTDcyedLWtTDRrgCvb6QlY3PGvvWFU7w2LVeG8joCfdCrOZxvXaN2jm+CY7xi0mWbyN28c64Xg73D10B1kc0MX0IzxIjjmDZBNs5DEwMq4LPuzRYi5T5mTeB/axj4Ly6EStLUEd97Kyl3ahK2wRVIXnc0qJLduvQScHmmEReJ2D7U9ek7l9gMKT4+4cjqdP/mch0PWrd12XiosVPQCFGV4IrxPxscLQvvZWNgxtS/JJCvu7QUGIGzn8BgV0G4BhSYgcGQk7jBuVJsrvPBtkM+jmSsorxBS/oN7nmKXHEfc8k9dDxnUYN872rO9pus3VjeQklPLFO9KXd/dXH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:32.5677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ffb8fc-bd31-40fe-841f-08deffbb5d92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8613
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

From: Felix Kuehling <felix.kuehling@amd.com>

Enable or disable NPA address translation using PSP during accelerator
state transitions in and out of READY state.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 134ff3d86126b..ca4b34ef1a49c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -639,10 +639,16 @@ static bool check_local_vpod_integrity(struct amdgpu_device *adev)
 
 static void activate_accelerator(struct amdgpu_device *adev)
 {
+	int r;
+
 	if (adev->ualink.info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_READY)
 		return;
 
-	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
+	/* Enable incoming NPA address translation with VMID15 */
+	r = psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
+				   15, true);
+	if (!r)
+		adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
 }
 
 static void deactivate_accelerator(struct amdgpu_device *adev)
@@ -650,6 +656,10 @@ static void deactivate_accelerator(struct amdgpu_device *adev)
 	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_READY)
 		return;
 
+	/* Disable incoming NPA address translation with VMID15 */
+	psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
+			       15, false);
+	/* ignore return value */
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
 }
 
-- 
2.55.0

