Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58CFC38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 14:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804D610E1DB;
	Tue, 25 Oct 2022 14:16:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F7510E1DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 14:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFfBO//bwo/RByYshxL5kf6lGBQql/jh/uUr7Iaonvh2u1axFj94PYsni5QvghZT5jIdm0ZUCLDkOyGV7cK47PNuUNg1QzL2DlQhAu2cSb7EreX6RAsTM/i5leCaOMwIKbDS+v+yeowcByv7lXxIUQUcDswWXPSIx3WDh5WRj0yrB2h6XJjDueT2wtBv4QIydxXIFGJ7k0uQqoqjEe00mhXPmawE2X8LStwKAN8WnPIg+5TZyGmqfiiJx9XutS2r5O0DPpvxHOypZ/tte4Dnut7p3UaEjGOY4o06HhiUIUSf1Pi3ofh25KMA+1WqbGu/iqoxqDwkdB4UNgtL2ogF1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8E8neNyvIeUwl9cOh2Nnjm2r+OLg2MCoXaBSRy+ELgg=;
 b=ky/7Bjq6zyDRUTpo9t7CNemsWyTZx2eaKADx6lwF6gniZNvQw4LZIUhC/m3uOE//KZDO0HRVytBZDBolOMf1yOa3fmX4aacSexuHBAmXJ0nJORilCXdUWKpCNPA9EGe6sRbm/GH/+2QilHSi8jbtVw8YbFvueRss5/DT2eeqvZyjaOwlm/P4/4qeqvZBI+Z4XeB5IWrftkTl33lGF3pOxLosnzbixOMmx8rgk/H+s8TdQMO+DG7WkU4l1/qhqqACuZs1Kc/uVf9+dDocGjdimxwBFhhPTD2fx90xFo2tlOkEkbt1zD6R/ZZYMa/zlougmKbNh+Ts9B/9kBv5PMwKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E8neNyvIeUwl9cOh2Nnjm2r+OLg2MCoXaBSRy+ELgg=;
 b=Hw5Tw3lXqYOcB+ABw8ToEwIMtQbpJbRzQIfgvyWEV+n6dnvOam4f5DyPhAhhJv3rOVMIsazkFrTzXleB8ixUsZChXKMcFmMSgDNf8bv/rvtruLg1jaRCRZrg/DrPIdzyr9lotzdbOklQHJY7HORUg54oFHKn7mo0L4v1nswALGE=
Received: from MW4PR04CA0076.namprd04.prod.outlook.com (2603:10b6:303:6b::21)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 14:16:18 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::a6) by MW4PR04CA0076.outlook.office365.com
 (2603:10b6:303:6b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 14:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 14:16:18 +0000
Received: from vm-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 09:16:16 -0500
From: Gavin Wan <Gavin.Wan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Disable GPU reset on SRIOV before remove pci.
Date: Tue, 25 Oct 2022 10:16:00 -0400
Message-ID: <20221025141600.1350-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 728a3d40-cd50-45c0-2538-08dab6937bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePvJlZtNcCq3QW+l7wx+qFpXY6YZoSqxj0Iyj6Q2T7y52rHTNX2iwkBjajSG1nCCd/KV7ExZBx4sKKXncURYjV5BB3Vjfqn5U5KWYo6elXcD5MSHqj8vVsFOgfEu+S1In6wPMMeUFDzuLJV5nh673g1uz33eU+PcSuRifaAn9itEDYyPoj/0T/qg1SB8a+4s9+EOsOHsOORVluIgldIhBd+bjaJ9n5N3zdHHjLVmgL1euvBrCYAx+aSmYPi8KtbR49oDprlTiir0kagGTEI+rUQYxITPM64FAP5ao3gs+EHUYlAo+TS8Jr+tYi66vnkgRCaRRNWq2spPNhabc3ppY8XWA1xWWKZtSR5tANrwGLrIBhsY+4CWYWFfuBF/Ve8nIHbKIj5wauGD0l17gZKQ3tMk4kW9hK3SiOXzHKZoF9r6OeZ1dYhV1cYcfE0n56rlsUz74TGkMd2JpVNRAOo9VBjWunDa0YMPFBFRj60mXGRrMGIrN4eHxZjABlWPZDd8r/7+bqLHsmLTqKzD5PYD7LvFJ6pzvBhQOUQZ/+Fkmp2mBguA+MZYv2U9JgCV5SEBs7hppEloTu1cfy6E1lxlOAMg5+8mE6T2JIObCY3B5dIXGyk5cqbueZeR8CX7CLZL+Htx982aGlKGGC06kWVLGe4a1/AWAKtTZE59dttP6zTZVux9RJuI8/aG0q84H6l1LOz1M3tI9doHbh6tVh1RS3mQngB7yYmOrnCZS/YwL+zYvvSzffqz9pY64o7NtRn40fAxJWhJvFUKO2ycHRU+cmI0mbpNQTSOyG2jlEkCcJ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(70206006)(70586007)(4326008)(6916009)(54906003)(41300700001)(8676002)(40460700003)(2906002)(86362001)(36756003)(316002)(36860700001)(336012)(1076003)(83380400001)(7696005)(47076005)(426003)(356005)(16526019)(478600001)(2616005)(81166007)(186003)(82740400003)(40480700001)(26005)(6666004)(82310400005)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 14:16:18.1444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 728a3d40-cd50-45c0-2538-08dab6937bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Gavin Wan <Gavin.Wan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  The change of the commit <f5c7e7797060> ("Adjust removal control
  flow for smu v13_0_2") brought a bug on SRIOV envrionment. It
  caused unloading amdgpu failed on Guest VM. The reason is that
  the VF FLR was requested while unloading amdgpu driver, but the
  VF FLR of SRIOV sequence is wrong while removing PCI device.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Fixes: f5c7e7797060 ("drm/amdgpu: Adjust removal control flow
       for smu v13_0_2")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I1ff8dcbffd85d7f3d8267d660fd8292423d2f70f
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16f6a313335e..8e97e95aca8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2187,7 +2187,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 		pm_runtime_forbid(dev->dev);
 	}
 
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) {
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2) &&
+	    !amdgpu_sriov_vf(adev)) {
 		bool need_to_reset_gpu = false;
 
 		if (adev->gmc.xgmi.num_physical_nodes > 1) {
-- 
2.34.1

