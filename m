Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3B9C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 19:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB893613E0
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 19:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB893613E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C47C89C97;
	Tue, 20 Apr 2021 19:28:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FC389C97
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 19:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCXggv+izKvdTDR8jXrRk8YCoDAS1nPSVuWRlLMqL7jJMicaS8Way/dAkXdFHWHYevajyD2fba3vLb/E0Ko2PTELlKLpxIxTQD8d9ruEZ1zBohux90IjzoHweGqfWcKHUhIET94fHF5SQEzs2WoG58wquIoABULM3qM+sCbvHl26mYz73FTJFTzI6ta96p8P8FI2a8v/k1JyZiR86eTHWQjrk4cB5wRerfTIioMhCMTzptlVNRWmIGoQYo0AibYgDlYcGjWBIbn85ErGnm/OJW/wUxcxNwuETNToaMmZQ6tJ0HTM9FumBsnoJ2nOidnMPfZA7RI8TVwKml3E+DIS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4LchflZDUrt/uO8wi/SsHP89Lt59KCNTH3CnOvi/GU=;
 b=fXjrjhM7uWd6iXuSGv6ppUynnBzEu/UjDMcEM+FfW6t9gTQDldp7ARKBxuo3G695dEShg4efAsoVe1wsFyd0/qlTb7Xr5Z8XNmE3ZPWzMUGDeCwWj0WqoY68xP/AFtsQsncja5nPCMriNqGijKOxCWj9DixxgH7qFX16TigH3gA904U7fJ4qy925XTvo//kPJKFDnG+ipGsSeH5lXOOOqtD8InodBbEuoiigVU4DmKNwvb0WL76/13M1Ar9mLhyWRTNd0mteKEqLly6Zb+ULhkwApWDurIKNkMBDOVMkXrwleB6oRHPrpc8uy1IF32OomoYnWBvxTEHfUtAUnSw+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4LchflZDUrt/uO8wi/SsHP89Lt59KCNTH3CnOvi/GU=;
 b=xO9S+hsVRBVcJegeBgR5ghhP5LCpYcuprZgqsB6eeM7IzalveOvxgfuuBBRoJb5+mqGLoC9bGy2UWfdAt6htpez1d53Xk+JTMjZeqH8p8uT7oykrOwnt/H1QR1lDqatJmVIha5TDPjSUm2R1eY8zqiEMhZRCxw1BUFOh6vSz+js=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 19:28:06 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 19:28:05 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma 5.0
Date: Tue, 20 Apr 2021 15:27:39 -0400
Message-Id: <20210420192739.1906700-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0299.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0299.namprd13.prod.outlook.com (2603:10b6:208:2bc::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend
 Transport; Tue, 20 Apr 2021 19:28:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c811f50d-a5e4-4e32-5e33-08d904326bed
X-MS-TrafficTypeDiagnostic: BL0PR12MB4964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49642A340EB6F012A5160C45F7489@BL0PR12MB4964.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1sMKGmBArSro/Uk+17daR3RcxTDPhBR72i2Gh+KiCQD3oFM7tgkCoub3KfUcK5P8NI5PPBRVj/rR5IbQSXoPbuFquLZKhQakYeYlNDwsx+doCEE7KTxw9lb06A9k4Y0U6s2K8vUaxXhcYb07OmeYqGNfeUhx4UBporXCH4zdIFtvGJ0RcgoyexRS4PBwi8632kqMN35kWSLJhLODF420WrHQiVmC1LFpDHozU48vOpnim2E6XYaCXydixMUkWeJcMeffl1VM3WbVrfKZxJqNo/W0Cpoufvjri6abh3NAlIwBTXxIkZ12N/i0WEJ+jdhMdaLJ/x0glYWMokfxjT6lGZBvzRP3eKBBuQVflkiATw1hcmHSqnp5yl9UEuk16TsZXw6Yrbvavam7vAEvwnUbJij49f6YT1yH7l6PTquIYGQDLHx4yxXkKI4vtM8VMSymbNN1HlFH16dykoIucq8IpSTnB6zq7lLQdAR+oBHJXU/0WIRJ6IXRG7BQQSYH8gt5XOvNpXmeGs0r+LqFcFcUc8V6AyIlEobTu7aucnPd/Pp5jVktKxs9mHsMJkmhHtLHApnsEt9Dde7WioYO2fhWO2nLGlpvl9k2KtcxHh74wtXpnclQKE+peJl3qVN4g4a8+3ai74p1dob3MEkOLtOIIsCwCW7/1TSBnyo5bna1hXYggUqe8VIfM5DU2hmB5BS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(186003)(83380400001)(52116002)(316002)(2906002)(66556008)(36756003)(16526019)(6506007)(478600001)(4326008)(86362001)(2616005)(6486002)(8676002)(5660300002)(38100700002)(38350700002)(66476007)(26005)(8936002)(6916009)(66946007)(956004)(6512007)(6666004)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KVUrqNxt0JaJ4wM7N6HIDjYAvNodtfdgmEbOFAJalqaAjV0Li3kJsCarUPTH?=
 =?us-ascii?Q?PwZDD0QsBIWQgLdv1sW95SerxsGJH6Ld3PjxJq2otfrb5Jgup5j9a31fCS3b?=
 =?us-ascii?Q?CLngfXenJ0GQHB+fJne0wssoPplXMlA+KnKJpntc6gfkDf/UEYgCCZQ0Ny9f?=
 =?us-ascii?Q?s6100sPDrJrqGrLHCyVlLb7jOPpdjHXvURTY+uQca+gCF0EuxvhxgNOvd4T/?=
 =?us-ascii?Q?LAwSqCR5k9ax8ru0STmT83UrhWRvWxHz/6OTzrO2gE0qwGDMdPF3Re5ahw/2?=
 =?us-ascii?Q?m0gFOMWdkoZqcFRNYw027xkRVnaB2hGiSCw8NJxpIMlQUEpTIaZRmJ7StnND?=
 =?us-ascii?Q?mRZO+wSkykUw71DtWzpFMAVsXQUZp9nL2CRfE/jm3OuhR+LKXbBCubwke0PI?=
 =?us-ascii?Q?Fe3itBbaG5hbI94OrOugcSDRMcAVLvIkd023+EJFYdTvXlZ0Urz3digX65kO?=
 =?us-ascii?Q?izs+569Akl6uyyDzChndpUu8zMyl24b4coC68ermDrKIJZJiPNOubmi0JtJK?=
 =?us-ascii?Q?rL0GS5DUl9mA2n10Oo85qrueas/aOvVrSLOVtofS5KAxrOpfR/DbDk7bfHEx?=
 =?us-ascii?Q?bc/E6vFFASSJkDIBa+J5GO/TBxIrxjvip+2zZ3LP2/jMP4OQ7Jo0g6k2tJoZ?=
 =?us-ascii?Q?gskOGPuQ3aKQv6CRL3laKZxLSiUdkMEpRltgqXYQ7tZBuM3js3l/0/askD6t?=
 =?us-ascii?Q?wUhu0v1q/KBiychT9+uoTvnB4bEp3n6sk+YJKeG1HycYoJ3yBs6IZJxEFzNm?=
 =?us-ascii?Q?mgKF/zEdbdd2pPiHiubyUUTAegcMuZMXbQNPEtIhpYvP66u+cPpGfNGTpx43?=
 =?us-ascii?Q?w8uOcM1BIVA1p7mUVrwK87qNe1jFuHxmiWB0sHmp9jxscR7fHVONaPlEXEbL?=
 =?us-ascii?Q?9/NmMXFc1g90v4/y6cT67Rd0YYGoL0aZjN0cPUCtJF3dOozF9LIbcPeg7Wu8?=
 =?us-ascii?Q?qSrkwJJpyXcnMzVgqexyWFzDwXAUhSWooGWBMlVVcH1Kz1i+liS0MMVwyUF4?=
 =?us-ascii?Q?pkk6KizV+elnxvskqXOgKhGeh0B8ileCI6F5w5tOSrY5SVmJB3pT/1q0YqAj?=
 =?us-ascii?Q?gW45jI4nYv4WKJYN1cjWxypR9Z07FigQbc99k8M7S6ArpTqbQ+TQTUqXlhgn?=
 =?us-ascii?Q?4EeQl0x/gKoplnMSsqwpr6JGS0ackNclVSsNQRasqynKU5sAcKG/Do2Z7hnE?=
 =?us-ascii?Q?NQTtk0cNHeyFa4Qbm0v42CKW5JOZx6x60lA2e2ja2X/MC+TK8/E9KHSeOkNa?=
 =?us-ascii?Q?MwJfaT2Hc+o8H+auBvnCENCX5nwvNjY3MkU6TAOMmcEZ0aOdsARbB++rFKty?=
 =?us-ascii?Q?Yz+tg4Iqjnl98S4GH2bQMkXB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c811f50d-a5e4-4e32-5e33-08d904326bed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 19:28:05.6355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbFqz5ARQBlqI2CXLZSjTEbvxwSVywmnuz9pJJjkfvHHid47rVJQ73pXd1inZz7UtULE8lksBBSM02i5cprZQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
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
Cc: Alex Deucher <alexander.deucher@amd.com>
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
