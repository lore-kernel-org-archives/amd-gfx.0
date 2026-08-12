Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C720EC5B567
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 06:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0AF10EE46;
	Wed, 12 Aug 2026 06:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IVHDVfiI";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542F110E3CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 06:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hr0SNyraWknKuyJPe48PPExiuYXgCDpnlrSQZ0APSEA3jboYV7KtFf1t7kT5v1HeRj5fimGtMrjosQB/x2LruFAeqQ/MzLxZGrIj2psL2X/b3B+j+V7IhhO5gjL0b8gzDhs275TZ2YtdLpqYOqiut0BV/6tondqNHLH5U0DSkbdsMSgBkSBcIJCUID7EfyLA6jSe8kSXfiYtiEgf0R/YpIuoG52NWekC7q0t6VkfWgv8JF39LsTTpA395KU/b9tddLIMLBhPWNMMqlCwQV6As3z2T/oYoBccTS0sd2U7BGwwOcE52rIkYnvE+mGfOnALLrMDPZjmGpvs5RjkjqJR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+KVkXSfQ66K8v7PyvB0mftB4hppEKU7vMq7tMZR0u8=;
 b=XhPPZBASwrn8ZQQAHf/qG2nbgpJec5gD5Ka1QhZy4KJrmDShqStHufTmwNeZlztB5QuIvPT0gSlwymUqA0ge0CgCehnEllJMoRN0QZq4aEkL51+OcixqLWA+OkX0dgPpLCA539C0eO7YAF9/9b5PUWDnFQeqHEDgoAi46wq+KCVhPSmuAK3Jymbbr7JioCyy1IcEPy9Fpvzq9xAy79vRFhMFUhafhpQKIOpC2F0kX2OXfV/8XRgouX3iNeaTvIz5OdtnXyw2Zvxub/YgOlHHQ2Fw6giGwTgDbkjouPSQTuuFRsZ/lND+oCn/FgoKLcEzQY5fT4jKcmCFayW3VIyVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+KVkXSfQ66K8v7PyvB0mftB4hppEKU7vMq7tMZR0u8=;
 b=IVHDVfiIvVfM5U6Qz97KBp7DYTKXXiwLYgyL4SKpLVcBUmbzPpWw6WXWGVnlMKon4hCDDwhm5VyiM/zvk6U1SLK+sRSzNdA3Sia+28zILMRbqXA8nQ/ocwp+3hVJzqXkj6P/QJq5GGie9/2o5VpGuFIRQUfLl7Lk9p9zceTSINE=
Received: from SN7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::6)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 06:11:32 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::15) by SN7P220CA0001.outlook.office365.com
 (2603:10b6:806:123::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 06:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 06:11:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 01:11:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 01:11:31 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 01:11:28 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Shaoyun.Liu@amd.com>, <Lijo.Lazar@amd.com>, <Alexander.Deucher@amd.com>,
 <Mario.Limonciello@amd.com>, <Christian.Koenig@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH 0/1] drm/amdkfd: Fix SVM page migration hang on MES-based GPUs
Date: Wed, 12 Aug 2026 11:41:21 +0530
Message-ID: <20260812061122.435929-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 8222deea-8d4c-4d05-6e97-08def8388e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: CC6DGBxsGJUv4mIviRMa8BSbT/9md7wYVIrvPb+ZPdjAYiWH7GuY3CYWZAuWMv9yQjOAsVKqkKrlqp/BWhtGHt8t6VRkbN2YAdAF9P4QPrJBkK7PX/kjd9Be8MsOw2/rppiV1ztDchqz3w1CsU+p+GQfOV9cCvMfnSQ1QkZ1ocDfqKOCCEjElM24cIqohN9OornafN3DsXivFKLs28riiLDHfLJiSZL4QDPkR+lAgaJEgUe1gOYa4SBvPrK/KvDWYmnfGpd/jziOvEjC7nFnIWf5NgqrtiGOPi5IEaMeAgq4siEiv83c/6alIY5Xx0HecKzcpxB1mu+jvjKJlp3apwVR1rVFdASbgejcP5hShZ5NQKbtaWlP88kU3dljAFVEhRi/RcywODyaJlYOfzN+v+nQMIPhCq+sAhUf3NCf1Vj0fv+8LHlMeuozs61TmxWjn6TK0hBsP4hdd4DBMWExodXi7Nk8DifU34D2U46OA3gJEioUkCsFq8OZtETbJVNGfRG3D4F6Y/LGQJj8CYehfzd9qOCglSOo9gRc+N0+w4ZoXE1y9OValwvU/fST1YqigNo6rpnlgcarXvLmyVHkNceBB8Q14r7d4Y2XqZuMXPxU76zZ7DJoNFSAQZ9UN7EuajXg4Ro6Pvt1qUU0QB4AxMDxFBca5y91wKK45m5+pLxB0lQGruk85zNWLCZxxDnO0i82kolR4RX3tDUXWShaKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V6NXh8v95cCa75l7x6lSYRkLbRPK9XjHVKGIDkdoBG3G8jLwDTom6lzaoRTk8X7i784YC9CczpQkdklREMcGjAglLnNV5movow0LLVVu+jPy4qpGHOVIdlt6QQwOyPmG/iRmfd3NrIVEjGsria13u6JxD+7LvtIxbQZ9PdNZPEdh7S2Xypu4qd9TBpHpkdueMfEbwC5NsU1mzhTMntRRGSN8OZiH5wNV/9rwtFPGDf9VdhoYPqyWG9bO+Mr1FNqE/lRyNMWW3qq2PY7UU+wMEZ9yu3txognIMIWmvEFid/gFWa63QD2VvdJSj8uoML3LjOpRXgB815gBiPaHGIMm0MBpZOQ/b+mDwW2SWVAEo3UfD/1yCE9srFmvqMTTfwkRLzzTN0uJ+VDYCVxRbopg9RIUUaqK6G8vP7S5I9AiSOo2AlYm+mXzEahMoTYsTHy8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 06:11:31.7606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8222deea-8d4c-4d05-6e97-08def8388e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
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

This patch addresses a GPU queue hang issue during SVM (Shared Virtual
Memory) page migration on MES-based GPUs, specifically observed on
gfx1151 (Ryzen AI MAX).

Problem:
--------
KFDSVMRangeTest.MultiThreadMigrationTest/1 fails with a queue consumption
timeout when XNACK mode 1 is enabled. The GPU compute queue hangs with
packets submitted but never consumed.

Root Cause:
-----------
MES (Micro Engine Scheduler) does not perform heavy-weight TLB invalidation
after unmapping queues, unlike HWS which does this automatically. This
causes in-flight SDMA DMA descriptors to access memory that has been
unmapped, leading to page faults and queue hangs.

Fix:
----
Add kfd_flush_tlb() with TLB_FLUSH_HEAVYWEIGHT after MES removes/suspends
queues in evict_process_queues_cpsch() and suspend_queues().

Testing:
--------
Platform: gfx1151, ROCm 7.15.0, kernel 7.0.0-28-generic

Results:
  - Baseline (no fix):     100% failure (50 runs)
  - With TLB flush:        7-10% failure (100 runs)

The TLB flush significantly reduces failures from 100% to ~10%. The
residual failures require further investigation and may be addressed
in a follow-up patch.

Priya Hosur (1):
  drm/amdkfd: Add TLB flush after MES queue eviction/suspension

 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.43.0

