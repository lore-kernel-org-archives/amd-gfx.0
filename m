Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FACEB64DB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C2C10E2FE;
	Tue, 20 Jun 2023 17:16:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D8A10E301
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWMdU/z+kVlYbCOnaBT77TehhujU11Vvp2WdGJ57K/ZjtRsZgGT4dZDR3kXA7J0dbe4NP7pfQM8+oWQBzL+9ryiZfP1xMzQi94B0BT61gt16KLfk4elh0gAGH/Ko9/F7NZYtZNQ38EDI6g0QBMT66KbgMqiV9/Ezgr8UOC4lNjsw7BbkxCZMvgbouT2BgElTuvgybXmiMTilREGZ7XhOvF36BLMCMiqGqxhEsWIAk0bQ1s8Ug9p8m+CxYX5YUJl/7anyuI2M3lMg9YN4g7AFNTmjxqrffuz3R7tieqO9eRl7I9Xecw1ncQ+04eIcQ/FE7qVjb2KxQhLrOZPzFRoqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2fEeliQVWH8WS2n2U3KU57aT0sD0/t8BCwkuCnNvjw=;
 b=jTC/FUn54qlA8AloQluDG6JQ94OHtBYh/0JG+N04Ih5/7UFNvokpOTFENGiHSvAu9HeV1BFNFnFoktEFxMkUVjihAKK7tFBSGOG8AMQfM3f/H0d9Ty4CsbaBsviSefYe3TUQY5mnLFoJjXu1hNV9evPRNP+0IopTTg3RKSxoDOd+LCyrrE1RRFu1K1c+GInW9QkO5kjtRiuTH/Pe764Wa/QWM5nHXYe0H5tsMCqexEAxnv/6QA9Dam0eWrmcPQG45v5jqy8fPPLWXEk/f9UB0Ihv9Yi/KU0U+1RNHjqLjKAyJcnuo1hZiLGe8cPg1070LvbiHgsKZ/OLI600E+Aa0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2fEeliQVWH8WS2n2U3KU57aT0sD0/t8BCwkuCnNvjw=;
 b=NJ5T997v1eHH8ypTRm9HM/cNHInZmn0BNGdPmMmxshm3nfDDaGgFA8Q6iicCxQLysXnb0NfvXG8rXHjdIewJB417jY6FVREX88nxwmMDK/XMGXpRFqwu7nr8vzDWbYM32V9k3VH5RI+OCTO8jI2YeK31ehfLEQZWuu/A7yhZhkk=
Received: from BY5PR17CA0030.namprd17.prod.outlook.com (2603:10b6:a03:1b8::43)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 17:16:42 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1b8:cafe::83) by BY5PR17CA0030.outlook.office365.com
 (2603:10b6:a03:1b8::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:41 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:37 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 10/12] drm/amdgpu: remove unused functions and variables
Date: Tue, 20 Jun 2023 19:16:06 +0200
Message-ID: <20230620171608.2131-11-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcd8804-6d5e-448f-234a-08db71b21d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJlCf0E6h3JRkQJGtUN3l7dlr6PcOkG3+2mBd1VBCEXoiug7xA7fwA3H8fulU9riXtncxN+usxk6dS9o28AoAjPR7oY3lN4htYTPSBdaxBm42ZV/JZJcFXNAATXBN/G7miykuc+3uPNBs2PTj+eIRpP6xmNzl+WFbFOiKrPx1ruPRKTWoS1s1uh2hFMHz+a3m/xqnFv41ejJ6g0x44j9zHE79CYwJa6aqNwWmncOdA5q4Uel3mLEesxiC9to75zsQCOKd2tVX2dNjs1CBE1AeJ3h8I+faN3y+pYb1WegPFq0rqpUbMFr/I+1pwvv7hs4zjYQZUahc115xlhP/ZTYMYLyLqObRUFMzEZOfxRCo/77uHWps/oNHFVapCs4K16sqmupon/8rcPXFlzZsbBTlnNNTzH9Ch2WGhhDSkq09oF5YHrVLuhgF6aQdltmuA8A3iS/yO5Eb5XCa93Dau9ujxYa19t05cyWBPpPAEmvHxySQhiNdGCoZTvlSGVXOAdP6Ru8LE8w5iJa071b+DPbawQJG89pqkfqfEvKV7yHD68FxpKm/6HhIN8xLZ8TxLgleCVCno6eQegTCT+D51C54Ox6pDO5oY9yOCIYCUoecQgxDnK43JKOS8SQYHm4DGPhCTeFgvqCzI9xp/DBVbByB4YqFPSYdsNtj92RxbCK8BiXgIsVJNfe1ey6K8AxeHjOP85qEYD1B8BoJa2LIBp8TE2Kof9LRAS4OdWjEj7zTKGeRnM/1VlWWNKPkvxVNX/l/dW1IMCTE033UeO4Z8T3gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(6666004)(7696005)(478600001)(36860700001)(83380400001)(16526019)(186003)(1076003)(26005)(426003)(336012)(47076005)(36756003)(82310400005)(86362001)(81166007)(356005)(2616005)(82740400003)(40480700001)(4326008)(6916009)(70586007)(70206006)(316002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:41.4312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcd8804-6d5e-448f-234a-08db71b21d7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch removes some variables and functions from KFD
doorbell handling code, which are no more required since
doorbell manager is handling doorbell calculations.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 32 -----------------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 12 ---------
 2 files changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index c9ca21e1a99a..5423d717ccbb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -200,38 +200,6 @@ void write_kernel_doorbell64(void __iomem *db, u64 value)
 	}
 }
 
-unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
-					struct kfd_process_device *pdd,
-					unsigned int doorbell_id)
-{
-	/*
-	 * doorbell_base_dw_offset accounts for doorbells taken by KGD.
-	 * index * kfd_doorbell_process_slice/sizeof(u32) adjusts to
-	 * the process's doorbells. The offset returned is in dword
-	 * units regardless of the ASIC-dependent doorbell size.
-	 */
-	if (!kfd->shared_resources.enable_mes)
-		return kfd->doorbell_base_dw_offset +
-			pdd->doorbell_index
-			* kfd_doorbell_process_slice(kfd) / sizeof(u32) +
-			doorbell_id *
-			kfd->device_info.doorbell_size / sizeof(u32);
-	else
-		return amdgpu_mes_get_doorbell_dw_offset_in_bar(
-				(struct amdgpu_device *)kfd->adev,
-				pdd->doorbell_index, doorbell_id);
-}
-
-uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
-{
-	uint64_t num_of_elems = (kfd->shared_resources.doorbell_aperture_size -
-				kfd->shared_resources.doorbell_start_offset) /
-					kfd_doorbell_process_slice(kfd) + 1;
-
-	return num_of_elems;
-
-}
-
 static int init_doorbell_bitmap(struct qcm_process_device *qpd,
 				struct kfd_dev *dev)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d0abfaccf8c1..edbaba845d06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -260,15 +260,6 @@ struct kfd_dev {
 
 	unsigned int id;		/* topology stub index */
 
-	phys_addr_t doorbell_base;	/* Start of actual doorbells used by
-					 * KFD. It is aligned for mapping
-					 * into user mode
-					 */
-	size_t doorbell_base_dw_offset;	/* Offset from the start of the PCI
-					 * doorbell BAR to the first KFD
-					 * doorbell in dwords. GFX reserves
-					 * the segment before this offset.
-					 */
 	u32 __iomem *doorbell_kernel_ptr; /* This is a pointer for a doorbells
 					   * page used by kernel queue
 					   */
@@ -279,8 +270,6 @@ struct kfd_dev {
 
 	const struct kfd2kgd_calls *kfd2kgd;
 	struct mutex doorbell_mutex;
-	DECLARE_BITMAP(doorbell_available_index,
-			KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
 
 	void *gtt_mem;
 	uint64_t gtt_start_gpu_addr;
@@ -757,7 +746,6 @@ struct kfd_process_device {
 	struct attribute attr_evict;
 
 	struct kobject *kobj_stats;
-	unsigned int doorbell_index;
 
 	/*
 	 * @cu_occupancy: Reports occupancy of Compute Units (CU) of a process
-- 
2.40.1

