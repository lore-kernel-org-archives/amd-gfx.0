Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C66606A333
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AQxvYHiA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67CB910EA5D;
	Wed, 11 Nov 2026 15:16:15 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C789910EA5D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 15:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9nxH5rUJgPKDsEs42p48uFqExzP0iMz8AUxhkB9vpa4GJfFYqWZio2xkyiaIQeZbBopEd9YAcYdyy5SNSJMIFGjvTQx8smu7qNEfj1Y5mpk+EmrSl+Y00ZxksEysw1S3JT7uIL7t9zof3qkN11NKKmFNgFibB1E+7+ZVN+cIJ91TQ9LnRCwfOP+bHWBczNp2qXU5h5LeacITfAtsrNGK4koNo09dOuVN19Pnb1+L19hMt3rzwC2k3ecpx6xVHXXT5SYA5k28rpA+zH1YWOe+Ga0Y7BFn0839/1jjacAIo4NKvuh57jsqUqEkEBkGr4LwEglCZ+p1vJQT8GM5Gjmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goo1ndX/w7E+NEHbsob6RNRVmUBLcEeFdE4yGHk3iws=;
 b=PHBdkE7NEu7yIX/ZnnKNqwh/mdv8WIVqopRALK+FaWMXOF7f9PU4v/1HEiy3him5/pY6lR0FL2cokq9Ft1gianIYJvuUJX2G3IXHlwYmyNTV+yQ9X4PX9RjMxe9XDj0ebLNm3mu3ACWb9bbLSGa02PgulMW9ebSSI3F6fnPpd9LE3ILbZG/J99uXQljo9v5MZ8LdMPpJJqG6anBTur0XCdQBUDQ8ZDxkAn9y8pB2SuOGz3gxgMYYorsm/5qBfDHcqzlqYtl/Qgzpvxu38zxzUJUpoDyLdg62fJ7+a7EUETpX9QMlwap7KE8RLVskXFs7XzIYPES217RPRTEb4+QrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goo1ndX/w7E+NEHbsob6RNRVmUBLcEeFdE4yGHk3iws=;
 b=AQxvYHiAi7jhy3iu8eENEna0dagwmuUktxlT0kM7KNk3zeZD+eX6vXuuFMF8KaFzeRklVtmXKxGQnofgFwemn4spxv/oJO+7qcwOdIbu7kUmZJ9PXWvccL/Psor3HnxiWfvCwkAcGQMuns000QPFOzoq8XcudrRRN3snYRqJx+M=
Received: from PH8PR02CA0019.namprd02.prod.outlook.com (2603:10b6:510:2d0::27)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 15:16:04 +0000
Received: from BY1PEPF00026967.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::52) by PH8PR02CA0019.outlook.office365.com
 (2603:10b6:510:2d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 15:16:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF00026967.mail.protection.outlook.com (10.167.244.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 15:16:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 09:15:59 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 09:15:59 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 09:15:58 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <tzimmermann@suse.de>,
 <timur.kristof@gmail.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/7] Drop non-DC display support
Date: Wed, 11 Nov 2026 10:15:38 -0500
Message-ID: <20261111151546.3105062-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026967:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: eab1447d-b6ca-4aae-fa34-08df4006b2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|11063799006|18002099003|261009223027099003|10067099003|261021123027099003|261026140227099003|261102123227099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: XNulDvLn2hLdi7h8v1xPC973OTR7xHT2OhFNwHBaCCEjmniK9DJp75zwRCbcbzPJ6yU5ISAubBmJSeLqPdRYYBycfX6UMhtUAR6hzGubaW1FgrgNhZfLi2uakfs7TTrlmf6tDkXHwTrETIv46Zon9RzNG//O0RLN+voG1Rug7/eObP6DEsew4xpnOo7t9Zcor1DD/s0v6JMQ18lPsjLbZPmKWlXWiwjrH+DrPLilIuRZXXV/uUY3Itkw/pWV1Xq4ExxHRly5CI3IyAhMZ5ht0jZWkVW11xbaD5HPdGjwySIgXEThN3Wr5rbUDK79UDqDb1LwLJn9rznHG+M+2uimgzski3y9SHebFsO1go5q2dGFuj2/xMcDvXChlrfCJwfBZTjw49TP+J4iwsm1DLQJ1fsSx5l/r1lbaVrYdJBztp7YhkZI8rZOv1j5xiu87+kESJZE/G9JW6ozBrnDqNKmNSNX2qsVB8QIphlOxzsGnaZAg+FPdSvNLl7qVR7JtH7D0KXbpHOUCkmBYbagLoZx+kayixGa4X47jKcR8Z5OwTsjW1+D9jqe3d1JQc1F5/aezPRf8LUEWPf/S+uMZ/MAvpwdwF8IX/msnpOJRa7ymbPTpchILTWKV6aDzdzZVJSDti7EDDEJWOUhFgp9JyfQDNFHa2GqADZ167zoZk5Aqwc5UU3pMT/n0/twVLmUFYx+qONE2iZohJ7nsc4cOJLHGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(18002099003)(261009223027099003)(10067099003)(261021123027099003)(261026140227099003)(261102123227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QkJxhqT2bOsi6cB4QgzR2AMDcqSkBx7eE52gCxFTHJ57pMDvDowVPKcsdstjRQ+GMbt5nomOODrF3w27VIEKgqof+hShPZtas3TQ8n592gGS9XFEJqOEQrBGqqEb3BKM9ivhgRFILDq/JydyKQUDuejg4X3muOWrG0b8bvSsGOK28sX3u/ceF3NphAcFC85BCs6fXevendHXITDu4s2Nhf376hoHFCUDtbkAoAHzsrwCMmqps2gOKXqHHYbmyDeQQFfgOLd0c1tijYc+restRLfSB+sYcI4c6HbLpV/yHVg0J9S6zcjhb4k0dhO57Ir6zSpo2f6Lbw1pN5UhRH7B6g3VisqMZZVLUjwBMhnPZvzmSNxCqbsGKdkKXGl4m14viqTBuzgvBBPfkk3Gu9FOJZJVKdnN+GmbFEAltkldpOnkvCP1NDB9WWpFVDDhbKBl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:16:02.2061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab1447d-b6ca-4aae-fa34-08df4006b2c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026967.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks to a lot of hard work from Timur and others we now have
full DC support for all chips supported by AMD GPU.  DC supports
a much wider range of features compared to the legacy code and
supports the atomic KMS API.  DC has been the default now for
all chips for several kernel cycles and we have an LTS kernel
for 2026 so I think it's finally time to retire the legacy code.

Alex Deucher (7):
  drm/amdgpu: fix audio parameter documentation
  drm/amdgpu: drop non-DC DCE10 support
  drm/amdgpu: drop non-DC DCE8 support
  drm/amdgpu: drop non-DC DCE6 support
  drm/amdgpu: remove legacy non-DC display support code
  drm/amdgpu: remove atombios i2c support
  drm/amdgpu: warn when driver is built without SI/DCE display support

 drivers/gpu/drm/amd/amdgpu/Makefile           |   15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    5 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c      |  106 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  418 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h  |   10 +-
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 2063 ----------
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.h    |   41 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   37 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  670 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |   13 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  |  262 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       |  176 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h       |    4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   90 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |   40 -
 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c    |  885 ----
 drivers/gpu/drm/amd/amdgpu/atombios_crtc.h    |   60 -
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c      |  770 ----
 drivers/gpu/drm/amd/amdgpu/atombios_dp.h      |   42 -
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 2126 ----------
 .../gpu/drm/amd/amdgpu/atombios_encoders.h    |   78 -
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c     |  176 -
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.h     |   33 -
 drivers/gpu/drm/amd/amdgpu/cik.c              |   18 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 3595 -----------------
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.h        |   33 -
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 3502 ----------------
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.h         |   32 -
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 3536 ----------------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.h         |   35 -
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |    1 -
 drivers/gpu/drm/amd/amdgpu/si.c               |    9 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |   15 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    7 -
 36 files changed, 83 insertions(+), 18857 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_crtc.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_dp.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_dp.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_encoders.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/atombios_i2c.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v10_0.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v6_0.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v8_0.h

-- 
2.56.0

