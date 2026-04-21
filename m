Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07883F94CA1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9386010E917;
	Tue, 21 Apr 2026 17:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FnCJ1Ry1";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011000.outbound.protection.outlook.com
 [40.93.194.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E3810E912
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoNrEjijiIm8JcTl0PjRjPsXpwzmAWFquYAd1EsdxMA9wnjxc8pqStgnfnpSgSr0Nm7HESbFMXrA80TPeaQQ6sF/6K+RjnasDa+l5rdjHhpR4TU6hzYvtPG2+AonocOZ5nmZZvjgrx9xWmjKJM3oLi+R+O5HBDR+/idbxMKFposbVcnRr3qh59ECKsHSVXn1koNfmjS3MOo4ukj+8HSe2KkQ8QrUOT6p+jO6iZce5WjDFYMiggvKs44onOheWXcpkVZWijnoAhTfKmRxR+qeKJ52cyDvE/PWFW666QPOZJ6IFDj6M6NiK3SEzmCf051vBJCP4jZPiaCv5Jb7sn93Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1A5UBO0GOJXHSjoXgLHE1+EUepZaAk1WK6tU2iFQOTM=;
 b=E6adQvLch662uTqYq0U+VJ7hoJ4Y7uRGElqsOOP+JkV+rL5mFhNNH4wsyJf56hIY/Cd04JAPAxoXusRWqXV+vcNe82uHyMMjmcYvRw3vsgVhD8pkZujbpgNwoOB6ruUz6gCHN0wnJF5pfn3frmShLWI8Ti12NC+JGSSjihX/1tA/rh+TTpOSumIhNtN7CTc3IiIhddDVXNvIl088++FLwo+ipYM6Qg8NkTm7ucJe2+rDIorjYtyt/ePRFPTbpL0EahXvIvZMizldNwBHvczbUTV4CZY83f3dtG4xA/zGGVzYFfiKmZOCCeg8HDxiO7qHBpGmg/lINbz9ofYTJSxI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A5UBO0GOJXHSjoXgLHE1+EUepZaAk1WK6tU2iFQOTM=;
 b=FnCJ1Ry1n6ZUPpXPaw5XOIlTmVN/Q0EmxrTiD+ppL23P+MtwmcMzl0nHpWSqf/2GfItIdjC9C6gA9rGFz5AFjHNIg+flZyoykol+Jo5/xI/dPjBukBIO1myXn1RaYBHGsR8WutTofGWg1UQzE68feTIjbX4/I4ojmIyOF3N1M3Y=
Received: from DS7P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::17) by
 SJ5PPF665EE4E73.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::996)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Tue, 21 Apr
 2026 17:59:45 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::c7) by DS7P220CA0028.outlook.office365.com
 (2603:10b6:8:223::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:59:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 12:59:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 11/11] drm/amdgpu: Signal SCRATCH eventfds
Date: Tue, 21 Apr 2026 23:29:08 +0530
Message-ID: <20260421175908.2402019-12-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
References: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|SJ5PPF665EE4E73:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4aa8fb-eeef-460f-600c-08de9fcfc532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: pjdM7L6j8a7MGOeAQw457XDW/VzxHxUOgJNTdEQxhN1k/qBSNjS3kvz+9HvEt3cxdW89o0OrwCvg9SUjjrULCZQcph9WAHwOjWtPyrE+wT+5lvyhWRpraST3VmGFR2sE8jJoXZaRTzLVlK4Bvk2ApNa63qBV912QRsk4ak6hKc1Yx4bOqioOb/5INEtW/51RxZgYlDW09L01Mk/dMdFy5Hcmk/0JyuAmDyWLmzGPYmvxvpO4knbzf9pVieHsbNINFrA5Lo//0LT8POJ5kws7khPWSjTmaLWfAD7Ov7QmgAgKBa11Ovg89WIm05NkLFsnxXnqVP9OWCyxLsYMnFI2oXJJ734V5U9QRd7dSi6dLIgaqAmEVmEc9WrgEHLoPLeRYIraPjaIHnv6+KR3Y2AEQPrHPYD8ctNBLbtYzD4QqbngknVG2LYRzU2koiixPzGLBokn8p7m3orxowcH7jhP9WAXvCh+CMq0FNW6Fo1yMCv0J6FI4VSaYrXp63T+49oT9t598i7eA/x474B4FT06vXRmipGPPlMWcGAyj3ZKxtwSw69Fa1UHRujAj4LqlDquJ1V4r3pqatqf2I5nNhoW9cR1V1F1vWZKnYIc+h/eF2St6/sJnzeRY+5wyMaMAkQT1fGwRqZgMb35XZAwPdINezn9gBjPYgv/X8M2bkcdLfgifBhyGQjbjNfiJqHgOZJsZYktTn75IQx3bDxiK/A3c2MuJGmdZqKNxPvIvCnHyQLljbdT166wwubVVlzU/H+YTeE5W0pF2Ru01e3Xsm6Siw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FrgQOPFq2lWe2xCutRSqWNL3NPEJ+mF8wnwi4MOrJYGoiM2YSDuQGz4rO71tZvx93LbE0fJgxKtPtUNXMLJUC1yKCWKh2uQLTqM/VAxyA/lN4VJGsX7jNoYObIkGyUxxayRXmMUn44mMpSbv0Ly2rmM7wXDPa+umYlNp/tailUFKze7d1o0SmxREIEvCJ/2hAcx/4co5wF4tkqXYgD5eq0ti/M6UidiUBn685D3MsYZvOTU4+P4X9kFYOwz8Iqhz1DdzOBQ1HyccPU/YyDITK9GQ/iwlS3mktXajkRu4r1lFIAxPjhcJYI3s+suy/9HypfntJGbWsaOSCnYNtPm6KaHFySPRJqmmgMvVbsN1GbXZqhRHTajE0UzW3l+1m4Q6iMoUBsv8l2DUINoiRLh9RHP6Rxbrm/WAKV73IcIvCg+UPMo8PHsqL2dX+sLf67cF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:59:44.8266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4aa8fb-eeef-460f-600c-08de9fcfc532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF665EE4E73
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

Signal SCRATCH EVENTFD subscriptions when user queue restore detects
missing VA mappings.

The INVALID_VA queue state is set when user queue restore finds that
required VA mappings are no longer present. Reuse this point to signal
queue-scoped SCRATCH eventfd subscriptions keyed by doorbell index.

EVENTFD remains notification-only.

Changes in v8:
- Use queue->qid instead of doorbell_index for queue-scoped event
  handling (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index dc6bcf955ece..2d140d7ee4eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1019,6 +1019,14 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+
+			if (queue->userq_mgr &&
+			    queue->userq_mgr->eventfd_mgr)
+				amdgpu_eventfd_signal(
+					queue->userq_mgr->eventfd_mgr,
+					DRM_AMDGPU_EVENT_TYPE_SCRATCH,
+					queue->qid);
+
 			continue;
 		}
 
-- 
2.34.1

