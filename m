Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935AAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 02:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048C210E072;
	Wed, 25 May 2022 02:09:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB5710E072
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 02:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxBZIhVoWAxHvNDA6gZA3RizGwery6LfXJrVTVCAmHNNfbbfHXIE9dKoF6H2eN+WI6SGxwEI0zqCDaTrQd76WRLbz6S709QtRDiYRB6I3Tdt2CmNQtBL+MHpUCSxHZ6VkBlBemeF54X/u/ZXe4AcPdTLmfW8Fx19QevGkywOwwUNBv+VSvYfFMx+ojQ0AcSwFot465A1o35WOfvNorSwlpw1YlQ7H8QGHMmw8D433nlyc4EMDWrFHvr22+0Qz+q5MjBCoo7wplrTJjDxVPXbIsq8eH7RwmHYN+GH1oezZtpXA7ITWqVS8qf5MrA59kF9EYf2IZo0dw6lWR4oqNKZow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tlqs9hQwlbDtmrwQHw/0GraEYS7vL3rfAPSXd9UMhvo=;
 b=TGrSSikKL354uQpkXeiB22GCflu/qLy1kJldkK92/cLWyc2fWZN+Cw1lDR6L32/lP9ooFOaOYpi9oG+EbmG6dRKuA8UvDeplCYmuPMrO17eT1OkO/7XkF2ZSe8rlXyb+rXMpSROiinpOqpnK5KiDZHLKpl9FyXKnCIFhBCBT6FIZViIivHYY7Kv1OSa9YsxPlupYA8NKrnb9ivYIHFYJrDdZOIKhlWpdeee2FIDq7+xLkV3bLaH6SvoauWYKz5r+R8Fbm0knP3VCcQPRcGZ+5oxRDoeU4dtt51Zvd7bgQbsOiqiHC6zyKM0cMEFzWghnB/MtTY/JncAD6qQ03swcxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tlqs9hQwlbDtmrwQHw/0GraEYS7vL3rfAPSXd9UMhvo=;
 b=QgBuviyTet070C/xvSUnMIZYLmCztSog/3d0dYZpB7PJEbrFp9vhw9nyN/Lrs2ePR3zR2m5eHUOmHA14ZVat4NjyhWvP8KGJvXD0X1QaoCmybvYUxfIppn7Vz1T8TwiNAk0oXd2RbHq1Q51TS2qQayw1i5YC9sZd6Ppb8+ccf9g=
Received: from DM6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:5:1b3::47)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 02:09:41 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::4c) by DM6PR17CA0034.outlook.office365.com
 (2603:10b6:5:1b3::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23 via Frontend
 Transport; Wed, 25 May 2022 02:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 02:09:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 21:09:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: convert sienna_cichlid_populate_umd_state_clk()
 to use IP version
Date: Tue, 24 May 2022 22:09:20 -0400
Message-ID: <20220525020926.1951685-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ccdabb6-9b7d-4403-3cc6-08da3df3a082
X-MS-TrafficTypeDiagnostic: SA0PR12MB4448:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4448096820DE122815260070F7D69@SA0PR12MB4448.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAArWc/fAKk/+k2KSVROVEFcLZFGcVoMIo0U8LAjF4RGxT/vObC7TCfDdV+m4GESFlUm8iM8Vsw/6xjmEiMxXSPFqsvMU3aEcnxpDVB2i/pXHMsd798yaTMmCUDz9cude4ZwXPiaLI6x59nXz9WwgaM7NCjA+eINc/ciupSWNsHSzPkVzkPgCYL/xwN6HWMh/WPiUeujMqewW5YXGSrpzdnG0FTIAomG4whEDh1W3Qv7mOCdIYRkKTW1LETVvlw2AMo18l00Y7bO2/ZVCBinBwLIivjw1WWrC99mNqL2CnyZbZcXavGAlDH5ShLAzwnCYMfrAd04621INW+uYhkTI5E3QJsfVzV2BwHvgEXL2hD1U63TB498p9LuUaXxRitSeuMoxe0zcJcEGIyrCL9kzFp9JAuaRXRdHXogeDrr0rVla7/+S9Kp2iEK4ca3Bw0rAUYx2N0wkWMqo6Xyoh1EOlsuR/30mqy+R4odYzVQryBUcj0hpAtn40FWuiCv8zfc1Mtvbz+HKqL3gACaQyOHnIqy1AZf5ZLIVIVKeCsKwfoba2Jk4dCinQArLeVRKYTtTCBXB64/MKzHFUYQ4fb5CWx1Rt2JXlDjfss9MDZZV6krjlV5GTkrU/vGcw2WQGdJfOflUPPw4cfHo502dQP7IiC+mXhO59IgHWuD0IDJCa21LYa3IX8yBuenS1MVvSSLN8/1R2WN+q9dLrGZK1lT6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(86362001)(5660300002)(70206006)(8936002)(6666004)(83380400001)(336012)(7696005)(40460700003)(2616005)(26005)(508600001)(81166007)(1076003)(16526019)(426003)(186003)(70586007)(6916009)(316002)(47076005)(8676002)(36756003)(36860700001)(2906002)(82310400005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 02:09:40.4646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccdabb6-9b7d-4403-3cc6-08da3df3a082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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

Rather than asic type.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 78f3d9e722bb..871435cca3c1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1464,19 +1464,19 @@ static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)
 	pstate_table->socclk_pstate.min = soc_table->min;
 	pstate_table->socclk_pstate.peak = soc_table->max;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 11):
 		pstate_table->gfxclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_GFXCLK;
 		pstate_table->uclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK;
 		pstate_table->socclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_SOCCLK;
 		break;
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(11, 0, 12):
 		pstate_table->gfxclk_pstate.standard = DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_GFXCLK;
 		pstate_table->uclk_pstate.standard = DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_MEMCLK;
 		pstate_table->socclk_pstate.standard = DIMGREY_CAVEFISH_UMD_PSTATE_PROFILING_SOCCLK;
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(11, 0, 13):
 		pstate_table->gfxclk_pstate.standard = BEIGE_GOBY_UMD_PSTATE_PROFILING_GFXCLK;
 		pstate_table->uclk_pstate.standard = BEIGE_GOBY_UMD_PSTATE_PROFILING_MEMCLK;
 		pstate_table->socclk_pstate.standard = BEIGE_GOBY_UMD_PSTATE_PROFILING_SOCCLK;
-- 
2.35.3

