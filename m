Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6768FE8FDDB
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18BAA10E34C;
	Wed,  4 Oct 2023 09:23:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F88A10E34E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfhvbCmHzRpM56kyHQ+oREGw8IeSIyAiDbS0L6bENUzbanfgPpU2JRItVMoJeVT37aUwn6/OAvkyg46Ylc9imVOfg8C7MQ8BBFmf1snq8LRKrIFaQx25voRXm0dYTMiol/+2FRDckJyGAq3xpowIbUcD2eKK6UyyNAnhQkIlLosaCAqbGIedhg9GgL60j0y6CFbuFWsXj+RFt4KqQe3zmonHeiBVoQW5qTgMI3NGqAyzxtZ+4Djfn+R/m2fcCsGArWZfQM4FtbgVOfz+DHV2QX0CrByhWMbVTg5vGxuzo/G1OI5hZnZrwcco9LM1cXA/Pxm6kxIkMu6QGe7dtK9fpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a04I0AEYMGIuRlXxDG5iPwiFTGKALjNVccXCMqck8po=;
 b=JnOf2Pm3/FiXaiFPvGAXUtLdsDQuvbHW52DjhfgLdXC1IoLCG6cEyx62iO3W0fJUysD6F2BzDfbQAoQEf1Wu1Xmbi+AqqdIPS2SnuCEg8nWufVDcAT1XwF32Vj8N5zP9FlHnWDXXg82RFsvDNk2nBtr6T3XfvZ0QC6g+5lri6d+u+URTC3IXxeqFAO49OialFHUpmAoTW3LhjXMF6iGely/BZo0joxqpIb/MXdzwA+nIXCy/3KRK7NmogwDg0UDIioN//Tt8PESKKLdyuhQJrmzU/RekDOTCcK8ayft0cVTv+eBlNJ2BXbT2B3O5D2/ndAx4mClR/pZCBHCbiSPhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a04I0AEYMGIuRlXxDG5iPwiFTGKALjNVccXCMqck8po=;
 b=UbktjxY+3WfVAldGRLAcaAxDrtwG8Yx3OICPzB8PfAMzNo3ltU617ajm8UyJYCl0jW7z7ReWcQaYMVPO8BDajWl/0tC3EhTKs8AtNZd8YCNnL8W9TQgo7KLzuhHPmYWEMUJfsZ2LVDBvr1bOcHxo3lW6ddjEQ82A9ijKzGA/PbA=
Received: from BLAPR03CA0174.namprd03.prod.outlook.com (2603:10b6:208:32f::11)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Wed, 4 Oct
 2023 09:23:36 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::82) by BLAPR03CA0174.outlook.office365.com
 (2603:10b6:208:32f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 09:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:23:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:23:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:23:34 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:23:29 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: VSIF v3 set Max Refresh Rate
Date: Wed, 4 Oct 2023 17:22:47 +0800
Message-ID: <20231004092301.2371458-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 260065bf-55fa-4038-2580-08dbc4bb964f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZ8LMVF37CIpm28PRWo9AT3S2tDoTa9S6UdM3fH5r6lMlhyp3R++vDbKNg9CejuZAqdanQXmNQtBaeUaZXvrBPHPCnnHaOkAmgywBYKiM8+d0lrySOfuUtDte2w+gzPUa8Z/+xs50bbmErPyfDtJ23vZMKF0t8o9zmrA/B7PMS33he+BOt2flj/Q4nkCudZlz/sIk9b9A+PcqkryN34tPast2eGwBLFYKpXNkkSEoH5Hm3/ZDh4W246TK9n/zfVuzyxRyD3eMC1dfc5DOaJncSdLvoItlCymxMZukAWx5qmVhGnyjep1wTe4kznSLTNBKxHqAMVf4JOzKFuEe7gF3oy3lO+P78pTNH2FoOZdiQlay5mRYKiEMk2yh+s10Pnfx7Hou3fimSVS1aw6xg7O98yuO4Nn6hMh71eHYnbNECPFlooUBBVb5/6hP3JxRlOKKVN5DdCtj28GM/cShPaybtsbC63ZIkXh3mJ6f1Dtw0jD5iczzIXCV69Msu64ykzNFhjwULAwHOT6LAcURaWdPaWoYB464fh830y4Su4EZIXJJdl0dnlHeC3kQ0O45hrx6ciwHZGZjXbjpAX3sxoxxV+24VTtpezaPIdZZi6pB5XP/z89VFIhXjUPtJ/CIa65thhe3oYF4HS9CT6xcUe/YwdDFQosq017K/b6d5PSk5q8AWbmTOf5lCvlv5NDZtavBaopmx9V3YqIGdjNwwgCkzoMo05h/O4E7Jb9aD8vPuEMXViLVCH/8FmNtLMz2UXpZTUuKtFl+2jtfZUjakRyfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(6666004)(7696005)(478600001)(47076005)(36860700001)(86362001)(356005)(82740400003)(81166007)(2906002)(83380400001)(426003)(336012)(26005)(1076003)(2616005)(36756003)(54906003)(70206006)(70586007)(5660300002)(6916009)(41300700001)(8936002)(4326008)(8676002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:23:36.2286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 260065bf-55fa-4038-2580-08dbc4bb964f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
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
Cc: stylon.wang@amd.com, Muhammad Ansari <muhammad.ansari@amd.com>,
 Anthony Koo <anthony.koo@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ansari <muhammad.ansari@amd.com>

[WHY]
FreeSync spec requires PB8 and PB12 to be set to nominal
refresh rate regardless of fixed rate or variable

[HOW]
Removed the condition that checks and overwrites max refresh rate
and set PB8/PB12 to be set to max refresh rate always

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Muhammad Ansari <muhammad.ansari@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index ef3a67409021..ccecddafeb05 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -626,7 +626,6 @@ static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
 	unsigned int max_refresh;
 	unsigned int fixed_refresh;
 	unsigned int min_programmed;
-	unsigned int max_programmed;
 
 	/* PB1 = 0x1A (24bit AMD IEEE OUI (0x00001A) - Byte 0) */
 	infopacket->sb[1] = 0x1A;
@@ -672,21 +671,17 @@ static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
 			(vrr->state == VRR_STATE_INACTIVE) ? min_refresh :
 			max_refresh; // Non-fs case, program nominal range
 
-	max_programmed = (vrr->state == VRR_STATE_ACTIVE_FIXED) ? fixed_refresh :
-			(vrr->state == VRR_STATE_ACTIVE_VARIABLE) ? max_refresh :
-			max_refresh;// Non-fs case, program nominal range
-
 	/* PB7 = FreeSync Minimum refresh rate (Hz) */
 	infopacket->sb[7] = min_programmed & 0xFF;
 
 	/* PB8 = FreeSync Maximum refresh rate (Hz) */
-	infopacket->sb[8] = max_programmed & 0xFF;
+	infopacket->sb[8] = max_refresh & 0xFF;
 
 	/* PB11 : MSB FreeSync Minimum refresh rate [Hz] - bits 9:8 */
 	infopacket->sb[11] = (min_programmed >> 8) & 0x03;
 
 	/* PB12 : MSB FreeSync Maximum refresh rate [Hz] - bits 9:8 */
-	infopacket->sb[12] = (max_programmed >> 8) & 0x03;
+	infopacket->sb[12] = (max_refresh >> 8) & 0x03;
 
 	/* PB16 : Reserved bits 7:1, FixedRate bit 0 */
 	infopacket->sb[16] = (vrr->state == VRR_STATE_ACTIVE_FIXED) ? 1 : 0;
-- 
2.25.1

