Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C95ECD5BD0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 09:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3060710E610;
	Tue, 26 May 2026 09:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XLFY8skZ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A3310E610
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 09:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2P0zkpIKACv2/oMiG9wkGsDa5bjYEWWx7f/D82rPzUaPiuvYfzlWZNexGtwxSuG6+9kXpT9+7E6DUGomLWrl+dnpogM8/CVlDOcbtjyx9nwAVGXtjZrraeExsGojCJnyEoxmXtyhEvnNUTEKRHcFh7dHatmcoHg9F9emJlfOGOEhEZ5hf6IHuHEb1RczHKDWSDvU+H5k4cbk1bUIpsuGP/cxSkE+u24PJSKJfMCqM3p4f30ePP65wy/TWOcgVimVn3KXAGonPK4EU0aH4B+FWxhIoDICvKMPEbwoArDefaGKxvL6ZmhIlu+ZN5fBnJTESeUwDqIaeqxc1oNtNeHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN0n1NfaGMIJIDl7/YCBS8PtUnr6Je5dLnUkfra80Ns=;
 b=HGP/vQIB+bhEjpicXfArE/UlKk3iGd2bRa0i5qOKjZXHzpAwMJbbT+JhxKa6UUgk4bIkKTPFcEBDxYXvhA+WIvEmE3poI9oNYoYziSDuYGdGlWGr1613Y5cHJt2FkgzvHJxmgnAGeVTP2RZXfunRBMSPpGXknD/dM5Ckqij/BQHE2bXL1piQhvv8yxkV/+V3e2jamVFi1ADgi8jCJ7rRk7ePS3EFrAnxrIeP6wHlUJIz84gglzYu3DFRCIq9zjJoBc7UhpGJENTT5NYHhRUH4GrPWU0lJyQlPzsM5O4Lw1kcQWnzkT1eT4sf2aSmM41B4AadcWiW2VPG6KZ/Eknctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN0n1NfaGMIJIDl7/YCBS8PtUnr6Je5dLnUkfra80Ns=;
 b=XLFY8skZJI9yC+SkPYK5HmyPSSAI0+3ER6BxE094uA2wkYt8iR2OREg2aCRydQK9vGUnmJq7eh1hbZ9lJDRufC4O02wrQ893NH8Lzx9KI9E2Icf8mnzQHLeW7uCXYlwv9boAcP7KoizdtG0SKQ1wICVjqscvkEqVXkp78e1Yhhw=
Received: from PH8PR02CA0014.namprd02.prod.outlook.com (2603:10b6:510:2d0::6)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 09:32:25 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::5e) by PH8PR02CA0014.outlook.office365.com
 (2603:10b6:510:2d0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 09:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 09:32:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 04:32:20 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: only flush restore work for rearming the
 eviction fence
Date: Tue, 26 May 2026 17:32:09 +0800
Message-ID: <20260526093210.55565-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526093210.55565-1-Prike.Liang@amd.com>
References: <20260526093210.55565-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b773f9f-f7a7-4f61-4edc-08debb09b22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|11063799006|6133799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: wwlFti0KBlDdPBU4IbVd95/fNUBNYkzRWi0FuZQqQr8teiECHQVTiZPFZsK9nvX8HvL47FNjqGyhVkWPZP672aQTlDLg3IWOCttnS4V5Hu6KAKYTWZwrUTWT8XVSs+xpPTdawa2TDET1I+J8zbgATjfLGIY9osREqw1Yx+ROgPr6UMrZILoGm5mZUqpBjwH12tVz275sMk3D/aWI2kNEUVG37/OKVG8PAUrLiNsafOQZjGRLr6GgHb0fc1WP/ECMPldwMIh4vmrIF1LQZW7Ww1EROiEKetkN4J7JbDA+G3TazPXknG+JpKUNnWn2In26FVthA6yUDzzL2FE/koTl3CRB9p+4osf1o9arYl9+v6N9Lg4O8d1jmJ0Qse18kfzDHo2/yCkOWAzuhO/gTMHF9j2UwoUV4X8aBxRA+6j4vJ1y6nIUV29a7uyH16T+b1u2HSOFctAiiwuDB+TYb60Fo07qwWC+k43rsE/B2e2ci8EPQR81UEdB/WbAcQ3EcVp9yD1gt0QfaQfw6s73nm2a8zvrvFMrDugALBIQ55V/svAu7/p+SVBNF26IlKX5RJemCkihSDMuCTNCVnwC22RJvh8hVGUN39v7Zix59R2f7bnMZQ5BAS+aN5XJN5hOe9ipeBqcncZM+/bCB36eqyZuutdy9zKz0YchmGDWQCjkT/0kOePXpPozuMaMBcCH5c3z4LOH3cuLcgmfvWQep/wrzdexcS7f085i1kDVMdHeMCw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(6133799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wu+X95fE9Zsd6l6Hh9cnNHn+BDalMDIhsCZonTp0Vw94tcxICVLJETjSppiZcU8mPugBK721NheZ30cULWBasOODQQU+ojoSlo6pUdhqOpl2AmejZfsPzK2CqjLFPAV1Ql+CbJuFPRoIuEUqHAg5EvSTuK+zeBT4mtnSLrHlHra8Zvi1GfVd8VzID4+YQcs/k/gYSQp+2NOKmYdEeq5BGWzzWzxBzcSTgSBfJCfi/DO6H/SonVF3TTwNNezsT81AI1ziNIKuuMk91pQSF+bd9Flxg6hBidcXKk16isKaJAtYQyQR1nn+GWCwTax/y55mn2h3GCA0IoZR8f5HjfxxRVqfX1TSBf9gS8lYlY+OMAve7wywXtKJMMoSgZXmoQuT/oSrAUKf6Aa9RWGthI9CLs3uVNfrHpyXvJU8vmcnRm8mkC/1Spc45Oh2I080JLf0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:32:25.1269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b773f9f-f7a7-4f61-4edc-08debb09b22e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139
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

The userq signal path calls amdgpu_userq_ensure_ev_fence() for every
emitted userq fence. That helper unconditionally flushed resume_work even
when the current eviction fence was already valid and unsignaled. This
adds expensive workqueue synchronization to the normal submit path.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 38e310a8694d..f650d8d0ef53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -412,8 +412,6 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 	struct dma_fence *ev_fence;
 
 retry:
-	/* Flush any pending resume work to create ev_fence */
-	flush_delayed_work(&uq_mgr->resume_work);
 
 	mutex_lock(&uq_mgr->userq_mutex);
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
@@ -422,9 +420,12 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 		mutex_unlock(&uq_mgr->userq_mutex);
 		/*
 		 * Looks like there was no pending resume work,
-		 * add one now to create a valid eviction fence
+		 * add one now to create a valid eviction fence.
+		 * Only flush the restore worker when the current eviction
+		 * fence has already signaled and a new one needs to be rearmed.
 		 */
 		schedule_delayed_work(&uq_mgr->resume_work, 0);
+		flush_delayed_work(&uq_mgr->resume_work);
 		goto retry;
 	}
 	dma_fence_put(ev_fence);
-- 
2.34.1

