Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0582EECAAD8
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 22:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C99910E584;
	Tue, 13 Sep 2022 22:16:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E1710E596
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 22:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBuI+W6hFkOj7L52yPyIt2V/H3jNU8kDEZ+CZDXRE0V5VFSvTVdIZ1+Ivk2/yDMUFKBXLsKRAewrteVjogOn6SdlZjk3m1JpR7bWGzpPekFYcpE5rEriVDDRhGaah49/AciknbsAT0q9YytCYPWBat4oKRXvykH6+i8NxIbX4YJuITwWH0cDUgjSByNo94yo0dT29CxNoZ4UnaWdH0SvvUzB+6IcH6HCC7bA+ZO9TNEGf9gXAxj4IIrJBbDOzlOZjnxIHwn6+WN3tH/Aml5UcRYzpx4i5B5qSsq03sK0GmRZFcxX5SfT9xT8WX69V6b1+32ELXhxKwHMiifM9aWw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBpoOS9Ol/0QE7sEVHKjNNAHov1p1PsDEWuKaClLOww=;
 b=lWcOgjoehJSJgayfeXRRMNSwR3hOzrDUHd0nLIzc/fn6F04EF1eLcV7xQgnCM0fhBw+fcAogkA9vXc9itDlbFeZ7iadMN3GlTGxnmeftHP2KS9h0WqooapmrobSzHnW1rR6It4Pqvcna0EOiRTHDjdvIVoBPVjRDu2bGWOzofdDV51hvusfyl1a5gAVC+QhRjBERHdPU3EFegO4kCHPLOSLf3+wxXoCOt2VbtZJ7K+5XMVpxYR/D5RNbW3Vq95Oq3RonrwQHSHjsztbPEcn+vIAS8GvJiqmUv1CiAwN3sqh19bfMQwgbEnm9Rs7x4eeDvdcoif0LViVQkoO2tthSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBpoOS9Ol/0QE7sEVHKjNNAHov1p1PsDEWuKaClLOww=;
 b=XPSS0xg5qd1TNVjWzeGvxZp44QZbNu8Gbu0l4KNXJBFqEABWKasXhtRkVnvMp14zuJPMeG8DPuuHSFu0cd87p5dxmVhvJf9u9YnNvyvKttXO8y7dPf2ESm9M+1jM5zXnbieHFOOCCuFDvKaPRjobyoYSaq+89AqcX2v4pUsyLwk=
Received: from BYAPR07CA0083.namprd07.prod.outlook.com (2603:10b6:a03:12b::24)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 13 Sep
 2022 22:16:24 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::cf) by BYAPR07CA0083.outlook.office365.com
 (2603:10b6:a03:12b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Tue, 13 Sep 2022 22:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Tue, 13 Sep 2022 22:16:23 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 17:16:22 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Update PTE flags with TF enabled
Date: Tue, 13 Sep 2022 18:16:02 -0400
Message-ID: <20220913221602.1308205-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c88ed1-25d1-404e-0327-08da95d59813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iB2FgMwhDLcqaZ5LYm8wJbxbvAICm+EsEN+zS5hG3DD6x6RrMR2z0SjpySyqk2NyLD6tJmfs+D8V70ptbBr5fCN7Y5Ki5G2zSJglxkrDie8p9I2l5uF6KvEziAnkTibip8YjmPsvcdiW9999G3CCzQ1DI4iCuL+ZjX4RMJbYnOi5gPK/xe7M7NcrZvtD0+f7rS6NJ1fIjSR58NYNz4lvjsiQ+AajupmVIIkxyoSz+/M6WPATvU4BGb2uHbCHWxpihZNur3DOk+SeLujZmkSYW6HdftPXaYkg4M1KSecttwJyKeIUMc5ISX7Mb0j8M7GiJJxbhCONJqTLoKaL2NqV/sZzZ+0h+5BhSNhTEAZiZZDSaJysFT6P5Yx7gtYSz4i8kfELfIm/+ok7y/H2cEkg2j75KQvnsrANAphNP0iOvgJ63fmhn03wQrBTdDtUGdeVKxDHlU7QzIezLYxvbG/074c+wuup37x6/f1pYe0zKNixMKkDfVRUY8kL+2Asyf39Mo1vdaPEe+gXV1/pPQ40WLjX3T1GyszJzCNcOFQV/j24+JqcVR3spiR8/nj2wSnMr9IBWHQ77aMoGGphr6rT3vsp0q4w6BnlGjde2M0QMP9p8wsiyL86ZY82t5ls5XA2HDJ2gns77Ti1zJsvwicwFH0ZEOpo6bwXQ68IZvlSFuZoS8XkvGMsG/9sSTPAOjMOPQYwvNde0hCyiz9u03K6aggpKsNRGZM+x4XwlFpRvswmuTHHGTYvbcrLMFTZ5HazlTxoA9iq0YrBPFhjEoO5HeqWgUjxbspxtsQJPVuiriM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(54906003)(316002)(6916009)(478600001)(4326008)(7696005)(426003)(2616005)(40460700003)(41300700001)(70206006)(8936002)(5660300002)(186003)(1076003)(81166007)(6666004)(47076005)(2906002)(336012)(82310400005)(26005)(36756003)(15650500001)(16526019)(8676002)(36860700001)(70586007)(83380400001)(44832011)(356005)(82740400003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 22:16:23.6426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c88ed1-25d1-404e-0327-08da95d59813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com, joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch updates the PTE flags when translate further (TF) is
enabled:
- With translate_further enabled, invalid PTEs can be 0. Reading
  consecutive invalid PTEs as 0 is considered a fault. To prevent
  this, ensure invalid PTEs have at least 1 bit set.
- The current invalid PTE flags settings to translate a retry fault
  into a no-retry fault, doesn't work with TF enabled. As a result,
  update invalid PTE flags settings which works for both TF enabled
  and disabled case.

Fixes: 2abf2573b1c69 ("drm/amdgpu: Enable translate_further to extend UTCL2 reach")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 7 +++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 59cac347baa3..690fd4f639f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2484,8 +2484,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		/* Intentionally setting invalid PTE flag
 		 * combination to force a no-retry-fault
 		 */
-		flags = AMDGPU_PTE_EXECUTABLE | AMDGPU_PDE_PTE |
-			AMDGPU_PTE_TF;
+		flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
 		value = 0;
 	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
 		/* Redirect the access to the dummy page */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4603653916f5..67ca16a8027c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1103,10 +1103,13 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 			*flags |= AMDGPU_PDE_BFS(0x9);
 
 	} else if (level == AMDGPU_VM_PDB0) {
-		if (*flags & AMDGPU_PDE_PTE)
+		if (*flags & AMDGPU_PDE_PTE) {
 			*flags &= ~AMDGPU_PDE_PTE;
-		else
+			if (!(*flags & AMDGPU_PTE_VALID))
+				*addr |= 1 << PAGE_SHIFT;
+		} else {
 			*flags |= AMDGPU_PTE_TF;
+		}
 	}
 }
 
-- 
2.35.1

