Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809C7E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 20:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FEA410F196;
	Fri, 10 Jan 2025 20:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aty6D/iU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF3910F194
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 20:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsjI4iI0Zl5rYPVXsYz44ne0kX6Id5SwsZ5BLnaFU0SLz4b2opLDtuRYrFKWJFdznZmLSA2IqhPrlGT91GPB8nbX0nbkEAJCyYwyvVNEhOzEMmeJSwAQkDJbRkC20neJMlL8PF59TL0M3XzmynctoXHbuzSAzwTJCWXx+yZGcB6kXcRNDLVCG4tsLxKwtGMFj/8+gVMz+sCpX+qORDdQJGurt40Aj2VQxJ5sk3q2SmLkeY1NfkORhow3g94V7e8WbHciJZVCjcH8FctuuxxuiryAVe0GPFJPcs+ZAGXc7CMoWDHX/mLv2whx/WeH7JZf14eMB0MBtM9skxdXIliiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWZ8hPJs1+0secVhe5PzU/ofwpVjrrebaFU/coA2vdg=;
 b=JyxsRAHZzMes30WJ8JSlIADGJW2uFfZxy6SXdy13IFU1dm2Bfj0EKmfHxEktvnjH7nl5GHStarFTN7rQgpSWOpoIqI0QmAHkXEyaSbYTb+nmK+9BMlhFknBNgl0HJ/NuTh+5/InkFUj2UZnRMTpNw3hJGfowxQ6U08RMBV2MSe1ijG+8r0W9VpIiBb8PMWE67jxnrh1S38IjMJtaU7otsbKk/SiwNQ360qCc04Y3YzX72KWK2PoK5m7TblAu+FiFDyEdbN7TYKboRErMLBQ55S5gl06UK/VQgVMYb8CFctGowfGDBBpPv1ysaq4qxjeC7+Vt/kQ/vE0MBZCoZvPdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWZ8hPJs1+0secVhe5PzU/ofwpVjrrebaFU/coA2vdg=;
 b=aty6D/iUTcW8hvHavpjGUlg2qRuvEiVMScav2Y5euGKaDBV7DmTlBJdqQX5kDRHHolmMwZIdUJ9Udmo1Jvhz6x3P5uozqZDPcnfgthvtFGTVtZ0Oj4S6LVwKIjVVSE0X3yBxyMjpndbDHnBq2MklquCYMtukuzhMmh0SLUQevVI=
Received: from BY5PR20CA0010.namprd20.prod.outlook.com (2603:10b6:a03:1f4::23)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 20:19:15 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::a) by BY5PR20CA0010.outlook.office365.com
 (2603:10b6:a03:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.16 via Frontend Transport; Fri,
 10 Jan 2025 20:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 20:19:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 14:19:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Use active umc info from discovery
Date: Fri, 10 Jan 2025 15:18:59 -0500
Message-ID: <20250110201859.3830203-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a55f59-19b1-4b71-23ad-08dd31b40dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gY/zoOfu82gLjUBUBmQrpwEzCSS+/9UXXJ0Houqd/acd3uBK4x2vHyq0HlWZ?=
 =?us-ascii?Q?7IqQOtZYFtynQ67tDdb6hGxVaBLE+sMrxcpTmz9bwWmRclpr5/85dqVSFXzc?=
 =?us-ascii?Q?M03Kxk3yG9CXB+T9Uj9FMYTAL/e4uuxngNm2uDmJz4VQ2WTkK/m0cbRba164?=
 =?us-ascii?Q?+t0lFw+8KUp/FrxtU/KB7SkiqP3EmKNgBoo9E3L9srIr0/tKG36fl9aZGSbj?=
 =?us-ascii?Q?huPhYrFGvjVf2+FV4oXSG5UE5Z5xu/Olcs06zkj3vPN0BGVpmB9457Itug11?=
 =?us-ascii?Q?yTMeAqgUDpdho/X0AqR8oUFXbaJrqvvuscjXe5sLAlbqWOTaI1yQmV6ZnO+v?=
 =?us-ascii?Q?Uc6H6qfYB2erHxsCeYgPlc+KW90DGb2z32/2XpNalUyaJHV/H7uE4cQxzCJr?=
 =?us-ascii?Q?8YpmKtZul97HGFZHtjzFlc+CDpKBnp0OUqUrQM35RgrvLpq0kzanoyIUqjux?=
 =?us-ascii?Q?Q2POZlpMFkRHIB3BnzurK109mrPx2H0/d9lHRK7hG/2bst7lLDOt8GK+3FGq?=
 =?us-ascii?Q?TAlhDO2Fd02ux6rMLlamwbS+yioYJ7PMFwuRxcRZ9Ewu92pYU7xkKlVtkrEH?=
 =?us-ascii?Q?8gGXJQysoLo/FGR3MczDjTjJEw2rXGmI/nCgNExAsrRkXgoaVhoSbqzu8jsV?=
 =?us-ascii?Q?x39Ct0XN+euRNdixBhY4LuF0PApal2oUbprhgaXTX3MCQCysJbDDXcWTLmx/?=
 =?us-ascii?Q?tO1rDQOn0vDPZRStV4X1ImmlRHWzxAMlaB88WFPEmPHC9Y4Amv6dA+utPZvo?=
 =?us-ascii?Q?UALtOmRHU9e8e/xsRwNhj5MIxjdwln2Vd2EM7L6+V7Sfftp1g+Vq0xwAbWPR?=
 =?us-ascii?Q?1fZzLoHPIn5AzvcAyGFeHZ6JoVuiTjOYgMnIILZSfYMZIRNbauyvsOVgr2xt?=
 =?us-ascii?Q?x+lZUKA9a/pvcQH0n7/TLa+BlLJVoSsHfRRosgjqYI3Ex7FFgNhOu5lONRqh?=
 =?us-ascii?Q?EGYXqq1sL2Laf0C6czfoFQyOqZdL80SAGneIlBqLn0Oa/QIbynwtJiLFIOu1?=
 =?us-ascii?Q?tXW2zmMC5TqgkDW+CwH61qlSzQsMmK55Ea6nbk13812e6lywLw+hf3hkW/RV?=
 =?us-ascii?Q?AG2oeByXPVg6y4apAIHDeTNB0IUmoaf2MAYV/3AHrbvFPebp954LgSh4iO7E?=
 =?us-ascii?Q?EvCyxnb1aGIENRsxhjXoCBpmvZYM0vcr+R9vij1PXUaR4NDtE+wGMK9wZJCL?=
 =?us-ascii?Q?D5kCyq5Puy7hfwDRPtmHskw+P27cb+JKlJSMU3Gt8CTzgWpTOtRxfvITAyfG?=
 =?us-ascii?Q?AMb3EvO3Y1S613f53uSmBP9G8km4XLOMyVs9ZMTMFeHFlQoN23ahxNoL+Ulw?=
 =?us-ascii?Q?4yvdnjpK9KmrgfClku7R7wzN+3vCxxXeStVEXZxPLhFYOgA1yLXzag7LEZjC?=
 =?us-ascii?Q?whDJJhVrZfKLhYRaljZScWA8isp6npuz61JTcQFp5h9aPnaHgWtsAqS07rAg?=
 =?us-ascii?Q?X6ZMwlsdjDgn16igvitS90BKbQxQ17a5TEHgUtm+mDJSVrFQa+wtDHqtFwtL?=
 =?us-ascii?Q?V45juRuCsspQG/M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:19:14.9813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a55f59-19b1-4b71-23ad-08dd31b40dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135
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

From: Lijo Lazar <lijo.lazar@amd.com>

There could be configs where some UMC instances are harvested. This
information is obtained through discovery data and populated in
umc.active_mask. Avoid reassigning this as AID mask, instead use the
mask directly while iterating through umc instances. This is to avoid
accesses to harvested UMC instances.

v2: fix warning (Alex)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 42 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  1 -
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index eafe20d8fe0b6..0a1ef95b28668 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -387,6 +387,45 @@ int amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
 	return 0;
 }
 
+static int amdgpu_umc_loop_all_aid(struct amdgpu_device *adev, umc_func func,
+				   void *data)
+{
+	uint32_t umc_node_inst;
+	uint32_t node_inst;
+	uint32_t umc_inst;
+	uint32_t ch_inst;
+	int ret;
+
+	/*
+	 * This loop is done based on the following -
+	 * umc.active mask = mask of active umc instances across all nodes
+	 * umc.umc_inst_num = maximum number of umc instancess per node
+	 * umc.node_inst_num = maximum number of node instances
+	 * Channel instances are not assumed to be harvested.
+	 */
+	dev_dbg(adev->dev, "active umcs :%lx umc_inst per node: %d",
+		adev->umc.active_mask, adev->umc.umc_inst_num);
+	for_each_set_bit(umc_node_inst, &(adev->umc.active_mask),
+			 adev->umc.node_inst_num * adev->umc.umc_inst_num) {
+		node_inst = umc_node_inst / adev->umc.umc_inst_num;
+		umc_inst = umc_node_inst % adev->umc.umc_inst_num;
+		LOOP_UMC_CH_INST(ch_inst) {
+			dev_dbg(adev->dev,
+				"node_inst :%d umc_inst: %d ch_inst: %d",
+				node_inst, umc_inst, ch_inst);
+			ret = func(adev, node_inst, umc_inst, ch_inst, data);
+			if (ret) {
+				dev_err(adev->dev,
+					"Node %d umc %d ch %d func returns %d\n",
+					node_inst, umc_inst, ch_inst, ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 			umc_func func, void *data)
 {
@@ -395,6 +434,9 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 	uint32_t ch_inst         = 0;
 	int ret = 0;
 
+	if (adev->aid_mask)
+		return amdgpu_umc_loop_all_aid(adev, func, data);
+
 	if (adev->umc.node_inst_num) {
 		LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
 			ret = func(adev, node_inst, umc_inst, ch_inst, data);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 291549765c38c..71b8ae7f2194e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1504,7 +1504,6 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.node_inst_num /= UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V12_0_PER_CHANNEL_OFFSET;
-		adev->umc.active_mask = adev->aid_mask;
 		adev->umc.retire_unit = UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
 		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
 			adev->umc.ras = &umc_v12_0_ras;
-- 
2.47.1

