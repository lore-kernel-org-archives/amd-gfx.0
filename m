Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A60C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD8121582
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M6xXt0EW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD8121582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F96B6E26F;
	Wed, 18 Dec 2019 08:45:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044F96E26F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 08:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCKUjhiYOEbuMY/PoTI0UVWaeO1OzsmuuQXIp8rzSWxf9OxJe+6rlT7EZioXlIGcwY5K6GUzVb7E47TZCdPos7t5U0fgHtir3eFRi7SDg2FKuvxAmgyvA3bzzRY1Eei4Tnd6MNs2KGjzZ01bLsxb/trry3gZ7OX+sse3YwnKsxt2/6r2GzmVXN0xS8DEzb+hDLHZrUu4k9dGfKiOW08iBBvj6OqSMFelJno22scd5yJYuMDD3Ar1MggBYERzFTURVH1pjYMOr/QE9ObhxeEdVHbyy/4pfCOrXs0LM3QblFqC0RlqFSklyt8Cvn+bIbUapN/qXkyjJXRcudQLGPtSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOG9RqZU1z2BjPpHx26UVOIH/HY6sR/QIzL5Rj3dyLg=;
 b=ilRLdkELq1K6qZ8kXNbP8zkMpVaQXoEniAgJeHq/7W/cieZnapO19Kd5GplR5tPEgX2vrJvsi3wR62yGL552G4Ku1sehqC/RZuf9+5bCmVA6tCn26b2uwT9RX7bl3wWKV63MDT37fRaZlxX3bUC8Qcp2Z34/8uvAuVeCFoAokOo8MMtPPrAhZsZVNWUAwfBGYsC0Y8N0easfNODrzBY8m+gEI7idJ1pFzu3F06n2awi5Ub77vSz8oQVjnPEA4EKYf2ZDGIOeZ7K1vMTvvSJ6tnQpvy5KZr/HStoQqZTqbO5+YjtML8XmIJtmNzstKNOHqOEqdGpCMtFGSdR+87w9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOG9RqZU1z2BjPpHx26UVOIH/HY6sR/QIzL5Rj3dyLg=;
 b=M6xXt0EWTkpddoVavj4sOCnkpGfwlYAGT9BXxs64HRGHqaKx0wK2l7YEuFz4ZiOMSrlezAnI722apWvo0tmc8rg286fs98DP+cjcTbMDjIBugmnOBG9SexcnXg1Jyy/Iq9QmISfHyeUGQv/GiLR9O22wnqNIEvwRih7fJcAsdBo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3982.namprd12.prod.outlook.com (10.255.238.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Wed, 18 Dec 2019 08:45:38 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 08:45:38 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Yong Zhao <Yong.Zhao@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: expose num_sdma_queues_per_engine data
 field to topology node (v2)
Date: Wed, 18 Dec 2019 16:45:21 +0800
Message-Id: <1576658722-2651-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 965a971d-2272-48f0-13df-08d78396a803
X-MS-TrafficTypeDiagnostic: MN2PR12MB3982:|MN2PR12MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3982FF84443D3A57A1898542EC530@MN2PR12MB3982.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
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
X-Microsoft-Antispam-Message-Info: Jm/W2mfvsdEgtu8ezU38wRPZWxaZ9v7Dq/KV8WTYw5XRWk4GSo9oy+fJPgFnTpykGVYZu76FqPXcXxKhLk2agUuOlTADLi/hiFGBEDSi4CbGahwfnGxTOTCqYOyc5wivwI/IaeoH1x3d3VJ1TnTyKPsEfBhes4OtriDHlBFffJ//oOPUk1ON0RX42Ombq+Tq0Gkm03Ul04TnMg/9NzojbjVrHhXMnnxqwGK6OrFkr6Nk8iE41EMOZG3mOjNsv8xJz/u71hLUrm/JGbTzFqREi1B5YOhBZ0rpbRwyPsRlOYGy34GlaHIjY9cyzlaVCBywewbfGakp7CHOgZ44eIN+z30vrIhr/VydqKESb2gmAwSgDR42eNZVXcfPHWJyEqUrDwNlU8nQvOif5AUVUu0VuqHnujUTAd8b5F2SUADENP59llHrBqc0zaD0i2xe5+6t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965a971d-2272-48f0-13df-08d78396a803
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 08:45:38.7039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TReWuUK5ELyb/6xSV/DDOsPYUic7LPGpc+mF+QlwU0Dq3uvlstKzUszKaCGLnm/J6iJ3VMxBCTxXJaa5XjosGA==
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

Thunk driver would like to know the num_sdma_queues_per_engine data, however
this data relied on different asic specific. So it's better to get it from kfd
driver.

v2: don't update the name size.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
 2 files changed, 5 insertions(+)

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
index 15843e0..e1c9719 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
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
