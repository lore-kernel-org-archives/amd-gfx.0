Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FCFC4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 04:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF57520897
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 04:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mqEHi1Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF57520897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B47E889EEB;
	Tue, 29 Sep 2020 04:56:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF56A89EEB
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 04:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr/MF4Nr2YG8x81fWpFMzDoS8C+KXOXioLbQ/VEhOcbTvZIcZXVg5lpTZ6AHUkPLkjydQQ/mIiPVYaBoAXx6Fi6oTotWkLlbEwfgm4IXC6bFfA/gG8yYKEWBdH0OESBRhwqeGksg+fAaMRt4ztuMDozs8aQk9GtQ36QGBII4OjORumsMKCig0RVNinxsK3pVvC6zpGYOr7BVLjQDch2g34ZbHyUc+6xb4DD5RFUlZLninSsDs8w49HCiYVi09WpPVJ4TUC7VOmKV85KOn9gx8SkHnvvvJa6Si0lptvbkQJQwQGPs+6MWbAbTb5sKdqnJCpwws9uAfkYOxmgEMlKYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLWnUv5v+5PZXTooWj5TErWExnV0HdB1SellJUtVdHs=;
 b=Jwjkbr6sHynnaJao+48xTWV86SjYbqwfHTFReRjbAd2cQNiKvbbykalrNerUVttWscv3P92/Cam8eM++b40EtpetRw6V5KKPWHMu4alVnTs9yXR2NIax8nMSswgZ6c1tDVeyJyN95vfLzan7lmUmAfabPZ/dUHd6VH3sTpB9Pqyaen4c0zWyb9LzksdCAGKPJL3z2oQ8EWqN0MCKunutqiwL8vqv8Oetyyq3zz5dGEtKKKdHWPv+V7w9aW5ewZcUi36aaPjixe+tXWfYEYykB0Fddbx59zUXZ7iO8XLrzKkJZc45BIGReAx5BIZAZkl90PD7f8OS769bEWKVOxv6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLWnUv5v+5PZXTooWj5TErWExnV0HdB1SellJUtVdHs=;
 b=mqEHi1OcJyQ/jxTCf0LwyXp+kKNulm4vqR9LJFG2Vb17a7JNNN/A+rvq0arKbSbJky5e1y5LjAM4IgFCa8FuoDqKskSHsBF+lAipLV5rbS4nxZTfd9ksIlGsSnFIsVg3wa5WySh8HQAL7BpqeuerewLo7y6CbeeXutYR5jt3kWg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0118.namprd12.prod.outlook.com (2603:10b6:910:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 04:56:07 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3412.026; Tue, 29 Sep 2020
 04:56:07 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Tao.Zhou1@amd.com,
 John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10
Date: Tue, 29 Sep 2020 12:55:49 +0800
Message-Id: <20200929045549.6164-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0401CA0001.apcprd04.prod.outlook.com
 (2603:1096:202:2::11) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0001.apcprd04.prod.outlook.com (2603:1096:202:2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Tue, 29 Sep 2020 04:56:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec5f01c3-e01c-4d03-ee9c-08d86433f9ef
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0118:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB011852A4D83EBDF337DE512EF1320@CY4PR1201MB0118.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hKCzN8CmbH2kKPkylUUt0eJrg6o1mdNjtT8+YiFT0liFJEp6C0ntp6Ps+JV7YKnl7v7SFkOm3YH7FErrpsSyus+3UJIAOK++8YefqNdptKlz3gBYZy2dbW0CiensofTrm3DUDvkPMmwmQAjDwfTbqJwoaC+j3DECaLK8w6FvNy/X9Lz6+huXvXWfGTIZvKmZ1Z6Ie9wpK4hSZWcXRlnH4oWa4YHC1YIDiuE5IEHVMag1JBiTCmE8ZOa8uz1dKNLyiduckxIa7Sb8X6nlHtnZSjBXPDG0VHvN+2ATJi/3/3AEeEUwXaImaw4hI9AmPr5Q4l9pxeNpBvGw2Vpjqo6MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(316002)(36756003)(4326008)(44832011)(16526019)(186003)(26005)(7696005)(52116002)(83380400001)(2906002)(1076003)(2616005)(478600001)(956004)(6666004)(86362001)(6636002)(5660300002)(8936002)(8676002)(66556008)(66476007)(66946007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kVRFUFrTtAPU9woz0PAXuIgcpa0p9NjJ7a3v470AuzG2lQ3wyXs/aatdxKW1kZVWB95PWEIRccAKmFh2NmE+uBitzr3FN9keSxhjW9n8RCHfbTwe5F/4sn8e8oJYvjO9zIf2C3VIP/E/CC+FyfhJRQV3j7+fd/SX8x14hepLZJzjY4kbs250UBh9pOlxuNBWdmQLoPWZ250x1q2/uj2G3001UKwzuOyGMqKUszQZhcnU8nEWGIFIDUz2P1mKw2iMZ+HqPxWq8PdY5VklOi7RA4kAS5eGKnIhQ/RdkTxk9aET+HdXb4II1vchBvDoQcLemUNmCIyISRGbsiJyHoUB468zzWseOoeWiiiKaI0D+aQPC++9iWPgpGCSihBsCT+H4DITjY/BYi9XcCmhUace9oxhJ8zB7dA7U/s7O2qVuJzWcjyEp2/hk7wqcESgxSTQWEOYwqgycFwpmQOrdHOIGDbteSz2pfNieGGL+tr14YV5sGo76T3NtuWIdA8k2FtEdyIqtm9Ogn9E+TZbdv8mlgH7pGGszKVrDVClHGqPc2xc6niYbBFIxSBlsrCLhFX1RC+0HvG4KtBLdc5H0f1k3bxaN32BM8rleSsqJ1SMuJomeTPNrZLH6GBr2tL86QWt7F2kU1UXV0icZHXgRAauIA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5f01c3-e01c-4d03-ee9c-08d86433f9ef
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 04:56:07.6883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScvHAAnn9BtMTEMV7j61i9J/T1nmNhh0VH8qtfrXWzfrOQ/t3/VlWcrLj2VIzhpdBXEa+zPFYHEHAS0rHk4jgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0118
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

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..f72acb7cfea3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1193,21 +1193,14 @@ static int gmc_v9_0_late_init(void *handle)
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
-	/* Check if ecc is available */
+
+	/* apply DF parity workaround */
 	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
 		r = amdgpu_atomfirmware_mem_ecc_supported(adev);
 		if (!r) {
-			DRM_INFO("ECC is not present.\n");
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
