Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2131BC3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 10:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69C710E234;
	Mon,  8 Jan 2024 10:58:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DE710E250
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 10:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxjORYkUSxjtyxCzlux6vqSyelQg3U0yqVZyWCnvnNcC1cfRoJZcrW9++eZO59OyKu3UAKg2IEt6Z7AzdXXQaVfJ6FtXY0yyGNmwhL6rQCJjCKa7KS39YIsBy9yrr857LZ+LJ2W24YjkyZ/SkzlpSMpp2IK77761yLZc1MjELk6z305GqzePJjyTGP2go/b0HQjKlBjvhoiZN89PmWrUVfsqSyB4A/zetpK/HmcBQjoUydef5zJ1F5R4zh55sQq3NYCpdtHTUwXxC/gb553v6DJExlLsi2EDVCZVk+8nRKxDp0eE6Kpe2jtF1SiSAyBNCDFWBJt1g/+q4bkh75YQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hfnvQ3oCtqi32D83CEHUvmtzMStCSn6HsieUO6cuMk=;
 b=TueC1JEoLLiQqIMVNC5MmSgFrmaxh02oeiHbsTMP+lqudZRiMlmW23V+9yMfzCGokRfEW1XE24ATFB1yQ49y5YG++kWXSMTDkqqpXWg/wsmoUT4cjdwxspTTcyGcTPKLI00Ool4lnO4c/tuvZB1/Wg25R6S7El668rQAmM8N47BXjhX/fgu7LrE6NLO3B6tMRJJrC0JBcU/IpOdYNdL0nG2gR+MHALijTseVjIaatstgsVM0DFs0+mEEiHSWeuWCx7ISGkmnT4Qs1UmFS07c9sO2q7VpfNyNgRwnDuHS7o27zXG3LV2NGWsbPdv+63fsazV2Whx8nTA0hdtGdgjzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hfnvQ3oCtqi32D83CEHUvmtzMStCSn6HsieUO6cuMk=;
 b=RhAPgGBl0iBsCOCfjxcXJm3aDLoOf+nQwqNxeAYB1JAzmEIl+2RHpmOfg5HgiOADwdoFJdH8aqO6CmGDxlT5sb654JdoS1YekpJZS9JyX3ekwHVxADNxVIeK/r23x2Fh0RDoI8WE7qsnuNGBgnxsc1atQqwd8EJsM5AFtyMqEic=
Received: from SN6PR04CA0101.namprd04.prod.outlook.com (2603:10b6:805:f2::42)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 10:58:08 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::76) by SN6PR04CA0101.outlook.office365.com
 (2603:10b6:805:f2::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 10:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 10:58:07 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 04:58:05 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>,
 <hawking.zhang@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Update irq disable flow during unload"
Date: Mon, 8 Jan 2024 18:57:52 +0800
Message-ID: <20240108105752.482885-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 584db706-ced1-4670-be04-08dc1038b261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMyWQ6rbQNhB1gxRgqqS2NZuJvXGXPyKo08KpU0jB8cM0FzaY+2iT5MA2WxS8qKw0Kx8zWhU4u+pf9VYfj9OaQ+DT9vr/mJD/w+DZ5UO5CU8rsKQRwOoSOeJBhC59tENdSs2UiEv2ZtaQ0bdHElLgutOOa6TlmS+YKfxQLD93qLqRuyxJWYZPstTyNH/EiVeqkckCopTfP43TAdm6B+oYTzfJ/PqlD/g1/cweT/tVYxaFBM1o1ERxhOaSotam+AA/vLzjd87eaUUJ+2/jKFQeAZb44qN3Ei5zTnIJJlhL3CL36u0sR41HEM7Fo7P2SOcvG/Zi0CmvfcPZAR5tzU32H7ahAd0JPbjhVftkBYTlbs2HFGfTDRqZQbjAKBU9Pz8K8WTNJa082aRi55KSm2ltldph8hpHmeBs/gLq1cCMEFXeEkztywaMgfhH2T60KV50wUIYVK3hsUIs/yaTXHZn0oxfkUg1wNdV5vmWEkOHJh5RIGgoKomKRcreD9T2wMf/sn9HByppD/dhfpRU1UAm9UU4WDPCFaujCBrRxoG+Rue6O+BukCoQzLuQbvU4bo+phjAKRbAtF2FnwPLpGd0BzS1FPGaU2XjLcgzJdzSQ4CPqvh4fAkg0uB4LpCNBt1+Q5qY/3IbTEYnbj++yEMdgJL0XhsEi5Me9j+oqALNWRQ6crAXKr/GsVA3MWQZHERWbQyfd5nG52Rz2TDqForY1WkxzldWU4UmoQujuWsd5FL5lQOwBxUKT5UI7UZc4XLyowPEytnG6g2/tkrN+TGEFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(26005)(426003)(1076003)(2616005)(336012)(478600001)(6666004)(7696005)(16526019)(47076005)(36860700001)(83380400001)(2906002)(5660300002)(15650500001)(41300700001)(54906003)(6636002)(316002)(70206006)(110136005)(4326008)(8676002)(8936002)(44832011)(70586007)(82740400003)(36756003)(86362001)(356005)(81166007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 10:58:07.6105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 584db706-ced1-4670-be04-08dc1038b261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
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
Cc: le.ma@amd.com, asad.kamal@amd.com, shiwu.zhang@amd.com,
 ckoenig.leichtzumerken@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Re-evaluate the original workaround: commit f5c7e7797060 ("drm/amdgpu:
Adjust removal control flow for smu v13_0_2")

This reverts commit 2e8e792e6a51e8cb7f5f96148146b6525dbb9cef.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 ++----------
 drivers/gpu/drm/amd/amdgpu/soc15.c    | 13 ++-----------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c8a3ef71d6ad..f9039d64ff2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2361,7 +2361,6 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
 static int gmc_v9_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool irq_release = true;
 
 	gmc_v9_0_gart_disable(adev);
 
@@ -2379,16 +2378,9 @@ static int gmc_v9_0_hw_fini(void *handle)
 	if (adev->mmhub.funcs->update_power_gating)
 		adev->mmhub.funcs->update_power_gating(adev, false);
 
-	if (adev->shutdown)
-		irq_release = amdgpu_irq_enabled(adev, &adev->gmc.vm_fault, 0);
+	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
-	if (irq_release)
-		amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
-
-	if (adev->shutdown)
-		irq_release = amdgpu_irq_enabled(adev, &adev->gmc.ecc_irq, 0);
-
-	if (adev->gmc.ecc_irq.funcs && irq_release &&
+	if (adev->gmc.ecc_irq.funcs &&
 		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
 		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 7ee835049d57..15033efec2ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1266,7 +1266,6 @@ static int soc15_common_hw_init(void *handle)
 static int soc15_common_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool irq_release = true;
 
 	/* Disable the doorbell aperture and selfring doorbell aperture
 	 * separately in hw_fini because soc15_enable_doorbell_aperture
@@ -1281,18 +1280,10 @@ static int soc15_common_hw_fini(void *handle)
 
 	if (adev->nbio.ras_if &&
 	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
-		if (adev->shutdown)
-			irq_release = amdgpu_irq_enabled(adev, &adev->nbio.ras_controller_irq, 0);
-
-		if (adev->nbio.ras && irq_release &&
+		if (adev->nbio.ras &&
 		    adev->nbio.ras->init_ras_controller_interrupt)
 			amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq, 0);
-
-		if (adev->shutdown)
-			irq_release = amdgpu_irq_enabled(adev,
-					&adev->nbio.ras_err_event_athub_irq, 0);
-
-		if (adev->nbio.ras && irq_release &&
+		if (adev->nbio.ras &&
 		    adev->nbio.ras->init_ras_err_event_athub_interrupt)
 			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 	}
-- 
2.42.0

