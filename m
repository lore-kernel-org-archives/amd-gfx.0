Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A8DC48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 14:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874E010E770;
	Wed, 21 Feb 2024 14:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GK787UNH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0552510E771
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 14:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQZjEpvuAcb9kGSVPSZ0sbs44hHr3WywzZ2Sf1I33JlSzYbnTnv0zUdkUO8o7VbbvQe97aZyhpe4weJtRWM35PKdLfx4UEpY//Xj2yBDFu4KIxgYiCQbvFAQ82VG98q9j43VbK5OZwHpmcEQNgUrh+lK8pi5jrz9SGOzj7h9eiaSMPG7iQ5vWsK8Y41DiUrZO+azBU83SRlcdtzOCtrQeftMN7fubZSyO3KNDyarsqATuZ1aYKMECW3Kziy/l9tN7UC6ua6s0/hdyrfJyXAGSJKyaGkvDBeF6rNF79S28AIp0z/S0bN9I/qtLqKglkLddojhM5UMRadqyj09u2YP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtb4X6bmdnBZPXCunOAycKfD5oXpdTnm1Qm/0tkl4go=;
 b=bZYpltnsnZb8M9ltZNiRaX/qAIWvvABxRdi8reP4l+kj7wM0fSiivzhyCVrdquja+cr+UYaUAnpqQ4qsqpemPqpre+8c0RaDDVN3iKUBqJ4PjV4x2vki5lkG+TzKqTG2O9bLGEcPXIAD0FDvBolgJp8Ae7gn6EoXxCQTrS34pqBwNlhxdIFHvYww+Mcz3XWZpkHR3+8uY6zZNJGBMk09T6Zyges+uvPQHsNYsb9w+mrxapjC2PuRf43RfTbV+KtvCe03HMHp15Xuzz7ZFw61hwL9ktuhORXIlnInvHXWkOQD55+SwTPeTl0QDgREVfuFbQCwzaYvQvgSFK6aMNW0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtb4X6bmdnBZPXCunOAycKfD5oXpdTnm1Qm/0tkl4go=;
 b=GK787UNHBH51X9c6l0Vhb77cqDW/R6d5jrM3b6stO0z33yorJXdZ5lucmik0uj8seT4pvEIzkPhqE615PE2GwjxFQ/gA3hmSkBOWpSpxG7PXt8OkXISD1wTLlRL3GaE1jyLNWxVKBN8lqKkpBOp35zf8IYaj2DdG4hLzL/89BQ0=
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 14:37:44 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::31) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11 via Frontend
 Transport; Wed, 21 Feb 2024 14:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 14:37:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 08:37:41 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Subject: [PATCH v2] drm/amd/display: Prevent potential buffer overflow in
 map_hw_resources
Date: Wed, 21 Feb 2024 20:07:18 +0530
Message-ID: <20240221143718.453377-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221063850.293956-1-srinivasan.shanmugam@amd.com>
References: <20240221063850.293956-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 73febf7c-3f12-4868-880f-08dc32eaaa85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3P++uwILDwcdLewrqTwUPt64+EqdKyT9JKbDLHYvoI2AAKP1J2w8V8HcHE7ov7YCcMH3mm1k4/kyDKjZfV9iITNl7vlsbyktjT2JkZM6wmCe7Rm5mM5E6+wuPuplokVqwkpmxOsVspzoZqo+xzW3vCY1vzCTvOr8IoEHembMhM/Rh0BcDNfyGl4XtQIWwg3r4pP4JiPFFW5ssdxMoTB/ACWtYhM+QkzdldgtuoU/Jyl50VmJPGhr3TXVRYqyij8QIqB8PcmD+zduLXxhbThof4GMkBiXERMjpEsSUYvOcua1x2T4uYaOs6d5uQ+Z788umnHkU2dvsXBLszMGjjkjbnlRe8Fb+5ZbkYStwOhcKt8zCVoOxJf7PqEa7Q90sXTKlpr3VTXbO1ZCVrxKCW6EqzB/OLj7mLueeqxrg5gzjDe4usPEwhLGf1ry1eKChEPnIMbV1xrsvBsVqQk2u0csCKApGc3FH37yyiMQzHkwXlF3BozwRB2Vsvk5K2nPwvljxPvD8AA3gwsEyFmalxk1xIesSSipkzdN5L3DI9vQGTTEeMbbtnKcSbcsSboRrEgS1/mn6iG4kO2XTh6Z7EQfpFFit1j2zDkVux+vo4TWvUcCpPBYXAXwpXi+Xx6iu8S/v9vnwMEXf71M5ke7TBSeL24MwI2zNot6rNvQ+Rkjs4w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 14:37:44.3756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73febf7c-3f12-4868-880f-08dc32eaaa85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
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

Adds a check in the map_hw_resources function to prevent a
potential buffer overflow. The function was accessing arrays using an
index that could potentially be greater than the size of the arrays,
leading to a buffer overflow.

Adds a check to ensure that the index is within the bounds of
the arrays. If the index is out of bounds, an error message is printed
and the function returns early to prevent the buffer overflow.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:79 map_hw_resources() error: buffer overflow 'dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id' 6 <= 7
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:81 map_hw_resources() error: buffer overflow 'dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id' 6 <= 7

Fixes: 482ce89eec1b ("drm/amd/display: Introduce DML2")
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
  - fixes the below warnings due to incorrect line continuation string split across two lines

/linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c: In function ‘map_hw_resources’:
/linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:80:15: error: missing terminating " character [-Werror]
   80 |     dml_print("DML::%s: Index out of bounds: i=%d,
      |               ^
/linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:81:48: error: missing terminating " character [-Werror]
   81 |        __DML2_WRAPPER_MAX_STREAMS_PLANES__=%d\n",
      |                                                ^
cc1: all warnings being treated as errors
 

 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 26307e599614..2ebeb2b384cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -76,6 +76,11 @@ static void map_hw_resources(struct dml2_context *dml2,
 			in_out_display_cfg->hw.DLGRefClkFreqMHz = 50;
 		}
 		for (j = 0; j < mode_support_info->DPPPerSurface[i]; j++) {
+			if (i >= __DML2_WRAPPER_MAX_STREAMS_PLANES__) {
+				dml_print("DML::%s: Index out of bounds: i=%d, __DML2_WRAPPER_MAX_STREAMS_PLANES__=%d\n",
+					  __func__, i, __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+				return;
+			}
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id[num_pipes] = dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id[i];
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id_valid[num_pipes] = true;
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id[num_pipes] = dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[i];
-- 
2.34.1

