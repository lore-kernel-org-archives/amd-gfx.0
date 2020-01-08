Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0446C00523
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 06:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E35206DB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 06:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B2V8CWHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E35206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F94989B83;
	Wed,  8 Jan 2020 06:15:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E8989B83
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 06:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d92BYrfRfIxm1aV/YIA1L0gSujzNEOeGahqGFGq2zZ9pNlNZWs7eeRg3pUHYH/EYNUf732JJFPbKTf620dLFtIsloJyi9RGvrys5zIOPtWgtCuotwR6YLclDS/uALtEagmcmz8/eis5t2iED4N3+I6kIaH09J4ojjeIVryeRA3/SrpwVFOxNYz9SLSW+aFxhEFGaeB06jUPJcs2DfEi9l/m+/6hV1/90y6yMZCv1dO6M/b1c3GS3pDTTsAW6TlMptQN0ntS0DeEhr6Q7peAIpREF6Leo9Y6nQ6nBRd/PVu5p4vyoOrlzDTu9mBWIiC326CY9BiV0hZVrmIw1EB++yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDHE2nF49ko2TMsv4aZqiAFNF2qonDSPs/vem1PFikc=;
 b=VEX3qFjDRGfUZGH9hVQdzFlbASGGni20Iu1avBk3pM7Ya6BHlMCsTOQpPxJIgXwZn8jB0feIFUDOUKS2qdqli6kL5kpJo9u4nrP3qNwA6L52Mo7PIa5+L7XPWkqyRnfl2YO/cSv2pt9t0+0gGUHH5WrX9KNTZ4Sey9bChEJn/C2sv0zcxBB3D6w/hGy4zrXbOqcCgKzjawLuuWsYbUNfOdfYuCM2sXMxi/DYPkbHI7/Jf7tDjsre3576+ihFVmg51BGLXS9j/+XoonaNsSyw1AO/c93h5RPsSiS1aYU/XONlbXgDZKDy5m3BVS6/nvUL3aSppU/npWyp4MW1Kz/Iuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDHE2nF49ko2TMsv4aZqiAFNF2qonDSPs/vem1PFikc=;
 b=B2V8CWHyUeXHILJb0lnP45Y5CJ0Os36g/X8fSmZRCkGuZC/yAcRkDGyPtifB4bSf4vJZcXPOUFDeXmO8qPxpVz6OvfXpoMorBrnOhQqkmg2XlqN7fpP7R2i5AmlPE79WKrzclSvIxYNwDo+BDqz7QGeCzx7jN8B5hZ4wcSVumQw=
Received: from BN8PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:60::31)
 by BN8PR12MB3041.namprd12.prod.outlook.com (2603:10b6:408:46::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Wed, 8 Jan
 2020 06:15:25 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by BN8PR12CA0018.outlook.office365.com
 (2603:10b6:408:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Wed, 8 Jan 2020 06:15:25 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 06:15:24 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 00:15:24 -0600
Received: from gamma.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 8 Jan 2020 00:15:23 -0600
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov: workaround on rev_id for Navi12 under sriov
Date: Wed, 8 Jan 2020 14:15:11 +0800
Message-ID: <20200108061511.30825-1-Tiecheng.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(428003)(189003)(199004)(26005)(81156014)(186003)(316002)(7696005)(2616005)(426003)(336012)(6666004)(356004)(1076003)(86362001)(6916009)(36756003)(81166006)(5660300002)(4744005)(70586007)(478600001)(70206006)(4326008)(2906002)(8676002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3041; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8c419a3-f538-4ccb-4b7f-08d794022667
X-MS-TrafficTypeDiagnostic: BN8PR12MB3041:
X-Microsoft-Antispam-PRVS: <BN8PR12MB304115B7478ECDC8E4E5DEE9E43E0@BN8PR12MB3041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYBhnN2Adq8BRGHGuQyj2Qg89vyxjTm9WHqmiuuuo3HiTEmCCRDeabvqa05aF6UMC/cOOX01xuONaHW9tfbcrXRgOxgH51tYRe0QCqO8E7F+gGtHV80RDGhqGCCKTmbkhM7G9rE+EMKZ55IQB2s/J0RSOQ3BzO6kTXG6wQaqCHL6epSuDuyMFfhG9PK8XI+re3kkzVOXHx24O2jZASSlSxlJ4xE/vgL3x1XjorAEQXhPcv6NRkV+CrrbUsAmUXWODmaKz6BGtOszHDBxDqkKlrK7yv5Oxy9re+90aI+GLz2TNDwua6JVsYuNN0BFgZbHsXXj95wh+FAY/eNFQ24jh5gD+YdjeDsTju/oz3V/vbPMGUd9lA/xnph2NItJuQU/Y2+UgnYKsTiz8/X+0raiRJ6/5oQeNysRdARhihhdvhXCVFz6vti4XvTt8PMoJ04y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 06:15:24.9792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c419a3-f538-4ccb-4b7f-08d794022667
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3041
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
Cc: Tiecheng.Zhou@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
as a consequence, the rev_id and external_rev_id are wrong.

workaround it by hardcoding the rev_id to 0, which is the default value.

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index b0229543e887..63d54604ace6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -726,6 +726,8 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_ATHUB;
+		if (amdgpu_sriov_vf(adev))
+			adev->rev_id = 0;
 		adev->external_rev_id = adev->rev_id + 0xa;
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
