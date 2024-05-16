Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1039C25B7B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D2210EDB1;
	Thu, 16 May 2024 19:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R0cBDvio";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF52310EDB3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcBp++tblHVLtbI+exI9AetzRV2IHiJdogVH0ZfpI+aOTRCuilUYBmDYVO6bl9Rfxx8BHxcGuiIhWkYhCreXhbe25dHrLOGZZ394HXgiL1yXzmoQwNsWrrMwYWBYo+FoT3plJtGc+S7nNdjl+86pcNzuNZ+ffAmL+s98A4T0DIh5uX+5eKneB/A0uLKImhkcLkdQTN/PzlkqA1qyBGSMQkkP8oh2diJH5qlOf2OhoayYLKiGKynLsZ/hTNywEi9ebHHuH9hFIQi2Zu/IgvrCej/J3uHiHYWWetCV2B7zE4qown2MZvc4vhwd0xo9Ra5fab1oL0oU6XTvKrlTGQoxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiArvf88zycIPDPthqtSTyEEYu9lmj8I9v8fgFUbto8=;
 b=apW02l29hl64gLnX/eQA6fxZnkqPuKr6DDNcPJsRD8wFsXIob+HKClixp9K+l/hEc6gBe7B5EKO5izN815v2v0VxOl8YrRdga/xqZm8Oe8wU/+m7xX1L9JJoOv517x0omj0uEU77BTU5o1dGFTa4odbYge3xSAunUg3b47wgVWWpCsU8CKmqYmlIpeCXQDBXZIp38jMoX8kz+GZH2/XfgoFR7/wV7MTS0H4v3Wg3pKxkE1yv8b31mCH5G3m9bpjwaJl9RDS1NldDpcPVZf1PWd4ZTHtADlM3364TR+oqlPwBsOgjsE89Ap5UOPg252eCmOSNG0UGl8UsXRpmGuFRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiArvf88zycIPDPthqtSTyEEYu9lmj8I9v8fgFUbto8=;
 b=R0cBDviofw9UWBdf8IVg+f6/wrkbkXsJKySKlw1gH5bljY4jNr5NTlAOB6HrjPxI9ZTdXoouUAXTMdY2YRW40BJgVBhUF5JemMjl+4gOfoIukz7gByI+3YcsePcte9WsYj0hYSIge4gORN3xt24c/q96Gjt8PRWgwEPVuQowCGY=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 19:27:06 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::45) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 19:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:03 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:03 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 14/24] drm/amd/display: Clear shared dmub firmware state on
 init
Date: Thu, 16 May 2024 15:26:37 -0400
Message-ID: <20240516192647.1522729-15-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ba4e3f-9799-4818-0ea8-08dc75de2c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tkMLQlEA+DGeeutHlpOqsuFYUZUAwxS9YRjxQltqu9GxbDCGBBqKZqkVV+MT?=
 =?us-ascii?Q?TwtXo4iZbQVi23wFfmOIQYbp8h3Kajzxc4rIamiYnBq7NnJntFfwy0t5k5ws?=
 =?us-ascii?Q?/Tp07TfXHkVzSS7cUfPbyM0u+qP6J1jTALskjSF7bncmk6s+h6AqZaS7ReEC?=
 =?us-ascii?Q?2p38lE9a/GwPkT7lJ8Phf+/0UO6uW1nQEFWYu0dfgqTW110fQkeZJtkVZM8g?=
 =?us-ascii?Q?EYLwoLhH/0YeXJ7S4lrHhpfJ9WrsM+V+pYWoXpVgGiHNey8Trj3Ra0pgdNHK?=
 =?us-ascii?Q?rojFDGEq0J0YDpMmS8DmARMEnrFPm/nI8jR2q6Vx/PREMfgOsj7KWfG8eq4+?=
 =?us-ascii?Q?ynpxd91YWzsPXdnQ2k68fJUVIelfu9kqKEaKseaEDLXmqOxE03Jn481D7o+b?=
 =?us-ascii?Q?Pd4gRSjplNskgzY2JI4kTNZnqvEyd2GkGdewDEbIMHQmV/T2UOnmVSR1Os3q?=
 =?us-ascii?Q?RgZUUdE/zzRswvx6NA3pGVkvxVwsAWH2hiq5/rzYkIvIwakfDcFX+F76TPOX?=
 =?us-ascii?Q?JaGZNxj99zE6zElr1CnkzIHwTp97ACTKlgjL8uO6ov3XBHU6xR0p7ypkFCt+?=
 =?us-ascii?Q?90agVJwmxtm/u+B2ILn4CPf3IvHd6F2N5qzB3WSYfMqbGUQfgxlzQshPvIyH?=
 =?us-ascii?Q?BfpVfeNWX6Yt7Vfv1omkOE9G7GKJZrwxjECJhyyWML0w4G//juBi/rihC8Fc?=
 =?us-ascii?Q?MQf6bVKh6MQk6w/UXl8c+m0jT97PnePT3iVh10oOwuiguMGWJj5JB17Q03/h?=
 =?us-ascii?Q?QUjR30lB7jZfDnLFBMMYkdNdAdih0jhPOKFdMiavkPAiVjk80THHouMsZkEs?=
 =?us-ascii?Q?pKzWQuCLoPyXk7t2ygY855n7Dw9eefKeNMGuHAume1Q9c0QkVexFCqRkyuce?=
 =?us-ascii?Q?JuVoBNjddq7xrBxibhKi0yoxw29MR4lVjDUYquGUhVvH40TNDdNkAPiH9xx/?=
 =?us-ascii?Q?YJ3su0Fymb69Up7EX+4E1VcyTMg6/iHLfwBLZ2ZyCUUhNXShOwb3AFTDvo24?=
 =?us-ascii?Q?FNpxauqCtNTFIxC+uT3yzwuvpMKIlFVydV444mB+3Rya+RLrYohXTpDiGeZR?=
 =?us-ascii?Q?YIZGo+ZJckpf23UZHBNzniVuVgSQ3dDPYyCevuak3o4OzJlVudZUAkcBGMQt?=
 =?us-ascii?Q?8gcXa/TzEwGnn+dI0pJoueujV4TbDWfM2YKmnVN/qEMYfnYUoggG3NOk06Po?=
 =?us-ascii?Q?F6aDopy+/3MSLKNPCfDDEJMVBTRPYYbGiOPeW8Tr2OnwDJh6TrlSKNZav+wE?=
 =?us-ascii?Q?JCJSwJTNhAITdJSAjMs4XZO9iSwUhnJdcAloHYMd0igDVzzSJlIXLHaIc3wR?=
 =?us-ascii?Q?V/Jq1rHpagiLCH9Wdpnq2Eo+fUY6Au2yWcDxtXc57e1EvRbpdYRiNcUaO0/L?=
 =?us-ascii?Q?aq0qnAg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:06.5907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ba4e3f-9799-4818-0ea8-08dc75de2c52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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

From: Roman Li <roman.li@amd.com>

[Why]
Reset the shared dmub firmware region on dmub hw init to start with
known state.

[How]
Memset the shared region to 0 in dmub_hw_init().

Suggested-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 616c0aa73224..53dc4c75fb75 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1207,6 +1207,9 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	memset(fb_info->fb[DMUB_WINDOW_6_FW_STATE].cpu_addr, 0,
 	       fb_info->fb[DMUB_WINDOW_6_FW_STATE].size);
 
+	memset(fb_info->fb[DMUB_WINDOW_SHARED_STATE].cpu_addr, 0,
+	       fb_info->fb[DMUB_WINDOW_SHARED_STATE].size);
+
 	/* Initialize hardware. */
 	memset(&hw_params, 0, sizeof(hw_params));
 	hw_params.fb_base = adev->gmc.fb_start;
-- 
2.34.1

