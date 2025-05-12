Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B38EC3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 03:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E98610E114;
	Mon, 12 May 2025 03:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y1uEksYh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13FA110E114
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 03:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bc+Pric9hTeCvPEVxYfDalQiKOslV58GR+nYxva0VtseB8umFaSMaXJ3A4FDzkAQUGGFq81Lg3TKkEWSnNVPRduXLL+YPlpb6ueNcANJxsjNkqeD/m9BVrj51rvANXAgnj3070IDZVxaUinqlHa/qB0dIOTvRfhXyKhdKGMch3lUjHc1jwkD4XNo7FtrB5a52Kw1x7KwXn29cxsZ/Dq5xdUYKQM6k3Pfq5VOLqhKq4QjQukx0LoPUHgbhBNavOS0Kd/nk3tmX7EiZvJukYLVZRJVXiZr9B35TJVC8Ciky/oGgQr/BQi9J0XHibrAwHPlj0TWtM9FvoUYp6nWonf58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o874nafAaFuVFRbpvvRhDSY3XWl7NaC67lbHsnmUJyg=;
 b=VIUrcNmA3HStrXDbOt1IPriJNlvdwZNNsYc8NYiYrpoBRlQR8fL6eAXBfCjOvQ8UtA3HIEmykJHAOgNSqpAhBl4CnBUaWyP6ppBBvcBSmDfmeDGJl+XrIo3wv8iEDylAMs+NIxfBkNwQcKoXt5A7fT7dxIM1Rv0Or6Kprrz/Olysffb38T3guALqf96ROQuc1nynxKcnq/y3rUJOstx69DaZXIBGakgGOm78e6zZY1nUrYe65Lax459DM+DZ1Q+Avhlpy3Ju103/MWUJIbU/35u+S7VhjyRLHKnybPOv3o73sjHGysGfDRTTUplLrhOlbsgZ3KWYiabppbvqkGeYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o874nafAaFuVFRbpvvRhDSY3XWl7NaC67lbHsnmUJyg=;
 b=Y1uEksYhryNIt14+4AQvO+wMIHgqeeQsK6ftPT4kXwu3YPlk0LtCK9OXtqL8j9jllEBLIf1u5wxbOg0XblABBd8yiLlfn3dCOJ62rZoHUolNFjuTgI+LF2CplmyVeTISpaEweuuWXxu3TIMJ112kHXXpp6tcHqRE7P87pwVxpNQ=
Received: from CH5P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::8)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Mon, 12 May
 2025 03:44:19 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::44) by CH5P221CA0021.outlook.office365.com
 (2603:10b6:610:1f2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Mon,
 12 May 2025 03:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 03:44:18 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 22:44:16 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <Ahmad.Rehman@amd.com>, <Vignesh.Chander@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH 0/3] *** SUBJECT HERE ***
Date: Mon, 12 May 2025 11:44:00 +0800
Message-ID: <20250512034403.381441-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 887caeb2-6b12-4fe2-8eeb-08dd91074651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WznH6zt9cGc1GcJ7N/y8B6cH4L10EacVXdckUgWiU6ER4s5HG5P5gdiUzCO+?=
 =?us-ascii?Q?hvnxH42wwORMJ0s6HgEOlBUD7BF58ATyW8RoiNVwtJuMAlMR8YU3LJtKJCHz?=
 =?us-ascii?Q?ghFhwpQNGgMbO+p+JhcNLuBQnpLXdp1IfPKqHe772oIE82uaC/MESTq9vacZ?=
 =?us-ascii?Q?2TJVM82MWZ3j/ZuwLFNqAzq6EiFFd2IwtvxY/7VhyGA09hk0BdyzCxLXewT0?=
 =?us-ascii?Q?omb2l6/1SZMgNUuwnsNDwRdYTqgXdzelhlNl/xUTNHk4/+t0LSISuE606/iB?=
 =?us-ascii?Q?SKJHB8DOdvQgvoYAU4W7u6L/mzBpFedOPBQYU4swrjxE8No7dff8Tiy/4I+U?=
 =?us-ascii?Q?Iz+EXpE96DhpNrA3wl6TUqlliXRnDjVwUtYTWrnDLAHg7BCLNY0SQP8Eqxl+?=
 =?us-ascii?Q?ms/dve6jOKaaSF77fM8oRxdTJ8nHJzzMjoKNtEy8MFQOHFv5ZDVHOIUbo/8m?=
 =?us-ascii?Q?b9TZ5drJn1wOrO4aTfvCdQzZH/v5g1iWpUieNUivbAmtYnLGTQvgAKCyLI9A?=
 =?us-ascii?Q?3KFOnV9hwLYrQoo5sYke24iigbkbRfbevJTFPfeHXs9VqvFoV4cTLzmfgqqS?=
 =?us-ascii?Q?IM5apGD+q4eHW/d3HiMWIBTiskbFvw8ffcNRrZUQAY6CrTqvJys4jTg0JKqX?=
 =?us-ascii?Q?XZRowvso31cidmeBemAGXxsz6OSHZJiHLw4bceJjNN1K14LqxyhtSJPEgfHL?=
 =?us-ascii?Q?FPC89vRIeNpLPn6xeXTl+H4zQEO0mrrWHdYYjQjJuxlZsXGKI7xo+JsETvWJ?=
 =?us-ascii?Q?KrBOC3/8KevGOJJ5YmSPgaoV8ogzOp/7a0TmA3HJooAFj6oQDh+LDb3WtAdX?=
 =?us-ascii?Q?IkrmmcC67eaDvdL+GEQih6eidA4BKLo9l+M/rUOFHEz9jzlYl34A6dBcEd5p?=
 =?us-ascii?Q?dsO5Iki6bf4yw22/vzbdHhaZeV3rzhuJ6vjfqmIz04iazxcdKz2kwlgJyWDb?=
 =?us-ascii?Q?FyCkkkA6fv6q0YqVtmRDAt3Y80LnDG+1HgsyJ+r8eff9eWI+5Z5x78JoPuzS?=
 =?us-ascii?Q?p0fy7MNCIzy5jcLhMNsdouhx/hJPfKD5bx0POrcmJbKMVnpAxv2K3ttY2RAw?=
 =?us-ascii?Q?qmXF9xSogNHxs5Xvz3Ub+6jLCNgcEG2uiIGa6fhTw7qG23Diis1U6D+ulXtX?=
 =?us-ascii?Q?eizozeIts7UKK40ju4Xq+0VCIYalaO5/nDeVqxEcf12eh3KI/rhw6LrFczhQ?=
 =?us-ascii?Q?nKImESLuxNCqsM6pMNUsGAOFh/MWGSphdLumo4kUIMpDkKuIqRqTz65vzriX?=
 =?us-ascii?Q?E7xP8r16Gugy/yWkK/9Fj1OUmAFMoD/H5BR/DlbqEeeWp0R0yVLiOjCjmktn?=
 =?us-ascii?Q?HucutoLAYuyF6ojBi6fjggPtMq6+P6nG2A3vLUeUl9h/Fj/tbtJzvs1w47UH?=
 =?us-ascii?Q?1hXi8jcDcp7Ux82cvNXWBttnUTn+wSTg3YA0lmU9AP7ePmGJ+KTGl9eu9T3k?=
 =?us-ascii?Q?0Wly9xEfN8R7rZEqrC+8tPaxYb4e5FOY+1lC3x0C1hn510IBpiJTKtoHctBr?=
 =?us-ascii?Q?dr1DeusV7Kh0IM33N3bS2+BqtF7jREUwC0xrTIQ/dvaG/uWPj9Sa3Rpr6A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 03:44:18.6480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 887caeb2-6b12-4fe2-8eeb-08dd91074651
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
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

*** BLURB HERE ***

fanhuang (3):
  drm/amdgpu/mmsch: Add MMSCH v5_0 support for sriov
  drm/amdgpu/vcn: sriov support for vcn_v5_0_1
  drm/amdgpu/jpeg: sriov support for jpeg_v5_0_1

 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 142 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/mmsch_v5_0.h  | 144 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 265 +++++++++++++++++++++--
 3 files changed, 523 insertions(+), 28 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmsch_v5_0.h

-- 
2.34.1

