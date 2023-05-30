Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B66C77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 12:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF6D10E06B;
	Tue, 30 May 2023 12:48:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FC310E06B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 12:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfkaYN7+BSutFgSLkEeUQ+HChA+HdjECq+4mLtuAZk7ttPyQZ/txXFS5wkmpPY6IYhsq/nEQ4TuMJrHM9Eiyf+CT2Zmbkr2UbQX4R16VDExPVo91HUaFNuyA3B9HbAjY94t0sduoQ0iopQcc8mMn7+Xs2dbyuMzB4fXDqZpJbB1ZunZSMJD6vnO6ecDu4tFlLxae0SV41CqjMEJR3DVKmuoID0WgLoSwHT1v0b0Ik0J/gWILSHuS/W10tin1T0Pv2ZkK1OsnMrauooKvwJEYOh45pAGPCyysaFh2SXDhdbybsjZV5127+HCglYbRTYEvtM0EAsLtQq6TGkncw/brww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PH1xoS0tONIpK0kNEHJW7WDYfSwOg5bcrzVAA6rFaw=;
 b=JYiVj0oeWuugpnUtWx9tdxDdCtqgJ3iMgtkr2GwPObY3+fBz0iv9+TmwrwdIeFeeraEdZYGZMF4U8HubIqJ6t64Ts25V1BISGRW5ppGeFmPfXh/sPmR82uBvhv9HZxBEObQtpZvF8Shfvt1XaXtr192V+HXW6TSwWGeX1SQqp9ZdKGTEbEjGk7cyhmWvbjdJe1PPGJSHecAZRqco6f3DWS0B0lGDjduIK6fyq1SkKKkbCRE+AyK21mgPJf30/yS04dQPkSfcK1TqWqQfSzQ1XPnnrLV6kEkjoHxb8s5X/yCUoCYaq01felI1GCOvofQXRT5c+2M/OlHBacr7deznXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PH1xoS0tONIpK0kNEHJW7WDYfSwOg5bcrzVAA6rFaw=;
 b=scDdisYdp4L8b+b/Bk2g8FsZL+wuIcA91rPh7O/R9HNWl0GTGEtKKfBPMd9wYPmioWNA96DVYCpi+Rmq4QOPhhytgOx0vh89VLpNNa8maQysFRShatcbUCH5RxImW3X5RV8NdqJzWihM2ye9OBK09iZzxOIohHNlNVBQ3d9r8kM=
Received: from MW3PR06CA0013.namprd06.prod.outlook.com (2603:10b6:303:2a::18)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 12:48:49 +0000
Received: from CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::67) by MW3PR06CA0013.outlook.office365.com
 (2603:10b6:303:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 12:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT105.mail.protection.outlook.com (10.13.175.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 12:48:48 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 07:48:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix up missing kdoc parameter 'inst' in
 get_wave_count() & kgd_gfx_v9_get_cu_occupancy()
Date: Tue, 30 May 2023 18:18:17 +0530
Message-ID: <20230530124817.2753759-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT105:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: d963936c-1afe-4443-8371-08db610c3690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fF5g/y5NjnLzFnpip164Uzcj8W06D5wjkwcvpzr22BlZLUfcqU0A7a2A3DDs8x+HPCqRRRq/Hk3jYiimN7yvh3SfarvWN4gyYRvm3owHS6W4PC6X6DL9zfiTVyV6AhjmIvFsYdiVN4UTil+J3rgsle2oDV9QWjE2gSfeeqt5oKDPcxpUarQ14WVYfcXTKIGfRonbdg3oKAM9PmlbeCNlXNtgJr3L56jt9mwLIOpoS+e+uTG0/fvfxAvsYQBXXaPpxy2AIVQtloHfBLHJehcPFrcxzLqLenpaS0aVKDHpPI9TspPMEW4P9wDIgR+hGRy02roB3zbVdD8ehbFsaYWc4VrHFtnqIYxmChGGqEZNI+VV2ByA2JGXLmg1oCvYT3EvMa2WLMdMTE7bqwRkazvFlJ9I5FOZO36N/MPE1xKMjN2G/A29Le0pPFoKRmMfwh4hacr7CuILM/7xU6jhVmKfXPtUS841jbhnnMuycc9ClPEkuL2xD8Zq9E8dsjbgoNXhkvip3yDVIpahMz/71ghM+yi79bHVr4BHFJIoHwYc/d02WRiQ6qyZzKE+atRk3IaB3JoMRgLVju4XEv9cMmnyCIExzwy6kJGYPMvBLB4vG3tQ31Q3i+8aT364VaqKmnxMnm826Fkuo+0dYo/eOD1JLXJgyyblu+EOQUfAXurJ97Nh5t4GqNbGs+Xsy31abqTI+jQoJVQYn19wHAKzhF8VxLM68QmmSENAcIIULPQ3jmwLzwQc8JSVfeVnXDhpv5eifpALcYpd81jsthyBUFoU2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(54906003)(110136005)(478600001)(81166007)(356005)(70206006)(70586007)(7696005)(41300700001)(8676002)(5660300002)(86362001)(8936002)(82310400005)(44832011)(26005)(2906002)(36860700001)(16526019)(186003)(1076003)(83380400001)(40460700003)(47076005)(66574015)(6636002)(4326008)(316002)(6666004)(40480700001)(426003)(336012)(2616005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 12:48:48.4593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d963936c-1afe-4443-8371-08db610c3690
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix these warnings by adding 'inst' arguments to kdocs.

gcc with W=1
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:692: warning: Function parameter or member 'inst' not described in 'get_wave_count'
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:763: warning: Function parameter or member 'inst' not described in 'kgd_gfx_v9_get_cu_occupancy'

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 9fa9aab22fe9..34bf030f3137 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -685,7 +685,8 @@ static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
  * @queue_idx: Index of queue in the queue-map bit-field
  * @wave_cnt: Output parameter updated with number of waves in flight
  * @vmid: Output parameter updated with VMID of queue whose wave count
- * is being collected
+ *        is being collected
+ * @inst: xcc's instance number on a multi-XCC setup
  */
 static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
 		int *wave_cnt, int *vmid, uint32_t inst)
@@ -721,9 +722,10 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
  * @adev: Handle of device from which to get number of waves in flight
  * @pasid: Identifies the process for which this query call is invoked
  * @pasid_wave_cnt: Output parameter updated with number of waves in flight that
- * belong to process with given pasid
+ *                  belong to process with given pasid
  * @max_waves_per_cu: Output parameter updated with maximum number of waves
- * possible per Compute Unit
+ *                    possible per Compute Unit
+ * @inst: xcc's instance number on a multi-XCC setup
  *
  * Note: It's possible that the device has too many queues (oversubscription)
  * in which case a VMID could be remapped to a different PASID. This could lead
-- 
2.25.1

