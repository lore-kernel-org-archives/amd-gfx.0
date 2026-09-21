Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBB6C982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7149B10E552;
	Mon, 21 Sep 2026 07:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bsa14cKG";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A9110E552
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:54:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKf6sfmr5CS5bb8V+QGF26ievQNiFBFyraDF2Zan7LBOGnsaOENK6m7ZodUs4mGD32Qx94huREpZ9jzoQDFeD/9b6NrCgbA88tIdqPotjSShUSZK5mWXIRqp64AqDpdNrqVzMzUeN4qYQkDT1BnEU7QaBDzTYQkUF+WV+bsPbObmtT8ZYZiFE6Cf1Mg9z18mfDz7O/GM4sTArjFrSLjHgk06vHatbpz7sE6wBaYqkcMqGHfvtnWxpa8cs31f2qdAApPpHLIRDLRORPGWT1AM+ofH/zXlntnvkoUXUu6xpY/p84U2tPc0c+7qa8AMdadbzmvqoxpJ5f7sZ7giuY5WtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLOw3aX4eMgheorv+/bTj+sTMWL+hYqaB2Hzw7wo/1A=;
 b=O+SZUxzVnL4/vnrzWLyLYL1A2nZsvewTEPpyDum1SX2LQHr+FOqlIWOlbPgFv2MJyfMpC5Wu3AB+moBEss3im3yeVqdXcn5SU4bukNscKla59BFL0aRE9LvasBwKp+wAH7K0qpE8WSP2Bk+fQ7y9wrD28SVv7boJB8Y4lEnlLgaJgQB2eIis8S969vdT22LrZW1F85qn0i5+/xobpoYmv5VmazDH78GpBzuLj6KXRl4M4NPt71l5ShrAKkXOmVdDPcV4Mdy5aQggCmPiJoxF+dDPH1baiukvsGPbjeHxGEuE35yooxtIWPlYj0WI/ToTcuinCbkyyCbvybXRTBIotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLOw3aX4eMgheorv+/bTj+sTMWL+hYqaB2Hzw7wo/1A=;
 b=bsa14cKGGO9cF6CvBjsbhgsx7wK3FJ+y4pOlugTNtuU2yxktP59OH+uo3D52OKWgV7jPHNb9RC7fPZ7Qk6skaqmya6/WnINjxD5JaOwGVtbm8dhNeMPD8Zd8iijCT4VXJCsokmgqgVMbahVVsjqQTFe98sD6WhdojVOwnWvBXwg=
Received: from BL1PR13CA0153.namprd13.prod.outlook.com (2603:10b6:208:2bd::8)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 21 Sep
 2026 07:54:09 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::8e) by BL1PR13CA0153.outlook.office365.com
 (2603:10b6:208:2bd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Mon, 21
 Sep 2026 07:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:54:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:54:03 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:54:01 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 16/21] drm/amdgpu/gfx: preserve collateral rings during gfx
 pipe reset
Date: Mon, 21 Sep 2026 15:51:23 +0800
Message-ID: <20260921075326.2409021-16-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df622f2-8337-44cf-db01-08df17b584d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XZ/QftoEfcPxh63CxgJjN3C8pCG/WZUyjG2u14G805K8V9HvP+C2/DYMrC8GIgHVJlgz6iHTFeo5Rzfig/vJx/DNHGWRzUZ36g7JWHx+DrLlTWTEKAau2aT1NPzEOhP25SxaeW2/QKszKzKAL57+C4rRbpbhU/lF7AbYmskGEeZKl7iBPRKkgfn46IAHV/cXll4S4+TP8N0TCu9n3OvF0hMN3bsidkS2zfpHuzLz/D2ji3DZnUN2wxo04SdRpOJELSqW8e9CLWslZMzMF+M/jI+iRySupdM8NkEIPl2Q1I/3oe9HOE76STEonm4+bcAN4EmtYhUKU8ytAcAJKvMLKVoO3vx8G64TA1Ex1S3EH1TiOczgPQlEQqIDfxB0ZutCw0shLO+BgyhIdhDbcOagqoXUcDoa0BTwN4RU9G71xvYGTUmJn2b3rdJ1oZjP6lOYurmt9V26uzdVh+EWpm2v6uHfhFJJTq+TYkIjYe5Ukn6ebJxzUDaBRCl+3VF1t5Fmhj0q8SY7u8hbJp3flwmdvRO7WMswMsjFBYKpHNBDqMoVz28F0aP9KAmggRFDiEOKiZpSYL1VwgtbiR+e/dBP2gk+QvDYUHKlKZtld3SpVowLVXbHiHeRv0oc97agTPnjcmHEsEMfafvbXpNHyA7klADToTufft8jCAi00b/bZtWzWp20nyCRMVP9onsFVLE80ix0qYTlXwHhFuKV6fEWgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v0xVa1g3wubYr/r0u2YOQzyDjPa5T+hIiFcw2FGH5dVWKLZEVI2aD1A88xaVoECiaxZvwkEZZaYYJc75ec1h+5FoTYlKaxD9LgZvov5GDNh3+/eHvtVt/Hi31kziBgDAdZiQc1apE0gOouaNJ6/i2V/RQTQH54Our/IVImXp/3Y7fzsfXgfh7NQb1FgaPA+yjW2Ivmizo5r1rMPwBojMyts5tuKQsIS0/zYYDvS0Ez3m/XwWdm9MNIGp0BqbhAY/ozQckDJwEHXHSeJG0sBQijTuQ2x+thI9noFnCi6j1dw0WvtIFdrPhX0hKAozolyLoD5L71tHQWJ4a0QjZq6fuoGVkhSuCIWlr14nsNuOIVn8S7MQVRnhJgcS2+PKCJpIeHgwAY5O9MeVTgsQ9wc2cpfu/8YY65i0oPdXama+7RRnhdwqqnqdbnGMiwsmsDYQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:54:09.3885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df622f2-8337-44cf-db01-08df17b584d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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

Route kernel GFX resets through amdgpu_gfx_reset_mes_gfx() when PER_PIPE
is supported, so collateral kernel rings are preserved across a pipe
reset. Keep the existing queue reset path otherwise.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7c597dab5b2a..94d45d7960e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2181,13 +2181,19 @@ int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence,
 			       bool use_mmio)
 {
+	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	r = amdgpu_gfx_mes_reset_queue_start(ring, vmid, timedout_fence,
-					      use_mmio);
-	if (r)
-		return r;
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	if (!amdgpu_gfx_me_pipe_reset_supported(adev)) {
+		r = amdgpu_gfx_mes_reset_queue_start(ring, vmid, timedout_fence,
+						     use_mmio);
+		if (r)
+			return r;
+		return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	}
+
+	return amdgpu_gfx_reset_mes_gfx(adev, ring, timedout_fence, NULL, vmid,
+				      use_mmio);
 }
 
 static DEVICE_ATTR(run_cleaner_shader, 0200,
-- 
2.49.0

