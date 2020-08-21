Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF87C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7063D2067C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aettWJgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7063D2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B69A6EC24;
	Fri, 21 Aug 2020 22:58:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 781A76EC24
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 22:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9uJQb1V5gv7dPOGzzk80xTgmOXmuNnu8VZjPJ1XHq3glNsF9wVazNlNxLm1jcF0RvKgs71tx5NfZWvT26fzhimvS/pEOqS61pH77tyfjZlcQ/swq1zNCmMDY2YLNgf2UP8Vd3W6i3aJnuc8LuJk60tS0qawlJHKXNRbwxj7XS1Uy93Z43Bk2/UfLI3Jmv1lILFjLqYwUFWMWLzmh7GSNZCS1w9dKmgtSDQfNTSz8MFE7onz2qA9EoGsV/IHwEXeEKGJwqhrBKh/YYF7tPxeHiwMlo9xOswSeMB/UUYws7JB58r9TqulAppHHlILDE3HEe20OkaX7XdVY4rvX+/VNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tfF80KDPhinUdLDmLQdopmQrnr9Ju6VyLi3w5YNtHs=;
 b=VuWTVeSNTq1cOlF2iFjJDUGT3NViT/OJSnLfeg3GJHjfeOM3h1VAwHq3ZgBpdJVgj1SpktSFsQ1j0dTiLwPZ3Wc4unvQ84E9SumnttwgwQahCwfJHclDU6yNmQGUjfyjYKr61sqDulUeYToxgtcsvaKDQSuyPO4kTmBjAiJAWoPwyhAIbJYa91lylZ+7XVGsy77p85yMvWZ27u/UifCI7JHx6wMwsQQMmWa6jDw1IzE5zwKHIBtZC8beKOvnZ3qmcQgKQldr3gFR5sebNgHMPpkszVeSFu+gsViIcKz2JxAnGZGZfdRU1yGGCnssKbMjjIChBEgboMYyDFMdVyNyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tfF80KDPhinUdLDmLQdopmQrnr9Ju6VyLi3w5YNtHs=;
 b=aettWJgT9j00HRM57fBGLgeyzzsKt1siK2YKMf8k9DEvOdSg1Zn2cFJktNHq2+eZa3sQnGYm2t5uvKL6VxTt42Sq1RnsMFU5fUEsvSJ/8CqxkamTeOaaqnZ+Pm331APsHbVnxtekoa4EsCDHDi1PKsz/n4djGOgf7jjvt/Df3yI=
Received: from DM5PR13CA0065.namprd13.prod.outlook.com (2603:10b6:3:117::27)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 21 Aug
 2020 22:58:24 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::bb) by DM5PR13CA0065.outlook.office365.com
 (2603:10b6:3:117::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Fri, 21 Aug 2020 22:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 22:58:23 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:58:23 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 17:58:12 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/9] drm/amd/display: Add debugfs for connector's FEC & DSC
 capabilities
Date: Fri, 21 Aug 2020 18:57:06 -0400
Message-ID: <20200821225709.136571-7-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821225709.136571-1-eryk.brol@amd.com>
References: <20200821225709.136571-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48fd37aa-a155-48e6-3cbd-08d84625b52d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4150:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4150F7A260AFBA39F96ACB39E55B0@CH2PR12MB4150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:222;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cpa7KFm2pIZOpyJygHsPRZymVbYI2NLX/h77SbOZ6Fy4iPIe8GrFSjH7Cwge7NeZdHvfGOh3g9LUR+U01wkjhABMA3R/oahA9vqG+ZKsg9oRKNmJWQMusd+DvYc8rT9gywIYqd64kbk2mY8t4m4G0gw/zMWi9vqX/AQMke1+AfGsPbMOC26WhC5jmdn91TcobQcGxtbAICn+Y/7+bBVQl5pDVdtXzLVbeTTFINzEWcgBrgh8kkcsyQ0uHYjf+wGSsO13DebswERtKi9ZyBNpAIQ3MpnEOx+1dbLXgXxzl38O4vAG122IXJeGbIBaTRoxqMALxSzLk3VDfVU9IRYqPOATQry4YHWNRq0cb78ThnqlJvT9jnNXSKGZdSsbDZ6dRhJFrF/XB+LzUwplOSfWrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(6666004)(70206006)(47076004)(2616005)(44832011)(26005)(356005)(82310400002)(478600001)(36756003)(86362001)(70586007)(316002)(426003)(2906002)(5660300002)(83380400001)(186003)(54906003)(4326008)(8676002)(8936002)(81166007)(6916009)(1076003)(336012)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:58:23.9450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fd37aa-a155-48e6-3cbd-08d84625b52d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <Mikita.Lipski@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why & how]
Useful entry to understand if link has DSC or FEC capabilities,
implemented to read DPCD caps stored on the link. Better than
manually reading the registers with aux dpcd helper.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 73 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 84360f3a0162..8d366404c09e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -49,6 +49,10 @@ struct dmub_debugfs_trace_entry {
 	uint32_t param1;
 };
 
+static inline const char *yesno(bool v)
+{
+	return v ? "yes" : "no";
+}
 
 /* parse_write_buffer_into_params - Helper function to parse debugfs write buffer into an array
  *
@@ -998,6 +1002,71 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
 	return read_size - r;
 }
 
+/* function: Read link's DSC & FEC capabilities
+ *
+ *
+ * Access it with the following command (you need to specify
+ * connector like DP-1):
+ *
+ *	cat /sys/kernel/debug/dri/0/DP-X/dp_dsc_fec_support
+ *
+ */
+static int dp_dsc_fec_support_show(struct seq_file *m, void *data)
+{
+	struct drm_connector *connector = m->private;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_device *dev = connector->dev;
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	int ret = 0;
+	bool try_again = false;
+	bool is_fec_supported = false;
+	bool is_dsc_supported = false;
+	struct dpcd_caps dpcd_caps;
+
+	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
+	do {
+		try_again = false;
+		ret = drm_modeset_lock(&dev->mode_config.connection_mutex, &ctx);
+		if (ret) {
+			if (ret == -EDEADLK) {
+				ret = drm_modeset_backoff(&ctx);
+				if (!ret) {
+					try_again = true;
+					continue;
+				}
+			}
+			break;
+		}
+		if (connector->status != connector_status_connected) {
+			ret = -ENODEV;
+			break;
+		}
+		dpcd_caps = aconnector->dc_link->dpcd_caps;
+		if (aconnector->port) {
+			/* aconnector sets dsc_aux during get_modes call
+			 * if MST connector has it means it can either
+			 * enable DSC on the sink device or on MST branch
+			 * its connected to.
+			 */
+			if (aconnector->dsc_aux) {
+				is_fec_supported = true;
+				is_dsc_supported = true;
+			}
+		} else {
+			is_fec_supported = dpcd_caps.fec_cap.raw & 0x1;
+			is_dsc_supported = dpcd_caps.dsc_caps.dsc_basic_caps.raw[0] & 0x1;
+		}
+	} while (try_again);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	seq_printf(m, "FEC_Sink_Support: %s\n", yesno(is_fec_supported));
+	seq_printf(m, "DSC_Sink_Support: %s\n", yesno(is_dsc_supported));
+
+	return ret;
+}
+
 /* function: read DSC status on the connector
  *
  * The read function: dp_dsc_clock_en_read
@@ -1856,6 +1925,7 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 	return result;
 }
 
+DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
 DEFINE_SHOW_ATTRIBUTE(output_bpc);
@@ -1983,7 +2053,8 @@ static const struct {
 		{"dsc_pic_width", &dp_dsc_pic_width_debugfs_fops},
 		{"dsc_pic_height", &dp_dsc_pic_height_debugfs_fops},
 		{"dsc_chunk_size", &dp_dsc_chunk_size_debugfs_fops},
-		{"dsc_slice_bpg", &dp_dsc_slice_bpg_offset_debugfs_fops}
+		{"dsc_slice_bpg", &dp_dsc_slice_bpg_offset_debugfs_fops},
+		{"dp_dsc_fec_support", &dp_dsc_fec_support_fops}
 };
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
