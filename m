Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A01ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 04:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD1710E828;
	Wed, 21 Sep 2022 04:57:00 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A3410E822
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 04:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFqVPlLCdea/OKTi0pMiecz32wmXStHo0giMcFaqDsym8MdhseRiQ1L9KNJ7B+7EjrjhgjQtad8P+Ic2X/Rw9mcLAw4Vn6h4LEI8+QcgLkbmD9pDtivQR4nwUc1xctpRjfCBMsTVhLpE21nInS+B2c28lUS/VJ+ReVQEH4OZZ9p5s2VVvkSWQKV1nX07E2CadzhjAuYk6/UzfnquwVn/7jVJCu56j+g80pdmmyRz0JuCLqzRfNf3CLsZ8QcGXgq1rEYb7IDXi6lOEg0u3nuxBzGLmXA8k1IDzPRrOs0UUNmdm8vN7KoTzT2q67zBaBx2s7bxWJW62mIg3C73/SCTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cguE9BEmo6NKkFw28JrBs4JOLp7xKzplvsAiGOrtHkU=;
 b=ladGw0s51AzGyLs67iUGYVsUq48M2wQzEDsuimbh6QmMA5ZmzVaF5sK8UDktyFuBjivaEBVMATXrkLu4QliDe8KB/5B/CZFHJlLDg1pPemNAgFBaZlOtQzqVVGMddcy+J5y7AsUeMMvxoXTO+UuMpZWUHGA7VVIAEbnzT1Lv7vRpFywi9qkY+MnIgJG7XQL+NSe+YRFiiOt5FuqoOWkJ3IOoprGlm2a5zoYhu71rZb4zn2UbbzTWBQVe8VLBGZOaBZueevsmdpDqkoHg8pI7wyz8QXeUIUiD8IjjFaEiaj63CoLVXeDPKb/jq0GWZqOWFo7rwl6+Pz3MfTZvRxfaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cguE9BEmo6NKkFw28JrBs4JOLp7xKzplvsAiGOrtHkU=;
 b=Qk2GlSB5NzgWfRD7l4sNw/UWCvyDTvVwoQJZoP5wYwNG43ABLVTz1PKdU0Z7G0e4MSF3TV6ihyb6Xdq4s58tXqSVLxo0BgU9FIhkJurH/5nQ3iV0fqXxcy/8/J1yr+t1JxoWf/vJrkZmIYRgKmtKOneqpx6eS48hhPkHjrBMnWA=
Received: from MW4PR04CA0375.namprd04.prod.outlook.com (2603:10b6:303:81::20)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 04:56:46 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::56) by MW4PR04CA0375.outlook.office365.com
 (2603:10b6:303:81::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Wed, 21 Sep 2022 04:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 04:56:45 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 23:56:43 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: avoid gfx register accessing during gfxoff
Date: Wed, 21 Sep 2022 12:56:21 +0800
Message-ID: <20220921045623.43401-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 5431aa2a-85a8-4c88-52ec-08da9b8daf11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDYEHdLNOIAp9C1OjaDyPTRuhlCieF3hR3nRPztFnY4zYVZiB5E2EjNC/rsU+cYM+NgWKSVug8QWzoDV4yWpuvh9SRcR+qE8tFTD9XeVPnHleXxuo3mN7FR7t0bgUXjxt/TxEfNVTmMIKnOtf+up8agRvesEHYjSQhWdmkey+wq2Sg0AiHC4xDS60MdfyyF7jTHDSMSaqbz+dle+bdEK9e9oQ0cFz56Xn9RjYFl2l5p82kgqqF8P38DrkA3q3AZdWF25wOo1XMITe/LY6ehrL7I525oMx4mbhDFKTenLbuFXaByIq2NjZpLAhGMxWzB8HlduvU2R5zYgDOt1V1EsWAoqmqsY6kYz3DLTAgYXczrwkwhlFfIyDFjG0gkLLVNdrA3QSp7UuObAY7hzFpzP2wqb7DaQlMKBEizoPAgaUgjKnfoaceySQfaXe6laRhOJxwybMqhIxArFLleI+/IIWCoigXOB91URJ/Zq2iiiewKytHnnSRm3wN53ctzqPioZSpkh+eFlEEslzdNfQH6riG5AC2hLPutGG/sM8S00DUZ76YEz6VDtelqEe3g1SzUwMEmn1U3JzA3IzIRmzgIcwte/1Fi+SmhwNGd19E2Hzd7eg/FsKx+gW/iPCVnB1ALWUYxf/ivjW0xdYEA/ys+7EtyFqAMD6D1WPwr9TJ8jhF9rlKTKU6h+TigrT2d7LKgQaV1VDKsOuyn9s6/5aKW0LPWvB8AtMjXWAraVGYRiuGxX8cCN04bbLi/6VygEMmhKRxWPs59I7QKdnu3g/3sYIw0r9Fwsa7bb6RZaTQEPn0s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(40460700003)(81166007)(356005)(2906002)(478600001)(6916009)(8676002)(8936002)(70586007)(70206006)(4326008)(44832011)(54906003)(316002)(5660300002)(36756003)(47076005)(82740400003)(36860700001)(26005)(40480700001)(6666004)(41300700001)(7696005)(426003)(83380400001)(336012)(82310400005)(2616005)(1076003)(16526019)(186003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 04:56:45.4313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5431aa2a-85a8-4c88-52ec-08da9b8daf11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure gfxoff is disabled before gfx register accessing.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia032869080f51cdefc6e6bad4f04405193ab0fec
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ce8c792cef1a..710074682279 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5245,6 +5245,8 @@ static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 {
 	u32 reg, data;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
@@ -5258,6 +5260,8 @@ static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 		WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
 	else
 		WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
+
+	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 static const struct amdgpu_rlc_funcs gfx_v11_0_rlc_funcs = {
-- 
2.34.1

