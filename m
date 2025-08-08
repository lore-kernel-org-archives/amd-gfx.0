Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12944C87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 14:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7AA10E941;
	Fri,  8 Aug 2025 14:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WGQNEz7j";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2888A10E940
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 14:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMvScx28CMhnvBlRpgO5P9+Jop6C6ARL+GDKXt9y7vRrNO3M6Tt4GsIt9URCEBbj0VRgV2IHIl09Xb6/WlVP4CA5x0W72xvuAaAlN8Ums8/IBekfAYt0oSVNYYgO5CaHDjsK8HhVaVEgQGgKnJlWO2VmLy8EunaZQRSk2FMHxR45hizZP/2Z72GE9+YcXG9ID80OzV1Xr/KNGAAtTDAXb5hw3MjvOvoL3q1BnlCZ4uuCjlE48UL60IagRS69QCN95UCQxUVwVH2jHYYxA00rK0rysnkqcab9EFQTUxbEmtuppgJ5BrhE5Y8woW7zDBSd2IcuB6tu+gsWho1UQarc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUjp85CQW73GeWiuumQamesleV9Hfgq4OelLnIlaRpA=;
 b=E1FYTCyoadj5C/wa64zx/47mt5LP/B/+4sS/pkZpWMEsGMUagcNAlzEdwl3iY+Gv7l7mAhyx/9N+EDrIEHLqb6d8NGmRhSv/KCOBhCshYGuIa/vXDNbBKJoRG3F5lyuu2xkeMLXaK2X4MQ5yZ5lbFaZp74o04DCXXUF5e4Nx6Q5Jz20sL0RPri5PINIvztwsVoYxiKx45eed22ANo4+0xMY0FoFq726izBESVMNHUjVRw82DbzuA5bb8MZiCHcHx60Qw4j4bccWKnAo+ikNWwE65ZfdM0a8Gubko232LgNyLKEzM3kwF2GYuBanjR4HMWczvcwyIiFBfzlCnSzJ/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUjp85CQW73GeWiuumQamesleV9Hfgq4OelLnIlaRpA=;
 b=WGQNEz7jDv15bmEHWlFNynsez6UtSnAF9gQKn8oIStY15nfOakDLk1VlRujnFyo6uguh9c9X8kR6L/4FBlExSplx2QATeUFv840uVvzFQTVIA/09B+zXzp8f0A9pEKRe3Sd6JCT8XaeKyDVbKQMmahr3DGePv2tIB2BdkRazmwc=
Received: from BN9PR03CA0631.namprd03.prod.outlook.com (2603:10b6:408:13b::6)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Fri, 8 Aug 2025 14:25:21 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::35) by BN9PR03CA0631.outlook.office365.com
 (2603:10b6:408:13b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Fri,
 8 Aug 2025 14:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 14:25:21 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 09:25:20 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yunru.pan@amd.com>, <Shravankumar.Gande@amd.com>, Chenglei Xie
 <Chenglei.Xie@amd.com>
Subject: [PATCH] drm/amdgpu: refactor bad_page_work for corner case handling
Date: Fri, 8 Aug 2025 10:24:46 -0400
Message-ID: <20250808142447.2280-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.47.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: d4dfaf8b-e537-4666-776d-08ddd687683b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fQRdDKzFBQykRq20nXfHL37mBKxVEZywKwOxVABbhFLoDGJw2xO4keO1oOn8?=
 =?us-ascii?Q?DWS/aUAN2qyMEd5JpZ3jTHJbQz4kqytRbh8HAXnnwMDYqwtb7KZgFb/dKTZ9?=
 =?us-ascii?Q?MN5IsCaWYrYrQkoz2x1uft7L3Dub5oJ/hRp/BVJN7MpOlo42jaauTL1NqjVn?=
 =?us-ascii?Q?Fc+sFxg8AlwHg/EVq87JA9MqsMfbEmP+/P9PGCh7FDFETmxzIeh6elr6oP0p?=
 =?us-ascii?Q?+B6az71M4zwIKGCKLFBnJ5gCEP5vq41xLyIFzCSxy1K+ude+YIVHxrcS+5jf?=
 =?us-ascii?Q?zIuRkj+eObTgJ1YpTAH5k5veS1iu8zWje1hkShPKcbkc2RTdw7O9Ia9Jn4IW?=
 =?us-ascii?Q?apAoMJLNJ01wIqtO4WErWMEZ/ZCJPc5eawqX9gEW3ENQAj2pirKLBlnN2Da4?=
 =?us-ascii?Q?TYfAQuqJraKlUXyNjMBhmr1/MKfq9YGJ0qz5AfqIYy0zf3MUtsGWlftjG3tk?=
 =?us-ascii?Q?MBFf298sZvHIbZXsgJ/U6igmOxBgjSN0Ds89XLE/NWfRjeDVcZNfFTQx8Cxn?=
 =?us-ascii?Q?EUuEVYFXbKsnN79SU583t0jAXo8UXPiZJiwiuVC371J2iLrmFP6DQTczRPP0?=
 =?us-ascii?Q?T7kBABzvAtdsBssRqo2bZF/mD0PmR9yWir+GrGdKS/uei+rvKXR92APm47VZ?=
 =?us-ascii?Q?r7I9w34E4WE1DTAI4DhHsV/RQDvUDWjNpo0lDO9np9MLMl753T8UCJ/zo4/P?=
 =?us-ascii?Q?+pgDlaIonIgT4m6XpNmsSGjtJwdvXi/S36BO2+FMpNuqQDl2VGGkDFnBLiZq?=
 =?us-ascii?Q?gjxRETv0ZnKFHnfw6V1mmfh98VvNVxMkFCHdDkxoGLpsQjpOG6IaHR9m8DdH?=
 =?us-ascii?Q?cxtHAmLvV+H911bH72BmrAcanTYOWIPn+DrkpdHisJwu5mdwYUkRxp6vfa5T?=
 =?us-ascii?Q?PfV36kDuxtYXauMyfFzkF/ksDadpFd9Tz0dXHi8LACEGwvcKpg34Z5WDoBwo?=
 =?us-ascii?Q?GYcpH7K7Fdn1OHHsW+slvPKSV4gLBkSeXxnYnvtvyWgkXgVb7xd+aNHHveND?=
 =?us-ascii?Q?vsRH9++SZWiwCSHdTRYiZjQizD60T3ZqZ6pc+fPkBPFgxd4ZbMSF+dkQk9AS?=
 =?us-ascii?Q?td3oU/vQbCfLpvAswHvpQplAulKn1XL6Ypp8P7RFzgmPOO2oWlPbASXY2O9X?=
 =?us-ascii?Q?SkrvvbW7sm8PqGElD64+8JNY4C1t62lxF3hRXWLyg1bVws5YE0JXVivhz2+k?=
 =?us-ascii?Q?xsLmlH2JdYhyrn7dt7wIc4vpW4yx5EARLuOtQIIRlFvLkOthOk/4FVzt9Y2F?=
 =?us-ascii?Q?8OMuQhp9Tw9I/MhuYn3CYxhdlaQeFhP7bHM6N8hOoPwembkyWjEa5/Z/fIAQ?=
 =?us-ascii?Q?h4BQTFOcsCBAqkZqTegBU8lbSBPeAuHbbLjwllAww3Yx+WJdOzh/JRYBABYB?=
 =?us-ascii?Q?RtZUXcUzd4m2+5+Ot/hlNekclSxwZW+0zZ5n6JcrGOX2MCyDdxayde0NV0fd?=
 =?us-ascii?Q?o0LLxz4MY4C0sMX1+HHkieadwkHsmVssufZ4UB0uBCi9Ft5/2+mGcS8JqtL1?=
 =?us-ascii?Q?ds4ZTmpaMrBJmvzlWzY0QDvGEDppzzq055OO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 14:25:21.3698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4dfaf8b-e537-4666-776d-08ddd687683b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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

When a poison is consumed on the guest before the guest receives the host's poison creation msg, a corner case may occur to have poison_handler complete processing earlier than it should to cause the guest to hang waiting for the req_bad_pages reply during a VF FLR, resulting in the VM becoming inaccessible in stress tests.

To fix this issue, this patch refactored the mailbox sequence by seperating the bad_page_work into two parts req_bad_pages_work and handle_bad_pages_work.
Old sequence:
  1.Stop data exchange work
  2.Guest sends MB_REQ_RAS_BAD_PAGES to host and keep polling for IDH_RAS_BAD_PAGES_READY
  3.If the IDH_RAS_BAD_PAGES_READY arrives within timeout limit, re-init the data exchange region for updated bad page info
    else timeout with error message
New sequence:
req_bad_pages_work:
  1.Stop data exhange work
  2.Guest sends MB_REQ_RAS_BAD_PAGES to host
Once Guest receives IDH_RAS_BAD_PAGES_READY event
handle_bad_pages_work:
  3.re-init the data exchange region for updated bad page info

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I053524bde337ff42987e0730dc92c53e2de3a152
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 32 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 35 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/soc15.c       |  1 -
 4 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 3da3ebb1d9a1..58accf2259b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -267,7 +267,8 @@ struct amdgpu_virt {
 	struct amdgpu_irq_src		rcv_irq;
 
 	struct work_struct		flr_work;
-	struct work_struct		bad_pages_work;
+	struct work_struct		req_bad_pages_work;
+	struct work_struct		handle_bad_pages_work;
 
 	struct amdgpu_mm_table		mm_table;
 	const struct amdgpu_virt_ops	*ops;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 48101a34e049..9a40107a0869 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -292,14 +292,32 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	}
 }
 
-static void xgpu_ai_mailbox_bad_pages_work(struct work_struct *work)
+static void xgpu_ai_mailbox_req_bad_pages_work(struct work_struct *work)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, bad_pages_work);
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, req_bad_pages_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
 		amdgpu_virt_fini_data_exchange(adev);
 		amdgpu_virt_request_bad_pages(adev);
+		up_read(&adev->reset_domain->sem);
+	}
+}
+
+/**
+ * xgpu_ai_mailbox_handle_bad_pages_work - Reinitialize the data exchange region to get fresh bad page information
+ * @work: pointer to the work_struct
+ *
+ * This work handler is triggered when bad pages are ready, and it reinitializes
+ * the data exchange region to retrieve updated bad page information from the host.
+ */
+static void xgpu_ai_mailbox_handle_bad_pages_work(struct work_struct *work)
+{
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, handle_bad_pages_work);
+	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_virt_fini_data_exchange(adev);
 		amdgpu_virt_init_data_exchange(adev);
 		up_read(&adev->reset_domain->sem);
 	}
@@ -327,10 +345,15 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	switch (event) {
+	case IDH_RAS_BAD_PAGES_READY:
+		xgpu_ai_mailbox_send_ack(adev);
+		if (amdgpu_sriov_runtime(adev))
+			schedule_work(&adev->virt.handle_bad_pages_work);
+		break;
 	case IDH_RAS_BAD_PAGES_NOTIFICATION:
 		xgpu_ai_mailbox_send_ack(adev);
 		if (amdgpu_sriov_runtime(adev))
-			schedule_work(&adev->virt.bad_pages_work);
+			schedule_work(&adev->virt.req_bad_pages_work);
 		break;
 	case IDH_UNRECOV_ERR_NOTIFICATION:
 		xgpu_ai_mailbox_send_ack(adev);
@@ -415,7 +438,8 @@ int xgpu_ai_mailbox_get_irq(struct amdgpu_device *adev)
 	}
 
 	INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
-	INIT_WORK(&adev->virt.bad_pages_work, xgpu_ai_mailbox_bad_pages_work);
+	INIT_WORK(&adev->virt.req_bad_pages_work, xgpu_ai_mailbox_req_bad_pages_work);
+	INIT_WORK(&adev->virt.handle_bad_pages_work, xgpu_ai_mailbox_handle_bad_pages_work);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index f6d8597452ed..457972aa5632 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -202,9 +202,6 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 	case IDH_REQ_RAS_CPER_DUMP:
 		event = IDH_RAS_CPER_DUMP_READY;
 		break;
-	case IDH_REQ_RAS_BAD_PAGES:
-		event = IDH_RAS_BAD_PAGES_READY;
-		break;
 	default:
 		break;
 	}
@@ -359,14 +356,32 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	}
 }
 
-static void xgpu_nv_mailbox_bad_pages_work(struct work_struct *work)
+static void xgpu_nv_mailbox_req_bad_pages_work(struct work_struct *work)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, bad_pages_work);
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, req_bad_pages_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
 		amdgpu_virt_fini_data_exchange(adev);
 		amdgpu_virt_request_bad_pages(adev);
+		up_read(&adev->reset_domain->sem);
+	}
+}
+
+/**
+ * xgpu_nv_mailbox_handle_bad_pages_work - Reinitialize the data exchange region to get fresh bad page information
+ * @work: pointer to the work_struct
+ *
+ * This work handler is triggered when bad pages are ready, and it reinitializes
+ * the data exchange region to retrieve updated bad page information from the host.
+ */
+static void xgpu_nv_mailbox_handle_bad_pages_work(struct work_struct *work)
+{
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, handle_bad_pages_work);
+	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_virt_fini_data_exchange(adev);
 		amdgpu_virt_init_data_exchange(adev);
 		up_read(&adev->reset_domain->sem);
 	}
@@ -397,10 +412,15 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device *adev,
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	switch (event) {
+	case IDH_RAS_BAD_PAGES_READY:
+		xgpu_nv_mailbox_send_ack(adev);
+		if (amdgpu_sriov_runtime(adev))
+			schedule_work(&adev->virt.handle_bad_pages_work);
+		break;
 	case IDH_RAS_BAD_PAGES_NOTIFICATION:
 		xgpu_nv_mailbox_send_ack(adev);
 		if (amdgpu_sriov_runtime(adev))
-			schedule_work(&adev->virt.bad_pages_work);
+			schedule_work(&adev->virt.req_bad_pages_work);
 		break;
 	case IDH_UNRECOV_ERR_NOTIFICATION:
 		xgpu_nv_mailbox_send_ack(adev);
@@ -485,7 +505,8 @@ int xgpu_nv_mailbox_get_irq(struct amdgpu_device *adev)
 	}
 
 	INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
-	INIT_WORK(&adev->virt.bad_pages_work, xgpu_nv_mailbox_bad_pages_work);
+	INIT_WORK(&adev->virt.req_bad_pages_work, xgpu_nv_mailbox_req_bad_pages_work);
+	INIT_WORK(&adev->virt.handle_bad_pages_work, xgpu_nv_mailbox_handle_bad_pages_work);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 9e74c9822e62..9785fada4fa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -741,7 +741,6 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
 void soc15_set_virt_ops(struct amdgpu_device *adev)
 {
 	adev->virt.ops = &xgpu_ai_virt_ops;
-
 	/* init soc15 reg base early enough so we can
 	 * request request full access for sriov before
 	 * set_ip_blocks. */
-- 
2.34.1

