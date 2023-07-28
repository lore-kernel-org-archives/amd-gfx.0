Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED932EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 22:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C5110E79C;
	Fri, 28 Jul 2023 22:14:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB9410E79C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 22:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtJswcJUqXP3u5lVaekNXyWBhWblnaIiCzvIBgElpuCqiUYTMc5H1AOK17YiNTR92nZDoYX+d5x9kgutqkUraBeDX1zaqbeHWxvTQRutG3nfFfnCerLUgrwG4k/kDXFrROvgtsP0JhsfWvX7MSPlrdZB9FeviK+0zzfb2/2WUWFIQV8Nd68jattAnf2VbqjELBUnDE1PC3sJ4CgCWUDCxhBVmzcp39RcEyDwon8/yOzlboW4HlXz87bvs3g+DQM9wqRvD+ARyZyASwkeyo54tYusQ9k4az3hJh2CGotpmQNH5HmZLukmTHulU2bRDkAhT30slyFQKAvhbU+3EY6J0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcrcASSUJJ6dmMboVICbHcnJFyisFmsOPdtFVyu1sr4=;
 b=oI9OgOrtdOSTEjpnGSVufoVfb3eL1o7QcXJHnz+aaZCTKCvdFfSWGM44/+65jEJLxZjrVie1+Pk3g1fIhMlsxgjS4tixhkJpdmBkMMXX08vmxuCLfQ/vXLlk1yNJ1Hf+uWt/R3MzRR9MjZEj7ERvAQV1NUGxImto6U2a/RRuqknqeEtRACcjpEjsHamJhnZAB97QVNg3I5tMe6YZK/TSKKjsbW6EeYBivI7Q5CnXFXnfZ87u4FzVoaoiq6b6LS11GQpLT3RUSzZEsx4NlHFjGvbDzjtLEEokUfPGXeJ44nNUYG2gCwYGPdm85JI36nq7AEBIeAbusCJ3PV0cp0sxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcrcASSUJJ6dmMboVICbHcnJFyisFmsOPdtFVyu1sr4=;
 b=4C7WtHibgTjTrEVimQh1DkaxA9ovAG6V4Fg9ZHxhnzUAQTIEMQgTVcYSS6K5FncsUUwiTVTLUxws2HKOL48H5zZQ2DKVaUY9h9nXlJBKOTn58au3wj3PdMIxdhaIvQ8YqCxycZxxU5ySeqWiZYxvfsUbfdx2+6+szXwMNPehvws=
Received: from BN8PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:94::35)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 22:14:08 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::fd) by BN8PR03CA0022.outlook.office365.com
 (2603:10b6:408:94::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 22:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.35 via Frontend Transport; Fri, 28 Jul 2023 22:14:08 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:14:07 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix a regression on Polaris cards
Date: Fri, 28 Jul 2023 17:11:43 -0500
Message-ID: <20230728221143.37363-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac9b036-5d01-490b-bbe7-08db8fb7f6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jRn3ADhc4JbWeSsSsyBkdPibjvsJcZFKyXVx3c3yJzGf3q/2MV7uxc21ldXZZMP36ICwIFsV161Etz9o+mNsb7fPrksE7uu5q/ylU/QSeKsrIJgDQKq3+G+d0GC9SS8Ll7Wz9TEpmZe40H/7pbtdUj2rNr1+K91P80aVTT9GwUylTHjaf8kB8DYOf5aogbYdGMeZCdo7UAAVVv07bVSBiTkvMS3kCoNMi/IwnmLW9NfaTPPoAZbnOlxCvboNUkH0vyx69F23blkm9DeUtYj9wp4wUMn9ZuECl1PTGmQq4Shf5az1+tH/cOnPnFAuQmwV6JwTMFlYbLJSsNJfFsTt88xvGfqh9DTMG8OQo9paUVurAUVG3DXGmYlcHD5VIgUyu+BV0QWxJmgLRQxpOtUNzaPAASd+v8n6kBmIOhWzG05nUSaCzFut5n0ZeF5ncfkKXi10AyXnUPGl7EXB4KCHRivbQq96/niNQcNAKSSSFlzwlhsqJSZrkktjAe2pB0KIYUhfD31+nUepuqUlq9LHFtTJovgXF2tmYTO/SaNdoQXNVuM/Q5Vvd2i0cXypk0E5k0Y1FYGSElF4OZA804msmhFJcwgguCA8AIDYI3uizQPFFcRjg8BkkCZ9NAoQ45hpDz0qm9octj2qI8/OqxjPvzf32mWfnoAhUuBLngZjZ9NW9rRMUzbHKD8ESDQSUnKbZmsokujL1wkEu3Hg4/+ulUJt2tWmNT03DQiSMnbQeMozqOkldGGtLEZSx0bnP/o
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(426003)(2906002)(83380400001)(6666004)(7696005)(2616005)(36756003)(336012)(186003)(44832011)(16526019)(5660300002)(86362001)(47076005)(36860700001)(40460700003)(8676002)(41300700001)(316002)(8936002)(1076003)(26005)(966005)(356005)(4326008)(478600001)(70206006)(70586007)(40480700001)(6916009)(54906003)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 22:14:08.2759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac9b036-5d01-490b-bbe7-08db8fb7f6aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
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
Cc: Klaus.Kusche@computerix.info, Harry.Wentland@amd.com, Mario
 Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DCE products don't define a `remove_stream_from_ctx` like DCN ones
do. This means that when compute_mst_dsc_configs_for_state() is called
it always returns -EINVAL which causes MST to fail to setup.

Cc: stable@vger.kernel.org # 6.4.y
Cc: Harry Wentland <Harry.Wentland@amd.com>
Reported-by: Klaus.Kusche@computerix.info
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2671
Fixes: efa4c4df864e ("drm/amd/display: call remove_stream_from_ctx from res_pool funcs")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 943959012d04..57230661132b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1327,7 +1327,7 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 		if (computed_streams[i])
 			continue;
 
-		if (!res_pool->funcs->remove_stream_from_ctx ||
+		if (res_pool->funcs->remove_stream_from_ctx &&
 		    res_pool->funcs->remove_stream_from_ctx(stream->ctx->dc, dc_state, stream) != DC_OK)
 			return -EINVAL;
 
-- 
2.34.1

