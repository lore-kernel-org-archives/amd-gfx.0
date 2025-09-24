Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ABBCAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 16:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87AE810E76D;
	Wed, 24 Sep 2025 16:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IAUQo4Ob";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BFEC10E248
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 16:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBANbzWOQz8lPnlGhNz5PYkZG4Vbxw+xjfc0oyvE6lCyPuSt8wlnaZ12Gt6meZC7xuCvpVxMKsehiOUiGELGHqx6cqI+h9NiC4MU0gm3W+wUNGI+AHuoQReAp6lAQJUCsNr6kog7BshgcJJEZbwIJsYFUmV5B3BPUy+5f8W5pkTrln0tnqzlVDNkMiukwLUc6rJlFrSDDA+oxxmkCyyOrrYoKXVE6oAsl49g8xbmsQ+uDSmzZFsW2iYlxJbdhdxYFWvuS2bBkzlW8AwLXsCHDVwpkG6EX72jg8a+obMD7VpoD7KqL8KApIQfzPB2aIcf/J4SOxPizbxTMC4wpEh8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckDq/M7HUtucSNsfjgUWt2aUpSKH5yvVwG3NvVe4E90=;
 b=jE6RekCwE3RfUYKlI3oVGViYtc22u+Tkz74NBmrk0rvcJDYY2HYk4bZ98mehAIpleYWrR6tRhqhorRzcuBHX1rDpWQcjIRRO2jiXqbbYp/EbYIG98VWrUpCvCG2zAAxSXRaDAp1ALkCRxhu/qD4RQIorfUDLueX+I8gX6cdjFfUDHrNd/UszOCph/dJKVmyyiwDb9lPC2KgMZ+ub/0kQXXBNvdryGWcEJKEHdCfvSJu8KitXckIWt0nW1ZutEITcX43LE59/0Pu1KMZUGTUEm9kg7974DCn95pYWPQiumb29jMIuhPPEldPssJYl8Qo29ah3UbccDU1bjzmZ5u00Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckDq/M7HUtucSNsfjgUWt2aUpSKH5yvVwG3NvVe4E90=;
 b=IAUQo4ObaeWishZuyd2PO1w//ORN2rdWzxOBoPtmlgSh4A/m1EmjGc3YWNHBsVf8up1pxMOZ9RGKeSo2HLaYqUCXI2QnJCY3YrMeYkX/obbYW90IoHv24gksIUhey+7l68JPF+sV07/6Ehl2lxQ9Xo/20XxwRzZjeo+rT36BoP0=
Received: from CYZPR11CA0007.namprd11.prod.outlook.com (2603:10b6:930:8d::29)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 16:16:45 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::ff) by CYZPR11CA0007.outlook.office365.com
 (2603:10b6:930:8d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 16:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 16:16:45 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 09:16:42 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/5] drm/amd/display: Only enable common modes for eDP and LVDS
Date: Wed, 24 Sep 2025 11:16:20 -0500
Message-ID: <20250924161624.1975819-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924161624.1975819-1-mario.limonciello@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3e7fa2-51b0-4364-0166-08ddfb85c195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDdQQjlSbTQweFNVQ0ovZVZkc054RHVrRDh6Z0VHdm85K1FhZEFVVXlCbmZ2?=
 =?utf-8?B?Q1p1SDJhanY1bkJFc2ppOXJHMUVRQnB5Q1R4NFBkcy95QllNMG9CQ1F3MUpo?=
 =?utf-8?B?elRGNVVKUW9KT2x1UWNGSVNTaU1lVTJyV2FNVmJPaW9pNzZ5K1NEWFBzNzd6?=
 =?utf-8?B?b2JRblprSGppdUY1RWFxSlhpbDRBU3RtNUZpK2h4OGpSTCttVjVLdjVXUlhY?=
 =?utf-8?B?ZDRDYkNxeXZrNUdhTXNOWndYSU11TjBZS01zcGdmaG1HLzE0SEJaVitadnVx?=
 =?utf-8?B?Ym5rMEh3dlZjK3NTeU5vbjVDMWxSa0JYa1VwTnZtZUtlMjlQbXhHRE5JaGY4?=
 =?utf-8?B?M0FET0tvdkxnVjFMNTJyOTRCOGZ5THd3bDY4SnZlZFh6cG9YdmJNRlhuUVEr?=
 =?utf-8?B?SUdkVjVreWtqU2tYWGhaU3NOcXNOSTZ0azFyZTVzMENUWUZzVjFMbTVpSHhE?=
 =?utf-8?B?T05Qb3ptd2VabU5STm1DNU43ZzdjMzg1VVc2Nkc0MWRZWmtneFFCVHQ2ek15?=
 =?utf-8?B?NmF3SFc3UWNKdE9TWEtlVmlveVRiRXVTYVN2V0lzdnZySWtBemF1Yk9sZGRQ?=
 =?utf-8?B?aCtSN0dYOUd3SElxeG1LVVdoM0ZpaE94OVkvQkQvTTIzMlplVStSZUxacVR4?=
 =?utf-8?B?QitRWktjZXFxS1Fzb1ZXUExad2dUOVZ4UFRNc0wveEZDZXY4aEcrdENtczc2?=
 =?utf-8?B?aFNYRlNQUEh3aXUxekdIeEJ6M0t3V0xoWGRpbUFWZDRWVmJ6TVZwbWZSdXli?=
 =?utf-8?B?aDBHRFEyNXZBbWx0Q2ZSOWdYU3VKWGp6alpBek13aXZzQitLM0FZeXozMW9s?=
 =?utf-8?B?aEptZ0syV0hrRE9NYVplRUJkTDNIZGVOWlF6KzdHelhRclJaSFpRN09CVVg3?=
 =?utf-8?B?YW8yYUVsZTJJd01mU2NZcHphZEVyOGtrcHNWWXY5bGI3L0FYSHRBT1VqMUhH?=
 =?utf-8?B?OXhnWW1wVVM5d0RENXFFOEJsYjNnWmQwWmNNd1FCbngrd0pWUTQybmJwbThS?=
 =?utf-8?B?dGREYUJ4Wm5TM0hqVmpENTgrTDJSbGRCdVZ4WDBWYkJiU05UVm8zQXl1eFMx?=
 =?utf-8?B?N1M2Y1gvcGpKK0daQjJBRy9aMVpoNmZpMmJ5b1dwbzhDTmp2aWVpL3p6eWZq?=
 =?utf-8?B?S1B6NTh6OWhqWEhLczVvRjJtSmFYb0x3V0ZTNmJDWmtobHZHUjc3bFAvKyth?=
 =?utf-8?B?N2RwR3FVaWNOUDJQN2d6dE1aNFJpRmlNTTJhbmJMK3B3dmx1QVNRdndjY0t2?=
 =?utf-8?B?cmpIUm5BemRMS3lJNEhsVzZCZDZ5dGZJS1Z4YnBsclJmbWRCWEtCTGwyUWcr?=
 =?utf-8?B?cFFhZ1Y1Zm9NbG1XcThvazdGRFdvM05aVk9KdUtiTlczSTBIeWlkcVFKOFhT?=
 =?utf-8?B?dnJwRjYrZUF6cUNzVGhTZXpTL2xPNUozeTN4NjdwaUJ2RGhBTDZId1Jhaks5?=
 =?utf-8?B?TWZkMDVtWXZqYitTRDFtNVRMbHpsa2gySDkyZTBhZmVaUHNLSWh0T3JFbVhC?=
 =?utf-8?B?SGhqT1o0VW5vWElITW1VNXBSUzAvRGZieVpxVUFUbDJ4U2dEOHVIbWlnTFo4?=
 =?utf-8?B?azRQMXpFNlNtMmU1T0NMNEJJNTR5a2NBOUtuYW0xUTVGaHdGSEg3LzhwdUlO?=
 =?utf-8?B?VlJET2ZFRllqUGNvZjBlaFIyQU9NNWtqb0tUTWZsOGtiUGxZbWRubDVLUG1v?=
 =?utf-8?B?Q3l3eUhkbjl4WTdrdUx6Wkw1ckZ2NUN2YTA4aFJPS05GeStPRlVmRFdhc2JL?=
 =?utf-8?B?eDl4NTBMc1dxTmpTdmxjUFBaTDlwbjFWeC9EdGszMHVnMk9RaG56TEx2WkVs?=
 =?utf-8?B?NnNNcytqQWNBWFVjME0wdlZkNzBaVHZnNnUxbWdlTXVaZGF6L09KRUxQY3ho?=
 =?utf-8?B?OXlpZ1duV1VYMXh2SENjTUpON3R0bllSbDk1MytwWVNBbG51bmlycm5tR21l?=
 =?utf-8?B?TTFpaExVUHpEZEVmZm1RM1lYK1UwTnY1UWhBM1NMcldMOTQ0elg0cmxJSG5p?=
 =?utf-8?B?RnBRRUowWUxrdkVwdU9OaDNiNnMxZktHUUdVMjlNa3gwYWlNYjIvUXpvejVH?=
 =?utf-8?Q?+WtbL2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:16:45.2601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3e7fa2-51b0-4364-0166-08ddfb85c195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859
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

[Why]
The main reason common modes are added is for compatibility with
clone mode when a laptop is connected to a projector or external
monitor.  Since commit 978fa2f6d0b12 ("drm/amd/display: Use scaling
for non-native resolutions on eDP") when non-native modes are picked
for eDP the GPU scalar will be used.  This is because it is inconsistent
whether eDP panels have the capability to actually drive non-native
resolutions. With panels connected to other connectors this limitation
generally doesn't exist as we the EDID will advertise support for a
number of resolutions and monitors will use built in scaling hardware.

Comparing DC and non-DC code paths the non-DC code path only adds
common modes for LVDS and eDP whereas the DC codepath does it for
all connector types.

In the past there was an experiment done to disable common mode adding
for eDP and LVDS from commit 6d396e7ac1ce3 ("drm/amd/display: Disable
common modes for LVDS") and commit 7948afb46af92 ("drm/amd/display:
Disable common modes for eDP") but this was reverted in
commit a8b79b09185de ("drm/amd: Re-enable common modes for eDP and
LVDS") because it caused problems with Xorg.

[How]
Only add common modes for eDP and LVDS for DC, matching the behavior
of non-DC.

Suggested-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 97d9eba17963..5a05ee6746af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8151,6 +8151,10 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 		{"1920x1200", 1920, 1200}
 	};
 
+	if ((connector->connector_type != DRM_MODE_CONNECTOR_eDP) &&
+	    (connector->connector_type != DRM_MODE_CONNECTOR_LVDS))
+		return;
+
 	n = ARRAY_SIZE(common_modes);
 
 	for (i = 0; i < n; i++) {
-- 
2.51.0

