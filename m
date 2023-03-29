Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F50C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B03510EB2A;
	Wed, 29 Mar 2023 15:26:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEAFE10EB25
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hekcv/A/9Ymbij2Yrm4+pr81AlX2YjnppszIdK2ge8FZzGsvIVfggEIgavzMMGR2c5k/h1Qsr9mieGDJwILV5aUUECtmxPb65K3qwU8elyrwbT3cYLVx1W+AYJPyGwsuiIYcXII2vmJ2w7e1UqO56/9wwbAmALLrC/0uG6b7oR4XfEosflNJHBdFHmDPTj1XeDD6lC6BQN2QoVhQUnheWk/8pqyG9LojN513Ns6VYgSEB7e6e1H+JZCH9w2V9UWhFoSuwe64HjtOCccYsE2TQ7zK1v3x8jHL5wYd88kYLfbAJtV0SGxvtzrQExZQ8pe81pvxW0ZXhihsw1OIm0h5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP8TdcQ7fOBVSOx1VcvZ+5le8IzJVj5vEelNeSyGjGY=;
 b=eplvjd6DbCRSZQatHdsZT5WuUBVZNOHx3T6NFbLMcvgFgVhn//5VArU9UXimYeM26YfYEC4jk3A1EPLxItvZ5hPZZyJ+NthKQ/nBOSy1gRzs5r6AWhZNwDefbi2M9eMm3E043+TjoLVRch2Jgx4F1helCRfZFA4oasckD7jfmoi0ZpsoF8Kr8oD9J1QlGtH55kuo6jpgdA8EVD4ddei8CyrP29MAo76H1MSQuSCuoG1vvZzsGs9rm5+xQrX+nNYLbAGz9s4KGqJXSOYl9YgCiQEbYh1/DxN7qobinmeba/Tw0rooFS8y76JS/0MmYufi6mzt64jHyMBSGtIZOVhT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP8TdcQ7fOBVSOx1VcvZ+5le8IzJVj5vEelNeSyGjGY=;
 b=NUNxhDUopXrUwmBVZ2ASZ/CT0DAg8dqAMhw39ItBuGsOlfmZdKWjEYqW8/taB/7Pv/jGo5IHGCIH9aCTgsx+TTGMXy6ovYhj+G2z+RGO/EkB0SEN4v1F6j9zxbN1RnSwigqLNfGFc3JYppelrbtpSuC/gXmCdZ8zdvOmDDcN9yM=
Received: from BL0PR02CA0135.namprd02.prod.outlook.com (2603:10b6:208:35::40)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 15:25:41 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::72) by BL0PR02CA0135.outlook.office365.com
 (2603:10b6:208:35::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amdgpu: track MQD size for gfx and compute
Date: Wed, 29 Mar 2023 11:25:20 -0400
Message-ID: <20230329152521.1980681-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329152521.1980681-1-alexander.deucher@amd.com>
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1bcf4e-6a68-479d-0184-08db3069db85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7z3EhxuBGDlRnbVBYrAMORpgduvwdryGNjXl31Tgsb7kG9To4kQlC2TK3fdyswZbinUqk48zL3y8UqsGNDoHH0K58Bt9ttVlq9RBjGJIJc7S2lXyVUywRLriQMeTe945xhZ5LJbcxr/jg6xq1Qhzj8ah+DU9peWK1SEHBCGWLdz7M+a044qKI4MbecgY3Vo4u+lyy0BL4ZYvHXpz3L7HcILtW6gAUo4WUNW7ZdfRuJ4JUrrV5jY/NcRrQJsqmPm1mugAPsUoAuYAP/+eUKbxdH0h2PJU9UL46tOlOh5ettT/uWqYnb1eVq0dX0fv8BtaOhEytvY5pfZb0wkxNneH05HGjMb1kIaAvFpWswMb20/WbWXD5nfvAcM/IGbxlsdnBN7NE4D8pWFRXWTQ0ws8LPsp9NdWbOHmQ5wkoCls0tjuri9pin/7N83Z1dNDaW0yMt9RZ+LNtpfsk2g17SiKaVDIWkJzC52M05hmAf0f428dDHRW4QHYbKTyWRg4Zk8o6EWvoWiQ4iArc3I0pXYHF/3GIM3iO4+KuyxTbyqo+Bwcnj625OGymVKliMmPgnniu+bF1pfbWsBKUfdUGITeFJp5dclvLixee1Xg23wH6ykFaa6S5dnkho4SchI789dL3GvvIK9clWLkeS9MIP+CRUuJzYkXeswmrmdo0wdGphkyWgGNaMqRnXf5gekTGgPWsmc2EjkGKNnNFe3PZCC86u9IvVcE+HPE7fAVf+FBqI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(2906002)(336012)(426003)(2616005)(86362001)(36860700001)(41300700001)(36756003)(40460700003)(5660300002)(81166007)(82740400003)(356005)(40480700001)(54906003)(7696005)(478600001)(8676002)(6916009)(70206006)(70586007)(4326008)(16526019)(6666004)(186003)(82310400005)(1076003)(316002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:41.5370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1bcf4e-6a68-479d-0184-08db3069db85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It varies by generation and we need to know the size
to expose this via debugfs.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c50d59855011..5435f41a3b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -404,6 +404,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 					return r;
 				}
 
+				ring->mqd_size = mqd_size;
 				/* prepare MQD backup */
 				adev->gfx.me.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
 				if (!adev->gfx.me.mqd_backup[i])
@@ -424,6 +425,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 				return r;
 			}
 
+			ring->mqd_size = mqd_size;
 			/* prepare MQD backup */
 			adev->gfx.mec.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
 			if (!adev->gfx.mec.mqd_backup[i])
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7942cb62e52c..deb9f7bead02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -257,6 +257,7 @@ struct amdgpu_ring {
 	struct amdgpu_bo	*mqd_obj;
 	uint64_t                mqd_gpu_addr;
 	void                    *mqd_ptr;
+	unsigned                mqd_size;
 	uint64_t                eop_gpu_addr;
 	u32			doorbell_index;
 	bool			use_doorbell;
-- 
2.39.2

