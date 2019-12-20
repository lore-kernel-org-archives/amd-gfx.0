Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC279C2D0C0
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 08:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B9D227BF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 08:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yxx/3t7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B9D227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C146789C33;
	Fri, 20 Dec 2019 08:30:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAED089C33
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 08:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jxbup3x8awGEAGrdXs450Mu1bW+W++QNZWSOUWYsGKD7FZlpxbk3G6B4nkF1ZJFsV1A5OT+RrQfNPh64tZRWm5Wkg8T9cikgr7/WcXNotMvVY4QoiyGznBlMhn/FUEUtHKgJU2+ZpXLW9XVO00iu+Xrn5DXxAKAaB2LZrfyk2+wga2SgF7MlmU64lMtmOSp4hTFypU88LVKBAtSsscHge0BvKpHy1TCEjruOs1ETzHy3wDrz8r0dd/xZPeleWLudHgxeoXC2rLlcfbq3CRU4eL4Zyaq0TagFDra5lYi+TbDvxlPHuLGQSe7vxRqTIWIcCRAWgs830nxSue2Ih5Lzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+w2PxuHNKolvdYiCsOANj4tHorq8/XLX0fh/+Sk20A=;
 b=CZIw/eO516IOb9sUnReI8rPbrb1D74j6eEWqTMgqlWmJz76RU1K5R6mS4jLBnOSQ4agcFf1fTKOrRMz2ELm4xAujWLvyFldhMBMRXr1DUXY/1uW0oStCUB+w8sHujL/+hwKEweI9MwIdzdnxT+DMPXlz1NF45LKDJIZqJ9Hi0vyMaVmTDUfHxhvRNQTGflJpurDwvxVsPRvHGvnmf37zL+7hj+kX+6NWmJU4TJ4DZuB77ehTf/2A0bDZ8EwItaU4iCG1pKNCVKyXn4nRENgvQ/Zq2cnXCG/ibJvbWZX35NuUuzChsZQWAYJwX3fHBDQqNaf+qxFvIrrecPxUMMSnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+w2PxuHNKolvdYiCsOANj4tHorq8/XLX0fh/+Sk20A=;
 b=Yxx/3t7DiC6s7cO3B7zPjz9KDhllL3GlLkKxtTEy6BXZMh0tnWnc55IwdLPrbLWUM5w45ZqnODw5gQ3/589nRQmZ0pcK99j1pmn9f88QZc5TbghUF5xwqptuVddDktHgI8U/lsnY9M2Tz0XISZleHu4p74VJXt93HArjBTl9kI8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3215.namprd12.prod.outlook.com (20.179.82.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 20 Dec 2019 08:30:21 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08%6]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 08:30:21 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdkfd: Remove unused variable
Date: Fri, 20 Dec 2019 03:29:59 -0500
Message-Id: <20191220083001.30607-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220083001.30607-1-Felix.Kuehling@amd.com>
References: <20191220083001.30607-1-Felix.Kuehling@amd.com>
X-ClientProxiedBy: YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::21) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
Received: from Harpoon.amd.com (165.204.55.251) by
 YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 20 Dec 2019 08:30:20 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e515e6f2-2cbf-4c2e-549b-08d78526d9ec
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32156FCC7CD618F9846C8B31922D0@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(1076003)(52116002)(6666004)(5660300002)(36756003)(186003)(16526019)(2906002)(7696005)(6486002)(316002)(66556008)(66476007)(478600001)(6916009)(956004)(26005)(66946007)(2616005)(81156014)(8676002)(86362001)(8936002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3215;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/ycedqdzN55C+KzUR7hpO8e/tqovaCw7fnNs8N6B3qkoaHTRgLu/c0InV3KthwEldisyU4rQbTNHdDcuqMDv/XNGJt4VnVCBqrgeGE613xnRmQYxGMZBpRnqFRVEFnVX5CyVkcsuZkHrNePny2pYyaEK/LQjAQvLAtSu0NicNn1Xg5CRrNKcTUHytqJ//s63Y4QlRDAA0Vycusg/d9es/mHGQ2v9MSoEleH1Fili7Ktbgd3fZz0AnR7OxqOwdHpvqgu5+t4TavQ224ouWgkaHd/QK4fs7Wy4KeuhU6NE7kFi+OAjexnOLp6XpHKzOqlfAD8YhbjHAPAbF9m0+ntm9j1iNU+TmeYSTeD+Ed9VFG0ac+fPmaVqToH7zIBfaPDys4wUALtvHucudu2x7zRPnuRBXetoxygBSxJ0CW3y9rDWumAvPrH339W/OBW7KCB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e515e6f2-2cbf-4c2e-549b-08d78526d9ec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 08:30:21.0938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMdPR7rduWdAQlvm/ENOf12pmLed0GGpdMTxQ4NUhYzbdNOX/Ls+lvY/+Kk5AUgOeoWbDrm/LtK5wxd/1iI3TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dqm->pipeline_mem wasn't used anywhere.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f7f6df40875e..558c0ad81848 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -930,7 +930,6 @@ static void uninitialize(struct device_queue_manager *dqm)
 	for (i = 0 ; i < KFD_MQD_TYPE_MAX ; i++)
 		kfree(dqm->mqd_mgrs[i]);
 	mutex_destroy(&dqm->lock_hidden);
-	kfd_gtt_sa_free(dqm->dev, dqm->pipeline_mem);
 }
 
 static int start_nocpsch(struct device_queue_manager *dqm)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index a8c37e6da027..8991120c4fa2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -190,7 +190,6 @@ struct device_queue_manager {
 	/* the pasid mapping for each kfd vmid */
 	uint16_t		vmid_pasid[VMID_NUM];
 	uint64_t		pipelines_addr;
-	struct kfd_mem_obj	*pipeline_mem;
 	uint64_t		fence_gpu_addr;
 	unsigned int		*fence_addr;
 	struct kfd_mem_obj	*fence_mem;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
