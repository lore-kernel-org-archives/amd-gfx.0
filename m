Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58093C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C832067C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DS2VGC/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C832067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40EF6EC1C;
	Fri, 21 Aug 2020 22:58:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62826EC1C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 22:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhwXSPFZhahxQocaBC6HeqI07YqdJvRJVkvOo2O8UeJBhmq6cRlXm0fmdTRwmC8YsHIvX78GVMcO1dDTH/V+GKP1p6WUi465OiOwnwSyz0Vo+WRrN/VqZlGFc01xwSRzX77cAeV/mYxB/AgSpazW2Prdehnm+Q0uKhQm2HcROLFcooCY/cmRekWf7VIB7GlOIFBDXmWV4rjPvk06xdO+Mn3zKT6UMpCD2nReAFsMX1+MF1tF1LPG0Q61lfqjub49k2u8Z7UGhc7UqoRUxCR0KzT57YVzQBgxOn5VGyQPmZdnVcWer+05nPzZor4Y9ytel121Q89AOG1D6cSimOCaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOyEiWAi3ujWbeRhvMD+YlMaz6WujqwDC3Mf00/IDGs=;
 b=W3xuF/jlLEPE8DzqIlv9muNIkzgqDx4IMm57IUtlOCV2adJNlNPCyRKlrCxbyLtZEiMLs9R1p36IojktQ1Ti7USBif3mXlO6VUJdU3j5m3nBwpMpba9XWrugb8Ttd8CnzasOOPZYRUdiu5rcdpn/BJechmri4C6nydvZWZVPtJCr69VGC1QZOeVO8/SPwRW8K34WG7kj6e5JWRa97IwXlwP2b/diEGnCBZctsZyjdt4vfJyYKUFLpAdt05C1iCiQRIHxw5X54QRnvMP0HjFAnzG3x1umwODrlOmR1P9G+fEVz0PN6slWUkg2iv2xl4Y/jwUk4E/CxLHSOREyfLkbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOyEiWAi3ujWbeRhvMD+YlMaz6WujqwDC3Mf00/IDGs=;
 b=DS2VGC/vAEVsxmPrxxPVK5g6XHpf9RR/rJyO68K4R71B7w8/KNfvY1r4hn8Anli0yt+Ohi1brST528HANQ4Vq4nIdpIY6ZUjHYtl+1LKYC1Ndbf6hmbtrWEFD0jub7BHeuidwnJUf5JqMZpAsaRD/4OsqVcXpUuhrUlO01b8lxs=
Received: from BN1PR14CA0015.namprd14.prod.outlook.com (2603:10b6:408:e3::20)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 22:58:34 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::47) by BN1PR14CA0015.outlook.office365.com
 (2603:10b6:408:e3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Fri, 21 Aug 2020 22:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 22:58:34 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:58:34 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 17:58:23 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/9] drm/amd/display: Add connector HPD trigger debugfs entry
Date: Fri, 21 Aug 2020 18:57:07 -0400
Message-ID: <20200821225709.136571-8-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821225709.136571-1-eryk.brol@amd.com>
References: <20200821225709.136571-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a21841b-34ea-49f4-7b99-08d84625bb88
X-MS-TrafficTypeDiagnostic: BY5PR12MB4066:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4066BF55901070357FF28BECE55B0@BY5PR12MB4066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIY/Rx+YUgPmJ6mNz9ONJxAapGBSVvqoGhmKqsRlG5j6vMo9v2sVRZwn+c8Lo4JzkM1/CNxeoqQ0Nmg9j1SylKaq3Vo33HKVDTHDDOAVodcASHxiKkptN8Ow8HlpYJB19XAU4hfaAZSUcqqejgbyN5CDz4IFYxCXWovkUU5zIBZpI85NqLSzuNFmpSDQwAmrHPPhiJOExXHyIr8XM7Z3jqPYG8pfRSgsVD5JWfCbYuQEU2QegxNnHdMzdq3DVkhjZmGLCDMliAHkJZNJ6I5gnKrxSFUbR1C3bBlWpZqgVY6ghyq7FSuEx+4FMAaM6AerkW6nueknHo5rs1L799FMtTVlhb533p7MZYxqq0ZXA+2M7VAnlflTO/DVcKFMhZnPqyD8Niigvv2WpOwbN7x31g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(2616005)(426003)(44832011)(1076003)(36756003)(54906003)(8676002)(82740400003)(6916009)(336012)(8936002)(81166007)(47076004)(5660300002)(6666004)(4326008)(26005)(70206006)(82310400002)(2906002)(83380400001)(186003)(70586007)(316002)(478600001)(86362001)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:58:34.6523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a21841b-34ea-49f4-7b99-08d84625bb88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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

[why]
Need a tool to retrigger a virtual hotplug for testing purposes with
force redetection in both DC and DM.

[how]
Emulate handle_hpd_irq for connector as if usermode would trigger
a hotplug. Perform DC link discovery, DM connector update, and
DM force atomic commit.

In order to trigger HPD on the connector user needs to echo 1 into
"trigger_hotplug" debugfs entry on its respective connector.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 8d366404c09e..a3787e5ae5b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1067,6 +1067,81 @@ static int dp_dsc_fec_support_show(struct seq_file *m, void *data)
 	return ret;
 }
 
+/* function: Trigger virtual HPD redetection on connector
+ *
+ * This function will perform link rediscovery, link disable
+ * and enable, and dm connector state update.
+ *
+ * Retrigger HPD on an existing connector by echoing 1 into
+ * its respectful "trigger_hotplug" debugfs entry:
+ *
+ *	echo 1 > /sys/kernel/debug/dri/0/DP-X/trigger_hotplug
+ *
+ */
+static ssize_t dp_trigger_hotplug(struct file *f, const char __user *buf,
+							size_t size, loff_t *pos)
+{
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	enum dc_connection_type new_connection_type = dc_connection_none;
+	char *wr_buf = NULL;
+	uint32_t wr_buf_size = 42;
+	int max_param_num = 1;
+	long param[1] = {0};
+	uint8_t param_nums = 0;
+
+	if (!aconnector || !aconnector->dc_link)
+		return -EINVAL;
+
+	if (size == 0)
+		return -EINVAL;
+
+	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!wr_buf) {
+		DRM_DEBUG_DRIVER("no memory to allocate write buffer\n");
+		return -ENOSPC;
+	}
+
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+						(long *)param, buf,
+						max_param_num,
+						&param_nums))
+		return -EINVAL;
+
+	if (param_nums <= 0) {
+		DRM_DEBUG_DRIVER("user data not be read\n");
+		kfree(wr_buf);
+		return -EINVAL;
+	}
+
+	if (param[0] == 1) {
+		mutex_lock(&aconnector->hpd_lock);
+
+		if (!dc_link_detect_sink(aconnector->dc_link, &new_connection_type) &&
+			new_connection_type != dc_connection_none)
+			goto unlock;
+
+		if (!dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD))
+			goto unlock;
+
+		amdgpu_dm_update_connector_after_detect(aconnector);
+
+		drm_modeset_lock_all(dev);
+		dm_restore_drm_connector_state(dev, connector);
+		drm_modeset_unlock_all(dev);
+
+		drm_kms_helper_hotplug_event(dev);
+
+unlock:
+		mutex_unlock(&aconnector->hpd_lock);
+	}
+
+	kfree(wr_buf);
+	return size;
+}
+
 /* function: read DSC status on the connector
  *
  * The read function: dp_dsc_clock_en_read
@@ -1986,6 +2061,12 @@ static const struct file_operations dp_dsc_slice_bpg_offset_debugfs_fops = {
 	.llseek = default_llseek
 };
 
+static const struct file_operations dp_trigger_hotplug_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.write = dp_trigger_hotplug,
+	.llseek = default_llseek
+};
+
 static const struct file_operations dp_link_settings_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.read = dp_link_settings_read,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
