Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF02FC3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 01:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB2010E102;
	Mon, 22 Jul 2024 01:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B0fHUx/H";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B363210E102
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 01:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTGInDgg3JB19IC77RjEtXWAwiLygt1m9fmVLTyJ83hvxa7/AADlLwiWidKOP1ltJKqJ+EYqRp9WuPxPW3otu3dKZGT/jvthDjncyUUTh3SQxC4N0cxlSxslOts9cvpMqOF/lierQ5zNzfvWVPmEB1qhuTOHcM027htKcHK6l3rr8ZOTK/Tc0u90iYiIzbfyuFN24GfYLGZT1dkzaefM+COK6RTd0I0YVRXMmvqkUpMyPdY5lNeBbNrOkqpXAN4S4bQiv+jwkUUY8p7O6GI3KfzkXgKzARFtScSmMTln7SAaVVAK7vs89f/ScFlLjw6mz8UzKWeN9t+8dJEKSIHmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYSS2wD1FC0JT3VBwHPkggduXk1UMy2rl/Mwf1BHTX4=;
 b=zBplAPYaJ7i6hFMSBVPckFQM+c1vdoyURWy/C9LwNKFH7LcZjvfpEOvWnOnI/eyXs5udHYkJVstraOfWbtLySOecJq/mIPW1pwgwUK8+C//JCtbefXIyYf+9RCT7t3zkiPXbc0iRK5cK0AvJOZracquf4XmxI2gxX1tVPRw7ORwHnrHP7DDsier9e2dtbJguc8HZj400uQc7LKgiJoN9ENFI291QPfcbcFfGfpPjG7iWGta9RqHBsqaPdGc+AvH3Xugoe7p5VrlJKm287OSPkOIgW5DOm/9m9StoY1RthaJ0KphExk7ZE58pjLFxqGj8w+nQF6mRvdU2JXqrJjKr3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYSS2wD1FC0JT3VBwHPkggduXk1UMy2rl/Mwf1BHTX4=;
 b=B0fHUx/H1vVM9E37YQbgPD1gZbd2OeWvHkdpqtvDEMmkc2spFdqsG8+JpsLLmbbfuHok+fnjrMYNeAUTfIKUGIjasAl/Xih7WTBfl6tR9bVcAEL/FBejjNztnNJGjlVs73euX3155iPL+Q1yk50tBPX5Ca32lwJNNG4rhhzeKiM=
Received: from PH7PR17CA0038.namprd17.prod.outlook.com (2603:10b6:510:323::17)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 01:48:27 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::98) by PH7PR17CA0038.outlook.office365.com
 (2603:10b6:510:323::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Mon, 22 Jul 2024 01:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 01:48:26 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 21 Jul
 2024 20:48:18 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: fix ras UE error injection failure issue
Date: Mon, 22 Jul 2024 09:47:55 +0800
Message-ID: <20240722014755.1183598-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6710f900-45c4-41f9-2ab5-08dca9f060ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FxPL5Dv6xvwXhdKHuFRUisaVTjRM6vvq6e5W4R9SQ4qYPeJkM1JMFUhzEPkW?=
 =?us-ascii?Q?DEkz3/p1Gd+/sMLDK/8USm4QAPz/ejns5ivOymYGzRWMUvXyNiGIer3H/q0Z?=
 =?us-ascii?Q?x6XEfvkVuZx3hQvgLQFVUkUt42ebtiL2pN87sbCsTantcQ7UF3aed/j4cYRf?=
 =?us-ascii?Q?V3E1dlUlrCddncbhpPj/U53uSJUBxP7az6MmuRl0VcoSnEEkB2FHNPatkak0?=
 =?us-ascii?Q?UsOBgVSkc5bAd6yo+iUUK41whe8f7rh1hIzaQmRU8dAR8Pg5fWYWcr92K2jq?=
 =?us-ascii?Q?wuR/i+S/Dky3pYJRxLhWylwq1xLrXIWV9JUPuzN2gykihpxok9vNoU87pwR0?=
 =?us-ascii?Q?MU5mpPjz1NXu9EnSaQJ7+NhX21tF7yg4Enee2SPh0rA9hA8EzMI5RJWBkrN2?=
 =?us-ascii?Q?ooM6mhf8gD7ACG3fZlyWHzMcvcy5VBoKXrGX19Nulu8Us2Gm5T+qoZPGHQ4z?=
 =?us-ascii?Q?JvHvbFIHJT4MsMEtXAmQmiiudV1N6CJBvHcJvFiGgPT3L4k2N1fLaiTOXTXk?=
 =?us-ascii?Q?M1iSFD/HD8Eds46vrGF9aD8gwnAGKT9b4WSrXHD4K3xnT4RHOmkbWS+KnccK?=
 =?us-ascii?Q?5nyj91u7OXgxTrE0LIRiIsnd5wx3Hezc6jsRb7I26d9HJmq/iEzCbeMrXKVc?=
 =?us-ascii?Q?KVz4r5/UqqzdxgpZJffNVa8x9HX2inKny36lSzsc/cJbmLtzA7z3B+L+YGNS?=
 =?us-ascii?Q?la3Yyfa3Af9Fh7JpSPfQ7alPMyVzzZ+M+GJesFDCzJkvfymxanFkWAsknu6d?=
 =?us-ascii?Q?CNCUPtjV7RTmeYXnOg3THdXWztyC53qefEabxW3Sfsbo3jY7sjhUkO1EqRxY?=
 =?us-ascii?Q?C/3Jdmb6KI/RS8JVjBYPs3DvE0tJfGmgzc6MnMqRV/zS/ZSIFVJ69HXhb4Xe?=
 =?us-ascii?Q?G+HsA6FomOoLvVEvf8HMxsK9+kVFOTOG6iE41fY6G6TvSL18N6tZxcZ/Yu/L?=
 =?us-ascii?Q?i/Z5+Jb2MYxHf1kiiE4Nvc/4sEJ/qNKhcTV20arAZeACVVWZuDrQc4ZLIfyY?=
 =?us-ascii?Q?ZI/ePYRloFMGkGxpsMamjasFKGigArvCVkZia9EHLpkr7rbYNc6GeSc+agdW?=
 =?us-ascii?Q?1GRu0dozh0VFP91H6bsXM50akXYtzI67X60A3VvLJs8xp2s5gWmNzO2jpnSO?=
 =?us-ascii?Q?5QQ7wZt4CK2UKpIp+tpytOr5sJtzulQIJcLN4UlVSyVWObNJBKDLLVM9g6av?=
 =?us-ascii?Q?MZPLWd0ntWXQxE2mrRL98p9ChIVA2Q9fsxiQ5sgdx+h5cYJqQFE9cYKPvWEZ?=
 =?us-ascii?Q?tq2HHcuO+XAkgNaUEqsozEodbSz3it3Aojnt3mbaAfVCGnkLqLvvpLvRSeiB?=
 =?us-ascii?Q?vrISPaZsQeJPE9pDsU1D1U91qo/508410187jhFDtY9J3DAcAnVZALBElraY?=
 =?us-ascii?Q?+XmUbcbZQYyDt1jDMnWmibUWtNYgzv8I3cr8N+e3Qr1W6pxSBegfPfQ1bDIr?=
 =?us-ascii?Q?EuLqd8OdvdAFkMaPEzsn1XDCwD7zHNZq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 01:48:26.0043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6710f900-45c4-41f9-2ab5-08dca9f060ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
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

The ras command shared memory is allocated from
VRAM and the response status of the command
buffer will not be zero due to gpu being in
fatal error state after ras UE error injection.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e97a5e0ce208..d6aeb53563ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1630,9 +1630,7 @@ static int psp_ras_send_cmd(struct psp_context *psp,
 
 	switch (cmd) {
 	case TA_RAS_COMMAND__TRIGGER_ERROR:
-		if (ret || psp->cmd_buf_mem->resp.status)
-			ret = -EINVAL;
-		else if (out)
+		if (!ret && out)
 			memcpy(out, &ras_cmd->ras_status, sizeof(ras_cmd->ras_status));
 		break;
 	case TA_RAS_COMMAND__QUERY_ADDRESS:
-- 
2.34.1

