Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C0DC4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 23:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3073010EC43;
	Tue,  6 Feb 2024 23:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HIWHZfW9";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4AC10EC43
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 23:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7aCvqPsR5b7s7o8h+RsrnE7XdTevgq0wa14TDiT9kQ0PoiT2ImD18SR8XevNQDbSCtzKDPAyGk8wh6K5TkXVWOAe1dbPHEIj4Dnnql4LV6fKmEYgUAk8Jj8AjyLYsRS4D/d70UKsUszBWaP3gZ1GD6x6rWJosCY4KEgn2I4zRO29hWpJr13vu9zNdPd+vWoxstxZCa1PcX7Tcv8y2CeFhm9rrZZr8lT4EJFRFF0GSLLJ20PbJa9HGrKMcurw8Q7agGNtCLXnKSErtXBgxSifqirVpWFTvSXxR4mSD05B2M6F+Fmzje3MFQ9VovP4uJUjCG0P44N9FDmwTQqdqvgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2poDPSOtSkLSXtsZr9Ynv/SsTltPmrlwUNoeTIVdFik=;
 b=fkGp29Bo45QwIvIhb/ipw1vL2f9mtCAlmHXmioPyoETaOinTqTH6ytEJbnyWJqWsZR0YmQj/JGyx3nJLy6PYlMFnqm4/cZ0JGkhiwmuzkl+iEuCNQ2Dj/ZLoowtZ5f0tAItEJIoTXfKYA3ZBgPvVA1frjW5BiyEX5ow/9AOk0Kg6jkzQpWCq2jjomHSnjl/8j4Zd2J2vyCjcYpiACrU9r9rWLc+oD5iSY/3HZLPaNK+t0Fh7Zfi98xIgTwfeeiQP2mojYA5fcu3TeC+AD1oZkrgTorYvZg5qVrMiYwn/qdN80+A8yVOmfBBgNClqqrQG4Y9dUtjdEuInRDepbHjosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2poDPSOtSkLSXtsZr9Ynv/SsTltPmrlwUNoeTIVdFik=;
 b=HIWHZfW9u84RGZ5bG0RiSuDXif1c8YV8NMDxJUiKa5TpoCh4rQpvk+IQ7kb5vq5EBuzxdPKo+81GOSBZgs+Zj+XUq0G4598TtmaC1L+uU7eEplbXO1z7YxInIQasPvFy9eumrW/vjZCvKgwNmxFaOGYvTLdzzbQjp7GcGVLD5mg=
Received: from BYAPR11CA0100.namprd11.prod.outlook.com (2603:10b6:a03:f4::41)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 23:28:42 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::3a) by BYAPR11CA0100.outlook.office365.com
 (2603:10b6:a03:f4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 23:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 23:28:41 +0000
Received: from MKM-L1-THONTHA7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 17:28:40 -0600
From: Thong <thong.thai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Thong <thong.thai@amd.com>
Subject: [PATCH] drm/amdgpu/soc21: update VCN 4 max HEVC encoding resolution
Date: Tue, 6 Feb 2024 18:28:28 -0500
Message-ID: <20240206232828.21053-1-thong.thai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4c575f-0101-4020-6cc1-08dc276b5add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9LD/sT7T5Y4Qg+t6+OqlUNk10lMZnXPDR3xf/I6x8LvYm5wrpjlHENRx76xdrOSEt0Jxshq0eSUIgaMXFdO15NQa+PAS5wZ5qL9Ac28HaIqkJx8LoS63NekVffLeyauLIssL5qNxjlgVK2FP8lgDv2mnSbnggku1JjzmYbvuFMUufAypcp6sth5bn7zkxA3iN43jEwQHuYGX9OOIOz7IRuM/qoxfKKpILnBC+QhaYtCJluoT6tlP6oET9RVxKZ7KRCVOnhzipBCeIOzDLfMeE7PWRSdxaishaCnvMR043oIpPx7XMW7VWTFG6W2QbEIb0wO31vhEjeXvksRwEC3LlnbvZOEnavJR5MQCpgkulricaMoyT4HvhsB0GW5cuoeeQBJAtXd9YEgg+JOW+jAr0RuX5RCfMM1Mh2G5YMH/BwQZXeBTDSRhoaFr8roX8F4leVV2SVwsDAw5mUzn8K+uWKO+dMwijBIpbYTtl8uWnCoMdpzYaKsh6J/mUw0rcdhHfdzyLqc7zR4WvjcsiwU+nd/TvHl+en/XN2w4jzwEmD1we33pBewUwzjPcFVgF6UcUoNQdvHhiiZQigj/+WU/dHSe++FeAQ4MyrqNYKtsHyDeBPn/MPeCDiV6BTAvdzufx/lNmEd5eO0V+ODGOAShTxuM6B0Pdea2X1sRH5L0bLAe4tuGDp7fUWh8LAkSAuiyGCCV8naMUmgmLT+/nX1VtdfB4amO32XMT3Key9WDZMbUcLL3YDp9nGnWNDXf12tBZ7rAWB8c+lz058gP9yJM2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(426003)(1076003)(16526019)(26005)(336012)(40480700001)(40460700003)(83380400001)(5660300002)(86362001)(36860700001)(41300700001)(70206006)(6916009)(70586007)(15650500001)(2906002)(316002)(47076005)(2616005)(478600001)(6666004)(7696005)(356005)(82740400003)(81166007)(8936002)(8676002)(36756003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 23:28:41.8118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4c575f-0101-4020-6cc1-08dc276b5add
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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

Update the maximum resolution reported for HEVC encoding on VCN 4
devices to reflect its 8K encoding capability.

Signed-off-by: Thong <thong.thai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 48c6efcdeac9..4d7188912edf 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -50,13 +50,13 @@ static const struct amd_ip_funcs soc21_common_ip_funcs;
 /* SOC21 */
 static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array_vcn0[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array_vcn1[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
 };
 
 static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode_vcn0 = {
-- 
2.34.1

