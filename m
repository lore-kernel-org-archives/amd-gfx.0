Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23087D591D3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9753D10E5D0;
	Tue, 19 Nov 2024 06:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w3b9ji9n";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3984E10E5CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMkmNvyKlM6OrWhOmgtUY+Nse1NCOhcQDqJn06WX/TSinOjbG5MxiplFClXZe4IV2t2inG2y68nZDs6xfA56o+WFvpeCRlOl1w/pbQ8stem0hGaoseI5GRLTR1XY/lp7aS4IWJo3c3WpVS+6WyIIoz1V1EkDcmSPN6rJ91oarah7ycrsr8xcdqz4ZdC6bG1Kd3UhRHSYhPDUdLEW3oph13VzEutMO5EFhP6wTaixNEN3qvpb+7HJfHThuzoeLfm9SJe/NJnz7FHGstF4W7jq/AioLHJV5o/ZoPy5fWN9ObvrRc0huHyvQF6njq7TnttTol4Z8RDoTICpdXAcCVpqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpnC1K3i+1JvTYOgeE5ZCq6LcZgzTrjd8cWlznd6FA4=;
 b=Vvs0A+DKxinbMC3CepDV42ogR0+zLvuFKQoF5ZBONIY/YwrjYJrTTC7YTWLhnSbC9uNBWN8ZsYnBoGIILiOoq1L9C1PWO5i3Hc6xkEtCY6ayjFlZHHJwq9t67OAajm8LJglIW0IekflcTjAhL+CLFtpJB0OlaCzqCTkkYfoMtcObNFN9VKs6i+p4+dYCSk81FyCEnAqzu66i1Z9zR70BZqkScwJRZIo1h/he153FXXu8l72nz+VI8ty02lAsuFS4x9II1Y24nTGiWt7b6kFzRQT7eqWaOYTO1RdeFeXgljl2VS2p7Dquly2a2A73GWRgHK/fGdowf62//B+Fmv0D3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpnC1K3i+1JvTYOgeE5ZCq6LcZgzTrjd8cWlznd6FA4=;
 b=w3b9ji9nzifciFvnwlWt5O5xYtm3OFxzambmNZKZaM5NeXVAz6rP1V8jwyhsC6nrpLpzyRgaOdMb7f2EYGb7D7b7lEO2keWyItQ5QTUTCf7QjoiSBbgsOCPps3wXCVg/Hqi5kHsTOW+aGJtyWVvMSOYAzVd4UgTpPyvERspBozs=
Received: from MW4PR03CA0048.namprd03.prod.outlook.com (2603:10b6:303:8e::23)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 06:36:41 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::db) by MW4PR03CA0048.outlook.office365.com
 (2603:10b6:303:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:41 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:38 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 14/21] drm/amdgpu: save UMC global channel index to eeprom
Date: Tue, 19 Nov 2024 14:35:57 +0800
Message-ID: <20241119063604.81461-14-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: b50cc6bf-4e3c-416b-c9d5-08dd08648732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k/UfbgRB5X9WCmfqx4dzLtziY14xr2w0iTB7f526urH0oo6un/ilTb6pWQH9?=
 =?us-ascii?Q?5n90kdILM4Kq0PqdTEBLpHyOMXXWUGknSC6qXwgSFTwpiBdwS7+0f5PZ7ei+?=
 =?us-ascii?Q?mVA1Jfncnr/4n86+pz7i1xx4Aybajm0/x+i6IrXnGLSsR/Bl0rHul3KxRPEs?=
 =?us-ascii?Q?fxlsD04+pwsi9QqY/lf7nPTwvVeoru+eQNnaTOIO1UeVwq5GqbqmE/GxCa62?=
 =?us-ascii?Q?zUQ9tetYnsKWSBGD3k/fG5oLIsY2vXOPsKYXXb1YAhrWCvuNe1fBYWWvxz6D?=
 =?us-ascii?Q?kEE0xOAwfX8PwhgFJRTKfaMFpp9Immh8Zo3Ye68R3XSqqI3CRzuySJ2EufsB?=
 =?us-ascii?Q?DdASp+k+0eJt801mdaMJwFNb4Uh6hG5aR2awKzOTGHXJoSMmxOryzsEF6apt?=
 =?us-ascii?Q?X06yDBvfn2gGbd18rxGPlXi6tHSNimgdbM8vxwB1zAMfq7x7foUzSLQScZh3?=
 =?us-ascii?Q?7lUubkh7PpRXXDznCAOVxzKnNV4sPTfh+v54HiwDa+4EcTkkELl2Va6j76hu?=
 =?us-ascii?Q?Cy2scqCHbNyAwWBmvIl989GFlZO1G2HdNyE/rn1B76DDgykkz8Szyj48HwaV?=
 =?us-ascii?Q?oJCWxzWdUfbL/YgHbnVG8cBYFfBCgDMJxIr6WJL9X7OZ6JLm685QH/hiUQ5H?=
 =?us-ascii?Q?pwQVtw3kPkBKs/OAuS2FNDf7SL7XRryHDrNqTC8HEDaN3ZkMXMcK4VoSxk0Q?=
 =?us-ascii?Q?UPtuRhf92cDm8zZvrSGJVx+VL0lp5l54n4x011ZuoxnWS7wDA0mqXLs5ij5C?=
 =?us-ascii?Q?dWFqgg+j8Zk/UdGxfl+258PDQL4nYhhdnKREU6H4M7RyztKr5GhvVwa9KoHN?=
 =?us-ascii?Q?5mx1wjLBnWBKI1MKX/zsmEZXk3ev2vk8P2MtUJ1zY6KXvD69wfFmmiwiSh2z?=
 =?us-ascii?Q?zz1YkH/w5iUOKOK5rWnRiMSM0sadMdSDqm25zv+qHWjvbur+aZj4v44/fPzV?=
 =?us-ascii?Q?d44mUXZ51eao9vAdYC0OtJQa4Oxx2c226sXoT95HOTkP/Mbei+w1WMCagdjV?=
 =?us-ascii?Q?Q40kd3/JYxub42KHs9CRHB+EuI0SqGbIWJxu7STSgOQzrkeQ3rF9Nq9Fyopw?=
 =?us-ascii?Q?vjRML6oFHm1+oCliz4EjdqDBt+ybNW61xzK2M00EYgHDi26Z2Za7Vnjn1HaM?=
 =?us-ascii?Q?JPRTfSF7XcgfRZRTYWi7Bap2Z26gtzG7gdSGedhPt0Jpok9TI3Vn34svdgAU?=
 =?us-ascii?Q?r1cNDXrIny1mn+HukAAor7RTxZ/MbMBu9lBBRMPrJ1ZIlOnmYAFCb1VtLT/E?=
 =?us-ascii?Q?cFyf2BlK/elp/5UPp38wJ8TWIVQ99sdy7fG82Q3ZuBo2R3eFsXsx49V7HqQ1?=
 =?us-ascii?Q?qlXT0P4JrcRzi3HrQTTnDtLnsrwZNUgGk6r54z1CKAYVAeiPfuIBPyqNQvWZ?=
 =?us-ascii?Q?Wtv39p4a2nAIglJzAnoaTC1glT/na+c1hNItO9qvrpjEFXKBRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:41.2607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b50cc6bf-4e3c-416b-c9d5-08dd08648732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
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

Save the global channel index returned by RAS TA to eeprom.
We can get memory physical address by MCA address and channel index.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 13 ++++++++-----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 871b2d6278e0..252e360c6416 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -481,6 +481,8 @@ struct ras_ecc_err {
 	uint64_t ipid;
 	uint64_t addr;
 	uint64_t pa_pfn;
+	/* save global channel index across all UMC instances */
+	uint32_t channel_idx;
 	struct ras_err_pages err_pages;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 11f7299f773f..17659fa4450a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -498,10 +498,9 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 			uint64_t err_addr, uint32_t ch, uint32_t umc,
 			uint32_t node, uint32_t socket,
-			uint64_t *addr, bool dump_addr)
+			struct ta_ras_query_address_output *addr_out, bool dump_addr)
 {
 	struct ta_ras_query_address_input addr_in;
-	struct ta_ras_query_address_output addr_out;
 	int ret;
 
 	memset(&addr_in, 0, sizeof(addr_in));
@@ -513,14 +512,12 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 
 	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
 		ret = adev->umc.ras->convert_ras_err_addr(adev, NULL, &addr_in,
-				&addr_out, dump_addr);
+				addr_out, dump_addr);
 		if (ret)
 			return ret;
 	} else {
 		return 0;
 	}
 
-	*addr = addr_out.pa.pa;
-
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index ce1e4fb385b5..2f71194d5da8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -146,5 +146,5 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 			uint64_t err_addr, uint32_t ch, uint32_t umc,
 			uint32_t node, uint32_t socket,
-			uint64_t *addr, bool dump_addr);
+			struct ta_ras_query_address_output *addr_out, bool dump_addr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 17ef9a6743f5..cce93b4ffb58 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -180,7 +180,7 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					bool dump_addr)
 {
 	uint32_t col, col_lower, row, row_lower, bank;
-	uint32_t channel_index, umc_inst = 0;
+	uint32_t channel_index = 0, umc_inst = 0;
 	uint32_t i, loop_bits[UMC_V12_0_RETIRE_LOOP_BITS];
 	uint64_t soc_pa, column, err_addr;
 	struct ta_ras_query_address_output addr_out_tmp;
@@ -193,7 +193,7 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	else
 		paddr_out = addr_out;
 
-	err_addr = bank = channel_index = 0;
+	err_addr = bank = 0;
 	if (addr_in) {
 		err_addr = addr_in->ma.err_addr;
 		addr_in->addr_type = TA_RAS_MCA_TO_PA;
@@ -206,7 +206,6 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 		}
 
 		bank = paddr_out->pa.bank;
-		channel_index = paddr_out->pa.channel_idx;
 		/* no need to care about umc inst if addr_in is NULL */
 		umc_inst = addr_in->ma.umc_inst;
 	}
@@ -228,6 +227,7 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	}
 
 	soc_pa = paddr_out->pa.pa;
+	channel_index = paddr_out->pa.channel_idx;
 	/* clear loop bits in soc physical address */
 	for (i = 0; i < UMC_V12_0_RETIRE_LOOP_BITS; i++)
 		soc_pa &= ~BIT_ULL(loop_bits[i]);
@@ -466,6 +466,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
 	uint64_t err_addr, pa_addr = 0;
 	struct ras_ecc_err *ecc_err;
+	struct ta_ras_query_address_output addr_out;
 	int count, ret, i;
 
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
@@ -495,7 +496,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	ret = amdgpu_umc_mca_to_addr(adev,
 			err_addr, MCA_IPID_2_UMC_CH(ipid),
 			MCA_IPID_2_UMC_INST(ipid), MCA_IPID_2_DIE_ID(ipid),
-			MCA_IPID_2_SOCKET_ID(ipid), &pa_addr, true);
+			MCA_IPID_2_SOCKET_ID(ipid), &addr_out, true);
 	if (ret)
 		return ret;
 
@@ -503,10 +504,12 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	if (!ecc_err)
 		return -ENOMEM;
 
+	pa_addr = addr_out.pa.pa;
 	ecc_err->status = status;
 	ecc_err->ipid = ipid;
 	ecc_err->addr = addr;
 	ecc_err->pa_pfn = pa_addr >> AMDGPU_GPU_PAGE_SHIFT;
+	ecc_err->channel_idx = addr_out.pa.channel_idx;
 
 	/* If converted pa_pfn is 0, use pa C4 pfn. */
 	if (!ecc_err->pa_pfn)
@@ -577,7 +580,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
 		ret = amdgpu_umc_fill_error_record(err_data,
 				ecc_err->addr,
 				page_pfn[i] << AMDGPU_GPU_PAGE_SHIFT,
-				MCA_IPID_2_UMC_CH(ecc_err->ipid),
+				ecc_err->channel_idx,
 				MCA_IPID_2_UMC_INST(ecc_err->ipid));
 		if (ret)
 			break;
-- 
2.34.1

