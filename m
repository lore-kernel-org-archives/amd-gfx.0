Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6278C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FAC510E108;
	Thu, 22 May 2025 21:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nwgS4t0Z";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2CB310E72D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5UFsQXy+Dw6dToe8UtzYULSb4GLifHri0WPgVAlOz3nrc34+z422DLr6W7UplNRAsM4pwbRXu/223EJCN51Mh+vYVveZCLrfwbmFS04aqVmt9Kv8a732hMWHX2RN1Ai7Bo/1bPItmOrpLkRzU/1YhkzOeTVFxleNH05GSUHqlRiNdNKOHtelFhyu9zjzFlu8VX7N9woAVb4zJvi4VcBx1sUmkktt+CldqYfiLZssGc2HiH5vIRzRVlDUQtS5GwnR+Q5BLzHGr23JrAlHBVNvElGOuTbtDhBx9e3h8MeudCNyJMzkJZSqSjvwYBBUSqj4+WRyMWToZQj4rZ8vvuPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8oaM0mFXm8kS2tPRDFNhJiJGjQ2ZT5RK98zUzpsbOU=;
 b=kBsGgnqp6stSV+EKqMiSsQIKrxl8uJnPWszPl1vnv3wBIMq4y8+KvHQyb//iuoimf6qey06gLWzqgUTg2oYGJ9YYN42s3RftBPASwb/KspqHFxqpUNz4w2INQPJ3hTeUia/ttMARlbPubDpmsMKa3m/pQNRT3VzgsEkEYDTtbYHqDRGOEYhYgmKF4YKkTBxhN4fYLUsWRbJ/WR+JVrrAItM2D+rb2xpXeTmfptW+UIalMUQAOWlpPP7U78ttjhMfySDfViRvIU5o45NOj8/OVxk/Z0Sqb/9rcSeN+iRn4W5ZBtm7DuVVsx+WdKAsyBcgK3bvBfxBRWwCCir+BJus5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8oaM0mFXm8kS2tPRDFNhJiJGjQ2ZT5RK98zUzpsbOU=;
 b=nwgS4t0Z4Wy4Ny/G4Zi1qL41lRDtsMmh5YRSDVFrUCIAIOZFiHEy8dPJSZIPrYIMNx7ki1vpP3XvDcRPLAjcCWnhOqoIJ0k61K6EsLuYJEyOWxQ1eUfd6GNuFAXnlrI9dCBur5W8cPBad76dmiZRHoYxz9vGZqJetScFbeO92lw=
Received: from MN0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:208:530::6)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 21:56:14 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::e5) by MN0PR02CA0003.outlook.office365.com
 (2603:10b6:208:530::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 21:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:56:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:56:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/10] Revert "drm/amd/amdgpu: add pipe1 hardware support"
Date: Thu, 22 May 2025 17:55:50 -0400
Message-ID: <20250522215559.14677-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522215559.14677-1-alexander.deucher@amd.com>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c17478-31c2-4701-7067-08dd997b78b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHRvM1ZLQWlSSGNsc1FMNTRUM0Qxcy85MjNISGVTRWxoWnF4eTFrK0ZTaHlP?=
 =?utf-8?B?ajJGaTZyTHVEN0dSYnRiVjFZRlZJZCtjbHdBSStFVjJhUWVoRkQwYkdPMzJQ?=
 =?utf-8?B?Wk5kQ0FCVGNKZHNnLzM5TkNXajNqdzcwYWtiTXZ5WXdJY3E2VVQ1YlhjU2o1?=
 =?utf-8?B?YUdpYUVZdHlNMTNxOGlMSHNLOVpKRzZxLzNSS1dLVURRUEcrYXp1Unk0V2s2?=
 =?utf-8?B?MkZPZWtyNUh2VGFkT2VwMTlVUzREYXhkZFZ2eklaSWxhd1ZMSEdWbllKejdn?=
 =?utf-8?B?YnNBTWN5VWZSdUMzWVdvOEhaZHFTSFVtUFJxSkJhbU11ZHlBVkFjVWRxVjA0?=
 =?utf-8?B?MFY4c0dQeTg0bFAwUWJHMU1jeWxRNm4vOUwyU1J4amhjVitSNHU5cjhvai9O?=
 =?utf-8?B?MmRrTnhGRWFqQnNoc3F2UWJxY1dHblh1VldwWUxxM0dLU3hVWmlJaElkVlBp?=
 =?utf-8?B?MFJGaVR1RVBnZTdiS1FZMUtSV3hsUXF3YkxYQkgrdFI0SFZkandlRDB1SGZQ?=
 =?utf-8?B?ZGYyVkFhUTB6RnhKUEh1cy9tMytyamNlUFJIcU1rbTIreVFPMTdPb2taOUpn?=
 =?utf-8?B?dFVJQm5nbGZUVG80dVpLRWs0ckMzUkN5cHE2MlhDRkpKMVdwNFJOdlA2S1d2?=
 =?utf-8?B?alE5SCtFeXhBQlhKTE96cEFwUmlKZmduV0JiVXZwbzBacTUxbE5RTHQ2Vk1a?=
 =?utf-8?B?SVJrWHptQStYdmxPL3NiMmxSK1lTVnVnbWhIREw3WmJtZmdqWlJvVEgvbllZ?=
 =?utf-8?B?aG43WEdxdWZuQitJWkY2QXQ2aG9nWUhjK09abXJ4UmV6VS96Kzhva1YvRDJP?=
 =?utf-8?B?OXpzNjlDQ3VpNy9QNlY3aFBNVW5sdHNWdDFlcndpejVhUE1Fa29KcmlZVkdx?=
 =?utf-8?B?VDVmd0ZJbTRhTDFEWStFSWJuekNGOVhreERBWHdsMnNJaW5HQVF1YTNWRXpm?=
 =?utf-8?B?K0NQcWp0dU12MU1SU3JFaDljakR4dXdVckVRWDA5Y1kvc0UrUFA2RDlUOXZX?=
 =?utf-8?B?YXlxNFNvMWo0b0ovQUpQNERpdEpiZjIrUm16YUtZUjEwbC9yT21RUEM5M2NN?=
 =?utf-8?B?dDdwNG81Q2M1eHQ4bEU4SmxUeWJsSUMxRjN1c3kyWTdnSkhJZlZNdENwLzky?=
 =?utf-8?B?WGlQRHhvQjZucUw1TUh1d2IxYkZ4Ym5rSGhrdGxBN0hLOUdSM0NFREZFREJm?=
 =?utf-8?B?Nlo5VitkOWhWZlI5aGVNbXFNak5ENjd3TWJGaGtXK2hWMHIvNGtxRUhUemtN?=
 =?utf-8?B?TVQxQUV3RXVDTDNwdmpJQVVWcGlJNUZxWmxGSjI4WFprckp0elRuT3NRMk5y?=
 =?utf-8?B?VVhMdEdyWkJRWTc5Wmtlb1pwRlpvMXZKV0w0MmtvS0xCeGJSZVFyYmczL2ZI?=
 =?utf-8?B?YkVNTXZLM2YxY09xTmZiL3BwL0tTQXZkRmRzbW4xdUxnRDBQZ2JHWnZYVzFo?=
 =?utf-8?B?NVZxRjYxd1VsSVRiaVZwVjJDYWQweDJaTko1VnpITnRpWjlSVGE1RksrQ04r?=
 =?utf-8?B?UmRMUnlQRVVoMG5UMTF1SWttc3RtZjQ2RlBueEl2RVZDMHZvL0RtVmNsNmJi?=
 =?utf-8?B?MzlBbndHNVFsNlVNMWtqRk1nSW1TbXVJeW9VSDZmNVdYek5oRFJ5OG5FSUZh?=
 =?utf-8?B?aFNkTFMwblFzVXBBdjJTazI2a0FKZG5BVlRTb2x3RkVkSGp1aVVTU2NCS1cw?=
 =?utf-8?B?MTlKUU52K2c0RVRYTi9vSFpTSit1ZThLdmRaZHZMZkFCL01IQWJXQXFmYnpZ?=
 =?utf-8?B?azh2dEJwMVlYUWdxK01qakVjVjdOMklEL1Bjem9YMy9lNy81UVQ3T0RzQTlM?=
 =?utf-8?B?bDkxcXpsemxycWxJNlAyNzYxWURyNHNjRTJNZDcwUm9wRFJaQXdBdkNCVkdt?=
 =?utf-8?B?bVRseHpJSno3ZUd1dldGRmpraWh3Rk5vZTYyeG9XVUJBK0x4cTVxSnVTMEs0?=
 =?utf-8?B?SUhieDNkeUVtVkN3blBBMWE2emRuanRIMERKTGY4TG1CVGpEbnFKK2lOKzEz?=
 =?utf-8?B?WTQzUXVTMWpnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:56:14.1512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c17478-31c2-4701-7067-08dd997b78b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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

This reverts commit b7a1a0ef12b81957584fef7b61e2d5ec049c7209.

A user reported stuttering under heavy gfx load with this commit.
I suspect it's due to the fact that the gfx contexts are shared
between the pipes so if there is alot of load on one pipe, we could
end up stalling waiting for a context.

On top of that, disabling the second pipe may fix the reliability
of vmid resets.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3519
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb5..14cbd1f08eb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4781,7 +4781,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 2;
+		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 2;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.49.0

