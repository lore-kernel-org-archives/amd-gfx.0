Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AB7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 05:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1B210EE9D;
	Wed,  8 Jun 2022 05:36:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156AA10EE9D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 05:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFyT1hUNDRz7a/i5lSijC3GCFQawxeROnZ8Mf2IT7zi0kX3KVypoD1X9TmgQ2HUgrnSLZVVWtnZ5m10H5CR/1raxH+Yz5Pn5h5X6JFd77xKydjB3ivWkllObGOVijVXhH6ggToakdqOg6bB4T7k7/ApSzd3ldgxFnHTFNxCGiGyBo9n21jOOEVE82RD2DkdvDULP/FR2P5YhgUVuDF+SDfa/0GJcbFVHytPUC74l71vtPnYU733JdBNHRKKuzTJ3DfmlVN0knSdFgNVwUOJE2iwCJR47tJS83lJubE2d9PMR1fo+2DKG/I4+boOwnGuUiqqOzGH4EJ9J5FKrg1cJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKKa4bRi4u5U7ADXfemhqScBMDjq8y6kCdl8FA+K4+c=;
 b=hA6efahlMPEhkCwKbPUJu8mvgkL/41CpIc/o6c1g+jj25ji0DQl70I1m4rz7CzrnVqsmhNFpsT0LN4j1sNdJFmTX6GDUswFtnK2G2EPVd2deG0pwGyfXYHBmRbMVGSALSR5aJYz2Et62uY4vxu/w/zSu0Ib2k/o86TT5uqW3os2EhETepCDNTKyM4WQIvCWeyx7ZSR+0VtbohapnKACOm8i68lZQKSrhuOxNULT94qzCy8kq+9Fep3zdpZT53B5J6mlqM9uUAmhMvoDdJ2wtMloYV+qS9IcOL4GUEms2oX8bA/dwYZgwgtzGMKDKbwuoRV2YIHynyfbtTtN71+tVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKKa4bRi4u5U7ADXfemhqScBMDjq8y6kCdl8FA+K4+c=;
 b=vPGXOvWLlbQUBRZ1I1Mvv3CCM1EBmdvvwVfQtO8fFMvs/zNONrRCYoZhn4nz6TVsCMRvbLVbajtF3Vs4KWSveiDG8qld1X+YEAModYv0p1qJB4Q8azOUHCfpMExvznRhaIewI5PE0z0M8nfQd/6ja8mCgLEGuhe4qTmS3t17hH4=
Received: from BN9P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::6)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 8 Jun
 2022 05:36:54 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::9d) by BN9P222CA0001.outlook.office365.com
 (2603:10b6:408:10c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Wed, 8 Jun 2022 05:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 8 Jun 2022 05:36:53 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 00:36:50 -0500
From: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
To: <lijo.lazar@amd.com>, <James.Zhu@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 1/1] drm/amdgpu/jpeg2: Add jpeg vmid update under IB submit
Date: Wed, 8 Jun 2022 13:36:19 +0800
Message-ID: <20220608053618.3484143-1-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc22f373-ce49-451d-8c63-08da4910e501
X-MS-TrafficTypeDiagnostic: BL1PR12MB5849:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5849EF8233EBA997C286AEBA98A49@BL1PR12MB5849.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3VcGumLtBGXEZt+3wA3aNiQweBvuZhxk1NdBwhL9IperOqQFivbFurK2SjkaUgym3otkEpLT3afU8oN/CJI8p2XzxMTHjaU1bldwGYLV6PSNVueUgaI2wvz9Ym8rTrGQp92uAInin9pEl967+yCu0UhHanZ98vqiAg6U4papV6ZMD49Fl28HhOQ5gPKLAaVblva4vU5a8CUmaYdWcXj7qUVxKL8kuhgsXT+k8PU8mOoOb93FT03HNHW9Uj8qiMklao5XuFgP4t2MN2Q4kIrRvdg7uCQlouk3aksmsZ3awwz3csMMGqyZHjVkhYjl43Qlg+6AT/Wh6dsnKpTUB2mQbhFndZMfFcYbUxDyB8++Wbf4JDkGdyeI20khL7JTtKHNuNuCoLEHLde7V1L9vyQFdi05+2Sm1K0tfC0DdWBhNkHSnCn/sedll8bpi8fRYvq+Vvl3EmDTig6Veeqcz9iVZB9WpG9fUcPSS4ryV4+5LIe0ks7Nxklwvrw1kCzngrR2OkUGSHNeOTzRSmju9KJdQHJIyjYoo/M0Ne2zoldPDVqJbEFj5skPDU6S5K8SI9gEn1ucp6HOEhrsDoaqhtzICa3cYSWyroZGb0b0h5xcYm8l7CwdEnHpBYHi7NJiDFSYaWfZ43V1zNLLD3WQfOaNAuN15Mh61FQmVbW10bHu2zfw0Nw/xvBkkldO3QaF1KQhzsrfnZo8vGWdn1I+4SNEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(6636002)(36756003)(83380400001)(15650500001)(316002)(86362001)(6666004)(36860700001)(8936002)(47076005)(66574015)(426003)(5660300002)(26005)(16526019)(186003)(54906003)(7696005)(82310400005)(508600001)(2616005)(356005)(1076003)(40460700003)(336012)(70586007)(70206006)(4326008)(8676002)(2906002)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 05:36:53.6109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc22f373-ce49-451d-8c63-08da4910e501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
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
Cc: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add jpeg vmid update under IB submit

Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index d2722adabd1b..f3c1af5130ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -535,6 +535,10 @@ void jpeg_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
 {
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 
+	amdgpu_ring_write(ring,	PACKETJ(mmUVD_JPEG_IH_CTRL_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, (vmid << JPEG_IH_CTRL__IH_VMID__SHIFT));
+
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
 	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
@@ -768,7 +772,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 		8 + /* jpeg_v2_0_dec_ring_emit_vm_flush */
 		18 + 18 + /* jpeg_v2_0_dec_ring_emit_fence x2 vm fence */
 		8 + 16,
-	.emit_ib_size = 22, /* jpeg_v2_0_dec_ring_emit_ib */
+	.emit_ib_size = 24, /* jpeg_v2_0_dec_ring_emit_ib */
 	.emit_ib = jpeg_v2_0_dec_ring_emit_ib,
 	.emit_fence = jpeg_v2_0_dec_ring_emit_fence,
 	.emit_vm_flush = jpeg_v2_0_dec_ring_emit_vm_flush,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 1a03baa59755..654e43e83e2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -41,6 +41,7 @@
 #define mmUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET				0x4084
 #define mmUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
 #define mmUVD_JPEG_PITCH_INTERNAL_OFFSET				0x401f
+#define mmUVD_JPEG_IH_CTRL_INTERNAL_OFFSET				0x4149
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
-- 
2.25.1

