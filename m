Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D89C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 21:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B368C10F675;
	Thu,  9 May 2024 21:50:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GBEdMyAI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB95710F675
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 21:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9KE294Vas9c2xgYfOrQJXDQVteZGpfvGtDwVWmX+bDTrIiWoBzvHRzVzT2NTdNq31SvhcyKfsDmB/Er3LgwTPA9PV/xeoCampmiXI6TOAPQywU7vVEAUrw8hAyHmSbTS9stLu8flT3m2iEGC7VCkvchjIVLlxp/xxuLy+pPBJ7E7HCcp1XKjVOSq3b9DVVE/zcYl9WSdLJLrW8CtwSmRO+C8wNbXMAcrmA9IexwE51B18nSkPbBf4uhow3X6sOYhHUh8ozzPeE63u64qjBOkMDRT/0aO9NvQ+IbksOUuUuhofrmjSdf/yL9SVt7tmim16La8vSxhvi8aU6GQix6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqN/DbuFefd/SVHcY/bKCVIx9KwGtrCPecArxLMkugg=;
 b=LGjtArvIypARC0jEbKwoYUzsqdgv0bQsO/7BTHNoatlpbS6ZYFwtKzHAfy9Z9avjrk1/YhTHSfUKhR7qoKQIDEiF4974SxvLdC0ghZbLyzo0IXI/FoihoE6lmbFCrTxG7sszvLBIl48cRyR32T0EazU341seOdhmIGusdo8n+0cZQML2xaQ62noIlWbTjq9SSPZDrDoASow/fJKrsRSPX6Mqch+SSjZqU9nQyaUSDYAqSL41n+YyrSQOR0ZCykxly/u9R3sNVdUmJhg9ullnOsoIDov3yudH+dXRHZ7L9RHYyXCEQmj2jjgUl8h2IW+yCEmWgfh5h+0pmlL14E7SiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqN/DbuFefd/SVHcY/bKCVIx9KwGtrCPecArxLMkugg=;
 b=GBEdMyAIX00Om4el0a8eDagXyNFXzGbtd/X94tKJDNt7fvvlNn9so1HD/yKa+eqOPIRIDIalJPENfphQReDdlLk8jr2U+46LZAbQnZa1JoxzYC58udBCMkZKRAoSefz3ltTIE7kv+WnLwSo8Jn9KKAmPeL4ZnKUUAVTj8YpLAEU=
Received: from BL1PR13CA0361.namprd13.prod.outlook.com (2603:10b6:208:2c0::6)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 21:50:15 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::4c) by BL1PR13CA0361.outlook.office365.com
 (2603:10b6:208:2c0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Thu, 9 May 2024 21:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 21:50:15 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 16:50:14 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <mlimonci@amd.com>, <benjamin.chan@amd.com>, 
 <king.li@amd.com>, <bin.du@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH v3 0/3] Add ISP driver support in amdgpu
Date: Thu, 9 May 2024 17:49:58 -0400
Message-ID: <20240509215001.515866-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: ac083b0d-5c26-47a7-0f87-08dc70720291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wD/1Vmsvvg8KfP/iAM1lHTa724GIP2FfhaVquhGFaj8IZ5em73V2XzlTLJW3?=
 =?us-ascii?Q?vGppR97lhRA/HcpryaWnfBX2xKLkm8epmG4HwK3yMekdbFvgFzuVwj9oWpQh?=
 =?us-ascii?Q?kmy9buWmnzibkqw+Vnr4oSmoy4Re74UvaYnX+D9ZPnU1vSUanHquy7gLEdNF?=
 =?us-ascii?Q?6d/YB7HkMyEosIpxQhgeUjcFzw/RBZnhqjdrBLBV5GeiV5jwh9ZdELB4XuzC?=
 =?us-ascii?Q?HRwuTMGGHmab+VVxki0bCdQSPl3HtCQIfs/SpQ7JVmlb1u8r8byWsWxMFHuk?=
 =?us-ascii?Q?ghOZV6LAzPchYSMApG4L9Y2QIXOIBZteVqWcbAoL90XTd6jhzmPM19P5tdb6?=
 =?us-ascii?Q?diAGLLoiPW+MP6VVJ84wsijYAWM3MiXuEprpU+HJtnj/FBANwUzZpteLW4Jn?=
 =?us-ascii?Q?hIWVmhSwDAmeBjOac+PYdIiAY+acnO2MjhiI73ySwbGr+2bTmnzAEoca+GaW?=
 =?us-ascii?Q?RgD1eD+gARC2NSP/I8lLeowtVgpSNbyhaOwN0FesRuA6xUHlXTgp9Qg8ZSn8?=
 =?us-ascii?Q?UgQZvkH1V34nN3rzmCthSJ8UtMoOey18f0nMvXx1QIJooEOQgbfO4ECriDYw?=
 =?us-ascii?Q?L7rAe4sw3su/m+qiZu21tyvGCW88tNYcwo0JHBpgP6ekSif/5Np8DITwvEHi?=
 =?us-ascii?Q?oxSnh+hoG2wyDuFJpu4+MACyD4diKEqV9ioi/tuTpPp6ttMgXMaGJREbqzG0?=
 =?us-ascii?Q?3rOyTNfn6G16oaU73WRb7iULY9lnPSc0mDpTK10cmuCQfTFcNE8JxIBGzsmx?=
 =?us-ascii?Q?Zbmf0dvZLlSBlqZVIvjna1ETdFT930teJrUVc/YC2xtlqlivgTwJcB38flmN?=
 =?us-ascii?Q?SzDPWkJn/y/OB8VP+rZm/KE61DBZ5T2a9uursj8mq9mgjUrvIj2knNr93dmN?=
 =?us-ascii?Q?O9Z632caf5tub1I4gKaBbfsEEJf9fNEp0h/7t3TidkKhr5qgAC5pDI+adFxJ?=
 =?us-ascii?Q?ptFTd1k8dV1AGt6vGpdY7y/lww9jLBup7wE3z3k3TKN8TxxZmtHOesqOmyNZ?=
 =?us-ascii?Q?DVZB9wyBz6A1/vONZKz/OVDAdQ22prN4j/zGAij2LE8awzBanwhVt/bIWfui?=
 =?us-ascii?Q?AyoWtjY5ltDtBKe82xLEeKxrnI2mE3CWm9zHxHYm+jdKiefxxirXyolfZK2p?=
 =?us-ascii?Q?2AtdCZ7IdG0tceoFOWQuHTYg8J8QROsGZVdqQLU8VVg9WXnKB1D9HexOI+Et?=
 =?us-ascii?Q?WUV50aacRg3AL8VxEzbqYToAEaUBMukXs/kyK5x8PIQo1a92VryZLmEYJANU?=
 =?us-ascii?Q?cS/FzB1tal27ltoQgfJSc8SVYIGzk7K4jTF9v1RRla42giwFisKxWMxF3pEo?=
 =?us-ascii?Q?F6XYxM677TneKMaHwhwR4hWkMqTGjortsego19AO3ebq0QHpRIrA3657YPTJ?=
 =?us-ascii?Q?EUcRcXvJV862TuDJqO4uBKsyUOB+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:50:15.1099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac083b0d-5c26-47a7-0f87-08dc70720291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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

Add Reviewed-by tag and address review comments on patch-2.

Changes made:
 - Add Reviewed-by tag on patch-1 and 3.
 - Remove unwanted header files
 - Remove suprious lines, duplicate error prints
 - Fix multi-line comment style

Pratap Nirujogi (3):
  drm/amd/amdgpu: Add ISP support to amdgpu_discovery
  drm/amd/amdgpu: Add ISP driver support
  drm/amd/amdgpu: Enable ISP in amdgpu_discovery

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  23 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       | 278 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h       |  51 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |   1 +
 drivers/gpu/drm/amd/include/amd_shared.h      |   1 +
 9 files changed, 370 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h

-- 
2.34.1

