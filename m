Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5C9C433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C918E610FA
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C918E610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65ECF6EB0D;
	Tue,  4 May 2021 14:02:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D79406EB0B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 14:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeV8hG9JAsBlvkLD01vo7z0RfYZshMoyP7T4QSBDj6RMh1zaB+/J9bCbB1FHEr7G3DSm7gLPRDxKi9zU9gmGscO2Pqv3DY6919Eck0ejBuf/+5s3HPhC8y/ayfOajPfVrZjhjrSJv7gVyu+SG7g5OIKZEntLEMXq7nPwaf3uUFXIl2ZrvU1RbOZd705kGg64cuwAO7IVdaLZUiiJBn60pdMVCGy6ImsZYQaAdGzUeo6wCZIMcUaG7qmv6dkBiw8LLHTXtY1jM0yDdQco2gvVY0A2rI6ZFU5lcYNv/WDEzHCuCcXVjoDRJlJOy0lTYGhOlumXDrJr1htdx2+jXvH4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkDEtIR6+BblH/oDQngeGSA7WUeLdAoiyume3J4xcEY=;
 b=TVUZ6LwfkIRFdIHPv+rJXEQ3jC+42L+OioS1qNVEd3MiPu7epCt5D7Y+RVuQwhKV2alKYoLD8WlGLNUOKg4J07K0ek3XKyXznWmig5kmj1IFNcvyEUbYD/MixIkRLndR2GwpyNE2MREUQsS/iQAB3SM3pHe7Fd5Rz6R8TsI2sHq57xSKhBmROr5aXKCkZs+gkAOm726nN8pR15i/MiiqksCeklFuaq5FkEafukpUIYq/oaNz/c6lHM6gQm4ppQFN3gdwKKcUHyqJi6DAOYw8XVef5enTxib9SetTqkOgj658hJkHXwwSu0S2BQfnj6jFW6oLfShATUNKBhh8e23VuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkDEtIR6+BblH/oDQngeGSA7WUeLdAoiyume3J4xcEY=;
 b=aqOJLMYIq85xSVEh7zbINV2UDy7cW2s0iY71MDEWgZGc2NHtaL/n6DbsVsbq62xh2zxgGc+mHC9V3qvxOpf7J0cO2s72M9Eff/gei/a5n7w1whQCiDpx24IZAPluRFWGhry4wncQk+J15ujTJkGVBVpbgKAVEecP79QEhSuJYBs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 14:02:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 14:02:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Add graphics cache rinse packet for sdma 5.0
Date: Tue,  4 May 2021 10:02:10 -0400
Message-Id: <20210504140211.1703369-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: MN2PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:160::22) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 MN2PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:160::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Tue, 4 May 2021 14:02:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfb11d3f-5147-46a1-1db0-08d90f0543ba
X-MS-TrafficTypeDiagnostic: MN2PR12MB3872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3872697FD02BA8CD98820F1EF75A9@MN2PR12MB3872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrSkJgr123AkhaXqsTDvbNb0gmoe0xF9ehgWBweRz1/Xwy6zkmjeJTT5wLEIDVyhVWZRyrJ0BsBANyZZtG/pB+6bnOPUOF1zygKHGWplg6KwpW/ZMKL3BDe+mN6FhcF6cshCrxmNMDRkcFkp2Zcfnp8Ppfkep57xbCmWhS2VllcKvfWpDfMzRoUpUuXwRTyR6IU/RFMqB5113h5BQsHwdtlbfNGuGsNgM7YwZ+lK5EYZKh7DiApQPbltCZ132rpdqtgESNg7XHPqgBpCX1jLg2KR+JtoxsB/FLeCg344WOPNdETB7eBkb7tC2TvbSWQA7uux5HCuMRGAreMtdE8pmklh3qYFDBVXluk9vIjK+oTOWyHriOHFUsjws7ZsJx+ePu/8hk9vfog4Bgl7vfAU9rdOgw6RrLR96sC+RTYkVkIW2tSLHxokiZPs3rSIF7QRNhFnP88I6Mw9Rp9Lv04V0vakXspiVFnj1sd3xBCzPCakOzaLfQ1DL+i50eabvK3YAlSDhkygv4zjsvomI7C16qElvX9Ie7+mUN4hvVQLl+nVmrGPKKKlPaEVtqyYetXlQ6PjPBXkToWCq7aUQFGqFxib6qRnoFa+UbHkHWEtiN7/QMOMTyfqBLLe2zp+IJyuzsK5iprduzQxbdjbF+86Rbpg5yUdRY91Hty/G/+/gabG4HtO7exnfrp/PqvOit5Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39840400004)(366004)(4326008)(66946007)(66556008)(5660300002)(6916009)(316002)(2906002)(54906003)(66476007)(6486002)(6506007)(478600001)(1076003)(38100700002)(38350700002)(8676002)(8936002)(6666004)(83380400001)(26005)(186003)(6512007)(36756003)(956004)(2616005)(52116002)(86362001)(16526019)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?T8BcFUKkObJ0VfSXZ8i1TF1rAWkZ5DJI3WNUUHgNJfMj+moY+6pgCaUh52Kr?=
 =?us-ascii?Q?T5ytJApFvDYlANLWFq9OuYrwH+XPzd31/tvfQbBbaiheQUKMQ7s6NVwPTvk5?=
 =?us-ascii?Q?yFZ6/EFPY2cwwkcg1xnz5JGnihoEWTYXmdX/EV0VnROWehL7224upOqhfPn0?=
 =?us-ascii?Q?nKBKOk7n5kwvwydDDL2N5TbwiFBm++eDGfrAWK5faLujvC269s5WVMfJsCag?=
 =?us-ascii?Q?AcZzwrb1kmp8cm+7b2eIwGhuGPhsaBzk+V8VoPofPg4/7r9zxXu+I9USi1c0?=
 =?us-ascii?Q?lG8UE0+JHYa1SCNLBIQHKtLygTL1lq2XH4DcPi54XYCIiDmK5qaMvpxJl3HY?=
 =?us-ascii?Q?JLfLonZ/mrPmwXHb3IA2v4cbx5XGXdcnT9BUZrS/0I098Ja29k5loYPpHvZO?=
 =?us-ascii?Q?WuWKfUC4MKvEW2zGAcK5efM3QLuqdqm3zmbyi0VjMPrboMQ6MWTJbSFoJEvj?=
 =?us-ascii?Q?aF1aPv/9p83KPivtnFipivNYUx9B/JLZuwBQwWM//QDw3lVB9Rbidd1TmkEu?=
 =?us-ascii?Q?dVD/XKStTEI4VZnFpc0Ikt7xmGuU2Eyr4oKw422KphWNWdeal8jVWoEhG51E?=
 =?us-ascii?Q?4Sr5z7O4VLn+uOKGSvsFD5GCvia33+xgUFJQdsuxSE+Nwza2C9qhJo/d2Y84?=
 =?us-ascii?Q?K1xQTmsOeQ5+6350T/l/VmFudog2b0RFD3FUEowsKwG5W+XfJqHnyP47ILfU?=
 =?us-ascii?Q?SwM3UeZ7HYm3Gs4c9rJuoFJgZPI5sOGjOpehCOwI7nPQIxdfhD1dKDN7qPWr?=
 =?us-ascii?Q?+EeWl9bopKhVXTMFsERMfY8xZ1N6hZL0KBMSU9ONmxRCDKo1fS2X0hI1EDGp?=
 =?us-ascii?Q?5+eczBv+rWF2PmpN3ybq42DplbwrZeg+ZyEbueDmNoIFhDnVbxPFXXvE0baN?=
 =?us-ascii?Q?MAUMiY7Ofb9S8eVREcK+s7vOlUI897y0YnF12RsL4JIU3J66MAMCluMPlxBt?=
 =?us-ascii?Q?iDxxwKXH27Zec4QqKX79ZM4czocaod3+SJkmJTP3Hm6Nf/iglMWqlKN6l4oT?=
 =?us-ascii?Q?Gv8tOtDD4yOWT77i5AKTHIempLZZ5DT+qcgXDw9NrjzZN1RXLTHF105LA9E6?=
 =?us-ascii?Q?XerYKas6w4YXuUP2ZaT+jBj3UjrLybK8XrgcAkCO4r26HyKQm4Qeg0hYa0+G?=
 =?us-ascii?Q?EKwcLRGYIfWl8mB6zkFmut3GF8X+JfLpLBEIU0U+6HZNC1aVPsWkIXDHDjC0?=
 =?us-ascii?Q?97jR1wFrW5DTk1pqm+rJs/44GpRHebGG7dgvGZVR6O8CxAsLXtMv0rHwDkZ0?=
 =?us-ascii?Q?H4VFfO6bvNrpdOmPVSYoHy3sZRrSWe50SqcaN9GnQUOkLhFha8pVIeakOobx?=
 =?us-ascii?Q?Ow1OUaZFK30LlJBldzF1kHhR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb11d3f-5147-46a1-1db0-08d90f0543ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 14:02:33.8325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIu4B11dLnsX2Pu10xNPgip1o2C+w+LBtivxyC6xL7VyHZWQmHq9CfG5PwChzx2wUHUabuYI2ezkQYEXP0cTug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3872
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add emit mem sync callback for sdma_v5_0

In amdgpu sync object test, three threads created jobs
to send GFX IB and SDMA IB in sequence. After the first
GFX thread joined, sometimes the third thread will reuse
the same physical page to store the SDMA IB. There will
be a risk that SDMA will read GFX IB in the previous physical
page. So it's better to flush the cache before commit sdma IB.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 920fc6d4a127..d294ef6a625a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -437,6 +437,33 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));
 }
 
+/**
+ * sdma_v5_0_ring_emit_mem_sync - flush the IB by graphics cache rinse
+ *
+ * @ring: amdgpu ring pointer
+ * @job: job to retrieve vmid from
+ * @ib: IB object to schedule
+ *
+ * flush the IB by graphics cache rinse.
+ */
+static void sdma_v5_0_ring_emit_mem_sync(struct amdgpu_ring *ring)
+{
+    uint32_t gcr_cntl =
+		    SDMA_GCR_GL2_INV | SDMA_GCR_GL2_WB | SDMA_GCR_GLM_INV |
+			SDMA_GCR_GL1_INV | SDMA_GCR_GLV_INV | SDMA_GCR_GLK_INV |
+			SDMA_GCR_GLI_INV(1);
+
+	/* flush entire cache L0/L1/L2, this can be optimized by performance requirement */
+	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
+	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD1_BASE_VA_31_7(0));
+	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD2_GCR_CONTROL_15_0(gcr_cntl) |
+			SDMA_PKT_GCR_REQ_PAYLOAD2_BASE_VA_47_32(0));
+	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD3_LIMIT_VA_31_7(0) |
+			SDMA_PKT_GCR_REQ_PAYLOAD3_GCR_CONTROL_18_16(gcr_cntl >> 16));
+	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD4_LIMIT_VA_47_32(0) |
+			SDMA_PKT_GCR_REQ_PAYLOAD4_VMID(0));
+}
+
 /**
  * sdma_v5_0_ring_emit_hdp_flush - emit an hdp flush on the DMA ring
  *
@@ -1643,6 +1670,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 		10 + 10 + 10, /* sdma_v5_0_ring_emit_fence x3 for user fence, vm fence */
 	.emit_ib_size = 5 + 7 + 6, /* sdma_v5_0_ring_emit_ib */
 	.emit_ib = sdma_v5_0_ring_emit_ib,
+	.emit_mem_sync = sdma_v5_0_ring_emit_mem_sync,
 	.emit_fence = sdma_v5_0_ring_emit_fence,
 	.emit_pipeline_sync = sdma_v5_0_ring_emit_pipeline_sync,
 	.emit_vm_flush = sdma_v5_0_ring_emit_vm_flush,
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
