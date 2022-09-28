Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC33C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A34B10E9D8;
	Wed, 28 Sep 2022 19:42:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E7510E9BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdkVqzuyOAN6PBELYa2mOX+Kha41S1sk13Qas4VcbFwAG42qC0F//NSs6XwFzVffZuJtPSsOBzKRN0PHErFz5aZT+A7SluOFqfWFc8OirNTnejpyCfQNNjuMeMYUKvKw1ZNkTpOaoqVolS0m7nhJYHaj8SKgQgODc7CO64e/VC/ztHzGh4i3EFJxf+iGMQsZj2Rmmk1dZrwZ4R8gjRUNON10ISqX1f3wkwwz8k+0ux2izFMVER+moOG0zQIgODtyXsjaCL78/oMqPycTI0Q5jAUHzxB73gkiE4MSSVkOjjbN2fr5QEqGn9hbZLOMrGUFIBNZmhIJJR2Oxyk4H8erfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBph53wShqp8wCpUr/mTKwGXG8zLjGYNxBUyLfeH14Q=;
 b=VdkHKPlPqQELhKgX617j2YOxcapT4/ljZOTBFQjw200o15/0EWMO+Wn0s4iqJfcSEH58YBfAyMUTPNh9jFAGYPYNtg/gPPOO77ahw9HEh1NkygTtShTGW8GqCDru5neBAT0sCyaW1NyPe38w5uR4UUfWzmXwgHqv9d7eFM5LxoqCGYOfrnJm5sWcm4RypSJySVw4aZTVq79RJYOLExFpjiSyMbUxfx94sVwPPaglTsikZc2Q1l2VarsItwHAODra41W1yE1G/niEj35xuNf9/DQY8egoJ6C1FdVUBJbdO2V9/Lzi5FCYfP81reJl9EJjeMoR8kl0GDscb3ymGthmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBph53wShqp8wCpUr/mTKwGXG8zLjGYNxBUyLfeH14Q=;
 b=UJ9X1tWq2Lq28NY+hf8j7ZwvB8Essat7J4gJTJ4+hsQgiG+GvuISgr/y0jo4nwgC+xhqWXTkuWpxqv6M70cNgkutLvGc7m4k7L1gIPyLJxYazuu0ZFfu9OFrnGeV+/SYmBZaDqbGyNNN3UOvma9TrBuf/xprcblZEAn0fC6ZXIw=
Received: from BN9PR03CA0662.namprd03.prod.outlook.com (2603:10b6:408:10e::7)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Wed, 28 Sep
 2022 19:41:50 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::72) by BN9PR03CA0662.outlook.office365.com
 (2603:10b6:408:10e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:50 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:45 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 35/36] drm/amd/display: update DSC for DCN32
Date: Wed, 28 Sep 2022 15:40:27 -0400
Message-ID: <20220928194028.144879-36-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f3d964-e272-49a4-6d3b-08daa1897cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4YpujSPF+zspgfQPHF5oXN4ITfBJaWaV+0XvP6aW9KjDcLFd4/awzRQ7TkV9N6vGsZPheV4rpaw1jpI2rJ5RtCUJlAwjutTgJ3SQ7R1chg26WnndD6FVMnyYdfOa6p0cU7KBLm/Wqq9oHtXxFUthnPW/yVr5Ow1qbQXiUgu8eZqHyFBG9Ba0gLrRNnIH16gnohdM3ie3s1NNGEEgCxJiCfJ/hOWfmfy57USEFyn3aSzNSNTLiSlD/nV93DdC4lFPcOOQlthK7f8q2XTD5hWvQo0vQ35QlPwQSRP/nCa86dDf8xGNHwJHVgKz5KPQ2xfHKxHhMdzNILWtWWKsbIJQ6w0LYcSd5DrC3YHR9YCjLaCvSNfefTFUBz9O1oWeAl7WAdMosywEvy+LJq9Q7Jt0ut8UIW8Kxo1AzgxCEtJFtfjUjQM5gQ8lfpxFEEU1J9Qo/Kpw4jt5AoeZOdoSm/zVv0BU/peDzCcDW+nJ6by2vlG5UuBCu/QtSe7K/pWgqsem1OVa3LatsIhFj7H1JFoQ+vo0nx9UIxDEpQsKyZtZgfbHJDNTR2raX9XspNU6lg4GReFOo523+WrEQ3MuhEO+KhOO81k7W1qQfaa37n8OGbIOcRhbWD7webi+23B2Lx5y7fo2IRA/70y/YokUdT2aSXWiVPPxBjuJpUKPuLamLDxDrJfxR5nTpX8T3PfTB2qNv5nGIp/BVLbjEf4kjaQHE4bzN5Md/r2Fzl+yZZEhMimHt5tOqY2iMMy4IfnrqhWZ+bRtaNgNmd0r4bBdsAB4H7cQpIyoamkG08pB2NqQKdI0WLiFtDV8OtANDJ/ziautcg13sDaEJgGRnHGGDem+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(86362001)(82740400003)(44832011)(356005)(15650500001)(81166007)(2906002)(7696005)(40480700001)(478600001)(6916009)(36860700001)(40460700003)(8936002)(26005)(54906003)(5660300002)(41300700001)(47076005)(2616005)(70586007)(83380400001)(6666004)(4326008)(426003)(16526019)(82310400005)(36756003)(186003)(70206006)(336012)(8676002)(1076003)(316002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:50.1691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f3d964-e272-49a4-6d3b-08daa1897cc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Update DSC checks in the DCN32 VBA.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 75be1e1ce543..8316b1b914c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -2252,9 +2252,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 		if (!(mode_lib->vba.DSCInputBitPerComponent[k] == 12.0
 				|| mode_lib->vba.DSCInputBitPerComponent[k] == 10.0
-				|| mode_lib->vba.DSCInputBitPerComponent[k] == 8.0
-				|| mode_lib->vba.DSCInputBitPerComponent[k] >
-				mode_lib->vba.MaximumDSCBitsPerComponent)) {
+				|| mode_lib->vba.DSCInputBitPerComponent[k] == 8.0)
+				|| mode_lib->vba.DSCInputBitPerComponent[k] > mode_lib->vba.MaximumDSCBitsPerComponent) {
 			mode_lib->vba.NonsupportedDSCInputBPC = true;
 		}
 	}
@@ -2330,16 +2329,15 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				if (mode_lib->vba.OutputMultistreamId[k] == k && mode_lib->vba.ForcedOutputLinkBPP[k] == 0)
 					mode_lib->vba.BPPForMultistreamNotIndicated = true;
 				for (j = 0; j < mode_lib->vba.NumberOfActiveSurfaces; ++j) {
-					if (mode_lib->vba.OutputMultistreamId[k] == j && mode_lib->vba.OutputMultistreamEn[k]
+					if (mode_lib->vba.OutputMultistreamId[k] == j
 						&& mode_lib->vba.ForcedOutputLinkBPP[k] == 0)
 						mode_lib->vba.BPPForMultistreamNotIndicated = true;
 				}
 			}
 
 			if ((mode_lib->vba.Output[k] == dm_edp || mode_lib->vba.Output[k] == dm_hdmi)) {
-				if (mode_lib->vba.OutputMultistreamId[k] == k && mode_lib->vba.OutputMultistreamEn[k])
+				if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k)
 					mode_lib->vba.MultistreamWithHDMIOreDP = true;
-
 				for (j = 0; j < mode_lib->vba.NumberOfActiveSurfaces; ++j) {
 					if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == j)
 						mode_lib->vba.MultistreamWithHDMIOreDP = true;
-- 
2.37.2

