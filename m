Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795A0C10F15
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 09:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D6010FBCF;
	Thu, 25 Apr 2024 09:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mQVJy5na";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BAE10FA6D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 09:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvdL7Wgkmfn8pYvhda8ZvMTbbpyd7CxLV/HtoRK+GwUIkKuL8zUe41o2MkhLtx7b/o7hB2JzjLgKerkzNo3kpXAtKR5JM7ZyDSir6/obZ9Qr4lLCOt3tFmrDd5o/85+QmOiH4ZpNxQmpOmW+P84IAsIYmZJq4pGHUpBQhR4Kh7TtZJ7AmgKi4LPQxjW812ar7IC8zYCVAroljGSJEfN/LThdo+DTdgdtrzx1bRh+hRFpHos9OZpZp6yfOTvwsww38i+VgasUd+9ShsyaU0BCzRlV5/z1VJ5xKj1qbhX7NEJvqTgYcaI2PimlOHgLWunUjP7G1zOnBEAGumfty5hYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OauTNCp8uKwtYXafNnt/soVm1CI6pV47P055iiqcpgM=;
 b=ACYsOCUG3rV4qmPBCWZ14Qf6ysVz2qwWtRJWDTefMufR+16a7OeL6mX9Qc/FVHPfWQ04h6hIgueRqWsLYJGPPHoZDgF8clugD/agjHoqDYtlIyWnm65ECQ8YTKKufRoS/qbCdps/dvbo02KEngIE2zbp5unaejSUhWadZi1TFb+E2KnHUQAB+xTi/0/SFhOsI9D+bYlfLxZ8kaGusb1r+JNyVuOQBIxKBPZezXeRkNYXOEdgCv83dnhcRlkOqnx80TKQPzz/XOeEnOEoC4px65kIBMHS9A9Xv1V7c4DX0QqJtHI51PgiM2bueeYM5WnOZ9XwzFTCRhzHraS9gYb+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OauTNCp8uKwtYXafNnt/soVm1CI6pV47P055iiqcpgM=;
 b=mQVJy5na+xHZQaKyLpVE+fHkA0PHU3sPaqn43zwqTrpF8jJd9UD10kCX4J5Jq9+5wBj5Zbis/Zbt707HBRhMTQo2E5qLlYt7u3TPbNQDuO4SziWQZRCv8DnfEd0B8f/IVrlWN2r2D0dgjQpoqNP12D7aEZ9PLTIAfUaHihunelo=
Received: from BN0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:408:e6::26)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 09:48:13 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::c2) by BN0PR03CA0021.outlook.office365.com
 (2603:10b6:408:e6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Thu, 25 Apr 2024 09:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 09:48:12 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 04:48:10 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>, <Likun.Gao@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 0/5] enable mes to map kgq/kcq
Date: Thu, 25 Apr 2024 17:47:38 +0800
Message-ID: <20240425094743.134248-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b18cd9-d9d0-467d-8762-08dc650cd256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d+kzmN6yKGVAobR9iD2k9FtZitwNwwvJNhRKpi0NdcuctOWk95u6iiZN031M?=
 =?us-ascii?Q?CZeYUpYdmacPLdqITk8rxzbZCFAl8rUYY2JWc07o9iFidNfh0OZ04h/3tNf1?=
 =?us-ascii?Q?cJHihR72wjk+P+TqvHEnFVuaiyqfeNr5+ZYMeLbwsVp0qEqSfw9E5Cgo6q14?=
 =?us-ascii?Q?m8+3OgTPmbEi6vCg+ksDYjaIzXwSnmxABejhjDGbSrcArfMebmKduVB1Nztl?=
 =?us-ascii?Q?nJZXYvoNBGXknLS+nYVAK7r+uK2CVjkSR0RVR9jl6Y140rSQhx1RKOllG6mb?=
 =?us-ascii?Q?UHxinI2K3fHlIH4m/3aHuWv/otE8n0CssFPzN5O+8Uxc4iLkUweRwAyndeZ7?=
 =?us-ascii?Q?wTk8mvXOvJguN4WawZm++eFK5KxC3oDxQd6fnNFesYrkRP4OH/BPN5rmt7ar?=
 =?us-ascii?Q?GbRZqOwPEyNI/CMBB0ZcYgF6iICPitEVZzKyoPj8bPlEKT7WZnXcZewe9+wi?=
 =?us-ascii?Q?3vc6CFF6vPDvV9lDPeo7VBmX1zrT0SUgtyUviovtASL+8MKsW+lFX3WnQ145?=
 =?us-ascii?Q?K6W7DwlTw2AHeqc20sQlCmCDf4c/Yrz8AeoepAyT41gNlMOJ7c8QTlmaibX0?=
 =?us-ascii?Q?QrZCLemATxVgMC/ISMnJoYc00vHK0kCMZVB28QABzIn1t7nqjzvkYvR0H3p6?=
 =?us-ascii?Q?ZJ1haFZ3mwDVzjwf66/dilkszooGS5FqYGpBm58N6JOnascxkE6MBGseam7k?=
 =?us-ascii?Q?6x4A9s2PafqtedfAMnDjbFrNdV4duXoKIgJp20YSzyRyczniJOc3uISOXjUI?=
 =?us-ascii?Q?dqPgqmtJc+bV/36VcgUKyWtkm0mF1VggnZvpllES9YLP3c2jwzkwAMNgNGv/?=
 =?us-ascii?Q?T+qqk1GlEGQVO5tfjrFLDsQOMUGuw6PC4WITxIFzUUlNNW5H+tr+7QqP5E5h?=
 =?us-ascii?Q?p51tXX+iR+vkxZk02V5D7lgTAVI+ROSPsl23Cu2PEdXNDEAjwSfBfiGnk0oO?=
 =?us-ascii?Q?7Z9lHJ1ZxAxgByEJw3Yp1G3AQWGImVItm7WwJsQZB1llbkeXHmaxG5C2kgsZ?=
 =?us-ascii?Q?jekDNx9GFcGTKuUJQhUOXBLjFa6LAE/NRQNuQDe+/6Od2xHPZgFQjKvpIbIF?=
 =?us-ascii?Q?PP9FbPrtbcSCPodpUOX+pALEGXELw3bnz3gjfU0LveLPuZb1nglnyGVeyDtE?=
 =?us-ascii?Q?deE0RKia6U51yxW1Hs7IoeeoowM26HHrnCZJ9xlqpZg7otnmWlmgXDtIYkd0?=
 =?us-ascii?Q?lTvu0HLKj63oidbGftGZzHZq/3C7tFZD4wSru7oLVr6tJfWOqGZ/g+Ur0FN0?=
 =?us-ascii?Q?3O687H0GKBgzCOPQGL2Wu61vu9jwaxzVT+zLpVa1DAK9nhhyd7O/QyMwRUCK?=
 =?us-ascii?Q?3wFS6cUeZElPF0L0mQMeGeT3UpOSnzeT7Kvp9umfCAKw+j2va5Duz4OBswpY?=
 =?us-ascii?Q?fB3U9DnyBPesSX9IDlMb8slP86F6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:48:12.2198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b18cd9-d9d0-467d-8762-08dc650cd256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
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

Jack Xiao (5):
  drm/amdgpu/mes: add mes mapping legacy queue support
  drm/amdgpu/mes11: update ADD_QUEUE interface
  drm/amdgpu/mes11: add mes mapping legacy queue support
  drm/amdgpu/mes11: adjust mes initialization sequence
  drm/amdgpu/gfx: enable mes to map legacy queue support

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 39 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 22 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 14 +++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 35 ++++++++++++++++-
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 17 ++++++--
 5 files changed, 118 insertions(+), 9 deletions(-)

-- 
2.41.0

