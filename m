Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED10C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 20:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8132010E779;
	Thu, 26 May 2022 20:39:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C091310E779
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 20:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9ZMHunvSgJ1nXw4kYB6EI3mMRDt51o4FRAUrCnDP7Q5TcpImkR26QA/s54wRT8TWniYyn6ZnbZOcY+N7aoLM66ikYScLDPfuR3OcrOgUv6svVv7sH7BtseG35b5S5GO2HobeGkdtIFGbs/+VHCxEUY82awiR2BYOyWbtMJUxQS85B0PywLi6tQ8fcR+Tr+J/u0OW7Y6uIcSMXnF379RVHGLJO1o7tyRJBwfKjAbPg26eEUGqrNUvg9tqtQbXvfjLh5Xrx2NNPb9U3ruc+pqvU83/lKQRDs0/DP8CGG1JTXvTFgKyqfTkSE7T6ApzVoNbuNVrBtqKFA4asR3YzHTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0fIwk77KqLLxjS8KeTU1lgIeQnrCVzV4yKxqLg1uCY=;
 b=h32T/y+x9J5LveFfSwPgjzlpUd84gpk6ePUf/K7ZMBuF9R1NCu6Mw/YdPcMgbnimFKRhW7mzm6pwxqfyeKdRKB6tofg83H4kVZz4ulXzBnN8g9DJ5Xapgk8n6VtO+be7DAGaYHobG4+8dlumnScKH6FS8wiIvFJWa/EJepJseNtMuWSWT14YhYiXzenPGJKgDkczjzw+wyIkui+stb2jZoKVPjAeUeA0GNhgH/XloUAZ7uG7ng3kYivwMdeHMDSKXTw+/GGxClhMBvlbRyb/Z+4RIhJC+6BtAUVR5C+DMdUpSWW7YZIK14DMr+yZP/p3e8j6oz9RvNfz2NXpt1Tszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0fIwk77KqLLxjS8KeTU1lgIeQnrCVzV4yKxqLg1uCY=;
 b=3+x5QBTpym9RUUF9MTtFx7hgECTqYuAupg1suTf+A6h1eVGUGPWL/unnC/dE0HglEtmn2TDNhi7YWqIBoKjbHBot/FOTCr0kqXjxDSe+W3Xq0CJnoMG5nNlOS/iqimYzqLjjctxecSeZ9D92Z0kuHLYSKr5TuFmHnl3utIbtqy4=
Received: from BN6PR1101CA0007.namprd11.prod.outlook.com
 (2603:10b6:405:4a::17) by DM6PR12MB5006.namprd12.prod.outlook.com
 (2603:10b6:5:1b8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 20:39:10 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::1c) by BN6PR1101CA0007.outlook.office365.com
 (2603:10b6:405:4a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 20:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 20:39:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 15:39:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update VCN codec support for Yellow Carp
Date: Thu, 26 May 2022 16:38:57 -0400
Message-ID: <20220526203857.100936-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a277b963-1970-49d0-5044-08da3f57c9a0
X-MS-TrafficTypeDiagnostic: DM6PR12MB5006:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5006101C16C1982C3CB0BFA7F7D99@DM6PR12MB5006.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIvGRFAIeS62b61bQvqGBTC+u3oeaHqv44pVWqeatNJauRq9ldrXtuniG3JhJ/zjQLEUbEiY41sa0br7nGEdGShxuYwn7TuZoftK92Ub5r2ePZvq/1vtX1rvS7bmc1Rfz9VY/b5SCG7b3eiEXltLE6++A5F+OIfrTm7QIiEnCqqAJ4WKLsggFz9T6nitSSOvwGBkRs+dvSbqy/gfR7YtvEpSp/Lv/RQeEzW4a29e+Alp29FdOYZ9AwaGylvcgv/tKnyFU4BCVB9zSMpYTvaFZ6Pb9/YxdQUzb2ZP5vsU0IKOCHEYXfYBlm92859BaTrYA7+lsUZENCfCDfTUIGBH5RuZFGYNBEeW0yKRI7/2KUzdLs4eJDyMnnQk68ViFPWIIBHcurYwDRR1JSBJYX1xEZLz5+SWEAdpW5yqAAw6y+StkactrhMYbFhskEekx7GAHBmt08U4n8kWkAiLOtioooi5OOwr6f49BpPNtztmEr++tnDfQt1oPzcK2ORoWQxvhxwi7a96GnwWruKo2/68a6HGFBfzy//f8u8zJD99q4lMfrOT4nGHywDnjYWrqk14n6ANq7HuhjCQX0hPW1n8h9x25/xx197wPCq+JVqjO5qBQTnv+9MNOMdzgN6GQR21WQHX/WXCwQDn0f8R+toHcm9GklHZsKBkTNzVzZXISurMh0JiDbdCa+eKLyRzcdgX8gTPkyPWPbQuvbAUQ3YOxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(316002)(336012)(2616005)(47076005)(6666004)(426003)(1076003)(2906002)(966005)(186003)(6916009)(82310400005)(16526019)(36756003)(70586007)(70206006)(4326008)(8676002)(7696005)(36860700001)(40460700003)(26005)(86362001)(356005)(508600001)(81166007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 20:39:10.3152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a277b963-1970-49d0-5044-08da3f57c9a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5006
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Supports AV1.  Mesa already has support for this and
doesn't rely on the kernel caps for yellow carp, so
this was already working from an application perspective.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2002
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index d016e3c3e221..b3fba8dea63c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -170,6 +170,7 @@ static const struct amdgpu_video_codec_info yc_video_codecs_decode_array[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static const struct amdgpu_video_codecs yc_video_codecs_decode = {
-- 
2.35.3

