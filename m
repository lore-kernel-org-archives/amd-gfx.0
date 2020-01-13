Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E78C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 20:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D0721556
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 20:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ni+UQPE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D0721556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E4589A9F;
	Mon, 13 Jan 2020 20:26:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E3589A9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 20:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDonUlW6EJYp10GSc5/vTYQ0DLGaSl+/3eIFoFlL6Utd8cxFjqER7mOH5/j41cDZkDfSKvK7Us/vts+Hck+DlYAU2FmTDu83XOArWi4vnt5TjugdcVPDZD9xD6phcFbK899RQLw3s4XIUDG+l6kOWjtUqJb5kiY+pkQbKlyaMesirzobaYCiG4lbEWmyXsRgiWgJZkCIkr2OmqUEQ6gTby0nyPKucbQMWxpjJHQRayPSi7pjj016twGuhFiBHmGw1txTRbGl/f6jPsmNaEgl2X8EQLLzXjcZQKqt3F9dukDswnuJCGmWWxfJWoYbJGscCHLYQivz673tgz+X7TocCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpgzggeZfes9yIGuesNopaMndevQbjwrYh6LH0QAmus=;
 b=P0fx8n3HvnKF37ePxUVROPU38OOLLYfv1O3+hgjGEKBkCFVIhpEIqGiQdxCNKcppKgrbEuIZGwMZgsXWFwJMaZAnEt99eTDxYBs8ang8RmR6CNR3uRg3r3kTarN0C7uyOfsWEAw36gY7vnmXaumshFzwoC8XlQhl6bgLuCb1m8p7zBXA28qyjOIoTMbj0cdYdDunItIxkg74hYH9DIma6zwtXChZTX67C0jKm0YKFMektL52XWQ23wwJTWX1rGuNIyIkjy8p4J8r+pJL7PsulSdQNq+ub8ffjFxZsBAJ9wprOvMI8MFHqUzlTF4D9TfElAcEJMzUxCamoIkzJnxQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpgzggeZfes9yIGuesNopaMndevQbjwrYh6LH0QAmus=;
 b=Ni+UQPE0P82Rea2gzAtNhRO5o5mbTIhMGR/mgWZzQynJ+089zDf5Ixh9yvMhX6b/eE2lF7P4SrRxasvnruiG5bjj0acPn5x2LwjzXw9k6qq40xiVoxQpMzliLG9bZ5KSvFS3PeLEWyE7iwVujstV5ETT+lHfSUup7jBgz5iOJxM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2702.namprd12.prod.outlook.com (52.135.101.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.14; Mon, 13 Jan 2020 20:26:50 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 20:26:50 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu: implement tlbs invalidate on gfx9 gfx10
Date: Mon, 13 Jan 2020 14:26:25 -0600
Message-Id: <20200113202629.94021-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN6PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:805:66::30) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR08CA0017.namprd08.prod.outlook.com (2603:10b6:805:66::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15 via Frontend Transport; Mon, 13 Jan 2020 20:26:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dbd3318-08d9-4357-06c6-08d79866eb5a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2702:|SN6PR12MB2702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB270229875F8C24D168FA6E3AFD350@SN6PR12MB2702.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(189003)(199004)(81156014)(1076003)(8676002)(6486002)(6666004)(5660300002)(81166006)(8936002)(66476007)(66556008)(66946007)(316002)(36756003)(44832011)(86362001)(4326008)(186003)(26005)(7696005)(6916009)(52116002)(2616005)(16526019)(478600001)(956004)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2702;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6bPAeeWtGXmKVDmyURC5NLg+L0niUgJv+0E7druwIRQ5yj8kIa2tXQheBjPZv65QQ/hgPSzd4+5jL5YNWwhB4UqVpayrkZa9/P5ayLn8FzjZTd7Zh5wSVPV+gKHu6ulQQdoRzxIpLeE0GO9z25hWbgNkHn89hIsrbUYDS4BnkGxzqwSs5Vp8SbCbo9YDl8gZD+ksvIPfV6lxG+ODHDaBSqIw6mBLIQISFSSw+StlCiyWf5dS5n7UdeduKsB3jky+Wc6wT4UqgJPpffwpXvsBFNRMZBuKUfqMs2EB8gx1GfCqjptpwYOoriQQb5YkxXUUObLC0Rvw9jR/UjTwjBWjoTi7scB29Vi5pNxb34pPF7HTFMCDFM9I4wdh1xHWBGou2+JTwGYUAaejMXS5dENQmSOSqCn1kNqk6gEKCZQR/DH8mAO1iL8o8sc55IWknzA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbd3318-08d9-4357-06c6-08d79866eb5a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 20:26:50.0975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTGwvv2GsaqfifhPwKEVHMPLEGDwUlJ9fogIvmrz2/vtgeDrKeHlosdKTWEcDOorr+kHJbh4k3+PSUOr3VPTBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2702
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tlbs invalidate pointer function added to kiq_pm4_funcs struct.
This way, tlb flush can be done through kiq member.
TLBs invalidatation implemented for gfx9 and gfx10.

Change-Id: I1b77b364f3ae0038ff3e70e869be5f2ef6e6d293
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 14 ++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 8e88e0411662..af4bd279f42f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -76,11 +76,15 @@ struct kiq_pm4_funcs {
 					struct amdgpu_ring *ring,
 					u64 addr,
 					u64 seq);
+	void (*kiq_invalidate_tlbs)(struct amdgpu_ring *kiq_ring,
+				uint16_t pasid, uint32_t flush_type,
+				bool all_hub);
 	/* Packet sizes */
 	int set_resources_size;
 	int map_queues_size;
 	int unmap_queues_size;
 	int query_status_size;
+	int invalidate_tlbs_size;
 };
 
 struct amdgpu_kiq {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 379e46c1b7f6..d72b60f997c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -40,6 +40,7 @@
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
 
 #include "soc15.h"
+#include "soc15d.h"
 #include "soc15_common.h"
 #include "clearstate_gfx10.h"
 #include "v10_structs.h"
@@ -346,15 +347,29 @@ static void gfx10_kiq_query_status(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
 }
 
+static void gfx10_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
+				uint16_t pasid, uint32_t flush_type,
+				bool all_hub)
+{
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
+	amdgpu_ring_write(kiq_ring,
+			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
+			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
+			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
+			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
+}
+
 static const struct kiq_pm4_funcs gfx_v10_0_kiq_pm4_funcs = {
 	.kiq_set_resources = gfx10_kiq_set_resources,
 	.kiq_map_queues = gfx10_kiq_map_queues,
 	.kiq_unmap_queues = gfx10_kiq_unmap_queues,
 	.kiq_query_status = gfx10_kiq_query_status,
+	.kiq_invalidate_tlbs = gfx10_kiq_invalidate_tlbs,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
 	.query_status_size = 7,
+	.invalidate_tlbs_size = 12,
 };
 
 static void gfx_v10_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ad0179ea2cc5..b8759386dcbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -837,15 +837,29 @@ static void gfx_v9_0_kiq_query_status(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
 }
 
+static void gfx_v9_0_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
+				uint16_t pasid, uint32_t flush_type,
+				bool all_hub)
+{
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
+	amdgpu_ring_write(kiq_ring,
+			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
+			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
+			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
+			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
+}
+
 static const struct kiq_pm4_funcs gfx_v9_0_kiq_pm4_funcs = {
 	.kiq_set_resources = gfx_v9_0_kiq_set_resources,
 	.kiq_map_queues = gfx_v9_0_kiq_map_queues,
 	.kiq_unmap_queues = gfx_v9_0_kiq_unmap_queues,
 	.kiq_query_status = gfx_v9_0_kiq_query_status,
+	.kiq_invalidate_tlbs = gfx_v9_0_kiq_invalidate_tlbs,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
 	.query_status_size = 7,
+	.invalidate_tlbs_size = 12,
 };
 
 static void gfx_v9_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
