Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D35C77B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 10:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0689610E50B;
	Thu, 18 May 2023 10:54:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A6810E50B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 10:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dd7Z64DjHKF/y6gjWsLH/kYNbw9lLf3YF30Kd1Wn6bV6QKURu+U84LOZZeiotVlG9za5DY02BAnu8i3/KK0WnVk36UKn00qR+JZuut1n/jkp2Hhxqfi3V7iFQoh9O7pL0pAqk/HE3poSX4sCZzxY1zYZBQal+OgMpzRPQD8y86TU6j3ejuy8T0v6qWUOTtVTLamK8sjouQnZkE0t3zQUmEdHHU9OlEk25Vs9i7gLq4jJx+gMxHFsnUpjr6zS8hhKadx5NP+0vm2yCZTqNvx/t6cVSs3ZagrcD7bPKylpre0FeyrVsFdmla6ArAJXGvV3iAgLSDrJI812yBtG93knmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDddOjMAzm9Y0+if98UHeAWrFZLByuSBbCPuCBHdFCc=;
 b=lyNx8hzRSqx7DGDjMIHldaMj5tKiVhl7UV+R94lWVNMhjOv7VbfoDjhu5YOACH6Sh+GFkTRtnhA1OU8GLB1d43wYKPsJAE6Gny2M3SrGIgpFwnG+kl2+UsR4bmrJ1WQQzQOitPx367uqrboWT/EFQppobURqsZ26zhOU9vWWnI+oJFcjyS3GZg2fno2sSo1xznf9hxe4r+b1s20qtyyS5KUhvWhlBaqZcGlxt7qvXlpgtNmT+YXt1ivrp5AEqFrPyISlFKB7IilARggvGHLYYpgR5K6pcAsuz0DmxRysq+RVb3XBjZQ6gQ1F7RUBU/ZjGC6dAaAtxI8QAXkVQ4FmaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDddOjMAzm9Y0+if98UHeAWrFZLByuSBbCPuCBHdFCc=;
 b=ISRDWCP/n5I4FiS0irQd7YCtmjBf43KmiMQ7zGSOklEo2QN0Rl4MiU5jnOBfLmSWsKwJp7QdqXHvESKkDDky/4qr7G9YZG1uf1gSCj2s+5NFh3hr1sR0IZA1xWn+ZQY4ITgt2ygtj067++JRvQlwJfPCMzAn2WrhKovQWRALWLA=
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 10:53:51 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::34) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 10:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 10:53:51 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 05:53:49 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amdgpu: fix the memory override in kiq ring struct
Date: Thu, 18 May 2023 18:53:24 +0800
Message-ID: <20230518105325.15609-8-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518105325.15609-1-shiwu.zhang@amd.com>
References: <20230518105325.15609-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8dafd2-863a-41f5-7f1b-08db578e2ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16TnjkFt7AxSTgxYdwTOy2dT10xe+eo2Q6O1Y9bR8EuLZjo3tp0lPdSpnr5VNjBmz0L170bbwuLwnmV1jsKzaKyx6Mx3JNyZa5kHV62bOSjANNW/OB/7+739HTbiWimut4339zMhrE/cy9/g/ul0XCKDmo3ojVxvmOvE2oYTbyF55xvW7M0TEOYgU7wXo2VA02iXIamgIvfgMyK210Cdl9lsByBEcDx2mhc8D1cwshn/lCwYUXnNtkhamQuDfs7VrTLo8xVAUyeFlf5iLBVWfZcUcaYgp125P3Se3wfIzX8FhaFkA3jLN4ScXddcnr+6R+7zbdGfQ/NaG/nDH43XB0YFabPhOBNdsbGYF3CSzAWFnJBmLqeB/OLOoVkWH1BZdos84hWKhmX43cM1wDCRu19hxR7C1bQvMrnZmyWH6BynUbwgNJ8OMsy35Qdr+bu3dQVsefAx+aeNrcBB2I3yQ2x8XPaHSAurhuPlseqMD4Vyua3QTORmlSjd5FaftL3O1/atpFsWU6rsABJZrEXlkJDPJRXy+qqpvo/l8ph2eObWCdTWUtOEnjtsIvjmI/vlFccGz2OgYCZ7dwFwvkG603MVmSJvJG7jdLT/vDNw8g+wvGK/Ovr+ngl7n9U2Bh2CmQ5AjrFJOnYVbVIiEWrc5kKJHtCjvg2aEdcLVcZ7stRvqnm/aJFrp39Danmy5rI4hjCUy0jiUSbTx6oKYBTbO+C2v12lSpS8kRegYXogr1jj3xhcgKi/cljjPLUU/ucDBJ29myyLwPo9R/KyooIRKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(186003)(1076003)(26005)(40480700001)(6666004)(16526019)(36756003)(7696005)(36860700001)(2616005)(426003)(336012)(47076005)(316002)(40460700003)(6916009)(2906002)(4744005)(70206006)(82740400003)(70586007)(82310400005)(8676002)(86362001)(5660300002)(41300700001)(44832011)(8936002)(478600001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 10:53:51.4899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8dafd2-863a-41f5-7f1b-08db578e2ab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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

This is introduced by the code merge and will let the
adev->gfx.kiq[0].ring struct being overrided

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8883d5ee13cb..460a771e34a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -448,8 +448,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 
 			ring->mqd_size = mqd_size;
 			/* prepare MQD backup */
-			adev->gfx.mec.mqd_backup[j + xcc_id * adev->gfx.num_compute_rings] = kmalloc(mqd_size, GFP_KERNEL);
-			if (!adev->gfx.mec.mqd_backup[j + xcc_id * adev->gfx.num_compute_rings])
+			adev->gfx.mec.mqd_backup[j] = kmalloc(mqd_size, GFP_KERNEL);
+			if (!adev->gfx.mec.mqd_backup[j])
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 		}
 	}
-- 
2.17.1

