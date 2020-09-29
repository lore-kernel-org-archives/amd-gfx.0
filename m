Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2D8C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 09:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF0B2076B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 09:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XBYevcXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF0B2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1ECC89BAF;
	Tue, 29 Sep 2020 09:09:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762CF89BAF
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 09:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHaIRTj6pn3C/YhFZlIJvq5xCFJVv7Gp2P8vWKOSqoMzlOm72bVCLnFikqjqrScwz+pkSVaO1VbzBCDBpr0hCKSUEfMeoGy9F5fG3+DNku9k1VzWsL3CGDoo+8ewaN20QAxB1axidZ5LMurYrzb5ncXFCFH97zMUu1YSfUy+cu4tvfUc6PkLLL5e6dgJ1xYxVZRb4UmOAq2plGUNc5VvTBfbiE2Vvei+mpai5GRWruskHsQDCjAl6OQ75ZfmS9tbRmtNcgTXb1XTitKG0FtSeHzECfhxeds6ALZwW5QEG0pCssNlbeQryLBSqu4zGP+kJ6e184uyv2lFyYr+XZFGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJMO6CtteXtXBf2RV9EM+2TrTVpZAhkI7SnE6ZHwnvc=;
 b=OHSpKX28VR3+FfI71UZ414Q2+30CH8eN4ATWdIoBcgmQzLw43JGmftUsnuIxRfdlYMANH4VveEeC/59ch1tSHr2j87jTp8ikV7EdmgVenzmiC5x3DDkM7NPlRcZBJXEP7+ElOnQbMHMw1tPG1ZbwUGshPH5NNt6OESXNu6n04BYtfXF6oyU9NxChWChI4eRD1aqffBeFXGmij7ZjAHGyKXb3MDX/2Xdh4TjwflzSbCKNXQ1hcu506lVoAXyrONd6E+QlE1lydPF4tym130uBiFO6f6izDRAZvH2lJeUHy5czG++6w+e9lDmLKwToz39mUc2FaaERK+iOV0fXA5flbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJMO6CtteXtXBf2RV9EM+2TrTVpZAhkI7SnE6ZHwnvc=;
 b=XBYevcXTyrdtT+Eiaqv5xk9SCDXgdnKf6W+C8G6TSySzQ/6dr5V03iqksDqMo9NYGx7/ReShTz8qpyL2uYrDUXZuTe+2p91u82BMrVSuCtYiwDRD4rHFBYlqV8iJqppH9ima7+dZDqBH9DjbuOU5fGqBxLjgTHpD7J4WfWI9kBs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 09:09:16 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 09:09:16 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Tao.Zhou1@amd.com,
 John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v4)
Date: Tue, 29 Sep 2020 17:08:57 +0800
Message-Id: <20200929090857.29951-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:202:2e::16) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR06CA0004.apcprd06.prod.outlook.com (2603:1096:202:2e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 09:09:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b7e89e4-4e79-4fdc-ccfd-08d8645756fe
X-MS-TrafficTypeDiagnostic: CY4PR12MB1159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1159ECA4B122D2337CB5EB27F1320@CY4PR12MB1159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sz6IGWJ+/SzU8XlaJ+Gpq0dUH38inyGQrEYO+As3opPhR5iY6XcAZfbnWRHHZzIWgMZlWPYDzN6cWMqrPndSoeBNWV8daPh05NzLjjxMF/NeBbOVdoh14nNCc+DKbjLV6j0EHPzNDLfkFCCAphYFt9DVvgdyTAq5/V/I3qD5WFvbPf8oa/p2ABGMs8LNsLgMDWKBqbpjWpuftkkd2YsTrud/f8qPl0OJ0egXUF1DfXMPvJkztQpRkv3Vy96nm/oVXfOSJ7LmEtwp7reZuDaMH7CSuoM4qJ5YUuaMtezw8q6Fmze5nD9k53H9fBQkTY9aaDZ+Ctn6sa+mA1I8kQywR97d3j76S6cqWPF+dhMuwPAXJWrfVNQifNv8/PsMrP94
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(5660300002)(6486002)(7696005)(52116002)(2616005)(2906002)(36756003)(44832011)(316002)(4326008)(83380400001)(8676002)(8936002)(6636002)(6666004)(186003)(66476007)(16526019)(1076003)(66556008)(66946007)(26005)(956004)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pyt2dJKTsFI02MNHITQ6j5WfHA4nvObVdt4V66zU/HzemjS/3VAMoMYMTEsplEBss6O5+TFvt7AhXLunBfHy0kqakxxmI28J/nB1J4p5IV4Bt/E38w9fdyFWLEJq05RfaBj5Acah4MqediMiFSI0Us0RH4GDeg5/+dGEi5qHQmXtmaQmv6dSWrM3p4R2RaeLIPHlMjTGm1tTkQVpWcFCwIQfthNBSDF4ob4yyU4qN4wSV5Y+LXmvBU9/CvSumh1gh3LM2xXfcyB86CYEzlC5fm2RDDMEwtEOfIbzAdgufPi+T6m0Nfe6ldcKwSr/UV1OLkoewCCYcqvdKP0zzVIxFavQgPiAmO1rtPzS47fcpDWxjGBLt+DznIDaxKf4xfS2y0snX1tbx1YIXGobOJESEuha6g0YvLD1MCLSlHBElO+il4B+spQCL+zbdKxn17M4CL68ZBRHt04q1Zt/0UV8hH5Staz45xSZF9maJeGkiBX7ioPFFK3QFy0F7J8+Wn3CJXwkwCFezO9O4p0Bv2x1UzLhOw5/et7nX5kHO30/GVF/GexZFDDMHdMqDMxWYlGxwcD9GG5389ImIaeSXPtT95M/rs9AyQsU3rJLg7fde07A5RynYtv9jdYo58+38jToJmb0yzmX4dYjFc7/FDcc+A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7e89e4-4e79-4fdc-ccfd-08d8645756fe
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 09:09:15.9605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbMVo7jkG+DzYJ49sUo5zDBs3vvVx/zaBYat0+t0BmrrjrkYfEZtrio6PdOHgaWwHMrkdJXlHsQ1/+PCCwpPYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1159
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
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..4aeeef3bc628 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1193,21 +1193,17 @@ static int gmc_v9_0_late_init(void *handle)
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
+		if (adev->ras_features & ~(1 << AMDGPU_RAS_BLOCK__UMC |
+					1 << AMDGPU_RAS_BLOCK__DF)) {
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
