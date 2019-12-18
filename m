Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B665C2D0D1
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4174521582
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RQpqvA4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4174521582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045EB6E260;
	Wed, 18 Dec 2019 08:45:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E03AA6E277
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 08:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INCQ2xie0pVmFUWkLqKvdHrlN09e07djEMaxTmEFUnO4IrmlvGc5ouFoOEZKOQxFN7ad7eLREXcfEoyaOGK+d/J0C83scdxQqHHA8CLG9UIQaWmmItJzeCAmv2ujkR7eG4vFkyGhnybIjVZ5GScRmze4hlCbtEWuD+nC5dgoLxAq8RhJu0OImrbEiR4AIXAbBagoVz0HvxCMpLWqDlCkHUxowT2bBCqlGzlo5fjHel5BQUT/ViJAptki7fwgR514kfz0v0DwqZhmwHkilLwMIvOUtOri16t4fS5+HfKG+UKjO68zJI3XPL+RfwONX1eoeqlkPq88mKq6IAuNEwLkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuudU9SKn2HW/9iM2UdMiPk+EqYfev4DMccUGrNjj2s=;
 b=lyEFGiZcXoFEf7GP/Pr1wHFSVNU22orJgZLltFmeiCsTf1YM5aq/B7hnCM5aza8CFd84AhvGnysWVkdr9VAGCZU3DIqjC9+bGz0uzZTerWmUHgoWj4s+Xx4zU4FdDytCGsrOclMWFt7MqPSAlS9D+yTvBSqQLG/ZfW5puo8WV6S5q+j+EdXtXtGY82SYHq8uf6nszzsk5SItiNWlcgZFvQOdHQew+Yh9gz7bdg3txBjJ1rcyHhRm71qZGBe1hBoGMNskbjiUlu4+Yy69ldT7e7Ll+wxjz6M0+1db/MQQ/LQI84I22a5PBfeQ5YNmqhdrnt+5vWC4BJUftTPMCmkK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuudU9SKn2HW/9iM2UdMiPk+EqYfev4DMccUGrNjj2s=;
 b=RQpqvA4ysB4DT/n5LoAaMHNKL+XgtLWZLGGE8KBA0rAo4zjPQ1D5AJt3gxJS06y0LjupQAYdHcs2mrJ8KFyfNbzlWBkPKaTSTnpX7oQYPmuzlzmb7X4FeuFaZ1oEg2ky/siQZ0lAn8lIQYOI/Hd/e8HyUMTZcqvMQvDsxokdcJk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3982.namprd12.prod.outlook.com (10.255.238.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Wed, 18 Dec 2019 08:45:41 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 08:45:41 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Yong Zhao <Yong.Zhao@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: expose num_cp_queues data field to
 topology node (v2)
Date: Wed, 18 Dec 2019 16:45:22 +0800
Message-Id: <1576658722-2651-2-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576658722-2651-1-git-send-email-ray.huang@amd.com>
References: <1576658722-2651-1-git-send-email-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2782ab14-7aea-4f6e-19a1-08d78396a9a3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3982:|MN2PR12MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3982755740D09287D11B19B3EC530@MN2PR12MB3982.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0255DF69B9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(2906002)(8676002)(6506007)(54906003)(6512007)(110136005)(52116002)(316002)(2616005)(36756003)(81166006)(66476007)(66556008)(186003)(6486002)(6636002)(26005)(8936002)(86362001)(4326008)(66946007)(5660300002)(6666004)(478600001)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3982;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aL8ZiGtta6/eKv+qBZLPUzqf0bAxUBIIcaS0zQvayPjoKQUvL/eBpOx6JnnAUgFUtCfNkwg1knmVVMODnFHPvCRiarK2x6Blk6CVz2QN5FU29v9LH/KWUM+LvsaNjiWEN1n+IwvIvHL9Ds3YGtyLgleNsS2PJ7DB0onFKm10sQpPHsC6wOjvNtr0LC8ca+Gj487PbCqZfP3DMhZ0cA6pJ8XSXpuyp1pGdiR04oUl4fLWLaviyDZK3Ru0/splV8F8R86+qcPDpdkV7ma9SBwUQmpezWlVTRIKjSnu0RJLXiFJ0G27badgBKIv3IWqTtHV02mPQ3yoYIYdTq5D4DqH68BTAtq/QHeP8b/z0ywtEe7I6/V5IpYtnWF6Q2NhiOLqdFT7iAzahqi+AIOqwm7iNRwaAbyXmDLel4cyoomcLpx8fyfthp0GDwzhncKQgQrJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2782ab14-7aea-4f6e-19a1-08d78396a9a3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 08:45:41.2824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUd0vIE9ZqwoDJlz8a0kCIzD+xI88ETpmrI4kPOBXqsf17EHwDRPqP2xFwL4R/c8xPwCEuIT+XNy+6vhTM7j2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3982
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

v2: don't update name size.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
 2 files changed, 4 insertions(+)

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
index e1c9719..74e9b16 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
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
