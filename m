Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DB1CA9ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 09:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5630610EFA8;
	Mon, 12 Oct 2026 09:48:15 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF2910E41B
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 09:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIwndD4oCAQgDOQNj6RaIIF5yFUYsVtK/BW5diXEb/NwfVlRq0uheZRjSmHjWYV21/HQDRcUj2il3n5BD32gGFejxAfhRfJjbImdFSsRzTvuAyfWDxQxN2L1Wg90w6V02aw4eoIu7TwuwLZ2WoVxqRmRIg67fUay3ji7JG8pUVrmsNlX9EEVIc4PtyDIrmNBLAUs0iSMPB2Ilra89hCkcjrfdbyYeT9MtMqsRrjRXJ5Shg4QF0ae2JsrSmSAHr5zEMx6laqPVcAxjrnB7MAEiii+Bffx+hmvQkenxRYb3a3eIhnHr2xnvz4YxVH2gFFbIVsPZFsn3xbYCsODilNBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E33qCaV4d9md4/MDl95J/DcxxUdGYowsAPCZkTrMhk=;
 b=snFiYDR3sw+PE6QE0lGLDB9LfBr5FLlFsi5Ls47jOvTPOIqnpH4+fuaodXgt9PM2E5xobna6UMbB+xQ9MXfa/wyQ9xxsDzRjF/My5XEFMEUzXTrCZY1zC04LRQchpGGJOLS1u0HyuUoLRlr/XNteG6fez1cEbPHnfLkJoiDGpiQ+MiktvNY2Vav2N8q8OnFfZec7S7HlcyNgTaWV1YrKzKOfAOtsIA0HHxkorada8L1qeekZ+DzgHn4vv86IGFkY85AIj5ncIrxAaaVJ2x/7waatUG/gzu99FjekSfPMsNcKy+P+SJ6e8f0wwo5XZqR8ihYo19N/hmz6Z2Jjb02qKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E33qCaV4d9md4/MDl95J/DcxxUdGYowsAPCZkTrMhk=;
 b=clniJdZM6C2lfZ3Gg3n7in8vbyxKVgmaNOwN9Bh6eeslD4FzjhYd80aqKA3wqwr5kXelaVCCYavGdPOx6wqaDjrUJBa0EiaspXZS5jtIRyHzW0JssGTL1Fo5UyLT6zHhPh74u+1Gxg9siUeV8RAmhMYeVh1zWHYkQ3OiEAf4Me4=
Received: from BY3PR10CA0011.namprd10.prod.outlook.com (2603:10b6:a03:255::16)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 09:48:05 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::9c) by BY3PR10CA0011.outlook.office365.com
 (2603:10b6:a03:255::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 09:48:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 09:48:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 04:47:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 04:47:55 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 04:47:53 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: keep the eviction fence until the last handle
 is closed
Date: Mon, 12 Oct 2026 17:47:21 +0800
Message-ID: <20261012094754.1685828-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012094754.1685828-1-Jesse.Zhang@amd.com>
References: <20261012094754.1685828-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: aff1aee1-68cb-4178-8f5e-08df2845e9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ddhpfdEile3pY9xTYXpJWmxW78nmVYQ5WWhnUt0X3y5xQ2efQ0xAA6D7gp+cLcSjlvF98cXnJCp7mD5hm+pYIbWvGuZYTp6TsIsHlLGqvQW1hSeCLenB0OaigITZbcAPULt7fbFgmmXYCuMJeQNImQ78CEZtltGtPef891azjryN8CIysPEUrbxEiXmDtVbttPiQ3BpMOKkM/iFo/OXFOj7+TDDUTPEd+qbRzHV37SkvXyFpB9w3+F8PnspkGsXie2jdCGyCn+6l/GHm5an1S+CI3EJhTvx3glTtGQvNESCmSqLxIr06/Re38iNjmDjv5UWHNR6ZluylelAArvkAfKYCqcaT0FGQbdXmyuFWsk+HMAmCkpc7PsWtJ8/fDj+rbm7jO4g7qVlpOQsGmC9N9+L1pk8s5MGa3Bv5Y1vzKe2YbEwiWBWwsTaLJjg4CN8CTdMgBdv6YcdlWR40iBVecONM0btA3fBArRQkvdkau47AE59K2WXpHlre3IujJaILf1yNZ9XQboNxAwxzLZbdQFUq4w1u3eWz0aZcMf4d+G5kKFgq26v+t0S5GFGTXYOctbSnOYwnz3phmqn3Z00GmBbKl6gh+1G5IHkqLa7M+44q65J3GznBnWCkXYhyn/btYAPjHD0Xs4SPxkz488H6QA1zaK/YjZxYIlBkWzHL7ZHNLU/LwrV/m1d3jB8T4Hp7AWa/s6J2xi4icUzOmbdu2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZYZKCDSWHv4dQcE/mHjNTSP+GRkolPDUJ+8V+KiKnGfk2NlhgHoVH0y6jrl5rvg+7d6iB7RVvarwM0AeKqxw/iRj6NdSXaRm6GYhE29+HLAFnuKB0gr0u0AhujX23cAXrAZbFeJUfB93FLXRgZIcnrGZf2VUFipEDvIl1KCuzfacd97gi4gYOFvcyyLoA/nFZDRwPdpEmlpQMhmRbdRkTRTGgnokB7YSfBnHqkYtdPyHFxnoZ48EerlAHy1ndL6cmTbu7sS+nxtqcq5OgNucL1+j8D8amMUjYJVF6nmFgFee4KD8nAKEGyOwpOSs4cMtpAnZrBYkLPTTTc53sVXsAJtBeONjlRmyMpfxB5ILJ/YtHAK6xjnqYPQjoW8wgUpYWGk2izTkjB6QKDQ90ugqFiQc+FTowxwy/piMKU5NOCgG/8CUaGkAccaXS3TQ7jNl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:48:05.1491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff1aee1-68cb-4178-8f5e-08df2845e9f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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

amdgpu_gem_object_close() detaches the user queue eviction fence from
the BO before it checks bo_va->ref_count, so closing any handle of a BO
removes the fence, even when the file still has another handle to the
BO and the bo_va with its GPU mappings stays. The BO can then be evicted
without suspending the user queues of the file, which keep accessing it
through mappings that are only marked for update.

Seen on navi31 with a SDMA user queue: a BO opened twice in the same
file (GEM_FLINK + GEM_OPEN) loses its eviction fence when the second
handle is closed (traced attach/detach of the fence):

  attach bo=ffff8c78a6c84c00
  GEM_CLOSE handle=7
  detach bo=ffff8c78a6c84c00

while handle 6 and the mapping are still in use.

Only detach the fence when the last reference to the bo_va goes away,
matching amdgpu_gem_object_open(), which attaches it only when the
bo_va is created. With this the fence stays until the file is closed.

Fixes: 31f7efcdca4d ("drm/amdgpu: enable eviction fence")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8dbd7bb77305..0552b17d9aa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -351,11 +351,14 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 			goto out_unlock;
 	}
 
+	bo_va = amdgpu_vm_bo_find(vm, bo);
+	/* the fence is attached once per bo_va, so keep it for other handles */
+	if (bo_va && --bo_va->ref_count)
+		goto out_unlock;
+
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, bo);
-
-	bo_va = amdgpu_vm_bo_find(vm, bo);
-	if (!bo_va || --bo_va->ref_count)
+	if (!bo_va)
 		goto out_unlock;
 
 	amdgpu_vm_bo_del(adev, bo_va);
-- 
2.50.1

