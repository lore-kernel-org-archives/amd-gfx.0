Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9731EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 15:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1E461101
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 15:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C1E461101
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F756E8A9;
	Thu,  9 Sep 2021 15:59:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45CBA6E8A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 15:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dspefERdogNOI+px5cVT1Iy870gWK00mXlgOZInZGlb9FfSuIedKvXkyvGl0W/MVq6zE+Eju9SvwCaT97UOs0u0hFiXSH1EeRar6p1VlXarNuXq+4xsxlBL6cmiErsbdEANDodOAqgnZa1ZbTWA/HU3EVMEj7JruFzW3+CtWSafo/P/X2pOoRBAC9rTe3rx9aZbgOE+DGAWzhh4k/OtUhbMfQ3mILwFfToBfz/e91jGPeDf/jaZSHE+b91fBRSjNCkpSkqxxLX5TgG7vFl38VlWgXXSzjNbrcXhL1oBKPqBvO7fv5WtRoA7hV6Jg30ivpBVX1jN0oy36FlmZmMKatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=YRdnsoqPynNI518LL1IPnblle4nHT3P/Acg9XWuku6Q=;
 b=KUyG8oAyTo0iYCUUfCBHBNRQJnP7aRpmwCNaONrrYtXuQgoLoQ0yYpqB19ESl9+OUwWXuQAG8oPNTLoYHAuwMrEHgFkVlCrlgst3l/LwGYbLLGYqqmSapP0GO1tkPLB8rMrXIBsQP/lNhu8VliQIuoPphjkAbmLrhmc88zrxSCERTxVhOw6cpLhh72ousO5gN/edSiwBVQ2UG0XY6b8DTMNabtzjHPcI17VMVYuo9bus5Ru4TJnxtAmGCYlucPgy2ITnGZpGoCMiKGamR2RLBDvxGrMGWkL/tpV7nIq+7ystwJX8uReoPl/TWFv0PqfHV9+dQ/6FhV5r8Uttz8VvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRdnsoqPynNI518LL1IPnblle4nHT3P/Acg9XWuku6Q=;
 b=wJjuNwiThik8SB471LGVxudxPKvvlvhiBICjAtcp+rNBh7ggH/Tqs7oruF3naDjWfJLwo02Ys7kbgOKtMJuxYJchvhhz4BjqgSKQV2XqCcvfLggHIRApaCI3l24lu5psjcZCXAMTvPHSTnEUr94LMby7tHwt3oKbg13tP1qU/lk=
Received: from DM5PR16CA0035.namprd16.prod.outlook.com (2603:10b6:4:15::21) by
 DM6PR12MB3786.namprd12.prod.outlook.com (2603:10b6:5:14a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Thu, 9 Sep 2021 15:59:21 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::7a) by DM5PR16CA0035.outlook.office365.com
 (2603:10b6:4:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 15:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 15:59:21 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 10:59:19 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu:  Get atomicOps info from Host for sriov setup
Date: Thu, 9 Sep 2021 11:59:06 -0400
Message-ID: <20210909155906.16026-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb54682d-c7ff-4c20-cf3b-08d973aac9c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3786:
X-Microsoft-Antispam-PRVS: <DM6PR12MB378613A84F0FCD6F085FBD1BF4D59@DM6PR12MB3786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zFp9SFHBfrM4igJz93OHW1GAeCqcyc2qG1KcjuT4QiXURtINV9LDL63hBK5x8nCq9ot3TLlcoRAZ5oSQesNEA8P/smAnDdYpO6YZNIc7JGo8Bz+zoB1DR/p0L/jH99cMESmUDiVJHYsa3ZztnSodUdtYAzPlWMc7FsmRo2NC/XxYXJB98QETecMxXsKjbvpXRUUqlLJ1eTFSf4/p+adRw5jIjF7FDrB3Q2cJKMbHn3BD6fyz++cuJK/WhkL/itXLr8tHYHvJ7GU54GHkCt2XUsgAU0zNcp1Y/KIshxiZyIP3Ay+QeqDxGnfvZNM7xN43cwslWkptTHo6CF5J5kRqFHyGm1EvnuUkr3hqmoVeZpKWA7fOw71r4hBHqTUsMoc9kNjYYvkPUIZpak71hfrPzEEGm+39ZFVoHLjAbYknTfTI3KaOg9YjzfzlMrON9WnJMKoDp7gcnGGvxBnR4vWXRzvkVuU9zZKpc2xX5QMfZmEFa+xaOGvTiFFpz0fGVyeCq5J0AWhsXubhxS1oW0OYNDvlk59Gk/7jHr8Z4uVhAlJYU2YDho5JJxY9Ol71eMRrezuhkY5s5DCY4Jv2E0AB+oYJUCdTuZv/CqqW+lxLgRQoY4jxYS01zOu+R2v9U4h9sDgPA9NT7K3JueLoNN4WBq9RSWtNiwHv2Clfsq3mVCud53LV/fumUsfjkBjs/B6uptT7XhWF80TFYSuwNql12meekvAWMmX4kZzBh3kDxhan8ZaWENZuEsSBqwG5JMmEuCX4sojDxS4OrNXbQTHww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(8936002)(336012)(6666004)(508600001)(36860700001)(26005)(70586007)(82310400003)(36756003)(70206006)(426003)(4326008)(2906002)(7696005)(6916009)(83380400001)(47076005)(2616005)(16526019)(186003)(86362001)(356005)(1076003)(5660300002)(8676002)(81166007)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 15:59:21.5332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb54682d-c7ff-4c20-cf3b-08d973aac9c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3786
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The AtomicOp Requester Enable bit is reserved in VFs and the PF value applies to all
associated VFs. so guest driver can not directly enable the atomicOps for VF, it
depends on PF to enable it. In current design, amdgpu driver  will get the enabled
atomicOps bits through private pf2vf data

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ifdbcb4396d64e3f3cbf6bcbf7ab9c7b2cb061052
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +++-
 2 files changed, 21 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
old mode 100644
new mode 100755
index 653bd8fdaa33..a0d2b9eb84fc
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2167,8 +2167,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	amdgpu_amdkfd_device_probe(adev);
-
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
 	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
@@ -3562,6 +3560,24 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	/* enable PCIE atomic ops */
+	if (amdgpu_sriov_bios(adev))
+		adev->have_atomics_support = (((struct amd_sriov_msg_pf2vf_info *)
+			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags ==
+			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64))
+			? TRUE : FALSE;
+	else
+		adev->have_atomics_support =
+			pci_enable_atomic_ops_to_root(adev->pdev,
+					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+					  PCI_EXP_DEVCAP2_ATOMIC_COMP64)
+			? FALSE : TRUE;
+	if (adev->have_atomics_support = false )
+		DRM_INFO("PCIE atomic ops is not supported\n");
+
+	amdgpu_amdkfd_device_probe(adev);
+
+
 	/* doorbell bar mapping and doorbell index init*/
 	amdgpu_device_doorbell_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
old mode 100644
new mode 100755
index a434c71fde8e..995899191288
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -204,8 +204,10 @@ struct amd_sriov_msg_pf2vf_info {
 	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
 	/* UUID info */
 	struct amd_sriov_msg_uuid_info uuid_info;
+	/* pcie atomic Ops info */
+	uint32_t pcie_atomic_ops_enabled_flags;
 	/* reserved */
-	uint32_t reserved[256 - 47];
+	uint32_t reserved[256 - 48];
 };
 
 struct amd_sriov_msg_vf2pf_info_header {
-- 
2.17.1

