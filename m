Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25B3C35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 17:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4126810E0DD;
	Thu, 21 Dec 2023 17:14:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A203D10E0DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 17:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwSo9ZO6ai39j6JDcnwJiNswv1zwdoFKqi997EwBHCMinjLFEdZ2cOBJTL8fl8fqQRLDfgXuBGnlLfN7E6KX6c8iPL0mFCEQs/fEVJAWNNTPN94x6fq2DxzXCA4LBz6U7Johjd2A/PnZkSfhTeSUfpKwIpOe3uHM3hKe2/U5/QMSRpjx1E0cQ1w0hM5M+lQx4iI5h0avy9F+eO9EDZU6FBDtENAxSrVMPu+ma/aVUwlznqr9357ZZ7XMBd2BAIkwwqKwXInpTw2/z/KcatnsqYlPfW2zNNyYZs304LAWjpZtVobxzH07HHVFlv+UCxBWSXzVX6li39yRnyzSDe5MVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtbFTkPGbjOgW7lk0VPKinmAZ0UNRQteVil0Gwz3OZo=;
 b=Ee2+76RIhT8FQYr619bitgJTgLqJ0ytWzG41RUoAph/CQ7fm9vIysgS/OmgjOILqMHzSuIJ3Aapg2jQphne/XxRuHvb0Q/9VutEayDNAyOMQRpjpfukJpK/373Yfe1KbaWru5T+FlU6SIlK1kO+ldLU68yf8mkKrpgGLI1+EmkpFZjhSjJJiaS8gClFWoti81IViypD1bILdF7ZK8TpQDmF8/sQR3zGKn2hHKD0Q8ilvPOhr2X2FeLp8omLZDQz3D2xH4XlOLLWE/tpD9KBOjzR1b1v6vZ9HUH2Kv069PN8wDuHbOqph1lIZ0/od9BSl5Yz4OS7JMoXDGb9RF9ri+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtbFTkPGbjOgW7lk0VPKinmAZ0UNRQteVil0Gwz3OZo=;
 b=misVoFOr3ZNUDDVTWRnNPTNzUIJwP3w6B28Uj3E+HH80ay+7FAqbV+wstDR2sS0yohwnzkAMNyQcTFv+SotbMgftfvEk5lGGGHpDzqAki6ewxcF1Q1WPlIP0mT+CFk1VuvoUOik33tw3nKxtf+iiLTd/TNoQI6WV0TpUfHHVHdo=
Received: from DM6PR12CA0030.namprd12.prod.outlook.com (2603:10b6:5:1c0::43)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 17:14:04 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::27) by DM6PR12CA0030.outlook.office365.com
 (2603:10b6:5:1c0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 17:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 17:14:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 21 Dec 2023 11:13:59 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v2] drm/amd/display: Adjust kdoc for
 'dcn35_hw_block_power_down' & 'dcn35_hw_block_power_up'
Date: Thu, 21 Dec 2023 22:43:46 +0530
Message-ID: <20231221171346.1394528-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219073734.149142-1-srinivasan.shanmugam@amd.com>
References: <20231219073734.149142-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 14450b09-a865-4c21-4a1a-08dc02483bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRqOatyLjlL6kTLeb+jPZk6e+jmcemUynb4pqlR/RauxE99ajGTjbqk5+siR4haw/TdvxTglGlAhkgvXQSpN+mf6OCHnrECh6ainULF50bjC06EBh7wAQa1s00lMGM432PoZoMHBFhwWcv+32KuLag4N0DhSjOfpEGzW90SYiWo/7cUoyKo+fbbK5/kckHXmP1nexTW8k1XwFPTI2AoErQvqO7CydOOYrY2Hg5vnluYwksJlWTlf34zcLTkcQYvJbb15v44jB4ApK82GHehjxERnQD4g63jx2PksIpHwx/JchPy0qO63gu/cgoPzEf+qpRvDKRYRigeec1Yd1gAO38YZbHqAk1HjR9Vm6axIVQxG29pcd1eHCiU+Fd6NeQL00zKhXE+kq3uTQ1Hg9ne4ibKT6h2aR1EbkhPsBw3tmYhxrU8Eknz+Xp32axgIgYbe1BeFQtt0IINv/+ecbHbG2sE3aJ1v5kYFDC141nCNfIR31WTPTx2SQecQJL9zZkqw3h4pT/QGggG+0UTz5ZovAXJESwzsXm26THyw5eOL7fcyA2Vm5swG5wgzlomJXpCIaveLWcipWP7QUvNmhjQEtUmIYefZO2/rG1qHad2R6E0Meh3eAlEOYY2NNtGIIIxDZsf2JVBgn/Zsijfquy0Fbsz2iDmlZAAQ8rulQhL4mfy3mQTmoz24f/YhqJ50ctAF2GJ/+d6jhPUAYmztGI7yavLIlAAKRJW2+qjGDidT9PM6LwuZbzQyfKbKcOuHNpiz9touKG+9XlhiFWtpIMSusFMs2lMvnTDiF/6y5bLUkLqIjD2eg1O2zboEtR91lHZP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(46966006)(36840700001)(336012)(426003)(26005)(40460700003)(40480700001)(6666004)(478600001)(1076003)(2616005)(47076005)(5660300002)(4326008)(36860700001)(8676002)(44832011)(83380400001)(110136005)(8936002)(16526019)(356005)(82740400003)(81166007)(2906002)(7696005)(316002)(6636002)(36756003)(54906003)(70586007)(70206006)(86362001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 17:14:04.3459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14450b09-a865-4c21-4a1a-08dc02483bd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
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
Cc: Charlene Liu <charlene.liu@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Srinath Rao <srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:1124: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Charlene Liu <charlene.liu@amd.com>
Cc: Muhammad Ahmed <ahmed.ahmed@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Srinath Rao <srinath.rao@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - Added explaination for power down & power up sequence (Rodrigo)
 - Removed documenting return void. (Rodrigo)
 
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 68 +++++++++++--------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index ad710b4036de..1cb61c46d911 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1120,21 +1120,28 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		update_state->pg_res_update[PG_HPO] = true;
 
 }
+
 /**
-	 * power down sequence
-	 * ONO Region 3, DCPG 25: hpo - SKIPPED
-	 * ONO Region 4, DCPG 0: dchubp0, dpp0
-	 * ONO Region 6, DCPG 1: dchubp1, dpp1
-	 * ONO Region 8, DCPG 2: dchubp2, dpp2
-	 * ONO Region 10, DCPG 3: dchubp3, dpp3
-	 * ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will pwr dwn at IPS2 entry
-	 * ONO Region 5, DCPG 16: dsc0
-	 * ONO Region 7, DCPG 17: dsc1
-	 * ONO Region 9, DCPG 18: dsc2
-	 * ONO Region 11, DCPG 19: dsc3
-	 * ONO Region 2, DCPG 24: mpc opp optc dwb
-	 * ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED. will be pwr dwn after lono timer is armed
-*/
+ * dcn35_hw_block_power_down() - power down sequence
+ *
+ * The following sequence describes the ON-OFF (ONO) for power down:
+ *
+ *	ONO Region 3, DCPG 25: hpo - SKIPPED
+ *	ONO Region 4, DCPG 0: dchubp0, dpp0
+ *	ONO Region 6, DCPG 1: dchubp1, dpp1
+ *	ONO Region 8, DCPG 2: dchubp2, dpp2
+ *	ONO Region 10, DCPG 3: dchubp3, dpp3
+ *	ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will pwr dwn at IPS2 entry
+ *	ONO Region 5, DCPG 16: dsc0
+ *	ONO Region 7, DCPG 17: dsc1
+ *	ONO Region 9, DCPG 18: dsc2
+ *	ONO Region 11, DCPG 19: dsc3
+ *	ONO Region 2, DCPG 24: mpc opp optc dwb
+ *	ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED. will be pwr dwn after lono timer is armed
+ *
+ * @dc: Current DC state
+ * @update_state: update PG sequence states for HW block
+ */
 void dcn35_hw_block_power_down(struct dc *dc,
 	struct pg_block_update *update_state)
 {
@@ -1172,20 +1179,27 @@ void dcn35_hw_block_power_down(struct dc *dc,
 	//domain22, 23, 25 currently always on.
 
 }
+
 /**
-	 * power up sequence
-	 * ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED
-	 * ONO Region 2, DCPG 24: mpc opp optc dwb
-	 * ONO Region 5, DCPG 16: dsc0
-	 * ONO Region 7, DCPG 17: dsc1
-	 * ONO Region 9, DCPG 18: dsc2
-	 * ONO Region 11, DCPG 19: dsc3
-	 * ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will power up at IPS2 exit
-	 * ONO Region 4, DCPG 0: dchubp0, dpp0
-	 * ONO Region 6, DCPG 1: dchubp1, dpp1
-	 * ONO Region 8, DCPG 2: dchubp2, dpp2
-	 * ONO Region 10, DCPG 3: dchubp3, dpp3
-	 * ONO Region 3, DCPG 25: hpo - SKIPPED
+ * dcn35_hw_block_power_up() - power up sequence
+ *
+ * The following sequence describes the ON-OFF (ONO) for power up:
+ *
+ *	ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED
+ *	ONO Region 2, DCPG 24: mpc opp optc dwb
+ *	ONO Region 5, DCPG 16: dsc0
+ *	ONO Region 7, DCPG 17: dsc1
+ *	ONO Region 9, DCPG 18: dsc2
+ *	ONO Region 11, DCPG 19: dsc3
+ *	ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will power up at IPS2 exit
+ *	ONO Region 4, DCPG 0: dchubp0, dpp0
+ *	ONO Region 6, DCPG 1: dchubp1, dpp1
+ *	ONO Region 8, DCPG 2: dchubp2, dpp2
+ *	ONO Region 10, DCPG 3: dchubp3, dpp3
+ *	ONO Region 3, DCPG 25: hpo - SKIPPED
+ *
+ * @dc: Current DC state
+ * @update_state: update PG sequence states for HW block
  */
 void dcn35_hw_block_power_up(struct dc *dc,
 	struct pg_block_update *update_state)
-- 
2.34.1

