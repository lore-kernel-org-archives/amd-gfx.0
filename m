Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756D4CF2560
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 23:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B8110E540;
	Tue, 18 Nov 2025 23:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jixUs/il";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DE610E540
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 23:00:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tqe6EMVCLwIiQE7APj64B3fYkbI00vfrm/Wj0kPkvV6EOhd29fTVJ20/u6IvNDVTsDvdSN3Oz79nrH+aMhVkRXctawfZ137xuA/pT/FuDLANZcekZiJa4zZPVILl9hKVNrGv+rTklxRBxYUBaXxFYxYTn8Edf8ZdtleIZE4Y+suquR45VdqhXmKaLluIyZSrYjoXaJ6JkV1n3SZsZv9sFqhdo9msOEzgH39zWyPCd2MP12t+eEJi5AZkxEE8a2VPNrNUuA1FSzBsvizVeWrsa/NdDgf9ALwk91Uab+plIkMDOTVaSANHhBJx4P+wD3rU4n9pPeyORdMbR7ZJLo9ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t5GPrFHddHtb4zS1/hWnma4FMbqyJSr81F3EaA6ACE=;
 b=a3EHfzGF4vrPL4dDecsIYUfM0AY2mzXRcF4U9PG9pPAoqcK2O8t89kyCsxqkfJ1M3nkf3/ufhZUyiQKU7Ha9xooCkC694PbsYm4exmySU5iRQ1aQljTkbBurC5HpdyTa5GHkOOtNde2cV8Lcf7i9oPIvY3hDmNzTEIswk9SzC6EqHyCO+DTo+XUqkjAqJmHwjYYpRJfTQE/u1dSQ6mpl+uPvSd8kvDWV0eH96AvsfWLBHYFNlwuFFRzhUU85cxqmidvCD5MGjCpBmhI5UMtGACUcJ+pE4wkIgoSH3oGGv52TuVo/hlsZir8VdApwA8JBGamXBJU87O1vWtpf9PfUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t5GPrFHddHtb4zS1/hWnma4FMbqyJSr81F3EaA6ACE=;
 b=jixUs/ilQwy+yR5dsp+2JBAeuFoeq46OUiJVjymOcnb7cuFAYu3cKRsU3jl/X5I6UrwzNdhuRsu2+fpvctrhcE+D547nWWX6JUEni6IlMdwxAWSmpxFc+B5nNqpB5GkZUEMAzh6EUyLqEUk8tQ8G29CBdICEhUG3xTm0uetNXjY=
Received: from CH0PR08CA0017.namprd08.prod.outlook.com (2603:10b6:610:33::22)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 23:00:12 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::d) by CH0PR08CA0017.outlook.office365.com
 (2603:10b6:610:33::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 23:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 23:00:11 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 15:00:10 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable IH CAM on IH 7.1.0
Date: Tue, 18 Nov 2025 17:59:56 -0500
Message-ID: <20251118225956.3613357-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118225956.3613357-1-alexander.deucher@amd.com>
References: <20251118225956.3613357-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 673de532-ac0e-418c-c9c8-08de26f63a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aqjF9UKSMmiPuMDuTSGXr21nbMOnJmaFObThlyZhYPWDFT/1Tkn78Rq45Dp1?=
 =?us-ascii?Q?05guFJqCmyKI2KiNZeKovf76R3dmeboH+tvHLsIm/Mp/jiu/VEKL0gbbzS6W?=
 =?us-ascii?Q?S38wQq4Lmh3cEGGdfrAD7/4OoVnBaamp4SjQanh6MHn8hb0IGZBjK9uVTdn5?=
 =?us-ascii?Q?MGvF+so4LiEbMYAZ2rwqgc2Q5KdgQp1ewDSTVTbEDDMVBrrIxkvHH3OuqP9o?=
 =?us-ascii?Q?5Bz5rb2RG8kuBjXZO7mX8MIcF6V78nUVKb5jKAX75mjO3zuWxt8IXrT5J9Cy?=
 =?us-ascii?Q?8nU57/5p2NlHAk+rVOFgSNRQIVkzxqRt7UBfAVeoPFeCUCERxRG5tIY14owM?=
 =?us-ascii?Q?EJiN5pzuKY26VW4LlklV2G9UguPg+7oON9ZZ/gTAH7EMSLr953oNdCDajXul?=
 =?us-ascii?Q?0N0/FwOc5/jj+UxGRUs+ud2GBDHd/2ILGW/AIaskhz3zq99/gLiXGavKMgVH?=
 =?us-ascii?Q?sglqvKzwHpYtUR8s9dJxfTF/eHyUV0XHREPrvpmcUcJq48SqH26gWmeDvVIQ?=
 =?us-ascii?Q?psAh8W0XisULMeN2dFMMEqoDFQC4ycfMdIT/FL26x5CaMumt8XjGE2B03QY3?=
 =?us-ascii?Q?oVkXLyL97N0rHfz4X+WV/bLG0FGeEp83FJGPxr0jFfjsh9reM9VPuVNYJE6I?=
 =?us-ascii?Q?OaAQa/OKuds602Zxpa0DZsOFTAs9BwGGvqU+h1gI2qDDowKprCbN6fL570jb?=
 =?us-ascii?Q?nUYgKUXn6hpn8KYop4w9UR7ww+2YNFzNWdNTqzvrUz2VDnIrljlgo2P7BEZH?=
 =?us-ascii?Q?c7J+n/WZC19wLb/WTlT5DiyqDIpHZezFcHKu6zbMHsBQty0cIanizRtEksjc?=
 =?us-ascii?Q?Er43Q4EUA8GE0Qiy07Mc27QcjnhUGkbeHd9eVzRtA21bSKt0CYlJEmvA4WYq?=
 =?us-ascii?Q?DDZseNMGEW+w8u6734qqGcYNpWmUdO1eaDpDRYauJ0a5WiwkvSK/tZAFN51c?=
 =?us-ascii?Q?H1ripRDlQFN4LCt2BqU/NvNPPKXHjG3WR3ljfzo5NB4OqaE+9y/oY79eLMz7?=
 =?us-ascii?Q?lddUqoBtNZ85ZykGuD0adZ5QSbrOOc/0fw+PIC6iYbfGsLW/nK3YP6UZpK/S?=
 =?us-ascii?Q?Md0jjTe85/V+2Nwy8APywbVtfyA8kDmsPTKDwG8ygXlSTfpKJJ5489/zNWag?=
 =?us-ascii?Q?3bC56EGkCAUQN1BcHH8kFpjpKRYwwO4oA1UUZRdA64HWGqvpSCMbDbqc7U1k?=
 =?us-ascii?Q?ewux/jA/nr2PXO0ovNglyHciXX2GEhmhz/9Jt9vKbJRM2Jp7p90Eq4dwKfYs?=
 =?us-ascii?Q?echiN8xvElnrSiGIGtrc9X3Vm6BST5GhNOnwO9UyDSYADENHKzTDIESDbL71?=
 =?us-ascii?Q?gajYCoPBCuYNwqIxs8sq0kY7l+ZKLuH9lwOK2C6FESfg6TVY8hitzdtRTeca?=
 =?us-ascii?Q?WhVuSxL/FFsyLIHPnZVmtDkpHih/JxZK/0qsnH/yll0C4gcsF0G9PqhdaxJt?=
 =?us-ascii?Q?pWautuxsqgCbBHsGww8BW6/rszBP6z1YWyg19Q6vnWF30rwV0MpBE9ifOJQ9?=
 =?us-ascii?Q?tsw/MOetKuYPPZJkyP9fiQdEsADoMBw8QK0/Qf7BQptKqfurgbuIv+gF4KZ8?=
 =?us-ascii?Q?sn5V0AEqVRK+fytGS08=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 23:00:11.3462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 673de532-ac0e-418c-c9c8-08de26f63a3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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

From: Mukul Joshi <mukul.joshi@amd.com>

Enable IH CAM to handle retry faults on IH 7.1.0.
Also increase the soft ring size.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 30 +++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index b32ea4129c616..451828bf583e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -279,6 +279,16 @@ static int ih_v7_0_enable_ring(struct amdgpu_device *adev,
 	return 0;
 }
 
+static uint32_t ih_v7_0_setup_retry_doorbell(u32 doorbell_index)
+{
+	u32 val = 0;
+
+	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET, doorbell_index);
+	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
+
+	return val;
+}
+
 /**
  * ih_v7_0_irq_init - init and enable the interrupt ring
  *
@@ -363,6 +373,21 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 
 	pci_set_master(adev->pdev);
 
+	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) {
+		/* Allocate the doorbell for IH Retry CAM */
+		adev->irq.retry_cam_doorbell_index = (adev->doorbell_index.ih + 2) << 1;
+		WREG32_SOC15(OSSSYS, 0, regIH_DOORBELL_RETRY_CAM,
+				ih_v7_0_setup_retry_doorbell(adev->irq.retry_cam_doorbell_index));
+
+		/* Enable IH Retry CAM */
+		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL);
+		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
+		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, CAM_SIZE, 0xF);
+		WREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL, tmp);
+
+		adev->irq.retry_cam_enabled = true;
+	}
+
 	/* enable interrupts */
 	ret = ih_v7_0_toggle_interrupts(adev, true);
 	if (ret)
@@ -542,6 +567,7 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 	bool use_bus_addr;
+	unsigned int sw_ring_size;
 
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
 			      &adev->irq.self_irq);
@@ -573,7 +599,9 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* initialize ih control register offset */
 	ih_v7_0_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	sw_ring_size = (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) ?
+			IH_SW_RING_SIZE : PAGE_SIZE;
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, sw_ring_size, true);
 	if (r)
 		return r;
 
-- 
2.51.1

