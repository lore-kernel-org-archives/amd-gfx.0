Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B52C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 17:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 192A310F46D;
	Mon,  9 May 2022 17:07:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF1410F46D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 17:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu4ZG4bfx18aYxjj6dHoikQvUWvVKaEVVS2xgwUkk4NJTwqaHK6hx0Ir8V6dzbLazR/CH4JWiWPBAnQHVnpftNkOHCh1CXOYVGnbZ2JjCv8FGFxXptOzROdpJdUvEq8UGitPv0WKyZGDoGMN8ziyYhQisOQ+thQAmhaDfafuW5EqnN2/c5ViT3p9LATNbZOJoesseyGXlj072b1//dO/vbzyp2U+XmC59AxRgNNeB4BxdgMlqcrTzRcJj6QsZo0wpXQ7VHNngH8I31fmzuc3S2aYk3C2seMb4wcUa2FsDHBH/6V+WT8wAWzLyZ3kHE8OUcjXnbpwJ5Z+1GUEwFEiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/0xd1Ge+mTODT9+4bllZX641SrK7pKjlXbDkMCl1Wo=;
 b=mXxJMLDeRFh4L44CSbDqnWmgr848EL29C+2ySCzcEyNbdrygv2wKruXN6wdSgVclh4aV4TKQTrUv1P1KMdRk49EQPTS7is93ZilnkN5ZuHkcN76ggwCvYxVP9rKzjYEPjnB2E37jIr6IMFzoZOi44J/sZ7JSbohrDIMOVooq8hUdJkjw12tFL9808M/p41NWt448MgkZqyoFKao05Na8nb2ICntlWomFAWqpy1x01FcRXJRXX6ExG93nLg9x8wCtClkMOv/vyvAG9aHNw8JDPyPcxmCaWjg09o2proM1h7kbFx+9fQwIdPL4LalAcouMKqqLntuQ0lj3n8fJ2yIdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/0xd1Ge+mTODT9+4bllZX641SrK7pKjlXbDkMCl1Wo=;
 b=mpQZ4f/pAQBh5iAuHtikmFVwxBwRrdKIGmk6RzV0y3d2c6Flh0p4lU35310YliLI19DdaIwRO2mJYSgh0csabQCc91oqe7sWHXPH8w2Herqe5k3BQjsjGkiz/sjmXenf/gKwQStpXpoRB3iOZjz9L+3MbDohT48VvS10De9n8AU=
Received: from BN9PR03CA0507.namprd03.prod.outlook.com (2603:10b6:408:130::32)
 by MWHPR1201MB2511.namprd12.prod.outlook.com (2603:10b6:300:e0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 17:07:55 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::d) by BN9PR03CA0507.outlook.office365.com
 (2603:10b6:408:130::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 17:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 17:07:54 +0000
Received: from yonsun-E14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 12:07:53 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Check kernel version for 'hypervisor_is_type'
Date: Mon, 9 May 2022 13:07:32 -0400
Message-ID: <20220509170732.791710-1-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ce7cc93-81b0-465e-db6c-08da31de751c
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2511:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25119AA6F523AA98028982E3F4C69@MWHPR1201MB2511.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBo9x9qR/vH4beM1AkU9qXcp92ZqJpgDsDtkvU4dK0kXQ88LheGeT+lfMMWIoLueaY1AIf2PkP86gpAJIJYIwSxSR7U5OsY4bp8po7S0bu52BIcUGoLy2nbyihJz9NjuZG6eWGKjQtosdN88WGNulJcl4ZWe67BaGRlAO3eSfHfYhrvSdyKvSDAQR/vzmhrvXfJxOTXkW5RlgbjF2X5TONL+XOaomlmB4w0OAzb3/NRO1Odmg8pFLLuLGBjatDo0z4BBqaD5qUCJCNjC+z4lL/s5J/sjYZOk4DvsrqsbERF0Jf9YC4vTW6klpUoPuM1hdGfeeVtPVPWo/K5cfy5jyYiCh3I/ZcKXVDH5UjFrW4haMQuDau/XXnPXOwchyq3ErydhkjNv3Fera6MzKp+6KNx+h0g/n2FuTvYaz0oZ8VG8DPrCNDUHzMOTDrN/NXiJgGqdBRXqVHQJWgFQ7pCicHN/8WkobDME3Yk5XXQzfrPj1e4h8V5pfYXvq9ZW6XnFTPr8EaUESqyy00aepQYybOk4jZ56ApjjUYTwAExLD4qHAn5tARAqGy8NRrU75ORbvOsc43+Y3rHnJmTHwfzxNwqT44lxBT0QG8lR5WQiR5+u84UtocO/F8hq1AO6bJ6EQlITGB0HKbaAVNUdPlPTydBmlIdz6mGusGZHKfNGwZgkxFhq9AiWGRLNCt4uYM3yh629B/1SaWD844CpRrvoxO2OC154AZoyIWnd+xmTG7c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(110136005)(7696005)(70206006)(82310400005)(86362001)(508600001)(316002)(356005)(81166007)(6666004)(2906002)(36756003)(16526019)(336012)(426003)(47076005)(186003)(2616005)(5660300002)(83380400001)(26005)(40460700003)(1076003)(8676002)(4326008)(44832011)(36860700001)(8936002)(70586007)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 17:07:54.3047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce7cc93-81b0-465e-db6c-08da31de751c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2511
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

hypervisor_is_type is added since kernel 4.15, dkms package failed to
install on older kernel e.g. 3.10.

Use marcro check kernel version to determine whether the function is
used.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 88b852b3a2cb..963b2e68205e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -28,7 +28,7 @@
 #ifdef CONFIG_X86
 #include <asm/hypervisor.h>
 #endif
-
+#include <linux/version.h>
 #include "amdgpu.h"
 #include "amdgpu_gmc.h"
 #include "amdgpu_ras.h"
@@ -653,10 +653,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		 * VEGA10 SRIOV VF with MS_HYPERV host needs some firmware reserved area.
 		 */
 #ifdef CONFIG_X86
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 		if (amdgpu_sriov_vf(adev) && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
 			adev->mman.stolen_reserved_offset = 0x500000;
 			adev->mman.stolen_reserved_size = 0x200000;
 		}
+#endif
 #endif
 		break;
 	case CHIP_RAVEN:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 02b161a1287b..5a50122a1161 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -26,7 +26,7 @@
 #ifdef CONFIG_X86
 #include <asm/hypervisor.h>
 #endif
-
+#include <linux/version.h>
 #include <drm/drm_drv.h>
 #include <xen/xen.h>
 
@@ -728,8 +728,10 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 		case CHIP_VEGA10:
 			soc15_set_virt_ops(adev);
 #ifdef CONFIG_X86
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
 			/* not send GPU_INIT_DATA with MS_HYPERV*/
 			if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
+#endif
 #endif
 				/* send a dummy GPU_INIT_DATA request to host on vega10 */
 				amdgpu_virt_request_init_data(adev);
-- 
2.25.1

