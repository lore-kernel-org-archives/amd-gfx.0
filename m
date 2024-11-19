Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E27D591CC
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C44C10E5C3;
	Tue, 19 Nov 2024 06:36:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WjXlV2D8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9706310E5C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGQISU22ZpcQDUuaVUiRHB3cQBWlT84i65l3oUW6iZbbQq3d7ycpjWFueMeW4yRgj5vD/r/lBSi0dNRVB6ckdn7seXJYgkfktD1X02YS+plduNQ0PGaQTRm0nDi66MR+NZxTmBkFZ/hd5I7et84Hpgfa0yFhsnlSOKH2OPnRYZViswBV+5CB6o8j6YTgH6ucHT3e1BcJnPRbDv8DMOBjzUvLMcxSeGiVg7xLJi43OM37oKoexmw0vFCBiz7+IbSO8nm3EJpKFBeiJs8gyj1Sl5EcxjG9nG1K1IwIo8GntgYabIjA3kDgAYtEulc+jyn1D1NBTXBk8fEihZeXYv090g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsfLa+2H9g9iORKqXpXtnYbzWmxlHa40DMVKCKltsjE=;
 b=aoz+gmBspth4q5goa3awIJ6htmoI8BFfJ1alhs8uxbZ3B5kO1CkeewWcVdh+xz29Kzj601x6sngjfoeusktlAow0ftC9grZLTR3hgMw6C5XGmXskRejZ1Xzzp0D29HYbH/U7N4xIP8cYvwHVdzbQt5yLdQtBS2TZQAft1Lt5CKCn/889xZ75d4wCvgkywoUi3AIQqXl+U4aW1m++CjXwMMssU8vr49dQrS8kuwPF0NYq39n4MTCTY8bOYHXYiop3yI4SXqofqHPdt71ZBt/7d78vCqe52Od4a+sVfGqHmvQMOlWXMest2PqfK9+fTi1c/1k1P4trVJIFAR4SXbcUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsfLa+2H9g9iORKqXpXtnYbzWmxlHa40DMVKCKltsjE=;
 b=WjXlV2D8jzCjn9u7I2HGC5FEq/RizkYtsjlm01RQpECLfnG2LXqUVuXQnNd13X2xkrrLKYDidm1XJTQz2KfoRww2U+1dXSEpyxAGjRPU2AO8FDVPKxeNKLW467zSgLF70Rf+VQLUEA72BCTIhGFLo/DGQxRAZ5xg6D+w+fruvgQ=
Received: from MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23)
 by SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 06:36:25 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::6f) by MW4PR04CA0078.outlook.office365.com
 (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:24 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:23 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 02/21] drm/amdgpu: remove redundant RAS error address
 coversion code
Date: Tue, 19 Nov 2024 14:35:45 +0800
Message-ID: <20241119063604.81461-2-tao.zhou1@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f1c696-6ae8-4225-5f27-08dd08647d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/38++j72MzjgAR7+vAdXKp7nB7wxK7CPury5h1Vm6B13LoprK8ScBjacLGMi?=
 =?us-ascii?Q?y+viTLY7rruWmwvFUck5lrQAHIKBplJBcaTW7JRNEwgo/zrizzKtVCy1HHBP?=
 =?us-ascii?Q?F2eCqUoe91IXtxzBHhjrs0oTX55NT//0p5VM3yQZzi1eczR16Ho9Zc2CT2WH?=
 =?us-ascii?Q?rseuLb0qTWiFLrDs8z0NNTDf4vxAOGJrg2ULlasEOck7uIjww7BKUqosJD/C?=
 =?us-ascii?Q?skga9nu0ue9V3creEAHoMP96Q5ae+38PB4/UM8bGFl2M+nyPzUD4NMV1thiz?=
 =?us-ascii?Q?+zEwAgvQkp2OL4zhNuDliqN3QJ02auXM79ldENzNhUE94I4tBldncdfoJgQP?=
 =?us-ascii?Q?DdG4H+Lf0haXxqMjfXOyUwGceH158tVG7QbjQBqNEUCc5floKjxl8dy3wFwd?=
 =?us-ascii?Q?whKgM0bZnIVc/RKpeTrzzLRS4Jt1n5anItsmYa0vwRigMB0dltlSErluEQAO?=
 =?us-ascii?Q?Auwc8VjsogwBwAZDBH/LZH3ijSs54b2jk8vEUenmCJOczcifwrVxOdjQ9tgi?=
 =?us-ascii?Q?UGBPv+uRyUrwtVKNujRTwSizoHXQKmXDtv0AE1x1oHbfx0n+oGUOJy+ueQXq?=
 =?us-ascii?Q?fwzqa/n8qAvy42wRonD5suaTOzRuKaae4dv7jLF4KdsXGt3kHDQXh/KN9QDZ?=
 =?us-ascii?Q?2ojrz3Jhp3Fndnw9RC3TQdqudVfp+v7tA4SmOar+QfSQFw7qKBIphsQnzshd?=
 =?us-ascii?Q?YOznsYtpFyNcGkNfKb+N2CPSSImEXXbVCqgo15iBhDvTfx/VNWiAbqSljUcF?=
 =?us-ascii?Q?CQ9suloIHM4rr95T21BODTc7Iz4pMwNpdUUL5uxqlsNOyrEQ7Xsokgk1nqXa?=
 =?us-ascii?Q?Kt7COj6QGjOZ8e6zdjL0BPsWTh1PkwQUnm/MVZa3Q/zgORqjUzJUeMNT5J68?=
 =?us-ascii?Q?eHrC15Y8WXm/oRiyVwoypQXQKeIw4SU3+Q3Q9lJ/zG573dVcfuctvf3Ytqms?=
 =?us-ascii?Q?3Z8XpJbJ7oVBKSaNfd0gdV6XIFLNc5k8+woJJUXBEOR2/fHzDsRhxCvi3QGj?=
 =?us-ascii?Q?Bb0iIBh6WrgiZnCG95Q7akhTEkT3ahC/4DOQne/cwhwK+elBh42Z8IxnpslF?=
 =?us-ascii?Q?WenX5N5kW0OM5b8VyuBSJ8sQ/w7swpKPwtGeGD+f2HPQToHk7NfYWOC8/+yi?=
 =?us-ascii?Q?qgJ6hxgsPijTbdV3WYPXLtZtrhbf8l2BOVO4v9LmVDpDz6ldWzA6/DJ7Tq3C?=
 =?us-ascii?Q?gssdsdUkDrJm5erjLY2BKgkq3GZ1eflz1LG7ZgplCsRkt42Ow5zVv7BdRTBs?=
 =?us-ascii?Q?MiM7nJ9WZjk1J30fQLVxk1UlP3RJi0QbT/AUYnwnWKf2lOGKGcv6pK+EnbXI?=
 =?us-ascii?Q?/dJF+DBqggDt//y6OS5zBYjhWlDw/AVDGfPMYEwklLg89Vlq1GES9LaIheCX?=
 =?us-ascii?Q?BB8+4XBQSTpwPIgc/WsYHCWIJDotckjUBMMl0knTrH3UNXQR1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:24.8851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f1c696-6ae8-4225-5f27-08dd08647d7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
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

Only one interface is responsible for the conversion.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 136 +++++++++++--------------
 1 file changed, 59 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 8939b4f1fb49..a030fed16c5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -175,62 +175,41 @@ static void umc_v12_0_query_ras_error_count(struct amdgpu_device *adev,
 
 static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ras_err_data *err_data,
-					struct ta_ras_query_address_input *addr_in)
+					struct ta_ras_query_address_input *addr_in,
+					struct ta_ras_query_address_output *addr_out,
+					bool dump_addr)
 {
-	uint32_t col, row, bank, channel_index;
+	uint32_t col, row, bank, channel_index, umc_inst = 0;
 	uint64_t soc_pa, retired_page, column, err_addr;
-	struct ta_ras_query_address_output addr_out;
-
-	err_addr = addr_in->ma.err_addr;
-	addr_in->addr_type = TA_RAS_MCA_TO_PA;
-	if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
-		dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
-			err_addr);
-
-		return;
-	}
-
-	soc_pa = addr_out.pa.pa;
-	bank = addr_out.pa.bank;
-	channel_index = addr_out.pa.channel_idx;
+	struct ta_ras_query_address_output addr_out_tmp;
+	struct ta_ras_query_address_output *paddr_out;
 
-	col = (err_addr >> 1) & 0x1fULL;
-	/* clear [C3 C2] in soc physical address */
-	soc_pa &= ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
-	/* clear [C4] in soc physical address */
-	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
-	/* clear [R13] in soc physical address */
-	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_R13_BIT);
+	if (!addr_out)
+		paddr_out = &addr_out_tmp;
+	else
+		paddr_out = addr_out;
 
-	/* loop for all possibilities of [R13 C4 C3 C2] */
-	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
-		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
-		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
-		retired_page |= (((column & 0x8) >> 3) << UMC_V12_0_PA_R13_BIT);
+	err_addr = bank = channel_index = 0;
+	if (addr_in) {
+		err_addr = addr_in->ma.err_addr;
+		addr_in->addr_type = TA_RAS_MCA_TO_PA;
+		if (psp_ras_query_address(&adev->psp, addr_in, paddr_out)) {
+			dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
+				err_addr);
 
-		/* include column bit 0 and 1 */
-		col &= 0x3;
-		col |= (column << 2);
-		row = (retired_page >> UMC_V12_0_PA_R0_BIT) & 0x3fffULL;
+			return;
+		}
 
-		dev_info(adev->dev,
-			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
-			retired_page, row, col, bank, channel_index);
-		amdgpu_umc_fill_error_record(err_data, err_addr,
-			retired_page, channel_index, addr_in->ma.umc_inst);
+		bank = paddr_out->pa.bank;
+		channel_index = paddr_out->pa.channel_idx;
+		/* no need to care about umc inst if addr_in is NULL */
+		umc_inst = addr_in->ma.umc_inst;
 	}
-}
 
-static void umc_v12_0_dump_addr_info(struct amdgpu_device *adev,
-				struct ta_ras_query_address_output *addr_out,
-				uint64_t err_addr)
-{
-	uint32_t col, row, bank, channel_index;
-	uint64_t soc_pa, retired_page, column;
+	soc_pa = paddr_out->pa.pa;
 
-	soc_pa = addr_out->pa.pa;
-	bank = addr_out->pa.bank;
-	channel_index = addr_out->pa.channel_idx;
+	if (!err_data && !dump_addr)
+		return;
 
 	col = (err_addr >> 1) & 0x1fULL;
 	/* clear [C3 C2] in soc physical address */
@@ -248,41 +227,50 @@ static void umc_v12_0_dump_addr_info(struct amdgpu_device *adev,
 
 		/* include column bit 0 and 1 */
 		col &= 0x3;
-		col |= ((column & 0x7) << 2);
+		col |= (column << 2);
 		row = (retired_page >> UMC_V12_0_PA_R0_BIT) & 0x3fffULL;
 
-		dev_info(adev->dev,
-			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
-			retired_page, row, col, bank, channel_index);
+		if (dump_addr)
+			dev_info(adev->dev,
+				"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
+				retired_page, row, col, bank, channel_index);
+
+		if (err_data)
+			amdgpu_umc_fill_error_record(err_data, err_addr,
+				retired_page, channel_index, umc_inst);
 	}
 }
 
 static int umc_v12_0_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 			uint64_t pa_addr, uint64_t *pfns, int len)
 {
-	uint64_t soc_pa, retired_page, column;
-	uint32_t pos = 0;
-
-	soc_pa = pa_addr;
-	/* clear [C3 C2] in soc physical address */
-	soc_pa &= ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
-	/* clear [C4] in soc physical address */
-	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
-	/* clear [R13] in soc physical address */
-	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_R13_BIT);
+	uint32_t i, ret = 0, pos = 0;
+	struct ta_ras_query_address_output addr_out;
+	struct ras_err_data err_data;
+
+	err_data.err_addr =
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+				sizeof(struct eeprom_table_record), GFP_KERNEL);
+	if(!err_data.err_addr) {
+		dev_warn(adev->dev, "Failed to alloc memory in "
+				"bad page lookup!\n");
+		return 0;
+	}
 
-	/* loop for all possibilities of [C4 C3 C2] */
-	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
-		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
-		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
-		retired_page |= (((column & 0x8) >> 3) << UMC_V12_0_PA_R13_BIT);
+	addr_out.pa.pa = pa_addr;
+	umc_v12_0_convert_error_address(adev, &err_data, NULL, &addr_out, false);
 
+	for (i = 0; i < adev->umc.max_ras_err_cnt_per_query; i++) {
 		if (pos >= len)
-			return 0;
-		pfns[pos++] = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+			goto out;
+
+		pfns[pos++] = err_data.err_addr[pos].retired_page;
 	}
+	ret = pos;
 
-	return pos;
+out:
+	kfree(err_data.err_addr);
+	return ret;
 }
 
 static int umc_v12_0_convert_mca_to_addr(struct amdgpu_device *adev,
@@ -300,14 +288,8 @@ static int umc_v12_0_convert_mca_to_addr(struct amdgpu_device *adev,
 	addr_in.ma.node_inst = node;
 	addr_in.ma.socket_id = socket;
 	addr_in.addr_type = TA_RAS_MCA_TO_PA;
-	if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out)) {
-		dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
-			err_addr);
-		return -EINVAL;
-	}
 
-	if (dump_addr)
-		umc_v12_0_dump_addr_info(adev, &addr_out, err_addr);
+	umc_v12_0_convert_error_address(adev, NULL, &addr_in, &addr_out, dump_addr);
 
 	*addr = addr_out.pa.pa;
 
@@ -363,7 +345,7 @@ static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 		addr_in.ma.umc_inst = umc_inst;
 		addr_in.ma.node_inst = node_inst;
 
-		umc_v12_0_convert_error_address(adev, err_data, &addr_in);
+		umc_v12_0_convert_error_address(adev, err_data, &addr_in, NULL, true);
 	}
 
 	/* clear umc status */
-- 
2.34.1

