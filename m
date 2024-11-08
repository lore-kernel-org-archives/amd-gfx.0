Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2834D5E145
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 08:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A12A10E922;
	Fri,  8 Nov 2024 08:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DZr3gIp6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9908610E922
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 08:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owDLfsGV4Q4j0bqfrVYx/Y8QZrZo9sxQFe0JUEu8Vw3uPnbiAVysVw4opKrozP0CQ0LDpWrGxZ2vwXj492XtJPcOBNtZaSwE58kkZC25OAWqHfK3jcQv75exuukvdqDp1fKtpbUazWcQRvhtgTVSwjmnTcUJkmLU4rwcnLWKgjTpQs+pb9vq0ANe8FtCpBhvnT2SsZfeKoVJ1l7DCvM8Ba6l7gAB8hn3thWr8gjtsgfx/LGccT5ylRpzWb6Q/C2ZA0XsBUT5KRq2Q4I7TdNk12j3MmHzmcC5Ej3gqqplkePO7bfD+PNywSl0o12Qg7BBIFkC25e9O30xCi17F6BfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw0kNnJg6v4lRcohAwkcgRs8NTr4m3RQeqRuiPXNx40=;
 b=RXc1BF0VyyX7/oEVc57A5YDxtr0iL5cK86a1HL0uVc6dJ8gp+TSJnFh1TjWUttKQXJlG91d4RAxVG6HUdmtpwApl/EyXDKj9H2C+dk2pw9zrmZE8v728LgstLbGGcW+ks6ACGY2UMt/SpamHNvBv+sOr0Jz2OY5EilQKXK8diAK4scCsUPga9fi4Z/6SSZx9flJ6ZZMyS+8hCS8gj93OabA0f962u9ib8NojG1FieO77zh1SW07BgpfF2hcBymUipQIlM8B7RPMpcKfxsgURWztsX3542eeoVYkN+EtSHD7b4cNUB579oDkali3ELZluCFUgyXudnrDX+F3dcEXwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw0kNnJg6v4lRcohAwkcgRs8NTr4m3RQeqRuiPXNx40=;
 b=DZr3gIp6u2Px8Tr3yCDpN6btR195/CXCMfzzmY015/HfvmV8VhSjsrIvHKAZ7NUVawB4u5yeVj8jFt3cGvcPq8NVWycOonEF0S3PqJqraHnZAc1qdUaK+vzpyVlppwh/f7bHlkcEtJsdExqgUSvOHA0Mr3117mn0x+WRBCmSUno=
Received: from BYAPR11CA0042.namprd11.prod.outlook.com (2603:10b6:a03:80::19)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 08:06:19 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:80:cafe::28) by BYAPR11CA0042.outlook.office365.com
 (2603:10b6:a03:80::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 08:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Fri, 8 Nov 2024 08:06:18 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 02:06:16 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Support vcn and jpeg error info parsing
Date: Fri, 8 Nov 2024 16:06:01 +0800
Message-ID: <20241108080601.824849-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ccfb20-5921-44af-7f37-08dcffcc39e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MdHtb3SpzDoEUpO1Z7FLzWA/DV36vO9on5ZdMdklpAj+Wv7JZJGBRyarYBpk?=
 =?us-ascii?Q?HhR2rSyjny9iMH19j7MQKzEIMfpFUMw2nN5Sj5kugXmbkMGbh+2OZ3d2FJO9?=
 =?us-ascii?Q?DytFsgFUm5lXj8Tw/s2/IjWqZ1LCq1GGpCMC+vg1I0YdnepdHOW8fedrkkSQ?=
 =?us-ascii?Q?EjRkULJE7FRCx1OJT+EniKwvSqGMOoqfEEP3l/8HGjCu3Yz/1NfMcdLLcG6b?=
 =?us-ascii?Q?z5C/s0yCt2w50omBazVOv+10HVUJWYzYQ+kFwIPKiZSBoRwJYoDu9/rA2HIS?=
 =?us-ascii?Q?7RT5BP6CDizWrHm+rzCwCZcFImk9tK/rwxBeUHii9u+V7H7/srYe4XCQSk/j?=
 =?us-ascii?Q?/9kgE3XEb4dXgZkp5UR6QSSSRMAa0FOZ7zuw8lp2QC8XS2rIKC+xA+xdvXow?=
 =?us-ascii?Q?10zrDYal33JpmYmyZAads3r9xvaBnJqrJ2QAp9KU5VET0mkGXydpDAT18NpU?=
 =?us-ascii?Q?7L29/rp2/G6pcByc5AAoMOHxT8gaWyMC/AYtz9A33uwqz7ktDs/CgYlKnPpw?=
 =?us-ascii?Q?7Hx8D8aFi+8bul0Ff26hvaxldKdluk+Yc1VkQSyNm/J3CDFZTk35kaFA9qme?=
 =?us-ascii?Q?7/sjngRdvOHRp3zr2sg3m4VGmozxeKP2nv/u4MFD4cqYAOtBITdoIP+OvCb5?=
 =?us-ascii?Q?SkCztluo0HLKkKEtcu012UIAF7ny1x55PY6PfH8AZfPaR1bzH3WcbZRMJrMA?=
 =?us-ascii?Q?md6PTCBRFRcwNCwhb0g8zsadu2uDv9I/bNs6Rfu3Uo8MS0GbvPEa044fZ1p7?=
 =?us-ascii?Q?X27KkIa1sjGpLebiVFSqesNUVVgoiPKgH2owC943TwoDkEyip0ic7CIZnqfg?=
 =?us-ascii?Q?95tbpf4IMVfPOem+2RFBs+NY0vjk89fJ4ndXcB2v/3FO/7D1r32aorb3Q/x3?=
 =?us-ascii?Q?Pkb3B3+qWB5eqKgqo7xMlqGuF4UKnGZ4d0FPt/iuXLzycpRCM+Qf/+UZRSsq?=
 =?us-ascii?Q?IhlWVDgMbDTb25kpDyyBaiquDUDtV6YKW9mdOdWnp1WPqQAtkI9EI+/h8AP+?=
 =?us-ascii?Q?M4I4IG+Sg/8bFcrspnCiqEaD3ivrA/qVuovEMPr1wqdXgM/XcPaSd1InBC7+?=
 =?us-ascii?Q?BMS4gv7QR+zLxQ7n2ELUrMrd16GDY+5rbxHar2G5GiXfd6cxofn5gbdvtXVg?=
 =?us-ascii?Q?HXUrnGFYF2ammJ43r6e/DTnM8VnHj5M4BFr4pMxIg8h6xGSA/Ji3PqlPFLcN?=
 =?us-ascii?Q?8tB3UGPgDeA1CeVTht6AbJLqOaEQVmQFbvFj86b6sKtiP0tQsNJ21cQz+7b0?=
 =?us-ascii?Q?N6Aatzsw79MX0XvXAzMkCokRzB736RL+F2D53JeTzjDzQSYRryRGj98cLwiF?=
 =?us-ascii?Q?TZl0uoCmdqrwJXqIpAuZiz4vu92n438E4cwjyURyr9maK/Y5tIw+KEGnRT98?=
 =?us-ascii?Q?WZE+o5Pg6u8RNWqdLxjz4gbek18AAU2nDoWQIS/TSFGlVl2QUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 08:06:18.8023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ccfb20-5921-44af-7f37-08dcffcc39e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
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

Add vcn and jpeg error count parsing.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c70b6ef5e5f3..b3bf5031e718 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3149,6 +3149,16 @@ static int mmhub_err_codes[] = {
 	CODE_VML2, CODE_VML2_WALKER, CODE_MMCANE,
 };
 
+static int vcn_err_codes[] = {
+	CODE_VIDD, CODE_VIDV,
+};
+static int jpeg_err_codes[] = {
+	CODE_JPEG0S, CODE_JPEG0D, CODE_JPEG1S, CODE_JPEG1D,
+	CODE_JPEG2S, CODE_JPEG2D, CODE_JPEG3S, CODE_JPEG3D,
+	CODE_JPEG4S, CODE_JPEG4D, CODE_JPEG5S, CODE_JPEG5D,
+	CODE_JPEG6S, CODE_JPEG6D, CODE_JPEG7S, CODE_JPEG7D,
+};
+
 static const struct mca_ras_info mca_ras_table[] = {
 	{
 		.blkid = AMDGPU_RAS_BLOCK__UMC,
@@ -3177,6 +3187,20 @@ static const struct mca_ras_info mca_ras_table[] = {
 		.blkid = AMDGPU_RAS_BLOCK__XGMI_WAFL,
 		.ip = AMDGPU_MCA_IP_PCS_XGMI,
 		.get_err_count = mca_pcs_xgmi_mca_get_err_count,
+	}, {
+		.blkid = AMDGPU_RAS_BLOCK__VCN,
+		.ip = AMDGPU_MCA_IP_SMU,
+		.err_code_array = vcn_err_codes,
+		.err_code_count = ARRAY_SIZE(vcn_err_codes),
+		.get_err_count = mca_smu_mca_get_err_count,
+		.bank_is_valid = mca_smu_bank_is_valid,
+	}, {
+		.blkid = AMDGPU_RAS_BLOCK__JPEG,
+		.ip = AMDGPU_MCA_IP_SMU,
+		.err_code_array = jpeg_err_codes,
+		.err_code_count = ARRAY_SIZE(jpeg_err_codes),
+		.get_err_count = mca_smu_mca_get_err_count,
+		.bank_is_valid = mca_smu_bank_is_valid,
 	},
 };
 
-- 
2.25.1

