Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CDEC61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9838410E299;
	Fri, 28 Aug 2026 09:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ILXYGkRp";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B8910E282
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C22UCrmBaX3D5N5/o919MbQAezG9Pw3FrD3rMF62S3lKvAHaLB6Cugjvw5LGlhXCauIkHVgjPYR0OlyjZ4HnFP8ymmkg7yGcn24fwTXJHlnsGnMuT2uRtr0eXt9/WGF5WjY8IrDAyMwDdSFHw9QaAE2z4ELsT3MLwnPotndNL3/ITbvC+3XDrGXTOZ5gNNWWSZsCSq6pxkG2KZ/GurPi/PZCLGxZRV4A+2X8EhPyHccYjUmdsiZCsmi8FNxm50Jx+YIALYjlpmeFKdHi30LWzm9U6Be+OuGW8xKSFV0YkGZ5A6vVToKMe/obN5qTz2c3gPsjb7WDaN1mZi2eSGISjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+I1dI3NugWPUdvrf4Ar7J4LsfKmJQiJh2NWKpeRUORY=;
 b=xShf/hXHyPophemLH/7x2NOrp9FN32HbkISiQ1Kc65dJawqLAT2onlErBvW7WvrboAPGbtiSMNPNrKlO4WnCeTTEFYm38LPNOat3K64VdyqUqPIvCZhIsU8w6Yu/0aMxF7dQfCIgX1sds/kmZ0KnXxgAZGQW5Imn72hP3DE4OTdlAahcU9L2RdRxUl8IeO/lCiaqmdEXvyuYJu7OyaD0rhqewk14KR6fKHj4bkoLwfeVz10U37cdd1dtlL4GqYR2eVcwavMAfqYNizajJ421Vv4+qauTc6gJ3wQzfSMfveAUTmfITwOsGaoZZmUGW48gmjO9X7VnL19STXj4mxJwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I1dI3NugWPUdvrf4Ar7J4LsfKmJQiJh2NWKpeRUORY=;
 b=ILXYGkRpms5AhAy0Ya38Q8z3WN2x20lG3i+cYfjeXrXWsvoIqb4R3ADKIyVq6m2UW2KmIfMXmd0iMWogej/HB/Adb1TFlLmZLePXq6tGzQg8ZYg8MJYO2zujI3D7FO3mwblTKZqE+KYoU4bkto/RvP7U2Cm8SEAVaVvTGVbEhBk=
Received: from DS1P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::14) by
 DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Fri, 28 Aug 2026 09:53:48 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:242:cafe::2) by DS1P221CA0024.outlook.office365.com
 (2603:10b6:8:242::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 09:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:53:47 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:53:45 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 04/10] drm/amdgpu/gfx12: hold userq refs in private fault
 worker
Date: Fri, 28 Aug 2026 17:53:43 +0800
Message-ID: <20260828095349.9797-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828095349.9797-1-lingshan.zhu@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d425dd-815e-4782-fa7f-08df04ea41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UMJksxe/kQjVnjpHmuYCdWep6FXO98cFWQ8pmiqPDfMmV4HTsgs4AXCsRK6dkcJa7Z41SGERGp1/WXjltiQ9YPqXfU97vdXd90SMftD8kh3Z9n++R+frrgs/Shj0wlMz7LgDTZ/5dyQ0B6XkyMFS1Klk4rOZkaoMY6NQ8p5/eymAyIKoKX2mgWcA1f9br2J4kV1eoV5K6l7f23erM09/8Tx69UlZif6WuiLtU6vKsqF6fsLILK46rSTYbFPcrnAyFhL7V2GtuVb4BI0i6eUUVAAol/E+f4FzmsVQk+uBXVGNmU4X+Z+CHFdkFkatvyIpEVwR6jZHk6BcMGLFFgv3cEor5PDd0tHispDKaukwCVceIogDcseVlvC/G/P7G63+KcsbIi1G1YPfEVPhmac5695btGuvzIxTbi5nLMXAJRTYYH7LTDMB/KniG6Yp41nvqcEHV+OOKBtFjWpHKvA+4wquR56V88BxMXNV/xLAlqFKhjqyogSQwDdG2TaC/ojt0eqUfZEzinBNskZw0DlwRfL4Urwu6oJqSVcLKP9dVYm6zdNwX0S0DvZq01ePhsNNMVq8kScIXcZ8ebw1ZKMCQuTmYYuQQgBU8ynQ6HW7PVf5hZP1hx090Q81KNpyiH1FlxFFPP+JM7V9q0p1u+vkBvE2v3EkZIA5VtWnxKXSBe2lGIrHUPirUx9annu/d5DlDafS+dsR8Ni02vhgV8djXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I7r4KMCKzezB6B62bVwhXe7MJSXKP7s/uzXNQhMoFOr9i0raHaKiylPvizf4ekBCP9EIqt79+uMzamxSqx+U7A1O8ETrqxufLyyotTNXt+Oty4K2yoyjn0oJOHVPYCIkr/vJPr8r95Aa3+ZtdB23q/VEEfMkaKRGGkwG81U/WVWIboHbHsETLv8XWOF9ph3aNqYTr9zHDIXu5P5wKPX7uHOm8ckTO9KiyuoYKuXvE2JUZpEm7ylIrBYkIRC7iabymflrjKyg73jkVtmr7HOG/c1Dw4vX9NXPRz6trr8YRoBT9mjVt9sJIkO3die7MOEC0+VP/RZMhfECMsx0a8agOrGr/VCCKmlvzMDjw8cOmvQa6BgrKaB2Tq+D02JtLXBe2k1DwLQHe1sDGKnxbkxv18+27R+9949C1LiYJ+xhOnZTHHtBf6g2yoyaQ44Llm0q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:53:47.9167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d425dd-815e-4782-fa7f-08df04ea41a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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

The GFX12 user queue private fault woker loads
the relevnt user queue from the userq doorbell xarray.
However it does not hold the spin_lock of the xarray
when walking the xarray, and does not increase the
kref of the user queue, so it races with queue
destruction path and may run into an use-after-free
userq problem.

This commit fixes this UAF problem by utilizing
amdgpu_lookup_queue_by_doorbell helper, which
properly hoding the xarray spin lock and the kref
of the user queue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index fdfee88e41e3..b6ae15066205 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5070,9 +5070,12 @@ static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work)
 
 		doorbell = (db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
 			   CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
-		q = xa_load(&adev->userq_doorbell_xa, doorbell);
-		if (q)
+		q = amdgpu_lookup_queue_by_doorbell(&adev->userq_doorbell_xa,
+						    doorbell);
+		if (q) {
 			amdgpu_userq_start_hang_detect_work(q);
+			amdgpu_userq_put(q);
+		}
 	}
 }
 
-- 
2.53.0

