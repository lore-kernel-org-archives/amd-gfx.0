Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3194606A328
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nIDemnjw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B1A88E45;
	Tue, 20 Oct 2026 16:32:21 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1352788E45
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 16:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YknmgfmBkx5Dt8EZ126+ia1u+gxkHIm5ZQftr+PXrRoKVvjZj/RUnlpid3M7fGVPX/sk+o5KF9aWykG8KVdLt7CywdyHqlAWkwFtlWRzN0LoSlCqQ+WB6p+1DWRvh4HE0IyJ7G6PZWVAOndWuyPujQG9XI1+bOof0lot+wyAHgAYl+MXkCGp4xve/z1YsKVRAEE7uMzm622tNHGn/McDqVG2HSbJ1j3NPJVhB+DbVfERNcS+CWi7SmZwHM42ce4oMMpvxWSqjR+3KR6NQV1ki4G9E7b9BuHIfC6HI0tjs1OyXoor3BalYDgQ8UWhInz/OPaefCOmmabEEGiFJd13ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0HAf2VLIPQDYfKwh1JCBa5QNlpoqElyiNwlKImNGnk=;
 b=tuPdZ4sJnPIo0sEjxG1KqtQ9wF9gh0wc/K2K4OSkpuOzYUFcb8EHG+bIDy/Owu9KW8adepBZfPvpq7RFqEdcOIID/8VFOqtv9NJdIL5dV1vnUdpx3zM3YPT8RsqPV7s2RH1hQQK0XzGtcP1kRaEOdEkfe1foB64KF62cusYQJDIgaphRySeZBPjRAKec7YUw6Ut7Ut3pA8eKkHvEv1PUJHXmXNacKHaC8Qfa2hW7AKaipoTlRl8sg/sj9XCTMfKPedrlZvYNVqY86GggrwA9bzix/lmHq+c1TIqsXkNu1f13WIEaeY0f8H1hNTiGZ+bVWY548Cl3eQ73ThQiYOPGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0HAf2VLIPQDYfKwh1JCBa5QNlpoqElyiNwlKImNGnk=;
 b=nIDemnjwg6qxUgTfJUc9YJWTn0S/Oqahe+8KQI9Tg20dlHkSfIS8DydbwJP8kvYv1GOG4rgbkgoB0upD8Dxe1k7836VI+dmjLcKBDmLD1MquOZliFUI49bXA3ZCJz1fUwY7iK50CNtrRQplFuwMOVA+ADnc4I1fAT30njDEnLcs=
Received: from PH8PR20CA0017.namprd20.prod.outlook.com (2603:10b6:510:23c::17)
 by SJ5PPF2CD49510F.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 16:32:09 +0000
Received: from PH1PEPF00062F25.namprd02.prod.outlook.com
 (2603:10b6:510:23c:cafe::5c) by PH8PR20CA0017.outlook.office365.com
 (2603:10b6:510:23c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 20 Oct 2026 16:32:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH1PEPF00062F25.mail.protection.outlook.com (10.167.243.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 16:32:06 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 11:31:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Downgrade mmap lock in SVM restore work
Date: Tue, 20 Oct 2026 12:31:16 -0400
Message-ID: <20261020163116.1069749-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261020163116.1069749-1-Philip.Yang@amd.com>
References: <20261020163116.1069749-1-Philip.Yang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F25:EE_|SJ5PPF2CD49510F:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9fcf6e-0727-4cf9-6e48-08df2ec7ae0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: E0/ea2IoFr7pzT7tG35q9002EzrlKlHabgscpuRjDdzdBFfvKC/XGs/cYhX+w9BmrGRiPiBQ9mOYK6SQuy5cDuCgWhHS2xbihI6GwDxMktjl0KQH1FPkR5Geu0A6K1KuJhTf178RVwzzqX4lweYW9+b2gtrtZNditCEzreWqT0pzrMwDni2Jy2sfFBBnuQWGw/8z2sZ2xjIVQsxEf/By/RN8pNlpjWtmiH+Bp92imV6jyJv4+hz3NYwR+7gAyMloPo5JwO4c4CPWB5dJsJpzM04r2NfgZL+nrV1K5/xXX9ZhfPsFk56lGnni/9LMLQWMCN5KQhgrfFsAUtZvX7QfgeLsUjspFfSOaq6qEG3hZV5gasU0s8NB8Fg42My8ydCbT3zQfnPx2+iKWjjUqKPcwxqXbolmAPYSXjxhYGzTvN1+aDkBLQQm6toBpu98/8uPtTfpi5gidd2ZaJl2t5RX9H3ryszWa7sUKXUEJcVnnCOlFASz8XxSyfU2KMEBIQ/rzf1ZpWzCD7e0z64avQZlpBMLMLFdM+s6I9eprN/Vu9EiJsUOyV1BYM+GZRcun3Pm197T5VPuLGbu6nDQNN+foMSaLMYaIR5cob7Jet5d4b22RxE1wynGzXM/y7AjVU8K27yjjqPLe7rZsY+MCRTzKNB6NGghpaOcLtg2M0gpSE86dgCh3d4K89mNLlvG/Q95a30biEl5y5IbXrOO6uONFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H1bpOGPsJwfl1bLOrdZHsHReFFydsYu9Y2xJTYTwBj0WjaUNa8Gs1oq5aQ6yH9heA9d8kv05ZibgxD+FIokfO8Rae5BshDUofcViat0JpH//BLPBwwVYodCusxRSrZCErV1uEM1+sCqFiIC7uxzVXFUI5rG+UZjEGFjl9LEKIscvWXVk6hbXGlcMku8b7V7WK9BiBTwW9pfeNUWF+fYzikjXYD2QDKAZKkgV1KP68/r2OiOCIG66uPGD4mp+ZLjp02Lq6eDAT0chsA8dgyPh31OHW5uBnV7lZe4TdALaTRM0wkhw+Bg4Dv22BxKBy7QPmdjvQ3DXIfKkMLWVsCRJLb4RqjlMYoUqOVa8UTTlxlfh/Hl6wesTWWhfvj4Id9nG60kjEgxiMlmhi0A19HYushp8mq4N4cI3twBqsdKYM3zV99rWAnojpdZzNFNzgKT3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:32:06.2607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9fcf6e-0727-4cf9-6e48-08df2ec7ae0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F25.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

svm_range_restore_work holds the mmap write lock across the entire loop
validating and mapping every invalid range, which blocks all mmap,
munmap and page fault activity of the process, not only the KFD paths
waiting for the same locks.

Only the deferred work flush handshake in
svm_range_list_lock_and_flush_work needs the write lock.
svm_range_validate_and_map runs under the read lock, as
svm_range_set_attr already does after its mmap_write_downgrade. The
flush stays valid because svm_range_deferred_list_work takes the write
lock, so it cannot run while the read lock is held.

Downgrade the mmap lock before walking the range list.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 28b687133cf8..f63bd8cf4174 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1987,6 +1987,10 @@ static void svm_range_restore_work(struct work_struct *work)
 
 	mutex_lock(&process_info->lock);
 	svm_range_list_lock_and_flush_work(svms, mm);
+	/* Validate and map needs the read lock only, and deferred list work
+	 * takes the write lock, so the flush above stays valid.
+	 */
+	mmap_write_downgrade(mm);
 	mutex_lock(&svms->lock);
 
 	evicted_ranges = atomic_read(&svms->evicted_ranges);
@@ -2045,7 +2049,7 @@ static void svm_range_restore_work(struct work_struct *work)
 					       AMDGPU_SVM_RANGE_RESTORE_DELAY_MAX_MS);
 
 	mutex_unlock(&svms->lock);
-	mmap_write_unlock(mm);
+	mmap_read_unlock(mm);
 	mutex_unlock(&process_info->lock);
 
 	/* If validation failed, reschedule another attempt */
-- 
2.50.1

