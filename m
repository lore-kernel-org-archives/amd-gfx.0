Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D9C33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 11:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB2A24676
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 11:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NYIZJ5zT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB2A24676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C63EA6E373;
	Tue, 14 Jan 2020 11:42:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001486E373
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 11:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui/IFAJNgeiZlyn2z3wkCAQJI/Zti3NCq0g5w5B9rlKXVQq6dYWcITi7Zi+/fv1sXqngfiogYzWw9cJt/kptJew5/dGXd1h4LHdb5SmpuYUKL6g1319PZkN55YbRLGHrpVAqSejHHVp48lDuSP7qEVayHt9kWtB0prj2Th79jd1IN8DToYtc44UISUU7dCEgsBRYFDyAcVzpPo8q0Aaa9R+rQw29USNQfwMzx2WlY9GdUFt3MfvMBZhEQLnDVDHmfXOwOILhYPRWZC4mTeS/x/oYizYTKMWUBRuZ4nwCunjjsHxazPwp5yipRNespC+uaAJt+4kDhRjRuOwOpNPtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT+d1vZ/9ovo+Kqnt8y4NCoEVfsiDraxi47C12Epygc=;
 b=JYEUEegWr3Dvm6wBDIlh+tKlSXDLzoJNxkwx9sMgKp/Cj0EE02x6TJlQkID2FSydk41cILm/9hEq7Wqh+AQTS3GbaDpAkVR/QU7BO0Y+l3uC0AiiEi2Q02RUnyieIxq2ClQ4o5jed5FG01BVOpwrZBm1qt6YEGBQen0wpn7qigXmzwg0b74ldaWCg9+StQM/liz7kQcWBRpqjfbom09S8emTdx5QcJ4ybdbRVSGBQzT/WlsuylJ63xpu/mcLEXyLeGfGgnMEKrXNL1exjjhwiYcf+uCPBbgm4Mlk2o7vtLVBADjgP2fWOxreMpIoEAzN3WWd33Emho5b6Dxu66qbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT+d1vZ/9ovo+Kqnt8y4NCoEVfsiDraxi47C12Epygc=;
 b=NYIZJ5zTl2mjizyy3Hdjk7YAPiRjxLwGhqz+z/OWlOY4IjR0s4mXjp9cWBccvxURlIYOb9aoz3LsIs8gT4rUeYD3hGWH2ApZ0CUIAS6mSeIsjxR20MVnz40FsyOGnKqMswJz4sYYLYwptl7WMNqg+qsmMu9dwhIcOAxOrpICK5g=
Received: from SN1PR12CA0071.namprd12.prod.outlook.com (2603:10b6:802:20::42)
 by SN1PR12MB2384.namprd12.prod.outlook.com (2603:10b6:802:25::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.16; Tue, 14 Jan
 2020 11:42:28 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::202) by SN1PR12CA0071.outlook.office365.com
 (2603:10b6:802:20::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Tue, 14 Jan 2020 11:42:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 11:42:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 05:31:41 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 05:31:41 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 05:31:40 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: reading register using RREG32_KIQ macro
Date: Tue, 14 Jan 2020 19:31:35 +0800
Message-ID: <1579001495-20729-3-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579001495-20729-1-git-send-email-curry.gong@amd.com>
References: <1579001495-20729-1-git-send-email-curry.gong@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(428003)(199004)(189003)(7696005)(478600001)(6916009)(4326008)(316002)(70206006)(70586007)(2616005)(336012)(8936002)(36756003)(426003)(86362001)(2906002)(81156014)(356004)(5660300002)(6666004)(26005)(186003)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2384; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b43a7dbf-b157-4cb3-62df-08d798e6d56d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23841B6AAB54A0BBD4C7FF319D340@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 028256169F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6p4PAb7vHZZpttJtmL1Lrl/lzWir9bty1iuf4IY6g65zbjVCa6Cx7PuSV2f59o3fSurx+69jWe8aIL6sQuxDP1OtgwlXkVkFoTWMaVAe+StRGQ78MdmcfWEwxOSQ+3G8b9O5VEeFwxJZoquEirHCjsOCouH+LYsx3e5N63uYSZwgGbrNiLJThY4vhjLBaRainAzeGAUR39NKDejwez/vNbUEc2jTv7Sf+b7Drw6ii0qM0XQPMr4nUolGfRDOhWX68Sd84t7KTPfAq1WP6eyPBdMcuxemDTlfWpyht3mNPiqs778sPRY1Gfo4UMkS7MuQfqfDAQRUL3w1gYFer4/1KFpKz0diJp/7C+N465SPV8P3E5QAq9FqdWypLoTwT8+CFRReqr/opx0+NcKgXTBKNqAczdT2+si+8Xmdk1PHLY3MvH0Oac6tzDMJBA0jzAd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 11:42:28.6399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b43a7dbf-b157-4cb3-62df-08d798e6d56d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reading CP_MEM_SLP_CNTL register with RREG32_SOC15 macro will lead to
hang when GPU is in "gfxoff" state.
I do a uniform substitution here.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 425762a..cdafacc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4714,12 +4714,12 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
 		*flags = 0;
 
 	/* AMD_CG_SUPPORT_GFX_MGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
 		*flags |= AMD_CG_SUPPORT_GFX_MGCG;
 
 	/* AMD_CG_SUPPORT_GFX_CGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL));
 	if (data & RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CGCG;
 
@@ -4728,18 +4728,18 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
 		*flags |= AMD_CG_SUPPORT_GFX_CGLS;
 
 	/* AMD_CG_SUPPORT_GFX_RLC_LS */
-	data = RREG32_SOC15(GC, 0, mmRLC_MEM_SLP_CNTL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_MEM_SLP_CNTL));
 	if (data & RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_RLC_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	/* AMD_CG_SUPPORT_GFX_CP_LS */
-	data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmCP_MEM_SLP_CNTL));
 	if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		/* AMD_CG_SUPPORT_GFX_3D_CGCG */
-		data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
+		data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D));
 		if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
 			*flags |= AMD_CG_SUPPORT_GFX_3D_CGCG;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
