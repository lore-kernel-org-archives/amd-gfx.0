Return-Path: <SRS0=L2kD=ME=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B55C07E99
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 03:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79DB60FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 03:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79DB60FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A48C89BB3;
	Mon, 12 Jul 2021 03:55:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C48889BB3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jul 2021 03:55:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip+nWtJMWgHF6MabkANw3dxBUWdah7TJOrNQskt9lRHPz6SQ8EsofdHbkyRfhtep+xUx8D7x7G34qOTQ5prK/hhdbPyziaJeEIbM97/99xadYTHQsfZpI4h1uwLs1OI+iY6XRyiCF2gKd2E6JzGFeCOLWRgDl65DD2PO0OBuG7qcjTppi2U7PYHa6j5C1WUC4yoShiq8513xyosiQuIq/7DUd5LW5EkmK9a2qSrR0fSwaE2pmdY+Jjdiag4TVyd3SWl7KvQRbor+Vnwpmr6x+C21Q7yWWMPa7FgfJagwtz/GA/lnRvmp+PtZRnn5WLVNOv66o8DdKb1fyh0dXe8FDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCkmkymmT7Ma4DhvDUv4vAib3jcc0R/phi9yKnE1mHk=;
 b=k/YrvFlgJf9MYJ0V/juBZHsy85H6ayhx9u/iztZYTg83d/3Jeyz3d16ePxiVbIlVA7YvyE6qbL7PThvB4ADaD6owbkAMaNfXGJwBD8ektjFxF0XKWCuVr+f2b8FZKlP/9BNCgRjRp1cExQW2vfzEVwZOcDuYjBbVIAGZASXjfAaSXmyJd4/t7oNrZ60hJao/9c4amu11yA9qzJeMNiSiNtuSRdX9lIYxuzGOnJvSASzNgjJLEB/0lFlr+AC6DJDZePaAUh6PjK2vjI7IxVUAJLfzxMe5a/DuBJ6QW6N1V6aPyVATBKSYsHVqOY1FXZANpVEYHllMQXhCLR0o8CFqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCkmkymmT7Ma4DhvDUv4vAib3jcc0R/phi9yKnE1mHk=;
 b=5lJjmYhjcjj/5KLQ4UMP4WcMUKkC0frGObvb5/I+HxGdLegO1LqCxEUZxIRQf7NuXBK7s5KDM/k0SajAa7mPoH3waFMf357qxEvgKK8R7o8fEFUKihRqtHb1iPn2t9M6+Wih+GH/+v4bDuv8ObOClkFA/BI0OvhHH1yLTghRlT8=
Received: from BN6PR21CA0006.namprd21.prod.outlook.com (2603:10b6:404:8e::16)
 by CH2PR12MB3845.namprd12.prod.outlook.com (2603:10b6:610:29::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Mon, 12 Jul
 2021 03:55:41 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::5f) by BN6PR21CA0006.outlook.office365.com
 (2603:10b6:404:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.4 via Frontend
 Transport; Mon, 12 Jul 2021 03:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 03:55:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 11 Jul
 2021 22:55:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 11 Jul
 2021 22:55:40 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sun, 11 Jul 2021 22:55:40 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Recovery vcn instance iterate.
Date: Mon, 12 Jul 2021 11:55:31 +0800
Message-ID: <20210712035531.30714-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d80a7656-c94f-4d69-1219-08d944e8eb0f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3845:
X-Microsoft-Antispam-PRVS: <CH2PR12MB384579CAD5E431E5644328ADF8159@CH2PR12MB3845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKauxFxzvGVPUsp98F/yGw9nG4u/O5FeVjS31GFgQvhr45RvDvP2nFf1JjfraR+buGAFm/cG8S4dlm56+C4AtJcmjJdHHDM1A8CHWu4kirIGeAEBTNTpT5fQKVMfea2Ws58ruEqK3RbA7FtShQHF3XAX+YfvssNLaFSNF73AsHSgKAw/PFA2Jp48mOLa2Qkq3A7HdFv3UiDE+0NxPSWKxt04xS4bj3TOH2HquaJI3YOt5vpUNUqE8oW5Whfcw+1S9Xv6Elc3KDNV6HL0MTV1Z/T58CRUcAOomzgnCvEpI1rORCUlXxFhwLD38yd1MCFIHINJdMANhjsNH3qjarGZzcoaFBHPr24hAOSsJiZm65dcAYowHh0cpDYVaQGbg7iUO1QdbuHOm+zb/H1SXrFM8pBwewghrWkDpGr3iUCHV6/vKFN1IrYZryh+tufxIrkF8zw+vFhQOeD8mPx2GUlJLM12JpL/kqmrO8lmWBgy1RErjLkgSlyqpgmMIiQ2y2OrXycD03SMUEwaHASsDuzilk2CLAUp5KmOF7zn3ke7M14tktx88EJ7GAZe9+wlt3s+IA6B5qocrIggpvf813e5ZNSb/D8viMRpYZoqv4Ca8vS5c4Mru7px0Y/tox3yc/JEiBnZMd8GYi5kjSDyq6C58uKAmv+N3CW81V9ogIcv/zeVxdpqd+w2LwJLUoOb42z0SPWTMcc+9jultdtl6HA/s17SNR0BoQmIeKqXvmJPWaQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36840700001)(46966006)(2616005)(186003)(478600001)(81166007)(8936002)(2906002)(7696005)(47076005)(70586007)(36860700001)(426003)(70206006)(336012)(4326008)(6666004)(36756003)(82310400003)(6916009)(83380400001)(82740400003)(316002)(8676002)(1076003)(26005)(5660300002)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 03:55:41.5841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80a7656-c94f-4d69-1219-08d944e8eb0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3845
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The previous logic is recording the amount of valid vcn instances
to use them on SRIOV, it is a hard task due to the vcn accessment is
based on the index of the vcn instance.

there is a machanism which recording the invalid instance and skipping
the invalid one, re-use this mechanism on SRIOV environment.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c3580de3ea9c..954ab7e76926 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -88,10 +88,10 @@ static int vcn_v3_0_early_init(void *handle)
 	int i;
 
 	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
 		for (i = 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
 			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
-				adev->vcn.num_vcn_inst++;
-		adev->vcn.harvest_config = 0;
+				adev->vcn.harvest_config |= 1 << i;
 		adev->vcn.num_enc_rings = 1;
 
 	} else {
@@ -151,8 +151,7 @@ static int vcn_v3_0_sw_init(void *handle)
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 
-		if ((adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) ||
-		    (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)) {
+		if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
 			adev->firmware.fw_size +=
@@ -322,17 +321,19 @@ static int vcn_v3_0_hw_init(void *handle)
 				continue;
 
 			ring = &adev->vcn.inst[i].ring_dec;
-			ring->wptr = 0;
-			ring->wptr_old = 0;
-			vcn_v3_0_dec_ring_set_wptr(ring);
-			ring->sched.ready = true;
+			if (ring->sched.ready) {
+				ring->wptr = 0;
+				ring->wptr_old = 0;
+				vcn_v3_0_dec_ring_set_wptr(ring);
+			}
 
 			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
 				ring = &adev->vcn.inst[i].ring_enc[j];
-				ring->wptr = 0;
-				ring->wptr_old = 0;
-				vcn_v3_0_enc_ring_set_wptr(ring);
-				ring->sched.ready = true;
+				if (ring->sched.ready) {
+					ring->wptr = 0;
+					ring->wptr_old = 0;
+					vcn_v3_0_enc_ring_set_wptr(ring);
+				}
 			}
 		}
 	} else {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
