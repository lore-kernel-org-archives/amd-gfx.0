Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8C5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 08:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F153A60184
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 08:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F153A60184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8184D6E982;
	Thu, 18 Nov 2021 08:27:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DF46E981
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 08:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PA9rUp+f9IoZvoC+m5R6atECf59PDVaMyweC99+z31xOgy083E8q5TJ7PZRJG5KwT2PyQh81mq3cYVz2Mf6O+CSbs2Q8W6N4zlUgIUVGOi7i8pB2OARbR/WlU5bOFHYSZDCgHfL4uXIoVqHpky0M5jlGP1efgLLyNG6RkHf2vPc3kPRgV6Wg26iNgv39gwA+Cl4CKQZhN+UUobDJy4rB+Ff4KAxw8u3ZxpVTbSeStDBogsaAZgO5URMOzoYWHxIJttDe7NbVyN9xl661th+MCQEYdqNiizRKF7a9la0TR70RyrEYJAxJEV8T9xzLO3JL+Hzk0djhuYklb9vcv4KRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzemruTM1qiirChen7gFygKDbzXlnGHp1jRgyeK10/o=;
 b=YOwnPyjBb73PeFAj2FMx9PiHaDHMQk6VvRvn5iiWR4TyLIpXfiycz5swVPevVgo7xJqTtnQxM3CRWmlVfpQwmpUpzF+rh9HEgi2tP6F8V7QgNJ5xHeho0NZZI7qUJoeL9YTka6fSxpVQ7pSmCHtMGaRp3y+NQnWoZsAa9bdOZAFtZR+Ljbjck50gbPpt94WAawfQijXoz9VI1lpB9v9BR2MKocivG6wFvHZqAUXfrQt8DPywPgMh8XNz4rUuRL0BeypzLA/BwyETZJzbkkJ8FGxyNRkbblgJBkycG5szZF9J9FnwLVLkXrZl4BSz18NrfyDf9X1wHwm1BochuhOXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzemruTM1qiirChen7gFygKDbzXlnGHp1jRgyeK10/o=;
 b=gblaGxINBvwWgFw5EUOh70HwBaTib7q98OMVVizcLWaaZjeNvD8BmZXlXis84YZtrtbDq5RQAUFvplmurBvtFMWbiwlOM7YS8XUalDIcwdh+++kxcOxwJk8CTre9twhfpgoL0SjviAK9prT5U3J2B8rc4CfrjrgU8yR2YMakDIs=
Received: from MW3PR06CA0011.namprd06.prod.outlook.com (2603:10b6:303:2a::16)
 by BN6PR12MB1698.namprd12.prod.outlook.com (2603:10b6:404:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 08:27:44 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::34) by MW3PR06CA0011.outlook.office365.com
 (2603:10b6:303:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 08:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 08:27:43 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 02:27:41 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update the domain flags for dumb buffer creation
Date: Thu, 18 Nov 2021 16:27:13 +0800
Message-ID: <20211118082713.2326928-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60cd13c7-2ab1-4506-e242-08d9aa6d4b51
X-MS-TrafficTypeDiagnostic: BN6PR12MB1698:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1698E444F2E97198517A0CE8E49B9@BN6PR12MB1698.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ox9WRG4BIA/7q6DJuNt2phIeVX08mM9cj8i3m5y5bn1gad0qcTsx9jojXYWPTXOXC+dyoAKPh1s01cOD8lgHbR8DLxTSDxu4fhL5Pc6DS8KhFDWFisXtC9zfLUxFt7/HwF7+uqwnTi+P9oI9I58C0vVjhqqJO+8yn7IaYQSN9CmLJvE07FiU84rKqedsCD0N7sqGrGJEe4Qm4gvudcTXSJiwCJESfDixLoSERZF09d3dePLj3s5j8+jkTQUIkuX2Yrk3sA/q/o7hdvKdbmyMeS7OSJ6BCMSOIEItjlGoNIsRIp9VIuvSsPeA2r6YLteoJqXdxyl0oEIZI3FxJziHvNyRKwLMUWFXDTgPOq9YgkrgrRc9uqUQ37NBCIDaRx7nqsJAHXYLDBVXRiIzBXSLVaXuk1cVQjPh7q2p3VdvxFNbXXPNTGd+wr5vra8i2U5dkWUoDCLrPUs++yLgA2Dy2O1uPOICV/WSWZ2UmytCzo3LwjmeK1h+BgR0Rs0ctsfAGjcaCMGjIpNr3VHwQAIV+PwFYmMj8ogGJg5N+6tcoKBu/wic4Tm/izujJXQhNYiqdtAb8fMNRVb7SnuVtSR+nIt1XQkuDjZFQEtus+Be7vWuxzFLhgw79pv7lCBqQp/YdMKbgXsIL/cgZ2uQ/in15wxWjSHLa/NHt8TFo35LdF/fiHbMnv1tuyjVlTspYwFZhOf83FLOG1GCevgTmW8m4UKmprOAvSzQGovRjYGasXE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(2906002)(70206006)(16526019)(26005)(186003)(83380400001)(8676002)(2616005)(1076003)(82310400003)(7696005)(336012)(426003)(4326008)(44832011)(316002)(508600001)(6916009)(8936002)(47076005)(66574015)(5660300002)(36756003)(81166007)(6666004)(36860700001)(54906003)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 08:27:43.9841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cd13c7-2ab1-4506-e242-08d9aa6d4b51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1698
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After switching to generic framebuffer framework, we rely on the
->dumb_create routine for frame buffer creation. However, the
different domain flags used are not optimal. Add the contiguous
flag to directly allocate the scanout BO as one linear buffer.

Fixes: 844612e1149d ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Change-Id: I403bf7a0b265c564b5f3a3343999670e5eb87ca6
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d07b6aebc449..189e32ee7a6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -883,7 +883,8 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 	struct drm_gem_object *gobj;
 	uint32_t handle;
 	u64 flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-		    AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+		    AMDGPU_GEM_CREATE_CPU_GTT_USWC |
+		    AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	u32 domain;
 	int r;
 
-- 
2.29.0

