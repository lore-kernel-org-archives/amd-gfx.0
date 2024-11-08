Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CF7D5E15E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258CF10E26F;
	Fri,  8 Nov 2024 11:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JmpkjesR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C31A910E26F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ps9ovHLsklMyucjxFL3X8eYgryl9HlSiqKf+MtrXcLAM7ksWqR+R2ncuruNkkEkpR1bxPXTQox8mQGwAdx2GhASEzGusKMX7RGxK+gY3OpU7Xoa/Fdn8htbTU3bOaoJygEzf6uyDhW5n2x6gGhXzPNy+QwoJRKY6qCUUyyk4N3vBbjfO2shMKdwPiJlpep4pA0d23aNLnH5qX3i2sowloo1U2kH9a7k+aT2mAxIhFvMjqsfdXn+pE2OVyfDzLgxM9pbMdXqqsIiTmTucP8XroogFPYZvxzDWKHowEXr9t2RN5FB2zTWd4dvIXDeeBeM8bBaNwjaERVfxCoKI/o9pvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l+/79f5ZGHedQ039MhPHmkGImA9ylWS6RcT6JBvdEA=;
 b=ZowBS7TnHtNvgrizaWm5P43JF3OmJBXv5MlBW5AKBxqn7y/jg7Vq0wXgLY0uzkUIkJUqJ1qcVeb4no9hluMuHY4IBMIBf2XclavyGiuWU7Tnb679wiSh8qHLVWFvF9QlrdNpTgKj/ySlenGFYS1s7tKAas3C+wyzKAZk6NDn+oVU2G4DVy/c5i1eQsrwBgAFAZUcCFlnD/A3whTNBZnw3lFmOYRcRrq3oJUEcWpJicwDyJGFUt76boPuQEmQwMNd/AAwERE7S6UB4zuwoi/JwYcD6aw/WzIMBBJgboiheY3z8vyfoPki7mh2+h8R3KxkvZvKueYITez73hxYZNpLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l+/79f5ZGHedQ039MhPHmkGImA9ylWS6RcT6JBvdEA=;
 b=JmpkjesRndhDa5owId9u+kOIbVrzUOClIJ/SRyF4j9W43Z0P2n7NNyNdoRmJ/IZR5DHhTHnrO6WkLVjwJXb+j9JkfySYsy87kl0ZSbHCuO/YTAfBIWaUoveaO25CryTnuysR+MWpWuuy7S5Kf/uAtPSMfs9haxh9YL5B9AbrofM=
Received: from BL0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:91::34)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 11:14:41 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:91:cafe::fb) by BL0PR05CA0024.outlook.office365.com
 (2603:10b6:208:91::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.10 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:41 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:40 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 08/23] drm/amdgpu: add return value for convert_ras_err_addr
Date: Fri, 8 Nov 2024 19:14:08 +0800
Message-ID: <20241108111423.60169-8-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b54afe2-e1b2-406d-32b6-08dcffe68ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f6oGcyy0SC8NjBfTRbP6bx0q0sT8u8tKlAsHikriSKPA8S2AM9B7jv1tB89x?=
 =?us-ascii?Q?6JoqrEi4DbavgZy7LADPXQiK2jvWlOG2SsK/teoiSnvhetTD6yqg5M7LS85a?=
 =?us-ascii?Q?JXOJSmbogoQ4aWDJDTPivPKywOdP5oAsZGCGguh6swZPFUQvdPEFxlV6BXne?=
 =?us-ascii?Q?K4ILS4gCjEFoKuTJXvuYFJyUaUwh5W9li1F+lj6Pyumj2yaTWicw19aB1Wps?=
 =?us-ascii?Q?vEpUSkp6QZhE7QklL8Cg8PvAaJnQ8AFyd1D7PvCj+5RSqohnb4d1j4KBjttx?=
 =?us-ascii?Q?lpco/f4RG3JDbFMSQLoMSq3wfQlpax+yMKGyq9jbZGXok8M/eiL48bn2XVaw?=
 =?us-ascii?Q?ZIvjyFeMUeZue4aVT0cHcsY3p1l480qRNK8vgjXMODPO18Ecm5+mHkwqPjc7?=
 =?us-ascii?Q?yRlqWriqvf8PEj16kAnw+wbGbhaTxV1bAxiqYcsvoOVzMmM33K/tcH3nhl+R?=
 =?us-ascii?Q?ghWrNvf5efi6hLgoix47C9xe2dpq5Za8r2e0jXPZy+N8TUEks4Ul6YLvEeKv?=
 =?us-ascii?Q?u+kbhTGHMpaedLHnQD+QNQ+5KJH/g0HE/73yDXTcf4IpbxjWx7PgtOzZsNpf?=
 =?us-ascii?Q?0wOOr4EhfWo9PUcRX/x103Q9a+xUbJif+FdtmMoRXdthqHTuSGkRB3Pf4PC2?=
 =?us-ascii?Q?8zeSY6C0t8ZOvg1/qxMlyhOeED9ce1VxJZtbU4FB7F8elYL9xcNEn/FOcXFc?=
 =?us-ascii?Q?JEV0ftn0T8ku3B2wsPjgY4Rm5jFsAMcsY1/BZvr5U2PgUjtr7I6w/aHLGD4z?=
 =?us-ascii?Q?XWCX8blbpFEpj2P0tdt3xxeWeqKRrGeAAhgWcxgWnIlfI3L3CE0W9rWWjM23?=
 =?us-ascii?Q?Iq6TTelcbE+nLJgNKLJeDyvrXGxlwI8sEoIsSfJ+JX1W2QLGUdHMZvKLnQDo?=
 =?us-ascii?Q?0vZrtm1+U1jIjpdb4LgeHNtvz7RGuoqYnpTylz9aE79WaY5l9+N9zU3esw2r?=
 =?us-ascii?Q?CjGZKIrJy5o2U8aFntlpjQOIc92/at89i5cF1kzp7517/LWg0lYwK86Tn1X2?=
 =?us-ascii?Q?o8i4Nm/d0ZYNgXsefRdnNWOUZ0c93Q1g1Vakefnlcu21mpZ91WfQqZfvxfN7?=
 =?us-ascii?Q?CLJGN4zxUh8Zfrd9hgVfDxrjAofaYZ10qaY4EVrtP8FbZNtK45jqN227vNac?=
 =?us-ascii?Q?VBCuRbZp3g5tg5sA5mShzw63fW5+atmgr07DjZqlVpULPHOEcfkfs1AYcfvF?=
 =?us-ascii?Q?js3AdyrMjxMoLg1vH+Bb4HSw01vL8sWlzXFhSSePn1K68P+PXeQLJYHDfTzX?=
 =?us-ascii?Q?oirwEGm6x7r3FYsFHRgodCxQnZtZEJkQxqlY7M9KZVlFjKT3z3ryuY50TLoF?=
 =?us-ascii?Q?xRslu7QJ1pIiOQzsXUrKch2de42VZrB+Pq9NGt5BULhhz4TK8vyIRLSI/Lg/?=
 =?us-ascii?Q?dBGBY9zctjxArYDjbLAes1npPcrGMRGnja/xzpF00LzL1EXtLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:41.5079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b54afe2-e1b2-406d-32b6-08dcffe68ac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
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

So upper layer can return failure directly if address conversion fails.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 19 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index c0433e6471f5..3199dca8f1ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -464,11 +464,14 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 
 	addr_out.pa.pa = pa_addr;
 
-	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
-		adev->umc.ras->convert_ras_err_addr(adev, &err_data, NULL,
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
+		ret = adev->umc.ras->convert_ras_err_addr(adev, &err_data, NULL,
 				&addr_out, false);
-	else
+		if (ret)
+			goto out;
+	} else {
 		goto out;
+	}
 
 	for (i = 0; i < adev->umc.retire_unit; i++) {
 		if (pos >= len)
@@ -490,6 +493,7 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 {
 	struct ta_ras_query_address_input addr_in;
 	struct ta_ras_query_address_output addr_out;
+	int ret;
 
 	memset(&addr_in, 0, sizeof(addr_in));
 	addr_in.ma.err_addr = err_addr;
@@ -498,11 +502,14 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 	addr_in.ma.node_inst = node;
 	addr_in.ma.socket_id = socket;
 
-	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
-		adev->umc.ras->convert_ras_err_addr(adev, NULL, &addr_in,
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
+		ret = adev->umc.ras->convert_ras_err_addr(adev, NULL, &addr_in,
 				&addr_out, dump_addr);
-	else
+		if (ret)
+			return ret;
+	} else {
 		return 0;
+	}
 
 	*addr = addr_out.pa.pa;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index abde7597bda8..f45408a6ff03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -70,7 +70,7 @@ struct amdgpu_umc_ras {
 			enum amdgpu_mca_error_type type, void *ras_error_status);
 	int (*update_ecc_status)(struct amdgpu_device *adev,
 			uint64_t status, uint64_t ipid, uint64_t addr);
-	void (*convert_ras_err_addr)(struct amdgpu_device *adev,
+	int (*convert_ras_err_addr)(struct amdgpu_device *adev,
 			struct ras_err_data *err_data,
 			struct ta_ras_query_address_input *addr_in,
 			struct ta_ras_query_address_output *addr_out,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 9b93ff769b86..ce60fd6675ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -173,7 +173,7 @@ static void umc_v12_0_query_ras_error_count(struct amdgpu_device *adev,
 	umc_v12_0_reset_error_count(adev);
 }
 
-static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
+static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ras_err_data *err_data,
 					struct ta_ras_query_address_input *addr_in,
 					struct ta_ras_query_address_output *addr_out,
@@ -183,6 +183,7 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	uint64_t soc_pa, retired_page, column, err_addr;
 	struct ta_ras_query_address_output addr_out_tmp;
 	struct ta_ras_query_address_output *paddr_out;
+	int ret = 0;
 
 	if (!addr_out)
 		paddr_out = &addr_out_tmp;
@@ -193,11 +194,12 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	if (addr_in) {
 		err_addr = addr_in->ma.err_addr;
 		addr_in->addr_type = TA_RAS_MCA_TO_PA;
-		if (psp_ras_query_address(&adev->psp, addr_in, paddr_out)) {
+		ret = psp_ras_query_address(&adev->psp, addr_in, paddr_out);
+		if (ret) {
 			dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
 				err_addr);
 
-			return;
+			return ret;
 		}
 
 		bank = paddr_out->pa.bank;
@@ -209,7 +211,7 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	soc_pa = paddr_out->pa.pa;
 
 	if (!err_data && !dump_addr)
-		return;
+		return ret;
 
 	col = (err_addr >> 1) & 0x1fULL;
 	/* clear [C3 C2] in soc physical address */
@@ -241,6 +243,8 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 			amdgpu_umc_fill_error_record(err_data, err_addr,
 				retired_page, channel_index, umc_inst);
 	}
+
+	return ret;
 }
 
 static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
-- 
2.34.1

