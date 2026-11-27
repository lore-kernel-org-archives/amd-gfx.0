Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA57606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cm5HWx2h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E0A611283F;
	Fri, 27 Nov 2026 08:29:21 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C591D10E4EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 08:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilJtk6SPZ2wzbIb1F0LXVHQ3B+jWTqiAgX5NPgA2fU3LEWrVXFnDcczfQmIErYZI3DrDbaMah+/iHp52xGH9kfrXCiJVid5KwUXoKcBz0aE4FhB6bQFvtjw/sLE/Azd+fwSxU2wVBDVQ0z4G/hq19G1cauZBpuMbjKyWO/oVcZ6gk6buQ/ACTcnc2jvhA5JhR4vNv4mD5Y/Dn+vsqi+87a/PDC2jTv0A/LSjeMtCv3BY3EijaYpXKAc53eGc62x2E7d1XvfnBGD95+gruvYj4lVhrCdwchGCOmHLGKR8GfvTTyzKtTysDyzd3BkTFnS4Km7JkXrplDyaOWeNwJ1Omg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUOmRB7FT0wdou9VSVFeEySi/XlcJNQA0advnUX/DBY=;
 b=fA+LnwYZcQVP4+J7FsWIExHbrm+zH0cHbFj7lYiJS3KOT39ravOL0yZHrdJhswU+afEHcU03+Y/ZS3m8zNvlCv0ugfN21UFNaUVRPiIK81ME/qPKyoiyjnGs2IZz5bgbTLfk/hlReMkt0e83hbyv4kOb/+FQjUPltOml7IFjzpLWHalPPBv61iXbvo2CxzJFPpyuAO9Qzo8mOA90+AqLmHmxBxnbS97uejarLN6Oue7yMD80su7UEA0LfyUoOeilAjFQ++LCL22G44QuHd16CoVU3S6gUfDQSaSVrDYJDfRJ2DI5AX+jJ3bXk5pMpZSwRjKa9ERvfX2CB0sXoDLZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUOmRB7FT0wdou9VSVFeEySi/XlcJNQA0advnUX/DBY=;
 b=cm5HWx2hp777xGaHsnr8PPZeU7EE4bPbilFmEvcjmNINVJhKXJZ97iB6BOAxpHmwPGfU6b/RSQz6kPI28NPpTCs/t0gGiftT6wcZ3F/+pgLLnRmoFvLMCSFhinw+dEBGMSHpCK+OI90DikU1tmzMrvXkZOFgHJlELuIZPzDdgg4=
Received: from CH2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:610:51::23)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:29:06 +0000
Received: from DM3PEPF000265B3.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::a4) by CH2PR15CA0013.outlook.office365.com
 (2603:10b6:610:51::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 08:29:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B3.mail.protection.outlook.com (10.167.23.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:29:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:29:05 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:29:05 -0600
Received: from rtgbeta01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Fri, 27 Nov 2026 02:29:02 -0600
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Strahinja Stamenkovic
 <strahinja.stamenkovic@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
CC: Priya Hosur <Priya.Hosur@amd.com>, Pratik Vishwakarma
 <Pratik.Vishwakarma@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: bound APU available memory by host available
 memory
Date: Fri, 27 Nov 2026 13:58:53 +0530
Message-ID: <20261127082854.112025-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127082854.112025-1-Priya.Hosur@amd.com>
References: <20261127082854.112025-1-Priya.Hosur@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B3:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d141a1-70f4-41cc-66cc-08df4c608022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|261102123227099003|56012099006|11063799006|261026121527099003|10067099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026140227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: t2l4RE8O/yMqL+KcktbifauB5TToOnHGcW1SD5GqPYPrxvom/ilg6AuMOGlR0jwM+/9M3hCVKT5nF+p0tD/loYIWPKZkYB7GAL5ok+to7PQjC5QPOFBtyisUU2XvdqOVkHVJlwmssTBzvXh/ORqfvcMiTPUn3qzgv+sDPg/emEjq0HuBYQQu4auBTpUZY1aUdox8n5zqhxog4E5IUuAFSu9EPPkW+Gd4ABv66zrzMArcLLEnsTjlkQpsApUojYu6UdGP20FBhQjmf6a/hU+DKZXq1qof1+AxzKwg0FcCPXnz0Z9lfInFNWY6kme34HslFmXRx5tatsTcVidee9PR7zHVVHP7OOCR4GiRXDcQOfiE4GhARHyTwUR5egojE//bXuOpxDwBMq7MPlTK1CWKT60QmP0rpOmvoWVGw6Tljsv6S/SWMM0ls2ZJ/2D2hVhrJIKYOO3X5EHHd6u7O7cn4pBnDoxI7AxBpoqufLdlz6GfOG3EJEPsbBnp4J/HuIqdJzI0DsLrN8g1aCNDAXvFEKNyNkiahh1UYSeOlBdW49M9jiLRrjK1WVecX50mIBFxN6q3qFIM/RpRY3onclwx/DkO4y4lfmuFoxSm9gEZ0paVtTHu6gn+DWNPYDtcs95t+fyLQwktqltyZPvriVO7bwiuJC3v5LsA+FehAvSzMd0tvP8z8TD4gyieVChyxIL+FzXDQaa+GLEfZ6BHxfJLDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(261102123227099003)(56012099006)(11063799006)(261026121527099003)(10067099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026140227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iMdh5eV1Xf7X/In1tUrAmrhVcGI8DjMJOuRzPP2y/iIoMXcG7jMUO433vB+u7PK7c+KxU+EiQtgXLTUU9bz2snuf5/SXqN+M1PQ1TdIJWltfeNXbGO4OFFNsdvsP8YwEBM25bF+n/6LoTL1eOgqCeBB6D2LWCVb3dCmDACzIBp2uW1zkLhmdPP38nwIGuIf66nfzFog84gnrfk99Kb+ermUCOZmxEwv5OVo+ybAFUP3OYi6hgOq2e+pWwAtJQeG27cphObN61O469MFSlaoslJhUEne7dUN4llvlpmyXc6elCZNGRxsVbvGbVAUEmcoXhqnfwzKxe4IjV84e7UXbx0MsNqn14WFPtncOUxDX0OH+DKDRWB+8rblWd/R47HXxrxXVonXhL5Nr2DtYw9ER6b6J7n7IpzMrgTXRvXcNFnYLAcObbEneMWKgFfKZvtOp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:29:05.9454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d141a1-70f4-41cc-66cc-08df4c608022
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
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

On APUs where the VRAM carve-out is smaller than GTT (apu_prefer_gtt),
KFD serves VRAM allocations from GTT, which is ordinary system memory.
amdgpu_amdkfd_get_available_memory() then reports the minimum of the
static KFD system limit, the TTM limit and the XCP size, each reduced
only by KFD's own allocations. Memory used by the rest of the system is
never subtracted, so AMDKFD_IOC_AVAILABLE_MEMORY, and hipMemGetInfo() on
top of it, overstates what can be allocated.

On a Ryzen AI MAX+ 395 (gfx1151, 62 GiB RAM, ttm.pages_limit 80 GiB)
with 40 GiB held by another process, hipMemGetInfo() reports 59.67 GiB
free while MemAvailable is 20.39 GiB. Applications that size buffers
from it (e.g. a KV cache) overcommit and, without swap, trigger the OOM
killer instead of failing cleanly.

Bound the reported value by si_mem_available() when apu_prefer_gtt is
set, unless no_system_mem_limit is set, which explicitly allows KFD to
overcommit system memory. si_mem_available() includes reclaimable page
cache, so this does not under-report on an idle system.

Apply the bound in amdgpu_amdkfd_get_available_memory() rather than in
__get_available_memory(), which is also used by the allocation path for
is_app_apu. Allocation limits are unchanged; only the reported value is
affected.

Co-developed-by: Strahinja Stamenkovic <strahinja.stamenkovic@amd.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a6616447abc8..0a04516e137e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1732,6 +1732,16 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 					   adev->kfd.vram_used_aligned[xcp_id]);
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 
+	/*
+	 * In GTT mode, KFD allocations are backed by ordinary system pages, so
+	 * memory used elsewhere on the host is not available to the GPU either.
+	 * KFD only tracks its own usage, so also bound the reported value by the
+	 * host's available memory. This affects reporting only, not the limits.
+	 */
+	if (adev->apu_prefer_gtt && !no_system_mem_limit)
+		available = min_t(size_t, available,
+				  (size_t)si_mem_available() << PAGE_SHIFT);
+
 	return available;
 }
 
-- 
2.43.0

