Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EB2C36012
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C1310E1D7;
	Wed, 26 Mar 2025 19:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rrg1IUt2";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A2610E18D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6R4oprCLYL94GzfMDVVEQH4Q2EItqtUB9at6M+z3wX6Z4h3swH5rKg+fkpWbMhYw8nKoh81O2DmGq0oPDayBkfhzT52UDt/lxJaCvpPWviIKUnB19q4OnTCaHx+GPt9DK4d/GyFqMWpk72PRS2HvMJ+zn+V6yVRQdzb4FN9F9+cUQAmjSOtHD8ie2m0h4j6eIc+UjycKBpj7YGxNjPHXzdgFGj+iZ07WHZ0domwfxBCmAHJ9EOUdspFcOFIaqAgxRSwsVJAhM+F91caCy7huxwEAROaPofFttAkjlvRVSUw+qnrMPH684KC9+DHqqdofEeAd1jDvBRWR63YgQbpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VslyKvOZAkMrS9KPC6XsCqr31sanFXvpvIukOoZl3Gg=;
 b=T4U1RHf5daf3sD7IJPpVOt8D4JaUKphPlD3YgOiaWk6JtVjT8bh6gPjorn2k9uDYJAHRBbTOIa/rCihXQiFyoIuHMCIqvM7HrV/4ObfzOQ9JiQYhqWfgDSkiolP94qrThiDQm4J12iH6aNWXEpagUaTVp38S1pXUDLk+hQgGTmdPTF2YAQ4fAgxGaxBA8rrYyT2KxwBxDX6ss1wwr1AsXDagcHHAMfL9pcSaamBSX6RY8+jISmBRQsCRfDX4EqT/N3xbPPqPLkLXyEfJDmb75IE6flyr00wYPiJ2jaCdlpHvVR8GI9IYleixeCS4mbZlSMGmrAegty/CHM38zZ21gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VslyKvOZAkMrS9KPC6XsCqr31sanFXvpvIukOoZl3Gg=;
 b=Rrg1IUt2X1NxU9p5Fg1YnUGWXQeqX5DFTZhLiEePZeiK9RGqB8Vi1fOfaDQ3WHF7M77gbIe/tMUstTUCKoApZamNKw2OMEdy5Ujt44IUNl6+pY58JwjhE56318qls8AtzOVNT2feOJkpLYOdQGolnBeGVAeWU4vwgPjJulVT83M=
Received: from PH0PR07CA0069.namprd07.prod.outlook.com (2603:10b6:510:f::14)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 19:53:10 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::1f) by PH0PR07CA0069.outlook.office365.com
 (2603:10b6:510:f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 19:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:07 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:07 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 01/17] drm/amd/display: convert DRM_ERROR to drm_err in
 hpd_rx_irq_create_workqueue()
Date: Wed, 26 Mar 2025 15:48:58 -0400
Message-ID: <20250326195202.17343-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: c12aab91-4a6d-4e94-5999-08dd6c9fd5d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LmbzAvFq0sPsphxf7t22lXEIGczYdJFalP9NalQu0uS5f+A+QO8KUTNghSZB?=
 =?us-ascii?Q?I8BT4VJXuBFOZgLKT4D8hkIaGyp/6Uz35amPlImdx+w55ZCOi5E34p2N7ZG6?=
 =?us-ascii?Q?wE0pruNbA7I3SJwFiUej7aLRu0kA4Dgz34vxTXTCmNIS4oiXe5ejRos5wTzH?=
 =?us-ascii?Q?CJHU65KQB/6Xkj45tPW/xPfeXFsIFg6OIZR5iolPbVuXaq4Z/aC6OSEpn1lI?=
 =?us-ascii?Q?HbCoIDH5dmZIY+IV1ePZznEjMZhhiQh4/AjSZl5ENJ4g3MTEZiohx9TY+vLX?=
 =?us-ascii?Q?CNK1LDLqLuEmdC6ojeXn1Z8845BSq19jxWlO/bKcOISM4CyZlf8c/uJ6uiVR?=
 =?us-ascii?Q?TBvFflh86MqNJBNTWwBWSy5IUjE5xB4PxQ29MVJk19w8SuHAaPXr06UPkV6K?=
 =?us-ascii?Q?Fc6vFQ0/gz8caB7XMZUtMulOcjpY32SZ6WzmjPjDnme3DUCEswwSwWu34LTA?=
 =?us-ascii?Q?E4LmpQp7bvb9iQuqX7+Zj9Gc5F0ePAohg9rEwcDjUUjxy2zFyVfBjF6Y3rMm?=
 =?us-ascii?Q?OP4q48RtB+JcLjBTJqUGUMzOiny4qID16AJ9jEVJpW4iV7yapDXDzygW/Xf2?=
 =?us-ascii?Q?Vmh9nkGdeGBHFWdP5sp8ctnIm6/ToslEAUJegh+/hFNrhTTayNzXWrRr5IEz?=
 =?us-ascii?Q?YGafT8F+/OMgYdwN9RyJy7SmUt1le8zWX6rpiKMpE2eZJlrwPU9y9+AwmAkX?=
 =?us-ascii?Q?R8dpJdtxb2X4m8fgDeSVnJV0BhRqU6FY5igzqqYXdFTGLu3EbwnhzMGTAqRg?=
 =?us-ascii?Q?IzQfdIJ8MWkkPWXQ06LWmPQIDvs5SDTM1zlbwE62yFAGDXahSML+Vjm8uxHY?=
 =?us-ascii?Q?TRW+AOaDlnlpDAosbpU1bfYkehIi6Bl1J/fbjAAmVBcZ7p3/jlCY4W8Zf47d?=
 =?us-ascii?Q?+2gXBjhaDVpKW9wPjGVlRqE5aQrE8fW8pE0cX2Mozuoa/NlxawGslZXgLIbO?=
 =?us-ascii?Q?BbDlX++6JDfh6WfyS/ohdMuuBTv5PnhneQHzxBeXXuJr/9Rz1D9yT7zuHLIZ?=
 =?us-ascii?Q?T+8ZIm75pPGlnNbeIh/DJjLfI+9IWQli5tkn72bZsArxIZdv90jzlwn8gv61?=
 =?us-ascii?Q?Kb3IbY/OPwj5OKot+t8/2miEWtHUCK19f/6FEhc5ibvIFrPG7yuX3c1BAN8q?=
 =?us-ascii?Q?8s4UTdtHfYIRGjSZ1ziwouWIEsPEW4CDFsNjPl8gUkW+QbETFR4AjhEF/DPw?=
 =?us-ascii?Q?HBHFT04eZgYXzRnrHTuK+sSPqFl5qFg1CC/XuNz61YmcFem122rSUGj1/I2a?=
 =?us-ascii?Q?wgqE46ZQtpGZlxdfJNv70HG8stKEZzVTBVz6cryGwXKPfMNI01eRh8x+kyFV?=
 =?us-ascii?Q?hIpln4boFcSaKm1mm40qY7kazn3TT3s1BxY9DOWFZ8Aq9I5E6gIHJcIg2thi?=
 =?us-ascii?Q?vaOTwvhRb98rs9CjeNx0kDVIIupNPmlXsD3Jp5IZAq8umdHDkhdgv99OcRzs?=
 =?us-ascii?Q?lszUOeWj0LouJfmXcnFiXDs0OMbXLLy9hrEZIy7ejatLNktReQQcSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:09.8044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c12aab91-4a6d-4e94-5999-08dd6c9fd5d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

pass in a pointer to amdgpu_device directly to the function.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 469d0039a54f..5117f5cac67d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1560,8 +1560,9 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 
 }
 
-static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct dc *dc)
+static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct amdgpu_device *adev)
 {
+	struct dc *dc = adev->dm.dc;
 	int max_caps = dc->caps.max_links;
 	int i = 0;
 	struct hpd_rx_irq_offload_work_queue *hpd_rx_offload_wq = NULL;
@@ -1577,7 +1578,7 @@ static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct
 				    create_singlethread_workqueue("amdgpu_dm_hpd_rx_offload_wq");
 
 		if (hpd_rx_offload_wq[i].wq == NULL) {
-			DRM_ERROR("create amdgpu_dm_hpd_rx_offload_wq fail!");
+			drm_err(adev_to_drm(adev), "create amdgpu_dm_hpd_rx_offload_wq fail!");
 			goto out_err;
 		}
 
@@ -2122,7 +2123,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
-	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev->dm.dc);
+	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
 	if (!adev->dm.hpd_rx_offload_wq) {
 		DRM_ERROR("amdgpu: failed to create hpd rx offload workqueue.\n");
 		goto error;
-- 
2.43.0

