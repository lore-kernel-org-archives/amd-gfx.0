Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ACC606A32F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3ttbEjoO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378BD10FF71;
	Wed, 18 Nov 2026 18:53:16 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50E510FF69
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJtEneUykno1ATaE18Jk8vm3h7s98EL3p5gugreaHpeYok5RtvSN/IDiwsLjXC5p0PrcHKDXiP+fUxpeda8XP6H1N0cQeyhEUqy5+woKP8cctBkzX2gHeawNH06kNrfef6PtRo4OyFstwoa2z2dxAjM3/wq9BKtVbknPuinfZL0KKslPRketdW6/10lLMaRgjgl2ffBLW4ATitmHAROR8PzJBoDRXhXHlhS2mHvdiULUxWNKowm7+m2AwZfTC9OUBXIL8nJNfkUMU637z8v+1N/J2jxFEHxrA2XsFyHUqZvsukmjrVXbS+tiCzYEyKXhNhHdxo7rKuyivXTc6sISEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtLmSHFJOH2ltWPUotecwnQpB6wu6c6Q49rko+/EEtE=;
 b=ikPQ4fete5qRKs7drZw5vTfyS3NbrSctIhVVaIP6Wck3ApMXzuKjXnc0vWKB7mo0RjFTlE+WgocLqg+s6cQj/nl43XMJsCY6mN9eKLUupgRpJQ7s+X+P0Oc/P+WT4CgUOvQmr7fgUSRGz30NkWhRE6dkHkNvjeGfuwgOyde4AOR1XEz4NiPVQHjD8JmFFTpOS7dVSU7EHd4lIlEEaFE2x9taCBJYgaVFG2YV4qFaQDg0ls+y+BDL7HigIp9gYiP9SRqjEtBQZkOWsuVQP0mXjO7NP/rRhDw5hPdWlptBCQ/v4kkF4CDxi7y9FjI7BKqvkXv8N11Yh0e9AqTS1X5d5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtLmSHFJOH2ltWPUotecwnQpB6wu6c6Q49rko+/EEtE=;
 b=3ttbEjoOmroUrIJj5TYsT8pQGd5rqJdBVMP1/9vxEuAb5IixZqMALIHic4UoKCu3s1v/KymIBtfeDBfl77hCFGQ36KaYlPr2RvK2OGiwNb2bCyu2XAwS5vCQMp6nADzJko36YtlR8dAsBqlzhpy2mFQ1DG2rWBgAvsfgnY7mw28=
Received: from CH2PR15CA0028.namprd15.prod.outlook.com (2603:10b6:610:51::38)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::987) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:52:41 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::65) by CH2PR15CA0028.outlook.office365.com
 (2603:10b6:610:51::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 18:52:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:52:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:40 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:40 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 12:52:39 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 3/8] drm/amdgpu/vm: reserve AMDGPU_VM_UPDATE_FENCES for
 handle_fault
Date: Wed, 18 Nov 2026 13:52:20 -0500
Message-ID: <20261118185225.1857845-4-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118185225.1857845-1-benjamin.cheng@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 727bc447-716f-4dc6-4727-08df45a51f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18002099003|261009223027099003|261026140227099003|261022105027099003|11063799006|56012099006|10067099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: ydKMSZ1yg11um7FJzShLDL/mMwpGWCKddzdAHAAf9rl4ajySVLXq8+g1wvNBCsRIttqrWcDqTXIvqzW+Ok36Kn73IIGTx5YZm/bMu0GoRvR8SOZ1qqLc1nfBz9wfJQLuuaF4jhJ/6aJWnBSSmb2stPMSrsY0Dg+wwC2t84p1OVyh6S+/ykfAw1UrcMEMChmmnqB/Fc1FRl33JtqPwAu+pZRwSElZfO48an4KTZibidvHSSyptJty6pwn9AW6RiA/zCqMBO/hcpRjt+4T0ylWICGw7YEuoYIO4EhHGzXz81G365bTm9+1oDG6ftpyrLuz0hGf6+6xgPsML3KGqKDRJV50kV8w91FCTwYPbH5UEAq28QW1n7dlOBeKDoJKNUCHMMjT2wpvtM8lO5dSXkORRAGR/4Gt8yhBREej0E6Yg7yKBDabBpAuYArDRSgSlC2Hw3s61PF/mG81VD3mP1i/6aLLjq+4ypfU2IMHN0ogVHnecK9Y5/AK95cHm2CUH3lKblGLzFliurwFnlgmKGVwSKJjmU02XsXQZry/Exr818xCKFDsn3rdCiGvc3ZFIekuclrzAVOEG3Org3gmLW9gjCzEupHGgsHZ7700YRgguTWFjQNR4So4qvNQRooRQz9SkQpYS6WjC7X2ZEQJzpjBXD43CgAtdoc6QWMADJJrBCIieIjPMmBcBFu/JbGewtXc5Wy6rz1OEc8kuuPBEZIXeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(261009223027099003)(261026140227099003)(261022105027099003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pYBhwG7/bY989JWBFnopUb4Pp0qgmKhNVOJx9PZ/2pfWr86ZvXZZSBX0KlBS4aK3sM2iUqWgFST6DPo/+DTl0NxR9GXOBrIiiyyYKHxGfs+iOqN2YIULSi8cNTahwSUiaLDMDzifwKLR1nBT+OjRoYp1uerhsXznUlJa3ng+xwLhXimITH9T9ukbrZJimxlZA3FWvp39lTGjCl/9vX0PaZye1eKUomKVeW1hWj6mXwWmPRWplsLYWtU6pf6iesxr1tLYoUd3FpEbCoEbbIir9YXLZOQI6lukZjZ23p+ePcyQhn4Ulrg6ycFQwizEttm09HCeWgQ3+GqLWehPWoQga49n9mDM6Kj+aWOww4SIhwuB2KN8ynpuEno8zzlQjgn+E0UW5a+QxWbsPZO0Le3/roba6fRkkIT5pB9NETbRe7EN+An3qy5/OTtYAkFk9SLk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:52:40.7100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727bc447-716f-4dc6-4727-08df45a51f58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF
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

Reserving 1 hasn't been enough here for a while (last_unlocked was never
considered originally).

Fixes: 2b665c3735b3 ("drm/amdgpu: reserve fence slot to update page table")
Fixes: d8a3f0a0348d ("drm/amdgpu: implement TLB flush fence")
Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6d8d639e5986..f4a836594e7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3186,7 +3186,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		value = 0;
 	}
 
-	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, AMDGPU_VM_UPDATE_FENCES);
 	if (r) {
 		pr_debug("failed %d to reserve fence slot\n", r);
 		goto error_unlock;
-- 
2.56.1

