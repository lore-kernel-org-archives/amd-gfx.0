Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F01C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2B664E38
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2B664E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D846E44C;
	Fri, 26 Feb 2021 22:37:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71286E44C
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9TCSZE4Shuw4RE1Twqy838qydEUe/UOGDDZ8ivkBXpToCiGz7HEMFe0XNo7mNXfDswr16iSmRBpVicuXICCBLw3x5OzCj8xtaPjasbpdl+CbojdWZTOAANqRfN1QLwCMzVSUh5zDEwmfntG+s92xlRosGreLwq62//dQtA/eLI65iPxwfmahY8tIaK4/rYs2zYlIGM+CXXyBQNOC1ORcFLZFGeN5GyKOd1WUbNv7oyimOdT4Om/W4Revxgy8VODbHBqGD3CO0xbHjklR2l5VDP57DusofzPL9VR797lQ2I/3el8/U1zDZOdGWMSBnJJ82Uj41nO+GBbyr/zYSR/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn/Hf04hmaSNKOOMpLpYtlavEjJ5w1S5HTf+LlgaZBU=;
 b=Q1LtfU+cd7kV/8W7cB9AeIYq6G2qWMyMbZfNrIFLdR0cQqxtf+KFADD3lPK/Vdpb1tTtrvSZRceUs2Rjk92SiayLB4qLmRZkQw4gjYmFA2ulO0dtY6koO1d1uxba93Iuc0IUI/Wdq2AoM4ymMecrhqlEDxl48PF+rIj9YzldzRw/hCVg7BWblh79iPvfAv5Coe/+fxanGtm+nZjqDYtLHVSM8f3qchmXj0DGehecZw2aV7TCh7uCYBGsJjwz+XtidaGcRWQp7pthyoZyij+xAX+6lEMOkQ3JptTYZejatMN2XpJKp5EreXLSWK2sy0GT6Ir4JeWahf8U/iaei+MBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn/Hf04hmaSNKOOMpLpYtlavEjJ5w1S5HTf+LlgaZBU=;
 b=x223o2YDjjrAUhbpf+ljSPsftpBGIaz6c2Do6ZWMZmFod2n+yTuyopjmhwuwWnz6JCF/i0o5GWuQC55lL1IVTmlVVvM3AOv07LYimPrJ+m7ued08uuthNot2ScWbm/CCdcpF2/n+lzxqwB41cY+uOjL5soLKnIw3RYfgLnQMARU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 22:37:44 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:37:44 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/11] drm/amd/display: Add max bpc debugfs
Date: Fri, 26 Feb 2021 17:36:57 -0500
Message-Id: <20210226223704.400472-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
References: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf]
X-ClientProxiedBy: BN9PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:408:fc::12) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf)
 by BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 22:37:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c68feb64-a137-4220-94b1-08d8daa72215
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18839C1BF776201C4533E1F0989D9@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWT2h+H/N5r9avCwVzBxL10HOWER7RQ+rGRe6syST6Yocztgr4cUj0fZlKok7zZmqsC3cg7mBPqJYMhmZTOi+2pbdlc7OnxR5ujJvuf52zaAH2kwu5WiKPtgOU0YIWJHwu9vJrVR1acyTDK2EHMRk86/r4NXVuMEA8WdBp149i7N1c5LvqPGV9QooOb7Cyw5v+rumnt6o4Yw05V6IfWk7/eH5glMKqSTyhqPZmqnsLvcaFRT/bfvW/piJuysSZ0jtdlSrTMQxONoTO9WlWLwG+HZHcPeOFfJ44TddrrPQ2P3KfQlNEAbsGbPb2No3GhlE8qJrwDyvGHs42TqFe12mwu6vHuZ0eBdcA6koI6zS0+nKNT1xFXk1n8H9W9/sH/Gf/bo3P85cLFYCyW0eAksxDqdcxONKEIx+CjdnJ2UsjH3NQsHOb/saL+dpy+P5ppEzLDIuKYDrrc5GvsyRIhAILp5IB0uzPNBfxNPhPmcmHYb0Q8MNVCzhsyMRZtIzZOo0gQyagZIqGChr9QvXH6izQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2906002)(6916009)(2616005)(5660300002)(66946007)(316002)(16526019)(186003)(1076003)(54906003)(83380400001)(36756003)(6486002)(478600001)(66556008)(52116002)(4326008)(6506007)(66476007)(6512007)(8936002)(8676002)(6666004)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6IRXX8/JIhl574lHsR+25BQ+KIYaoA9qcdQy6WvlEDHqtNWL5hC2vucQ0OEp?=
 =?us-ascii?Q?hkbIIH4Ra3zVyDOa2XlnoXlq4uKt/EgTG1sXNDb6DZw5rDATaCGIUCgsCADD?=
 =?us-ascii?Q?H7gudNuTESKGHECXCu80JGt4q+wEY7AkVVILzHATiUPJ8K3m41khzeU5RWrN?=
 =?us-ascii?Q?TvCb1igFsV4gcEYef3rgEy6azqsvXuBLH1PaS5+fm3ynapG4pJmtnAF+GTXu?=
 =?us-ascii?Q?uFtw1/qBV7r/WXMIcsIMUbikPyiyEPdiPc1cMbGblBITXk29o6W3b3MjBDKf?=
 =?us-ascii?Q?LwQqOdmAH820cRU+cAlQbGLzXznGmzfK9qfhDT9cug4gfsd4DeYd7ieSoHnd?=
 =?us-ascii?Q?DhOL4u0mG1FZprmLQNEkS9wAs1UxMd8ORDB1TWB0y5Vzw00oWrUJ7L1Mab0n?=
 =?us-ascii?Q?3RtNZVA8GGLt+qNT6q1NsQMrVw8hPZHcgV84AbTYyzRrSNngLQ2suclJjpqU?=
 =?us-ascii?Q?YJIkSaj4YXpd83M2peCMZOnTsTtsb7PYjCQUD0GHjUjp76H2k/rnZYZhgnFJ?=
 =?us-ascii?Q?QtOU4DzgxJp8EnW8Ybdfe54pS6dwV2Xnz5RI2BptZo6YxdkQ5HEvi240HPux?=
 =?us-ascii?Q?uob+Xe/SfM+RbThpuHNjblqcmL8nd9hG60BsI5ZTWpOT/ZQ02OFntaXIPUNB?=
 =?us-ascii?Q?j9GrZd+7ri7tmFQojeoyaf41Ij0yFf9LId2N3up9hZxb7xbYrPVp0UV3cjlx?=
 =?us-ascii?Q?h6e16NcKREovpiRUunRjpQ3bineAH1ZdtwxGr7nCYeoUFIZy3PRK9GZRsN87?=
 =?us-ascii?Q?PVHz8pTnwu2M8doT27hZMgzWbGHqTkEYX55T641fp3AtdIc7IMP3ywgh8pjb?=
 =?us-ascii?Q?wvNEbqESCX+N6GYZSx/+qgx5BmYEGxdomuhBDC1Y+WkVonw99UwqB2VmXSzQ?=
 =?us-ascii?Q?yIh1UhZxol2afe1ewwMFkp4nt0ivOZTlnRGhAmfBFkoE1kkokXv+i7mrekdy?=
 =?us-ascii?Q?4zHogMU0hi+WI2XUxrQV9QgyDUyVubxQXwjwW/GBtDYtB0lGW7Q67ZFKqzie?=
 =?us-ascii?Q?UP/E2M65RE7kgADhZQujv2wR2mw8SwRhb1EwvdcX28aTe3qnljlxLx/Qm8ky?=
 =?us-ascii?Q?Mvm+S+sdo7rNE5EEP8DKyQhVbLHDRNSJPRM07CfxGpsC5ZBVhSpXokfFJmqZ?=
 =?us-ascii?Q?3Ebcrl1YVV9XZLoTwHX2dAlarAcpxA+iL8+uQng+ZYNVoXgCJHfpCM/SCIJl?=
 =?us-ascii?Q?bnH73XDN+TEfdQr2GZECFMhwT0fMoATj+DoKoYcgsGxMBQE8yGC4AbrPf0VL?=
 =?us-ascii?Q?H7tZ9eCBo3sPuCDkFl0BN7seCEmeBCoYRyz0gJ7m2Of7lYNchXkkQ8+PFlJ7?=
 =?us-ascii?Q?91FSZSjQcxdjGOsOw79XGTg07IUJVQwUaQE0Z5edB1cuiXZL/x9CymupFA03?=
 =?us-ascii?Q?q3UezKwM2uJpfDp7S5aASUISs38E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68feb64-a137-4220-94b1-08d8daa72215
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:37:44.1767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iy/dNlGhzJiSxe+aTYXmF5wemTo3K+NFf5QpLvWjTuWL6G4ZBdFxnptzQ25XYo/Py6OxtNj/tBgimZowpFAHKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Mikita Lipski <Mikita.Lipski@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[Why]
Useful for testing when setting a max bpc value higher than the default
is required

[How]
Allow for reading/writing of the max_requested_bpc property of the
connector

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 153 +++++++++++++++++-
 1 file changed, 152 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index f7408d09ded9..859560a89afa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2152,6 +2152,149 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 	return result;
 }
 
+
+/*
+ * function description: Read max_requested_bpc property from the connector
+ *
+ * Access it with the following command:
+ *
+ *	cat /sys/kernel/debug/dri/0/DP-X/max_bpc
+ *
+ */
+static ssize_t dp_max_bpc_read(struct file *f, char __user *buf,
+		size_t size, loff_t *pos)
+{
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct dm_connector_state *state;
+	ssize_t result = 0;
+	char *rd_buf = NULL;
+	char *rd_buf_ptr = NULL;
+	const uint32_t rd_buf_size = 10;
+	int r;
+
+	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!rd_buf)
+		return -ENOMEM;
+
+	mutex_lock(&dev->mode_config.mutex);
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
+	if (connector->state == NULL)
+		goto unlock;
+
+	state = to_dm_connector_state(connector->state);
+
+	rd_buf_ptr = rd_buf;
+	snprintf(rd_buf_ptr, rd_buf_size,
+		"%u\n",
+		state->base.max_requested_bpc);
+
+	while (size) {
+		if (*pos >= rd_buf_size)
+			break;
+
+		r = put_user(*(rd_buf + result), buf);
+		if (r) {
+			result = r; /* r = -EFAULT */
+			goto unlock;
+		}
+		buf += 1;
+		size -= 1;
+		*pos += 1;
+		result += 1;
+	}
+unlock:
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	mutex_unlock(&dev->mode_config.mutex);
+	kfree(rd_buf);
+	return result;
+}
+
+
+/*
+ * function description: Set max_requested_bpc property on the connector
+ *
+ * This function will not force the input BPC on connector, it will only
+ * change the max value. This is equivalent to setting max_bpc through
+ * xrandr.
+ *
+ * The BPC value written must be >= 6 and <= 16. Values outside of this
+ * range will result in errors.
+ *
+ * BPC values:
+ *	0x6 - 6 BPC
+ *	0x8 - 8 BPC
+ *	0xa - 10 BPC
+ *	0xc - 12 BPC
+ *	0x10 - 16 BPC
+ *
+ * Write the max_bpc in the following way:
+ *
+ * echo 0x6 > /sys/kernel/debug/dri/0/DP-X/max_bpc
+ *
+ */
+static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
+				     size_t size, loff_t *pos)
+{
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct drm_connector *connector = &aconnector->base;
+	struct dm_connector_state *state;
+	struct drm_device *dev = connector->dev;
+	char *wr_buf = NULL;
+	uint32_t wr_buf_size = 42;
+	int max_param_num = 1;
+	long param[1] = {0};
+	uint8_t param_nums = 0;
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
+	if (parse_write_buffer_into_params(wr_buf, size,
+					   (long *)param, buf,
+					   max_param_num,
+					   &param_nums)) {
+		kfree(wr_buf);
+		return -EINVAL;
+	}
+
+	if (param_nums <= 0) {
+		DRM_DEBUG_DRIVER("user data not be read\n");
+		kfree(wr_buf);
+		return -EINVAL;
+	}
+
+	if (param[0] < 6 || param[0] > 16) {
+		DRM_DEBUG_DRIVER("bad max_bpc value\n");
+		kfree(wr_buf);
+		return -EINVAL;
+	}
+
+	mutex_lock(&dev->mode_config.mutex);
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
+	if (connector->state == NULL)
+		goto unlock;
+
+	state = to_dm_connector_state(connector->state);
+	state->base.max_requested_bpc = param[0];
+unlock:
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	mutex_unlock(&dev->mode_config.mutex);
+
+	kfree(wr_buf);
+	return size;
+}
+
 DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
@@ -2263,6 +2406,13 @@ static const struct file_operations dp_dpcd_data_debugfs_fops = {
 	.llseek = default_llseek
 };
 
+static const struct file_operations dp_max_bpc_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.read = dp_max_bpc_read,
+	.write = dp_max_bpc_write,
+	.llseek = default_llseek
+};
+
 static const struct {
 	char *name;
 	const struct file_operations *fops;
@@ -2285,7 +2435,8 @@ static const struct {
 		{"dsc_pic_height", &dp_dsc_pic_height_debugfs_fops},
 		{"dsc_chunk_size", &dp_dsc_chunk_size_debugfs_fops},
 		{"dsc_slice_bpg", &dp_dsc_slice_bpg_offset_debugfs_fops},
-		{"dp_dsc_fec_support", &dp_dsc_fec_support_fops}
+		{"dp_dsc_fec_support", &dp_dsc_fec_support_fops},
+		{"max_bpc", &dp_max_bpc_debugfs_fops}
 };
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
