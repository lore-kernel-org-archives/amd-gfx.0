Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C3C103E189
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91AF510E834;
	Wed, 18 Mar 2026 14:09:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yKQ81wj5";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF44710E844
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gL3gfpaWMh4IiiEUlX7uo/PJ4Anc+e0SbiU4+iZmuCIQbSvhySKOcR8xTZewbj5a4/yNHR3b7we6ev0E/kIEAkKenX7r5mvDMjzE1ubtBobw0ZnvrOinL+cthZQCBwqeHslMjSPcCxrBNlpBs1nEC/4QRwPJTq5/jaJP6j1YUf1pFqovbWKJ0A7BuxggrrNUNR6CqIIksfEd/5ccxFZwYsTF8HLrxoVHInWajvQdNJMSKmVgfA49Xv8E9Bg6/eJy5WIpn1IDU35ZquAFi51OCBan5SSepFAipCJGDUA/kV+qurL9NFFXlcpFAt93L0cf2McJd8If/zUAea89AukR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwXb2Vs00zTF1oYTcWdCPrLdV7j7BySZKVzK4XzDETU=;
 b=AN8f1FLq43tFKtiSRDtj2fYAvin8c8/fh8jznmseTyhyheh6QMMCU8WbJp+m1nlzQn+reSXdEJFWfTh+R4RWnDPqUYhbxO7G13t5D4rg8g0R9EXFKdNDJfrg7KRidFFl/cdw8p9BNYJa0o2rToAksyachhrzC8YnECNsD3fA1EbTn7akuNv3TeNXT2Dj7a6sVe/ZffjaZFGqZVN+GEuM41NRxuiI+rGM05FBf1XMyRrrGAb9iq8IHb8yHcgll85ux56krKnsZlO4Pp2NCpi1LLMCyqyNm4qpLl80PpRT9wDnsxAV1INDFIMH2jMSJc5NW5PzEnkgvKelQlbVB0irEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwXb2Vs00zTF1oYTcWdCPrLdV7j7BySZKVzK4XzDETU=;
 b=yKQ81wj54qhHpNOjLDrhF0nYwpwJ3qwPpSWoqD4hwyoNAfc6LNvt3leIuBlTS1C8wdQz2L02E0tbkz39R9nOwWIDxJAzjz3KGsbkN4oAQUDG3QD7GK+nENX0nk0h7VAHZ/Ir6pKrA6vdIKj/vtZX2f8rKa3hfXfVJW/ab9XlNOo=
Received: from BN0PR04CA0125.namprd04.prod.outlook.com (2603:10b6:408:ed::10)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Wed, 18 Mar
 2026 14:08:59 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::74) by BN0PR04CA0125.outlook.office365.com
 (2603:10b6:408:ed::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 14:08:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 09:08:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 09:08:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:08:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/16] drm/amdgpu/gfx9: align mqd settings with KFD
Date: Wed, 18 Mar 2026 10:08:24 -0400
Message-ID: <20260318140837.582776-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 99500f2b-fb0e-44e9-fca6-08de84f7e63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: o/jyXkw3fOdWRmeVyvKn45/BT6clkdykg02wd4DIWdtHZ5X+JDKu3fspOH2JIUJg3yNZx4kS0crsNtAdrvU8AZ6nl5upnOIhkqqi1IYpJIa3bv8F6EShQbiQjSNEpkknVFu3JcZivoH+g0KL6/LqUWw/YHK8SRtHUNMI/HG0P3IGNk2MaBB6pD3dNE3LSNqQ3+KohwNLYsjtms2dvQ59sHXdv2jAkFR0oYfTRJMzXaOYksXQzfE9NF1/SBJZIw3oL23qujDeTpZWRCd9FSFT4l7szfFGRI95+VWLLU3+F7CN5T9QvYbdC0RtQMzkgWYfCKU3wNjMGrQNhnA3K2A6YFKbwiz/4qosvHrSoj8WV6ykpEEkPMZ+jR/9VvUIPnnqB5QURIiEmOXueyW/8+AK2S2mz8CmtM1vadvFjN0qVJhBTDVesnYl3FvlWtZkEtI2vvoQWWRF262FO1ROKqOmx0tMu4aLofTs3//slZmVj9nZD8+rBD8ItI5xoyp4m5EIUMxN95qAWLYsaSBxrvtm4e6YV+6LgcaD9Ye1C38DXuj0ljURZRg+ikspQ1UIcxbaQtTZ8kVvGkPNGvolrq5rjFoozSfImXyT4UxxIgqU1KpJ0WUWRLXvEIchM1mcM6im33pX8TBJE/4raireN+vVQTPZcVm8gdPqjTbKehGZsMUUyiDXLsdjOcgywqUZJifSpPKKmnwETO4qwmsVKY8VCg3zcbNTvveAQkh7oq2okLfPw8fP2mP0uUtl4SFLpPIDkWRzd/vr8tRNtozipha7Gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4aB4eqkNtjNEfQNCoEwhPn8h4l1W4oiPhl3irEHAP2SrwF5zMP4BgaQ0jLgTMdUVf/9w50pJf8Gam0mfcm+jOYX2LZ//e9sHOjuyIuLT78WinhJNoJTNZFaxzDa3ygxZU3m1kMY7a5rwwhKf09jidi2DFmxVN9laEuPvjgDV4xK6qqsctLU47q2qWt0UIGKcfHdaOKwK+q7HImE52DEWSqpZP5EY7Yh1iM8QWYGq7yQgYd6T+QF8jy9mGFcwCo9zbtsNLlB0kuei4RlwrU25SEbnBJ8ZtxJGOfRFFxDhb1LyzQb8BRj4oZPWXnZVgxXw5fun4zWBxkMzYZFyeztNZUnLUR/nirbxG32h6eMOxBnt3jggbGxMXYR2xjUZbFgQ9bQ7q4SKkzED9TBblLCYQfyUMaibFllOwB26zAc1v/pSoJCsIO6JLqqe6zme/fxY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:08:58.7483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99500f2b-fb0e-44e9-fca6-08de84f7e63f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
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

Make sure to set the quantum bits in the compute MQD
for better fairness across queues of the same priority.

Reviewed-by：Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 95be105671ece..2eb32f92a77c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3667,7 +3667,11 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 
 	/* set static priority for a queue/ring */
 	gfx_v9_0_mqd_set_priority(ring, mqd);
-	mqd->cp_hqd_quantum = RREG32_SOC15(GC, 0, mmCP_HQD_QUANTUM);
+	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_QUANTUM);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	mqd->cp_hqd_quantum = tmp;
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
-- 
2.53.0

