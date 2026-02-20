Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADF7C5AE49
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440D310E82D;
	Fri, 20 Feb 2026 19:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M6fOAnsZ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 526E510E82D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSMqA/+62QBKJooVgCLDApv9MJGCNd5O1sjl7wx46nfmFXbaWkZKVH9YW35cjQSYgRArYKjLCfWp3MS/1kfg0bSr9k4nYOsQBi5U8+6u1irHe32Bk6aGF9qJxFitukMPPyrhXGgG4GsBzx7aWX2sMeqGlSv7QcneXMVoRRh+LueTJ4XcbOIiUrI2bHU5igFrYL+aAXpi9x724y0nYhxdr0AxrGHDCiXIFzSVwhp5QPH3+oG+yjhcL4YJ9bmz20fRIdKeVhSa6jn5Ge0ufNv+YsMTZ0RpOuItp7cVjkZxmS2xcb3mKMflBZZCKTt/z2kDOWLfyfyUwMqXbV+U+HxJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv972v+YX5KLkh7RUFS2sOC4Z+o9sEtRix9CnDdcl4g=;
 b=tmJIMSg2KZ6GcGr072/pIW+pvzmw4Yr65LXybnYemt9DfDcVEx/PeMHHTMZPyJbV+ya78FjZseAlAm9SL2i6VZ7qlLp/wrttjpAdKQTOYtT3iie5j+FyOUpkGelv5Wu31foasp8uydFPhfEjCP9kAFQUaNFDK1y3quDdhWqHCh0JlavkY27K8H9e9TGPhyXy13Ks8KMNFKKnBjwQQLYUtXFDbHhv7eaxkevZcUmrb6lCHpi9ZeHzgP96Tk29p9MpUlTsALopI6Lf7/Z1Yf4+Z4o/4zs/YmiKsLxELrjAPCwJDFM05vKGYRkiMs9AcUpsjiPg2E04Z7WlYNyypB9XHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv972v+YX5KLkh7RUFS2sOC4Z+o9sEtRix9CnDdcl4g=;
 b=M6fOAnsZL+LZX2jxXTCcwoApJDSwDYBdcpvzWaGqc0/4MnYM/tuiI9Tx7E/MGYCsVjBQgOl76A1Uxo5o4f1V4Z8joXNRGKJLLXGju1znHacBUbrBIQFseT9LVMeLXVFI0LVUY4DIatWUa1S7hNT+FTJ7uS+311/D08CgU7F8Rg0=
Received: from PH1PEPF00013302.namprd07.prod.outlook.com (2603:10b6:518:1::11)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:23:07 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF00013302.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:07 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:54 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 11/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_SET_DEST_BUF
Date: Fri, 20 Feb 2026 14:22:30 -0500
Message-ID: <20260220192236.3121556-11-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca39679-276d-4488-0e0e-08de70b57a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L6w9Uc4wWsDonhUzTv+dlrL1sMCc8YYep3+hS4bjhslcryGhCd3Fcg/qUi7h?=
 =?us-ascii?Q?V11G5n/Q/LxHGsrqb6tAq60AM6CZvqsLmWADwx1DP9515DQ6FkM7/LcbCoJZ?=
 =?us-ascii?Q?KJ8ZFRanjch3uQ6p/Ns5BU5HqhTiOmlNULrT5ka2RMQMH/GW2q+tVysrnA12?=
 =?us-ascii?Q?kYB4m4noBq7p8GvlVz4S+NxZGuv48+ffBHblzm32wa2KoNCIjQmoj/GQkcEo?=
 =?us-ascii?Q?vuT6/U+jcib25EXlv8Zbn9ayjAc2OyA9hwoOt5qM8707ED9b+IrdlAa6hnn6?=
 =?us-ascii?Q?cwFcWayDclhffIOWpDjSuhS1OhLKzwRUSasp1v9yO10FCb4CtZKtGxVRbJJk?=
 =?us-ascii?Q?bIxPkT7oYvs1q5619w/9Aj0kv+KwYK0EEyopRE8gmtTY96wGRNwKe6tBjAnI?=
 =?us-ascii?Q?dpGBTMVy2pvRiIjbOTaiUtCRrxvUjPcknd4gIpgwpSCj82Hsb+qGpRDXFKPq?=
 =?us-ascii?Q?2dhb+inpEFo9vhAfqUX383aFn5Y/oWzWCJnxOm2ffRlpke9Z4JuXx7TxMo14?=
 =?us-ascii?Q?7xrsozbzYFfEoLH9gfEBc8S7j/TMoYrBCiv8zRHhsjYQWUh4R+V6oJpGsYWp?=
 =?us-ascii?Q?gx2mP35FdF3unoS/2CM8u8sF+wX/Bk0xbTky9HQNj1AlHyikBUy51i6UeKom?=
 =?us-ascii?Q?LeNudbl78n9cCeIKx7PPbutWGffhNGpp+OCifOJ41VTj8RMXFbNVzqM7q3PK?=
 =?us-ascii?Q?eWDbQKoa1uyU21AXABP7mzkNCSNmSoTsVQdHdPH1tydr0dS9uI1Dx77EZ7Af?=
 =?us-ascii?Q?gTM48pp5xorsW8c/2wjIEl5agrEX6xDkdcWGA8pcY6YOY2MA9dcZ2BIbaVKQ?=
 =?us-ascii?Q?9ChYF/JXIDvAxCe6qwnEMWdiHDW1/OeAMk6XnHW+/S6EsKb/Yllk26aXlA3n?=
 =?us-ascii?Q?BvqkK5j4B2XDwh9yMhA7R4re5eNkqYbS6BKmibfyJMN23WT1yOaeJMeCsryc?=
 =?us-ascii?Q?iYcGb2AOxiujEA3Ii2izCbHrbc6pASA2cB5s/VHTyrluxbjsTBSoowf0b20O?=
 =?us-ascii?Q?hl6Hy49uoGlPWrOhKAC+siUmIMK9z5zCdqr7tMFclssEmjSvfLcjdVo0BiYT?=
 =?us-ascii?Q?IEiwED0B1BUfW8o3uHQP5dIzsdf9Jk9h54OBAJ8z3dv48jlBRXY2z5714//B?=
 =?us-ascii?Q?L2EfmkK6GW0XhHn7HV67asbbFYZ9fBIoEFV566k99DmK/l6kMlfzP1JEqSD0?=
 =?us-ascii?Q?qRBC7krI1hcQtEXkOpqXQ2p8m+TJ9q4BYt+FPQu7YQdyOw4nAWBueXxW0JXf?=
 =?us-ascii?Q?J7vteiTUr94IbJ8rUpfcbNa2pxGRGHIZF3b4KH2rYQ9vwhlfREI0ww+4zO35?=
 =?us-ascii?Q?/LOtCOtu76iNuo/Jdp0jGmbEgsj/FrBrg0IsOEhZdmaHrXEYFu55XZ3QFvBa?=
 =?us-ascii?Q?LLczf6IMsrXMN8ZtJcIH3EUNRXlzsKS6TzG9dqqh5r24V7cE8zv11dN8RxhT?=
 =?us-ascii?Q?Q4GHgtb0stA5ZcbVhFmECioBYuY6IbHrALWNJUXCrpQrmg6hQN7wFp+E1pMS?=
 =?us-ascii?Q?U3puxHOmOwJv+urUbAeJM6Bo3rNpVBZpwBjQRE6w5JeaKoDgaGZ3up10nVP7?=
 =?us-ascii?Q?RTn84WztBNBnZZkoFHAOk1QaRSFiZGYENJuxeos0Ou13rEGLaH4ijaod1EmN?=
 =?us-ascii?Q?omwX1GkAMcxCbrjBlH9ZJL/TbF/aR4tpnP4OKFOkCGXY8PrNGMauv9Co6Qwc?=
 =?us-ascii?Q?ZMXsWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xdJ9l2cB0GOGFpGWw409XXB4X+hAwCpVcRlLok8X2Xq2BW/U7WKfIUOmO2/hE2ucldjttG1CjRRYlPPuFb9EuAqgw71CHgdDpXxj2NmmPambZmj4K1SLSiTqW1nHYhKMAuz2hghY4ECtqtjCam2/pggXA6XDZZZA9pxWGBZja5LdQSvDIllsHePsEt81sAjlQsvieBQEsRkvvqsZMusPTdRNMPCUygY3Q/4ofWn6DTSB39SPWo0FeFQ/QGpI+sgCgjXsQDob8MSFU90Pe/TXE90eHg/tiWPtut+XGu9xXcvxVpu4wBjSBjzMro62MTrFgToqgf0TocwZReT47pnrA2muDf5f0zgLuWfkLK5BGL6Oof706hmelYIk01pMGdj4A5uIMANLShDewNKnRTGpTB0C/oFsH16Gw39fVyHZYVfCyTAPsKDZjOpVyJjH7nsJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:07.1715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca39679-276d-4488-0e0e-08de70b57a12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
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

to provide user buffer for SPM collecting data, start a work queue
and SPM HW to dump data, wait for buffer filled, and wake up to
return data back to user.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 223 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |   1 +
 2 files changed, 223 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 1ac3668c9744..4b2c7f7b494b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -29,15 +29,35 @@
  * 0.1 - Initial revision
  */
 
+#define AMDGPU_SPM_MAJOR_VERSION	0
+#define AMDGPU_SPM_MINOR_VERSION	1
+
+struct spm_user_buf {
+	uint64_t __user *user_addr;
+	u32 ubufsize;
+};
+
 struct amdgpu_spm_base {
+	struct spm_user_buf ubuf;
 	u64    gpu_addr;
 	u32    ring_size;
+	u32    ring_rptr;
+	u32    size_copied;
+	u32    has_data_loss;
 	u32    *cpu_addr;
 	void   *spm_obj;
+	bool   has_user_buf;
+	bool   is_user_buf_filled;
+	bool   is_spm_started;
 };
+
 struct amdgpu_spm_cntr {
 	struct amdgpu_spm_base spm[MAX_XCP];
+	int spm_use_cnt;
 	struct mutex spm_worker_mutex;
+	wait_queue_head_t spm_buf_wq;
+	u32   have_users_buf_cnt;
+	bool  are_users_buf_filled;
 };
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
@@ -133,12 +153,16 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 		ret = _amdgpu_spm_acquire(spm_mgr, inst, filp);
 		if (ret)
 			goto acquire_spm_failure;
+		spm_mgr->spm_cntr->spm_use_cnt++;
 	}
 
+	spm_mgr->spm_cntr->have_users_buf_cnt = 0;
 	mutex_init(&spm_mgr->spm_cntr->spm_worker_mutex);
 
+	init_waitqueue_head(&spm_mgr->spm_cntr->spm_buf_wq);
 	INIT_WORK(&spm_mgr->spm_work, amdgpu_spm_work);
 
+	spin_lock_init(&spm_mgr->spm_irq_lock);
 	spm_mgr->file = filp;
 
 	goto out;
@@ -166,6 +190,196 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	return 0;
 }
 
+static int spm_update_dest_info(struct amdgpu_spm_mgr *spm_mgr,
+				int inst, struct drm_amdgpu_spm_args *user_spm_data,
+				struct drm_amdgpu_spm_args *user_spm_ptr)
+{
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	int ret = 0;
+
+	mutex_lock(&spm_mgr->spm_cntr->spm_worker_mutex);
+	if (spm->has_user_buf) {
+		struct drm_amdgpu_spm_buffer_header spm_header;
+		uint64_t __user *user_address;
+
+		user_spm_ptr->bytes_copied += spm->size_copied;
+		user_spm_ptr->has_data_loss += spm->has_data_loss;
+
+		memset(&spm_header, 0, sizeof(spm_header));
+		user_address = (uint64_t *)((uint64_t)spm->ubuf.user_addr - sizeof(spm_header));
+		spm_header.version = AMDGPU_SPM_MAJOR_VERSION << 24 |
+					AMDGPU_SPM_MINOR_VERSION;
+		spm_header.bytes_copied = spm->size_copied;
+		spm_header.has_data_loss = spm->has_data_loss;
+		spm->has_user_buf = false;
+		spm_mgr->spm_cntr->have_users_buf_cnt--;
+
+		ret = copy_to_user(user_address, &spm_header, sizeof(spm_header));
+		if (ret) {
+			ret = -EFAULT;
+			goto out;
+		}
+	}
+	if (user_spm_data->dest_buf) {
+		spm->ubuf.user_addr = (uint64_t *)user_spm_data->dest_buf;
+		spm->ubuf.ubufsize = user_spm_data->buf_size;
+		/* reserve space for drm_amdgpu_spm_buffer_header */
+		spm->ubuf.user_addr = (uint64_t *)((uint64_t)spm->ubuf.user_addr +
+					sizeof(struct drm_amdgpu_spm_buffer_header));
+		spm->ubuf.ubufsize -= sizeof(struct drm_amdgpu_spm_buffer_header);
+		spm->has_data_loss = false;
+		spm->size_copied = 0;
+		spm->is_user_buf_filled = false;
+		spm->has_user_buf = true;
+		spm_mgr->spm_cntr->are_users_buf_filled = false;
+		spm_mgr->spm_cntr->have_users_buf_cnt++;
+	}
+out:
+	mutex_unlock(&spm_mgr->spm_cntr->spm_worker_mutex);
+	return ret;
+}
+
+static int spm_wait_for_fill_awake(struct amdgpu_spm_cntr *spm_cntr,
+			struct drm_amdgpu_spm_args *user_spm_data)
+{
+	int ret = 0;
+
+	long timeout = msecs_to_jiffies(user_spm_data->timeout);
+	long start_jiffies = jiffies;
+
+	ret = wait_event_interruptible_timeout(spm_cntr->spm_buf_wq,
+				 (READ_ONCE(spm_cntr->are_users_buf_filled) == true),
+				 timeout);
+
+	switch (ret) {
+	case -ERESTARTSYS:
+		/* Subtract elapsed time from timeout so we wait that much
+		 * less when the call gets restarted.
+		 */
+		timeout -= (jiffies - start_jiffies);
+		if (timeout <= 0) {
+			ret = -ETIME;
+			timeout = 0;
+			pr_debug("[%s] interrupted by signal\n", __func__);
+		}
+		break;
+
+	case 0:
+	default:
+		timeout = ret;
+		ret = 0;
+		break;
+	}
+	user_spm_data->timeout = jiffies_to_msecs(timeout);
+
+	return ret;
+}
+
+static int amdgpu_set_dest_buffer(struct amdgpu_spm_mgr *spm_mgr, void __user *data)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	struct drm_amdgpu_spm_args user_spm_data, *user_spm_ptr;
+	struct amdgpu_spm_cntr *spm_cntr;
+	bool need_schedule = false;
+	unsigned long flags;
+	u32 ubufsize;
+	int ret = 0;
+	int inst;
+
+	dev_dbg(adev->dev, "SPM start to set new destination buffer.");
+	mutex_lock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+	spm_cntr = spm_mgr->spm_cntr;
+	if (spm_cntr == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	user_spm_ptr = (struct drm_amdgpu_spm_args *) data;
+	ubufsize = user_spm_ptr->buf_size / spm_cntr->spm_use_cnt;
+	ubufsize = rounddown(ubufsize, 32);
+
+	if (ubufsize  <= sizeof(struct drm_amdgpu_spm_buffer_header)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memcpy(&user_spm_data, user_spm_ptr, sizeof(user_spm_data));
+	user_spm_data.buf_size = ubufsize;
+
+	if (user_spm_data.timeout && spm_cntr->have_users_buf_cnt &&
+	    !READ_ONCE(spm_cntr->are_users_buf_filled)) {
+		dev_dbg(adev->dev, "SPM waiting for fill awake, timeout = %d ms.",
+				user_spm_data.timeout);
+		ret = spm_wait_for_fill_awake(spm_cntr, &user_spm_data);
+		if (ret == -ETIME) {
+			/* Copy (partial) data to user buffer after a timeout */
+			schedule_work(&spm_mgr->spm_work);
+			flush_work(&spm_mgr->spm_work);
+			/* This is not an error */
+			ret = 0;
+		} else if (ret) {
+			/* handle other errors normally, including -ERESTARTSYS */
+			goto out;
+		}
+	} else if (!user_spm_data.timeout && spm_cntr->have_users_buf_cnt) {
+		/* Copy (partial) data to user buffer */
+		schedule_work(&spm_mgr->spm_work);
+		flush_work(&spm_mgr->spm_work);
+	}
+
+	user_spm_ptr->bytes_copied = 0;
+	user_spm_ptr->has_data_loss = 0;
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+		struct amdgpu_spm_base *spm = &(spm_cntr->spm[inst]);
+
+		if (spm->has_user_buf || user_spm_data.dest_buf) {
+			/* Get info about filled space in previous output buffer.
+			 * Setup new dest buf if provided.
+			 */
+			ret = spm_update_dest_info(spm_mgr, inst, &user_spm_data, user_spm_ptr);
+			if (ret)
+				goto out;
+		}
+
+		if (user_spm_data.dest_buf) {
+			/* Start SPM if necessary*/
+			if (spm->is_spm_started == false) {
+				amdgpu_rlc_spm_cntl(adev, inst, 1);
+				spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+				spm->is_spm_started = true;
+				/* amdgpu_rlc_spm_cntl() will reset SPM and
+				 * wptr will become 0, adjust rptr accordingly.
+				 */
+				spm->ring_rptr = 0;
+				spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+			} else {
+				/* If SPM was already started, there may already
+				 * be data in the ring-buffer that needs to be read.
+				 */
+				need_schedule = true;
+			}
+			user_spm_data.dest_buf += ubufsize;
+		} else {
+			amdgpu_rlc_spm_cntl(adev, inst, 0);
+			spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+			spm->is_spm_started = false;
+			/* amdgpu_rlc_spm_cntl() will reset SPM and wptr will become 0.
+			 * Adjust rptr accordingly
+			 */
+			spm->ring_rptr = 0;
+			spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+		}
+	}
+
+out:
+	mutex_unlock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+	if (need_schedule)
+		schedule_work(&spm_mgr->spm_work);
+
+	dev_dbg(adev->dev, "SPM finish to set new destination buffer, ret = %d.", ret);
+	return ret;
+}
+
 int amdgpu_spm_ioctl(struct drm_device *dev, void __user *data,
 		       struct drm_file *filp)
 {
@@ -180,6 +394,9 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void __user *data,
 	case AMDGPU_SPM_OP_ACQUIRE:
 		return  amdgpu_spm_acquire(spm_mgr, filp);
 
+	case AMDGPU_SPM_OP_SET_DEST_BUF:
+		return  amdgpu_set_dest_buffer(spm_mgr, data);
+
 	default:
 		dev_err(adev->dev, "Invalid option: %i\n", args->op);
 		return -EINVAL;
@@ -203,6 +420,7 @@ void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)
 void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
 {
 	uint8_t  xcp_id;
+	unsigned long flags;
 	struct amdgpu_spm_mgr *spm_mgr;
 
 	xcp_id = adev->xcp_mgr ?
@@ -215,5 +433,8 @@ void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
 		return;
 	}
 
-	/* TODO */
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	if (spm_mgr->spm_cntr && spm_mgr->spm_cntr->spm[xcc_id].is_spm_started)
+		schedule_work(&spm_mgr->spm_work);
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index ee4f03e2f6cf..075ad7eaad01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -31,6 +31,7 @@ struct amdgpu_spm_mgr {
 	/* spm data */
 	struct amdgpu_spm_cntr *spm_cntr;
 	struct work_struct spm_work;
+	spinlock_t spm_irq_lock;
 };
 
 int amdgpu_spm_ioctl(struct drm_device *dev, void __user *data,
-- 
2.34.1

