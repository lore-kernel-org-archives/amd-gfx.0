Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA48C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B7210E536;
	Wed, 10 May 2023 21:24:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6CCA10E52C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGL/IwiibcipXm5sEFxCwyAF2NgWMm68iCNsYLFQmS6FY8giK/juW7MSnex9Vcl1fkOSmYY5FmsrlBDFP6VSx+9p+qF3dkNuuDwllouu4leG/qVyO2vEvVQ63i7KS1WPKtSu6/CXhbanFbX4L64/jyScc2USoV0DQ4lT8fHSOBFUc9kF1p5K9GHI1oAMR6sT2xFiHk45wCYZQCXATYMOP/652LHRPndw3Z6+WCN+CW8kxfbWCvK7yx+vLka42j6IXxTqp1T0mO2vw/Mbwk00yzlzgrnK/kRXG42CWho2PhHnTWdJGnuIMUYPfAj4KptjrOgm9ZAYDZuwGbkU7VI2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm6Ybkw7eK6339lg9wS+XLzIjhW1WGFfGyUV8RWjKu0=;
 b=n4WCtbOcqhFgZIPs8q9xFJWCwG2iexmUgmzj3LwhnSN+KsoChlr8D9IcBFqBGBy/qH4Z6fYRs9BR1BgXs/jz9eW7iM4yMg9WKJ73SBdUpzSCFqsAsJawBo3dXAiu+tUTmG5Cf0mmee+xemQkQ0aGnffxLvplLl7Wu+gaPxdzLmss3wsJfWLgrf5e5uwCJNDby82NTCTPL6fXnwxZa6f0afVkYgTchGHnKa8X4jr248ZD6Y59eJsLxEJ7sZsr84afcsCc85wr1yCjqKomzMbAW2qLRujRcL4aBef1ka9/ZIJVXkyuGnXUH2JbqVN5wqBSuQxt4VzcE5fMaC32nJiZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm6Ybkw7eK6339lg9wS+XLzIjhW1WGFfGyUV8RWjKu0=;
 b=Iy7xNJl13pfsN1Q7gImsJVPLR8ehHqwqGjrPA9bbsRI93HTSVEGCTxLi36ob1ZvcYfjTrAinHXOIwOj/tcHTalzdBGKT3yPUXxnFQFrgSQ9KShDAnKIRlI5JvKEIcT5DXQhhmAA5wiEfLAFSLaxGkFchxxPM9uqLTRtO1ILu2LY=
Received: from MW4PR03CA0073.namprd03.prod.outlook.com (2603:10b6:303:b6::18)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 21:23:56 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::c5) by MW4PR03CA0073.outlook.office365.com
 (2603:10b6:303:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/29] drm/amdkfd: Show KFD node memory partition info
Date: Wed, 10 May 2023 17:23:17 -0400
Message-ID: <20230510212333.2071373-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|BN9PR12MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3650dc-91d2-4d71-0baf-08db519cdcf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8oUffnX2Do7tqfo4/sUehHmAcDB4fE/X+a6HnNqjxKUBZDxKXHZOzmQ4R7tEwDfPkpbyo03rh8SAlOzFDxa4cl7nKJddofXAfI7qbQeRXHxsYzXYtJmQCw9eERTZEX2s3y4JRjAvpWdUtz8vFXQJMWygBaanaxE6IL4bRjiJwrIL0xkHSDpGr8KVzoYhFBbHQ+HiPQiEv4bF6nCELbCtbBgS2/U+mb/1uoYSNhk+0tTJcdYtjKUuT/BW7upvmbH0HoiTU/3JCvcRLshpmvHJclIiPtGO6I6iaj1Ftsel60lLR9DRMq5pYWiyWXsQuTlbZ+L88y9t7hlIh5gWne/9sU9LDkyIsPjp3cD+w4cyGu54t+dcj+E2LdDSFTVG2502vPhCe37MJgkYTtKuzDZYEbdl8gPtuVSMiCF9GcOMXA0K7XBjyCpTUQLxqWgQrGgxi1ixZ56yDZewdSms4l0wTevqwG/+maSb2o3/LWpJj7QWu9aKbu1D5WE6KkscrWfXu367oXYjKK1+DvTVkkPK00nm1R3/MZ8+K75k3c6YeA1oNBIxawjZGSmy0WTvHWxrlDz5SrYLas6YNh2K6xqxYaHBSGMYGSunJbqah1uSPpM9YS2+Dpl1dZr/8t3fGDBUINP+uLdHNmWFcBLfPgPfoQB527tQkLDLmZgoDA6Z9XcgWkB+YDFDTcEaoDU1NarjkRDs7vd6oGQdpBvTpevMGCHg0rE3mNK943NDavpTHY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(478600001)(7696005)(336012)(2616005)(426003)(40480700001)(40460700003)(47076005)(83380400001)(82310400005)(82740400003)(356005)(41300700001)(81166007)(1076003)(70586007)(54906003)(70206006)(86362001)(6666004)(26005)(4326008)(5660300002)(316002)(6916009)(8676002)(186003)(8936002)(16526019)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:56.5224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3650dc-91d2-4d71-0baf-08db519cdcf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

Show KFD node memory partition id and size, add helper function
KFD_XCP_MEMORY_SIZE to get kfd node memory size, will be used
later to support memory accounting per partition.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e4e1dbba060a..324cb566ca2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -330,6 +330,11 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag);
 
+#define KFD_XCP_MEMORY_SIZE(n) ((n)->adev->gmc.num_mem_partitions ?\
+		(n)->adev->gmc.mem_partitions[(n)->xcp->mem_id].size /\
+		(n)->adev->xcp_mgr->num_xcp_per_mem_partition :\
+		(n)->adev->gmc.real_vram_size)
+
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b5497d2ee984..db5b53fcdf11 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -724,7 +724,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	kfd_cwsr_init(kfd);
 
-	/* TODO: Needs to be updated for memory partitioning */
 	svm_migrate_init(kfd->adev);
 
 	amdgpu_amdkfd_get_local_mem_info(kfd->adev, &kfd->local_mem_info);
@@ -754,6 +753,12 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 				(1U << NUM_XCC(kfd->adev->gfx.xcc_mask)) - 1;
 		}
 
+		if (node->xcp) {
+			dev_info(kfd_device, "KFD node %d partition %d size %lldM\n",
+				node->node_id, node->xcp->mem_id,
+				KFD_XCP_MEMORY_SIZE(node) >> 20);
+		}
+
 		if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) &&
 		    partition_mode == AMDGPU_CPX_PARTITION_MODE &&
 		    kfd->num_nodes != 1) {
-- 
2.40.1

