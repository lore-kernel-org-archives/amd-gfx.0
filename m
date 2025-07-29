Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94754C83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 04:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E70210E1C4;
	Tue, 29 Jul 2025 04:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z9vP+1OJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B9510E1C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 04:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kpu/klDZ7rVAZ10mJ5OCMRWV57ClIIqoSfdOqFCXkt6rtb84p/pRmjSwpnBBJx/gxMdHUfjF3kUERl7wone95NLJ+wPlOInyhOyelcNUeKFpKduZq4n+5v9E4fim4FrsP+EzeoN5JIEuINtlw3Wyr05yR1ppjSbKjf+cFrWrpQVIVlMBUuRH+iixB9zVtwI7ulYSwm5RtL+NrTkUcwMiY/VbpcAxzjqtTkBX9lf5rpbtzcx/ZEZShD5AvnWXoS+Wc6GTX//ugol1al0bWZLzEGtrieFm1C290+oFHjyxdtXzNKO0M4NZzAyWsZqlUmFAhoOm5zZvmPqWFafUqb1DPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkNaSliXWzw+pXapDRz8HxyNbXFT98dwjYOvww6Q4iM=;
 b=raqqJX7GEB2EwXX6lcXkhMLdZxKEsdT3EmXq4zTza1d55+17n4NVJqQ4BNqxx2JasJV/3hmqToKwuIZ8sj6Naj1E1SpKsl6zOm2TxhaBagPbSXIEy0kKXFKiE/exuwJHM6RFQfYxO+b4zXTZqSkSo5qklyKS72HRM5MjdUOFNg5zDPQgEpQ2XDrbldQypun1JVeN0Dut+GKKkcesafNtkUPYnOrDVcadz4BpK1HVKaa/Z+mMejApJcKKd83YYUtPYZhA602Ba5jva04ocbtBXR1lvFQEYZnRgu8LqFIoDTcBK82i8FSdokVARKfb00L7g0eQ6ISaHqMe12Qmxe0sXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkNaSliXWzw+pXapDRz8HxyNbXFT98dwjYOvww6Q4iM=;
 b=Z9vP+1OJN8gPrQcK726zXX9W3ZblPv52idOTwQk6K8sUWIQGHD9/bbpFFLJuvgd2CLfPDsqI3e5jeTSl6ItUukiEaSzizHUBiJ/xQjYifeSvTiVA4w2kF8Wzv83alEixlADSqeb1UeQL2ANOAEsxzaY1gU9oD6sCHnpfagJhKs0=
Received: from MW3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:303:2b::7)
 by SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 04:20:40 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::53) by MW3PR05CA0002.outlook.office365.com
 (2603:10b6:303:2b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 04:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 04:20:39 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 23:20:37 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, "Stanley . Yang"
 <Stanley.Yang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Initialize vcn v5_0_1 ras function
Date: Tue, 29 Jul 2025 12:20:19 +0800
Message-ID: <20250729042019.1487385-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: bf923c7a-a39f-4e00-1821-08ddce574684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kgyt4Jjuom7V880cBNiGNlEDGjpzxgQZL7IUsBZD6dj9ozvQBnp2HCpZd3rb?=
 =?us-ascii?Q?PqPFHupwNThcwWj/KU4Y3b9IzCkIcvzMhIlncgwI9f6Unk18nbeQKdR8H8Iv?=
 =?us-ascii?Q?b5DlLRK0a9ysnw7gO6vafJ9NdYErPVMUj7+T6RUgNAzqK9IUUjzqgnFEms8b?=
 =?us-ascii?Q?kL+hLGtwJSsjPgx8yyIX3O+zqU4WlKhOVAk6LRR2V+9T8c2pkwmGvV8W02Gj?=
 =?us-ascii?Q?QXW5LnvER5c5lJ5PcXr0VE2IlLKyU3a0GxbD0b5J2hs7Vkrw3yJACzxu8spL?=
 =?us-ascii?Q?tbdL3pHwkWEtjgr61OYOdSAwwLAAeBHudCX8Mk0z/7cE4WgGpFd9kHXDokFj?=
 =?us-ascii?Q?xt/xsVhWW1YsmlZNmZ66nMpI9zc7a1GgS84knfV3TmPo4hC0pm6nTpIaJB5I?=
 =?us-ascii?Q?1eHJUT4wbBeyEu5t4FPWmQS3nDltawZghigAbT/pt3gNAlXCuIAlZIEPsdBi?=
 =?us-ascii?Q?pJij6jIIFcsjZnwwTwfetDyAq1nZLdookgvz6F6xJNl72CWVpwbGynHSGGr1?=
 =?us-ascii?Q?/bmbWU2bNxsZ4s0jXTwxsZLNyXZkU0/cywblXMHD4YZ1yqrnhOTkmMTj7fpT?=
 =?us-ascii?Q?n6Qca5A1CKBiPR4n9QbfIac6PAXZiPUCeslOTQwb3aLB1n6xFr4Q9BlMvzDb?=
 =?us-ascii?Q?jskbQhQ5a0CWuyqjVtixiqsX/Ccbf3mAzZs/ucfjsajxk1K+uaK71J7v6hDL?=
 =?us-ascii?Q?pOgeBOL6cWeOkUDv2bxcxpkxVJONiriNR0VjSAEQQOtLloqs+Q6CmMBkLL6Y?=
 =?us-ascii?Q?bulTjgUiodn5ufuqn6kjALH2hnwRYU8PX3S/LeRZh7akQGdY9UtID5jQ/wTl?=
 =?us-ascii?Q?spae8MBjBJll+KKjjerf7jlSOevRI1sWI6sOcfRNSPi9R8wYRedSg2EEJHvH?=
 =?us-ascii?Q?EcGtEeqiQiQqGWpdvsAPONXbglRs35L8YMF/t53Rwy35FdYY/TpXvK9ODhHz?=
 =?us-ascii?Q?2DD/yPd+Bn4c9HZn72vPA4G9m8lQj4xqToO4hkBpk2PByYfpgTAgheqlEZTL?=
 =?us-ascii?Q?PC3w2VEaWrIHlrQSyZhnyiHahg2Dcwbz0IL4hbKx8FaUSVq02aH0fwb9XQdx?=
 =?us-ascii?Q?7KATEWiATE/RFHwzs+z26zoQrZWOpouMsmwNvlophlLeqFhq0EJSoLKusU8q?=
 =?us-ascii?Q?wbHzQTLgEdS7XdKH4+4HOZ1DJUA0Aru2djvh29VSdSP7gjZqXcd1K86o1IeY?=
 =?us-ascii?Q?8Jp70igc8A+Moc618A4NPIAfbuzkfe5XGoeATlDv+tSd4mKYgCaZWRTRdu22?=
 =?us-ascii?Q?SrVnfzzsleArGk9bHGnycQ9sadBlQ1q3UOf8S2P3E6UYxShz/f2mD1NEfH9x?=
 =?us-ascii?Q?2QvHJSQ5PAWnOTgOQUO/dFcbhfUlT3uys7CU6o+VmMPVPFI33E7dLm5lZy4s?=
 =?us-ascii?Q?HAcNoLsqkqorI2dQYAbqJvEU4az6zbkb4tyVom0mvuIuFwbuRkeOhV+fmspF?=
 =?us-ascii?Q?WaxIemrILUG6nTALRYEg+CLxamR6RIn+5PhLb48qdrlHNAy1hrjd3jEN7Bu5?=
 =?us-ascii?Q?F581KVo45ZxF+KtWrav4r7FDl2bp78aIkULq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 04:20:39.5675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf923c7a-a39f-4e00-1821-08ddce574684
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107
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

Initialize vcn v5_0_1 ras function

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index cdefd7fcb0da..563cb3e1b610 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -163,6 +163,15 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
+		r = amdgpu_vcn_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize vcn ras block!\n");
+			return r;
+		}
+	}
+
+
 	vcn_v5_0_0_alloc_ip_dump(adev);
 
 	return amdgpu_vcn_sysfs_reset_mask_init(adev);
-- 
2.34.1

