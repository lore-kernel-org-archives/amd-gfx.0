Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B05AC61DA4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 02:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7378110E088;
	Tue,  7 Feb 2023 02:49:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8FE10E088
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 02:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8KA621gSkXkMdHDX/SaFIn74keL/G/zy4S7pbwUXrwfyJM6iFjYxAVchBQ1ZTZg11LzhER9CFHmKZGExVk0Bf2oIr6Gnna1K4krgD1+8RrbzJc+GSMHT9We1Qk4gPyls9Fn0LEMxRtGKwVbSJUDSbHTRS20M3B3KzHHFBi3camWtdvBqVCOzXYL9tpdZ3qeE2CD4rVz9rswt9ph1KvqfXN/ijPN1VOgJdR+URtrOa26dxpaRhQX9nGi3B4IPO0Sz6Ma3ylsJZTdhJ+xVptMq11YMslSXivDYLih8mk+PZ1gyWF3wsrV/ETI2hUbrcAbhWwztWEJIDwhsmj6PrXWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/8uFOUyqK9q/XiF+CgAeuDkxn/NLM02ZpP0XsV8Rss=;
 b=Nl18NDC3M2pXmdUQHlfjJzdEdnpX4/uwWo/b9Qou9yc68XQ/IceYhSLfFytCYEDy5PBZDw8kRZ8PWurvfu2FRPDcLlH9bWrP6/3VZGbYl9GsHGVUzEOVf+BKnB+a36c5Ireg38b413rs3NboC4z37uMNWSjyTrYDjPwPBcTlEtD6Gl3c97Ya314z+IKFmF0+iFJ0Gmnv4ac373Cys/N7Jfpe/8j2Yv/y9JFrVQDWynBX8bbDgXPRDExxCmvjgK5Py4ilvSKicRtUNwWP9PwaQSn1Ic8VDxk5Kks5SewZCgf+/MlHCUt3Sko0v5XNhihptWYqdOdoeTmwtJXBkbt1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/8uFOUyqK9q/XiF+CgAeuDkxn/NLM02ZpP0XsV8Rss=;
 b=OOdBMeSgYOtkM04g0LD3Qq8WQN6OfGMMpaiHVeao1AT2oDriN93/bY5sgdH6LlzgQ5iPBMqgPvpFVvscqtvS/8blwPZ23Gh6EIIeNE3xCJub7KPkTJgYM5F/kVU9i58HztmdpSVIVuxS0F0vRNoxvLMcrjemogDU0Q4X3eu1Avc=
Received: from MW4PR04CA0034.namprd04.prod.outlook.com (2603:10b6:303:6a::9)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 02:49:18 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::3b) by MW4PR04CA0034.outlook.office365.com
 (2603:10b6:303:6a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Tue, 7 Feb 2023 02:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.35 via Frontend Transport; Tue, 7 Feb 2023 02:49:17 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 20:49:15 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: bump SMU 13.0.7 driver_if header version
Date: Tue, 7 Feb 2023 10:48:55 +0800
Message-ID: <20230207024855.1589467-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207024855.1589467-1-evan.quan@amd.com>
References: <20230207024855.1589467-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b495fb1-fc2a-4d5b-1a6c-08db08b5e80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWZXT9AT3HTWIJZmwBdHtFXmhzgIJL5QQAwGG0A0ES2V2rSqZGFfq3cUQ7CUBavFs1F8LUhrCCbmxteW5pPdK9QGtYtX4WNKwcekTZqETtiX1nNEVdhY1WNq/hvNqiJEgCeEj3KW+shniVgYO+J4DVck8WcCrosTvAG2j0JY+hbZJG2+jICDgCw5nzhhI3oQmUUePDgjichIN7CcRkto1B+kQ1wlSv/zdjbsqp+YhxPD3ZquUVHtVt0VoxdF9Ij7eYGJ4c65kFTYmrUWFjSeRx1Ho8OiU6w1NwU137BATMvBMJHmyqzW2+LP/byS2tlEy8e+a3CdS+4Jne9tl2/9VqlHzFMJZgwK7MhQQXOaxVtChklmWq1oPwEW/bfZVe8alxKSPyxv6iir9P0zbA7N4mgncJMyrqCUQxWK9DZc3YJ7cbfI3W1bruHCRRYQz4UGvGVKW0y63iYRaqrDG2ihGFW9gKkigjvY6Q4piUGy0QdDPOdLJOhI5ZJZ0oUtSLMPnATI47erlyfXljUuPMP3E5u22WUCjlOxqbGIMv/Jb1yVK6NAYa7QyWLAUEiV3ndx5gELlyaRmua+ut7DFptE0l0tbMKsvQKvB82UwtJ1NYngnSBNR3NpxphWbrW2QTSEGQRncI0I8VduLSgMbYLgTk6UTXQIlGvSrkUfLlkySKBSZ4t+bPcB8vp+0OfvfzWUt9liN0k9IQhDrGLGQg7p8rIly328jrHKY73lCfH+Nh4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(7696005)(40480700001)(316002)(6666004)(478600001)(54906003)(82310400005)(36756003)(86362001)(356005)(40460700003)(81166007)(82740400003)(2906002)(70586007)(2616005)(426003)(47076005)(26005)(1076003)(336012)(8676002)(70206006)(83380400001)(8936002)(6916009)(5660300002)(41300700001)(4326008)(186003)(44832011)(16526019)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 02:49:17.6992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b495fb1-fc2a-4d5b-1a6c-08db08b5e80e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can suppress the warning caused by version mismatch.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Id3331a329ea9b1dbc45d8a4e773af1cbe8e21a27
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
index d6b13933a98f..3446a569057a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
@@ -126,7 +126,8 @@
                                          (1 << FEATURE_DS_FCLK_BIT) | \
                                          (1 << FEATURE_DS_LCLK_BIT) | \
                                          (1 << FEATURE_DS_DCFCLK_BIT) | \
-                                         (1 << FEATURE_DS_UCLK_BIT)
+                                         (1 << FEATURE_DS_UCLK_BIT) | \
+                                         (1ULL << FEATURE_DS_VCN_BIT)
 
 //For use with feature control messages
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 40adc4fa808a..1c0ae2cb757b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -32,7 +32,7 @@
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x35
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x37
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_10 0x1D
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
-- 
2.34.1

