Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A8C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7444A64F0A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7444A64F0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD0E96EACE;
	Wed, 24 Feb 2021 22:19:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13AB6E054
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxg9Al1zgOx8zkJPwhDlgW7+GdJqTBwvtQ9wbGRfHXRD1NECOjOwI5ANKFpwWbNx6TZO63FDbTcovz3MqRg9fsK6wnzH/OGAjDb+kuHiPMMFfHSGbRp4drkVAXUXOlwd0aURdCKs8H2Sk7Hr/0G7ZrJbMOBuHyrRCPUJfqbf3mXW3SQg6BQmzX9D+K3eY+yoa8gRw+uSuO6BAznuIyXm++tXVhBCU73Q6Ycmr+0VoLOzvzIsN8wRMvilk4QBNRwqaSP8hEg/dAc+FSCojWWte1FJf7Vk4I/GMW2HWziyQGR7nlQgoeeA3sEm5RJ1ZsZhNcJsxjko8q2SPJDtc+s0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTJ8Hwtrs27NIPKadfb+ELHKZAv1OITgg0XySp5qab0=;
 b=IjdAFch+S8zWLggYecR0eaod2jlRU2o68/UJ8nD0W9+cA4gWE4DAS0Vpg46jHE9l1mN3K73ERgACzPXLi7H0u765ZpLzCphHFC/EJot5o4PSlbrDdtgj+mKFd3t1oIF+R8r7dyV+6rFmf09AXIi5dXjWGKbyXW1AHz+/9EcDSnf41VeO/8yRJTuQaWxQpbueo5P8jsnmb8Ty2DPrj3eIJDUiT9g+ybZM9WtfJgZTbk66qnEJeYJD8XKJzUVAPgPLL1QVSpoaMnMWZoNdpd5H3CU71NGxpD/6ecFzS7BLDq71EALDXX7FURlm7gDE0x3AfBwaFvAMANnRBHuGauo9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTJ8Hwtrs27NIPKadfb+ELHKZAv1OITgg0XySp5qab0=;
 b=Qmlh2rYI50fw1iOS4aiTPIsgKnlcOzqi1817obQ8lLaNx3V5xk8eBKTuqt5F9qEwxTn6rrcflCVigFwT1PpkhzkWtxb/6nlIMC4EbX8BCcDQJCGMupJHAwcK8FnTEVQtAKJutEN1Wrig09Onj19EMfY//mCt5d2K70MZJT/023k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:39 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:39 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 029/159] drm/amdgpu: add psp v13 ring support
Date: Wed, 24 Feb 2021 17:16:49 -0500
Message-Id: <20210224221859.3068810-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ead6dd7-f482-436b-23fd-08d8d91246bc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175133DD959256E02F67474F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:59;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngpD5e9ikrlMqjA9Wk4XlXQa4Yxw9uNJEyEbcWWr/T5zc0cVepdfQ/7Ne1h8NKnVe7KrIxDfmMzN6EXjaDOW867sERqcmHTjG9claf5XvON30ENm0ozkIBF7x+4CDTDjZrbk16lQcNwa4OcQ+rDjXJMEb4luHhYLAwELBGfG/sOLIbjjHAmzbKxjGEVQFWZrBdXWQ7cvmdzaC2Rw2jf9+9IF+vSDewP53a1UbWcLGy2HTMss+BCZVNByj6DgyHHeOqi7bf7CZlkpo1wV590llt/Xk1J3OTSg/LSVohEtKvzM3PVvwOE3BCkoZS7tr97gePJqFguRJvScp+C7hSuDFtGNK6xeJVzgElMwBAE2IZgRhBsDLUk9p9WZWAon39OUFQOy1HHYdNQXb4xO4hmAOMFlBWGG6HHTVR5seTdatoz/5v4+9uWb6VC0qjamGz99XFppNkyP/ehHVIrTZpSZBTpeWj4oL3f7hv3fzYZ9I6BbPhK+55HZSp+Q6YUSWXgzWGVQCBIkelsSnAezaHgRaQoN6/Y1L+orzJrQMKMbUHj1icGoHWz9SmmxP5zoOCOF5xdYY4kAo2Iry6MaiyV69Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JII3h1Ws06QdflvlB9WFeTSrPDlnPAqIPdZC1qPIRUr2ibmJwUg4lOpyzwi6?=
 =?us-ascii?Q?becmJhMUIqZQmE3Sxt6B6bXSrEaOl6QfCXkNLDhG9t+L5dfgiPaRY3jValFo?=
 =?us-ascii?Q?G7J9MtsmougjLhwtGDYP+3/qt+zk2D4TlTiwhS7eqXwD9mir64e6W3lXMVXD?=
 =?us-ascii?Q?wFzYf3s8Owfralw4y4NA0RBx+xjKHbhYhlwa/rO1a9xmh4IQtUrNdSuA+bu4?=
 =?us-ascii?Q?Rrlx+vORZ4kYR8fSgbI0GXgEVQmAKzONH3JGLCqPEvxcS25ngWXJbQGoFYPF?=
 =?us-ascii?Q?qaonkotBdDRcBjVZFmnMCt4glcMVwh3jz/t5GtjE3mvBV6VMphUzFUdzzVhs?=
 =?us-ascii?Q?z6gqoLtvOmsp0IGHbesklOCMfCHlVIEyB8i7UbbF03gjIe7RzaVi2f/S/Zjm?=
 =?us-ascii?Q?pYJVmZdjjn4hViWsIPCmd2j2NTj5Tc2rKJ48LLsygPsJ33Yxf8joVgm9RS3F?=
 =?us-ascii?Q?KqxpAp7TY4HxTMJY9vto79TpdNb2Hou+/jY+olE4NNuksGWqg1GqM3K21Kh4?=
 =?us-ascii?Q?Np4YjL7kfuzkPMqTZM5/jtAedwq5lEl/+rOJKPqsKkUdqYar7rzUdBgrKAE/?=
 =?us-ascii?Q?7vOzml5/athZ78YbfYjKyzw77TnxYCc9GsLJQVuNm2IO/V17hAZeCPlbjX0F?=
 =?us-ascii?Q?FVQq8lj8EoknyzymkzrIZ6KD/RHrL/6bUAftsYYN5VRFL2Qv7z5MR/gUbD/f?=
 =?us-ascii?Q?x7qxtKPlroeKmby7IlWI5XqVnuu80szQI2tCuB22tCV64f2r1f4z3ipPuoXo?=
 =?us-ascii?Q?BPnJufe2OdGUV8J8d1DudaMgmup7rPPXGLpKFos+HsIElv3aiA8Ay0gA5UTj?=
 =?us-ascii?Q?5a05FPoVUPQzrG8EQPPyeJR/JTS9WZ2IDaOZzLxtky1/m8Vzt/DbP/gJ7+ku?=
 =?us-ascii?Q?ScuTFnUG1BcUDUJIFSgcvOiabWYBPO7d/pj6cc6jV0A4hXO1y4ssKHAY6kAe?=
 =?us-ascii?Q?paBvjVwthXZwiv5Lh8ENLr5xM5qfh1NYGvao2pztqnqzARQM6JsMEzG+i6cH?=
 =?us-ascii?Q?TEuHkVmGAJHnuBSLQ6wD1N+e2r26rX25x7nujSTFpOWkgQ79ZJ3wWe437MXI?=
 =?us-ascii?Q?s8Ry7h3rRRNKeThTmKnRJgWRRJb2Lf1pzHxK6PS1NRtRerrwtI1kzsWq299i?=
 =?us-ascii?Q?bpSS4Di4layEgCz8jU8EA0iap7uo70BsLShEIG0K5/GQdrdk/9gPxpulLMYP?=
 =?us-ascii?Q?pLNP678mVMTao7FzDLR2L8mZ7ArO0+YP/eS3Gbt4Gd8s9P/ZjjdXiSWm3usS?=
 =?us-ascii?Q?IEkwtldl5gsakZv8W2N9cLIjBbceWs1YBILwClciG8CcZ6+D3Ot4C4AjnxK1?=
 =?us-ascii?Q?xlmN1jRjKXiYbabffGZfnDLB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ead6dd7-f482-436b-23fd-08d8d91246bc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:39.4071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5d+I6M5zVVkF2Ch0Y/SucSD5rXFNiQ/Bm8nBx7K4j+yUev3y19qnE+DDY2rhYXm5AXTDDuQnhGN6IWgGGTISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add callback functions for psp_v13 ring

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 171 +++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 6bdea3f35f3d..4beee092acf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -189,11 +189,182 @@ static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)
 	return ret;
 }
 
+static int psp_v13_0_ring_init(struct psp_context *psp,
+			      enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ring = &psp->km_ring;
+
+	ring->ring_type = ring_type;
+
+	/* allocate 4k Page of Local Frame Buffer memory for ring */
+	ring->ring_size = 0x1000;
+	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->firmware.rbuf,
+				      &ring->ring_mem_mc_addr,
+				      (void **)&ring->ring_mem);
+	if (ret) {
+		ring->ring_size = 0;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int psp_v13_0_ring_stop(struct psp_context *psp,
+			       enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
+	} else {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64,
+			     GFX_CTRL_CMD_ID_DESTROY_RINGS);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+	}
+
+	return ret;
+}
+
+static int psp_v13_0_ring_create(struct psp_context *psp,
+				 enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	unsigned int psp_ring_reg = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = psp_v13_0_ring_stop(psp, ring_type);
+		if (ret) {
+			DRM_ERROR("psp_v13_0_ring_stop_sriov failed!\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_102 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_102, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_103 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_103, psp_ring_reg);
+
+		/* Write the ring initialization command to C2PMSG_101 */
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_101 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x8000FFFF, false);
+
+	} else {
+		/* Wait for sOS ready for ring creation */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+		if (ret) {
+			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_69 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_69, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_70 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_70, psp_ring_reg);
+		/* Write size of ring to C2PMSG_71 */
+		psp_ring_reg = ring->ring_size;
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_71, psp_ring_reg);
+		/* Write the ring initialization command to C2PMSG_64 */
+		psp_ring_reg = ring_type;
+		psp_ring_reg = psp_ring_reg << 16;
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64, psp_ring_reg);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_64 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
+	}
+
+	return ret;
+}
+
+static int psp_v13_0_ring_destroy(struct psp_context *psp,
+				  enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ret = psp_v13_0_ring_stop(psp, ring_type);
+	if (ret)
+		DRM_ERROR("Fail to stop psp ring\n");
+
+	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
+			      &ring->ring_mem_mc_addr,
+			      (void **)&ring->ring_mem);
+
+	return ret;
+}
+
+static uint32_t psp_v13_0_ring_get_wptr(struct psp_context *psp)
+{
+	uint32_t data;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev))
+		data = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_102);
+	else
+		data = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67);
+
+	return data;
+}
+
+static void psp_v13_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_102, value);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_CONSUME_CMD);
+	} else
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67, value);
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.bootloader_load_kdb = psp_v13_0_bootloader_load_kdb,
 	.bootloader_load_sysdrv = psp_v13_0_bootloader_load_sysdrv,
 	.bootloader_load_sos = psp_v13_0_bootloader_load_sos,
+	.ring_init = psp_v13_0_ring_init,
+	.ring_create = psp_v13_0_ring_create,
+	.ring_stop = psp_v13_0_ring_stop,
+	.ring_destroy = psp_v13_0_ring_destroy,
+	.ring_get_wptr = psp_v13_0_ring_get_wptr,
+	.ring_set_wptr = psp_v13_0_ring_set_wptr,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
