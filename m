Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B4CC35246
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAAD2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ejXiBW91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAAD2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC17B6FC47;
	Fri, 31 Jan 2020 22:17:23 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFCA6FC3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY2dRzmAy455u0j9SXWhg8QvBR6zamg4oYo1eoxtQJr8Ss+f8qaHb3KuF5wPLr7GwfZM4rzw3Sr4S5dNG5aarc3+GYn4OMidDRu9Lkfv/pU5aNoD8xX/Jy3OkBiOYt+1nGvCNgg/Yay7aSqhzdZ51b5UMbxzKIwSLU+6RdHWs/cO2e6tyHsnvV6FI7sX91Wo6LSWhW5b1u+lPA4/7sDoNYXRCpM5IQR65FiVzqF+QjWtGHS+aJ0g3mYtD+fD60/jCpqUWjg94Le68H1a1PcYY7QFICmLfecLUAAFj4/qQgFd0CZKAqeyvZ96huL74ygtXzT+dbpVHAS3mElQNd9YtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udm127YBxD62vAIWzAvZXYM14ZN2cpWqVsIEil1dM3g=;
 b=ENmggdZC1iTsXCRcRRRoqRQNn4GrLtPEyevaVRjkk1ITq5imgVtQQO7+vq7pxNuib/fgVafVif/esy7uHrXjhXzCQt/1JMskEyLv7O+8AdIjC86f2fpcVzf4/j5V8iwDnwhpb95inq5wqsF5C/xdvu/uxI/z+5jAS/QI4hbrdZErj0SjBBHkungI8UcLKzSr8mzXK+4vnBa/JUqLHqoxfUaFUSxcpdrXmY0RzfU4ifi7sEN9Pq49mZmLsMHXWPyiBdISH0MwE/IqWaR0eVrBAHSBIujJP6yDkGB6nSFkC+nzqD8WCH91/kwP72FI7kGMXWCh1s8Cqq5/pNfKgqw+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udm127YBxD62vAIWzAvZXYM14ZN2cpWqVsIEil1dM3g=;
 b=ejXiBW91lOHaC1ls3XJQQsy96fjjxILaox6qJG8pSlQRIrIbmHJHOII+vAM+SXPr8W7NDLucGWwzH3J3yNk2lwQTw1J1o4Ua6fZcttcz7Vca2lBCOP7FXMI1Z8u6+cLsYYHmLelkgR/YSgGkuny6MqHvM59JkA/R9rNmR4y3QIE=
Received: from SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Fri, 31 Jan
 2020 22:17:18 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::208) by SN1PR12CA0075.outlook.office365.com
 (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:18 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:13 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:13 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:13 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/33] drm/amd/display: Add DMUB tracebuffer debugfs
Date: Fri, 31 Jan 2020 17:16:38 -0500
Message-ID: <20200131221643.10035-29-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(428003)(189003)(199004)(6916009)(478600001)(86362001)(7696005)(1076003)(5660300002)(36756003)(356004)(316002)(6666004)(70586007)(8936002)(70206006)(81166006)(81156014)(8676002)(2906002)(186003)(2616005)(336012)(26005)(426003)(4326008)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1833; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 603277c0-6945-4a96-21c9-08d7a69b55a2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1833231C593AFF056620807EF9070@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKbxfFhaTRCuVouM4Di6UViYwMxqB6kgMPRzskDwHeI7BiwIbnHVU0gJSIB9cb59AWC3E0Z3DMcmxgov5Ek+oHMy0xaSVaWVh96KsAH5NG6gUrSGTowVOJEiyRqf7DElb4Pn1/AC5tgmr15UHZdXp1F4cjElE1hux2w3vYLsEjs6BKDz/rV8Y3c28jP8I2tdaz0AsbdHgTZw7pnRuWc8zE4Hp0yoGOyMK3MT6yCOrBpi9ag7lecSlTm/Mfmmu2S4+hVwDi6tUICP2SmxVRsfYGpOKZYNZDxX6NaNChzcNqepBaAHFIrGELsP6/cTFWZq3wxtHBpFeqf/FDtdM/2IWLbyn+Q+z9rW6NJIfDhxUcJ1VEompoBKmNZIAZumI21pTnTEsGc3FOcmxWYSwJ6GAVLnSmEjcxPjQNadWeYadBqE69+5deEGHowsTl16Bi6/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:18.2614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 603277c0-6945-4a96-21c9-08d7a69b55a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The DMUB tracebuffer is useful for understanding DMCUB execution state.

[How]
Add a "show" attribute debugfs so we can loop through the buffer
and print the entries.

The structs for the entry format are defined in the debugfs since
the tracebuffer header no longer exists in the DMUB service.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index f81d3439ee8c..ead5c05eec92 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -32,6 +32,19 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_debugfs.h"
 #include "dm_helpers.h"
+#include "dmub/inc/dmub_srv.h"
+
+struct dmub_debugfs_trace_header {
+	uint32_t entry_count;
+	uint32_t reserved[3];
+};
+
+struct dmub_debugfs_trace_entry {
+	uint32_t trace_code;
+	uint32_t tick_count;
+	uint32_t param0;
+	uint32_t param1;
+};
 
 /* function description
  * get/ set DP configuration: lane_count, link_rate, spread_spectrum
@@ -675,6 +688,50 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	return bytes_from_user;
 }
 
+/**
+ * Returns the DMCUB tracebuffer contents.
+ * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_dmub_tracebuffer
+ */
+static int dmub_tracebuffer_show(struct seq_file *m, void *data)
+{
+	struct amdgpu_device *adev = m->private;
+	struct dmub_srv_fb_info *fb_info = adev->dm.dmub_fb_info;
+	struct dmub_debugfs_trace_entry *entries;
+	uint8_t *tbuf_base;
+	uint32_t tbuf_size, max_entries, num_entries, i;
+
+	if (!fb_info)
+		return 0;
+
+	tbuf_base = (uint8_t *)fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].cpu_addr;
+	if (!tbuf_base)
+		return 0;
+
+	tbuf_size = fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].size;
+	max_entries = (tbuf_size - sizeof(struct dmub_debugfs_trace_header)) /
+		      sizeof(struct dmub_debugfs_trace_entry);
+
+	num_entries =
+		((struct dmub_debugfs_trace_header *)tbuf_base)->entry_count;
+
+	num_entries = min(num_entries, max_entries);
+
+	entries = (struct dmub_debugfs_trace_entry
+			   *)(tbuf_base +
+			      sizeof(struct dmub_debugfs_trace_header));
+
+	for (i = 0; i < num_entries; ++i) {
+		struct dmub_debugfs_trace_entry *entry = &entries[i];
+
+		seq_printf(m,
+			   "trace_code=%u tick_count=%u param0=%u param1=%u\n",
+			   entry->trace_code, entry->tick_count, entry->param0,
+			   entry->param1);
+	}
+
+	return 0;
+}
+
 /*
  * Returns the current and maximum output bpc for the connector.
  * Example usage: cat /sys/kernel/debug/dri/0/DP-1/output_bpc
@@ -880,6 +937,7 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
 	return read_size - r;
 }
 
+DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
 DEFINE_SHOW_ATTRIBUTE(output_bpc);
 DEFINE_SHOW_ATTRIBUTE(vrr_range);
 
@@ -1188,5 +1246,8 @@ int dtn_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root, adev,
 				   &visual_confirm_fops);
 
+	debugfs_create_file_unsafe("amdgpu_dm_dmub_tracebuffer", 0644, root,
+				   adev, &dmub_tracebuffer_fops);
+
 	return 0;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
