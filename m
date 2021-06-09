Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DFCC47095
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 09:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1636124B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 09:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1636124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD4689FC8;
	Wed,  9 Jun 2021 09:23:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF4589FC8
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 09:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgUhBS2yp/LCem+QOsp3Rt1Mek7WTeOOe0XEaHR7yLYY9nR26xj21qGRRNiaa31sTefBpB/1dkjPR8NH5AR19vrGVyt7XjUZhkjUzdApDa3Blxb+pVtEYv+pIDlJAAp+fQP9DhlAGWoIS/7AzBhg7TArWIeKS1EpHnLJ2Mi0yJODn3/6PAwBl18HzcJi9fm58OAlT9sy8SjHC2kuuw0zRbFZoVRKO5djoLOiuI4ZKJejgOj53ARFcDBG6cbywADVqHDePFSmdtc8RwBsOxF+5p5+QduSeYA8dUOKih4OrfbIlRGyIKtjr77EEhXjXN5noI2sZBermLzb/btoJFwCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wPkpUTZ0D5JEhbQo9ZDOFUQFL+RNaHfyS2j4TwZ7DA=;
 b=l2JoxqBmp7XFL/YiWQs4fSGjbQMNdm5bAIxT6aPmIOgqnstvYS6dSB4Qcyjr8OVPq4ygAWUeTJL8Q3wXmSuXcdJwtLmdOepnLj6PrYOhtyfiij7VvU6Vvmxvst9jZU9vPsXjLCs36n1/OcaWpjNEtDzI1OaqcJRkwFlWl0RxZbFDsAlp8ESDwKTJjQMWh+DPvgu5TkCE9DdmdGN9sGmfuRc2/JmiJ5ygiU5W6MbXECFjj0/AysQUit8oEZeB6DPg5A+W4RnSXDE0hBr6JTerz+QFJBVaiCHbqu4JJcW7WY+z61ZjOowmotipvmueF8w9g3vEXwTDf4kZlyaY59lcTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wPkpUTZ0D5JEhbQo9ZDOFUQFL+RNaHfyS2j4TwZ7DA=;
 b=FWOPA6jHa87fX+BTxNnBWrNvUx7LX8OfBwI/CHvpZW9Z050qIbyNqcOhn4ZYu7NQnu7A8tUeBuT43A6fKmqJiNxMQmivcFohs/tfpY+X+mO+ezjj/uUVk4sIarVGRN9s+LaVVIP27F0I6OiA8KgvRWggst8gbXZbMsQsDN9ep4g=
Received: from MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) by BY5PR12MB3731.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Wed, 9 Jun
 2021 09:23:43 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::66) by MWHPR1701CA0008.outlook.office365.com
 (2603:10b6:301:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 09:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Wed, 9 Jun 2021 09:23:42 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 9 Jun 2021 04:23:40 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <luben.tuikov@amd.com>,
 <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device
Date: Wed, 9 Jun 2021 17:23:23 +0800
Message-ID: <20210609092323.32650-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f1037f2-4486-4aaa-4639-08d92b28465f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3731:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37312A2D05DA09D0A34734CCF1369@BY5PR12MB3731.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E60krV2s5GdsXbjyp955Zdax59EmzMZjFknlNyNUtXIVpvVAZCyFEacA3NcwJljQEoGCId6NKlaGa3GkBLfMD4uQoV6ukktyE1LW4ouk/3DifGt9OATJVo2dCBQOSaiEx94tbncLrGkI+92RDr96yoTTDL+dm6tKnWa3kKkIsezc7LW/iXoYFyFtyyYTnOvcfF4wNqrHdseh10ysaq+Kxx2GQ3sYgHAtkpMikSa5OWwV/WgB2Zp2JRdqjYwnoT8gVsaO3iuhWTnb7TowEOr1mRJ4Iw4njMIaSv1nctBnmTuF2N0l0dZ6qo9vPSO15AydTLCEOQsZEFANysGyydLD7KHH6PKGNN1kbmfcUZZsyH/z7XAiVfBqrbbivH/rRs5e/N3KLLKO8cf8kdgHaeGZcIeZ2UOZWUr2OGGCtwafeLMKYfDU1Xxm85Ltz/aaZs7IUDnxNC9rd8D5DOIomEiSi3HzQ4d1FSUThKSo+DQuXXp8uXYRIgAFGwPfCNFL7qNI1LQdhhnOycBVyMYocTwKGnEHL9baiDAE0HHFoujSynbxFe8Fi3PwwcoPwXPNjQC/bDK2vcgI+DBY0/RkKT96vKx6+0hxGy4I5Lld1pilcxJaV7JoWEQK81IN5iAn4jiwfNgMXYwMHhu9gus50rxAGLU0XOhM3biKia8r83I1ydCeL61p85A6NEdgyMCu1w5R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(356005)(110136005)(81166007)(186003)(83380400001)(2906002)(36860700001)(6636002)(36756003)(316002)(478600001)(426003)(4326008)(16526019)(86362001)(8936002)(336012)(70206006)(1076003)(70586007)(47076005)(7696005)(82310400003)(44832011)(2616005)(8676002)(82740400003)(26005)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 09:23:42.7344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1037f2-4486-4aaa-4639-08d92b28465f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3731
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes:
9faf262c32d3 drm/amdgpu: Add DMA mapping of GTT BOs
090f3a60d7e8 drm/amdgpu: Use delayed work to collect RAS error counters

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 016815b7a773..fb6bcc386de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -639,7 +639,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
 		}
 	}
 
-	gobj = amdgpu_gem_prime_import(&adev->ddev, mem->dmabuf);
+	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
 	if (IS_ERR(gobj))
 		return PTR_ERR(gobj);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ec936cde2726..bfbcb9ff2453 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2122,7 +2122,7 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
 	struct amdgpu_ras *con = container_of(work, struct amdgpu_ras,
 					      ras_counte_delay_work.work);
 	struct amdgpu_device *adev = con->adev;
-	struct drm_device *dev = &adev->ddev;
+	struct drm_device *dev = adev_to_drm(adev->ddev);
 	unsigned long ce_count, ue_count;
 	int res;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
