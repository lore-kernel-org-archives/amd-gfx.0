Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E311C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 07:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7AF10E70A;
	Wed, 16 Feb 2022 07:22:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890AB10E70A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 07:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUE8FeMJNRSMTwRmoQsqXThxqfT807BpA0D5p6zQwY2tRNr0pVlxVhHU9C9tlwocnGeRVsKo1Zli08kblPtHgq4EWWujJIWNXbmK2oxMvMAIm0b5TVYLNtVJbaEicI+ybpe714vFKvkf4ARttuZ0WcyNwdilJeIGalWAhi086Do3SxdKkrk9luetDmnlKLORmoEzuRhvm/diimHUptiKagwDnrxoPAl2cAQWmGe5Dk+20QGDD10cJTEX/VhTFm3+JG46rHUZQeZvvISAP761un3ZG9Su2lIvYiqhBA3qMIPBTAtcif5cHhkW5QkxovCpMgeno/fOqZCsKkomTgoWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LfyOiMI2I3JkIwc7C3rJ44TJ/VESt6VYCgxI4Q+VJ8=;
 b=JVWcejN5bRDV/QcCjpFmyZVpKysH4MUTj5E3goeTXvKN/RthNEiZPZP/H+jJByCHeX4jh06OIGvR3AQs8BD9YBwqvGAwPcQav5yo0lP1NxvrWKtsl3HljFt1iGnsM6cDRIgfk6OoYM8dtP0Blxpj1t+NnI8DH+btCoRnDtVxnqmBdIj07R0ErbpP9JoGxo6Ct9sSBuozRS3l7LV6FkXrRCC4rnGYF7gre7KKy7d5Cuf5yDniSDpx/cwSUbbgh2ilhPwNWWlTLv715sXIlE7+ZlzC+iXaD1FHykulinS6+rWN8kcmKlwRB32+PewPSXo/aLLS6iycoBdcSiTBLLlBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LfyOiMI2I3JkIwc7C3rJ44TJ/VESt6VYCgxI4Q+VJ8=;
 b=pS8rVJ7oUyx6F7eCQGJPwi0imD2MXjVMdl5i6gzxr/nUNRk7pwOSypUuPxOkeLhlWoRbaZ8HC0Ags9jzFyEE1eSfL4xc9MdvF2LedWnb3OTTRZHqQ+kmw6mT5dy5CrgovZ43Nzqyp6krrgH2nM+lC6ZC+67+xl/T0mvGV7jjBpU=
Received: from DS7PR05CA0097.namprd05.prod.outlook.com (2603:10b6:8:56::26) by
 BY5PR12MB3905.namprd12.prod.outlook.com (2603:10b6:a03:194::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 07:22:52 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::70) by DS7PR05CA0097.outlook.office365.com
 (2603:10b6:8:56::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.6 via Frontend
 Transport; Wed, 16 Feb 2022 07:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:22:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:22:50 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:22:50 -0600
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 16 Feb 2022 01:22:48 -0600
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Andrey.Grodzovsky@amd.com>,
 <Monk.Liu@amd.com>, <Emily.Deng@amd.com>, <Horace.Chen@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fill scheduler with device ptr
Date: Wed, 16 Feb 2022 15:22:23 +0800
Message-ID: <20220216072223.8394-2-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216072223.8394-1-Jiawei.Gu@amd.com>
References: <20220216072223.8394-1-Jiawei.Gu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d70b279c-e0d1-4002-dfd9-08d9f11d24dd
X-MS-TrafficTypeDiagnostic: BY5PR12MB3905:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39056AC3B5CAD2EF721FBDC5F8359@BY5PR12MB3905.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZYAnwwd1kuTdopF8s4w1srbLItBdUqMJIifzXhazMNXfw2slvc4+wBfAqgv9758Se2ra9qtKiZiboy1P3sam2S1esbykHVcP/RE6jhbTqunl+RasTDqQkbAIfP1SYv8krlnGytcnrpTMgz53a9c3m2BcIty/KqjYIee+O6GbrX8N+UaRyPCeXmkhosK57QD6bsnJf8R66jsSndcVjaWsROUr9xUUAytqbDho5/3zrK7d6VoS9gjHlgAwQ1mxE+6JPMAXU+IioUQ25k6W2hrNjDqPUBXbjcfk+9cgzMiFh7nBC4GE0oPpm6LC7P0M+R0oFKgcQnSevsNYcldci+RTU8Ql/3mIi0F6ZkKIjzaCoHXy7df/FcEiI3We+ETGoB7SBKup1+p57KRxCG/KpU2iQrmcm+QVibFGD57cfOKczfjv20Mr+opJAlT+H9ZUkIhoxNohlx8h7+sGrlop0pDoPznVfSFLOvYZQuBAGEfDkpEHZAHtlC/OsuIIGwl6fWwrbriTdj5Ohwiabp6h1ui8XWq2diOSn3yD+jhk/oMB7QCgClmc6xFehft6UI2yac4By/v3rHaacohV2L8ij399i/moKHmisLpWyVpwouEZbBtJg6VRn9oqaWm41XpxQFKVNbrnP+hvXVzVXaqI1R1Rl7MDrmv2DHG2RFQUvI+iVsAXehsT0SYt3wXVP8Ui2qLBs3PpcD/hdkjowyxNLPAjXIJ5poWpYoDY5oAPXwStps=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(186003)(336012)(426003)(26005)(1076003)(508600001)(2616005)(70206006)(356005)(7696005)(6666004)(5660300002)(110136005)(82310400004)(81166007)(40460700003)(4744005)(6636002)(36756003)(36860700001)(8936002)(316002)(47076005)(2906002)(86362001)(8676002)(83380400001)(4326008)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:22:52.3408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d70b279c-e0d1-4002-dfd9-08d9f11d24dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3905
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
Cc: Jiawei Gu <Jiawei.Gu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now scheduler contains device ptr. Add it so scheduler printing can be
more reader-friendly under multiple GPU scenario.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 4787cb3acaed..da53983c93f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -506,6 +506,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
 		break;
 	}
 
+	ring->sched.dev = adev->dev;
 	r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
 			   num_hw_submission, amdgpu_job_hang_limit,
 			   timeout, sched_score, ring->name);
-- 
2.17.1

