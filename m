Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F4C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 19:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F296361287
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 19:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F296361287
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1406EACE;
	Tue,  1 Jun 2021 19:07:53 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324596EACB
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 19:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbiIYk4bSXFXsOXSJYQcLfjjHi8J9trZbLqEXwvXI6iGkHUNAsi+7u5D+y64yYg5pA/kCIcIvTYzvnuyvrWQ/hYxX0KikSivT9XlFdUCrZzoSOC/kkaJqpnEl7Rx6deL4y8y350sQagUlydAxbJws1TdHSIppC6USmI3Q5+GU7GFljc19WWmUqDOT/30WlaNZCB/5CIl0/PA0FoFdgRpN0Sd9dTasvE/tRQPbk80dmiRJDKgl8YVeA9w2jnWjJuWQZZgk9BcZvTCpkAk15mvEpthLx5329eDtoOw2RmEOGg09s9AIb2ilJAebu2w8r6Mueazpjuq4iyp8iMuhBFZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn42jYYELmlAcNrr+7CqWjqPk2B6XeWlNhGQ3t/hnbI=;
 b=GxZC4KO2f9suHtHjSlcN+cKOYwVzUwdDfg7ODxOTh20mRYbF0w9eIzBQWQIManlb8+2YIhx2IXlYsnbHf8Y347DlKhmYhx1rsMPAwVpNlUphQ9+Wskzpey8VCysEgS1rMuE0YTcTI8tPSEN+CYtZ6a5PCLyS9pCSRPhbTfKtKb66Ey3FARAcLStC6DBlMEk8wyeZ1UnXFHjjYtWX339DynFzEEx2BsWlX9mnF8P4AqcWlMB2jm37UyCrgUCXOtOJv7khvSrcJv2ftXgG+H6yrHt9fkBOKirt6dDHzc+adK/0MvsnWRoB1aFUjdWaRsJnMFrnem8Maz/C7CvR7MM8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn42jYYELmlAcNrr+7CqWjqPk2B6XeWlNhGQ3t/hnbI=;
 b=KBcdI60lJF0lDwUYeWJv4KgwVwh208n2elGkuvDG4As/xNcfqO6gg7EjsHu/t/pNbCceQkzhqUsRPFORqp8y/lM2Yl+urNGmMCtjF0Pgbcnq2q2HCGZQ7Ia34IuWpHQVg/Xf2qJNGZEcFl2WSDeFTPUHXXFPQ6dFL3vp8LeH2Uc=
Received: from DM5PR04CA0072.namprd04.prod.outlook.com (2603:10b6:3:ef::34) by
 CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Tue, 1 Jun
 2021 19:07:50 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::e9) by DM5PR04CA0072.outlook.office365.com
 (2603:10b6:3:ef::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 19:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 19:07:50 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 1 Jun 2021
 14:07:48 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdkfd: Create node in kfd sysfs for memory only numa
 node
Date: Tue, 1 Jun 2021 14:07:34 -0500
Message-ID: <1622574457-4447-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 367b38db-a9e7-4728-3700-08d925308cda
X-MS-TrafficTypeDiagnostic: CO6PR12MB5441:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54413B69C5E2DF5B81F179FE803E9@CO6PR12MB5441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3dDuYlvLbKn7h9V/3vF0zksojl+B7lX4UKPwM6KG6FdXS2q09Pfzat3rJB2L2WEVMtYS2UGc5aQ3//dkjBubKntDPKhjUJ99oMOkYTw4KG4bgYx584fnt08ZEUBsbmqAypbNuGqyCtpMNZxxsJC8Kehx5uJfBJBbkL3n7lbLRrHvZN6IUtYVTu9Vs8V6vs0HkA0QFiy0olK5N0xYsvaHFWjn1T973bRO/HbEomQ7Lq+3X6irXFjOeCvPwQWXiiAjfMaICsh0dYiqC/0HlOgIbR03uNfzg0usIplOvZ0h8oxcneX1eVtIkYBLa0txQmdHjnZjFkQU0TUqdBC829MtMYLF7tOUjZGzqOtKwDt05YmN4gRmbsBhVUtLZ06O0qWReHnKuBZM+rGAChspfYYvOgU0vL/yeBeeAU1gXnpCziOrDN+CgE8Tc3UXQabomlSOm9Vc/bO/FsovuwKDuItHGJ6kEAZOipNKH89vgs7JRw1PjVl9WLNafqiwKILsvEA5QJjZLYpZjbc3LYfKszbAJVMg59j4RyxPDVCyDQcNf1SfdViQ/A+TUUVSwgc0HgGJ98nEnE0Iz9Bgr+WBC8DMC1cbWqAF2rfRW+z0Or61u2coUpujCbXaTxoxo0OtwD/pTg2mZsYOpL+KPdHXCsfbBOY4r5PwF4g8jmKfDYoGA6rwMQ6iYGo3ME8LC2lplFn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(186003)(16526019)(36860700001)(426003)(336012)(356005)(36756003)(8936002)(6666004)(26005)(83380400001)(86362001)(8676002)(54906003)(7696005)(6916009)(70206006)(82310400003)(5660300002)(2906002)(2616005)(70586007)(316002)(478600001)(82740400003)(4326008)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 19:07:50.0425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367b38db-a9e7-4728-3700-08d925308cda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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
Cc: jinhuieric.huang@amd.com, felix.kuehling@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Previously kfd driver assumes all CPU numa nodes are associated
with system memory and there is no memory only numa node. This
is not true anymore for ALDEBARAN A+A set up. This patch creates
memory only node in kfd sysfs.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 73 ++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 3251fe2..56e6dff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -827,8 +827,11 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
 	uint32_t flags = 0;
 	uint32_t width;
 
-	pr_debug("Found memory entry in CRAT table with proximity_domain=%d\n",
-			mem->proximity_domain);
+	size_in_bytes =
+		((uint64_t)mem->length_high << 32) +
+		mem->length_low;
+	pr_debug("Found memory entry in CRAT table with proximity_domain=%d, size %lld\n",
+			mem->proximity_domain, size_in_bytes);
 	list_for_each_entry(dev, device_list, list) {
 		if (mem->proximity_domain == dev->proximity_domain) {
 			/* We're on GPU node */
@@ -848,9 +851,6 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
 			if (mem->flags & CRAT_MEM_FLAGS_NON_VOLATILE)
 				flags |= HSA_MEM_FLAGS_NON_VOLATILE;
 
-			size_in_bytes =
-				((uint64_t)mem->length_high << 32) +
-							mem->length_low;
 			width = mem->width;
 
 			/* Multiple banks of the same type are aggregated into
@@ -1718,51 +1718,62 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
 
 	for_each_online_node(numa_node_id) {
+		pr_debug("numa node id %d\n", numa_node_id);
 		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
-			continue;
-
-		/* Fill in Subtype: Compute Unit */
-		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
-			crat_table->num_domains,
-			(struct crat_subtype_computeunit *)sub_type_hdr);
-		if (ret < 0)
-			return ret;
-		crat_table->length += sub_type_hdr->length;
-		crat_table->total_entries++;
+			pr_debug("Numa node %d is a memory only numa node\n", numa_node_id);
+
+		if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
+			/* Fill in Subtype: Compute Unit */
+			ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
+					crat_table->num_domains,
+					(struct crat_subtype_computeunit *)sub_type_hdr);
+			if (ret < 0) {
+				pr_err("fill cu for cpu failed\n");
+				return ret;
+			}
+			crat_table->length += sub_type_hdr->length;
+			crat_table->total_entries++;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr->length);
+			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+					sub_type_hdr->length);
+		}
 
 		/* Fill in Subtype: Memory */
 		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
 			crat_table->num_domains,
 			(struct crat_subtype_memory *)sub_type_hdr);
-		if (ret < 0)
+		if (ret < 0) {
+			pr_err("fill mem for cpu failed\n");
 			return ret;
+		}
 		crat_table->length += sub_type_hdr->length;
 		crat_table->total_entries++;
 
 		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
 			sub_type_hdr->length);
 
-		/* Fill in Subtype: IO Link */
+		if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
+			/* Fill in Subtype: IO Link */
 #ifdef CONFIG_X86_64
-		ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
-				&entries,
-				(struct crat_subtype_iolink *)sub_type_hdr);
-		if (ret < 0)
-			return ret;
+			ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
+					&entries,
+					(struct crat_subtype_iolink *)sub_type_hdr);
+			if (ret < 0) {
+				pr_err("fill iolink for cpu failed\n");
+				return ret;
+			}
 
-		if (entries) {
-			crat_table->length += (sub_type_hdr->length * entries);
-			crat_table->total_entries += entries;
+			if (entries) {
+				crat_table->length += (sub_type_hdr->length * entries);
+				crat_table->total_entries += entries;
 
-			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-					sub_type_hdr->length * entries);
-		}
+				sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+						sub_type_hdr->length * entries);
+			}
 #else
-		pr_info("IO link not available for non x86 platforms\n");
+			pr_info("IO link not available for non x86 platforms\n");
 #endif
+		}
 
 		crat_table->num_domains++;
 	}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
