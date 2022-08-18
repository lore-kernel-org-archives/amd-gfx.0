Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741D2C00140
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Aug 2022 18:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0C610E80F;
	Thu, 18 Aug 2022 18:20:48 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F1D10E721
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 18:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvQKdZdPUlK+NCq0X3WOU2u2RInZi9zIlMdoVfS4+Hn37B38v2jaDhF68r2019rbP3jVvLhNtEurHXHHvAsHeFTfwVUjjB3/klQedFCunoRO90YSgDHqH/rTi7a/zp/KpLT5xSM7bfeJDMAb5nJeC5wpT0r2HKVkWLY4G+6IhPdLtp5H2RpNz+QTh+26NcCwGCeh4d4N0rm0S9Du4Xa7XcMR2eGTn1w6gmTb4S0gzqixZwLx3XGuVy7lsX4XISVxF95z3xpq7Xhd/agXQu7LOt/3hdji7l8q1WT46AcGunyMBXn4NKLtdMgzxgTrLF7pwnnyizWk3bdaMLyGFjQGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H23JqJ1q/QPa3gqLUJBY7tbz82XzMdGhYH0MFfQ9U04=;
 b=CO+IWKXFL5G9CdQOzfCOzr3jaP9fqfyocA/kfuOCXf2YXy/mrkU5ornX2etZ3LH53V0RS/BN7eZQq9QyCFVne8F01jwilz1G+fbt1eflhWmkHKQrWqodfbqGuvfRMPB0CsF7uNua1Vt6rW/SWqh6i7xsaIGRVnqKpx12Yl1pPR9X7MkW3WbZb1tCgJ6iyCQKhB8Hu3mebimxuliMSr8NP1EEcvn9vBtB2iKGPTKymivkXBIOrgzCYM+hvWHo6py+gY3OD9gnMK1GByw9MoC+NohEu4glK2xfWa1Z/wj1SYyGTjPXhKbbiG2eeOiw9YaM+346TBNGNdTgvf6hnLbCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H23JqJ1q/QPa3gqLUJBY7tbz82XzMdGhYH0MFfQ9U04=;
 b=nHMokNLLn4Ovi0cff6HYABrsePBP5mNi2TIpA8TFqd9jqAchQcZUVXRR8byGZI7lsaY6F0O3Oin3dkqFGi/80EJSTfEEkqES1nr4XEow5dNa/MG/LW+jQocI0/VYdWho0JrMEpSMTlV1UaBZfMrc6itBK3G6l/5USamFanCZSw8=
Received: from DS7PR03CA0170.namprd03.prod.outlook.com (2603:10b6:5:3b2::25)
 by SN6PR12MB4624.namprd12.prod.outlook.com (2603:10b6:805:eb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 18:20:37 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::4e) by DS7PR03CA0170.outlook.office365.com
 (2603:10b6:5:3b2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Thu, 18 Aug 2022 18:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Thu, 18 Aug 2022 18:20:36 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 18 Aug
 2022 13:20:35 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove the additional kfd pre reset call for sriov
Date: Thu, 18 Aug 2022 14:19:55 -0400
Message-ID: <20220818181955.11762-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19a01a0a-b115-4156-d831-08da81465934
X-MS-TrafficTypeDiagnostic: SN6PR12MB4624:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xv6vCpoTOGV9s9z/pVpB2JR039k7m28SjkONSaQKHL23nyO2pSguVikVFz1O44vxDNwZAYWpid2lXm4vN2MKxrM+Isd6okTLTdFWsRMmeRZPBcwl/xqsXXHz5pmBubL1NPzuyBXEmU3GrQIaXJAoyBBnOp/jnSL15bRpjbSLpjtrB/47VX/FWZq0fvYjA46QuGvPXlsvb1Y9YzUti37bjCWt3c5YEVTYrtKpkAozyjY+UX7oTH7IQg3ssCmYC7qJA6+4smTvRpLkHAaqAR/NuL1QIe3/g4BCzKd4mVcu7/9PDn+u+vPX2AYPWLNle4+NcF87C4XRh9k/KXlbD5O9L3951nJHMUvmXBkVTrR7p8GB5x7T2zBfthes2BDbiSpPaWw2QuXuZxSnPQNplkDx0qb3PSiwo2m2MBB3IbTYRsC3/6YLzRHF8+ajOwOIYJePV1qVm1Fdcu2pJ9Jsw/AxOEPcH9FomvmafoTesYcfd56teAl9iluCCBTQFFdf5QXriywPGjxXCdPccedRz7lLiXDqp50maR6Zq3TRFDYcu+jtawOYjS7cfj85BFAjj4e3ebhiOo1vqE7hCWKHHez+je2QO/MSL2NgJMD9iypbIUhgw4ncjEIvrwvqrygE0Vy/2IZQnE2q4xnagSS/OfZkv8JT7dnXlRd3AyP2PbhKuNakj5LgcQnzJEMT+9wkCBPZLdM2hGpcwajoGtF8EauQlp55ZYWR6IBe34wKfL/4cJRO5TggVRSb0wo8eDhs+Ny/rLPTRK8NSSeACGprvPVjl8/OxXC8i4G/IzDWFo0+8YpoqBTbZ8p9QZAzCNeCawcvrrK5bKTi+Ps9Q9DCTPqwkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(40470700004)(5660300002)(36756003)(4744005)(478600001)(40460700003)(40480700001)(356005)(316002)(6916009)(41300700001)(6666004)(2906002)(70586007)(4326008)(70206006)(8676002)(8936002)(1076003)(82740400003)(336012)(186003)(86362001)(2616005)(7696005)(26005)(16526019)(426003)(81166007)(47076005)(83380400001)(82310400005)(36860700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 18:20:36.9425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a01a0a-b115-4156-d831-08da81465934
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4624
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The additional call is caused by merge conflict

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4cd87dbb108c..d7eb23b8d692 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4417,8 +4417,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 retry:
 	amdgpu_amdkfd_pre_reset(adev);
 
-	amdgpu_amdkfd_pre_reset(adev);
-
 	if (from_hypervisor)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	else
-- 
2.17.1

