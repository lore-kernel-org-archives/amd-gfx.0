Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A04C7EE25
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 05:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0640110E2DB;
	Tue, 16 May 2023 05:04:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051B010E2D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 05:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK6phkdb00zDVJb/wqScCD5EuwNk/I35Lhd1rgUvhfjGkeUNEocxHPE/C0+2f+KZg3bomDywlDeNv9OUkxjHjcOo6ZPlXh2wp42byg7n5JUVKnY6RzFg/DaIaxR+yRKkmMT3tnIyGMJE95qSt4V3r1ThJ6mH6QLiJaY+vQp41llbHUxTpqzov2Ka/VyKOJKCh3Ae1ICTizI21aTHOIPYyMq+WEYT6oOlgmjtxuRicxq5BMIw6AazGLs88VB68kLvztvwxdewBUS8lZLlCCf0uahAoTzU5aWYCbKazy3tx5aDAiBRCgMsONwDv2Z1x0qgupHcOOQt+aelmIpOSoPO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XF4ClDaPGrj7Qn5kQffFt8P6pFX7EBIUo4m2fkY8Ruk=;
 b=WEFhIwC3pQT78HD3w+iO42ZisL4lw3NP5TQhwwNeb/FrEXsAE299CXm/ZzMIS97s1XSHQQF6+4HHEPelLNZAkfBolSawYSyhTMgeFMlb1MJZS+RBD2i4Hy0RHIU0NFcnxGNOFlqcc7g7A5Y3ImQ6JOYfxYLUJqDfykxoACCVNmjuRMPPVxH5MYjAxHRtlYHuDqXHqfZFTKpPGgHQ9SN1CrzY1cPWyHyBVmqgEbfWQIrp216lPtJfiLdjjo/H0XHF76eYYiUVuoqKn2eRM/JF/HBLdOaO0WEpHUJyL0Ng5kDGNSNsjkkrpL7+SwQt/rnZQm+cgiZ2H9V3J6AGneKrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XF4ClDaPGrj7Qn5kQffFt8P6pFX7EBIUo4m2fkY8Ruk=;
 b=cxGac940xMsODjTUoBWaNLEcy2wtsEyFI/QGBr/KX0tjfRcOcF3Jj4zT65wfvjHBj2OUjw/Wz4RQRohNQJCj4kOahX/L8m7iIrenqgcYTPPQ3v4+X5BP9PVrVj9zYZlNyoOTvNMHv2f+IyzXpw0tHVBx9q3mFpnKQlM+NC0YdXI=
Received: from SJ0PR13CA0138.namprd13.prod.outlook.com (2603:10b6:a03:2c6::23)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 05:04:38 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c6:cafe::d3) by SJ0PR13CA0138.outlook.office365.com
 (2603:10b6:a03:2c6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.14 via Frontend
 Transport; Tue, 16 May 2023 05:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 05:04:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 00:04:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 22:04:34 -0700
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Tue, 16 May 2023 00:04:32 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 6/6] drm/amdgpu: add RAS POISON interrupt funcs for
 jpeg_v4_0
Date: Tue, 16 May 2023 01:03:58 -0400
Message-ID: <20230516050358.13095-6-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
References: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|DS0PR12MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d32fa79-2252-472c-3900-08db55cb0c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXIponrS+tWgjLfYmSvuXHdH5HBenGY1nK2gmhFcv9mJrfRSqW6WtQiVY0HbjGqOzsAgK2tqWv1BwPm4Py9go4CzjPJVo1aiWEVxh10a6KrYdy3mGkhBXQrakOMVi266yEKu6mLcaO1zIcg0hV4wwcac8hdHwiyCqNQ7gDLqdeKdb9hnD7h/llDzR/s3Wm3tsVrMCnmiKjaPU0UTa28uoewjCx6tvmBTQa6LAYWJn368TgAu7viYQx8lozbXx5Wr/IheaBrcaUh41aMb82p8hRh4HqITwHFlk1+GRyMRyL6YxdU0E0boTkt6igDqTZly7/+Cpw/dOPOjUpKr5R1mhoaYjO0/CTwE6BSmzym631dKvIXtElbXSLUuuCASiApx/2sgozLlZErtaiLwp/7t4ubHgWlpTDlJBhY9lGRipGCuSdHFkpoMZJ41ftxJTuHyHcshGkVRCgAQfYOyyZCkta/2+3ILYwqeeOtrlRUrgQeA+Eij47cj3XSRbDuv35d1bt2eMrnRKttsepeOWLtlYyd+HgXSh5gg6Sj7/FxO0ilaoknlidcp9Lf4dnrHhcGGqWxLpPcMCT+Oz5fQHuRaV6RmWJMZIOz4rABBvAhvxe/2gKjo3JaJAHavgZZAscH2XJpk3CqtHPfrgWSrbLewC7kvWfaGzwd36r/de/ZtaI1K9g1qyichLweEeBK2zOZrie8v9sxHTMCQHj2hT9AS3/5kdAjWMzhu6t2e+HUooSjBExfeeYa2qcymqugT9dEkfueiXoK5vPODGzmLjdlsFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(2906002)(82310400005)(40480700001)(316002)(70206006)(70586007)(4326008)(6916009)(7696005)(6666004)(36756003)(47076005)(54906003)(478600001)(36860700001)(336012)(83380400001)(26005)(8936002)(1076003)(82740400003)(186003)(8676002)(356005)(81166007)(426003)(41300700001)(2616005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 05:04:37.7881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d32fa79-2252-472c-3900-08db55cb0c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582
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
Cc: HaoPing.Liu@amd.com, bob.zhou@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, feifei.xu@amd.com, tao.zhou1@amd.com,
 Sonny.Jiang@amd.com, Mario.Limonciello@amd.com, Leo.Liu@amd.com,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add ras_poison_irq and functions. And fix the amdgpu_irq_put
call trace in jpeg_v4_0_hw_fini.

[   50.497562] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
[   50.497619] RSP: 0018:ffffaa2400fcfcb0 EFLAGS: 00010246
[   50.497620] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   50.497621] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   50.497621] RBP: ffffaa2400fcfcd0 R08: 0000000000000000 R09: 0000000000000000
[   50.497622] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99b2105242d8
[   50.497622] R13: 0000000000000000 R14: ffff99b210500000 R15: ffff99b210500000
[   50.497623] FS:  0000000000000000(0000) GS:ffff99b518480000(0000) knlGS:0000000000000000
[   50.497623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.497624] CR2: 00007f9d32aa91e8 CR3: 00000001ba210000 CR4: 0000000000750ee0
[   50.497624] PKRU: 55555554
[   50.497625] Call Trace:
[   50.497625]  <TASK>
[   50.497627]  jpeg_v4_0_hw_fini+0x43/0xc0 [amdgpu]
[   50.497693]  jpeg_v4_0_suspend+0x13/0x30 [amdgpu]
[   50.497751]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
[   50.497802]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
[   50.497854]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
[   50.497905]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
[   50.498005]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
[   50.498060]  process_one_work+0x21f/0x400
[   50.498063]  worker_thread+0x200/0x3f0
[   50.498064]  ? process_one_work+0x400/0x400
[   50.498065]  kthread+0xee/0x120
[   50.498067]  ? kthread_complete_and_exit+0x20/0x20
[   50.498068]  ret_from_fork+0x22/0x30

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 27 +++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 495facb885f4..8690467b3285 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -87,13 +87,13 @@ static int jpeg_v4_0_sw_init(void *handle)
 
 	/* JPEG DJPEG POISON EVENT */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst->irq);
+			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst->ras_poison_irq);
 	if (r)
 		return r;
 
 	/* JPEG EJPEG POISON EVENT */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst->irq);
+			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst->ras_poison_irq);
 	if (r)
 		return r;
 
@@ -202,7 +202,8 @@ static int jpeg_v4_0_hw_fini(void *handle)
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
 			jpeg_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 	}
-	amdgpu_irq_put(adev, &adev->jpeg.inst->irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
+		amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
 
 	return 0;
 }
@@ -670,6 +671,14 @@ static int jpeg_v4_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
@@ -680,10 +689,6 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	case VCN_4_0__SRCID__JPEG_DECODE:
 		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
-	case VCN_4_0__SRCID_DJPEG0_POISON:
-	case VCN_4_0__SRCID_EJPEG0_POISON:
-		amdgpu_jpeg_process_poison_irq(adev, source, entry);
-		break;
 	default:
 		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
@@ -753,10 +758,18 @@ static const struct amdgpu_irq_src_funcs jpeg_v4_0_irq_funcs = {
 	.process = jpeg_v4_0_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs jpeg_v4_0_ras_irq_funcs = {
+	.set = jpeg_v4_0_set_ras_interrupt_state,
+	.process = amdgpu_jpeg_process_poison_irq,
+};
+
 static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.inst->irq.num_types = 1;
 	adev->jpeg.inst->irq.funcs = &jpeg_v4_0_irq_funcs;
+
+	adev->jpeg.inst->ras_poison_irq.num_types = 1;
+	adev->jpeg.inst->ras_poison_irq.funcs = &jpeg_v4_0_ras_irq_funcs;
 }
 
 const struct amdgpu_ip_block_version jpeg_v4_0_ip_block = {
-- 
2.34.1

