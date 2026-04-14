Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8037AED7B8D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 09:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FFEE10E5BD;
	Tue, 14 Apr 2026 09:00:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G3QLz1eC";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6E410E5B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 09:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeFsO375wBJjqMW2kM8MlTZdGdehZ6kYAbTLUb7NBOSOjGPB7QvnCmSSnS3r0eiGpsJ6B7msf+LujXmj4ra43D+kGdkbOvdSo19xLqM66QVZjvpfIeyDkhW5htpVUL1Rtj0giwDKkEsECmsD3vbC5Ky9HD5ILpDgzqCBFoKQTbMvtG2OUJetJnV92k9mNzm1HdL/nBDCFjgYEPlQhU//0S8zfPK0xBD24ZF2p/1xiytfUkoo2rRv+Zl0CaJWDgEGI0hWXeo90hfTvOACctYhWjDGcotbdfHIhZQUcBT+dUARl/MxAfgKn8NqjR9ion1oMbczUpkDIjjdInO6vJlAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz5N3xbmKzUi/qJLgkj+D/XAYCqVVJTcD22H7yiBf2M=;
 b=kwK03zf3Wgox/VQ1iVi91yl16sbsXgRXD1T+Z/yCXv77bG2QB2o2Tg7kjOQzy1zeoJwvuzQL6jU47YbtK/UMqUxLgUOIyh9xFWh/hO7nwuZ2bs/GR1XDBRp2SUaoRkvkrzqfeoxpf19jvrzjBlL9iqhWTfdpoPxcTRnEo5DQyVCDYNFf4pQd65BFUVM7JirGcGhi6xGa9clCQEB3i32SX0gu4A0jf3k3agyfjCLGT+GTQjvTX7shdN1G+BHzqv7OjMI4wsF9EL4iXJA72YBXjsCYAB0zONXHmxLaDl6QHum9ii9UiVWZDOi/HvLs7sozeGkn+RyxU8BRN1UShN2Tvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz5N3xbmKzUi/qJLgkj+D/XAYCqVVJTcD22H7yiBf2M=;
 b=G3QLz1eCjNrZYM2X1Gt4YfyVsSNj4rDXHu5ZOCWyYHB/LnEFQf7Za2+QPpr5/7I4dCWpA483YQ7sUD/Swde3SPYTR+s5zs7ZqUBJt+UamgsWS/yKU8HyqPae4Vm08BGB4p9AhomYkqeQyrqbCKzq54yWShit1v/He6wpZxv5vJI=
Received: from BYAPR03CA0006.namprd03.prod.outlook.com (2603:10b6:a02:a8::19)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 09:00:30 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::6e) by BYAPR03CA0006.outlook.office365.com
 (2603:10b6:a02:a8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 09:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 09:00:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Apr
 2026 04:00:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Apr
 2026 04:00:28 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 04:00:22 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 6/8] drm/amdgpu/gfx12: Fall back to pipe reset if per-queue
 reset ring test fails
Date: Tue, 14 Apr 2026 16:58:53 +0800
Message-ID: <20260414085926.3171086-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
References: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 37af5b71-9471-4ea8-6929-08de9a04472c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9gPcZDyRbNOR7KK6iXNa3hN5Furcr2c/1AjTrh6+o2WYlx4D5UH+7Ak8uy7ldYFz7Ia7OF9DJVV1A9O9AuybczZD3jpXovth+GsQb0VVBp2ZtUdNyd2lt0kl/uKhcU7WqYINMe5VtXNMv9uIykNak3TUCJrOdbPIT8E8tROuaG5sjHtvMNz7jHW9G2PWx49B8z4U6BpQhi/tPLXealn7gV8lrPOnV+fkKfuE/iKVDGjwte7nvk1bGu1uJ+2U1zCm3024R1/S69cLpGPvMOIEEtvVvo2k5deOcUj92Hz1u6xQQ2b50tbrQzPeYpJnCBv1d/+FdSNY7Srnxlr5BUX4BdstTFTvSz3W8c0BBkQnLtL2IAx+niA59+2vkSd2aF/P4W6buSQXO9iLElccIGNu9JzPKBUx5hU+aPuxcr9CNqvYTSfv07LXcCDNFbuhD8Yn4O2QxCzgDGIR6SxCDBin2Ts95ss39oo3Zpa/RcgE09+ltQOXDTtmM6NrRK6/xU9XHVE4+VBXbj73b+FTkNrVai5aY+QxPQtsQwKtiNJPkXx/3LJbNK/KCYRXzOhrkAzq7oi1nyCsZndDezG0ZHXgCm7zXXXHUgl7T1yogZjPG4JpzUK2OBeg7QWTd2tICRdyUrN7qwZze88xzcUW1pi7HiHGhVvbqc26nmLZVLN7xRua5Q5FzG3DQoYKtR0kxZxH1wJw3FwHJkD3nP/m7X6ZW0UHI+ik9qehBX2ub8qANHXBS3efyqu4wwdsnS8lxXa4BK6NT4DHuYyS1jvrziczFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XxDRtTfalfSMh8U52g6kCXdosi7msQr02Pw8ZB3+/LswcrIiPKr3d8F6Bf4oluc0zqiHY/34t6c9kBolslqsPeNCiJTQxmfn0H1YBvO0FiKdKS1W7o39a5uyJZPfRvypA3TofTW7L56N0wmSL+sybdniEidk8+G2jCTs4MfR7r6fivMRgyyk1zaJrsAQRLgHow4UAGF6d/i4VSp1WyGb1xjtv0syIngsYuE0YlgVydoabROLc9hEUlG4p9Aa9ZgRpABSoawbeYYFed/gleGTdJMOOqAujBX622xP5ukpr3udTli2VlgxQzp4sEF/Hc9NaRmqn8B+YaELr3di5IGx+7HjsIiUyuiHEmTOLrn1VDrOfUbih8Z1N1uIlIsNOD7y21w0pINZBzzo55vifVboyIp3aQnjAQ3xke/okM+joiF9Jg30L1NOZOFMT0BOcwQz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:00:29.6493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37af5b71-9471-4ea8-6929-08de9a04472c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
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

After a per-queue reset via MES, verify that the queue is functional by
performing a ring test. If the test fails, fall back to a full pipe reset
to ensure proper recovery.

This adds a fallback path similar to the one already present when the
initial per-queue reset attempt fails, improving the robustness of KCQ
reset handling on GFX11 hardware.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 676a655d1cb6..f90354e2ab3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5474,13 +5474,17 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	int reset_mode = AMDGPU_RESET_TYPE_PER_QUEUE;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
+
+pipe_reset:
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
+		reset_mode = AMDGPU_RESET_TYPE_PER_PIPE;
 		amdgpu_amdkfd_suspend(adev, true);
 		r = amdgpu_gfx_mec_pipe_reset_run(adev,
 						     ring->xcc_id, ring->me, ring->pipe,
@@ -5503,6 +5507,13 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
+	if (reset_mode == AMDGPU_RESET_TYPE_PER_QUEUE) {
+		if (amdgpu_ring_reset_helper_end(ring, timedout_fence))
+			goto pipe_reset;
+		else
+			return 0;
+	}
+
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-- 
2.49.0

