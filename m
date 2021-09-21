Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E35C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC3B61184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AC3B61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9213C6EACF;
	Tue, 21 Sep 2021 18:08:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0A56EAB5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpX5F3TJsFN+QtrXCoK1ofrdk4iT6cUt2mrZhsX9JvrXcTMBkzZyxRR74bv3gvaY9+1WL4V/7BSPyAw3fnFsilFiXzbrFx8DUkUimXE5lCrvNS5LnzYxwfOXaVxUhQdQXp8YtqY6RucWECVYTbmRRXW4VDRYFYW1EapIRIcbMaBMtDmeeaKYGnRrAXTqvdBv5fT71DaH06ShXlUu6ecuJojXclnJOX2z76Hzw7z9d0HkYWEQ94jF/tD6vlO01bIs/kGKsZMJm+blN0QLXa3F/KEcsC3nK+UhP2D3a8Hp6zvuhwrtL6xRWA/565ZEViTx+ayIMR6Rc2XIIOZjUuzMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=FLZDVVwgTXoRMw0Osu6LIhMZoNE2+EsmtNTRhIrWP1M=;
 b=ALJcXsFyb58YR9ptaRhg0qWUJ1KySzwmAaIWnvOzinbQLHAGee8/KhgS/YZ7ALND2EenZUP5NB+jDU9x0epzFXjOFKTOQhssNPLnMSv9OMXtaKoBvrzuvcEjikcXYxRh5rUOoKHsVNFXA8icSg0q2j3Ng26U1zlb0tx5qi5JwXuTWW1TK94oQW1A7nvCLzIekRy5v4/r1Dv+EAFh/h0dFqoycnNc9HYVsL0kZBSnOUIc2Yuua1nhpuAH/htvfGjlb5XotjV4ECiQRCdV8gxkOCXi8sotS4BJYrOA/ZSic5M4QhTXzxY+LEeSMhkj+16QTrUev9gQd00LPwtDZ9XLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLZDVVwgTXoRMw0Osu6LIhMZoNE2+EsmtNTRhIrWP1M=;
 b=RFb74ctpgL+r2Js/VnudzCVXfLzxNSL+N3prDEuU/q2zmBQqDWa9RhlvLs+pqMyldZkklT0LWVvuHsOew/GABo+MD/y0feFBCZOT0zFZiZ2DVt7n1nez44I98UYhcwvbQwlYeJ2ca43AJgoavgdo9uULNcb1TeXJ213oBJwJAIA=
Received: from DM3PR14CA0135.namprd14.prod.outlook.com (2603:10b6:0:53::19) by
 BYAPR12MB3191.namprd12.prod.outlook.com (2603:10b6:a03:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 18:08:10 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::34) by DM3PR14CA0135.outlook.office365.com
 (2603:10b6:0:53::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:08:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 64/66] drm/amdkfd: clean up parameters in kgd2kfd_probe
Date: Tue, 21 Sep 2021 14:07:23 -0400
Message-ID: <20210921180725.1985552-65-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c00e64f-a3ac-4e9a-502c-08d97d2ac552
X-MS-TrafficTypeDiagnostic: BYAPR12MB3191:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3191492D8121EBF58D1B5C87F7A19@BYAPR12MB3191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRA88N0PFKuOko6LVwqGxDvoYUYrKCUMrI22wNTN9TTnWqj+R+fSzyR96nj38g84sKlpRnUwHLVF/6DD14kU8ZThfvFx1JOFIK9Xjy6m7P1+C9+p0ffuNuzNR+v+LowlXsg+AgneIzjmPbbWH6ikW5x4a8K1aFhDn2Ik/q8+FVWRHkeQxWLGZ45XcCYqd9EB1otHCeWXCyLXx72OHpWo9CclkdOTlVsLywS2rTrPhsR7a/UDXfe3h+go5K19DjRJwhKQF0/9ofFnQ8AoL5NqkuDgEivzL+DZKGKmNMBajaTtBqFMVOQm7qZcMFkrXO2GaY/vQlfjsT3lKSfWYBcnI8CGICpDaDx6oW/s9FxGB6SDsnSqSa0l8CZ4tiwyc7NdSj89cuH+FhTbvJG5ADjkeWyZ1C5lNZViQYo7UWmehKBDGr4wYDRtg9o0VYwj6eeh3nmxa3hihnCFnpb5eFZSx7vYMp5a3fDsSs5LKBUtCB9rP7o4w0YVAXdBiexCJXyLnozGjwqCxXOywH5MRhNN9nOi1STsuXl2xQYCXp2QERqUIy6r7v9yLIbjsdSsVJW/PG06u5jiYi+1DTMI6rihKgyOfHAwQTbwYKxVdRyLBM5pB/eNtHf65xwn+62wn89CTNFf//5c/E33GXyqn6ezCi6CUX3v2+LLHVyuZ1ON0t/DBj8I0I6U+50fOja3hv8h0vR94vQwaZqmofog+AqnTgXd5pVxE/dfrssYVByLYk0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(8676002)(36756003)(1076003)(81166007)(356005)(16526019)(2906002)(6666004)(336012)(4326008)(70206006)(83380400001)(316002)(6916009)(82310400003)(426003)(5660300002)(36860700001)(47076005)(86362001)(26005)(7696005)(508600001)(2616005)(186003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:10.1440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c00e64f-a3ac-4e9a-502c-08d97d2ac552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3191
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

We can get the pdev and asic type from the adev.  No need
to pass them explicitly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 7 +++++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1d41c2c00623..ce60f42647bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -70,8 +70,7 @@ void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
 	if (!kfd_initialized)
 		return;
 
-	adev->kfd.dev = kgd2kfd_probe((struct kgd_dev *)adev,
-				      adev->pdev, adev->asic_type, vf);
+	adev->kfd.dev = kgd2kfd_probe((struct kgd_dev *)adev, vf);
 
 	if (adev->kfd.dev)
 		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 3bc52b2c604f..1f16bd772ca8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -321,8 +321,7 @@ int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 #if IS_ENABLED(CONFIG_HSA_AMD)
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
-struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
-			      unsigned int asic_type, bool vf);
+struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf);
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 98d1b3ab3a46..9269b5e3aed1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -32,6 +32,7 @@
 #include "amdgpu_amdkfd.h"
 #include "kfd_smi_events.h"
 #include "kfd_migrate.h"
+#include "amdgpu.h"
 
 #define MQD_SIZE_ALIGNED 768
 
@@ -691,12 +692,14 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
 static int kfd_resume(struct kfd_dev *kfd);
 
-struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
-	struct pci_dev *pdev, unsigned int asic_type, bool vf)
+struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
 {
 	struct kfd_dev *kfd;
 	const struct kfd_device_info *device_info;
 	const struct kfd2kgd_calls *f2g;
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+	unsigned int asic_type = adev->asic_type;
+	struct pci_dev *pdev = adev->pdev;
 
 	if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void *) * 2)
 		|| asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
-- 
2.31.1

