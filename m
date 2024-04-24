Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3222C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 253A110FE2E;
	Wed, 24 Apr 2024 08:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NN1cjVZR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEB310FE2E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvxqqZRBIjL3g+QGG6F1CNvrhPKCKFKLWIaGZtwgu10NQw1WMyjiqL163QPb1feLyFbDbpYS2pgPsQTKBbvL60/Hvl0JlvyLox/RncaxIYEDl7kDXRdUY8aWheTSaz0ivudW1DZw0lW1gLKBMxUUxA0USuZnU8yfaJE6I5S7iBQy17HZEZM7YMR5LlRsZ8hzTIZrkVvWoQjtT59dbG9eTSJaIADhzDkSWDhj5/LIUt8IXbDZy2dwe0aYIcRsBES5pQIxcbS1xuiI1+y0Eu8jdbqR27wwi7HVDNngy1ofP3wA55a0U0JnY3D68G/ij2pQZ+dDXtyrhnbGRJ2q+3MTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r27Ee1CGIoQEZqj+MPGaXGhpZGkk356vGL0XsKghUcE=;
 b=gIqIn+maVpGWY+uA9ED5g6BeWiF3O64+Nlalq+uV2jwYAjmGobb2/3qlYoIrMHHuoQscV+KNZYo0Flym2wH7UkOkez3ge0ioGf0XSr/ks4R1yu/Jywt8EjYTB7YxZe1pM5/QzPY16RcF+DVQrrNhc3qhoFGR6/NznJzDMoqjkEms1mI8zoMpRimjcSBkFBF9i/Um9+PHuGUJXWW14i40XImysNugfm6/8J4aIVQ8B+ZeWRWdsCS83UehchtzctaGz310Y+mT1ECHxLq4hhvLmFFtlC0iktUWhMOZgRAsL+RjaUt6N7QRBB/98L3kQct8aK6zgjCHUrvMMd4nhl069w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r27Ee1CGIoQEZqj+MPGaXGhpZGkk356vGL0XsKghUcE=;
 b=NN1cjVZRFrMX5bGhHuWhBiTtuOL61MSngJP2Q99n8b4xBoviiUrL2hs8ceTYk3b1YafEl8342Vy5wnB4Ku9DrlH4G4yt0jnr3Dgpa3AUkvF36HszOC5gvtcCRY96H5yEa0mjhW84Tt/u7kxSqM9XEjjWQj1Gi56fI7UCoYSj+fM=
Received: from MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::24)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:53:37 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::b7) by MW4P222CA0019.outlook.office365.com
 (2603:10b6:303:114::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 08:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:53:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:35 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:53:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 36/46] drm/amd/display: Fix uninitialized variables in DM
Date: Wed, 24 Apr 2024 16:49:21 +0800
Message-ID: <20240424084931.2656128-37-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: e7caeae7-2706-406f-8a15-08dc643c077b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DIrxUTCHbdDrQzyXS12l2VNYAZbKZ8IK6FsGwICWmZhpNEk0cGkRzp/DAmlN?=
 =?us-ascii?Q?ie+GzB9ESICahD/j5by8LUTrNGqgx0r8Yd/sQuDY4O7XxPr83YjEE8aP4RmW?=
 =?us-ascii?Q?Y4ncBDxX9MbiVGXIerSn0UAiCXFMUj0jSEIkGtPv0vZFhdvLm0RJwaAuk2MK?=
 =?us-ascii?Q?QtZATfapJnicEs5g0UbmTBf9Qt6PCtjUyKdI37HiEVVRnbNjhWgI7dkOUkLz?=
 =?us-ascii?Q?Hbpp8hSou9taRPMxLejfqJ5f6zUcsU64A2l9Q/jKRmMOE5/mo/KVMhJboP7Y?=
 =?us-ascii?Q?k6pQmSdfv/JqKJ8UsehlRCnz/dmlgQQ4sRHvmczq8kIjJCVPs+vHm1FSz0NK?=
 =?us-ascii?Q?1FZVyP4xnWi2iJhJA5YGpCU7bVMr17gE5Khmx7TiHwT1oeNMMMWgnA438gVB?=
 =?us-ascii?Q?vTn/lmtXWirNlEizlLqTPylETTG2Xp5NtgUvqZCcmEqv3fAvEWFCJmKW5tlD?=
 =?us-ascii?Q?f8Rrh+zxel2MfYHYbf+VVaKgq3HOKGfNS9Q7Ju4JJ82zmbMDNAFVmB1Av1xL?=
 =?us-ascii?Q?4dvyPQwebkQlekTLumsO5zdk48rSt+e8NGjtw5gccYsr2kIUWK3d9VkW048u?=
 =?us-ascii?Q?t7PSc8gDBT8uQWFvZdcCW/4lING9BTGJaQNajtRUdHO7uJ3dC6h7RV+/iLLw?=
 =?us-ascii?Q?kItyjUnU9+1wNQgEppn5dA/Qf9oK0uc7anN4cI0qSNyiBUuLbzIi53/tVF0I?=
 =?us-ascii?Q?bEvNwz9rKFUF8FRPU6Ye/CVhswhBfeEEwX6ZXQpst6i12SGpEuNHQ6s5cGJ2?=
 =?us-ascii?Q?rgz9QlnEXnt+APlHXjA/qLF9pyrOyjlpV74pcFBTR+9RYsEqeMOW5uYabbNU?=
 =?us-ascii?Q?Pvt7eM6kNCGch/Mbz33ur4eLSpe00wh4HcWpHqhpKNwt/WKzcbt4nX+wUhJA?=
 =?us-ascii?Q?f+mUF9vF0j5vNn5ivl5eOvebBc6MbRlSe0IDBicWiYsDOYVx7LqYzwrOOyOO?=
 =?us-ascii?Q?Sz5lunR5P6xZTWqSjLitksTZW7ucHX0i7FUfvkj2lSgcWo84pfmr3vHl56mR?=
 =?us-ascii?Q?vyNhm0e53jFHmnmn1b3hBxJGOi8mf7p+ISsjDIoiGnJc6cqzRi/P4Wo4cdf5?=
 =?us-ascii?Q?epWNHQtmV0Jux2Ea1Q1jeBim1TxDZ2uIGYs9J/osMJveBiHCa6GxPy1hGG95?=
 =?us-ascii?Q?0zX11BQV1R06dD8cAMUH6an/GIdw3pOvigahzeH8CI3TQqhTGx7kvTSXYulE?=
 =?us-ascii?Q?nVZK/z0ssnZFFhZOirzq7gM5LmVoon+Z/Uwa9MCTaD54xDzzWaYK+NXh6F1/?=
 =?us-ascii?Q?U/Fz0or8u+G/3A6RmPW1ALmAI/K9E+SS6gqtwbTu4eVljbQO7dc8yjhTDnBN?=
 =?us-ascii?Q?ioGpR41I32YVVaQ94QRIbK08Hy7w1soBE+aQn9hIeKosGq8rFGWt0pnQvYrE?=
 =?us-ascii?Q?O7/NcjwFCzHxczrI01Z0tdH2XrDH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:53:36.4401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7caeae7-2706-406f-8a15-08dc643c077b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081
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

From: Alex Hung <alex.hung@amd.com>

This fixes 11 UNINIT issues reported by Coverity.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 8 ++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3ece11883941..29b5c953a656 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -277,7 +277,7 @@ static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 				  u32 *vbl, u32 *position)
 {
-	u32 v_blank_start, v_blank_end, h_position, v_position;
+	u32 v_blank_start = 0, v_blank_end = 0, h_position = 0, v_position = 0;
 	struct amdgpu_crtc *acrtc = NULL;
 	struct dc *dc = adev->dm.dc;
 
@@ -851,7 +851,7 @@ static void dm_handle_hpd_work(struct work_struct *work)
  */
 static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 {
-	struct dmub_notification notify;
+	struct dmub_notification notify = {0};
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
@@ -7228,7 +7228,7 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 	struct amdgpu_dm_connector *aconnector;
 	struct dm_connector_state *dm_conn_state;
 	int i, j, ret;
-	int vcpi, pbn_div, pbn, slot_num = 0;
+	int vcpi, pbn_div, pbn = 0, slot_num = 0;
 
 	for_each_new_connector_in_state(state, connector, new_con_state, i) {
 
@@ -10713,7 +10713,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	struct drm_dp_mst_topology_mgr *mgr;
 	struct drm_dp_mst_topology_state *mst_state;
-	struct dsc_mst_fairness_vars vars[MAX_PIPES];
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {0};
 
 	trace_amdgpu_dm_atomic_check_begin(state);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index c7715a17f388..4d7a5d470b1e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1249,7 +1249,7 @@ static ssize_t dp_sdp_message_debugfs_write(struct file *f, const char __user *b
 				 size_t size, loff_t *pos)
 {
 	int r;
-	uint8_t data[36];
+	uint8_t data[36] = {0};
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
 	struct dm_crtc_state *acrtc_state;
 	uint32_t write_size = 36;
@@ -2960,7 +2960,7 @@ static int psr_read_residency(void *data, u64 *val)
 {
 	struct amdgpu_dm_connector *connector = data;
 	struct dc_link *link = connector->dc_link;
-	u32 residency;
+	u32 residency = 0;
 
 	link->dc->link_srv->edp_get_psr_residency(link, &residency);
 
-- 
2.37.3

