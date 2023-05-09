Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14155C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9048710E1C4;
	Tue,  9 May 2023 22:08:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D3110E1C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxbYy7n1F4YkHkZqx8UpwyEnZW4bkLqfo9PSlE50DbZ/b1YC+tO/eDmvuhJ1oc+Tg7WpyaHTPSJsDhjOcVV2kV43ME4UWrWIj9/X+zxxtLdr3JshBzJri9zYxc5u9XT3DWoXZh9xdWx4Qb6+V9/XWgpHYcuubpgjAQ5IA2cv1FBnSUGhY8Hy6XzBcTwAd+IQeKbe2jMBArJfbyU0W4i5M93nYpT9BSu+xTQKo/oyOEW0Q2+7o9LO0GwrnRFZRn3kXtaOLTBd2d+qMFlSpo1TUfnX1EJ08bO+rpveWEr87ylsNKKCmvYnD5aBVATFqt/u2aAumlbrOITzzZNP9Rjovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLBtUkpE3aWQwZAxvgJ0PWuE4n6eZHkKjcvw6c1ftGU=;
 b=NlAt2mjABORGZRCPBnJ/BHVhHYccYrdU4Hr8JkWx/XJr1im04IoYrNO6lGWnQYzzasEpcf6bnPZEHgdqIN4ATkYV4tJ/5bRqWhKMQ3HDVwoyGelzltN9sBuBrZ2gAmiN31OZmq/KgKDRbY/n5NcjRl4pLeG2s9FXbwNapOV9JGlEbhlhaeND6ATv+pbsLVCReX1wsS37EXsIV09aspu9CiDr1EymMcW/saRGaddb2Dpg0qzwY37Jb/5iguBnM8Ps69ykPD8Rw7CJuc8IXBOnBLHJFY8BGaIKKldxdpjrDToMCM70Adpv88HE4IMEuFwGVrRbvoMd6hJHiCeNgqthbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLBtUkpE3aWQwZAxvgJ0PWuE4n6eZHkKjcvw6c1ftGU=;
 b=19IvEQvw2NA9Of6Z56/1IA/dCaebzcPUhXv0fvcAbi1diagYdV5Slk8xSlNpCwLuqP7wG6vjKcQhBltHFTenZ6lLQ1h/tNrVvebi3wa9oWp2VJ0w1Q7JxecC0chV2sRA34LFale8hURLdrF6bxxERYmCXwwGJjI3HR6f1YDigvQ=
Received: from BN9PR03CA0236.namprd03.prod.outlook.com (2603:10b6:408:f8::31)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:08:34 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::78) by BN9PR03CA0236.outlook.office365.com
 (2603:10b6:408:f8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:08:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:08:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Add flags for partition mode query
Date: Tue, 9 May 2023 18:08:15 -0400
Message-ID: <20230509220818.475582-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: e7976308-edc5-4d89-29f1-08db50d9ee3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mu7ntDb5f2wbqL6JtMQ2iiJdP5rtsK+hn30ZErLzbmrkM5chOKxBIZTimU/RFTTEnzb3YxbgfNwyHW3IFQkfToYGoq1ja4IOUzHLpB15azRgSkZoGHUSPcPY4NCud/ljfuKfMSrWMI24S/DYpkwQzdNlex0XD+baK2YO7tUCXlf5zvXdsdHqs5fJGHTYc+bW2EWZNRnrcWBWKUDBrYMm/rPux/Lcs7ZWks3C/qLlpt1+JLI40wsx06CfzdD+OwAaD7EAifgtAUi3HURtg4tAdJlSfU78AQpTBOT1sc8XypRqYM7gmQhXxiJTwy0tCk5FiMewXmEAzdf54ELTkTk4O1GaNzPREwPKFBkXgy33aZhLv4DICTDWscW/BWloW5zKFeQEXmiRU5gTDw7PmtEbk9JCf6ofXFCtjYzX4zdrJ5fIXv6g8ZTylrhGuJmkVZCP5hVBsYq8yGwYWIrvBIrEv6RDZ5RlZPbG+yt86diZXNgDyxuYGLVvlLg96p6l1/7Xov+qdc3IY6qw1N8VWuwsYb03PDg4iuHdFrDaMpyD+cucpupuCf8xiVSBV4SZTDohZ/v781+wUOKFbU3OPKVASEgTaDUWrMgWiLhlqSELq+usaNOaW96R9eSDwUFQzNiGEsngIVnDHeNhDW77koGW/48uqkjl9gcw5wEX8QlG5rmYyA+lKGLQk36EL8prMsgC3EDrvhtecWDlRTPovKMkUVKSskmENM13W9bKaxv8YEY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(6916009)(5660300002)(316002)(41300700001)(81166007)(82310400005)(4326008)(82740400003)(356005)(70206006)(26005)(86362001)(70586007)(54906003)(1076003)(2906002)(8936002)(8676002)(186003)(16526019)(7696005)(36860700001)(36756003)(478600001)(47076005)(83380400001)(40460700003)(426003)(336012)(2616005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:08:33.7568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7976308-edc5-4d89-29f1-08db50d9ee3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

It's not required to take lock on all cases while querying partition
mode. Querying partition mode during KFD init process doesn't need to
take a lock. Init process after a switch will already be happening under
lock. Control the behaviour by adding flags to xcp_query_partition_mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index dc0e5d18a0cc..a939ffe2969a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1171,7 +1171,8 @@ static ssize_t amdgpu_gfx_get_current_compute_partition(struct device *dev,
 	int mode;
 	char *partition_mode;
 
-	mode = amdgpu_xcp_query_partition_mode(adev->xcp_mgr);
+	mode = amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+					       AMDGPU_XCP_FL_NONE);
 
 	switch (mode) {
 	case AMDGPU_SPX_PARTITION_MODE:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index f59bc450cabe..5b999e5334bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -170,7 +170,7 @@ int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
 	return ret;
 }
 
-int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
+int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 {
 	int mode;
 
@@ -180,7 +180,8 @@ int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 	if (!xcp_mgr->funcs || !xcp_mgr->funcs->query_partition_mode)
 		return xcp_mgr->mode;
 
-	mutex_lock(&xcp_mgr->xcp_lock);
+	if (!(flags & AMDGPU_XCP_FL_LOCKED))
+		mutex_lock(&xcp_mgr->xcp_lock);
 	mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
 	if (mode != xcp_mgr->mode)
 		dev_WARN(
@@ -188,7 +189,8 @@ int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 			"Cached partition mode %d not matching with device mode %d",
 			xcp_mgr->mode, mode);
 
-	mutex_unlock(&xcp_mgr->xcp_lock);
+	if (!(flags & AMDGPU_XCP_FL_LOCKED))
+		mutex_unlock(&xcp_mgr->xcp_lock);
 
 	return mode;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index f0b973c6092f..9fa6f0ea2061 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -30,6 +30,9 @@
 
 #define AMDGPU_XCP_MODE_NONE -1
 
+#define AMDGPU_XCP_FL_NONE 0
+#define AMDGPU_XCP_FL_LOCKED (1 << 0)
+
 enum AMDGPU_XCP_IP_BLOCK {
 	AMDGPU_XCP_GFXHUB,
 	AMDGPU_XCP_GFX,
@@ -99,7 +102,7 @@ int amdgpu_xcp_resume(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 
 int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 			int init_xcps, struct amdgpu_xcp_mgr_funcs *xcp_funcs);
-int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr);
+int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags);
 int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode);
 int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
 			     enum AMDGPU_XCP_IP_BLOCK ip, int instance);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 42877c4505f1..69867294117e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1940,7 +1940,9 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 {
 	int r, i, num_xcc;
 
-	if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr) == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
+	if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+					    AMDGPU_XCP_FL_NONE) ==
+	    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
 		amdgpu_xcp_switch_partition_mode(adev->xcp_mgr, amdgpu_user_partt_mode);
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index d7cffd91f1d7..4293cbf9ceb0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -645,7 +645,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 * If the VMID range changes for GFX9.4.3, then this code MUST be
 	 * revisited.
 	 */
-	partition_mode = amdgpu_xcp_query_partition_mode(kfd->adev->xcp_mgr);
+	partition_mode = amdgpu_xcp_query_partition_mode(kfd->adev->xcp_mgr, AMDGPU_XCP_FL_LOCKED);
 	if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) &&
 	    partition_mode == AMDGPU_CPX_PARTITION_MODE &&
 	    kfd->num_nodes != 1) {
-- 
2.40.1

