Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC6ECF9C5B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 08:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E5110E177;
	Mon, 23 Sep 2024 08:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YiJExcfA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCEA110E177
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Sep 2024 08:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8FK8wMKc2kWisqHuOv8enzFx1eGO61llQ13vMR7H33jwTSYS8QqwKOllGWMRkpKT574m4rf+IqcCu12trO5wgtV1e8aoJWJVUUxUgQ7odqVJhpWTDuITO6mHQHYmrSO11gLb9L77TliO5arKMK15S1unZtvACbejRqwjjtp0VyQVAq8kG1pe6Lm8J77WoyDclvFANACMkPmcjFa+D1JtAf5hV22myymZleuFaPRUBd6m7xuQEQdz8B9KHvus32RdxI/KAG0cyUIDB2d57oCJSYzzINScXT4PI5Eu+hTI4O1vaz0TLrmR5AZgiihJsbhFBdouHKGXrfx8SR45Xzq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYH8+TWYypLtF0g4Js49vFmkmd6/60YMq4PQgu4r63Y=;
 b=WQ+5aqym2Q4gFR8aZzyAr0ZqBxjufEb+/BE8hOkETlZEOh+qxgjc1vu1ziRruLC9b94SqYfUpH8AMr+8jCp/MrY8pwWn1QI5Z8kb51O+WyVfBQpdGAB8d2xi1Rwskw9A9TFtAmbuOpg04GDYnld8YbBlGFpas55zm6l65ZBAz5zUUNPcJACEImD9KcT9j+Wnqoqxr2bDfiWSxsiH0YEbQ1k19HZJ0JLdXCAzwEmXAPuiUaBJs4W1J416Dc6BK0yB6GCerPO7qU8fskHw7avwp2InbflAedLHjrxCMiFMzxwfVkpOXkoE5KS8W/J+s6lPN+QD8L7EeXlzP0ysQVk+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYH8+TWYypLtF0g4Js49vFmkmd6/60YMq4PQgu4r63Y=;
 b=YiJExcfAshLp6JZtpfbS1G1rKf/GRH3Di95ZamyHieUgqBX5xK1Y+wFbYYtxGykE+1bUN6wI3MF+rHmBs2vXS8zDGmL9pXmCt5rPGsWxz6Zf1ZHkcEj3IfByWw8/wyDk5EMCeEejA0UDF56aHExAVxma2KeYwjXfHC+Xjn2fnDo=
Received: from SJ0PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:33f::13)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 08:02:28 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::ea) by SJ0PR05CA0038.outlook.office365.com
 (2603:10b6:a03:33f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.15 via Frontend
 Transport; Mon, 23 Sep 2024 08:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 23 Sep 2024 08:02:28 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 03:02:24 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <lijo.lazar@amd.com>,
 <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: drop the UCODE_MAX_PSP_PACKAGING checking
Date: Mon, 23 Sep 2024 16:02:11 +0800
Message-ID: <20240923080211.715446-1-le.ma@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 9654547d-6d66-4c48-25a0-08dcdba61160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z8dFA9miOaVI2ELXoLZH6Q0RTcpOfU/z630f5ekk07YPMWOyvsLFXnBORVtX?=
 =?us-ascii?Q?Q+Nfq9nC+yRZ00uzWzBQT+blqW8zwmjJ39SgE+DKdktL129aytUyllnmNYHq?=
 =?us-ascii?Q?2+ld70FLEN0KeH+REFl86StD6NSYQQzOQiATllW2VJM0sTbgdh59Fq0z18bJ?=
 =?us-ascii?Q?sUJmtdLwlpzQGaNHR0zzW3zjO3hNtsSeZtRqyfunDPsLX+Nfd1dvDT1ZiPpN?=
 =?us-ascii?Q?6KneHWYt9CYlvTlfmAElqdV4roNbodVBnptFXZHMkb0OwKl/NWMRFkceDWwF?=
 =?us-ascii?Q?OfVm0s2R4goew4m1Lrt8qaVESij5kpjEo7CueSTvWeVilWbXXUfm9AG9Iwbj?=
 =?us-ascii?Q?wLN8XM2N0EbL2yyyNPplXiJxFiy/p9XNspqJl0oXH23m82HMIBFdNYFP5egd?=
 =?us-ascii?Q?0WhczGzGuHPmJ9+G4BxiW+uOCnAY3dsfQZBHas5zCkkVruRFTxg7WfLM+XI1?=
 =?us-ascii?Q?UFH6dsjC31zpOzXv8gKARXOgmpzD7vDUnR7PQ4cS7xhORvtRQCDqsZe51UK3?=
 =?us-ascii?Q?apMwh7EOcIVe6RIL7ry41WxQS6SoLW8oEXQdQv8L2PU9b7ayTxA9g2nI3ZAG?=
 =?us-ascii?Q?s5ZvyPvbGJZ3XJjfm2xbwAOFGA/mh1rKu6u+On7yZAPqEfAPv2rlg/eGMwpj?=
 =?us-ascii?Q?DiDnd6r33vNq4/K140RHS859+wHFFV4hp/uzwzaU2AzxrqLn3wliKVU2JGwn?=
 =?us-ascii?Q?nYi8FND1qUIfKjIq1KwgKOzpMjgMwqEeOz3C96PynfdmpyCC4nHVL9oik/WR?=
 =?us-ascii?Q?2hCETaUDFvja6Uwak0BNl//5bV7p0UR8YAsHsrcont8D3BUJATg+kuLwV0Xg?=
 =?us-ascii?Q?iRdst85gEIJUfOigWZmlKXsxB9OM1mX0zoJLgTu5/XfLrMh5QyC6/8hmUHKl?=
 =?us-ascii?Q?4r5u6i1y+hZ4xrlC7utLuFVdhyBnHc1LhkE2pMd2r/b2+eWxQfSQgfwf5Hvm?=
 =?us-ascii?Q?TpIc7UxQ7ZAWajWqsyBToCKz5hVVbkBVT7FMRTYzYUEYOYAfmPYP1UOKEi/D?=
 =?us-ascii?Q?Zrh/RdoR/6OYOkUk/td/otXp5AtDjxZ1Mh/Zhv675tFdW/HM4dPYyhgHpVtT?=
 =?us-ascii?Q?mYeTNWZNdUZPR/rp3dUP45iwyxRnnY2MK4CeeqJrKzRJC7Va4MG5t3jq86N0?=
 =?us-ascii?Q?rHtVoM5S1UEeD3Q9u41Hgc8TAxLJmRpHf1/SwE4bp5RwQleUD7Ot3G2ByHX9?=
 =?us-ascii?Q?Zk5DqNr20aGB2hYTnAvICDv1rip/IMpD4C9i6Li4vtVehOjlL6DeAS255Eqx?=
 =?us-ascii?Q?NuOgP7/kBZ6lxcMYNqpkXXaNfE81SnrIhCYQAehnO/5aQDIZFGeHLmbJHs9f?=
 =?us-ascii?Q?P0mm314jfTbeUloM0K3dJSpk6fliC5gMuPNVJtbS4UPet5RKNZm+qM8z8ojY?=
 =?us-ascii?Q?9B6sgUkc0+2yFVQYNIuY6gB7XF4J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 08:02:28.0773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9654547d-6d66-4c48-25a0-08dcdba61160
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164
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

This checking is not suitable any more after introducing
psp aux firmware binary.

Signed-off-by: Le Ma <le.ma@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 11 -----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  2 --
 2 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7452b2dd775b..7b8469da3e2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3484,12 +3484,6 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 
 		fw_bin_count = le32_to_cpu(sos_hdr_v2_0->psp_fw_bin_count);
 
-		if (fw_bin_count >= UCODE_MAX_PSP_PACKAGING) {
-			dev_err(adev->dev, "packed SOS count exceeds maximum limit\n");
-			err = -EINVAL;
-			goto out;
-		}
-
 		if (sos_hdr_v2_0->header.header_version_minor == 1) {
 			sos_hdr_v2_1 = (const struct psp_firmware_header_v2_1 *)adev->psp.sos_fw->data;
 
@@ -3653,11 +3647,6 @@ static int parse_ta_v2_microcode(struct psp_context *psp)
 	if (le16_to_cpu(ta_hdr->header.header_version_major) != 2)
 		return -EINVAL;
 
-	if (le32_to_cpu(ta_hdr->ta_fw_bin_count) >= UCODE_MAX_PSP_PACKAGING) {
-		dev_err(adev->dev, "packed TA count exceeds maximum limit\n");
-		return -EINVAL;
-	}
-
 	for (ta_index = 0; ta_index < le32_to_cpu(ta_hdr->ta_fw_bin_count); ta_index++) {
 		err = parse_ta_bin_descriptor(psp,
 					      &ta_hdr->ta_fw_bin[ta_index],
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4e23419b92d4..a06cc0a155fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -456,8 +456,6 @@ union amdgpu_firmware_header {
 	uint8_t raw[0x100];
 };
 
-#define UCODE_MAX_PSP_PACKAGING (((sizeof(union amdgpu_firmware_header) - sizeof(struct common_firmware_header) - 4) / sizeof(struct psp_fw_bin_desc)) * 2)
-
 /*
  * fw loading support
  */
-- 
2.43.2

