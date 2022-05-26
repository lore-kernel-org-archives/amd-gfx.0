Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E543DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 17:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9C010E00E;
	Thu, 26 May 2022 17:58:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2943710E00E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 17:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCfSojd97IO0IdRLEN28lDUdhJ5gO9uTPY0uPthuft49h4e7BRT4JVXhB1loHktjoBYTk3AQf6oxwFh6bQ4Xp0eURuHCtbVlVOkY6Pypk3XfJjpKyLTc9w7oog9jcDpQhWgtzQb3qm6wnHVRfaJxdC0ki/YDhydheQB8Mxj/kDWJtZLcd86UDzp97VmHeLWYMK9LUcEmWYPB71uynIqiOc6iyzt2va+Tc2z06PcP6BIJTQDPzxkVkb6lNit6aRKqEdEOa/Q4SemsuzgJpRf9k4MsxlVnqQreT48MerdWIhhUQimsoDSSxVlNro94ehlVLPp2n0O5BGxPMwvpX2K7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gagi68+mSGIzMluR91tK8fkAg/X0i6Aj1s9OMMFdu5k=;
 b=i4lTpKpgkB7WE4BLhiWy2JfnbqKIcFeSah/Xi+PJslmkiWYz3B3qa2/A9GhBMZ1Pn/AaUjCxFMeumu00greUyE0yKE0cyuODNfa4SaiaNVjimxZW668P1I/g7qjgQziJIi1BTd5etmfJWPekv9M27Fi8KHvXaddUuWmHkf8j27DmkXX9XA1z1q7NOb8Dskt8CmdUAwIMbBcl9gZQNCltZ8uHiYOPnxVnPn9PpMMmyWxbcUNbVGJShR09w6g/VtQfMrvcEELy3dpKSvOKdl7RurmXMufHhLJoZo0ObBMTOvUHw0BjYIunHIHXF9vIQo/YY+PXZWJAzS6zbiNnJKKx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gagi68+mSGIzMluR91tK8fkAg/X0i6Aj1s9OMMFdu5k=;
 b=cPv+moMdyx61VP5/t8qg6nMziqbqfTCgPS/lEtaGrjNN8uzDcb6PvrtehalSZy3jQt61B4r6lqlSPTLf3JtCwXIKn4f4hYlUsNn7zVFvtT2E5XUQjFTF7f8cEd8mLYR/dOtVLEAvp5YRDZlFPC6+wWDTYaY/mECCreGDpIPTm0Q=
Received: from BN9PR03CA0606.namprd03.prod.outlook.com (2603:10b6:408:106::11)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 17:58:50 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::e0) by BN9PR03CA0606.outlook.office365.com
 (2603:10b6:408:106::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 17:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 17:58:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 12:58:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix aper_base for APU
Date: Thu, 26 May 2022 13:58:34 -0400
Message-ID: <20220526175835.3044451-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea65d8f8-77db-426f-e549-08da3f41637e
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB640520C5E67A62C349F184DCF7D99@CY5PR12MB6405.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5R9PuW5G3z4JtvX5Hj1P7CeTtWTrvY85W4djVL9g02uk+ntvcpxKw2i8hIMtGMOaRiIOXfRwUPtTgB3qmv3j5pxNmITPmmpSr73Kb8sWw+nhmqolWI+GEFhJGmoE/fmwye19S1kUu10WrAW/ta7H+XSZV8KK9DBVDB3snuzWpe37itHsKe/bnnP+cxs4HMUz0Jt7ApEx4gRRId1f5jo7VbHJ1MzwKNpMgfHyE0qZYU5uhgjoIW0pMFhT8toej6fz6GlOMIyuMMwX+n08vSlD6tF5xANduxAemEH7bFsQP5R7SrDb3e9Xvm/gwYBWo+IUi7tlZV2bulEKPL12PmCLMJWzdBu+40Sl1syCljs/HgZVX1VZU74P5YvsgfAnbcYmZI2b57+er02OilsfJiWWXnrQiTSOTvh+t/xDw7lurskBsIBxekcgfeNUa//r2K4+wTx5RPTLwDGwCWEGKLPphcPueeshORe1hJUJ7NwNtofNNlrCVxcSSSFcUfCUl+QypTznZKH1gC5WaF3ZgyizMEusnH94sBYj2NnDI589/ozRX0PSsOGi0N67ImBRyISRq1yi1uQgVE4DUtH18GcnlRkaGBx1KowIM8tqFPfY3pmg5RPL0C4V9ihEDtEeWCD2U78immKc6SUnclcP6p6bcedlJp3Z3kugXb2QpDRdyYenPee0xVeVSu5qoJq65Fq2YGlNUdy2twtd6RBCtpCcSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(2616005)(54906003)(36756003)(6916009)(4326008)(40460700003)(2906002)(86362001)(81166007)(508600001)(356005)(70586007)(70206006)(5660300002)(8676002)(36860700001)(6666004)(16526019)(316002)(1076003)(426003)(82310400005)(47076005)(186003)(26005)(336012)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 17:58:50.0250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea65d8f8-77db-426f-e549-08da3f41637e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Roman Li <Roman.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
Wrong fb offset results in dmub f/w errors and white screen.
[drm:dc_dmub_srv_wait_idle [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3

[How]
Read aper_base from mmhub because GC is off by default

v2: use BAR for passthrough (Alex)

Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 11b61da419e7..b6daa4146dd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -685,6 +685,12 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
 	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 
+#ifdef CONFIG_X86_64
+	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
+		adev->gmc.aper_base = adev->mmhub.funcs->get_mc_fb_offset(adev);
+		adev->gmc.aper_size = adev->gmc.real_vram_size;
+	}
+#endif
 	/* In case the PCI BAR is larger than the actual amount of vram */
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
 	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
-- 
2.35.3

