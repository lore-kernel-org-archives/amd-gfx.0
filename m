Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0072CCFA1A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A784110E2D6;
	Wed,  5 Nov 2025 15:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yhe0xb2Q";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1470610E2D0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuV0wMuq1moyng8XUshs5QSy4hP8P1sruaZz3CGbFRaL1TLRO+XQThg3dYbLUN8vsIzgMzwJnNqp6gX1/jp75Difa42fsimD7ovtQFN15/PPOIaB4zVbvV7GuJDadVszH38J2nj6pgNURZriqf41Ug/buR9soC9aeoqCvkIv6tFub2TXhcAN+9ylAzC7FDafrJ7xS3JjpVap3/Ya2a5/SsfKI+uCTFkDCjRPvk/stY/a8dElLrc7CtmBq/SePZ7oslqiC3M86Fl29Qb32iKZISFIPhDiWQQjYha+aYYo+UGvV5ZWdbqn8OmBwgSqQ4zKq4K5Tc/0Bf6hnW3P3n2dQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtEJ/liAnhG2sNVMiApPway1Z/FGgKWHKzvrmZBzhfs=;
 b=QcQd8UgmoT8rvWm5uT7JJpxnylRbfF7Srlc0jbi6v3zH8xUpVsGuAEfsuzuN8tzAwirk6AapKpj/jai64iRC9BMzbVswyCwgE/xwRO77t0UpsY5m8HIYP7/oYcTp/8CGCjuBRr99JYDWrhDZnd1C7CuZ9TAED+uPHV7wfhCqaXoeWLvFsItwTLRds0XGB2+96o9Jh5fghIBSpZowNSBHWta7fNXt/n1/co1TbXEocy4e9MhKQKPtdkuJ7teZBi0XFLHp61uX8GIwbnk2M0wMdxnTMgQRVI+CM1QsPVFzZHq7ZKRvRZpzWZwfPGjJUYngOjO3Y4C8Fw/GucDTPOgYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtEJ/liAnhG2sNVMiApPway1Z/FGgKWHKzvrmZBzhfs=;
 b=yhe0xb2Qvi+6+rpFny0DSyJcquZfmfFkzyu50BYxnIdTp3XZRXeARxisa5m6vXVWNJOHdwJXAwi8bY6lpJBppSdStj97ErbFPprFrkn08jc0c3AgzbJTxQvwJpShcwqFQGvg+ro6VaCGr0OXdOUAXUDFjmz2L0loy0EX6F/5z+A=
Received: from BN1PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:e0::12)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 15:41:01 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::61) by BN1PR10CA0007.outlook.office365.com
 (2603:10b6:408:e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 15:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:41:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:52 -0800
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:52 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 03/13] drm/amd/display: Allow VRR params change if unsynced
 with the stream
Date: Wed, 5 Nov 2025 10:36:18 -0500
Message-ID: <20251105154035.883188-4-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: d022759a-050a-415d-6dee-08de1c81b91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUR2U1ZjSzFlVFF0YVA2Q25OK2lBd1Y3czVoa2pSM3hSRi9qQnR6VTVMbmd2?=
 =?utf-8?B?by8vRUc5emFIM0w0VzcrelllYWxQcXdxb29LVVNDR1A0eURMK04rN1BmMVBm?=
 =?utf-8?B?QjgrSzlBNWtBU2tKUDdSQVFNT3ZHbmdPTFNORXdLV1BXZnd0Znd0WVBFM0J0?=
 =?utf-8?B?L0pKYndTbTFsWk9aeHE1VCtiSWR0UDhoV1VvNWtpYWhlbGZ5TkN2aHZpTEM2?=
 =?utf-8?B?UWJFaHN0Z2JkNDlYd1hqeW9NeWp6K1Q1c0ZIOEJRWi9qR1NtL1AvTTdmMk54?=
 =?utf-8?B?cVo0V1pJZHkrUjkzR3p6WVg4cEtrZ09ZN0FWTTlCdkRCdHp3dE9nenJ4SHpi?=
 =?utf-8?B?TmwrZFdncW9WcnJKTVRzUFVIcDRJdVZLcjNIK1hMNzFoaUJFemlYblBIcFVw?=
 =?utf-8?B?OWJFN2cvMktQa2NvdUh3QzJ5bG5hWW1nb3VHZFQrbW9xVDVkMG90MUlnZXl2?=
 =?utf-8?B?Tnp0dlpHdVJHbEdENktRdjhtUmRza2k1UVVHNWswTVJSZFBzckJkc3JQdE1p?=
 =?utf-8?B?ZTFrOGFpdXFCNEY1blBzZFFjNjQ2VnVzeVVoNG13aHJWVTVJRjArYmhqQk5r?=
 =?utf-8?B?NXlidktoYlZIWnBKNUtLOUU5U2N4Ky9LVnM4dmRXenpNTzlobzBNb2c3aFRE?=
 =?utf-8?B?c2o0Snp1T2hhdVhTMUwzRUx0WU8yckRkczRvNS92RHNaS2hBWG5GamlOSDVl?=
 =?utf-8?B?Rnl0b3Q4NW96ZEJ3azdEdHIrT2FyVCtzN1ZQYjRUMjc1UWJwZnlrWndmN1NL?=
 =?utf-8?B?NTNvUWozS3BKdmVuejZpWmM5RnFFNmpHTUw5aU1LRldodnVwVFVndVRxUGpG?=
 =?utf-8?B?cG5XOWhJTElHbFNucldUa05qeUN5a3F3V1J2RThOblZIY1p4bHdBNjBjU3VZ?=
 =?utf-8?B?Nm02clZ1bFhvN1ArUkx3MzJtSUdUaEx6TmY3WWc2TnJUeEpsYjdMRXI1QVlO?=
 =?utf-8?B?RXNTYWRVbjNvbkxLT3dtQjJPY1JDNFNWbnQvOGprdkd3eWhLZ3Qrazhpc1g0?=
 =?utf-8?B?YzRNTWJKbm00aFV1VFhnOXVpVjFaYkZKZXFnZnNiU1RLYUlNMXhiTEhTT1lJ?=
 =?utf-8?B?MWViOWVhbWRGWGRqbTB1OHpBdWl6eGpkMlZVSFRVVmdkdUxkVkozd3lMRlBk?=
 =?utf-8?B?bXlZcDlySWRubCtBN0g2T0tLdDRFODRkSnBmbitPeWcyeitSY3QzZkJvTW1O?=
 =?utf-8?B?cTJ0QjBOYTcweEJodTdrajRqNk40Nk1Vc2hOMmdaejJXaFB4VVFZa2NTcXFu?=
 =?utf-8?B?TXpCU2cydlI0WlBvOGdmTDlSbjN3TzRaMUJVc2s2cUZrRG9nSHVwYUJLdit2?=
 =?utf-8?B?Ylh1cythOFAxbmo4MHFHOU1ZQmVEdzVyajlRN3o3VTVZZkFYVWNmWk5vY1Na?=
 =?utf-8?B?L3B5VWRvdHJaWUcxbjV0OVNCQXVDWnR3UUhzOW1kUU9QelR5eU9pR3o5bkRh?=
 =?utf-8?B?OGhMbXN1MHRJczBQM0lZMUs4aE0rUytyR28wSHBOSWxRSHZjWDBQeCtBMVM5?=
 =?utf-8?B?V1RCU1J6Ty9QelpPTk16NENiV3RCbWZ3RzRmb2M4Z3Zva0o1V2pURjBldlVJ?=
 =?utf-8?B?L3F2VFBpdlVLZ2N4SHhSeEU2RzFJKzFlaHRKeGhiaWg1aXZKQXlzV3F4WFZO?=
 =?utf-8?B?TDlSYmVFZlIzMExnbGNDbTBSSXlIMmdBNFFzRHpDQTlZZGJ4MWdycmZPZWY0?=
 =?utf-8?B?OTVDYkZ3S3RzNXowdUN6anFXZHZLNEZaalY2VVZldE1mUno3bFR2YU1ZWDZ6?=
 =?utf-8?B?LzMrRUFNNFI4VkFBTm5SbkRwWENSVVcxMjJVNWFIMENxYmRia2lITzRaUm1S?=
 =?utf-8?B?Ty9aTmxNTGNSUTFGQ2NGaFlyZjZVOWYrY2lyc2p3UmxldlhUS3pLQnRxNk1N?=
 =?utf-8?B?YmRCT1dwK1RhUkg0V3ROc3B0WFZEZmVGNGQ5cDc1dWU5Ly93YkZUT21xclVi?=
 =?utf-8?B?MkZtQ3VNY0pzeEg5ZWhPVk5IMUFpb3ZNdlB5MmhEYTNaZlkrN1pBWGRWTDRE?=
 =?utf-8?B?MDllbVFnV24rQmVMSnA4aWgrazU0cTVEVHdSaG1adXJwNFd6d3JOUTNlZnMv?=
 =?utf-8?B?eUdmMWVncklISnZXMi9FNkhuOXRMdFdqZGluYjgwdUtOZUFaby9OVDBrUFdQ?=
 =?utf-8?Q?k2UE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:41:01.4633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d022759a-050a-415d-6dee-08de1c81b91a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
When changing resolution (e.g., 4K → FHD) in mirror/clone mode with
certain monitors, the monitor blanks and loses connection due to an early
exit in vrr_settings_require_update(). The function only checks if VRR
state, fixed refresh target, or min/max refresh rate range has changed.

During mode changes, if the calculated min/max refresh values remain the
same even though the stream's v_total changed, the function returns early
without updating vrr_params.adjust.v_total_min/max, leaving the monitor's
VRR timing parameters unsynced with the new mode, causing it to blank out.

[How]
Explicitly adjust VRR parameters to the stream's nominal v_total when VRR
is supported, but inactive.

Fixes: 3fd606f57448 ("drm/amd/display: more liberal vmin/vmax update for freesync")

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../gpu/drm/amd/display/modules/freesync/freesync.c   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index ce421bcddcb0..1aae46d703ba 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1260,6 +1260,17 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 		update_v_total_for_static_ramp(
 				core_freesync, stream, in_out_vrr);
 	}
+
+	/*
+	 * If VRR is inactive, set vtotal min and max to nominal vtotal
+	 */
+	 if (in_out_vrr->state == VRR_STATE_INACTIVE) {
+		in_out_vrr->adjust.v_total_min =
+			mod_freesync_calc_v_total_from_refresh(stream,
+				in_out_vrr->max_refresh_in_uhz);
+		in_out_vrr->adjust.v_total_max = in_out_vrr->adjust.v_total_min;
+		return;
+	}
 }
 
 unsigned long long mod_freesync_calc_nominal_field_rate(
-- 
2.43.0

