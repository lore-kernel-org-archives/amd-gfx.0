Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0814AC624D7
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43DF10EA94;
	Mon, 31 Aug 2026 18:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TY2y+taV";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA8F10EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dckdVWUYtBFinOMmlWOTP02bCfWyheORo0XqIGere8SOmJtKh97sdg1YE2xDKbKPWqZ8aTdIp/LtRhwAoSpRxBTRfnY2CxUfyuttP/WFBJT7SS7TD+gqae+pVrO1rEeDiAHFpt2fgP5yM6fDdemn4fY0Z/wGTlR8OMx0Hr4M0KcYMpn/UwKzXdNcrhcXxAnqXGNxibz4sn667Ms1ho3FtzqYWItLOQtwzmQuo4OTksk9hsEdmqhWyPwVVamh8RfNXA4Tlgy4HD1mo2N/O/6TwokD/TovitgykMMjPv2V5gOxdnNK1ucmypVDn2a7LHpxIwHxNwwGfIfhWmiL6FEvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASDz++R6XGrsDnXAIwNMBmxrOIjz6u7j8ZejoOMsvPU=;
 b=rjrF3+3DMXaqL/mqxr3jUibFt0ltadmDGGtzkYhr2Sck2M55+63lMVNGr1u6E0nAUUFBMM9WNE2thCT9CuKwGxq7JXdPlyud6YeWfQUk4s0Dd7wx4CPMMXNuw+zI/2WQf/CxiUNiM/45LELP/MLB5jYkI5XKYtV4bHixdyKQ8LIdtrDmMfNjBtthl942fE1Ru4kg56JzxqPB8DV2rMompQFfCJ0rcYk0UNq07E553B1W9+iyfE1+TuxWO8c3RhDhcEn6t12Vf57llx81kvv/E8VMivJCQLBEnTZRTRkjoyrAIPmEQHxp6BAY3LUu4vw4IB6uIBt2lOhUnoEa3GWcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASDz++R6XGrsDnXAIwNMBmxrOIjz6u7j8ZejoOMsvPU=;
 b=TY2y+taVwRMBahXSqrlcFJ9raGrvlTddgAmDC+k6Zqp38Sr9zTAlbsPsb/swEvlX+En5KQyjimHFqajs/gAiXeVCkNRWc+0yNSfmSxhxcZilN8wQ4HAb6PjINJNGGlT2d7tHDe5OE7lPQTfrvsCZKj5qJjVnOhJ99YsD5sdkjmI=
Received: from BN9PR03CA0688.namprd03.prod.outlook.com (2603:10b6:408:10e::33)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:05 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::45) by BN9PR03CA0688.outlook.office365.com
 (2603:10b6:408:10e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 69/95] drm/amdgpu: Fix uninitialized fence in UALink NPA unmap
Date: Mon, 31 Aug 2026 14:27:28 -0400
Message-ID: <20260831182754.1089811-70-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd1d7af-b4f4-415f-1200-08df078dbced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: n4GTijJdqV+P/rnfTqq5uHCsZIdGtmgtxBYCRjCWjONNoqql1f/7LHWzHVJnEhT1Okw6ZMdFItl/w8F1WocxDPeGdCjcKagFmrfAFGdDMOO0vGhWpZz0YqvrKHF1QFDgwjzeLCXx8dDyBRm0zzQuSeMAVZb/FkqwwKPLWsHDdxBYTeNxV8m157Rm9fgOZDNjygiozNgyRAU6oGYa7u0YYb77NG3Jw6pzIBdeZAb0mKZ15jlcuxbCaXQ0px68bRdkyosvAZ8d/e8UWaKcRpE3nQgXNeAjtksO2rfYdMaV9XyUmj7wjZEIbxQQGUnarnsM+LAvGSBXfeQnIbQQooQZ1c61kX28C3ypY6GwMPiazfW0wtNLOl7DTYYV/3SWU2sipyEZKdgTgHQ9tlMa/jyF8KtyrsZ4cJKIGp/IeR/Ng6FXQiGuIVlWeFT9wlMPR1v1UPPZJWLTQZwxNyoieUlBwCpErAY84Qy39Rs/jnRMVQBHNEJujxCBqwnuOL/PwwhGye4UWRXfg3kWRw4lo9475NtPza7WEmfXoDnfwu5RuDsHvsGVCZ9tmfS9hKZTXWpb1jsmEQtLsl8wyPd43uaplBXIZD5llxuFQl4fIbAmaBc7FfZ32qhcQbaEdZLZxnP7mDXcM6/yeOu/Y4Rhc03+OSpRGAZYtnCDbuha+sGw9ZQ2QoneqDBk9zbKZ8bhw3RZO3XadFPI805grOFQoq7LsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tqDiUS8mhretTZMnQnDOrk5ep47yyKnLeqeWzqMV3qTc8KU1NJUQswr6Vx7YfeFbuHOKIjjFmoSSSXYhua8xrcu9ZKqEZCMeDQE0xzx4yxrXzZz5qN5lCPB7fuARmfxDhzaFuZSBLZvCu6cFdbj0ulVz29rgRZubrHy5J3lhbYCJgFO7R8KwgSxiLYsSVUs3e05vHrGaAMfhcQ20FYmg94sVZ067ZytJPkyMQ/IcNXB+SECbIqQaqbO0rL4CKBhiBracwaTk1SXZUVpyWFL1Dp/RSPxlpt+WF2Tm0I7lgyf79zL7dUaHoGR53k/joiSc3flgliSx8kL3kMUsRGFOkugbF+pmdMrUa1lwWnXLFvyDX0PzTbb6PVVbNLqN2QKah7M3PWZ8mK0Shvx12LDXl+DpgS86cN+/1b+TtHk8THOLNBLrpBsdKptQCLSpCBqZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:05.0940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd1d7af-b4f4-415f-1200-08df078dbced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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

From: Mukul Joshi <mukul.joshi@amd.com>

Initialize fence to NULL in UALink NPA unmap to make sure we
don't end with a garbage value which then gets incorrectly
dereferenced inside amdgpu_vm_tlb_flush().

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d4a5304ee2d81..85276db902b15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1490,7 +1490,7 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 {
 	uint64_t pte_value = adev->gmc.noretry_flags;
 	struct amdgpu_bo *bos[] = { bo };
-	struct dma_fence *fence;
+	struct dma_fence *fence = NULL;
 	struct drm_exec exec;
 	int r;
 
-- 
2.55.0

