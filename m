Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCE9CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 20:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79ABD112363;
	Wed,  3 Jun 2026 20:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1xMDna39";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012069.outbound.protection.outlook.com
 [40.107.200.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB3811235B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 20:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikeGEEKOXushUPncUHC99InaHRa+v4XbUcDGIF/0xAnFo0NMk/goRxNKILZ5nPdQfLAMbviqIIsgubwsOMrSd1lNzQtgVFZSPJ0fouZGENBniCpWYE0/rtFa0ZFaRNEkgr/w1+PAv3UMcNepDCpJLS+SWzrQyek/w2QMpa3Hfbj94aZswPqKVwGhUl2NB5XrsA/FlIVucySbBIrwiqXgDJ1rh1FFTb3AhMqAjrc31u60gUqrVcQwkuNUykR9/AwMVnctaM2t0HSYTyOI/HUhzLcIMHExRNzdjgLwWw2LrECT/bWRBfIKlgswFXehqRRzoRYGiJ/akDhGfN1Kiq1oAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTQZ8PxtTokFrP6/7+3CQCpxzKOeghbDd24hidzxzoM=;
 b=EhnTHqmDaO+7uIdkXxYWVB/B5kKOWBuaaggtkK+WYGsSMCm2tvLjf1nPtLhJ++HiWCgRrf8RuNqkh/U4n6eAzScOBI6wh7MSem6OO6KteM2Yo9w/wG/Oso/jbhOCeP0raOMzcvOi1o3huFHeduN43c5JZb/qegtB+fXlcfvdXesoem6y5XFCrvER7d1A9ohjfqwNPQycLcPjBblIxylRo/8alTV3AYQKp6xsX0Y41MylEhUjIuuC0K2Ze8TH9NVI2l32MKkemdbNFd5fuOPwKOrTtzAzpNWMK3mUnhz2uKt4i2fpJj1HgxAYMLwfTyfWmfDe5uysWslfw/kzSXw1oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTQZ8PxtTokFrP6/7+3CQCpxzKOeghbDd24hidzxzoM=;
 b=1xMDna3955xPm2MzkjsoZ+69gz0iiL06H9kz9JAeTOQhM9aJrIWOG5YFLPM+E9tNJB+7BSybXkWyKOjQ2K9GnD900/C/qZvHTpv5SzRALbtureLfX6t3AAMsUyjsYGhM1lKE8gNcn1hhs5z738NdfLKAKnSjRKC9ShKT/4SwIU8=
Received: from SJ0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:2c0::30)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 20:38:43 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::94) by SJ0PR13CA0025.outlook.office365.com
 (2603:10b6:a03:2c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 20:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Wed, 3 Jun 2026 20:38:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 15:30:55 -0500
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 15:30:54 -0500
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>
Subject: [PATCH 0/2] Fixes for DCN42B enablement
Date: Wed, 3 Jun 2026 16:30:14 -0400
Message-ID: <20260603203208.3721331-1-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 6908e9ab-3aa0-4713-ae28-08dec1b01a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Kjss4qrd25ChnYxm9PnH7KVLbfPUeY/tYEskCYrj/B9Q6i+13eAvyfw02Q5YBNzji5df8mDWF5eSjJib6IgotHlkPRbYym5Tl8un/ZaXwky434wADxf3F5hMXpJoX35I+X+5VX7lTbb+07nOuVQPmtcgXBuDFsfI7LMDtjZ5ruBdx2uFBxVEN8mjItlVXSVkMYlILP99+4R2tQQDTOwxAzTU0smYeFaNwopy3OGFItDdu+jExkoZ+gRtXGgJzWsoQBHVXOfr7suxtnNTnHkPqwjA4HihX2IBecG9/5IO1BGd3hcL9+6Dx+JwRnf+ZxLwzUTTcITBD8y2rkfYqBGfe9sf7G0xZmz3fsYaeSIg4Xq+rWQviNvkEGFzBkMBITWOAcP1/r2A2q4R/ALurQoboAS8uLJV/SCu1t1waZmGrksEzfpuJdQYZGeszycBybfDkKQasv1b+YjZ0TBqzi8dU3p+8H27hrrQdOLxt4/U1xsQX+mMkvdZQ1G/LHXYmRZbDT/fOB0X/VOTHCtNZZHjaXZ5yXhhpRU+fDDO+VHFvMpEW7dOiFaSzLpQxIdYqRgxZC+QiWb8hcNu5S8yQwVLWS3i+p5zMY2WDfT3NHfq99e2j6LGyaiF3XfceTL7VPwnb/MMVDhWWKIfsD1/xx4XCdYxPJ3EeXPEt/UMMY0WJVlDnw3fSYLngN2iScDo6f8vN+ewUIEE15Tg6sGZx4PTr9JJuAfCFEV5gzsdKA2DsEs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2pzD+T49bP89uS4EOk6YnZsTEpL3HBVmNSqKvkFXtxXJpKaO9Od+70iR0MDvosbyNU3XXJCVTcbSe3AYuRxqNaNS+778Bn91DYGmKAH7Bj0yezU6EgzhV7FY505aPgOgb3eJyDobh5jLtktc5FzmKr8UeDidBUNDgupv4Gd4Xvo6Qaolpoi96hqlyKCoQy+Nl8qHieXnVVf99kIGQ1pInDerG3Ary9TdGdocYMgBFygYDY/raq4tQZFx6ajPKR4D8xskccDzcEAdiY0FDJDAcbd8KzWq7XKuW4YHrlLr0TPxQ+vrdczEgEtv0fvr33L9W3+W1zTgCBjUF9WbZLt3id9Y+hxAcUpzHRQwzafZkGVsEAym+YQwb8WtVgonGlVXtwiqU/hxShgdTvEwPEeT323rC0R4VcPvOaSdNNxqpO8EdXQYWHle1LjZ4hrhZJJ6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 20:38:42.6705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6908e9ab-3aa0-4713-ae28-08dec1b01a03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564
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

These patches fix issues which prevent DCN42B from functioning.

Matthew Stewart (2):
  drm/amd/display: Fix DCN42B version detection
  drm/amd/display: Add DCN42B to dml21_translation_helper

 .../amd/display/dc/dml2_0/dml21/dml21_translation_helper.c    | 1 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h             | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.54.0

