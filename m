Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE20C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AD5410E72F;
	Mon, 27 Mar 2023 19:46:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A207610E736
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3DZ+6L/BIg9vhGuHXlVpmrqKLy5CwNxlazsSkwkF1T6RRf0Dbjd+4E/Z+nN9ZL4q2VtvcJHdkxbsBlo/KhooACDGsGDV7jQP4DLXSqmhnZ+mczK3LN9AkkSNUGEB4BgqqS1EOXf/SXUM8/+o+Uz+VYST2AkhTeY9fF68a1rTR049mGjSJ1nAVKFt4QsaEbL67JIRo3AUXjQUy3y69sTZs5kVWPb0J0jp/7u+AEJXmqRR8yT2de8ZCDCTTicxyFl2B9VcNqL4km8KdemNyX+f3yB09vN4FGml+xHsEKeNSPB4UkjfjZKoCFyHO94s7IuGlt84jcrJO0iqu6ratDx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1SbZUxa4ToVFJYWStnk9jFbYsNCiih2ogP3Ow3f3aU=;
 b=nabzXU2NBIq23HbEYfiBDMVfwxjb7O2RzTWxIIYbSFMFjdELDz9La8Mk+NLLYXUwstWgZX35aO10lIn/dhCffxCHTObzT9nxkrWs1yTpn4tIZy/XJdbjHT2vQ3JHDj2wVlr/UB08xlwae28XwdfEFXBepOjDmrXf/b0MgngQ8c/2HVwO1Sfjt04wzLHu7goQtVSBvhs713APKmKaBPzj1EVzM3VpZWrT6RTKuYndjkdrP2USC0DUlyYoQM9mGQ7KwFwrGYRV15EJIlvKboUE6yYFH/vpLmsNsX3VTn8kaXEXX5L+vYin7oENXhLBBldIymm1h9sG9L9EDtjrQvzTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1SbZUxa4ToVFJYWStnk9jFbYsNCiih2ogP3Ow3f3aU=;
 b=gfsSULG3XByes8OVw5D9grC3IR4FEtrfDKlBlwgw/JFBYH0cM2Z/uip5XpwjMgkHmEYxha0dXNfIqF1fJM5Bypl/q84zwjc+BIOZW1wUSZaZhl2nErFPB3W7OzfxuTXgPtOELVgZ1fYcvvjYOI5yQXN4jbpJMaThwTyj+29gwlw=
Received: from DM6PR18CA0003.namprd18.prod.outlook.com (2603:10b6:5:15b::16)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 19:46:41 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::fc) by DM6PR18CA0003.outlook.office365.com
 (2603:10b6:5:15b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 19:46:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:46:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/11] drm/amdgpu/jpeg: enable jpeg pg for VCN4_0_3
Date: Mon, 27 Mar 2023 15:46:17 -0400
Message-ID: <20230327194622.8109-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327194622.8109-1-alexander.deucher@amd.com>
References: <20230327194622.8109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c12eb76-2043-489a-9e57-08db2efbfcc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JzuYgLTmicateHk11EkNnK1LfZG+MN52uDIUq2iArRLo3DL97O13ELPsRLVpl+2tKNfziPCAr5QZDYLzDvbAQJYG+6haQKBIneORMMNMGFDM3My/sj24yoM93bSd1hJSz4vJH4NDumg5Whb6+o0lpuAhH4sTPqvbNRivU2mUS7aJ5wo6mpCC+mtGuLi/w4FzrLCwfOErQpE+bC/+gyap5DqXlY4MCxJ3jHlSHFZReq2WFnq0ct5533fQSGcXENmCH5htf4vfKm4ROwV+B82wAQ9xRix0cndrpS4NU3rovAZ5cgxpZhITxQLbTdR9OKc2V1GSPIfFPjd9IY5UjZIlZAUNN53YPJZdgvwLDB/vk58totbCO/uPQEVMmc7Gg1dZ9QonhroNFQqWkWtM5d9FccbUyZ6CbyV8gIewi8NswqgcHNk2wbGP3KapOKg/B6NOG1Tt9BvdJRGLuoPGb9J+wSZgmFUPq2W9cE7zioVPpLFGWTYxCRs0rRz0otw2fNjIHWYLGYSurOuRiruKMkvDW5JvS53dXt5Xv4r0CUddXbcdoYYKuIM/v8cFEQga17KkBU+4o3AazA7aM9a65YQijE/iNsTyr2Ku4wWB5jRJQ9m26aoMdeyn2Zb0X/thKQU9FsROv5FjHFr0ltLrMq2XLwWJ9u8DC3hOhLhEkz6rY6yk732nFA0R5XkTq75iwwKVha7AMAYZCemJ2gsD2n0x87uYrbr7UAbUnrJbZqBXRM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(47076005)(83380400001)(336012)(426003)(41300700001)(36860700001)(36756003)(86362001)(5660300002)(356005)(8936002)(81166007)(82740400003)(40460700003)(54906003)(7696005)(478600001)(70586007)(8676002)(4326008)(6916009)(70206006)(2906002)(40480700001)(82310400005)(4744005)(6666004)(16526019)(1076003)(316002)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:46:41.3948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c12eb76-2043-489a-9e57-08db2efbfcc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable jpeg pg for VCN4_0_3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index b120c2624f1c..6e66808b1f26 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1105,7 +1105,8 @@ static int soc15_common_early_init(void *handle)
 		adev->asic_funcs = &vega20_asic_funcs;
 		adev->cg_flags =
 			AMD_CG_SUPPORT_JPEG_MGCG;
-		adev->pg_flags = 0;
+		adev->pg_flags =
+			AMD_PG_SUPPORT_JPEG;
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.39.2

