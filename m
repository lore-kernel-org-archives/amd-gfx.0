Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC0DCDE002
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A264F10EAF6;
	Thu, 25 Jun 2026 08:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ObzaSBuQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D1810E1F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWXgsCejRG8eQ9qFfZQicBmQIe1xZsRLdbgubjU7svqxCC4vXBkSutQxQX0c4WtKUUsCHqw6IQVQ7oFFS8j1Rd7NyeqW3OwlMxoqZt2OH6PV8skd4zz/1QCPBvrkP83gudD3Gwevu+o+bjfi3m7dGNASNQUhpR2mtghjexZ3tOEVs5Z3vBn3mOyR8K9PxxdIE85Fak2UtP9IUqOTNLHDBTNQ8/4fp1gORuhTWriYI75AHWRN8Y7YQwF+2bNYqodjQB6pqz9rxbHGFKFWhB1ZZBW4//MBMB3Y2GVgchLsFi9SJej0mbWz5vwQ1xUYTUWzyhLu6nbfAT4UYVIZWaCPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhQATreeNVtpInWRNcUNW2lUx93jceMneYAs0rDX37Q=;
 b=tTIQgxsbSUBMOEI9H0jCbIfAZam5TqFIusH6NmeCOAfxUKqgoCNJlDp3Df5/jNt/pO0noeKBx8RlH6Z6Ls2ptqL9pqiJA7UBXQfgXtmsmjdrmpUx7yCzA5nVhZexgfgpGdRpr0vLtkRJFPcYmCyCxeVozpY/CKxZ83goJ86SOEVH5m7825unU12/6bSYuhHV3YYvxTelvnp0FSAvd2FJJI44Jsq8c/eQwgk5anxVDhOABgwWtMrqkeF+Dd2nKQn8Xio1qMttqRw0DM9s6N+riVkpc9/aaSxesmtamXTL9cY6y6fMev5R1i0e9NlFtZEHQjpttGHGbUSSt4Dfl72cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhQATreeNVtpInWRNcUNW2lUx93jceMneYAs0rDX37Q=;
 b=ObzaSBuQSKV+m8TXtMwWFoMfhHhqGtYAovMgSi7vn2EOUcmQjGSoctqeuK8d9U15Kizp+EfvyK0pKWEf+3c1SYCj9GAvXaAKU/CKv4FPYtN5IvfWQgR9Cf+KkafBMQosZszRitUvsElx8CfKErxFz4AW6l+jYH7eWGBVLfvRKF4=
Received: from PH7PR17CA0031.namprd17.prod.outlook.com (2603:10b6:510:323::14)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 08:20:20 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::27) by PH7PR17CA0031.outlook.office365.com
 (2603:10b6:510:323::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:20 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:18 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 06/44] drm/amdgpu: retire ACA support for vcn v4.0.3
Date: Thu, 25 Jun 2026 16:18:59 +0800
Message-ID: <fe107a864a947067c01804fca0699c35eb7d27ac.1782373701.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecfcf27-413b-4fdc-949e-08ded29298e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +fNgGk+QgBJl/aSRf0T71y+Zvtg0VRa+YGOfYuarTLKp9NFW3xyhNH4r16dIVIQ4LOREK6nkc2Qft0dMzuOZEqq2VDXTR9o0x5zi8HMZNu96dTQViggX18oZUG2x+yHB2lo2vbi0Q/6PDYg4TRJ1nFe9Bobh14gKc53I6OLf4oRcT187TJg+8bVIchPpHJT/NPYravlH+sgJpbq9IHqfIYhL/vMZMh2q8XUkKTwrPc9HLSO/oXNrMRL5PPG4C9UqFUhq0D1qpiB3VlS+gYItKiGCdIXNqA1tTHEaQ5+Fgh2aGwyTfPaZbuoLjrhXLqLxpSkOyY0DF9XTiS8Co3x8bDL4c2qsE+Mf70S7HBp0ek4AbUyGi5FL9VoWENPswOgGn97r23xYUzzlySYB2ggBkbo0Pn4t/BpufSykrSkVxHuhK9wqeTcbuXn4Nk4fpXBCPquqgx2kbG3pjiOEy8kDMiMweppREUO8xKPM7lsxjCWmMwbbYdGUEAdzFyLfyVXe8BiZKgm70ewBtxt+92JATVh2+IeL1yFQJCHZVWrlYB3TeuI9m7oBuhn3Yv6k++7BugLx7NSTIBSASwirnpZoB17pfeAoNm/Nza1/M6NaEEKsRNSn8lpJmj9SAaW/pCN9DvmrgATgz52IoCvKbm7Amiuq++G8sCtWzqeDlyyB+Jmlhmm6dzGKjeM+IzoNmpyT3VRP0w06QrGhZmWzfj6n5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZWQyCqz+hF7T16J4qk6a+tVokY3qC++UwHkgenSVUHEe1nDxIsESivnkYr3MkLs1Cd0zxJxuqgntr5wDRxFEbDx6dJ8mXOCQcwdYHcgz2nDnCyk/v4ANftPn5Q84CRVkBRTeXN5LwRIfNnJRX2XPoKmJJvCg1/ImQUl8XJWxg1ilnDR1EE2QxxRvhdE/hMnv87rb9pUWwtnf4h0TmZELPE+oTYVVhTlvj2LH4LL5Px0ZcE6rDBvFwDKiC3lPKZX/hHaq3Kuvx72pgdtRGMMonPyKstw/ik0jsUK5sPg6UVy0XsRTAhB6Latbg1KC1eNHZKfs/9xLUV2+5OGOr5SrxXY50M/cwBq0wDSIuvehrxVl7lVxGSS+MzHTgDkPLxUj954lspWqU4bRnAcU5pmI7vvXtIusszhSkTZcns5VMmDg0r4rhQbkRlRTDo4rC/aN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:20.4966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecfcf27-413b-4fdc-949e-08ded29298e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
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

Retire ACA support for vcn v4.0.3

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 70 -------------------------
 1 file changed, 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3c3f3d1a040d..179b892fb410 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -2163,71 +2163,6 @@ static const struct amdgpu_ras_block_hw_ops vcn_v4_0_3_ras_hw_ops = {
 	.query_poison_status = vcn_v4_0_3_query_poison_status,
 };
 
-static int vcn_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				      enum aca_smu_type type, void *data)
-{
-	struct aca_bank_info info;
-	u64 misc0;
-	int ret;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	misc0 = bank->regs[ACA_REG_IDX_MISC0];
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
-						     1ULL);
-		break;
-	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
-						     ACA_REG__MISC0__ERRCNT(misc0));
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-/* reference to smu driver if header file */
-static int vcn_v4_0_3_err_codes[] = {
-	14, 15, /* VCN */
-};
-
-static bool vcn_v4_0_3_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-					 enum aca_smu_type type, void *data)
-{
-	u32 instlo;
-
-	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
-	instlo &= GENMASK(31, 1);
-
-	if (instlo != mmSMNAID_AID0_MCA_SMU)
-		return false;
-
-	if (aca_bank_check_error_codes(handle->adev, bank,
-				       vcn_v4_0_3_err_codes,
-				       ARRAY_SIZE(vcn_v4_0_3_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops vcn_v4_0_3_aca_bank_ops = {
-	.aca_bank_parser = vcn_v4_0_3_aca_bank_parser,
-	.aca_bank_is_valid = vcn_v4_0_3_aca_bank_is_valid,
-};
-
-static const struct aca_info vcn_v4_0_3_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &vcn_v4_0_3_aca_bank_ops,
-};
-
 static int vcn_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
@@ -2243,11 +2178,6 @@ static int vcn_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 			goto late_fini;
 	}
 
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__VCN,
-				&vcn_v4_0_3_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
 	return 0;
 
 late_fini:
-- 
2.34.1

