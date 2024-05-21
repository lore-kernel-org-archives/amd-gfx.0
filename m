Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C6CC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A2A10E023;
	Tue, 21 May 2024 07:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRT9yg12";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6B410E023
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nueIaWYb/8D+WrrRmN6DJoMSIpEej6Z1IFWEs/jABOE8LxkuTyI6DojmR9ffdkt/SWFWvOzE81CyBW5GEC14CNFcV6I1mwa3CWSiP1QDD9U3kA784eW8OW4GcEtXgCSZfpN0bZWLOnMsBW4qfGb2HHtGu9MO2SqcyYM+enliLgVzLpMdtv35olCwWyswAVJsBR/0eQ8Uqdy2PQDQmM0J5NxqjPF6M4iJskDmkyKZ4IjTWLCo2ki6ouJnWqLBAmCRHv5q+hpCpmOkeHZANrXZWLkS2BK4IKdunQH/y3sY0Z//z8lpDLADnCTx3OgqWGD2AFvh4RXvC6ot84dt+3GRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8/HegC4GH/+szfeNAU0+T24BMHoDuh1+pSjgatFsKU=;
 b=FORt/SGDsVYkuFH6HBUiUEATdojTvfVKlpv7y0dKnlrNnOFl43ur3uM7Aqt7IROS+fVVoqbHlVD9Bv7x+JIDj2a5s+zGn6dULLv1hXvDiKMn5gXtZWnPHnbAK5G6Njr6oQT6PFXvYFzLYqhBB8kQns8tqFoNjzdNM/mOAKObw2H9CtQIaby4t18+8pCDEf0fRX0WgzffH+U77OIxgdyl8KfrvIwoCck5PpW4rsvdiXBk+Qtpd+L+cWEapT25D8fcHfX9Wvxsh8b7xFn2WFW/dinPaHJs5fseECUzkYxl33b9kb8SkM+757jXTLqD6hPJ80C2x2HJG3DPXymyA5PGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8/HegC4GH/+szfeNAU0+T24BMHoDuh1+pSjgatFsKU=;
 b=mRT9yg12dt8YzS+hZCoU31hfq2r2Xo5lhLTKmKWk07orcAAtakNwxck9QK7PtWt1fmqrilDSCqMhnoLFlMuNmItFcz0D1h9vWc7ThyfsVN8Y+z0keReB5FxQQYfXBJJ6Q+HSarvs53zldOIdf+eCkNUuZ/DLPNfSkQaM/sVDAIE=
Received: from BL0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:208:91::40)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 07:14:53 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::53) by BL0PR05CA0030.outlook.office365.com
 (2603:10b6:208:91::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17 via Frontend
 Transport; Tue, 21 May 2024 07:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 07:14:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 02:14:48 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>, kernel test robot
 <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Add CRC16 selection in config
Date: Tue, 21 May 2024 12:44:30 +0530
Message-ID: <20240521071430.750167-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 226dc596-8bf8-436b-da77-08dc7965b5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aaV90Lv5qw0hYk8TD+tYBS38HC1CsBSzIrh6UrzWUR8QXbXDlsGjXygOMPg1?=
 =?us-ascii?Q?R07RJ2AX0jY4OkQIsPT6J3Z/SPLaSDStib4dIq/KscIQoC3Q4S3PYYKMUzih?=
 =?us-ascii?Q?PDzUeuppUz54H7XpUF5hc5DHW0Vr9picrZlbM94k0OTRFlV3P6xJ/nk5Mlqb?=
 =?us-ascii?Q?0OiX5T7x3fFNPIy4YlL7TYFnSDXjsRajOZ2EpfC5jmfAqWDfRUqKMTXSDyUD?=
 =?us-ascii?Q?jbS40axhvIfAaq4PIJ915h5UMoTwK8ayeMmplGxHEsqoYOoQFUelfnZ7HT/a?=
 =?us-ascii?Q?rOlYB6RVS81eLWcfFj69dBYMloaHNePXNvCftjqTbjm1+4XmSSxhu0OZ/b9/?=
 =?us-ascii?Q?xYXl/gDbXNep+ZN5412zptNRsMaeta1HaSh5tPw3Fhvc0aHoj882G8qm1Thl?=
 =?us-ascii?Q?UAmk5vZy2pTwymNvsvQrbQRHbg91w7t5REdOeje0LKTpnfW56kFLmTHl0xUa?=
 =?us-ascii?Q?p30Mxr6Y9v9iVAHBRJ0G2YBmsZoZEUvaXOJDsGGsd9ksIQmu4/o+oc4whKEm?=
 =?us-ascii?Q?Ul1rEdpvpGlBMs/lMr5a7oBESjtV/s9c8F7/bVnouO5QO+XBedqWsGx/oKdG?=
 =?us-ascii?Q?3vA2AXNZVLIFkmACnyDCkhHu2s8YvXuA6T5lp6rDkWK6UGunxqgMlHM+AseW?=
 =?us-ascii?Q?3S/eJt/cYNWfTAMlZ2QVOt0UVhGkTxS82IyKbnEd+WEaLWptmRC/Fr2L4iMf?=
 =?us-ascii?Q?ddRgEDhyZDXPMF31Vj8q0aloD27GmTCd9rvDkZOhPmoYWdgs3Hwpo0oRtpbF?=
 =?us-ascii?Q?kNfc80EiL5VI+r/tDia739CQ+xM0ZKLmUijqJV4DgZfVtX5CzmaHFQS0WFer?=
 =?us-ascii?Q?yESki9HtEs2rTKyIc8tFhuF/z32CplYzD1iRHPC158g9wJSwEx9pagR12SLt?=
 =?us-ascii?Q?DL6J0tRvyrOYWSgevgbIZMirsmVUlmvpKiZQVPv0Pv+RNb7JS/MExEk8uAFp?=
 =?us-ascii?Q?ss5r1+z1mFGclLUQRtDSVhpqZVq8wJkZ2mT6j1+RBEt5NqJtbc1s5+srs7CY?=
 =?us-ascii?Q?b574wqpR1xy+l73T26zPeTvWs46YUADrOT2a4JhyBjLY8Zrw+zeCAM3VERAe?=
 =?us-ascii?Q?3fuESOlnoiOJ2n7OBau+FIlqvUVuJq/HMzY7f7QyqnVThhNHJRSF9MRWHYnb?=
 =?us-ascii?Q?aN66+WDkHpyd3r0jcZT1U3An1dvUsLR4g84U2kXj3l+nP0SqyyTeOrvMRuHN?=
 =?us-ascii?Q?UGuCVL6GfliUV6hvVa8rgHdak06zbNSs/a/kP3E1/2PyuEVgT/ZpVQEg/yH9?=
 =?us-ascii?Q?5xN/2DmfDJfu2cWiMhLlAi5ZskW1TV+N/QGH4WdF99t9YTFyxGvYsbSEgiVj?=
 =?us-ascii?Q?MdQ1X1l9DxbhD8w7HxxvN3zB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 07:14:52.7624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 226dc596-8bf8-436b-da77-08dc7965b5c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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

KFD uses crc16 for gpu_id generation.

Fixes: 6dbc6469ab0b ("drm/amdkfd: Ensure gpu_id is unique")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405211405.TidTWIBX-lkp@intel.com/

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 0cd9d2939407..0051fb1b437f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -17,6 +17,7 @@ config DRM_AMDGPU
 	select HWMON
 	select I2C
 	select I2C_ALGOBIT
+	select CRC16
 	select BACKLIGHT_CLASS_DEVICE
 	select INTERVAL_TREE
 	select DRM_BUDDY
-- 
2.25.1

