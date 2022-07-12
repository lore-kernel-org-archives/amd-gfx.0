Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EE9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 13:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFA53913D3;
	Tue, 12 Jul 2022 13:25:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B001794678
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 13:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZO2lE3Iwiv2X3c5AK33Vpw4k9ngbfozhEmXZr4yGoATf8rWQURLnU0NEXHkqZBZBP/rtaqQeb2DrMHZvL5Q+sT6IjBdrqV99WhuPfl1iP2VRIEDOBWcF1C5dSsN96lEqisMnGR7/nUH3AIXzJsO4/UQxD/wW4N3buJCQnen1Mxdwwsy7VyL1RKht7lSz+5Ib6c3RoO5Ban05/g28nmx35oVST1hWdQvUiXxDldO4/FwssSnHyTt7ua1+JE2ryhdkjLRqwUiJ+Y/R1lXdBjqwkfNNwm6oq3XK9ziYadlEVnWWzDx6+edxxICkaJhcGYefkS2OABnRrzMm3XaDww3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9akqSCAFKciFHN/9QmfMgLc5T+DOOS20NmKkShzaho=;
 b=ec42xmwLRkbjSy7e+ZvTfVe6Iy96BVhrm23yzpCFbTWBpCCnHwIOl8+aOlW9Dsxf11dLoa/eRjCSTOHFsteIwl2f4ajdbfqVppfT0JAw2lVCIAN4ct1i2SDSBUGDApTdkq7fBfRsNzmczO78xmvEgeH4qB+M0sMxjgFp4LTdWTGf56FRJrvurcKDSVjg8mPnxtJlvDz0J45zagUG0grkWxKLQrE1Gqir796vDCspUB0MSCCDaeFmxR8sNGffqeIcdo0PWEuNvTRErpKKnpecdeEtvfrPnNHe0Gx3Rl8jEV7HCLCRSVgEwS8Hy10JWXQO12ETScf8BcNo4V4QREr8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9akqSCAFKciFHN/9QmfMgLc5T+DOOS20NmKkShzaho=;
 b=pqortql5Uv2qse2OmjzvQH8Fk520ZYi/fbF51QcraVpQCdFzpSwxBm19/+0olczw+0ZoedjMKfG7ZFkvwKyxfx1mWjTzgruRbcKvn7VxXPPOBciNXMiXwF9gZF3C3WylMTnqAFp2ykv29r5QPH8fw5TYqii15rZ9ZxOJcsPZZYs=
Received: from BN9PR03CA0771.namprd03.prod.outlook.com (2603:10b6:408:13a::26)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 13:25:08 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::43) by BN9PR03CA0771.outlook.office365.com
 (2603:10b6:408:13a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Tue, 12 Jul 2022 13:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.16 via Frontend Transport; Tue, 12 Jul 2022 13:25:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 08:25:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix file permissions on some files
Date: Tue, 12 Jul 2022 09:24:55 -0400
Message-ID: <20220712132455.2197338-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be071057-8fb3-4ceb-8bf2-08da6409f0e2
X-MS-TrafficTypeDiagnostic: IA1PR12MB6484:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJJdMVXKA9TGaYtjCl0bYav/nnQlw9m05uIz8wlF67866Us3En78H6Jyi8vWzPQ+B/0OEvUDG3aKeWqUJbcpzchP42DpGkRZ9QsNVHWTRlQJAdbzy0Ibep8tJZjEuQXCKhT5nVERVm940O9Zgapqk0Nnj5I0zt2/O6fzaBe05R7CJaHI46/3/GvyisK3LWe3s9bHpLDpKBlHo3LMFIUcLdVqqFMhJUCEwOb51wdHF65vJdfQoMoCHAu5kjjBsC3/GykATk0gRf7PEQi2oWK5pf+BvJG768KhGvKuk1cRd8uXRqZI146vWFAkbaJ9itrpeibBVmyuqgP76Ua+Nlf+uBn+EKZeQXgsJDqDJ5oXOawTrsHO+TSZ+XK0eHb1nEjnToYZWXzuD5qGo48OdqC5y2oRJbVZx76+GZleV3Y4o5DDHxlDh3O8IwSs1MRxg00gkui3o6BTQhWgNq6XeJ0Fk9v6KJ9XevEWAicSRYO4eGIKqsrFaMrD/rm2CWMJa4/Slc3Sf4aTyxdMksGFM5HAopAdls3bQPYP7Q3kpz9+kJp6O0hfofSK92s/URLSaQbvnkuQTulGd+up4JO353j18kzRYa2uxPjwk5gdrr8klil1XrrRMz5wwQX15MwdwiLmIMuV2XfTrb1ONMcLEX76T/80IByYjdD9l7yC6vcfTNy2rvm4hSEyQqZgBicmsBuKvO3V/GymDVUIa4IyfNBlG7WogivCYaUTrpuLuNIicaKmk5kAMiPwAGHUxrkV3zC+cUaXSijXUxPug4wHM6EfCLnBIxbQ7JEBdAQFqouECw0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(40470700004)(2906002)(336012)(7696005)(16526019)(40460700003)(966005)(82740400003)(426003)(40480700001)(82310400005)(356005)(47076005)(36756003)(83380400001)(186003)(36860700001)(478600001)(1076003)(70206006)(86362001)(5660300002)(316002)(8936002)(8676002)(4326008)(6916009)(26005)(70586007)(6666004)(81166007)(2616005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 13:25:08.4583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be071057-8fb3-4ceb-8bf2-08da6409f0e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop execute.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2085
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h   | 0
 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h  | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h    | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h   | 0
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h  | 0
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h | 0
 6 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h
old mode 100755
new mode 100644
-- 
2.35.3

