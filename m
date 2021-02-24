Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED80DC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05D964EF5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05D964EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113256EBA5;
	Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770089.outbound.protection.outlook.com [40.107.77.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470176EBA0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jE49mzLup5CxIht9eL+lY8pZVwKqFGaa18XE6FIfyuI9cESBJ+yIf6hhzrWLYvFvEvoq+c9LkFK/0bpoKKY7m8SvQ2LkhcJrB9uPrCvDGd9JXBPjCE1a2WFiGMlRIGl482FYJqFW6O2dzUtNzzT3FDwLmsz6tvaxn9clQPDcuaJRZMy76K9EPhrLnr/SvJbt6+wQDUNMoo+6ER17pzkL0oeCzX73McTSvwR1V830Ot06QkfqQkB17IuYIy+InhjGBpQkXOYstTg6XoibByhNarg7kLNXJSDLapaFta1G18n69CxWYzHxgFQyIdtyQ3ewb2mSpj5bI/HrHR9QF1RKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc7jrK0J1DWLf9xQIm+Xdw9YRJCJfYHvGJtRRH97sRM=;
 b=hVcijmY7HIg2d0LTpbujc7HW+WOIpzUB4BEVKi6vRsOfCJoxbMpSiiq4E94PzlCRaErWCUskUNcDPgpNIuZ7t1gwPGe7jDs2g5gjGyU8Pg21jA+a0X+zoANFYWUpxNgDyjzP6jX0wuH8qB9exRv9626UTu32O4Nw3IbJOO3p9vJpfD0douzmKcr8yZwIQKqVha2ns44WXBX29pD2wuiCZoaIJNP+ANwsA5Jnuym9eKRhc0EVkjVp17vxPV8bLgw0gcsqzs1xBCe4bioaQ6QKmpz7d5CUHXkv4PiHrNeCmJv+uSIY6HgGAUZ9Ih7eYS7Vn9FiSsNV9qZ7m0LzIIYv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc7jrK0J1DWLf9xQIm+Xdw9YRJCJfYHvGJtRRH97sRM=;
 b=JDP4PDZqCGL7/zbpBspxxtQxt7yFtN+4AwAAyKUd28CYdoFtyryrCcpLaz4sZyqeEs+JWhd4BMlc6+NMQNAE8pWocJY0ykgtg2RYFogw9nRwkb6MnU2GfKyjli2yxYw95Af9TunDe78nQPutQomtANUxj0ssDiWvy4CXjVy728c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:22:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:34 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 144/159] drm/amdkfd: Add kernel parameter to stop queue
 eviction on vm fault
Date: Wed, 24 Feb 2021 17:18:44 -0500
Message-Id: <20210224221859.3068810-137-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45a6fd4f-b557-46f8-b40f-08d8d91276c3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807F884C302D5648808C04CF79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbdCQNIsCW3X1a2IQc+iy8tLOEt+JaqtAWqdDFghJWLruEjxwZnC4NEkkcQHOthj4dIMsjhfi24TiaVzu4/3WNcTJps2abISLdzJRkwlR1gj7jJ0Pzl8wqdHswS9EKVKgho6SRTjbUhy7CXBL3fnuH5WC/aavQcTGnoE7ooEATogXdGEp88gxLqQZM7Rr0I9YMpjs34qskd+qZ9fwNW88qwkDM1lYNYQovO05SOIxLxYlqafbYMqwcB8nrh+S3W2n2AT4eg7+bVLe0jAWMeze7QllXXJpuuyoqC3N97Td1FHm7koapLt9b+0feRQte33eoc+eCGomebDomZrSXKDzPBFTPJThaKDSPv2FEQ519CFV3xPMh5pX764mHBdTrAFd8XDbJ14yyTuoQu1iexJ9kGbtSTUH1u1HS3abi5bq4XkkYvlcyG5rAdwflwooujrOkTpFyUcXRY4Kt2GHpn0SQ6zoPEnKXu20Vise30f+k2UoGKMoCxy4WOi8zP506cxz81SHYd4s/dAKrWw3bvxhgDxdMR2IND044Ja4Dt4d2sDU0xIVePWrIo2iAbozp9fh3bq597MHMefqhjkPuYP5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iuyWEzSpxmezmFo7w7y3mO5p++yTME/bYt7YHr36PBm9ekBrPLKKsqkhE1Dv?=
 =?us-ascii?Q?TaBL1Wvy/D96A25GddqNUmYNsHQrjQoqlv4uzxUOxnPz5LCsvnAjzr4e0Nxh?=
 =?us-ascii?Q?eMMV9ZzK0GsLO2RlE0UP6vAvLTtYn9Gl5ZYs9RkhmZsDTfUDiuJIyy5UlHyZ?=
 =?us-ascii?Q?EENuED4jev2gzv+cSNu+Tn4b5n2ucPNdQriqCrnXqRCtd5RXa/9ytAKCdlUr?=
 =?us-ascii?Q?AdtlGp9fzlw0jdolV/5iQrryQOO3XfTZPBGRF2BCWEQqx3+uMvTNWxGwpf15?=
 =?us-ascii?Q?5xVxFy6976jT2UjtJG1YmzBvqd8tOxT+8ldjqpeJijM9qAPwPZjkSBkC68i0?=
 =?us-ascii?Q?89NP0FwiiXIwHjni8FRFN9QO/5yyHpYzoUtENvmkGJ1oApNZ33rNoV9x42N5?=
 =?us-ascii?Q?tir/2esklVaSjYNfMRp5OhqprSa65LTZ+RhkX1uzmsoCVEPbL7LQXe1qqmeZ?=
 =?us-ascii?Q?+wPeffgg1wJmsi92AHlkMBY459fGPh6zn0QOIp0rKeNfVyKWsnv3Wfavh1ZL?=
 =?us-ascii?Q?WLxvmEqZJqUE9FlQRTWxGD7ZG1kyrKZ5l2mccEYcyvLQrm72Sd+tYlDbNcYT?=
 =?us-ascii?Q?7WWpNmJ4vjPTaj6DNLwQ9rKcsds8V5+KGTflGBbfB/72O9/uR93v+TBcXAij?=
 =?us-ascii?Q?CZVvD5Ft2ZLsd8BxR+XziGwrLyMTOs+7nbwe3mU7cIYvDIzzA8CuaTIzispn?=
 =?us-ascii?Q?7OKvpr0q4CoT31r2wSk4Vi4eLqhIssltrtJ+UwMdotAA6zktsepFu/e2wZmR?=
 =?us-ascii?Q?cKNEjnKLNrybOywO9PF/p1TJFYW5xhJd+zVobpZmgRK73wtSSwNGgv8jyPmR?=
 =?us-ascii?Q?ELrcZhL9nqlqpW01mHNe5e5EIQOAQLn3yiQ6UaBs9c8KI4huOFkKDH6k2gTy?=
 =?us-ascii?Q?nI719aJAbvDor/3ZHKTHNmB0pq/zhCeJktpCZZBQVLvOx4LLCAp+88wn6hno?=
 =?us-ascii?Q?pEVAgEF5EE8lqVGzIKfGRYvLxeNWgzqeqi8OEn+UELfIk/T/ZkGu0LuDjIFo?=
 =?us-ascii?Q?Hayuxk0oHceF1yvE35/OyXO2yb12p7PeQrfys44/wUCvgEGzDTxgFiDIjJlv?=
 =?us-ascii?Q?KYcY6Aq9NKs2NrdIj83ymOk3iqutG/HgL7Xgn1Pqc34yLd7970rgsjwxQgv6?=
 =?us-ascii?Q?sV1uZsqT67aVLSbZNGftIEIpK8fHsSSGGzVq6vYazcsZPInPr7wzuDQLryns?=
 =?us-ascii?Q?kc86hmhrVq7loSGteUM0ULwvozPsGID8xpo1GEid8FlvEdp9DiQLUZq1rfBI?=
 =?us-ascii?Q?4edPBp4/vyhaFdvfeu4jbqWDGtMpYN0XNtC/98qUdwEKLPhjdYlhZN8EJ5Pm?=
 =?us-ascii?Q?cZR+EtuCUUO9UfPhLJ2P3Rhz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a6fd4f-b557-46f8-b40f-08d8d91276c3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:59.9813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/iLJdO6KuOPX+B6r9i6NylP/RsX2ssA0lP1fQbYJYmuPaLQu/20KHxkBKq9G7Z/L69GLpSYiM/AmQF57weWMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

This is to keep wavefront context for debug purpose

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          | 7 +++++++
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  | 5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h            | 5 +++++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1d7839dbbc33..c4d822b46ea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -748,6 +748,13 @@ bool no_system_mem_limit;
 module_param(no_system_mem_limit, bool, 0644);
 MODULE_PARM_DESC(no_system_mem_limit, "disable system memory limit (false = default)");
 
+/**
+ * DOC: no_queue_eviction_on_vm_fault (int)
+ * If set, process queues will not be evicted on gpuvm fault. This is to keep the wavefront context for debugging (0 = queue eviction, 1 = no queue eviction). The default is 0 (queue eviction).
+ */
+int amdgpu_no_queue_eviction_on_vm_fault = 0;
+MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM fault (0 = queue eviction, 1 = no queue eviction)");
+module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
 #endif
 
 /**
diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 8e64c01565ac..60f752d75833 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -80,8 +80,9 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
 		ihre->source_id == CIK_INTSRC_SDMA_TRAP ||
 		ihre->source_id == CIK_INTSRC_SQ_INTERRUPT_MSG ||
 		ihre->source_id == CIK_INTSRC_CP_BAD_OPCODE ||
-		ihre->source_id == CIK_INTSRC_GFX_PAGE_INV_FAULT ||
-		ihre->source_id == CIK_INTSRC_GFX_MEM_PROT_FAULT;
+		((ihre->source_id == CIK_INTSRC_GFX_PAGE_INV_FAULT ||
+		ihre->source_id == CIK_INTSRC_GFX_MEM_PROT_FAULT) &&
+		!amdgpu_no_queue_eviction_on_vm_fault);
 }
 
 static void cik_event_interrupt_wq(struct kfd_dev *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 74a460be077b..1c20458f3962 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -98,9 +98,10 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 		source_id == SOC15_INTSRC_SDMA_TRAP ||
 		source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG ||
 		source_id == SOC15_INTSRC_CP_BAD_OPCODE ||
-		client_id == SOC15_IH_CLIENTID_VMC ||
+		((client_id == SOC15_IH_CLIENTID_VMC ||
 		client_id == SOC15_IH_CLIENTID_VMC1 ||
-		client_id == SOC15_IH_CLIENTID_UTCL2;
+		client_id == SOC15_IH_CLIENTID_UTCL2) &&
+		!amdgpu_no_queue_eviction_on_vm_fault);
 }
 
 static void event_interrupt_wq_v9(struct kfd_dev *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e2ebd5a1d4de..b9839c650f21 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -169,6 +169,11 @@ extern bool hws_gws_support;
 /* Queue preemption timeout in ms */
 extern int queue_preemption_timeout_ms;
 
+/*
+ * Don't evict process queues on vm fault
+ */
+extern int amdgpu_no_queue_eviction_on_vm_fault;
+
 /* Enable eviction debug messages */
 extern bool debug_evictions;
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
