Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61550C27C77
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 18:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D558510EE22;
	Fri, 14 Jun 2024 18:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JUq2wEMK";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A44810EE24
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 18:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=angP7oWFOhN3jk9jHwwKuhRDofB7WDYqWKiD5+wJs5TLGzLoMnBUE9JkoWc5V8trjelRGGnMFfRsDLROnSHtErp2HWhEcP0niHuwB24DTwgmX7jDfxoUVGMAUwX0kBVh0A3xAFPTk/y6GzmgbhLGO0Xb/iPF5/alSrYodt5vqkUw+ZgZ4Pvuw0A3CGBBt+HTROW9GNpwJma+bbFleCHkPoIlZyP7mm/9zih8B05SYrW9jcECfVXbBbPzadkgo1xIlHiQMzXjls4Nq84lRMG1lP6s753veFf3q23TYvL+0rW/0SrQYOUo/RZ1Yhn+pthgY35pjWYOwLO0UdewKxRtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LRTWHwoSyA+ashy4g9OjQOftn7soupdpfAaf9frt8w=;
 b=AUIRxOB8k0bGCRI0OW33bGwxduCKm0VKgiodJAMZheN4TglEWCJsRp0uG7TlLYMJk9jbJxDCeC8m/5WrIaxikIceSd/rIJpVqEstqMr1MTR1vMzCRgW/bicP082prexu7YjempyxTzU2xT2HUcg+12AewbhJVBFPzAgLs/cOILK8ZjxOssxNL90M9eB72g+kHJgTpowa3gLCThzeGsyvCXR2UmeNqaXX/rakCvEwQ8lY4HE1/OGCmjMLxEyMcPcE2JNU/W0dvBsAFzr2GbwWL8sP7jgPvyZA342TN1/X/9qaXERFuJYxApIQB3KsfOIQewWPL8IHp9vEd5O2lw7VBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LRTWHwoSyA+ashy4g9OjQOftn7soupdpfAaf9frt8w=;
 b=JUq2wEMKj5GO3x8PQoIY/jRt89DdJ4/7lAMHoVC40Zcks4/1CPjGUgq6v7N5kd3FWWdyvWWYh57R35aAqko/8C2xrKQYacIrH4I3sT2hlM+1fjgm1dLvsWL0Eb2YcRNO3oC4jq4SXqbokObLHJrH1OK6KT7O3yF5HkteYnKo/dE=
Received: from BL1PR13CA0443.namprd13.prod.outlook.com (2603:10b6:208:2c3::28)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 18:33:57 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::48) by BL1PR13CA0443.outlook.office365.com
 (2603:10b6:208:2c3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Fri, 14 Jun 2024 18:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 18:33:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 13:33:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/radeon: fix UBSAN warning in kv_dpm.c
Date: Fri, 14 Jun 2024 14:33:37 -0400
Message-ID: <20240614183337.483183-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240614183337.483183-1-alexander.deucher@amd.com>
References: <20240614183337.483183-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd326c8-0ce5-4347-9d13-08dc8ca08d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tlSh6afNz4/BalIRATNYwXTBq2iHpmfQpU1hvGjO05vfVYFHAhw/JV0zFIiC?=
 =?us-ascii?Q?HWeY9QnvBgkAwgaOmieaEXE2tHXdTPNiKyfaBnxx6d3cBv/i7i0YHtueXW+Y?=
 =?us-ascii?Q?uz7j8jQ+0lZcteNyoM20ErHJq7xG5+x0/F6KZke/SrBMeb3hGZET62FdK/AL?=
 =?us-ascii?Q?DbIyuT2wkCB5xql7aMQX0EGTOlzyXbRtlvoq29VqpPyVxXEEg+AXy3ovNzMi?=
 =?us-ascii?Q?ARe3IRT6f56jUDRa4nrjB7W1eF1o1QgzMPWwNAslZV56c2jUfOhWIpu/rMI2?=
 =?us-ascii?Q?1QtvfHcBX48DsBFMKnLloHZV+Va6b+CxvHUzfqbmyeRkPy9u//2QQmLwot10?=
 =?us-ascii?Q?55trOmCAap+o5kbYCOMPwKh3HvMQWVdiNJpbVfeDU1ntluVVJInwnqJnEt8c?=
 =?us-ascii?Q?1PkUVJIHN6UyXmn8kZNFFCE1fFihpOUXksL/X7pfTOG4GsSDpg+wHlT+GWHZ?=
 =?us-ascii?Q?orYMUQW03uBf9yi1bdc4lEJDe78i/Tz0DKzlQ3XwhzvZ2+Cn3Iy2LBKUzV+2?=
 =?us-ascii?Q?h8Yn9NTya+RRme5UJFT35PYxtY9rwzXT6bqDYSvhsbIXEbbcUXq4UzD4CCSP?=
 =?us-ascii?Q?82MnNyev7lc8e5n4PDm/ogt5oTZrtTUgi6kdeOyfIwN/MbEU6EFERmQM5tdn?=
 =?us-ascii?Q?0wRBIm5C0G0bNE1pP1MPL1fopmcMcwoNIaFPdFxpAtAgGcIgVAitFOTX94uV?=
 =?us-ascii?Q?1PqzU+C43K6tMMhwejlo9+0XRbpGQ+Ato8doVqpFWiF9baKaX0UMcbc/3qeD?=
 =?us-ascii?Q?d11npWYlJd/SJIEygQki8W/lNU0W/OsxZNpB0R9XyLdHCaEVqeh8YY/jIBtT?=
 =?us-ascii?Q?50fa41RxtGLQlIeRmSyg4IpZ+pph9qfC/EMi2nYTceOiHvmLxJ4NgxDlkgVp?=
 =?us-ascii?Q?PGeGtBDQPzQTePuKFYjv5K3Zt/Np4yPduQSoL3jei+67hYPWUO+aERVYUiaZ?=
 =?us-ascii?Q?lJsHNot8a6H86iq0kOVfs+GImL1RwnlFBHdHozJVbQYJTUbl0oN7iaSEhh15?=
 =?us-ascii?Q?3JtH/3zXhXZPo647DvOWy2WaEOycfiAfF4g+EI6vqlWHMlpEUcX+lFEs1Be0?=
 =?us-ascii?Q?WLCp+m1c/zTMEtco1JlGT0ZGoAl/HidEhyKlCHLte2wvgF78hN4Oj04W/ChG?=
 =?us-ascii?Q?GAWzZhmv37IQOR5NCDBFhd1JmJAfdFoGhuse/1/5Xm2D3zV8DpacKJYRf55u?=
 =?us-ascii?Q?gzZeAK/hTccochko4CE7KQW0p9johXFXr6Bo6paJ7PzXRPJOJvMLo+XJqZaa?=
 =?us-ascii?Q?TGDSsdQbiYkYzKhM03oDbFCq/Igb/P1TiEOATE4S8HWBJIsH14QbOBIKxCB/?=
 =?us-ascii?Q?h481Fu4StBR1G5Wa58DcEYKoFox42HmauXabaH7Pg4mztjDrPNUPVU1S/IAS?=
 =?us-ascii?Q?5mPaKG5wG6IVIzz8jWbDBr/Jgu6knhv1ZLLumkUTeaRnnC4GxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 18:33:57.5290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd326c8-0ce5-4347-9d13-08dc8ca08d97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887
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

Adds bounds check for sumo_vid_mapping_entry.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/sumo_dpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/sumo_dpm.c b/drivers/gpu/drm/radeon/sumo_dpm.c
index 21d27e6235f3..b11f7c5bbcbe 100644
--- a/drivers/gpu/drm/radeon/sumo_dpm.c
+++ b/drivers/gpu/drm/radeon/sumo_dpm.c
@@ -1619,6 +1619,8 @@ void sumo_construct_vid_mapping_table(struct radeon_device *rdev,
 
 	for (i = 0; i < SUMO_MAX_HARDWARE_POWERLEVELS; i++) {
 		if (table[i].ulSupportedSCLK != 0) {
+			if (table[i].usVoltageIndex >= SUMO_MAX_NUMBER_VOLTAGES)
+				continue;
 			vid_mapping_table->entries[table[i].usVoltageIndex].vid_7bit =
 				table[i].usVoltageID;
 			vid_mapping_table->entries[table[i].usVoltageIndex].vid_2bit =
-- 
2.45.1

