Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853AA606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Q3ThpYou
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287471125D6;
	Thu, 22 Oct 2026 12:51:54 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4931125D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 12:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ5+C5IsaKLFn3EwRAEQw4fKeo0yCgwLGarsTko1Nl1XSPdEWUtSiXAAC6uB61owJZXO9yCZjmKjt3Mhzw7WyFS6FmFiharmt137I5VvO3Q6U6qmRw5uNcQK1OVrEu2lQd9NCQfKxKa0k+YuaWJeAOxuXGoXd879tHizBCKyOYqubK0Nmhgjr55xXzWzB053q4YG4IUsxi0ek45a+8G+IyEWTwSRc6xyqXCFy6M7Htdves/l6CIuc527j586HVco3iJQ2Y01cAW+ENB+lJAZNAaHmfRKpHTyhZ3vkl3dFt4Yj6SeISvrIDm1frI2XeoY+Sow1AGFMOF78j9slJvPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auaILcxixWeTGjQJ3mHM8XbplLvwVjWSsAsuGYpIsmg=;
 b=v7H+JyFyrrRC3eyhgI//vQtLJ/J/ymTQwON/ImWRj75DRH2KKq0zVb1GqbtR46kUO8LO3DcBvgO94Uk/dC52ofkW30DXSDoFOE/rBi5cTeeOGtu0NUskCqK6y6Al3J1qs6G+wdMBKSH+ZlouFQQudniCuW5fsD+5H27M9n2W/ess+WRQDqRQOIh6r1hvnvY5usfu0asO8pDcPwiJtPNCGMIJn6WcylW8hFp2dpNajVJglPbefJonTMe1AKrh+cX1Jqkp/4C7NfKkX13KKcI7tuuV+GPaO17QkirD9dHA0GyyPeiD0YnFMbVCn/wmkb+eCLx/ZP8gf9tHJTiLolbyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auaILcxixWeTGjQJ3mHM8XbplLvwVjWSsAsuGYpIsmg=;
 b=Q3ThpYouIGinkwRekERJuVTbLQnI6+p7/ANw6ALSbg4RyHAN/WmY8WkSRRLWMxZr4MJJoS9AIqaJhF+6UXa6UuClizk4JtEMv64ZjJI5JTfCF7uUeqlGRuVTax3P+FdJmy+hf17/8YQ4Goa/ehgj8HpGssUCwDsgYHa+1r9akXs=
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 12:51:43 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::68) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Thu,
 22 Oct 2026 12:51:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 12:51:42 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 07:51:21 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Add a metrics revision attribute ID
Date: Thu, 22 Oct 2026 20:49:16 +0800
Message-ID: <20261022124917.2232285-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: ef272c4f-fe71-4f59-8ef7-08df303b3933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|18002099003|261021121427099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Cl2ag62yz0YH/VvCHAYasGkxMjnF0EqWAk8WJXrvxXYmVZm6DsP+fR8UMipxzmCwAz0r2khcHwo3UtqQf2rRz4g10WpbF7iFVDFWAbSrXcZ/YDwC4x2QzKKsMALMAhd5PZH+PMYK7y/gqHNWCRVET6puZwkTJ1P8qV+icH+ySf6IDN19E7zo0VdztD6qv8lfPXd9x7p7TCK8RsDRu2tAMZBbW/L6V4GcajPy2pXTne7izrg6Uo6gsFRbdXE/JEgWlCKw3v9HqXdcbHZyuPNc5/Dl7kYmK+t9DGPwYDxXdV5WOe/6UjFl7kf/uO0sh558YNbqnc1XalDZFizLSpbSPbBxVqb/HyUqKQRaCwDeMlBcNq8IvdFW+1t/AEhTn+orW230qgxla1bFU45+krdOPw5SXg5VrgCnuKlnVEWj8SjE8PXf8YpczeNSdhR0wPb8hRiBcHpY7vRKNRWggrBfdDZ6LkVnOPG5t5J59OilG3kItkXdKvusqfeHqo17fV8ulrlK6avOc4A3IzECNSv+QQ7uPWZVoMIG0XwOUbqy3f7Ja1ko8kaTFdOrca6i3DXqVVrfPMBugIASpt/P1Q4Gd8qWkWKcVEl+AUO2WWfr5um38m5QMou5hitk8fYpCtgcGuWiJUH4stQ/qkMn0qe0paRqFszrv/nICrOrkNbXTk2HKCwj1DaZeDXCpUiObeTRv0nILVq15+uuW3g5ZrqskQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(261021121427099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: piUrox9yFgmwEmLbf34X5SFkxk7kWaoTDavNBSmoOJ0Jfn1eNS7gWlYnuX7IYXbEYY/cdJ/ZtVrZBFEa9BkCMV6hmWTX4+WGjWKSmXXUIPDhgIC1MNVwdAxYOiHAHECVYmmeyGIKcEZGtreVqXklRjr3HyxDcNRWnT2tfz/AW4ejL5qO5nEqGjji1aBBaZrDeS1JNtuK8h5LCOUwod3ouubcc9pokvMwSA5ketLJs15N4zsYe8snN6gk47UIPQXDgXGeeQSOz3ZaLlkfFw3G4YxOXVPAa8Kmqpj2d7Mt5vPrrj+RkZ4n9aqsCWQJL3i6346ELJkBOTOifNt8J7gExob3dyyuwTGjGUB3zfVjMdFGcKWPEgmRH0NEa7LLzMYfzjuN8rjEGNRfpMzsQCqM5vfS4uzHp1M2C0kSA4y9P349W2otedbVJrsJDY0DS8gj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:51:42.9522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef272c4f-fe71-4f59-8ef7-08df303b3933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add AMDGPU_METRICS_ATTR_ID_REVISION so a dynamic metrics table can
report its own revision.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 7db44fa24042..27c3c55edbe0 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -662,6 +662,7 @@ enum amdgpu_metrics_attr_id {
 	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR,
 	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_IBC_HSC,
 	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_IBC,
+	AMDGPU_METRICS_ATTR_ID_REVISION,
 	AMDGPU_METRICS_ATTR_ID_MAX,
 };
 
-- 
2.46.0

