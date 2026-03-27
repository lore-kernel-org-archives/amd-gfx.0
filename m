Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAA310BA432
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 07:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F76110ECA8;
	Fri, 27 Mar 2026 07:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3vn47Z0p";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114DE10E0FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 07:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxcndN0hvbhlw2DFNMl2OZ/pH666tX+FnO9WxDW46BH7+ZIk/MlrpU0zI6VpeF6IX77joWEloPYj7GLtJ3LRjagljZHwHriCfiLcx71J8FAN88hiGinNYWCvERaq9lbbNH2HhaAVzmwCPvu2PJ93oB3DkWmW2Lm1HRcWUx3bWCh0YAdWXQbLORWxPOEntdkib0jfzaVyBrjJshMeK+pgeBcjj5iCEpHPKetlhn18HVUNFGW/YPhJtgNJbgJQHfHZOniIziLxV1Y9niAosQ1B47oViNNQ3l3mCuxER10MYp8TJb5MaT4pDT31l1EJhuBROmeKNLreqzBD+WIIekfL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MngvZRdqdvOu37LmCeP1RAdsuoS0A2ip0ySm8QnIOw=;
 b=tcuuUcRlq7eUfja9TlXLwMajJnxSaPolz9fAA5LFzJPGrOPYNQUX9dHw4YACZrMKjpI2CsgBrjzWVfdYOWidZIf1U3Mrrrt3Sc1RuY+azpTO3OKSHc2WsJ6oqQy2VMxjZdKTmtkJvTF+LJqLTBKlKPYhh00J9OI/APxITcmSC/Qmu0HyAIQzxx4F1EKR2qrOc8LMNyRUY/LRckhH736MWw28aEie6YgewxvY0jo7Ft8uHX4PPDwv7y3Z9TjHsaLUXlNl+/H9IQzaPITHdrzBdJADWoI2SpITP+k0lmXgxWQzwOzXCE4pJAd9sl5YMZk3gZHqWY7AhMJatq9tzogFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MngvZRdqdvOu37LmCeP1RAdsuoS0A2ip0ySm8QnIOw=;
 b=3vn47Z0pJ0JCTc+SwPyq9yEktMa2WHOzUpI6P0K7GzPt2OHJyjZTWC+RtELHn6Tscbwtt4+DRs9f+gwXsp1jTw0MCn16SF4+ytz+MVUd5RVsj5Edh6wmajChepAyPpFIcZVWvzxiCbUNcAhLIn8KARyblD700FoLfUzR13rxRYg=
Received: from DSSP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::12) by
 CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.7; Fri, 27 Mar 2026 07:52:50 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:3d3:cafe::29) by DSSP220CA0012.outlook.office365.com
 (2603:10b6:8:3d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 07:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 07:52:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 02:52:47 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Add smu vram copy function
Date: Fri, 27 Mar 2026 13:22:29 +0530
Message-ID: <20260327075231.1413092-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e48784-2572-470a-76ce-08de8bd5d76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: egJJmb3dksCUE2ewI+rXV+GJxAGzxQBDVvw1uak6DN+aBYHrjIDpv14ce6GfmGvd2cS3mF96Y8eXqFu7UI96b3NZtLTGvpKmBSSvTzuiioWgF6/RNagcvEH6vju+H9n22zyQ3ublyNDfL66z0Soag97qAT6N6dU4PFkKAFs71+LNhq9zF355xbmzozWGxI0TJeEBUk7SUXegveCB0l14j0ZdV6KcPBRZPP4OY2lP9SQuGRN9FRgKvQOa9yb3O8QND5B+5eCIe6f//UbYlTgEU4V+cGWQ25MyKpS9OSiH29yYx1pxme6Yq6TXZF4Y49ntJBZwlCHCBRpMrdtQW4BVIX7h8y3mzdBnAQ1RVxBdeoDpe8BElnBcsRJps56G1jkhz1kXBtgg1FuSnHTQeAb2kJiqNDG4CGpY/bDgrQFhdZpxWOjT5crDwlQ+kpl7GTCIc8jdwk5Px5zgtWFQHiGGuS5k57dkZeTeXcxsNu9MyssvzP0W+QJXklpckxjAJnDxyZZ767IVkbyEx5T84i68JLl8fcSMSNiNu/IJARYtQVQQe92HViMmUiAqKeLTFDDf78C8yCFUStYxy9HVZwDntLvZdMYs9a+lAIYEKOAeKT6Q7uOof8pSvaG0uatYJUBcURaaFC2BiQ9ptW0/UDh92Z+UzRprDrL0szP4qeuGgRV/mSDh/AGpzuuLrXGifr3czLZO36pbgDdHDgvC1cdoG/LAAlC93lSZudDZFBqzQoSB2fOYOYJO/fdD27rizia1Xtdx4r/ArytzP/QYIPTNdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xx0WJCdOLmzpH1KoGshhP8HOx2MnqJiS5QQOzkMgeYRDsLPvOyZEucpRSV38UzxUGSyJQry1p+wdC8lQjQu4kJkA0g41FK3mSUqzfyu8tdGg2acQu9I8aoAJ6tnJdBUTPR2xKOGq32NIf6HvtrUwyDCKJW4HKxU3VgIGKdGwe7hlPPLcJakMGhQkKjpeAvWbT6jVW/VAMnAI1yxyED6OW+nW1bG394RTm0v936hpjHQKdVAzYRpc9Zp0JAVtz8sezHSAjaM7AILTEQfgFC3092yOf5nfjQh2DMzsEqYcEKMm5QIzlJKziWEcVHLnUMKsaVvXxVRy3w7aEwMGbQ0X63vpu1w4Vo3HG/cGHWmFiFskAkg+eD/p3dtOnZoGZB8X7g09LDJNJt7s6Wvuhk1OEMtLNZPdWD0xnnKmmntRyDP8wQUM5LdfHzis8J7fuWoh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 07:52:49.1142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e48784-2572-470a-76ce-08de8bd5d76f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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

Add a wrapper functions for copying data/to from vram. This additionally
checks for any RAS fatal error. Copy cannot be trusted if any RAS fatal
error happened as VRAM becomes inaccessible.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 7bd8c435466a..006ef585a377 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1104,6 +1104,18 @@ int smu_cmn_update_table(struct smu_context *smu,
 	return 0;
 }
 
+int smu_cmn_vram_cpy(struct smu_context *smu, void *dst, const void *src,
+		     size_t len)
+{
+	memcpy(dst, src, len);
+
+	/* Don't trust the copy operation if RAS fatal error happened. */
+	if (amdgpu_ras_get_fed_status(smu->adev))
+		return -EHWPOISON;
+
+	return 0;
+}
+
 int smu_cmn_write_watermarks_table(struct smu_context *smu)
 {
 	void *watermarks_table = smu->smu_table.watermarks_table;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index b76e86df5da7..d129907535bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -174,6 +174,9 @@ int smu_cmn_update_table(struct smu_context *smu,
 			 void *table_data,
 			 bool drv2smu);
 
+int smu_cmn_vram_cpy(struct smu_context *smu, void *dst,
+		     const void *src, size_t len);
+
 int smu_cmn_write_watermarks_table(struct smu_context *smu);
 
 int smu_cmn_write_pptable(struct smu_context *smu);
-- 
2.49.0

