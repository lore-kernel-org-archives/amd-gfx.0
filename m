Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B54C77B73
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Jun 2023 05:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBE010E027;
	Sat,  3 Jun 2023 05:11:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D4F610E027
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Jun 2023 05:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUef3pdh5Q71y6xGgo0A5PegLmwtK4c0/TcNizrHQHepgPgtBEZIQBWhOuqoeDfU9/tDMH3e2V48kGs1iWG7m+y+0QaikECYEVZfG5o7AC8CwlT7fFUE89Dy440sCZT18XtocVnbdn8N5rmAW2bRAkQl5nJ4afPLtujx2OipvbA23FXFyoIYQxXcQE9zZY6M3WDdM0P5bVBTLYvLHP40LdpSRV9WnaaPf3dPVfpuGMSGjPM8u/Ka2XUp3Sh7s05KKu0B7BQZNeoVfKJc6Qhj5t3gjF64/DSTDjlmWBlH5m/yKXVTWP07rkb+3MbGpP2tun9Dfk8ON4+gHR/E00ZJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gj8PDB0MXdVU8B7EomCT5xNoS6vor/ckosV27dWjON4=;
 b=A39tK25wikiRkdPdZkORpBeiS0/sXjHrkp3QDpTuebdr6OPee13hEQda0bGOXIXajR/Kfpy3TCEAZhXnywG9UwDjq0n8gpaEDyXm7UwqSayl8yGY8d70vDS9K6iSHsGJmBrLykj5iZj2GyqxAnZ5qaCBG0KC63IUwaQfU5QkQ2Hc48spnOwtY59hfinKtX3Hz91tR6IpNQNsT0Q/glPjnQRb2GzXcwVQxPJcLhlw45sB6xwo0zl2Oij6uM/tghRv6nFQFIdSavsE1UnJQtlf9AcAuLwMk4psRGTNf1EbKMC6lLTAmoIYwO4uLoNqQuMeRIu8o+HcWSOK9jLsKAxswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj8PDB0MXdVU8B7EomCT5xNoS6vor/ckosV27dWjON4=;
 b=nylzMTBtr7phzEjhlFKjyFN0YUNAHo/kA3mQnT0fOjOEOQ4H+atGSdydS538+Vi0vKFBZnToMAGAA8nUkhC5p/DThtoEbOiQOg8fsOpF7fBFAb+DfZWuStM25b4f7NvupbdmFl9IiSLyD8frsjCrLB/OEKdyYZ7CWJH6RBSo0yM=
Received: from DS7PR03CA0246.namprd03.prod.outlook.com (2603:10b6:5:3b3::11)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 05:11:01 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::97) by DS7PR03CA0246.outlook.office365.com
 (2603:10b6:5:3b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28 via Frontend
 Transport; Sat, 3 Jun 2023 05:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 05:10:59 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 3 Jun
 2023 00:10:58 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Report ras_num_recs in debugfs
Date: Sat, 3 Jun 2023 01:10:43 -0400
Message-ID: <20230603051043.211548-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-check-string-leak: v1.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: bdeebde9-d1a8-4c50-f22a-08db63f0eb94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5DWP6eCRHfwI+227XWi00OAQuGRrU4cLWHQRy0xceNlEq7AG5PXLJm3cTa4/EZIx82IWgTJcfgHSItob6tFXogxJWde2+ICtv6Tw7sm5fZuo/V61P1OHrER99U1T1Gx7vaGgFGmPXrrVsLJnfb3ZeElFffzTrz4W5FeWcQyYObc841MsQHu+GASM6MmNaOqwXJjzdiunKagMdh5RjtUP69YQB4Kx2XO5itGSj2h/vFbxdUXDtmckoBBE+6suPcwSl3zDCGT6lP8gwRkpVjVLLWlnIAGnib4b+napc/9fi8lUyO0pJoyVd5/qhwWgKJP6oPkyNKfqvSyWHsO4bnMt9Qymw72in4c5yAEZVyfqKxrGH4Aa4aUmEDReWNXCm7Ug/ZB2H0NxA44f7h6nIQWLGLdBz5Xuz2Kj8YHFZiC5kEAuiTiiqc2LRnaAUfpv+6qJ9To+GeO6DSOpkGQcXoPLpNaXdG0ObFg0M+YowYdB53DPA/GuuwUPhD1zXJ7IQS9IprppWWFZwAMQC7yackWbRyYus5oPIs0Q6e0Lm1WMRGAH3M7kywF5Rww8NC3U75WqkTZ97gkenC8TxsSw2KNfdcqU4CWP8Fbjc4KHEj2tUNqY4Re4LiyCjmAlmU9xS4ChXxH+H1dMCrQJE3+ltnyJ2U2pm0yFumDrlGb6LuKDrrslbIqJOCYnW1Am07EJ89dxRXlPuForOsXARMzaNvYeqyhcq1HBo0FfLuxaLdL2+KV9XplBmBkNS3SHK3C8XTjPvbzoKx4XDkzpqIhlX6Z/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(1076003)(26005)(2616005)(41300700001)(7696005)(6666004)(186003)(16526019)(36860700001)(426003)(336012)(40460700003)(478600001)(54906003)(4326008)(6916009)(82310400005)(40480700001)(356005)(70206006)(82740400003)(70586007)(316002)(81166007)(8936002)(5660300002)(8676002)(44832011)(2906002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 05:10:59.8140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdeebde9-d1a8-4c50-f22a-08db63f0eb94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Alex Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Report the number of records stored in the RAS EEPROM table in debugfs.

This can be used by user-space to calculate the capacity of the RAS EEPROM
table since "bad_page_cnt_threshold" is also reported in the same place in
debugfs.

See commit reference 7fb6407145479d (drm/amdgpu: Add bad_page_cnt_threshold to
debugfs, 2021-04-13).

ras_num_recs can already be inferred by dumping the RAS EEPROM table, also in
the same debugfs location, see commit reference c65b0805e77919 (drm/amdgpu:
RAS EEPROM table is now in debugfs, 2021-04-08). This commit makes it an
integer value easily shown in a single file.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: John Clements <john.clements@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f2da69adcd9d48..68163890f9632d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1487,6 +1487,7 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
 static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *eeprom = &con->eeprom_control;
 	struct drm_minor  *minor = adev_to_drm(adev)->primary;
 	struct dentry     *dir;
 
@@ -1497,6 +1498,7 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
 			    &amdgpu_ras_debugfs_eeprom_ops);
 	debugfs_create_u32("bad_page_cnt_threshold", 0444, dir,
 			   &con->bad_page_cnt_threshold);
+	debugfs_create_u32("ras_num_recs", 0444, dir, &eeprom->ras_num_recs);
 	debugfs_create_x32("ras_hw_enabled", 0444, dir, &adev->ras_hw_enabled);
 	debugfs_create_x32("ras_enabled", 0444, dir, &adev->ras_enabled);
 	debugfs_create_file("ras_eeprom_size", S_IRUGO, dir, adev,

base-commit: e82c20a87511115677528a5e01e58b7763a42edf
-- 
2.41.0

