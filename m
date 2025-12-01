Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87579D116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 23:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF2110E4CA;
	Mon,  1 Dec 2025 23:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l7FbEe3i";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D17410E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 23:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/S7iIvYZ1N1MO0spjnhsErXRh2SZIeAqYWvef0TQWVOoMO+yiLyDuPoEtZ5RrdDTtp4cOs083XVoKgXc9eHne6ToSD84IM6qbHqsdYU1gg3ha+Glx/+5NgOV+bv5PIsBvrUR/dhwgBhry6TPGOhrjgKuKbRVmlGZXIWVSjoh8yt6QO4L/rAlGaQToRLFkfbYdgHYbgllMMYy83EUe7+S59ESJZ3NUJ+IZWyTjLhWNYtBbKcc2O/7aKXBXjUHU/VxHOuuPC9CLr8n0Nzj+e26yZmO6T0Xr0Hf2y23+PiIrymfmBBr6p+yCoBfSCUMM/i6nxfVqt3wepwj+6U6fFzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLLlQ7c827+bNBA+1DAtNvTp4zxdckeiclKhyycpHWg=;
 b=hcyWuxH4vv9beaiWAAx52Mv7AaZ0aw/Z8ciixzWq1M9+h+xEfcNFccHf0+oCbzluoDlU31prxt0QoQTiB0TBUOJsnWB3mzd0nPAcIQL+Kdcxd1ccAbTraG7QUKa4fznD2Vcij3buF8xUGJ0DAdxkb8mG+erddDnJPWsHjvE2c8ji6FypHXrLmDgDvWgb7Pd2jvPVe+BBUqg9Qdy+5V0W1HPAnqsiiUFylKwNfe74JPCyZ6yPl75bA9cO+yTN6ueuy5TgrxYw406rMZU9n9dsJMD/HYalarAEdp4AyMM0lQJFIZjIFgVbbZ2pBKP3VeyRPykzTKEKEuAzIlHDoZPnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLLlQ7c827+bNBA+1DAtNvTp4zxdckeiclKhyycpHWg=;
 b=l7FbEe3iNwAovkt/SaHaALhxzJVx9w0YLRqoB/HJYkGUr+9VUBHMrKVZ3HTnY7MyWj25CjRUUyQ9yKVhnq4A788Q04MYKDniP7RmbOagw4Du76dyoilV3wGmAJUALiA4cOsiphWBvOBn2o1+UpFaLaw+JA8qdcEu1sdinEtQrJ4=
Received: from SA1P222CA0041.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::15)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:15:29 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::b4) by SA1P222CA0041.outlook.office365.com
 (2603:10b6:806:2d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 23:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 23:15:28 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 17:15:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: set gfxhub according xcc_mask for gfx 12_1
Date: Mon, 1 Dec 2025 18:15:06 -0500
Message-ID: <20251201231509.791954-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251201231509.791954-1-alexander.deucher@amd.com>
References: <20251201231509.791954-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e59ea93-9064-442e-d83f-08de312f847c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gdy43KaCBjX2C/E22NkO5+Ri1kxaBFMNZ0aTINCOt/5ZiymEq47AGVnllijC?=
 =?us-ascii?Q?NnoB1+OwfBFPjBzaHRSstgCGZ15Q42/2xeBYJg74Xdt7iFBp35ElyzmIWp0m?=
 =?us-ascii?Q?nShWW/3RcHcVa6vMP4Vc5ParhsUKX9Vq2b1JfPQm8Lev402cdF+V6kO5b6LS?=
 =?us-ascii?Q?81EHwzsKzN8Ip/L4VsAFmc5j9204OIKYuT0l+kd2W0vHIyC7MCoXDL9ueH+7?=
 =?us-ascii?Q?aRwRSt+2KYcUiBAvZkkj114sjNIB5c42XxqYIduCKbpDbyzMqUGVof/m5J2F?=
 =?us-ascii?Q?LEmgRbtDDcPahhseMWUpmpgHsmlQSqa2d2F4+Ph9Zv4HgIvxukFC7OlVUUKw?=
 =?us-ascii?Q?/2zgq3d6n2pUJoUAPxwI5FneffnwLJjDSZKJ4YttAN8rcg7uJWKk9WLiPH6n?=
 =?us-ascii?Q?QVf7xmP9l2sIvW84x1gEP8Z5xCAThHVH960D8OoAqnRehe4QPlacF2pgRXQc?=
 =?us-ascii?Q?hr+qwY/yeQirnv2lN/PdbPN6li5Pt3CJaqiTHaDo+yOXvBMiYY5KMH7K/DSY?=
 =?us-ascii?Q?xWUfSvxLC/ICVVCFMp9wdTCTlDlyOdxZrA+dOupW9LKEMsTbTG9K53PKagLW?=
 =?us-ascii?Q?CtwgCWM1Ua0rz7WSXvPnSdPuv+wQEJnpe7pwQL9QAgkdhTRXG5h7KQeWQ0N1?=
 =?us-ascii?Q?sSksfKnv6RTDcl4r1MW/meF6VmOkqnemHxnSmoymekLnzkCklgTrxrO6E1Tz?=
 =?us-ascii?Q?lLFuHjJBY7ssbYdzh0r0K9r/cb/VTV8LmG/Uf517glVym6gJNerFt+FHZWph?=
 =?us-ascii?Q?QXYUAsw3yfj1cAu45jVxOZ4aB5lrkKHitnzb9Xhp3PIr/LeYGlVRbXvc+Dj1?=
 =?us-ascii?Q?Tx1BW3nQZFZWa8/rwWKvEDbRGSiaE7n4WpOoxuVAfoFk5cQyTRyXwRu7gVu6?=
 =?us-ascii?Q?x1vzXkwKs8qwvLr7lqs4x/hecPu1cav7qgNY4uN0tTi3Iws1T9pZVmoY4VM/?=
 =?us-ascii?Q?tP+QVi0+Q9zRSJM3eKnt1u/MabsY0EqkWBa+lzlCwcRzLkU/DkW/SQcC8i2k?=
 =?us-ascii?Q?5L1bvqG908RfIWzu0gFTy0tPWDWFzjyJ1J9TR3Vwwip11LeVF2dN5et3jXqS?=
 =?us-ascii?Q?j69HiXtjkBoVYICp0Xo2Ui+SEdaiT2YzJMyeG3kV++d803NUIxT2yJckQoFl?=
 =?us-ascii?Q?40opd8YAaBkfi7/vmZLmdeVn2pcMKD89fwJeXjCcR8TAAG308rssZiDlXYLU?=
 =?us-ascii?Q?6UK/eFAPd1vNbncUqizMLxliTMnVQjdH4btBJRopDgnUiQDkU663pFDcl/L5?=
 =?us-ascii?Q?V88FZDs0oTijUict0MkAYr9/X5vAM2W6pOieYpcFZHx98til4OlWKRQgsopj?=
 =?us-ascii?Q?ZMSCpXgtbLqsSYOTDA1yLs1sMlj9XJ1Dl94Ucfnza7bcHY/ZIrRBaZNP+E/M?=
 =?us-ascii?Q?xEsj/foWgNNU3blRjUiRz8dPc71+tubZucYlt6Xlvak/sZRcsvGwx4KFzreC?=
 =?us-ascii?Q?9/gr370c2sCJl1DKpc5crKWxWgKADGOGBW3ucfdb1/Gb7ut0k/mydligTKSS?=
 =?us-ascii?Q?AlzLE5nGRnQojyGEIO9yDQV5kwA5weHAiox5iAZpdsvcJ7oI7DIeHrGDQvMu?=
 =?us-ascii?Q?HLxKeD7Aa4yh9v65V+g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 23:15:28.8797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e59ea93-9064-442e-d83f-08de312f847c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
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

From: Likun Gao <Likun.Gao@amd.com>

Set GFXHUB accodring to xcc_mask for gfx version 12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index dfb06baea1ff1..74bbb683cd0f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -805,7 +805,6 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
-	case IP_VERSION(12, 1, 0):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
@@ -815,6 +814,17 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		 */
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
 		break;
+	case IP_VERSION(12, 1, 0):
+		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
+				NUM_XCC(adev->gfx.xcc_mask));
+		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
+		/*
+		 * To fulfill 4-level page support,
+		 * vm size is 256TB (48bit), maximum size,
+		 * block size 512 (9bit)
+		 */
+		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+		break;
 	default:
 		break;
 	}
-- 
2.51.1

