Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78497C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2F210EF9E;
	Fri, 28 Jan 2022 14:06:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360EC10EF9E
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ4QMdh/CPQVOfcbfbTE3FJnTrPO3gLkZrkzXZW8R4e6Xkhk0ywvm5MI4IPkle9kdcGAi0kk3E8gkyFlLBwGMkqWBMPt4qrbKeLFzwL9OvluADYvq5ynyMAg8hBsaEW8GpRwjrDuuEZ6juHTw2Pam3zfDquiGRMzlFHNDH6BMXaDIFK1xRINBIqALrv4hO2fMRgTfaqHdg9fuZAXDa73+SRNZyk4QN34Ktsc6KdKg4B6I6So1ewpYnrYJbOlnCks9tzCZpGhk/MxWDK4Xpn2GgQLENMsnH/mFJZNEhfOjhVktPUxWWknBS/q6/RV93rlIT4RNxT1pG3EMaupDmSScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HklitgLuT0Xsq/jz82IiSd5SLlIWp5Int6TbA0XaRUk=;
 b=kAh+OFFSjqxZvEAuxUlVQxqUZOoAWwGAlmwUIBQbxiyDJYJ+u8Kn3cU2RoNtlqdKFJDbQJ00biuod9Z2ZcXQV5MVqmiN4EhnkgExOUmElB2eyMrSMme44VDZo5XIPyU6CuRFzW/Hzf/dVLP1KAm4UYLShNmLUzCWM/EAkS1JaKy8NCyEtuGUD5WCmrrFA/0xiGZvF6J4ZQRZ+icwXD2itxN8OwVXzMQQfMfiH5WZm4UHSZhkBs386fYdJ0VBzLKE3LrT7djJH1vL1Eh08EiCbm3WJWHXel1e3ckQWYyZnNh5AKIffnY+8pSZ4z4LJYsZjIEDh3Tg49mEYNd/JTiZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HklitgLuT0Xsq/jz82IiSd5SLlIWp5Int6TbA0XaRUk=;
 b=rex0PnF0smVT5KPUzO6YJLM6IuMFR8mKAo0JgGuioUHZPEzUOeeBeiQioWSLyOxhQ3sBl5WYjY8e/icmznoCpD9MkhPDNhVt/1h7NX0iPdkGxLxOWNsEJ8t3eep3QdgC7D99ZdoRVIjB7XRo4rW3bP0NnQls4/tgGr9XLDFSFHQ=
Received: from DM6PR02CA0080.namprd02.prod.outlook.com (2603:10b6:5:1f4::21)
 by DM5PR1201MB0059.namprd12.prod.outlook.com (2603:10b6:4:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 14:06:11 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::ed) by DM6PR02CA0080.outlook.office365.com
 (2603:10b6:5:1f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 14:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:06:11 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:06:05 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/17] drm/amd/display: Trigger DP2 Sequence With Uncertified
 Cable
Date: Fri, 28 Jan 2022 22:04:10 +0800
Message-ID: <20220128140411.3683309-17-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e9e844c-e0df-4d9c-f6e3-08d9e2675692
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0059:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0059013AC545DD2F09A79030FF229@DM5PR1201MB0059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ph9WX3UeeRvHVz4wtVBKUJmFzTHzol7kcDeWnZb2xsr2HmvvdG7gum3vjINBm64Wg5eroatL6zFaiMizAyBLp2AF8/3mnnHCfLqHBr0pvvQtne28n3yDvwOt9dfLBeoUGauCMsnP6PTGf9IVuOky7bprIbG7g0MV4q+em0xuHo0PDqHhj+h099X+y9+xrIJZtfm3rFA7MyA+8Wfg3vRPfZsY6lzNNG6jKDioyL6pJ2W59fMa6LZXZw3xsjhI9ZQV20NCSw1EyN8zayFj4N2Q3iSIhCMnRP7a2j6snHDxANkvij8welex4qrqjtdfmckUeYz8xUH71yRMhNPTXxbc9LQqeY6DKyft+b71ugXGI4dhmT92PNASXki/kA+H1ICVFQduLk2vJcyqCacFcpXxZyTL/xmxgPDYVJ6R6xCN3xow8M1RlkKRy79dYuD+gGqrKQNdYQHN4AVBe3D9ECa4tunloh7ZcbpVIPxuKdyuXdcdC+rDBuw3f1dVrO+vO6wPbUtUK8TmqHOdVKK7MsledyObe4Iao57SUBdFyIplaMn5gvxfXMmJP9OlPWvSa1xr+Yn8xYkcjdj35jMoxTzVzbtPQh2LrCwx4Tl/czH0BO499kmKzhLKJjIKgKdQTM/ddiC4NNOegMUk1+gz501zzZ8KgyZsOyzpuogsjZkwCypy5jUlJl67ujvCD2g0pP1gj1esMAl4K6BrYv+x0sX70w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(5660300002)(44832011)(508600001)(83380400001)(2906002)(47076005)(36860700001)(54906003)(26005)(426003)(336012)(7696005)(186003)(1076003)(16526019)(86362001)(6916009)(6666004)(40460700003)(316002)(70206006)(70586007)(8676002)(4326008)(2616005)(8936002)(82310400004)(81166007)(356005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:06:11.0366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9e844c-e0df-4d9c-f6e3-08d9e2675692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0059
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

DP2 sequence is triggered only if VESA certified cable is detected.

Force DP2 sequence with uncertified cable for testing purpose.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 306a16b7be75..d7611c81fca8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3431,6 +3431,30 @@ static int dp_force_sst_get(void *data, u64 *val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(dp_set_mst_en_for_sst_ops, dp_force_sst_get,
 			 dp_force_sst_set, "%llu\n");
+
+/*
+ * Force DP2 sequence without VESA certified cable.
+ * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_ignore_cable_id
+ */
+static int dp_ignore_cable_id_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	adev->dm.dc->debug.ignore_cable_id = val;
+
+	return 0;
+}
+
+static int dp_ignore_cable_id_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	*val = adev->dm.dc->debug.ignore_cable_id;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(dp_ignore_cable_id_ops, dp_ignore_cable_id_get,
+			 dp_ignore_cable_id_set, "%llu\n");
 #endif
 
 /*
@@ -3549,6 +3573,8 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	debugfs_create_file("amdgpu_dm_dp_set_mst_en_for_sst", 0644, root, adev,
 				&dp_set_mst_en_for_sst_ops);
+	debugfs_create_file("amdgpu_dm_dp_ignore_cable_id", 0644, root, adev,
+				&dp_ignore_cable_id_ops);
 #endif
 
 	debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root, adev,
-- 
2.34.1

