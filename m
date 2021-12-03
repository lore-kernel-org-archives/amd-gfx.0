Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10ABC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51904AA4AC;
	Fri,  3 Dec 2021 22:59:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5120DAA4AA
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gfm9n9fZ9i2D8FWcYwbEwJAbRfO62l+iWjUbT8tTcQb4ca+4TPN8YJffn2IlCeSl/O0rsPnM75CQLQvb/Y+tch6W7popg2Ekit3syGgU/FX/+3pLGRTCykrreAYFIQqN/27Uav1PjXWGSmmTGp3P3S7m/hZoNdmk6GIayUIfOOPULVrRMcWiYxBRnFzMH9TsKFEqiJTFgPMwKXK+LWiG2PvmR1tG1pdwW8WHAspFRYzujSv53EhN0wp3GQXJfmRQRhE0VsjgDahSiB8GNwJqpOMsFJcfzrxiNcRlm/e3b/OLIMjteGwPOM3ULUIBoA89VJGuOWchPfemDzCMxukcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUbUCYBswNDsZA7Ypms28K4mJQkXzNckCYilTzjWe0Q=;
 b=SVvYR0k/3cOPa/oCR7JP494dDX/7R1rE3oA41drf/IJbfFjfXTo11Cn9WG/ZysgG+zOZWp8z2g4jGkd7Lmi/EJIVGTxkMDGB/vT85RfhTx+jwBXVIS8ADhfFtymoinnuqd7bI5klmA3VdYtbAxDMB/J1DaeWXH7v0Gw9FiU5Dxr25LbZsktBWLFPnbO+NCO/0QyhVLuP/UGr/b6x0on7v9Kl1f4ROntdH/Dx99cMc8eUHRWbHdsWtH0rAM4Gaw9++1ZOL0VlZgneZhkfFmOD4eNCvR/W+GVO2VxmR5rPlAr2aVsBLKiUxYTBSGmxFlqickdM304sbOO1/HXsE3guFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUbUCYBswNDsZA7Ypms28K4mJQkXzNckCYilTzjWe0Q=;
 b=Emg1gdaoyCKoAf8rrlKvAwPB/kgBLrqCgIk/jOkqpvLUrgCv/qHxESJkqmzWF8FC8Orz+6TWXm6RPbnylyxLUcfq1YwOHIi07Ua9Cf0EupHxKgiEp2uZt4tWf6WJbLeAhHdLCNC7jGIKR4hL2RomTxsE3lxNnYl9sZW7MDNDmvA=
Received: from BN9PR03CA0504.namprd03.prod.outlook.com (2603:10b6:408:130::29)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 22:59:03 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::e8) by BN9PR03CA0504.outlook.office365.com
 (2603:10b6:408:130::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 22:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:59:03 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:59:00 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/15] drm/amd/display: Fix bug in debugfs crc_win_update entry
Date: Fri, 3 Dec 2021 14:57:54 -0800
Message-ID: <20211203225802.651367-8-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae3ee088-29b7-4f72-de8f-08d9b6b08053
X-MS-TrafficTypeDiagnostic: CH2PR12MB4118:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4118282F96D2B4392A1DBE17FC6A9@CH2PR12MB4118.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xOmqhPCd67fALQQwAbPL9xlMqtRitAVp2mWMC306Pq2LYQjcxx2TMrGmusjgbOFHiDy9mS7RI6cPA4jfelxejZvhuBAj5IzexohaMv/A3kTqW0NwrnNeAZUy6EEvasjQRTf9pUa9sBbJJX2Zmh7hZ+2dMyaduISeH4CV0mwF3E2KddxD/kP7dQYXPZ3HC5DcRh0o9VZ+CV8dx+vQBguaeH43nCnXGRW00Ec9AnU5yZ9nhTWUF4eQP4ySwpfQNWMEUepZTPbf+ph7IwS3fdJdVTlXyZzXZpiM5EeZxdkKewpFcA/tGVQs5wP+tZvdZWqgI8kSzFWiHVrzvavPbaQkMAtwbJQihdXEeaUzqQozeWGRkG9joluwrJnTWu+xFu/UCI05xjVb+Mz6waNsxN6UOeb/m1XrAtDY+Jadm5UEfFNAkeE2tFtBlb1MNy5sHUnKONBvvSjSszFW4dWi44SkO8pL3+kwaK40+S8dZzoN3nb3XDOiiLou/bpMXvAcbf8kof+/a18WOIlv75GR/L7oNRN5hnH/qHmHiWxHgI7JAzADT+5q2j29HwTJ/dsgBDFkLSanOySMkpMIni36yAsnxZ0wOtxPbnL0oBV2hNKrc/A12qLCBItCXadbNnAp8j2m8fAb6+RVCuunAMaUG2JXoBvu5eXDMBwEbkXG1a0zPdXKp4F0mVowvhRep+7kWUS58lYYrp+we6s9unY4b9gNn5gSQU72pbFSZObMlsQZGPjaPIRLCrU9kknkpOJraRE+D3KUCBIQ9g7c8kKfh42HtIQNrcT6qbRCezsjDj0wqqE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(8936002)(54906003)(36860700001)(2906002)(82310400004)(7696005)(16526019)(26005)(6916009)(8676002)(40460700001)(5660300002)(508600001)(186003)(47076005)(316002)(70586007)(6666004)(2616005)(86362001)(4326008)(83380400001)(1076003)(36756003)(356005)(81166007)(70206006)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:59:03.2646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3ee088-29b7-4f72-de8f-08d9b6b08053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
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
Cc: stylon.wang@amd.com, kernel test robot <lkp@intel.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Dan Carpenter <dan.carpenter@oracle.com>, Wayne Lin <Wayne.Lin@amd.com>,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
crc_rd_wrk shouldn't be null in crc_win_update_set(). Current programming
logic is inconsistent in crc_win_update_set().

[How]
Initially, return if crc_rd_wrk is NULL. Later on, we can use member of
crc_rd_wrk safely.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 9a65df193108 ("drm/amd/display: Use PSP TA to read out crc")

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index d7f8883cd4ff..31c05eb5c64a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2953,10 +2953,13 @@ static int crc_win_update_set(void *data, u64 val)
 	struct amdgpu_device *adev = drm_to_adev(new_crtc->dev);
 	struct crc_rd_work *crc_rd_wrk = adev->dm.crc_rd_wrk;
 
+	if (!crc_rd_wrk)
+		return 0;
+
 	if (val) {
 		spin_lock_irq(&adev_to_drm(adev)->event_lock);
 		spin_lock_irq(&crc_rd_wrk->crc_rd_work_lock);
-		if (crc_rd_wrk && crc_rd_wrk->crtc) {
+		if (crc_rd_wrk->crtc) {
 			old_crtc = crc_rd_wrk->crtc;
 			old_acrtc = to_amdgpu_crtc(old_crtc);
 		}
-- 
2.32.0

