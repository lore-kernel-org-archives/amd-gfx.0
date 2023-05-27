Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C34C77B7E
	for <amd-gfx@archiver.kernel.org>; Sat, 27 May 2023 17:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934A310E179;
	Sat, 27 May 2023 17:00:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24F610E179
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 May 2023 17:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAQcJ0kKSklY0Q3JJKeGpf2457bqn+Z139jN6eJaNzByArwOb3ED7Cj8JkzBfRp6Nzm/X1kjHAKOwvUr+pPPAOheVvQFMUdj7l/Hs+q1aaNJfWgzrzZA2z1OXhoYlSJdSO3LxvQpbmKGS4dRacKBSviuznUOqqRU18tkliLAdRVzQ458kqh6NVGZkOaZZ502L3NQsOTFCmQ5vsi84v3WFj0hk7nPGn2Ojq8Jxlkj3JU3r28tzwOLImbOapNZQY7g7xvJdzFoA/7PkXrRmCuTnNxQCNVJQSXVtJWiZaJoA0zbbid0XrCLMfLscPs2PlTZ8kUQ/v7XC6pEAkxnDPoSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wznZ98CXtu60Q5L/GWx/cajTfUb0enUHeOf4FhAeqcA=;
 b=DkaomoyaZm3Cj2kcKfOac5mHIDFf/419lNyE51BfuG5Gm5oyxLgZGV8Tf5g37Mky2obRy5IVgJyixo9hPTfvf78MSVkbzsbHQYtqGpAuWtAaKB2C6dEP5zNGTozjZCfbgalkXLORjDV02FJR3fEIsp5wDSXiY3XW1Ys2jjMth3PBE8D0ElDFIzbuPZ5JEf9o1E0ZuyO8CaKT+kAwQq9H0CPdYQkZ3jY55dxrgoEH+x8tz0nNBmSieDd0ZF4ZMKsm8a8+EEujHCDj/tpFq+5ZBbv6t5xidviACNgg5iqs7WKJJCupr7tjsYxEmuTYLJB2aIF7x2ohBBxYIlNazOwkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wznZ98CXtu60Q5L/GWx/cajTfUb0enUHeOf4FhAeqcA=;
 b=NIN8zwm/q6CY+/XplA3SxjocF4KwDIktgomkkZXq2lNutgl98SUTFebGF5ljvUihLmTsORG2ctlk/mZkT4AxAJm1oKLLuaSJtoR+J+Lt+qsDkPHr9J7/b5xstbg6HHkKQKB0UIaqV3GgYFc+MHF/K7BJmB9jVFaKW4Wn0l2ju78=
Received: from MW4PR03CA0048.namprd03.prod.outlook.com (2603:10b6:303:8e::23)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Sat, 27 May
 2023 17:00:05 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::c6) by MW4PR03CA0048.outlook.office365.com
 (2603:10b6:303:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21 via Frontend
 Transport; Sat, 27 May 2023 17:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.19 via Frontend Transport; Sat, 27 May 2023 17:00:04 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 27 May
 2023 12:00:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix create_dmamap_sg_bo kdoc warnings
Date: Sat, 27 May 2023 22:29:46 +0530
Message-ID: <20230527165946.1536728-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: c0503632-d49f-4b10-bf40-08db5ed3d168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPknxiZtxaXny1Av5OEQkvnfhrG9qEbMFGgoXRDnJyfkaTnm1cThh3CZIBqZ3pGajG/JLHGOn41E5qfLWVS1gFB/BBoj+2XHJ7WPVFG1UCbqq0SvZSuqP1lIKhIXV1NfZo+ZseqlyzpnFinEBu7AJhCOZIxZfvRJq7hzrU7/jTd6swOpBGzHsS7a+q1hKFRg3yBSB7vh4s26sqk6I5VQ2k+ukb5ZlboXDmsMJRXRLcqZhWbTqBdrhlB/hBqWlNZHLI4OO8MliKdnp1dfKXrz3KZfn6pqU0SihyQ+UDQsR2SA21QFfOQNSTPozGd/4sMYR3leZJUcb1yo7tAaXuUuZeiTQh0svueA5k1qOYShVXHSO8MDDesFybdorN3h8EgmFzvqT4FtQrQNXIjDLApP9em13I5Fq1GQ3i9qC2pUBE5TZK+xVRseN9/t7MJtGF/7LnrijZ9hpZyFU6ODQHlLMJqRRMWHiIwySTNb4agKosDxfpU1bIzUtP6cTa3lZqgKTN5ZvmYJu/Nog2uVuOSeI7KneYHKHS3YHAcN3ir0e3re/vtXpt+piEZKEjRO6/ff9zz5btxvgvPf5lUARev7GkgCVs1+5lAgqinFAXNE6xkknK5cF6W04VO7qMvvKFjULNPoZKkI179wqtfXFyf6/OxzOnaPtJmUVlhhieuH0/nY4n8n6FTg8xFxZdf3Ux9J/I3fkamZA1/dgVs0iWcYI+LnaZ4RKIxgRfVp5YSrRo/kNWEMadq7j4i5UhaMPAu6Nhefo6yvSvjUfBcs4+9vRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(2616005)(66574015)(47076005)(426003)(336012)(40460700003)(83380400001)(2906002)(4744005)(186003)(16526019)(40480700001)(36756003)(82740400003)(356005)(81166007)(36860700001)(8936002)(8676002)(70586007)(86362001)(70206006)(5660300002)(478600001)(7696005)(41300700001)(6636002)(4326008)(316002)(6666004)(26005)(82310400005)(1076003)(54906003)(110136005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 17:00:04.6064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0503632-d49f-4b10-bf40-08db5ed3d168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:292: warning: Cannot understand  * @create_dmamap_sg_bo: Creates a amdgpu_bo object to reflect information

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index fa4057da0d7f..4540d0964801 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -288,7 +288,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	kfree(bo->kfd_bo);
 }
 
-/**
+/*
  * @create_dmamap_sg_bo: Creates a amdgpu_bo object to reflect information
  * about USERPTR or DOOREBELL or MMIO BO.
  * @adev: Device for which dmamap BO is being created
-- 
2.25.1

