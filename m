Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E34CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 15:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F7710E756;
	Mon, 22 Jun 2026 15:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lU3XIZmn";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0109910E756
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 15:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhgMkyIanV1gVwp9f55YJZh0xrpgA01unxzaBIT9kMmfkLhAtSxo1BajcX1vsaNmyalQ7/J5ddwNU3dwVWhxFj6SenAZRSFB/CjS9yo6xr67008pvd76MhBxzPFTn3SEh5sUcMnrkyhFDIPS1uooImDbgb/Ph234r7U3aaKbTKKacJ9wjRWlDcyVsrvJOrqwYbm482GmvTBtGMpNC1QWJEA6UKSd+8pvWrW8q29ITl0joCIrTZKOZ2tOKPiuqhX8lSxOukdLPRPlMjvQ/f62rMMa/crLlGwibXyuA9ggde/nE1BcRh3JWxaHdIcwmSOC6BhLtvqb+AElTNESD5XCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODTb37+/L42ZchfyozLkODbpc6d+bHU++IT9Z19ORtk=;
 b=lgt7NpzC0mvsHzz3t3PG0aFENAbuV/jHheEcUsN/+pOCsfuigR4eqx9naJU+R6NqgK3FIItWBbsvLglMLnq+diKvcmD68P9ewwXzQk1WGanlLwC66JZDMtuLxEjDVNdwbJOB+9SWzS4Co7Or6J+KEGQ76AZKOkI0q+Su07zDZBVTV8ZuSkfj4OJ7f8aZCZNAYSOlCt5rmOBaerS1wZz6xo5E8iMempMO6yY3GTkl0AkSQACN82FfBK90GCSg0709yb0F54Lc442n6cncezshddUD98HR09tt8Lm3gt9r3n73c8e0NF3XCiESUUR6AkXBmzmZLXfQ5WX1P5F4rYidHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODTb37+/L42ZchfyozLkODbpc6d+bHU++IT9Z19ORtk=;
 b=lU3XIZmnj9xC73ytDh8YMSVdZNBQPi7Jq18D7RAadEryiwZTLw6UrXQK7x1tdO1s1VvLcO4x1qK59dM0V14M9vNnX6F8lLbyLe3q7iJrZG1V4Ma2TlLtjtFIBgryjOtFOamvb6xcc+N3Pvo41SYveaFL1T8IBU1jVkaAl4KT23A=
Received: from BN0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:408:e5::32)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 15:17:26 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::b) by BN0PR02CA0057.outlook.office365.com
 (2603:10b6:408:e5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 15:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 15:17:25 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 10:17:23 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix resource leak on ACP reset timeout
Date: Mon, 22 Jun 2026 23:17:15 +0800
Message-ID: <8df8e57e7a17f131ab9065b4671780378fbaeb08.1782141279.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5db799323a211d12937f69a1ba28d3c740bf2569.1782141279.git.cesun102@amd.com>
References: <5db799323a211d12937f69a1ba28d3c740bf2569.1782141279.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 10783535-ef6a-4896-7eaf-08ded0715dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: LvCSEQQqVSd8RPN8ZGzBEof/rB9s2m4fmXiCWcST6R7JvowGLfLgCy1hXNt0mkAD8+uOqVdB63QpsyrBjZn8r321/pkiiNAAaGh27d+QsfiDFNfhP0sYn62Mz6BrJtqY4k7Bpfk/gESCgHrPfrQIWUqWbT+WqAsJneLmKX6UH98WeRWLlM+T4+0OckTnEiwQJa6wCiK68kcFxPZTr5hGCgOoKif0OktD/WumvBVpf518oxNinj1ArKdQsDKqTc4bb203gBSi+PS4yT0pKd5d3AzKROA2eu6GOy4a+7VetqEs7pnIYmxMQXBIEHSR6zjxL87hfPtMBNVyksn6LDW/EwdCXFbTLVhDMfqj1U5TsYCPyZj1LzHPYG+LA6NwmgeEhUdvt0/dYqPDBDt3zw72zCJQDmOqrndK7jvAO1OMBqZDQLXVaHQ8t5oA7DhSRahaRkoLxF79JGsihCm7S5aJMhaHNkUYWvaR2iy+cemFGks+pF1vZR7B3xtRI3JwCz+SsfkyhyGGc/OBpk/eBOqvEhtO6esEUaPxw1+KVTliiovmT477b63r/bw/Y87M7LLwAbY/J7dfRklafy+ieCCnJ6/MM9RAVUXCL8J7+4WUk14uaWhECz5V6T1TEstepNlC+A+DTsAq4Hn44zb22o9WeatEihRzI6HdaLGoGTriazbgtASPkxvwq7wp54ncP60H0XucocVFEs4Da1JBJqETbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xZbNQBjgqkYGKxYkCE4rtl+tG0h/9KpzlYxZanDGbIpk74CJIyaOY1LBTrL4w1OT6K4+lFLeBsha70ktM6aAxVBOkfLeHTHZRUboSnI9d5Jrm1q5RrV5IFF285N2u39e3gyVPdz+qn1b6EP1vzFe6Ci/aFOlPN0bWF3kd59pp/HmzK6hcz6F75DOBjp9uGAPJzz1aCTL+QuWynxECozhloVDAWCDf826PFeX/e1xVOZU1Sm5MIAclZuYcrI+unjaqh0l3iH+gml4xR4BxzUmD5MXhGKwgc8OZ/7VQHYftlgOftldZuZ55zHAY72hhbpVQ2gVm/hEBK1Q16F/+VhGDSMIS8zyfYJvWZPuJ4nP1g+vrTXIccjdbAaZveHhKOD5/cuK64g4bVlNEPvMncuML9nTiFEmJmfSNfBDmkwmXvabJIsz+zDvntC7AIYMn/aT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:17:25.8374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10783535-ef6a-4896-7eaf-08ded0715dec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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

When ACP soft reset poll times out, original code returns early without cleanup,
leaking MFD child devices, genpd links and all ACP heap allocations.

Replace direct early return with goto out to force run all cleanup logic
regardless of reset success, preserve timeout error code for caller.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index b0db0834bfff..1bb931d1d2c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -510,6 +510,7 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 	u32 val = 0;
 	u32 count = 0;
 	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
 
 	/* return early if no ACP */
 	if (!adev->acp.acp_genpd) {
@@ -531,7 +532,8 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 			break;
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
-			return -ETIMEDOUT;
+			ret = -ETIMEDOUT;
+			goto out;
 		}
 		udelay(100);
 	}
@@ -552,7 +554,7 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 		}
 		udelay(100);
 	}
-
+out:
 	device_for_each_child(adev->acp.parent, NULL,
 			      acp_genpd_remove_device);
 
-- 
2.34.1

