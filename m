Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AC2D72372
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 11:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8677510E2A1;
	Fri, 23 Jan 2026 11:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YKB5uazw";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0611F10E2A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 11:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+wb/58/eIeGqg6fgOaV2bnf1aFaCgbWObj8vUGAqRYjKLRBZzRsbCfrHBVI/GvY2wNyFw4jMbimmockLY/vhFuWjym5o6xAsFSgOKG44vOSLHyCPyK2uqt4JSk6nMzZVHpKhHS5V5NPLtT02it4j2Kcvcn60fcrdSSBxaWAwJG0hzxWixeg2d4nsb+S4Zh19Jo1TQ3XyRfJfiVwJq/U3ELcGro0fce/nbtUDvmvfZDc6a2Lq4Ld7f/cjpLNuwhoCIrOtQUXmP6MeCDRY56At8y+8NEJQ2qItPsRfDO94hRAqvdb3gTa7a6E9JQ3uUKvyhsnCEyK510EferOpsjmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDo64o4Rj3VAQdWXiqMfDBbBHU4+2mQ4TnbyeAk+2UI=;
 b=Q1BqduKIepj3xAQxGJTPJesTm8VcfEF5cPWmdU9/K4/DD3kV5evSO4y7Z+EblcwPmIN+eIBEdfMBbhfUIH5jAynd5yD4f0vAMxRpV5yiiiTF87UJwqugq7P0k3zHSYiGyQ2nweONDvYuWhndqr26r/acFu9uMA78yFPWUkkG18x6GuH05si7UBxQsrj9WDZKp/KRoNnVYdKDTKcQ8ChGMnWer6n1rGQJbKiLKvJuAdsL/o3ng3bNIXpe//rigZ0oJwIA1hibwPyHecPrBhcCLFARGug4cGRzLTNw4ts0k6ekHwGnni0raWdUI4Cvp0Mm4I1kzsvOWXQL/VSbWVWJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDo64o4Rj3VAQdWXiqMfDBbBHU4+2mQ4TnbyeAk+2UI=;
 b=YKB5uazwHbDESacqTd2w9yqJPbNxia+Qj0fv6Hq5Ei4AnenKijfGnqQ8aZvt5jSN4Ryqnsna4D/jx/b3+r8kAJB2z3QTGjPG+crbrUGB7bEktqeXEzOkr+yXiXupkfeFKS0VoS1lyrybkTf9jiKOpIGcRJjJLStM6b2pDsWkGhc=
Received: from SA1PR04CA0015.namprd04.prod.outlook.com (2603:10b6:806:2ce::11)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 11:27:59 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::f7) by SA1PR04CA0015.outlook.office365.com
 (2603:10b6:806:2ce::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 11:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 11:27:59 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 05:27:57 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: statistic xgmi training error count
Date: Fri, 23 Jan 2026 19:27:42 +0800
Message-ID: <20260123112742.3855999-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: df2b9f94-f024-46fe-0f7f-08de5a72764d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?poarUm3pkj0zMj2MRlyJiBJTtj9W46ByEhQhgRsId7espIUdGckitDZMUunF?=
 =?us-ascii?Q?USBBTX7brHBQM1ota5uGJlLDgKT5l1yXpOFSn68idPPwAvSzVCBYfyYhnOBI?=
 =?us-ascii?Q?cBvvlib1mYoYTsSjkIOJjhThW+nfjx5mFbCX67i3cOzco5Noel01MGuqIykP?=
 =?us-ascii?Q?/rypcIw63/Aqq/i/4bpGZA9+xtstIXDeBwyuqyC04l/uS6fEfcq54eVXdjVb?=
 =?us-ascii?Q?YCHPbTPVDjEDxETeKyENg6CyvRe8237kxD6rRgNDPqzbz8NYRhTPN/pauclw?=
 =?us-ascii?Q?hQEl7dMnkQQxN+9jVap8Mvh2zFIBDOZt88ks24u8eRkjYbQtkod3SYG5jtC1?=
 =?us-ascii?Q?T1R1Y9QaChJbxWGQNo5cUIEUyfAJ1cMUZwUknPUgnwqPEWSgklsdn5az3/Kk?=
 =?us-ascii?Q?0HfKYQ5kaHTLMLLGFuFfOb6tr/rgynAOxNj8pGWfJdBHwhSOqweMltxFqvDo?=
 =?us-ascii?Q?KSCtHIBDTf9BYCi29YRy9SGmKH4sph50spLizS+mNauPG983KMlRBt6LzLLg?=
 =?us-ascii?Q?G8Sy68vP/fqVmf5aYz+dgOSgQhCjL4wE/cDKpaOjoQ55KzBoneekoyNySWBV?=
 =?us-ascii?Q?BlHED3Cpp3tBSPRiGZp7YIhhPD7aOqn9QcwdDvpPmNyzPvnKl6HGDim36DSz?=
 =?us-ascii?Q?WgInytGYLaxZPoPCWRTFcuediJmyWD6IOKoElQ5ELu8Crl2V96QzjpWT2SH9?=
 =?us-ascii?Q?YHl0Z+LFGEZpLxr+hUS5hzRrsokKprLOz9x3l5PWiar8Asohf2QZfvdoS57B?=
 =?us-ascii?Q?ea3TsI2PBN/uvlgMYHk8OPoqLRJOobZevDSmGQTOEsCsMYnSRkhoFeu2EgH1?=
 =?us-ascii?Q?ty6fk2G3WESoFaesvb58KLlEDW2eTPfNTyCfBC4GVcJDiqN1D1jX5+4Zd/2a?=
 =?us-ascii?Q?RbvlRxjD+y6JrLJTGChYnBIhemXma02anTu9nnxMjNIvhq1BL6yZlvm2nsbd?=
 =?us-ascii?Q?rIiqSnzNp0xcyKejMpaZY+2B+j3WpcF2M4XmiptnUZBJ3kYDNilhpEb9ckAb?=
 =?us-ascii?Q?YyxStf9Qh6hJUBvWZqXcKDmlcNiC0kLGXg23iPQZJ2tYVipijLEsBBtdqYWA?=
 =?us-ascii?Q?D354j6ISX1wddLFgXM2Z6zguXOvSFAuaRuR71TgWZIBMTqxxRnAChyvHkM5f?=
 =?us-ascii?Q?N/lTA1x8iI84q/knMxVAPn1uXPsEEziiXZkv6mufWd9RueaEhxQKKckM/Ir2?=
 =?us-ascii?Q?DMgvH7SBDkDTmsYZeylE1EkqWLY8hss0Q7DXLRTCyUGz/GTtIUKy3HGTGEts?=
 =?us-ascii?Q?wnNe2tWdOmiK3p/vmqkF4uE1e9ZVR28pow7nUcnn6ScktyZTZFKDhrmE6bJK?=
 =?us-ascii?Q?Jc4K721WDTlR6O4q3EOHcf7jbNHALBi5TmKt45+CpDuU8TPn8PNd2/NC8irh?=
 =?us-ascii?Q?O1E2sRqPTY3uJ2d6g9pA8B7TL5+yrWSuq58crTMztRoBZnm3R8ugl3qh5YBq?=
 =?us-ascii?Q?RGLhUmzbLNwtXOwbA7O9uUfzffhism1G2PV2i2JNswOwDJOVh9Gn5rgEQDR5?=
 =?us-ascii?Q?4sZGfnlayvhrO5gXFwyP37bgX26kPEnAmjEJotK1iQgYwvqvgYhldSaehQ8O?=
 =?us-ascii?Q?TUenvFj0WNVA+5BinaxUOo6LCPR3Lfqu/q/dkx4iY5BAiGszDI76O8jzKe+b?=
 =?us-ascii?Q?3yHEe2C4mZ7sZLwoFUttcUqQMn/GI3yRKsHlh5eTXYRrpjf6R6SekTSW8f5n?=
 =?us-ascii?Q?PeE0Sw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:27:59.0057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2b9f94-f024-46fe-0f7f-08de5a72764d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
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

Report xgmi training error uncorrectable error count.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 95f3611d743b..a220fa6dcd6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1199,7 +1199,7 @@ static int xgmi_v6_4_0_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
-		if (ext_error_code != 0 && ext_error_code != 9)
+		if (ext_error_code != 0 && ext_error_code != 1 && ext_error_code != 9)
 			count = 0ULL;
 
 		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-- 
2.25.1

