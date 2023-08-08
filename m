Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BF9C001DB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 19:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F0D10E3EF;
	Tue,  8 Aug 2023 19:32:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D0710E0F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 19:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6Oucw324NmaxDpIZBo6xKzqTGcqhJ+P0a1ndNR5v0M/35AAqJWFliYrhb/jh5qf9LTG2mHR3x70iusT5orhBadwzMULqxJQcCzNJbXnpFnqVhxwjL4mI9s+mt9RFkchayfMSZahwN8KN3f3QZIYwLGyq4c/zFotZMyV4tt2uNNy0zpzFD1eh7miXi4GdqOU2vmz5rN3ruOHJ5n/81OG+A/KxFBn7ZhQ8R5thnLlsxi+dV0LFA+ehMr3cfwuvIOPjrOsQB0u9OmSRXpFMlMdfYtPZHeW3McO5cmnSWD5msv4fADBevV5AJ4J4uuiTr74Ww3x3E52PMJ/eo+Epb+Ktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TL/geO64fRNIGJnmJoxE+2w+eJHajUwphWcMJ8HOuQs=;
 b=Hye7lcjZ/d8HfjJm5uuEi4LWU6D8OVooymLIYeAfIsJvrZhmMGLwe/7XoVlkLWShVLJYg4VsKSOA0REvGuV6EuqcDLBNODy9G5yYLD6a8pz2QDYYSYEmnrvuYeUlv51UjKJxmJmn0XrpL7bqotv/rHRT4wJ73midTB8x7n56hcrE2qfB4m+Z66kfZCocFrGJcP47zO4PiMauaEXjPEc9wke2G29l74/bFQXLQ3v7vLaV62M/r2o2zqqezCZEXeWbOMBIWOwpemy6Fjz5/EdApqWZ3oB69uqzc1GnnKoZOmdpki/bgck7CaRBjaRdrpzIwBvHHWQGkaJVmsTVSq0f8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL/geO64fRNIGJnmJoxE+2w+eJHajUwphWcMJ8HOuQs=;
 b=Owzz1RzLAAi1Ji7JaTh6Pz1Gdcxmgy7lDrC3s6yExaRtPwNQG2z+UsbS6lfQOB8NAnpxSaHl0lS5nt0GkG41joSxT5qy/q6fTqgPKQC6Gt/sngk+e5hlpGlS1mCe3QPAd4i2w15Y/sVptPdJB3iXJ3tVBMUX1vK1J9Woj9rMaac=
Received: from SJ0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:a03:333::7)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Tue, 8 Aug 2023 19:32:14 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::1d) by SJ0PR03CA0092.outlook.office365.com
 (2603:10b6:a03:333::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 19:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 19:32:13 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 14:32:12 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Add flag to enable indirect RLCG access for
 gfx v9.4.3
Date: Tue, 8 Aug 2023 15:31:49 -0400
Message-ID: <20230808193149.34505-3-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808193149.34505-1-victorchengchi.lu@amd.com>
References: <20230808193149.34505-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 232f0286-624f-4ec5-540a-08db98462a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNelZnTN0pUDitLS9pwbaSnlvj2GhrEX5EvyHY8T3jSqWcyw5Mtrb55jbz7Ch4hPQQLRbjOKbbYwIjJ3axP9c0Nv2C6fpdK2PNE8KfsG516+c1HsxL9Lj9xVQWsa8Iwy5+4bS66XNIpbSO3eupvHIhE9Xt2p5dwCzMWfFDxmOVCAwU1e27P4xB1l8gkvDkvm8eE0YSCVc7bs7YqT5BboMTFNU7RYKQwM9818SCsc1kN9i7ShI7NJT469bwptqMAAcmQ7hlL7xz69f/E7loo+PCainhdLR7UBPiF7UgJGjUOSvnLyHhygV5vUeNsnRkPnQMJOTy9KaPiFYGA004dbaSlyxPZ7rjCP0T0/qY3TYg2OYL67LiIkp98qCFUCZWEIfHyUN/I1BFWMEjQzDmh37YRe2cKcPp9uvGJ4Dh9JPRM1pwhb8WnQ2dbtoyAfqJxNYzLPT3SeXj/ELSkO+Wgx2yxITDt4Vfeq0FPjLEJomYww/DDtjaVMIbIWg9A2/bIsoRGmzLIFnwwmTz28H2AuZ7mnZlv+XtS3XO6riBT8hCzW7kEm76zj/3ckmrXOOJAHS9xRA6XUFCROOq+9onkzmcs0EpOlnf+UBPkKi8/DTK82OanRpXA6a7az99E/VFU/J+4g37bnp+TfiOxHDkPwJLGrrH56Cn9fneiBo8RCLXaqCS6FiHsSrm9va+ymHLoedE71jEfmS6c/yZbpnQ61rHgw1tvsSggtRbPwSTCHDADwIXU+6ibPJIAUoRSKGxd2AflXLVXIE9oAzq9AMYPHoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(82310400008)(1800799003)(186006)(40470700004)(46966006)(36840700001)(4744005)(83380400001)(47076005)(316002)(82740400003)(2616005)(41300700001)(6666004)(2906002)(336012)(16526019)(36860700001)(86362001)(426003)(5660300002)(8936002)(40480700001)(1076003)(26005)(8676002)(54906003)(36756003)(7696005)(81166007)(40460700003)(70206006)(70586007)(4326008)(478600001)(356005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 19:32:13.1081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232f0286-624f-4ec5-540a-08db98462a93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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
Cc: victor.skvortsov@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The "rlcg_reg_access_supported" flag is missing. Add it back in.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a8178d871795..8b779a103400 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1096,6 +1096,7 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX);
 		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPARE_INT);
 	}
+	adev->gfx.rlc.rlcg_reg_access_supported = true;
 }
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
-- 
2.34.1

