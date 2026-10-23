Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F2606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ui5DIohv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43DF10E5A3;
	Fri, 23 Oct 2026 09:08:53 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F10E10E5A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8lRvrkCAjZ2528k7Jj6aKY/zW5PZ1giA0Kfjc/hjOCUUVheO2zuldaOZ4SHJvlNC0NnBVVT6gVYRtp3G9DLZWlc7Awpe4NPWAdVddxxuHSUIVwB6Z63+DoOIixm1ykPn/M5nVV/QxuGWPW8IP26yilzrj/E6OSIpxjo+Yf9S4M4FIA7Xefn2ukpDbCythtK6yFn7rTpvSPvTqz41hYp3FPipaH9jrUfRILm3xAOZQ/Req4+ms5HA4vXfOpVohhQc9JsivhMa1ltu6cliHiuu+uFRVQh2oAlttcjhNMf9QvGcqeR8PFGJ+cw+fiX3tIRJvQWFr1P5cc8G54GPD5aKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD6lPDph0O3eFVZzb6/q2RlLcC8jt6dv3dde4aMhjPQ=;
 b=D7NMSYahDOh0wYLuODNebI+MwAiveOXc2kD7TFdwS4P3SJ6D6pwbPNvFf7xaMZnjf6bWYemvH2n9qORjpWXzOLP790y6jivUYxSJ7z02z+4V8flamcjYn7hC1JmcAHes9NgcEGG4tsELyyD0NSVQ5cd3MJ4DjzBfcv3iB9H89IceG4qse0DnRnPgvisUQ2vX9oXW1KXKlwY1QEB5t3RxG+DGyZ89cVJ83lgesNZeRcsvQiBU7s6WLBO535cJhsiM7T0w8Ai+/UG2qwi5SOkuQ5W515mxGlZDSVvD7xzNYAP1ZmOqjwaabKN3a+HlL+l9nTS/b04AqhX2SdtD4c3BQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD6lPDph0O3eFVZzb6/q2RlLcC8jt6dv3dde4aMhjPQ=;
 b=Ui5DIohvwZr4qa/rcgABetI39/wSM+L4dqbWngdgTvDo/sD4J1hkEC4JzJjgwjKR76zgq+3+CFrV2XPy6Gy0Sqhd/8PN5cddigJ5YW09VacGPWccJBDsAKr36qS8TSauCSCB/VU13+AK8P+D76K5nYeZ7+ZgxVOZD0W91PZnFjQ=
Received: from MN0P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::27)
 by PH6PR12MB128275.namprd12.prod.outlook.com (2603:10b6:510:3da::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 09:08:44 +0000
Received: from IA0PEPF00000040.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::20) by MN0P223CA0007.outlook.office365.com
 (2603:10b6:208:52b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Fri,
 23 Oct 2026 09:08:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000040.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:08:43 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:36 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 00/13] amdgpu: implement Performance Monitor Counter support
Date: Fri, 23 Oct 2026 17:08:32 +0800
Message-ID: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000040:EE_|PH6PR12MB128275:EE_
X-MS-Office365-Filtering-Correlation-Id: 84296e60-f96e-4fef-5af2-08df30e53cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|10067099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261022075727099003|261021123027099003|56012099006;
X-Microsoft-Antispam-Message-Info: XBs6QlQxT3lcCc2/epuHkX29nsd8Ei5oVPM11DJ4Y/6Wc7Erenkn4JO0LtEbr8coxP/yAct68NGKW/4YajtUN6iq5UYwBUQQgS4zANwPywNHOejaa+jrfR+2TuAJepnlKTm0skOgaCPeIte7fC5Ebclr5qLIGVQFT8Zremp1Fgvd4nfpGNQzsldHFOxBWF0DnuCKbgcZ6t9WYJwqU0RqktEUuxRNJs4NDP4hcZfMfxRC/agFinDBoHFmeZ5eu4ZEwP+Ob5ud48mB/Dyia/i6kU+YbEQHRLZVeD708FEmKOinMsTof9ZG9hAdLKA5cyf6oz+mzVadmJi9f3GlIUxpGvk/Z/PAz06QFSgf+2toikx28rHigFqLPy/MxCiCuPZTQQvsoNI4l6u6crRPvbtjQJ68sWKWJ487qhlIAbNAk4UOCLn6/JVhBEXskknrYWXUGXyafB9VgT5Bnaxclbl2stzohLZ2glXu59cmGsktSNxS94GWr7J7CNbARmxg3O35LDeyMYjWWM10XXaG/alMC5F6nD2AKavSOX9aumfjor8V/R8hpx6z7EGAR3hZEO7UzgW+zJrOBgUR+IaYZSa922EdhFDb1mxPXbG/dPXOSWb4KS+CoFJwEFH+YkX+19u82P9JvqVDWiYfnRS5azE4/QWgp8zYXIWmGIaBf5sCmYL0/cbhVzLq5tNzvsd/Nfe9okFx5v8u1nN9JGr+xzxCcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(10067099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n2DjGXL2EHQjzG4jlsgecbTL985gjWIhyDc+5SUZUDLkHdHWGrW7Do8t1HE+mCycw4x1ngNRaijzoyOGTi+xBTtURRDuGHsVfQiSYd1/CbKjV5QouS6hQu+H8FdRHHiN8Quif15lquYEtKporXctFW7Q8IF7JWhQTci9CuaMv01LMKXkKGBUSRHpV0j+fBTjrAYHQPUlR2L+DA9fR0sLELBAOgjzl4GvMQFrK1lADKhl6JmYoVOgzMdb8W9uVpEAht31j+/ATeWfMxT5OZs8Ln1/BQUnjRKCPlS1lerQJXXoG7xXMQ/Ovxo6YaBreU+fXFMBz7slSLf7ypL9b/vymmlPsHO+xtrdySFWKyjWVQXz2yc3iF+bmkgbmfzZghukkmJAqGm9oi17m5iFx05riPBFpSZEMwY1EvNOEqCqSvBK2Y9zls3gB6RT0ONw4YJv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:08:43.6259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84296e60-f96e-4fef-5af2-08df30e53cdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB128275
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series implements PMC support for amdgpu. Including two parts:
1) PMC Enablement
2) Profiler Reservation

The user space should take the reservation, then set PMC.

Changes from v1:
1) remove per-IP set_mqd_perfcount, use init_mqd with modify == true instead
2) squash amdgpu_userq_xa_find into the caller patch
3) keep CWSR registers when modify mqd for GFX12
4) minor improvements

Zhu Lingshan (13):
  drm/amdgpu: implement PMC ioctl framework
  drm/amdgpu: add device-wide PMC config
  drm/amdgpu: introduce PMC ioctl handler
  drm/amdgpu: implement reservation mechanism for PMC
  drm/amdgpu: set device-wide PMC enablement indicator
  drm/amdgpu/gfx11: set mqd->perfcount from mqd_prop
  drm/amdgpu/gfx12: set mqd->perfcount from mqd_prop
  drm/amdgpu/gfx12.1: set mqd->perfcount from mqd_prop
  drm/amdgpu/gfx11: set pmc_supported for GFX11 family
  drm/amdgpu/gfx12: set pmc_supported for GFX12 family
  drm/amdgpu/gfx12: keep CWSR registers when modify mqd
  drm/amdgpu: implement device PMC handler
  drm/amdgpu: set userq perf state before publish it

 drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 183 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  38 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    | 164 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       |   3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c       |   1 +
 include/uapi/drm/amdgpu_drm.h                |  36 ++++
 13 files changed, 451 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h

-- 
2.53.0

