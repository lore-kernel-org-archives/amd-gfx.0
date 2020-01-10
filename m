Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA50C33C99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9151120721
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tSHSCtWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9151120721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441B86E0BF;
	Fri, 10 Jan 2020 06:37:42 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700052.outbound.protection.outlook.com [40.107.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BC86E0BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 06:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmXqOpViwUmQbVsOP0Ja1/d8bjvRWW0dws55MFREqXte0E6XBk8EG3Xgea9WCgbcexK/r6vPrl8kXWX9zrelRG42A6GkjRdixBfOLhfYDaIN1ZqhjyVvAJkfwCbbTqdl05V1PKyYg8RrGKHj9zET25jbJbEizZ7d00fsbnkZqNi7PQd7plvh/NR9EyLNxM7+Q+VtQQAzth3H3cqlP1yUDBK9wNMIfuZwDN07s/Cz7SLAqIjJjt6mFOoZAunOsgFrXZCf9NHs/kJwN2+DrzX6Zp2dov5eC08n6g3Q7xDK8BdYCpLhKiP7EcRzXG9eYsH3lAHx6SpAO/P0OiK9dzv6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuOqYP8Bp7d5Hds9DQN2ieIlVGkpbWGHIorhF6XBf0k=;
 b=WQe8auDwwehI78uDdvwSF1LYZ0a4/hq/gomR0YIr+30e1X1gig3x7MhgK5BJvclYFt46vZlBF2WRWm1sspgY7uUBsCSVTR2mrd3kW0HUQqwPNRXRsxwHMorhVOSmMigONBqN3Aljj+G52cDeWOpGdQVqKDiNL9/MwzE+gd+kY917JiCcgT/tBKgnxskVIuyDo3ya1eAgHleZqrtaN33oGHldjq3NtaWiNiYchtChbjXSacrJr3yQqTMXfutUBnvs1zGgkHnmcPS2upzF7VQ1geNJ3Xcw4Xeqr4Tf4G5uCMAzgeK9hFt0+qwIh5WLW6KRAS/rBagLTEuSPOF6ZQr5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuOqYP8Bp7d5Hds9DQN2ieIlVGkpbWGHIorhF6XBf0k=;
 b=tSHSCtWGB9WYpzCaRNW7JDdXaMmg9M9yrlew//xqplN2uslIfQ+F2R2awluttGtijdwSFNRphpOGbnhUYmcYVTzZdsclTPhevPFXWxJgSLGNUw0UMKBzABmPN+dFYZ2AFz/hZA5MiTHwVPc2age4RLD21MM9PeWzUiRfpQBAbdo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB2974.namprd12.prod.outlook.com (20.178.240.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 06:37:37 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 06:37:37 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: only set cp active field for kiq queue
Date: Fri, 10 Jan 2020 14:37:09 +0800
Message-Id: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR03CA0045.apcprd03.prod.outlook.com (2603:1096:202:17::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2644.6 via Frontend Transport; Fri, 10 Jan 2020 06:37:35 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60ae28f8-c0db-4df7-25b1-08d795979522
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:|MN2PR12MB2974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB297485762D0455848EA2714EEC380@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(86362001)(54906003)(8676002)(66476007)(478600001)(66556008)(6486002)(8936002)(66946007)(6636002)(37006003)(81166006)(81156014)(316002)(2906002)(4326008)(956004)(26005)(6862004)(2616005)(7696005)(52116002)(186003)(6666004)(16526019)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2974;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EStKt5zjkexty8gDNdugsmSXpYhf8tWrVPQTV5yO0ez9IMrtG2jGjafCeVlkOW+0AZEoT0WCXKXauzBdff1p36zU1IY6GUToGd36bOH4JBor2Ni3AjPbjC7gAOLcazJ5ocUEyGqG5Gv5Kn5guc/Cv3PPbi88QQewk2TwvFm934IS+TX8vh/LCHnxQMUw+E1PIGrmKAmCYC/xiwYVp0ReIpMgFPl4Ye4wlyBmjmvhI7My5XI0+OZ6YPbH7qHu1lU19d/0HxbSuZXkfL0sd+AmFZpzKHaCpizovMp0+d4ybLAQ4/TGt97nJxAAw8NduwgzUC9pD5RgJUdYbXJnvMSJFEZjtX4I5ro7PfGX2sR+a8F0f2LeiW4c3qlPhqRDKVDzGE1SmgVIXMkKBWUCxXrjTQzTv60hMSDTutgIqmx3dZ/3ZdJpF7IZ77yBwwsAXJmx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ae28f8-c0db-4df7-25b1-08d795979522
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 06:37:37.2816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UesW7rhx5b8LWAwls2JhnCaDJbU/ddZ0UsaVH4Z4F5KmiFiesYZRN7akGx7plKA/Ccufni95suZzEMEzW+ltpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The mec ucode will set the CP_HQD_ACTIVE bit while the queue is mapped by
MAP_QUEUES packet. So we only need set cp active field for kiq queue.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 7 +++++--
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5b05334..22c69d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3323,8 +3323,11 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
-	/* activate the queue */
-	mqd->cp_hqd_active = 1;
+	/* map_queues packet doesn't need activate the queue,
+	 * so only kiq need set this field.
+	 */
+	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
+		mqd->cp_hqd_active = 1;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 8b9f440..306ee61 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4558,8 +4558,11 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_eop_wptr_mem = RREG32(mmCP_HQD_EOP_WPTR_MEM);
 	mqd->cp_hqd_eop_dones = RREG32(mmCP_HQD_EOP_DONES);
 
-	/* activate the queue */
-	mqd->cp_hqd_active = 1;
+	/* map_queues packet doesn't need activate the queue,
+	 * so only kiq need set this field.
+	 */
+	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
+		mqd->cp_hqd_active = 1;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 45328f9..e29818b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3313,8 +3313,11 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
-	/* activate the queue */
-	mqd->cp_hqd_active = 1;
+	/* map_queues packet doesn't need activate the queue,
+	 * so only kiq need set this field.
+	 */
+	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
+		mqd->cp_hqd_active = 1;
 
 	return 0;
 }
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
