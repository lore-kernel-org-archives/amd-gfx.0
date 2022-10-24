Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699F1C67871
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 19:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 994C610E061;
	Mon, 24 Oct 2022 19:45:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCD610E061
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 19:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIRwvDITL1JfPi3uSNik8me6Jg91yJdnhmWjDbZj58XRnPzzB0pUKgvDaLwY8QwDJBEKbKyfkqdi9XH0UyJfNojbciJf92gQXRzxDTTNHW5MuQCrXAR1Z0VbpvzpzU/2CFenM5tWDe0kL/H2gbDwJzdddH4W0NNtAgHFaf6Er/bsx+eugih2RjBSxMpdOQx+Vaengwse0gF3MvDlutAwv1zjHFmmIkfcyeV5bnOCwcEUywBZprl4IrBV/BptPCgtvv51Xm/fY2RdCAemYT4cITOGl+OKXq3BrYS1fiW09fIO+A+BiabvaavVZNlGQuTL9g4JMKCCb4PGKSQETV7bmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk4QwAKEOTcp9DUqJXo5a2CWZe66dc09H36Rq6ZIofc=;
 b=mzUvndkDNkHJuT+nwuBiEvOpTF1EqAN0ReLpDKPqzHzJRc+vmb3NMBT6iaJXeE/EHRxNQenvzuBYJTTkl9Iw+hm8j6zeD8ZFg+VlI2Zs14b4XJJ0YdY4ZAm4gUsfjgbhN4q9N4bGMzfxQKAodXSNTEox/LIzY6esRwO934/TgWNxIMzqJUL/FWniEV0ATOvU/2d8l6kzzpI0WhlK6vcQ3vZsuK0GrOW8VGrLqTEnkzPO0hJB2KacIo/L/syF+5GAYifhoqin6LowEi03B4YBf0SIYPLcPnsvq/rZCFuzGtW5nyokkzY9ZRjt6a1+6/gSU/DXvNT4xyaaPCR6KSQZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk4QwAKEOTcp9DUqJXo5a2CWZe66dc09H36Rq6ZIofc=;
 b=y0gmtjdHU+BQSwLae+8U2Q+Kv30jfSRECt2IN+upOAAxbZwNk3Zi8E60lnsbcy8HunqMO0hNd5VdG0hA5P5P6qjxpm9ls4LqlLcWsmGnS0rTjuacMrhD4Jkzw9dOpOKAC2X/Kwdt371pHvS8bfqLJD0Q0qx1tglOLVPSG50LfAU=
Received: from MW4PR04CA0130.namprd04.prod.outlook.com (2603:10b6:303:84::15)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 24 Oct
 2022 19:45:30 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::ba) by MW4PR04CA0130.outlook.office365.com
 (2603:10b6:303:84::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Mon, 24 Oct 2022 19:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 19:45:30 +0000
Received: from vm-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 14:45:28 -0500
From: Gavin Wan <Gavin.Wan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Disable GPU reset on SRIOV before remove pci.
Date: Mon, 24 Oct 2022 15:45:15 -0400
Message-ID: <20221024194515.7545-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT010:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe10856-97d2-43a4-6a1a-08dab5f84eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6uctwl6k27fu8+ltW4wwxuekIZIv3SuA9hEd13EAygxJlidmYOnxAcxjJUHCJN3ejpu9zyslyjZ00OwaXCSKL95jh596IZD+zwUY/1xFltM96dDQ+UHrUmISQW4ruxZ8btHLJGBx77JC9JoQGhIyPrC6Tz0yW12HSiRo9j+8IFJ1okvByC9O8zNfSGQJ0fDEzG4WtrBR0miPEDabyBfTn+/0gTPL2//a5oiN9/P18pbIZrdqPaI8+fc/gCLrDAPJkww42S5QnTW/POTBichGs9AgpZG+g3nCst0cuwp/t7SI/2rYT2hUsYEzRjyew9WZUXq7J1bMc0tGnyjVbYodrrNdge3K4oEGmw+Rrfb5yUrsQU7dSy3a9oKeTRGhAZyM+jyUkwikRQCZCtkjUSyB2CZrHCBCCKYz8r6mOyvnwFGyukCPxjRtpsAiDKb4zkDJmrjNzjEDvUcNvrJ49rmZPMXUmf4QRCmyOJP5N1j1WHmhgZzZLh+2LzLVGTBcr5tWFOHbIryUx+4RYDlSWKG5xyWUXuick4p35Jlv7cacDIoQK+6RmXmvtIfj9TYkYXuhUU6xy/qu7V0iKPgQEPEwMIuhgaLlO8c4iR2ID+44b/ZtZqe0S/tEojf+vasOK0C0gzEnDJh4U2HE4cOPAukcS/ApvazYqkW52JopRJcEoW2K/VKZmNVnoi5G1S/99T9SA6x0A4Mm4NLDm8YXmTG5r98BT1h0N4c9TCEyiraQEfsta4osqjBz7RlcCSqQ6sTMHD3sPz5HO0B6Hr4fRFqeSzoTcPohj8QQO+4MmKhapE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(426003)(82740400003)(47076005)(83380400001)(356005)(40460700003)(36860700001)(82310400005)(86362001)(40480700001)(6666004)(81166007)(6916009)(2616005)(316002)(5660300002)(186003)(8936002)(1076003)(70206006)(336012)(16526019)(70586007)(2906002)(478600001)(7696005)(26005)(8676002)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 19:45:30.0935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe10856-97d2-43a4-6a1a-08dab5f84eaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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
Cc: Gavin Wan <Gavin.Wan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  The change "Adjust removal control flow for smu v13_0_2"
  brought a bug on SRIOV envrionment. It caused unloading
  amdgpu failed on Guest VM. The reason is that the VF FLR was
  requested while unloading amdgpu driver, but VF FLR of SRIOV
  sequence is wrong while removing PCI device.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: I1ff8dcbffd85d7f3d8267d660fd8292423d2f70f
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16f6a313335e..ab0c856c13b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2187,7 +2187,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 		pm_runtime_forbid(dev->dev);
 	}
 
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) {
+	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) &&
+			!amdgpu_sriov_vf(adev)) {
 		bool need_to_reset_gpu = false;
 
 		if (adev->gmc.xgmi.num_physical_nodes > 1) {
-- 
2.34.1

