Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132B3C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 08:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D007A206B7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 08:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UpnFOX5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D007A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5156E28A;
	Fri, 13 Dec 2019 08:54:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D02F6E28A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 08:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEFvmS+h0YkYxWKa0P7bHoK5OCRlgreuDxGSxSut8q48YYRZ8b8na+5xd6m4nMzfOwe/FAi95e4GrmdIkWZi9N3bbMFa1nl0zZVuuNbcGPgb7sJVu0bvvNQHzb8A/b2G8XWPXy1LPyYOC4hD6agqhKWn0YiEWNk6LKjC4b7ethMz8KdLpTsqJ5NTwTGD6rTX2BY9wCOLe378pUFvIWjBs/liVOp26JRyAjEfsRnwP43owvECHgcmTmsSXcWFUU+TuPNMSSPh27KkxMb99juiQ+uhbGgJaScoT7YSiPUYL3ifjxglFmdkyzvI64x340/UbJ5TK7y+e3XTTEcsUsKLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+pzSQsDjRY+NdmXCRPaCPxySfJezmXJAKHmV4taETw=;
 b=oeajkBQTxqDsIcBYYy9/JC3mQreK39cbzH0cslvOhFISniYpV6qxTmXw5Irw5WtJeop21mPIgHdDkw/+5Tu2puZ23AR/lcSW1UijUns7MMRKEu1QevI/p92u/tlszP2YfBNcURdIsKMGdStOBkoExpm55Hl6rMqZxFilUwMA/yM24aDFKgtRKdwmW0K8cqXeXEGSbi6WYjVwRnFhONdV3+5pwzpaM22f5b++DSVvrqHyAQpoagnv7siiaISCEAzWLgf4FtMNyHaTFfCUkoLl6vsqqIotPmyqUzvT5FUhmabADLGexrtR9MrkzqmaoI+1J0B84EgseoX2jNGFTEuwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+pzSQsDjRY+NdmXCRPaCPxySfJezmXJAKHmV4taETw=;
 b=UpnFOX5LnZJal5F/qNEVU/xFiYmbn8+qcKRNBx9oyUDWdV3A42VJmdQaCSm/6mutsdlor6r7NFIOSwpmjF3iFfYioLBiWn7dl5xqN8fTXdBB7mRp7dc1UCvLwWW4S5IY/34bTok4dAUJT05FOIepznAnl+Af4S0YXi3EiwiGtLs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB2967.namprd12.prod.outlook.com (20.178.52.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 08:54:08 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2516.018; Fri, 13 Dec 2019
 08:54:08 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: Hawking.Zhang@amd.com, Le.Ma@amd.com, Tao.Zhou1@amd.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: drop useless BACO arg in amdgpu_ras_reset_gpu
Date: Fri, 13 Dec 2019 16:53:34 +0800
Message-Id: <20191213085334.17618-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 472b8241-d2fc-478f-62c1-08d77faa03c3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2967:|BYAPR12MB2967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB296790141C9C4CFEB96D98F1F1540@BYAPR12MB2967.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-Forefront-PRVS: 0250B840C1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(26005)(1076003)(6486002)(186003)(66946007)(6666004)(66556008)(52116002)(478600001)(6506007)(66476007)(36756003)(81166006)(44832011)(81156014)(2616005)(8676002)(2906002)(4326008)(8936002)(86362001)(316002)(6512007)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2967;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uY1dHN97LFgueRZYviHr2wXc9kBk0SWhJPb4sav4xlTOLc8+HnRra5h7ytgr/tbvvUoRLjo7J34gFulMMbjRklJfo3QgIUs0qiJgilvonoFAMyfvuiV3J4Wk4UfjMFulKsfG/PNmeIF8DRmgIRZ+LIwPMDTykc8ljPzG+o2SC0TWfYgKoxp3vmbkiVkEMs8vQf7yGvI0faHTZfdQEhJXXOZ8q05U8MsQIejrs8n2MnvblobEe3oexZ9QvGE29VG13nkBcer1leR5VezdErcdu7n6GuUBgRR+gwjaIHpVJaRYjq8IZ/HdorlLBk2Jy0qsYFX8A65cPQzWsBwel5AzxWZNAOUVVlqHUX4QaPBFzfdz2LvpwaAKA1Ke4oCWfyC74uWCr52I9Czx4mKWhDkcG1wBTa10He8WrIiDEJn55lf2OgsMlbvYauzbRi9oRdG4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472b8241-d2fc-478f-62c1-08d77faa03c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 08:54:08.3946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSyppuF+6b2KHz++LSUjx6dm3mNz/j59+PGpil0nN5uV6jCuqtMgOSv2RDj1X1q4V496XvmJYXDe5vwYsqmMuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2967
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

BACO reset mode strategy is determined by latter func when
calling amdgpu_ras_reset_gpu. So not to confuse audience, drop
it.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 52c27e49bc7b..056c7e7a6040 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -641,7 +641,7 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 		if (adev->gfx.funcs->query_ras_error_count)
 			adev->gfx.funcs->query_ras_error_count(adev, err_data);
-		amdgpu_ras_reset_gpu(adev, 0);
+		amdgpu_ras_reset_gpu(adev);
 	}
 	return AMDGPU_RAS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3f4ba408aee0..e9f8decfbc69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1872,7 +1872,7 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
 		 * See feature_enable_on_boot
 		 */
 		amdgpu_ras_disable_all_features(adev, 1);
-		amdgpu_ras_reset_gpu(adev, 0);
+		amdgpu_ras_reset_gpu(adev);
 	}
 }
 
@@ -1935,6 +1935,6 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
 		DRM_WARN("RAS event of type ERREVENT_ATHUB_INTERRUPT detected!\n");
 
-		amdgpu_ras_reset_gpu(adev, false);
+		amdgpu_ras_reset_gpu(adev);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index d4ade4739245..a5fe29a9373e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -494,8 +494,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev);
 
-static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev,
-		bool is_baco)
+static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 6361b2c9ae1a..9bbe819de46a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -160,7 +160,7 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 		struct amdgpu_iv_entry *entry)
 {
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-	amdgpu_ras_reset_gpu(adev, 0);
+	amdgpu_ras_reset_gpu(adev);
 
 	return AMDGPU_RAS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index d4fb9cf27e21..8a6c733d170c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -132,7 +132,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 						err_data->err_addr_cnt))
 			DRM_WARN("Failed to add ras bad page!\n");
 
-		amdgpu_ras_reset_gpu(adev, 0);
+		amdgpu_ras_reset_gpu(adev);
 	}
 
 	kfree(err_data->err_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index bb701dbfd472..7091782266b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -339,7 +339,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		/* ras_controller_int is dedicated for nbif ras error,
 		 * not the global interrupt for sync flood
 		 */
-		amdgpu_ras_reset_gpu(adev, true);
+		amdgpu_ras_reset_gpu(adev);
 	}
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
