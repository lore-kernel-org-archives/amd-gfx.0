Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B53606A320
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0Tj4Kj1r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13F910E033;
	Mon, 23 Nov 2026 02:47:50 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F94810E033
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 02:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENw0FsIz1OKyCQIfVnUCwljkLNFXtP69qvvk8NShh7W/Rp1V066bsaB7wHUJ/LiyuoRd/OHiSFoo4cOp/Mg3tREkzYFSmf2iwEkrMI+Ml5RMBTabQYmh6r9XaBTqPPUE8dHngcBJGju3rMO9A/VNGdwgmy6WLJcV89xBlOPIvtntiBa/Avb027GD3s/vxNQcNCg8umMVBjgHn2nQhNjwFerr3VFnro3KM2eI5Xz3dHVHK3EsP08aXLeR7G72tK2fCFdnEBSaO9OS8PI76vpKqRVPm8ZcrJatw4ys+BGxgt7xvmX8r5wTq0EOy9s9k/nk9NnKjp4Azt6ToDX++vi9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YueR2rlzd+eKsob2thZ+0W/Lq0tx6gLBWSSIHJaPA3k=;
 b=Bn4otW2JoDCGtBdWo4lX9kg7rlq4C+2PuItCxOyDVqnA3RkqftTH7uhtj7e2qZ8L6AFtcw6LrHVuZ9QlT1r4nAWFNEs+S1GcX86vBGEK6mX7jN+woyqcC0pl3trpi7OLvw32IQ3UTdAVOOpC8XGzbp6vdNgj+LtKh8Ahmz8USd2WMtwb0ApZPMLb78Qyugj9GcmDlvZgBDb5qYT6N8KUZtWXyBu9by1cAyT0dQ0pk2Q/nSXMtv2Ht36jso5X/ZGhZJ3NxLmyRGBFePzbpSoPom5UuFEfZp3FHBmOZ8Fe7zlScKT7uMkgIKk9iob2h9hVN0+wFmbf+6SeTtx9LkOL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YueR2rlzd+eKsob2thZ+0W/Lq0tx6gLBWSSIHJaPA3k=;
 b=0Tj4Kj1rZ7sl2kKDCcXhbegyN4/34BzKdOC7/7xXOTGkTWCnSa+n14lg5e4aemXBBBHZVArhJJVWCmBome8TLZSfQqfFcSWk6+aD5HF+wQI2ZnQnS+GtlPNY9LzNA7pZPUgFcuJjIbVZr4cgr48bbwJttY0JkzrFMjofGdy2ARI=
Received: from CH0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:610:e4::8)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 02:47:42 +0000
Received: from DS2PEPF0000710B.namprd05.prod.outlook.com
 (2603:10b6:610:e4:cafe::1a) by CH0PR03CA0183.outlook.office365.com
 (2603:10b6:610:e4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 02:47:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF0000710B.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 02:47:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 20:47:39 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 22 Nov 2026 20:47:37 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 1/3] drm/amdkfd: don't flush the TLB of a device the
 process has no VM on
Date: Mon, 23 Nov 2026 10:47:06 +0800
Message-ID: <20261123024737.1475714-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000710B:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 001ee6c5-1fd7-4537-b465-08df490c24a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|11063799006|56012099006|261102123227099003|261021123027099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: j88BE1udcL/MAjLOyXq9HYdc1erVLlNWD12ov2iopqE4Mc+ZXT4rCUqp1OrsXIwg7i4EbdlzwiuBi6EB2Xv1N1Ftmrh1kvb8+EA0HjJcMSBKWJlERh5Ec4mVk9WtlQhgMjacTWvWiP4WK1phhnCOpjrsOt1YHbLcd9ZbDjegDXyyNH1wgVgBOodJRWznHqu6cfpnu3bWLX2YATUaUvxULxDbPug7icUKPMpOmbzCarFchs7kPxlus/AwRqdm4b2Ctfqjwt0KzV0vpyHmZRSGIH5Be17gDn4R4gMXkw3jyZfCjQ69AWZR8TmCsMZETOLHRvsLm62I+TgZJKQ1oa/46C6yp/NjY/Ir1AGWCQ0zTTPX7EqDkrUMevfJNlRJTlICexMkilVPRVroz0YXvP7dp6C8d/OuZGXxlExbRecVVZxVayf8e3lLaBh9vnCfTX0+0B09qty3NDtiT9nMNcjxEn1gYhKxOgTqzWfM2nBeFazsNOIHluFtOvRQtlflv6uYbyjXtly5jERSHjm/IzHJWy8pHkWP8XkVNY//K4q7s4TNQeOlZpROvCvoFRQyYWCagobUtD+WproXMKj4p73JHmeXPddJwZtdCePW5vaJXSGxWy5Ydz8FSQ2RgQt1D5hz6bKcWuoeXLN7A66tRW7WM1L7ptxUJXWejzdxxJZB4vYxSwC+K9j3K+WmLDysuCXAVlWRkn2CUuqegpfyTgBplQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(11063799006)(56012099006)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vk7KjRFLail25ZK+WypQoNXfURHgeMuw4QWmGUrlE6c6NnFoa3ZzxGNy68XOaLhjxKi6GkX2nVcemvB0+ZXOB973bCsb6Y/Vw0EHqoic+i9med8QNRVImIMwy6z85Kga6O2MWfoqmT49CCjLk1G9o5Na8lnL+xKJVBakyOW0/1PDD2vzyQnBUbV/z2F7a9WNNeYwHhQFUkX84DeMerQ7iRfYvJwcfd7iT2qJyoBY0+fhZuXdM39dEm9BeQXB89nligPGNObHac0NK654XoOartlEcyS9ari+TjpgaJBRDqzeXg3AYWh7J8UiXs//H+opbHuFqWyCbdBsXobarEnzAysxrc6ZVzu9yo4uhV36w4UlPQlmSin8LC9lp5GgKI1ZFH8vZAbtIL1SLHrSep24pEJAKSEbhBbVIfHoAO5PYdsrF7Mg52J9TLibDklNsw4d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 02:47:41.2157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 001ee6c5-1fd7-4537-b465-08df490c24a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000710B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A process has a PDD for every device, also the ones it never acquired a
VM on, and pdd->drm_priv of those is NULL. kfd_flush_tlb() dereferences
it unconditionally, which is how suspend_queues() oopsed before the
previous patch.

Return early from kfd_flush_tlb() when there is no VM to flush, so no
caller can oops on such a PDD.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 30797e1886d9..e84e364b4d64 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1608,7 +1608,13 @@ void kfd_signal_process_terminate_event(struct kfd_process *p);
 static inline void kfd_flush_tlb(struct kfd_process_device *pdd)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
-	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
+	struct amdgpu_vm *vm;
+
+	/* A PDD can exist before the process acquires a VM on this device. */
+	if (!pdd->drm_priv)
+		return;
+
+	vm = drm_priv_to_vm(pdd->drm_priv);
 
 	amdgpu_vm_flush_compute_tlb(adev, vm, TLB_FLUSH_HEAVYWEIGHT,
 				    pdd->dev->xcc_mask);
-- 
2.50.1

