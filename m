Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86072FD45F1
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 00:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139C110E846;
	Thu, 26 Feb 2026 00:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t6WzcOuf";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ECE910E846
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 00:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDR0zzJNIREBrvRqQm/vFq+6oPiZJYpo2N/biiiWu+rctL+KID2GYGB4ypgf+ZTlGTy0xCP9EVNWwm1RuytjAh79HCa/Anf3ClGCFbaS2mWlcD0KGME9K8rUNjvOYLJPrsUCExpr2/Pzqc2WFD4fDLUJkOgNxz/Fvz+qCJIrRlj3bFCTk9ks+1wT0YpD3qL60+NBdqH+4yyhY6suYePWnNcqPEqot1j0Y5doiaW/MbJVpZK2T3Gib+AYOZYsxzcNNYKa6HjD7F4RzfH4WzUvqw1LnJk0eayDqNf21Br5PuBHcO9V6+S5iWOspxlXr/S1w2MqWuEDEP47S2aMxwsoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAH3FgYv5WoyJ7Kp6ztTLPySyxvNsRhytQ4orDAfl5E=;
 b=i+lcGrUSmCI0yElkJsn4m/mJ2Rggi8tBD9Ywx+EBL43ArCth10iPJzBGF2oDtRcrea8SSv3RgBAcZCQ4ZUCUDkEQvm2epogrgd9Hrbghk/D6GTbfYEX5zUsmFJ8nlouZ/3X+7Flx1Gafq2td4N05dtF4AC13kc41AecV48/uZI11PcCVs+uTEqflS7474iVP6uz4MhIqCm4FTvxrsQQ4OrMU3m9mlLKyB/60mmXqN+bhdAsxxKka1K5uaNL2EPHxFDISLbPzLZOHj4h83rqqNxlOiUuTK5A7AnMeRnTXFtu3BDYhSa3kwR9T+SwJd01eV+epBLhngr1NdgDqNHHofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAH3FgYv5WoyJ7Kp6ztTLPySyxvNsRhytQ4orDAfl5E=;
 b=t6WzcOuf+CK6g88mKsX3UNkdMAubkuMiDkrPBS6Tm9mSSa5gaiBqTsr86xptGpBZcS0LMWPtEMadNHvG3OF7p0DRZ1VmZghuVXE2Jdd/hgUULzBD/DORDJDWnbzN35oc4aU5faqC3ltAhflM1ebjI3O6j8sIp0+t1MkIC0+GoNI=
Received: from PH3PEPF00004098.namprd05.prod.outlook.com (2603:10b6:518:1::44)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 00:01:15 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2a01:111:f403:c801::5) by PH3PEPF00004098.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 00:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 00:01:14 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 18:01:12 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 0/8] DC Patches Feb 25, 2026
Date: Wed, 25 Feb 2026 16:57:39 -0700
Message-ID: <20260226000048.68030-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: cb49e4b7-3b61-450b-a7eb-08de74ca2866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: wY1tQL5qsNv/lybiNxvIvU2i9+8hXIe7aEhZpTf5iM32sWid/97oR5f5csrswDyYdF11Bg7/W+SuOq7+iOU7QEn4M4TImdmXB5AkCfaIqoAOOmwNyXKalawdOrJytjv/G8cmqfRIzsMn9USe7HW7i4PtNiHFMSVwetqaFtFLaUQiw0bzDV2enDXbI7xKtrdY0Uq27BQEtmaIoBT7pHnEeixpC6igD1338fVcMIy1Nw0IuXg9LYqWQ6JfX/5g0SUSugq3mWS611vQkGrOL5gsUGGS8xzT1qIMkJbL+DbuTVc4i96as0aymzAHeYqRuzTkA3r5lqAKs88gmzh4hwhXHxOgsAUepHI1p3LHmnhcfyhEaGE9f+EZ/y/bem/VMTyP7y+SQ4qW3L42CJuuOeJQpLq7tFbW6eeP0YT/FyU5S7ACykxE+ihnAsPW6ZsV56YPpy8E8RtBC7fv+7RA2knOHOuMgbNRCALacF+knVjHK89MPYj5hFz0iYNMDTyRYASceEA55mHslW2BfEBkxyXOYetwRautdSPZNd2VAKjoo4CLIUzviuXAS6opuW6odAZgnvyxIrQX2ok19fGlY753CkDj3WM+QOxG7y9NNNjAADey+FYsFyyc6oInRa82IKLr8/kT1WEkePnUhQqpPXX1aYH2rZPuE/+/IJjmlP6CZUvllhYT8Rs4xHAM6PdMOUMw5VLxQdCibPn8ZD9zBA7NxZp+GYtnr5XqD/SaS8Jt4VFB5xdB0UyDtOFaYfTe4mDJ2sw4q2oivbRYAg9AxwAQZcS/5qi5dp8edBXZ9eV6Hx4ti+DgRt791Xi6FxEVJES2iULaSlfq3Q7L/RJ+UxThDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yerCsNhQ/lyvSBljCoDv/EKATz+fh1skQk86u1dG1riylpa3sX7ZlcbbsLSEO0VBQOYpsr6ubM1d0j39AQl36ZxH9UEDr1rzPMbkz18ISXiEf3nFm9tm1McMInGoUvBUYUwA+ZuYWTL182difosf/H2LpVuYnh6n0cPbbIZYF/5YnTxV1ROtdSK47v9xIt540rLrDXoaapOdeGR+PrSFAAUjlQU80Y+hMrqI6723rMD3J3T8+6C8PKSzpzoHYO0luiWnfAMNaMFyXYmem57DdstINRKL7xEAUTf0NiY5DhWk0JsNhUc8Lzj4WLxzvTtagQfavWAUq+WXeol6mmsy1XmeHQobt4BNeGfVuWvsqDIlpdx6wYbIkbGw5h1Tp3+0Klz0+eiUrBzx266pe5TiAzGB3TZuEnx71dAtY18HXe0ACjbs+bzxa1l1xSYWNEXL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 00:01:14.2463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb49e4b7-3b61-450b-a7eb-08de74ca2866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
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

This DC patchset brings improvements in multiple areas. In summary, we have:
* Prevent integer overflow when mhz to khz
* Remove always-false branches
* Remove redundant initializers
* Silence unused variable warning
* Initialize replay_state to PR_STATE_INVALID
* Fallback to boot snapshot for dispclk
* Skip cursor cache reset if hubp powergating is disabled

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (3):
  drm/amd/display: Remove redundant initializers
  drm/amd/display: Remove always-false branches
  drm/amd/display: Prevent integer overflow when mhz to khz

Benjamin Nwankwo (1):
  drm/amd/display: Skip cursor cache reset if hubp powergating is
    disabled

Clay King (1):
  drm/amd/display: Silence unused variable warning

Dillon Varone (1):
  drm/amd/display: Fallback to boot snapshot for dispclk

Ivan Lipski (1):
  drm/amd/display: Initialize replay_state to PR_STATE_INVALID

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.372

 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 14 ++++++------
 .../amd/display/dc/clk_mgr/dcn42/dcn42_smu.c  | 22 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../display/dc/dml2_0/dml2_dc_resource_mgmt.c |  6 ++---
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |  7 +++---
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |  5 -----
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  6 +++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  6 ++++-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  6 +----
 .../dc/link/protocols/link_dp_panel_replay.c  |  2 +-
 .../dc/resource/dcn42/dcn42_resource.c        |  4 ++--
 11 files changed, 39 insertions(+), 41 deletions(-)

-- 
2.43.0

