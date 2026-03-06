Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3258BFCC04F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 17:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B978710EDD7;
	Fri,  6 Mar 2026 17:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDxqCJYp";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED58110E0E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 17:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inoFlY2w4G8oHeBqj2CQ0O6g7Sk6WTkwPLCpLR0K430DECILnbuAf9lt2sKcHK8t1KfdeaKY/vcYLs0/sD2SQmKOdotFZyXAwI9bscMFiDns+uV440Xq9+sxC0sUixSrYH+ic2Fbh4tVcAH+4JpVYQjn9pCMhcuByJHQDelSG5OxMXV8gd1oY/1Aq0jt3wYnLqswvnkx4wR1s5k9l12HcKzO8AueMBqdAhAvWPtelA7hAuU4Q8N2BE9r4cC6Xg60VRlynYkTQzjrqHuwU25/YKbzvQeBMU9UW+Qi+tIgrNkGBr2bp7NxE4gsUO9NqJDHD1rphI7NsSIx0Z2MRawQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INq471NoupzTNRXgDCEXZu22ZCzuuNjEuizEVNgJh9s=;
 b=KjOWJWBH/KDIVQ7QyJ34OuPRrTrODzKlPis+a/BB8Y6ptoD55Wdy1ZJWp8xZh+bPMAGUXzRBjqrlBfFErq7oCeUNvcVaCpwstlh5E/m6P/gzb41nAkFbMtQE9Z0U0QHcBsgVoRAZV5aUVORQliT5miKKjh7agvabfZD5+fBby7RAhyv1KX07SLH5196RhTeWNqehOCWPVLEQPIDxx+k/RktmEqJNjtgjU02dCnmEViE57UY234OIST0wsUzDHRCcGOw6yIOnfP1201WtoJkYt9CFf5bgK/Y1TC9fJ0DYsN0fR/7+mPGdOBv1qv3ZoBFbalfdRSLQQhV8UN/FBQtVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INq471NoupzTNRXgDCEXZu22ZCzuuNjEuizEVNgJh9s=;
 b=yDxqCJYp7srt9VHxArz+OMWlmWrjaCv4Hd9JFURp8Q+hkXVBV3iKtbRDHY3Eee+6G4l/99FPb+T456vOBM7ZBmqY0UmKh1W7WY0F7KCqv11RZ8ZvWcUBjbZFgWWB6B7oR+aljmAxxWPkqikyhOiwOvk7XQTCCQYLWkf+8yhAQCc=
Received: from BL1P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::25)
 by SJ5PPFF62310189.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 17:24:26 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::b4) by BL1P223CA0020.outlook.office365.com
 (2603:10b6:208:2c4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 17:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:24:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 11:24:25 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 11:24:25 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 11:24:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu/sdma_2.4: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Fri, 6 Mar 2026 12:24:11 -0500
Message-ID: <20260306172417.325169-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306172417.325169-1-alexander.deucher@amd.com>
References: <20260306172417.325169-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SJ5PPFF62310189:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4a769a-2f87-4c96-d5ff-08de7ba53743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: uvLciBbj79KZi6Ut4YWYxxPZXiuEYP1kIwRgT/3OCD10XFl04aAiO0AR72SiHCQikrtQnbdCHxycQ2fMyLFF5/oaNfrWBkgDZGaFAdMjtHop2niQFhKCq6+1+CQCT+0Hwxpkn110AGsJ+OjOYPceLsa/s+3oDaiI6dkYP2XI8n5L+l0pG/2Np4bv8G2IWlOUwKhA/ofIy7C5MQT0Gz/y3D07WmRHg6ZSPthEpCgTCkkMcCm1qTS6ueyTEvkuTa9wjLd6ohgSy/BUr/WDtgilgbI04yvM1CvGbkITxyubUQaeg9ePwXaYuvmU8apgctWgTzkM7KnWSTfZhsrAn2oVl0/vHIDWh5FQRXrhLWtq2u0JnH+/ozLfGqTLf682DRpSIg2y6b8PeagaLJiEczN7g31Lk82WuH8OZSV5dFEvn0pvb3MBfYNN6zPPPij3wLlEngMz4hABkNtJNeygx6i9Dqe5a+oOJHNHEg+UPw1bnlGqsPxgOdkgKh/8g9gf/CNPWrATni8NEtQ8HbIpZhDmAvRKklrDrl3lTv67/xmR7aU8bQKquPur/LU8jR1ioAje0OLMsARIvbd6Mn+IXg6LMgHmmKrKhArcVfEdCbdPbWS6isIPSL3ZwPCDbiBE6j4Iq69BdfBEozBUNmgmhQL3od6/RV8twMak1HWuTNmls8FuT4/YjSigCPQ+fNHIRn2woXe4SSEoL7UdjpoYpaSvY1kZXwUnB7Ly6iBCLKfkofQ08mebwcOF/24tLnneCQkmOBaTGylaaGtWOKAfmMKbtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gQ+SKSFBkJSmnlf3IVd8dikyDAVS6eDkw7I2wBGDqMOTKDxeLGLKrwzEkbMPxqZt5fzMlGOlKvhxprs9TV9UtWr/1Dto/PonWUjZlJq0BpNQPFlSIobTOfsNQwoJ98wWDMsjJbpBFjlbytq/L5hLO6Adf3LA12BRlGZbyxYOENUMNzjDJdCNJhI49GbB1E4d7F0/a3xpvNP5SDiydwXgtX3zaFKfdWj7G7E2T93snktj2q0JPq3AUZ/IfHw+ZFFRJdn0s6YIpn1UkC3rfY/4tmlFMUi9csyes9Tj47CKpIKK8WxSqXcYOtuuk8xY3d+/1+ovDNLmr3wleLpGdpTLYaeSewScQeXH1A4GOgzVINiq5OUQL/qWEAaka/vZ+INtudpwk4Uw5/3hx9NvfVDe/Hlc+eE1fXQkfxXNaT7AajzPZF4nFd/EiXcnLXbjyOu9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:24:25.9760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4a769a-2f87-4c96-d5ff-08de7ba53743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF62310189
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 0090ace49024f..ff03cbae1c59c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -420,7 +420,7 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
 		WREG32(mmSDMA0_TILING_CONFIG + sdma_offsets[i],
 		       adev->gfx.config.gb_addr_config & 0x70);
 
-		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 10);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

