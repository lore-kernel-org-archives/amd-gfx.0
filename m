Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE618C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 19:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FCA6128C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 19:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FCA6128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B236E3EF;
	Mon, 21 Jun 2021 19:24:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B166E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 19:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZuMbZ0zCF998Psnv6GBX9M93INqySxGyZ94B9MWmRQlx4wkmMki5AbPMtAkFC4ueVOTU+ljtU63vFrohbkjFDJqpfXc5A1/gcdCF7fpcrHorg61cRkKiRmJcxQ8pEwdMJJ3X3gbrw3Qw2NJDPQG7VjV3G0/swTDlObJ0dzQ8HlijpSzSB4yea9MSITEDETjY+ij6c0m3MLdThZPjixLE/3C4jWbouUb2k7/3NOtKJQjy3sEIXgJIPJHEVa5mYQErIOF9kKpJtVs4UTo60jf8iogGhRdnMMymcSek/3asjIpXOKQ4VU13vOv2HhF9nmaBx3C22TrqyEaQOa49UTS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maZErtnxj/m/k7J7FgxdkkxqZyqUjLWCv2pOEShSL/0=;
 b=FTOLDm6b9XV2T1BzGhd2IKAY8q2U7+/ytes6B/fX6d9xSKlR4vNdNBJOjOOzuJkpFl7DVfzmtCmbYc8z67haBCMYyEFXbnNZDk3myf6zBlRwfe+5sGRlJZM5rB7pEcuibeFcDfwo66sq4nKt4vZQLRdZzuvrlNs/vsLzCNR2dCZD6tfiHZp1j0VRkuOhOmvJgPf/7l5f1WEvYsbeIjd1A1I3HM69QWjKzwGCIj64WKYRZkYG1hVG9fJXoW1uO1Uc+8QG5jphLOszv1/zwac6rj3IdSq3AcolbCJ4gHG5MdFA0ljdqFB/ypHMn1OtBlw6KxljbOyGJXbHFNZ2eopcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maZErtnxj/m/k7J7FgxdkkxqZyqUjLWCv2pOEShSL/0=;
 b=xLgIDaaT5qUVKgWWyqQD+o9lWlj1cd5RLVllexG1OcbzaYTY4a3Gs3xJLmYXXCxJp7rK0lzA3duI1NdiYZxN47EOXUiYD3bDzyLYrwms7Ax8d5jfQ7k7miPeK5cS0RsZ1PU2Dxvi9hdaQJnDc/NejxwEz7fIGQxY2kb8sN7owpY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Mon, 21 Jun 2021 19:24:04 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 19:24:04 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdkfd: report pcie bandwidth as number of lanes
Date: Mon, 21 Jun 2021 15:23:47 -0400
Message-Id: <20210621192348.2775943-3-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621192348.2775943-1-jonathan.kim@amd.com>
References: <20210621192348.2775943-1-jonathan.kim@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Mon, 21 Jun 2021 19:24:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44aa6d3c-e1cc-4bad-aade-08d934ea2177
X-MS-TrafficTypeDiagnostic: DM5PR12MB2470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2470FFD7CF160E47E4611FF3850A9@DM5PR12MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BWHa+m6LhVKunw3G0Us+HeSiV5uWh7a4d4z1y7Hzpmjaf+Fg89Yjk9VtFupgN66QD6cRIqtU4HTVZFKyPoXT8w/MFqxxS4KeHVFzru2HsYx/otqJyiGbb2DWpDOfDKRhsHq4zv3DmZVHt8GmffVs1gAg8FldDgE48sbFE+mf6LFMp2ITdssXDMY5LKS/PLujbN24zq9xObiWLRQIkxG2spY6/Rnf7/ITuWdLMmNk6oDJOKMO9XWAAB7q2b1EYBUY8SeYZGQ3IE9vkZsqkQqfQnFTIlkwWxYYqfg0BJkBiogIQO1FfIzP5Vb2Q4Rmyv4vr6sT8ixfQryS40HDtP7A+X6qWA0AcR7V0VDYPiRuloj+Sph3GGvim9WqXeihZhKmQkdly8r6TuaMIFtj0GhZkWdw3GKvNdY+KDlnlsQQGuDKHvxWjAWQawi7x551Ibglf2YbfASLellHHDr5z2rnbsvIDUbnTwyXh744ZInYyLYjd/Lh3cbhW6+X/4zQ78ktrt/aYXoh7kdxvkeHnsTBSAbkLXCnxIGipUyjCfB8pkVKPFLMQgocfJu9tyQv/GZXdKBESJVzqIM6MEV63aKSa7UIxRoDbHNt4qM0d26lOt2zyKgK7IV+0ImxHSkXz0Dv98DbX6VTGG7Rz2U1u0QWahyXuSRQ1NL9A5CXflNAK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(8676002)(66946007)(5660300002)(6666004)(2616005)(6486002)(8936002)(1076003)(7696005)(2906002)(86362001)(83380400001)(26005)(52116002)(16526019)(316002)(38350700002)(6916009)(956004)(36756003)(478600001)(186003)(38100700002)(44832011)(66476007)(4326008)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dn2S5/sRSH4kMlC86w8NSQREb4lHYauqQlfd4f1eoUOa/wRpI1bvmtJMYttK?=
 =?us-ascii?Q?Hlyzbv0eQJ9MxutujM0qPaQTXyFstg+/BrLzhF0XZyuceH9m1nb3Wz5O3mgE?=
 =?us-ascii?Q?k8jCm/ySkWG0Xavlb2Po68oIG/fPmN/G0c3U7yj128MzQtQhqsJVuDCnMVJ7?=
 =?us-ascii?Q?Z9pgwp4hTqk7k+KRZfLYqnLOBrccT1YEcpZT8NtNWW6/JQFyB43RCS4Xr0yj?=
 =?us-ascii?Q?7HE2No+FGqu1kJw8SfNoo0GIiBVgV2udvpsxPaCY66mz/N3W7vFnwnUvmwXQ?=
 =?us-ascii?Q?6+fTz8q3cnmgDroiL5fvtXirccwyL5qKTV0R9MdeF4FscJ30BIZvsfsD8IIL?=
 =?us-ascii?Q?tsBLXo59jiAzDpV5PiPvvLEbWRPoUTIz5eFCcbcFw3W7JP2T8qDrePeE0AG9?=
 =?us-ascii?Q?BrzoS8DP16Lq9Beh4yjytBK3LhZyZCeAaCuL3OFcGrvAbIyUmfaXqum+9xPs?=
 =?us-ascii?Q?uYDgUaiSuabweqVmYb/X+znPek/JhYtZa4vY48DXJuJ8sz1HcI/JhqSoTDSb?=
 =?us-ascii?Q?bzvN9Ri2tHvzJ6LbvbW+drk3SsvYrGftW2fTXImJgX9mHLlQ7HzAqPKk8s1w?=
 =?us-ascii?Q?bOvz0KNVK08Wa5VYgqysRIYPk2EuffZtd/Agkb0RcAP+0GWKxOVIqZVfjIp2?=
 =?us-ascii?Q?TlC/19eQHRSGLAf4zOUOtZafM1PnyZ7Zn0LyfBkJv12nS7F05BzsnIayN1ZF?=
 =?us-ascii?Q?gk1cQrW/b8djjRYC1yZbC/fujEacTYHi5RCMdBPS2sv9Ox/KisablruXQ6pC?=
 =?us-ascii?Q?gBYubrTrui5iSvFO7bvO2+9E8C6PxaZNXifo53EP9UntfuXRGEY5qhb8Y7/1?=
 =?us-ascii?Q?eC2DBCQhfz1DGROX8MwctG4ItV7Ow+N7YP95QemQRrd6GwmXe7poMW8i7c6e?=
 =?us-ascii?Q?azsLvjmvMX2h69u3mSOAInJn/RlNQkeDe+22sbFyooI7Q4YsM3eMi1V1b/DR?=
 =?us-ascii?Q?ljrWDdMgN4+AbEV/tuqfl6cxZqJKKFJ+PhtNigKSouefLhM1xvSsC1LrM2Tm?=
 =?us-ascii?Q?Xa4SBTHr2WXcIFBsRJoF76GeUnDKAuxRlHnnoD8P6UrmqK/EG5SrsEmdUzj1?=
 =?us-ascii?Q?Ee9ZYOp2XSR1as+JVr2AVQAFQZNi21I5WXN3Kx/ZSAxuj5gX1QDROLLSor4m?=
 =?us-ascii?Q?HpkL+OaeEn+3pCn57sepkONloyeTEQ05hmL4XeX3J3bMblB+hnzlHwT7J+FD?=
 =?us-ascii?Q?9xtbQoX5n1Xew6mjrqwZflxb5JPzR6fyNy9iZmfW8LP1mO67VPelC3I462Ay?=
 =?us-ascii?Q?69sSxJPsFKlUIWskCyyO+T6HFX2Od80zNebwUOMbEEboyh6rAODwzpMZC5P3?=
 =?us-ascii?Q?hSWAl2DrNd5f1slFA9a6Ry5V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44aa6d3c-e1cc-4bad-aade-08d934ea2177
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 19:24:03.9577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EC75GHKERUYb1vKG6G75fGYAftWKhzCoLW1n3w2RwXNGDrixtE7xvAnMOTK3CGtY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Similar to xGMI reporting the min/max bandwidth as the number of links
between peers, PCIe will report the min/max bandwidth as the number of
supported lanes.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 24 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c      |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c84989eda8eb..99c662b70519 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -568,6 +568,30 @@ uint8_t amdgpu_amdkfd_get_xgmi_num_links(struct kgd_dev *dst, struct kgd_dev *sr
 	return  (uint8_t)ret;
 }
 
+uint32_t amdgpu_amdkfd_get_pcie_min_lanes(struct kgd_dev *dev)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev;
+	int min_lane_shift = ffs(adev->pm.pcie_mlw_mask >>
+				CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT) - 1;
+
+	if (min_lane_shift < 0)
+		return 0;
+
+	return 1UL << min_lane_shift;
+}
+
+uint32_t amdgpu_amdkfd_get_pcie_max_lanes(struct kgd_dev *dev)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev;
+	int max_lane_shift = fls(adev->pm.pcie_mlw_mask >>
+				CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT) - 1;
+
+	if (max_lane_shift < 0)
+		return 0;
+
+	return 1UL << max_lane_shift;
+}
+
 uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 20e4bfce62be..88322c72a43d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -31,6 +31,7 @@
 #include <linux/workqueue.h>
 #include <kgd_kfd_interface.h>
 #include <drm/ttm/ttm_execbuf_util.h>
+#include "amd_pcie.h"
 #include "amdgpu_sync.h"
 #include "amdgpu_vm.h"
 
@@ -227,6 +228,8 @@ uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
 int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
 uint8_t amdgpu_amdkfd_get_xgmi_num_links(struct kgd_dev *dst, struct kgd_dev *src);
+uint32_t amdgpu_amdkfd_get_pcie_min_lanes(struct kgd_dev *dev);
+uint32_t amdgpu_amdkfd_get_pcie_max_lanes(struct kgd_dev *dev);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 75047b77649b..f70d69035fe7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1036,6 +1036,7 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 			props->max_latency = iolink->maximum_latency;
 			props->min_bandwidth = iolink->minimum_bandwidth;
 			props->max_bandwidth = iolink->maximum_bandwidth;
+
 			props->rec_transfer_size =
 					iolink->recommended_transfer_size;
 
@@ -1993,6 +1994,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		sub_type_hdr->maximum_bandwidth = 1;
 	} else {
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
+		sub_type_hdr->minimum_bandwidth = amdgpu_amdkfd_get_pcie_min_lanes(kdev->kgd);
+		sub_type_hdr->maximum_bandwidth = amdgpu_amdkfd_get_pcie_max_lanes(kdev->kgd);
 	}
 
 	sub_type_hdr->proximity_domain_from = proximity_domain;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
