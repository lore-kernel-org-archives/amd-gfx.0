Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D72CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 14:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DCF10E7B4;
	Wed, 29 Oct 2025 14:09:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GJepVvmW";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BEE810E7B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 14:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyaCtCALzC3amddJUJ8wGlZMxByzJvkKdrguIRFjSxQGhZo3SLRUjobkFsNbna9ehnv5xLtPnqJLsxUuzy8q/4Kw0OUDFiQjvjKZgjcNC12d/FIYJuUpqd8lJ7lYxG8SqhOJJESdEjjuYsCLk+Y14hLtT/JOj9nxy2Kf5mJ8CNBPR6l6oS/NSqfrlZ5+PyiyO0bFSrghLv/wmyErw6IZk2gaZqTFCaDHJkYe4k6Ye7iHD62BQLuYvnXXhmyzFJcAhG8gO1MESEVYP7Weo8AnUt7HswgGCUTpLCLcoQ8BgR/OA1UqqzveNhBNO7alxEjMqhgAvrl/rNB59UztqjaXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS4PRXENoNNhiI/gZj03rsz8eUYY4IOor772QDpO1pE=;
 b=qKnKE1t4NI59/jAh9wpUpgWqc2t7RBhIu2bTLF8uboiaxvqkXF646NuYSrwJLip8lOCrWdt86OSVaZGFdjidjK2L3GhCGn9vbNiYsYAXvN9jbGfGSb49/yG9WTzbpPPT8GufkPdpveFaCoytShFyK2hqwnCtkqWcg00UewjvoC7iJjRhZm4qg9SWAOxPulV/OCU/NvwreSPzoXFccLBoSkryy4+OnHPK8a7f4l6V0OBfBf+ApEUt17wi0totEE/NVyVLd4o+NrBOJwECcBdL4gpbMHvaQ5v0xrH82J4BKuUEudw5Q/oAqNHo4/Z7IjhG2jaADqI109sBCq7DCUYdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS4PRXENoNNhiI/gZj03rsz8eUYY4IOor772QDpO1pE=;
 b=GJepVvmWvYuR2Z+i/7Q8PmsWEPWNJnkIRIKELJciQ8lykvImAssZrPEmOXU0nso9NF0KThhb2VotXwISA/x5t86XFC+Q5rUvqCGOKBuxDCfqtUgGnPF3dLTeeAedd61/TEx7lIu9lSVpPGY49p3Yoihc6N16PfgDK7w6QYdzJwY=
Received: from SA0PR11CA0029.namprd11.prod.outlook.com (2603:10b6:806:d3::34)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 14:09:07 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::7f) by SA0PR11CA0029.outlook.office365.com
 (2603:10b6:806:d3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 14:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 14:09:06 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 07:09:05 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] Revert "drm/amdkfd: Improve signal event slow path"
Date: Wed, 29 Oct 2025 10:08:19 -0400
Message-ID: <20251029140820.10930-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: d058e88d-d36f-4617-c7b0-08de16f4b8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wz0Yx92F44O0i2xkJjwQMXsof17op2yZjMPvRZJ2f7ouzPMqJF/OIRPvz+Uo?=
 =?us-ascii?Q?3m7aqOEWHK7lqcdWzeBXYhwIUoRp/jmblLbA87hwhXx2K+y0L8hp+oxcf+vn?=
 =?us-ascii?Q?SQ06zlM1VYRZyZVkOmPxK6ZwLjZgF84Gt0OwordZkOnIzAYcAtcOKMmCfYJg?=
 =?us-ascii?Q?dkfx/YKgI8mH2s8a/4mMqriTwtqDpa9nh5VtPPJdsUE24d+ey1iqc8ZASDna?=
 =?us-ascii?Q?MTfHg6YjFwvj1ibqn5TTFGcS/GpznmafMClF+YouJJc4GAdC4dyrAhbR1v4b?=
 =?us-ascii?Q?/LJSFr9cZtYJuE42lY4KlQw/TYLGBAuww87zgkZs6XspyReqX5zNnvR524T8?=
 =?us-ascii?Q?y7vCXO/w7IjJtUn4W4LSr4T4pC8Ois88Bv1ff7scthGUpfB+6fJyEV3wPrVq?=
 =?us-ascii?Q?XT+OmDWUDYd1bVt1QVknS0LgCxEWEvU61WSoQdE4ySWzY4aY2MJx5UbMi7V/?=
 =?us-ascii?Q?pf9TuhlKQIXe4qnsxhU3j0GAMtPfH3cFJ48W2Xr62UTd7X8amaPlYu9RqXUO?=
 =?us-ascii?Q?21yJ6izdLAMCxrADhhVlnWL7iZoefFVgqxRtSTSzSzyxMcph4A/jScIW6k+L?=
 =?us-ascii?Q?xbHusMqOs/JsqFtvqEc99/FgpvCOXKmNLNgx9CBxcDzH52NpqIJmm5qUm44q?=
 =?us-ascii?Q?4xhAs2Y3ci7ZXQybWpx++gsL7YzXCkHQyTuL7j8tNfwSpVYtIUYJ5584k/kh?=
 =?us-ascii?Q?HTsO+QCQcgy+Y7JHyGZM4l+TAajVOGhC9ubRBE194vKn5+VrCqmvO4fpS1EB?=
 =?us-ascii?Q?O9xCpugjyHneudZW+joRONBxWWZzzx+t6IqPKVxqn/XKbksIOKsh4HWJMaXs?=
 =?us-ascii?Q?+2mUmmjSLQKiDXVW6SyXBEmk6L/AV0LJejFR47tD1Ejwtqmx30/WicdH3bOi?=
 =?us-ascii?Q?smZfX53DkzfRamhZAD2eLjJRSkao7uyOQecgZUZvoLq9X7caxP6Ze5xrt00G?=
 =?us-ascii?Q?4fG8+1H/pjHVzRYNumY3xyHef7J1T4LhHe2zWK69Nc+CKKIN5ml3H9lZpwOS?=
 =?us-ascii?Q?ECRDz7y2FgCs2hP9IAlSDucZWA7u4f2zVU0lDYIypKuxdBuqyxys27dEgzq7?=
 =?us-ascii?Q?22Wuwnp5Zn9W5ta9V8zCevZQbbCBgXfmXWb25OgLb0FV+bAqmFZAb7geDEiS?=
 =?us-ascii?Q?EEghcJV+BNk1Y48XzCsl3+Yq2C6dZcPJSBH+Un2GOWb3brW1Bv7SRB9JLE3o?=
 =?us-ascii?Q?Va1afv493kSPOGgULDosK1B6KR+m4kI0IumGQc16feJEDbqZwHyQOARGDQgC?=
 =?us-ascii?Q?KeBFpEEk4fq9n3Odb32pATvw6CWe6OV/nHwxHazgRkzw9toS/wBnvZF/ypsm?=
 =?us-ascii?Q?4ZhZeY9i0DIPH/yEtRESbqLWyXGKqzAtEKuHRHs1NikYT6tvRjbzJe/tW0Mp?=
 =?us-ascii?Q?ba8ZfEw1kYuITtQ3Zc05cBISPzx2E+acvOFtVyT6c5tSfBO3oYALHgWc6ODA?=
 =?us-ascii?Q?hcz22JQWdUhZAv22nu87Lh34CDFO7uN/CPngb2vhPTfIgvIYVizYZWkab3U5?=
 =?us-ascii?Q?bKchVEpv2OIcqvmTC8e32lfoz/aBsQuFSocfkeijzqCbHS6Rra7ZpHkp6BBi?=
 =?us-ascii?Q?grbjey5r4zOd0gJULM8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 14:09:06.2155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d058e88d-d36f-4617-c7b0-08de16f4b8e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268
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

To fix regression report on gfx8, which requires the exhaustive search
path for signaled event.

The high CPU usage of KFD interrupt wq issus is gone after HIP/ROCr add
option to reduce HW event interrupts, safe to revert this optimization
patch now.

This reverts commit de844846f72b152119faaef1b363448dc8ea368f.
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 82905f3e54dd..5a190dd6be4e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -748,16 +748,6 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 		uint64_t *slots = page_slots(p->signal_page);
 		uint32_t id;
 
-		/*
-		 * If id is valid but slot is not signaled, GPU may signal the same event twice
-		 * before driver have chance to process the first interrupt, then signal slot is
-		 * auto-reset after set_event wakeup the user space, just drop the second event as
-		 * the application only need wakeup once.
-		 */
-		if ((valid_id_bits > 31 || (1U << valid_id_bits) >= KFD_SIGNAL_EVENT_LIMIT) &&
-		    partial_id < KFD_SIGNAL_EVENT_LIMIT && slots[partial_id] == UNSIGNALED_EVENT_SLOT)
-			goto out_unlock;
-
 		if (valid_id_bits)
 			pr_debug_ratelimited("Partial ID invalid: %u (%u valid bits)\n",
 					     partial_id, valid_id_bits);
@@ -786,7 +776,6 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 		}
 	}
 
-out_unlock:
 	rcu_read_unlock();
 	kfd_unref_process(p);
 }
-- 
2.49.0

