Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855C0C47DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 11:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F03A610EDDF;
	Fri, 22 Mar 2024 11:15:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="134EifMq";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D2510EDDF
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 11:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIwCpUx70gDkWD9l100nnYm7841z0fJzsBnc+NL3t0bFLh10hrtCBzbJIcIqWfUHNCJfVNNWRSMbKzGtmad0SLiR/ZMb6RWthjMsFdM7VTD38CQHd3FqVGBEo8CLNuV5rW45SYXAaIvqvwe5Emb3RkmoWdOk9jAbQ0i68Pqqsi870z/SGpVKWHyO+JIjZMJk/ra3QtoS5w5kWEtIHwJbwLIRUpmCax0D8RezJPwxG7nORscEUv7oJ0YDmgPgIhShUuOGwkRmf8ZwVOQ2RNwMUQPw6Q6ZzTWkXnAuGA1jlScHeE7rkxPaGFrFfWOmVePUP/nudzPJsi2l/scnTwmu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xybyYhBMlM8E80OudOYl+1aDvVGQWsSAS8hAPU098E0=;
 b=C1mRfrNtD0I8N8yxB+8BdMdBFPcSuD53t2MA+nu081ypNIuOZuLfOUZv0tiAjZ3h1aYcHyblNWAcNA8N5IzJRL4ygZ8gaI2AdpzZyjWC1kfqP2HxFrj+vcTlwpgFOVBv/KwGA+WT0GfFrb7yyCnSX8qfCKk1FskrfNF8mNVW65azKzSMqKyo4JxSWy8+BMEf2hKIkaZx1HohstlttjvQVIA9g5EGXEC+wNLgdgnfprq+NeUlU4PjwhAZrDdeS5ecH0J/LAB9A3FMTBJMCc9roEe9D9P6nF9ZFs/MwAiG03VXTiGXCrDbbJXp3zmPCln90YDMJAMzHjAV/PQmolxyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xybyYhBMlM8E80OudOYl+1aDvVGQWsSAS8hAPU098E0=;
 b=134EifMq/+3dUL7J34XsDSd7RYmyBuEl9B7qJBqQ0J7X48dhzv+v9M5UY9KV3QKekJ5FsE0HojFj6oCSucPrZGuatIfLXr6wraqacB+zEFVegb6FnLtRDtlneMw4D1hgUccB9qEBEY1ULbGeNqkTFsr5Z4mvTCdb/hizleUmGw4=
Received: from BN0PR04CA0201.namprd04.prod.outlook.com (2603:10b6:408:e9::26)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 11:15:14 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::58) by BN0PR04CA0201.outlook.office365.com
 (2603:10b6:408:e9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 22 Mar 2024 11:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 11:15:14 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 06:15:13 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix the list movement
Date: Fri, 22 Mar 2024 12:14:45 +0100
Message-ID: <20240322111445.2162-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 8344cc86-9dde-4bd0-b039-08dc4a615900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGmsXUlqQEgCEUPjsHPSqIXyKkaO6FWdgbZqNL9rgkuYy3J+K+5sFlClopRUEV/IwPbTu4/uCKV7RCTm8QecL/4GNIr6/zJZiyFDntVkgoUmhT9bz7nn6juda7snals1NvJCgrn/QaKHz2PsGouBXdhYvTc4Cm6S+cJNJwMF8tyhu1ZBejuCsDKLJoBfFRtB3rk646pZEYu3L/K44L31Cz6PTDmDInJbeEKyD7rSOKTXAXGyHcys/E9nkdsfuMRtNsqjo0oU94ZyQBZaY+kSDxncHJ2TDJsSH6HNexctk51nWfoIKG9R8ePd9n0k1jpUsKYpo2I8NovIVD5i9luf3GpTXYeJVXRQFWWKLMQCfDuq7Vo/4WD3jNfCihoJJtLPo4GgbgQHgw7H/7sNf25lJLsiVe7Hf1b96m6BzHnzfScPdaAYTJoHycwBjGK7DvBsniZkIeGFaTNAJI65dhhWKe4DhgFxbWON3j2S3l076MNgkXwlyQZbyu6C0u/2bR5eLm3rrtQIH5wsukonppayYv5at0uDcaC2ptrHXk4MyRtje3qJFFVM7+bzDAzvCBIMEsiCysB7q4IXR1XWBx1CZGaRwohRHingQqP2UQTPt3F+FB6UhJGhq6K04l3cZmB2je4o4XYRpycDRkmvn2BumsqwIH79jBvpgIBZctj1Xg7t1iKO79MHXn0anVcrU8P8FNivrjx0b8++GEoUco4k1HNPWHGzFJpr7T9YSEXmNs7uYA8jrOBH58OtPK5LUb0j
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:15:14.4799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8344cc86-9dde-4bd0-b039-08dc4a615900
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265
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

This patch adds a fix for list object movement, which was
introduced in the TLB flush series.

Fixes: 0a29a49f3ed4 ("drm/amdgpu: sync page table freeing with tlb flush")
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a0a5b955a4b4..7fdd306a48a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -641,7 +641,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 
 	if (unlocked) {
 		spin_lock(&vm->status_lock);
-		list_splice_init(&vm->pt_freed, &params->tlb_flush_waitlist);
+		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
 		spin_unlock(&vm->status_lock);
 		schedule_work(&vm->pt_free_work);
 		return;
-- 
2.43.2

