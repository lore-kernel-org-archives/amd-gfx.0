Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40E2C61CE2
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C6110E86D;
	Mon, 24 Aug 2026 22:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jGsqVNb5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013042.outbound.protection.outlook.com
 [40.93.196.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA6E10E5A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iE3EUEZlxE3xy9I28zipJ7N8hjSySMBVhBDW5sBVytBvKoIRueBuTNHz5zkkCZjVvY6LBNqqVwyyMEG6JaNsNUwL+viMRqSZFAXnXuqQCmbmZVRWcXHPr+rqfaUou/MknaMHW2OPRU/hxncPcMZcpnY8VPjEPe8pFk8197KhTWuuaYIoVynv5STEQW9LDf360QHhRGQSfG+NbI4o1UawT2oyeSQQgVIOXuv4q4G7X7vir1ksevEZFDuZA05ALSWxoNyRqAMB/03tevIGUJkJgDQu0WyIZJimZkmqjxJdh5K5z89YjrgWYE7ox+B1FzrC5l1lkV7DItIusfrC716ORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiS25AdZqjr7SITMQLHwX7ZAhoaZQepADuP3FjBb39s=;
 b=DyFlct6Q92GXDmvOsX3b00Ry0EID/mqFzzq1sailqyaEIdPyRNW1ri+f8LTUYHpTQxhOKyxSrH9/5qsef1blBD0PQOWZjAiNR73ZV8CzUT7rwGq2sxhg9BEqnMvj535smaVs+N6y1nKP/fJoSgkq/l5WhDX0FPal/xaVc6iKVipoPDqLBFnunnGk0zQ2GQ1JoGMHzLz0034IMSXA3eFNqHNw68ZtPB6xHZMCjTo2gcsGEa50rIoGErALll16IrrYxC2p9/i4FUJd/fDHlbfvDYrpCS7XPN2bkX6TgK+NW6elZFbVR/puXDYb5DLeGi+3vxSp2PC9LWfrAIB8W+CrTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiS25AdZqjr7SITMQLHwX7ZAhoaZQepADuP3FjBb39s=;
 b=jGsqVNb5aDI0qFUp2CbqVHIDX1NT1+pMehnWJZAEqzwAGgaHcGLRZSf1n15lYluupkpG/IB0D7KI1fC14AwwlY7yT4mDC5pf90vfzE1uMpBsYc7rpp+O+SMkYi6hl2XUMXohlmkuPuM2GxR7EsgnrPwvc9eRHId2U9C6WVZcZc4=
Received: from PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::29)
 by DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:19 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::d) by PH0P220CA0024.outlook.office365.com
 (2603:10b6:510:d3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/30] drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
Date: Mon, 24 Aug 2026 18:13:47 -0400
Message-ID: <20260824221352.1793542-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DS4PR12MB999075:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf47b82-019d-4d5a-c0f4-08df022d0abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ljq1UHtcmIvgw+D8U3G8iL2BaVQrgrE+FaOyo+zxICixLGP9fBRoHxNcxhV+bRpJpULNIYcjKTShSCtAoQfsKc1bEYvLrK/c1oaNLi88UpsIzLf3tTvt8a6eLPHO53VF0jn+jfxCINi89d2eOlU8hPq8fsnQVd8xPFDsGMCm7EsoZUn1RbAtzJCWQxb8sGCzjtjG3+eApCx8K29SUYtWZhcu0DHpf6clzzfJWBd7RcjHKHbC8RLyhptvktxPml55Uj9hfc++PJIxee80+QzffzTAp03BRtIwikUC/7mkhEOyfdMGZAqcwrPHr1+vi9imyNdsiaEPS7Pb0rVEDOnNd0Rs0mBWgSBbB8g0uQ4/WByGtimDDtIrOFO6JdWYR4xAJGgy5OZ86U61not8OSU/lQ4ucpPa1/H+oDSAy2qk/c+hrgDSJ/CXO94HLxmFSBjCcku15AEQJuqtCz9efccIDCMS9iZlm4CaN8Bj9A+VqPCGnizygdwJIn0+vrrht+e9DmseVfzGGWu96KAbNJdv34MO73hY96q+50L0ponBeRTHrI/7bORjFo73zCk7CnDZx2VC2CbywhlxaXJ8ZoDwCpM6EXg02f8bbY3K2FEOi5959qUUjlouWNJnFwdtcJ4bS4BLM0p8w1Y8i++ujhB3Flx50NQR8sToUXL6cYQKnblrgICQA15XrS/5unvTJXCH5rcINvRYRJ5hHD2UXloJuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WZY7Rr5mUBDHHoVf1l+mcIXYQs42ouPUF3/bTzBukfG5eOEqHijrcKu72vzNoFN2+m4jGuMn54hADXvkC9isHxt9dk2T5w0HE1m7RsnmIwe5KztsN+O7yMhvyY48EEvfnWuu55voB50X4VfAcWxoXIydQa0L5C0BCjiegc5OokVhyALPoT456BdC5MUXKjNXMZND8hOcmFnPaCj957+XbQ2ngGNy39/6N+gWIvQoL91omfnxFBrTx3qTYsCLWfwfgBCJbjo4di17CDbqRcHBpFrAL154/8iu7ZMgM/Q/k3QwGQiPYOSlSvL+r4F9sWE3gFi/6loX3Zyo1cHMfbXyrVqQhb1br/XNXE3eYNA53KZYUac0392kVEB6UzCjtgZ8LmQrKN2AGYRADx20gdIoTH7y1ncmh1hHIzo23Iu4UAREqVVmdyibkityTGvkChvh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:18.6359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf47b82-019d-4d5a-c0f4-08df022d0abb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999075
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

Use SDMA rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 889c0005fec3d..6ec5798494be1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -1061,6 +1061,8 @@ static int gmc_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
+
 	/* The sequence of these two function calls matters.*/
 	gmc_v12_0_init_golden_registers(adev);
 
-- 
2.55.0

