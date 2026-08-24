Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D888CC5DF9C
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 04:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D14110E5DF;
	Tue, 25 Aug 2026 04:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L9f/mnqo";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A098C10E112
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 04:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qf+LVAEAJJwM7XxNv0YSa9SCFS0yGwzVWvr6d+hUq9KuycYDxJpchXKhJ/eEA7wCx2HzBABads+2dOvIAwA/FXRVjzdJ8Ky5Ca/arHqqdp1RpXexTm8Vymx6IytIkAwZ7mG8ADU6FAsb2XQ3PG/fNVhFfleqagckqzz8UE4PHBb3pyurEsKIsi6V77mIZw/D27xI0Y71MHxPP002bC135xlG5XH2l1q74A5dpHfPfQz+sBUkN3I5H919NdP8bk00UDMkoTXNixdc43+Znx1JyzxeHV7OT+Iw9o2jS5Bo2+FSd5okRxmkTza5yCpmmYeKxFvY4+rR4DwmDfpge6hJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jM7lPlP866l1Efx/vcBO0MRZy1PC5kHhIWpcxZDf4w=;
 b=TCIlCxO+C7kpqNRes1+Aq9Gq/lddQ7BWkdWskQLRyB4g1IXHMsmxJvyj6A8oLPnlRqO+7mBoBxqFmOu/zeErgHF2QHuz/b4vf4P+J5aVzPIisJ3rNn62AsCjgZvk/VuW6czspEdrXpwZKF2YHwKaoYUImhzRd1E4l3kJMOjAUywV+BwvyKVCYayiaYyZtIlYhZEO0KQrN8yx8EetuLeCe20JOzKtPSf31n6rNGSCRtbA8Aug9si/6I6E/rlz/OopPspaB8SchitJBPYdef9Zahf2Ei1ZlrM5RGl6rd1kqsNSBzM+KzuLn4UomgTAd9mHpAlYcPFwzZfTzZyZ4cilvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jM7lPlP866l1Efx/vcBO0MRZy1PC5kHhIWpcxZDf4w=;
 b=L9f/mnqofFYoIJfxEf7+A82krLZhlfKtmjO7Bs4Lc/FplKAYRCMk45AuuHnmV1gMhj44/6QB0OsH8ImFxMhExPZMF7OVjb4vuiG9W3HfZSVcRYqSZaRiQ6m9cb8z9ZhvOvd05Kfn17aVaHeSLrpo3y41yuQpsMngDz0WbFrO0OY=
Received: from BN9PR03CA0873.namprd03.prod.outlook.com (2603:10b6:408:13c::8)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:23:03 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::41) by BN9PR03CA0873.outlook.office365.com
 (2603:10b6:408:13c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 04:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 04:23:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 18:30:53 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 18:30:52 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: take reset lock after halt_activities
Date: Mon, 24 Aug 2026 19:30:03 -0400
Message-ID: <20260824233040.125300-4-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824233040.125300-1-vitaly.prosyak@amd.com>
References: <20260824233040.125300-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 749fd34a-a4bd-4882-d6bb-08df02608e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sGomsZ6u1w9yvBbDoZafoZ3hPMqCpVq/G821JpruKHO/RDTNkEHPe6b3RDfO/F0sjj5EWbB8P4qWZn99Qrb0qmTCKm3h7pAxmpd749+YmCfhygu90GEwGopzom2P3IEnnOF75MEEMmVg4A8tgqOGQD/qikB1HuYRyslyUmJk03pr6KWL4GjYCd9sDh/QKXY858cNyvATV8GePN1TDUYyQIR2KNFiiU6R4YJHXGuCwqg/wMNwdZIfIleOdJ1ggtmDoYtp0uIo0vny634jubuCnt3lSq9qm1U9TZsBQN44nb9odMIl160X/wS+t2CxPxLz/LMIywrkLTe8DNKNEhniEfuFHNip+u/0lsX248v9d+VAkhCK5fMV09SMByYF1njhs9kYoR368Dv1GPmqveoPSKsE08vnBbDV2hLxE3psL/xKvbZPl4uKQLsiDplBc8UNsn7gXrL27ON8wrloTkZycwKe9/26z2b03VkRHCnaCzNZQ13RWhJWeKNMLL/LfxEAWK7/dAp9CyJjE5I6iRbj8kaLW435FIXU309ikcBhYOdE/NNnvI3Glmz+DI5tkGD714liKoHOM7u3ezBGl7bwg+E+1PbyMJZ/uAcdHMVXzXArbQ8PfvMPayfK1Hr3MFxWjfhZv9tnH0oWB4uq1cbbm0hMF4AsNOW42tH16IBwHVlPNsJaVyvcB0W60JTTBRqHhmw4sAjloKp234OIOsvZGw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c5e+WuaG94kzKDMlVeQKXy/P+3d/6n7P5dro/8apqiLOADxWvJZ0XHrposuSxrLEiZoFud7eKiBMUqrpkHFKWzaTYebLeFlMuDTqSSn79H13PFDNJrLzq0bppfIfO24Ju9PC68Y1teR9Kx81biB+aNZ6TXLLpBHxCTZgVbihRyzGIHV5qpAyW9TyDow+yaJwAZP1QRzVyXcK20ot7Ere8nnQ3ug5hYbPMsUHkalq7bwSWuNI/Yvtz9y9zKPZAj6HuqayPiP9HAYTf4DxMpoJXtZs71/SLZzfPQ68qFG9lTO/pfyvv7B6dGQCf3BJYxpJcAOGikYqYdUu9vXltTsE2CZVKy6m9cpVy7phvSYOPnpvE1qFF1L42uyd8/iNKVa1/0yiTY7romrIbj8j2E9JEtHu6TbsFxVjxRKJg7B0fJp+AtSdFabQWhx/idox0f2E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 04:23:03.1263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 749fd34a-a4bd-4882-d6bb-08df02608e0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

halt_activities() calls drm_client_dev_suspend() which takes
clientlist_mutex. The userq restore path establishes the ordering:

  clientlist_mutex -> userq_mutex -> reset_domain->sem

Taking reset_domain->sem before halt_activities() inverts
clientlist_mutex -> reset_domain->sem and triggers:

  WARNING: possible circular locking dependency detected
  kworker/u128:0 is trying to acquire lock:
    (&dev->clientlist_mutex), at: drm_client_dev_suspend+0x2d/0xf0
  but task is already holding lock:
    (&reset_domain->sem), at: amdgpu_device_lock_reset_domain+0x1c/0x30 [amdgpu]
  Chain exists of:
    &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem

Move amdgpu_device_recovery_get_reset_lock() to after halt_activities().

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d7640da9f6de..c248d589f755 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5786,19 +5786,23 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Cannot be called after locking reset domain */
 	amdgpu_ras_pre_reset(adev, &device_list);
 
-	/* We need to lock reset domain only once both for XGMI and single device */
-	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
-
 	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
 	 * accessing them
 	 */
 	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
 	amdgpu_amdkfd_clear_kfd_mapping(adev);
 
+	/* Halt activities before taking reset lock to avoid circular dependency:
+	 * halt_activities -> drm_client_dev_suspend -> dc_lock, while display
+	 * IRQ path holds dc_lock and tries to acquire reset_domain->sem.
+	 */
 	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 				      hive, need_emergency_restart);
 	if (need_emergency_restart)
 		goto skip_sched_resume;
+
+	/* Take reset lock after halt_activities to avoid AB-BA deadlock */
+	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 	/*
 	 * Must check guilty signal here since after this point all old
 	 * HW fences are force signaled.
-- 
2.54.0

