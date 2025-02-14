Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419E1C021A9
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF6110EBEE;
	Fri, 14 Feb 2025 08:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZNAePWmp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEAF310EBEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlCNhzeq2e2T8GZiqW2QIUbtxAbycDvqF+8mV8Y9ET04R+Yg2WpKs8UTyBFmSKX8eN/Z/BwcxOAsaIzwWM/5JbGbVDcNXXTBu3eU+d/LLtyewvXXI0Y+S8p0vMMFQ/lqIBnJCZMUGHf1B3zY8zAj126nJf4qQhK4zb6gCO82DOafVK7FE2cINZquAHNba+n+4gr+oyYHlZq5NhqhlMVBsb+hYtdF39IIPBRc3BHLx6LfBYiohrbfzeeDKHlyO2Mvs39pSNjwFR0Zbl3YpXxgVmvA3XcTyzSLH9e/ldJ5oOr8BnnZbSB9kUDoVm7XAJUS989+uwD4XFYiuMqD54ae5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj0nLchErpMTAtzYMJbG/shtR8hgmWRWBbguEEdbqK8=;
 b=C9sTnnw2D5CEjYl8dfPEQ1C/jMXJgxLTXNuQ3VAjEtll78CWn6Of9Ujiy5lCxseKPa3kaia3cpI4lmdJv0tEWc8F+wYMRbZnEj7x5FkPcWPjNsfejZaOCpHRHQZGGV5sw7JEaVmiHGx2uVqZ3tGtnbCEM+Wzizf0rnMVrvDGZsEDTotpjRaNb0Aw3mnbZmnSeEpmmFZeRw1WxzZWj94FJlUjax68oRLGZJogUNGpjfrP0z04KxowkkY5lOyYc8Dr1EeGXJeo7LWuV6AcrYbtGuk5zQIzUOW7rstWAQPZDvJNFklpaX8hyLvvtoZdAokA4Z7iVOCdCDFAjZErOpzSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj0nLchErpMTAtzYMJbG/shtR8hgmWRWBbguEEdbqK8=;
 b=ZNAePWmpHVDJjSvFn5ucRT3rY4MLrk1n478GnT/2JeRKE7sCkx3WMbJEXltv307xhgBNhFfQmZKvZH4Wqv2tJuwoZL34vEq28ZUCyLA8fp1zVuGyj8W51P7IXtsRsWLrakPtWtTZB8UCE8HeG6SotvRRmq7C7ACEWlIpwWmAscs=
Received: from BN1PR14CA0007.namprd14.prod.outlook.com (2603:10b6:408:e3::12)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 08:08:00 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::ec) by BN1PR14CA0007.outlook.office365.com
 (2603:10b6:408:e3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 08:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:07:48 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:07:46 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH v2 00/12] Generate CPER records for RAS and commit to CPER ring
Date: Fri, 14 Feb 2025 16:07:07 +0800
Message-ID: <cover.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbcf0de-43f2-495b-98d7-08dd4cceabc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dGC0xihqxsNqK6ltlyqw5S8Jc2L4cmocCMY6hJWXN9+a5mMuAlqy+tOj3Lsc?=
 =?us-ascii?Q?sVBnvPidL/mDU0qNs2UeSKG3Ofi9iy/bzQZdfQM8vYhgRYcnb94APRTQdQkv?=
 =?us-ascii?Q?n8k7PyJ+RsJ/FCMuuAiRNBaXaw88p5fcmfEdbaQxMOmvIkJUQ90pTZn7lFr7?=
 =?us-ascii?Q?aw4rAEfVruFW2w911Sd2psbQTsE19kI65J7+9z1DmSsY/VJeQehXIqhw5COf?=
 =?us-ascii?Q?dmY5nV6MnoLm6aqbo5w3J5OWx54r8fyTFnvqKXWO5W2QTEKcO0eR5RiSsUKp?=
 =?us-ascii?Q?98tW/qYEhD3FIvbBjBqPjsmDZ5AbzQBvfaTwBQbKaVwDdfPgeU5cicBh1VyT?=
 =?us-ascii?Q?xMgmzPLhJyxYj0+LJDx28IM/reg8k7CpctLpsvuZXWBOxSGIfDmu1heJRzEW?=
 =?us-ascii?Q?8A1n3vFvwOtSo1+yRLg+m6PHXRLUZvKxcw9stK0SR09BO726hU1m5DWL11wh?=
 =?us-ascii?Q?JKZE8jN3Iy92+WWYqWyq/OzinwW/zSmVh9/LDNCid68A6lOkSHLjDB+LLNdW?=
 =?us-ascii?Q?3HXuiMKvb1c7msB5uN93Ui2BqOX3rjzO9Tt4lJhi57EOS1GbX05/MByd4YrU?=
 =?us-ascii?Q?hXWWWzIq3zwJI+8SdHwVS0g7T9h0bWjTCz4qZxt+bipNeGwgGcCyfVj+NhdD?=
 =?us-ascii?Q?KD0twhHqgwwsPQcOG/Nz6RgLJi/hx6kU2Bo+5srlDrHedpcVOG7CI5oUagLU?=
 =?us-ascii?Q?Q5pboCT5+f3An4xwrYoP41v13LMd/TFaqng8mcyNae9+PWkMBBXdTx26OSkj?=
 =?us-ascii?Q?wE3J9ffApZI6s7ai6dAjqUUJ/wSmeFG/1CmJ88Z89tbWUkkmP1cUES7RNlH5?=
 =?us-ascii?Q?VybNJCpKrHHLDh/hjaFs3uOMWGNdvGiR6G358xxTEFe6fiBLbkztIgAOn0rh?=
 =?us-ascii?Q?P2ay4pxA0lcnTGdsVp3T2xK0OQ+T8CJNUkMLXwv0CNxHgo9PR7v5VN8ngufB?=
 =?us-ascii?Q?adpi3rAVfqrOCIuJIfWmamSXcPksSWixw775UymprdMQqr/Qqg1K5Ht9i3f0?=
 =?us-ascii?Q?IxkRaXSVmo4Mh5NPlke/h2rTlYOEhysiCxYmAJTwNwa74o1x2zyJ4LmR5FBK?=
 =?us-ascii?Q?8dsN0UewCTa/mdzA5Hc9/GvAfIgVdZUVQS3lBB6yxtIiS9AC97OhMhfTf8I9?=
 =?us-ascii?Q?pxS8x6u1o1ILBb7Tnwtf7JtHczCsBF4kveG/wLmS2kmrihH15UrNjR137h6I?=
 =?us-ascii?Q?cl8sLOSHmvaPIBRoLdHHlQ2yPyl/hMwSDy+BgF1ILSUJIy7PvW1ZHMsFmmHV?=
 =?us-ascii?Q?E/GVWCfjcIooo2mlBrqBCSHLDBdF9UdrkImlal2KF1k2DCfnoEr0oncH4TVG?=
 =?us-ascii?Q?tiALgNRoclREp4zuwyDzobzflavMFHgndS22FYNuyjxHedZjn1Yekg4pTgiS?=
 =?us-ascii?Q?KeMAFIU9x1qHfVEo+8xLPz6S0Kjat6HPVMeqHMHg/uAtB/obg0+czH8jaVo9?=
 =?us-ascii?Q?oKevQndnmW2+82bphaFN7lCfYaiaOwXJILUB8N8a+y/KcxA+abi6oQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:07:48.4681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbcf0de-43f2-495b-98d7-08dd4cceabc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979
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

This patch series generate RAS CPER records for UE/DE/CE/BP threshold exceed
event. SMU_TYPE_CE banks are combined into 1 CPER entry, they could be CEs or
DEs or both. UEs and BPs are encoded into separate CPER entries.

RAS CPER records for CEs will be generated only after CEs count been queried.

All records are committed to a pure software ring with a limit size, new records
will flush older records when overflow happened. User can access the records by
reading debugfs node, which is read-only.

Hawking Zhang (5):
  drm/amd/include: Add amd cper header
  drm/amdgpu: Introduce funcs for populating CPER
  drm/amdgpu: Include ACA error type in aca bank
  drm/amdgpu: Introduce funcs for generating cper record
  drm/amdgpu: Generate cper records

Tao Zhou (4):
  drm/amdgpu: add RAS CPER ring buffer
  drm/amdgpu: read CPER ring via debugfs
  drm/amdgpu: add data write function for CPER ring
  drm/amdgpu: add mutex lock for cper ring

Xiang Liu (3):
  drm/amdgpu: Get timestamp from system time
  drm/amdgpu: Commit CPER entry
  drm/amdgpu: Generate bad page threshold cper records

 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c    |  46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h    |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c   | 559 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h   | 104 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  91 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   2 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c   |   2 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |   2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |   2 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |   2 +
 drivers/gpu/drm/amd/include/amd_cper.h     | 269 ++++++++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        |   3 +
 19 files changed, 1075 insertions(+), 40 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
 create mode 100644 drivers/gpu/drm/amd/include/amd_cper.h

-- 
2.34.1

