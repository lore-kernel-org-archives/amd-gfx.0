Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E730F31E25
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 15:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2135010E812;
	Thu,  9 Apr 2026 15:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rZXsCSM6";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4EA710E0ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 15:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTWHjhExTejIkfV+24xjaoV3XLMdORxi9fWU6Ak1lcnSMxjnWv+iMhrQBHxjlBlBGnvjnm7B22h5txvL0hG3Wi8X1E6n2VeodAjMgQYtOPnzonPDM/zmPw1Ig8uKah41eBlQXjEyAbk+MnWFMwxDFgyVykz+LUYi8pm8yqlFuTcRwdyDY07rXbOy85vJQ7sg+xcj30eZY8rrsAP5s8UgsM2GxJxDVDgketHjvQuSbok1fna5XhkXlOZBlnXoe+6lLP/OA9MPLEe2RICoDtbG/nxeWAPu+iC4RkfM9qaTyVF6+q8EIsMwNcaG2MKDko+Z9vGaBpaBJZN1nnE8j4b1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL6ed+AmUNjP/vkiwK9bw8ZmhyJQqY64e2W4WNOwE8I=;
 b=jp7B21y1f3Cgno3+xmclDKEcGz3jcH6ieCJFduSyL1mtC2B1OjoU2x9/pQQkIHCTvK+roRhOXRlYFTs5C3mSESQ7L/XXmpueGNBshXTi92OHADUlGEKpUKG0OmDhiDIQISgoI0pDQY12Qus2AjO1Au5sB9ydmXRWyHtFhOCOdfomnT38tBIzdrsmaubmsRe2369QOTWR0QJO/FJtWN4zocFgbwfDxenkwxEnsZKDKwauvdn/g+XIvJ1xPbIE/yn9GnnIpfDBQ+rNKgZB88Ek34XoFxgoo8VHQQcV7hrqd3eWznfjYBCLdI1f9AGsDJAzz3H16CVF0IS8slVaMs4+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL6ed+AmUNjP/vkiwK9bw8ZmhyJQqY64e2W4WNOwE8I=;
 b=rZXsCSM6aymilsiAvJRLIlnq02IYhgsT26dbSTOP5JA6C6Jq4SllDyEdk3JCosPm3xi/FcaPG5KDNxShhNIC7f7dUORyVX84uF14p6aXtdf0kx+tTdSbKzTCpHYB3z/Je+kMBf72lbaZUS4p6da7vwsnGEcKyMRL5Zfx8hgAv3A=
Received: from BYAPR21CA0025.namprd21.prod.outlook.com (2603:10b6:a03:114::35)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 15:04:17 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::4a) by BYAPR21CA0025.outlook.office365.com
 (2603:10b6:a03:114::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9818.13 via Frontend Transport; Thu,
 9 Apr 2026 15:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 15:04:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 9 Apr
 2026 10:04:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Apr
 2026 10:04:14 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 9 Apr 2026 10:04:13 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Subject: [PATCH 0/6] DC Patches for 13 April 2026
Date: Thu, 9 Apr 2026 11:03:08 -0400
Message-ID: <20260409150413.34779-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|BN3PR12MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: ad753e68-99b0-40ca-3ef7-08de96494431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: SHNDzYBMlWKzV+YTXo2B7dzWx2YKbsn+hRrhAZcQgipbi9a7G20CMpvtHeyaitB5ee0wCr3HTHCeJ3jTjpCgyPI/VVER2dSDNvatMy9z8wC/U7MbK1NvJZPnWr3cf5heb+hc7drIMgvolSI9XGuuYtGJuN+Ve4Y67/N3HasWVWWJjjSwldjkYFeDJaAQnWwHz4aVXrrtVcj8/Us1AKEuIqqgX0AMORIt6B2bN/g4XnWpgjBnXVxGSZaCqnNe11tXq6OAj/uh9fnWeDNrnu4+fwaV4naQ3elNG4Qv8lJxI+GMmCx8vMt/2ELzlNIigRs8B27yKI3pBxUEu4agOqCxqzuVSxad8eeaJur57SzYJ3pW2l4x+g6R3YUZHFjsLI/pWh+/Zc9ZORl7R9BWop/O5bJF0ec96qQG+T9DX2SraFLntvNeYqrwyrxo0KXnIludoXd2ZDD3NoznI1xNCos0ufbIAPzkXqTHuzBdRHRCoyDwxAIWR9clLwSqZKJF7X/K5KtLIiZESHKVtPR1fQnXqmSouGw+nqXvSMP29SUKfOu8wsEZDz5kX4FXm9Q7rMNoUdhCFNsRYNKaqGvlAUaLnba/jo+XbOsvsvsmv8wuUxQyxaqIXkFaxRNROOz+4Nyk6NjdPFaGIol8WcyG7BT1wUpQfsK/NYpCa/mQY9NIyfcaVr4d07fPgwVrevoF/ef57wVwGRUGe4Ft2D07QAEk375Zs+8XpFgLkbsmJZLu66DByLbMW7ZDWEgBDxvgEwyjBud45I8bN2EOrfPJGTmU7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M1KXiG5IubwgAu0ADaR3st7qimrg3Zxvjtq+YCUv6HF+GrYOs/Wg8IhuxPYxIIkgsSB86dXn0Eg1UOOnO6dRT2CUoffXKZ2izmWaMplE7x/TuhpkubPJ7OETL7PetkhhFug9JCLv0BLaktjDxd/ytQ291eysgVWhmQhhSeyNPWDO/mLe/Un53Lb2TvUF2eDwnkq8dA2NXFSH8tJJmkPUhDlK78YAxRM550PZhZK5ulW74S2X3xh48dWUSAt6DntPJcuWRYdzwprV1/s6T8QKGcrTC3fCpEl17PxK4SPJwwMITx03wsHzl/ZCbYPpqmG4JeQ+7cyM/cuEFxnlCvYmenf3aUaewJv6tGemXpIewE2B/Np+B+gVkjUJhSrIO4tF0HugFDx71x4wfNMsHo0nzt1a1XvGf6RwcLu2YBL9suUjzrFNYWl7z+wBayvvEYGC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:04:15.2946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad753e68-99b0-40ca-3ef7-08de96494431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572
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

DC v3.2.378 summary:

New:
   - Add p-state schedule admissibility flags and frame-time utility

Fixes:
   - Fixed incorrect math_mod() result due to wrong variable in fmod implementation (Cc: stable)
   - Use overlay cursor when a color pipeline is active to avoid incorrect rendering
   - Constrain vblank_nom to bounding box value instead of entire blank
Cleanups:
   - Add const qualifiers to watermark params struct
   - Fix C4242 narrowing-conversion warnings

---

Alex Hung (1):
  drm/amd/display: Use overlay cursor when color pipeline is active

Gaghik Khachatrian (1):
  drm/amd/display: Fix compiler warnings

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.378

Wenjing Liu (3):
  drm/amd/display: fix math_mod() using arg1 instead of arg2
  drm/amd/display: add const qualifiers to watermark params struct
  drm/amd/display: add pstate schedule admissibility flags and
    frame-time utility

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 53 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           | 10 ++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 +-
 .../src/dml2_core/dml2_core_shared_types.h    | 39 ++++++++------
 .../dml21/src/dml2_core/dml2_core_utils.c     |  8 +++
 .../dml21/src/dml2_core/dml2_core_utils.h     |  1 +
 .../lib_float_math.c                          |  2 +-
 8 files changed, 90 insertions(+), 29 deletions(-)

-- 
2.53.0

