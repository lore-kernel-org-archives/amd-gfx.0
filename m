Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60335C636CB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 16:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71702613E3
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 16:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71702613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6106E9C5;
	Fri, 16 Jul 2021 16:43:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6FF6E9C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 16:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfWkyfE0k4KpNnbPWCT6JFL1zU1KX1Lpg/GwOoEWvIG4JnNQweN641Pr83w4+6H9rWfDlDEhJTATrPcB/AwZ64Li0qDJGqD9g8SkEUEGW01ck/+1RfIPUmGNxzZMc8dqwkvKqs4qnvDTkxV7r3Oz6OVuNRpZsKLkN4E8+sgnU/4OXyvsm9Owt4vzMkVzNAH9L/X4nCC4ZIjJkERlnA7FBd6AsoDbclVSmSGlCBNkKE/qytlwIIe8lAcL8ithIdR7IZbonJoMRFVl4YZsDfTMBZb5GoKUur/RWVu6SV3p9Y1AaI2db0L+6oPAuqfEgF5OPDAp1Ws1r2F0dPS130kDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwxjNacUnw0oOKL0gqsPv5JDy88k2eQuRP9AV/a+7cE=;
 b=RZ/+ogC1/i02F+Pe1TY57tkILxuiYrT7Z9V3FmjtNh4CZtLZGP+rHg4kic7szi5413BV81lh2g579ctf7UOudKDTVFVKRBjZgn2XnASA6/RhoTzRt67TRIJIlvJbHPYgnTfizCbRqLAzVzSBulwP3Neg9fET1sQ5VgvL/l0zUVr0sy7bThUtQH5XuAPzZsGCfOkknB68RVoZsytiAK1oFX2Y5UybIbFQF6v/k0pflN61rIxS+X1KD1fSrnLusJkg2xhSgbY8QpX55Mj9oJX+6xDfirL1+hpHpOCw3deTrajoNEHrVmFqVKb5zOHq2ZAgEOKFY/N2CKk3s/Apd8732Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwxjNacUnw0oOKL0gqsPv5JDy88k2eQuRP9AV/a+7cE=;
 b=UDn/lqhEoGHkXCNGZUL9qHyuVbUWDE8UUBhEYoSbrCOiHq0NUL3CRsWgWbNVyp0CdnYsieKHE38UUaagQbWgrqVh7z5jQZaHrtlLWuyZ2T/X+tLMCtb0cYkC1Q4UMnwD0e0Bmhd1yIVjGi8esryJ6TvdhW9Z1X0xOwiMXtMqucE=
Received: from DM5PR07CA0141.namprd07.prod.outlook.com (2603:10b6:3:13e::31)
 by CY4PR1201MB0151.namprd12.prod.outlook.com (2603:10b6:910:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 16:43:25 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::92) by DM5PR07CA0141.outlook.office365.com
 (2603:10b6:3:13e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 16:43:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 16:43:25 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 11:43:24 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: report xgmi bandwidth between direct peers to
 the kfd
Date: Fri, 16 Jul 2021 12:43:11 -0400
Message-ID: <20210716164312.896939-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716164312.896939-1-jonathan.kim@amd.com>
References: <20210716164312.896939-1-jonathan.kim@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc7b187c-a13b-413c-6a1c-08d94878d50f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0151:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01510FF6D618F7B9E917B72D85119@CY4PR1201MB0151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmIr6qMpYwhYfC8gXS2PJ4SFJtGRS9YDdq9uJlYN9pBsMlLYdn54a0Y4hUb4yj8dy2fEttCkkixNxD8CzwAnEfdODoDnAxDeoogKet01AsMYZKhkwcnCZce8vUXCRFmUhKoME4CgZrs1OKuDVc8SCvq6G7wy80vTJttGsFnIxWlY4S/pX2e/n2hY8sAJ0zSpN/nIrNg1AjP5GPGpmLbaODuIN7EVpux25thRs9gYdkWrvBN9+/+/ItEkNBVgUoAegXkBYLoE/yT4zOnT4PD18tmgGfytSRvV+5pkSN5qv+WUICqM5aiYU5zB+44SEI/pAUGmTkCSOV4p89fLOhlNu2yUlWiPdpxYRXyfB/z+N6R+EzQv74F9ILFc8IPiclwz3x/hx4bf6570aVBhN+lBRLXqjgu2KjJhueTzOmjdnoasZ7Qy78ZpfUF2rB21J9WBU8zZnnxRfQULrCYHCHBmv6yUvv7TgAA4JE/9qyPFfiSbW1z1rvGT+VoJxcnUaH/dQkxtjVdKfdae7ADJgdMddA7J03UxsxQ1/O/cu+4PMSNNnnJnKF+KyJ/q9cCn+dI3vbRVpkbZvq1j8SjsRuVGh8Ah9lys3BW+Vz0J3CzGjfWFrGFTBYWjOqxphBVFM7ZFy69QddOWc70xDlzspgxzKjB9GktYg/8Fk9Ugoeq3wkzvfgg2ZsxTZeFcmFo9S996wFQ9JSUmoCWnTbq50socofvIVs6arfzZebw+Ctzgav0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(6916009)(82310400003)(7696005)(4326008)(36860700001)(83380400001)(426003)(5660300002)(82740400003)(70586007)(6666004)(70206006)(336012)(8676002)(44832011)(2616005)(36756003)(8936002)(16526019)(86362001)(2906002)(478600001)(81166007)(26005)(1076003)(47076005)(356005)(54906003)(316002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 16:43:25.6379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7b187c-a13b-413c-6a1c-08d94878d50f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0151
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Report the min/max bandwidth in megabytes to the kfd for direct
xgmi connections only.

v2: change reporting from num links to bandwidth

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 23 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 12 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 12 +++++++++++
 5 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index bfab2f9fdd17..3978578a1c49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -553,6 +553,29 @@ uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *s
 	return  (uint8_t)ret;
 }
 
+int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dst, *peer_adev;
+	int num_links;
+
+	if (adev->asic_type != CHIP_ALDEBARAN)
+		return 0;
+
+	if (src)
+		peer_adev = (struct amdgpu_device *)src;
+
+	num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
+	if (num_links < 0) {
+		DRM_ERROR("amdgpu: failed to get xgmi num links between node %d and %d. ret = %d\n",
+			adev->gmc.xgmi.physical_node_id,
+			peer_adev->gmc.xgmi.physical_node_id, num_links);
+		num_links = 0;
+	}
+
+	/* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for bandwidth. */
+	return (num_links * 16 * 25000)/BITS_PER_BYTE;
+}
+
 uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 81264517d532..e12fccb2d2c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -226,6 +226,7 @@ uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd);
 uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
 int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
+int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 8567d5d77346..258cf86b32f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -486,6 +486,18 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 	return	-EINVAL;
 }
 
+int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
+		struct amdgpu_device *peer_adev)
+{
+	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
+	int i;
+
+	for (i = 0 ; i < top->num_nodes; ++i)
+		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
+			return top->nodes[i].num_links;
+	return	-EINVAL;
+}
+
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 {
 	struct psp_xgmi_topology_info *top_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 12969c0830d5..d2189bf7d428 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -59,6 +59,8 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
 int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 		struct amdgpu_device *peer_adev);
+int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
+		struct amdgpu_device *peer_adev);
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr);
 static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index c6b02aee4993..40ce6239c813 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1989,6 +1989,13 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
 		sub_type_hdr->num_hops_xgmi = 1;
+		if (adev->asic_type == CHIP_ALDEBARAN) {
+			sub_type_hdr->minimum_bandwidth_mbs =
+					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
+							kdev->kgd, NULL, true);
+			sub_type_hdr->maximum_bandwidth_mbs =
+					sub_type_hdr->minimum_bandwidth_mbs;
+		}
 	} else {
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
 	}
@@ -2033,6 +2040,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
 	sub_type_hdr->proximity_domain_to = proximity_domain_to;
 	sub_type_hdr->num_hops_xgmi =
 		amdgpu_amdkfd_get_xgmi_hops_count(kdev->kgd, peer_kdev->kgd);
+	sub_type_hdr->maximum_bandwidth_mbs =
+		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd, peer_kdev->kgd, false);
+	sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr->maximum_bandwidth_mbs ?
+		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd, NULL, true) : 0;
+
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
