Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94841CD3429
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF2410E782;
	Wed, 12 Nov 2025 18:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gq5FuHaN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B58E10E782
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7D0lOMSbaPS6F0+FcX2/K7fCye7Uf7Xbe1e+ZHpxAVOhMnoLgVEsmE2rivEpHqKbuc2GDt3R0AJtmKP9+rCRMWL65sOXweu4BHtvOkYZAKNNX8oQwcOfpHHydG0UFP72tilCW0qt7a3KtayCtxSkGp0SEPsCDjkpThfmOi6Z2Gn9IJWEk7QmWHm2rjNWOHANHPGhlwXW5r6fvv2T4iNsB7SE8ro6XwjtrqaW42xSRx1vvw7+88MFfxu/wA65ruIPcuuA5E+sxfqY6t3o0qOq6QB3IQIqC4v1VY+IHSoloi4xHo8daWVWmBEFFozFRZ27mX1wOhmPnc7WayG9ZMcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1JMuPJtW21E5DQWW1aCZ/P/fXQz+an9VP2HgY+ol5Q=;
 b=YiJ7LkQe5xU0Yxlgw7saCwaJGuinH/H3NoKxCJ2uWIt7LauXwgRqkLUVUh6PvcVjFnr6BqzqEDRmpFPw0PIqEVsWKhiK5/dta5WjHAIaft6qxNPlTp2wtp8Xluwvh/XascXykiSC4zscxmM09ZqjEz9HZTHH+UunovHrzQ2BkRGTTJR1MVCovpNllz79hhr0qefLFKbV+uxCQiFVqtEd25yVvbwr22zlr2xY+SaqLAUbZN3oeyLE8Bn2nz4BgTrAYSwQkuxgZLog8QanSQ386NI0V1ezOXN7ydSBs+V3ra4fGyHrdZwiFaGXS6Q/jkU8A5FFXBImwxebqqxLqIr9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1JMuPJtW21E5DQWW1aCZ/P/fXQz+an9VP2HgY+ol5Q=;
 b=Gq5FuHaNl93r8REThfgEiq7NiSioSU1Mpj3ry66vwCRcQRSNFEtEq4EwKup55xUdGhpS1xRvMXEYOW3+ejo6r4XdPnZTECvWYGJCWwmoPCC9SHUMkLVXe0wqByqI8bQBjfwNnPRuRf088rpz34HPXSDlmpGDXm8ICKYtBzJY4qQ=
Received: from BL0PR0102CA0037.prod.exchangelabs.com (2603:10b6:208:25::14) by
 CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 18:02:49 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::2a) by BL0PR0102CA0037.outlook.office365.com
 (2603:10b6:208:25::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:02:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 10:02:49 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 12:02:48 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:02:48 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/16] DC Patches November 10, 2025
Date: Wed, 12 Nov 2025 12:55:56 -0500
Message-ID: <20251112180242.556200-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6674598a-8654-45d2-0936-08de2215b121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1RDU3krN1ozdSszWmQ5Q1RUZWJhZnh6b1h1UCtFOEF6RlRHYzVsK0tObkRN?=
 =?utf-8?B?VDJNcnlUU29IRE9vbVVrUElWY0N4NDZUQ2FmWU9aRDgxYlZSRDA3VmJOQ3My?=
 =?utf-8?B?ZnBJQVdKT0tMb0JTSndKQ1l0bXEwVWpPaGpnZGJJdFZoWHB0bnJIZWlBUERz?=
 =?utf-8?B?VVZKZWVyS2FySjAzT3FoTGtoWlMzMS9TSVBNdFNreUI5TWNsdmJsWWxHcnUx?=
 =?utf-8?B?KzNlRG1MeGhOUDZWMjhkRW5ib09UK2dxTnVoSG1YQ2JJdGVwMU9COURhMEZC?=
 =?utf-8?B?NWVpVXJESHZWWEZMOERIMTdRNm1xRCtOdERNNXFNeVMzalQyQ21ha3VhR1dL?=
 =?utf-8?B?WE1oamR2bFRVaW9BMHE1NHUyVmZYMHFxU2lMeXZRYkYvc3poRFBSck5zeFAr?=
 =?utf-8?B?RHRWZTJZamt3TVVIWUhFR2pacVpSRXhYb3E3cTNINjd2QysvZzZRekMzOUx4?=
 =?utf-8?B?UTBJREtOUGYvWWowWlp2VjBVeE1RQ0dONnlWL0V3NFlZcnRCcVVWb0hsMll0?=
 =?utf-8?B?ZlBFRTJ4MGMwMWQwTW12bGJ0TldPV2dPZFdXQkpXWTFwdUovdWRpUVRaRkc1?=
 =?utf-8?B?dlNRRzlkMkdwZEZvN1dUaTZhYnlhSXpYWnZQb3BrNkN3NTRseEZWaHd2K1NR?=
 =?utf-8?B?NnNKd1JvWTU4SXBQdkEzay96K2Q5Q3QzTnVmQ25lU0J4SERVSGxFVXVpdWwz?=
 =?utf-8?B?U2RUaG0vNEVSQlhUZ2FkMnZNdXhIcU04bEVqUTNwSERmSVljR25TSnpPeUpq?=
 =?utf-8?B?bldNMGdsb3M1cUhyY3ZrSHI0RmhGRHNlbUpCWFN4dldTMmpMemV1emNld2di?=
 =?utf-8?B?QW13dUMzYk1LWnZMaDdFSDA0NmFkUUVhTVEvTXFNT1AwazBHaGZzYUdQN0o4?=
 =?utf-8?B?Mmw4WkFJUkR4Z1BiTURYNFpLZStsSnhVajIzSEpqdG5PdTJ2d3A2VWdINW1p?=
 =?utf-8?B?U0dQR0V5SGdTaEVOV2pjdVBvTnVQNTh6dWo3NWZ0TXJNSnpCd0thM2xZbEtv?=
 =?utf-8?B?WS9ocFpYRnliK3lxclJJN3ZrZGZvRm5HM0ZEVkFXdXlld0Z0aEcxeHNPbHJD?=
 =?utf-8?B?NlBxMDh3UjZ3TGJXd3N6SUxHeTFoWFpUeHBmMkp6b0hFS241NWQ2RTZqVWFD?=
 =?utf-8?B?dzQraEpvWEV5bmZHTFRwRWF2WnFyaDdYNW1tOGQ2Z1d3ejRGU3hoejNiZng4?=
 =?utf-8?B?MXlaeTJsODB4cWFNOXN6TUpSYUhsaTRmUnlvbmRwT0lQOWZnNzdJTlNCN0gx?=
 =?utf-8?B?alNXaHgvV3gwWUxpakgvY1ZYaFhCakhrbnFUTXV0eVRra1lOU3RpbU1PdkhM?=
 =?utf-8?B?dktFTGR3ZVV3cE1ZMmdyZlNaR3RFcHNQUXZJSmtRQ0gzSEpSN21GdUN1dnd4?=
 =?utf-8?B?Q0NhVVVMWHAySnZTUTFJdUg1L3dBdHRJSDhsdnlLNUtkVVJHSjRST0ROUFVL?=
 =?utf-8?B?eU1QanlyYThDQmRnbnRkelVacWpDSmJwZ1FZZVVNcElhenZCVitWL3FkRjlw?=
 =?utf-8?B?ZkhWQklpWVYvTWdrZ3B4ZEtEZEE3TEN5aWhIV1JsYm91U3pUd3IwanZBVjF2?=
 =?utf-8?B?aFZ0Mm8wMEltck5kUUJYR01rYk5Fb2JZSHRZNFRvcE1HZFZDU1RmUURvYzFj?=
 =?utf-8?B?SWtKQldNdjZ5MXB0TWlBVWs1ZjhURk9SZ2NQaDM1cXkzeUMxZzBheEkvZjRM?=
 =?utf-8?B?a1hxMXEyMEY4VFhDbEV4UThySkVRUGFRamtOTWszL3JBTjdPZEE0RFkydFlx?=
 =?utf-8?B?NlNPR1BuUFc3NWdiQVlJUm5Ya0xIaGtSVWhBdnBFVGFBaGlPSTZUeDVQSWZh?=
 =?utf-8?B?ZkFSWlpaV1lMNDJLd2k2TkE5bE1laG9BZldpQkRHcDFGNHlhZXh5bGEvSU5z?=
 =?utf-8?B?L2dJRDhlNW9MUC93RStsQ1FMa2VkVk8zL3RuaDExT0h1NFdDbkI0Yit1T1ZJ?=
 =?utf-8?B?S25sVUtXSWNsKys4N2lLZDV6cTVWTGxERzZ3L3hJS2dWMzBsdWdXMEhXSnU5?=
 =?utf-8?B?emNoYlEvU3NZeGJkcldZSll5dVhhbkdKTG5XcE04TnluTVJMN0IzRm9RWmxa?=
 =?utf-8?B?V0o4YzU2ZklWYzVvMWxPYzZ4MzNtT1hYWk1tSHBWbGROZXl6ejJ2VllGWjJi?=
 =?utf-8?Q?7cqU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:02:49.4131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6674598a-8654-45d2-0936-08de2215b121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Add interface to capture expected HW state from SW state
- Add panel Replay capability detection, DPCD reading, and enablement logic
- Re-check seamless boot enablement on subsequent dc_commit_streams
- Improve DPCD link capability retrieval with increased retries and per-retry delays
- Add HPD filter for HDMI
- Add pipe topology history tracking to DC
- Fix MST initialization on resume when switching from SST to MST during suspend
- Fix double cursor on DCN20 & DCN30 in non-native scaling
- Check DCCG_AUDIO_DTO2 register mask before access
- Fix pbs to kbps conversion

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Charlene Liu (2):
  drm/amd/display: Add null pointer check in link_dpms
  drm/amd/display: Check DCCG_AUDIO_DTO2 register mask exist

Fangzhi Zuo (1):
  drm/amd/display: Fix pbn to kbps Conversion

George Shen (1):
  drm/amd/display: Add interface to capture expected HW state from SW
    state

Ivan Lipski (2):
  drm/amd/display: Add an HPD filter for HDMI
  drm/amd/display: Clear the CUR_ENABLE register on DCN20 on DPP5

Jack Chang (4):
  drm/amd/display: Add panel replay capability detection
  drm/amd/display: Get panel replay capability from DPCD
  drm/amd/display: Add panel replay enablement option and logic
  drm/amd/display: Remove unused variable in Replay set version
    structure

Mario Limonciello (AMD) (2):
  drm/amd/display: Move sleep into each retry for retrieve_link_cap()
  drm/amd/display: Increase DPCD read retries

Nicholas Carbones (1):
  drm/amd/display: Add pipe topology history to dc

Paul Hsieh (1):
  drm/amd/display: Re-check seamless boot can be enabled or not

Taimur Hassan (2):
  drm/amd/display: Ignore Coverity false positive
  drm/amd/display: Promote DC to 3.2.359

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 138 +++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  59 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 570 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  76 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           | 490 ++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  36 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   9 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |   3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  13 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   8 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  26 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   6 +-
 .../drm/amd/display/dc/link/link_factory.c    |   2 +
 .../dc/link/protocols/link_dp_capability.c    |  16 +-
 .../link/protocols/link_edp_panel_control.c   | 126 +++-
 .../dc/resource/dcn401/dcn401_resource.h      |   3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   1 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |  16 +
 .../amd/display/modules/power/power_helpers.c |   3 +
 20 files changed, 1554 insertions(+), 53 deletions(-)

-- 
2.43.0

