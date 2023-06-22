Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882D2EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 08:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37F010E14C;
	Thu, 22 Jun 2023 08:58:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421A610E14C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 08:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0yd+No1jUSXNAm3kUsfDcshyWJ/t4cCOx+g4Pmq1xZUqFTU+rgNIJ8UvNwQR0lh51ofXg2yZkoPrPcShALKVhMt3jDmK3SLEbOmqyxePxCPXNxl0dVpPbYpCx5dS5649V7TmPVaUM7la+sLJGR1UoYBRABooOUWvm10J+Z4Q7mM+2vOk4DZ5fjZk4ev7b3e9PIogTW5xeE2l7ikRDcWupjwkKXs2pZoD40EG13ywcgboaiHQ5Ojehg+xp7ctNvq7nFoMwOfShpMT5Hsakyv/kYJS0Yf5hsBHEmFAIne2umwiUFG+/3ticxAEqgQIGVXIyw1m/9OIxYZplJfHu1X5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoAlAfu3fIPy+NcLSRulmXUtNkW8ux5l/q4ASzj5qgY=;
 b=DhfnY7XqKDl3Z7H0OFUU90NaW+n6ZWZlPf7KHDejlJhoTXLWLKbe0Y7mzhKOgkVb+tQX9ImeB0Z4/NcLnKvX3gVCE0I6inYKmr38/Fhc27WrEX6YZm/8GsVPpO+Hn0nn3Y6xIxHH2p+3st7MHJc+6j+VCKeT+QVzI4aqoGmn1LMMvrylzwE/0Arklr9xKMfnjtKGdwoy/9WpB+wO4cZLTQocDf+5tpAkwvzzzxaJ6Hf3OARyE71KHFjtsTDc0GYZCsrqCnRFUl/zuw3+YFC5LNvKaSKTO+Na64qR3rdy0GYuEb8As4vd++JyeYKe7zuEyTO7gM7k42nbw7HVTh8ckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoAlAfu3fIPy+NcLSRulmXUtNkW8ux5l/q4ASzj5qgY=;
 b=hlWSnjiRxqOBbWtBwJ5HFL4r5dKuBKrHgrhHqjFyrBTlinZC2UPO4gNo+AXZDouPOvPkzNBSPTEqUh7eY1kyz5qjrY9eSI+Do0ZSxqQkCdZHeFZIu0qDXJFxuf4+eNyRHk+ZWJ5QqlHDrrUjG4Y47gjJ4qdDeUTyoM3bhIRGszc=
Received: from BN0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:ea::11)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 08:58:32 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::d7) by BN0PR04CA0066.outlook.office365.com
 (2603:10b6:408:ea::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 08:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 08:58:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 03:58:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Use seq_puts() in
 'amdgpu_current_colorspace_show()' & 'edp_ilr_show()'
Date: Thu, 22 Jun 2023 14:28:16 +0530
Message-ID: <20230622085816.1087357-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: ec614712-b34a-45b5-6b07-08db72fedad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upCWQHOYM5IKE8D9tXQI5kpEOB+QzLTs0ALZrrH9TYyylKhTM82o6mUJjEmMY27V5cu7LVp9RiIWCpwONl+Y6lQz7SGs8UTgXMmOBbbyujbvdOm9c7iyNXoGH/+IzlSDyXLYRsDsSOOGOqT+/xAzLDZOeIPtmY/zYseg0QVSScglp513XwH+/raNDpukXy4f55HHefihva8asLLzfs0LuaTK6tL3e8Jma1Qa+7PDojBqEF6BptV9x+pg8anxee5N/rdD1CjZHFNxr1SpR0wimZ6zsrGAX7WtnJ13hntZKjGdv2zzOH6LCGZhgsgvu0RpqVWC4mwuYsJmuHs9Lfo/qiOmCQEQcHwYzgPMIouE1qrXka3dfA/0u2OFjFnd3nY4v2mTSTVgtpKsdIfvJuLZ1r1fkW2w6slM+Q/WdKZ0wMBG1AhZFpExSgu5kIilhRRHAa2m/NKyU/MG5ClkXa9i/90k2Phw2TqjPHtMBGFZzhXsc/ttLGwl2rGLoUg8Q0WbcjcFK3ojOgicZ3iZDu/DW/Xhi5Bh1L+AF3COxc5/olAmhaK2ABZPqEo8FlbflkL+zERwH/s8QSGd3oQFke4Qq2LV73FrD0ir19uIt8VzVF547UpapScMT6hATV+DVZpXov4oaMVGwaoAIdW+u5QzSsqXJz0bVhnvEOoztAUVwzOk8RT4IzY68Xs7o5blehGT6MeBYDbwn5SnCnRlnzPjyNdCXUMHJ/nT3X+THKgaZm3UovwRYjZ181iAGkX3o6EuoLqXhi27Vy9qv8/EcPomzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(36860700001)(478600001)(1076003)(47076005)(6666004)(336012)(7696005)(83380400001)(110136005)(54906003)(2616005)(186003)(16526019)(2906002)(26005)(44832011)(5660300002)(40460700003)(36756003)(70206006)(356005)(81166007)(70586007)(4326008)(316002)(40480700001)(82740400003)(6636002)(86362001)(8936002)(8676002)(41300700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 08:58:32.1529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec614712-b34a-45b5-6b07-08db72fedad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, Wayne Lin <Wayne.Lin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace seq_printf with seq_puts when there is no argument list.

Fix the checkpatch warning:
WARNING: Prefer seq_puts to seq_printf

Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index d63ee636483b..7c21e21bcc51 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1075,24 +1075,24 @@ static int amdgpu_current_colorspace_show(struct seq_file *m, void *data)
 
 	switch (dm_crtc_state->stream->output_color_space) {
 	case COLOR_SPACE_SRGB:
-		seq_printf(m, "sRGB");
+		seq_puts(m, "sRGB");
 		break;
 	case COLOR_SPACE_YCBCR601:
 	case COLOR_SPACE_YCBCR601_LIMITED:
-		seq_printf(m, "BT601_YCC");
+		seq_puts(m, "BT601_YCC");
 		break;
 	case COLOR_SPACE_YCBCR709:
 	case COLOR_SPACE_YCBCR709_LIMITED:
-		seq_printf(m, "BT709_YCC");
+		seq_puts(m, "BT709_YCC");
 		break;
 	case COLOR_SPACE_ADOBERGB:
-		seq_printf(m, "opRGB");
+		seq_puts(m, "opRGB");
 		break;
 	case COLOR_SPACE_2020_RGB_FULLRANGE:
-		seq_printf(m, "BT2020_RGB");
+		seq_puts(m, "BT2020_RGB");
 		break;
 	case COLOR_SPACE_2020_YCBCR:
-		seq_printf(m, "BT2020_YCC");
+		seq_puts(m, "BT2020_YCC");
 		break;
 	default:
 		goto unlock;
@@ -3022,7 +3022,7 @@ static int edp_ilr_show(struct seq_file *m, void *unused)
 			seq_printf(m, "[%d] %d kHz\n", entry/2, link_rate_in_khz);
 		}
 	} else {
-		seq_printf(m, "ILR is not supported by this eDP panel.\n");
+		seq_puts(m, "ILR is not supported by this eDP panel.\n");
 	}
 
 	return 0;
-- 
2.25.1

