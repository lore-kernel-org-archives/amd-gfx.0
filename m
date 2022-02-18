Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E64C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27DC910EFFD;
	Fri, 18 Feb 2022 15:05:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D97310EFFD
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clV5DYifb+ADLSMJX9SRQz42kAT488uTxakZ7dR3/ZAgcdxM3DqxqhW1hANU47P9pZNAxk8Cj9ENIXUWuwA0rmQAI7D0g9x24v/n3OOSuO/VTGwDuuqXPdrNgij722Dlr1ykDV5tx5IhaHfT4UYwzJf0oqdVnkroc7fvB5sipeKOTi9YK76o03bpbl9O1c7GhtzatTVBpmJTpAyjDe8IfICO4/vve5Nwuhu4T/yj1r12+wj1T0Ae1a9pCTHyLtYcMIMg44L9edz2SYAcrMVE4AZQDLB+f4N8WMTXaw4c3O0naiQkgyqETVLX61Y4fSwYzeTTSwTMCfD+GGGVhE4MqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIJ9B5I54hzS/QfPMshW3hZSzyskbAw+SHbPSnd1Tqs=;
 b=Ng1rswcY9MsoDXRpVzT3jEzenc8SCoNeEOyddzpznJhbzWbJkoI1KQJG6qWtQcLw6A5AVCdFd3uOt/QWdWlBP1zuUkEJ9S4ZAikkVse3EzkS3ZxPMD19Kb97AChAurBOpJ0D3q3TVEVteFQsCmbtXgROQ6KiuiBrxyPD9vklx2GIiJoVUMz8jUlcySlXK1WkeGFuCmDqLXOCxwpMM0KUjf2rYlQMKdMXFD1z3VNkPKoS6qEdhJEeoJI3itSjSRYSfwNrUzKRXvRFEUO9cW7thMBJ1xrBKwHDekLnos8DD7p1xCLF9MHNtv22SMZYIFVjD0i+l4nfVCFbbb+jZ8Is2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIJ9B5I54hzS/QfPMshW3hZSzyskbAw+SHbPSnd1Tqs=;
 b=kxzPEEeA8gs6lgGRUTrE13TXQgXlz8QHFQ2ve1+3VnYIdFor5Ke83L5ye5ZyBxrHzu5aObF1cDNv0gDGHS7AFiTF8WlJydDJyWGTP6n/fSxi57ou39vkpQFTRqwnNTCpuqbBPe5Pxyll+Xd0Mza5henuJWN05xaCrmUZS456OU0=
Received: from DM6PR07CA0087.namprd07.prod.outlook.com (2603:10b6:5:337::20)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:04:58 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::12) by DM6PR07CA0087.outlook.office365.com
 (2603:10b6:5:337::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Fri, 18 Feb 2022 15:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:04:57 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:04:51 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/display: [FW Promotion] Release 0.0.105.0
Date: Fri, 18 Feb 2022 23:03:27 +0800
Message-ID: <20220218150329.7976-11-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4476844-114f-4bc6-fe2f-08d9f2f00769
X-MS-TrafficTypeDiagnostic: CH0PR12MB5236:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB523641A9277BD1BF16A700CB97379@CH0PR12MB5236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ax9Ty6NVq5eqljpMEvTCe27ukTpWCqNSGEl/B8HsfBgxEtYNGreepLN52pSAECopipYGa5Nskg8ADr+VQBf3TkiPEnP6UCMEpNHbxbHUss7Verxcp9NmBXXqXkyBg1z1Es+TAshrp4XJ0iWVsnbPVrZvatAdPaWOCihwJEXdZ8Hh4CuO0kgN4h4QPDB7ldBPnZ9+skXqGodgOSmUpaPcIHfybfLb8XZwKWjDPo4pyvt6xbxZLK+RURU40muZIqrlRXme7CAwPtgn29nz36YKs4YGlI/mBvSn2XVXaljZL9X3rwDlgKMYLyEuj353eCx85gFYkScJbPxvQf3ZXKr6QYjFY5xUNXoNrBd3DRu5ZC1NVicNV7JQS0zC07iE4NmYSxPCjq8+s7ofPBnO7U5X2eOD2VYIJl+DaphdSJIIO5tr6J3gv53448wB/xPmIvppTEUQ5M9pYreL4vYmpTNxWkGJI7fLbCqDsDK3RxtIuOKfViK7Df61aiNo3gDOwImGaL5v5wIzlgj8X/8K+F1ch0sYGrhYecRzqf6F0xaOaSI1q0wvN20kQfm1eq6U7v8xtoJGuZCMfCtaXM6sSJdG7wCwE2VT3/jQtjwjJmspSojXAEkj7n0/Yk9UmTQ3vrR7nTbUf5XwOgelvEDSEz/U3+8Kn541vZxYv9QWw6O8PoWde1MUmJEGpCGqCQazSFmBmQp7P1KpSQANsKF1ETx9BA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(47076005)(82310400004)(2616005)(16526019)(508600001)(316002)(36860700001)(26005)(186003)(356005)(83380400001)(6666004)(54906003)(426003)(6916009)(2906002)(1076003)(4744005)(5660300002)(8676002)(40460700003)(86362001)(36756003)(70206006)(70586007)(7696005)(44832011)(4326008)(8936002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:04:57.9001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4476844-114f-4bc6-fe2f-08d9f2f00769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index bc889492f9d7..d906ae8099b3 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x1422ef84
+#define DMUB_FW_VERSION_GIT_HASH 0x5fb9349b
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 104
+#define DMUB_FW_VERSION_REVISION 105
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

