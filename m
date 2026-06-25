Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00046CDE002
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C8D10F19E;
	Thu, 25 Jun 2026 08:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="loszMrXP";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36EFF10F19D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLOiRYhHvqgjVxFTCk15HlE73XRc0Q7bstcv/pfEWLOFxUuocJt3AOpfaTMvY8OVOdUx5+TIvWngFdVsUtozI1rPBK9WtKXm7PCvbmqWwwFb1VtMoqlklIi18yyz214Jj8bJ/xEN73HSu/L/BgQCVaDgB2Uk/R2s6Fo5+x4smGMapUtcnLeU7a9O9XXevARwUpqziYRNEBx7nEB354nYLoQ1zQL7ihKl/Tt0nAtwBxqKQM+6F/5YTHeL7wIjKpWaYu9kianSW030uLIDM4iv+vC0nLd6IDtZuxXlkqPA4DJzJT4qTRTpxy8XP8siCsOnMx+laJ/FxZjS31FrznZeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDfQY3ggAbc3c/0l++f+CD+SRSEY5/vaBGCizK8wTnE=;
 b=uGFvfm5DDZLyF1U+rrdfVuCSBfjtgMY1yQb6H587B6HMb7NDxQtm2MJfVhQFHHSOroXDHgQLSj4Hk47eZXSQOf/I4nd4BPHeJVScA/D2WYX+TriyC1o4exiFuQNpxhGw9n4/F6dFTqkIxXGmm3MYATDTYIN22ZMCEPvA2EzSvkTl6+5H0I7icrFN24aDSWmyNJxU/O+9wLY/VgTmQ/4Yoq5QSPjfNEWRtQs8Fw9B62dxVDvMOjKUJilSH1VkSVGPPR2YPRa4LLd09hJhtgeb1kgysksMAxOmlLJhOMfGQwvIbrtsEVCVIZqUDeg321eEWXOym32btY4mZm/zxbLkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDfQY3ggAbc3c/0l++f+CD+SRSEY5/vaBGCizK8wTnE=;
 b=loszMrXPZiHfL9v+i1orfR0Xeat7QDcYgCbJuoosDth5iFTDm4cpkUGqgBjrfo13Ww4nZpzYTJQlsd0zfZrozigdIx/7WtOCbtkzItBy0kh/F9cEE+qtYLYCx5/Rxe9kRnZp+SIxq0avTWNm6ic+wysBumPx/06FhNPQtkGV0ks=
Received: from CYXPR03CA0060.namprd03.prod.outlook.com (2603:10b6:930:d1::6)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Thu, 25 Jun
 2026 08:21:24 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::4e) by CYXPR03CA0060.outlook.office365.com
 (2603:10b6:930:d1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:24 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:16 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 34/44] drm/amdgpu: retire legacy pmfw eeprom check
Date: Thu, 25 Jun 2026 16:19:27 +0800
Message-ID: <175058553fc44e64cd4da19eb614a1d6c3a949d8.1782373702.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: af0eed96-c3cc-4d8f-8bbf-08ded292bf29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2zD127MyhoWEuxnx6LacHkfKEEcU0AI6aa1AueNRvRqIqBpYB9XngVZREyR5aGX/wxVenjY3F5fy0iOMGfD/VpdmusD65MWpaS/L1mMtPwKQ4kBvmY4itWucbcsnszImjATbuPrXaySRNfIZaqnd2Ul3LJ1dP+SzLVfs5S5rl4CC22+jmNRO5A3ZW7wtO48YbC/x7w+0oTsQZuIL6RPTm/2b0CeLsghkIF07jE3bvD5CNf0tjKGS5V25fRj9c7cYN3OoynN7lX9TvWM2rqZaZu1EvKsvGO7JJqjzNmCkWlkzYN+Gnj/m+OSQehrTMMobSK6TuHC9q5/M4rEGIrm4Sdz98UWVrsfc6ZneZcQ91aCA5dry3q2oeVYuDVXMGXLJY97lRQGTUKhGVmNMxXniK0JS4OcgKZzsm+ApqffubU2xYmHiYjd6VSFu9UAG/jl7qbcZWOqLY54Kbdg9ifxbqOlRVT4NHgLf7LsVn/4VewiVkaniBwOIpeHdAeM3QGSGi8EyVIrY61ETzVH0INgIK48BN9Ub5arrXi7lrekm4AenDv3t5yMIDH0/bwGC1FIJEmjYyi4HBKEs20tdLiRvTJGluDI/J4pYBcowZ1zWc2JSV2kdvqqnnqfLGrzpg8/eL5JEQOb8ZocTwCs0MGBIU8wppTx5YZBJ+CJTboFeeQQOh5gSEFQM9LBkhR3pm8r7bJQkcTv9Sk1huW2n+IWT5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R3ZjbH+/mSt0EcsaylmNW6u8mE4/Dc4EszdsAHfYiW7cEiTkvCTm5mP+5EqyDXRFXE0nw8KL0tPZ5caPJa4rfP6PYaACL2v+Be3bt0c6ULAusGk6IF2/9cgimtocqdHf06nGKex9J5Z162Uq7wvj7SyHb+m0Z98wyxUYNpaQs8/1QRi3de99oUjpj+j6vUcN87s06IpRVGRq8v8JjGJr+eKXQOSt6ykWqhhkkbUdjGGRNKVLCdQjbqFgPfso1LKP0BFB1Hfrx4uryXN8Qll2grFIIrbxb5AWtZ7TZmU+DyE4WTdrHjt1SDJJu/d3b0Chm1ypStRL3izCLBejqtXJv9/N5rD+5BJSvEd+Q+eKqXnHl8UjoHvwSYsgp2G7+lvkAFKJZC0RHHQbkhyUa/oQc+oDkOwlLLkc/98AurTg9uFjZkDUYcCWG1aFyH6rd/At
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:24.6539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af0eed96-c3cc-4d8f-8bbf-08ded292bf29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245
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

Remove the legacy pmfw eeprom check function, as the feature is deprecated and unused

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 44 -------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9a9633b57022..f5d1bc1142a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1627,47 +1627,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	return 0;
 }
 
-static int amdgpu_ras_smu_eeprom_check(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (!__is_ras_eeprom_supported(adev))
-		return 0;
-
-	control->ras_num_bad_pages = ras->bad_page_num;
-
-	if ((ras->bad_page_cnt_threshold < control->ras_num_bad_pages) &&
-	    amdgpu_bad_page_threshold != 0) {
-		dev_warn(adev->dev,
-			"RAS records:%d exceed threshold:%d\n",
-			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
-		if ((amdgpu_bad_page_threshold == -1) ||
-			(amdgpu_bad_page_threshold == -2)) {
-			dev_warn(adev->dev,
-				 "Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
-		} else {
-			ras->is_rma = true;
-			dev_warn(adev->dev,
-				 "User defined threshold is set, runtime service will be halt when threshold is reached\n");
-		}
-
-		return 0;
-	}
-
-	dev_dbg(adev->dev,
-		"Found existing EEPROM table with %d records",
-		control->ras_num_bad_pages);
-
-	/* Warn if we are at 90% of the threshold or above
-	 */
-	if (10 * control->ras_num_bad_pages >= 9 * ras->bad_page_cnt_threshold)
-		dev_warn(adev->dev, "RAS records:%u exceeds 90%% of threshold:%d",
-				control->ras_num_bad_pages,
-				ras->bad_page_cnt_threshold);
-	return 0;
-}
-
 int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1675,9 +1634,6 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int res = 0;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return amdgpu_ras_smu_eeprom_check(control);
-
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-- 
2.34.1

