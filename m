Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87866606A333
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ChJKD/m+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB06910FD96;
	Wed, 18 Nov 2026 15:11:13 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571DE10FD96
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciNrgVwlJfCEEphb2zhF8nGCtmUg3weXV/t9JK7iBN/hsIEm25ezkdeYJwDE/k+DwS7hfyE4xkdCn5hW571266tXDTVfaCo7l8YqO/mncGVByqAdQMsNym1f4Ix8VLXTI+1nYDEGn0oAzQgbKA9xP6RWm1EYzhByoSWsV9gE1OCLWFCjIhXwb7Q/GOzZXyDPkQUdv9Zf5zI9ENB6jjwjZLYZ6CR1sCDVEGklTgBIxjdAfz1chu0W8dJAPoUDkO+mVRSJ93mp8HXy2IgFQu6cY5jNZ6Tlzx16xZpb3K3JoFsmSiV0twt56aW5EWjTn+c07ei7AV8nUV1wrwjSM2pt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuXgniGsUutDj/6jQ2NxWkzQPvGnWP1zi74zOlOfRSg=;
 b=efMWuyLpUgNVKnajfwYJpUqWtUcU3GN+7hqeafBh68gBxgyZ0f/9r1BFyQt3mxPAOrpntdAboO4AtDHk385UKmyvmtNthhtdmBM+U1Rpq0NP3wKCTeep6Y8qU6L/gcahzbao3I7g+1XX9jnMub0t9jSL76KKtWKmPxjIGMmMdHwlOQpWeDfDUaBqdWulc9N04klaAry2fdReytE63sh08T76XiW94rnhARxW1I35xERTmLPuqaDfFE0AX+/zdUWwwZVyM0Xn7TnciNj5conjaofEJBvGx0knCObNKftEANf1FfUEYDsK4iRGaFNwRthULKJ0+dySeSaxbnGmC1hpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuXgniGsUutDj/6jQ2NxWkzQPvGnWP1zi74zOlOfRSg=;
 b=ChJKD/m+dzpO/Omu5J3PJpFxWwBrbhl2qRSAy7TAdJgzp5drrAVM+kDJwnZUdabvaFuNr18bZeYOtUFvPaSGz6Zuu5IuDpMfBR4wXRjD0rY92ZnRCaIXfMM/Lso1LOUUt9W3TNXzHy34Q9WI5WHIaOc9Q7JUhk+cwkurRBCjqf8=
Received: from PH7P220CA0050.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::28)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:10:57 +0000
Received: from CY6PEPF0000004D.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::47) by PH7P220CA0050.outlook.office365.com
 (2603:10b6:510:32b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 15:10:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004D.mail.protection.outlook.com (10.167.247.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:10:54 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 09:10:53 -0600
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, <philip.yang@amd.com>
Subject: [PATCH 2/4] drm/amdkfd: don't take p->mutex in
 AMDKFD_IOC_GET_CLOCK_COUNTERS
Date: Wed, 18 Nov 2026 10:10:36 -0500
Message-ID: <459bad3a225aa415fa359d638046f8cd7d26b0ab.1795014593.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795014593.git.William.Palacek@amd.com>
References: <cover.1795014593.git.William.Palacek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004D:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 28be316b-4fba-477c-ff91-08df45862435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: DK4FgwtmFRLrKmZFilwpMQGdYGZtbCU6twnxKLngwf6vtAuLqRSnam6v3/mye8QlgN6AKSPABTTKhGwz/dMk/VkULfDeGegrBwc5jqj5mAJ3Wxs3s1XQMyeUF4V9lUdsP+kud0gH3oe/gqGseeiHinVn4fZgWJzX+fDRRtXkkUugIh/IWb4yoaXCAreEgkvf8bdUt+UQGCtaK6DH/lfD3OgQqnvsuuu2Owb2Zy6aGCCMW3dj7csv6bUuqpSKeUgZddZ5LdRp4nq2p2IBYTjW7JGUtRhvRrI8prLxFpywOUUDqrTpXCxIpRuVqurq35911UzBQDlJ2TxpmP9FUA0o8fwVaBT3PI6z8Zxiq1uKpvfjFqOVRAWdqKH6FxEbYV1u3mSh1yZQsispuO7yyOiGDhHu7IOmXNi+EQ9Fj5Mf4OAOghZ2nBCmV1q2pjWLwHsDDyEMv5zfTBSMnor44xwbxPhOpmCg2tQPKWfXhdRAqcn6Cu/NilkTQ9WnwvPCv3KkFWmj08RqBfSwNgvAJaAydQmU0DlWiC2SykaBgcMcd+VpbPzc8lFYt4CkUaTAeaHgTPR0/QvafzJHmpPUzWL/qR4lk1wqnSICHb2Hul9sODlQK8CxOK+mB7wSxrATseZu724c/LM8nKBqrSRHjNJ7z8NyFFNifD3w60/XwAqua/uNE1f9LOtDPXeXMsu5PTgw1FJ+kYZZZcFu+6A37yXF8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: shGicmJKaD0LXhA2Xnq1EBbG6BkeDiN4O9i/YmzcN9TBz0NW39MoNBa2Z9iT/p4td2LZ05xc2XTe0I6Csq1GeBYDSSVDnQgbFuZ5CMldD65ombxu2GPKQwA5lDXXRWq/SIYrzfK+u58NxcybawwPtwdZm4wAcrBuru3rkNcp8IEzxIVD5HP0+MkHgsSetq2s4FAvIOI4tW2fiOFtMBpUOzcWibGyqXikwx852YM4sMKNt2w+LvvUVZDhqujkYZXBsUFpQ3jDpBjOx7C5r4XYvyrbDDTQHvh46eTMA2KZ1VZZCFLgwAhiElX+RdcTjstkb48xA8WgpC7E5TbdBmFSBCmrcSjFly4E/YElk1GznpP14Nd3Dg2YB9hpFXlFPBcAQ7mIHInvOfLlRDvUgPAsbBN3Ualn6mjqQxwZyITOtoWICGLCLGmBhc1ai+gTZO5M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:10:54.4464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28be316b-4fba-477c-ff91-08df45862435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
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

The ioctl takes p->mutex only to look up the pdd. p->pdds[] is filled
in create_process() before the process is published and freed only at
teardown, and the clock read that follows already uses the pdd without
the lock, so the lock protects nothing.

It does serialize every clock counter query of the process behind
whatever holds p->mutex. Threads submitting GPU work call this ioctl
(seen in a PyTorch workload on MI300X), so while one thread registered
and mapped a 32 GiB userptr, the others waited in it (205 ms measured
for one call).

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3d2136adb62b..9886bbd28ea2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -745,9 +745,8 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 	struct kfd_ioctl_get_clock_counters_args *args = data;
 	struct kfd_process_device *pdd;
 
-	mutex_lock(&p->mutex);
+	/* p->pdds[] is fixed from process creation to teardown, no lock needed */
 	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
-	mutex_unlock(&p->mutex);
 	if (pdd)
 		/* Reading GPU clock counter from KGD */
 		args->gpu_clock_counter = amdgpu_amdkfd_get_gpu_clock_counter(pdd->dev->adev);
-- 
2.43.0

