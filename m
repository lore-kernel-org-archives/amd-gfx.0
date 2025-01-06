Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD57E77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 17:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 109D310E2D0;
	Mon,  6 Jan 2025 17:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v+WyPuS0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A610A10E2D0
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 17:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+y0hOL/kQUaVhVFtKcO4tkVar3Q9F9ETzcuMWKOeGoEYz+SoxJbx0PXqz2hvMuN78hYxvYRe9N1gtd3wXitXngP+JmhryEfj/pOwgsEfQdSTOKgIkAenNVQWf0qZmMcVIeEHYvBjacyPzfzEPiHPo6iRDfu6n74JpniYBmaHjNxU2cVWbx/graoDtuwPQhYPPLG/f1njdu84HXnb7O68egWFcx8XQjQB0tdwtUZTKKkwmCodwagEfR7iqpciaQFayFquMpHb7Eodew7dcWNXw5eG7D9Cw1+o82u9c9NwuYcewGaw7mfOYgeLTOmb0GTUuSrJyOL577K37izkl6oBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR7GKtoOvV2Y3yNuhBHw8dHev2UsQsAU5dA50/hIs/A=;
 b=BerxPY/pplUcVlzNRPNZeN2t8YxAC/kFKuCSFEcW1vXH5Akf2KmGYOfO5oUeMq/vDNBH8FS1fHdv63bR5WXIWLl2XIeylsNKDZDnqP5t1eUROpHga6K/ZuoMA4XINacJ2NbKzf+M6P2ZxilYqyi/EG/COT2dLHDlIbxxRxXS7Oj48pIl/TT1Er8vUMDGvp0P9aGFp4zEWSsTMdULQ0U6CjCPwJ1Kx/BjSBdE9MjuFcn91jagfhZAzhYro8SPubX0cWoXR/onbOTk131XgSfiMEIiY71Bq7nfYKeKXgPnyoShmX/K427lR7/iFjUuOpyUavp0JHFr6urcgbV70sNBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR7GKtoOvV2Y3yNuhBHw8dHev2UsQsAU5dA50/hIs/A=;
 b=v+WyPuS0spBFq0yi9vfMWJj6skYR6ZrsiBzo8orU/7rRXTNS5UlyGIPkSNygIU7c+ZNw3oYcu4EZzZGjMcP/3X6W24zHjbIfesxoduh8yDK8yVPyZe9nhwnpGjfV2aJ5jM8V0Z8PNFdm8uIsmgiZ+CENIIxGYtdRiSyEmG4WvwM=
Received: from CH0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:76::20)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 16:46:18 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::58) by CH0PR04CA0015.outlook.office365.com
 (2603:10b6:610:76::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 16:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 16:46:18 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 10:46:15 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <saleemkhan.jamadar@amd.com>,
 <shashank.sharma@amd.com>, <veerabadhran.gopalakrishnan@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 0/3] Allocate and map doorbell based on requests
Date: Mon, 6 Jan 2025 22:15:27 +0530
Message-ID: <20250106164530.763188-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: d15aeb5e-6d15-4143-ae94-08dd2e71a483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pEdCrvSxweN/RmPVvbM88FHQ+err2TjzSFc9omsVO00lDGjyHcpQDRU8Rjlw?=
 =?us-ascii?Q?X6SKfU9xNK6/Qb3AcYiRgfAaM9VuEsIFmcxONouzjwdEfXfLK2c3oDzI+NpX?=
 =?us-ascii?Q?kbNsIOWQdTa53jxoAR9lVgu1Uh7Z9EKtBo9bLCUsGu8z8JHTzxMFuONnGi/q?=
 =?us-ascii?Q?Jri6PZXX8HCyXogwoqr1PEgzUfvu/YiXd7SqFqd+ncvsKfMEv2/pCPDjUjKL?=
 =?us-ascii?Q?nkSg/NjctwWeXIpn9vZ8Uvgn+wsFsmoYrPtPr552vpz6dHgEnB+/9n5xBQkX?=
 =?us-ascii?Q?AuLxAc/d4YtLSr43cuV7TcGsE4AuYNRAsLvaADUvzK2Clo8p39egrjOhh64m?=
 =?us-ascii?Q?5hsVsLVv5FtHO3eNg5tQCgAVOPbYNhUN/TSjfUaL1qrGNcRz2sc7QtmJZh0n?=
 =?us-ascii?Q?g8j6ffTM6rrHsmS/XhFy92NjqtyGfcvYeXIQPLlQ78g9ljE/5FN+1/uOln1v?=
 =?us-ascii?Q?tv+EWSvoIoeW3mMj9dPbPO24apn8YjqA5UHniz+gPHL5K4FDfcxfxM7zH1SG?=
 =?us-ascii?Q?4i9DqQJi225h2svp9tkWjYmvHpzV3bh6ThMCq+0dg1/EAhTGgzMjiv/tmLUd?=
 =?us-ascii?Q?yaPsWe6GCBxT6d+JH6Hfwojls/5fAnZAMOO2PLN6RnxEXAqzrfHcnfJGnkUZ?=
 =?us-ascii?Q?UmZUa9Cg0yGr6k07nS/QkaNDzX3hXvlbL+LmHfCpzRUu93r8SfIsDYS+SJ6u?=
 =?us-ascii?Q?9w2NMmPJs+eO7MpDNSE4CI68/1DeFFiuKtFwD/p8+X1SsMUSV2eeu0hmm8w4?=
 =?us-ascii?Q?bBxgI+3L0j4rLREo7S1iaW7pTMxrbPsU+pD6WLbxDvcL2luBssZ8wMTEwNih?=
 =?us-ascii?Q?Obx0DUMeOKBfjkyHgSE4d4OcxzuedPCaTUIyMwW1gfEQJ+2k7a9giJkyliq3?=
 =?us-ascii?Q?RcoqTMEN89r61Dwknwbhd8+HSC5xnUy/+qmEhtt6Z8rJZfSzRuz9q5cLtK5H?=
 =?us-ascii?Q?G51b+6qNItLMYWyXGRXRdvv2t2Q/LxLdMVg11/BzVxRUuNpLd0bq2HeLOovG?=
 =?us-ascii?Q?eAV562nmwikiniyB602d/fMR/2p1j4iXUUc7AWCZ4skCJ8Mf61YiE2BG3Ame?=
 =?us-ascii?Q?G3PU2RxJFpJkwXbzXvs69Xti5Tq95VHj74xhzMqfnch2ZM8dlpERwuYaN+Xp?=
 =?us-ascii?Q?mJpP8xnOaoXPGh0e26taCNPyWaiSwPYxHAoCH+7X2wk15a25ArF4tN8YX+Kt?=
 =?us-ascii?Q?wMTi7mZ08viuko653l38GK6yh3iUiTFXBwsW7FG5r4GyPE27EPa5HFXqG5vn?=
 =?us-ascii?Q?oF7IPamgY9Y047VVFCmTQBmihnIyoAUW94mqYyDHTIqXEFSTT6YJrBEyDUB+?=
 =?us-ascii?Q?Cf/Njn/xzJ1k5hJqfvjNEBn1EFpH26AO34cbbB8UJXqhZgleCOc7eybIYfna?=
 =?us-ascii?Q?fQXNpEC4KhrHTAdzpvPitEKwJ9XuXG2u1qPGHTDNwVNVg4fTyjXSODoQSLTt?=
 =?us-ascii?Q?OZv0caOhwhYK1fomkiUq/kiV9UacWi3XvX2NOmnsGbkZpOxz8QzNe2Fj72HL?=
 =?us-ascii?Q?OIJx9PY4BSmdPRQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 16:46:18.1972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d15aeb5e-6d15-4143-ae94-08dd2e71a483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636
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

Hi,

Why:
The current implementation of doorbell mapping does not handle the
IP specific doorbell size and offset range. Multiple doorbell
allocation when requested cannot be allocated due hard use of
"struct amdgpu_usermode_queue" parameters. But these parameters vary
for each request of doorbell mapping. For example VCN needs to allocate
AGDB(Aggregate doorbell) and per instance doorbell. Parameters db_handle
buffer allocated in userspace)and db_offset vary with respect to VCN AGDB
and per instance doorbell. When compared to GFX apart from above two
parameters db_size is also different.

How:
Introduce another structure to locally populate the varying parameters.
Modify the the door mapping api to use these structure parameters to
get db_size and offset range based on the queue type.

Regards,
Saleem

Saleemkhan Jamadar (3):
  drm/amdgpu: add stucture to populate dorrbell info
  drm/amdgpu: map doorbell for the requested userq
  drm/amdgpu: add doorbell size and offset range for VCN and VPE

 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 42 ++++++++++++++-----
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 12 ++++++
 2 files changed, 43 insertions(+), 11 deletions(-)

-- 
2.34.1

