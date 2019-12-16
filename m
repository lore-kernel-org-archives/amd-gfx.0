Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D66DC43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 07:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4D520700
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 07:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S23uz017"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4D520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB556E130;
	Mon, 16 Dec 2019 07:03:11 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760070.outbound.protection.outlook.com [40.107.76.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 662B36E130
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 07:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvWqkp+G+DFa7rc9AzvaxjVF8xWa3K3er4NKLBgX09rLqP0ESrWD9F7zdmCD3cNqmMsJ2VjnfgZkQtqwEg4MQmsN1V+0iQuhtnO9jHn4dF4vDMvzWfv/kxXvcu5rubI2iiAxlAEN1JHKho4LhBTbclnq2jw+pnFjOI/YacZfgmTXrvn3C3Vl4Ymqy82I6FU77Kaj0a9lXhXFAAvmIMiZrfHUwY94DfJPcu+TIN7VQRmIUoXjwrow+JTqcTJAyzItuliG6l2EIQZ+1bFPZ2gX99Eldsd5ZwfW0zSUB7DhSPhLl5qKtTrzbkZ2rdXVRhe+ee8xW8DfRaLKLUhwIwihjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHmieuZvnIcCPCcQYvWUxi4MFUIBLdXQhlo/puoM/lM=;
 b=ni2XrdrwekZbKkAna7RwQzeFigpryWJZ1qQhZeKhopNXLYXYF8FfrZ/zAanZXtFohoQlM9b1YLrkNz2q+r3QRWPPBoeJbIBzjN6qKr2v9KK5Pchi5lqQYtbwSIPtICSwDY5xA0mhptORPVI+HWWEhiDhYAzY6lWf3YpPJiJl1TgfXjUkoAJV0tlnMgwsc90STa8IO/i5aZzMS/amjUbUc+xgGRfmcrZrzAHaZGaYyzn8Fv1JSdsNycV5g+TgX0PLh+NnCFZm610u+i8vboElwIRCO8tnopC8DIb5ATmZ143fLtDMmvZXN5kMzNuFyqOVyY5GSQaOsZvXdv2xxOudvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHmieuZvnIcCPCcQYvWUxi4MFUIBLdXQhlo/puoM/lM=;
 b=S23uz017En2VoUXfniZVyw0RvyfkCzGKYjjiUZSDgp6HsKqmjH1YFHUYSfadZDHFuzOSCIfUbbybtLgejJOjVsPXI29u7Vt/P/oOCCm5nlZ1O4JMalw0KK1Z14R3JYdujqUqK7H0BgxhEIi6zxf6fVhOcOK7I3gvW1CIFnxaqCo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3390.namprd12.prod.outlook.com (20.178.242.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 07:03:09 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 07:03:08 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Yong Zhao <Yong.Zhao@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: expose num_sdma_queues_per_engine data field
 to topology node
Date: Mon, 16 Dec 2019 15:02:50 +0800
Message-Id: <1576479771-10748-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a064fbbd-8d09-4a58-3750-08d781f60195
X-MS-TrafficTypeDiagnostic: MN2PR12MB3390:|MN2PR12MB3390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB339043120AE3B5A0166CDFFDEC510@MN2PR12MB3390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 02530BD3AA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(6506007)(81156014)(2906002)(81166006)(26005)(6486002)(86362001)(36756003)(4326008)(6666004)(66556008)(66946007)(5660300002)(6636002)(66476007)(186003)(110136005)(54906003)(8676002)(8936002)(52116002)(6512007)(316002)(478600001)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3390;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5afIDuUrnFT70iCmn9LsbQq7vOtdivPMPpn/5uGjdVMAavgQ9vEVgvpy+pdYQB5mf07dxtklfdCgqKzB6PkokcOjNpAM0YPho6EgEF63JIGmI09ZVshnWHdGk5a2Qjx5ZhHjs7wtg+FKsan++rQkCExXTJSvFMhMSAlzkUt+wjfjD+iFGbrV3skMt+0rLdhznkafTFHKndC58SsGp7ryYGEHZVOvkwV+SwOpc+hi03pHfisjvrtSy9qfkrTsOuedy8Np/3qxWb7QU+HPiefSP3W9JoAMtWaMpIkrBNrT1XXFU3oyFuG3s5BIDGYP0j0p1kj6vAA7efBVVr1Ij2e0FuIcETY7p3pVvn0OioZvWrVTYwo9I0YdJ36RKMM3GcyIQEVpd2FwamDwGMPm9aqOJ/2eD9nmQlaFMtbhAZo6A4s3Z1hQS6ry071SPT43Qnq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a064fbbd-8d09-4a58-3750-08d781f60195
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 07:03:08.7317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emPNWiC8hFUL3g8ZHKKSuy+37X7DaZ/1RuBK9Xx++6SywTS7LdAPw9ixZ2ltMtkiwULZjvO28s87cjrGe2VHZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3390
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

Thunk driver would like to know the num_sdma_queues_per_engine data, however
this data relied on different asic specific. So it's better to get it from kfd
driver.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 69bd062..cc01ccd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -486,6 +486,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			dev->node_props.num_sdma_engines);
 	sysfs_show_32bit_prop(buffer, "num_sdma_xgmi_engines",
 			dev->node_props.num_sdma_xgmi_engines);
+	sysfs_show_32bit_prop(buffer, "num_sdma_queues_per_engine",
+			dev->node_props.num_sdma_queues_per_engine);
 
 	if (dev->gpu) {
 		log_max_watch_addr =
@@ -1309,6 +1311,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	dev->node_props.num_sdma_engines = gpu->device_info->num_sdma_engines;
 	dev->node_props.num_sdma_xgmi_engines =
 				gpu->device_info->num_xgmi_sdma_engines;
+	dev->node_props.num_sdma_queues_per_engine =
+				gpu->device_info->num_sdma_queues_per_engine;
 	dev->node_props.num_gws = (hws_gws_support &&
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
 		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 15843e0..9346cc1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -27,7 +27,7 @@
 #include <linux/list.h>
 #include "kfd_crat.h"
 
-#define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 32
+#define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 28
 
 #define HSA_CAP_HOT_PLUGGABLE			0x00000001
 #define HSA_CAP_ATS_PRESENT			0x00000002
@@ -81,6 +81,7 @@ struct kfd_node_properties {
 	int32_t  drm_render_minor;
 	uint32_t num_sdma_engines;
 	uint32_t num_sdma_xgmi_engines;
+	uint32_t num_sdma_queues_per_engine;
 	char name[KFD_TOPOLOGY_PUBLIC_NAME_SIZE];
 };
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
