Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06317C369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 15:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ADDC10E14F;
	Thu, 17 Apr 2025 15:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Wv7+Juw";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204E510E14F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 15:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrIKWuSw//fuD1Hewt3fluomdBpEfqEic60yH9ZE2WPx22pxFE7TWB1K9tBTjASuce3DTG4MKXemvi7XDsblt9WgoR0zTdge3zMD5z0O92EIl2Ft65bRLu2spkRM5lsEGLhZJvpHckvTEtLObabPmgCBelBmBDqzUII3PyqVa5nQMhvDnqneYW31J5XOTwzcJ7zLuP+0jm+Qt+bNwOYyNZ10DEEgoxa4fX9XR1uyAa/ustEoblC1cj52TwW3AUQfk7lJjTZfEGifMJWFr7BU8GjfmOwc5tRm7NNPmer//M8czjowL8n6laio0I1uL4F8ReXpMlCZtLY1M4QgetlZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pupVnf5CDhORNPbZRQKr3I6cVab+Soc4iJUMuPZo7Fs=;
 b=j1rAn3ciAePTnrgKvrZRQFJkhWMnaHgmrzys/vdJC47DP2TP9wBOh12cwpu9631QAKaobK0O5LutnYUHjGtggyZ3J97vnjzO3MhfKhRq9545jGvEugVoIp74dJg5n35y+6FJ0oDjXSTuGhiBf7mQ9F9aqFWNQhdfIO+KKzOkrs1T27s4QUNnfBEMJpmCCcGV88zgKuC9eYibnNkQzHHM5fl2yZumcouFBoG6H7k1X0nI5lgfVqgmd657jXRFmYKCsOGQw4R3SzRNLFYMg3BUN2yuWU00j8RhMD7MNG3v5cyzZPZxw0qkU3dt5bux9tr2Z4Ks+oqwBbPKj07eLzUENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pupVnf5CDhORNPbZRQKr3I6cVab+Soc4iJUMuPZo7Fs=;
 b=0Wv7+JuwMzBAokeZYqj8q5KbLyr+wli+p75ZVOahFMOf+y3ALVAeIGCeOTO5pBaYJEnw3RSddV65MEJ7jylkN0XNVl4crE49hIT06LZUbFVthh+YQA9E59JOFTXa5N+OCzDO1ly7w9JlJEz2l9sSrz1GuLoXve0XcLEHGOcD76g=
Received: from MW4PR04CA0194.namprd04.prod.outlook.com (2603:10b6:303:86::19)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Thu, 17 Apr
 2025 15:44:36 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::7) by MW4PR04CA0194.outlook.office365.com
 (2603:10b6:303:86::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Thu,
 17 Apr 2025 15:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 15:44:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Apr 2025 10:44:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Refine Cleaner Shader MEC firmware version for
 GFX10.1.x GPUs
Date: Thu, 17 Apr 2025 21:14:21 +0530
Message-ID: <20250417154421.3752158-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aaba0d2-02d0-419e-c5c6-08dd7dc6c19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjU4bDlyVU9aUTNhZlMyckV4MkIxTFN3OURCei9nQVBBbFR2QnFuamtubmNJ?=
 =?utf-8?B?Yktsa2xQSmIzeWhIangrOS81cWwvUFNKOFBYM1Y1aitXN0x6VXlvVTQwZnNr?=
 =?utf-8?B?cFB4RndiR2RINnVta29ERjhxTEd4SThFTVU3V0ZXK1JNTndBVW1BVXdBOTVk?=
 =?utf-8?B?Rll6eklLbEl2UkRET1VZT0dhb2NxSWNYN1dBZG5hQ1BrQ29tWE15NVNNLytk?=
 =?utf-8?B?b1dReTY1MnE2L3V3Z1F0R0VTODBFb0g0dXJjaUtYTU9ReEJrbGdVVUd5aEJC?=
 =?utf-8?B?dnFxN0wzNkNhSTFSVUd3SDNvbzlTVXZZRzRHRXcyM0tzQ3NKd3hnblRsOHNG?=
 =?utf-8?B?bTAvZjhQZ0M2VnBCY2NWOGEyK1c3SlpQZzVOQkJXa3I4SGhxVXlpZE9ldWdT?=
 =?utf-8?B?dVYvSnJyRzZQWElFY3pKdTB1N2NINmVOMm9tNS8wb25JK2xmUkRadGhVMEF0?=
 =?utf-8?B?MEFlQ1laclRyNTllMGZYWTlBY2p4NDhQMUtodjAzN1MycHpwTlNFWS9iVDI0?=
 =?utf-8?B?VHZwYi9rTzJza1NJenJvZXJVYTdvY2pQMzQ2OVNIdFkxeU14UnlvRkJPRGZa?=
 =?utf-8?B?WUV1M0lUdG5idlVxM1g2dEZvdTAyekJKTStuSXFNWDlMa09McmJTRWUvOGly?=
 =?utf-8?B?cnBNei9FdVg4dDgvczFaRzRWM3RYMW9HNmZ5T2ZvQmJCTFN2ZTQyRWYvaHZh?=
 =?utf-8?B?MDROYzNrNFFDZ1ZxNXEyR3B1M2hlNUI0YUxjMEExR3V3NENhUDBiVmVvSUFQ?=
 =?utf-8?B?QVRrQy9ubkdFVXRrNCtKYUgvTGR1aStqV2NpeVNJQ3VmWlYvNVFGbzFHK3Ey?=
 =?utf-8?B?aGlWa2lNaGl5cDQxc3VqY1VRdU5INksycGhzb2tTRGdEaUZlc0x2cVd4aVlr?=
 =?utf-8?B?SUZISXNKNnZmcFptc28zWGdzQVhab0UxMmxxMDRVNFJYSjBZQU8vNnd6Y3V5?=
 =?utf-8?B?WlNkZmJzTy9sV2Jva1RBY2pnM0Q0eXVnaHZDam51NU9uaFh1clNWSTZ4dW1Q?=
 =?utf-8?B?SGFCakMrazFuMXlORmd6a2ZpdmwzQmhoS1lLM0RlVlozVnZTWSt2WEZENHJM?=
 =?utf-8?B?d2hDTFRBL1YwNGk4RG9BY0NIZ0JVOGZFK0Vjay96QU5SNllDM0R2RngyektN?=
 =?utf-8?B?M2xVVkdsQjB6bmNMdDRhN2RERGs3UXMwMnBnbk5rRFdzUnVjSkhKc2ZpOVpJ?=
 =?utf-8?B?b3dpRjR6UGFKUWYzaDJneThwbk83YXVPR1Z5ZGIzLzNrZjNGeHdRZ1hCV0x0?=
 =?utf-8?B?RU1IUE9pU1VqNG9QdDhwKys1N2JSZk9LRUc1U0pMWVluakhQZWFtazNhUVNQ?=
 =?utf-8?B?WWlPSCttSXNOb0QwaHJKejk3WVFiZXhEWDdXZk5FUk1xVmhPYWQ1SFk0aEJr?=
 =?utf-8?B?eVdnNi9hWWRwVDlPTTBSK01oMm1temhQTTl1OGx4RGtIWmZLb1BCQlJwd25Y?=
 =?utf-8?B?MjZ3bFJQNEF2SW5ib1dwT3V5U1FtSWdmbnBINnEvcHZzU1FtR0VOdXNpOVFu?=
 =?utf-8?B?L04zTFRJdXhxcFhScm56ZXdFaGdtOXRvNlMvQTF1czRFQ21Sbml6c3FORXdV?=
 =?utf-8?B?WDdGYmp3TDliZDR0V1ZrUjJ4N2NueWtaOUNOQ0kzRnkvaWNIOGJsN2hhS3Y1?=
 =?utf-8?B?QnB2TUdxMzlSRVhTY2R5eGZXNE9uS21oOHpIY1NHRXM5RFNwWGRleS83RG9Z?=
 =?utf-8?B?a0Zwa0FyN2lUUkVLcElaQUQ5bURCTjFsaHRFYXgxdUplS2NYL1M0WTQ4RVd0?=
 =?utf-8?B?S3FhSE9WNmVhUm9SY0ZyV0xxVjhOSFppQUk5aGRUK2dnVlNlL0JrR2dEUXZL?=
 =?utf-8?B?UlhHN0h0STJTR1VrQVo5U2pmUURaOWF4U0s4aU5JZWNqZXdPUTVCamlhMVlQ?=
 =?utf-8?B?N2pwVDJPSGNYbUVKMU9xQmZGdEY0TVFSSmw5cFVkMFAyY3RkNktzSWhOQURp?=
 =?utf-8?B?VGlzUlhlMEk2TkozWm1jTlN6SUw2ekovRTgvaWlzQWRMZkc1T2U2ZFJUTEFi?=
 =?utf-8?B?V2FicDJCZ2x5UjlhSjY4dHRBRHhEV3NuSFEvYlNpQjlnUG9taEJvUDJWNjZx?=
 =?utf-8?Q?09ft45?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 15:44:36.0164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaba0d2-02d0-419e-c5c6-08dd7dc6c19e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996
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

Update the minimum firmware version for the Cleaner Shader in the
gfx_v10_0_sw_init function.

This change adjusts the minimum required firmware version for the MEC
firmware from 152 to 151, allowing for broader compatibility with
GFX10.1 GPUs.

Fixes: 25961bad9212 ("drm/amdgpu/gfx10: Add cleaner shader for GFX10.1.10")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 00eb4cfecf8f..e140f673d25a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4828,7 +4828,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.cleaner_shader_size = sizeof(gfx_10_1_10_cleaner_shader_hex);
 		if (adev->gfx.me_fw_version >= 101 &&
 		    adev->gfx.pfp_fw_version  >= 158 &&
-		    adev->gfx.mec_fw_version >= 152) {
+		    adev->gfx.mec_fw_version >= 151) {
 			adev->gfx.enable_cleaner_shader = true;
 			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
 			if (r) {
-- 
2.34.1

