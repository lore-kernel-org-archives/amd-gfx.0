Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321C0C02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 17:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82C610E02A;
	Mon, 13 Jan 2025 17:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AXnmxc3O";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7659910E02A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 17:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enbhkXYRfmANcpcRon+6JzEyPhe4wVfAGy6Ijdoe9zszJgpKnEPoGDc57EBPy8XKL/6MIzJOAsrCkEy76LIPD4IA9wiPxvmB1V/uYBssA5LiCearbAheyaFUQHQQVXz6BElvf8rLQEH/kNA9ua8DmszlYN6YU6PnS2wcSSMbejoAFXx/Fqo+0ZBXHN5a6vLU3UaZWGdsHSuJO/rdB0uFYznQSxXSpAkrlM3fH1BKaNjaciVnFBB4LZf7e36lKqpR74eYzo9ptYf3+WSf4DcAf4BQpAtrCMbfUxQgggNEWcjUb3hQrvAWwFQpwKykPjGQutEnp1v+p/0AqJNjpdEUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcmey9Vf4YmqAlL1o0ScQ1Jxl6RFob77HS51texgnDY=;
 b=V2aeoZ2ocoNMudrvkMfnnMFbrBFFAMdDTVaB+MSDZ2rBlGBWIgUegiBWTIIfBte8ieNiXgP7+g62wDKXvkgaGIQx+p351QxAjDhxHX6b0VheaPiQtL7SdPJMwyfZw/FmvOBc53m3ZYbQQGRdk3q0k3eBzRmUnvxDfHlZkc2QOeAjNuBXBDDe9tSJvtlbUCt/1Lb70RA7EAFNtLxJSPedzq9dDaAPcUmT+P3PtBzWKkKZ6rjy0xaM0YuoVVmNanop/y1WqNw1b2cNXcv8gQtM5ufTTtiLJFihrPcOqPPioKCwcS0zZ//rnAXFuikp3wkwV54YWhwLOdV+wE0HRYN5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcmey9Vf4YmqAlL1o0ScQ1Jxl6RFob77HS51texgnDY=;
 b=AXnmxc3OFOSG2l9wu7hak0sJTlWmCpXQnc/oN6QYRRlwj88f0cRVD2HgltmswWk3ddh+Zo1ZfFo9gBKN3oSg61BUsU8YisZHOKc+ZGhl9PKasKIreE23Civ0cAHclFr8ipNagwjnS9cWXO7cGc5aEqtJK6/AkoNxtwMfBjdh9eE=
Received: from BLAPR03CA0100.namprd03.prod.outlook.com (2603:10b6:208:32a::15)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 17:22:55 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::9d) by BLAPR03CA0100.outlook.office365.com
 (2603:10b6:208:32a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 17:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 17:22:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 13 Jan 2025 11:22:52 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx12: Add Cleaner Shader Support for GFX12.0 GPUs
Date: Mon, 13 Jan 2025 22:52:37 +0530
Message-ID: <20250113172237.472236-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d46e93f-97ea-4061-75c3-08dd33f6eac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDBHNUhjajFQY3IzdDkzQUwxZmUyVzlLSUlkTWNoa0NhSURXd3paZXBjL2NB?=
 =?utf-8?B?dGtBWVpCbytucUhsRXR1aXBWSlkwcWVHeFRFS0c2VjdmZTE2bXNmaWpiTHc4?=
 =?utf-8?B?Q1MzTmxmSVhQYjlXNVZZQS9UQVViank3dGcyMlptc2tFWTZXMjU1bmZEdStH?=
 =?utf-8?B?QTdXL3c2OXFmVTBONkRUNHkxck1VdSs2ZEhid28xb0VQaUEwUnpFRm5ZUE1i?=
 =?utf-8?B?RkJxZFRsZnc1cUVtZm01cFJwc3p2dTVuTjFPQ09oWVEvMWJLdXp3b1R2UEs3?=
 =?utf-8?B?aU41K2pXZXFKSkUzVkNJUzk2LzhkTjlUS0N6Y0lydmNuUTQzN3JTdzdrbXBi?=
 =?utf-8?B?ZlpuWFlYSGVyK2NISVE2QTRGSmZxZE1YMUgrUlZ4eDcvSitWU2hjNTBhNWFB?=
 =?utf-8?B?Zjl0TmRGSFpMMitwQ0pSUVZKVVJSdkVHTURWTFF0WXBBR0Q2R2NaL1l2WmJ1?=
 =?utf-8?B?bW9XbllINjkxdjJ2VXBsMHhGVExka05Rckxva2VkUlZWdTh3M2JTU3NJaUpI?=
 =?utf-8?B?dE9sWGs5RWxqYjByQ0duSkc2UFA0VGxHcjg5MFdQM2xKWm5DL3NqV1dhR0RF?=
 =?utf-8?B?eUZBbzdyemo0Z3hHa1FwZ0xhSktOVUg5T21VdHp5b3FFSENId1hUUVNyVm84?=
 =?utf-8?B?aU1qcmZsejdINU5IREtsa1VTS0FOL1JnVjFobG1nMExXT1h1Z3FraVh0dzVk?=
 =?utf-8?B?cXZmbkU2N2ZmSkdDZHRQTmxGMWtzTnBvYi9CZG1hVG9sQjIyV1hDUnJXQjlI?=
 =?utf-8?B?VHI0Mjg1bDBxWkZDRzVQak9kZXRHTFVaQnFleHk4cjhpRUFxUlh6OFNxQmVw?=
 =?utf-8?B?RjE2WmxxMjJ4Wk9ZcmdCeHE1SllrMUEvQmV4UVJHTFh5RkNEbnYvdDY3V2gv?=
 =?utf-8?B?YW9va3JoQUpzQllzY3FMUW9JUFg4cFNzS0kyUFNRUTR3QUYzWDluQmpoSU16?=
 =?utf-8?B?U1M1eFBIOFNGRHFUR3lTY0o3UU44MkpMYUVjZDZVdGk0eVY3aGdEenVYZjFo?=
 =?utf-8?B?ZVFsWGtUNXdvd2RXY3AwWnVWd0hjWi93RGR5OHhyOXN2d3BjSEdPbmpBRm1C?=
 =?utf-8?B?MXZ2d0l5dmk0WWx1ZVdaVkgrLzV0QVZsdEdhWU04UjgrVVZFbW5UbWpEd0d6?=
 =?utf-8?B?RmtveVdFTU4zQk5MRTVJbkpWZityNENuQk96L3hBclZzNk8xOFdGYjJhenE0?=
 =?utf-8?B?OU13dlJadkpldDlOb3ZqL2dLRU91RUVWcldoYkFBSVN2VXR1bXRwMzI0c0tn?=
 =?utf-8?B?MHBGQ0R3Z2lKMVRjVlFoblphWmdaS3laZnpEdmVhbGpJQWZOckJVQ0Y5QkJY?=
 =?utf-8?B?VDhpZDJ5U1diNERSNENUK0ozSmlqVnRScDFhNE1qYW5JcEdwaWc2YXpsZ1Qx?=
 =?utf-8?B?UWJyQXRwd0MvYzVrd2VFejlDYWQreVlBSWNnSUFtSXZybzUzZS80Y05ZZnJZ?=
 =?utf-8?B?TmFTOFZlMzlOV21rY3czMDZHNCs2bnZ1ZzVlL2NaUEh5RDZ5ZWJnK3ZKUFQ5?=
 =?utf-8?B?RHJTQzBZRGVRWXVTUVlhMEZvR1lPZTVTU1VZbXh1dG9ENk5oQ3oyVUozWUE3?=
 =?utf-8?B?ZFY1TWZtLzczNDd5ckp5Tk5pVlgyRjhmdmpveSttNEJsRFZnOFQ0dWhxWnV0?=
 =?utf-8?B?ejhIdVQ4ZWxIM1lFZi9NNWZtYlBuWis5cmNDckx3Y0VZeWVac2djLzdFNFhE?=
 =?utf-8?B?SEpvS3FQbUFBVE9FT09YVWRERCtuNEp1d25nRUpSdHN2djludEFEaktlQWs0?=
 =?utf-8?B?R0N1Zm54SWJvS2tCWTU1N1c0MGJvVXJOR3A2QjBEY1RvZWp1OWVVVmZ3TENX?=
 =?utf-8?B?eU44eE1MTDIvOWRKZjBzUHQreisyWVBnQ0JxRzdnby8vcjdUeFhQZ1ZMRnR6?=
 =?utf-8?B?cXJVUFpWa3hlaXlyWjNleURmSDJIdDNNMEt6bGpxc1V5M2hMYkRmVFJYdnly?=
 =?utf-8?B?N0dmZ2RrNzV2UFFTdStkbkVJNkFsaVdpa3I2blNURDJzV2tJMURjQnR1UHR4?=
 =?utf-8?Q?C/gC6XsdCQjlQIcDDA7VKXViirNqeU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 17:22:54.9437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d46e93f-97ea-4061-75c3-08dd33f6eac2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067
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

This commit enables the cleaner shader feature for GFX12.0 and GFX12.0.1
GPUs. The cleaner shader is important for clearing GPU resources such as
Local Data Share (LDS), Vector General Purpose Registers (VGPRs), and
Scalar General Purpose Registers (SGPRs) between workloads.

- This feature ensures that GPU resources are reset between workloads,
  preventing data leaks and ensuring accurate computation.

By enabling the cleaner shader, this update enhances the security and
reliability of GPU operations on GFX12.0 hardware.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 69941442f00b..fc75af08a7fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1387,6 +1387,14 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		if (adev->gfx.me_fw_version  >= 2480 &&
+		    adev->gfx.pfp_fw_version >= 2530 &&
+		    adev->gfx.mec_fw_version >= 2680 &&
+		    adev->mes.fw_version[0] >= 100)
+			adev->gfx.enable_cleaner_shader = true;
+		break;
 	default:
 		adev->gfx.enable_cleaner_shader = false;
 		break;
-- 
2.34.1

