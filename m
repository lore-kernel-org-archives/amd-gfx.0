Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D88CA0ED3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 07:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F5F10E21D;
	Mon,  2 Sep 2024 07:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3DJQ3mei";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1769A10E21C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 07:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLGCeJN/T06vcnYuKbEyzGoowftobKJ2ip6RSVowitC+9NJzRbVBgAjq3TDGIM0NXMluPXocG+fPKwvrn12Bt33IHkC2pHX9wAhR0Lcg/XPNA1YL1BsmATMycc9fLgI12UqjR/tJ62awpZ6fg80FtXjehaFHdZ4IXm0M8q1R3GYnl9CYEtP1r+9V+0URV6QYNwANZCU/VOJbxD5GcbU7gyH+Su+IwUhy15kooJTkYtdQF0FOm3DkRH4J86Z5Pw+LvWzK/ScDIdlFcSCS1kY5HRtZwpbyYbhYQ63++mjsd83rC37EaS7dt1zH+WTn80V4/ibak+h9UTiI88RtGBqokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD3GIHLEiUCVTW73K6V/gASvsxXPhBK+MnJ9TSnw/ks=;
 b=nFSfrS9AajvNA9LyZCP2B9+g40kyq+/TcMZtp5EvR/o/e7rJeDwunD3ZklA3ZikFJvgqeWdP4L30ui6eGMxyoRiO5LtAxbyQa1TPz0GWsiWXjpZRkw5q5fLf7NWaA81SppYVcJy3ueRIeGa9/Dr23HtylyF3DVb8bjemlcMwCJ927a0nJ/AsD5r733h01mKM/oQOXectaaYOC3ZAOag4+uN2eTqYhQ0oqGCACPGXvhbuPKdjRJKlHof7vgBzqLzO484MDIS7hFf2z55GZq/VInzWk40ucwIkshEB2ECS+Uva5pq/GQv4ZSWLfLHLCQP6LVXOJFMYLqzkqgzVNlTZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD3GIHLEiUCVTW73K6V/gASvsxXPhBK+MnJ9TSnw/ks=;
 b=3DJQ3meiwjn4Md4hNpwhaAEVyyJPBcQjli6uAG81CU7NnPS+qSjdXse8CHi0JvHdNGZcvATCYX/GQUonHFy2rOGkt6/vmLCv+03pzTqSN0XKS6JuSs0TG+UVh0VdCacCVPmESOxWub6poVIbwAsD69lB4kL54JnhOO8/OUZXvmk=
Received: from BN9PR03CA0586.namprd03.prod.outlook.com (2603:10b6:408:10d::21)
 by SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 07:34:43 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::2a) by BN9PR03CA0586.outlook.office365.com
 (2603:10b6:408:10d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Mon, 2 Sep 2024 07:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 07:34:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 02:34:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 04/10] drm/amdgpu: Add reset on init handler for XGMI
Date: Mon, 2 Sep 2024 13:04:11 +0530
Message-ID: <20240902073417.2025971-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902073417.2025971-1-lijo.lazar@amd.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SJ0PR12MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f4adbd-f045-4cae-7d14-08dccb21b5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XeTidsgeaWZRvwhcN3YZappqQQqtU/2EkHq2YbTX98SYbIZKz0NKdY3vEClB?=
 =?us-ascii?Q?kub8MxQUyazrBbfhEYihRG0/Cb7JLmEQRD4s91vzYgR6FgoRdBKDUz4gikph?=
 =?us-ascii?Q?Jg/9iSDxZMmdD7XbI5daUWK1SR2zYxN5JS3PE7rJBfhK4Q7S4mV3evyBbsv2?=
 =?us-ascii?Q?zTGZc7KjMZeTHxvabr4No1EZBY30n4JwBI/PPKf/58qdY4KfZoIgSLggapog?=
 =?us-ascii?Q?D8ckFQNbICtj+0IIPcDN1zIvuphXEilF9vqWT9PHtN3uIQGWnb+IHyj6X8WW?=
 =?us-ascii?Q?F0Iecq1CvpRJVexT8dwlRw6mIgyPar7QuDhAegSrUby7ZMIg2GZKyn1GFCOO?=
 =?us-ascii?Q?rRE+MFx97+OZvN1jiBX7VpwLJFuQWwEIhmy5+KwxLA4Csc+phk6uwUZwJxFR?=
 =?us-ascii?Q?976ZpCqSMFTjI//p/graaPnnArzqcZNUR6+VwjwcT4ZdK2gwtT3G0FHSSCaB?=
 =?us-ascii?Q?d/2KfxSXI7nNnYKmTceAVX7+gtZL7ZYkZZRlhtH5hU2GW7gFbGaUwDaedUps?=
 =?us-ascii?Q?BFTtNg8grMzXMVUcW6r/bMQDcbedJ/z3Qv9prHwGpV6LlmZKVqPDwIZUctqz?=
 =?us-ascii?Q?aE83xuuK34HVfXD3iVQfdHNMrFaWKAH9wUj/KMcn+8ohwfH6VU/wkAMR9gw7?=
 =?us-ascii?Q?xAgXKH0QCPiKlh8WrXdOXGw9rUXzyBNRML1MUshakdbSTIgdYYOHjQKY1CLJ?=
 =?us-ascii?Q?pKhQtlUXSNCHZPwLYY4Ns7+JUHv+HTPLbeu+JbMhowpUDRCHb5aGxKUZIKRj?=
 =?us-ascii?Q?igbbKX6+6NFFpsNcpTO5QSx5cFz1uNk/pGZnpuhz3Zr8FY0tYrz3G1Qqqg3z?=
 =?us-ascii?Q?nEOcZt4YdwqAVp29fyb1IzEf12CgMu5QwEB+PvMe66tmI66HXogn3AOKDV3J?=
 =?us-ascii?Q?KI/ORDRmuOCUnMZaMcpJB99NSMDzj8vbQX5wIrDimn1WhqQRWU48R2HNwUP+?=
 =?us-ascii?Q?Xs76nIXNnKK5350ebP7XYRJ/QOwtr7Ito7GDrJt45ApG3tMnonLdU5YAnlM6?=
 =?us-ascii?Q?hewJN/dkLPuS0/GzAB+laCiUsJdldP92JCOJa660RHyypriOO3Ca84B/AvfT?=
 =?us-ascii?Q?gQ1oAGLc3b6EVzsQ6tpMQNrRZPBbxthquINUJyIz0ogKPynUTbhPIhonf1yu?=
 =?us-ascii?Q?fwgL0FwR+9j7DIagq5Lp6+c7qrCh2x8XXiguxcTgy4adQTK8hCOXREFbbLXj?=
 =?us-ascii?Q?FBrGv5JIHfCf9aTkyGXfr5k/O4dccjRJpsteA0i9rAuUS6C2cy7JE6OKHEKj?=
 =?us-ascii?Q?QIOzps//DZXe+MNqldk2lEvJx7ozTsLZaikFd8hfKwZDmvI3+uee/kMBq5zz?=
 =?us-ascii?Q?Sh55LILxUEmZ+KsMf1sFN5Oyf4V7NwqLwKNm/dr4YPlOxUlitl8U26uTnwXh?=
 =?us-ascii?Q?h5b0p05i08IUt4pC2WqjU0OnM1h/APsDeN5w+LNH9Vsi/JYYCxFf0xGt3MQr?=
 =?us-ascii?Q?BpnheK2Zk614B4P/fIZx3+3z8PGKihHy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:42.3907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f4adbd-f045-4cae-7d14-08dccb21b5d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674
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

In some cases, device needs to be reset before first use. Add handlers
for doing device reset during driver init sequence.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 148 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |   4 +
 3 files changed, 153 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e1ae898b42eb..d17506d9adae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -562,6 +562,7 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_MODE2,
 	AMD_RESET_METHOD_BACO,
 	AMD_RESET_METHOD_PCI,
+	AMD_RESET_METHOD_ON_INIT,
 };
 
 struct amdgpu_video_codec_info {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 66c1a868c0e1..29128d5edf14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -26,6 +26,154 @@
 #include "sienna_cichlid.h"
 #include "smu_v13_0_10.h"
 
+static int amdgpu_reset_xgmi_rst_on_init_suspend(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (!adev->ip_blocks[i].status.hw)
+			continue;
+		/* displays are handled in phase1 */
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE)
+			continue;
+
+		/* XXX handle errors */
+		r = adev->ip_blocks[i].version->funcs->suspend(adev);
+		/* XXX handle errors */
+		if (r) {
+			dev_err(adev->dev, "suspend of IP block <%s> failed %d",
+				adev->ip_blocks[i].version->funcs->name, r);
+		}
+		adev->ip_blocks[i].status.hw = false;
+	}
+
+	return 0;
+}
+
+static int
+amdgpu_reset_xgmi_roi_prep_hwctxt(struct amdgpu_reset_control *reset_ctl,
+				  struct amdgpu_reset_context *reset_context)
+{
+	struct list_head *reset_device_list = reset_context->reset_device_list;
+	struct amdgpu_device *tmp_adev;
+	int r;
+
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+		amdgpu_unregister_gpu_instance(tmp_adev);
+		r = amdgpu_reset_xgmi_rst_on_init_suspend(tmp_adev);
+		if (r) {
+			dev_err(tmp_adev->dev,
+				"xgmi reset on init: prepare for reset failed");
+			return r;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_reset_xgmi_roi_restore_hwctxt(struct amdgpu_reset_control *reset_ctl,
+				     struct amdgpu_reset_context *reset_context)
+{
+	struct list_head *reset_device_list = reset_context->reset_device_list;
+	struct amdgpu_device *tmp_adev = NULL;
+	int r;
+
+	r = amdgpu_device_reinit_after_reset(reset_context);
+	if (r)
+		return r;
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+		if (!tmp_adev->kfd.init_complete) {
+			kgd2kfd_init_zone_device(tmp_adev);
+			amdgpu_amdkfd_device_init(tmp_adev);
+			amdgpu_amdkfd_drm_client_create(tmp_adev);
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_reset_xgmi_roi_perform_reset(struct amdgpu_reset_control *reset_ctl,
+				    struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	struct list_head *reset_device_list = reset_context->reset_device_list;
+	struct amdgpu_device *tmp_adev = NULL;
+	int r;
+
+	dev_dbg(adev->dev, "xgmi roi - hw reset\n");
+
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+		mutex_lock(&tmp_adev->reset_cntl->reset_lock);
+		tmp_adev->reset_cntl->active_reset =
+			amdgpu_asic_reset_method(adev);
+	}
+	r = 0;
+	/* Mode1 reset needs to be triggered on all devices together */
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+		/* For XGMI run all resets in parallel to speed up the process */
+		if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
+			r = -EALREADY;
+		if (r) {
+			dev_err(tmp_adev->dev,
+				"xgmi reset on init: reset failed with error, %d",
+				r);
+			break;
+		}
+	}
+
+	/* For XGMI wait for all resets to complete before proceed */
+	if (!r) {
+		list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+			flush_work(&tmp_adev->xgmi_reset_work);
+			r = tmp_adev->asic_reset_res;
+			if (r)
+				break;
+		}
+	}
+
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+		mutex_unlock(&tmp_adev->reset_cntl->reset_lock);
+		tmp_adev->reset_cntl->active_reset = AMD_RESET_METHOD_NONE;
+	}
+
+	return r;
+}
+
+int amdgpu_reset_xgmi_rst_on_init(struct amdgpu_reset_context *reset_context)
+{
+	struct list_head *reset_device_list = reset_context->reset_device_list;
+	struct amdgpu_device *adev;
+	int r;
+
+	if (!reset_device_list || list_empty(reset_device_list) ||
+	    list_is_singular(reset_device_list))
+		return -EINVAL;
+
+	adev = list_first_entry(reset_device_list, struct amdgpu_device,
+				reset_list);
+	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
+	if (r)
+		return r;
+
+	r = amdgpu_reset_perform_reset(adev, reset_context);
+
+	return r;
+}
+
+struct amdgpu_reset_handler reset_on_init_handler = {
+	.reset_method = AMD_RESET_METHOD_ON_INIT,
+	.prepare_env = NULL,
+	.prepare_hwcontext = amdgpu_reset_xgmi_roi_prep_hwctxt,
+	.perform_reset = amdgpu_reset_xgmi_roi_perform_reset,
+	.restore_hwcontext = amdgpu_reset_xgmi_roi_restore_hwctxt,
+	.restore_env = NULL,
+	.do_reset = NULL,
+};
+
 int amdgpu_reset_init(struct amdgpu_device *adev)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 1cb920abc2fe..d89929f412fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -153,4 +153,8 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	for (i = 0; (i < AMDGPU_RESET_MAX_HANDLERS) &&           \
 		    (handler = (*reset_ctl->reset_handlers)[i]); \
 	     ++i)
+
+extern struct amdgpu_reset_handler reset_on_init_handler;
+int amdgpu_reset_xgmi_rst_on_init(struct amdgpu_reset_context *reset_context);
+
 #endif
-- 
2.25.1

