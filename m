Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFFCC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 06:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915FD61370
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 06:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915FD61370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE40898A3;
	Tue, 13 Apr 2021 06:23:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B20489836
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 06:23:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5kJjjUStmYw0Gk7amQtnlcr87v7Gr5X8tCIXTci0YK6nenS6lAWOsEbf2J9uwk4XlhulFRKuUpe7tVB2Efv3MPtBkMWvIGOeuOS7z2qtpeKCdjLOXyZgWTReOl5QjWM9Z0jxGSIlKWf05ztDzi2s4cH/UCO4g2bbo8S9hSVqFMKhhkhH7G5FB3uuKfGsAoYFwlwsnn7tn62ymRzU2iR8g2Z6Vu+7ZGd/C8oCzHR9tKdQqGYOIV22Hx2rgikGGDo3glxsOgfe9Robcl/W+Yd/sbrId9+53HGVLpAO/abs/+a0UAmZS42Irh6ECPfUE6Tt3SN9I3DYAz4F/D4+i29jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twEPgf46t5x/j84qI9B/mP0VsGuf84hNcsubhN7EsCQ=;
 b=Zv6wVU1gDoeXnNiBWQVJCK+MhgIV/PGOk0gaXyFocLbxD+/fFlh2R0/D+PtF/f8Kvpcb5ruYj3sfxZl6gHTSjSxykk0zpJEkuJKl4o8BVrCU41KcFzZQ9+Pikhd7DeLL8GOzpiwpjhpvMCPGWnpao9mLY57EpZiyhGcOECA/NFlFlspc0x4J4aTCCExG9dnCXn8+UE2VdCKkcJ4iA3PmIbgtfkadyE4BBPWA8wJmuAiebeMUoUbh129pheksdu9Kl9sGVVTe0bzWbkK+kgv2NTIp3so+ChYtyNkjZO4C217LIadIt6WBWP3pfUXOsNmbIsTfm522RDXFqAMC2s96sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twEPgf46t5x/j84qI9B/mP0VsGuf84hNcsubhN7EsCQ=;
 b=zBCKiOVcQPD9Ieini7eX49tyFVqtijheWjAHtunIKRN/Jl7dq3Pr8cFWq3EIkakn/Ck1DHzw94B2Rc9piQjYPJmAWJUM0RMx3XlE0mh0waRLwaEHLuj3ioukVYKy6oZ7ZAN9vdtKRkc0WiSgcQx6IGQR0gl5zOxEXIgbvguA490=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.18; Tue, 13 Apr 2021 06:23:23 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 06:23:23 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma
Date: Tue, 13 Apr 2021 14:23:00 +0800
Message-Id: <20210413062300.12558-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0173.apcprd02.prod.outlook.com
 (2603:1096:201:1f::33) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0173.apcprd02.prod.outlook.com (2603:1096:201:1f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 06:23:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a08077-05c7-4ba5-62c8-08d8fe44a3ad
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB010740E08341213999DFCA56904F9@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hmuf2sfGPIHcT2loSLzrAqIH7kDO9EOVKfdvpy3kEeCiwoyrTFVtiHJPMT6CLDOPl/yfRMkQeNTEIn98GzwW/QAWP15ZLl6GAjQH5iqMaFtAlZYKag/SFrBDMUqbi2ZOQchoibLdoOfJPaRWE+ny4rR+VW1JSjASpUir3L2Nk4Zxx+82b5lO0ud3nfYdpwWmS9d8I2BqNrOi7Jmn9S/MmbpI2asI0oC7XViMPQBt9egQNgdJAbkRAd/J7NvQNd4oLZ0cNIlRvBsc/LwA8UbpqUG5V7iSu2hkRdNp41yrpR4GWbwW9ehOqv2qqjKtxNI0Rp6jyOCy9Fo47WbDR03LYu0VYsjt9q/i8XUurcwmoqR6dkCcpipYpQIXuJ1HYGqVzpaOBwtfiwFhIH6yeu63PFwEJAqDgzD6hrOkyDsBw01NkuguM5yavhMC0uYbRH5sRXsX8tn+7Ib0veTMb6AnwSDryytyQ4DOj6pY8d4ayaZYoWTjFzFSQtaxePkdvmAaJtF2JSXVWBD/GFT1Efss7A6n+29mpXcBprpA7sGktkJfBLnRN7jS06GE4Ugwv8c9VsQWzUoH3L2DfUakuxJG4bqNXtVCnS7A35osdMPg/z9pMKGEpEVmvJe4wi7stE3tmrXhJyG+d0N4rdm4tCveoiewa5sI+dK2DpxC0bzjdw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(2906002)(38100700002)(8676002)(1076003)(6916009)(83380400001)(36756003)(66476007)(316002)(66556008)(6486002)(6666004)(26005)(2616005)(86362001)(956004)(16526019)(52116002)(186003)(8936002)(5660300002)(478600001)(66946007)(7696005)(38350700002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BlBxi+ZUxhLjJId8RTrG1BUnyuEiGJa5VzQ2rNJWi1jYsSRpFOKcU8hLg1mf?=
 =?us-ascii?Q?WNfP/h6RSxgW6UiWVpCfRC5XyAYTEDxRROZkQunJEmMWA9Bk3En6yt3XihHu?=
 =?us-ascii?Q?aGQmNL6T1lgmgLQoAYPpY4lFYileZFQfGZSpq5mjS9ZzQqlS754iKpBtfQNG?=
 =?us-ascii?Q?i9cDWlBCoINooHyfjDQZxLGRtj3C1/923iaugPYQryriugaW5/NKd7IGyS7U?=
 =?us-ascii?Q?7LAZ9//Zkxda1udlOxkP7NbasAkifj+hnszkrOCDN002/4eeOstbUYjGIzws?=
 =?us-ascii?Q?GTQ15bVGZZp3iMGNw5AQ4EwvBddKmGcHjspto9iAy0JNULG5BtzlnpzKfuaX?=
 =?us-ascii?Q?kRdG+u/8EM3nN71HslgUG317vbkE4ZML0Fq/010mbj9NwnNIWim39LT77Wmb?=
 =?us-ascii?Q?Ge3yXThP9irgZypYN7Z8DLY2E+KAlRfJPdRwxeOepOjIoYCua4J9aRqxz6gn?=
 =?us-ascii?Q?QKUHhxYFrH+v92J98zkGJO5Pw18RbNf0At7UwVCjonW0nCdIQeth676ff38A?=
 =?us-ascii?Q?Kk97PQucyMcq3dxmI+zZLYjzNoPhXrgV5I80BYKJrCr+C8fmONvXpkndoJ7e?=
 =?us-ascii?Q?W+cbY77xDzNXXmsZaCiJs6ugg1ePuTc6CJPJ3Vm+mpb9LPs2gbqBXVfHxUKs?=
 =?us-ascii?Q?1RtbxiU03b4jLWY2WXlWOJyqlinn6t0xmBnfVr7uy28ddJZOYoFsnKNaCa51?=
 =?us-ascii?Q?pvGwLyb7JraWLJc1bEFxkpbGFBI5eUK2ZoGe4mKH9+hhT5qe7R3Ja1bEP2gG?=
 =?us-ascii?Q?N4gYRyCQKVKDk8N6GCwWMD8fTTaJ/Tl2LJ6kC6W11qyic0fq/6y+KqqAw+al?=
 =?us-ascii?Q?5pHC+vhhxgnOwzba+eRJbU1GYBa81ht79rhX32bH6kEi1WW+vCKAHHl0qMud?=
 =?us-ascii?Q?9I+Xi7kbokzcjzhOTniTAiZLE14CDTSObe4RUjjXah7hMtF2N6PXRe558HGR?=
 =?us-ascii?Q?rLbX2OW5t2vxjNzApVKR+U/ZqKLNhKZGe0eckGI4u2EI15w+hzebTvsMhiH6?=
 =?us-ascii?Q?T0tY7VxY/Ex0d90H6a7QxKOZ8JIjtUDmUGTqwrqcMCPhqV1rYEI+FHK4ZkFo?=
 =?us-ascii?Q?rUfYlOiPAhbyrjO0ZMIlE9Pc0kKCETshPRtsgYRXMET3OPCgLZ9KPKhiBY8I?=
 =?us-ascii?Q?OLq0xjpGVXAIz8KyZpz6P17liaTc/cGbbxrFql5HRzhXecjprmvlqLmkgmjl?=
 =?us-ascii?Q?Dvb49FN0RElUwnzWPx7I4PRwU0b6Vamf/u2ECsOqf0EXA3JBV3ZBrRfX+6kS?=
 =?us-ascii?Q?zqoXaizPS3UrMVl26LNVJ0ZAB1JUbgl1HQWBonHmnIss5AwOl6MbcwwwiJgT?=
 =?us-ascii?Q?5G7L2jr5BMslG16Xy95+nH9Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a08077-05c7-4ba5-62c8-08d8fe44a3ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 06:23:23.2884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWU/4/NqRUxugLpAM9x16uGmSGzZ5eC3Gjsuf6PpHwoExa6J9yOs94QNnm6/3v7VzDU4F3KWMAM11dwt7rmjMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
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
Cc: alexander.deucher@amd.com, Jinzhou Su <Jinzhou.Su@amd.com>,
 ray.huang@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  Add emit mem sync callback for sdma_v5_2

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 93f826a7d3f0..b1ad9e52b234 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -369,6 +369,33 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));
 }
 
+/**
+ * sdma_v5_2_ring_emit_mem_sync - flush the IB by graphics cache rinse
+ *
+ * @ring: amdgpu ring pointer
+ * @job: job to retrieve vmid from
+ * @ib: IB object to schedule
+ *
+ * flush the IB by graphics cache rinse.
+ */
+static void sdma_v5_2_ring_emit_mem_sync(struct amdgpu_ring *ring)
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
  * sdma_v5_2_ring_emit_hdp_flush - emit an hdp flush on the DMA ring
  *
@@ -1663,6 +1690,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 		10 + 10 + 10, /* sdma_v5_2_ring_emit_fence x3 for user fence, vm fence */
 	.emit_ib_size = 7 + 6, /* sdma_v5_2_ring_emit_ib */
 	.emit_ib = sdma_v5_2_ring_emit_ib,
+	.emit_mem_sync = sdma_v5_2_ring_emit_mem_sync,
 	.emit_fence = sdma_v5_2_ring_emit_fence,
 	.emit_pipeline_sync = sdma_v5_2_ring_emit_pipeline_sync,
 	.emit_vm_flush = sdma_v5_2_ring_emit_vm_flush,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
