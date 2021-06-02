Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627F4C47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3405761C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3405761C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F5766ED26;
	Wed,  2 Jun 2021 16:49:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4AE66ED87
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJwSCwBms2eusiYGM3tPYaS4IUQV55l8hKxO4pdQ0lgAZDVzG49ji7OL+g+G1T8MFcH2ejMshbwdaevs1zasV/nqjoyCknhCP0LE3byuQWj2tjK9e5bgF/7ekEbkpx5ZmqeyBJ6GH7Hzl3K5D5P1njfNPOu37M/+fdT9y6JDETqUp9dwH7SZIzYEs5yWg1jZtvFn5vBlLs5xNviLPeKbzzno5DPxqK3VojBbEeFxXuKExtOoMp8wa84tj+PQt5l+DtF8HcIP65bVX/aUnCM6Kh29gVsUolRCoHgh0PtHM+PYN7qRorsthhXid6lxlCLTf8xntpaqUoUUEzhpBswY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHokLHyIT6CKTsKWB//YN63fw8h3ix+88zvhqQwyLDE=;
 b=aEaFRpavN5QKq9fJFSK6xVtugEtlkfCEsCrThGE93ug5i7h6jlnqx/Ge1FmtpRc4QtnNtFDshP6h+4dx9XqJ0PzgQQ1lWQHfkS2jY9HG2npbz+kYPdHZINYQAGDB/YGbGUYN2s5bgtnvlfnHqs/WX3mNC3p/crmBJQZEErNUVLbYwGbF/p99fQuYA8lsFjPYjQchQV5DBReD993DntjvjzEIvlyo8QDJyEdirJzB3/2l9Fz/oFtp9YCytERhc1bpd0TZQ17U/Wmax8zxuQkXketwJV6dBJcEQtWGCBu7IOnnimOgUh9nFag/Kc1ZgVFPPCfx4HyDaydC7zFl8+salg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHokLHyIT6CKTsKWB//YN63fw8h3ix+88zvhqQwyLDE=;
 b=hdm4dTolyzqIkpz/iQpNgnI4f0jnfSp25dzCEnzutfVdHEdxpH0Wym1Qz1kN5rzeZOK9pkbT/9FWXdFlfF3IM8JJM88/yB+RzQmHhCGe9axZGaAW4yH44YfK3e2v3PRKOaBMnouunfw3bbQ0T/dhvmc+sKR4t3gb1K+Vq4CAl0w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:44 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/89] drm/amdgpu: introduce a stolen reserved buffer to
 protect specific buffer region (v2)
Date: Wed,  2 Jun 2021 12:48:02 -0400
Message-Id: <20210602164908.2848791-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebbf2248-7277-4e57-49cb-08d925e66c2f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB406396CE23AC4B12CA1661D5F73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmGHFLfe0oTjnR0LhJzv5Rp57cYk6WS7vjlYi7vy5QCjSp2Wi3MyNMopcC4og+DUHfytIzW37IoU1wSMvcEFYryNXHZ44bdWbiEcMsQb6BBB5FOd8rb9TEijpCzerqupE2So4HIwTFZpspu+U/hZErUPMriB3a5V04UpTAuDuMS+Dd47ge3amKstYR6aBlOmyl5EneySP4O4R5mOwyBuCSUof8KCBsQ4u5EPD8Kw8ZpLIknetpjwyDRQRW+E4LllTh4w/FwooeuqHGbnnGW8mZbS+Lg44F08Rw0JTNO/1HGPLvDtmSDQO5sKaIaAORdN5zewsQtvsRsmGimpLbg7any3VApMqdqi8jwcpv+iFSVKZ9RZxZPcp7EpmllpotRFCMT5X3Y9JmPEZQavwLCRDwUC41JlZH+Wsn1nnXfXwIZEKiLwlPL0HaB8JWNZRwVYASlIgrI7iWenuUJ6+Fx6YKOPEUC7bxLtL4iIsHWJ0+zetxFmLRlNv94IoWRZvcod/moVEQhTZm4dTb45TLX0oIjLc+V4+Pb4FaeG6aSDXR2GPmyeOs2Jz+8Hoc8Gv4rBIwAcNNXFPUnbzlT/My/WQoJ6E+SZfu7yJMaz9Cl5R3ztWin90AeB6HtQh0DRTSrvS8W6ShPafBBzg4eViSBcu4ySRfp48zFgFwQyLbMjnnPtsL4jMbxFT9AlY0eW6oX9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(83380400001)(66946007)(26005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NJ/QUO8vZ6fpobiyGKoPkK72DlWrxVLTQN+8Nu44ZE6MeoO/ooBMQQoD806W?=
 =?us-ascii?Q?CVWHq3vZcdhbcuE37+s4GjiJxkqvLjFH4qHaGocIWfPLaCkRTrecrrSkwzke?=
 =?us-ascii?Q?5k4apLQ+9uZdMJpxqX0/kh/TNQAU3zsPa0MElIhCYz5I43bZXiGtXtMyn51Z?=
 =?us-ascii?Q?BYCAxEzLDWfp5meuTuGrCSgcWTyVq7u++RIRIO3fXiGygrSCLKPzYAyAynWl?=
 =?us-ascii?Q?RNWHoWauXqbe5bE5btmUJeCI+FOqg6qjOfE+oV60n9G8UhwMwoBGS6ytyisJ?=
 =?us-ascii?Q?rpSS1xqQShNN6NA0MqxaEAXOjoJQ/fq6YSVKh7pB0odRvaXw5yQJCK8krLI0?=
 =?us-ascii?Q?wjSGmjaMwdwtSguvAom1XWbQish3DoYHSZs7TBlLozdbn1Sxcaoqfz+jDaPx?=
 =?us-ascii?Q?kFgL8MJbUbYBxg6Yv9y86VffXS9pBdHT9vWog5DW+ke+1BsIjfuHFGc3uHeQ?=
 =?us-ascii?Q?NlwTLU2BkCafOPw+70Y6xnfas50/JkvPK4TMpc1626U3/TaNa6JBsVy1m6+w?=
 =?us-ascii?Q?ewumiaiFOUE6mivljFG6z6thMk9f7NMmmOIEluCMXvTiKmhQCMho0ffYoC/8?=
 =?us-ascii?Q?gyQwOYSnCl9gBhT2MBX8QDBjKGEajdYUNqi+QNsbeQKTMOGKjY8ikZwdc2Fl?=
 =?us-ascii?Q?PzQT0Wo2xW/W8TP9jNj69oCgSRzintvi2Q/01ZMSzRHH6Pr+ItI3skYL+hzG?=
 =?us-ascii?Q?jWfPxsxNiWPcEkb0ac/rVY0Je9Y2quJ4j/LnQAhtWUjBff4F2t0+TOWxfq2R?=
 =?us-ascii?Q?LZ6H7dA5aQ/hztHFhGkmhc3qsWIBhXFkSaQSJN8cs87F/3HnrweJCsHRgqLY?=
 =?us-ascii?Q?uAYSJ+TcMJbijx2oQYsKM9EIBO7QO1MJnxpWNzzc7tn3nc9OOP2+3TKmYGRb?=
 =?us-ascii?Q?cim1TFTwWDWBiYuIoiGfFlTwebiXc0wnmq3gvHu4n3X3BO3sSWnmdjRzoW36?=
 =?us-ascii?Q?v3FkLzmQgvf+FMFdW6g4ej0eppa0/nn3oMaq5/2SjE/dVjt5oD6qwBA3g5Mt?=
 =?us-ascii?Q?tnAEPfm8dszR2fKr705+bUp13YPB1dB+8VLBm4pS8ECEbhaSKu1XS80k8nFB?=
 =?us-ascii?Q?SCEdSw3yJ2RobIKX8/AJpR4JpMgrsPNJVRzMyE/AoJ1QVOJYxXqsV+MKM+z4?=
 =?us-ascii?Q?ZcqcYld9wedChjt/SyljbV5ZGq9W27K+K6FhNtU5BiM0P2ZElO4tTD8YS18G?=
 =?us-ascii?Q?du7TspHlg3h9rJbjtImzC9LcYgYC09dKaWdZ1F1X/3TqFh4UK4lJQ9aOx6Hq?=
 =?us-ascii?Q?cI6gvyvr+YFOupDc63ygXfTRnIFKJw3ipMMqBFBQP4ZyNzL5sqED2UFtyote?=
 =?us-ascii?Q?31JaDDYyOfL4J7NsQ4nQTl5f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbf2248-7277-4e57-49cb-08d925e66c2f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:44.0217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DFvH0EPt1qJjIAtuuTPVOFIvM4CkOoZSHLTwOzClnW5qFM+ZHWk5z4NyCxYGqiiMuIaQhewTILtmvUD+wzACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Some ASICs such as Yellow Carp needs to reserve a region of video memory
to avoid access from driver. So this patch is to introduce a stolen
reserved buffer to protect specific buffer region.

v2: free this buffer in amdgpu_ttm_fini.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-and-Tested-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  1 +
 5 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 0fad971e663b..f1460acbab3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -777,3 +777,19 @@ uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo
 {
 	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
 }
+
+void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
+{
+	/* Some ASICs need to reserve a region of video memory to avoid access
+	 * from driver */
+	switch (adev->asic_type) {
+	case CHIP_YELLOW_CARP:
+		adev->mman.stolen_reserved_offset = 0x1ffb0000;
+		adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
+		break;
+	default:
+		adev->mman.stolen_reserved_offset = 0;
+		adev->mman.stolen_reserved_size = 0;
+		break;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 6aa1d52d3aee..e55201134a01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -332,6 +332,7 @@ amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 			      bool enable);
 
 void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
+void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev);
 
 void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
 uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 786650a4a493..74037271e91e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1740,6 +1740,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 				       NULL);
 	if (r)
 		return r;
+	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
+				       adev->mman.stolen_reserved_size,
+				       AMDGPU_GEM_DOMAIN_VRAM,
+				       &adev->mman.stolen_reserved_memory,
+				       NULL);
+	if (r)
+		return r;
 
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
@@ -1809,6 +1816,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
 	/* return the IP Discovery TMR memory back to VRAM */
 	amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
+	if (adev->mman.stolen_reserved_size)
+		amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
+				      NULL, NULL);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 
 	if (adev->mman.aper_base_kaddr)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2877a924086f..951a77099659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -84,6 +84,10 @@ struct amdgpu_mman {
 	struct amdgpu_bo	*stolen_extended_memory;
 	bool			keep_stolen_vga_memory;
 
+	struct amdgpu_bo	*stolen_reserved_memory;
+	uint64_t		stolen_reserved_offset;
+	uint64_t		stolen_reserved_size;
+
 	/* discovery */
 	uint8_t				*discovery_bin;
 	uint32_t			discovery_tmr_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e9fc8d21f3d1..716d2849ca16 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -936,6 +936,7 @@ static int gmc_v10_0_sw_init(void *handle)
 		return r;
 
 	amdgpu_gmc_get_vbios_allocations(adev);
+	amdgpu_gmc_get_reserved_allocation(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
