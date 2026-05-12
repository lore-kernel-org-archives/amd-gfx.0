Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11F3CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 08:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4003A10E9C6;
	Tue, 12 May 2026 08:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wPJ/wf7d";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AD910E9C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 08:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6VsLgoAi53+mR4l9RHe5NhsmBpWyRYXMVVZkDwC11N6HYjr+luKezW7ugJfsZRdwceViCXjlge1Z065u5mhifR5ecR8McuUUgtz3XTikulAaBF/aicqEVqBzsGinUJsRiuUpImvypF8BkKHxMz6GFK6pLpjISrHSWjyBerg62WdylIjroPiSjNhRRKVW/NeALDsB3Lu7Yhv2JFkSUeCMxyDiqxrQjkrvNf5kxTBLK+o1zno53I33cvJj8qDdex+GrzsQut2Sc1bFDFfkuPDmui+DV4mGjS9FkkAZiCfdkB5h9xSVZHwPYMPJZ0FzYxTZe0oxgNong9c2gMQVqri6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbTUJ8xjZPB/SWEGZFJArlXfpSwMVV+LG3mUM9+n/3A=;
 b=c+J2Q1oOYdHTH+MBaQ1caXqhka6rCT8dSlMNRhU983T/f15uw6qtHNjwVwOBPcxU/7REUtm20dJQRzsByQhjfHph8yWogQvVY+zxrNaqUgydqp9gJ2IGCD6Y4YMcJY3CaW9YH6lCn5Ek2frxFkU3spnKtAVkwc5gYFBd2Df/4EgOjH9jCoMWJS/DFVXEIiwLBQ5K1du4ErFIllrLH1Won9Zjz53JfWnHRr7XeQUUNgeLe5zII5Fuf3jc4Z/Uu1lRiA/hhhuCwz8Pjwx2CFxwj/wiAh0SLNbAlZXb9RojCO4WmGfLH8KPmFCMzDc4Fn5G+pNh8XJhbfYA0sMTrqOuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbTUJ8xjZPB/SWEGZFJArlXfpSwMVV+LG3mUM9+n/3A=;
 b=wPJ/wf7dynxrphpCYNTigrM5Kk8cimBkVl+/kGAcfZ9tBUrpbR3z6JAr/dv29ziIruRly9FM1CWERBHJbEfJo182mlzPEwr0d4x8Ena9NOGM5dxj4M2OBXNtMZhCMhTUDQiR7Tpn/gYEhfljSU+7VUTAVI82FXmXU8IEXZYqFk4=
Received: from SA0PR11CA0100.namprd11.prod.outlook.com (2603:10b6:806:d1::15)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 08:48:59 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::7f) by SA0PR11CA0100.outlook.office365.com
 (2603:10b6:806:d1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 08:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 08:48:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 03:48:59 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 03:48:52 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 3/5] drm/amdgpu/gfx11: Fall back to pipe reset if per-queue
 reset ring test fails
Date: Tue, 12 May 2026 16:46:16 +0800
Message-ID: <20260512084827.1630497-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260512084827.1630497-1-Jesse.Zhang@amd.com>
References: <20260512084827.1630497-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 45fd1037-4ef3-4a35-f986-08deb0034f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: /anBjx5tr6hEpoqpx5DzJbTH6niBOLiYvIFZ8QNgO7fyHo2wr5ipObiWDRQ6unk0WpEuLR1aGq8ENUv5sbEeUHG3/ucz7IGZz0HhLyRvqMAiVIgP2V7Y2xMWFkLNIIu/Yy9g6JDKBEwwVi4mhlLVcOWPXnc3azFhwwIA5lrTLkJdoXaswxeT37uDFNRSBuxLmrQFEAVpMV1V81A1+GT22j4Xg63MWubzDNScCbaXeDU19VqlB1ds33oqdp/3UGwJD06yCdgHf3HBbEsoGOwZ03SEgX/SHxKbHxkCrPVR8w7CB2t7+Ocpr5vNCM3OXdGyLreSqBp46oLgfQ48DvBdtlpLqXG29wnC4hU9rp5v6Hwc/20HW7XCkwPcvBJgGFq4MfyN1/ncVycnPJbHDYydKOdEHxyuVhAKfgCErUe743jXeNxI9A411YvUWtEaJItI33xKsec+NqkTwGEG5xm5Aa4OutN20znrMxC7nyvisrSB4b0c5LUer2wCvfSiPg9HgTDJhstULaCqiG9XHDn3LGyXh4YPFBDiaG7lIB+lo7TEJWe2H4FSr4ykao23mTcXph96o2onAzeIglbeNYNeRZvcJ2ma9oYgLbSZ7Ou6TGTNOh1qDH/9a7YUpeH4wkOaEjOkwJ7hytvi3XqhPCCIElkSCR7kIpC9U67i7tbPiAZBXE7+btHO7Gwpf8iE0XbaZE5pIjTl0CbPVjTNUA72ESYlyAfzqL2OtF8GLPUF5dg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wu7YerUmrALYDn4htKNgdI2zonWKn/g/EKf/JKzjCSNS5Oa52VfnxIBU7aeNgLiAuR4OKwR7HK1Sv+H+DwIglFkxXFEx5KsG2L0MB6F++HwNCbl6Ltb/dZWeHr9sPR/VlqUH5fLwgh8jw8PCX+hVw23cvn2hxP4xULug+biOvYmbTxnBzISCv5CQ6vPYwkWbzAWuRxQfLPBU61e683S9PGc7HmhM/YNDi+vQDe07Jz+K0rKMqzyvH+kggsSBwEtgNbiLl9Vx+14uxV174Fp57sv/Y4jRCUauJ/+Wde53G/A16OwVAHnPwmzdsmsJKBEQuM2IC3yVXbui5SDd1CVytqbTpILWDAB2Bi3pBTG31hMXPll8QebZje1qAH5SlSEA7QhAwrVFpehj9/NHXLz4Dz/HnfATZRtpUlJ3GAhgdoMLNs7hrSfNaxmXp8jSTnyK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 08:48:59.6120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fd1037-4ef3-4a35-f986-08deb0034f67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
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
performing a ring test. If the test fails, fall back to a pipe reset
to ensure proper recovery.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4db6b4e398e5..bec99d149845 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -7044,13 +7044,16 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	int reset_mode = AMDGPU_RESET_TYPE_PER_QUEUE;
 	int r = 0;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
+pipe_reset:
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
+		reset_mode = AMDGPU_RESET_TYPE_PER_PIPE;
 		amdgpu_gfx_mec_pre_pipe_reset(adev, ring);
 		r = gfx_v11_0_reset_compute_pipe(ring);
 		if (r) {
@@ -7071,6 +7074,13 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
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

