Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACD9EDE998
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 07:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201A910E9EE;
	Wed, 11 Sep 2024 07:07:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CnswzsKA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CB810E9EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 07:07:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qniiL1kxAGvoJUV9dPkIpu6h9sftZxbc4D99Q1xBF6FklURd9429Nqz5sdwWyUuIlCnzVt+ClyahVsmXtTMfVInpQrhZAS+BvVXYzZ7narv4/Ut8jBq8dM/+qnIWdgK40OvViUKUiyMUAe/SEX8QAj6YCik14SfR8fI/f0vnFSBHoPeZ6o6Ef+NSv5+f1SQmxEL833q7ILRSnEkHCEdmkoHPjZP0CWfY/ZETLlseRlY9QavCHymfdVm7x3T/H3IKvH5aIp3PdzoPrCryZymUja8w7468XIZiSbgQJ4s7Op5CB3DDYBVHGq71dcWn/9MzBaivrySzYk2YB8zI+HV/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3W5eQtUZ94SJrpppl48ovuKrQFqoP5D7tQ2NzTdwXA=;
 b=aUtrxZPP9j1Px+zZL2ygH3ql+6QKVDFph8n7e9k3v1wZ+W4A8LH76jGzYI8VRuQzv7q4x+LW8x1E26ulqhd6o3MxkqOGfJ6wfsh8zAN/QKTEE2/EN991gxYEHa7h6+wTJt9MSlSUUry9UA6wrpDaEySQGQP2RdZSTsaV8654ceupDRQ/Q13EXDRfXUDj0t20Cewb6wbkDqPwjO2bSdO/lH/7En9MiSn0q6upxIFRF1ElH/PqvjgzlRetDMgnddyWSkcsAQJhhBLFuS/95EVDNzb2PdK/oPL7IvgJ7Jy0U+rbbXqg3qvjAFTJ5Soyv9rMKVMhnmgy6eLWizrvpQWFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3W5eQtUZ94SJrpppl48ovuKrQFqoP5D7tQ2NzTdwXA=;
 b=CnswzsKA0csSxvtqHAeXGzequnEl9FhWAiPh0B9H+uE+OzXHquSwY3JOqOEn0w7cBhe7UEVds+tIQtvD2r1hog67A/BZD2f9O6bjQgRnT2kxmtJFKuMALqP/3bEUTQFgWRX525TPEVV9dyeXMimYmwCtzk/5ye/KHqCuziqKBmE=
Received: from BN9PR03CA0688.namprd03.prod.outlook.com (2603:10b6:408:10e::33)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.18; Wed, 11 Sep
 2024 07:07:19 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::e) by BN9PR03CA0688.outlook.office365.com
 (2603:10b6:408:10e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 07:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:07:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 02:05:24 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <feifxu@amd.com>, <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v2 04/10] drm/amdgpu: Add reset on init handler for XGMI
Date: Wed, 11 Sep 2024 12:28:52 +0530
Message-ID: <20240911065858.2224424-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911065858.2224424-1-lijo.lazar@amd.com>
References: <20240911065858.2224424-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2f7f94-a8bf-4c2d-5417-08dcd2305fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?14UGx0TE/P0JO7oubztNz5vduBkmHvy6crVTs7DE9oYn44Y9QllbwTuzhsSU?=
 =?us-ascii?Q?TTGd81qk2FjLdOGm9rTJ42ne1qGXGT+cgk33ilI2gHi7b2ZlkPl3vxmI8A8z?=
 =?us-ascii?Q?VQElkeMt8zM+kqaw6blnXfj99i+2+/qJmeDUES6jmuB6M4vJLLnsLLcaBQ8W?=
 =?us-ascii?Q?6iC71k8asJ/0/43cQoZFA5RhOiKiNF/Hpm33UA0TtZjVU7UFRu1eldZwnQ0R?=
 =?us-ascii?Q?cOSuFyuCayI+W00Zz6WNyG9sSidaJ9E9BFqIgRGZ15eIK3sw2fWGdjjjLdH8?=
 =?us-ascii?Q?Nj7ZCpi82mIVyrf/a9fnS6axTUHmc7gUbDxHvg75dc8LYNehnoLvX/k5AWQB?=
 =?us-ascii?Q?hBDUeHP9si9RDMuZcB6r/+RHdY/qUylr/t2Vlw9fVShzRlGmowjR8L6lHs8w?=
 =?us-ascii?Q?kWu2TBKH3YZyxQq6z2W10la3iiempLo7AWYwuFULhuiumdhaBjtvcrTm+VDu?=
 =?us-ascii?Q?yG82B+lBGIa5HlXmR+U9I6x5BSEvBVoES5oXUQKUBNLdplYW1+SZByBai7YO?=
 =?us-ascii?Q?WxLa+FZyq1hwP+aK5LHZOIPpA+pqG84VqJgm7iBWZO5ZcCLNTw5J0458yWIU?=
 =?us-ascii?Q?LvJwwDjNf3gtjv26DJpJFuQ4U3iTr8f8eCJAjyKJ3lvr16MhQ2S4G+7WKPmE?=
 =?us-ascii?Q?ULfgoYDl3bX5Awmt3s9vCYTPI48jlxUiseA34za05qMQvSJ75CV1hYryIxY3?=
 =?us-ascii?Q?FLSVvs8xLEGd+rd5I39BJM4b5qUYBn1bd1mBYQ/nSUkW9QnmngDqZV0yqgpL?=
 =?us-ascii?Q?PfICQj5mpFepe4+MI2PHXSsNd3eXUtDOR3iUEzDuUsOPdaHfIqasqBs5QI5k?=
 =?us-ascii?Q?lPc6hVT5e4xDU/fJDkj5qAWDNDkcNLoXSDTn75YBiJb1Pjhc9nb1NLtNMww/?=
 =?us-ascii?Q?SBNj6bGJP8TgSNBJqmPxBS3adDNBo1tddvPEkJhIm/oV9K68Kgcqk32vsDaS?=
 =?us-ascii?Q?fifWqns1RzkkHzxsU43Wf3R5xA0LYvOR48lCqOeyOZujO6q2paIFPxKuZSnv?=
 =?us-ascii?Q?xtKOov7rdwFaDWjY3qiIj8FXzaH85xII8DxLbTOlf9XDmX1oXPwdao4W0a/V?=
 =?us-ascii?Q?BE69X95x/iCtFD3VK9yN7nCKzi6KWJMnCA6mTwetCcrhrhThY4rxOLdDwAGg?=
 =?us-ascii?Q?UEGw7fRM33tu9eGpfWaphqHDNxpC0UkNPDPHmq0uZRxX2BZ2CMasxqH/y8TW?=
 =?us-ascii?Q?rt1YO7ZzRaJnBvuF6Mb+PVgTGj8OuuP8FiXaNKwIHRc6B+B3b+wrLXwmg/H6?=
 =?us-ascii?Q?UmEkp/AH/Da9AKjXCZkBO3cZZIoBOyCW+MnfiBLJvUPMaRl3+a4VVxAG+NKP?=
 =?us-ascii?Q?32GTv0n+uv3t7Q+706WYNWQ5IBXCkrMUyBKOm6lBfyfCIyDXcNHiTCHwNFf1?=
 =?us-ascii?Q?rJlLKnoh5zVqe+iMgn0I3fRL6Ve9vmKpRCd7iCgOBSJzI4k6doBTDVnf0R3e?=
 =?us-ascii?Q?M6JxxF+rdNMsd4EceVo8nYAdYqiKCt3T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:07:18.7025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2f7f94-a8bf-4c2d-5417-08dcd2305fd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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
Reviewed-by: Feifei Xu <feifxu@amd.com>
---
v2:
	Use consistent naming scheme for functions/variables (Alex Deucher)

 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 149 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |   5 +
 3 files changed, 155 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bb89d2ac7abc..348725908cf7 100644
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
index 66c1a868c0e1..f35fcb46861e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -26,6 +26,155 @@
 #include "sienna_cichlid.h"
 #include "smu_v13_0_10.h"
 
+static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
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
+static int amdgpu_reset_xgmi_reset_on_init_prep_hwctxt(
+	struct amdgpu_reset_control *reset_ctl,
+	struct amdgpu_reset_context *reset_context)
+{
+	struct list_head *reset_device_list = reset_context->reset_device_list;
+	struct amdgpu_device *tmp_adev;
+	int r;
+
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+		amdgpu_unregister_gpu_instance(tmp_adev);
+		r = amdgpu_reset_xgmi_reset_on_init_suspend(tmp_adev);
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
+static int amdgpu_reset_xgmi_reset_on_init_restore_hwctxt(
+	struct amdgpu_reset_control *reset_ctl,
+	struct amdgpu_reset_context *reset_context)
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
+static int amdgpu_reset_xgmi_reset_on_init_perform_reset(
+	struct amdgpu_reset_control *reset_ctl,
+	struct amdgpu_reset_context *reset_context)
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
+int amdgpu_reset_do_xgmi_reset_on_init(
+	struct amdgpu_reset_context *reset_context)
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
+struct amdgpu_reset_handler xgmi_reset_on_init_handler = {
+	.reset_method = AMD_RESET_METHOD_ON_INIT,
+	.prepare_env = NULL,
+	.prepare_hwcontext = amdgpu_reset_xgmi_reset_on_init_prep_hwctxt,
+	.perform_reset = amdgpu_reset_xgmi_reset_on_init_perform_reset,
+	.restore_hwcontext = amdgpu_reset_xgmi_reset_on_init_restore_hwctxt,
+	.restore_env = NULL,
+	.do_reset = NULL,
+};
+
 int amdgpu_reset_init(struct amdgpu_device *adev)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 1cb920abc2fe..f8628bc898df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -153,4 +153,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	for (i = 0; (i < AMDGPU_RESET_MAX_HANDLERS) &&           \
 		    (handler = (*reset_ctl->reset_handlers)[i]); \
 	     ++i)
+
+extern struct amdgpu_reset_handler xgmi_reset_on_init_handler;
+int amdgpu_reset_do_xgmi_reset_on_init(
+	struct amdgpu_reset_context *reset_context);
+
 #endif
-- 
2.25.1

