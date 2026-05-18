Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7033CD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 07:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A3C810E5B9;
	Mon, 18 May 2026 07:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TNPYGFYd";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9289F10E5B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUfLxLaVv6tRfKOzZO8mXfLnhVLkrwa9GShq57FCHkK6d0q2hPN3N+eU2c3Y+7YPAknsfqMpc7MRpYlfD+cBJOLAkPdpytlxQk/YOSOdvOljQl75auPBM3/M7ADb82JT+JGY7ph7xwkHTqtyMJ+Z8HuQHRzgcPA/rVV4uV1G0G9AfcSyeVSg3b3xw3QgMADN3geJSYknIA6HqUrfPQHCXTxO1/6OJqOARwSLXc49UevOLJtXpaNKQOVsW2P3+E2AMzbWZOjEebRYEaRXLJLS2tOTAHKTRTmQAmPk5Z3RZkMdKk99NuhgnsDeccddc8jigsGNmxMrsJDeEGjS+S6FpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icnuDD0noWtOvuEqxCoiVhYdOV59vbh0WvZIPHVaJKI=;
 b=lp3mFoIywN+0RiP9w9gwXqVPguFPXEgWWKizTziPbgdN0nDYzCkISExAyGfLWyXsRqqePovFkhPf3U63kFIn80n1vi12J+f341OMB9lRlX8Gd9VgZSv1zRxaMD1qUJVyG9VlY56U3F3KxA9QeTr9yf8H0MNrI7p9PE8emoqvkoLZwYLex4DwTQUHfkT9lhNIrRcWg3DmvHhxcimpCm3629RGS20EU2Pg4LXzNS21pINBAEojP3PXEcunK4eJ6Fkr4Qmx0su4oHoKXkcJZxF7spBnpbeMgffhFRzDdP11+lvy11ZPIjsy8F6dQx+Wbte1Ee7uI6/5n4k8QSqSR9STRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icnuDD0noWtOvuEqxCoiVhYdOV59vbh0WvZIPHVaJKI=;
 b=TNPYGFYdpDsivY+kKTRJ5ZwojWj4WF2Tb6HGfpD5uLIHexQdHHmZFgh4MJf+XAwanJjc+IEY0utptsfWCR6SzySqH/EDpXgEmF0/Wgfey8w+yODCxuYs2KS4PvQKSI4OEiFWa3uV2jTKbjATVqWOVHIYtojvF2Sr1UUT+ftJPn8=
Received: from CY5PR10CA0011.namprd10.prod.outlook.com (2603:10b6:930:1c::11)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Mon, 18 May
 2026 07:09:37 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:1c:cafe::4a) by CY5PR10CA0011.outlook.office365.com
 (2603:10b6:930:1c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 07:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 18 May 2026 07:09:36 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 02:09:34 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <stanley.yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amd/ras: Add more IP versions for uniras
Date: Mon, 18 May 2026 15:09:25 +0800
Message-ID: <9bee8531980fe38fe2a831398b3b3a335bd69fb2.1779087990.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779087990.git.cesun102@amd.com>
References: <cover.1779087990.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: abee83f1-adfa-4b26-abac-08deb4ac6b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: VyX6p//vKsJdg47V679YYka5URk7X95BsCD+9BBkPKjQcux7Qqb0CkA0+8Np66S25wWt9511O34OoWDlU01amsOIldIJsMpF6o9FmxdeZwutRDhzkBhGWpcHwQQ3iOJvlyPvLmdm1Pb3Y52F+4aSFOZ3KLmrZR90zu3+P5/LEGFKEbghGZ7XyhfvcbsqzPEVoHilE+bACjlkw1wivdNxdrzFzzqY4o86QdM6X2dXkFOV34/genagoesFl2dzYo0mVU6k8poWw+TEHfDrGjV06NQ996q2rDeFS2hi6c5nKOnziwOVdUIFY0u409jvoYynNBjYQ1rFVGK6E7faU9IrNhVpj006HKkKVC6Pp09jAppJaiA6nK2QpKOKwC8Ff91MhBXsxyh+czSlsCQRRsjfZhPh8gg75HHg2/WbPAEO2F1XvFerVxUNcgeDxqwhOD1mLoXzex9Sz+YzZTdzEt8WMZhYD15hOX01d+LgqA7bXxDpLe9IivMUXZv1uEzRfqjrkbnq6K8SgLNwfzQZoNxfNw2818S2KGxxn/B7qVxficiox1GTIMWwsV4wxaZS2Icr5TQHN5HQwia+v7a2Eb1lU/t5uUbD4YEpIthPIh+aZrBm6qqTLFgk1b6NHqtj1iCPeAfEY97sVuLU0MG7Yp599dEKnEMDRsPTFgyPh29eImDD2yOzVYD/pdI6iy9EgBWM6a0RMihIqcDpChkg5fZS2QZxD6wOh/KK8Kl8ef40eAE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R9P8PbSPenYcpYYNjNMYX2Q+6tqjOg7HB6QDJdE7rtaF1qLOAFzJzwtLf+SxCJqzHWxt5vYuU9BAkbDkj0QeNPegVawappjSWZHS/IEeRGTVLpftMEVxTtSe2mqzqOhYskhsCzpVpmeyxzBpHKjzYnpT526P3DTobrAjgY1DpUPHdmGnP8sxpgIX19qvcHuYo+iqbxXUiu6zg76Qrz5wwjIAVSfngIJmaZzq3GNMYV8CSvaCoWT/vVPsc/H7o4Ju90jb9zolPcAVn+LF9/yAQE4bDo330nB/kn8aaJOzcXNt9estuEujI6AWlYmEHn6jdN8jUEVz4HFRoNhL+U2V2VnoNSu7jldrVc/HecGksg9vQt3vodmIlWZcMELxW6DiMFw6Q9yqi6OwK+w6jXXXkluIROQxBMMUZBKSd1cgA81YUG32jwYWLdgplD3BxWAD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:09:36.4385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abee83f1-adfa-4b26-abac-08deb4ac6b90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add more IP versions for uniras

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index aaf88e1cdd07..4181caea71c7 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -291,6 +291,8 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
 	con->uniras_enabled = false;
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
 	    adev->debug_enable_ras_aca)
 		con->uniras_enabled = true;
 	else
-- 
2.34.1

