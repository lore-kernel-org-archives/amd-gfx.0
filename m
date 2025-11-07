Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DDECCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 14:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E096510EAD6;
	Fri,  7 Nov 2025 14:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRIAOER1";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1877010EAD6
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 14:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVkgfOngBtYNX3JqPt3YgOG9vpkdg+gj/51phzbhAHrNxsDuonSQz6g0Zduwe7ZazL1vC5uRfN+tKn5KSvgMq9o5ENecK1mqqgUHED9MPBkQWbJCtZAg2g7F7zXrAJ4Qz9j4wVJ+Gfjr9lcVWYRWmeLtjx2m1kMAy0o6Dw8VpTXhedIXFINZ/GFoZ2YSc7rNnteg0dPUUXWJWbDnrKpFsqSDm7bpiCD8yMmeG7GSDvvVVxp1B6fXb7Ur8uY4mgIqBXo7Zk0CPLxBZSiKwQx58b1lDeaCGkfxwdCfwi6oufNgtFwJCSDxn/fBlOjlaakT/3IZqC/wCiLA9UUntJFIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42Fyvg83EKHpAAhyZTrihjQEK2QELjrfmcdkB65dvno=;
 b=lUKWtqnKXc+HHAiV6vaNxhrc6kQO0GMXrhV2F9SDv36oIdFiQYdGEvbaPLD8YdOFhZ+xtyASmlJ2U4jt21H7SsWLrC9wfKuOtWs5dO62BmaAuHqg3Hndyuihra+C/CvqmRs9lLJ/5WdeX7i3CI6+31Kq+u9fhi/B2DHPep2Ukl2NBFaowTOYlm5Ou0geIeEsAx/Q3Xzz2D0j5nxhu5bX7om57ZIRgkrDCW46OhuQqOGmGRdQkxV1+EMb/omSOS6yuQMwOVo+r9bOs1PIEPwW9fzqiFXF37y58/D+JBn5pWb7zuH9lIOk6HcmtocNz0XM+vcHBYJE2mnl57+vcp4Ocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42Fyvg83EKHpAAhyZTrihjQEK2QELjrfmcdkB65dvno=;
 b=mRIAOER1gmFa/VTPHtGxUVY3VRrWv1PO+RxYeq2wX7od9kNimNd3M+1/RbvWaJXve/+mlOmjaaAE5ODuulG4H80lQRck3/uElm1YNPHbkksnhAshb1fWU5IhGqB4IjRyaVRtQk3b8ayidkIlU8V+CNjfKkBTcjnICPXlPFjIO5M=
Received: from MN2PR19CA0016.namprd19.prod.outlook.com (2603:10b6:208:178::29)
 by LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 14:15:34 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::77) by MN2PR19CA0016.outlook.office365.com
 (2603:10b6:208:178::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 14:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 14:15:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 7 Nov 2025 06:15:31 -0800
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Tom
 Chung" <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix annotations for connector poll/detect
 parameters
Date: Fri, 7 Nov 2025 19:45:17 +0530
Message-ID: <20251107141517.3044480-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|LV8PR12MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: 535f53b0-fab8-4a9b-8d4c-08de1e081db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG95bHNnNlZnUWI4dGFhTFl3b21Qc1RwV09zSG5ONnc1b2tXQzBmeGFsQ1RU?=
 =?utf-8?B?VHg0TFpiazZKRndGWmxnNEdqSmVacTFrRVZjNHFoamYrTWo0Zm9ReExpUFJn?=
 =?utf-8?B?Q2tSZ1ZNWWhxUXZsQ3ppT1hoS1hZSjd4bGt3enN1V0xqcEVBcGFhTnlrYjV6?=
 =?utf-8?B?SnZrZkpVYUJJRkoremtFK3EyNGdKWjZQdHhYaXZlLzUyeFpGZlZ0K0RDNFNt?=
 =?utf-8?B?aHB5Um5TVXhMS0w4Tm80TjRiVCtiUEtaRC9pbFVnUDZZY2lYYzZOMDFwek5v?=
 =?utf-8?B?b3JiOWxxMWNZN09lWTdmQklmM0QrUVBaK0NNbnJNT29lamxST05NMWVWNUoy?=
 =?utf-8?B?YXRrUnpsdFRLMG52ZjgwV3UrdStyU0FUVDVrWXVZQjljQlgyekFZU25qWmhm?=
 =?utf-8?B?Yzg1c2VtRGFLZ25JL011NXVHemFmQmx6U09HMGFyRVNtSndGMnB6NVBBeU5Q?=
 =?utf-8?B?RUVXaDhIc3VWbXBFK0FKU3RUNWRYMWFLeERvRmp0a1pXZXNHb2NySHlzdUQr?=
 =?utf-8?B?K29vT09IZStrM0NoOVMrZUEvaTlvM3F1czdsRkVVc242NU02OWVRanFYN2hy?=
 =?utf-8?B?b2ZPQUFKdVNyVEFrZ1FRN0dZWURwWUEyYUtYb1B1c0xyb1k4YmRiaVUvbjZ0?=
 =?utf-8?B?eHJEM01MSHlGTWFBV2NKUDFGeUhkOHZHbzlmckU2a3BaUTQ0Tjg2R3c1anV4?=
 =?utf-8?B?b2dLRDFjUUJqelJyV0toUDBkd3ZNWEZIb1J3ditFaC9aTTdLMVNwUVNyanhG?=
 =?utf-8?B?MFI2WHZYT21ZY0tVODl1S28vTFRYNjI2NzNwdS9LT1Z6ak9YRmJqQUNLL0t2?=
 =?utf-8?B?cVVRRmpzRk1YQ2dVMTk0YnJxdjk3bGN3bDJvblFBSko2ZFNRN3d2RE5lRzMx?=
 =?utf-8?B?cGxWR2p2UnFzeG1Ga2hJbkhiTFgweldpZEdNdnpOWjlNOUUvK3N5RHhtMzA4?=
 =?utf-8?B?ckhZbFhmblZubDV4SGM2WWVqdmhLUGRzZHFFSnZwa3hEK1JicVFEN2JoemIr?=
 =?utf-8?B?OEd5U21kSkVTVy9Nc1lvaVd6VjVSQnZoQ2M4L2kyOFgxalRGNkw2WjQzMkMx?=
 =?utf-8?B?RXFXdkJZbmZMb0g1aXBWOHBmZXF2V0orb1NRbXdWdUdmVXhQUjVNbnEzajNC?=
 =?utf-8?B?YmtLSUNMUnpGNmhNeitsOEN0V2Y0UGFMcUZCcmhESEJCenFiVjVvek5WOTUr?=
 =?utf-8?B?UTI0WEVnWHNRUUlPTGhNWkpxbExhS25pTkx3eStuQk0vYklXNnpEZEd6bHNO?=
 =?utf-8?B?Y0NGdUxXWTR6czlYeEwvdmRhditVQ2dVM3NtWFhONE5IZkF5amtjSVVYVEtj?=
 =?utf-8?B?TjYvRFZVcmxneVMwYXZwNFNveEh3TDFzbW03VWpWWE51eUNnYVpxRGJEcUla?=
 =?utf-8?B?MlJjVEtBWFJ5TUNhZjVhNWhGejlaSk1RdGlsc0M3NmFJZUs5SVM0aStVRVAy?=
 =?utf-8?B?dGhrc2dvcHMzTUtvcTlMNU04OHU4aGpabGs4RGdHYXRNTUpjUEVBNWI5OXpi?=
 =?utf-8?B?UUhpcHB3MFZidnU1bmc4UE9wV2RIL1VKRmxtQzZoMEhEc3FtRTk3ZitENW5Q?=
 =?utf-8?B?d2RKUThweWRXNGRJM0M0ODB4TUl1TXhUVm8zN0ZpTzlVZGpsU3JQYkxRVHly?=
 =?utf-8?B?S1pFWTRwVlpKWHZWN2pHRjNzUGs3MmhZYVdGRi9OZ20vNXRKV1dVdlFSY3FR?=
 =?utf-8?B?aGc4aUNsb3NJczRKM08vNndFNWdIeGtZS3pQTjlFbXFObjI4T2hMMGZsdEJ5?=
 =?utf-8?B?NFlkeVozRTF4ZXNsdGpMZmd2emFOcm1TS3V2TG1JTkx0RjFsWVFxUWtTQ1dV?=
 =?utf-8?B?WXZwK0RaNmk3cklxR0tsQlBKVG95QkMyK1Vvdy9FQ1R1L0VvNjVJMWJ6eTVw?=
 =?utf-8?B?M2JXS1ZvSTNHMnhnNzV4VkV6eEJ4b0ZzUTVEOGs4SU1KT1psWC9Vd0dla1NW?=
 =?utf-8?B?QjB4T1dlQlErNGNrZExpa1NRRDZ6QUpYOHVWbUMwN1E5dEZhTFZlcTFDejBO?=
 =?utf-8?B?b1NteXhxK0Qrc0FFb3ZwSDdBRlhDRG5TT3JoWld3Z1hBNlNjOEEycUh5VFZB?=
 =?utf-8?B?c0Q0TjV5Umk5M3pxRDBFOEFuTERGZDBCTFhSYm1wekpUZU1Kdlk5MVJpeVRB?=
 =?utf-8?Q?Od9o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 14:15:34.0019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535f53b0-fab8-4a9b-8d4c-08de1e081db9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9714
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

Adds the missing @aconnector, @connector, and @force descriptions:

@aconnector – This is the DM (Display Manager) connector.  It gives
access to the DRM connector, the DC link, and hotplug/poll state.  The
code uses it to check the link, update the sink, and manage connector
state changes.

@connector – This is the main DRM connector given by the DRM core.
Inside the detect function, it is converted to amdgpu_dm_connector so we
can run DC link detection, either light or full.

@force – This flag tells the function whether to run a full detect
again. If false, we avoid heavy DAC load detect steps to prevent
flicker. If true, we force a re-detect even when we normally skip it.

Fixes the below with gcc W=1:
function param 'aconnector' not described in 'amdgpu_dm_connector_poll'
function param 'force' not described in 'amdgpu_dm_connector_poll'
function param 'connector' not described in 'amdgpu_dm_connector_detect'
function param 'force' not described in 'amdgpu_dm_connector_detect'

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ba11421332da..aa31e969b39d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7220,10 +7220,18 @@ create_stream_for_sink(struct drm_connector *connector,
 }
 
 /**
- * amdgpu_dm_connector_poll() - Poll a connector to see if it's connected to a display
+ * amdgpu_dm_connector_poll - Poll a connector to see if it's connected to a display
+ * @aconnector: DM connector to poll (owns @base drm_connector and @dc_link)
+ * @force: if true, force polling even when DAC load detection was used
  *
- * Used for connectors that don't support HPD (hotplug detection)
- * to periodically checked whether the connector is connected to a display.
+ * Used for connectors that don't support HPD (hotplug detection) to
+ * periodically check whether the connector is connected to a display.
+ *
+ * When connection was determined via DAC load detection, we avoid
+ * re-running it on normal polls to prevent visible glitches, unless
+ * @force is set.
+ *
+ * Return: The probed connector status (connected/disconnected/unknown).
  */
 static enum drm_connector_status
 amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
@@ -7291,6 +7299,14 @@ amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
  * 1. This interface is NOT called in context of HPD irq.
  * 2. This interface *is called* in context of user-mode ioctl. Which
  *    makes it a bad place for *any* MST-related activity.
+ *
+ * @connector: The DRM connector we are checking. We convert it to
+ *             amdgpu_dm_connector so we can read the DC link and state.
+ * @force:     If true, do a full detect again. This is used even when
+ *             a lighter check would normally be used to avoid flicker.
+ *
+ * Return: The connector status (connected, disconnected, or unknown).
+ *
  */
 static enum drm_connector_status
 amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
-- 
2.34.1

