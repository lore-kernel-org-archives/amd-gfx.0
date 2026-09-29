Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02D1CA5FA7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 21:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E94310F0DB;
	Tue, 29 Sep 2026 21:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z1yQW5kw";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C84C10F0DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 21:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaOA2MHVyTBMyr4rxo/BNjhJeesQ5DHxaPUjOWR5A5tZL3JvyJ0/DTp2YPVi/PVXfx6n+MU8NOGWLUMlkFTDqFKw8BkwP6O26dIieA/PTp7JUWpFoQKozZelewq75bQd6EklWHO8QgGkbwnoTkd6vynMv9YgJEYjI8nEpGUT8HSKceBVZeeqvIITfo1fV84F6uS1AjMSq8XLws4hl0aPn9J4OEt/iwLdap5dDrIui89newCy+K4GpSxJXrRTBRdwCOnDf3sd16timYqNLd5NSEkHSycs6+dfI5lxsyyccr4iCx0frQ6KNatIpV3lf/BjgGNCQhVcOg23jnyTQ0CQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7EVtG6aZvybP6j2gWEHA8Qpf9UNVexXzn0brG+7kio=;
 b=fvYiSRtjmladS3aHEHzRZjLK6EB+C7GtPaCkU9Ri3FxA4ZQ8PofcQGey6ekOtO2SCJNwKRZ05VznuVnCzWgsp1x26rbAZpPuDXKQKcuK/7Pdf8Oo82QzO3F+tN3c3dOqzwxGvcrHJ2HbQqaL/J/nrdFTNJl5TLD6QADsw0eUfWMyGCauffo8Cp5cOwDCcaMKTMhCqQTL7vLfuIS4BXIUQAsgYuNEZnVgr+d9JcURMSYzKlgfltBpvwuDU/rvv5HgIEJ/74rKpt0qrvHUJOUHnbKkzwmWzQJetID9MjkAcQzx7bkHwDiUoUCvhXWT/mG2Q0+3C7iQQvhQ9LWzWt0mHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7EVtG6aZvybP6j2gWEHA8Qpf9UNVexXzn0brG+7kio=;
 b=Z1yQW5kwNVI2gOhtTda7+4rJbIa25fj750H2DH90gacFxvJMEoxsYpFH08ye6xv6A0iUP4hdsYG5iYJX2PVnEayXdELNkj5A1mczk4zoiU3+Vas7SgazOifmuFr/3tt/2upUHezMiYe6ygbW4wB3omCekgFwul1iv1ksFlwQUHw=
Received: from BN8PR04CA0039.namprd04.prod.outlook.com (2603:10b6:408:d4::13)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 21:19:50 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::19) by BN8PR04CA0039.outlook.office365.com
 (2603:10b6:408:d4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 21:19:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 21:19:50 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 16:19:48 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, David Yat Sin <david.yatsin@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Use MTYPE_UC for ext-coherent local memory on
 AID A0 non-SPX
Date: Tue, 29 Sep 2026 17:19:30 -0400
Message-ID: <20260929211930.2095058-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929211930.2095058-1-mukul.joshi@amd.com>
References: <20260929211930.2095058-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: f392151f-8766-4a90-62d1-08df1e6f655d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TPVFy82eGAipHVkVqoFQpC0ymezyvjXa89v1P3Laf0atVt8kQaH7n2iS24G7R/Y8tdDGwaleK7sJE+XvnEGp7mXQIRiy07SMkshXUjhbjWAa6p16prQEiBW7o+IckLEaH8pFntq7IiXC66viGjgAQv+PQxcNvdVv0DFFzsi8mvqa+ygBuK3EmzmjoGdG+ehhRKFq1BRpvaZyrdzkVMdInkZ42+mCKzj6g9rN2Gk1F3EcKLCJ0UA6Q+QR11EP/224/vykW7QPYDMMCK5eO77+dcMznzw4vWTRWkfskzKv2cG+t5L2PE4Hxl4dBpojVImD+IdFwawWsZpj4lCXasN7Cj3rSgX5KSQFUEO2QW1Gs4S8I+xVryUoSK1RK10nW+9rsmTujO+Or498020cnvoRP+fAxAuO/m33l/U7eP4NhC/Mq9pfROQ80wgnUsdojS+O4WJMRGeZXcmwVWHIXahBca16VybvyOTl87WRAbhtormxBpMkNS+USaEGTfznIMUJYVbyDcBIOZegI3xcWBjNN8C57K4Q9fGf9F8w3A9kff0m014KJb0RcKwQVRwDf8L+z7g0/+MQBllIY2JLDmtM++x8Z6rURZ1iVdPABup21FUBAE0spvvs1kRdO4InZYZpFdj6G0CzyBOp2C64SwbAu+tO6IFSnXA+8Rt25U1JARFyaSZKoWmE2tbXOB+fuDSnSUfnzKgrB2RtipvRF6TBPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pnqPuUA+R5KQ1mhZazEjpjQkVlhH2pOZBiZJFFL6DPmyaGiPuuOzkaZTmTIGivj/+rvqcLoxudgHBJXvRDLoBQn2KDtSTPrh5wn6Y8OMYIr+ZFkUO4uDsCnjoJLBnkK96BMCorc2R2xTKWYPcQ9O9f715MkEYbWyORI0oHvN5sJqLPTsMnaeEt/kGbjQ+YxeZTBl0JvKEbRTPCXqIq4IeYc0Ct6V7eoaslijSGjr/1Xm4/k2nmAjEhD5/y+m6Ndcw4AEVG7yp0Gm78p54cpae25T5reTb6cYl9eCbicAcPmfw0dXiRJa70u8iN++a5YqY4EQ6apUPWygGAEUyZr8FcoSIAeuwgallCkaQNnfIPLc9g45j/PNQuXX9h3w8c9c7i54Ugdieqvouym8zYzk89i8S9ABW5HXHrv3i1FxC8tWtw04wz6JrZ/QqSzKOsNh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 21:19:50.0288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f392151f-8766-4a90-62d1-08df1e6f655d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GFX 12.1 AID A0, extended-scope fine-grained local HBM must be
mapped MTYPE_UC when the device is in DPX, QPX or CPX compute partition
mode. In SPX mode the local MTYPE (MTYPE_NC by default) is kept.
Remote VRAM and system memory already use MTYPE_UC.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 17 +++++++++++++----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index e056eb80b3a3..57aac3a9a3b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -680,6 +680,7 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 	unsigned int mtype, mtype_local, mtype_remote;
 	bool snoop = false;
 	bool is_local = false;
+	bool is_aid_a1, is_spx;
 
 	switch (gc_ip_version) {
 	case IP_VERSION(12, 1, 0):
@@ -690,7 +691,17 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 		if (uncached) {
 			mtype = MTYPE_UC;
 		} else if (ext_coherent) {
-			mtype = is_local ? mtype_local : MTYPE_UC;
+			is_aid_a1 = SOC_V1_0_DIE_REV_AID(adev->rev_id) == 1;
+			is_spx = amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+								 AMDGPU_XCP_FL_NONE) ==
+				 AMDGPU_SPX_PARTITION_MODE;
+			/* AID A0 requires MTYPE_UC for extended-scope coherent
+			 * local memory in DPX/QPX/CPX modes.
+			 */
+			if (is_local && (is_aid_a1 || is_spx))
+				mtype = mtype_local;
+			else
+				mtype = MTYPE_UC;
 		} else {
 			mtype = is_local ? mtype_local : mtype_remote;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f99cb18e8e11..671193fb1203 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1254,7 +1254,7 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
 	bool ext_coherent = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
 	unsigned int mtype_local, mtype_remote;
-	bool is_aid_a1, is_local;
+	bool is_aid_a1, is_local, is_spx;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
 		bo_node = prange->svm_bo->node;
@@ -1357,10 +1357,19 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 				AMDGPU_VM_MTYPE_UC;
 		snoop = true;
 
-		if (is_local) /* local HBM  */ {
+		if (ext_coherent) {
+			is_spx = amdgpu_xcp_query_partition_mode(node->adev->xcp_mgr,
+								 AMDGPU_XCP_FL_NONE) ==
+				 AMDGPU_SPX_PARTITION_MODE;
+			/* AID A0 requires MTYPE_UC for extended-scope coherent
+			 * local memory in DPX/QPX/CPX modes.
+			 */
+			if (is_local && (is_aid_a1 || is_spx))
+				mapping_flags |= mtype_local;
+			else
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+		} else if (is_local) /* local HBM  */ {
 			mapping_flags |= mtype_local;
-		} else if (ext_coherent) {
-			mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		} else {
 			/* system memory or remote VRAM */
 			mapping_flags |= mtype_remote;
-- 
2.55.0

