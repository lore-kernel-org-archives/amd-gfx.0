Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4826CA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 05:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753F810E43E;
	Fri, 12 Sep 2025 05:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uLXHu/X4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1375F10E43E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 05:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqPniZFkwkrk0wX6lWk84AYX/B+CYVasYXqvbHCWWxvyo9opUZsH3LH+cFxPW1h6WGNB3Uhpv3k01n6zXciEC5XnTLcwkxknJ9HThCna5xzvpFc/dZcT6mASiOUIRbVG4ShRr0WLhbX15UYzsIcgKs/ye4Yy1/aj0U0wak+8pY7jQ7VaSOl/w1ANFKmCJc7Sl7fTyCbzyB8dwLXhmwfM77fTPO39R9x5AV2hCLE9VFpcmfsclVc04KgWj7fWBOxIYVu/Q32jfgLrWH7ju1Lqd1Kw6fzMvBbfXDYYv4d9B7yhnBWjkD+WHBEjC6JtZd+78aksdSs2ftxTxQYynotA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mII1A0tRanhDbI1ZjERp4ah9hgCT5ItzR3FekJD+bSg=;
 b=iirCdb+EOJNhXK7v/iQQ8N/y9vTe+8rLdE4Lm/5/WureRTlx09RlD27OJaksecgHA7D4Nw0nmSwQ9gmu9Q79yexCl59oh6vKTLwmOkO/FztR4LK990hAVV2YKU6tccbD63MvQ40DceltBKStWPvagI/+Hx5OQmbZw9tgArb1dJpmtBUb2MP1IOuanYWWBmCAJwYTlD/BJEZdy50+fI5EbLhigwCMV7mH2Vj6jCqDBYPhspx++UVQAQzquaJb753tqO9Rv171CyHe587w0GRSdXacRPZ4zr0bEVkSNNMPd6IcDhX1VmcJ35yRe3Hn4u4LUOvpBVlBygwgcuygO4pD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mII1A0tRanhDbI1ZjERp4ah9hgCT5ItzR3FekJD+bSg=;
 b=uLXHu/X4nRX+fV1RYAuBRZJLqRRPGvAys3x+nqowu4t5pEOpBXHKUBaqZ3caUj9y5xUxjbELwQ667K8TOFCoxqybVbnEZTka8AfdCZsFKCPN1DHpuObnth2flqaWdhIxY7Z6HeyRaW0cOfowwkHu3VdLALMVf3cYCvrmMYqQxMU=
Received: from BN9PR03CA0700.namprd03.prod.outlook.com (2603:10b6:408:ef::15)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 05:55:35 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::53) by BN9PR03CA0700.outlook.office365.com
 (2603:10b6:408:ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 05:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Fri, 12 Sep 2025 05:55:35 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 22:55:33 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 4/9] drm/amdgpu/userq: extend userq state
Date: Fri, 12 Sep 2025 13:55:13 +0800
Message-ID: <20250912055518.2719533-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912055518.2719533-1-Prike.Liang@amd.com>
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 0246e570-5bcf-4a86-364a-08ddf1c0fe07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CV619QJ75td9OdUmMOPfPHDxKuV8EfM6QhaWpdv1l/bwyvRDbSE9OQIsfbMd?=
 =?us-ascii?Q?KvhwSpG+Krjz/NfA3aoeZq0ll7tQlExB069VG7p4YftrG8w5Ll/v9e/z//i+?=
 =?us-ascii?Q?0rDmUWhwf4CLc8lm5TDIRWwtvQGlqw8vnJzQPMkpjM9dd51TQMprYQABOKT6?=
 =?us-ascii?Q?v37lzn2XQc11AFGW9VbxT9IQNI7pE4QeZ7yz1ohQiRQokDE1pTeuJ+2RzpFV?=
 =?us-ascii?Q?D88d+oRAZZlOsxqhktCrRoxiP4CNAyCmwtG1EY1pdPAzfJBsk5eG9B7dXGKY?=
 =?us-ascii?Q?9VEry8QGAt3/tEwiykp1srx0xVUpnHzIsXLcXoVfvgLUujnyKnoAFHOPTr54?=
 =?us-ascii?Q?+3dHdCCKdX3s1FtjMvN5qEoiLH6yrJBZV5Kr0UndnarZEFHEPsr6LpNYkui3?=
 =?us-ascii?Q?xz8M6zPApvzSZH0kQWFzfJW5rPsU8+A4gwNvq5CL/xmJersfkWFdoxGxZKLA?=
 =?us-ascii?Q?xMAeZXbGtEpfmZCdbfOb9Y6Btr+G6fQ0C7FbkuI/qhYx/aAyC+dqMCqKFR6F?=
 =?us-ascii?Q?werHP87jR3ggIZga5D4/zR0anTEuRVVJzR9TAnOJfQ+wRw/iqEx5kpy5x9du?=
 =?us-ascii?Q?KYAoW6MYdowPFW/plssuyCJP6DRnLw8sQgVWmN1a7Lba3IXCqSe7J8R0mw8P?=
 =?us-ascii?Q?e36AkstbIx6N/M3ICMCa4y65X5Ro+TD2PtFuSNDRAuO10bDSl7Bs+c8q3VT+?=
 =?us-ascii?Q?9hcuVPwrJK3kZidzzzhegV625Eqhc4ABC/ruDX52Hr8koAtKXDjaDt5hVDyv?=
 =?us-ascii?Q?pM/5aEnQftMq6BoG1SQxNXp5TrYWY0yzYStnBQbVLeVfMdf6Rv0JzKywtzAZ?=
 =?us-ascii?Q?MScycUcb8CrhfnPWL9LKwhQNCgqzx/WUm+GcDFBXHskR+JmdFyICaS4cRnaA?=
 =?us-ascii?Q?zlWFoF2QGLJxs1sGG6olvBGQqXOGH0/vqwjH1bDyk5CVZgFgOohfl0tph1BG?=
 =?us-ascii?Q?qMzDov0/tbAvwW6JMYqbGAKl+hFN0kkzc+sE5Cc35Pc+ajkAtz7z9KM2LfOP?=
 =?us-ascii?Q?p4LBNF32UacHC3NKAmjMyUpwr1POpwHgIdJbGrCEOqKki7CUqrhC2zt317bR?=
 =?us-ascii?Q?KhEPLlhH96F659MlyMpf3LTDcqio3SgjLg9abmtFPfUbsOyZUHs1V6mtbuuS?=
 =?us-ascii?Q?qq9KavnfGI5WuyW6Rcg2VbC/hgjyEaqZ+7aavaHeum2eaQxePJARukA3+mEv?=
 =?us-ascii?Q?StxiYpFIXgBRDNZb6ExUbgTZXcBCqWz8pD8Z09lA4AcbX+XMC5JqOr5y9FMp?=
 =?us-ascii?Q?gv6ZfiAzcecjfh9nZw+97fuQTiOwO/5aDTBPFT79uLQkuM0Z3GSdDIz8kJ1c?=
 =?us-ascii?Q?Pe2vPnkT4QpZulxfswCab5jvXXCVCzWxx2gOA9DS0Jjna46Zkb7fY73keowo?=
 =?us-ascii?Q?SJ50pwNLll5GkPEoEuVR4ml58tDDvkXGcHS1hhVQY7hBAK2rW3G1Rgx/nDH5?=
 =?us-ascii?Q?E0IvYQYccbM0d7qgpMERe0YdyjV7WvVOocbOulSsxHyHmhFs/glMfmO9fKCD?=
 =?us-ascii?Q?9j2o7MemH0DfC5UuMjdVItN5XfJp/Tym8qX4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:55:35.3967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0246e570-5bcf-4a86-364a-08ddf1c0fe07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305
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

Extend the userq state for identifying the
userq invalid cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 83f0ecdaa0b7..ba7be4db5a01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -576,6 +576,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 2260b1fb8a22..33a582200dda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -37,6 +37,7 @@ enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_MAPPED,
 	AMDGPU_USERQ_STATE_PREEMPTED,
 	AMDGPU_USERQ_STATE_HUNG,
+	AMDGPU_USERQ_STATE_INVALID_VA,
 };
 
 struct amdgpu_mqd_prop;
-- 
2.34.1

