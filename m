Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC465C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D503610EA33;
	Tue,  3 May 2022 20:09:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 596E710EA1B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFlqG1vAT/skQzrjEhIFeVCbmfLuXVQYYhcaAq6i26HfaghYCkzgN3b2PMb2bH7j2Lakh4OGZoHLpPlz2/WSopzMRLCls9SQ9aJB6ZRxjLmGUHvbuSLnoDTL/WnZrbQhBENlbgdDICv3ljDLT0Wx3qzsKqEdxyI1xaCkt7LPxr+6Een2X2GNo7C7whenJAEpE6eyPSeGGTxZnMajmPxRAQuq7JkT2bLuqP4cdd+0KzlLSpy8BQ1lZKUKKrZbp8v7FpLlovl5K0kLKVIgl6ultHhuZxceJt8fP5Xeq3GNAqVNFYKHUMfSpO/4buwkerBevTgvEYivhnoNNmeeo0DfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWl399L3zDsrAgMxyiqIjQNnNiVWuJd7ybQWJQmMAsE=;
 b=hUslmJq2pzytsop1TM8WCdIwpgTmmijmAyMTQG7hCWUrbdGHaSndjSm4E4XzQ9KQk8JYJpX6PcSrETcCbuDHTCYf886WWfJxeteJ+74xtBIhwdIHnsFHmY7G5EUk0zImRHoYt+I2U/vDY0EOPs7dl0UG69aqc5Sfm2gq0o9ga3vlVW3Er6WEHSmvpHnktCDxfeLSFSN2zjwvWhl69oSZH3mZXxk56N+S+Hv5s7aRHIXxESv6223yOKuzSvFey39Lj2U9YQid2laVQVI3/RelCQxVrBO4TEyeYYZ+++MlWAbUpdtjEKX8wFymFXSM19MgAiB/WZp2uVfG4DnbMq8/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWl399L3zDsrAgMxyiqIjQNnNiVWuJd7ybQWJQmMAsE=;
 b=JtRcRatxI/tIl86+Cccf+EWIGqnt6fgkwcNkVLc9zaP+cmZ5ewwpgB5zcVG3R1erHYxc/1intbcC4OaV9XuNwQ98SN31xBudIzzDG3nn8037UMSVlfa9VVcHrjHQwSYX+VfOK982wajXXzp/OKHccyXxmzuKOktXRhGPPnKx854=
Received: from DM6PR06CA0066.namprd06.prod.outlook.com (2603:10b6:5:54::43) by
 BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Tue, 3 May
 2022 20:09:20 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::e8) by DM6PR06CA0066.outlook.office365.com
 (2603:10b6:5:54::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Tue, 3 May 2022 20:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:09:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add support for ATHUB 3.0.2
Date: Tue, 3 May 2022 16:08:50 -0400
Message-ID: <20220503200855.1163186-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecc7e539-6b33-4297-842e-08da2d40cf0d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4100:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4100C6BE5582E55F5D656A63F7C09@BY5PR12MB4100.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XTCNMatzQCLNBUVBIDZwuUIAONgSx2f0eA2JP/T6NG4m+ghgKmAj2bdSJLFqqcPkbMQj4eG1+zHO79oA5gSlyiM5lmlTd4s1uoJfCG8JNo1mt/jnS8VQ+7DKaZlHQi001Pfl6RVsmVOgfWwb3nbaZaXIlnsJ76YkvYQzsxYVP87KOkbQLzZ0w4JIoY697iJXeH4PXWex6uvtWsDJeIUhKw51MtH/aZL3SLB0yI6niTE1ovzE0bFMk0jAdqquKVeBrul/LPJ5MBhUBdqwDKPmvcPw2/xx3GA5tsNNQQGLz/7DC4uyedW5BPyqd8SBBDja0OcpT6jVoflNOdACZfWwmREqAScogjFMDZLtmpVpxYi1ek3nK6FTvaJIyxaSbewOnG2RtP317onnW31PuWJZFzc6zKlfBaP1soQsIm2vyd0XQEgkiupymyShCpX+6Y5b4MleFvQjBvxNPwhypXPD0XpnbGwlA9SKE5PstnSpmuzAFjRGcP1N8+fXH8peokKqWNN5+6A1BG+ZOGqKAbK8TCpycSDtjsI7rVefue5DuphH1aKIImXErHoKGA8SImqlcDvWGOjj+bOHC/oXidQXKp4HlFEzSGp/6yUktXLDayHhB6ahZ5u1c398cIzScJoNPjev8El/YXO7gDJnccN1G8n3viKC8DiUgjv5Kw6jvQbk+8J31+KX8F6PdQdimei/8RJ7dx0My+TNlTFk3EPRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6916009)(86362001)(82310400005)(8676002)(4326008)(4744005)(2906002)(316002)(54906003)(7696005)(36756003)(8936002)(508600001)(70586007)(5660300002)(70206006)(6666004)(426003)(2616005)(26005)(186003)(16526019)(1076003)(81166007)(47076005)(336012)(83380400001)(356005)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:20.0335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc7e539-6b33-4297-842e-08da2d40cf0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Add support 3.0.2 to the ATHUB 3.0 code.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
index eda07cfe92bb..33a8a7365aef 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
@@ -70,6 +70,7 @@ int athub_v3_0_set_clockgating(struct amdgpu_device *adev,
 
 	switch (adev->ip_versions[ATHUB_HWIP][0]) {
 	case IP_VERSION(3, 0, 0):
+	case IP_VERSION(3, 0, 2):
 		athub_v3_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		athub_v3_0_update_medium_grain_light_sleep(adev,
-- 
2.35.1

