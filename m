Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716E2C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 07:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CAC20700
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 07:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J+XFwtCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CAC20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC036E149;
	Mon, 16 Dec 2019 07:03:14 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244B96E149
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 07:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3FIR7Gh76I4dOr+v38DjwpLT2pwmMucq5z77uD6OUy8UjGv56JRAWi/UgMD2Tk7BVSoPHTZNp0s4hx9dhMhwoXTdhE/0V/3Csc9r3d4NA+tG76AclNUxlLCBWaEh2OyNOHH4WVY15EI+5zrqIliWQ4SYo9R5NgQJSXkGteirqqXoKP/rukNya7+Htdu5SgDV2uOTnqXghOLYHpnibXyZcfIesDAmys2zjwO00H+b6N66VcgT9CJysMejHJ5o8MLmj113Ue0j7Tiv+a0IwLjbX/HPOxrQq2C810dooV3vTXqpEb0GDmx0Ga0R7KulTwxd/+cAB7QZ/10a62+YEqiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV9GEwK3gRUeYXQFeXofgKbWZGnmWbHxeGoOsXiMyW0=;
 b=VczenqtDv58SGYBuGr3m2Wr7apAjveIrvMSlFfDvuY/Wl2TPN/Gyb/iA/9fNabot+6Igwpjh919CJXjL9/RICPfnveQOQ3jNKfcF7NAnZOzQJIEBkKhxGO4R1W1IUWcU9VHWdYXn06FGN9Jgg09RjIF/Rtl5wco3GQX0cXyxFOAhqQB6+YJxy7+4epSiOhlx373GHs9haYTQaSNthiTb+bVYjhR7ClYPENuF5FNrLsc+xxsU0O3/AxZ3a611H+VyFMft1L0cOsnvoFThOjp7jkcXH7w5xYDBsEwc0J847Dp17pFlhkOw5+mEVnIT8bzgpjzZ+uBONnT02mmf6ZWmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV9GEwK3gRUeYXQFeXofgKbWZGnmWbHxeGoOsXiMyW0=;
 b=J+XFwtCqYjT/+soa922vk4lxq7JU4h8NfHMaUyfZ3e0yNzDVR33cXRRzvfdiYlt9Y/KnhboTEKOrDUsovYDfYpgDYra8cWMe3Z62b3nrfwZYIe2Vci1DLO2gmWDhFgew4wIzJBNTZscYytOtCLJOy1Rg1cqGYXYl8BVltkn+iVA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3390.namprd12.prod.outlook.com (20.178.242.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 07:03:11 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 07:03:11 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Yong Zhao <Yong.Zhao@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: expose num_cp_queues data field to topology
 node
Date: Mon, 16 Dec 2019 15:02:51 +0800
Message-Id: <1576479771-10748-2-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576479771-10748-1-git-send-email-ray.huang@amd.com>
References: <1576479771-10748-1-git-send-email-ray.huang@amd.com>
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 472c38f3-ce0c-49a5-409f-08d781f6033c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3390:|MN2PR12MB3390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3390CFE256AB5DA8BA4AADA4EC510@MN2PR12MB3390.namprd12.prod.outlook.com>
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
X-Microsoft-Antispam-Message-Info: SWjCaKyd//leoocLR52uMc2YJv0H/XTptQ1X9MT46bH1o/JBLux/4Qif5dGR3qIfcTAfZ+oAh7oJDA9BWQcAQDDcsxw6J8rPVDNrFkLWnlIjPXiyZiipP2N52DGCTbgQNlEQ+lGUc6bSRlxMekNUMqZpLjwJ4wMQkY772U7mICwSV2D1LaOFYagB7OXVLqQoQWKTbPWKdKfoP1DgfXYiCADvE/ZbVnxtICDLzNwnn2CdtVdwn7S8MQD19LEozxoR/KiMwTRKsDtPUOPE018GpEnTRUTAwtVr4edBAvyGfZaZXkNtWPMoHgYJpgJB78qogiO4Hxr7vS6x1zNcXZq7kRcTyy3lvBaPlZThJMLYrf5FLK3tRpoaobKk1I3WgbM4fChT1+6xyu9i0XHH2E5ico/l1S+8VLx41OAkl6Hk6VxBA59FdL8dG9gOFoaDe4LA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472c38f3-ce0c-49a5-409f-08d781f6033c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 07:03:11.4981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JryViGVJtYVD4PF7RD+brM9WJ2+0rKxURcWOJH6GSQp1DdSIuy/KJt+aeZd2L7z03I+HlGLN0Bd4crrcEH6/A==
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

Thunk driver would like to know the num_cp_queues data, however this data relied
on different asic specific. So it's better to get it from kfd driver.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index cc01ccd..203c823 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -488,6 +488,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			dev->node_props.num_sdma_xgmi_engines);
 	sysfs_show_32bit_prop(buffer, "num_sdma_queues_per_engine",
 			dev->node_props.num_sdma_queues_per_engine);
+	sysfs_show_32bit_prop(buffer, "num_cp_queues",
+			dev->node_props.num_cp_queues);
 
 	if (dev->gpu) {
 		log_max_watch_addr =
@@ -1316,6 +1318,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	dev->node_props.num_gws = (hws_gws_support &&
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
 		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
+	dev->node_props.num_cp_queues = get_queues_num(dev->gpu->dqm);
 
 	kfd_fill_mem_clk_max_info(dev);
 	kfd_fill_iolink_non_crat_info(dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 9346cc1..e447901 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -27,7 +27,7 @@
 #include <linux/list.h>
 #include "kfd_crat.h"
 
-#define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 28
+#define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 24
 
 #define HSA_CAP_HOT_PLUGGABLE			0x00000001
 #define HSA_CAP_ATS_PRESENT			0x00000002
@@ -82,6 +82,7 @@ struct kfd_node_properties {
 	uint32_t num_sdma_engines;
 	uint32_t num_sdma_xgmi_engines;
 	uint32_t num_sdma_queues_per_engine;
+	uint32_t num_cp_queues;
 	char name[KFD_TOPOLOGY_PUBLIC_NAME_SIZE];
 };
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
