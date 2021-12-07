Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49D6C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 19:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D97F6EAC0;
	Tue,  7 Dec 2021 19:11:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA1B6EAC0
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 19:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLdBJYnkR/DNJBbRogpWarwXDqLl284WgGebfN8/Ymfzm9JIxj4ipnJkDY90ZfKj2jCW4TYnfOMR9zpKPapiEZmw1JXbMU6k62xaZsSq3QczahBpuacssKli1VCzpVQ1iCyBdx6NjH9Or+FgQPaSdAwYdObC7hPTm5+4NPvlw6jSFN6Z6dc7v0acg5/QX3X+6kT0N1eOqBb/GmKkEdZ6zUhGvtfZesp2mYDrV7C8bKaOGh/DCb7tJ4w8N0s40g7BT3GY0GBLxa/IFFT/9AnbuxMEUpnw1fkiNZNdAa3XXheaD18uXIKPMbP3hUgKI9K/KexXh221yysxqPSK5pbNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CB+G4JPalfiChKjpwC9ROAUoFzPwywVY82LIpfe3+WA=;
 b=jSh8veXKZC1W4rvHmvsdc/3fPYltMQCK6cXf78XETNRvdhOJLbj3xtcpAPQHdD6GiJ1DacEov0THvc7Q2rJSDou3A2MnZl8rvaUpXhKLyi5pHdb2KBCovj1tnP+b6NAWetYiadAcHZKDeeYeivMFleNIQLhO8vySloWg/ryVBvZfRLysar/HUyTh37Mzz2ljtbRFc/tr4/tX1wAk6gOYaCJdV2qAnjszkeRmtCxAH3Daik3ELDKhwTR6N51TVN2E4D9nkCdeldqUP7iT/37WgfvlIbGnDspBa+OW1Qf8/yccoXJTh05gNcyC4Jk91n852u89Vz4l/9nFJ5ephbRH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CB+G4JPalfiChKjpwC9ROAUoFzPwywVY82LIpfe3+WA=;
 b=4mPFyC/W1F3M1468l3jnOZixShhCrh1DXTHTvBbH/eQtvNqI+P8kYRLLiGj7jEmw7D4hW4PONPHiZZ6691IdWIHo4ALV1+c2ALIDCdkiwY/0VQFcotWfrc3gIFtYLa4ozMKUQgCzimy9GYzXfas2a8Ivv0om8ehd9o/fpQrsIfA=
Received: from MWHPR2201CA0059.namprd22.prod.outlook.com
 (2603:10b6:301:16::33) by BL1PR12MB5160.namprd12.prod.outlook.com
 (2603:10b6:208:311::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Tue, 7 Dec
 2021 18:56:08 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::a7) by MWHPR2201CA0059.outlook.office365.com
 (2603:10b6:301:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Tue, 7 Dec 2021 18:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 18:56:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 12:56:07 -0600
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Dec 2021 12:56:06 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH v1] drm/amd/display: Add Debugfs Entry to Force in SST Sequence
Date: Tue, 7 Dec 2021 13:55:41 -0500
Message-ID: <20211207185541.349209-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cff0d0f-dc6c-4ec4-1134-08d9b9b33abc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB516032E207AB603AD06C9779E56E9@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDnrBhebi9X6+p5QqXrfU+73aD1+ezKwTsyn8JrnmeEjWmLAstSBot68nwgc9DUWOahboZUNwvORLXXneSN1FvmLQv11TN4yiFsvZefLVB+um46gSOoqepy5cSLbYKJycNHgb8b3HVggT9rCvNrhRPXq+4C9Ci5i/dL0IMD3VFNCPKBkN8qhHm1U5L23MrH86iKh7cCvzjqASqS4yI5wcmkehJFJcWZ5CFmOqdq4aOuYTZb9MnvilfJ/s8Y+AHBZMAxETLl3Caf/soH2XQl9+BcHOnnSriUCC5XoDPZ3F0M+e+RWIYQB1ailKnP5RlYUFDlMVAnhkT9IFrkbh521GIJ9f6xnKe7UMkWqS9I8HbZ2XVfoMmNF6GK4kVBGTSE4fG8ICBlpCBjetRNI4RAWtdIq9B2U/QVTpVPt4ip6k9aYmPmBRm5H229Qr9uA5dSOEJs0kieUavFeeM6NFIucI8/ZNFHRhPnqdmxmzd86vpxnTH54xyoQpzBNhlj5Hdnj0bldO9597x+oTtwfXzJXXnRswoj+8I9z8LWU8fsqPDmc5AZ6W3r4rHPbGCfoXQQ5VgKsBuHPGIfA5IGJruHQIbhaSdv7MGewsVIxP3dKxbYr4QRII9iuReNyAqiT/aTa4OLtNra58kjdAEisXf4/ZKnLN1qq1SRm+7/4SvffcCbU43t7sU2oYaZDTHWpAXlO0syNpn/NKJ7uDEpGX5+MJHQqXt9LH4scGZRfT46gpLKo/o6vL2De48Iou0Ohyy4xWCR1JlYGs/IY2DHDjVXhapqdJNNigoL2ixrqb3st7bY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(6666004)(316002)(36756003)(83380400001)(110136005)(1076003)(2906002)(86362001)(54906003)(356005)(70206006)(81166007)(70586007)(47076005)(26005)(40460700001)(5660300002)(186003)(2616005)(7696005)(4326008)(8936002)(8676002)(6636002)(36860700001)(82310400004)(336012)(426003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 18:56:08.3917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cff0d0f-dc6c-4ec4-1134-08d9b9b33abc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
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
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>, wayne.lin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is w/a to check DP2 SST behavior on M42d box.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 31c05eb5c64a..9590c0acba1f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3237,6 +3237,30 @@ static int disable_hpd_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
 			 disable_hpd_set, "%llu\n");
 
+/*
+ * w/a to force in SST mode for M42D DP2 receiver.
+ * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp2_force_sst
+ */
+static int dp2_force_sst_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	adev->dm.dc->debug.set_mst_en_for_sst = val;
+
+	return 0;
+}
+
+static int dp2_force_sst_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	*val = adev->dm.dc->debug.set_mst_en_for_sst;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(dp2_force_sst_ops, dp2_force_sst_get,
+			 dp2_force_sst_set, "%llu\n");
+
 /*
  * Sets the DC visual confirm debug option from the given string.
  * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_visual_confirm
@@ -3371,4 +3395,7 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file_unsafe("amdgpu_dm_disable_hpd", 0644, root, adev,
 				   &disable_hpd_ops);
 
+	debugfs_create_file_unsafe("amdgpu_dm_dp2_force_sst", 0644, root, adev,
+					&dp2_force_sst_ops);
+
 }
-- 
2.25.1

