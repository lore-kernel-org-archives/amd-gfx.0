Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23628C4727C
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 04:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D290207C3
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 04:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hx401u/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D290207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 316B189ED3;
	Wed, 30 Sep 2020 04:38:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81E989E33
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 04:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRNtM/D6xR2fO8yBBkYFZpoID9WrPlKr0+tA5yOup6y1G3Vf7kPhk9ZCCpkXrpLBEpfvyRSsdJr7Gw3irfLfemAwX+jqHc3FZH96knG4aLI/VMCrpuHEz626b8Xhh2PXO0Iz/D4A4wAH4msDesVXPQCkoY3wklxnNn+zg9mnXEnH/BpqVrSoGCr3SZrsO3LJfTiGSWZxUgtr9bfB215npJ6T95/fUhCfT4n/ZIAdYwI4lttW/cgGY8N9tWA6rAyT2UFzdhhgBIY57yY28l2CzDiUENhrXPYVIKJcpqveroxDFag1O4NoBkBrcP6LMG9Qy7D0I43m5sWobBOBvNtglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr3q8RCITNJwHqvM+WkEwRJVjoOcDPSvD8vbi3aqN1A=;
 b=KfcAqZdNL47TjIbTVw4rEnh7vE3TlR0qfO8coT0y3LrM/cdr+EF6rUG6+hOMF+nvcZ6Gd1LgsR1EvJJYyq1WrTA2YujwiMwp4Mi6BYu7vZgB9dvaulkRjG2Hoi4lza8yJLh/SNa3cqQcfIt/Cqh4USmVVGJjUSgGGEY+smmAzKq18KOjgPdPw+3AQbmS3I0ctFRca3OmXsHKfHGAmbn4Ft8ySDXz/5CTmJSMc6W1/+FA63Fp8bL2xEkXfSPTTPTTy9efCtLcar8uXa7/5LIbJ7O3YEJfJNQxiNflJI0kRMvQD5JvWn2S9ZVd46XKL5f9CBdbePwcG+A8uES0zLQchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr3q8RCITNJwHqvM+WkEwRJVjoOcDPSvD8vbi3aqN1A=;
 b=Hx401u/1lLXGyJUd9ZZdhFs2ZD82IAk1aS9p3CZa+m4IhTtuFKQpGPAOlSRx4QUt91Re+aTJurIBGlSU32MB/TfhSZsukuW6ULY79sK6w6poWYDXnwmbdm5L8cZgxJC5UqXnG73ln/mSXXtxzXjg8KQaoAUf21tpg7KQH7kQ4iE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0040.namprd12.prod.outlook.com (2603:10b6:910:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Wed, 30 Sep
 2020 04:38:09 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 04:38:09 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Tao.Zhou1@amd.com,
 John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v4)
Date: Wed, 30 Sep 2020 12:37:52 +0800
Message-Id: <20200930043752.25037-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:c9::11) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0024.apcprd03.prod.outlook.com (2603:1096:203:c9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Wed, 30 Sep 2020 04:38:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 888bcf03-d504-48dd-9595-08d864faa1d2
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0040B31BF045EF3D0D9D9E96F1330@CY4PR1201MB0040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sNlONNr5PyqsHkq/gMKehKNShXpGWOrwBzEPZAJRnMRZOVNOPTmdQxNhVqPMuaVOm3YBRGufllw+/F1UcYJHgHvhYRDdEphxmDo/ulPfA7ZuxAOvHS+4neAOgwMYSxLFOEtsdBbEhQfsdBjsYFWBHdmoss/3shYeeMwQ4oEaoEbYvL2eRXhZk78obmufWNRh849r+FMcMAk4FkRuMpILGF9CHsvXFiIHnGbhIdNhu1147hZkstilyqwkyMMMpw2+KffXU91qwew/UL/ucDeBMoXYSFM3ACxCyZLjLIIheUnj/GVJTXLm2PSp28Pbu/3sXDkPIy5T5ojfrZg7Go/qRXk/HDtTx4LjW1FHe46FR+ACCxrw5GYj87ypA7ZzQlv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(316002)(6666004)(956004)(186003)(8936002)(52116002)(478600001)(7696005)(6486002)(66946007)(26005)(1076003)(5660300002)(4326008)(6636002)(8676002)(16526019)(2906002)(44832011)(83380400001)(86362001)(36756003)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +twlQyV+MjjXcs4lvILCv9FMSwQbtoOarcY5aHw7H5bW1DmEU7ppsD1ZwfG8NxVCFwXO1JgtiOYzvkkh2cBnCUTkPTag6IXIDO3wCtBRmjgLDDEE4BaXE35zHZngJx4Kwsx0tUKmT459kMfH2adRP7Yj+N0ZYe1V1qQ6gIbrP/MJz+9/19lFO6qCxJZh8JfcucuBUFvoQS6IYtHOEdCY/iLNWWxvAPxJ+AlSC5V29LmY2SS3QPw0wOKgPpqu5qmPg+vTTOEOLCfCZtDexRHQaOBlPgEWhdtYShcTD+0VrNxs6GKMf3ElOLtTOFsZQrydWk55Eno4oBJPaNxF6GoJu4nmgm3Siw8CpFeeJj4sEtFYW17AXos0wtQPYHzXtSbpKERM9i7ugLjN551RmXHGdaX8vDS+b+8434oZmZa5SuA+7/DQUn9XHw0Tm47LNk3xNhPpFu2v0MNwCf8mr9EJGeZqCtaXwE85YezquAv0vdc5uC3RMYOQhSF/HbecWJTMM8EaOwhcl3cKmWv01oUjuJZzoooqzXHMOqWLswuXpRBE0/Np5BvEB9G/sumpX0oGm4VQvAQk6XEL50pS9NieZS5+wUh/dhNhbhx18HCUgSOW3v7ffVDWIfsbqOFSYN8Kg5VBT4HEyEKy4xt94P2YhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888bcf03-d504-48dd-9595-08d864faa1d2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 04:38:09.6717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XF656PYI8++6OIt/Ce6KqofH4e2f8BpfDXPV3J0jMAEkCFKLX+DY49V3Qfk3TXBPRHmsKh+PxwPZhjrG95KUXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0040
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The same ECC check has been executed in amdgpu_ras_init for vega10,
prior to gmc_v9_0_late_init.

v2: drop all atombios helper callings
v3: use bit operation
v4: correct inline comment, remove parity check statement

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..3784483badcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1193,21 +1193,16 @@ static int gmc_v9_0_late_init(void *handle)
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
-	/* Check if ecc is available */
+
+	/*
+	 * Workaround performance drop issue with VBIOS enables partial
+	 * writes, while disables HBM ECC for vega10.
+	 */
 	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
-		r = amdgpu_atomfirmware_mem_ecc_supported(adev);
-		if (!r) {
-			DRM_INFO("ECC is not present.\n");
+		if (!(adev->ras_features & (1 << AMDGPU_RAS_BLOCK__UMC)) {
 			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
-		} else
-			DRM_INFO("ECC is active.\n");
-
-		r = amdgpu_atomfirmware_sram_ecc_supported(adev);
-		if (!r)
-			DRM_INFO("SRAM ECC is not present.\n");
-		else
-			DRM_INFO("SRAM ECC is active.\n");
+		}
 	}
 
 	if (adev->mmhub.funcs && adev->mmhub.funcs->reset_ras_error_count)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
