Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E18CA1009
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9394C10E708;
	Tue,  2 Sep 2025 13:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xV4pU6Gq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D4710E702
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtmJnWgpfxsbyzaBmrl1pQk86i24IDGa2b5vKNXO8HwkR9jp8tUhZ0EQAIoNoJS730j7/WImpn3Z63UT3polsH+bxgeBTIJL3Toh+hKcRBPBbZpxqI8qwnWKRA+co1ZOgvk1iugFo42O11kvzkdf7bPxtlXeUL0ed3Hoc8KQmucJNt9COPlfLVYNm8e6y/DYoefMb4enHCOVwdVaDAS8N8hd90AIjB8r1NzzdcZLY0h+zqDhwDvDVAW6zoNtacTF0YljEfbFsfMR9A4s3TW/dWtPYgpyaeugI82NXA9EoGoRfiC48HfpYAKddWQAHiOx67D3MZM/WHzU+5IafSuXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1S1g0qa08ISwQUPibf4Hc0Oiio4X+2gZpwA1YYvpKc=;
 b=eZJsBVjYebW4zGWlzioPJyPU5q6tRR5bIM+kFKopVBjomsByvYrSQ2HA/RYVwAxA9Jkf55a1nshZ55XO9MjlMNRZkLx4AnuZWipGsK97g5uUbwRCyyg2d5WgvT3rT2yfWL/XEIpe2d1bijYEYaWZDZEu3e9sa5Fl7Nc6VNwU/wJoB9yd84CWHzM1wkMPSFK6OWYUIAmAPP6pFRfn63TzeJ4fsyj+UMJaX5kzqKpW6A+F1hGaZHpZFd/c4cSumag8brb8MqizrHmA+dM+K4MikdcMmDQ81AbedudJpwBGpy6sFgbLPDFi/OeFedcLUEysqMEwE/ZZNbet47doCWW7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1S1g0qa08ISwQUPibf4Hc0Oiio4X+2gZpwA1YYvpKc=;
 b=xV4pU6GqlQia0klzeiNo+qlA1IYdijtH3TffVtx+mr1Dh//VSb2BkCdmzSmdzVlqHz9BHfnYJaRbIzqAk9pl615Po07TMehDz/uvnH0Y+/4sB3Ihd/3SRrSUREJ69PHNZ4KbaLEr1h3h0TGIGE2Ds+3tGbs4JdwNubLHN07gO6E=
Received: from CH2PR14CA0055.namprd14.prod.outlook.com (2603:10b6:610:56::35)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:35:52 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::38) by CH2PR14CA0055.outlook.office365.com
 (2603:10b6:610:56::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 13:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 13:35:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:35:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 06:35:50 -0700
Received: from jzuo-laptop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 08:35:45 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 0/8] DC Patches August 25, 2025
Date: Tue, 2 Sep 2025 09:33:29 -0400
Message-ID: <20250902133529.4144-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4271b4-78db-4084-d84c-08ddea25a2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vnuXMDVHlDPKyPZ1oDMhSuJN09ae8sRQhYkQ//q7ttt7CTgxg1lx1TwFayAj?=
 =?us-ascii?Q?2W8oDuzLjaDAuz91CXVIH+o0escjRlWqwr3vg1pLjogX1DZqcgLQbJzxelEn?=
 =?us-ascii?Q?h0IyZEMeaKTYnTWgMGaGNX/m7R91bL3304J67phj/QDaNGBRdexCG/zNeGQr?=
 =?us-ascii?Q?E05Uk7gKFW/TVATgMmCX83fpi9iRGcmIvKgziNQqVcfLB2Z7LCynZuXkct9G?=
 =?us-ascii?Q?MGYn8zo7C3AXW7CXiQe4dYpzcIdlZdmHzFnY+ITvDQ/lGHT1cVuSID21vf6M?=
 =?us-ascii?Q?wMZ4iCar1dUbaCA978/3VykKOfQxzMe8T5PQzmnTz5l2dWITH2HJ2eMlrmGL?=
 =?us-ascii?Q?wKer1MCvVcgKc6SDjtcw02RK5QnhK7Ou4WqwW+lYEkX3XtzQsodpYI8XyHfi?=
 =?us-ascii?Q?zCpmgJ3L0eghRyeCEzxaKHZUhFXr9TS7WGCVDaV76/OAPdH9y4s4IHPPJfem?=
 =?us-ascii?Q?BxWC9QDWXFGNCqX8bBXw1xj43WiVY6Ecq9qAol6ogveBwfE4EO2hYfZ/82VE?=
 =?us-ascii?Q?T6b2M3bleJogGAD/pHX4lOoBdyJz8DlYPvysc7wQs4xNfhIRx0/E3ILkqRIK?=
 =?us-ascii?Q?J0YM5EZrpingf4vwFTG0dC39byhOdWU29JWwgwqw2bDsqTRKAkW0hw0Huomn?=
 =?us-ascii?Q?5CTyO6oqF3WVLUnTC8XAKuDZW4R9BtluQYni3Mh1c59R7uAkAxpnpw+tLvZF?=
 =?us-ascii?Q?c0iSaca3ZpdCk7vW2A6dkQWLGqmqO6p2Ig/VWLVlMDtqV3UzZF3YMTufnt9N?=
 =?us-ascii?Q?tXaNoOJI2fP68+m3wi0VAk/raPSU5dCODmcZPaYN7i2BN5rHRVkb9sLUoRca?=
 =?us-ascii?Q?hp6n8BXuRyTKIQCk5om2nbj/KtWT6NDvvb4D0vKaA9cZT0vnNqpzmK6IieFC?=
 =?us-ascii?Q?vANdyzsRYC0JMfqPfEuU6ZKn0+9GKgYH7Uoy+XFARsw02G+fDIV3M8VFD1hk?=
 =?us-ascii?Q?KPvewwU15nomugaIWaEqNU2EtndMGHQzB/VlTjJPDF9o0KpEUs4ls1GjfqjU?=
 =?us-ascii?Q?jGR3CqvdC368zfGX/TjFISnI/zIu3a3gShqFk1J/AS1Ifxu7lYEpFcKlmEf2?=
 =?us-ascii?Q?Xcg3Yz2V5p+OCo0OhkxGAdEeXutj/U4vYnl7gQVB85mt8lTnJYaqbS9NRXw1?=
 =?us-ascii?Q?xN0FRg7mL2gfymLGDt5L3B11F5/JOyMVI9CFNx8JfC0cxuVc/MrRrvq7maB8?=
 =?us-ascii?Q?he9YTU5nBlGS4i+uZaBDLr9yJMlsij5TLJVuetRannkbqkYD9LU0En94R4mw?=
 =?us-ascii?Q?P/KpwbAzEisT2uMOQn4oqrZ3gIFQbxwrAXBlEVVKm0U5tfg0NJDawon+xyEq?=
 =?us-ascii?Q?j7MExz3pxrPo+CgHvPhae80kzeHekbu0rX9AN2kwCanrp+WW/CIKyyO/u9Z+?=
 =?us-ascii?Q?wEYPWCTDwXE11EyciZ2L8p6oNeV66nxXwMCNvGwz/lz5zB78oa8Nmy9GATb6?=
 =?us-ascii?Q?T4JL/heCOM7WVKwemNaWTXpReH3Ft6X9j9lCcoFszkjGMLXOcyvahWvePI7w?=
 =?us-ascii?Q?MgedQhQrxHfiCvz943U+NKiYaRdG0EOYlEPt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:35:52.1036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4271b4-78db-4084-d84c-08ddea25a2be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
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

Summary:

* DC version 3.2.348
* Remove state/param from check update
* Refactor bounding box values handling
* Fix incorrect condition to fail dto clk calculation
* Skip check downlink setting for a certain MST branch device
* Fix double cursor issue on dcn314

Austin Zheng (1):
  drm/amd/display: Add Component To Handle Bounding Box Values and IP
    Caps

Clay King (1):
  drm/amd/display: incorrect conditions for failing dto calculations

Fangzhi Zuo (1):
  drm/amd/display: Skip Check Runtime Link Setting for Specific Branch
    Device

Ivan Lipski (1):
  drm/amd/display: Clear the CUR_ENABLE register on DCN314 w/out DPP PG

Mario Limonciello (1):
  drm/amd/display: Optimize custom brightness curve interpolation

Relja Vojvodic (1):
  drm/amd/display: Increase minimum clock for TMDS 420 with pipe
    splitting

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.25.0
  drm/amd/display: Promote DC to 3.2.348

 drivers/gpu/drm/amd/display/Makefile          |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  64 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  40 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  | 368 +-----------------
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  28 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |   9 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   2 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   1 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  72 ++++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   3 +
 .../display/dc/inc/soc_and_ip_translator.h    |  24 ++
 .../display/dc/soc_and_ip_translator/Makefile |  19 +
 .../dcn401/dcn401_soc_and_ip_translator.c     | 304 +++++++++++++++
 .../dcn401/dcn401_soc_and_ip_translator.h     |  22 ++
 .../dcn42/dcn42_soc_and_ip_translator.c       |  27 ++
 .../dcn42/dcn42_soc_and_ip_translator.h       |  16 +
 .../soc_and_ip_translator.c                   |  37 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  13 +-
 26 files changed, 672 insertions(+), 401 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c

-- 
2.43.0

