Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA33C54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 14:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CABA9112B4F;
	Tue,  5 Mar 2024 14:31:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b7J/CrJ6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D613112B50
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 14:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQTlSGiFdFvXfTk3VrO6gihoyL5WGoulBpy6q7Di3vI6SehxFuQHzvvFQZ8nTj01XWSNeArAKxgfkBBlQSyzEktVqkAkNELRELHSMbusA0lI+PIggFlZplSMMt6tyttcRPUQ3dJIOKsGyYkcOGJao6+VqfesKRj54X53dFtsyixeZqG53xrGwSUrDihOZQY7SApYKrlTRGuib2FFL2oPTMRvHDa2KeZT+eWQ2GKc1DwzRfyTCrbkukanlqIBAKiQWGxkw4m9EDc598Hq01aErSa7H+c9w7Ea82IYMIO8Yuqm2lPj6gRuCqsv5VrIvZ35Gfm25Et1xi4vxqBQDZLTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k60TlCP02ptTL9NeSelxdv/8Uopr2vTEQedFGdD3oLQ=;
 b=YvIOioiEFpBtV5Z+YGSCtnMRj92bfROuNPlN3N8Kswtg8JlL7KGYbhLmuZBwrN5eo/eyjMJOdqWrrREiqi+bX9xQ9rTG7dSLVCXy6wJJxvH8h25+ON9ffIGJPzD4DcmixnaMOqOnka6EqzoJx7VIKRpMWjHXtnak9UF4Mro/93oKIW4iURC3ioHiFNmcbbbPDmGmc3FuX1EOdCRVi/IZ5qhKy7fn+kb4fYtUMOCj8+kTh5D94TQeEJSMhyIuKZlfcTTaEsKKvaZceSiw7bqHPnra0agj28U9FIoVmybXqEalWkwuI6dRI8RDGRwh5+XRvxgW6ZM/xT+aF1A5OY2Q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k60TlCP02ptTL9NeSelxdv/8Uopr2vTEQedFGdD3oLQ=;
 b=b7J/CrJ689y+6o1HYSU/DZX5jY/K/2/UNaA5Exphj8mBUEvuztJqPEb/ljrROXgTkMT8cOF++3aO5TRNq64LZ0FH2ggzwxP1bYyPeZlq1d+Dj8MQ231bOH62o+3FW+bM0d0D0Lq2etynh+UNCzN0cWzZDWOfZwuHXD7KYPVvsfY=
Received: from BYAPR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:74::17)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 14:31:25 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::12) by BYAPR05CA0040.outlook.office365.com
 (2603:10b6:a03:74::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 14:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 14:31:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 08:31:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: add VPE 6.1.1 discovery support
Date: Tue, 5 Mar 2024 09:30:53 -0500
Message-ID: <20240305143053.1262593-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305143053.1262593-1-alexander.deucher@amd.com>
References: <20240305143053.1262593-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 993537e4-bdf9-4f96-22af-08dc3d20efa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2FQvk7TpA2ewwVejjLiIhToAnPBLdQDivNSwerHaEohrmP7ofM2yQwZDHHh6wwEuLxLyzcK70eElhuT2ZdKwVTmd8csO5nYG0P59OsoeWi4yCgY6kYZec5SehoY4CTqd6mt+z8kztV6G269pzBZ1c3cUsCoimm5L83UCgNIJ7U00pmeaIQgmmRFyKPIMOBN4cf78itV0NSW2m9D/sRzfEdcrBEGIoOKMs2EzrQChuCGkpQOFVYaKRuktq/BmYRLODteajnX05DZCz5Wq5DxFpcvlt4kkTg9qysdfMRELelCPw0z3Ay4F5O6zEWFYLu0tF8GRye29NFOzRA208r5kIk1FlSx4wJG0Bt6oI++QSqegeYdYF+U3V/4trsCuURbjgk+h/kxT+xmYe1EULubgBppDvJLcg8ks6ub74JlqefLU1vuePjFP8IAr1M3zuEgLFXKtjSTfEVBoLVp94h/p/ge3WotN08NwLP3zmyHwGg4kyQm4KmYDqMv8UZhthsiMgI8OnGZUjOTHDp3v7LKYKcEKswdX9bYyFndZ2nEpB4GPb67m8pkotTONOth3eUOcMugKPOHt9XQEKcJUpNC1oD5lQGb2mdHyG/FytyZUIDyNn2sUd3uwGqPl4YaIFYWL+UoB3q3eS0vYbZegWkU7M4v836DmtLhNopPFhdGRrmzwdz2nfaEuNDImBTZ7FjV9jhFL38CMiMK8+nI3kz9zIgcwnie3ox4t8JyOH4qEfeOHl7iCtGvjyrMckn69k6e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:31:24.7095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993537e4-bdf9-4f96-22af-08dc3d20efa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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

Enable VPE 6.1.1.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b6bed77b454de..b9209e6aa438c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2222,6 +2222,7 @@ static int amdgpu_discovery_set_vpe_ip_blocks(struct amdgpu_device *adev)
 {
 	switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
 	case IP_VERSION(6, 1, 0):
+	case IP_VERSION(6, 1, 1):
 		amdgpu_device_ip_block_add(adev, &vpe_v6_1_ip_block);
 		break;
 	default:
-- 
2.44.0

