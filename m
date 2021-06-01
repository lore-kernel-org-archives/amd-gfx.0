Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF88C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 16:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DB561375
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 16:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DB561375
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA6089D81;
	Tue,  1 Jun 2021 16:28:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9038289F4F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 16:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yxnj/V9RhM8TIKYxDIzK7yEDJ4KdVQQmLm+ML9TJPfLycAj2P9qSssT9PcjHYEtMrjrU3Ne32eqnWM5vD9NcxfqXCH/wVw/lHTZ/QQ2jCrnNsWVDfrAeOd72dMqs/mb0w3xORpi5hmbcuH4yFs2IXXbuYlU775Z/qiBtvCFqyJ5Dbj+hM6mWZleeGpI2WBZ0iG1YRfype89JZrTeHkUBoxN3lAZ1T6NL80BCXcTwjQvYxrqh8qAXT85MMw3KO6eFCDmDM7zbGRzYmRqkKuasv3gRhppJODUakrMC3R+ywENOwmE+nCIJyQwfPy5gNKXEIdGQsuOASWB2K/Bs/YtYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlPLPHOdoADae8tGHYjIS1rHbjrrUYNofLSxrJe7soE=;
 b=czTo9InCPrR1oUWLI4rDmjwjxSMQjOrWZxEyDh+z4ga899gMsENfMZMiZ7Anx/zwSqXOLESd5g99ZP3WZ3/TnZDSxprpBAIZ9ip68fV935BnIq8bnVX/Q2TKaYMCnE8lVl6J1Cmdjn1+tEhyF7x4gwG7JorBk/QlORy17pji3O/CEOdcDvyGxWnMjIGkkXbrehMhrz2+LOsiHsqxYjRIg/68g2ZjfHR1s2fuim8Z3UW2++Ez0PnKNdC/Lke7bGajbw0rqxP8HrjKeZ90t/0fzgN05x4IYxoVkx9Isgru0+UEDbyGFO78lxvBD6enBzlTIwdNB2oA4F5uRxog+4x2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlPLPHOdoADae8tGHYjIS1rHbjrrUYNofLSxrJe7soE=;
 b=FGVdk4PaP8dVk4Loz33jWrharegKL840ox/rtbGICM+lVR8tTHX2kf7Y1Tbc75szYmpFGSQ85lEJDVcfjdGQduWFDZ2oiTeEWaLR7dzzQdeLk5YxrsWIzHZqm4cjdtAwTCa58IlzXjCC3eVvkiemrzOyzrCn48xK2Q1XRxKq9sQ=
Received: from BN6PR14CA0026.namprd14.prod.outlook.com (2603:10b6:404:13f::12)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 16:28:38 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::5f) by BN6PR14CA0026.outlook.office365.com
 (2603:10b6:404:13f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 16:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 16:28:38 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 1 Jun 2021
 11:28:37 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: soc15 register access through RLC should only
 apply to sriov runtime
Date: Tue, 1 Jun 2021 12:28:25 -0400
Message-ID: <20210601162825.11235-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa2d6a2f-9388-4891-51ae-08d9251a4fa3
X-MS-TrafficTypeDiagnostic: CH2PR12MB4295:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4295C12AEFD358A2B3A622B6F43E9@CH2PR12MB4295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYD1BlKq6meAFwB48/icK3sqlsU5+DkeHr/9AAP7zPJnUoR7y56P9fV5JodVSXCAFdqGkPwyYe/B+NCKKx6ioTATcyUpjDOxZFsP7580iiFeZsGr6mt9YQeJvgPu7wHSDbLUSbHiP7kYNrAwM5fsYn491SAGoeRHja5wwLyK/DPvi8g69GqTnTLRD99ndUliihLcYX0qjo8sEpjHxunxsGBHgb7YOS5pCocjf9UWficSLA2dsdNuewBmXt3V2xwuO7CBJF+l/D1UJCNlar5fheIm+wa3YhahxoShVEJ/eE2UVDnzJ0oA4RzbC1x4lJP76nHhEZ08UFgT6W3laX0TrwCguE1YZ3mAdZoec5Aqs5MZ8rkFPHTB4ufpsg6Nlig4kmiVMHqueLtWZXRNzUe+r1gBkqb/x9HTjSBYIYXtbE5/CwgF9T6YcqJZvcVRI7ZV7kiE5b2RfC7YW+bVIMx5MISGhwmO5eQj5/P44y2v0EouaHbzOVkTaJrz+S4Rn4U5Zyol+cMaApxSHvJut5EA5BORFlTyxmUER7v4YXPrS8Ve+vasrm9ahIQDuKcu+LvTtqEGlkQESw5uay1RufaVuvYlnAJYtvv64cif1q/viuMDLPozkTzIu8YV5n5Po+PQzcArQ8OyA00MqIinKlPmCFimG+nbRz54jUspV5WTkZ1OSso91BtdY03fIm7Gq0tJ9t/Kj6dtb+xROzK/98eXMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(46966006)(82310400003)(82740400003)(26005)(478600001)(4326008)(8936002)(83380400001)(6666004)(70586007)(2906002)(7696005)(2616005)(336012)(8676002)(47076005)(81166007)(1076003)(356005)(36860700001)(86362001)(36756003)(16526019)(186003)(6916009)(70206006)(5660300002)(426003)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 16:28:38.4686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2d6a2f-9388-4891-51ae-08d9251a4fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On SRIOV, driver should only access register through RLC in runtime

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Iecaa52436a2985a18ede9c86cb00cc197a717bd6
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index c781808e4dc3..f6cf70e69cce 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -28,12 +28,12 @@
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 
 #define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
+	((amdgpu_sriov_runtime(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
 	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
 	 WREG32(reg, value))
 
 #define __RREG32_SOC15_RLC__(reg, flag, hwip) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
+	((amdgpu_sriov_runtime(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
 	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
 	 RREG32(reg))
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
