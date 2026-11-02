Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994B606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Jmak0jAp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2E110E5C8;
	Mon,  2 Nov 2026 08:22:43 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFEED10EC09
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 08:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MM8DWNABGE8oD8cVL3/HcV6aQwSSM5jdrqsOOTD6uw2RCbnhuLavbv/XlAfQnJ/wDXIwwQkekKgFukzrqU5glIx+/egYQjOOGjKUSDAG/JzYvHU+CBWNXH1Pxxkp552Bg96HXABl5IWdNfaRcVSi0AP9WcrMYtYcUCxMUG3V2eYt5FDjESNcTNc9O9mSEoixkeZ381iUMG5mOfsCNO3FvoFGiGa2MfDAF7QEUAneqgYqMRNIRBcCRODmwSHamARRevRdttfRcSKuodRW81XGGCjqB17h+nmb89Dx4fsquDsstAWlXofQZCMMtl1nG6/K6SCso5lp0AcA8V4h/1XtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnGITz9f5BJc61UJFFcR7mqOfAqUP1q8RgOOF1chb0s=;
 b=n4u/WAVEO3dxU1jqSilmhahczDpyIKRSm12PLaaANwnXHtG7YvbxKcjRA7inhhtsb+LdCb4KYCkf34wQEr7D4PrMRV4/voTUcGI3Gjhb6CAFg9+BC9uWt4oq3tt5rDBrVkWX62bF9S0JnP/4PyqOnJTDhs6RhS0lNUEI6HKVM3BCNGCNjfaLir4WFionVN9n+Qmk6trOgys7SnVmeS7bHqlmUzzWVYfacm2sMJ6uCTypT+zBAQE2H7kIM2lxkS2U+SMf0doT6ikcQsiVayAtZcjRTNFD4Y22yEktgXu8XK/WeEE3AutUXBwpcBPDpjzFYlH4x03GAXmHeUaqB4GOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnGITz9f5BJc61UJFFcR7mqOfAqUP1q8RgOOF1chb0s=;
 b=Jmak0jApXjWRhtj3W33eJ4JFh8eoMB4/26CpqzmYcT7nX+0ySIGpVQ64ev5dqBase/7qnWl1RqXWYKMZfHINqCKWqPrfl1ayC/+OE8bQR7h79O6JOgMZVrmAGVI6zaLgCjtHOZKR2sPnniK6FIaoNf3rzGR4cJpuygfiCoKwHok=
Received: from SJ0PR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:332::7)
 by SA5PPF3C36BFCB5.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Mon, 2 Nov 2026
 08:22:33 +0000
Received: from PH5PEPF0000002B.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::a0) by SJ0PR05CA0062.outlook.office365.com
 (2603:10b6:a03:332::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 2
 Nov 2026 08:22:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002B.mail.protection.outlook.com (10.167.243.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 08:22:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 02:22:32 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 2 Nov 2026 02:22:30 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: unlock the VM and BO when attaching a KFD BO
 fails
Date: Mon, 2 Nov 2026 16:21:12 +0800
Message-ID: <20261102082228.2149111-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261102082228.2149111-1-Jesse.Zhang@amd.com>
References: <20261102082228.2149111-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002B:EE_|SA5PPF3C36BFCB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 149f8210-e572-46b2-5c15-08df38ba71c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|261022105027099003|11063799006|261021123027099003|10067099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003|56012099006;
X-Microsoft-Antispam-Message-Info: THhuuQSUv82B4ZYn1AIiL5waMjSj+akwPhMbtbAQN7EOldq5tVbjJdWhR2fm12ubK5J09uf8zysAa1bv4eOYEvHvWfC6/WcpmYsdwSUYZJCIfmWULOHXSQhsx5cZ3GDKuNxqNWLnXdUsfetj5U9yw0mJ5mYyzmdVuYW0nCMa+vJlr+xW2tLFAWpEjXVnLHzsqZb67t+dEtTOKZR+xvGWlt+39Zhrv/09FPDFiBU5/fyqOKqYayClHQJ8S1t6wIkJilN7touVxbZ3Sg0rrqbdlPqG+UR2g0+J9oQYACRXm2CxUhgB5traioTvZWATq/E/FBi/yI40clIqBPxoa19/LVChm/D89e+fHaIjaf899z3lKxcfirx13KfpS1ImKBd8IU3x5J/3AIFbgvDatqDZ8aYKUq1ydPAfQNKnTAIy/v4E6fZuIyQCEtvhUSXI2MD/J3mlYToVVYkAq17pqHT5supZOtpaa5+ow8nPqLuLC43ijxUOvTqNwvVgQRXr2EX5Ni1vYiWDtc2z32hjaCur0DuG1CQqnBGCh7AslkEe4kwjBnc5pW/PMDlJ05YDkD+Rqi/s5HgmBOqJAUBl/jYn+16fQwhD5o60dFtiI8+afiS3DEcg5fsU8I9K5Lk8M8NbuDHlHAJd+YuL9l3WfwicTUQ/jIk2FAnOi8NVaVGohrPmmEgxsbdK7gGN0ld0ifSy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(261022105027099003)(11063799006)(261021123027099003)(10067099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mEqHxHYYV1ZOcqEMh9weu6OqR3sjUAg9tZT3e5KZPqK/OjSFJfqR70uTFBRYEJOh+faS/awNUjGxheHy+9o/8DdfQNWttvbmnENfsRzNDNfixXGO6Jwo+dp3Ox17vtaiYV9U8PBrDq1iuYcmq8dEh58XfvewrBqgmeWAIdOOe5vHQnM+utWVv8/kQZCV+SoWqu8ONOJ8gFsaqr5/YqkuAusxe68TL1+pqWUqB1Soja7RDzi/KpzbnS/gHdOn/Mfu15n/JgZHAelb+O4bmpy4oClkudE60NwOwmaAPs4yb5IuNgzAfxaHz4fR25PSvKDkhEhMM8ImkiGYeWCXEtw4nfhnlPtumlyGkDQgD3tg+uKx+vX0w1lG+To2A6RvEEkX7WBfffepuVL1q8ZBPVIWbUV7FHRRqQsl3404JFRAmNolUsmWjrX9nKtCiGb8okfH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:22:33.2349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149f8210-e572-46b2-5c15-08df38ba71c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF3C36BFCB5
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

kfd_mem_attach() locks the page directory and the BO with a drm_exec
transaction on its stack, but leaves through the unwind label without
drm_exec_fini() when locking fails, e.g. when MAP_MEMORY_TO_GPU gets a
signal while the page directory or the BO is busy. Reservations already
acquired then remain locked with their ww_acquire_ctx pointing into the
expired stack frame.

With one thread doing GEM_VA map/unmap on the KFD VM and
another one mapping KFD BOs while getting SIGUSR1 every 20 us:

  BUG: KASAN: stack-out-of-bounds in __ww_mutex_lock.constprop.0+0x34f5/0x3da0
   ww_mutex_lock_interruptible+0x2f/0x150
   drm_exec_lock_obj+0x107/0x2d0 [drm_exec]
   kfd_mem_attach+0x4dd/0x1b60 [amdgpu]

and the process ends up in D state.

Finish the transaction before unwinding.

Fixes: fd1fa48b935f ("drm/amdgpu: lock both VM and BO in amdgpu_gem_object_open")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2f8a5e7d3f78..f060b206c255 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -975,11 +975,11 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			ret = amdgpu_vm_lock_pd(vm, &exec, 0);
 			drm_exec_retry_on_contention(&exec);
 			if (unlikely(ret))
-				goto unwind;
+				goto unlock;
 			ret = drm_exec_lock_obj(&exec, &bo[i]->tbo.base);
 			drm_exec_retry_on_contention(&exec);
 			if (unlikely(ret))
-				goto unwind;
+				goto unlock;
 		}
 
 		bo_va = amdgpu_vm_bo_find(vm, bo[i]);
@@ -1005,6 +1005,8 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 
 	return 0;
 
+unlock:
+	drm_exec_fini(&exec);
 unwind:
 	for (; i >= 0; i--) {
 		if (!attachment[i])
-- 
2.50.1

