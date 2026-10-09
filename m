Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9E9CA601D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 15:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE83B11206B;
	Fri,  9 Oct 2026 15:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MfY5/7Io";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D88410F42E
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 15:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rn4qtUNmcqtsLog5mdmkT0a/d8LLPdUze1dtMxZvSniolWNx8Agg4BpHgp9RabbshBD/KBoCeLw7JfUsvo86fvWBU3phD6dzBUEoWtNLIB2TlpHL4Gi9hZk9EdSCfA2CVhOBypWCoe4U49t7QBPtlzT8q2LROmiWeDgXKVLYMVUp7dR4WiRapZiPEX00tFYArAqtE75QA907Cw4lSXpjkJd4IgjsDJXpvK9FV3FKk7I/Yu5NtYdZ07w/xKFN6gI35bh2TdTyGm8Tn4tu+sidK4PtRhOvDu+ZPhzmzzOFLK6c47kLLPkMKn+80m9sYUK3Q4pV0vMIR+RZC0lu3PLF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCRA5W3AJNvNbkv9zHngGHgQczUFn0+MrYBUPZOmnJk=;
 b=SCArrU6HRM4XMymccpkREbdTL+3Senfgp65bDDP2WNmlr3hFLaFea30GLxp1KQogMJB/uUY+TiJ8doFX+rSyxH/YnVup7wId6A4Q6YmOdzDIVs8keNt2gKlTgx2rQs4L6vgpMHampBIujICAL0TQDj7TljoN5rtR53ALvOiTOzK3zDOWMPJ5EPjsW5kOVZSL8C/DiGcN5VktkgsfMsXousofC1jIw8rEKtUZdh8PCkJytw7RgpfhIYQd3zB3Af24KOP+L/ncG8dN2pAG1fU/X9h336Y8FRuH6pv17c2hHHoC8OQgVX/MejL3v68KWjtFT43Az+SQ1sfKeItlArnBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCRA5W3AJNvNbkv9zHngGHgQczUFn0+MrYBUPZOmnJk=;
 b=MfY5/7IoGpIMCj4Sit/nYUFdnGfORxTYQt2gGWLtOFHCkd7bU+KIu/qftWO/Nz0wslfmJVEapIlb1+jV+rwM8ua4iCnfgXr5W0EkjUPqj83qA5lNp0l0GMFaLm17kbvCFiWshNwJd9gWDH+vrhbu7uxkICHRRcLlSr16mdPfGqU=
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by DS0PR12MB999079.namprd12.prod.outlook.com (2603:10b6:8:302::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:46:55 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::3) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Fri, 9
 Oct 2026 15:46:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 15:46:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 10:46:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 10:46:49 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 10:46:48 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Sunil Khatri <sunil.khatri@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH] drm/amdgpu/userq: actually invalidate userq BOs
Date: Fri, 9 Oct 2026 11:46:51 -0400
Message-ID: <20261009154651.632259-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|DS0PR12MB999079:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acb530f-eeab-4f46-3233-08df261c8b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5sNyzAGtLr+c2auRv02Pkmd4OkNokPKV1NRTr71KtPgqNNNob7GEjLvxSSnAq5T650Ar2nSMbqGVjLInG+2icV8gd9WPXAxQL9Y6aGrPzghjBke6HeaqMI2FGD7oI/ZvTlhdvkdApln7CB9ZAXfbPoN+4HWFz9NAnY+QQwyOXUGVG5tmtgsTBfRUkl4Onsd931RA8YiC7jqhwKghH4Uu2sNsLFKcquQwPVWocl8zLsosruLdk2VuOOf8RO4a2AM/NgUP4OgTQiNluAschfa5JB/x5CN2aiVWu74wkMsWUMVP4bC1iXdxWJ+TkD0tV0LZ01OO3p6PLHeWyXdeVc9VB3UF7bBQEtUlwK48IvnvPQcAPsI9LRBMmwnKY8u36SMKyQOc7mVhrv6H7aF44DIWrQm4v7Rd70mwZZYAAadEg3p9Bue2aaS/PhU2L8KhQv+uLwr0v4LmSnN2Dew0KK6XV8k/jHrK86wK2gGAAJuUD2K9uMNBD+cWs/kXqyf3Wbgu9UNT0fRVY1/UyMvlczWCsWgGj7GFo++VhG7UkXgK+BQgGsRZaU95xvjix0WFPuq7tYgsQW/AtuJd/D3Hr423Jgt94va/WtYdjfaSbxWa0kMKUF9ZRNmzb9jYmBZr1XtzPJwMQNQnApWXQJ0+fQ6Of/jQtrutBKW93DF9uFIdCa/4eCLUtO91eRwXHawCkdFhzn9wYScrq0t6uQhOYKeY6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o6EKmxdMwaFTwzvKs0zeMSQ+TFYJdRFICHIu8IZTXXGxUAdSw8Ue/gfbgWMyy8p57a6mZYW/rOTsrFT9vkak9UpgUgJEWEgrlF/cAmdUXBabCYMbxkfHvz8r6MVm5lUrPOwlhwJjNykek1CENhNqZhCEWgXicpmghligzE/37oxJRQqIidX/neUC1jz4id6ZSsyuh+HPQa5gswvIg3IECd1cbUjy2nP/kPbxh5ogUEBFG2W8DuuR7TpxP5c/BfbxbsjvbGXR6ef8aSJjAZMCLp6HhJeR3ExjYYBlOFPpF+GSMLTVOvl9+Ewv/VVLFC5JrbbWODA3OP9IE3JG/YjY8wxPLYNjnLubyHXGiqkH3VexNwo2r/OFACadw9PztPS0QhviffOBT0YEwR8/PPhKEyBT9p3VnueRCcEuV3TSemwhTcjMK6UrVX4bgk3TztJ7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:46:54.7556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acb530f-eeab-4f46-3233-08df261c8b63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999079
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

This was supposed to loop over the individual evicted list, as the
kernel and always_valid evicted lists were already handled in
amdgpu_vm_validate.

Without this, BOs that were created and evicted before a userq was made
would end up never end up in an eviction fence rearm.

Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a90db4d3d4e9..5b9f7f7f3862 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -993,8 +993,8 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 	int ret;
 
 	spin_lock(&vm->individual_lock);
-	while (!list_empty(&vm->always_valid.evicted)) {
-		bo_va = list_first_entry(&vm->always_valid.evicted,
+	while (!list_empty(&vm->individual.evicted)) {
+		bo_va = list_first_entry(&vm->individual.evicted,
 					 struct amdgpu_bo_va,
 					 base.vm_status);
 		spin_unlock(&vm->individual_lock);
-- 
2.55.0

