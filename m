Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A97BCDB471
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3585A10E578;
	Mon, 22 Jun 2026 08:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T5xUOY8K";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A47F310E578
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDI+KNwaOfntNOIGYFEpraBvt74aZTnDbsvmyZSg77yG8KG4vlz6v0bUM9CuVntD2Eiyn4O+6QmTucbFxKi5pPNm6sWjeKXgCs98QddcIRmnWaRiyjnTyR3pXpUiNWPm0davoVaLW4fp5li0f6tuRBjMMGViZ3iMC9EBxGukyRefYlO1DHnft0Z0syXw9ChmFJ0cLdwi3u03Q9GBgSqYH0hgOFX+5bWD4amGy/gaPZt+qrK0LL+FyQvW778Gio3tLGNxBIckdyUGrlSG7T1sDRUlh1asSdldk1XWmiOf0RUe4uB5k6wxwdql1gg341iw9H1Nqe+b4wmVDC22IOwr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVFbNwnHGnVt1jYpuArY9dsMlpD9NlRYti/oWV4QeCE=;
 b=hX+WrC0y0oQrI4oZxHqaNdooqXd7NsfGI+aKBY9RxLwTGvxnLGunfCKFxvHwtB6pLaTlaye79mck7EMMkBHGqwpX9mKNFjrGLwcnqmAsVSLmCHlNPc5608edp5N8XNysZp8E+RkYGhXvQKP4tc1qmo6NUYDrgYbTOPiN7ChQr05M+WIOJ30EfOvHBce1CRI9BMckyRe0xUHycs5qwCGGW9xbFyOO+LS4hwt02Nl9AHK+Q2D8AIZ5xXA4zx7ZLhjJjjQ9f7dy++/x43WffYk51KlbnrMFwTdvmbVLHeDRcxWCtkyIWADCTATV6X303RR9KrlbUl2Org7kpjJ/NyMtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVFbNwnHGnVt1jYpuArY9dsMlpD9NlRYti/oWV4QeCE=;
 b=T5xUOY8KQOGTSI/+ZCLoxiccozkeYu/TmSUNdqW73GajbU9D53vqF89AH+4hspvHqYGo5J+GRVrmPMruk5YAh4pO57CpOBHTx/cXG0zSvpfpkZFsTofFlH9TVLrFrLDsvcrczIWfUoNshTsXBVxNce4hRtJYz646YpCbd4kHbfA=
Received: from DS7PR03CA0269.namprd03.prod.outlook.com (2603:10b6:5:3b3::34)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 08:46:19 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::83) by DS7PR03CA0269.outlook.office365.com
 (2603:10b6:5:3b3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:18 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:16 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 35/48] drm/amd/pm: retire legacy pmfw eeprom feature check
Date: Mon, 22 Jun 2026 16:44:37 +0800
Message-ID: <bfd471963fe007f2aa0de40dd71525f00cef0cbe.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2f491b-a4aa-401f-ee24-08ded03aba92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: w5RkrtqDMxRlKf4f5mgE8XHix4eLykWMmUpBchs4NktR2lTDBTyaG62Hx7QTxu8fpma9wiORDmVHfm9enNZby8Klg0PV8XVAXcLO6XX4powUkNtLcO1SWIc43sR2ZEwqCWk1eEBwPWLE2twK3BHf9zfymSRdcWQSDKm+U3gBilqoEKlWE2/s2eIKeJL1GJ+/gRs59ZIDkBspFI7I1h7dH0mos7gHqTqy5CBuPP26bbOazqwHSBNqFG1+CJ6sNi7i7IK476NQtPWb6ePgJKqhxrAZBO2Aq7iwKChDFoZm2bRJwOhk5V/8T4vs5yLQq47f93aot364A+xKRjKtDEx8W08dHpnnzOtQA2oz0g0B3MFPwjDDjBwu6PJXbwVJHLdkLBZWKN0W+DEfpVQeEA6tClBAMsv66hK7G61B3mDvUkjYJ5YHuIsBt6k8YRl+iQ4dzslKXRicyo/jIlhy8U++zeMM5fzc+yFJibVl48Gf2/ujqFdPz/LrOKxz/oSgl/BM+hlQsp0gztb6eXj8fWT/cXAOvdrDE0l1JmEC2UFNwdzCVPrBUmBTejdGaEuGKZfw/M6BERATGGE8uw1FnCG8yHCkRzjEmxnPicfZsMwslh19GKIan4iUErLgw3+lbY9v7yVwyIjWEyDsMm0tNa9zlhgjmkah8CtE/PE8uJhOJ5oyMrO2wzpUvAZ3UKZG82b4Y6xwS8MUAoROn5eov8dfNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2lIlnOTmHbcDvPDJjE6U9rYn/9yeT18yE6UvGq//lfsTBAKriwlFxkPZ/RRJRRSxmSePX1tv5agAt8YKP/8O1a8Bo9VIzySUzlF5GBkMAJara3tQl6aQltg9kVUeLOvWc8KipnH07wZJJwdms17CBg7bM+l/yzxtR6ZcoCtmubmEH1+MAiuPVWrRoyDxRnW80PvWu4Sbr6e7FEkuWr1dceg6r2SCHHlIAR6vhQaFwaHeNtKxIUEnAVgmLZbSJUWytXDDYRbt4WUmwvPKi6nXdb2XiQrEWINzRQtHkWg0CbBpll2aEOLNedIE5ffwr673WGhKDl83cn6iWMlqW1AH/JHtukj9CKn7TgF6NqQLYEmTzRoqWehGQQnHsA6T3inTMuZN7Q1gYKssrVT+bcjx0eVe+3ale572+gG7bSJYpJAzsCHxQwhSZKHLhd9FFkKG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:18.9183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2f491b-a4aa-401f-ee24-08ded03aba92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
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

retire legacy pmfw eeprom feature check

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 6 ------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 12b57a0f4fc4..0098e9414c55 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -1137,16 +1137,10 @@ static const struct ras_eeprom_smu_funcs smu_v13_0_12_eeprom_smu_funcs = {
 
 static void smu_v13_0_12_ras_smu_feature_flags(struct amdgpu_device *adev, uint64_t *flags)
 {
-	struct smu_context *smu = adev->powerplay.pp_handle;
-
 	if (!flags)
 		return;
 
 	*flags = 0ULL;
-
-	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(RAS_EEPROM)))
-		*flags |= RAS_SMU_FEATURE_BIT__RAS_EEPROM;
-
 }
 
 const struct ras_smu_drv smu_v13_0_12_ras_smu_drv = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 395b735dfa8e..966b2415d983 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3281,9 +3281,6 @@ static int smu_v13_0_6_get_ras_smu_drv(struct smu_context *smu, const struct ras
 	if (amdgpu_sriov_vf(smu->adev))
 		return -EOPNOTSUPP;
 
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_HROM_EN_BIT))
-		smu_v13_0_6_cap_set(smu, SMU_CAP(RAS_EEPROM));
-
 	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 12):
 		*ras_smu_drv = &smu_v13_0_12_ras_smu_drv;
-- 
2.34.1

