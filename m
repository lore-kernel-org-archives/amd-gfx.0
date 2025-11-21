Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B1ECFC283
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 15:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA04910E89F;
	Fri, 21 Nov 2025 15:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vJPfls6r";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7727010E89F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 15:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDg5MysUpjV1INzSTZNRDO1/xxLn7C71A8DIeSDPAceAbSQmdCuqjQcyhNkvoNOpXinYS9DQIJmaJ5+C1Rfy9mN7MmORXZaPSley8e2ghm/41Cu9kEmIErKAc4bxOZjjSDA3UuFCHMzRweGYZw4FDzGqiNfRCvPmF/Lj/EXFC3p3eP8F619t1L0g+v+3qIuR1coiVDK1l0N7317pBTKJvNP6zThFp15I1sw9/Em5nu7dvl26AotFEuhjFub/CYEX/dzeGLzxb4mGe169S25K5K1+8ZiNjiFHTldSBojxDpFaYqzHyT4Aa1gdlvrrapmZlDipwQskT++AyP+py9AjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HT50bj5euxti2s4No/xS7X89MuODLb9vCYhzgXtPPU=;
 b=VrXqNHiXdoppOGi8/C6EpBNjNFpvKN1WJwD5qAJWv2dHCj0lcDoNS4QnH2ajsP/9aUEFKe2Jvg8EslBZPPm/smHH9H2WzWvm5DouMuwZnOwBIP7Co5gjWehVN2lZdC/Ww1LxQfxLvChE9H6X/5z5kAzP/GnNRWRKJcnPLSisjmxCJ0DGWaH9kaS/E5JXkza6qFVfQaMeLf/pwSV0UOcS+Lstx7fM3TOq73adaP+kkmSvHg7MfLIClNPecPJpLQ/t0lQWkVT5JlCAg8YWtD2Fbh5zcL0f4PD9uLzDdEdiBlQbAgwu/+nVtV1ugkFDGYONGARbHfna3qXzznLQsIm7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HT50bj5euxti2s4No/xS7X89MuODLb9vCYhzgXtPPU=;
 b=vJPfls6r3tVAOp7abHidLO6wR+dIpcgGzi4Bwrvhus68+3wuarYmAZ0YfpHK7RORZ1x5Kv2V5S1pVCKv8XVSxnxzpBiZDlekzofCSdv+nxKtdJobCAiQwugHgnxopJSz//tjqlZQ8fgVWsDqMX2EJIeGKrsOk8kQSrabpMRjLN8=
Received: from MN0PR02CA0009.namprd02.prod.outlook.com (2603:10b6:208:530::12)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 15:03:06 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::e1) by MN0PR02CA0009.outlook.office365.com
 (2603:10b6:208:530::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.12 via Frontend Transport; Fri,
 21 Nov 2025 15:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 15:03:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 21 Nov 2025 07:03:01 -0800
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Roman Li <roman.li@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix dereference-before-check for dc_link
Date: Fri, 21 Nov 2025 20:32:47 +0530
Message-ID: <20251121150247.181583-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1b0865-7688-4b59-d397-08de290f1349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGhSSVQ0UEV2ZXM2ZG5SQ3FCaW9ZY1VaMjYyNkxkVVplaE9uTkwzRkRGK2s2?=
 =?utf-8?B?c25KMUxQNTdveE82dWNPM3V1RHM5a1pMZnR2NjhTYU5uMlVmNE1PcDFxNmd5?=
 =?utf-8?B?VVBPVTd1OWQ1YiswZXRhUFZ6RDZjekdRN2ppVHNXMHdzMXY0Y2FPMkRETENk?=
 =?utf-8?B?OGVuaTk0S0w1MHlRSk94NWcxNUVoWFBwemNIWnRMaGhmVEczNE4raXJXZGpl?=
 =?utf-8?B?NTdjcHFVdjhuaVY2VWdKZ1pJWXdqazg0bXZtNGhDQURqWUtpVHlLSzgzZHBL?=
 =?utf-8?B?aVEyVU55YXA0THdmd01abVZtbWVEOEMzZVdPNE5kWTZPTHlqQTRsb25IVEly?=
 =?utf-8?B?ZkFlc0VJcHFBbWhWUzZ2dmRQSHZRVGc0cXVFYmdsTXhJQVJzaEpaNVhrTXgz?=
 =?utf-8?B?c3lLODQ2YzBwSTQvVEphVjkzZDdYZWpXL0lQREhUdEE0RFlOSkszZ1VXcy9G?=
 =?utf-8?B?aWVuOW5KbjNralEvUVJJclh1OVVFUE5KRHZDZC9TQTZxWHJ1eG82ZnF1RnRv?=
 =?utf-8?B?Q3Rsd2Q2T0dVMExNNXZMUWR2ZjU1SmdET3daYUc2M2pua2dWWmxNSlFoTHZq?=
 =?utf-8?B?dDFMS2xvN2N0S2dvVE9zSDlhMDZYSUdyZVNrcG15U01WckJLKzFnczhvbGJU?=
 =?utf-8?B?YTI0UTlCcmdJYXk4WGpaMkRWS1ZRRzIrNGVRUkhvU2FXVTBGNVpCMzdYYjZT?=
 =?utf-8?B?dW0xK3p1cmJ6SUYvdlJub09EWVMzbHR1c2ptUURMNXVYL201OUQ4WW9Eb1Jk?=
 =?utf-8?B?d3ZNS1N6bXoxcTFBSnlnWEFQQzVKa0pwM3IvWlhmUHdDV2VIUjdUYmZhQkc3?=
 =?utf-8?B?amV6Q2tvbEVUUENYczJ5RW0xSE1vOStpQjFHYnFMN3lMSGVOcUdPZVQyRnRl?=
 =?utf-8?B?dkN3dkFzbU9TdEJ3ejNjalBLMnBzc0RFRHl1UTRZUmEyUjNqdVgzZ1FrY0dz?=
 =?utf-8?B?dUtCcGkzS0xtR0FMTytsRDdBTDZoU2locGVQZUVTWUgzajdMQkZSSklhWVdN?=
 =?utf-8?B?T1NpZGVidi9FTy8xZ0RldWsxdTN2M3A1T1FCa0QweUZyQlhzU0EwdFcwdUxt?=
 =?utf-8?B?djBoN2xiM1JWclNvbDNBVUVJYXdrREtGZzdKTGZMYjVsd1lKV2NrNXJCSjgv?=
 =?utf-8?B?emJ6ZCtIRkE1Z1pZWXlSYkx5M2JTV1ZXMmZWV01iOE10WGVEVEZiZ2ltRGg2?=
 =?utf-8?B?dUdEQUVGZ29zSFhqMjFQbW1yR2NrZS83d3UzQmdTSmVpWDIyZS9aaEc1LzNa?=
 =?utf-8?B?eXVDU0pkQjV3YmUrQ2FqWXd4RGRKajlLWktvS2hwZm8yTE5XRWVML2JYNnZy?=
 =?utf-8?B?RDMvWGZHdUxZVzRQVFoxelk5RzRvN0pjTkZmMUZYWGhITHRsOStaOFpZZkQ1?=
 =?utf-8?B?aWtDUm5jVjdOZVhXRHVQNU1Ld3NRN0FUL1BUcDZXTnlwYnU0dXhCQnJJMzdh?=
 =?utf-8?B?ZmdtM0FrUFVDQTVzK2FVNGc3VXlqTnJnY2VVR3BxWTMvUFcxbnBjSHNRTHFP?=
 =?utf-8?B?amJ2dnNrZ3g4MTVLbmxpZUNrOHZvdGIvSWhOOVNaSnZqZklHejJ6cTlIS0hv?=
 =?utf-8?B?c1pEcFZhT2FDbTVJaENJN1duczB0RE5QTjZyZm9CR2puNCtrcldBc3MwOE5F?=
 =?utf-8?B?NzNVL1lOc0oybElvQUFiKytsVlpRWlpzTmxUNlFIZ01JYmlZa1BYYm1Hd2tQ?=
 =?utf-8?B?Z3k1SGlQcFV3LzYydWFwK2hRaCtsc1JnU3BRN2lPcW4vMW81QzJGQ2orOUNa?=
 =?utf-8?B?R0ovNHRNWkJBbVFRejlTZ3FOeFNIRVVMaG9YbVhUZms0YThCbWxvSFNKUWhZ?=
 =?utf-8?B?MXF3MVdEZnNKRUdRK0ppek5kQWJXaFdFWXJLWlBMZ3YxR3pZK0h6UDJLVTBw?=
 =?utf-8?B?SWUxL01rQkF4aWgyc1VvSlV0WGhoWGphMFlYNmpvV1RGQWdHYUxXUGxpcUc3?=
 =?utf-8?B?WHh3M0JEWGtBQ1FVeWlOVFpRdndZQ3hWeW0vZnExZU5SVkhISjYxNlovN3pX?=
 =?utf-8?B?cityWGVBbmtBTnpTMW85MWFyUFRWbTYxM0NNdFZYc1BlVEtINXlML3RUdTIy?=
 =?utf-8?B?NHFja2xIZFI4L1l0dnRCMGRGNFpBQVd4aGlIUzgvcVZVMW44a0pQcFVRUUJZ?=
 =?utf-8?Q?gSmM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:03:05.7654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1b0865-7688-4b59-d397-08de290f1349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689
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

The function dereferences amdgpu_dm_connector->dc_link early to
initialize verified_link_cap and dc, but later still checks
amdgpu_dm_connector->dc_link for NULL in the analog path.

This late NULL check is redundant, introduce a local dc_link pointer,
use it consistently, and drop the superfluous NULL check while using
dc_link->link_id.id instead.

The function uses dc_link at the very beginning without checking if it
is NULL.  But later in the code, it suddenly checks if dc_link is NULL.

This check is too late to be useful, because the code has already used
dc_link earlier.  So this NULL check does nothing.

We simplify the code by storing amdgpu_dm_connector->dc_link in a local
dc_link variable and using it throughout the function.  Since dc_link is
already dereferenced early, the later NULL check is unnecessary and is
removed.

Fixes the below:
  amdgpu_dm_connector_get_modes():
  variable dereferenced before check 'amdgpu_dm_connector->dc_link'

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
  8845				&amdgpu_dm_connector->dc_link->verified_link_cap;
  8846		const struct dc *dc = amdgpu_dm_connector->dc_link->dc;
                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                      Dereference
  ...

  8856
  8857			if (amdgpu_dm_connector->dc_sink &&
  8858			    amdgpu_dm_connector->dc_link &&
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            Checked too late.
                            Presumably this NULL check could be removed?
  ...

Fixes: c8f52ca2cefb ("drm/amd/display: Cleanup uses of the analog flag")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8a0555365719..6eb88a96cc33 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8818,11 +8818,11 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 			to_amdgpu_dm_connector(connector);
+	struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
 	struct drm_encoder *encoder;
 	const struct drm_edid *drm_edid = amdgpu_dm_connector->drm_edid;
-	struct dc_link_settings *verified_link_cap =
-			&amdgpu_dm_connector->dc_link->verified_link_cap;
-	const struct dc *dc = amdgpu_dm_connector->dc_link->dc;
+	struct dc_link_settings *verified_link_cap = &dc_link->verified_link_cap;
+	const struct dc *dc = dc_link->dc;
 
 	encoder = amdgpu_dm_connector_to_encoder(connector);
 
@@ -8834,9 +8834,8 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 1920, 1080);
 
 		if (amdgpu_dm_connector->dc_sink &&
-		    amdgpu_dm_connector->dc_link &&
 		    amdgpu_dm_connector->dc_sink->edid_caps.analog &&
-		    dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id)) {
+		    dc_connector_supports_analog(dc_link->link_id.id)) {
 			/* Analog monitor connected by DAC load detection.
 			 * Add common modes. It will be up to the user to select one that works.
 			 */
-- 
2.34.1

