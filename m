Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CACCCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5567910E6E1;
	Wed, 29 Oct 2025 03:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zNIdY4Hy";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5899710E6E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9HTMv6FO94p68o++eUXxxfQm2lIyqtjaDlecQmBjtda/1syLPPVvAD8+Ev9bg4hGYZh/+jAS4tBDdJ6W5qJzxpjIZJ4qPwSHHtFg14xVfsaXVPV7Zx4nv4jXNAM1C15KosVWVn77XGu0duJ98CWG2Lz/lftagztXjb67MScwRx9KJdO/+MMCIbqCZMJr/nleKwgHhbzYlvjcuxSdOWd/fJb6aBhdCKxIJIAZYHgDCLxYt0Rjo3qegZqxrNE7GtJcHyIsfTlEhkMEclG/DaGNusSWvzxi1qyRxJ50W35pv09ikw9jUqjugLj+ZcF2EAQ2Yug+Y2LTgLdZpsGwKRouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1lOeRmVaUDnbfn3JeOyHgAcBvMa5Sd51KHAldzoSZQ=;
 b=JoWCBcJHpOV237ORnpq/8749AtLltTQfWEzqDN5SpBQ25tTEuMCBn4OTeTfIgEi8NAO5g7XWf5zrbbCRHNXzPfwRUz4mSaf1PanV6mqej73/wE8gV2NY9sLBAmCHuPoldcSK+xcyUSFJJZplFfrZL+f4IRAQ+1XMEwC1xgCqJFa+9G3k6Tx2kmjJUODK1PIETdL0Ml0N63/Sm6oxahrdJ3XG22NDLztp2NEIIkZDTQIxGbLo8yq8pZ00DN6uSBW9ycN8Sg+2rvUkPTjNRS5Rs2o74MRud+vrDjtlCGmv5doBK5I9P7dIWIz7+55K3dr5gyMvpaE69QpVBJOWu0fn/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1lOeRmVaUDnbfn3JeOyHgAcBvMa5Sd51KHAldzoSZQ=;
 b=zNIdY4HycoSbndX7OHmrygk5ARmb92oQh0QVsgVnYP1LyzusOWVz+bScNVcOY//TImWvPxCjQJQyqhQ902EI3QVChkAyT43Y9CXYa/Qmb/2nGg7NSkCxatw4oerlAp7udQ4/aItbOlI01sza1H4FEJ5CngrrT8VZ1tY8HquOuqU=
Received: from CH0PR04CA0101.namprd04.prod.outlook.com (2603:10b6:610:75::16)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 03:10:13 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::81) by CH0PR04CA0101.outlook.office365.com
 (2603:10b6:610:75::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 03:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:10:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 20:10:12 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 20:10:11 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:10:03 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 00/13] DC Patches November 3, 2025
Date: Wed, 29 Oct 2025 11:02:48 +0800
Message-ID: <20251029030935.2785560-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a38da47-d143-4f0a-ec45-08de1698acf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWR0eng2NmRzNDlGSGg1VllCSDJMeHpvYUlzbmRzQkdKOFNWY1d4aUprQUdo?=
 =?utf-8?B?d25rTmpKNnVMQkg4c2c3M3FKdTR1RzNnUWdDUU5vWkZXL3NxUGN1SzQva0FW?=
 =?utf-8?B?dUViN20ybnVQR0NmQUlUZzNBWERlU3V4N1FZVW04NndhaFdhWGpWWlRTSnZr?=
 =?utf-8?B?STlzRy9tSFV6N2J1b09CWGJRb1pyelBRdi9vT1JSeURIU0pCR00wdVMwZndP?=
 =?utf-8?B?RC9ZVVhzMmRGMkZXMzFOajNsRWtvQVRhQmgwTWEyblVYWkpBNE9mV0JEeng0?=
 =?utf-8?B?aVpJTGJuVERybUsvWXF0MFdDS3ZLaWNnUHFHaGRJNHZzUDVSSDkwZzI4eHBa?=
 =?utf-8?B?RVJQbnBMd3MxRE5zQ0VwMTU2K3V0LzN5ejdWZlduQTVGVHVzNGRqSndENFVR?=
 =?utf-8?B?QlN3RHduMmFvOTF0OS85WmxRTWVUNjFWVzZHbmR3amhtUWJjV0s2dW9rZEFx?=
 =?utf-8?B?VTBlRkZjenJxaXp1R1lhcW1EY3hsRmNybUpjdElGNEY5UXVIVUpPQkRrTVEv?=
 =?utf-8?B?aC82MTFJS21HSU54TWRqOW9HWVBxc0lwdUkrcjA3N3hDQU1VK25weFVwQzc2?=
 =?utf-8?B?QzFzN1c5dEZLKzlsZFFxU25UVmRWSzBCeVZ5SkJBUmhuVDVZNFlGOW1qUGV3?=
 =?utf-8?B?eG85aGlXVFF4ZlJ5QkRFOS9wOE5wMEJiRnBrSTJDVi9mSjdTTkVKZnNWWWN1?=
 =?utf-8?B?RDFROXlrckJPUk5qWGVUcE1mRTF0Z3ErdEM0YWRQR29VY3BqdlhqSHkyVHRW?=
 =?utf-8?B?RjJnWFIwNzhHVUdQa3NtbVhndE8rTjZ3UDg1S2FRQzh4UjRxSXBsVFFFOTNz?=
 =?utf-8?B?ZW16VEhXTXZnUFNjUEQ5M3BpZTlhYXVMWlVXRlIyZE5wRlc1UkJJQmVhS2hN?=
 =?utf-8?B?VVNHczIvYlVFWkI4YmtyLzNWWEljcTkyVFRWRVNKdEt4UlhKTHZaSkZ2Y1E4?=
 =?utf-8?B?TE5pU2g4L0FHay8xRG5MZXlIZkJpcDhEMHdCSkp6U2dmOE9zaC9mNlFoM1RB?=
 =?utf-8?B?Z0VXaTRvQkpqWU1sOU1zOTJocmxHTWx6ODBwam5KRE50RThsT3pjNktIQTZT?=
 =?utf-8?B?cCtrS1Q1VkVtdVc0OHJnU05RNHR0a2swWitLbkFxZ09SM3J6THhwYnBLeSt1?=
 =?utf-8?B?Qk9vUW5aSk1UQkJ5OTJjbXhQTlNBNk1oaGlIeDlwTitxc3hqbE1rRFZMM2Rt?=
 =?utf-8?B?UU04MjZRQ1pnWW1meUQrSUNNd2Y2bnBMK0s2dVBCY2lCcTJ1OUx3eGxaZm5x?=
 =?utf-8?B?QXJ5cUNKSzVGMXNQVThLMEVlamU4U2lGcnBKYk4vdFowcnVia0JCMEpXcXh1?=
 =?utf-8?B?emJGQnNjcTZ0NFF6VDArSjUyUGd1b2M5TkJvZmMvT0NHa0Y2MWg0WWlTNXlJ?=
 =?utf-8?B?K2xDREdDT3pwOFZMZ2h6dG9PdzIva1B4RHNpRE5SVjNKZm1JVGNmUUQ0ZnEr?=
 =?utf-8?B?VmM0YlFVWXVqdXhRNlRkSi9qNHdqcHEwam1OL3VYUzlSRm9KWm12YkhEMGIw?=
 =?utf-8?B?K2txekdKbXpkWWdDc05aVVRrbW5nSmlSWHRSMHp6U25GNU1Ha1UxOW9KbThz?=
 =?utf-8?B?VFk1VG5ZT3A5TlZJanVQL0FhZDNIQ1hFOUF3Qy9EZEllK2NnTlVQMXVVWTRj?=
 =?utf-8?B?UE9zNzdIMU40VXFiVEwrbEk1VGJVY3lYTnJJRjI1eDQyR2RQOEtUbkFBdFd6?=
 =?utf-8?B?OTdQM2g5TEVqV242dUpMcURDa2JQQ2lGSlRUVStVOGt6K2tRK2dQYnJYMGtj?=
 =?utf-8?B?VUJGcjUzcFpGUkt5dGN0Z2RoN1NOelc4cCt5bFlIOUJ1WkRmay83amNQN2NY?=
 =?utf-8?B?TVNTVDU4THRJRW5NR3l3OEpJQlZaTXAxZ0cydEpRQ3A5dWxxajJzRWhDVUZx?=
 =?utf-8?B?OUdITlBsaVloUTdWdlN1cWI5Nnh5dVFsSmFTZzhxRThCQ1ZMNkZFWlFtMDZS?=
 =?utf-8?B?R1Bqem5PeUNyMzYveEMrK2NWQlJwQ1pQL1JBQ3NnaHJJRkFYNythSk5Qdkh4?=
 =?utf-8?B?Qlk3T21EdGFzcjdmUDVqZ0tTRExneDJHdWtmT1lBWGdKM3dBdmt4dTFNQ0dh?=
 =?utf-8?B?bGozWUpoeGROdmVWMHlJeC9xU3daMUdveFRTTFcrckw0RVQrL3V4bWhiakln?=
 =?utf-8?Q?3JDA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:10:12.4969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a38da47-d143-4f0a-ec45-08de1698acf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- HDCP2 FW locality check refactors
- Fix black screen issue with HDMI output
- Increase IB mem size
- Revert max buffered cursor size to 64
- Extend inbox0 lock to run Replay / PSR
- Refactor VActive implementation
- Add Pstate viewport reduction
- Persist stream refcount through restore

Cc: Dan Wheeler <daniel.wheeler@amd.com> 

Alex Hung (1):
  drm/amd/display: Fix black screen with HDMI outputs

Alvin Lee (1):
  drm/amd/display: Increase IB mem size

Andrew Mazour (1):
  drm/amd/display: Extend inbox0 lock to run Replay/PSR

Austin Zheng (5):
  drm/amd/display: Add pte_buffer_mode and force_one_row_for_frame in
    dchub reg
  drm/amd/display: Remove old PMO options
  drm/amd/display: Update P-state naming for clarity.
  drm/amd/display: Refactor VActive implementation
  drm/amd/display: Add Pstate viewport reduction

Dillon Varone (1):
  drm/amd/display: Revert DCN4 max buffered cursor size to 64

Joshua Aberback (1):
  drm/amd/display: Persist stream refcount through restore

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.34.0
  drm/amd/display: Promote DC to 3.2.357

Wenjing Liu (1):
  drm/amd/display: fw locality check refactors

 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  18 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   5 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  52 ++-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h |   2 +
 .../dml21/inc/dml_top_dchub_registers.h       |   2 +
 .../dml21/inc/dml_top_display_cfg_types.h     |  14 +-
 .../dml21/inc/dml_top_soc_parameter_types.h   |   6 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |  10 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  39 +-
 .../src/dml2_core/dml2_core_shared_types.h    |  34 +-
 .../dml21/src/dml2_core/dml2_core_utils.c     |   2 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  20 +-
 .../src/inc/dml2_internal_shared_types.h      |  42 +-
 .../drm/amd/display/dc/link/link_detection.c  |   5 +
 .../dc/resource/dcn32/dcn32_resource.c        |   3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 439 ++++++++++++++++--
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   1 +
 .../display/modules/hdcp/hdcp2_execution.c    |  68 +--
 .../display/modules/hdcp/hdcp2_transition.c   |  61 +--
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |   2 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.c   | 123 +----
 .../drm/amd/display/modules/inc/mod_hdcp.h    | 134 +++---
 25 files changed, 688 insertions(+), 402 deletions(-)

-- 
2.43.0

