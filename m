Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DB4C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 17:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA622067C
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 17:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rD9hjbsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA622067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198DA6EC62;
	Thu, 17 Sep 2020 17:10:46 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750080.outbound.protection.outlook.com [40.107.75.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81C96EC62
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 17:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR6dFEE6GB78IFjwN2zWbE+FzPIYwt1kbcZGJl9wKCHuFisCss4piZn3U8TSC4WRPC2ZvFkdrIgdnnP5wa9OzRsftikLOPyWxLutIn/4a38NGgoDHiKrX/2kYW5iyo7xuvUbYJyyrRCnI+stFpNjxtCGWIITuMnF9uVR6g1X0KsNl+x3+1rf36lyA8pXKUPrYlzVPUgkkTaq4OBDqei1d4s8D8phnk8p13841uIl4tOoiQKMSb0Oz5vcr21t1zs1gafA5u1Sl5tjK16M0FMF/ht2BGEwPH8VAA/uRMS0+r+XACXfEqgD1biP9QAe8Zsitl4LqtKVOfrr45ddw3+ICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRQ1FiU05Y2CrTbdUZq3KBETOLQZun/pR7VPGeweMAc=;
 b=hmUIU+KVLTk6wQ8NySZha/Ts55YTE+DgHge1WsZIroFWFvkjXIAQNbMKLbOfW30HAp4hMgaaY5YjyF+RiGf78uZW9P313n1+kVM/zf4kH/6zmZUZAzhay74E5YSN/Tw2vwwd2GHq4GXGTpkKieXOd3JYj1cM3y6Bo9VyFxABrVlEMcglERzzCMrbT36cqgswF7hXr7yNTdzp1oJapBvu72XsY3grJ5PNDF4xDKG3Q4F1QH7EVoJPPhPJIXG6zrZeDN0m+91DOSd4ozk+ZVy868Fo+T/SiVZx6jm6HeeAYpd3sBnU73gfPzNy+sf3SOSvXIf7M5dNICRtp7qnzQBoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRQ1FiU05Y2CrTbdUZq3KBETOLQZun/pR7VPGeweMAc=;
 b=rD9hjbsqqBG/Bb8uEQOHbMnWeV8bk5b0tY6ioPBUMIfRKaRWX4hmsTHedhK1VWty+Ek1AKe0pZezjMBxexs05Hk/wM4mIaTdLHzGsEjgxXWoruMz6mj9wpAzgzObbdh0T0RHo1yrUPOcuy96+QS3bSvE8bBb4E9TirZZpeTUF60=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2592.namprd12.prod.outlook.com (2603:10b6:802:24::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 17:10:41 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82%5]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 17:10:41 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
Date: Thu, 17 Sep 2020 12:10:25 -0500
Message-Id: <20200917171025.2454-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: DM6PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::35) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsacqe51.amd.com (165.204.77.1) by
 DM6PR02CA0133.namprd02.prod.outlook.com (2603:10b6:5:1b4::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 17:10:40 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f7094b0-9da6-4b9d-caad-08d85b2c9aed
X-MS-TrafficTypeDiagnostic: SN1PR12MB2592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB259277E98D7CFC8F9B010176E33E0@SN1PR12MB2592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQDhWrbVdS8VJcY5c5eHtgagjzRk6lz6mXmNER30fV1ltzLMqMc6mcJOm5vWV+J5NlrTtXl62kCYGfIYeUyycvPtIez1N04dYc3uXJb0o1puARHBeKs1c08KHVfJ16SSdbmBSsAqXhqnUpEwERNtg19doyiah7uaKJYKvXOGCt+LHHZ5hsH5MHUWZmf1gTJ/YLOyWSC103aA3xdykZZUpBbzA+TP/IcR+cvYDbZZVfl+/iAEGa7+iBQyEf2WCnCiG5pJMbUZoHdnSLT90QuKSxeah9fA4rDsVRDKrPnSnb6PszLyxEzHwcn6L+e7ouN7JAZovVWzUX+c3e/754iCmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(6916009)(83380400001)(956004)(186003)(52116002)(2616005)(2906002)(7696005)(316002)(16526019)(26005)(1076003)(6486002)(478600001)(6666004)(66946007)(86362001)(66476007)(66556008)(5660300002)(4326008)(36756003)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 43drPr9Kknq1Ir/cK2smwLuHDXRPLIR3V68IkxHBc7xg1BN77UPb/D7CLvorfsrYNmKG+6CrHvZWcuX37DJV6pSoML2XR+sYnzXUEdWsJ7cI9SkerJAst9VShmer0DT7onX0g2l02v6QIup+f1hz6Eu5TA/WVRMa5mZCcA1xFTr1X+srD7kV/AUBp5CpJcS8X+N2v155dy1RPmAEzXYshWgDg0SjeE8NuDNnaSietMPSO13/PJCfE5Qj7It3r1keQ+zou9WWj+XDIcymBTg6qeZ7u77VkIdMOTJ6CcQq2emvdni9Wey6wlpxoj0Z12+zuIEd0cjz9g+CuRsUjuem8gvswhAK/Il9lOgseTmf5oLq/fv1sX0b395aD934yguMZ6/DPl3tOySwF8xX0M/3kn1kpivyax4OsNpnZmAa1XNIbu7qhSxt2SUjH9y8GTrQOv8/QwA9Ko2kHdCyJufFYu1Nl9uHYoop9c1w4Hs9hm7jP4FAw20MEY8dpOnbzjq/5paREwuThCMQFvZdTYi8DYJt7WHhCVlVrxfWSI8wu5gmMcBtV+Yr0clIDKoPWVZ++vE/QVAYpyS9I78C45gvGvlM5oUSQGNw6Z+dmEeOtvGqFjD5pYCzIY8+bCYHou61AkhqQH+Mtog5/7rn9bXv8Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7094b0-9da6-4b9d-caad-08d85b2c9aed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 17:10:41.1447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Su5x7EgicV494UhjGvr0oX3FKDfov5h5682/QWdoVVtbrPXBBxVzL5NpxdC8akhsj2eL6JjjLac8i/oZIVqWqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2592
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Allow user to know number of compute units (CU) that are in use at any
given moment.

[How]
Read registers of SQ that give number of waves that are in flight
of various queues. Use this information to determine number of CU's
in use.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 14 ++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h |  3 +--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d898c9ff3526..b31879be2c05 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -49,6 +49,7 @@
 #include "amdgpu_ras.h"
 
 #include "gfx_v9_4.h"
+#include "gfx_v9_0.h"
 
 #include "asic_reg/pwr/pwr_10_0_offset.h"
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
@@ -785,10 +786,6 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
-static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
-                                 struct amdgpu_cu_info *cu_info);
-static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
-static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance);
 static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
 static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
@@ -2402,7 +2399,8 @@ static void gfx_v9_0_tiling_mode_table_init(struct amdgpu_device *adev)
 	/* TODO */
 }
 
-static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance)
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance)
 {
 	u32 data;
 
@@ -4117,7 +4115,7 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	return ~0;
 }
 
-static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
+uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
 
@@ -6928,8 +6926,8 @@ static u32 gfx_v9_0_get_cu_active_bitmap(struct amdgpu_device *adev)
 	return (~data) & mask;
 }
 
-static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
-				 struct amdgpu_cu_info *cu_info)
+int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
+			 struct amdgpu_cu_info *cu_info)
 {
 	int i, j, k, counter, active_cu_number = 0;
 	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
index fa5a3fbaf6ab..a3d73667e60a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
@@ -26,9 +26,8 @@
 
 extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
 
-void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num);
-
 uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 int gfx_v9_0_get_cu_info(struct amdgpu_device *adev, struct amdgpu_cu_info *cu_info);
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance);
 
 #endif
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
