Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A1CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 13:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9630A10F1E0;
	Fri,  8 Apr 2022 13:58:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FCA210F1E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 13:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo0+z3yFfugsiMKfNXTMAjvrIV5m2Lf4D1/cdbY+W1ky/sF2zgWLeamXRhfvIY29OsbDGhWBMbSmAW6tw6dDSTEMcm5xDESm7MwBU44+Pcy3ssuVg2Umcfp7TbAK9Xm2j7iTXZBupKu8zZFz8ZUBP+s34HEKoTNT+dh6kXPPFqpX/kLNNNHKCnb/F0MU4STPW0EMu3N23I73ZymAs7x0jgC8i30/dd34hnDu0XPYxYyQYNYiTqqZeve7DHBMXnh+mRw/T7tCGipdzCGe3K34u9FP1eWMVegSm9R4G4cRAYvh/EWh4Zv/71K3vYKpQDcZ6tieJ1Q7caWniQH8l48Nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDcp/Uf2Qfnvh/WA5Dm3uvHjYnLXP+L/W/b46dCjB9M=;
 b=dPhRHBsq4vEO7WjZBKqr+nwuv8TXZpfhogIo7IyA+/d7EjJ5rEQxIkTB5ZMUXVw/ieG3hqL0LCMscFhywuD5TzzaiuPafOISPGmn81Y+628oSNtx3feShd41xtG0BFSz4p3BdqY2A0hXkPyQOKaksGmCw+nSRpURyvBXe6hCYlkYq8DuucrWypza9gAkHDRVWxRiGzIbmVM22+zg+7ljr5JXEl/A0Ji1e4Na9CtHvGi2KyHix1mpmjyEWSkOAbfkZeZG69PtScaeQnttcGCoakC26bfKU+kj+gp9Ph+MSslcaPCIbEC/F+iIJ1BCpqzwz/nsW8l3UdCZLGr2195A0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDcp/Uf2Qfnvh/WA5Dm3uvHjYnLXP+L/W/b46dCjB9M=;
 b=X6lE6rpTGoeHAiQ3y8Kd214XFUSFoPmgNSWNlcmzX/hkkSeChd1zrs8iN18A5EPKAnGwjXJ9kckKLPCkq9nxc2C/FeeJMAVSufzwRxgzSZrUiFoKuZpXvB/d39a5xgHCWksGdZtxto86tuOnyOQeza9cASsI3z4SWT8rKhCamSs=
Received: from DM6PR11CA0049.namprd11.prod.outlook.com (2603:10b6:5:14c::26)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 13:58:31 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::5d) by DM6PR11CA0049.outlook.office365.com
 (2603:10b6:5:14c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Fri, 8 Apr 2022 13:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 13:58:31 +0000
Received: from yonsun-E14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 08:58:30 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix asm/hypervisor.h build error.
Date: Fri, 8 Apr 2022 09:58:14 -0400
Message-ID: <20220408135814.244798-1-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 929b6d41-6a3a-4a46-a5ea-08da1967dd65
X-MS-TrafficTypeDiagnostic: MW5PR12MB5597:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB5597A94AC09F9067C3FE361AF4E99@MW5PR12MB5597.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRULH+3CbfRseel12KIunPbUeN8Mqb1uQwvaaV75ZWUfBewAr2J5wIBm3z5Nq960EpGtsYVL8na3izfLLYfkZ9XU529ydxIg6rB+cpEVAgqJus8/7AcfToJOl13XetfpsV7nDVFXfktKGOikJaARY3L4V4Bsl/mHDQ4Rb9IslkePFYBHUxI3R2amsQV8jHD+mpNH8Pxfk/TdVhLHGTlXYKSThWCwYUkNquwt17RcKnYir822QiQfP1eM5+oUdqRRgv6rK/AbMOUhQKMvNDZKqSWfllhnZjvO5M1W053pHFyVRjQgOfX6TNjWvgTRpoKUpUFYgLi//kYBm92n0usq/G6C1NyDXUNN0144pYRNLuVjJCc2TjDjGpv/NDBESFfmoAoIqSP8swWgOfHiq6pmu38aWPZSnEtaYXehhkuutO0B6g7YsIdnZy7J2yjxBsk/sNX1uPu/AewwKvSqu04kdbWb2fiSadEzTSA6a81o0L+J6NgFacZK3uXFbi6rohCEVG9URkBoCdTJgmbeNmSCIw2TPMrglbrUh3Tvmw+yaIYxGg/RwZLoBV9Xpo17pHASP/FY6Xri5Hb96alM031QZaF17I+bmI3VzBkfXxrALxRc8Zr5hQFgssV7yt2d5gjdExBT6emoep0tHvePtLCdjcsenS2R1iiTvK1tBlCh5WwcDOANx5kngamXZE6pLAsAiZxOZuvUEWSSbdqXxeCS5LL/Jt9jwVgLZMwR7XxIxRk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(40460700003)(2906002)(336012)(47076005)(86362001)(1076003)(426003)(44832011)(2616005)(16526019)(26005)(186003)(8936002)(7696005)(5660300002)(6636002)(70206006)(4326008)(81166007)(70586007)(8676002)(356005)(36756003)(54906003)(36860700001)(6666004)(316002)(82310400005)(110136005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 13:58:31.1848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929b6d41-6a3a-4a46-a5ea-08da1967dd65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add CONFIG_X86 check to fix the build error.

Fixes: 67c7a4b1ec6c
("drm/amd/amdgpu: Only reserve vram for firmware with vega9 MS_HYPERV
host.")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c322daf9c734..569cc394e562 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -25,7 +25,9 @@
  */
 
 #include <linux/io-64-nonatomic-lo-hi.h>
+#ifdef CONFIG_X86
 #include <asm/hypervisor.h>
+#endif
 
 #include "amdgpu.h"
 #include "amdgpu_gmc.h"
@@ -671,10 +673,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		/*
 		 * VEGA10 SRIOV VF with MS_HYPERV host needs some firmware reserved area.
 		 */
+#ifdef CONFIG_X86
 		if (amdgpu_sriov_vf(adev) && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
 			adev->mman.stolen_reserved_offset = 0x500000;
 			adev->mman.stolen_reserved_size = 0x200000;
 		}
+#endif
 		break;
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
-- 
2.25.1

