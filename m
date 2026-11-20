Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993E606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AhsBiOxj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 262A410E86A;
	Fri, 20 Nov 2026 09:16:08 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8733510F03F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 09:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/QjzLEgPQO8WWwk7uymUAuD8kEvxHeBG3PHArobI8mS16Q9e96Jyxaj54YwkjC90iFBykJEL8yJ05AnEn2l7jbX86hqt0iQ2HbDa7rgevDESpwZ0tbylbbXryro7NQEAFCUYnQGNP5RS0LrV0hofX47+S5uCKQ/gAJFWJDBNnYLZEQ4RFe4iLeS3xhx4b7rNFDzWKiJUuYyQZJ428wa5Sa+xvghnvVzehgtsCPMjoAv4vIOOCbuXfPdp4Kkm6JVvp15fvDy9INwMbC6mqW29qpApNQ54DzVL+7exTLGSN940Wv8JR0Ey2//w6UF3wE4sm1KrfqqOoYfIE8rh618Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdAITnEq6hO596epagqpybcH2vXqGUaIKQBHffnWvUM=;
 b=LnRMDq+vOtqDfLwfVsqBHZ2HMJUKaALsukbYieAf+f56R+9VCC6H2dWSIkQhs78T0aWtZZPVNNGq5i7UAXrojQvnTxc3M/qW1mdpHEqxMrzyG7cD5M11rV4EQcxqHoiS2wTX9GxpqwvN7bpn7glTBcthXdFDv72Rtaz3G3xyFc4jMjgN9D+GCyNKclIH3IQqG9yT866AgHA2hK5ToEbnZH2KWxFVQlNL/zW3QkYq7uGV/rbO/i8M31q2J8NVh9FvLv7rpxm2k85ejUT2/XNDC+bRvvG/aULBne/nhZuSTnuvOUwQvbacBQm2KUR6oq+n59cltUOXysOePSzY+EwHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdAITnEq6hO596epagqpybcH2vXqGUaIKQBHffnWvUM=;
 b=AhsBiOxjkkLhwpGq0dsvkVl5LUA2tRMfQI9izO/UUTOadAzozk+j1iLz2lNyyow+Xsg1r6v/TyofErmg0Fvp4awLXFDgIOEJrOH5Qh/wOuNbov7Qg8EERg5mjyLKtEomVD8Ll9HrAN6K22wBkHI1aUkimo9NuDUO6MMIZ3xmXSQ=
Received: from PH8PR02CA0021.namprd02.prod.outlook.com (2603:10b6:510:2d0::28)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 09:15:58 +0000
Received: from PH5PEPF00000030.namprd04.prod.outlook.com
 (2603:10b6:510:2d0:cafe::18) by PH8PR02CA0021.outlook.office365.com
 (2603:10b6:510:2d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 09:15:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF00000030.mail.protection.outlook.com (10.167.243.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 09:15:57 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 03:15:55 -0600
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: don't map SVM ranges to a GPU without a VM
Date: Fri, 20 Nov 2026 17:16:38 +0800
Message-ID: <20261120091638.20608-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF00000030:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 75db7d21-6e82-4d9e-bcb5-08df46e6e329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|261009223027099003|11063799006|56012099006|10067099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: BXjwrg9XnTJlmuYjEzAmp9t4qW/oLiqI8oZUKvQEWjg0Osub2B37CKIb5p3qkWLtfUtUEZ7LKPcMK6Obqh0e+T86Jr1lhaTpKI1tBABVvnHnvd8IwTaNn3i+p4PaVrTD4A9ZwBz0VN1SPX8OwFp36KqLB+Na+7Sp5GjLQV2tJ6iA1++TiWOffIt2HWJWdszpMpxHUDNdMcEMkHlaW2NjdmBtcTuiorMoQbTJwG/NNDxiERAx/UHa2C/L06th3DTQHJiij1g05GX2veCaCfPo+S2Qcy0wGfWSyEyAIfid3Io9FPUNdxPcnozB4LecUW7lBKo+NEI3sk5wZclkWnGl7A9hSuJFuNmT9BzED155z3065106z5r5X0qSqOd1FKb0G2eZK9wuU8G3MRi8M1/GsF5u2qSymT968XHkHlQ8+OVY79UbIjjm+LmEzKIWUG3f16JNe8Z10cPdtlbpqVKP6LFxUGn2qd4WDF/I6By+WpkFwGbZXeFCD8YVD5ruB6ODVakj7+1qZheoN+Hc0PCG8IHVJpegfYqC/Uxw9Ag85vWEFzWEf7m0Lij3swYZNneJYrlfnM0VdqN37MNom0hxaySeY0LH0wpWw8PmpqvIrwYFOVKI6GqhB0ImaksZtpiOu3Ko7vBK6tXedFR4FepBqN5dB4T37uEdAxLdVjBFhHMwdkaJo0UGl5gkXxfClRID4F5Fdxz0TUMR9LUA4fm8aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f4Ozr48aq0j4zco41TuE8nCYeRqyd0krRjN6udayK9bZwxyWi6b4zwXnifdBEyu61k5xeJY5C8YOMAt2mdL6Dnz6soUZMeNzXxkqBwX2u8ip6mB1qFLrQvi+xVhYVCzlZWIET6wm+iGLeRnMzglLU7fGwWI4wrzWjLcK1L/gCPggw0wJ0PxcA2n9GfjdITKIe4N+R3LlD5bnnKE1ykFe3ngHJ46zOPQaxilQFQjsCA87Atj8o7TMNin1AysmUq/deHS16zTviXK0LijK20uIFKCI9+feU+tevnV2EJqW0OhimNAL8vX4xzCJBjFMi2C09fnbCwNuQxSqqW4eL2+OWsBKDEq6RXrn4n/ldEhn1QJOCLkwaWBvZoZPDhnoTK3kSKdpZoSjmbea/xTaA5MqEd7cD/m2CAx1tvOB4w3ZH0ONH8qGLXBMI0jZYMWPVuK7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:15:57.6534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75db7d21-6e82-4d9e-bcb5-08df46e6e329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF00000030.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If a kfd process does not perform ACQUIRE VM for its
kfd_process_device, the VM of the pdd is NULL.

svm_range_validate_and_map does not check whether pdd->drm_priv
is NULL before accessing it, and may cause kernel panic.

This commit fixes this issue by skipping any GPUs
that haven't acquired VM in svm map.

This commit does not return an error code when
pdd->drm_priv is NULL to avoid endless
rescheduling of restore_work.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7401b7fdcb57..b5175f346351 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1818,6 +1818,14 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			  prange->bitmap_aip, MAX_GPU_INSTANCE);
 	}
 
+	for (idx = 0; idx < ctx->process->n_pdds; idx++) {
+		if (!ctx->process->pdds[idx]->drm_priv) {
+			pr_debug("GPU %d has no VM acquired, skip SVM mapping for it, please consider acquiring VM for it and perform SVM unmap and map again\n",
+				 ctx->process->pdds[idx]->user_gpu_id);
+			clear_bit(idx, ctx->bitmap);
+		}
+	}
+
 	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
 		r = 0;
 		goto free_ctx;
-- 
2.53.0

