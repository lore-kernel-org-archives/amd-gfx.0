Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537CCC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 08:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED62510E70A;
	Wed, 30 Apr 2025 08:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fkmsGrN/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E83A10E70A
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 08:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCqj3WcdPLWeTEAgzlul5wAmZdg3bFfe/8GjaCfql1CgWhp8aB8EhEptjZ/YKSRG3gn/pZgk8nFKg0mP3/3jLG9N5H1An0qCEZIcTAaeDySnwlfavTDWBJoJzNKatB6mmSdXTysFat5hrFG5CtEhjSgyldjElAipMI6yS2KYZ0N1HEOJLs9mWXiq26EZ2WyJo2jrRKosJ/NVe1yJgdBP8okQ3vp6SEv2SylLyQDTYkE8AR+xnwIVy2PFPBHvXAyrYhpCOJpw1DeytnviZzBTeIGqZLBzwaBArPZk5j3SlPMJvP2Obuaw5t0CkUN+wJsv1bhYWilsW6pTqwhV8asE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STU9MIg9fSI0uDIWAwUS1YJIwi2HONkhHHOuf6Vab3U=;
 b=NBZi2/AiWFZffdkw/p2DWfZ/j15IaQaGVUgst+RMOigsKrh1FZSlNQtAkddCKpTm0oPGT6u6mmgNMt4PbLAEzALP90b0fHruwZ6E3257uAH/OtTFJ6MS1xfEDewm2hQ0NG30kyX9Va1PMoVDqrDVA262csSq4HnoNk3byTvb4KlBj4Tcp/Xj9mdKGtvIX6rCCUF+KiGezQuUpNTUsPjTpgrdcMfFCze+PxYEU6YmW3uFBPthYd7rr4v0F7hL1lTTvHUsV9hSMkAo+fYOU3C1HRdpTwF2fEH+AOapaGmT2JmPksZYKaN5pXLkqKArj6XH1mtKV09G4clDnIHnyAX9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STU9MIg9fSI0uDIWAwUS1YJIwi2HONkhHHOuf6Vab3U=;
 b=fkmsGrN/0wbEa98czSxLukG1Gl8FJCaGLUAj7mVf6jupLKj7vrhg1GDM7KDFnUhxx8gOmSzkymyyNDFeKC50NH2f4hamPLckF3Dw35eWdtM5pA5gJGA+D2a3azQrWC0UmbWKd7k1pMqjjC5SkL+bi1ocOoejJJIzmHNny/jc34E=
Received: from BY5PR17CA0068.namprd17.prod.outlook.com (2603:10b6:a03:167::45)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 08:38:47 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:167:cafe::5) by BY5PR17CA0068.outlook.office365.com
 (2603:10b6:a03:167::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 08:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 08:38:46 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 03:38:44 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: handle old RAS eeprom data in non-nps1 mode
Date: Wed, 30 Apr 2025 16:38:34 +0800
Message-ID: <20250430083834.60357-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db40b36-0ffc-4733-124f-08dd87c26c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yNTYQckPvRWfJfkNfqxC7wS/Mp8f6I/eKGF0jq2r+PTsWcl1Iva/E353ADWK?=
 =?us-ascii?Q?zEo54YHzEaCRvefFIpgCjTE6uN1bRBlfzAHqTXlcJzzeKU4O1py/0fouARKw?=
 =?us-ascii?Q?a4EluVCv3l0ZdEzd5+VfHbV985ddiOkcjzz2R9LrlTAPNjtV+bRskisjEZXA?=
 =?us-ascii?Q?6IgAwCYnCJA/CyjZsAy+VHaD5LmwEqpk4DbL3x3suiMcvn+u+Kxp0+BL4BIj?=
 =?us-ascii?Q?D7vLcRJlVymM7f97uwKGehS/s3zhlpSvKChkoXWZZ/vtQUnpHGdaYAKLXaqL?=
 =?us-ascii?Q?CFvtg91OFVYmbEGcqk2Vxi7qytRkTuFKBEjqO4PapBK9Of4on2YCOu7FmIZo?=
 =?us-ascii?Q?ZAdxiJwMEauGrG5/3Y2Rzf8AsdNK+jmrrStSkgYIkfiOaeFO1oLh0/91nyUR?=
 =?us-ascii?Q?Cn8fQ3ZXZUUWz7aodV72g7wXjvcLiPAin97ya4Yir+AFMOE3mW6BgoLoaZlG?=
 =?us-ascii?Q?jn3ofrGU9WE+Qr5qT7467jMmDyLh0BRRS0retXG0EwPDJFuafVhtncH1wBDX?=
 =?us-ascii?Q?fLg6au+KIe9YQU4lVtld6DcLb69/0wkDk36EncJ3HqvGOuXqV5CWKZqJKte0?=
 =?us-ascii?Q?NuSdmlJipRxBlpMWqUPZ27lvnTkk2qktYmmVj9l/XQLxngzOzsuC5f2MtKH2?=
 =?us-ascii?Q?pCQvMxFdL0FlRDcuCfrxKJZAIohth3icbIpkP3RoyFlcgR2d3FmomsHXaD7v?=
 =?us-ascii?Q?SLi77/N/RYrY/rHk49kvx6etY+gVoyX+pPrvcKcFSAfduJIG70Z17zs7kKPx?=
 =?us-ascii?Q?M1i8JDM0oMbBINFw17kZUxcoJaS2R8TSPsnEsploqZC7mXZeA9NJCm+q8BJ2?=
 =?us-ascii?Q?M1Bb7TgV/9SCuG0mdU/Oqyz7S5tjWq96ofnswnxaPATZeWkWXKMi0zVv02CY?=
 =?us-ascii?Q?fcxMFU9aubLqQWliJx/7ghPYtAwPpQRw9NtISW9lwHME5o4CR6TJ/QGNM3sd?=
 =?us-ascii?Q?P0oRvc/4fFNktDgbFgAIqcPmQoeQzG8iwpxi8m9jvfPlw/wyQ9u+m8zuEpv4?=
 =?us-ascii?Q?jIKKq+1ZUITcYUIEHVP5ydu7p2vSfvsF1pqP9qlpR2/e9GebiEy38e/HjXHt?=
 =?us-ascii?Q?OkjErGUmBM0Mc8kzrXBetfcVUNcICuhZRkwfPyCpTvEvAl61wXE7mw+BUo+Z?=
 =?us-ascii?Q?EKO6fxkqmiXBBozkbdCOzWKAK4E0n5J1X0d8SFFbou26HVbEdMgmVgFnYGZz?=
 =?us-ascii?Q?cnlM+H2SGqjBCU3pv6O7vilITGVPTMz+v/sH//YZ6FSkLPUbi1QTgwtJNO21?=
 =?us-ascii?Q?i3fpPQLrHSIAZuz17bEQGjHwJ/Nf94Z9IOJstC+8jD7E2/PgfTpCtBHrPe1A?=
 =?us-ascii?Q?yFdhn+Flna0nYGGVbQMxiFOQjdD3g7OU2lC7FqOU+toBu1lcSKC+Me+fOlzr?=
 =?us-ascii?Q?RQZQS7wMp0sUsnwnPBCzACdTcySPzceLsvseHz8YKE0NCqPYmOKss76M3I8e?=
 =?us-ascii?Q?d1T7F66Z9z1P3Ka70amxPte04ymqKCY/BQNKyuHk6ugw9xHQgUK/h/42zG4O?=
 =?us-ascii?Q?K7HnWzW+4iXaTgamI0fTgfgkQgF7jQYadkpl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:38:46.2900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db40b36-0ffc-4733-124f-08dd87c26c26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080
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

Get MCA address from PA in nps1, then convert MCA address to PA in specific nps
mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 ++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a5a853894ab0..a9d2e7fb3e47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2889,8 +2889,20 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 				bps->retired_page << AMDGPU_GPU_PAGE_SHIFT))
 			return -EINVAL;
 	} else {
-		if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
-			return -EINVAL;
+		if (bps->address) {
+			if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
+				return -EINVAL;
+		} else {
+			/* for specific old eeprom data, mca address is not stored,
+			 * calc it from pa
+			 */
+			if (amdgpu_umc_pa2mca(adev, bps->retired_page,
+				&(bps->address), AMDGPU_NPS1_PARTITION_MODE))
+				return -EINVAL;
+
+			if (amdgpu_ras_mca2pa(adev, bps, err_data))
+				return -EOPNOTSUPP;
+		}
 	}
 	return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
 									adev->umc.retire_unit);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 8adceeee298b..6337b6406006 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -565,3 +565,25 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+int amdgpu_umc_pa2mca(struct amdgpu_device *adev,
+		uint64_t pa, uint64_t *mca, enum amdgpu_memory_partition nps)
+{
+	struct ta_ras_query_address_input addr_in;
+	struct ta_ras_query_address_output addr_out;
+	int ret;
+
+	/* nps: the pa belongs to */
+	addr_in.pa.pa = pa | ((uint64_t)nps << 58);
+	addr_in.addr_type = TA_RAS_PA_TO_MCA;
+	ret = psp_ras_query_address(&adev->psp, &addr_in, &addr_out);
+	if (ret) {
+		dev_warn(adev->dev, "Failed to query RAS MCA address for 0x%llx", pa);
+
+		return ret;
+	}
+
+	*mca = addr_out.ma.err_addr;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 78a8b8654573..d6929d6f64f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -187,4 +187,6 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 			uint64_t err_addr, uint32_t ch, uint32_t umc,
 			uint32_t node, uint32_t socket,
 			struct ta_ras_query_address_output *addr_out, bool dump_addr);
+int amdgpu_umc_pa2mca(struct amdgpu_device *adev,
+		uint64_t pa, uint64_t *mca, enum amdgpu_memory_partition nps);
 #endif
-- 
2.34.1

