Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07666C44536
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24C210E94F;
	Thu, 22 Jan 2026 08:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Aq/cWfvH";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011009.outbound.protection.outlook.com
 [40.93.194.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4E510E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 08:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e84ZlgMKyAt7Wpb27XqlbQw60uyjxKbspzXt479Zoft1ih24/JH2IQfQU4BSmBa+ghtkAUjJxNyGzxtoRjBzQyfwu20+goCMNp8sp0cMXp08sNSfhwDDM8oYpyOENZlm9rMBf49j0bPPC3N7kC0JfTH6WovRGKB3luxEl3nYvnCjFbwPHQk5E38KZqG4XhP0CiQMzkM+8Lw5HEZAdwseejI7xwsYoZdWTZVhxUCjNkUHZLxNH4qCoEULgeZzolbN6uHfeoRyIhjRmXs3z/T+zBq6ae5anrMjGrrQFyMOnTa/CkkmcMpXcLTzw9GkVn1izhkSAYIeEeRmOIYxUPRLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzuGxL2v3pT1YkstuBhAHnZL2H03iR18TIUqEqupfP8=;
 b=KRGGAE1p5//ZTaGrUIJLbFOcAuflmVOSPTano9bSnABrBtnaZ8fTRIgR8UqBWR++MGo2r2XrVp8tXvumi+PZLJ+RdGWqez9Zk8qgauohVf9CiD+/0val3Zy7CVst0c/eeHWayCz0pDezaLM9bfptcdJv2LV43NTNhAyTChSrgOxT689HJmbI2dLA3/Ecsstwww3gqJ5c/1lukrXKBtxBtKcv8iN1sXOZNEaVJvmRkTaXzsBhhRPFhBZgc0EZX29RsKqe2/O1vgXJ02aKuga9eXhJsoNuctmVJP9LRCz8FpqXCgRJmuhl4HoQLEllK5LQg595ncVDYsdU4u+qHvPRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzuGxL2v3pT1YkstuBhAHnZL2H03iR18TIUqEqupfP8=;
 b=Aq/cWfvHdLaPLjdOBrPBKsQHRz7yYa9KaHCpfc1VXSNAwv1RX2l62iMurGAkBu9tSGt/28rouAW+krgPJsZnoCy1WDa3MiQRw9mRsI9+/SKs9zIRny6MbieYq17ulYr2V8gQXUWPB2EVPNFrp6w7s8TPmhbLZZxfhh4rp7qWQCg=
Received: from SJ0PR03CA0173.namprd03.prod.outlook.com (2603:10b6:a03:338::28)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 08:57:52 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::f2) by SJ0PR03CA0173.outlook.office365.com
 (2603:10b6:a03:338::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Thu,
 22 Jan 2026 08:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 08:57:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 22 Jan
 2026 02:57:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Jan
 2026 02:57:50 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 22 Jan 2026 02:57:43 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/9] drm/amd/amdgpu: Add update_mqd callback to amdgpu_mqd
 struct
Date: Thu, 22 Jan 2026 16:57:11 +0800
Message-ID: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2ffd12-ce18-4793-508f-08de59945358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jQLCGFBLT/o8MXPLuESvjkuwNeiwSIs4pg2nKwzoc7RO7gGyNiCBGCcWffGp?=
 =?us-ascii?Q?xBJcxcGytI8ber/wT2/Joi4UKAiBfAQlfH5+7NNX+TC/9hPnFVk5LbSkVm95?=
 =?us-ascii?Q?A7CTh60tFvt9PmDUh/67/x6nvJ9vQgmavOiruGLrseUmWr6WcgznqBS9JA6n?=
 =?us-ascii?Q?K/asObqvUL1Fq4OvKCA5u6MQ4NQf8AVtJwYLO8eYPKS0wziHOyvh1XdrkUTm?=
 =?us-ascii?Q?WGmtA+5e0Wdov7Pw+EvZTzX6Jo2ZoaX8G5GgRlTrWCnReHIxj67Jywq1n/+c?=
 =?us-ascii?Q?Yb/U89YPlM6fjiztvHOwHTBWlDO1nPzkD+99R5fcbfIpf53Sdw7KuD/YtjTQ?=
 =?us-ascii?Q?I8ToqTBr+KaOQFFldHjdzxjQNvq4+W75MZq0Bp46vP50vjFjAsycZvDaurFV?=
 =?us-ascii?Q?uVJqqNmMA4pAJ5h+wMtSd2gK4kI5pLqQH4Gtk1Hc+/VBnaVdzaZvo2YSWf9T?=
 =?us-ascii?Q?uy8/PGuqBvHSwZAGYzdqaSh1alml/I/ZHd0B3zpUWiEV36uibcJA1jRLqsLp?=
 =?us-ascii?Q?aBq4AR1ApL2aKmKacKstCpyCMwKNypUekUs428jW4DPCcIQWN/S6uz1wYAKh?=
 =?us-ascii?Q?B/UqIB2sYzqQZBg4A621i5+RXWza9i9iy8hJmNFPgFQLE+0wAP3nGnCksecF?=
 =?us-ascii?Q?3I5zrbedXcHQ2IwoCFVDaxzpsF0MtX6U+s/mmTtl546wVvPSGmw+zFp1Ty7r?=
 =?us-ascii?Q?OubMiXbPK5fY4MgNq1agzJOpajwvsBil4y+vUim7n3+CCY9jZcty2XKDzoPF?=
 =?us-ascii?Q?3b3wjc0M+RD/15mMBVvqI0Hr17uM/zqxCBY7MP/3SRfeSVNpgZ8qNAY0a3vQ?=
 =?us-ascii?Q?Y048IhRE6uxY3315S+3GC8q2ygL6jBVFL/Os3+aUNWJUl0vckXSoj5kMYJFD?=
 =?us-ascii?Q?bKJcUcEEI+DOCfBcFhgecob3T1l9TvHUWSTEvBtYqrjc13gtgS51RL9grGN7?=
 =?us-ascii?Q?A7oeY/OF7ORhRKANwwDK+9oJVajwLum+i/TmsAzf2QNcphfPfEEEf/NkFY8P?=
 =?us-ascii?Q?K0jXevKAMlnDJwPb7SqalVN5cPO6jSneu3Hvz0XKMXBOMFIwJHg/ALhjbmfy?=
 =?us-ascii?Q?BHRefUp/sQODc3vpnPeWwRgz4D1b/d+YBfCuHsVe3stcmmdYinX12IM6gClf?=
 =?us-ascii?Q?+ciDR/YN4bTDn+sb4g35rLkcbNfQvqEtilhlgLsDWK2oBxmJ6tKEoSA9mgnP?=
 =?us-ascii?Q?5Ky87sy+daKgR28/kJ6jcS0x2WreBaIwhHAcDlE9HLxH2YGoeyN8Jhyu9Tb8?=
 =?us-ascii?Q?iqbaeVDOSXEc19Ia6CEaJscAPC8ZtHNPUjpO3iAQfNW9eNs9Ids1D5wRxN1C?=
 =?us-ascii?Q?QLi1pEi4+3bsxnM9i/Vcu5XUTr8IwNs4YvlFhPKRUIS3SXTnLTY6q4VQRxCb?=
 =?us-ascii?Q?eVBC4wnVM93GgeyUmB1CCcneCB+tzHirK2rO1soiJyfP9s9H26tJEPt8ptMw?=
 =?us-ascii?Q?bapTX9w/fQDN1qNTzbHen35sXhUXzlhSj/U/LCzQ+AcBEqWLBZgCKJOpF65F?=
 =?us-ascii?Q?FmnKKP4M66iK9Wu2LbbqfeR+V5fTRmJhq0qvf2MX9pbkfILJDr9NQP5jEKbR?=
 =?us-ascii?Q?QDaaVW7wp2tdts4aGYJDdO2p56lrSdJqq9wQQzrSk8GPa+vCLTcWk9BWZ1NY?=
 =?us-ascii?Q?wGuOywcEUhdkAXbL3W4IRl5XIaHJKiuOOF/ipK0TEi1RR3W1wqr4laQ9PsNc?=
 =?us-ascii?Q?au0PSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:57:52.0270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2ffd12-ce18-4793-508f-08de59945358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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

Extend the amdgpu_mqd structure with a new 'update_mqd' callback to support
runtime updates of MQD properties for user queues

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 11a36c132905..f997fa17e8bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -815,6 +815,8 @@ struct amdgpu_mqd {
 	unsigned mqd_size;
 	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
 			struct amdgpu_mqd_prop *p);
+	int (*update_mqd)(struct amdgpu_device *adev, void *mqd,
+			  struct amdgpu_mqd_prop *p);
 };
 
 struct amdgpu_pcie_reset_ctx {
-- 
2.49.0

