Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E848C53210
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 22:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B649910E0D7;
	Wed,  4 Jan 2023 22:20:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0CEB10E0D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 22:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkQMPqpG5cCb0wLJvo3ldA3cqXsguOVxVXtxQC1cbywsOOx8i7lJWBp7F1AUZuwNO/fLJHHErNNH7MkrzTBuj2aeQaK5eVTQM5WWZXrN0T/ebHgCZooza+u7/xO6akmla14YyGkq/2zst5KuKzbmALhqeenRGncL3n/TB/vozRu6I7zTDVn2VkQk0rw1BqNtcPsLI6TyPrshkRhPRbMFtpNQTqVHWspBbk7ur1monAxnW4KLjQD7Nkw6LTklidDOV7Ej1hxtb1mdGPZpuYximRNk+u+lbF1Yip6GSTAjzWvMupvSctk379bOyEscLMM3FgAMnS+xO3mpDM2I7iW4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp2Kcy+e3eivyFZsArJVFhbnO2rJ2TBar4u+9/I5o1s=;
 b=WFVGo6CTrTV7Wm+dGORm4DR/hh1Jz7ft1foIxR/CJPfZY5ifA+FDruH/3eeEzQtMSm/fWa5CJ71Noe5KLskJEHnqJpgpysUUJsPysT2D7/2uCUqiLLh3vEGM34u/yOoVmZVqzlRXXvAfBCeggHnuhvCoGYolIj5chhr6BwpZK2tjxEZt846XnFXjoERwVXDSC1FAZfBxwsr7tdIaSWfXSPcIlNJHzXoUMfqSqNLBhNZuRCiE1jF8IxcN4YSwg7XYPJsSLKGkm2ruBaBXJ52hMahex4xi2/3URhbLJf83W5AEw+Aq5jWPuDM0qFUsnNW6+WQkYwh3lVaEohBkiXmXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp2Kcy+e3eivyFZsArJVFhbnO2rJ2TBar4u+9/I5o1s=;
 b=tIuvNyXs+7csYIrI6eA/1bIsaIQEOcCRZu9q/TWpimJAlB1CAzspf5Uq+LYNFzHn9lfd6RBXEP8/eMde26kovSimivMGSH3eMd2GtMW1rhkib7saAj+hWwvy2raqeePFJQBRLq4VfBBPAIDlPvA5lE7HGl6rLi2PQTWI6vpaBCI=
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 22:20:01 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::5e) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 22:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.17 via Frontend Transport; Wed, 4 Jan 2023 22:20:00 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 16:19:59 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix potential NULL dereference
Date: Wed, 4 Jan 2023 17:19:35 -0500
Message-ID: <20230104221935.113400-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <202212300020.CFmsapaG-lkp@intel.com>
References: <202212300020.CFmsapaG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b65295-b202-4747-7430-08daeea1d21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSIGvkAlzjG0qV2oxO11KWcYq4XwKPFz2lLn1XjT0Q8TrLbhN6MU6XStZr2yVLIho+4snPZVkOq/W/e1vzP2G+Q++clknRUqLECHYA87hhTudBkSgMr2E1KdmD3WQBFIxXW4pHhQZJe1j5+5gtIwda6OI5lCgwbfAOChtI+G39JAUF34Nfc/JsX5DeqGkcyj1m815guzmsKpK/KJr6F6n5Qjttf+v1dk+FOSRUdKFYmklEf2GfKVAfLOS7ALBA8spfKEa6wn81fUAXhJDIiTZuETJZcynCBzS8vHxfGaJQEzpaHbHX3LFyhcz5Vv9QdBaJk/AO9P40kG+r6oDOGW2Kj5bEsrx3eqbjwpEyxsvnALGgNhIY0+qv4cDNx+3txQr4ejq75UgcSNLIeNNtLl3JGenoetph+UCYcAExZev3D9WgADZxlHxQ+jJIz/t9z+EY6YroLTZ8QRL+kjBVcU83jfRtc+JM8kDe/0qrlum+BdyYXg+X2WnWa1TJ7sRsFS6ulEQbMVW8oH/T+N2bKzguB2gVa4mceAKoSUaZ1QLtGsVUL+5c/IDx2+1379Vjjw4fD4sZ6fliIxyhA8mF2qzMRy+9pDcLSXR0q4x4/DGpROW5ICRr5HwyGtgC7FZu6mcfnNaR2NXhms2nPNjRoR9KhmxqSc/wtx+V+qAB/qD5vHp57LcCsBJANhEvz6nxgAcTTeZKI9wqEhFjAEnK0FI1MzjZuSudK2RRouk0TTNaQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(70586007)(2906002)(44832011)(8936002)(4326008)(41300700001)(8676002)(70206006)(316002)(6916009)(54906003)(478600001)(2616005)(336012)(186003)(26005)(82310400005)(6666004)(40480700001)(7696005)(16526019)(83380400001)(1076003)(426003)(66574015)(47076005)(82740400003)(356005)(81166007)(86362001)(40460700003)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 22:20:00.7921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b65295-b202-4747-7430-08daeea1d21e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, kernel test
 robot <lkp@intel.com>, Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dan Carpenter <error27@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix potential NULL dereference, in the case when "man", the resource manager
might be NULL, when/if we print debug information.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
Cc: Dan Carpenter <error27@gmail.com>
Cc: kernel test robot <lkp@intel.com>
Fixes: 7554886daa31ea ("drm/amdgpu: Fix size validation for non-exclusive domains (v4)")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index af716afad9a59a..d1c90015651ba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -470,8 +470,9 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 	return true;
 
 fail:
-	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
-		  man->size);
+	if (man)
+		DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
+			  man->size);
 	return false;
 }
 

base-commit: b45d1c2754f5080acf2096ffcb17bcfeee7f5c2f
-- 
2.39.0

