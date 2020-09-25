Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25678C4727F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 22:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1FA20717
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 22:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nVuNh7RD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1FA20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B0A6ED69;
	Fri, 25 Sep 2020 22:03:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3986ED69
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 22:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3IkYpPZAZJxJp6d40uptxPWiiZHC9PdwZFH8ilubBqNiy2lRKId1aZr1dZ6pJyjzgbhA+A7tGqrPskc10Mn90COB+Ywq4ZVPItcVtkQdEftGyUo8h2SZcBWLfQrE9BsVU77Ya0qj/d9+/MgGOVi3kKRJjQkuGC7IVEVewTMQsZYPdbm0rwkfeZcNcQoNKN106rRnWUl2fe8Kuin4vqzm3+A6hKG4vS7wEwuWfDcZ3JTBj1DIOeqFZ5hT/CiMQO58ZET5TBZJ3brC4nI2NtuBT1ZBgp5H/6W6mQLReTHSaTZ0XJqVXdpHFzOmHBrEHvJcLSY5DbZbXJXxF4GPvcIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfZVyI4qRSjw7vj2rACgDVNHFV5eak6mNT0qpkg88h0=;
 b=LICe7khmNIO5dtrHYb1askYfNXa51L9AkxXX9X+fQT7vCz85y6r4WH6X10tphrU23UKurwc2XIVFFWm1AwCA6I5EQzJqy8SItZXs2BQPBuxJsY8/eafVL+ntsj8xM1en0ItJgM/tVhioO2PhMKC2p1ukeW7sIC59LnQ3LN0H08pO+QFqaZF63+5Fo7ZKlCzt5rNfVdvyRnQ2yPSwag9exv+tLRZANOF6eg76iPZ2Z2iGD77kSL3iDa2YIvK34FwE2PaGeMaunHBnmRUb/i98FowE8q0t2blLwQNLStN/lmStJh1xcBLxcrwMU8g+E6EFwoxdoIxTj3pOHArO74esyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfZVyI4qRSjw7vj2rACgDVNHFV5eak6mNT0qpkg88h0=;
 b=nVuNh7RDyMtiavHYWW0M1/+sFMzkyI1Yq4Nl7VnGcS9K5EXEjY2+/JenokGP6ogIW1pb2sK1qWvp0z4AJUzGlDLXxyb1GV5JGTJchO711rTWAfKUxxZSFH8zw33mXmD3sxNKRjt1dAuhTD+ubYJEvJDF5sEe1dgdlR+S2tQsPNI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2431.namprd12.prod.outlook.com (2603:10b6:802:27::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 22:02:58 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82%5]) with mapi id 15.20.3412.021; Fri, 25 Sep 2020
 22:02:58 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
Date: Fri, 25 Sep 2020 17:02:40 -0500
Message-Id: <20200925220240.30957-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:3:93::28) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsacqe51.amd.com (165.204.77.1) by
 DM5PR20CA0018.namprd20.prod.outlook.com (2603:10b6:3:93::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 22:02:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f86bff9-1251-40d7-4725-08d8619ec313
X-MS-TrafficTypeDiagnostic: SN1PR12MB2431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24310EB2DE3881DF685A7F4BE3360@SN1PR12MB2431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJwOO/vS682FVYWK/taccSVhD2r2/miI/1J8wE9xtxfx5Tu6OmVxDmlhDFIWsKGz+o0cRDUcz78UrOZtGs0QUbd0Yv/p//LRMmnC+ztAfcIMXkPGSz6sc/5rLIw5fBOg45Ht2mLRGGf2KQWaeTiB4YWZBrBiIy2Fte0YlAvnN1Wz2LNSFO7MmMZ+RsfQC3xy0n+wjnyirIP4aqHeiEYcPYMzcF9gi42/LiDgLY2F9D7moMgU/QtYCqoJb4sCutz0MK9OFJiJFKz9FpON4MspLhfcNxlGtMk3sS5/jCGnC1ST+G0cPRJzkvjoInHuXIr7wII/E6qduAtS5RnrccaleO6g009KxF8iglryu2dI3O0tVCvJwbGoWLUp6E3bLr0v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(66946007)(66476007)(478600001)(66556008)(956004)(5660300002)(83380400001)(1076003)(6916009)(2616005)(8936002)(186003)(16526019)(316002)(52116002)(7696005)(6666004)(6486002)(2906002)(36756003)(86362001)(4326008)(26005)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: y+hb9qoS7kIeHxSWv/dx5V03I9NMv+2z6HcR5/SrvL12XyBJsKNqCxDfha2LY5GpDG/LTb6FX+CoidMHJXujGNAAc2VsW9P824peVBlor/nsjwqbrO67At9vFReHTtzgCHnnQIoa4fZERzOSia9ERIWFLNz9R12TNKItoRZnNie3MQMn49ZIs6jPRdG94Vni+7X9UKBek80YG29GSOWP/UkMXlEVGbnpkjkaOsdE3xnrXei228AQrYRxn8i2BVAxtUqMDar4HVoLq0MxhZQFsowgIxCuiFjgzAEdy2Io2wpibfUPdjx5P2Akmftn7Woc9YeKMeG5itQGF3Oij99UbDGoD3TYIlNBB+GFGqHyi6RMiE2nRiCFI+TfU1duDpd4SFxQKrXPa3yFJefvfJZ451+3gGT73TXtaJswVZFRJW7MVaxeAq/lcdD6rKH/RddiwDHnlXTbbi6u+ooxrBvA96kLvqNF+Cr6m4PxH9CTpY3qQphEt+Atonkrm1eexh1tswih3HBvQ9TByxlu/ozZi21TQjyACINEVLGMkWDivFvzXErnPEiUnRu3PvJM92e1js/rqMJ2TtH8PQ3/7dS96o5tRqlJ1t4RCmGO7pvMbnlQxDM4H2SciGp50gVDxEvAwQCSwOGVgfrkd/0BQIyKBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f86bff9-1251-40d7-4725-08d8619ec313
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 22:02:58.1730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/aO98OtKTTLaLz4MapxamG2J7WdNTaF1YlpQ2qRjJDYlR5Tv6WRLtinqYApQBna5pKK1fLpYfw/qX8E2/7lKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h |  5 +----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 346d8288f6ab..75a17a4007ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -49,6 +49,7 @@
 #include "amdgpu_ras.h"
 
 #include "gfx_v9_4.h"
+#include "gfx_v9_0.h"
 
 #include "asic_reg/pwr/pwr_10_0_offset.h"
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
@@ -785,10 +786,9 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
-static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
-                                 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
-static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance);
+static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
+		struct amdgpu_cu_info *cu_info);
 static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
 static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
@@ -2397,7 +2397,8 @@ static void gfx_v9_0_tiling_mode_table_init(struct amdgpu_device *adev)
 	/* TODO */
 }
 
-static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance)
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance)
 {
 	u32 data;
 
@@ -6924,7 +6925,7 @@ static u32 gfx_v9_0_get_cu_active_bitmap(struct amdgpu_device *adev)
 }
 
 static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
-				 struct amdgpu_cu_info *cu_info)
+			 struct amdgpu_cu_info *cu_info)
 {
 	int i, j, k, counter, active_cu_number = 0;
 	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
index fa5a3fbaf6ab..37eba971acb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
@@ -26,9 +26,6 @@
 
 extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
 
-void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num);
-
-uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
-int gfx_v9_0_get_cu_info(struct amdgpu_device *adev, struct amdgpu_cu_info *cu_info);
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance);
 
 #endif
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
