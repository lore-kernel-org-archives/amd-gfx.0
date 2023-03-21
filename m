Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BACEC6FD1C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 02:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08D310E308;
	Tue, 21 Mar 2023 02:41:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F2610E0D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 02:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRBhpzFLHPmjmjJNurJ8YurP5uLydNMRTbYpTR9105Ct0GTMlwsW2wFeJdrukvllmKsMoQdC82Qw+35V+LHqd9j9INZpwKEHwbzf39EYgQZZfEW77Hi5sxvXBUASXcHG/4KEgawuEdsuIY53BoIwtW5fXbblRtt73Y4iIdN9sm+FelPQ4xkOJ+LzXqbBKwZ1gkr9VWNheb6L3p7qFmNz0RVAWnORNfsvH+pYMuBnGNsYRbo3aXijIoM+tEPG6ZbdsYwT/1JGB7+KrNVF+hg5MCJePz+Rw1CoRs4XOeUjrOsQFuKtR0kc3zKrm/kg114Ab05VA7UbLkTfYSFvai61Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZzxoiCYGGMhYb0uy8WKdeanmYBFSccun+f60VvGkNE=;
 b=O9PaA2oUHshio4tUD2lxj9CSR2WuutFl47acUeRk1aqocBR0e3jZ/U1KSHMa6409pKE68+MIIWE/xXb49aYhP+O3bTCUBqMCFzqUcGxvV94vU8irij+KUZ1ET1271BXA4qBmtw6hOn57/Zbz1B6Bwae0WTH+TgV9Ra979zwzRXu+2qOzM3gcbJoel8M5SZLKyoF1inF11gCTkwsdweLdgQIW4/0uMSNtaJMI3KrIGgbn+4JUK9sGBvL2q0lIx5m1XhTtH8LG+IvTCbHRqbcTCJpkMBGAixTyN36+Y+wE2kdQl9rjFdANq7tWaksQ8mLFxdtIhXAP9b3BYBe8UW13lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZzxoiCYGGMhYb0uy8WKdeanmYBFSccun+f60VvGkNE=;
 b=O9oZEh/hz1drL3H87l+Uacuyjq7yntzPqE5hRiV4/kEGXOSJ2X6hY1uYZcwqNUuF0AzLX+puc5vSoj3Dj/lD/Zg+WJjXrvMLgvVGxAdPPYffZzXDPMDoPRFgMQyjFcQhNIfMgurGkiNo91JsmlG+0XJlIRfPMG+mDZYj/Saf31w=
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 02:41:18 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::ea) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 02:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 02:41:18 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 21:41:16 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: resume ras for gfx v11_0_3 during reset on
 SRIOV
Date: Tue, 21 Mar 2023 10:40:20 +0800
Message-ID: <20230321024020.139199-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321024020.139199-1-YiPeng.Chai@amd.com>
References: <20230321024020.139199-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6de1ef-f7f1-41eb-9f95-08db29b5bfc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kb7YWzj6gM99Tl9/HsR+ho1S6e3fxmu2qFQVHh+UVtK42fweKRcU1YR2vgVVIACRUq3JVKhnFVlotrTcAIgo82UuHgS81DWQwYnvJFrun/EGIaPzjm6jiSwYXKvTfuXRF/u+sn9+eKFWdVoewpn5WOrhuMa+nMWfvSxIsBAVdkrKHepUicuXzhs6OvMDhP9gX1PrCfua3iTsm9qtEWsld4ol4X+q/8sAzfKKd4qVi+KRjMvGG1Lqhfn+ddjMMMZIeF319fA+3qWdYmxbSRm8p3r81KfVrU+rwUw35kH7fzxoZ5gB1NjHwPPw/jpso9BYD5Zh5IuJltQ1VHkauSNYp4oXxHhH+8MWj92XpBJu7msC0s8gyzLiTXhzEDOeY1CCAvMd52AmmdHK7KtZz+8La8NkDmK9edlCS2HJJ6ZNNVptKzUcwn2LtCfiyqAm3FychyDZnnweyE/GHqDZ6ZwgIZcRfQ+K3DWWOTUllI0xS6wxZIxU/COpqOiA5zJ7zwI1N4wrW5tmb9PJ38EM29MsKzOlEiBgqRWZZD+f/d3p5i+dzz3WNNlZhVQHGDPRMcnXQYdzOxTLmQLkVhCdDRh3Vl41CIr9+TaXqcxj7EwNC+quq9j3JzzX3pHvFSCbO0qnNCCDxgp2QATabUPhjohRkMFOAZM5qqWjd/Nv1SSy/R0hI0QGA7KToyUlT3IFBvz0jZ+/JRnU8Nq8BUFcv7vUR3JGXWB6WZ4dsL/vpa3fHc0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(36860700001)(41300700001)(82310400005)(86362001)(356005)(40480700001)(8936002)(36756003)(40460700003)(82740400003)(81166007)(2906002)(6666004)(4326008)(336012)(83380400001)(478600001)(426003)(7696005)(47076005)(2616005)(186003)(16526019)(26005)(1076003)(8676002)(54906003)(316002)(70586007)(70206006)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 02:41:18.5479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6de1ef-f7f1-41eb-9f95-08db29b5bfc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng
 Chai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Gfx v11_0_3 supports ras on SRIOV, so need to resume ras
during reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d74d05802566..14d756caf839 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5313,8 +5313,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (r)
 			adev->asic_reset_res = r;
 
-		/* Aldebaran supports ras in SRIOV, so need resume ras during reset */
-		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
+		/* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need resume ras during reset */
+		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2) ||
+		    adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 3))
 			amdgpu_ras_resume(adev);
 	} else {
 		r = amdgpu_do_asic_reset(device_list_handle, reset_context);
-- 
2.34.1

