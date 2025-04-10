Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7AEC369A8
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDAFA10E99C;
	Thu, 10 Apr 2025 13:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ftr8O5cB";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D042510E99D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 13:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIqm7kwBXJrRbjc0LzOgl4/37IbQCBnnOIQUFnuSzTuhvQGUisB38KFsLdSsG3je1w3omWAs/VvVLRtjmqtvVlIlPujWXkjtmGN67CDVBd4VLp16yUeR4WQCo0HN+IAzOo1uTjGK2XGDEciFr50qKt/448xUAq6jvvjLNUsPeNRBaJxzxqD03qloDRkQxC3q+4owNWrqknkTNL5eHeMre3Lk3tLgAkMs5KmXzfx47V07x/p9c+34CpqKZ+y236seHqR8Aozlk69H3baxOiKA6nPM6NKCGt4z2ymsL/0RzvxOfQJkyiEIzTX7pZwtugJ556epHp4Ycau9gLeXsBU4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuNya7Egc7n16JGql4Usp6Y5u9tusJpiuMbV8OPRGJU=;
 b=s3Bs2YaHlcJMesuQarGQjbtzvgqqE1RCCDhxa/ZqUGBIy5GM0xRd6LN4wW5DRmjDY77AXmvSFzesUBR4zP200naV8idqGGXuwM3z8PoQwtnD95GzXTp4YKRQCHuD7DXDe+d5iZ97jTB/05WsBngrrD5t44AjFawr7tb8QPXr/x9TWtc1PL3mVGfZQkR3HsQEPKgipMT8OubZr7r6mCRLTrvecfoVq6tJzNItHaOfDV5LnFvYg2lKiU3wVHLqIegyP1RQlS3a/vPLLIChGhYihYUfVwn/Xt/Mu+S9jo5Pfk/Tb1O8wLyWJeO2M6iGsuhKiq4ocMlqWmnxRZ+oXs2irA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuNya7Egc7n16JGql4Usp6Y5u9tusJpiuMbV8OPRGJU=;
 b=ftr8O5cBnEA1yVY3EL/ngbJhfBVqGE/8HBTEh3lnLfaicUMk6uSJmKIWVmiBRgnXcgNtAMf9q5xNgCABYchG4DfUMog8RSR5QBtc06F9YcDUSotwAECXo5bwQwapr4Ckfv6x7fnPPKrYr6PIY/pXEhAGPJbQPGpnqZndBfromCM=
Received: from BYAPR21CA0011.namprd21.prod.outlook.com (2603:10b6:a03:114::21)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 13:01:29 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::3) by BYAPR21CA0011.outlook.office365.com
 (2603:10b6:a03:114::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.10 via Frontend Transport; Thu,
 10 Apr 2025 13:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 13:01:28 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 08:01:26 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Zhang Hawking <Hawking.Zhang@amd.com>, "Shiwu
 Zhang" <shiwu.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Update vcn doorbell range in NBIO 7.9
Date: Thu, 10 Apr 2025 18:31:12 +0530
Message-ID: <20250410130113.2834113-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bdd5b4-8c76-4e94-044f-08dd782fcf0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUpWUE1pS01JeXBwUndnWFlVWXFJV256emFvdjE1UDE1RzJOUVFTVElNYWpI?=
 =?utf-8?B?bmlhQ0loMnRyZ01DbmU3U1hHdnJPeG4raTl4SkYwR005SnhJdHZXbU5aMDdx?=
 =?utf-8?B?ZGxJQ1dnWWhPMXE1NHdJQTJCbm9tdWQ1eUgvRWQxQnpMR0pPdXRVT2JiMnNm?=
 =?utf-8?B?dldCTDlaeWY4b1BUWlgxWGNWdCt3U3pkWFNwS1hHcitDWFlFWU1PdnlWSUFo?=
 =?utf-8?B?RWgvbUxMWDV3dzVhMmNhN0syaEJDQmltT2RCd20yOWdTRnd0Q2R5eXFXUTB6?=
 =?utf-8?B?K0svcXE4QUxBeUNHNG9RS3BqRnMzallkTTRHaXM2TWFuVkM1V3VkSVdubmwz?=
 =?utf-8?B?Q0dGL0NHVUlYRFNrLzFCb2w2b1R1K0tTNFA5aUxoNmltaFZxUjJEeTFkRFNZ?=
 =?utf-8?B?bnVLamMxdHZTOWE2dnBScFQyUTJnRnFhbWRYQTJScWpJZW1kaVg2aUUzMk5P?=
 =?utf-8?B?U2s1WXRJZk5KV2w1N1Y0Q2ZvUnIwS2p1RzJtZEh3RjVGb29uWkNVTDkzdFBI?=
 =?utf-8?B?aFdudE8zRlhGYUwxM1ZJYmhNMDRPZHNQS2ZsUFFLbUQ3U2RQaTN1QWNLb2lq?=
 =?utf-8?B?ajdpUlNvZHFTdUxFaGlLRTdRVlpOdDhOeU5sMEJwRHpBdjQ3bGl0dHFUQ3JX?=
 =?utf-8?B?N3BhdkdWR0ErMUxkazZKRmNBbEZCNjZrcjBid0I5TjluQk9MRkdJaUQ3UWt0?=
 =?utf-8?B?OFVoZHFzbllwc05DY2NyTzgvY2J6K1VKZGRaOHN3M2NxRnVZdjRQUnVJM0s0?=
 =?utf-8?B?YTBzNFAxTW9weUcrbGtTWkRvZ09KdjBKb01YWGxkbTdVN3Q0UVVGOHl3VHcr?=
 =?utf-8?B?eGF6dUgwWHBBOCszc29SNUN5Z3VlVk93VC84VmFBdGZDUy9hTWxXT1o4QWV1?=
 =?utf-8?B?RkJSWTBJU0dpNityUGZrSjhpRW5WMXZsa2NOc0NHUkh2K1RZQ2oxZEx6ZDB3?=
 =?utf-8?B?QmdPKzg2eHk5czBtb1NCL1NLQkxEanlFZHlFWlMwOEc1YW5VTm9HeFdKVjF5?=
 =?utf-8?B?blJvNVNVUHA3WGNsVlBTRDFVZWk3cTl1VGxvTU04VExBZWxKaFpjd2d3em1s?=
 =?utf-8?B?TllxaW5hN2c4NVJ0bWRWa1k2cHhiUkM5SlJxanpuWnIzaWY0NUQzQktvcFJj?=
 =?utf-8?B?bW1EQ2Y2ZjlVSEZVRGhNallkTWVOeDdKUUtZZTJKQzNXTDZlb09GQm1reUlM?=
 =?utf-8?B?M2RLSnBqalNzeEJPSE8vYWpBMzlMT3BsdHFPRWN5NlFzTGowRWo1ZTQyS01j?=
 =?utf-8?B?RVpNTW1vRmZ3U3FCVEo3N3hOUzJJcUlWa3FkSnZCRC9DRnI0UXFCaXpVd29Q?=
 =?utf-8?B?UmczenBwYVFVbjFXR2ZjK2xMenNoQ1lKR2F6SkV2Vldjb3QyUTFNQXVGQy80?=
 =?utf-8?B?OVEvU0ZHbmg2eHJWVTZhRHp4OU4yWk9SeWVPTUtYSDdkaE11WGs1WFZuVTdT?=
 =?utf-8?B?WERUcEE5V3ppOTZSN3RUMENGZFpTYmZiZG1tOG9Vd3dvNjFkdXBUV3JHLzNE?=
 =?utf-8?B?b0cyQ1ArNWFKc1FMektxT0JUQlYvcGI3NEpWTFZhNWN0Skg2dHh4UVR2NXhq?=
 =?utf-8?B?czNydmY2cUxrSkJHZnIvU09FaHoza2dSTEFyOFo1aGk4SGtzd3NWTmZSNVFy?=
 =?utf-8?B?c3UrKzJsN0dKanlrT3B4bzA4U1MwT1RTWVdDdEhRNEt5M3ZsVTkzU3hUbnJ6?=
 =?utf-8?B?eXRrSUJKWXI1ejdZZ0EyNmNvMUJKcEpQRnZMbmliN0JPb09tbUQyWlRGTVVz?=
 =?utf-8?B?TWVxNGRkTFRUYUVXV2hZd2cvMkdKQkJrOUJ5eDNzSHFBcnBoMjBEZUNrTWlw?=
 =?utf-8?B?MkVjYkNDUTV6ZVRKR3dNaGE5eEdCUWs3SXZMN2MzZTVzbHJjM1c2WjFaamg3?=
 =?utf-8?B?bUlYR0VMTFhYcWw3SUc3aEpNdjFyQjlQU3JEaklpSExnV0ZQQ2h6VjNzUDFq?=
 =?utf-8?B?OU1zQlJUdXBzeXZQK0lXSHpkeGRoOU9oNGNzYlBuZXU0SUVlT21KYmYyQmVm?=
 =?utf-8?Q?m3lO55NGPP+wDiiiyppHHuJVHayuzQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 13:01:28.7539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bdd5b4-8c76-4e94-044f-08dd782fcf0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

Increase vcn doorbell range for gfx950 to 11.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index f23cb79110d6..a376f072700d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -177,8 +177,12 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 {
 	u32 doorbell_range = 0, doorbell_ctrl = 0;
 	u32 aid_id = instance;
+	u32 range_size;
 
 	if (use_doorbell) {
+		range_size = (amdgpu_ip_version(adev, GC_HWIP, 0) ==
+						IP_VERSION(9, 5, 0)) ?
+						0xb : 0x9;
 		doorbell_range = REG_SET_FIELD(doorbell_range,
 				DOORBELL0_CTRL_ENTRY_0,
 				BIF_DOORBELL0_RANGE_OFFSET_ENTRY,
@@ -186,7 +190,7 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 		doorbell_range = REG_SET_FIELD(doorbell_range,
 				DOORBELL0_CTRL_ENTRY_0,
 				BIF_DOORBELL0_RANGE_SIZE_ENTRY,
-				0x9);
+				range_size);
 		if (aid_id)
 			doorbell_range = REG_SET_FIELD(doorbell_range,
 					DOORBELL0_CTRL_ENTRY_0,
@@ -204,7 +208,7 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 				S2A_DOORBELL_PORT1_RANGE_OFFSET, 0x4);
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_RANGE_SIZE, 0x9);
+				S2A_DOORBELL_PORT1_RANGE_SIZE, range_size);
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
 				S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE, 0x4);
-- 
2.48.1

