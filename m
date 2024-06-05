Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553DEC27C55
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 01:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A7710E672;
	Wed,  5 Jun 2024 01:33:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5izYaAuu";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B8B10E672
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 01:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvXgnDWoEavEIKA/xm8+bJdWRe9zLGCIB9qpA7Yih64Z07Mx52ZfNcNEt/MIiVI/zKNY7RexrIB4rESQuc8d/IU+nY62pA24XM4yT7b0fWDqlM4J7gAG6QHWX/e6CY2kbRn7VkrqixkZvBq4rQdUJnHhUpYOJJyILiigCdTLEhcY/CM1mFI+3rSPsQImHSgfDooOGtIesU1tLooHe57y3IU4bKtgeLwkeEdAhKlXUd3DZKe9LcAPHHb9VafcRnRGLjM806w8HHGqNikv80j6gd0rZuf+7Aw+72cnTvnwV8pfvuQ7kZk2CNnKFslPGJLHDtqgIoTxHYHqJLQ+SupjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7l13edFhL3qvby5pBBn+8btHybQnHVTmuNZWyMAK98=;
 b=Uyjb2uR4U+0UHgD9+DellqfWD7/HKpE0FUpOLBz+Hocfui2Gv3nPKZyRxUWrbExKdrNpk5yCEff0bO4xvEAHZJTtzlI2gzszNw7VaSDzAxBc6bTFzJDDjPRzA2gY4D/1cFrANHsM/6xF18BGFxJqNWkAYMDrjWdQH27mH20+aYY2HjGj0cInVIXpYVfICFdVAMPveB+30acoPWLw9Hivdwz7M5ANG3ga68KE9ihkoywC2En+Wb2+5bDTGSfe+mJhO2UibM6k30NErDnnp2yNxtghucSfK7Qt/XfpRpL+uzyxCJ3TNflffUdz27K2648Ed+PTpL1c1eFpZJW9Xs/fzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7l13edFhL3qvby5pBBn+8btHybQnHVTmuNZWyMAK98=;
 b=5izYaAuutb4EW+bjHGOdXWjzg32Ti4QmD6LXtg12yJmI/17jfz/gHWDpIKbizyqRm3hCOCAL0Lm+4176fnvLbxfhh/PwgTYWTaME3o1iGfefPSyMkYFWZNzj/jj7DOV3cdObsTOhfnO39fjzHcQLW2xE5NE0IuDD7RMIw7yHe14=
Received: from BN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:e6::16)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 01:33:53 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::44) by BN0PR03CA0011.outlook.office365.com
 (2603:10b6:408:e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 01:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 01:33:53 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 20:33:51 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v4 8/9] drm/amdgpu: add lock in amdgpu_gart_invalidate_tlb
Date: Tue, 4 Jun 2024 21:33:17 -0400
Message-ID: <20240605013318.11260-9-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605013318.11260-1-Yunxiang.Li@amd.com>
References: <20240605013318.11260-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfc4875-ccb0-4a0a-5f17-08dc84ff8f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXlZUWl6azFORGl5d3BlODluaU5HckM1OGVGNEZ1MUV0bXNpWjRqSHY5Sm1Q?=
 =?utf-8?B?dUFST1pRb1UyQUlaREI1S1pjTmxxRDk2bCtWSFd6OUloZDRxTTBHNk9TTXhw?=
 =?utf-8?B?eVBINUdpWnhINmpTSjZ2ZXM1elZJVW5jUUtZRkUyVEU3cFR4ZXhVem5CYit4?=
 =?utf-8?B?RmpaWjlHQlMrWEpjbHJLZ1k5OGlLOUpickk2Wko4WC9IM1pkdlJhenFQeGFm?=
 =?utf-8?B?U05SclFQaEVJZWY4UXRhSXNFZUZHYllYZGQ0N1JVY0RZYXV1bE9saHVuN2JZ?=
 =?utf-8?B?bXBDYzAvRzJJbEFtYWVwTDZFNUU0ZGpjZnJrWThHZmtWejhONGd3ZzBuU0Qw?=
 =?utf-8?B?NTlBYjJiYWtISE1nR1lUMitQcGVlamNPRTFiMFdJM2J0bkttSnkwSFljUHV3?=
 =?utf-8?B?M1ZXZWdHUTVpTGdQaXdGN040MldSYUFId2Z4dzV2dkg4N0FSbSt1NjBuYWk1?=
 =?utf-8?B?VGdXSE5NYTlmdyttWGJiRFF2Ynp5OHp3Njk5eVVVSzNwNHIvTHlUYnQ1aU1Q?=
 =?utf-8?B?TGFFaGppcW5XeFJnc2gzVTJLQndKd3U3dGhZQVRvZVdaa201NFR2OGlqdEpO?=
 =?utf-8?B?SU1LUjF2SC9xRjNPamkzY3Q3a0pYM29xQlpUZ0E0eFlKWTduRFVyU3ltUmI5?=
 =?utf-8?B?QkxxM09VaGI5WkM2aTZ3ai9jV3kzY0MxaUtaajVKbWt4NzhpWjNRU0kvSlZm?=
 =?utf-8?B?M29ySnZHVGtFcDRlQjdUMm1tbTRoc3ozZWJFR1pKL2pZUXlVSUhqY1d2RnNC?=
 =?utf-8?B?L2NDVUVMbkloS3Q3Q1IzOEowRmN2QmxYcHhQSTBwQk9TdjRtU1dkYVluMkMw?=
 =?utf-8?B?V2dnVHU4eXVLYWhEN0lrWTVMQjVPOXZZN1k1NmhuVFliM2VKT3Fza1pUcXRi?=
 =?utf-8?B?dU1vQ0VuM0FMV3ZBditOcUc1bUNFMWx4SnVjVms4OUV0T2pPdURIcnVSNlZK?=
 =?utf-8?B?eTVUNVNUMHVaNFNvVUExTHpTb3ZjMjUyZ2hxQjRucytFR0JONXBGK1I4QWVI?=
 =?utf-8?B?blp3MUpQWmhHN1p4MXd3Kzg1WTV5VTBISU91R3QrRWlDRE9MUjg3SHozSklt?=
 =?utf-8?B?Z1A5bFpJczQwNVlJdFBxWnc0elhkdTZpaG92WmllckJZNjZ1WnF2NzBFTndv?=
 =?utf-8?B?aTl5L2FuMTVNWlNnTnd0bWNUcHA3S1J6NFd1eUtma2NZVzdFVjB2L1hpeE9J?=
 =?utf-8?B?eGF5OC9VNUwvSStsdlZQN3BjVXFpbFo1YmsxYjlvQjZpb1Q2UDY5RlVxZzF5?=
 =?utf-8?B?dGYrdmRoMHZQTmdqYW9wcnVRY3FQRlhJSHZ6K0ZncDV5Z243ZTQrWTNvRHNl?=
 =?utf-8?B?cWJPdkRCQkpib1BLUDVhWXU5QzI0aWluTDRnNkVsK3AzemlidU5maXNJbmtD?=
 =?utf-8?B?dU5XTXMyb0xEdkVPdWphTHVWM1htWTNaZXozbkl4UEU3Y1BsZ2QzNEZyTEp5?=
 =?utf-8?B?cWVxdEZaUUhUUHlVcm81YWdwMGp0a1ZLbkt4NFlhaEdxdlJzNWFMbHJqODB1?=
 =?utf-8?B?SUp4aXJSWDF1R25yVzdWWFJOblBQaFkzL0xzRXJvTmhCT0xDcGk4N1I1QlVT?=
 =?utf-8?B?MkU3ZkY5R1ZhOG1HOFRKelRQbmYwMHVhYmJWNW1uQnFKUUtRUGFNOFF2TXZO?=
 =?utf-8?B?dXRsLyt0czBlb1JIMnFUNkdVbjEyMWNhclNVQ2JIU0k1NkUrM2RtT0NtdUdE?=
 =?utf-8?B?cFVoQ21ZOWNublNNZ2dKVGdHUlRjbGVEeTVtVWVzVElsOE1RSGNKWXBkQmt0?=
 =?utf-8?B?amVoNUFwOStsS1QxcktXcm05TmFPTTZ5MlljdEhNQWg3UmVCQ3ViWW8xSXdR?=
 =?utf-8?B?VEFWOVN4MUxMR3QxNURpVlcyZjBzT1R2OE1jY3I3eUkrT1ZOK3pwdDZiaTF3?=
 =?utf-8?Q?dUwY/nAC2qTW4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:33:53.6455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfc4875-ccb0-4a0a-5f17-08dc84ff8f65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361
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

We need to take the reset domain lock before flush hdp. We can't put the
lock inside amdgpu_device_flush_hdp itself because it is used during
reset where we already take the write side lock.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index eb172388d99e..256b95232de5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -34,6 +34,7 @@
 #include <asm/set_memory.h>
 #endif
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
 
@@ -405,7 +406,10 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
 		return;
 
 	mb();
-	amdgpu_device_flush_hdp(adev, NULL);
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_device_flush_hdp(adev, NULL);
+		up_read(&adev->reset_domain->sem);
+	}
 	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 }
-- 
2.34.1

