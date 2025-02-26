Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4093EC021B2
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 01:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE5810E82F;
	Wed, 26 Feb 2025 01:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yvduw0wr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559C210E82F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 01:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSgaE6GI0NmFpcto/DBr5pQT7o3srj64BP7dU9w3jsdhMmsRL+HBc31KpTAytGdSyKKIOVdFucf6/y4vhKlKpxuVm1x4fgPqRoDalZv4JPMTx6EFPyHSyvW23jmpWA2nPTDM6mDu39qMoKTHFHWHb/5oEfatQ9atDgS64b8RntVnH7hg+NfwZrsfRnUpVC/AhqtzRt3JG/QeVCqr2zYwhILfgI/n/vi53cCkki+FX2Snj3G0NumFyk3ApwP5wPrEGwBZhUqQXcIeTi57GFcP9EIW6eLcXyIV7ESbAzKZ3a6NXXBAhozIu/+QjzryYlTlI0iF3fK/WvoNrJrqxEaqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZvKbN1Vl++3lCMW6ayjTfAJ/JQAcxfT5GYxcKGxj2o=;
 b=av40mZ0GylEPaMNC/qxluNSQ7BpjQxcQjS8Fzg18nu1HRq69hsJnAz5Z4Lu5yyOnpGmO+Rz2ym51nFmYaez7x3Xu2CctnDRObt/4hxWjWN+wxEcmIwxi5KkWqSPmPLmgX2kRBsoel7ZPPd9RtXN3aXb9Y1Hp9JeIJFCrXorv2PsGsW1jEn/JjWCEHx/MgzuhzTmE7Rwuc77d3oiq6fPaaBrqWg1fr8/ah60iDoBZxjrr1evbhNTDr/wQZkePZ6v3MtSuO5qo2gYOJkw04Y3eTyUm/HSza0T5Fg6C5PW6WkOp8oLRF9YGgbb0IOeItfapBWMhDIwczrlUs7QebqgkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZvKbN1Vl++3lCMW6ayjTfAJ/JQAcxfT5GYxcKGxj2o=;
 b=Yvduw0wr25e33446MXhc/Y+G41njpmqrU+Ut3b+dd8UmqR7ofnJMnDrv4bLo3MIuCZuErdcyavpz8TPSN6E9x3NC6BSBpZ/AH2/K00Yekplf3/DVy9eig77ZMLPc8Ix8tjOXaOpHxyZ8FKGSnSS2aQnYfzxn00ksvB3r9KWHQ9s=
Received: from CH2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:610:38::33)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::618) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 01:51:49 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::9b) by CH2PR05CA0056.outlook.office365.com
 (2603:10b6:610:38::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Wed,
 26 Feb 2025 01:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 01:51:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Feb 2025 19:51:47 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix parameter annotation in vcn_v5_0_0_is_idle
Date: Wed, 26 Feb 2025 07:21:38 +0530
Message-ID: <20250226015138.2441786-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: d80f61c1-fcd3-42f7-7760-08dd56082258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEx0RmJuZVF2Q0dKUlk5UVoxN1pkWFdxeHUwakRFdkpDUVJibzZLaFlvcFhi?=
 =?utf-8?B?VmFuZ3JmMjc2UEdZazBpbFFpMnh2dzBQZ3BDdCtwWlVIYnMrdnpZazRnanpz?=
 =?utf-8?B?SllYQjVTbGhJc1ZMemFEcThOT0U5MVBtRzJNaUdYQmlSeFd3eHUrYWZVOWkz?=
 =?utf-8?B?SVZNenl3RmdLY1hCYzRPQ0szSU1Eblhka0xwVWxFRnlnM1ByeW5nUkhManJx?=
 =?utf-8?B?SUVxN1F1OVdzdzNmRVVyZlhjSnB4cWthWXowa0RpT08wdUhFM3JkcHcxRlhZ?=
 =?utf-8?B?YTFRYUJDYS82d3BpYmhRN1Y3WGpGQ0F3azFSaDVXOTJER3VCd0x1RmIvN0FQ?=
 =?utf-8?B?ZlRBb25NSkVNSk1XWHlWaTVoZG9mbVg4TzdFbGp6WnN1R0dhMGJuWi9TUkdi?=
 =?utf-8?B?RHdlTUJmSmF0RnFZSzhKZFI0clE1S3lHOHpvQ0Z3bTVtQ0N6bWRGekEwOWkv?=
 =?utf-8?B?VWJjSUg4azRFREZiUHQrNUZIaUJCSWtSRGJtazAzZE5waVFqVDRqc2ZFOWNo?=
 =?utf-8?B?WkRqUytTNVAyMVQvNVNacjZhTnlNMVV0QUlBekVGNU0va2RYa2JjNis3VTBG?=
 =?utf-8?B?M2VnVmwwSVVMYnFBWkppVlpsb3hkRWRJWnhvSW9HRHFsVFRwekppcmdVMEJp?=
 =?utf-8?B?T3NuazRWSCtnV0o4MnYxOEJvelFqTlYwSDFaWnA4ZE5wL0pTaUtpMWRmMzJj?=
 =?utf-8?B?SWZxSGlxN2htbks2L3FOK1RXK3JvMjAreEYxNGpvNWZRS3pBMS8vL21kL2RO?=
 =?utf-8?B?dDcwNDRYV00vTDY0N1RDdU5rZjBJU29HakNrTmhoOUZJclhURVpJUDk0YTV1?=
 =?utf-8?B?WVVFdXBxSVh3VjZQSjI1MnFFMm5NUHI3RU80aTFiWHpOVmp6dHZQeFpvL1Zh?=
 =?utf-8?B?c2FUeXlhM1NqcTIycEtpSEJUaElKY3hodzU1SUMrNlJLZGNrUVRXdjF6d29h?=
 =?utf-8?B?eUNCRkZrcnBaRjhVSW5saUsyVnBZOGE1SzJoQW9GQW5vd0VoUFVFWmVnRmZC?=
 =?utf-8?B?OUw4UENOU1Rtc1Zhd3NaaWpyaFZFTTNBWDh1blRJZXh5VEdKUk5lOVVmZTcw?=
 =?utf-8?B?RzNMV0ZTTVYwa1JqQ1d2L0JmWlNWVHk4ZDBtdWVrOEIrcEJLUkdqWHl0clRL?=
 =?utf-8?B?b2ZENG5iK3RGallLeFQzYzRaVWFGcjN2dVp6UGY0MUdTSzhyUnU1Wkl6RzNl?=
 =?utf-8?B?cWttc0pzWHkxNUNnbUh3U0hBMWh5bVJDTEJkcDl5Z0NQWWtPVm1XcXhpNUNm?=
 =?utf-8?B?YzZIRmwwQ0t4b3I1cEpKTXNLSVZNVVNGQ0RyZnloVm1BcFA1SDRjb0I0M3hy?=
 =?utf-8?B?UFJPZjdPZTR5M2NHM2FPaENMVUxYaFdWV2ROeE9kTkg4VXFUN1I1cGFCSUs3?=
 =?utf-8?B?OUdBOEFzZzJLQmFuVUJHQWFCMkw1MThobEdKa0JreWJqeGpvaDh3b3h1Z3Fh?=
 =?utf-8?B?azhKYlYzcThsRTVEeldhOEw2VTVFQkpERjduYVI0T0dOYk5oOW1HRzI2dlp2?=
 =?utf-8?B?R2swNkJFd2pXZFpENVdhOFROaUlmNFgrWDMxWHM5bjNsTXBtZjFkOHpCUE9j?=
 =?utf-8?B?ZzhaRGIzaTcvblhBcEgxRGZpRi9PRzl1TVlMekdpTmtlMmxvWVFRTHdkQ0Uy?=
 =?utf-8?B?VWQyUXdiT1g4YXZhNG9wRmFkYmZSTVFqcEJHdCtmMHNZbWJmMm95QzdmYVcv?=
 =?utf-8?B?QmhWNW9lbWtMT0NIYmdmNThGSEJhWEtlVXVzNFhrdGxUVG42OS9LYWljUlNV?=
 =?utf-8?B?VW9oMU1Qd1VTR1cvSmRJRVFDM2t6dVZPdGgxTDZoaXJ2cTE2Q3UxZ1VZZ043?=
 =?utf-8?B?K3FwMVAxT0pGVWNrcTFmdEN6QlVvdkdDajN6aWxGZmxaRjc1S3NqbWlEdVhL?=
 =?utf-8?B?QStGVjBSOXJnd2tHTklld2NDdlhXYkRwYmN1MDhFellUbWIrTExFY3piQ1o0?=
 =?utf-8?B?Q0IxUzF6bGp1Z2U5bW05ZGVTdHQ5Qzc3QmwzbWwvR2dSeUZCSzdBdVZkZm9O?=
 =?utf-8?Q?orFl9Ahi4U7PybimGDLy9XLjVQ3f7s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:51:49.1491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80f61c1-fcd3-42f7-7760-08dd56082258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96
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

Update parameter description in the vcn_v5_0_0_is_idle function

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1231: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v5_0_0_is_idle'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1231: warning: Excess function parameter 'handle' description in 'vcn_v5_0_0_is_idle'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index e07b500235b5..d99d05f42f1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1223,7 +1223,7 @@ static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
 /**
  * vcn_v5_0_0_is_idle - check VCN block is idle
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: Pointer to the amdgpu_ip_block structure
  *
  * Check whether VCN block is idle
  */
-- 
2.34.1

