Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B8CC4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 17:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7702075E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 17:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vyvL6AY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7702075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78066E7E2;
	Tue, 29 Sep 2020 17:26:06 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760071.outbound.protection.outlook.com [40.107.76.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2EFA6E7E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 17:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8hciGAo7qONAQSDwiHw3BXpo+hV5Bk9VuP50RyiWatyZ7i46wPyttBbURWPXPWZEk8DPqMB+cltSsazmOivm6xwy7zyAM4WmAkwvHIKw7j99gjBXln6uoT+0Qbx7MwXKJ3MD6YhMsA7CjxJvPIY/OnIxx6ynsXGTMS/xnC7cc2EVl1Y9KmMN3rD+SeYAni3h3tqxgPjsUt7DFsqrN7aen8sHedBDedTBMKYeHZ9850gQYNwcNdGU49nthlrHeB/Fc3gSOZ6+gsknvf/7SOQLGgti7vofngm45KstxLV+sllV4Q7z52wH6b84FhEZYE6a5mUS5QKi3H9w/VFZjNSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X02l0Yk9UC4CgIWq23Y5alQ//0HGoRqss8yMcE/QDwg=;
 b=WiR8oViy8GkKitaxTIDMB/xMR98vstyfOeshRGm6HJhch8jlsZ/tNig/1vxJbuU/uasFKvBDr+MWHK6P/6bE6tCxWFeLLmpcR/7QFEldBQ9QllYkUC7fDRDWaNMQFV9UGunDqPTiuUsZKcTt5TsdNlra0gfsdalNCmssjcO0qB0wIRMGYEuj+5woPBufhXs++6iA35GajN9YRYIdGgIc+oMYagPOrqHzuy2aX80oH/BI9FFUZb3olOjxMG9P+vRYEZ1x13sQcXR060wGGC7xTzBYVq3m1YHxQuR6lCdg2D92ogqe2gA1fW2BXKXd3sQlAfCbf495pX2Jz6PStPbynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X02l0Yk9UC4CgIWq23Y5alQ//0HGoRqss8yMcE/QDwg=;
 b=vyvL6AY6tVkL11Ae3FRnRF1emx0zCNvZ25N+Vj4du84SF+slmoGSDzQfh4RdGL4NOwVsDSrDV9Db3PLTz6HgzZLJtBgqBQgt+49Kab2Z3F/pic32EsIdX+yvzOqOIoXHddY05KkPMlu4J1l5I2iJsh07xKQiuLNawkH0PBCLe8E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 17:26:03 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82%5]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 17:26:03 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
Date: Tue, 29 Sep 2020 12:25:49 -0500
Message-Id: <20200929172549.24920-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:3:ef::32) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsacqe51.amd.com (165.204.77.1) by
 DM5PR04CA0070.namprd04.prod.outlook.com (2603:10b6:3:ef::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 17:26:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bd00c4c-bbeb-46e0-7c61-08d8649cbdd6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2382007414A9F122A8C57FA5E3320@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4vXNY8yHhu+gJgqXbizWM/EUNsLoMopoeD0V/eLdDjdx1yFjyzxPcaH5m/Vx5xmI5r08yy2FgDH7MN6WfkHL9/EEEUsMN4da++R6Kf+wyJwHFSbkfL7YEyTaRGBZzEUIcuDQhK19bTDa2QDiRj4RxOLK7YFwM1eLAIGsw7waEhI488X3Q5jzL9GEMiclxL1UdIXDC2++eRdEOSsgI52iTd75/++TNX23qStKA1NBKBia7s5Ng0Rut4MSW8He3NNLHSkb2w/a5JlQfZbfsVBixz0LbkBKcTjb+RDWCMxXMcjovz+YJGUqMPFoQMKQTa15IzQ1s+cAWpXw/NML7nET8rjKzrICVBV4Zaj2dwkeZnhAKKENQaDcQS7JDnzUV5A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(5660300002)(36756003)(6916009)(6666004)(8936002)(1076003)(8676002)(83380400001)(66946007)(86362001)(16526019)(186003)(26005)(2906002)(66556008)(66476007)(4326008)(478600001)(956004)(52116002)(7696005)(316002)(2616005)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0HB5NyKj2kTJVjcMG+2EvLLuv/2t/1y//SIKQXmpt6TOamfUgkcZh5DCuLQeIGmUnCdegSwwuUwXKtvl1Rsh3P4gCOOPKjH4mBZ0e21ovSY+NyRpLEd9xX7U24z6I5PFbUeM126mObLddMzfvKr4lquCSklLGj6fxy9OapBT+xi89ZYsuXcYogTTiqARORGyDNOXrEIjJ5Q9E0ElycBWj/w4rgZiYAwMug9jsWsrQ/f3ZoPQJs/l7cXVpG6xFUxPUE+ju1rTR1RZ9TgGkkGvsZkKB7mdApogoaS4FsmBHMckyi7enRPLWBFn0QRJIPM943vMJBxPmKmzRIMuJtiMwGq2ykM+EPcRfl/n+pBno6Lq6+lLlHQoE6314URrL0nYzDfuakvYvDMF28zNOQDJjEyX1tQrgHnepbk4jrLEh6Q72qpg+o8B8+QgWRU/9GI8U9Acf07O3WaXVrLvgoA0RyLrlNfdz5v+ZnFK0OvKzAYtNDRY5HlLHxgBweeOhBxl0okPr+tIczcwyEqFmsaOcWhGi3yCkAJsvhy1/99vi+8YVGbFERWLa9/1Ak9/X5QYC012QiR+2UimFF8qZwNYcrmdsm/7Y8v9H7rVNz6BpeeWPRiBMZ4MsOqMofunzdiqE1WONfio9QfHMAzv4VWKEQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd00c4c-bbeb-46e0-7c61-08d8649cbdd6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 17:26:03.7370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnzMqrucChEamNPpZalhkbYbG5wEsD5273oolpqsSkJe9pDqDoEii1ym/umtCVG33yRlJnuGz5iZc2QMD1DxWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 346d8288f6ab..b1ab9fd02db7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -49,6 +49,7 @@
 #include "amdgpu_ras.h"
 
 #include "gfx_v9_4.h"
+#include "gfx_v9_0.h"
 
 #include "asic_reg/pwr/pwr_10_0_offset.h"
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
@@ -786,9 +787,8 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
-                                 struct amdgpu_cu_info *cu_info);
+				struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
-static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance);
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
+		struct amdgpu_cu_info *cu_info)
 {
 	int i, j, k, counter, active_cu_number = 0;
 	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
index 407472031daa..dfe8d4841f58 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
@@ -26,4 +26,7 @@
 
 extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
 
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance);
+
 #endif
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
