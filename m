Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA91FC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7559F64E40
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7559F64E40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7AC6EB8C;
	Wed,  3 Feb 2021 18:47:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E976EB8C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 18:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msMCYbwTMTto/Rs4tYrzC4gY3YylCZyHPJoag23KTVQ3DoIJepnBP2uVon4h3GphZufC/lYq3Yiq+K3txdPtibxySbtyB6vsNbrQSAdUA29b8CLLCHhpJYxsW2wKgdMJ2u5xcM54+sV/vsAQuQCrwBM2UwR0wEqFK0+SxBzEOHqqb+6tpc40xELC9mMCGp2k+/ANGrG6++qFXpD1puarqlWWPuVh3FHFklpZYij0HNmAx8uSox3eqj8YThKoQmFpKrSKQv9fteOnxsFvh0kXb0lMZCieq8Tna9LoeSWdYmctZ2VYwkwYgakCgIJW5cJoQ4FSV5AcbIz2Kqq91Lj6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAlF8qQ0zvZWYDBzNbj+8FFFSWqIWhfhxZ9gpYAuUiQ=;
 b=ZBsrYrI5Gh6mK5sDJm3OChdu+/Tlx7YsJh+vygEELjGZX3rriK0FxS29Gblv5LalFlgXhD1M8OdhDavzlaDn1qZzH5zrsKkD7koqLVkBtsIpkb+U6GVE9AWP8timns7ffI1CPL5hZsKItnuJHGm6CUmPDj3Dd2SVIp/+6eXqz0yW/UvEuFNIw20Kx3ST9Bv55CBBjE/dmm6nov0PLw1ryYQn+OgToLkBEXdCvXsq2IcZLJxY79TGAbm2gYIUV+kDPDJOHsQVfaZg/7P4+5tCTftFE82zlhtUxopJZ5CpEi/dBEZ6tJIJ/YOd+vZksZyaD5lN0Y6ymq0ecJAlMFUUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAlF8qQ0zvZWYDBzNbj+8FFFSWqIWhfhxZ9gpYAuUiQ=;
 b=VIN0e7PMsrVNt3vFZ/rtT1GnI3z47blTMwU5gwMq2VRU62L06LfrcB7adqYQTuSFeJf+fZ5hF1VB/0L4eFZMQVDHQ6nECafD3Bas9qwom+s38wpPLtudx0UnEpZmzJFjyWRGpvJvOZO85aC2Ov1MG1fgF2aP8MJuh/bKNjoCAAM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 3 Feb
 2021 18:47:16 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e122:1bb3:9f2:915f]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e122:1bb3:9f2:915f%6]) with mapi id 15.20.3805.019; Wed, 3 Feb 2021
 18:47:16 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Get unique_id dynamically v2
Date: Wed,  3 Feb 2021 13:47:04 -0500
Message-Id: <20210203184704.25079-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To DM6PR12MB3324.namprd12.prod.outlook.com
 (2603:10b6:5:11e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 18:47:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1c09e51-c68d-48e1-1d1a-08d8c87420a6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24218161B8FA109ED5EAA58D85B49@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyT2VivisaI8z97rI4O1LD0U2WzUuB2XPSfqm/CwYTWOVjquGqk0ZHP6gj/Ou2zcIsVavf8KTmbqzVAEXcWBGPtbzu26/pup3WYzvQ73KKKvFvPoKwPThvYJAHRru22ej0ketG0yydO/Wt18yXLB8+3jExzzYNUa/keNjyP/AAzdfdjDTpt7kAgloXNuo/irTgxP9Qjr8faHWSYVFnCvAHX8Aai5WqyWztFgLXgfC7uPOVd4gVHB/7nDk9c4MJmfwx8rkDwpgcySkKNpns9OtHoe91TgcxtWIU1cgjUkIdxr74MJTNegdt8zOjIGiupY4geEEZoEfi5b9Ip/XM4xIxC0RpV/35BKlWNDn9W4CPcvz4+igPm2wcguEz9Btoyuf3/ITMR/uvMEQjXoSw0ATAMg44bTKl5FKOlle+PObNtVXNBjCIwOp4bmiRqORJ3bUHJWmNcDTJ6Kk8Pe9iNizeTU67MbDDs6/1QiV30Rz/vZeLP3swvRem6hjf3L7Fb/5of0keJ5xcB59guoTyhNfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(52116002)(6666004)(316002)(2906002)(86362001)(7696005)(186003)(478600001)(956004)(4326008)(2616005)(66556008)(44832011)(16526019)(83380400001)(8676002)(1076003)(36756003)(5660300002)(8936002)(6916009)(66476007)(26005)(66946007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Erklzj3QsavGeRR9ZawzZqYvcnA3xKVIejGzxB76Mn0RI797qvU9MlrbYxcV?=
 =?us-ascii?Q?6c6zfMTnarB+d1Kl/FNhyfv5UVaO6sYRnPYGHihot7qhTbbpe774pjgpyl6V?=
 =?us-ascii?Q?JxL41VkR5GEY+ydWtA+9sQwjlynJ/WhTAOhUjzxCTi4Yxo+dE854WECVs632?=
 =?us-ascii?Q?Uc/wI6MKMtm7E22oKW59Qykojc5NjTBQhUyD0vfaH6fduuryKjNhzFH3+zQb?=
 =?us-ascii?Q?I4bKhMzsiL2HT+Hzhg6/wuBA9otkbQ/Vsw11E0b8T/CoGGCupon61VrQGvcO?=
 =?us-ascii?Q?RV5xOaMQWQij1WK/4OH6jpTxtJxlFAWsQaWYSIO5ji5oKbNT5lE/ErVXvsrq?=
 =?us-ascii?Q?Imiqqtexvle0s/wYgxWtHi+c8rEe+0zAUVnB/07ECe88RCwkRjaAW88K1O7Q?=
 =?us-ascii?Q?Ox5JtZGcC6e+Z8R+dHw1AqqO9HZv7AVfy2+GM/Dd4/A5SF/oPzhv/TKLqdm0?=
 =?us-ascii?Q?l2f3ercHBmpYDhcrzho4qT9VBIOmndQjdRoxpOmhywb+18zGaEQ+mTbDAv0i?=
 =?us-ascii?Q?oA6iwvmDXNN4u4OxaxuKf5IyLk8GDmgd/FBgVItZWQquLDnLpIUV5n8FN6Hl?=
 =?us-ascii?Q?OPOoyAEwPQLmJVto94hrd+v7a2/us6rsleiiBqEbJ9m8931Z7YHMqFt1eKVN?=
 =?us-ascii?Q?ADhOGmMIt7hl6l9fJLvRoco1rY1wz9UN+lxCP9hAGh1q3cvVFVWkvwjsPQ4p?=
 =?us-ascii?Q?f8dsznsoiU4EAmF+cDuQnaAXfNBZ/r9bKRdxOS2DPD7Dw35iX8IwiCZZeAzs?=
 =?us-ascii?Q?iYkzRi4CL8dyEvxUMyg2K1cwSiQ9zAJ4cSjcPCUVRfEalni9RPc2O2FLRsIX?=
 =?us-ascii?Q?TiDLdlIJcrcJtoXHeeGTTI5m1TbRFQURmSiI+8W2RVv/QFbHLAwPcF7NpOQ4?=
 =?us-ascii?Q?qtekLKIPI6D9MhgSw9aAbeG59jWUi2DbyhCHaK6X4SZU4/c6l8I9R9q70/vy?=
 =?us-ascii?Q?vk31MipotFHvEeAFxElQlHEgDpTAzgP9cHqSOJ1KbKpbp5JbM4GlHOKvlScF?=
 =?us-ascii?Q?DabzoCT9hq5UFaDtmsmDS3P8KLJLkH0LcKKQc2Db2C2xzp8POSnjS8e/jzpM?=
 =?us-ascii?Q?yLdJRmg+NxZih1sSV4MJXpcTD/aKaeZJGQ9AjADCaF3pgeSwMXJU1pziIeZx?=
 =?us-ascii?Q?jrIbWl0zFOTc02UE7RrW+oDTzqgTQ4g2ECVOqSYka3dWPGb3WBU6s5gQvSAn?=
 =?us-ascii?Q?6q9mmvDM9PWKbw4ls/PETZB6HwMH5aS3pKWTd+8pdqbJ5oS77gp+ZS7w8Mm9?=
 =?us-ascii?Q?8u+sfxn4HgO65Xawwt/6NBx3ISm2ZNfhA3V30DPtaVLQj/WPsIoP7TRx8Z+v?=
 =?us-ascii?Q?7DigbevZYwU07yaB3IM8PCpG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c09e51-c68d-48e1-1d1a-08d8c87420a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 18:47:16.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mAfMuPmaG4T6pqSAikRc3EgoBqD5Mnt5XHa8d9iHk+qjPcKwcDZStKY3/M+vn7QZrROIHp3WPUcTOrVvpoz9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of caching the value during amdgpu_device_init, just call the
function directly. This avoids issues where the unique_id hasn't been
saved by the time that KFD's topology snapshot is done (e.g. Arcturus).

KFD's topology information from the amdgpu_device was initially cached
at KFD initialization due to amdkfd and amdgpu being separate modules.
Now that they are combined together, we can directly call the functions
that we need and avoid this unnecessary duplication and complexity.

As a side-effect of this change, we also remove unique_id=0 for CPUs,
which is obviously not unique.

v2: Drop previous patch printing unique_id in hex

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a3fc23873819..0be72789ccbc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -497,8 +497,6 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.num_sdma_queues_per_engine);
 	sysfs_show_32bit_prop(buffer, offs, "num_cp_queues",
 			      dev->node_props.num_cp_queues);
-	sysfs_show_64bit_prop(buffer, offs, "unique_id",
-			      dev->node_props.unique_id);
 
 	if (dev->gpu) {
 		log_max_watch_addr =
@@ -529,6 +527,9 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 				      dev->node_props.capability);
 		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
 				      dev->gpu->sdma_fw_version);
+		sysfs_show_64bit_prop(buffer, offs, "unique_id",
+				      amdgpu_amdkfd_get_unique_id(dev->gpu->kgd));
+
 	}
 
 	return sysfs_show_32bit_prop(buffer, offs, "max_engine_clk_ccompute",
@@ -1340,7 +1341,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
 		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
 	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
-	dev->node_props.unique_id = amdgpu_amdkfd_get_unique_id(dev->gpu->kgd);
 
 	kfd_fill_mem_clk_max_info(dev);
 	kfd_fill_iolink_non_crat_info(dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 326d9b26b7aa..416fd910e12e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -57,7 +57,6 @@
 
 struct kfd_node_properties {
 	uint64_t hive_id;
-	uint64_t unique_id;
 	uint32_t cpu_cores_count;
 	uint32_t simd_count;
 	uint32_t mem_banks_count;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
