Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2339DC47DDF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 11:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90325112F66;
	Tue, 30 Jan 2024 11:09:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AD1112F66
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 11:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccSRVXbmVg8Q6CkQ0qGFLnoTwILmqNPCUfG9eEIKapkZsv+HNv9YFRJBREVBPWFLGDYcyV4GwPh2paHvJsVgWW//9G8eslo3A7+o3hAG9GxijEPsAYdlPHMcQG4lCQT/5p6Qpdpp1/+QVFD6ugTSnnkj5+Asdjv5bqN9TSkPtb7Il6Tgw/Ocg/VELTMnU4Rqt7smbAO3ef4oTizqYp0GQFdLt639n0C1J5LfZRG3PlszFzXtMhuJuH3le9ACsmD4MztplPdFoneF4i9FmVPIB0LXnyd4DaNaPzDb6M1DagMzuGUTnDt6WsWQDfrgP71+uNZAe8rVZ2j/c2sLDK+M8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hFABjpxUIqZos6FvhbyLgP+oZsLsfVMf4/cYyIfqkA=;
 b=d/JFdJIXXMFv196JK0T1HpewaiIufqZgq2/iuY+bTNJTN4UBYyXTbvG8VyQdm7lRMvVsl6vALJkPE9TLnGVZZt4nD1HNXkOU8c7aQ+qKjWhqIKzFUnpBfTwLZtvuAzvmtGPom+bEc61AkmQid9fS0XTb1UjZCL7OBiukeUrw+6TjUBFdyy2ow8VtQm/ANoYtwSOR5J1aNs4VL3Z5tvgHCHr3t98SqqYA2ya4ZT7NSrKh204QqRbNBPfyqwFLdR+Cnr7PTS2knlFlcP2cbtdbXWEQjp4wb44XA5HFMGDT5HAqhYkJ3LFO3T8ZdHuCcBGkDPrscu8pYdd0NgjxL2UzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hFABjpxUIqZos6FvhbyLgP+oZsLsfVMf4/cYyIfqkA=;
 b=kA0P3MmIr6G+t9IHI8kLfKMS/xx9oX5f8UwK4GSnPsDSd/q1yT9Jmoa/p+8sQCOHt/OfM7+7VgvEXV89EeWmUZzLeh+WzJtIcdng45lbGm2iNKBSK0x5SOVs6yw/dL59jS7o/1E3TGgbyX8nhoWck6gHeDhnmUBEPdte7esrDIM=
Received: from MN2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:208:23c::29)
 by SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 11:09:26 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::a0) by MN2PR18CA0024.outlook.office365.com
 (2603:10b6:208:23c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 11:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 11:09:25 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 05:09:24 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] use PSP address query command
Date: Tue, 30 Jan 2024 19:09:14 +0800
Message-ID: <20240130110914.295366-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130110914.295366-1-tao.zhou1@amd.com>
References: <20240130110914.295366-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ0PR12MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 895fcd59-9f76-480f-f1d3-08dc2183ebb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHOGCFv+yhmCGs1QEnk/+CK9dPcRsjIJ2JR/5M41VxWRvQA+vcseXsTSOf9y8NIE3RoEjJC4etDRcPzM9EU3LZyjAVciznK7JXqC4sAomI4yk0oHpchkKFLwfyPkA5zc+VNv1hFb5C8I6OMGrE5u++WYQ+clhZUJzNnEcUbqGmfVzHeeQ2PUC4M134hwlAW9FzFB4ca0GAatt+cNJrTjxzAn5v9I7iarAFaR3K/cBrFxM1AX9im60InAEZ0eR/Vbb5BEyBnzv2mTBTGP3U+O59vpBz7bf9eFbF5a7ckZzvTJMiLHF5nc447CHpkYK+vOn3foChDBTdtfdWgqmadX28q9PthQC1c6VxUqq113lbbB5E9oc2eKpAw1UdYzt0Vhhw5FxnPdRZ7MypfomLN86Bbi1xbke7NSGC3it0jbQQSd+kmjqQg0ll4HW0HNbg6Td64NqEzz2rdTgnTc9OzbzDrH8CnuMSVRssPQ5LU8QbyNFRcGaVUDn7pcCT+rtVoypXawXrA7AuhTHAQBoT7sWiCtb8HGZ9SL6QeyAER+xctMZGqK3Qnp/0V/Zn9eXXxczVfkyO/N/Y+shAENsGzTCLGP9fMUhxw+35St8WuPtVlUH1bvL7MiMH9dFXfitzFdvq3XsKtf0WB64A2RE7GRdfW3L9cPOFPZFUelZGDRYQZOUt26sm92aUCvLyB5c110/m0sXWhS4tQKAyo4gxFqgqSWzDzjN5pqbuPhBpM9jTLGkbmGgCldYwdPeHNTTFQzCUiQR2Ueqrv3Y/6tdeEIfpuZD/jJC8N+DR6HuKV9Iug=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(26005)(8936002)(8676002)(4326008)(2906002)(5660300002)(86362001)(70206006)(316002)(70586007)(6916009)(478600001)(36860700001)(36756003)(47076005)(82740400003)(81166007)(356005)(7696005)(6666004)(83380400001)(16526019)(2616005)(1076003)(336012)(426003)(41300700001)(40460700003)(40480700001)(36900700001)(358055004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:09:25.8170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895fcd59-9f76-480f-f1d3-08dc2183ebb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Get UMC physical address from PSP in RAS error address coversion.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 46 ++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 836a4cc1134e..14ef7a24be7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -203,14 +203,14 @@ static bool umc_v12_0_bit_wise_xor(uint32_t val)
 	return result;
 }
 
-static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
-					    struct ras_err_data *err_data, uint64_t err_addr,
-					    uint32_t ch_inst, uint32_t umc_inst,
-					    uint32_t node_inst)
+static void umc_v12_0_mca_addr_to_pa(struct amdgpu_device *adev,
+					uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst,
+					uint32_t node_inst,
+					struct ta_ras_query_address_output *addr_out)
 {
 	uint32_t channel_index, i;
-	uint64_t soc_pa, na, retired_page, column;
-	uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row, row_xor;
+	uint64_t na, soc_pa;
+	uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row;
 	uint32_t bank0, bank1, bank2, bank3, bank;
 
 	bank_hash0 = (err_addr >> UMC_V12_0_MCA_B0_BIT) & 0x1ULL;
@@ -260,12 +260,44 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	/* the umc channel bits are not original values, they are hashed */
 	UMC_V12_0_SET_CHANNEL_HASH(channel_index, soc_pa);
 
+	addr_out->pa.pa = soc_pa;
+	addr_out->pa.bank = bank;
+	addr_out->pa.channel_idx = channel_index;
+}
+
+static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
+					    struct ras_err_data *err_data, uint64_t err_addr,
+					    uint32_t ch_inst, uint32_t umc_inst,
+					    uint32_t node_inst)
+{
+	uint32_t col, row, row_xor, bank, channel_index;
+	uint64_t soc_pa, retired_page, column;
+	struct ta_ras_query_address_input addr_in;
+	struct ta_ras_query_address_output addr_out;
+
+	addr_in.addr_type = TA_RAS_MCA_TO_PA;
+	addr_in.ma.err_addr = err_addr;
+	addr_in.ma.ch_inst = ch_inst;
+	addr_in.ma.umc_inst = umc_inst;
+	addr_in.ma.node_inst = node_inst;
+
+	if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out))
+		/* fallback to old path if fail to get pa from psp */
+		umc_v12_0_mca_addr_to_pa(adev, err_addr, ch_inst, umc_inst,
+				node_inst, &addr_out);
+
+	soc_pa = addr_out.pa.pa;
+	bank = addr_out.pa.bank;
+	channel_index = addr_out.pa.channel_idx;
+
+	col = (err_addr >> 1) & 0x1fULL;
+	row = (err_addr >> 10) & 0x3fffULL;
+	row_xor = row ^ (0x1ULL << 13);
 	/* clear [C3 C2] in soc physical address */
 	soc_pa &= ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
 	/* clear [C4] in soc physical address */
 	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
 
-	row_xor = row ^ (0x1ULL << 13);
 	/* loop for all possibilities of [C4 C3 C2] */
 	for (column = 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
 		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
-- 
2.34.1

