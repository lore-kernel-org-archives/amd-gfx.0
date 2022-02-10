Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A18C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 06:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50CD110E513;
	Thu, 10 Feb 2022 06:40:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8E210E513
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 06:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCUqo/ei0xQjfNtCMh4gn4eEN/agIhlfgpkvJO+ZW9mA6CkKVGm9F2LzYKHHERupDbYgmQdzZXMqmSjLuj6YadUlejguRQr68j/egS+xW8NzXa8uj93RKKKuFeN515HQZQZ77J3vVhAvZpSt3mAwj0Q9Qr/EaL7NNf9oXFBrxcBxOfu2mbbzFUmfl4A5llFQWct/ZnBj3MWkH5NkLZxOrj+PxA5RlWpqbYqscnKcuuuSuLgzybxYv+A0P3IoH6Xu9xo9LBdBfKm/7WWz6xmeNTTl5VMN7zQFblZJynPChtw/wmUFpinJlhnNPP7d39LoppuwC36hubfEwoSMrOgnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuhqUsnZ+vSAqfPwR2vul5gUZ8rtKqF5kouRXeKB2pE=;
 b=j2sHDutCVhG6vxCamUHxp6lawn/It6Fe6TVR0BxtvVfXWLm3IoSRZ+iEATL1IwaMbYVU6wbdi1n4m4LrJLmBylWXEJmMLu6E27/0ThU549fnZGgGZF06mH4Pk74QC6+YiBAZtxa1J3ydWqyrHN/ZXAXQLThsuEDpjev+AGZWkx7d1eaPuE36yZDXJxHqOT7Ik7nkr8hAg//pbT0hTEW5qB5jUUY7MqNk8RiAEcfkZptBhOp7vhgZvMD1Z6zFwxq50Qy6u1U2bx3vMtubEEzG+QAXIB11HqDxVUVjEC0F0BOpWraE3qjukA6kZQevK+HTnprqYruN07Qi6TanDZPFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuhqUsnZ+vSAqfPwR2vul5gUZ8rtKqF5kouRXeKB2pE=;
 b=HYPhyWe33x2n5SPB87F9Qm7evuCyzdgFSl8b1wXcEW5qFtRQILBBy72WbrUks6uOEGWz18oB/hrt2yZdxK+O9F7uEnZvHfa9OI+rPFiqP0YNV9YwTAQR9vu9Hj2DzP54/9dLYcccXc4ACGxfLnQm51Wg0NP/pMChvIUn0v4DStM=
Received: from DM5PR22CA0009.namprd22.prod.outlook.com (2603:10b6:3:101::19)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 10 Feb
 2022 06:40:54 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::28) by DM5PR22CA0009.outlook.office365.com
 (2603:10b6:3:101::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 06:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 06:40:54 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Feb 2022 00:40:51 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <pengju.zhou@amd.com>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: no rlcg read access in SRIOV case for gfx v9
Date: Thu, 10 Feb 2022 14:40:29 +0800
Message-ID: <20220210064029.16545-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddc6a7e1-b7aa-4405-4f53-08d9ec604971
X-MS-TrafficTypeDiagnostic: BY5PR12MB4259:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB42591036CE02F3D39B812EC8F12F9@BY5PR12MB4259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kI5wS7YHe1FukZg4g+iK8xmeGFKeM+0LRO+UGUX5aEThtS5i/s3jwXbM4UWI5YYtBV4BuLyhYajoVevQ/+VTTII92w7cOJUP2mNToiElUNpnETpQfQIx+/rdPoklCQkR7eW2+Nnuy2MZjIsq2FKXUBBX5vDwdq/Edp+ne7Ng5Y6Pa8dMTep7rEDLBLcY/hl7CY/hEy6X4O/XgoEbiOBnSuzozsNyE7sz21VQfxLYYT383XZQ15FdZV146NrQK4dWU5ezeoKxPUDVYGy8SaEbJvc4Gh3z2fYNgtct7a+RX8ncw2uCwZGDIECdOcEE2clJ573KTAaV+S/LdQYUdXpl9fijXz3xoVjpNnQ1XbfnHX7He7rFVS6LQgbch0N8QcImrxMyi562RPXEP0fTLzlhAcjhu3Jgc/8uTcfuVaBdT4OIpjfMhJI157+CFoBvZ5QtEkXU3snT5b5yucSHLsJNuDKuJyCMRSII2JrcJRt/zrU0Tilu/1rSKo/B9cgCBOKqH3Vj2F5mhbjV+N6dDQ6Z/E5Zf2RFI3hbeTd2GfL7NJkCMTPynCmfsr2mL00s0l57ynzH6v2Aswhd2WfND4freMDwtQGIc/gFqZKzwKMmupmv6jUua1iv3IREjG7iT96K1Z86KbajechODZ3Nu4xf4RJLMxuh3qz0IAI6WPZg/OhsY3PRgy9mSb/98s9ag36oEXzMEFv3wPA80RMrnzjbqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(316002)(6666004)(70206006)(8936002)(8676002)(70586007)(7696005)(36756003)(6636002)(82310400004)(508600001)(44832011)(26005)(81166007)(5660300002)(83380400001)(16526019)(4326008)(1076003)(426003)(336012)(186003)(356005)(110136005)(36860700001)(2616005)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:40:54.1720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc6a7e1-b7aa-4405-4f53-08d9ec604971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fall back to MMIO to read registers as rlcg read is not
available for gfx v9 in SRIOV configration. Otherwise,
gmc_v9_0_flush_gpu_tlb will always complain timeout and
finally breaks driver load.

Fixes: 0dc4a7e75581("drm/amdgpu: switch to get_rlcg_reg_access_flag for gfx9")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index e1288901beb6..a3274fa1c7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -37,6 +37,16 @@
 		vf2pf_info->ucode_info[ucode].version = ver; \
 	} while (0)
 
+static bool amdgpu_virt_is_rlcg_read_supported(struct amdgpu_device *adev)
+{
+	/* rlcg read is not support in SRIOV with gfx v9 */
+	if ((adev->ip_versions[MP0_HWIP][0] == IP_VERSION(9, 0, 0)) ||
+		(adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1)))
+		return false;
+
+	return true;
+}
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 {
 	/* By now all MMIO pages except mailbox are blocked */
@@ -957,7 +967,8 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	u32 rlcg_flag;
 
 	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
+		amdgpu_virt_is_rlcg_read_supported(adev) &&
+		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
 		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);
 
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
-- 
2.17.1

