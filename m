Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1059DC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 22:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C2B214AF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 22:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ygi/FFub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C2B214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321976EC4D;
	Fri, 17 Apr 2020 22:54:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 256506EC4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 22:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ98I+FjGaon7riFwoUZvj6cJTkrEmBQ5Xo0YcwlCiM0Pi71t2CAZ+ud5xD/PE3Oq3I5sR9S11fQiswNMz2gxKuH3qdbdc9y7lBYFX3swl8Zj4+NSJEQu+gRQsfBTX14cNxZAtMo8nKgbYC+F+ys3cr6z7reJrla4eWg3SvrfAgyqCe2RkqBL9SrtKFXp9H9ADUPQzTD5inhyP4LRamnJr8/+sp5YTZ3GMsGMXKkJBLSwkFWMYI6pu2OGWLLo6f88vMEGaOiFUoOzdOtcFUevW9/7MQy+8bLIkjdPyCrjPVGife8cFPr+Wi1whbWjMPLMr50ARqcPg8lfMrMwR7KrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rhqr+AritTd/MLJW0g6hg/xudXWRS/wdgC62Qqlc4b0=;
 b=WYwYF8PQLlwHvt4MlHzIagWPU/nbl5bMWneOW7cyJyE7DcXQry5GvdZnwkt+MiFuyQPT+ICDTQsUg9K5bNCZi9bd2JUrrYSumj9+1BIupDcv+zpY1UWIHZ6Xd+4h7EQZ2Y64b8mLqcHDR9GPc8C88aTkvYKeUrJpQCsCV279ollTUqPJfej4S5L5IT7hy/ISGYEfsWDwt4ihWmVaGBwR8cy1L5mTAZwcovGh1J9YNSZ18/hI7xUrX/+tGhfELXbCiIkfELIofUtqzjjwdcudTNGgaP6i0d8PTFy3He5z/+wuJkz61v/nwIxMIuSJVgfRZehxdb6Ue36CGLSc9D9DMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rhqr+AritTd/MLJW0g6hg/xudXWRS/wdgC62Qqlc4b0=;
 b=Ygi/FFub2jOmT5nNAheU35QiexkntLHF8BBSCwQbtFW8jFLeaVna9d7z310HKb8xvDwHeejcLJ33aE0eKkHrvKysuPef4l+oPF6WfmjCcU1v69/9tNoWNDfKqoBPtFYi1+TPHNx0/RPEWzjo+/qgi0Z/e340jxJjoxTe2SedsEA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Greathouse@amd.com; 
Received: from DM6PR12MB4561.namprd12.prod.outlook.com (2603:10b6:5:2ac::8) by
 DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.16; Fri, 17 Apr 2020 22:54:51 +0000
Received: from DM6PR12MB4561.namprd12.prod.outlook.com
 ([fe80::357d:e89a:42f1:f492]) by DM6PR12MB4561.namprd12.prod.outlook.com
 ([fe80::357d:e89a:42f1:f492%7]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 22:54:51 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdkfd: Put ASIC revision into HSA capability
Date: Fri, 17 Apr 2020 17:54:32 -0500
Message-Id: <20200417225432.529695-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <0f6d51ba-0247-c6a1-2a99-2b747754074a@amd.com>
References: <0f6d51ba-0247-c6a1-2a99-2b747754074a@amd.com>
X-ClientProxiedBy: SN4PR0701CA0018.namprd07.prod.outlook.com
 (2603:10b6:803:28::28) To DM6PR12MB4561.namprd12.prod.outlook.com
 (2603:10b6:5:2ac::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rocm-perf01.amd.com (165.204.78.2) by
 SN4PR0701CA0018.namprd07.prod.outlook.com (2603:10b6:803:28::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 22:54:50 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72e3e5ee-e74b-40f5-f31e-08d7e322562b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:|DM6PR12MB3306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3306F89CA7F3999FD90B88D2F9D90@DM6PR12MB3306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4561.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(6666004)(66476007)(66946007)(66556008)(8676002)(86362001)(2616005)(81156014)(956004)(4326008)(8936002)(36756003)(2906002)(1076003)(6916009)(6486002)(186003)(5660300002)(16526019)(26005)(52116002)(478600001)(316002)(7696005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRfEMO7PtrCNl/v/v3zyz9wqByLM8srF+wTg0ho16/dJpMrzt0OnQrSLxQDnJNQ1Y6XclmiZd+RAwUXuEwN2aFA/xj9a6/9eZa9EBM4S7z48ntOlaNtZmvZQnYbb73Y2CKDM0OeD1a1SaY0QjWPusHV8j1ZQk376Lt4G7Rwt3JXpGm9MjeoyA+CqOD5L0VUbuX9VGyOoczEnX/p4sXk2qgEjbDBNJeDAJ/mNI0R8DbM07V33Rx22RWIRTqCA8SHjqQ4eCcMzno+CcFyvfX7yeU5lfUQiSJPSC8xuDC5EWf+Fb3Wo4eJTymGkyEsl0x1ZUAC0O9yeLRJnL1947isUwf5XQN/ILTDfLC/IAMJZO9xwtBSSGJ/Jz8mA4VhA04Fu0hORjeXjEPpkPWnIc2xLhQIFkpShcuQqmsbyz8w7jdWtdyQN6m1Y46qQxwqDL2SL
X-MS-Exchange-AntiSpam-MessageData: cJvGm5MeUSapTk760EEpXrWyBtac2xX1iICN15G8ZydkbL9yTDTTrmQlYQ7iqaAHPP+O2zj4ltmEJK4Tuh+9+L0gQ32tsrrgKNnEUoX31V/6i5uPu8uXmD1ovT91RY0f5uAzkE3LgX6iLudKMMiDaQtL+wsedUA3vqE7HA2VYKUxfGrdK0QqrMP+mcjZuvGcgGPgXhVK61RXj5A8aSSMBnTAwm/tP7PABIPfADYFbvxw3QmvNC4gJnQafcwxlSkm9Po+WTtiuB+jBLtI2vTkXPFAn7blmc1HE/ovFOUG+eLGIEsbj91IIpQRD1OgxWyh85QpyLdx/KAyQzWiAPgmfDlUnd/IdT/C+5CU+rKjZHAeDXEKRXNrwTFcRKICTDJA5LjMSe+z36C1cEgSOxwmkpSklZi19Iowgcvy5zO1uG05lcd+LeFHBRi8Y2gDeHKksykYJj4bMaRQ6uwLwxXZNgQ+nKoQ5Cqf9YKpzZ15sgCtESQLNshdrtpYMgN29HYcGtYXPQpRV4RsrKXWedN+9bxpwcbHPBod0cuVpDSvEPoqeaVejoS/Y+R+cJgf7FS436TsgC7BxvaP077AN96LfOvSZYG8YXHbLpGXrxav+9AmtEmk1uTUYGRhHLx81H+n0RCgEJARA+b5wyTH0DbQn5veXAme0ZxPchZvaR4S16zCCyq8JUYvHk5yNp91iysrr+eCh0Y1E4o2RtnkleQZACh7W0wOCoEIzKNcIpLYHzCvLPQXy6lyMtClSr7ZGSU1UF8MwnaHbA06S5XN3undcSoq0TqKDRqgbiuvXbRSVcw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e3e5ee-e74b-40f5-f31e-08d7e322562b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 22:54:51.1812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5M4MMG78q2ZKMmrILvQFaf4XHLXvu10xmFcfEx1+wjJfD2W5HDhFjTKkxpchEyFH+mNgJwTNRZvF4F5vxKRAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
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
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In order to surface the ASIC revision to user level, we want
to put it into the HSA topology. This can be because different
ASIC revisions may require user-level software to do different
things (e.g. patch code for things that are changed in later
hardware revisions).

The ASIC revision from the hardware is maximum of 4 bits at this
time, so put it into 4 of the open bits in the HSA capability.
Then user-level software can use this capability information to
know -- for each ASIC -- what revision-based things must be done.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h  | 5 ++++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index abfbe89e805e..ad59ac4423b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -564,6 +564,13 @@ uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd)
 	return adev->gds.gws_size;
 }
 
+uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+
+	return adev->rev_id;
+}
+
 int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 				uint32_t vmid, uint64_t gpu_addr,
 				uint32_t *ib_cmd, uint32_t ib_len)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 13feb313e9b3..d065c50582eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -175,6 +175,7 @@ uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd);
 uint64_t amdgpu_amdkfd_get_unique_id(struct kgd_dev *kgd);
 uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd);
 uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd);
+uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
 
 /* Read user wptr from a specified user address space with page fault
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 5db42814dd51..6e52c95ce8b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1303,6 +1303,10 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	dev->node_props.vendor_id = gpu->pdev->vendor;
 	dev->node_props.device_id = gpu->pdev->device;
+	dev->node_props.capability |=
+		((amdgpu_amdkfd_get_asic_rev_id(dev->gpu->kgd) <<
+			HSA_CAP_ASIC_REVISION_SHIFT) &
+			HSA_CAP_ASIC_REVISION_MASK);
 	dev->node_props.location_id = pci_dev_id(gpu->pdev);
 	dev->node_props.max_engine_clk_fcompute =
 		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->kgd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 46eeecaf1b68..0c51bd3dcd59 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -41,7 +41,6 @@
 #define HSA_CAP_WATCH_POINTS_TOTALBITS_SHIFT	8
 #define HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK	0x00003000
 #define HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT	12
-#define HSA_CAP_RESERVED			0xffffc000
 
 #define HSA_CAP_DOORBELL_TYPE_PRE_1_0		0x0
 #define HSA_CAP_DOORBELL_TYPE_1_0		0x1
@@ -51,6 +50,10 @@
 #define HSA_CAP_SRAM_EDCSUPPORTED		0x00080000
 #define HSA_CAP_MEM_EDCSUPPORTED		0x00100000
 #define HSA_CAP_RASEVENTNOTIFY			0x00200000
+#define HSA_CAP_ASIC_REVISION_MASK		0x03c00000
+#define HSA_CAP_ASIC_REVISION_SHIFT		22
+
+#define HSA_CAP_RESERVED			0xfc078000
 
 struct kfd_node_properties {
 	uint64_t hive_id;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
