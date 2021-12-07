Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D7DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 19:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779626EE78;
	Tue,  7 Dec 2021 19:57:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6796ED7E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 19:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0fkZn9GUHTGzLVnBAz4j5sDk9bttRukYJRnnnAVpE13dhOooQvI4citLAJAukxLoc29uYSpPV9AcVr0yicyuKB7ZOBXlfpdQPJdQskHs8FMpuMXVsUSUEGUgbu1H1dqlAuTpwH2+bvvfhRXmzG501LK+q1KpacRicAL/P27v0ov9PbOi3xck9kLWh4nPkfbbOPOjOtWYDVju4tFZUoA6eRuySEe9yhXmiweamS5lyAA2cUlKUNqWSh3BvDKs5Ad/ANZhFs3YItTlvZ1mbsAM/Jjf/ezw8iL/UwbZ4TeQvKPMspQqzmbMmx3ksLwHGInPncvPYVNBZXQDbjWlI9LVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVrRbklsGVTl0i3FLN4xtt/qncl2ORI5BbbI/TgM4Ro=;
 b=asIeO4AgA5PupXaVUC6dk8YXJrBaRUME0Cp0jpr/wYcGkTNn+RzPa40XEUoELHTkMn5OJ05YJaV2OW7sXU0tD9E7ws2tbtE/GLrsuS2TiRqa0pt2Yn6lK8GMDGFtiSaQRhdeobU5py77Gasf2BZu8bOnqm+/2wRZQbRo/yxwvjs4u8rGdAa8/kvQ/61sMe5h1Izgbmmmj70c+VghSdnPDA8EJ0RaWTGmt3S4OqII0p7nxY0VKxhSn3894Xy0wM+9mKsDVUuJBSfPNMD1XalG0UrhdpUUZ78qzFHGKR5qM6nPiNIYwAd0rfRHjQgcvlu6i5tPG4JassjdpvZpObs1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVrRbklsGVTl0i3FLN4xtt/qncl2ORI5BbbI/TgM4Ro=;
 b=261n8MdmwC29m5ObdLDP06+CvToUoEru3J3fBlyiwJwpYBCgmGJtnSJVb+6xRNh6XbRXVGjkQSExdGHJhMSQfIYUA/WE7a0CUISth3NuIfr03xE22G7dFyHerLC3tKlw0DFKBZhQq55gc/bEPMSdsWiQHO4FWu7CdnDC8Fm4ISI=
Received: from DM6PR06CA0027.namprd06.prod.outlook.com (2603:10b6:5:120::40)
 by MWHPR12MB1903.namprd12.prod.outlook.com (2603:10b6:300:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 19:57:16 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::dc) by DM6PR06CA0027.outlook.office365.com
 (2603:10b6:5:120::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Tue, 7 Dec 2021 19:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 19:57:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 13:57:15 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 13:57:15 -0600
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Dec 2021 13:57:14 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH v2] drm/amd/display: Add Debugfs Entry to Force in SST Sequence
Date: Tue, 7 Dec 2021 14:57:03 -0500
Message-ID: <20211207195703.352933-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4102cc9-13e1-48ab-943f-08d9b9bbc4f1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1903:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1903CAA3877D2F074FC91C99E56E9@MWHPR12MB1903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+ruXKd//CYZc+AyoN2YuAI+rYduV9OqLs0xHk9+GcGjEkn91DtQqSsVK1Mi7tUTTRwAeLel3KnV4SDE+zX+1zaQ1eZ7XfoQNVsmgb+MTNGvB5RtA65Zxta0hFH6E+igRPOL3NQpeIzRyB8J0bpVpR/3VNlVW/npJjjaMUOLWszFNJmq2NF0GL1BV7XXqcw39WJB3GEc1dvX5rVdD3RFHQQWYgcKrVRylL3YDI8SRQ+bahFE/blyL1u3IN6za2rxfjJSA6zEKSXzgVEI530L7gmPXtIew3d+JzQYIcpAo2OAB5sc2D5OiQb9E9bpGaMdgwp9z9Uyk4SW/FKZ6JUXh/TwE6bcvP/LsfqujLqO3Yc72AOgiEiW3gOrsepW1deyQq6INjeevXMt9q9o3HGpLDVTEOWUlNPv/03GebXf/ZOBwKod0+4Gw8/ohp4+KIej80G6UtudwGsq10K849izHiBpglMSO/CJvE1K/fRXuV6ZJo4WgMzp168fEGLvMEka+1CwO8TuisB1jXyRP1N341MrAwQYN/jhaoX66uciJEIlHlSUtHfWopa1HrlPBYcCPolYmx6nznhqbklRn6TNn5e6UPIF0GyZkbk71vgFWan8hx5DstzS90DEbuvtBQObiRlkYRlxDdwy/1fr30cTn0N4ishuz9XXHZR1hpykZ63V0P1typvusHe4B6dUdG4BgibQwTYVDZHd1m3smyQtuLEXLtJTav4hxh7acd9XWCjgqJeZsfYwzhCdcOY6RvICeX+7wSLaZiR16QQn80zU28GTKoK+m+q7VxKLoqhr7AI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(4326008)(336012)(82310400004)(47076005)(426003)(36860700001)(8936002)(7696005)(40460700001)(8676002)(508600001)(2616005)(70206006)(26005)(316002)(36756003)(6666004)(186003)(5660300002)(83380400001)(81166007)(2906002)(70586007)(86362001)(54906003)(110136005)(356005)(6636002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:57:16.2772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4102cc9-13e1-48ab-943f-08d9b9bbc4f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1903
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

It is to force SST sequence in MST capable receiver.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 31c05eb5c64a..1779c7daaf72 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3237,6 +3237,30 @@ static int disable_hpd_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
 			 disable_hpd_set, "%llu\n");
 
+/*
+ * Force sst sequence in mst capable receiver.
+ * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_set_mst_en_for_sst
+ */
+static int dp_force_sst_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	adev->dm.dc->debug.set_mst_en_for_sst = val;
+
+	return 0;
+}
+
+static int dp_force_sst_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	*val = adev->dm.dc->debug.set_mst_en_for_sst;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(dp_set_mst_en_for_sst_ops, dp_force_sst_get,
+			 dp_force_sst_set, "%llu\n");
+
 /*
  * Sets the DC visual confirm debug option from the given string.
  * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_visual_confirm
@@ -3346,6 +3370,8 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 			    adev, &mst_topo_fops);
 	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
 			    &dtn_log_fops);
+	debugfs_create_file("amdgpu_dm_dp_set_mst_en_for_sst", 0644, root, adev,
+				&dp_set_mst_en_for_sst_ops);
 
 	debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root, adev,
 				   &visual_confirm_fops);
-- 
2.25.1

