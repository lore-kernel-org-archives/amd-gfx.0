Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC2EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 18:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C099C10E25C;
	Mon, 15 Apr 2024 18:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UVOHaL7W";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B3A10E25C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 18:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7M7+3J8p1es6TnC5vYLdYeSzL5r2aC5Hoa5is25vmKQ6gw9XWIEhrVhVVDjVo6kSM2kZy1wyX6TqgOwGsmq/gt+09U6pstsvkxjGK4eAMv4FaQRZFjR9+WPJM0pEfucxrII6GwDUqafTFpDn+gB6Tv266D543BDVg6pN/Zc22KJoTKZJkoXbuyq5A2pQGQxikF+FRwGMiTNQV0LR9q/TnzXhT8Wukwpic8r5PTjOs455utbJuB3xsolI7lqV3z4ES6z+27FWmAxlpA9eck80UaSVmqaTqX1INgLki22PRKaq4HmU6vUc2iUHENr/jIaFG64iS2YTqc91ZAmPd9KaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2N5dkfqNSnd2vSvjfZM/HmIhpM3UeQoEYHWZH52UmTk=;
 b=cML2c5LbSKVpBDciYz3nqfvbfRPJeCEOy/8ABWhUd6rCoONectjJuKLHpEPcDEhP/EYxrtoeS6HxZU550ppx2sRXJRRx+ecxG42Kyq7zu3O8DT7F/7OKbRAwD4dGHwDt/cMcZ7REoll0Jlr3RzNG1AASUGMw2KaITGtlCbJ0398bnBDlzalirRnuQdIZQu3fRqWN9gKga37ql9PPfWcTSSMxLkVcrxJ1iNapi5NDrD2Cfu6GTT9Np4viQAXlWMAUGBztYPn8d+JAv9Khr+4cs9iRIFnszxZTP+lYkU5oWdfRH11gPc1vNPoWbxn9s8D9EVWR2pzpbOKnQfR/Esq+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2N5dkfqNSnd2vSvjfZM/HmIhpM3UeQoEYHWZH52UmTk=;
 b=UVOHaL7Wh5aDOQ13Bc/24G4XxgaMNKntLur23T65zB64bkDJS6s2S93enM4pcxRmTuI66I1QRVl8bW8TdNJdaMMVctgeBQGeOUJERbUM7uNyPmsyiihEUqzfKPy6D03DGaYagdu5o3/uOKePBCjqqlXAI3Igwb7HnaThx7qu0Yg=
Received: from CY8P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::24)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 18:49:02 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:6b:cafe::18) by CY8P222CA0010.outlook.office365.com
 (2603:10b6:930:6b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 18:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 18:49:02 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 13:48:59 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amdgpu: clear seq64 memory on free
Date: Tue, 16 Apr 2024 00:18:37 +0530
Message-ID: <20240415184837.299965-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e93ec1-d80a-4009-d5ff-08dc5d7cb800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5H+/uhmSOEg2Vj6So4zaV9oyWig27KD87s0J+wW4rB6EX1+eLaOVaR0OuyAyHHa5WM73nONpa+ePzmTavLce6PMwGv9eTH/oE+q1Ts7u4C+jASDktgpaDsaYMx61vwd8cQWJY2ZTg060D7MGsP/K5jBbaUhQO31BQDOdz62iRLcnU8qEhUjBOTet6Sq22/CWoUEb8fu0IcQfwaqrgTerY0ZsSoBIHa4O+Stxh/lhH8ni+rikWaa0iy7DtXk/zrZ4n1ZZc2npDOG8wFLQXPhJ4kHu/w+QtBycCHVa7Sg2d4vK2IEPRLA0rb5/gFpym445qlKywL6e4AyLAwNC1SyJ2S8ufHP5D+STQCWLCNtdo3J3h3HKYjB57yWKh/1KiJVMJHc9sMiOtYrmP8/G8lZeKh+frQ/N7jvbxOevO2guwsAUljU9asQSMqUCRpw/i1kRkTlHlBqCsRwuUCeziMSl4ol8UDkIyEUb+Gjpka88zb+3LMKzUiN8TBh+ynD+zZ33g1uCYjSdG94bxiGmqR4FNSzmXrOnDr0kdhNLAkEHj63Rf33DI0oPPr6mLK7RfXEuwwVdQEixVQkCVfTMN7WGx2utrMX+LOduHJH40PEwP8mMqGAp7FoyVZU7/0g9qd0tHrn0+afuKX2X64L7L5LbRIHgQ3WVjL3pOlFo6KGLhROV1cjqJ9A/7F3RK/XDlNsqtgRJgfet/goPlRZ4Vx+iM1O6nAkyeKwuUUTjMfH61YNB1Y+n/fYzL1WblMglD/Z
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 18:49:02.3220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e93ec1-d80a-4009-d5ff-08dc5d7cb800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
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

We should clear the memory on free. Otherwise,
there is a chance that we will access the previous
application data and this would leads to an abnormal
behaviour in the current application.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 4b9afc4df031..9613992c9804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -189,10 +189,14 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
 void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
 {
 	unsigned long bit_pos;
+	u64 *cpu_addr;
 
 	bit_pos = (va - amdgpu_seq64_get_va_base(adev)) / sizeof(u64);
-	if (bit_pos < adev->seq64.num_sem)
+	if (bit_pos < adev->seq64.num_sem) {
+		cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
+		memset(cpu_addr, 0, sizeof(u64));
 		__clear_bit(bit_pos, adev->seq64.used);
+	}
 }
 
 /**
-- 
2.25.1

